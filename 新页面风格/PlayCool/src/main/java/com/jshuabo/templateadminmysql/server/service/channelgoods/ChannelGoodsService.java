package com.jshuabo.templateadminmysql.server.service.channelgoods;



import org.springframework.transaction.annotation.Transactional;

import com.jshuabo.frame.server.service.IBaseService;
import com.jshuabo.templateadminmysql.server.model.channelgoods.ChannelGoods;

public interface ChannelGoodsService extends IBaseService {
	//添加
	@Transactional
	String addChannelGoods(ChannelGoods channelGoods);

	 
	
}
