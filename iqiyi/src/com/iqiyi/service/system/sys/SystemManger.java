
package com.iqiyi.service.system.sys;

import java.util.List;

import com.iqiyi.util.PageData;

public interface SystemManger {
	public List<PageData> showTables() throws Exception;
	public List<PageData> showCloumns(PageData params) throws Exception;
}
