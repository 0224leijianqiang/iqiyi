package com.iqiyi.controller.admaster;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.iqiyi.controller.base.BaseController;
import com.iqiyi.util.Client;
import com.iqiyi.util.CommonDeclare;
import com.iqiyi.util.PageData;
import com.iqiyi.util.ResJson;
@RequestMapping("/applogin")
@Controller
public class AppLoginController extends BaseController {
	@RequestMapping
	private ModelAndView appmaster(){
		ModelAndView mv  = this.getModelAndView();
		try {
			mv.setViewName("account/login");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return mv;
	}
	@RequestMapping("sendValidateMsg")
	public Object sendValidateMsg(){
		PageData pd = this.getPageData();
		try {
			  	String number = generateNumber(4);
	            HttpSession session = getRequest().getSession(true);
	            Client client = new Client(CommonDeclare.MSG_SN, CommonDeclare.MSG_PWD);
	            session.setAttribute(CommonDeclare.VALIDATE_NUM, number);
	            session.setAttribute(CommonDeclare.PHONE_NUM, pd.getString("phone"));
	            String content = URLEncoder.encode(CommonDeclare.VALIDATE_TEXT.replace("@", number), "utf8");
	            String result = client.mdsmssend(pd.getString("phone"), content, "", "", "", "");
	            System.out.println(number);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "success";
	}
	 	@RequestMapping(value = "/validate")
	    public ModelAndView messageValidate() throws IOException {
	 		ModelAndView mv = this.getModelAndView();
	        ResJson resJson = new ResJson();
	        PageData pd = this.getPageData();
	        HttpSession session = getRequest().getSession(true);
	        String toUrl = (String) session.getAttribute(CommonDeclare.TO_URL);
	        String sPhone = (String) session.getAttribute(CommonDeclare.PHONE_NUM);
	        String sNumber = (String) session.getAttribute(CommonDeclare.VALIDATE_NUM);
	        if(!pd.get("phone").equals(sPhone)||!pd.get("number").equals(sNumber))return null;
	        /*User user = loginService.validate(sPhone, sNumber, phone, number);
	        if (user != null) {
	            session.setAttribute(CommonDeclare.USER, user);
	            resJson.setCode(1);
	            resJson.putData("toUrl", toUrl);
	        } else {
	            resJson.setCode(-1);
	            resJson.putData("msg", "手机号码或者验证码错误，请重新输入！");
	        }*/
	        String url = (String) session.getAttribute("url");
	        PageData pd1 = (PageData) session.getAttribute("params");
	        if(!url.equals("")){
	        	Iterator entries = pd.entrySet().iterator(); 
	    		Map.Entry entry; 
	    		String name = "?";  
	    		while (entries.hasNext()) {
	    			entry = (Map.Entry) entries.next(); 
	    			name+=entry.getKey()+"="+entry.getValue()+"&";
	    		}
	        	response.sendRedirect(url+name.substring(0,name.length()-1));
	        }else{
	        	mv.setViewName("redirect:../appmaster");
	        	return mv;
	        }
	        return null;
	 	}
	 private String generateNumber(int count) {
	        StringBuffer sb = new StringBuffer();
	        String str = "0123456789";
	        Random r = new Random();
	        for (int i = 0; i < count; i++) {
	            int num = r.nextInt(str.length());
	            sb.append(str.charAt(num));
	            str = str.replace((str.charAt(num) + ""), "");
	        }
	        return sb.toString();
	    }
	 
}
