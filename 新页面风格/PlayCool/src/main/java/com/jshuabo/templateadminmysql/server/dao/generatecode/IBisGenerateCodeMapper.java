/**
 * Copyright 2014-2015 www.jshuabo.com. all rights reserved.
 */
package com.jshuabo.templateadminmysql.server.dao.generatecode;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshuabo.templateadminmysql.server.model.generatecode.GenerateCodeParams;

/**
 * 
 * 
 * @author shuang.zhou
 * @since 2015年9月24日16:23:06
 */
public interface IBisGenerateCodeMapper {
	/**
	 * 获取编码
	 * 
	 * @param generateCodeParams
	 * @return void
	 * @author shuang.zhou
	 * @since 2015年9月24日16:26:37
	 */
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	void generateCode(GenerateCodeParams generateCodeParams);

	/**
	 * 获取行号
	 * 
	 * @param generateCodeParams
	 * @return void
	 * @author shuang.zhou
	 * @since 2015年9月24日16:26:46
	 */
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	void generateLineNo(GenerateCodeParams generateCodeParams);
}
