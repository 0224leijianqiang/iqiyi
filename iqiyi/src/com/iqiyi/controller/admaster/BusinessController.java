package com.iqiyi.controller.admaster;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.SortedMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.jdom.JDOMException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.alipay.config.AlipayConfig;
import com.alipay.util.AlipaySubmit;
import com.iqiyi.controller.base.BaseController;
import com.iqiyi.service.o.order.OrderManager;
import com.iqiyi.service.o.type.impl.TypeService;
import com.iqiyi.service.web.BusinessService;
import com.iqiyi.util.CommonDeclare;
import com.iqiyi.util.GenerateQrCodeUtil;
import com.iqiyi.util.PageData;
import com.iqiyi.util.PayCommonUtil;
import com.iqiyi.util.XMLUtil;

/**
 * Created with IntelliJ IDEA.
 * User: eric
 * Date: 15-9-8
 * Time: 下午10:44
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping("/appbusiness")
public class BusinessController extends BaseController {
    @Autowired
    private BusinessService service;
    @Autowired
    private TypeService typeService;
    @Autowired
    private OrderManager orderManager;
    HashMap<String, String> title = new HashMap<String, String>() {
        {
            put("1", "爱奇艺VIP会员月卡");
            put("2", "爱奇艺VIP会员季卡");
            put("3", "爱奇艺VIP会员半年卡");
            put("4", "爱奇艺VIP会员年卡送三个月");
        }
    };
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String index(Model model, HttpServletRequest request, HttpServletResponse response) {
        return "index";
    }
    @RequestMapping(value = "/buy", method = RequestMethod.GET)
    public String buy(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession(true);
        int bc = service.getCountByCity("1");
        int sc = service.getCountByCity("2");
        int gc = service.getCountByCity("3");
        model.addAttribute("bc",bc) ;
        model.addAttribute("sc",sc) ;
        model.addAttribute("gc",gc) ;
        return "business/buy";
    }
    @RequestMapping(value = "/order", method = RequestMethod.GET) //如果出现得不到的情况，改为get
    public void order(Model model, String cid,String chanel,String pay,  HttpServletRequest request, HttpServletResponse response) throws Exception {
        int count=1;
        HttpSession session = request.getSession(true);
        PageData user = (PageData) session.getAttribute(CommonDeclare.USER);
        PageData pd =this.getPageData();
        try {
            int id = service.save(user, cid,count,chanel,pay);
            if(pay.equals("1")){
            	response.sendRedirect("pay/{oid}".replace("{oid}", String.valueOf(id)));
            }else if(pay.equals("2")){
            	String url =service.payBaifubao(id+"", user);
            	response.sendRedirect(url);
            }else if(pay.equals("3")){
        		response.sendRedirect("pay2/{oid}".replace("{oid}", String.valueOf(id)));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    private String convertQuery(SortedMap<Object, Object> map) {
        String query = "";
        Iterator it = map.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            String key = entry.getKey().toString();
            String value = entry.getValue().toString();
            query += key + "=" + value + "&";
        }
        return query.substring(0, query.length() - 1);
    }
    @RequestMapping(value = "/pay/{oid}", method = RequestMethod.GET) //如果出现得不到的情况，改为get
    public ModelAndView pay(Model model,@PathVariable("oid") int oid, HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession(true);
        PageData user = (PageData) session.getAttribute(CommonDeclare.USER);
        String ip = request.getRemoteAddr();
        ip = "211.99.216.18";
        try {
        	PageData order = service.payByWechat(user, oid,ip);
            String prepayId = order.getString("prePayId");
            model.addAttribute("url",prepayId);
            model.addAttribute("order",order);
            PageData tYEData= typeService.findById(new PageData("TYPE_ID", order.getString("CITY")));
            model.addAttribute("title",tYEData);
        } catch (IOException e) {
            e.printStackTrace();
        } catch (JDOMException e) {
            e.printStackTrace();
        }
        ModelAndView mv = this.getModelAndView();
        mv.setViewName("business/callwechat");
        return mv;
    }
    @RequestMapping(value = "/pay2/{oid}", method = RequestMethod.GET) //如果出现得不到的情况，改为get
    public ModelAndView pay2(Model model,@PathVariable("oid") int oid, HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession(true);
        PageData user = (PageData) session.getAttribute(CommonDeclare.USER);
        String ip = request.getRemoteAddr();
        if(ip.equals("")){
        	ip = "211.99.216.18";
        }
        try {
        	PageData order = orderManager.findById(new PageData("ID", oid+""));
        	PageData tYEData= typeService.findById(new PageData("TYPE_ID", order.getString("CITY")));
        	Map<String, String> sParaTemp = new HashMap<String, String>();
    		sParaTemp.put("service", AlipayConfig.service);
            sParaTemp.put("partner", AlipayConfig.partner);
            sParaTemp.put("seller_id", AlipayConfig.seller_id);
            sParaTemp.put("_input_charset", AlipayConfig.input_charset);
    		sParaTemp.put("payment_type", AlipayConfig.payment_type);
    		sParaTemp.put("notify_url", AlipayConfig.notify_url);
    		sParaTemp.put("return_url", AlipayConfig.return_url);
    		sParaTemp.put("out_trade_no",oid+"");
    		sParaTemp.put("subject",tYEData.getString("CONTENT"));
    		sParaTemp.put("total_fee",order.getBigDecimal("AMOUNT")+"");
    		sParaTemp.put("show_url", CommonDeclare.BASE_URL+"/app/");
    		sParaTemp.put("body", "");
    		String sHtmlText = AlipaySubmit.buildRequest(sParaTemp,"get","确认");
    		//sParaTemp.put("app_pay","Y");//启用此参数可唤起钱包APP支付。
            model.addAttribute("sHtmlText",sHtmlText);
        } catch (IOException e) {
            e.printStackTrace();
        } catch (JDOMException e) {
            e.printStackTrace();
        }
        ModelAndView mv = this.getModelAndView();
        mv.setViewName("business/alipayapi");
        return mv;
    }
    @RequestMapping(value = "/pictureCode", method = RequestMethod.GET)
    public void PictureCheckCode( String codeUrl, HttpServletRequest request, HttpServletResponse response) throws IOException {
        if(codeUrl!=null){
            //设置不缓存图片
            response.setHeader("Pragma", "No-cache");
            response.setHeader("Cache-Control", "No-cache");
            response.setDateHeader("Expires", 0) ;
            //指定生成的相应图片
            response.setContentType("image/jpeg") ;

            GenerateQrCodeUtil.encodeQrcode(codeUrl, response);
        }
    }


    @RequestMapping(value = "/pay-notify", method = RequestMethod.GET)
    public void payNotify(Integer order_no, Integer order_id, String sp_no, Integer pay_time, String pay_result, Integer paid_amount, Integer coupons, Integer promotion, String sign, HttpServletRequest request, HttpServletResponse response) throws Exception {
        HashMap<String, String> map = new HashMap<String, String>();
        map.put("order_no", String.valueOf(order_no));
        map.put("order_id", String.valueOf(order_id));
        map.put("sp_no", String.valueOf(sp_no));
        map.put("pay_time", String.valueOf(pay_time));
        map.put("pay_result", String.valueOf(pay_result));
        map.put("paid_amount", String.valueOf(paid_amount));
        map.put("coupons", String.valueOf(coupons));
        map.put("promotion", String.valueOf(promotion));
        service.payNotify(order_no+"");
    }
 
    public static final String ENCODING_REQUEST = "utf-8";
    public static final String ENCODING_RESPONSE = "gb2312";

    @RequestMapping(value = "/test-notify-url", method = RequestMethod.GET)
    public void test_notify_url(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String content = "<xml>"+
                "<appid><![CDATA[wx2421b1c4370ec43b]]></appid>"+
                "<attach><![CDATA[支付测试]]></attach>"+
                "<bank_type><![CDATA[CFT]]></bank_type>"+
                "<fee_type><![CDATA[CNY]]></fee_type>"+
                "<is_subscribe><![CDATA[Y]]></is_subscribe>"+
                "<mch_id><![CDATA[10000100]]></mch_id>"+
                "<nonce_str><![CDATA[5d2b6c2a8db53831f7eda20af46e531c]]></nonce_str>"+
                "<openid><![CDATA[oUpF8uMEb4qRXf22hE3X68TekukE]]></openid>"+
                "<out_trade_no><![CDATA[1409811653]]></out_trade_no>"+
                "<result_code><![CDATA[SUCCESS]]></result_code>"+
                "<return_code><![CDATA[SUCCESS]]></return_code>"+
                "<sign><![CDATA[B552ED6B279343CB493C5DD0D78AB241]]></sign>"+
                "<sub_mch_id><![CDATA[10000100]]></sub_mch_id>"+
                "<time_end><![CDATA[20140903131540]]></time_end>"+
                "<total_fee>1</total_fee>"+
                "<trade_type><![CDATA[JSAPI]]></trade_type>"+
                "<transaction_id><![CDATA[1004400740201409030005092168]]></transaction_id>"+
                "</xml> ";
        HttpURLConnection httpURLConnection;
        URL gatewayUrl = new URL("http://127.0.0.1:8080/iqiyi/appbusiness/notify/pay-wechat-notify");
        httpURLConnection = (HttpURLConnection) gatewayUrl.openConnection();

        //设置连接属性
        httpURLConnection.setDoOutput(true);
        httpURLConnection.setDoInput(true);
        httpURLConnection.setUseCaches(false);
        httpURLConnection.setRequestMethod("GET");

        byte[] requestStringBytes = content.getBytes(ENCODING_REQUEST);

        //设置请求属性
        httpURLConnection.setRequestProperty("Content-length", "" + requestStringBytes.length);
        httpURLConnection.setRequestProperty("Content-Type", "application/octet-stream");

        //建立输出流，并写入数据
        OutputStream outputStream = httpURLConnection.getOutputStream();
        outputStream.write(requestStringBytes);
        outputStream.close();
        //获得响应状态
        int responseCode = httpURLConnection.getResponseCode();

        if (HttpURLConnection.HTTP_OK == responseCode) {
            //当正确响应时处理数据
            System.out.println("");
            System.out.println("Http Response OK...");
            System.out.println("");
            StringBuffer responseBuffer = new StringBuffer();
            String readLine;
            BufferedReader responseReader;
            //处理响应流，必须与服务器响应流输出的编码一致
            responseReader = new BufferedReader(new InputStreamReader(httpURLConnection.getInputStream(), ENCODING_RESPONSE));
            while ((readLine = responseReader.readLine()) != null) {
                responseBuffer.append(readLine).append("\n");
            }
            responseReader.close();

            System.out.println("Http Response:" + responseBuffer);
        }

    }
  
    @RequestMapping(value = "/resend", method = RequestMethod.GET)
    public String resend(int id, HttpServletRequest request, HttpServletResponse response) throws Exception {
        service.resend(id);
        return "business/ok";
    }
    @RequestMapping(value = "/resend/phone", method = RequestMethod.GET)
    public String resend(String phone, HttpServletRequest request, HttpServletResponse response) throws Exception {
        service.resend(phone);
        return "business/ok";
    }
    @RequestMapping(value = "/result", method = RequestMethod.GET)
    public ModelAndView result(Model model,HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession(true);
        ModelAndView mv = this.getModelAndView();
        mv.setViewName("business/result");
        PageData user = (PageData) session.getAttribute(CommonDeclare.USER);
        List<PageData> order = service.findOrders(user.getInt("ID"));
        for(PageData pd:order){
        	pd.put("title", typeService.findById(new PageData("TYPE_ID",pd.getString("city"))));
        }
        model.addAttribute("cost",order);
        return mv;
    }
    @RequestMapping("/bfbresult")
    public ModelAndView bfbresult() throws Exception{
    	ModelAndView mv = this.getModelAndView();
    	PageData pd = this.getPageData();
//    	service.payNotify(pd.getString(" order_no"),null, "");
    	return mv;
    }
    @RequestMapping("/choice_pay_method")
    public ModelAndView choice_pay_method(){
    	ModelAndView mv = this.getModelAndView();
    	try {
			PageData pd = this.getPageData();
			PageData type= typeService.findById(new PageData("TYPE_ID", pd.getString("cid")));
			mv.addObject("pd", pd);
			mv.addObject("type", type);
		} catch (Exception e) {
			// TODO: handle exception
		}
    	mv.setViewName("business/choice_pay_method");
    	return mv;
    }
    
}
