package com.iqiyi.service.o.code;

import java.util.List;

import com.iqiyi.entity.Page;
import com.iqiyi.util.PageData;

/** 
 * 说明： 激活码接口
 * 创建人：vianet21 wjm
 * 创建时间：2016-08-18
 * @version
 */
public interface CodeManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	public int getCountByCity(PageData pd)throws Exception;
	public PageData getByCity(PageData pd)throws Exception;
	public List<PageData> findByOrderId(PageData pd)throws Exception;
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	
}

