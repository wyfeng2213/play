package com.jshuabo.templateadminmysql.server.web.deploy;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.RepositoryService;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.jshuabo.templateadminmysql.server.service.deploy.IDeployService;



@Controller
@RequestMapping(value = "deployAndStart")
public class deployController {

	@Autowired
	private IDeployService deployService;
	
	private static WorkflowBeanStatic workflowBean = new WorkflowBeanStatic();

	/**
	 * 部署管理首页显示
	 * 
	 * @return
	 */
	@RequestMapping(value = "list")
	public String deployHome(HttpServletRequest request) {
		return "deploy/list";
	}
	
	/**
	 * @Title: add
	 * @Description: 增加
	 */
	@RequestMapping(value = "/upFile", method=RequestMethod.POST)
	@ResponseBody
	public void add(HttpServletRequest request,HttpServletResponse response,
            @RequestParam("filename") String filename,
            @RequestParam("file") MultipartFile mfile) throws IllegalStateException, InvalidFormatException, IOException, ParseException {

		String dmId = "";
		// 获得项目路径
		String realPath = request.getSession().getServletContext().getRealPath("/");
		String oriFileName = mfile.getOriginalFilename();
		String fileNewName = realPath + "file" + File.separator + oriFileName;
		File newfile = new File(fileNewName);
		// 先将文件上传到项目中
		mfile.transferTo(newfile);
		dmId = deployService.saveNewDeploye(newfile,fileNewName);
		// 将部署信息保存的WorkflowBeanStatic
		WorkflowBeanStatic.file = newfile;
		WorkflowBeanStatic.filename = filename;
		WorkflowBeanStatic.deploymentId = dmId;
	}
	

	/**
	 * @Title: addCustomer
	 * @Description: 转向增加页面
	 * @param request
	 * @return: ModelAndView
	 */
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public ModelAndView addCustomer(HttpServletRequest request, String userId) {
		
		return new ModelAndView("deploy/add");
	}


}
