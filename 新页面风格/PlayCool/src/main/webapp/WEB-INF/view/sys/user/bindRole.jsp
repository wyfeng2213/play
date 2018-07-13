<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
/* 已绑定角色右键菜单逻辑 */
function bindRole_rightMenuFun(){
	var selections = $("#bindRole").datagrid('getSelections');
	if(selections.length > 0) {
		$("#bindRole_menu").menu('enableItem', $('#bindRole_deleteItem'));
	} else {
		$("#bindRole_menu").menu('disableItem', $('#bindRole_deleteItem'));
	}
};

/* 未绑定角色右键菜单逻辑 */
function bindRole2_rightMenuFun(){
	var selections = $("#bindRole2").datagrid('getSelections');
	if(selections.length > 0) {
		$("#bindRole2_menu").menu('enableItem', $('#bindRole2_addItem'));
	} else {
		$("#bindRole2_menu").menu('disableItem', $('#bindRole2_addItem'));
	}
};

$(function() {
	sy.createDatagrid($("#bindRole"),$("#bindRole_srchForm"),bindRole_rightMenuFun, true, 10);
	sy.createDatagrid($("#bindRole2"),$("#bindRole2_srchForm"),bindRole2_rightMenuFun, true, 10);
});

var panelWidth = $("#user_tempDialog").width()/2;
var panelHeight = $("#user_tempDialog").height()-24-20;

$(".bindRole_datagrid").width(panelWidth);
$(".bindRole_datagrid").height(panelHeight);

//添加角色
function saveBindRole(){
	var userRoles = new Array();
	var userId = $("#userId").val();
	var selections = $("#bindRole2").datagrid('getSelections');
	
	for(var i = 0;i < selections.length;i++){
		var userRole = new Object();
		userRole.userId = userId;
		userRole.roleId = selections[i].id;
		userRoles.push(userRole);
	}
	saveBindRoleRequest(userRoles);
}


function saveBindRoleRequest(userRoles){
	if(userRoles.length > 0) {
		$.ajax({
			url : 'saveBindRole',
			type : 'POST',
			data : JSON.stringify(userRoles),
			contentType : "application/json; charset=UTF-8",
			dataType : 'json',
			success : function(data){
				refreshDatagrid("bindRole", true);
				refreshDatagrid("bindRole2", true);
				msgObj.ajaxResponseMsg($('#bindRole_msg'), data);
			}
		});	
	} else {
		$.messager.alert("请选择要添加的角色！");
	}
}

//删除角色
function deleteBindRole() {
	var userId = $("#userId").val();
	var selections = $("#bindRole").datagrid('getSelections');
	var ids = "";
	for(var i = 0;i < selections.length;i++){
		ids += selections[i].id + ",";
	}
	ids = ids.substring(0, ids.length-1);
	deleteRole(userId,ids);
}

function deleteRole(userId,ids){
	if(ids != "") {
		$.ajax({
			url : 'deleteBindRole',
			type : 'POST',
			data : {
				userId : userId,
				ids : ids
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : 'json',
			success : function(data){
				refreshDatagrid("bindRole", true);
				refreshDatagrid("bindRole2", true);
				msgObj.ajaxResponseMsg($('#bindRole_msg'), data);
			}
		});
	} else {
		$.messager.alert("请选择要删除的角色！");
	}
}

$('#bindRole').datagrid({
	onDblClickRow : function (rowIndex,rowData){
		var userId = $("#userId").val();
		var ids = rowData.id;
		deleteRole(userId,ids);
	}
});

$('#bindRole2').datagrid({
	onDblClickRow : function (rowIndex,rowData){
		var userRoles = new Array();
		var userRole = new Object();
		userRole.userId = $("#userId").val();
		userRole.roleId= rowData.id;
		userRoles.push(userRole);
		saveBindRoleRequest(userRoles);
	}
});
</script>

<div class="easyui-layout" style="width:100%;height:100%;border: 0;magin:0;padding:0;">
	<!--当前用户  -->
	<div region = "north" align="left" border="false" style="height: 24px;">
		<input id="userId" type="hidden" name="userId" value="${userId }"/>
		<table class="table_border" border="1" style="margin: 0px;padding: 0px;">
			<tr>
				<th class="title">当前用户</th>
				<td>
					<input type="text" value="${userName }"/>
				</td>
			</tr>
		</table>
		<%-- <div id="ids">
			<c:forEach items="${userRoles }" var="u">
				<input type="hidden" value="${u.roleId }"/>
			</c:forEach>
		</div> --%>
	</div>
	
	<!--主要内容  -->
	<div region="center" class="easyui-layout">
		<!-- 已添加角色 -->
		<div region="west" class="easyui-layout bindRole_datagrid">
			<!-- 角色查询 -->
			<div>
				<form id="bindRole_srchForm" class="frmSearch" action="" autocomplete='off'>
					<input type="hidden" name="bean" value="role">
					<input type="hidden" name="method" value="page">
					<input type="hidden" name="type" value="in"/>
					<input type="hidden" name="userId" value="${userId }"/>
				</form>
			</div>
			<!--角色列表  -->
			<div region="center" title="已绑定角色" border="false">
				<table id="bindRole">
					<thead>   
				       <tr>  			        
						   <th id="id" data-options="field:'id',width:60,sortable:true" >ID</th>
						   <th data-options="field:'code',width:100,sortable:true">角色编号</th>
				           <th data-options="field:'name',width:100,sortable:true">角色名称</th>   			           
				       </tr>   
				   </thead>
				</table>
			</div>
		</div>
		
		<!-- 未添加的角色 -->
		<div region="center" class="easyui-layout bindRole_datagrid">
			<!-- 角色查询 -->
			<div>
				<form id="bindRole2_srchForm" class="frmSearch" action="" autocomplete='off'>
					<input type="hidden" name="bean" value="role">
					<input type="hidden" name="method" value="page">
					<input type="hidden" name="type" value="out"/>
					<input type="hidden" name="userId" value="${userId }"/>
				</form>
			</div>
			<!--角色列表  -->
			<div region="center" title="未绑定角色" border="false">
				<table id="bindRole2">
					<thead>   
				       <tr>  			        
						   <th id="id" data-options="field:'id',width:60,sortable:true" >ID</th>
						   <th data-options="field:'code',width:100,sortable:true">角色编号</th>
				           <th data-options="field:'name',width:100,sortable:true">角色名称</th>   			           
				       </tr>   
				   </thead>
				</table>
			</div>
		</div>
	</div>
	
	<!--已绑定角色右键菜单div-->
	<div id="bindRole_menu" class="easyui-menu">
		<div id="bindRole_deleteItem" onclick="deleteBindRole();">删除</div>
	</div>
	
	<!--未绑定角色右键菜单div-->
	<div id="bindRole2_menu" class="easyui-menu">
		<div id="bindRole2_addItem" onclick="saveBindRole();">添加</div>
	</div>
	
	<!-- 提示信息 -->
	<div region="south" style="height:20px;">
		<div id="bindRole_msg" class="msg" style="width:100%;height:20px;position:absolute;bottom:0;background-color:#E9F4F7;">
		</div>
	</div>
</div>
