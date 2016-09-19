package com.iqiyi.controller.admaster;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.impl.client.AIMDBackoffManager;
import org.jdom.JDOMException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.alipay.config.AlipayConfig;
import com.alipay.util.AlipaySubmit;
import com.iqiyi.controller.base.BaseController;
import com.iqiyi.service.o.type.impl.TypeService;
import com.iqiyi.service.web.BusinessService;
import com.iqiyi.util.CommonDeclare;
import com.iqiyi.util.PageData;
import com.iqiyi.util.PayCommonUtil;
import com.iqiyi.util.XMLUtil;
@RequestMapping("/appresultbusiness")
@Controller
public class ResultController extends BaseController{
	@Autowired
	private BusinessService service;
	@Autowired
	private TypeService typeService;
	@RequestMapping
	private ModelAndView list(HttpServletRequest request) throws Exception{
			HttpSession session = request.getSession(true);
	        ModelAndView mv = this.getModelAndView();
	        mv.setViewName("business/result");
	        PageData success = new PageData(request);
	        String returnsign = success.getString("sign");
	        success.remove("sign");
	        success.remove("sign_type");
	        String zfbsign= AlipaySubmit.buildRequestMysign(success);
	        System.out.println(returnsign+":"+zfbsign);
	        PageData user = (PageData) session.getAttribute(CommonDeclare.USER);
	        List<PageData> order = service.findOrders(user.getInt("ID"));
	       /* for(PageData pd:order){
	        	String oid = pd.getInt("id")+"";
	        	pd.put("title", typeService.findById(new PageData("TYPE_ID",pd.getString("city"))));
	        	if(pd.get("pay_method")==null)continue;
	        	if(pd.get("pay_method").equals("1")){
	        		wx_pay(oid);
	        	}
	        	else if(pd.get("pay_method").equals("2")){
	        		String url = service.bd_order_query(oid);
	        		Map<String,Object> ret = XMLUtil.doXMLParse(url);
	        		String retSign = (String) ret.get("sign");
	        		ret.remove("sign");
	        		String sign = PayCommonUtil.getBfbSign(ret);
	        		System.out.println(retSign+":"+sign);
	        		if(ret!=null&&ret.get("pay_result")!=null&&ret.get("pay_result").equals("1")&&sign.equalsIgnoreCase(retSign)){
	        			service.payNotify(oid);
	        		}
	        		System.out.println(ret.get("pay_result"));
	        	}else if(pd.get("pay_method").equals("3")){
	        		//service.zfb_order_query(oid);
	        		 String out_trade_no = success.getString("out_trade_no");
	    			 if(!out_trade_no.equals("")&&success.get("seller_id").equals(AlipayConfig.seller_id)&&success.get("is_success").equals("T")){
	    		        	service.payNotify(out_trade_no, null,"");
	    		       }
	        	}
	        }*/
	        //order = service.findOrders(user.getInt("ID"));
	        mv.addObject("cost",order);
	        return mv;
	}
	private void wx_pay(String oid) throws JDOMException, IOException,
			Exception {
		String result = service.wx_order_query(oid);
		Map<String,Object> ret = XMLUtil.doXMLParse(result);
		String returnSign = String.valueOf(ret.get("sign"));
		ret.remove("sign");
		 String sin = PayCommonUtil.getSign(ret);
         System.out.println("sign:"+returnSign+"--calc sign:"+sin+",eq:"+sin.equals(returnSign));
		if("SUCCESS".equalsIgnoreCase(String.valueOf(ret.get("result_code")))&&sin.equals(returnSign)){
			service.payNotify(oid);
		 }
	}
}
