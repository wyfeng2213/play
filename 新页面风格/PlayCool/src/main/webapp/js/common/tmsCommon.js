/**
 * 格式化显示线路类型
 * @param {String} value
 * @param {Object} row
 * @param {number} index
 * @date 2014-07-25 16:27
 * @author bing.jiang
 */
function format_line_type(value,row,index) {
	if(row.line_type != null) {
		if(row.line_type == 'TRUNK_LINE') {
			return "干线";
		} else if(row.line_type == 'BRANCH_LINE') {
			return  "支线";
		}
	} else {
		return "-";
	}
}

/**
 * 格式化显示配载方式
 * @param {String} value
 * @param {Object} row
 * @param {number} index
 * @date 2014-07-25 16:27
 * @author jing.huang
 */
function format_truck_load_type(value,row,index) {
	if(row.truck_load_type != null) {
		if(row.truck_load_type == 'FTL') {
			return "整车";
		} else if(row.truck_load_type == 'LTL') {
			return  "零担";
		} else if(row.truck_load_type == 'OTHER') {
			return  "其他";
		}
	} else {
		return "-";
	}
}

/**
 * 格式化显示运输方式
 * @param {String} value
 * @param {Object} row
 * @param {number} index
 * @date 2014-07-25 16:27
 * @author bing.jiang
 */
function format_trans_type(value,row,index) {
	if(row.trans_type != null) {
		if(row.trans_type == 'ROAD_TRANSPORT') {
			return "公路运输";
		} else if(row.trans_type == 'AIR_TRANSPORT') {
			return  "航空运输";
		} else if(row.trans_type == 'RAIL_TRANSPORT') {
			return  "铁路运输";
		} else if(row.trans_type == 'MARITIME_TRANSPORT') {
			return  "海上运输";
		}
	} else {
		return "-";
	}
}

/**
 * 格式化显示调度单状态
 * @param {String} value
 * @param {Object} row
 * @param {number} index
 * @date 2014-07-25 16:27
 * @author bing.jiang
 */
function format_dispatch_bill_status(value,row,index) {
	if(row.status != null) {
		if(row.status == 'OPEN') {
			return "打开";
		} else if(row.status == 'ACTIVE') {
			return  "生效";
		} else if(row.status == 'ON_ROAD') {
			return  "在途";
		} else if(row.status == 'ARRIVED') {
			return  "已运抵";
		} else if(row.status == 'CANCEL') {
			return  "取消";
		}
	} else {
		return "-";
	}
}

/**
 * 格式化显示运抵状态
 * @param {String} value
 * @param {Object} row
 * @param {number} index
 * @date 2014-07-25 16:27
 * @author bing.jiang
 */
function format_arrival_status(value,row,index) {
	if(row.arrival_status != null) {
		if(row.arrival_status == 'UN_SHIP') {
			return "待发运";
		} else if(row.arrival_status == 'ON_ROAD') {
			return  "在途";
		} else if(row.arrival_status == 'ARRIVED') {
			return  "已运抵";
		}
	} else {
		return "-";
	}
}

/**
 * 格式化显示签收状态
 * @param {String} value
 * @param {Object} row
 * @param {number} index
 * @date 2014-07-25 16:27
 * @author bing.jiang
 */
function format_sign_status(value,row,index) {
	if(row.sign_status != null) {
		if(row.sign_status == 'NON_SIGN') {
			return "不签收";
		} else if(row.sign_status == 'UN_SIGN') {
			return  "未签收";
		} else if(row.sign_status == 'ALL_DENIAL') {
			return  "全部拒签";
		} else if(row.sign_status == 'PART_SIGNED') {
			return  "部分签收";
		} else if(row.sign_status == 'NOT_HURL') {
			return  "未妥投";
		} else if(row.sign_status == 'SIGNED') {
			return  "正常签收";
		}
	} else {
		return "-";
	}
}

/**
 * 格式化显示运段状态
 * @param {String} value
 * @param {Object} row
 * @param {number} index
 * @date 2014-07-25 16:27
 * @author bing.jiang
 */
function format_segement_status(value,row,index) {
	if(row.status != null) {
		if(row.status == 'UN_DISPATCH') {
			return "待配载";
		} else if(row.status == 'DISPATCHED') {
			return  "已配载";
		} else if(row.status == 'PART_TRUCKED') {
			return  "部分装车";
		} else if(row.status == 'TRUCKED') {
			return  "已装车";
		} else if(row.status == 'ON_ROAD') {
			return  "在途";
		} else if(row.status == 'ARRIVED') {
			return  "已运抵";
		} else if(row.status == 'SIGNED') {
			return  "已签收";
		}
	} else {
		return "-";
	}
}

/**
 * 格式化显示运段状态
 * @param {String} value
 * @param {Object} row
 * @param {number} index
 * @date 2014-07-25 16:27
 * @author bing.jiang
 */
function format_segement_detail_status(value,row,index) {
	if(row.status != null) {
		if(row.status == 'UN_ENTERED') {
			return "未入场";
		} else if(row.status == 'ENTERED') {
			return  "已入场";
		} else if(row.status == 'DISPATCHED') {
			return  "已配载";
		} else if(row.status == 'TRUCKED') {
			return  "已装车";
		} else if(row.status == 'ON_ROAD') {
			return  "在途";
		}else if(row.status == 'ARRIVED') {
			return  "已运抵";
		}
	} else {
		return "-";
	}
}

function format_sign_driver_name(value, row, index) {
	if(null != row && null != row.driver_name) {
		return row.driver_name;
	} else {
		return "-";
	}
}