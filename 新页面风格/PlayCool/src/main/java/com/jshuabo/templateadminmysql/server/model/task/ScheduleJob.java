package com.jshuabo.templateadminmysql.server.model.task;

import com.jshuabo.frame.server.model.base.REntity;

/**
 * 定时任务实体类
 *
 *
 * @author shuang.zhou
 * @since 2016年4月5日 下午2:42:50
 */
public class ScheduleJob extends REntity{
	
	private static final long serialVersionUID = 2816602940273329927L;
	/** 任务名称*/
	private String jobName;
	/** 任务分组*/
	private String jobGroup;
	/** 任务状态 是否启动任务*/
	private String jobStatus;
	/** cron表达式，设定时间*/
	private String cronExpression;
	/** 描述*/
	private String description;
	/** 任务执行类*/
	private String beanClass;
	
	public String getJobName() {
		return jobName;
	}
	public void setJobName(String jobName) {
		this.jobName = jobName;
	}
	public String getJobGroup() {
		return jobGroup;
	}
	public void setJobGroup(String jobGroup) {
		this.jobGroup = jobGroup;
	}
	public String getJobStatus() {
		return jobStatus;
	}
	public void setJobStatus(String jobStatus) {
		this.jobStatus = jobStatus;
	}
	public String getCronExpression() {
		return cronExpression;
	}
	public void setCronExpression(String cronExpression) {
		this.cronExpression = cronExpression;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getBeanClass() {
		return beanClass;
	}
	public void setBeanClass(String beanClass) {
		this.beanClass = beanClass;
	}
	

	

	
}
