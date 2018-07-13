<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="/WEB-INF/view/common/memory.jsp"></jsp:include>


<script type="text/javascript">
	
	var rMenu = function() {
		bisCommon_rightMenuFun('deploy');
	};
	$(function() {
		sy.createDatagrid($("#deploy"), $("#deploy_srchForm"), rMenu);
		Enter_query('deploy');
		/* combogridCommon_only_post_status_id($('#_deployExperience_id'), true, true,
				$('#deployExperience'));  */
	});

	var rightMenuFun = function() {
		var menuTarget = $("#deploy_menu");
		var selections = $("#deploy").datagrid('getSelections');
		var num = selections.length;
		if (num == 1) {//选中1行
			menuTarget.menu('enableItem', $('#deploy_editItem'));
			menuTarget.menu('enableItem', $('#deploy_searchBelowItem'));
		} else {//未选中全部不能操作
			menuTarget.menu('disableItem', $('#deploy_editItem'));
			menuTarget.menu('disableItem', $('#deploy_searchBelowItem'));
		}
	};
	
	function addFunForDeploy(name,title,width,height,parentName) {
		//var url = postPath+'/'+name+'/add';
		var url = 'add';
		if("undefined" != typeof parentName){//如果parentName定义
			name = parentName;
		}
		openDialog(name,url,title,false,width,height);
	}
	
</script>

</head>
<body class="easyui-layout conditionjs" style="width: 100%; height: 100%;"
	onkeydown="javascript:keyPressImpl(event,'deploy');"
	onkeyup="javascript:keyReleaseImpl(event,'deploy');">
	
	<!-- 数据表格 -->
	<div region="center" style="width: 100%; height: 100%; border: 0;">
	<!-- 查询表单 -->
	<div class="condition-search">
		<div id="deploy_srchDiv">
			<form id="deploy_srchForm" class="frmSearch" action=""
				autocomplete='off'>
				<input type="hidden" name="bean" value="deploy"> <input
					type="hidden" name="method" value="page"> 
				<table class="tableForm" align="center" width="700px">
					<tr>
						<th>ID</th>
						<td><input style="width: 140px;" name="name"
							id="id" /></td>
							<th>流程名称</th>
						<td><input style="width: 100px;" name="_deployExperience_id"
							id="_deployExperience_id" /><input
						name="name" id="deployExperience" type="hidden" /></td>
							
							
						<td colspan="8" align="center" class="btnbox"><a href="javascript:void(0)"
							class="easyui-linkbutton" onclick="tj_query('deploy')">查询</a>
							
							<a href="javascript:void(0)" class="easyui-linkbutton"
							id="deploy_newItem" onclick="addFunForDeploy('deploy','新建信息',780,420);">新建</a>
						</td>
						</tr>
				</table>
			</form>
		</div>
	</div>
	<!-- 查询表单 end-->
		<table id="deploy">
			<thead>
				<tr>
					<th data-options="field:'id',width:80,sortable : true">ID</th>
					<th data-options="field:'name',width:200,sortable : true">流程名称</th>
					<th data-options="field:'deployTime',width:200,sortable : true">发布时间</th>
				</tr>

			</thead>
		</table>
	</div>

	<div id="deploy_menu" class="easyui-menu">
		<div id="deploy_refreshItem" onclick="tj_query('deploy');">刷新</div>
		<div id="deploy_querryAllItem" onclick="realQuerryAll('deploy');">全部查询</div>
<!-- 		<div id="deploy_tj_querryItem" onclick="simpleSearch('deploy');">条件查询</div>
 -->
		<div class="menu-sep"></div>
		<div id="deploy_newItem" onclick="addFunForDeploy('deploy','新建信息',780,420);">新建</div>
		<div id="deploy_editItem" onclick="editFun('deploy','修改信息',780,400);">修改</div>
		<div id="deploy_deleteItem" onclick="updateDelFlag('deploy','1');">删除</div>
		<div class="menu-sep"></div>
	</div>
</body>
</html>