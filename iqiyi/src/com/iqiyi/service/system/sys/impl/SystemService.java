package com.iqiyi.service.system.sys.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.iqiyi.dao.DaoSupport;
import com.iqiyi.service.system.sys.SystemManger;
import com.iqiyi.util.PageData;
@Service("systemService")
public class SystemService implements SystemManger {
	@Resource(name = "daoSupport")
	private DaoSupport dao;

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> showTables() throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("SystemMapper.showTables", null);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PageData> showCloumns(PageData params) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("SystemMapper.showCloumns", params);
	}
}
