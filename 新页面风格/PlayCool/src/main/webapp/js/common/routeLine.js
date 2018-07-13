//格式化途径点
function format_address(value, row, index) {
	if (row.wayPoint != null && row.wayPoint.address != null) {
		return row.wayPoint.address;
	} else {
		return "-";
	}
}

/**
 *  明细列表的右键菜单生效失效逻辑
 * @param 
 * @date   2014年11月10日 下午3:56:45
 */
function bisRouteLineDetail_rightMenuFun(name) {
	var menuTarget = $("#"+name+"_menu");
	var selections = $("#"+name).datagrid('getSelections');
	var routeLineId = $('#bisRouteLineId').val();
	if(routeLineId != null && routeLineId != ''){
		if (selections.length == 1 ) {
			menuTarget.menu('enableItem', $('#'+name+'_add'));
			menuTarget.menu('enableItem', $('#'+name+'_delete'));
		} else if(selections.length > 1){
			menuTarget.menu('enableItem', $('#'+name+'_add'));
			menuTarget.menu('enableItem', $('#'+name+'_delete'));
		} else {
			menuTarget.menu('enableItem', $('#'+name+'_add'));
			menuTarget.menu('disableItem', $('#'+name+'_delete'));
		}
	}else{
		menuTarget.menu('disableItem', $('#'+name+'_add'));
		menuTarget.menu('disableItem', $('#'+name+'_delete'));
	}
}

//新建路线信息
function saveBisRouteLine(name){
	var vldate = $('#'+name+'_addForm').form('validate');//验证表单数据
	var formData = $('#'+name+'_addForm').serialize();//序列化表单
	if(vldate) {
		$.ajax({
			url:postPath+'/'+name+'/add',//请求url
			method:'post',
			data:formData,
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : 'json',
			success : function(data){
				if(data.additionalMsg.status == "成功"){
					$("#bisRouteLineId").val(data.bisRouteLineId);
					
					//保存按钮变为修改按钮
					$("#saveButton").children().remove();
					$('#saveButton').html("<div style='margin:10px;'><a href='javascript:void(0)' class='easyui-linkbutton l-btn' " +
							"onclick='saveAfterEdit();'><span class='l-btn-left'><span class='l-btn-text'>修改</span></span></a></div>");
				}
				msgObj.ajaxResponseMsg($('#'+name+'_msg'), data);
			}
		});
	} else {
		msgObj.validateFailMsg($('#'+name+'_msg'));
	}
}

//新增路线信息详情
function addRouteLineDetail(name,title,width,height) {
	var url = postPath+'/'+name+'/add/';
	url += $("#bisRouteLineId").val();
	$("<div id='"+name+"_tempDialog'></div>").appendTo('body');//将临时dialog容器添加到body中
	var target = $("#"+name+"_tempDialog");
	target.dialog({    
		title: title,    
		width: width,    
		height: height,
		closed: true,
		cache: false,    
		modal: true,
		onClose: function() {
			target.remove();
			refreshDatagrid(name);//关闭刷新父页面，该函数在listUtil.jsp
		},
		onOpen:function() {
			target.dialog('refresh',url);
		}
	});
	target.dialog('open');
	msgObj.clearMsg($('.msg'));//清除所有的消息提示div内容
}

//删除途径点
function deleteRouteLineDetail(name){
	var selections = $("#"+name).datagrid('getSelections');
	var routeLineId = $("#bisRouteLineId").val();
	if(selections.length > 0){
		var ids = "";
		//取得所有选中行id
		for(var i = 0;i < selections.length;i++) {
			ids += selections[i].id + ","; 
		}
		ids = ids.substring(0, ids.length-1);
		$.ajax({
			url : postPath+'/'+name+'/delete',//请求url
			method : 'POST',
			data : {
				routeLineId : routeLineId,
				ids : ids 
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : 'json',
			success : function(data){
				if(data.additionalMsg.status == "成功"){
					refreshDatagrid(name);
				}
				msgObj.ajaxResponseMsg($('#bisRouteLine_msg'), data);
			}
		});
	}else{
		$.messager.alert("提示", "请选择要修改的记录！","info");
	}
}