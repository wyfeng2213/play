package com.jshuabo.templateadminmysql.server.service.channel.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jshuabo.frame.server.util.json.JacksonUtils;
import com.jshuabo.templateadminmysql.server.dao.channel.ChannelInfoMapper;
import com.jshuabo.templateadminmysql.server.service.channel.IChannelService;

@Service("channelService")
public class DefaultChannelServiceImpl implements IChannelService {
    
	@Autowired
	private ChannelInfoMapper CM;

	@Override
	public String page(Map<String, Object> params) {
		// TODO Auto-generated method stub
		@SuppressWarnings("unchecked")
		List<Map<String, Object>> rows = (List<Map<String, Object>>) CM.page(params);
		long total = CM.total(params);
		params.clear();
		params.put("rows", rows);
		params.put("total", total);
		return JacksonUtils.object2json(params); 
		
	}
	

}
