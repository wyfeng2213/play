/**
 *  数据表格下拉框
 *  version 2.0
 *  ——添加onSelect事件 适应性更强
 */

/**
 * 创建combogrid组件
 * @param {object} target (jq元素)
 * @param {object} queryParamsObj (查询参数对象)
 * @param {boolean} required (是否必填项) 默认为false
 */
function create_combogrid(target,queryParamsObj,required,onSelectFun) {
	target.combogrid({    
	    panelWidth:500,  //面板宽度
	    panelHeight:308, //面板高度
	    mode: 'remote', 
	    method: 'post',
	    url: postPath+'/process',  
	    queryParams: queryParamsObj,
	    pagination:true,
	    pageSize : 10,		
		pageList : [5,10,15],
		required:required,
	    idField: 'id',    //combogrid的值，传到后台
	    textField: 'name',  //显示的值  
	    columns: [[ 
	        {field:'code',title:'编码',width:247,sortable:true},    
	        {field:'name',title:'名称',width:248,sortable:true}    
	    ]],
	    onSelect:function(index,row){
	    	if("undefined" != typeof onSelectFun){
	    		onSelectFun(index,row);
	    	}
	    },
	    onLoadSuccess : function(data) {
	    	var paramsObj = target.combogrid('grid').datagrid('options').queryParams;
	    	if("undefined" == typeof paramsObj.q && data.total == 0) {
	    	}else if(data.total == 0) {//没有符合查询条件的数据
	    		target.combogrid('clear');
	    		target.focus();
	    		target.combogrid('grid').datagrid('load',queryParamsObj);
	    	}
	    }
	});
}

/**
 *  carrier(承运商)
 * @param {object} target (jq元素)
 * @param {boolean} required (是否必填项) 默认为false	
 * @date   2014年11月4日 下午2:07:36
 */
function combogridCommon_carrier(target, required,onSelectFun) {
	var queryParamsObj = {
			bean: 'bisOrganization',
	    	method: 'page',
	    	status: 'ENABLED',
	    	type : 'IS_CARRIER'
	};
	create_combogrid(target, queryParamsObj, required,onSelectFun);
}

/**
 * 创建车辆combogrid组件
 * @param {object} target (jq元素)
 * @param {object} queryParamsObj (查询参数对象)
 * @param {boolean} required (是否必填项) 默认为false
 */
function create_vehiclecombogrid(target,queryParamsObj,required,onSelectFun) {
	target.combogrid({    
	    panelWidth:500,  //面板宽度
	    panelHeight:308, //面板高度
	    mode: 'remote', 
	    method: 'post',
	    url: postPath+'/process',  
	    queryParams: queryParamsObj,
	    pagination:true,
	    pageSize : 10,		
		pageList : [5,10,15],
		required:required,
	    idField: 'id',    //combogrid的值，传到后台
	    textField: 'no',  //显示的值  
	    columns: [[ 
	        {field:'no',title:'车牌号',width:248,sortable:true},
	        {field:'mainDriver.name',title:'司机名称',width:247,sortable:true,
	        	formatter: function(value,row,index) {
	     	    	if(row != null && row.mainDriver != null && row.mainDriver.name != null) {
	     	    		return row.mainDriver.name;
	     	    	} else {
	     	    		return "-";
	     	    	}
	     	    }
	        }
	        
	    ]],
	    onSelect:function(index,row){
	    	if("undefined" != typeof onSelectFun){
	    		onSelectFun(index,row);
	    	}
	    },
	    onLoadSuccess : function(data) {
	    	var paramsObj = target.combogrid('grid').datagrid('options').queryParams;
	    	if("undefined" == typeof paramsObj.q && data.total == 0) {
	    	}else if(data.total == 0) {//没有符合查询条件的数据
	    		target.combogrid('clear');
	    		target.focus();
	    		target.combogrid('grid').datagrid('load',queryParamsObj);
	    	}
	    }
	});
}

/**
 *  vehicle(车辆)
 * @param {object} target (jq元素)
 * @param {boolean} required (是否必填项) 默认为false	
 * @date   2014年11月4日 下午2:07:36
 */
function combogridCommon_vehicle(target, required,onSelectFun) {
	var queryParamsObj = {
			bean: 'bisVehicle',
	    	method: 'page',
	    	status: 'ENABLED'	
	};
	create_vehiclecombogrid(target, queryParamsObj, required,onSelectFun);
}

/**
 * driver(司机)
 * @param {object} target (jq元素)
 * @param {boolean} required (是否必填项) 默认为false	
 * @date   2014年11月7日 上午9:54:27
 */
function combogridCommon_driver(target, required,onSelectFun) {
	var queryParamsObj = {
			bean: 'bisDriver',
	    	method: 'page',
	    	status: 'ENABLED'
	};
	create_combogrid(target, queryParamsObj, required,onSelectFun);
}

/**
 * transLocation(Bis运输地)
 * @param {object} target
 * @param {boolean} required (是否必填项)
 */
function combogridCommon_bis_transLocation(target,required,onSelectFun,platFormId,platFormCode) {
	var queryParamsObj = { //查询参数对象
	    	bean: 'bisTransLocation',
	    	method: 'combogrid_page',
	    	status: 'ENABLED', //状态为有效的记录
	    	platFormId:platFormId,
	    	platFormCode:platFormCode
	};
	create_combogrid(target,queryParamsObj,required,onSelectFun);
}

/**
 * 只查询运输地中类型为'平台'的数据
 * @param target
 * @param required
 * @param onSelectFun
 * @param platFormId
 * @param platFormCode
 */
function combogridCommon_bis_plat_transLocation(target,required,onSelectFun,platFormId,platFormCode) {
	var queryParamsObj = { //查询参数对象
	    	bean: 'bisTransLocation',
	    	method: 'combogrid_page',
	    	status: 'ENABLED', //状态为有效的记录
	    	type : 'PLAT_FORM',
	    	platFormId:platFormId,
	    	platFormCode:platFormCode
	};
	create_combogrid(target,queryParamsObj,required,onSelectFun);
}



/**
 * 创建路线combogrid组件
 * @param {object} target (jq元素)
 * @param {object} queryParamsObj (查询参数对象)
 * @param {boolean} required (是否必填项) 默认为false
 */
function create_routeLinecombogrid(target,queryParamsObj,required,onSelectFun) {
	target.combogrid({    
	    panelWidth:500,  //面板宽度
	    panelHeight:308, //面板高度
	    mode: 'remote', 
	    method: 'post',
	    url: postPath+'/process',  
	    queryParams: queryParamsObj,
	    pagination:true,
	    pageSize : 10,		
		pageList : [5,10,15],
		required:required,
	    idField: 'id',    //combogrid的值，传到后台
	    textField: 'code',  //显示的值  
	    columns: [[ 
	        {field:'code',title:'编码',width:247,sortable:true},    
	        {field:'description',title:'描述',width:248,sortable:true}    
	    ]],
	    onSelect:function(index,row){
	    	if("undefined" != typeof onSelectFun){
	    		onSelectFun(index,row);
	    	}
	    },
	    onLoadSuccess : function(data) {
	    	var paramsObj = target.combogrid('grid').datagrid('options').queryParams;
	    	if("undefined" == typeof paramsObj.q && data.total == 0) {
	    	}else if(data.total == 0) {//没有符合查询条件的数据
	    		target.combogrid('clear');
	    		target.focus();
	    		target.combogrid('grid').datagrid('load',queryParamsObj);
	    	}
	    }
	});
}

/**
 *  路线(routeLine)
 * @param {object} target (jq元素)
 * @param {boolean} required (是否必填项) 默认为false	
 * @date   2014年11月4日 下午2:07:36
 */
function combogridCommon_routeLine(target, required,onSelectFun) {
	var queryParamsObj = {
			bean: 'bisRouteLine',
	    	method: 'page',
	    	status: 'ENABLED',
	    	curPlatFormFlag : '1'
	};
	create_routeLinecombogrid(target, queryParamsObj, required,onSelectFun);
}