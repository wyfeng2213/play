/**
 * 生效失效操作
 * 
 * @param {String}
 *            name 请求url controller
 * @RequestMapping value
 * @param {String}
 *            status
 * @param {String}
 *            parentName (加上此参数)
 * @date 2014-07-25 15:49
 * @author jing.huang
 */
function updateStatus(name, status, parentName) {
	var url = postPath + '/' + name + '/updateStatus';
	if ("undefined" != typeof parentName) {
		name = parentName;
	}
	var selections = $("#" + name).datagrid('getSelections');
	var ids = "";
	var msgTarget;
	if ($('.msg').length > 0) {
		msgTarget = $('.msg');
	} else {
		msgTarget = parent.$('.msg');
	}
	if (selections.length > 0) {
		// 取得所有选中行id
		for (var i = 0; i < selections.length; i++) {
			ids += selections[i].id || selections[i].ID + ",";
		}
		ids = ids.substring(0, ids.length - 1);
		// 与后台交互
		$.ajax({
			url : url,
			method : 'post',
			data : {
				ids : ids,
				status : status
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : 'json',
			success : function(data) {
				refreshDatagrid(name, true);
				msgObj.ajaxResponseMsg(msgTarget, data);
			}
		});
	} else {
		msgObj.invalidSelectMsg(msgTarget);
	}
}

/**
 * 格式化显示是否授信
 * 
 * @param {String}
 *            value
 * @param {Object}
 *            row
 * @param {number}
 *            index
 * @date 2014-07-25 16:27
 * @author jing.huang
 */
function format_isCredit(value, row, index) {
	if (row.IS_CREDIT != null) {
		if (row.IS_CREDIT == false) {
			return "<span style='color:red;'>未授信</span>";
		} else if (row.IS_CREDIT == true) {
			return "<span style='color:green;'>已授信</span>";
		}
	} else {
		return "-";
	}
}
/**
 * 格式化显示性别
 * 
 * @param {String}
 *            value
 * @param {Object}
 *            row
 * @param {number}
 *            index
 * @date 2015年3月27日16:58:56
 * @author shuang.zhou
 */
function format_sex(value, row, index) {
	if (row.SEX != null) {
		if (row.SEX == false) {
			return "女";
		} else if (row.SEX == true) {
			return "男";
		}
	} else {
		return "-";
	}
}
/**
 * 格式化显示业务类型
 * 
 * @param {String}
 *            value
 * @param {Object}
 *            row
 * @param {number}
 *            index
 * @date 2015年3月27日16:58:56
 * @author shuang.zhou
 */
function format_type(value, row, index) {
	if (row.TYPE != null) {
		if (row.TYPE == 'PERSON') {
			return "个人";
		} else if (row.TYPE == 'LEGAL') {
			return "法人";
		} else if (row.TYPE == 'COMPANY') {
			return "公司";
		} else if (row.TYPE == 'GROUP') {
			return "集团";
		}
	} else {
		return "-";
	}
}


/**
 * 格式化显示持卡人业务类型
 * 
 * @param {String}
 *            value
 * @param {Object}
 *            row
 * @param {number}
 *            index
 * @date 2015年3月27日16:58:56
 * @author shuang.zhou
 */
function format_type1(value, row, index) {
	if (row.OWNER_TYPE != null) {
		if (row.OWNER_TYPE == 'PERSON') {
			return "个人";
		} else if (row.OWNER_TYPE == 'LEGAL') {
			return "法人";
		} else if (row.OWNER_TYPE == 'COMPANY') {
			return "公司";
		} else if (row.OWNER_TYPE == 'GROUP') {
			return "集团";
		}
	} else {
		return "-";
	}
}

/**
 * 格式化显示存储账户类型
 * 
 * @param {String}
 *            value
 * @param {Object}
 *            row
 * @param {number}
 *            index
 * @date 2015年3月27日16:58:56
 * @author shuang.zhou
 */
function format_type2(value, row, index) {
	if (row.OWNER_TYPE != null) {
		if (row.TYPE == 'BASE') {
			return "基本存款账户";
		} else if (row.TYPE == 'GENERAL') {
			return "一般存款账户";
		} else if (row.TYPE == 'TEMP') {
			return "临时存款账户";
		} else if (row.TYPE == 'PRIVATE') {
			return "专用存款账户";
		}
	} else {
		return "-";
	}
}
/**
 * 格式化显示贷款品种
 * 
 * @param {String}
 *            value
 * @param {Object}
 *            row
 * @param {number}
 *            index
 * @date 2014-07-25 16:27
 * @author jing.huang
 */
function format_loanType(value, row, index) {
	if (row.LOAN_TYPE != null) {
		if (row.LOAN_TYPE == 'ORDER_FINANCE') {
			return "单E贷";
		} else if (row.LOAN_TYPE == 'INVENTORY_FINANCE') {
			return "货E贷";
		}
	} else {
		return "-";
	}
}

/**
 * 格式化显示婚姻状况
 * 
 * @param {String}
 *            value
 * @param {Object}
 *            row
 * @param {number}
 *            index
 * @date 2014-07-25 16:27
 * @author jing.huang
 */
function format_maritalStatus(value, row, index) {
	if (row.MARITAL_STATUS != null) {
		if (row.MARITAL_STATUS == 'UNMARRIED') {
			return "未婚";
		} else if (row.MARITAL_STATUS == 'MARRIED') {
			return "已婚";
		}else if (row.MARITAL_STATUS == 'DIVORCE') {
			return "离异";
		}
	} else {
		return "-";
	}
}

/**
 * 格式化显示证件类型
 * 
 * @param {String}
 *            value
 * @param {Object}
 *            row
 * @param {number}
 *            index
 * @date 2014-07-25 16:27
 * @author jing.huang
 */
function format_certType(value, row, index) {
	if (row.CERT_TYPE != null) {
		if (row.CERT_TYPE == 'ID') {
			return "身份证";
		} else if (row.CERT_TYPE == 'BUSINESS') {
			return "营业执照";
		} else if (row.CERT_TYPE == 'PASSPORT') {
			return "护照";
		} else if (row.CERT_TYPE == 'OFFICERS') {
			return "军官证";
		}
	} else {
		return "-";
	}
}

/**
 * 格式化显示状态
 * 
 * @param {String}
 *            value
 * @param {Object}
 *            row
 * @param {number}
 *            index
 * @date 2014-07-25 16:27
 * @author jing.huang
 */
function format_status(value, row, index) {
	if (row.status != null || row.STATUS != null) {
		if (row.status == 'ENABLED' || row.STATUS == 'ENABLED') {
			return "生效";
		} else if (row.status == 'DISABLED' || row.STATUS == 'DISABLED') {
			return "<span style='color:red;'>失效</span>";
		}
	} else {
		return "-";
	}
}

/**
 * 右键菜单项生效失效逻辑代码
 * 
 * @param {String}
 *            pageName
 * @date 2014-07-25 16:27
 * @author jing.huang
 */

function bisCommon_rightMenuFun(pageName) {
	var menuTarget = $("#" + pageName + "_menu");
	var selections = $("#" + pageName).datagrid('getSelections');
	var num = selections.length;
	if (num == 1) {// 选中1行
		menuTarget.menu('enableItem', $('#' + pageName + '_deleteItem'));

		if (selections[0].status == 'ENABLED'
				|| selections[0].STATUS == 'ENABLED') {// 状态为‘生效’
			menuTarget.menu('disableItem', $('#' + pageName + '_enabledItem'));

			menuTarget.menu('enableItem', $('#' + pageName + '_editItem'));
			menuTarget.menu('enableItem', $('#' + pageName + '_disabledItem'));
		} else if (selections[0].status == 'DISABLED'
				|| selections[0].STATUS == 'DISABLED') {// 状态为‘失效’
			menuTarget.menu('disableItem', $('#' + pageName + '_editItem'));
			menuTarget.menu('disableItem', $('#' + pageName + '_disabledItem'));

			menuTarget.menu('enableItem', $('#' + pageName + '_enabledItem'));
		} else {// 状态为其它值
			menuTarget.menu('enableItem', $('#' + pageName + '_editItem'));
			menuTarget.menu('enableItem', $('#' + pageName + '_enabledItem'));
			menuTarget.menu('enableItem', $('#' + pageName + '_disabledItem'));
		}
	} else if (num > 1) {// 选中1行以上
		menuTarget.menu('disableItem', $('#' + pageName + '_editItem'));
		menuTarget.menu('enableItem', $('#' + pageName + '_deleteItem'));
		var isSame = 1;
		for (var i = 1; i < num; i++) {
			if (selections[i].status != selections[0].status) {
				isSame = 0;
			}
		}
		// 如果状态相同
		if (isSame == 1) {
			// 如果状态全为‘生效’
			if (selections[0].status == 'ENABLED'
					|| selections[0].STATUS == 'ENABLED') {
				menuTarget.menu('disableItem', $('#' + pageName
						+ '_enabledItem'));
				menuTarget.menu('enableItem', $('#' + pageName
						+ '_disabledItem'));
			} else {// 如果状态全为‘失效’
				menuTarget.menu('disableItem', $('#' + pageName
						+ '_disabledItem'));
				menuTarget.menu('enableItem',
						$('#' + pageName + '_enabledItem'));
			}
		} else {// 如果状态不同
			menuTarget.menu('disableItem', $('#' + pageName + '_enabledItem'));
			menuTarget.menu('disableItem', $('#' + pageName + '_disabledItem'));
		}
	} else {// 未选中
		menuTarget.menu('disableItem', $('#' + pageName + '_editItem'));
		menuTarget.menu('disableItem', $('#' + pageName + '_enabledItem'));
		menuTarget.menu('disableItem', $('#' + pageName + '_disabledItem'));
		menuTarget.menu('disableItem', $('#' + pageName + '_deleteItem'));
	}

}

/**
 * 批量删除信息
 * 
 * @param {String}
 *            pageName
 * @author yu.wang @
 */

function deleteItemById(name, pageName) {
	var url = postPath + '/' + name + '/deleteItemById';
	if ("undefined" != typeof parentName) {
		name = parentName;
	}
	var selections = $("#" + name).datagrid('getSelections');
	var ids = "";
	var msgTarget;
	if ($('.msg').length > 0) {
		msgTarget = $('.msg');
	} else {
		msgTarget = parent.$('.msg');
	}
	if (selections.length > 0) {
		// 取得所有选中行id
		for (var i = 0; i < selections.length; i++) {
			ids += selections[i].id + ",";
		}
		ids = ids.substring(0, ids.length - 1);
		// 与后台交互
		$.ajax({
			url : url,
			method : 'post',
			data : {
				ids : ids,
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : 'json',
			success : function(data) {
				refreshDatagrid(name, true);
				msgObj.ajaxResponseMsg(msgTarget, data);
			}
		});
	} else {
		msgObj.invalidSelectMsg(msgTarget);
	}
}

/**
 * 跳转到查看货物页面
 * 
 * @param tableId
 *            列表页面datagrid table的ID名
 */
function scanGoods(tableId) {
	var selections = $("#" + tableId).datagrid('getSelections');
	if (selections.length == 1) {
		var url = postPath + '/tmsDispatchBill/scanDispatchBillGoods/'
				+ selections[0].id + '/' + tableId;
		var dialogName = tableId + "_tempDialog";
		eventKey(dialogName);
		$("<div id='" + dialogName + "'></div>").appendTo('body');// 将临时dialog容器添加到body中
		var target = $("#" + dialogName);
		target.dialog({
			title : '查看货物',
			iconCls : "icon-application-edit",
			closed : true,
			cache : false,
			modal : true,
			onClose : function() {
				$("#db_scan_tmsSegmentGoods_tempDialog").remove();
				$("#db_scan_tmsSegmentGoods_srchDiv").remove();
				refreshDatagrid(tableId);// 关闭刷新父页面，该函数在listUtil.jsp
			},
			onOpen : function() {
				target.panel('maximize');
				target.dialog('refresh', url);
			}
		});
		msgObj.clearMsg($('.msg'));// 清除所有的消息提示div内容
		msgObj.clearMsg(parent.$('.msg'));// 清除所有的消息提示div内容
		target.dialog('open');
	} else {
		msgObj.invalidSelectMsg(parent.$(".msg"));
	}
};

/**
 * 隐藏日期赋值
 * 
 * @param srcTarget
 *            源target
 * @param destTarget
 *            目标target
 * @param required
 *            是否是必须的
 */
function datebox_move(srcTarget, destTarget, required) {
	srcTarget.datetimebox({
		required : required,
		formatter : function(date) {
			if (date != null && date != '') {
				var y = date.getFullYear();
				var m = date.getMonth() + 1;
				var d = date.getDate();
				destTarget.val(y + "/" + m + "/" + d + " 00:00");
				return date.formatDate("yyyy-MM-dd");
			} else {
				destTarget.val('');
				return "";
			}
		}
	});
}