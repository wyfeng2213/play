package com.jshuabo.templateadminmysql.server.web.manager;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jshuabo.templateadminmysql.server.service.manager.IManagerService;


@Controller
@RequestMapping(value = "manager")
public class ManagerController {
	
	@Autowired
	private IManagerService managerService;
	
	@RequestMapping(value = "list")
	public String list(HttpServletRequest request) {
		return "manager/list";
	}
	/*页面跳转*/
	@RequestMapping(value= "findGoodsparam",method=RequestMethod.GET)
	@ResponseBody
	public void findGoodsparam(@RequestParam String id, @RequestParam String supplier_id,HttpServletRequest rq,  HttpServletResponse res) {
		
	     try {	 
	    Integer integer = Integer.valueOf(id);
	    Integer integer2 = Integer.valueOf(supplier_id);
	    String supplier_url= managerService.findGoodsparam(integer, integer2);
		 res.sendRedirect(supplier_url);//跳转到途牛的页面
		 
		} catch (Exception e) {
			
		}
		
	}
	
}
