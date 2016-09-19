package com.iqiyi.service.o.master.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.iqiyi.dao.DaoSupport;
import com.iqiyi.entity.Page;
import com.iqiyi.service.o.master.MasterManager;
import com.iqiyi.util.PageData;

/** 
 * 说明： 用户
 * 创建人：vianet21 wjm
 * 创建时间：2016-08-18
 * @version
 */
@Service("masterService")
public class MasterService implements MasterManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void save(PageData pd)throws Exception{
		dao.save("MasterMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void delete(PageData pd)throws Exception{
		dao.delete("MasterMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void edit(PageData pd)throws Exception{
		dao.update("MasterMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@Override
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("MasterMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@Override
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("MasterMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("MasterMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	@Override
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("MasterMapper.deleteAll", ArrayDATA_IDS);
	}

	@Override
	public PageData getByPhone(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData)dao.findForObject("MasterMapper.getByPhone", pd);
	}
	
}

