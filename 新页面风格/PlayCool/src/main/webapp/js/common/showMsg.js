/**
 * 消息提示 公用js
 * 
 * @author jing.huang
 * 
 * 2014-08-27
 */

var msgObj = $.extend({}, msgObj);/* 定义全局对象 */

/**
 * 清空消息
 * 
 * @param target
 *            {Object} :消息显示区域 jq对象
 * @author jing.huang
 */
msgObj.clearMsg = function(target) {
	target.children().remove();
};

/**
 * 隔段时间后 清空消息
 * 
 * @param target
 *            {Object} :消息显示区域 jq对象
 * @param timeout
 *            number :间隔时间（单位：毫秒）
 * @author jing.huang
 */
msgObj.timeoutClearMsg = function(target, timeout) {
	setTimeout(function() {
		msgObj.clearMsg(target);
	}, timeout);
};

/**
 * 清空所有消息
 * 
 * @author jing.huang
 */
msgObj.clearAllMsg = function() {
	msgObj.clearMsg($(".msg"));
	msgObj.clearMsg(parent.$(".msg"));
};

/**
 * 显示消息详情
 * 
 * @author jing.huang
 */
msgObj.showMsgDetail = function(targetId) {
	var target = $("#"+targetId);
	var msg = target.text();
	$.messager.alert('消息详情',msg);
};
/**
 * 消息提示 统一创建方式
 * 
 * @param target
 *            {Object} :消息显示区域 jq对象
 * @param msg
 *            {Object} 消息内容
 * @author jing.huang
 * 
 */
msgObj.showMsgService = function(target, msg) {
	var targetId = target.attr('id');
	var msgDetail = "<span style='float: right;width:20px;margin-right:5px;'><input type='button' value='>>' onclick='msgObj.showMsgDetail(\""+targetId+"\");' style='border: 0;padding:0;color: #0000FF;background-color: #E9F4F7;'/>&nbsp;</span>&nbsp;&nbsp;";
	var targetWidth = target.width()-30;
	msg = "<div style='float: left;white-space: nowrap;text-overflow: ellipsis;overflow: hidden;width:"+targetWidth+"px;'>"+msg+"</div>";
	msgObj.clearMsg(target);// 先清除
	setTimeout(function() {
		target.html(msg+msgDetail);// 后写
		if("top-bar_msg" == targetId){
			target.children('span').css('margin-top','-3px');
		}
		target.children('span').children('input').mouseover(function(){
			$(this).css('cursor','pointer');
		});
	}, 150);
};

/**
 * 无效的选择(未选择行或选择多行) 消息提示
 * 
 * @param target
 *            {Object} :消息显示区域 jq对象
 * @author jing.huang
 */
msgObj.invalidSelectMsg = function(target) {
	var msg = "<b style='padding-left:5px;color:red;'>[请选择一行！]</b>";
	msgObj.showMsgService(target, msg);
};

/**
 * 表单验证未通过 消息提示
 * 
 * @param target
 *            {Object} :消息显示区域 jq对象
 * @author jing.huang
 */
msgObj.validateFailMsg = function(target) {
	var msg = "<b style='padding-left:5px;color:red;'>[表单信息填写有误，请按照提示正确填写！]</b>";
	msgObj.showMsgService(target, msg);
};

/**
 * 通过ajax方式与后台交互结果 消息提示
 * 
 * @param target
 *            {Object} :消息显示区域 jq对象
 * @param data
 *            {Object} : 返回的数据 json对象
 * @author jing.huang
 */
msgObj.ajaxResponseMsg = function(target, data) {
	var msg = "";
	if (data.additionalMsg.totalCount != null) {
		if (data.additionalMsg.status == "成功") {
			msg = "<b style='padding-left:5px;color:blue;'>[操作成功！总共{"
					+ data.additionalMsg.totalCount + "}条.耗时："
					+ data.additionalMsg.processTime + " 秒!]</b>";
			msgObj.showMsgService(target, msg);
		} else if (data.additionalMsg.status == "部分成功") {
			msg = "<b style='padding-left:5px;color:red;'>[部分成功！总共{"
					+ data.additionalMsg.totalCount + "}条.成功{"
					+ data.additionalMsg.successCount + "}条；失败{"
					+ data.additionalMsg.failCount + "}条；原因：{" 
					+ data.additionalMsg.message + "}]</b>";
			msgObj.showMsgService(target, msg);
		} else if (data.additionalMsg.status == "失败") {
			msg = "<b style='padding-left:5px;color:red;'>[操作失败！总共{"
					+ data.additionalMsg.totalCount + "}条.原因："
					+ data.additionalMsg.message + "]</b>";
			msgObj.showMsgService(target, msg);
		} else if (data.additionalMsg.status == "请求超时"){
			msg = "<b style='padding-left:5px;color:red;'>[请求超时！]</b>";
			msgObj.showMsgService(target, msg);
		}else{
			msg = "<b style='padding-left:5px;color:red;'>[系统错误！请联系管理员！]</b>";
			msgObj.showMsgService(target, msg);
		}
	} else {
		if (data.additionalMsg.status == "成功") {
			msg = "<b style='padding-left:5px;color:blue;'>[操作成功！耗时："
					+ data.additionalMsg.processTime + " 秒!]</b>";
			msgObj.showMsgService(target, msg);
		} else if (data.additionalMsg.status == "失败") {
			msg = "<b style='padding-left:5px;color:red;'>[操作失败！原因："
					+ data.additionalMsg.message + "]</b>";
			msgObj.showMsgService(target, msg);
		} else if (data.additionalMsg.status == "请求超时"){
			msg = "<b style='padding-left:5px;color:red;'>[请求超时！]</b>";
			msgObj.showMsgService(target, msg);
		}else{
			msg = "<b style='padding-left:5px;color:red;'>[系统错误！请联系管理员！]</b>";
			msgObj.showMsgService(target, msg);
		}
	}
};

/**
 * 通过ajax方式导入excel后与后台交互结果 消息提示
 * 
 * @param target
 *            {Object} :消息显示区域 jq对象
 * @param data
 *            {Object} : 返回的数据 json对象
 * @author yunlei.hua
 */
msgObj.showImportMsg = function(target, msg) {
	msg = eval("("+msg+")").additionalMsg.message;
	if (msg == null || msg == '' || msg == '""') {
		msg = "<b style='padding-left:5px;color:blue;'>[导入成功！]</b>";
	} else {
		msg = "<b style='padding-left:5px;color:red;'>"+msg+"</b>";
	}
	msgObj.showMsgService(target, msg);
};