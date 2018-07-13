package com.jshuabo.templateadminmysql.server.dao.supplierGoods;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.jshuabo.frame.server.dao.IBaseMapper;
import com.jshuabo.templateadminmysql.server.model.supplierGoods.GoodInfo;

@Repository
public interface GoodInfoMapper extends IBaseMapper<GoodInfo> {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_goods_info
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_goods_info
     *
     * @mbggenerated
     */
    int insert(GoodInfo record);
    
    Long insertReturnId(GoodInfo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_goods_info
     *
     * @mbggenerated
     */
    int insertSelective(GoodInfo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_goods_info
     *
     * @mbggenerated
     */
    GoodInfo selectByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_goods_info
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(GoodInfo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_goods_info
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(GoodInfo record);
    
    /*传参*/
    String findGoodsparam(Map<String, Integer> params);
    
    /*查看*/
	@Transactional
	List<GoodInfo> loadByParams(Map<String, Object>params);
	
	List<GoodInfo> loadByName(Map<String, Object> params);

	void addGoods(GoodInfo goodInfo);

	List<GoodInfo> findSupplierGoods(Map<String, Long> params);
}