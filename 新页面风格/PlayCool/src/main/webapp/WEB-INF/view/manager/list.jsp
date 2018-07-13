<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="/WEB-INF/view/common/memory.jsp"></jsp:include>
<script type="text/javascript">
 
var rMenu = function(){bisCommon_rightMenuFun('manager');};
    $(function() {
	sy.createDatagrid($("#manager"), $("#manager_srchForm"), rMenu);
	Enter_query('manager');
   });

  var rightMenuFun = function() {
	var menuTarget = $("#manager_menu");
	var selections = $("#manager").datagrid('getSelections');
	var num = selections.length;
	if (num == 1) {//选中1行
	 menuTarget.menu('enableItem',$('#manager_editItem'));
	 menuTarget.menu('enableItem',$('#manager_searchBelowItem'));
	} else {//未选中全部不能操作
			menuTarget.menu('disableItem',$('#manager_editItem'));
			menuTarget.menu('disableItem',$('#manager_searchBelowItem'));
	}
  };
  
  

</script>
</head>
<body class="easyui-layout conditionjs" style="width: 100%; height: 100%;"
	onkeydown="javascript:keyPressImpl(event,'manager');"
	onkeyup="javascript:keyReleaseImpl(event,'manager');">
	<!-- 数据表格 -->
	<div region="center" style="width: 100%; height: 100%; border: 0;">
		<!-- 查询表单 -->
		<div class="condition-search">
			<div id="manager_srchDiv">
				<form id="manager_srchForm" class="frmSearch" action=""
					autocomplete='off'>
					<input type="hidden" name="bean" value="manager"> <input
						type="hidden" name="method" value="page"> <input
						type="hidden" name="curCompanyFlag" value="1"> 
					<table class="tableForm" align="center" width="1000px">
						<tr>
							<th>名称</th>
							<td><input style="width: 140px;" name="name" id="Name" /></td>
							<th>编码</th>
							<td><input style="width: 140px;" name="code" id="code" /></td>
							<td colspan="80" align="center" class="btnbox"><a href="javascript:void(0)"
								class="easyui-linkbutton" onclick="tj_query('manager')">查询</a>
								
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<!-- 查询表单 end-->
		<table id="manager">
			<thead>
				<tr>
					<th data-options="field:'ID',width:10,sortable : true,hidden:true">id</th>
					<th data-options="field:'code',width:100,sortable : true">商品编码</th>
					<th data-options="field:'name',width:50,sortable : true">名称</th>
					<th data-options="field:'supplier_url',width:80,sortable : true">供应商URL</th>
					<th data-options="field:'channel_url',width:80,sortable : true">渠道URL</th>
					<th data-options="field:'supplier_id',width:70,sortable : true">供应商ID</th>
 					<th data-options="field:'channel_id',width:50,sortable : true">渠道ID</th>
				    <th data-options="field:'goods_describe',width:80,sortable : true">描述</th>
				    <th data-options="field:'photo_path',width:80,sortable : true">图片</th>
				    <th data-options="field:'add_time',width:80,sortable : true">添加时间</th>
				    <th data-options="field:'update_time',width:80,sortable : true">修改时间</th>
				    <th data-options="field:'del_flag',width:80,sortable : true">删除</th>
				    <th data-options="field:'flow_status',width:80,sortable : true">恢复</th> 
					</tr>
			</thead>
		</table>
	</div>

	<div id="manager_menu" class="easyui-menu">
		<div id="manager_refreshItem" onclick="tj_query('manager');">刷新</div>
		<div id="manager_querryAllItem" onclick="realQuerryAll('manager');">全部查询</div>
		<div id="manager_tj_querryItem" onclick="simpleSearch('manager');">条件查询</div>
		<!-- <div id="manager_export" onclick="exportXls('exportXls')">导出</div>  -->
		<div class="menu-sep"></div>
		<div id="manager_editItem" onclick="editFun('manager','修改信息',780,250);">修改</div>
		<div id="manager_deleteItem" onclick="updateStatus('manager','DISABLED');">删除</div>
	
		<div class="menu-sep"></div>
<!-- 		<div   onclick="updateStatus('bisOperatorAccount','ENABLED');"><div class="icon-ok"></div>生效</div>
 -->	</div>
</body>
</html>