//项目名称
var strPath = window.document.location.pathname;
var postPath = strPath.substring(0, strPath.substr(1).indexOf('/') + 1);

/**
 * 创建combogrid组件
 * 
 * @param {object}
 *            target (jq元素)
 * @param {object}
 *            queryParamsObj (查询参数对象)
 * @param {boolean}
 *            required (是否必填项) 默认为false
 */
function create_combogrid(target, queryParamsObj, required, onSelectFun) {
	target
			.combogrid({
				panelWidth : 500, // 面板宽度
				panelHeight : 308, // 面板高度
				mode : 'remote',
				method : 'post',
				url : postPath + '/process',
				queryParams : queryParamsObj,
				pagination : true,
				pageSize : 10,
				pageList : [ 5, 10, 15 ],
				required : required,
				idField : 'id', // combogrid的值，传到后台
				textField : 'name', // 显示的值
				columns : [ [ {
					field : 'code',
					title : '编码',
					width : 247,
					sortable : true
				}, {
					field : 'name',
					title : '名称',
					width : 248,
					sortable : true
				} ] ],
				onSelect : function(index, row) {
					if ("undefined" != typeof onSelectFun) {
						onSelectFun(index, row);
					}
				},
				onLoadSuccess : function(data) {
					var paramsObj = target.combogrid('grid')
							.datagrid('options').queryParams;
					if ("undefined" == typeof paramsObj.q && data.total == 0) {
					} else if (data.total == 0) {// 没有符合查询条件的数据
						target.combogrid('clear');
						target.focus();
						target.combogrid('grid').datagrid('load',
								queryParamsObj);
					}
				}
			});
}

/**
 * 创建combogrid组件(在修改页面中，防止分页时页面显示id)
 * 
 * @param {object}
 *            target (jq元素)
 * @param {object}
 *            bean (查询参数对象)
 * @param {boolean}
 *            required (是否必填项) 默认为false
 * @param {long}
 *            width(宽)
 * @param {long}
 *            height(高)
 * @param {object}
 *            hiddenName (jq元素) 存储name的隐藏域
 */
function create_combogrid_forEdit(target, bean, required, width, height,
		hiddenName) {
	var queryParamsObj = { // 查询参数对象
		bean : bean,
		method : 'page',
		status : 'ENABLED' // 状态为有效的记录
	};
	target
			.combogrid({
				panelWidth : width, // 面板宽度
				panelHeight : height, // 面板高度
				mode : 'remote',
				method : 'post',
				url : postPath + '/process',
				queryParams : queryParamsObj,
				pagination : true,
				pageSize : 10,
				pageList : [ 5, 10, 15 ],
				required : required,
				idField : 'id', // combogrid的值，传到后台
				textField : 'name', // 显示的值
				columns : [ [ {
					field : 'code',
					title : '编码',
					width : 247,
					sortable : true
				}, {
					field : 'name',
					title : '名称',
					width : 248,
					sortable : true
				} ] ],
				onSelect : function() {
					// 将隐藏域的值替换成 选中行的name值
					hiddenName.val(target.combogrid('grid').datagrid(
							'getSelected').name);
				},
				onLoadSuccess : function(data) {
					var paramsObj = target.combogrid('grid')
							.datagrid('options').queryParams;
					if ("undefined" == typeof paramsObj.q && data.total == 0) {
					} else if (data.total == 0) {// 没有符合查询条件的数据
						target.combogrid('clear');
						target.focus();
						target.combogrid('grid').datagrid('load',
								queryParamsObj);
					}
					if (!target.combogrid('grid').datagrid('getSelected')) { // 若数据不再当前页
						target.next().find('input.combo-text').val(
								hiddenName.val());
					}
				}
			});
}

function createCombogrid_MapResult(target, queryParamsObj, required) {
	target
			.combogrid({
				panelWidth : 500, // 面板宽度
				panelHeight : 308, // 面板高度
				mode : 'remote',
				method : 'post',
				url : postPath + '/process',
				queryParams : queryParamsObj,
				pagination : true,
				pageSize : 10,
				pageList : [ 5, 10, 15 ],
				required : required,
				idField : 'ID', // combogrid的值，传到后台
				textField : 'NAME', // 显示的值
				columns : [ [ {
					field : 'CODE',
					title : '编码',
					width : 247,
					sortable : true
				}, {
					field : 'NAME',
					title : '名称',
					width : 248,
					sortable : true
				} ] ],
				onSelect : function(index, row) {
					if ("undefined" != typeof onSelectFun) {
						onSelectFun(index, row);
					}
				},
				onLoadSuccess : function(data) {
					var paramsObj = target.combogrid('grid')
							.datagrid('options').queryParams;
					if ("undefined" == typeof paramsObj.q && data.total == 0) {
					} else if (data.total == 0) {// 没有符合查询条件的数据
						target.combogrid('clear');
						target.focus();
						target.combogrid('grid').datagrid('load',
								queryParamsObj);
					}
				}
			});
}

/**
 * 未授信客户
 * 
 * @param {object}
 *            target
 * @param {boolean}
 *            required (是否必填项)
 */
function combogridCommon_bis_customer_is_credit(target,required,is_credit) {
	var is_credit_value = '0';
	if("undefined" != typeof is_credit){//如果is_credit定义
		is_credit_value = '1';
	}
	var queryParamsObj = { //查询参数对象
			bean: 'bisCustomer',
			method: 'page',
			status: 'ENABLED', //状态为有效的记录
			isCredit: is_credit_value //授信标识为未授信
	};
	createCombogrid_MapResult(target,queryParamsObj,required);
}

/**
 * 所有客户
 * 
 * @param {object}
 *            target
 * @param {boolean}
 *            required (是否必填项)
 */
function combogridCommon_bis_customer(target, required) {
	var queryParamsObj = { // 查询参数对象
		bean : 'bisCustomer',
		method : 'page',
		status : 'ENABLED' // 状态为有效的记录
	};
	createCombogrid_MapResult(target, queryParamsObj, required);
}

/**
 * 贷款规则
 * 
 * @param {object}
 *            target
 * @param {boolean}
 *            required (是否必填项)
 */
function combogridCommon_bis_loanRule(target, required) {
	var queryParamsObj = { // 查询参数对象
		bean : 'bisLoanRule',
		method : 'page',
		status : 'ENABLED' // 状态为有效的记录
	};
	createCombogrid_MapResult(target, queryParamsObj, required);
}

/**
 * 所有客户
 * 
 * @param {object}
 *            target
 * @param {boolean}
 *            required (是否必填项)
 */
function combogridCommon_pre_customer(target, required) {
	var queryParamsObj = { // 查询参数对象
		bean : 'bisCustomer',
		method : 'page',
		status : 'ENABLED' // 状态为有效的记录
	};
	createCombogrid_MapResult(target, queryParamsObj, required);
}

/** 所有客户
* 
* @param {object}
*            target
* @param {boolean}
*            required (是否必填项)
*/
function combogridCommon_after_customer(target, required) {
	var queryParamsObj = { // 查询参数对象
		bean : 'bisCustomer',
		method : 'page',
		status : 'ENABLED' // 状态为有效的记录
	};
	createCombogrid_MapResult(target, queryParamsObj, required);
}

/**
 * 日结算报表所有客户
 * 
 * @param {object}
 *            target
 * @param {boolean}
 *            required (是否必填项)
 */
function combogridCommon_after_dailyBalancecustomer(target, required) {
	var queryParamsObj = { // 查询参数对象
		bean : 'bisCustomer',
		method : 'page',
		status : 'ENABLED'
	};
	createCombogrid_MapResult(target, queryParamsObj, required);
	//createCombogrid_for_after_dailyBalance(target, queryParamsObj, required);
}
/**
 * 日结算报表
 * 
 * @param {object}
 *            target
 * @param {boolean}
 *            required (是否必填项)
 */
function createCombogrid_for_after_dailyBalance(target, queryParamsObj, required,onSelectFun) {
	target.combogrid({
				panelWidth : 520, // 面板宽度
				panelHeight : 308, // 面板高度
				mode : 'remote',
				method : 'post',
				url : postPath + '/process',
				queryParams : queryParamsObj,
				pagination : true,
				pageSize : 10,
				pageList : [ 5, 10, 15 ],
				required : required,
				idField : 'CUSTOMER_NAME', // combogrid的值，传到后台
				textField : 'CUSTOMER_NAME', // 显示的值
				columns : [ [ {
					field : 'CUSTOMER_NAME',
					title : '用户名',
					width : 247,
					sortable : true
				}, {
					field : 'CUSTOMER_CODE',
					title : '用户编码',
					width : 248,
					sortable : true
				}] ],
				onSelect : function(index, row) {
					if ("undefined" != typeof onSelectFun) {
						onSelectFun(index, row);
					}
				},
				onLoadSuccess : function(data) {
					var paramsObj = target.combogrid('grid')
							.datagrid('options').queryParams;
					if ("undefined" == typeof paramsObj.q && data.total == 0) {
					} else if (data.total == 0) {// 没有符合查询条件的数据
						target.combogrid('clear');
						target.focus();
						target.combogrid('grid').datagrid('load',
								queryParamsObj);
					}
				}
			});
}

/**
 * 所有客户
 * 
 * @param {object}
 *            target
 * @param {boolean}
 *            required (是否必填项)
 */
function combogridCommon_after_loan_customer(target, required) {
	var queryParamsObj = { // 查询参数对象
		bean : 'bisCustomer',
		method : 'page',
		status : 'ENABLED' // 状态为有效的记录
	};
	createCombogrid_MapResult(target, queryParamsObj, required);
}

function createCombogrid_for_bank_account(target, queryParamsObj, required,accountObj,bankObj) {
	target.combogrid({
				panelWidth : 500, // 面板宽度
				panelHeight : 308, // 面板高度
				mode : 'remote',
				method : 'post',
				url : postPath + '/process',
				queryParams : queryParamsObj,
				pagination : true,
				pageSize : 10,
				pageList : [ 5, 10, 15 ],
				required : required,
				idField : 'ACCOUNT_NAME', // combogrid的值，传到后台
				textField : 'ACCOUNT_NAME', // 显示的值
				columns : [ [ {
					field : 'ACCOUNT_NAME',
					title : '户名',
					width : 247,
					sortable : true
				}, {
					field : 'BANK_ACCOUNT',
					title : '账号',
					width : 248,
					sortable : true
				}, {
					field : 'BANK_NAME',
					title : '开户行',
					width : 248,
					hidden:true,
					sortable : true
				} ] ],
				onSelect : function(index, row) {
					var grid = target.combogrid('grid');	// 获取数据表格对象
					var row = grid.datagrid('getSelected');		// 获取选择的行
					accountObj.val(row.BANK_ACCOUNT);
					bankObj.val(row.BANK_NAME);
				},
				onLoadSuccess : function(data) {
					var paramsObj = target.combogrid('grid')
							.datagrid('options').queryParams;
					if ("undefined" == typeof paramsObj.q && data.total == 0) {
					} else if (data.total == 0) {// 没有符合查询条件的数据
						target.combogrid('clear');
						target.focus();
						target.combogrid('grid').datagrid('load',
								queryParamsObj);
					}
				}
			});
}

/**
 * 银行账号
 * 
 * @param {object}
 *            target
 * @param {boolean}
 *            required (是否必填项)
 */
function combogridCommon_bis_bank_account(target, required,accountObj,bankObj) {
	var queryParamsObj = { // 查询参数对象
		bean : 'bisBankAccount',
		method : 'page',
		status : 'ENABLED' // 状态为有效的记录
	};
	createCombogrid_for_bank_account(target, queryParamsObj, required,accountObj,bankObj);
}
