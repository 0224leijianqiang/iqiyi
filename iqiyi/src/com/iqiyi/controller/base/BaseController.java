package com.iqiyi.controller.base;


import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.iqiyi.entity.Page;
import com.iqiyi.plugin.websocketOnline.OnlineChatServerPool;
import com.iqiyi.service.system.log.impl.LogService;
import com.iqiyi.util.Const;
import com.iqiyi.util.Jurisdiction;
import com.iqiyi.util.Logger;
import com.iqiyi.util.PageData;
import com.iqiyi.util.Tools;
import com.iqiyi.util.UuidUtil;

/**
 * @author wjm
 * 修改时间：2015、12、11
 */
public class BaseController {
	protected Logger logger = Logger.getLogger(this.getClass());
	@Autowired
	private LogService logService;
	private static final long serialVersionUID = 6357869213649815390L;
	public HttpServletResponse response;
	public HttpServletRequest baseRequest;
    @ModelAttribute  
    public void setReqAndRes(HttpServletRequest request, HttpServletResponse response){  
        this.response = response;  
        this.baseRequest = request;
    } 
	/** new PageData对象
	 * @return
	 */
	public PageData getPageData(){
		return new PageData(this.getRequest());
	}
	
	/**得到ModelAndView
	 * @return
	 */
	public ModelAndView getModelAndView(){
		return new ModelAndView();
	}
	/**得到request对象
	 * @return
	 */
	public HttpServletRequest getRequest() {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		return request;
	}
	/**得到32位的uuid
	 * @return
	 */
	public String get32UUID(){
		return UuidUtil.get32UUID();
	}
	/**得到分页列表的信息
	 * @return
	 */
	public Page getPage(){
		return new Page();
	}
	
	public static void logBefore(Logger logger, String interfaceName){
		logger.info("");
		logger.info("start");
		logger.info(interfaceName);
	}
	
	public static void logAfter(Logger logger){
		logger.info("end");
		logger.info("");
	}
	public void addLog(String tLogDesc){
		PageData pd = new PageData();
		pd.put("LOG_ID",get32UUID());
		pd.put("TLOGDESC", tLogDesc);
		HttpServletRequest request = this.getRequest();
		String ip = "";
		if (request.getHeader("x-forwarded-for") == null) {  
			ip = request.getRemoteAddr();  
	    }else{
	    	ip = request.getHeader("x-forwarded-for");  
	    }
		pd.put("TUSERIP", ip);
		pd.put("TUSERID",Jurisdiction.getUserId());
		pd.put("TUSERNAME",Jurisdiction.getUsername());
		pd.put("TIME", Tools.date2Str(new Date()));
		try {
			logService.save(pd);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public String initTableBar(ModelAndView mv){
		String KV= Tools.readTxtFile(Const.getConfig("REQUEST"));
		return "";
	}
	public void initTableData(ModelAndView mv){
		
	}
	public void sendMsg(String username){
		JSONObject result = new JSONObject();
		result.element("type", "senFhsms");
		OnlineChatServerPool.sendMessageToUser(OnlineChatServerPool.getWebSocketByUser(username),result.toString());
	}
	
	
}
