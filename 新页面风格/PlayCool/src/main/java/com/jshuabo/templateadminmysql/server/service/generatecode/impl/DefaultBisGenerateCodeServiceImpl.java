/**
 * Copyright©2015 www.jshuabo.com. all rights reserved.
 * 
 * @Title: IBisGenerateCodeService.java
 * @Prject: fq_info
 * @Package: com.jshuabo.fqinfo.server.bis.service.generatecode
 * @author: shuang.zhou
 * @date: 2015年10月27日12:24:41
 * @Description: 单号生成
 */
package com.jshuabo.templateadminmysql.server.service.generatecode.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jshuabo.templateadminmysql.server.dao.generatecode.IBisGenerateCodeMapper;
import com.jshuabo.templateadminmysql.server.model.generatecode.GenerateCodeParams;
import com.jshuabo.templateadminmysql.server.service.generatecode.IBisGenerateCodeService;

/**
 * @ClassName: DefaultBisGenerateCodeServiceImpl
 * @Description: 产生编码、单据-实现类
 * @author: shuang.zhou
 * @date: 2015年9月24日16:23:39
 */
@Service("bisGenerateCodeService")
public class DefaultBisGenerateCodeServiceImpl implements
		IBisGenerateCodeService {

	@Autowired
	private IBisGenerateCodeMapper bisGenerateCodeMapper;

	/*
	 * 根据GenerateCodeParams 生成编码
	 */
	@Override
	public String generateCode(GenerateCodeParams generateCodeParams) {
		bisGenerateCodeMapper.generateCode(generateCodeParams);
		return generateCodeParams.getResultCode();
	}

	/*
	 * 根据GenerateCodeParams 生成序号,用于订单行的行号等
	 */
	@Override
	public String generateNo(GenerateCodeParams generateCodeParams) {
		bisGenerateCodeMapper.generateLineNo(generateCodeParams);
		return generateCodeParams.getResultCode();
	}

}
