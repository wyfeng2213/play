package com.jshuabo.templateadminmysql.server.web.supplier;

import javax.servlet.http.HttpServletRequest;

import org.apache.xmlbeans.impl.xb.xsdschema.Public;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.annotation.JsonFormat.Value;
import com.jshuabo.templateadminmysql.server.service.supplier.ISupplierService;

@Controller
@RequestMapping(value = "supplier")
public class SupplierController {
	
	@Autowired
	private ISupplierService SS;
	
	@RequestMapping(value = "list")
	public String list(HttpServletRequest re) {
	return "supplier/list";
	
	}

}
