package com.jshuabo.templateadminmysql.server.service.manager.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jshuabo.frame.server.util.json.JacksonUtils;
import com.jshuabo.templateadminmysql.server.dao.manager.ManagerMapper;
import com.jshuabo.templateadminmysql.server.model.manager.Manager;
import com.jshuabo.templateadminmysql.server.service.manager.IManagerService;


@Service("managerService")
public class DefaultManagerServiceImpl implements IManagerService {
	
	private static final Logger logger = LoggerFactory.getLogger(DefaultManagerServiceImpl.class);

	@Autowired
	private ManagerMapper managerMapper;
	@Override
	public String page(Map<String, Object> params) {
		params.put("delFlag", "0");
		@SuppressWarnings("unchecked")
		List<Map<String, Object>> rows = (List<Map<String, Object>>) managerMapper.page(params);
		long total = managerMapper.total(params);
		params.clear();
		params.put("rows", rows);
		params.put("total", total);
		return JacksonUtils.object2json(params);
	}

	@Override
	public String addManager(Manager manager) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String findGoodsparam(Integer id, Integer supplier_id) {
		// TODO Auto-generated method stub
		Map<String , Integer>params = new HashMap<String, Integer>();
		params.put("id", id);
		params.put("supplier_id", supplier_id);
		return managerMapper.findGoodsparam(params);
	}

	@Override
	public List<Manager> findAllManager() {
		// TODO Auto-generated method stub
		return managerMapper.findAllManager();
	}

}
