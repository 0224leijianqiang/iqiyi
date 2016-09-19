package com.iqiyi.service.o.order.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.iqiyi.dao.DaoSupport;
import com.iqiyi.entity.Page;
import com.iqiyi.service.o.order.OrderManager;
import com.iqiyi.util.PageData;

/** 
 * 说明： 订单
 * 创建人：vianet21 wjm
 * 创建时间：2016-08-18
 * @version
 */
@Service("orderService")
public class OrderService implements OrderManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void save(PageData pd)throws Exception{
		dao.save("OrderMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void delete(PageData pd)throws Exception{
		dao.delete("OrderMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public void edit(PageData pd)throws Exception{
		dao.update("OrderMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@Override
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("OrderMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@Override
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("OrderMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	@Override
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("OrderMapper.findById", pd);
	}
	@Override
	public int findId(PageData pd)throws Exception{
		return (int) dao.findForObject("OrderMapper.getId", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	@Override
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("OrderMapper.deleteAll", ArrayDATA_IDS);
	}

	@Override
	public List<PageData> findByUser(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>)dao.findForList("OrderMapper.findByUser", pd);
	}
	
}

