package com.jshuabo.templateadminmysql.server.service.supplier.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jshuabo.frame.server.util.json.JacksonUtils;
import com.jshuabo.templateadminmysql.server.dao.supplier.SupplierInfoMapper;
import com.jshuabo.templateadminmysql.server.model.supplier.SupplierInfo;
import com.jshuabo.templateadminmysql.server.service.supplier.ISupplierService;

@Service("supplierService")
public class DefaultSupplierServiceImpl implements ISupplierService {
	
	@Autowired
	private SupplierInfoMapper SM;

	@Override
	public String page(Map<String, Object> params) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		List<Map<String, Object>> rows = (List<Map<String, Object>>) SM.page(params);
		long total = SM.total(params);
		params.clear();
		params.put("rows", rows);
		params.put("total", total);
		return JacksonUtils.object2json(params); 
		
	}
	
	/**
	 * 取得供应商列表
	 * 
	 * @return
	 */
	@Override
	public List<SupplierInfo> getAllSupplier(){
		List<SupplierInfo> supList = new ArrayList<SupplierInfo>();
		supList = SM.selectAllSupplier();
		return supList;
	}
	
	
	@Override
	public SupplierInfo selectByPrimaryKey(Long id) {
		 return SM.selectByPrimaryKey(id);
	
	}
	

}
