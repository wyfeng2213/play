package com.jshuabo.templateadminmysql.server.web.deploy;

import java.io.File;

public class WorkflowBeanStatic {

	public static File file;		//流程定义部署文件
	public static String filename;//流程定义名称
	
	public static Long id;//申请单ID
	
	public static String deploymentId;//部署对象ID
	public static String imageName;	//资源文件名称
	public static String taskId;		//任务ID
	public static String outcome;		//连线名称
	public static String comment;		//备注
	
	public static File getFile() {
		return file;
	}
	public static void setFile(File file) {
		WorkflowBeanStatic.file = file;
	}
	public static String getFilename() {
		return filename;
	}
	public static void setFilename(String filename) {
		WorkflowBeanStatic.filename = filename;
	}
	public static Long getId() {
		return id;
	}
	public static void setId(Long id) {
		WorkflowBeanStatic.id = id;
	}
	public static String getDeploymentId() {
		return deploymentId;
	}
	public static void setDeploymentId(String deploymentId) {
		WorkflowBeanStatic.deploymentId = deploymentId;
	}
	public static String getImageName() {
		return imageName;
	}
	public static void setImageName(String imageName) {
		WorkflowBeanStatic.imageName = imageName;
	}
	public static String getTaskId() {
		return taskId;
	}
	public static void setTaskId(String taskId) {
		WorkflowBeanStatic.taskId = taskId;
	}
	public static String getOutcome() {
		return outcome;
	}
	public static void setOutcome(String outcome) {
		WorkflowBeanStatic.outcome = outcome;
	}
	public static String getComment() {
		return comment;
	}
	public static void setComment(String comment) {
		WorkflowBeanStatic.comment = comment;
	}
	
}
