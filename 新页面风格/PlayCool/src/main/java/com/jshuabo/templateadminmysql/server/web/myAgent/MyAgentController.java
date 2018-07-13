package com.jshuabo.templateadminmysql.server.web.myAgent;

import java.util.List;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jshuabo.frame.server.aop.web.controller.CommonControllerAspect;
import com.jshuabo.frame.server.model.security.User;
import com.jshuabo.frame.server.security.context.SecurityContextHolder;
import com.jshuabo.templateadminmysql.server.dao.supplierGoods.GoodInfoMapper;
import com.jshuabo.templateadminmysql.server.model.supplierGoods.GoodInfo;
import com.jshuabo.templateadminmysql.server.service.deploy.IDeployService;
import com.jshuabo.templateadminmysql.server.service.supplierGoods.ISupplierGoodsService;

@Controller
@RequestMapping(value = "myAgent")
public class MyAgentController {
	
	@Autowired
	private IDeployService deployService;
	
	@Autowired
	private RuntimeService runtimeService;
	
	@Autowired
	private GoodInfoMapper goodInfoMapper;
	
	@Autowired
	private ISupplierGoodsService goodsInfoService;
	

	/**
	 * 列表取得
	 * 
	 * @return
	 */
	@RequestMapping(value = "list")
	public String list() {
		return "myAgent/list";
	}	
	
	 
	 /**
	  * 审核跳转
	  * 
	  * @param id
	  * @return
	  */
	 @RequestMapping(value = "/approval/{id}", method = RequestMethod.GET)
	    public ModelAndView approval(@PathVariable("id") String id) {
		 GoodInfo goodInfo = new GoodInfo();
		 /*goodInfo = goodInfoMapper.selectByPrimaryKey(Long.valueOf(id));*/
		 goodInfo = goodsInfoService.loadById(Long.valueOf(id));
	        return  new ModelAndView("myAgent/edit","goodInfo",goodInfo);
	        
	    } 
	 
	 /**
	  * 审核--同意、不同意
	  * 
	  * @param ids
	  * @param flowStatus
	  * @return
	  */
	@RequestMapping(value = "/updateFlowStatus", method = RequestMethod.POST)
    @ResponseBody
    public String updateFlowStatus(@RequestParam String ids, @RequestParam String flowStatus) {
    	// 完成我的任务
    	User user = SecurityContextHolder.getCurrentUser();
    	List<Task> list = deployService.findMyPersonalTask(user.getCode());
    	for(Task task:list){
    		// 完成对应的任务
    		GoodInfo goodInfo = deployService.findGoodInfoByTaskId(task.getId());
    		if(Long.valueOf(ids) == goodInfo.getId()){
    			deployService.completeMyPersonalTask(task.getId());
    			
    			/**
    			 * 在完成任务之后，判断流程是否结束
    	   			如果流程结束了，更新流程状态从1变成2（审核中-->已结束）
    			 */
    			//获取流程实例ID
    			String processInstanceId = task.getProcessInstanceId();
    			ProcessInstance pi = runtimeService.createProcessInstanceQuery()//
    							.processInstanceId(processInstanceId)//使用流程实例ID查询
    							.singleResult();
    			//流程结束了
    			if(pi==null){
    				goodInfo.setFlowStatus(2);
    				/*goodInfoMapper.updateByPrimaryKeySelective(goodInfo);*/
    				goodsInfoService.updateByPrimaryKeySelective(goodInfo);
    			}
    		}
    	}
         return CommonControllerAspect.RETURN_VOID;
    }
	
}

