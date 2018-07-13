<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/common/taglibs.jsp" %>
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
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/common/bis/sysWarning/format_bisSysWarning.js"></script>
<script type="text/javascript">
var rMenu = function(){bisCommon_rightMenuFun('bisSysWarning');};
$(function() {
	//combogridCommon_bis_customer($('#___customer_id'),false);
	sy.createDatagrid($("#bisSysWarning"),$("#bisSysWarning_srchForm"),rMenu);
	Enter_query('bisSysWarning');
});


var rightMenuFun = function() {
	var menuTarget = $("#bisSysWarning_menu");
	var selections = $("#bisSysWarning").datagrid('getSelections');
	var num = selections.length;
	
	if (num == 1) {//选中1行
		menuTarget.menu('enableItem',
				$('#bisSysWarning_editItem'));
	} else {//未选中或选择多行
		menuTarget.menu('disableItem',
				$('#bisSysWarning_editItem'));
	}
};
function format_type(value, row, index) {
	if (row.TYPE != null) {
		if (row.TYPE == 'EMAIL') {
			return "<span style='color:#A020F0;'>邮箱</span>";
		} else if(row.TYPE == 'SMS'){
			return "<span style='color:#EE4000'>短信</span>";
		}
	} else {
		return "-";
	}
}

function format_status(value, row, index) {
	if (row.STATUS != null) {
		if (row.STATUS == 'ENABLED') {
			return "<span style='color:green;'>生效</span>";
		} else if(row.STATUS == 'DISABLED'){
			return "<span style='color:#FF4040;'>失效</span>";
		}
	} else {
		return "-";
	}
}
</script>
</head>
<body class="easyui-layout" style="width:100%;height:100%;" 
		onkeydown="javascript:keyPressImpl(event,'bisSysWarning');" 
		onkeyup="javascript:keyReleaseImpl(event,'bisSysWarning');">
<!-- 数据表格 -->		
	<div region="center" style="width:100%;height: 100%;border:0;">
		<!-- 查询表单 -->
	 <div class="condition-search">
	 	<div id="bisSysWarning_srchDiv">
			<form id="bisSysWarning_srchForm" class="frmSearch" action="" autocomplete='off'>
				<input type="hidden" name="bean" value=bisSysWarning>
				<input type="hidden" name="method" value="page">
				<table class="tableForm"  align="center" width="980px">
						<tr> 
							<th>类型</th>
							<td>
								<select id="TYPE" name="TYPE"  style="width: 145px">
									<option value="" selected>&nbsp;&nbsp;--请选择--</option>
									<option value="EMAIL">邮箱</option>
									<option value="SMS">短信</option>
								</select>
							</td>
							<th	>号码</th>
							<td><input style="width: 140px;" name="CONTENT"/></td>
							<th	>业务类型</th>
							<td><input style="width: 140px;" name="BUSINESS_TYPE"/></td>
							<th>状态</th>
							<td><select name="STATUS" style="width:145px;">
									<option value="">&nbsp;&nbsp;--请选择--</option>
									<option value="ENABLED">生效</option>
									<option value="DISABLED">失效</option>
							</select></td>
						</tr>
						<tr>
							<td colspan="8" align="center" class="btnbox" style="text-align: center; height: 50px;">
							<a href="javascript:void(0)" class="easyui-linkbutton" onclick="tj_query('bisSysWarning')">查询</a>
							<a href="javascript:void(0)" class="easyui-linkbutton" onclick="sy.cleanSearch('bisSysWarning')">重置</a>
							<a href="javascript:void(0)" class="easyui-linkbutton greenbgbtn" id="bisSysWarning_createItem" onclick="addFun('bisSysWarning','新建银行卡信息',530,170);">新建</a>
							</td>
						</tr>
						
				</table>
			</form>
		</div>
	</div>
	<!-- 查询表单 end-->
		<table id="bisSysWarning">
			<thead>   
		       <tr>  
		           
	       	    <th data-options="field:'ID',width:80,sortable : true,hidden:true">id</th>	
	       	    <th data-options="field:'TYPE',width:80,sortable : true" formatter="format_type">类型</th>
	       	    <th data-options="field:'CONTENT',width:200,sortable : true">号码</th>
	       	    <th data-options="field:'BUSINESS_TYPE',width:380,sortable : true">业务类型</th>
	       	    <th data-options="field:'STATUS',width:80,sortable : true" formatter="format_status">状态</th>
	       	   
	       	    <th data-options="field:'DESCRIPTION',width:120,sortable : true"  >备注</th>
	<!-- 			<th data-options="field:'CREATOR',width:80,sortable : true">创建人员</th>
	            <th data-options="field:'CREATED_TIME',width:140,sortable : true">创建时间</th>
	           
	            <th data-options="field:'LAST_OPERATOR',width:100,sortable : true">最后修改人员</th>
	            <th data-options="field:'LAST_OPERATED_TIME',width:140,sortable : true">最后修改时间</th> -->
			   </tr>   
		   </thead>
		</table>
	</div>
		
	<div id="bisSysWarning_menu" class="easyui-menu">
		<div id="bisSysWarning_refreshItem" onclick="tj_query('bisSysWarning');">刷新</div>
		<div id="bisSysWarning_querryAllItem" onclick="realQuerryAll('bisSysWarning');">全部查询</div>
		<div id="bisSysWarning_tj_querryItem" onclick="simpleSearch('bisSysWarning');">条件查询</div>
		<div class="menu-sep"></div>	
		<div id="bisSysWarning_createItem" onclick="addFun('bisSysWarning','新建银行卡信息',530,170);">新建</div>
		<div id="bisSysWarning_editItem" onclick="editFun('bisSysWarning','编辑银行卡信息',530,170);">编辑</div>
		<div class="menu-sep"></div>
	    <div id="bisSysWarning_enabledItem" onclick="updateStatus('bisSysWarning','ENABLED');">生效</div>
		<div id="bisSysWarning_disabledItem" onclick="updateStatus('bisSysWarning','DISABLED');">失效</div>
	</div>
</body>
</html>