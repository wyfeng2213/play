package com.jshuabo.templateadminmysql.server.quartz.syslog;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.jshuabo.frame.server.dao.exceptionLog.IExceptionLogMapper;

/**
 * 定时删除错误日志 删除条件->当前时间-产生时间>=15日
 * 
 * @author shuang.zhou
 * @since 2015年12月24日10:20:57
 */
public class SysLogQuartz {
	Logger logger = LoggerFactory.getLogger(SysLogQuartz.class);
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	@Autowired
	private IExceptionLogMapper exceptionLogMapper;

	public void deleteLog() {
		try {
			logger.info("删除开始" + format.format(new Date()));
			try {
				Integer count = exceptionLogMapper.deleteByTime();
				if (count > 0) {
					logger.info("共删除错误日志记录数为:" + count + "时间:"
							+ format.format(new Date()));
				} else {
					logger.info("根据当前时间:" + format.format(new Date())
							+ ",前俩周系统使用情况良好，为产生异常情况!");
				}
			} catch (Exception e) {
				logger.info("删除发生异常:" + format.format(new Date()) + "异常信息:"
						+ e.getMessage());
			}
			logger.info("删除结束" + format.format(new Date()));
		} catch (Exception ex) {
			logger.error("process firstRechargeReturn job error: {}",
					ex.getLocalizedMessage());
		}
	}

}
