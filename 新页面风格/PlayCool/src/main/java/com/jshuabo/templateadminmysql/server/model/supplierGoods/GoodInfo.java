package com.jshuabo.templateadminmysql.server.model.supplierGoods;

import java.util.Date;

import com.jshuabo.frame.server.model.base.REntity;

public class GoodInfo extends REntity{
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_goods_info.id
     *
     * @mbggenerated
     */
    private Long id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_goods_info.code
     *
     * @mbggenerated
     */
    private String code;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_goods_info.name
     *
     * @mbggenerated
     */
    private String name;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_goods_info.supplier_url
     *
     * @mbggenerated
     */
    private String supplierUrl;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_goods_info.channel_url
     *
     * @mbggenerated
     */
    private String channelUrl;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_goods_info.supplier_id
     *
     * @mbggenerated
     */
    private Long supplierId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_goods_info.channel_id
     *
     * @mbggenerated
     */
    private Long channelId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_goods_info.describe
     *
     * @mbggenerated
     */
    private String goodsDescribe;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_goods_info.photo_path
     *
     * @mbggenerated
     */
    private String photoPath;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_goods_info.del_flag
     *
     * @mbggenerated
     */
    private int delFlag;
    
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_goods_info.add_time
     *
     * @mbggenerated
     */
    private Date addTime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_goods_info.update_time
     *
     * @mbggenerated
     */
    private Date updateTime;
    
    private int flowStatus;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_goods_info.id
     *
     * @return the value of t_goods_info.id
     *
     * @mbggenerated
     */
    public Long getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_goods_info.id
     *
     * @param id the value for t_goods_info.id
     *
     * @mbggenerated
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_goods_info.code
     *
     * @return the value of t_goods_info.code
     *
     * @mbggenerated
     */
    public String getCode() {
        return code;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_goods_info.code
     *
     * @param code the value for t_goods_info.code
     *
     * @mbggenerated
     */
    public void setCode(String code) {
        this.code = code == null ? null : code.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_goods_info.name
     *
     * @return the value of t_goods_info.name
     *
     * @mbggenerated
     */
    public String getName() {
        return name;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_goods_info.name
     *
     * @param name the value for t_goods_info.name
     *
     * @mbggenerated
     */
    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_goods_info.supplier_url
     *
     * @return the value of t_goods_info.supplier_url
     *
     * @mbggenerated
     */
    public String getSupplierUrl() {
        return supplierUrl;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_goods_info.supplier_url
     *
     * @param supplierUrl the value for t_goods_info.supplier_url
     *
     * @mbggenerated
     */
    public void setSupplierUrl(String supplierUrl) {
        this.supplierUrl = supplierUrl == null ? null : supplierUrl.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_goods_info.channel_url
     *
     * @return the value of t_goods_info.channel_url
     *
     * @mbggenerated
     */
    public String getChannelUrl() {
        return channelUrl;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_goods_info.channel_url
     *
     * @param channelUrl the value for t_goods_info.channel_url
     *
     * @mbggenerated
     */
    public void setChannelUrl(String channelUrl) {
        this.channelUrl = channelUrl == null ? null : channelUrl.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_goods_info.supplier_id
     *
     * @return the value of t_goods_info.supplier_id
     *
     * @mbggenerated
     */
    public Long getSupplierId() {
        return supplierId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_goods_info.supplier_id
     *
     * @param supplierId the value for t_goods_info.supplier_id
     *
     * @mbggenerated
     */
    public void setSupplierId(Long supplierId) {
        this.supplierId = supplierId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_goods_info.channel_id
     *
     * @return the value of t_goods_info.channel_id
     *
     * @mbggenerated
     */
    public Long getChannelId() {
        return channelId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_goods_info.channel_id
     *
     * @param channelId the value for t_goods_info.channel_id
     *
     * @mbggenerated
     */
    public void setChannelId(Long channelId) {
        this.channelId = channelId;
    }


    public String getGoodsDescribe() {
		return goodsDescribe;
	}

	public void setGoodsDescribe(String goodsDescribe) {
		this.goodsDescribe = goodsDescribe;
	}

	/**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_goods_info.photo_path
     *
     * @return the value of t_goods_info.photo_path
     *
     * @mbggenerated
     */
    public String getPhotoPath() {
        return photoPath;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_goods_info.photo_path
     *
     * @param photoPath the value for t_goods_info.photo_path
     *
     * @mbggenerated
     */
    public void setPhotoPath(String photoPath) {
        this.photoPath = photoPath == null ? null : photoPath.trim();
    }

  

	public int getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(int delFlag) {
		this.delFlag = delFlag;
	}

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public int getFlowStatus() {
		return flowStatus;
	}

	public void setFlowStatus(int flowStatus) {
		this.flowStatus = flowStatus;
	}

	
}