package com.jshuabo.templateadminmysql.server.dao.manager;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.jshuabo.frame.server.dao.IBaseMapper;
import com.jshuabo.templateadminmysql.server.model.manager.Manager;


@Repository
public interface ManagerMapper extends IBaseMapper<Manager> {
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
    int insert(Manager record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_goods_info
     *
     * @mbggenerated
     */
    int insertSelective(Manager record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_goods_info
     *
     * @mbggenerated
     */
    Manager selectByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_goods_info
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(Manager record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_goods_info
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(Manager record);
    
    /*传参*/
    String findGoodsparam(Map<String, Integer> params);
    
    /*查看*/
	@Transactional
	List<Manager> loadByParams(Map<String, Object>params);
	
	List<Manager> loadByName(Map<String, Object> params);

	void addGoods(Manager manager);

	List<Manager> findAllManager();


}
