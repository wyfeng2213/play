package com.jshuabo.templateadminmysql.server.service.task;

import java.util.List;

import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.Job;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SchedulerFactory;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerKey;
import org.quartz.impl.StdSchedulerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.jshuabo.templateadminmysql.server.dao.task.IScheduleJobMapper;
import com.jshuabo.templateadminmysql.server.model.task.ScheduleJob;


public class LoadTask {
	
	private static SchedulerFactory schedulerFactoryBean = new StdSchedulerFactory();
	@Autowired
	private IScheduleJobMapper scheduleJobMapper;
	/**
	 * 加载定时任务
	 *
	 * @param 
	 * @return 
	 * @author shuang.zhou
	 * @since 2017年7月9日14:31:30
	 */
	@SuppressWarnings("unchecked")
	public void initTask() throws Exception {
		Scheduler scheduler = schedulerFactoryBean.getScheduler();
		  // 可执行的任务列表
		  List<ScheduleJob> jobList = scheduleJobMapper.getAllJob();
		  for (ScheduleJob job : jobList) {

		   TriggerKey triggerKey = TriggerKey.triggerKey(job.getJobName(), job.getJobGroup());
		   //获取trigger，即在spring配置文件中定义的 bean id="myTrigger"
		   CronTrigger trigger = (CronTrigger) scheduler.getTrigger(triggerKey);
		   // 不存在，创建一个
		   if (null == trigger) {
		    JobDetail jobDetail = JobBuilder.newJob((Class<? extends Job>)Class.forName(job.getBeanClass()))
		    		.withIdentity(job.getJobName(),job.getJobGroup()).build();
		    jobDetail.getJobDataMap().put("scheduleJob", job);
		    // 表达式调度构建器
		    CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(job.getCronExpression()).withMisfireHandlingInstructionDoNothing();

		    // 按新的表达式构建一个新的trigger
		    trigger = TriggerBuilder.newTrigger().withIdentity(job.getJobName(),
		        job.getJobGroup()).withSchedule(scheduleBuilder).build();
		    scheduler.scheduleJob(jobDetail, trigger);
		    if (!scheduler.isShutdown()) {  
		    	scheduler.start();  
            }  
		   } else {
		    // trigger已存在，则更新相应的定时设置
			   CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(job.getCronExpression()).withMisfireHandlingInstructionDoNothing();

		    // 按新的cronExpression表达式重新构建trigger
		    trigger = trigger.getTriggerBuilder().withIdentity(triggerKey)
		      .withSchedule(scheduleBuilder).build();
		    // 按新的trigger重新设置job执行
		    scheduler.rescheduleJob(triggerKey, trigger);
		    if (!scheduler.isShutdown()) {  
		    	scheduler.start();  
            }  
		   }
		   
		  }
	}
	
	/**
	 * 暂停任务
	 *
	 * @param 
	 * @return 
	 * @author shuang.zhou
	 * @since 2017年7月9日14:31:30
	 */
	public void stopScheduleJob(ScheduleJob scheduleJob){
		Scheduler scheduler;
		try {
			scheduler = schedulerFactoryBean.getScheduler();
			JobKey jobKey = JobKey.jobKey(scheduleJob.getJobName(), scheduleJob.getJobGroup());
			scheduler.pauseJob(jobKey);
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
		
		
	}
	/**
	 * 恢复任务
	 *
	 * @param 
	 * @return 
	 * @author shuang.zhou
	 * @since 2017年7月9日14:31:30
	 */
	public void recoveryScheduleJob(ScheduleJob scheduleJob){
		Scheduler scheduler;
		try {
			scheduler = schedulerFactoryBean.getScheduler();
			TriggerKey triggerKey = TriggerKey.triggerKey(scheduleJob.getJobName(),
					scheduleJob.getJobGroup());
					  
			//获取trigger，即在spring配置文件中定义的 bean id="myTrigger"
			CronTrigger trigger = (CronTrigger) scheduler.getTrigger(triggerKey);
			//trigger不存在，需要新增
			if(trigger == null){
				addScheduleJob(scheduleJob);
			}else{
				JobKey jobKey = JobKey.jobKey(scheduleJob.getJobName(), scheduleJob.getJobGroup());
				scheduler.resumeJob(jobKey);
			}
			
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 新增任务
	 *
	 *
	 * @param 
	 * @return 
	 * @author shuang.zhou
	 * @since 2017年7月9日14:31:30
	 */
	@SuppressWarnings("unchecked")
	public void addScheduleJob(ScheduleJob scheduleJob){
		Scheduler scheduler = null;
		try {
			scheduler = schedulerFactoryBean.getScheduler();
		} catch (SchedulerException e1) {
			e1.printStackTrace();
		}
		try {  
            JobDetail jobDetail = JobBuilder.newJob((Class<? extends Job>)Class.forName(scheduleJob.getBeanClass()))
            		.withIdentity(scheduleJob.getJobName(),scheduleJob.getJobGroup()).build();
            // 触发器  
            jobDetail.getJobDataMap().put("scheduleJob", scheduleJob);
		    // 表达式调度构建器
            CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(scheduleJob.getCronExpression()).withMisfireHandlingInstructionDoNothing();
		    // 按新的表达式构建一个新的trigger
		    CronTrigger trigger = TriggerBuilder.newTrigger().withIdentity(scheduleJob.getJobName(),
		    		scheduleJob.getJobGroup()).withSchedule(scheduleBuilder).build();
		    scheduler.scheduleJob(jobDetail, trigger);
		    if (!scheduler.isShutdown()) {  
		    	scheduler.start();  
            }  
        } catch (Exception e) {  
            throw new RuntimeException(e);  
        }  
	}
	
	/**
	 * 删除任务
	 *
	 * @param 
	 * @return 
	 * @author shuang.zhou
	 * @since 2017年7月9日14:31:30
	 */
	public void removeScheduleJob(ScheduleJob scheduleJob){
		Scheduler scheduler;
		try {
			scheduler = schedulerFactoryBean.getScheduler();
			JobKey jobKey = JobKey.jobKey(scheduleJob.getJobName(), scheduleJob.getJobGroup());
			scheduler.deleteJob(jobKey);
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
		
	}
	/**
	 * 更新任务执行时间
	 *
	 *
	 * @param 
	 * @return 
	 * @author shuang.zhou
	 * @since 2017年7月9日14:31:30
	 */
	public void updateScheduleJob(ScheduleJob scheduleJob){
		Scheduler scheduler;
		try {
			scheduler = schedulerFactoryBean.getScheduler();
			TriggerKey triggerKey = TriggerKey.triggerKey(scheduleJob.getJobName(),
					scheduleJob.getJobGroup());
					  
			//获取trigger，即在spring配置文件中定义的 bean id="myTrigger"
			CronTrigger trigger = (CronTrigger) scheduler.getTrigger(triggerKey);
					  
			//表达式调度构建器
			CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(scheduleJob.getCronExpression()).withMisfireHandlingInstructionDoNothing();

					  
			//按新的cronExpression表达式重新构建trigger
			trigger = trigger.getTriggerBuilder().withIdentity(triggerKey)
					.withSchedule(scheduleBuilder).build();
					  
			//按新的trigger重新设置job执行
			scheduler.rescheduleJob(triggerKey, trigger);
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
		  
		
	}
	
	
	public static void main(String[] args){
		ScheduleJob job = new ScheduleJob();
		job.setJobName("动态任务调度");
		job.setJobGroup("EXTJWEB_JOBGROUP_NAME");
		job.setCronExpression("0/1 * * * * ?");
		LoadTask task = new LoadTask();
		task.stopScheduleJob(job);
		
	
	}

}
