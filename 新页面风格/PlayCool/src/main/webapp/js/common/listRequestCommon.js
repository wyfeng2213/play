/**
 * 单行请求公用js
 */
var requestCommonObj = $.extend({}, requestCommonObj);

/**
 * 处理结果显示在当前页面 （单行）
 * @param tableId 列表页面datagrid table的ID名
 * @param url 请求url
 * @param requestData 请求参数
 * @param msgTarget 消息提示元素(不定义默认为{parent.$(".msg")})
 */
requestCommonObj.singleRequest = function(tableId,url,requestData,msgTarget,onSuccessFun){
	var realMsgTarget = parent.$(".msg");
	if("undefined" != typeof msgTarget){
		realMsgTarget = msgTarget;
	}
	var selections = $("#"+tableId).datagrid('getSelections');
	if(selections.length == 1) {
           $.ajax({
           	url:url,
           	method:'post',
           	data:requestData,
           	dataType:'json',
           	success:function(data) {
           		if(data.additionalMsg.status == "成功"){
           			refreshDatagrid(tableId);
           			if("undefined" != typeof onSuccessFun){
           				onSuccessFun();
           			}
   				}
           		msgObj.ajaxResponseMsg(realMsgTarget, data);
           	}
           });
	}else{
		msgObj.invalidSelectMsg(realMsgTarget);
	}
};

/**
 * 处理结果显示在当前页面 （多行行）
 * @param tableId 列表页面datagrid table的ID名
 * @param url 请求url
 * @param requestData 请求参数
 * @param msgTarget 消息提示元素(不定义默认为{parent.$(".msg")})
 */
requestCommonObj.multiRequest = function(tableId,url,requestData,msgTarget,onSuccessFun){
	var realMsgTarget = parent.$(".msg");
	if("undefined" != typeof msgTarget){
		realMsgTarget = msgTarget;
	}
	var selections = $("#"+tableId).datagrid('getSelections');
	if(selections.length > 0) {
		$.ajax({
			url:url,
			method:'post',
			data:requestData,
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : 'json',
			success : function(data){
				if(data.additionalMsg.status == "成功"){
           			refreshDatagrid(tableId,true);
           			if("undefined" != typeof onSuccessFun){
           				onSuccessFun();
           			}
   				}
				msgObj.ajaxResponseMsg(realMsgTarget, data);
			}
		});
	}else {
		msgObj.showMsgService(realMsgTarget, "<b style='padding-left:5px;color:red;'>[至少选择一行！]</b>");
	}
};

/**
 * 跳转到另一页面
 * @param tableId 列表页面datagrid table的ID名
 * @param uri 请求uri
 * @param title 打开窗口的标题
 * @param isMax 是否最大化打开窗口
 * @param width 打开窗口的宽度
 * @param height 打开窗口的高度
 */
requestCommonObj.skipPage = function(tableId,uri,title,isMax,width,height) {
	var selections = $("#"+tableId).datagrid('getSelections');
	if(selections.length == 1) {
           var url = postPath+'/'+tableId+'/'+uri+'/'+selections[0].id;
           openDialog(tableId,url,title,isMax,width,height);
	}else{
		msgObj.invalidSelectMsg(parent.$(".msg"));
	}
};

/**
 * 跳转到另一页面
 * @param tableId 列表页面datagrid table的ID名
 * @param uri 请求url
 * @param title 打开窗口的标题
 * @param isMax 是否最大化打开窗口
 * @param width 打开窗口的宽度
 * @param height 打开窗口的高度
 */
requestCommonObj.skipPageByUrl = function(tableId,uri,title,isMax,width,height) {
	var selections = $("#"+tableId).datagrid('getSelections');
	if(selections.length == 1) {
		   var url = postPath+'/'+uri+'/'+selections[0].id;
           openDialog(tableId,url,title,isMax,width,height);
	}else{
		msgObj.invalidSelectMsg(parent.$(".msg"));
	}
};

/**
 * 跳转到另一页面
 * @param tableId 列表页面datagrid table的ID名
 * @param uri 请求url
 * @param title 打开窗口的标题
 * @param isMax 是否最大化打开窗口
 * @param width 打开窗口的宽度
 * @param height 打开窗口的高度
 */
requestCommonObj.skipPageByUrlForTmsSegment = function(type,uri,title,isMax,width,height) {
	var selections = $("#"+type).datagrid('getSelections');
	if(selections.length == 1) {
		   var url = postPath+'/'+uri+'/'+selections[0].id + "/" + type;
           openDialog(type,url,title,isMax,width,height);
	}else{
		msgObj.invalidSelectMsg(parent.$(".msg"));
	}
};