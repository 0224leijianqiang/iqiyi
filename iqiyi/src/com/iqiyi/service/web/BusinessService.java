package com.iqiyi.service.web;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.GeneralSecurityException;
import java.security.MessageDigest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.SortedMap;
import java.util.TreeMap;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradeQueryRequest;
import com.alipay.api.response.AlipayTradeQueryResponse;
import com.alipay.config.AlipayConfig;
import com.alipay.util.AlipaySubmit;
import com.iqiyi.bfb.BfbSdkComm;
import com.iqiyi.service.o.code.impl.CodeService;
import com.iqiyi.service.o.master.MasterManager;
import com.iqiyi.service.o.order.impl.OrderService;
import com.iqiyi.service.o.type.impl.TypeService;
import com.iqiyi.util.Client;
import com.iqiyi.util.CommonDeclare;
import com.iqiyi.util.CommonUtil;
import com.iqiyi.util.HttpUtil;
import com.iqiyi.util.PageData;
import com.iqiyi.util.PayCommonUtil;
import com.iqiyi.util.Tools;
import com.iqiyi.util.XMLUtil;

/**
 * Created with IntelliJ IDEA.
 * User: eric
 * Date: 15-9-8
 * Time: 下午10:45
 * To change this template use File | Settings | File Templates.
 */
@Service
public class BusinessService {
    @Autowired
    private CodeService codeMapper;
    @Autowired
    private OrderService orderMapper;
    @Autowired
    private TypeService typeService;
    @Autowired
    private MasterManager masterManager;
    /*HashMap<String, String> title = new HashMap<String, String>() {
        {
            put("1", "爱奇艺VIP会员月卡");
            put("2", "爱奇艺VIP会员季卡");
            put("3", "爱奇艺VIP会员半年卡");
            put("4", "爱奇艺VIP会员年卡");
        }
    };
    HashMap<String, BigDecimal> price = new HashMap<String, BigDecimal>() {
        {
//            put("1",new BigDecimal(0.02));
//            put("2",new BigDecimal(0.03));
//            put("3",new BigDecimal(0.04));
//            put("4",new BigDecimal(0.05));
//            put("1",new BigDecimal(19.8));
//            put("2",new BigDecimal(58));
//            put("3",new BigDecimal(108));
//            put("4",new BigDecimal(198));

            put("1",new BigDecimal(15.8)); //15.8
            put("2",new BigDecimal(46.4));
            put("3",new BigDecimal(86.4));
            put("4",new BigDecimal(159));
        }
    };*/
    HashMap<String, String> valid = new HashMap<String, String>() {
        {
            put("1","2016-12-31");
            put("2","2016-12-31");
            put("3","2016-12-31");
            put("4","2016-12-31");
            put("5","2016-12-31");
        }
    };
    private BigDecimal off = new BigDecimal(1);
    public int save(PageData pd, String cid, int count,String chanel,String payMethod) throws Exception {
        //获取码，存订单、码使用，存名字，发短信，放百度
        Map map = new HashMap<String, Integer>();
        PageData type = typeService.findById(new PageData("TYPE_ID",cid));
        PageData order = new PageData();
        order.put("USER_ID",pd.get("ID"));
        order.put("PAID", "0");
        order.put("AMOUNT",new BigDecimal(type.getBigDecimal("CURRENT_PRICE").doubleValue() * off.doubleValue()));
        order.put("CITY",cid);
        order.put("COUNT",count);
        order.put("PHONE",pd.get("PHONE_NUM"));
        order.put("CHANEL",chanel);
        order.put("ORDER_DATE", Tools.date2Str(new Date()));
        order.put("pay_method", payMethod);
       /* order.setPaid("0");
        order.setAmount(new BigDecimal(price.get(cid).doubleValue() * off.doubleValue()));
        order.setCity(cid);
        order.setCount(count);
        order.setPhone(user.getPhoneNum());
        order.setChanel(chanel);*/
        orderMapper.save(order);
        return orderMapper.findId(null);
    }
    private String convertQuery(HashMap<String, String> map) {
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
    public static String getSignature(HashMap<String, String> params, String secret) throws IOException {
        // 先将参数以其参数名的字典序升序进行排序
        Map<String, String> sortedParams = new TreeMap<String, String>(params);
        Set<Map.Entry<String, String>> entrys = sortedParams.entrySet();
        // 遍历排序后的字典，将所有参数按"key=value"格式拼接在一起
        StringBuilder basestring = new StringBuilder();
        for (Map.Entry<String, String> param : entrys) {
            basestring.append(param.getKey()).append("=").append(param.getValue());
        }
        basestring.append(secret);
        // 使用MD5对待签名串求签
        byte[] bytes = null;
        try {
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            bytes = md5.digest(basestring.toString().getBytes("UTF-8"));
        } catch (GeneralSecurityException ex) {
            throw new IOException(ex);
        }

        // 将MD5输出的二进制结果转换为小写的十六进制
        StringBuilder sign = new StringBuilder();
        for (int i = 0; i < bytes.length; i++) {
            String hex = Integer.toHexString(bytes[i] & 0xFF);
            if (hex.length() == 1) {
                sign.append("0");
            }
            sign.append(hex);
        }
        return sign.toString();
    }
  /*  public static String getSign(HashMap<String, String> params) throws IOException {
        // 先将参数以其参数名的字典序升序进行排序
        Map<String, String> sortedParams = new TreeMap<String, String>(params);
        Set<Map.Entry<String, String>> entrys = sortedParams.entrySet();
        // 遍历排序后的字典，将所有参数按"key=value"格式拼接在一起
        StringBuilder basestring = new StringBuilder();
        for (Map.Entry<String, String> param : entrys) {
            basestring.append(param.getKey()).append("=").append(param.getValue());
        }
        // 使用MD5对待签名串求签
        byte[] bytes = null;
        try {
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            bytes = md5.digest(basestring.toString().getBytes("GBK"));
        } catch (GeneralSecurityException ex) {
            throw new IOException(ex);
        }

        // 将MD5输出的二进制结果转换为小写的十六进制
        StringBuilder sign = new StringBuilder();
        for (int i = 0; i < bytes.length; i++) {
            String hex = Integer.toHexString(bytes[i] & 0xFF);
            if (hex.length() == 1) {
                sign.append("0");
            }
            sign.append(hex);
        }
        return sign.toString();
    }*/
    public PageData payByWechat(PageData user, int oid,String ip) throws Exception {
    	PageData order = orderMapper.findById(new PageData("ID", oid+""));
        SortedMap<Object,Object> parameters = new TreeMap<Object,Object>();
        parameters.put("appid", CommonDeclare.APPID);
        parameters.put("mch_id", CommonDeclare.MCH_ID);
        parameters.put("nonce_str", PayCommonUtil.CreateNoncestr(16));
        PageData type = typeService.findById(new PageData("TYPE_ID",order.get("CITY").toString()));
        parameters.put("body", type.get("NAME"));
        parameters.put("out_trade_no", String.valueOf(order.get("ID")));
        parameters.put("product_id", String.valueOf(order.get("CITY")));
        parameters.put("total_fee",String.valueOf((int)(order.getBigDecimal("AMOUNT").doubleValue() * 100)));
        parameters.put("spbill_create_ip",ip);
        parameters.put("notify_url", CommonDeclare.NOTIFY_URL);
        parameters.put("trade_type", "NATIVE");    //NATIVE     WAP
        //parameters.put("openid", "o7W6yt9DUOBpjEYogs4by1hD_OQE");不是必须的
        String sign = PayCommonUtil.createSign("UTF-8", parameters);
        parameters.put("sign", sign);
        String requestXML = PayCommonUtil.getRequestXml(parameters);
        String result = CommonUtil.httpsRequest(CommonDeclare.UNIFIED_ORDER_URL, "POST", requestXML);
        Map<String, String> map = XMLUtil.doXMLParse(result);
        if(map.get("result_code").equals("SUCCESS")) {
            order.put("prePayId",map.get("code_url"));
        }else {
        	 order.put("prePayId",CommonDeclare.WECHAT_ERROR);
        }
        return order;
    }
    public String wx_order_query(String oid){
    	SortedMap<Object,Object> parameters = new TreeMap<Object,Object>();
        parameters.put("appid", CommonDeclare.APPID);
        parameters.put("mch_id", CommonDeclare.MCH_ID);
        parameters.put("nonce_str", PayCommonUtil.CreateNoncestr(16));
        parameters.put("out_trade_no",oid);
        String sign = PayCommonUtil.createSign("UTF-8", parameters);
        parameters.put("sign", sign);
        String requestXML = PayCommonUtil.getRequestXml(parameters);
        String result = CommonUtil.httpsRequest(CommonDeclare.WX_ORDER_QUERY, "POST", requestXML);
		return result;
    }
    
    public String pay(PageData user, int oid) throws Exception {
        PageData order = orderMapper.findById(new PageData("ID", oid+""));
        String cid = order.getString("CITY");
        String payUrl = "/";
        DefaultHttpClient httpClient = new DefaultHttpClient();
        HttpPost method = new HttpPost(CommonDeclare.ZDH_PAY_URL);
        HashMap<String, String> params = new HashMap<String, String>();
        JSONArray detail = new JSONArray();
        JSONObject item = new JSONObject();
        item.put("item_id", 1);
        item.put("cat_id", "3");
        PageData type = typeService.findById(new PageData("TYPE_ID",cid));
        item.put("name", type.get("NAME"));
        item.put("desc",  type.get("NAME"));
        item.put("price", (int)(order.getBigDecimal("AMOUNT").doubleValue() * 100));
        item.put("expire_time", 7200);
        item.put("amount", order.get("COUNT"));
        item.put("url", CommonDeclare.ZDH_ITEM_URL);
        detail.add(item);
        params.put("sp_no", CommonDeclare.ZDH_SHOP);
        params.put("order_no", String.valueOf(order.get("ID")));
        params.put("total_amount", String.valueOf((int)(order.getBigDecimal("AMOUNT").doubleValue() * 100)));
        params.put("goods_name", type.getString("NAME"));
        params.put("return_url", CommonDeclare.ZDH_PAY_NOTIFY_URL); //通知页面
        params.put("page_url", CommonDeclare.ZDH_RETURN_URL);
        params.put("detail", detail.toString());
        params.put("order_source_url", CommonDeclare.ZDH_ORDER_SOURCE_URL);
        params.put("customer_name", (user.getString("NAME")==null||user.getString("NAME").equals(""))? CommonDeclare.DEFAULT_NAME :user.getString("NAME"));
        params.put("customer_mobile", user.getString("PHONE_NUM"));
        params.put("customer_address", "暂无");
        try {
            params.put("sign", getSignature(params, CommonDeclare.ZDH_SHOP_SK));
            String query = convertQuery(params);
            StringEntity entity = new StringEntity(query, "utf-8");
            entity.setContentType("application/x-www-form-urlencoded");
            method.setEntity(entity);
            HttpResponse result = httpClient.execute(method);
            if (result.getStatusLine().getStatusCode() == 200) {
                String ret = EntityUtils.toString(result.getEntity());
                JSONObject retJson = JSONObject.fromObject(ret);
                if (retJson.get("url") != null && !retJson.get("url").toString().equals("")) {
                    payUrl = retJson.get("url").toString();
                    order.put("PAY_CODE", payUrl);
                    orderMapper.edit(order);
                    //存支付的URL
                }
            }
        } catch (IOException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        return payUrl;
    }
    public String zfb_order_query(String oid) throws Exception{
    	
    	AlipayClient alipayClient = new DefaultAlipayClient("https://openapi.alipay.com/gateway.do",AlipayConfig.seller_id,AlipayConfig.key,"json","GBK",AlipayConfig.key);
    	AlipayTradeQueryRequest request = new AlipayTradeQueryRequest();
    	request.setBizContent("{" +
    	"    \"out_trade_no\":\""+oid+"\"," +
    	"  }");
    	AlipayTradeQueryResponse response = alipayClient.execute(request);
    	System.out.println(response.getBody());
    	return null;
    }
    
    public String bd_order_query(String oid) throws UnsupportedEncodingException{
		 String service_code = "service_code=11";
		 String sp_no = "sp_no="+CommonDeclare.BFB_SP_NO;
		 String order_no="order_no="+oid;
		 String output_type="output_type=1";
		 String output_charset="output_charset=1";
		 String version ="version=2";
		 String sign_method="sign_method=1";
		 String array[]=new String[]{service_code,sp_no,order_no,output_type,output_charset,version,sign_method};
		 String getURL=new BfbSdkComm().create_baifubao_pay_order_url(array,array,CommonDeclare.BD_ORDER_QUERY);
         return HttpUtil.sendGet(getURL,null);
    }
    public String payBaifubao(String oid,PageData user) throws Exception{
    	 PageData order = orderMapper.findById(new PageData("ID", oid));
    	 PageData type = typeService.findById(new PageData("TYPE_ID",order.getString("CITY")));
    	 SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
    	 String order_create_time =sdf.format(new Date());
    	 String return_url1="return_url="+URLEncoder.encode(CommonDeclare.BFB_RETURN_RESULT,"gbk");
    	 String service_code = "service_code=1";
    	 String sp_no = "sp_no="+CommonDeclare.BFB_SP_NO;
    	 order_create_time = "order_create_time="+order_create_time;
    	 String order_no="order_no="+oid;
    	 String goods_name = "goods_name="+type.getString("NAME");
    	 String goods_name1="goods_name="+ URLEncoder.encode(type.getString("NAME"),"gbk");
    	 String total_amount="total_amount="+String.valueOf((int)(order.getBigDecimal("AMOUNT").doubleValue() * 100));
    	 String currency="currency=1";
    	 String return_url="return_url="+CommonDeclare.BFB_RETURN_RESULT;
    	 String pay_type = "pay_type=1";
    	 String input_charset="input_charset=1";
    	 String version = "version=2";
    	 String sign_method="sign_method=1";
    	  //签名串拼接数组
 		String[]array={
 			    service_code,
 				sp_no,
 				order_create_time,
 				order_no,
 				goods_name,
 				total_amount,
 				currency,
 				return_url,
 				pay_type,
 				input_charset,
 				version,
 				sign_method
 				};
 		//浏览器参数拼接数组
 		String[]array1={
 			    service_code,
 				sp_no,
 				order_create_time,
 				order_no,
 				goods_name1,
 				total_amount,
 				currency,
 				return_url1,
 				pay_type,
 				input_charset,
 				version,
 				sign_method
 				};
 		 /**
 		  * 4、调用bfb_sdk_comm里create_baifubao_pay_order_url方法生成百度钱包H5端即时到账支付接口URL(需要登录)
 	   	  *   array是待签名串
 		  *   array1地址栏拼接串
 		  */
 		 String getURL=new BfbSdkComm().create_baifubao_pay_order_url(array,array1,CommonDeclare.BFB_URL);
         return getURL;
    }
    
    public String payZfb(String oid,PageData user) throws Exception{
   	 PageData order = orderMapper.findById(new PageData("ID", oid));
   	 PageData type = typeService.findById(new PageData("TYPE_ID",order.getString("CITY")));
	   	Map<String, String> sParaTemp = new HashMap<String, String>();
		sParaTemp.put("service", AlipayConfig.service);
	    sParaTemp.put("partner", AlipayConfig.partner);
	    sParaTemp.put("seller_id", AlipayConfig.seller_id);
	    sParaTemp.put("_input_charset", AlipayConfig.input_charset);
		sParaTemp.put("payment_type", AlipayConfig.payment_type);
		sParaTemp.put("notify_url", AlipayConfig.notify_url);
		sParaTemp.put("return_url", AlipayConfig.return_url);
		sParaTemp.put("out_trade_no",oid+"");
		sParaTemp.put("subject",URLEncoder.encode(type.getString("CONTENT"),"utf-8"));
		sParaTemp.put("total_fee",order.getBigDecimal("AMOUNT")+"");
		sParaTemp.put("show_url", "http://www.uping8.com/");
		sParaTemp.put("body", "");
		String getURL = AlipaySubmit.buildRequest(sParaTemp,"get","确认");
        return getURL;
   }
    public String zfb_order_query(String oid,PageData user) throws Exception{
      	 PageData order = orderMapper.findById(new PageData("ID", oid));
   	   	Map<String, String> sParaTemp = new HashMap<String, String>();
   	    sParaTemp.put("method", AlipayConfig.orderquery);
   	    sParaTemp.put("app_id", AlipayConfig.seller_id);
   	    sParaTemp.put("sign_type","RSA");
   	    sParaTemp.put("charset", AlipayConfig.input_charset);
   		sParaTemp.put("timestamp",Tools.date2Str(new Date()));
   		sParaTemp.put("version","1.0");
   		sParaTemp.put("biz_content","{\"trade_no\":\""+oid+"\"}");
   		String getURL = AlipaySubmit.buildRequest(sParaTemp,"get","确认");
   		
           return getURL;
      }
    public int getCountByCity(String city) throws Exception {
        return codeMapper.getCountByCity(new PageData("CITY",city));
    }
    //pay-notify?order_no=5002&order_id=13421386&sp_no=93262&pay_time=1442057416&pay_result=1&paid_amount=1&coupons=0&promotion=0&sign=9512b4b45882501a90e1865a03a959ec
    public synchronized void payNotify(String oid) throws Exception {
        try {
            PageData order = orderMapper.findById(new PageData("ID",oid+""));
            if(order.get("PAID").equals("0")){
                	order.put("PAID", "1");
                	orderMapper.edit(order);
                	sendCode(Integer.parseInt(oid));
            }
        } catch (IOException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
    }
    public static void main(String[] args) throws UnsupportedEncodingException {
		System.err.println(URLDecoder.decode("张三", "GBK"));
	}
    @Transactional
    public void sendCode(int id) throws Exception {
        try {
            Client client = client = new Client(CommonDeclare.MSG_SN, CommonDeclare.MSG_PWD);
            PageData order = orderMapper.findById(new PageData("ID", id+""));
            int n = order.getInt("COUNT");
            String codes = "";
            for (int i = 0; i < n; i++) {
                PageData code = codeMapper.getByCity(new PageData("CITY",order.getString("CITY")));
                if (code == null) {
                    client.mdsmssend("18623599561", URLEncoder.encode("没有获取到消费码，检查爱奇艺数据库是否用尽，订单ID："+order.get("ID")+"【海拓智方】", "utf-8"), "", "", "", "");
                }
                code.put("ORDER_ID", order.get("ID"));
                code.put("USED","1");
                codeMapper.edit(code);
                codes += code.getString("CODE") + ",";
            }
            codes = codes.substring(0, codes.length() - 1);
            PageData type = typeService.findById(new PageData("TYPE_ID",order.getString("CITY")));
            String msg = CommonDeclare.CODE.replace("@", codes).replace("&", valid.get(order.getString("CITY"))).replace("#", type.getString("NAME"));
            String ret = client.mdsmssend(order.getString("PHONE"), URLEncoder.encode(msg, "utf-8"), "", "", "", "");
            order.put("MSG_CODE",ret);
            orderMapper.edit(order);
            //if(order.getCity().equals("2")) sendGift(order,"1");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        //取码发送
    }
    private void sendGift(PageData order,String type) throws Exception {
        try {
            Client client = client = new Client(CommonDeclare.MSG_SN, CommonDeclare.MSG_PWD);
            PageData code = codeMapper.getByCity(new PageData("CITY", type));
            if (code == null) {
                client.mdsmssend("18010471882", URLEncoder.encode("sendGift没有获取到消费码，检查爱奇艺数据库是否用尽，订单ID：" + order.get("ID") + "【海拓智方】", "utf-8"), "", "", "", "");
            }
            code.put("ORDER_ID", order.get("ID"));
            code.put("USED","1");
            String msg = CommonDeclare.CODE.replace("@", code.getString("CODE")).replace("&", valid.get(order.getString("CITY"))).replace("#", "爱奇艺VIP会员月卡");
            String ret = client.mdsmssend(order.getString("PHONE"), URLEncoder.encode(msg, "utf-8"), "", "", "", "");
            System.out.println("赠送成功！电话："+order.getString("PHONE")+",码："+code.getString("CODE"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
    }
    public void resend(int oid) throws Exception {
        PageData order = orderMapper.findById(new PageData("ID", oid+""));
        List<PageData> cl = codeMapper.findByOrderId(new PageData("ID", oid+""));
        String codes="";
        for(int i = 0; i < cl.size(); i++) {
            PageData code = cl.get(i);
            codes += code.getString("CODE")+",";
        }
        codes = codes.substring(0, codes.length() - 1);
        String msg = CommonDeclare.CODE.replace("@", codes);
        Client client = null;
        try {
            client = new Client(CommonDeclare.MSG_SN, CommonDeclare.MSG_PWD);
            String ret = client.mdsmssend(order.getString("PHONE"), URLEncoder.encode(msg, "utf-8"), "", "", "", "");
            order.put("MSG_CODE", ret);
            orderMapper.edit(order);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
    }
    public void resend(String phone) throws Exception {
        PageData user = masterManager.getByPhone(new PageData("PHONE", phone));
        List<PageData> orders = orderMapper.findByUser(user) ;
        for(int i=0; i<orders.size(); i++) {
            PageData order = orders.get(i);
            if(order.getString("PAID").equals("1")) {
                resend(order.get("ID")+"");
            }
        }
    }
   public List<PageData> findOrders(int id) throws Exception {
        return orderMapper.findByUser(new PageData("ID",id+""));
    }
}
