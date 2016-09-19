package com.iqiyi.util;

import org.springframework.context.ApplicationContext;
/**
 * 项目名称：
 * @author:wei.jiangming@21vianet.com
*/
public class Const {
	public static final String SESSION_SECURITY_CODE = "sessionSecCode";//验证码
	public static final String SESSION_USER = "sessionUser";			//session用的用户
	public static final String SESSION_ROLE_RIGHTS = "sessionRoleRights";
	public static final String sSESSION_ROLE_RIGHTS = "sessionRoleRights";
	public static final String SESSION_menuList = "menuList";			//当前菜单
	public static final String SESSION_allmenuList = "allmenuList";		//全部菜单
	public static final String SESSION_QX = "QX";
	public static final String SESSION_userpds = "userpds";			
	public static final String SESSION_USERROL = "USERROL";				//用户对象
	public static final String SESSION_USERNAME = "USERNAME";
	public static final String SESSION_ROLE = "CREATE_ROLE";
	//用户名
	public static final String TRUE = "T";
	public static final String FALSE = "F";
	public static final String LOGIN = "/login_toLogin.do";				//登录地址
	public static final String SYSNAME = "admin/config/SYSNAME.txt";	//系统名称路径
	public static final String PAGE	= "admin/config/PAGE.txt";			//分页条数配置路径
	public static final String EMAIL = "admin/config/EMAIL.txt";		//邮箱服务器配置路径
	public static final String SMS1 = "admin/config/SMS1.txt";			//短信账户配置路径1
	public static final String SMS2 = "admin/config/SMS2.txt";			//短信账户配置路径2
	public static final String FWATERM = "admin/config/FWATERM.txt";	//文字水印配置路径
	public static final String IWATERM = "admin/config/IWATERM.txt";	//图片水印配置路径
	public static final String WEIXIN	= "admin/config/WEIXIN.txt";	//微信配置路径
	public static final String WEBSOCKET = "admin/config/WEBSOCKET.txt";//WEBSOCKET配置路径
	public static final String FILEPATHIMG = "uploadFiles/uploadImgs/";	//图片上传路径
	public static final String FILEPATHFILE = "uploadFiles/file/";		//文件上传路径
	public static final String FILEPATHTWODIMENSIONCODE = "uploadFiles/twoDimensionCode/"; //二维码存放路径
	public static final String NO_INTERCEPTOR_PATH = ".*/((login)|(logout)|(code)|(app)|(weixin)|(static)|(main)|(websocket)|(uploadFiles)).*";	//不对匹配该值的访问路径拦截（正则）
	public static ApplicationContext WEB_APP_CONTEXT = null; //该值会在web容器启动时由WebAppContextListener初始化
	
	/**
	 * APP Constants
	 */
	//app注册接口_请求协议参数)
	public static final String[] APP_REGISTERED_PARAM_ARRAY = new String[]{"countries","uname","passwd","title","full_name","company_name","countries_code","area_code","telephone","mobile"};
	public static final String[] APP_REGISTERED_VALUE_ARRAY = new String[]{"国籍","邮箱帐号","密码","称谓","名称","公司名称","国家编号","区号","电话","手机号"};
	
	//app根据用户名获取会员信息接口_请求协议中的参数
	public static final String[] APP_GETAPPUSER_PARAM_ARRAY = new String[]{"USERNAME"};
	public static final String[] APP_GETAPPUSER_VALUE_ARRAY = new String[]{"用户名"};
	public static String getConfig(String fileName){return "admin/config/"+fileName+".txt";}
	public static int SERVICE_CATEGORY_TYPE_REQUEST = 1;
	public static int SERVICE_CATEGORY_TYPE_REPAIR  = 2;
	public static int SERVICE_CATEGORY_TYPE_CHANGE  = 3;
	public static int SERVICE_CATEGORY_TYPE_LEVEL=4;
	public static int WORKORDER_CATEGORY_TYPE_REQUEST=5;
	public static int WORKORDER_CATEGORY_SOURCE_REQUEST=6;
	//程序字典编码
	public static String STATUS_DICTIONARIES_LEVEL_DEAL_WITH="002";
	public static String STATUS_DICTIONARIES_LEVEL_RESPONSE="003";
	public static String STATUS_DICTIONARIES_REQUEST="004";
	public static String STATUS_DICTIONARIES_REPIRE="005";
	public static String STATUS_DICTIONARIES_CHANGE="006";
	public static String STATUS_DICTIONARIES_WORKORDER_REQUEST_DEFAULT="007101";
	
	
	public static String ORDER_WORK_TYPE_EDIT = "007301";
	public static String ORDER_WORK_TYPE_SUSPEND = "007302";
	public static String ORDER_WORK_TYPE_REMINDER = "007303";
	public static String ORDER_WORK_TYPE_SPONSOR_CHANGER = "007304";
	public static String ORDER_WORK_TYPE_RECEIVE_WITH = "007305";
	public static String ORDER_WORK_TYPE_RELATION = "007306";
	public static String ORDER_WORK_TYPE_TRANSFER = "007307";
	public static String ORDER_WORK_TYPE_REFUSE = "007308";
	public static String ORDER_WORK_TYPE_SURRENDER = "007309";
}
