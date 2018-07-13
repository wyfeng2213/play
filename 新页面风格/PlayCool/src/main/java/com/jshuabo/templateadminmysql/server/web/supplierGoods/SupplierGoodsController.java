package com.jshuabo.templateadminmysql.server.web.supplierGoods;

import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.jshuabo.frame.server.aop.web.controller.CommonControllerAspect;
import com.jshuabo.frame.server.model.security.User;
import com.jshuabo.frame.server.security.context.SecurityContextHolder;
import com.jshuabo.templateadminmysql.server.model.supplierGoods.GoodInfo;
import com.jshuabo.templateadminmysql.server.service.deploy.IDeployService;
import com.jshuabo.templateadminmysql.server.service.supplierGoods.ISupplierGoodsService;
import com.jshuabo.templateadminmysql.server.web.deploy.WorkflowBeanStatic;


@Controller
@RequestMapping(value = "supplierGoods")
public class SupplierGoodsController {
	@Autowired
	private ISupplierGoodsService goodsInfoService;
	
	@Autowired
	private IDeployService deployService; 
	
	private  WorkflowBeanStatic workflowBean = new WorkflowBeanStatic();
	
	// 提交、保存 标示
		private boolean isSubmit = false;

	/**
	 * 商品审批列表
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "list")
	public String list(HttpServletRequest request) {
		return "supplierGoods/list";
	}
    
    /**
	 * 提交
	 * 
	 * @param request
	 * @param response
	 * @param remark
	 * @param mfile
	 * @return
	 */
	@RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
	public String add(GoodInfo goodInfo) {
		isSubmit = true;
		Long orderNo = (long) 0;
		User user = SecurityContextHolder.getCurrentUser();
		// 1.保存表单数据到业务表,返回id。设置工单号=id
		goodInfo.setDelFlag(0);
			orderNo = goodsInfoService.addGoodInfo(goodInfo);
		WorkflowBeanStatic.setTaskId(orderNo.toString());
		// 2.启动工作流实例
		deployService.saveStartProcess(workflowBean);
		// 3.查询我的任务（我的待办）
		List<Task> list = deployService.findMyPersonalTask(user.getCode());
		if(list!=null && list.size()>0){	
		// 4.完成我的任务
		deployService.completeMyPersonalTask(list.get(list.size()-1).getId());	
		// 5.更新业务表的工作流状态
		goodInfo.setFlowStatus(1);
		goodsInfoService.updateByPrimaryKeySelective(goodInfo);
	}
		return CommonControllerAspect.RETURN_VOID;
	}
    
  
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public ModelAndView addBasicInfo(HttpServletRequest request) {
        return new ModelAndView("supplierGoods/add");
    }
	
}
