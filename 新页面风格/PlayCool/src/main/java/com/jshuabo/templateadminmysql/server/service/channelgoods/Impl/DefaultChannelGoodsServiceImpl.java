package com.jshuabo.templateadminmysql.server.service.channelgoods.Impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jshuabo.frame.server.aop.web.controller.CommonControllerAspect;
import com.jshuabo.frame.server.exception.BusinessLayerException;
import com.jshuabo.frame.server.util.json.JacksonUtils;
import com.jshuabo.templateadminmysql.server.dao.channelgoods.ChannelGoodsMapper;
import com.jshuabo.templateadminmysql.server.model.channelgoods.ChannelGoods;

import com.jshuabo.templateadminmysql.server.service.channelgoods.ChannelGoodsService;


@Service("channelGoodsService")
public class DefaultChannelGoodsServiceImpl implements ChannelGoodsService{
	
	private static final Logger logger=LoggerFactory.getLogger(DefaultChannelGoodsServiceImpl.class);
     
	@Autowired
	private ChannelGoodsMapper ChannelGoodsMapper;
	@Override
	public String page(Map<String, Object> params) {
		@SuppressWarnings("unchecked")
		List<Map<String, Object>> rows = (List<Map<String, Object>>) ChannelGoodsMapper.page(params);
		long total = ChannelGoodsMapper.total(params);
		params.clear();
		params.put("rows", rows);
		params.put("total", total);
		return JacksonUtils.object2json(params); 
	}
	// 添加商品
	@Override
	public String addChannelGoods(ChannelGoods channelGoods) {	
		String errorMsg;
		Map<String, Object> params = new HashMap<String, Object>();
		params.clear();
		params.put("id", channelGoods.getId());
		params.put("code", channelGoods.getCode());
		params.put("name",channelGoods.getName());
		params.put("goods_describe", channelGoods.getGoods_describe());
		params.put("photo_path", channelGoods.getPhoto_path());
		List<ChannelGoods> channelGoodsList = ChannelGoodsMapper.loadByParams(params);
		
		if(channelGoodsList.size()>0){
			errorMsg = "商品:{" + channelGoods.getName() + "},已经存在!";
			logger.error(errorMsg);
			throw new BusinessLayerException(errorMsg);
		}
		ChannelGoodsMapper.save(channelGoods);
		return  CommonControllerAspect.RETURN_VOID;
}
}
