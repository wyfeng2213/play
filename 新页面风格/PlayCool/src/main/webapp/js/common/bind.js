//查找按钮
function queryBy(name,srchForm){
	var form = $("#"+srchForm);
	$("#"+name).datagrid('load',sy.serialieObject(form));
} 
//点击清空按钮触发事件		
function cleanQuery(name) {
	$("#"+name).form('reset');
	//$(".timeInput").parent().children(".combo").children(".combo-value").val('');
	//document.getElementById("srchForm").reset(); 					
};

var tabsObj = parent.$("#tabs");//获取父页面tabs对象
//关闭当前tabs
function previousPage() {
	var curTabIndex = tabsObj.tabs('getTabIndex',tabsObj.tabs('getSelected'));//得到当前tabs索引
	tabsObj.tabs('close',curTabIndex);//关闭当前tabs
	//tabsObj.tabs('select','用户管理');//返回list页面
}


//添加或删除绑定
function addAndDelete(bind,url,sourceId,tab1,tab2){
	var selectedRows1 = $("#"+tab1).datagrid('getChecked');
	if(selectedRows1.length < 1){
		$.messager.alert('提示','至少选择一项!','warning');
		return;
	}
	var userRoles = new Object();
	var id = $("#"+sourceId).val();
	var ids = new Array();
	if(bind == 'bindUser'){
		userRoles.roleId = id;
		for(var i = 0;i < selectedRows1.length;i++){
			var userId = selectedRows1[i].id;
			ids.push(userId);
		}
		userRoles.userIds = ids;
	}else if(bind == 'bindRole'){
		userRoles.userId = id;
		for(var i = 0;i < selectedRows1.length;i++){
			var roleId = selectedRows1[i].id;
			ids.push(roleId);
		}
		userRoles.roleIds = ids;
	}
	$.ajax({
		url :url,
		type : 'post',
		data : JSON.stringify(userRoles),
		contentType : "application/json; charset=utf-8",
		success : function(data){
			if(data == "successed"){
					$('#srchForm1').form('reset');
					$('#srchForm2').form('reset');
				if(url.indexOf('delete') == -1){
					$('#'+tab2).datagrid('load',sy.serialieObject(srchForm1));
					$('#'+tab1).datagrid('load',sy.serialieObject(srchForm2));
				}else{
					$('#'+tab2).datagrid('load',sy.serialieObject(srchForm2));
					$('#'+tab1).datagrid('load',sy.serialieObject(srchForm1));
				}
				$('#'+tab1).datagrid('unselectAll');
				$('#'+tab2).datagrid('unselectAll');
			}else{
				$.messager.alert("提示", "<font color='red'>操作失败!</font>","info");
			}
		}
	});
}
	