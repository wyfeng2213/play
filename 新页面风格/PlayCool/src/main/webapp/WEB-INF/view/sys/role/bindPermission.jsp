<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link href="${pageContext.request.contextPath}/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" />
<script src="../js/jquery.ztree.all-3.5.js" type="text/javascript"></script>
<script type="text/javascript">
 	var setting = {
		view : {
			dblClickExpand : false
		},
		data : {
			simpleData : {
				enable : true,
				idKey: "id",
				pIdKey: "pId",
				rootPId: 0
			}
		},
		check : {
			enable: true,
			chkStyle: "checkbox",
			autoCheckTrigger: true
		},
		callback : {
			onClick : zTreeOnClick,
			onExpand : zTreeOnExpand,
			onCheck: zTreeOnCheck
		}
	};
 
	$(function() {
		$.ajax({
			url : '${pageContext.request.contextPath}'+"/permission/getPermissions",
			async : false,
			type : 'POST',
			dataType : 'json',
			timeout : 60000,
			success : function(result) {
				var zNodes = result;
				$.fn.zTree.init($("#permission"), setting, zNodes);
				var treeObj = $.fn.zTree.getZTreeObj("permission");
				var ids = $("#ids input");
				for(var i = 0;i < ids.length;i++){
					var node = treeObj.getNodeByParam("id", ids[i].value, null);
					if(node != null){
						treeObj.checkNode(node);
					}
				}
			}
		});	
	});
	
	//绑定权限
	function saveBind(){
		var rolePermissions = new Array();
		var roleId = $("#roleId").val();
		var treeObj = $.fn.zTree.getZTreeObj("permission");
		var nodes = treeObj.getCheckedNodes(true);
		if(nodes.length < 1){
			/* $.messager.alert('提示','至少选择一个权限!','warning'); */
			$.ajax({
				url : 'deletePermissionByRoleId',
				type : 'POST',
				data : roleId,
				contentType : "application/json; charset=utf-8",
				dataType : 'json',
				success : function(data){
// 					if(data == "successed"){
// 						parent.showSuccessMsg();
// 					}else{
// 						parent.showFailedMsg();
// 					}	
				}
			});
			return;
		}
		for(var i = 0;i < nodes.length;i++){
			var rolePermission = new Object();
			rolePermission.roleId = roleId;
			rolePermission.permissionId = nodes[i].id;
			rolePermissions.push(rolePermission);
		}
		$.ajax({
			url : 'saveBindPermission',
			type : 'POST',
			data : JSON.stringify(rolePermissions),
			contentType : "application/json; charset=utf-8",
			dataType : 'json',
			success : function(data){
				msgObj.ajaxResponseMsg($('#bindPermission_msg'), data); 
// 				if(data == "successed"){
// 					parent.showSuccessMsg();
// 				}else{
// 					parent.showFailedMsg();
// 				}	
			}
		});
	}
	
	var tabsObj = parent.$("#tabs");//获取父页面tabs对象
	//关闭当前tabs
	function previousPage() {
		var curTabIndex = tabsObj.tabs('getTabIndex',tabsObj.tabs('getSelected'));//得到当前tabs索引
		tabsObj.tabs('close',curTabIndex);//关闭当前tabs
		//tabsObj.tabs('select','用户管理');//返回list页面
	}
</script>
<div class="easyui-layout" style="width:100%;height:100%;">
	<div class="easyui-layout" style="width:100%;height:85%;">
	
		<div align="left" region="north" style="height: 25px; text-align: center; line-height: 23px;">
			<span><strong>当前角色：${roleName }</strong></span>
			<input id="roleId" type="hidden" name="roleId" value="${roleId }"/>
			<div id="ids">
				<c:forEach items="${rolePermissions }" var="r">
					<input type="hidden" value="${r.permissionId }"/>
				</c:forEach>
			</div>
		</div>
		<div region = "center" border="false">
			<div style="magin:0;padding:0;" align="center" >
				<div style="height:280px;width:98%;border:0;">
					<ul id="permission" class="ztree"></ul>
				</div>
			</div>
		</div>
	</div>
	
	<div region="south" style="height:50px;">
		<input type="button" onclick="saveBind();" style="width: 100%;" value="保存">
		<div id="bindPermission_msg" class="msg" style="width:100%;height:20px;position:absolute;bottom:0;background-color:#E9F4F7;"></div>
	</div>
</div>