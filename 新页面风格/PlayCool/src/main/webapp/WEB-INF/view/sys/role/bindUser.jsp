<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
/* 已绑定用户右键菜单逻辑 */
function bindUser_rightMenuFun(){
	var selections = $("#bindUser").datagrid('getSelections');
	if(selections.length > 0) {
		$("#bindUser_menu").menu('enableItem', $('#bindUser_deleteItem'));
	} else {
		$("#bindUser_menu").menu('disableItem', $('#bindUser_deleteItem'));
	}
};

/* 未绑定用户右键菜单逻辑 */
function bindUser2_rightMenuFun(){
	var selections = $("#bindUser2").datagrid('getSelections');
	if(selections.length > 0) {
		$("#bindUser2_menu").menu('enableItem', $('#bindUser2_addItem'));
	} else {
		$("#bindUser2_menu").menu('disableItem', $('#bindUser2_addItem'));
	}
};


$(function() {
	sy.createDatagrid($("#bindUser"),$("#bindUser_srchForm"),bindUser_rightMenuFun,true,10);
	sy.createDatagrid($("#bindUser2"),$("#bindUser2_srchForm"),bindUser2_rightMenuFun,true, 10);
});

var panelWidth = $("#role_tempDialog").width()/2;
var panelHeight = $("#role_tempDialog").height()-24-20;

$(".bindUser_datagrid").width(panelWidth);
$(".bindUser_datagrid").height(panelHeight);

//保存选择的用户
function saveBindUser(){
	var userRoles = new Array();
	var roleId = $("#roleId").val();
	var selections = $("#bindUser2").datagrid('getSelections');
	
	for(var i = 0;i < selections.length;i++){
		var userRole = new Object();
		userRole.roleId = roleId;
		userRole.userId = selections[i].id;
		userRoles.push(userRole);
	}
	saveBindUserRequest(userRoles);
}

function saveBindUserRequest(userRoles){
	if(userRoles.length > 0) {
		$.ajax({
			url : 'saveBindUser',
			type : 'POST',
			data : JSON.stringify(userRoles),
			contentType : "application/json; charset=UTF-8",
			dataType : 'json',
			success : function(data){
				refreshDatagrid("bindUser", true);
				refreshDatagrid("bindUser2", true);
				msgObj.ajaxResponseMsg($('#bindUser_msg'), data);
			}
		});
	} else {
		$.messager.alert("请选择要绑定的用户！");
	}
}

//删除已绑定的用户
function deleteBindUser() {
	var roleId = $("#roleId").val();
	var selections = $("#bindUser").datagrid('getSelections');
	var ids = "";
	
	
		for(var i = 0;i < selections.length;i++){
			ids += selections[i].id + ",";
		}
		ids = ids.substring(0, ids.length-1);
		deleteUser(roleId,ids);
}

function deleteUser(roleId,ids){
	if(ids != "") {
		$.ajax({
			url : 'deleteBindUser',
			type : 'POST',
			data : {
				roleId : roleId,
				ids : ids
			},
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			dataType : 'json',
			success : function(data){
				refreshDatagrid("bindUser", true);
				refreshDatagrid("bindUser2", true);
				msgObj.ajaxResponseMsg($('#bindUser_msg'), data);
			}
		});
	} else {
		$.messager.alert("请选择要删除已绑定的用户！");
	}
}


$('#bindUser').datagrid({
	onDblClickRow : function (rowIndex,rowData){
		var roleId = $("#roleId").val();
		var ids = rowData.id;
		deleteUser(roleId,ids);
	}
});

$('#bindUser2').datagrid({
	onDblClickRow : function (rowIndex,rowData){
		var userRoles = new Array();
		var userRole = new Object();
		userRole.roleId = $("#roleId").val();
		userRole.userId = rowData.id;
		userRoles.push(userRole);
		saveBindUserRequest(userRoles);
	}
});
</script>
<div class="easyui-layout" style="width:100%;height:100%;border: 0;" >
	<!--当前角色  -->
	<div region = "north" align="left" border="false" style="height: 24px;">
		<input id="roleId" type="hidden" name="roleId" value="${roleId }"/>
		<table class="table_border" border="1" style="margin: 0px;padding: 0px;">
			<tr>
				<th class="title">当前角色</th>
				<td>
					<input type="text" value="${roleName }"/>
				</td>
			</tr>
		</table>
		<%-- <div id="ids">
			<c:forEach items="${userRoles }" var="u">
				<input type="hidden" value="${u.userId }"/>
			</c:forEach>
		</div> --%>
	</div>
	<!--主要内容 -->
	<div region="center" class="easyui-layout">
		<!-- 已绑定用户 -->
		<div region="west" class="easyui-layout bindUser_datagrid">
			<div>
				<form id="bindUser_srchForm" class="frmSearch" action="" autocomplete='off'>
					<input type="hidden" name="bean" value="user">
					<input type="hidden" name="method" value="page">
					<input type="hidden" name="type" value="in">
					<input type="hidden" name="roleId" value="${roleId }">
				</form>
			</div>
			<div region="center" title="已绑定用户" border="false">
				<table id="bindUser">
					<thead>   
				       <tr>  			        
						   <th id="id" data-options="field:'id',width:60,sortable:true" >ID</th>
						   <th data-options="field:'code',width:100,sortable:true">用户编号</th>
				           <th data-options="field:'name',width:100,sortable:true">用户名称</th>   			           
				       </tr>   
				   </thead>
				</table>
			</div>
		</div>
		
		<!-- 未绑定用户 -->
		<div region="center" class="easyui-layout bindUser_datagrid">
			<div>
				<form id="bindUser2_srchForm" class="frmSearch" action="" autocomplete='off'>
					<input type="hidden" name="bean" value="user">
					<input type="hidden" name="method" value="page">
					<input type="hidden" name="type" value="out">
					<input type="hidden" name="roleId" value="${roleId }">
				</form>
			</div>
			<div region="center" title="未绑定用户" border="false">
				<table id="bindUser2">
					<thead>   
				       <tr>  			        
						   <th id="id" data-options="field:'id',width:60,sortable:true" >ID</th>
						   <th data-options="field:'code',width:100,sortable:true">用户编号</th>
				           <th data-options="field:'name',width:100,sortable:true">用户名称</th>   			           
				       </tr>   
				   </thead>
				</table>
			</div>
		</div>
	</div>
	
	<!--已绑定用户右键菜单div-->
	<div id="bindUser_menu" class="easyui-menu">
		<div id="bindUser_deleteItem" onclick="deleteBindUser();">删除</div>
	</div>
	
	<!--未绑定用户右键菜单div-->
	<div id="bindUser2_menu" class="easyui-menu">
		<div id="bindUser2_addItem" onclick="saveBindUser();">添加</div>
	</div>
	
	<!-- 提示信息 -->
	<div region="south" style="height:20px;">
		<div id="bindUser_msg" class="msg" style="width:100%;height:20px;position:absolute;bottom:0;background-color:#E9F4F7;">
		</div>
	</div>
</div>