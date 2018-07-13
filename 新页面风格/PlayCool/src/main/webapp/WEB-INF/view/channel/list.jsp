<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="/WEB-INF/view/common/memory.jsp"></jsp:include>
<script type="text/javascript">
 
var rMenu = function(){bisCommon_rightMenuFun('channel');};
    $(function() {
	sy.createDatagrid($("#channel"), $("#channel_srchForm"), rMenu);
	Enter_query('channel');
   });

  var rightMenuFun = function() {
	var menuTarget = $("#channel_menu");
	var selections = $("#channel").datagrid('getSelections');
	var num = selections.length;
	if (num == 1) {//选中1行
	 menuTarget.menu('enableItem',$('#channel_editItem'));
	 menuTarget.menu('enableItem',$('#channel_searchBelowItem'));
	} else {//未选中全部不能操作
			menuTarget.menu('disableItem',$('#channel_editItem'));
			menuTarget.menu('disableItem',$('#channel_searchBelowItem'));
	}
  };
  
  

</script>
</head>
<body class="easyui-layout conditionjs" style="width: 100%; height: 100%;"
	onkeydown="javascript:keyPressImpl(event,'channel');"
	onkeyup="javascript:keyReleaseImpl(event,'channel');">
	<!-- 数据表格 -->
	<div region="center" style="width: 100%; height: 100%; border: 0;">
		<!-- 查询表单 -->
		<div class="condition-search">
			<div id="channel_srchDiv">
				<form id="channel_srchForm" class="frmSearch" action=""
					autocomplete='off'>
					<input type="hidden" name="bean" value="channel"> <input
						type="hidden" name="method" value="page"> <input
						type="hidden" name="curCompanyFlag" value="1"> 
					<table class="tableForm" align="center" width="1000px">
						<tr>
							<th>名称</th>
							<td><input style="width: 140px;" name="name" id="ame" /></td>
							<th>编码 </th>
							<td><input style="width: 140px;" name="code" id="code" /></td>
							<td colspan="80" align="center" class="btnbox"><a href="javascript:void(0)"
								class="easyui-linkbutton" onclick="tj_query('channel')">查询</a>
								
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<!-- 查询表单 end-->
		<table id="channel">
			<thead>
				<tr>
					<th data-options="field:'id',width:10,sortable : true,hidden:true">id</th>
					<th data-options="field:'code',width:100,sortable : true">编码</th>
					<th data-options="field:'name',width:50,sortable : true">名称</th>
					<th data-options="field:'add_time',width:80,sortable : true">添加时间</th>
					<th data-options="field:'update_time',width:80,sortable : true">修改时间</th>
					<th data-options="field:'del_flag',width:70,sortable : true">删除</th>
 				    
					</tr>
			</thead>
		</table>
	</div>

	<div id="channel_menu" class="easyui-menu">
		<div id="channel_refreshItem" onclick="tj_query('channel');">刷新</div>
		<div id="channel_querryAllItem" onclick="realQuerryAll('channel');">全部查询</div>
		<div id="channel_tj_querryItem" onclick="simpleSearch('channel');">条件查询</div>
		<!-- <div id="channel_export" onclick="exportXls('exportXls')">导出</div>  -->
		<div class="menu-sep"></div>
		<div id="channel_editItem" onclick="editFun('channel','修改信息',780,250);">修改</div>
		<div id="channel_deleteItem" onclick="updateStatus('channel','DISABLED');">删除</div>
	
		<div class="menu-sep"></div>
<!-- 		<div   onclick="updateStatus('bisOperatorAccount','ENABLED');"><div class="icon-ok"></div>生效</div>
 -->	</div>
</body>
</html>