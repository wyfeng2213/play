package com.jshuabo.templateadminmysql.server.web.channelgoods;



import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jshuabo.frame.server.util.json.JacksonUtils;
import com.jshuabo.templateadminmysql.server.model.channelgoods.ChannelGoods;
import com.jshuabo.templateadminmysql.server.model.supplier.SupplierInfo;
import com.jshuabo.templateadminmysql.server.model.supplierGoods.GoodInfo;
import com.jshuabo.templateadminmysql.server.service.channelgoods.ChannelGoodsService;
import com.jshuabo.templateadminmysql.server.service.supplier.ISupplierService;
import com.jshuabo.templateadminmysql.server.service.supplierGoods.ISupplierGoodsService;

import util.Res;



@Controller
@RequestMapping(value ="channelgoods")
public class ChannelGoodsController {
	
	@Autowired
	private ChannelGoodsService ChannelGoodsService;
	
	@Autowired
	private ISupplierService supplierService;
	
	@Autowired
	private ISupplierGoodsService goodsInfoService;
	

	/*@Autowired
	private ISupplierService supplierService;*/

	
	@RequestMapping(value = "list")
	public String list(HttpServletRequest request) {
		return "channelgoods/list";
	}
	
	@RequestMapping(value = "/add")
	public String add(ChannelGoods channelGoods) {
		return ChannelGoodsService.addChannelGoods(channelGoods);
	}
	
	
	/**
	 * @Title: addCustomer
	 * @Description: 转向增加页面
	 * @param request
	 * @return: ModelAndView
	 */
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public ModelAndView showSupplier(HttpServletRequest request, String id) {
		return new ModelAndView("channelgoods/add");
	}
	
	@RequestMapping(value = "/getSupplierGoods", method = RequestMethod.POST)
	@ResponseBody
	public String getSupplierGoods(HttpServletRequest request,HttpServletResponse response,
			@RequestParam(value = "supplierId" , required = false)String supplierId) throws IOException {
		List<GoodInfo> goodsList=goodsInfoService.findSupplierGoods(Long.valueOf(supplierId));
		String jsonstr = JSON.toJSONString(goodsList); // List转json
		// 前台接收：	jsonStr = json.data.response.goodsJsonStr; 需要什么插件？
		Map<String, Object> resultMap = new HashMap<String, Object>();
    	resultMap.put("goodsJsonStr", jsonstr);
    	
		return JacksonUtils.object2json(resultMap);
	}
	
}
