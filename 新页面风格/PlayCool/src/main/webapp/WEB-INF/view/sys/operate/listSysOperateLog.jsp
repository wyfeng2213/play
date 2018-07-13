<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<style>
		.datagrid .panel-body{position:static !important;}
		.layout-body{position: relative;}
		.pagination{position: absolute;width: 100%;bottom: 0;}
	</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="/WEB-INF/view/common/memory.jsp"></jsp:include>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common/sys/format_sysOperateLog.js"></script>
<script type="text/javascript">
	var srchForm;
	var rMenu = function() {
		rightMenuFun();
	};
	$(function() {
		sy.createDatagrid($("#sysOperateLog"), $("#sysOperateLog_srchForm"),
				rMenu);
		Enter_query('sysOperateLog');
	});
	/* 右键菜单项显示逻辑 */
	var rightMenuFun = function() {
		var menuTarget = $("#sysOperateLog_menu");
		var selections = $("#sysOperateLog").datagrid('getSelections');
	};
	
</script>
</head>
<body class="easyui-layout" style="width: 100%; height: 100%;"
	onkeydown="javascript:keyPressImpl(event,'sysOperateLog');"
	onkeyup="javascript:keyReleaseImpl(event,'sysOperateLog');">
	
	<!-- 数据表格 -->
	<div region="center" style="width: 100%; height: 100%; border: 0;">
		<!-- 查询表单 -->
	<div class="condition-search">
		<div id="sysOperateLog_srchDiv">
			<form id="sysOperateLog_srchForm" class="frmSearch" action=""
				autocomplete='off'>
				<input type="hidden" name="bean" value="sysOperateLog"> 
				<input type="hidden" name="method" value="page">
				<table class="tableForm" align="center" width="980px">
					<tr>
						<th>客户编码</th>
						<td><input type="text" name="USER_CODE" style="width: 140px;"/></td>
						<th>客户名称</th>
						<td><input type="text" name="USER_NAME" style="width: 145px;"/></td>
						<th>操作名称</th>
						<td><select name="OPERATE_CODE" style="width: 145px;">
								<option value="">&nbsp;&nbsp;&nbsp;--请选择--</option>
								<option value="LOGIN">登录</option>
								<option value="HUO_E_DAI_TO_APPLY">跳转货e贷申请页面</option>
								<option value="DAN_E_DAI_TO_APPLY">跳转单e贷申请页面</option>
								<option value="HUO_E_DAI">申请货e贷</option>
								<option value="DAN_E_DAI">申请单e贷</option>
						</select></td>
					</tr>
					<tr>
						<th>状态</th>
						<td><select name="STATUS" style="width: 145px;">
								<option value="">&nbsp;&nbsp;&nbsp;--请选择--</option>
								<option value="RIGHT">操作成功</option>
								<option value="WRONG">操作失败</option>
						</select></td>
						<th>操作起始时间</th>
						<td><input type="text" name="OPERATE_TIME_BEGIN" style="width: 145px;"
							class="easyui-datetimebox" /></td>
							<th>操作结束时间</th>
						<td><input type="text" name="OPERATE_TIME_END" style="width: 145px;"
							class="easyui-datetimebox" /></td>
					</tr>
					<tr>
						<td colspan="6" align="center" class="btnbox"><a href="javascript:void(0)"
							class="easyui-linkbutton" onclick="tj_query('sysOperateLog')">查询</a>
							<a href="javascript:void(0)" class="easyui-linkbutton"
							onclick="sy.cleanSearch('sysOperateLog')">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<!-- 查询表单end -->
		<table id="sysOperateLog">
			<thead>
				<tr>
					<th data-options="field:'id',width:80,sortable : true,hidden:true">ID</th>
					<th data-options="field:'USER_CODE',width:120,sortable : true">客户编码</th>
					<th data-options="field:'USER_NAME',width:230,sortable : true">客户名称</th>
					<th data-options="field:'OPERATE_CODE',width:150,sortable : true,hidden:true" >操作编码</th>
					<th data-options="field:'OPERATE_NAME',width:150,sortable : true">操作名称</th>
					<th data-options="field:'STATUS',width:100,sortable : true" formatter="format_status">状态</th>
					<th data-options="field:'OPERATE_INFO',width:180,sortable : true">详情</th>
					<th data-options="field:'OPERATE_TIME',width:130,sortable : true">操作时间</th>
				</tr>
			</thead>
		</table>
	</div>

	<div id="sysOperateLog_menu" class="easyui-menu">
		<div id="sysOperateLog_refreshItem"
			onclick="tj_query('sysOperateLog');">刷新</div>
		<div id="sysOperateLog_querryAllItem"
			onclick="realQuerryAll('sysOperateLog');">全部查询</div>
		<div id="sysOperateLog_tj_querryItem"
			onclick="simpleSearch('sysOperateLog');">条件查询</div>
	</div>
</body>
</html>