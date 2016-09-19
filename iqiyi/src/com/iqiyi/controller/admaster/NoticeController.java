package com.iqiyi.controller.admaster;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.alipay.config.AlipayConfig;
import com.alipay.util.AlipaySubmit;
import com.iqiyi.controller.base.BaseController;
import com.iqiyi.service.o.type.impl.TypeService;
import com.iqiyi.service.web.BusinessService;
import com.iqiyi.util.PageData;
import com.iqiyi.util.PayCommonUtil;
import com.iqiyi.util.XMLUtil;
@RequestMapping("/appnotice")
@Controller
public class NoticeController extends BaseController{
	@Autowired
	private BusinessService service;
	@Autowired
	private TypeService typeService;
	@RequestMapping("/bdnotice")
	private void sendNotice(HttpServletRequest request){
		PageData success = this.getPageData();
		try {
    		String retSign = (String) success.get("sign");
    		success.remove("sign");
    		String sign = PayCommonUtil.getBfbSign(success);
			String order_no = success.getString("order_no");
			System.out.println(sign+":"+retSign);
			if(!order_no.equals("")&&success.get("pay_result").equals("1")&&sign.equalsIgnoreCase(retSign)){
	        	service.payNotify(order_no);
	        }
			response.sendRedirect("appresultbusiness");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	@RequestMapping("/zfbnotice")
	private void sendZfbNotice(HttpServletRequest request){
		PageData success = this.getPageData();
		try {
			    String out_trade_no = success.getString("out_trade_no");
			  	String returnsign = success.getString("sign");
		        success.remove("sign");
		        success.remove("sign_type");
		        String zfbsign= AlipaySubmit.buildRequestMysign(success);
			 if(!out_trade_no.equals("")&&success.get("trade_status").equals("TRADE_SUCCESS")&&returnsign.equalsIgnoreCase(zfbsign)){
		        	service.payNotify(out_trade_no);
		        }
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
    @RequestMapping(value = "/notify/pay-wechat-notify", method = RequestMethod.POST)
	public void payNotifyWechat(HttpServletRequest request, HttpServletResponse response) throws Exception {
	        System.out.println("pay access ");
	        InputStream in = request.getInputStream();
	        ByteArrayOutputStream bout = new ByteArrayOutputStream();
	        byte[] buffer = new byte[1024];
	        int line = 0;
	        while((line = in.read(buffer)) != -1){
	            bout.write(buffer, 0, line);
	        }
	        bout.close();
	        in.close();
	        String content = new String(bout.toByteArray(), "UTF-8");
	        Map<String,Object> ret = XMLUtil.doXMLParse(content);
	        if("SUCCESS".equalsIgnoreCase(String.valueOf(ret.get("result_code")))){
	            String returnSign = String.valueOf(ret.get("sign"));
	            ret.remove("sign");
	            String sin = PayCommonUtil.getSign(ret);
	            System.out.println("sign:"+returnSign+"--calc sign:"+sin+",eq:"+sin.equals(returnSign));
	            if(sin.equalsIgnoreCase(returnSign)){
	                int order_no = new Integer(String.valueOf(ret.get("out_trade_no")));
	                service.payNotify(order_no+"");
	            } else {
	                System.out.println("weixinpay signature Error : "+content);
	            }
	        }
	        response.getWriter().write("success");
	    }
   private String getResultXml(String return_code, String return_msg){
        return "<xml><return_code><![CDATA["+return_code+"]]></return_code>  <return_msg><![CDATA["+return_msg+"]]></return_msg> </xml> ";
    }
	@RequestMapping("/g")
	private ModelAndView g(){
		 ModelAndView mv = this.getModelAndView();
		 mv.setViewName("business/g");
	  return mv;
	}
	@RequestMapping("/x")
	private ModelAndView x(){
		 ModelAndView mv = this.getModelAndView();
		 mv.setViewName("business/x");
	  return mv;
	}
}
