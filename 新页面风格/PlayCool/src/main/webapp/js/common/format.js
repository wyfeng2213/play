//格式化创建人员  @author: jing.huang
function format_creator(value, row, index) {
	if (row.info != null && row.info.creator != null) {
		return row.info.creator;
	} else {
		return "-";
	}
}
// 格式化创建时间 @author: jing.huang
function format_createdTime(value, row, index) {
	if (row.info != null && row.info.createdTime != null) {
		return row.info.createdTime;
	} else {
		return "-";
	}
}
// 格式化最后操作人员 @author: jing.huang
function format_lastOperator(value, row, index) {
	if (row.info != null && row.info.lastOperator != null) {
		return row.info.lastOperator;
	} else {
		return "-";
	}
}
// 格式化最后操作时间 @author: jing.huang
function format_lastOperatedTime(value, row, index) {
	if (row.info != null && row.info.lastOperatedTime != null) {
		return row.info.lastOperatedTime;
	} else {
		return "-";
	}
}

/**
 * @param 格式话显示上级组织名称
 * @returns
 */
function format_parentOrg_name(value, row, index) {
	if (row != null && row.parentOrg != null) {
		return row.parentOrg.name;
	} else {
		return "-";
	}
}

/**
 * @param 格式话管理者联系方式
 * @returns
 */
function format_managerContact_tel(value, row, index) {
	if (row != null && row.managerContact != null) {
		return row.managerContact.tel;
	} else {
		return "-";
	}
}

/**
 * @param user
 *            list 组织名称
 * @returns
 */
function format_orgName(value, row, index) {
	if (row != null && row.organization != null) {
		return row.organization.name;
	} else {
		return "-";
	}
}

/**
 * @param 状态
 * @returns {String}
 */
function format_enabled(value, row, index) {
	if (value) {
		return "有效";
	} else {
		return "<span style='color:red;'>无效</span>";
	}
}

/**
 * @param 客户
 * @returns
 */
function yesOrNo(value, row, index) {
//	return value ? '√' : 'x';
	return value == "1" ? '是' : '否';
}
/**
 * bis status formatter
 * */
function status(value, row, index) {
	if (value == 'ENABLED') {
		return "生效";
	} else {
		return "<span style='color:red;'>失效</span>";
	}
}
/**
 * @param 状态
 * @Description {String}
 */
function format_status(value, row, index) {
	if (row.status == 'ENABLED') {
		return "生效";
	} else {
		return "<span style='color:red;'>失效</span>";
	}
}

/**
 * @param value 
 * @param row
 * @param index
 * @Description {String} 市级别 格式化
 */
function cityLevel(value, row, index){
	if(value == "MUNICIPALITY"){
		return "直辖市";	
	}
	if(value == "PREFECTURAL"){
		return "地级市";	
	}
	if(value == "COUNTY"){
		return "县级市";	
	}
}

/**
 * @param value 
 * @param row
 * @param index
 * @Description {String} 区级别 格式化
 */
function distinctLevel(value, row, index){
	if(value == "DISTRICT"){
		return "区";	
	}
	if(value == "COUNTY"){
		return "县";	
	}
}

 
/**
 * @param value 
 * @param row
 * @param index
 * @Description {String} 省级别 格式化
 */
function provinceLevel(value, row, index){
	if(value == "MUNICIPALITY"){
		return "自治区";	
	}
	if(value == "PROVINCE"){
		return "省";	
	}
}
 

/**
 * @param value
 * @param row
 * @param index
 * @Description 空值过滤
 */
function short_name(value, row, index) {
	if (value == '2')
		return "-";
	return value;
}

/**
 * @param value
 * @returns
 * @Description 是否使用
 */
function isUse(value, row, index) {
	return value == 0 ? "未使用" : "已使用";
}

/**
 * @param 组织父
 * @returns
 */
function parentPermissionId(value, row, index) {
	if (row != null && row.parentPermission != null) {
		return row.parentPermission.name;
	}
	return "-";
}

/**
 * @param 格式化显示最后一次密码
 * @returns
 */
function format_lastPwd(value, row) {
	if (row != null) {
		return row.info.lastPwd;
	} else {
		return "-";
	}
}

/**
 * @param 最后一次修改密码时间
 * @returns
 */
function format_lastPwdTime(value, row) {
	if (row != null) {
		return row.info.lastMdPwdTime;
	} else {
		return "-";
	}
}

/**
 * @param 格式化创建时间
 * @returns
 */
function format_createTime(value, row) {
	if (row != null) {
		return row.info.createdTime;
	} else {
		return "-";
	}
}

function format_showShorCut(value, row, index) {
	if (row.showShorCut) {
		return "显示";
	} else {
		return "不显示";
	}
}

/**
 * @param 格式话显示邮箱
 * @returns
 */
function format_email(value, row, index) {
	if (row != null && row.contact != null) {
		return row.contact.email;
	} else {
		return "-";
	}
}

/**
 * @param 电话
 * @returns
 */
function format_tel(value, row, index) {
	if (row != null && row.contact != null) {
		return row.contact.tel;
	} else {
		return "-";
	}
}

/**
 * @param 手机
 * @returns
 */
function format_mobile(value, row, index) {
	if (row != null && row.contact != null) {
		return row.contact.mobile;
	} else {
		return "-";
	}
}

/**
 * description:格式化QQ
 * 
 * @param
 * @returns
 */
function format_qq(value, row, index) {
	if (row != null && row.contact != null) {
		return row.contact.qq;
	} else {
		return "-";
	}
}

/**
 * @param 性别
 * @returns {String}
 */
function format_sex(value, row, index) {
	if (row != null && row.contact != null) {
		if (row.contact.sex == 1) {
			return "男";
		} else {
			return "女";
		}
	} else {
		return "-";
	}
}

/**
 * description:格式化用户名
 * 
 * @returns
 */
function format_user_name(value, row, index) {
	if (row != null && row.user != null && row.user.name != null) {
		return row.user.name;
	} else {
		return "-";
	}
}

/**
 * 格式化显示货款品种
 * @param {String} value
 * @param {Object} row
 * @param {number} index
 * @date 2015年3月27日16:58:56
 * @author shuang.zhou
 */
function format_loan_type(value, row, index) {
	var result = "-";
	if (value != null) {
		switch (value) {
		case "ORDER_FINANCE":
			result = "单E贷";
			break;
		case "INVENTORY_FINANCE":
			result = "货E贷";
			break;
		default:
			result = value;
		break;
		}
	}
	return result;
}
