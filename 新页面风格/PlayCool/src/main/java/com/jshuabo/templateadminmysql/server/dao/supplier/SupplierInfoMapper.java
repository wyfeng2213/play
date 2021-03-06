package com.jshuabo.templateadminmysql.server.dao.supplier;

import java.util.List;

import com.jshuabo.frame.server.dao.IBaseMapper;
import com.jshuabo.templateadminmysql.server.model.supplier.SupplierInfo;

public interface SupplierInfoMapper extends IBaseMapper<SupplierInfo> {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_supplier_info
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_supplier_info
     *
     * @mbggenerated
     */
    int insert(SupplierInfo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_supplier_info
     *
     * @mbggenerated
     */
    int insertSelective(SupplierInfo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_supplier_info
     *
     * @mbggenerated
     */
    SupplierInfo selectByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_supplier_info
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(SupplierInfo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_supplier_info
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(SupplierInfo record);

	List<SupplierInfo> selectAllSupplier();
}