package com.jshuabo.templateadminmysql.server.service.myAgent.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.activiti.engine.task.Task;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jshuabo.frame.server.dao.security.IUserMapper;
import com.jshuabo.frame.server.model.security.User;
import com.jshuabo.frame.server.security.context.SecurityContextHolder;
import com.jshuabo.frame.server.util.json.JacksonUtils;
import com.jshuabo.templateadminmysql.server.model.supplierGoods.GoodInfo;
import com.jshuabo.templateadminmysql.server.service.deploy.IDeployService;
import com.jshuabo.templateadminmysql.server.service.myAgent.MyAgentService;

@Service("myAgentService")
public class MyAgentServiceImpl implements MyAgentService{
	private static final Logger logger = LoggerFactory.getLogger(MyAgentServiceImpl.class);

	/*@Autowired
	private MyOrderMapper myOrderMapper;*/
	
	@Autowired
	private IDeployService deployService;
	
	@Autowired
	private IUserMapper userMapper;

	@Override
	public String page(Map<String, Object> params) {
		
		User user=SecurityContextHolder.getCurrentUser();
		// 1:查询Task
		List<Task> taskList = deployService.findMyPersonalTask(user.getCode());
		
		// 工单号 工单类型 申请人 申请时间  当前处理人 流程状态 
		List<Map<String, Object>> rows=new ArrayList<Map<String,Object>>();
	for (Task task : taskList) {
		Map<String, Object> map=new HashMap<String, Object>();
		// 工单信息
		GoodInfo goodInfo = deployService.findGoodInfoByTaskId(task.getId());
		map.put("id", goodInfo.getId());
		// 工单号
		map.put("order_no", goodInfo.getId());
		/*// 工单类型  
		map.put("order_type", getNamebyStatus(goodInfo.getOrderType()));*/
		/*// 申请人
		long userId = goodInfo.getUserId();*/
		/*String userCode = userMapper.load(userId).getCode();
		map.put("apply_user_id", userCode);*/
		// 申请时间
		map.put("apply_time", goodInfo.getAddTime());
		// 当前处理人
		String curUser = task.getAssignee();
		map.put("cur_user_id", curUser);
		// 流程状态 
		map.put("flow_status", getNamebyFlowStatus(goodInfo.getFlowStatus()));
		
		rows.add(map);
	}
				params.put("rows", rows);
				params.put("total", taskList.size());
				return JacksonUtils.object2json(params);
	}
	
	/**
	 * 获取工单类型
	 * 
	 * @param orderTypeInt
	 * @return
	 */
	private String getNamebyStatus(int orderTypeInt) {
		String orderType="";
		switch(orderTypeInt){
		case 0:
			orderType = "稿件制作";
			break;
		case 1:
			orderType = "媒介监测";
			break;
		case 2:
			orderType = "分公司个性化报备";
			break;
		}
		return orderType;
	}
	
	/**
	 * 获取流程状态
	 * 
	 * @param orderTypeInt
	 * @return
	 */
	private String getNamebyFlowStatus(int flowStatus) {
		String flowType = "";
		switch(flowStatus){
		case 0:
			flowType = "未提交";
			break;
		case 1:
			flowType = "审批中";
			break;
		case 2:
			flowType = "已驳回";
			break;
		case 3:
			flowType = "已结束";
			break;	
		}
		return flowType;
	}

	/*@Override
	public MyOrder loadById(Long id) {
		// TODO Auto-generated method stub
		return myOrderMapper.load(id);
	}

	@Override
	public String updateDelFlag(String ids, String delFlag) {
		String[] userIds = StringUtils.commaDelimitedListToStringArray(ids);
		List<String> idList = Arrays.asList(userIds);
		myOrderMapper.updateDelFlag(idList, delFlag);
		return CommonControllerAspect.RETURN_VOID;
	}*/

	public String updateStatus(String ids, String del_flag) {
		// TODO Auto-generated method stub
		return null;
	}

}
