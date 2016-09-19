package com.iqiyi.controller.o.category;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.iqiyi.controller.base.BaseController;
import com.iqiyi.entity.Page;
import com.iqiyi.service.o.category.CategoryManager;
import com.iqiyi.util.AppUtil;
import com.iqiyi.util.Const;
import com.iqiyi.util.DateUtil;
import com.iqiyi.util.FileUpload;
import com.iqiyi.util.Jurisdiction;
import com.iqiyi.util.ObjectExcelView;
import com.iqiyi.util.PageData;
import com.iqiyi.util.PathUtil;
@Controller
@RequestMapping(value="/category")
public class CategoryController extends BaseController {
	
	String menuUrl = "category/list.do"; //菜单地址(权限用)
	@Resource(name="categoryService")
	private CategoryManager categoryService;
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save(HttpServletRequest request,@RequestParam(value="BGIMG",required=false) MultipartFile file,@RequestParam(value="NAVIMG",required=false) MultipartFile file2) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Category");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData(request);
		String  ffile = DateUtil.getDays(), fileName = "";
		if (null != file && !file.isEmpty()) {
			String filePath = PathUtil.getSystemPath() + Const.FILEPATHIMG + ffile;		//文件上传路径
			fileName = FileUpload.fileUp(file, filePath, this.get32UUID());			
			pd.put("BGIMG", ffile + "/" + fileName);
		}
		if (null != file2 && !file2.isEmpty()) {
			String filePath = PathUtil.getSystemPath() + Const.FILEPATHIMG + ffile;		//文件上传路径
			fileName = FileUpload.fileUp(file2, filePath, this.get32UUID());			
			pd.put("NAVIMG", ffile + "/" + fileName);
		}
		pd.put("CATEGORY_ID", this.get32UUID());	//主键
		categoryService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除Category");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		categoryService.delete(pd);
		out.write("success");
		out.close();
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
		pd = categoryService.findById(pd);	//根据ID读取
		mv.setViewName("o/category/category_view");
		mv.addObject("pd", pd);
		return mv;
	}	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit(HttpServletRequest request,@RequestParam(value="BGIMG",required=false) MultipartFile file,@RequestParam(value="NAVIMG",required=false) MultipartFile file2) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Category");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData(request);
		String  ffile = DateUtil.getDays(), fileName = "";
		if (null != file && !file.isEmpty()) {
			String filePath = PathUtil.getSystemPath() + Const.FILEPATHIMG + ffile;		//文件上传路径
			fileName = FileUpload.fileUp(file, filePath, this.get32UUID());			
			pd.put("BGIMG", ffile + "/" + fileName);
		}
		if (null != file2 && !file2.isEmpty()) {
			String filePath = PathUtil.getSystemPath() + Const.FILEPATHIMG + ffile;		//文件上传路径
			fileName = FileUpload.fileUp(file2, filePath, this.get32UUID());			
			pd.put("NAVIMG", ffile + "/" + fileName);
		}
		categoryService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表Category");
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
		List<PageData>	varList = categoryService.list(page);	//列出Category列表
		mv.setViewName("o/category/category_list");
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
		mv.setViewName("o/category/category_edit");
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
		pd = categoryService.findById(pd);	//根据ID读取
		mv.setViewName("o/category/category_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Category");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			categoryService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Category到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("标题");	//1
		titles.add("背景图");	//2
		titles.add("导航图");	//3
		titles.add("内容说明");	//4
		titles.add("链接地址");	//5
		titles.add("是否上架");	//6
		dataMap.put("titles", titles);
		List<PageData> varOList = categoryService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("NAME"));	//1
			vpd.put("var2", varOList.get(i).getString("BGIMG"));	//2
			vpd.put("var3", varOList.get(i).getString("NAVIMG"));	//3
			vpd.put("var4", varOList.get(i).getString("CONTENT"));	//4
			vpd.put("var5", varOList.get(i).getString("LINK"));	//5
			vpd.put("var6", varOList.get(i).getString("USED"));	//6
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
