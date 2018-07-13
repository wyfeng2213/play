package com.jshuabo.templateadminmysql.server.service.deploy;

import java.io.File;
import java.io.InputStream;
import java.util.List;

import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.task.Task;
import org.springframework.transaction.annotation.Transactional;

import com.jshuabo.frame.server.service.IBaseService;
import com.jshuabo.templateadminmysql.server.model.supplierGoods.GoodInfo;
import com.jshuabo.templateadminmysql.server.web.deploy.WorkflowBean;
import com.jshuabo.templateadminmysql.server.web.deploy.WorkflowBeanStatic;



public interface IDeployService extends IBaseService{

	String saveNewDeploye(File file, String filename);

	List<Deployment> findDeploymentList();

	List<ProcessDefinition> findProcessDefinitionList();

	void saveStartProcess(WorkflowBeanStatic workflowBean);

	String findTaskFormKeyByTaskId(String taskId);

	List<String> findOutComeListByTaskId(String taskId);

	void saveSubmitTask(WorkflowBeanStatic workflowBean);

	List<Task> findMyPersonalTask();

	List<Task> findMyPersonalTask(String assignee);

	void completeMyPersonalTask(String taskId);

	void deleteProcessDefinition(String deploymentId);

	GoodInfo findGoodInfoByTaskId(String taskId);

}
