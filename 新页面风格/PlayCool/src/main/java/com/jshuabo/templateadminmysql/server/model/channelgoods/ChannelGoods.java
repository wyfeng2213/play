package com.jshuabo.templateadminmysql.server.model.channelgoods;

import com.jshuabo.frame.server.model.base.REntity;

public class ChannelGoods extends REntity  {
  
	private static final long serialVersionUID = 1L;
	private Long id;
	private String code;
	private String name;
	private String goods_describe;
	private String photo_path;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	

	public String getGoods_describe() {
		return goods_describe;
	}
	public void setGoods_describe(String goods_describe) {
		this.goods_describe = goods_describe;
	}
	public String getPhoto_path() {
		return photo_path;
	}
	public void setPhoto_path(String photo_path) {
		this.photo_path = photo_path;
	}
	
	
	

}
