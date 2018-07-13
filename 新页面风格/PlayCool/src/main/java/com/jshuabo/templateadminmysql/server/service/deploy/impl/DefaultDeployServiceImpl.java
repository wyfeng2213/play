package com.jshuabo.templateadminmysql.server.service.deploy.impl;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipInputStream;
import org.springframework.stereotype.Service;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.bpmn.model.FlowNode;
import org.activiti.bpmn.model.SequenceFlow;
import org.activiti.engine.FormService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.form.TaskFormData;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;


import com.jshuabo.frame.server.model.security.User;
import com.jshuabo.frame.server.security.context.SecurityContextHolder;
import com.jshuabo.frame.server.util.json.JacksonUtils;
import com.jshuabo.templateadminmysql.server.model.supplierGoods.GoodInfo;
import com.jshuabo.templateadminmysql.server.service.deploy.IDeployService;
import com.jshuabo.templateadminmysql.server.service.supplierGoods.ISupplierGoodsService;
import com.jshuabo.templateadminmysql.server.web.deploy.WorkflowBeanStatic;

@Service("deployService")
public class DefaultDeployServiceImpl implements IDeployService {

	@Autowired
	private RepositoryService repositoryService;

	@Autowired
	private RuntimeService runtimeService;
	
	@Autowired
	private FormService formService;
	
	@Autowired
	private TaskService taskService;
	
	@Autowired
	private ISupplierGoodsService goodsInfoService;
	
	/**部署流程定义*/
	@Override
	public String saveNewDeploye(File file, String filename) {
		String developmentId = "";
		try {
			//2：将File类型的文件转化成ZipInputStream流
			ZipInputStream zipInputStream = new ZipInputStream(new FileInputStream(file));
			developmentId = repositoryService.createDeployment()//创建部署对象
							.name(filename)//添加部署名称
							.addZipInputStream(zipInputStream)//
							.deploy()//完成部署
							.getId();//返回部署id
		} catch (Exception e) {
			e.printStackTrace();
		}
		return developmentId;
	}

	/**
	 * 部署列表展示
	 * 
	 */
	@Override
	public String page(Map<String, Object> params) {
		// 1:查询部署对象信息，对应表（act_re_deployment）
				List<Deployment> depList = findDeploymentList();
				// 放置到上下文对象中
				List<Map<String, Object>> rows=new ArrayList<Map<String,Object>>();
			for (Deployment deployment : depList) {
				String pname = repositoryService.createProcessDefinitionQuery()
						.deploymentId(deployment.getId()).singleResult().getName();
				Map<String, Object> map=new HashMap<String, Object>();
				map.put("id", deployment.getId());
				map.put("name", pname);
				map.put("deployTime", deployment.getDeploymentTime());
				rows.add(map);
			}
				params.put("rows", rows);
				params.put("total", depList.size());
				return JacksonUtils.object2json(params);
	}


	/**查询部署对象信息，对应表（act_re_deployment）*/
	@Override
	public List<Deployment> findDeploymentList() {
		List<Deployment> list = repositoryService.createDeploymentQuery()//创建部署对象查询
							.orderByDeploymenTime().asc()
							.list();
		
		
		return list;
	}

	/**更新工单状态，启动流程实例，让启动的流程实例关联业务*/
	@Override
	public void saveStartProcess(WorkflowBeanStatic workflowBean) {
		//1：获取工单ID，使用工单ID，查询工单的对象ManuscriptProduction
		Long id = Long.valueOf(WorkflowBeanStatic.taskId);
		GoodInfo goodInfo = goodsInfoService.loadById(id);
		//2：更新工单的请假状态从0变成1（初始录入-->审核中）
		// 状态并没有更新到数据库？
		goodInfo.setFlowStatus(1);
		//3：使用当前对象获取到流程定义的key（对象的名称就是流程定义的key）
		String key = goodInfo.getClass().getSimpleName();
		/**
		 * 4：获取当前任务的办理人，使用流程变量设置下一个任务的办理人
			    * inputUser是流程变量的名称，
			    * 获取的办理人是流程变量的值
		 */
		User user = SecurityContextHolder.getCurrentUser();
		Map<String, Object> variables = new HashMap<String,Object>();
		variables.put("userId", user.getId());//表示惟一用户,对应的是下一办理人吗？
		/**
		 * 5：	(1)使用流程变量设置字符串（格式：LeaveBill.id的形式），通过设置，让启动的流程（流程实例）关联业务
   				(2)使用正在执行对象表中的一个字段BUSINESS_KEY（Activiti提供的一个字段），让启动的流程（流程实例）关联业务
		 */
		//格式：LeaveBill.id的形式（使用流程变量）
		String objId = key+"."+id;
		variables.put("objId", objId);
		//6：使用流程定义的key，启动流程实例，同时设置流程变量，同时向正在执行的执行对象表中的字段BUSINESS_KEY添加业务数据，同时让流程关联业务
		runtimeService.startProcessInstanceByKey(key,objId,variables);
		
	}
	
	
	
	/**查询当前人的个人任务*/
	@Override
	public List<Task> findMyPersonalTask(String assignee){
		/*String assignee = "王五";*/
		List<Task> list = taskService.createTaskQuery()//与正在执行的任务管理相关的Service//创建任务查询对象
						.taskAssignee(assignee)//指定个人任务查询，指定办理人
						.list();
		/*if(list!=null && list.size()>0){
			for(Task task:list){
				System.out.println("任务ID:"+task.getId());
				System.out.println("任务名称:"+task.getName());
				System.out.println("任务的创建时间:"+task.getCreateTime());
				System.out.println("任务的办理人:"+task.getAssignee());
				System.out.println("流程实例ID："+task.getProcessInstanceId());
				System.out.println("执行对象ID:"+task.getExecutionId());
				System.out.println("流程定义ID:"+task.getProcessDefinitionId());
				System.out.println("########################################################");
			}
		}*/
		
		return list;
	}
	
	/**完成我的任务*/
	@Override
	public void completeMyPersonalTask(String taskId){
		//任务ID
		/*String taskId = "302";*/
		taskService.complete(taskId);
					
		System.out.println("完成任务：任务ID："+taskId);
	}
	
	/**删除流程定义*/
	@Override
	public void deleteProcessDefinition(String deploymentId){
		//使用部署ID，完成删除
		/*String deploymentId = "601";*/
		
		/**
		 * 级联删除
		 * 	  不管流程是否启动，都能可以删除
		 */
		repositoryService.deleteDeployment(deploymentId, true);
		System.out.println("删除成功！");
	}
	
	@Override
	public List<ProcessDefinition> findProcessDefinitionList() {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**使用任务ID，获取当前任务节点中对应的Form key中的连接的值*/
	@Override
	public String findTaskFormKeyByTaskId(String taskId) {
		TaskFormData formData = formService.getTaskFormData(taskId);
		//获取Form key的值
		String url = formData.getFormKey();
		return url;
	}
	
	/**一：使用任务ID，查找请假单ID，从而获取请假单信息*/
	@Override
	public GoodInfo findGoodInfoByTaskId(String taskId) {
		//1：使用任务ID，查询任务对象Task
		Task task = taskService.createTaskQuery()//
						.taskId(taskId)//使用任务ID查询
						.singleResult();
		//2：使用任务对象Task获取流程实例ID
		String processInstanceId = task.getProcessInstanceId();
		//3：使用流程实例ID，查询正在执行的执行对象表，返回流程实例对象
		ProcessInstance pi = runtimeService.createProcessInstanceQuery()//
						.processInstanceId(processInstanceId)//使用流程实例ID查询
						.singleResult();
		//4：使用流程实例对象获取BUSINESS_KEY
		String buniness_key = pi.getBusinessKey();
		//5：获取BUSINESS_KEY对应的主键ID，使用主键ID，查询请假单对象（LeaveBill.1）
		String id = "";
		if(StringUtils.isNotBlank(buniness_key)){
			//截取字符串，取buniness_key小数点的第2个值
			id = buniness_key.split("\\.")[1];
		}
		//查询请假单对象
		//使用hql语句：from manuscriptProduction o where o.id=1
		GoodInfo goodInfo = goodsInfoService.loadById(Long.parseLong(id));
		return goodInfo;
	}
	
	/**二：已知任务ID，查询ProcessDefinitionEntiy对象，从而获取当前任务完成之后的连线名称，并放置到List<String>集合中*/
	@Override
	public List<String> findOutComeListByTaskId(String taskId) {
		//返回存放连线的名称集合
		List<String> list = new ArrayList<String>();
		//1:使用任务ID，查询任务对象
		Task task = taskService.createTaskQuery()//
					.taskId(taskId)//使用任务ID查询
					.singleResult();
		//2：获取流程定义ID
		String processDefinitionId = task.getProcessDefinitionId();
		//3：查询ProcessDefinitionEntiy对象
		ProcessDefinitionEntity processDefinitionEntity = (ProcessDefinitionEntity) repositoryService.getProcessDefinition(processDefinitionId);
		//使用任务对象Task获取流程实例ID
		String processInstanceId = task.getProcessInstanceId();
		//使用流程实例ID，查询正在执行的执行对象表，返回流程实例对象
		ProcessInstance pi = runtimeService.createProcessInstanceQuery()//
					.processInstanceId(processInstanceId)//使用流程实例ID查询
					.singleResult();
		//获取当前活动的id
		String activityId = pi.getActivityId();
		//4：获取当前的活动
		 BpmnModel bpmnModel = repositoryService.getBpmnModel(activityId);
		FlowNode activityImpl = (FlowNode) bpmnModel.getMainProcess().getFlowElement(activityId);
		/*ActivityImpl activityImpl = processDefinitionEntity.findActivity(activityId);*/
		//5：获取当前活动完成之后连线的名称
		List<SequenceFlow> pvmList = activityImpl.getOutgoingFlows() ; // 取出节点的所有出去的线
		/*List<PvmTransition> pvmList = activityImpl.getOutgoingTransitions();*/
		if(pvmList!=null && pvmList.size()>0){
			for(SequenceFlow pvm:pvmList){
				String name = (String) pvm.getName();
				if(StringUtils.isNotBlank(name)){
					list.add(name);
				}
				else{
					list.add("默认提交");
				}
			}
		}
		return list;
	}
	
	/**指定连线的名称完成任务*/
	@Override
	public void saveSubmitTask(WorkflowBeanStatic workflowBean) {
		//获取任务ID
		String taskId = WorkflowBeanStatic.getTaskId();
		//获取连线的名称
		String outcome = WorkflowBeanStatic.getOutcome();
		//批注信息
		String message = WorkflowBeanStatic.getComment();
		//获取请假单ID
		Long id = WorkflowBeanStatic.getId();
		
		/**
		 * 1：在完成之前，添加一个批注信息，向act_hi_comment表中添加数据，用于记录对当前申请人的一些审核信息
		 */
		//使用任务ID，查询任务对象，获取流程流程实例ID
		Task task = taskService.createTaskQuery()//
						.taskId(taskId)//使用任务ID查询
						.singleResult();
		//获取流程实例ID
		String processInstanceId = task.getProcessInstanceId();
		/**
		 * 注意：添加批注的时候，由于Activiti底层代码是使用：
		 * 		String userId = Authentication.getAuthenticatedUserId();
			    CommentEntity comment = new CommentEntity();
			    comment.setUserId(userId);
			  所有需要从Session中获取当前登录人，作为该任务的办理人（审核人），对应act_hi_comment表中的User_ID的字段，不过不添加审核人，该字段为null
			 所以要求，添加配置执行使用Authentication.setAuthenticatedUserId();添加当前任务的审核人
		 * */
		User user=SecurityContextHolder.getCurrentUser();
		Authentication.setAuthenticatedUserId(user.getId().toString());
		taskService.addComment(taskId, processInstanceId, message);
		/**
		 * 2：如果连线的名称是“默认提交”，那么就不需要设置，如果不是，就需要设置流程变量
		 * 在完成任务之前，设置流程变量，按照连线的名称，去完成任务
				 流程变量的名称：outcome
				 流程变量的值：连线的名称
		 */
		Map<String, Object> variables = new HashMap<String,Object>();
		if(outcome!=null && !outcome.equals("默认提交")){
			variables.put("outcome", outcome);
		}

		//3：使用任务ID，完成当前人的个人任务，同时流程变量
		taskService.complete(taskId, variables);
		//4：当任务完成之后，需要指定下一个任务的办理人（使用类）-----已经开发完成
		
		/**
		 * 5：在完成任务之后，判断流程是否结束
   			如果流程结束了，更新请假单表的状态从1变成2（审核中-->审核完成）
		 */
		ProcessInstance pi = runtimeService.createProcessInstanceQuery()//
						.processInstanceId(processInstanceId)//使用流程实例ID查询
						.singleResult();
		//流程结束了
		if(pi==null){
			//更新请假单表的状态从1变成2（审核中-->审核完成）
			GoodInfo goodInfo = goodsInfoService.loadById(id);
			goodInfo.setFlowStatus(2);
		}
	}

	@Override
	public List<Task> findMyPersonalTask() {
		// TODO Auto-generated method stub
		return null;
	}

	

	

}
