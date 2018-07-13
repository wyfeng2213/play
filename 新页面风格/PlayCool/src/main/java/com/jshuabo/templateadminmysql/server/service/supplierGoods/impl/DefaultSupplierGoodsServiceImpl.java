package com.jshuabo.templateadminmysql.server.service.supplierGoods.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jshuabo.frame.server.util.json.JacksonUtils;
import com.jshuabo.templateadminmysql.server.dao.supplier.SupplierInfoMapper;
import com.jshuabo.templateadminmysql.server.dao.supplierGoods.GoodInfoMapper;
import com.jshuabo.templateadminmysql.server.model.supplier.SupplierInfo;
import com.jshuabo.templateadminmysql.server.model.supplierGoods.GoodInfo;
import com.jshuabo.templateadminmysql.server.service.supplierGoods.ISupplierGoodsService;

@Service("goodsInfoService")
public class DefaultSupplierGoodsServiceImpl implements ISupplierGoodsService{
	private static final Logger logger = LoggerFactory.getLogger(DefaultSupplierGoodsServiceImpl.class);
	@Autowired
	private GoodInfoMapper goodInfoMapper;


	@Override
	public String page(Map<String, Object> params) {
		params.put("delFlag", "0");
		@SuppressWarnings("unchecked")
		List<Map<String, Object>> rows = (List<Map<String, Object>>) goodInfoMapper.page(params);
		long total = goodInfoMapper.total(params);
		params.clear();
		params.put("rows", rows);
		params.put("total", total);
		return JacksonUtils.object2json(params);
	}
	 /*增加*/
	/*@Override
	public String addGoodInfo(GoodInfo goodInfo) {
		
		
		String errorMsg;
		Map<String, Object> params = new HashMap<String, Object>();			
		params.clear();
		params.put("name", goodInfo.getName());
		List<GoodInfo> goodsList = goodInfoMapper.loadByParams(params);			
		if(goodsList.size()>0){
		errorMsg = "名称:{" + goodInfo.getName() + "},已经存在!";
		logger.error(errorMsg);
		throw new BusinessLayerException(errorMsg);
		}
		goodInfoMapper.addGoods(goodInfo);
		return  CommonControllerAspect.RETURN_VOID;
	}*/
	

	@Override
	public String findGoodsparam(Integer id, Integer supplierId) {
		// TODO Auto-generated method stub
		Map<String , Integer>params = new HashMap<String, Integer>();
		params.put("id", id);
		params.put("supplierId", supplierId);
		return goodInfoMapper.findGoodsparam(params);
	
	}
	
	@Override
	public GoodInfo loadById(Long id) {
		// TODO Auto-generated method stub
		return goodInfoMapper.selectByPrimaryKey(id);
	}

	@Override
	public void updateByPrimaryKeySelective(GoodInfo goodInfo){
		goodInfoMapper.updateByPrimaryKeySelective(goodInfo);
	}


	@Override
	public Long addGoodInfo(GoodInfo goodInfo) {
		goodInfoMapper.insertReturnId(goodInfo);
		return goodInfo.getId();
	}
	
	@Override
	public List<GoodInfo> findSupplierGoods(Long supplierId) {
		// TODO Auto-generated method stub
		Map<String , Long>params = new HashMap<String, Long>();
		params.put("supplierId", supplierId);
		return goodInfoMapper.findSupplierGoods(params);
	
	}


}
