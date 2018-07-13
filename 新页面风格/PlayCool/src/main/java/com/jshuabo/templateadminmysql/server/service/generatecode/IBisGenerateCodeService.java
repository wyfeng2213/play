/**
 * Copyright©2015 www.jshuabo.com. all rights reserved.
 * 
 * @Title: IBisGenerateCodeService.java
 * @Prject: fq_info
 * @Package: com.jshuabo.fqinfo.server.bis.service.generatecode
 * @author: shuang.zhou
 * @date: 2015年10月27日12:24:13
 * @Description: 单号生成
 */
package com.jshuabo.templateadminmysql.server.service.generatecode;

import org.springframework.transaction.annotation.Transactional;

import com.jshuabo.templateadminmysql.server.model.generatecode.GenerateCodeParams;

/**
 * @ClassName: IBisGenerateCodeService
 * @Description: 产生编码、单据-业务接口
 * @author: shuang.zhou
 * @date: 2015年9月24日16:22:57
 */
public interface IBisGenerateCodeService {

	/**
	 * @Title: generateCode
	 * @Description: 根据GenerateCodeParams 生成编码
	 * @return: String
	 * @author: shuang.zhou
	 * @date: 2015年9月24日16:27:08
	 */
	@Transactional
	String generateCode(GenerateCodeParams generateCodeParams);

	/**
	 * @Title: generateNo
	 * @Description: 根据GenerateCodeParams 生成序号,用于订单行的行号等
	 * @return: String
	 * @author: shuang.zhou
	 * @date: 2015年9月24日16:27:04
	 */
	@Transactional
	String generateNo(GenerateCodeParams generateCodeParams);

}
