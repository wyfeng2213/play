<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/WEB-INF/view/common/memory.jsp"></jsp:include>

<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/js/common/bind.js"></script> --%>
<script type="text/javascript">
	//右键菜单项生效失效逻辑代码，注：函数名必须为rightMenuFun()!!!
	var rightMenuFun = function() {
		var selections = $("#role").datagrid('getSelections');
		$("#role_menu").menu("disableItem", $("[id$='_do']"));
		if(selections.length == 1) {
			if(selections[0].enabled == true)  
				$("#role_menu").menu('enableItem', $('#role_edit_do'));
			$("#role_menu").menu('enableItem', $("[id$='_do']"));
			if(selections[0].enabled == false)  
				$("#role_menu").menu('disableItem', $('#role_edit_do'));
		} 
	};
	var srchForm , push_node = [] ;
	$(function() {
		//$('body').layout('collapse','north');
		srchForm = $("#role_srchForm");		
		sy.createDatagrid($("#role"),srchForm,rightMenuFun);
		Enter_query('role');
	});
	
	function getSelections() {
		return sy.getSelectionsIds($("#role"));
	}
	
	function quickQuery() {
		$("#quickQueryDialog").dialog('open');
	}
	
	function zTreeOnExpand(treeId, treeNode){
 		zTreeOnClick(null, treeId, treeNode);
 	};

	function zTreeOnCheck(event, treeId, treeNode){
		if(treeNode.isBtn == "true"){
			$.ajax({
				url : "${pageContext.request.contextPath}/menuButton/bindPageMenu",
				type : "POST",
				dataType : "JSON",
				data : {
					byId : treeNode.id,
					roleId : $("#roleId").val(),
					checked : treeNode.checked
				},
				success : function(data){ }
			})
		} 
	}
	
	// 绑定权限 
	function bindRolePermission(){
		var zTree = $.fn.zTree.getZTreeObj("permission");
		var nodes = zTree.getCheckedNodes(true);
		for (var i = 0; i < nodes.length; i++) {
			var node = nodes[i];
			if(node.isBtn != "true"){
				push_node.push(node.id);
			}
		}
		$.ajax({
			url : "${pageContext.request.contextPath}/role/bindRoleToPer",
			type : "POST",
			dataType : "JSON",
			data : {
				roleId : $("#roleId").val(),
				nodeIds : push_node.join(",")
			},
			success : function(data){ msgObj.ajaxResponseMsg($('#bindPermission_msg'), data); }
		})
	}
	
	function zTreeOnClick(event, treeId, treeNode){
 		var childrens = treeNode.children;
	 	var zTree = $.fn.zTree.getZTreeObj("permission");
		if(typeof treeNode.uri != "undefined" && treeNode.uri != ""){
 			if(typeof childrens == "undefined" && typeof treeNode.id != "undefined"){
 	 			$.ajax({
 	 				url : "${pageContext.request.contextPath}/menuButton/getMenusByPage",
 	 				type : "GET",
 	 				dataType : "JSON",
 	 				data : {
 	 					roleId : $("#roleId").val(),
 	 					pageId : treeNode.id
 	 				},
 	 				success : function(data){
 	 					console.log(data);
 	 					zTree.addNodes(treeNode, data);
 	 				}
 	 			})
 	 		}
 		}
 		zTree.expandNode(treeNode);
 	}
</script>

</head>
<body class="easyui-layout" style="width:100%;height:100%;background-color: #eee;"
	onkeydown="javascript:keyPressImpl(event,'role');" onkeyup="javascript:keyReleaseImpl(event,'role');">
	<!-- 查询表单 -->
	<div id="role_srchDiv" class="easyui-dialog" closed="true" title="查找" style="width:590px;height:200px;">
			<form id="role_srchForm" class="frmSearch" action="" autocomplete='off'>
				<input type="hidden" name="bean" value="role">
				<input type="hidden" name="method" value="page">
				<table class="tableForm"  border="0" align="center" style="width : 500px;">
					<tr>							
						<th>角色编号</th> 
						<td><input name="code"/></td>
						<th>角色名称</th>
						<td><input name="name"/></td>	
					</tr>
					<tr>
						<th>状态</th>
						<td>
							<select name="enabled" style="width:162px;padding-left:15px;">
								<option value="" selected="selected">&nbsp;&nbsp;&nbsp;--请选择--</option>
								<option value="1">有效</option>								
								<option value="0">无效</option>
							</select>
						</td>
					</tr>
					<tr>
						<td colspan="6" align="center">
							<a href="javascript:void(0)" class="easyui-linkbutton"onclick="tj_query('role')">查询</a>&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"onclick="sy.cleanSearch('role')">重置</a>
						</td>
					</tr>					
				</table>
			</form>
		</div>		  		
				
		<div region="center" style="width:100%;height: 100%;border:0;">
			<table id="role" style="text-align:center;">
				<thead>   
			       <tr>  			        
					   <th data-options="field:'id',width:100,sortable : true,hidden:true">ID</th>
					   <th data-options="field:'code',width:150,sortable : true">角色编号</th>
			           <th data-options="field:'name',width:150,sortable : true">角色名称</th>   
			           <th data-options="field:'description',width:150,sortable : true">备注</th>
			           <th data-options="field:'enabled',width:120,sortable : true" formatter = 'format_enabled'>状态</th>
			       </tr>   
			   </thead>
			</table>
		</div>
		
		
		<div id="showDialog" class="easyui-dialog" shadow="false" modal="true" closed="true" buttons="#dlg-buttons" title="角色管理" style="width:500px; height:450px;">
			<iframe scrolling="no" id='openReceiveFeedBack' name="openReceiveFeedBack" frameborder="0" src="" style="width: 100%; height: 98%;"></iframe>
		</div>	
		
		<div id="limitDialog" class="easyui-dialog" closed="true" title="导出" style="width: 350px; height: 200px;">
			<iframe scrolling="no" frameborder="0" src="limitRecords" style="width: 100%; height: 98%;"></iframe>
		</div>
		
		<div id="quickQueryDialog" class="easyui-dialog" closed="true" title="快速查找" style="width: 350px; height: 200px;">
			<iframe scrolling="no" frameborder="0" src="quickQuery" style="width: 100%; height: 98%;">
			</iframe>
		</div>

	<!--右键菜单div-->
	<div id="role_menu" class="easyui-menu" style="width: 120px;"> 
		<div onclick="tj_query('role');">刷新</div>
		<div onclick="querryAll('role');">全部查找</div>
		<div onclick="simpleSearch('role');">条件查找</div>
		<div class="menu-sep"></div>
		<div class="addItem" data-options="name:'add'" onclick="addFun('role','新建角色',370,220);">新建</div>
		<div  id="role_edit" onclick="editFun('role','编辑角色',370,220);">编辑</div>
		<div class="menu-sep"></div>
		<div id="role_bindUser" onclick="bindUser('role', '绑定用户', 1000, 450);">绑定用户 </div>
		<div id="role_bindPermission" onclick="bindPermission('role', '绑定权限', 400, 400)">绑定权限 </div>
	</div>
</body>
</html>
