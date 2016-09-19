package com.iqiyi.controller.admaster;

import java.net.URLEncoder;
import java.util.List;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.iqiyi.controller.base.BaseController;
import com.iqiyi.service.o.category.CategoryManager;
import com.iqiyi.service.o.master.MasterManager;
import com.iqiyi.service.o.type.TypeManager;
import com.iqiyi.util.Client;
import com.iqiyi.util.CommonDeclare;
import com.iqiyi.util.PageData;
import com.iqiyi.util.ResJson;
@RequestMapping("/app")
@Controller
public class AppController extends BaseController {
	@Autowired
	private MasterManager manager;
	@Autowired
	private CategoryManager categoryManager;
	@Autowired
	private TypeManager typeManager;
	@RequestMapping
	private ModelAndView appmaster(){
		ModelAndView mv  = this.getModelAndView();
		try {
			List<PageData> pds= categoryManager.listAll(null);
			List<PageData> tDatas = typeManager.listAll(null);
			mv.addObject("tDatas", tDatas);
			mv.addObject("tCategory", pds);
			mv.setViewName("index");
			mv.addObject("checkType",tDatas.get(0).get("TYPE_ID"));
			mv.addObject("payType",1);
			for(Cookie cookie : baseRequest.getCookies()){
			    mv.addObject(cookie.getName(), cookie.getValue());
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return mv;
	}
	@RequestMapping("toLogin")
	private ModelAndView appLogin(){
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
	 	@ResponseBody
	    public String messageValidate() throws Exception {
	 		ModelAndView mv = this.getModelAndView();
	        ResJson resJson = new ResJson();
	        HttpSession session = getRequest().getSession(true);
	        PageData pd = this.getPageData();
	        String toUrl = (String) session.getAttribute(CommonDeclare.TO_URL);
	        String sPhone = (String) session.getAttribute(CommonDeclare.PHONE_NUM);
	        String sNumber = (String) session.getAttribute(CommonDeclare.VALIDATE_NUM);
	        if(pd.get("number").equals(sNumber)&&pd.get("phone").equals(sPhone)){
	        	 PageData user = manager.getByPhone(new PageData("PHONE", pd.get("phone").toString()));
	        	 if(user==null){
	        		 user = new PageData("NAME", sPhone);
		             user.put("PHONE_NUM", sPhone);
		             manager.save(user);
		             user =  manager.getByPhone(user);
	        	 }
	 	         session.setAttribute(CommonDeclare.USER, user);
	 	         resJson.setCode(1);
	 	         resJson.putData("url","app");
	        } else {
	            resJson.setCode(-1);
	            resJson.putData("msg", "手机号码或者验证码错误，请重新输入！");
	            return null;
	        }
	        return "app";
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
