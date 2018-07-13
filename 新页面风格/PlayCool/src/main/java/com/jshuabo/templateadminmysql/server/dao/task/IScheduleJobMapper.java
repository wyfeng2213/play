package com.jshuabo.templateadminmysql.server.dao.task;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.transaction.annotation.Transactional;

import com.jshuabo.frame.server.dao.IBaseMapper;
import com.jshuabo.templateadminmysql.server.model.task.ScheduleJob;

public interface IScheduleJobMapper extends IBaseMapper<ScheduleJob>{
	
	/**
	 * 获取全部数据
	 *
	 * @author shuang.zhou
	 * @since 2017年7月9日14:28:54
	 */
	@Transactional
	List<ScheduleJob> getAllJob();
	/**
	 * 新增
	 *
	 * @author shuang.zhou
	 * @since 2017年7月9日14:28:54
	 */
	@Transactional
	void addJob(ScheduleJob scheduleJob);
	
	/**
	 * 根据id查询
	 *
	 * @author shuang.zhou
	 * @since 2017年7月9日14:28:54
	 */
	@Transactional
	ScheduleJob loadById(Long id);
	
	/**
	 * 更新
	 *
	 * @author shuang.zhou
	 * @since 2017年7月9日14:28:54
	 */
	@Transactional
	void updateJob(ScheduleJob scheduleJob);
	
	/**
	 * 更新状态
	 *
	 * @author shuang.zhou
	 * @since 2017年7月9日14:28:54
	 */
	@Transactional
	void updateStatus(@Param("idList") List<String> idList,
			@Param("status") String status);
	
}
