package com.iqiyi.util;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;

/**
 * 调度公用常量类
 * User: baibing
 * Date: 13-5-2
 * Time: 下午4:11
 */
public final class CommonDeclare {
	public static final String BASE_URL=System.getProperty("os.name").toLowerCase().contains("windows")?"http://192.168.1.108:8080/iqiyi/":"http://uping8.com:8090/iqiyi/";
//	public static final String BASE_URL="http://192.168.1.104:8080/iqiyi/";
//	private static final String BASE_URL="http://192.168.1.104:8070/iqiyi/";
    public static final String PHONE_NUM="PHONE_NUMBER"; //【秀域】
    public static final String VALIDATE_NUM="VALIDATE_NUM";
    public static final String VALIDATE_TEXT="您的验证码为：@，有效期为10分钟【爱奇艺】";
    public static final String COST_TEXT="您的消费码为：@【秀域】";
    public static final String BOOK_TEXT="您的预约码为：@【秀域】";
//    public static final String CODE="您的肯德基咖啡,订单号为：#，消费码为：@。请您妥善保管，丢失不补发，感谢支持。【爱奇艺】";
    public static final String CODE="亲，您已成功购买#，激活码：@，有效期至 &。感谢您的信任，请您登录http://t.cn/Ryn0dcG，按提示激活。如有疑问，请拨打：400-923-7171【爱奇艺】";
    public static final String TO_URL="TO_URL";
    public static final String DEFAULT_NAME="亲";
    public static final String ZDH_PAY_URL="http://m.baidu.com/lightapp/pay/order/online/add";
    public static final String ZDH_REFUND_URL="http://m.baidu.com/lightapp/pay/order/refund";
    public static final String ZDH_REFUND_NOTIFY_URL="http://y123.57.237.17:8082/Get.html";   //N个工作日才调用，配置到店铺
    public static final String ZDH_ITEM_URL="http://123.57.237.17:8082/Get.htmlw";                  //单个产品页面
    public static final String ZDH_SEND_CODE_URL="http://m.baidu.com/lightapp/pay/order/open/ticket/generate";  //发送码url
    public static final String ZDH_SEND_CODE_RETYR_URL="http://123.57.237.17:8082/business/you";     //当出票失败后，轻应用支付平台重试出票后的结果通知。
    public static final String ZDH_VERIFICATION_URL="http://m.baidu.com/lightapp/pay/ticket/ecode/use";
    public static final  double EARTH_RADIUS = 6378.137;//赤道半径(单位m)
    public static final String USER = "USER";
    public static final String ADMIN = "ADMIN";
    public static final String VALIDATE_CODE = "VALIDATE_CODE";
    public static final int VALID_PAY_DATE = 15;
    public static final BigDecimal PRICE=new BigDecimal(9);
//    public static final String MSG_SN="SDK-BBX-010-21010";
//    public static final String MSG_PWD="1D0bfe27";
    public static final String MSG_SN="SDK-BBX-010-23138";
    public static final String MSG_PWD="[da8-07[";
    public static final String ZDH_ID="6130473";
    public static final String ZDH_AK="UYCbivbjKgdRiYE8FUfaDihA";
    public static final String ZDH_SK="2LjLOW4VhWGnIUeejtlNr6t3xLzikUTU";

    public static final String ZDH_SHOP="245349";
    public static final String ZDH_SHOP_SK="A09e5OdaOcwTQdoWnDT6zXHj8UDb6ZGI";
//    public static final String ZDH_PAY_NOTIFY_URL="http://123.57.237.17:8083/pay-notify"; //付款后的通知页面，上线后改为my/business/pay-notify
    public static final String ZDH_PAY_NOTIFY_URL="http://172.16.97.138:8070/iqiyi/appbusiess/pay-notify";
    public static final String ZDH_RETURN_URL="http://123.57.237.17:8083/result";    //付款成功后的跳转页面
    public static final String ZDH_ORDER_SOURCE_URL="http://123.57.237.17:8083/result";     //发送码短信里面有 ，订单来源页
    public static final String ZDH_SEND_CHECK_SUCC_URL="http://123.57.237.17:8083/appbusiness/certify-notify";  //核销成功需要跳转的url
    private CommonDeclare() throws UnsupportedEncodingException {

    }
    public static final String API_KEY="62Dc2201C2854E9662ec2201c2854E96"; //62Dc2201C2854E9662ec2201c2854E96
    public static final String APPID="wx62ec2201c2854e96";
    public static final String MCH_ID="1359244502";
//    public static final String NOTIFY_URL="http://www.uping8.com/notify/pay-wechat-notify";
    public static final String NOTIFY_URL=BASE_URL+"/appnotice/notify/pay-wechat-notify";
    public static final String UNIFIED_ORDER_URL="https://api.mch.weixin.qq.com/pay/unifiedorder";
    public static final String WECHAT_ERROR="WECHAT_ERROR";
    public static final String WX_ORDER_QUERY="https://api.mch.weixin.qq.com/pay/orderquery";
    //百付宝
    public static final String BFB_URL = "https://www.baifubao.com/api/0/pay/0/wapdirect/0";
    public static final String BD_ORDER_QUERY="https://www.baifubao.com/api/0/query/0/pay_result_by_order_no";
    public static final String BFB_SP_NO="1001787753";
    public static final String BFB_RETURN_RESULT = BASE_URL+"/appnotice/bdnotice";
    public static final String BFB_RESULT = BASE_URL+"/appresultbusiness";
    public static final String BFB_KEY = "3Tki3uztdaDQfRQVN57z7bExqPX9GUPJ";
}
