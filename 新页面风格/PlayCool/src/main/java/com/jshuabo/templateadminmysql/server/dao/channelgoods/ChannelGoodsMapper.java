package com.jshuabo.templateadminmysql.server.dao.channelgoods;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.jshuabo.frame.server.dao.IBaseMapper;
import com.jshuabo.templateadminmysql.server.model.channelgoods.ChannelGoods;


@Repository
public interface ChannelGoodsMapper extends IBaseMapper<ChannelGoods> {
	/*查看*/
	@Transactional
	List<ChannelGoods> loadByParams(Map<String, Object>params);
	
	List<ChannelGoods> loadByName(Map<String, Object> params);
	

}

