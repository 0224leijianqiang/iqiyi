package com.iqiyi.controller.system.resources;

import java.io.BufferedOutputStream;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.iqiyi.controller.base.BaseController;
import com.iqiyi.entity.Page;
import com.iqiyi.service.system.resources.ResourcesManager;
import com.iqiyi.util.AppUtil;
import com.iqiyi.util.Jurisdiction;
import com.iqiyi.util.ObjectExcelView;
import com.iqiyi.util.PageData;
import com.iqiyi.util.Tools;
@Controller
@RequestMapping(value="/resources")
public class ResourcesController extends BaseController {
	
	String menuUrl = "resources/list.do"; //菜单地址(权限用)
	@Resource(name="resourcesService")
	private ResourcesManager resourcesService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Resources");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("RESOURCES_ID", this.get32UUID());	//主键
		pd.put("CREATE_DATE", Tools.date2Str(new Date()));	//创建时间
		pd.put("IS_DELETE", "");	//是否删除
		resourcesService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除Resources");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		resourcesService.delete(pd);
		out.write("success");
		out.close();
	}
	@RequestMapping(value="/download")
	public void download(){
		try {
			PageData pd = this.getPageData();
			 pd= resourcesService.findById(pd);
			//   设置响应头和下载保存的文件名    
			response.setContentType("APPLICATION/OCTET-STREAM");    
			response.setHeader("Content-Disposition","attachment;   filename=\""   +  new String(pd.getString("NAME").getBytes("UTF-8"), "ISO8859-1") +   "\"");    
			  //   打开指定文件的流信息    
			java.io.FileInputStream   fileInputStream   =   new   java.io.FileInputStream(pd.getString("PATH"));    
			BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
			//   写出流信息    
			int   i;    
			  while   ((i=fileInputStream.read())   !=   -1)   {    
			    out.write(i);    
			  }    
			  fileInputStream.close();    
			  out.close(); 
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	/**去查看页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goView")
	public ModelAndView goView()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = resourcesService.findById(pd);	//根据ID读取
		mv.setViewName("system/resources/resources_view");
		mv.addObject("pd", pd);
		return mv;
	}	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Resources");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		resourcesService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Resources");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		pd.put("CREATE_ROLE_ID", Jurisdiction.getCreateId());
		page.setPd(pd);
		List<PageData>	varList = resourcesService.list(page);	//列出Resources列表
		mv.setViewName("system/res/res_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("system/resources/resources_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = resourcesService.findById(pd);	//根据ID读取
		mv.setViewName("system/resources/resources_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Resources");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			resourcesService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出Resources到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("名称");	//1
		titles.add("类型");	//2
		titles.add("大小");	//3
		titles.add("物理路径");	//4
		titles.add("访问路径");	//5
		titles.add("创建用户");	//6
		titles.add("创建时间");	//7
		titles.add("是否删除");	//8
		dataMap.put("titles", titles);
		List<PageData> varOList = resourcesService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("NAME"));	//1
			vpd.put("var2", varOList.get(i).getString("TYPE"));	//2
			vpd.put("var3", varOList.get(i).get("SIZE").toString());	//3
			vpd.put("var4", varOList.get(i).getString("PATH"));	//4
			vpd.put("var5", varOList.get(i).getString("URL"));	//5
			vpd.put("var6", varOList.get(i).getString("USER_ID"));	//6
			vpd.put("var7", varOList.get(i).getString("CREATE_DATE"));	//7
			vpd.put("var8", varOList.get(i).getString("IS_DELETE"));	//8
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
