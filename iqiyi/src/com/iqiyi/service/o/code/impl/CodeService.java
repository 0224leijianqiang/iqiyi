package com.iqiyi.service.o.code.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.iqiyi.dao.DaoSupport;
import com.iqiyi.entity.Page;
import com.iqiyi.service.o.code.CodeManager;
import com.iqiyi.util.PageData;

/** 
 * 说明： 激活码
 * 创建人：vianet21 wjm
 * 创建时间：2016-08-18
 * @version
 */
@Service("codeService")
public class CodeService implements CodeManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void save(PageData pd)throws Exception{
		dao.save("CodeMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void delete(PageData pd)throws Exception{
		dao.delete("CodeMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void edit(PageData pd)throws Exception{
		dao.update("CodeMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@Override
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("CodeMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@Override
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("CodeMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("CodeMapper.findById", pd);
	}
	@Override
	public int getCountByCity(PageData pd)throws Exception{
		return (int)dao.findForObject("CodeMapper.getCountByCity", pd);
	}
	@Override
	public PageData getByCity(PageData pd)throws Exception{
		return (PageData)dao.findForObject("CodeMapper.getByCity", pd);
	}
	@Override
	public  List<PageData>  findByOrderId(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("CodeMapper.findByOrderId", pd);
	}
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	@Override
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("CodeMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

