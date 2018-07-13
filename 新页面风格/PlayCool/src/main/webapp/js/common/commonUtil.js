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
 * @param {String}
 *            msg (没有数据时的提示信息)
 */
function select_combogrid(target, bean, required, width, height) {
	var queryParamsObj = { // 查询参数对象
		bean : bean,
		method : 'page',
		status : 'ENABLED' // 状态为有效的记录
	};
	target.combogrid({
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
			width : width / 2,
			sortable : true
		}, {
			field : 'name',
			title : '名称',
			width : width / 2,
			sortable : true
		} ] ],
		onLoadSuccess : function(data) {
			if (data.total == 0) {// 没有符合查询条件的数据
				alert("未查询到相关信息"); // 提示信息
				target.combogrid('clear');
				target.focus();
				target.combogrid('grid').datagrid('load', queryParamsObj);
			}
		}
	});
}

/**
 * 收货方
 * @param target
 * @param bean
 * @param required
 * @param width
 * @param height
 */
function select_receiver_combogrid(target, bean, required, width, height) {
	var queryParamsObj = { // 查询参数对象
		bean : bean,
		method : 'page',
		status : 'ENABLED' // 状态为有效的记录
	};
	target.combogrid({
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
			width : width / 2,
			sortable : true
		}, {
			field : 'name',
			title : '名称',
			width : width / 2,
			sortable : true
		} ] ],
		onLoadSuccess : function(data) {
			if (data.total == 0) {// 没有符合查询条件的数据
				alert("未查询到相关信息"); // 提示信息
				target.combogrid('clear');
				target.focus();
				target.combogrid('grid').datagrid('load', queryParamsObj);
			}
		},
		onSelect: function(record)
		{
			var grid= target.combogrid('grid');
            var rs=$(grid).datagrid('getRows');
            if(rs.length>0){
            	var d=rs[record];
            	$("#customer_code").val(d.code);
            	$("#customer_name").val(d.name);
            }
		}
	});
}

/**
 * 改变状态
 * @param action 
 * @param status
 */
function statusChange(action, status) {
	var selections = $("#" + action).datagrid('getSelections');
	var ids = "";
	if (selections.length > 0) {
		for (var i = 0; i < selections.length; i++) {
			ids += selections[i].id + ",";
		}
		ids = ids.substring(0, ids.length - 1);
		if (ids.length > 0) {
			$.ajax({
				url : postPath + '/' + action + '/statusChange',
				type : 'post',
				data : 'status=' + status + '&ids=' + ids,
				error : function() {

				},
				success : function(datas) {
					if (datas == "successed") {
						tj_query(action);
					} else if (datas == "defeated") {
						$.messager.alert('Warning', '操作失败', 'error');
					}
				}
			});
		} else {
			$.messager.alert('Warning', '请选择一行', 'warning');
		}
	} else {
		$.messager.alert('Warning', '请选择一行', 'warning');
	}
}

/**
 * 隐藏时间赋值
 * @param srcTarget 源target
 * @param destTarget 目标target
 * @param required 是否是必须的
 * @param sec 是否显示秒
 */
function datetimebox_move(srcTarget, destTarget, required,sec) {
	srcTarget.datetimebox({
		required : required,
		showSeconds : sec,
		formatter : function(date) {
			if(date != null && date != ''){
				var y = date.getFullYear();
				var m = date.getMonth() + 1;
				var d = date.getDate();
				var h = date.getHours();
				var mm = date.getMinutes();
				var ss = date.getSeconds();
				destTarget.val(y + "/" + m + "/" + d + " " + h + ":" + mm + ":" + ss);
				return date.formatDate("yyyy-MM-dd hh:mm:ss");
			}else{
				destTarget.val('');
				return "";
			}
			
		}
	});
}

/**
 * 隐藏日期赋值
 * @param srcTarget 源target
 * @param destTarget 目标target
 * @param required 是否是必须的
 */
function datebox_move(srcTarget, destTarget, required) {
	srcTarget.datetimebox({
		required : required,
		formatter : function(date) {
			if(date != null && date != ''){
				var y = date.getFullYear();
				var m = date.getMonth() + 1;
				var d = date.getDate();
				destTarget.val(y + "/" + m + "/" + d + " 00:00");
				return date.formatDate("yyyy-MM-dd HH:mm:ss");
			}else{
				destTarget.val('');
				return "";
			}
		}
	});
}

/**
 * 时间format控件
 * @param format
 * @returns
 */
Date.prototype.formatDate = function(format) {
	var o = {
		"M+" : this.getMonth() + 1, // month
		"d+" : this.getDate(), // day
		"h+" : this.getHours(), // hour
		"m+" : this.getMinutes(), // minute
		"s+" : this.getSeconds(), // second
		"q+" : Math.floor((this.getMonth() + 3) / 3), // quarter
		"S" : this.getMilliseconds()// millisecond
	}
	if (/(y+)/.test(format)) {
		format = format.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	}
	for ( var k in o) {
		if (new RegExp("(" + k + ")").test(format))
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]
					: ("00" + o[k]).substr(("" + o[k]).length));
	}
	return format;
}

/**
 * 仓库、库区、库位参数校验
 * @param target
 * @param bean
 * @param required
 * @param width
 * @param height
 */
function checkWarehouseInitParam(name,val,valZH)
{
	var formData = $('#'+name+'_addForm').serialize();//序列化表单
	// 默认publicId和code同
	var start = formData.indexOf("code=")+5;
	var end = formData.indexOf("&");
	$('#publicId').val(formData.substring(start,end));
	$.ajax({
		url:postPath+'/'+name+'/checkInitParam',//请求url
		method:'post',
		data : formData + '&val=' + val,
		dataType : 'text',
		cache: false,
		success : function(data){
			if(data == "successed"){
				$('.msg').children().remove();//清除所有的消息提示div内容
				
			}else if(data == "defeated") {
				$('.msg').children().remove();//清除所有的消息提示div内容
				setTimeout(function(){
					$('#'+name+'_msg').html("<b style='padding-left:10px;color:red;'>"+"校验 "+valZH+" 出错,请重新输入 "+valZH+" </b>");
				},150);
			}else if(data == "exist") {
				$('.msg').children().remove();//清除所有的消息提示div内容
				setTimeout(function(){
					$('#'+name+'_msg').html("<b style='padding-left:10px;color:red;'>"+valZH+" 已存在,请重新输入 "+valZH+" </b>");
				},150);
			}
		}
	});
}

/**
 * 库区参数校验
 * @param target
 * @param bean
 * @param required
 * @param width
 * @param height
 */
function checkAreaInitParam(name)
{
	var formData = $('#'+name+'_addForm').serialize();//序列化表单
	$.ajax({
		url:postPath+'/'+name+'/checkInitParam',//请求url
		method:'post',
		data : formData,
		dataType : 'text',
		cache: false,
		success : function(data){
			if(data == "successed"){
				$('.msg').children().remove();//清除所有的消息提示div内容
				
			}else if(data == "defeated") {
				$('.msg').children().remove();//清除所有的消息提示div内容
				setTimeout(function(){
					$('#'+name+'_msg').html("<b style='padding-left:10px;color:red;'>校验库区编码出错,请重新输入库区编码 </b>");
				},150);
			}else if(data == "exist") {
				$('.msg').children().remove();//清除所有的消息提示div内容
				setTimeout(function(){
					$('#'+name+'_msg').html("<b style='padding-left:10px;color:red;'>库区编码已存在,请重新输入库区编码</b>");
				},150);
			}
			else if(data == "codeEmpty") {
				$('.msg').children().remove();//清除所有的消息提示div内容
				setTimeout(function(){
					$('#'+name+'_msg').html("<b style='padding-left:10px;color:red;'>请输入库区编码</b>");
				},150);
			}
			else if(data == "idEmpty") {
				$('.msg').children().remove();//清除所有的消息提示div内容
				setTimeout(function(){
					$('#'+name+'_msg').html("<b style='padding-left:10px;color:red;'>请选择所属仓库</b>");
				},150);
			}
			
		}
	});
}

/**
 * 库位参数校验
 * @param target
 * @param bean
 * @param required
 * @param width
 * @param height
 */
function checkLocationInitParam(name)
{
	var formData = $('#'+name+'_addForm').serialize();//序列化表单
	$.ajax({
		url:postPath+'/'+name+'/checkInitParam',//请求url
		method:'post',
		data : formData,
		dataType : 'text',
		cache: false,
		success : function(data){
			if(data == "successed"){
				$('.msg').children().remove();//清除所有的消息提示div内容
				
			}else if(data == "defeated") {
				$('.msg').children().remove();//清除所有的消息提示div内容
				setTimeout(function(){
					$('#'+name+'_msg').html("<b style='padding-left:10px;color:red;'>校验库位编码出错,请重新输入库位编码 </b>");
				},150);
			}else if(data == "exist") {
				$('.msg').children().remove();//清除所有的消息提示div内容
				setTimeout(function(){
					$('#'+name+'_msg').html("<b style='padding-left:10px;color:red;'>库区编码已存在,请重新输入库位编码</b>");
				},150);
			}
			else if(data == "codeEmpty") {
				$('.msg').children().remove();//清除所有的消息提示div内容
				setTimeout(function(){
					$('#'+name+'_msg').html("<b style='padding-left:10px;color:red;'>请输入库位编码</b>");
				},150);
			}
			else if(data == "idEmpty") {
				$('.msg').children().remove();//清除所有的消息提示div内容
				setTimeout(function(){
					$('#'+name+'_msg').html("<b style='padding-left:10px;color:red;'>请选择所属库区</b>");
				},150);
			}
			
		}
	});
}


/**
* 仓库保存功能按钮
* 适用于添加页面
* @param name: 添加表单id的前缀名
*/
function saveWarehouseData(name) {
	var vldate = $('#'+name+'_addForm').form('validate');//验证表单数据
	var formData = $('#'+name+'_addForm').serialize();//序列化表单
	if(vldate) {
		$.ajax({
			url:postPath+'/'+name+'/add',//请求url
			method:'post',
			data:formData,
			dataType : 'text',
			cache: false,
			success : function(data){
				if(data == "successed"){
					$("#"+name+"_tempDialog").dialog('close');
				}else if(data == "defeated") {
					$('.msg').children().remove();//清除所有的消息提示div内容
					setTimeout(function(){
						$('#'+name+'_msg').html("<b style='padding-left:10px;color:red;'>操作失败！</b>");
					},150);
				}
			}
		});
	} else {
		$('.msg').children().remove();//清除所有的消息提示div内容
		setTimeout(function(){
			$('#'+name+'_msg').html("<b style='padding-left:10px;color:red;'>表单信息填写不完整，带*为必填项！</b>");
		},150);
	}
}

/**
 *  格式化显示当前时间
 * @param target jq对象
 * @date   2014年11月20日 下午2:09:56
 */
function format_current_time(target) {
	target.val(new Date().format("yyyy-MM-dd hh:mm"));
}

/**
 *  格式化时间赋值(修改页面)
 */
function edit_time(target){
	var targetVal = target.val();
	if("" != targetVal){
		var date = new Date(targetVal);
		date.setDate(date.getDate()-1);
		date.setHours(date.getHours()+10, date.getMinutes(), date.getSeconds(), 0);
		target.val(date.format("yyyy-MM-dd hh:mm:ss"));
	}
}
