<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="/WEB-INF/view/common/memory.jsp"></jsp:include>
<script type="text/javascript">
 
var rMenu = function(){bisCommon_rightMenuFun('channelGoods');};
    $(function() {
	sy.createDatagrid($("#channelGoods"), $("#channelGoods_srchForm"), rMenu);
	Enter_query('channelGoods');
   });

  var rightMenuFun = function() {
	var menuTarget = $("#channelGoods_menu");
	var selections = $("#channelGoods").datagrid('getSelections');
	var num = selections.length;
	if (num == 1) {//选中1行
	 menuTarget.menu('enableItem',$('#channelGoods_editItem'));
	 menuTarget.menu('enableItem',$('#channelGoods_searchBelowItem'));
	} else {//未选中全部不能操作
			menuTarget.menu('disableItem',$('#channelGoods_editItem'));
			menuTarget.menu('disableItem',$('#channelGoods_searchBelowItem'));
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
	onkeydown="javascript:keyPressImpl(event,'channelGoods');"
	onkeyup="javascript:keyReleaseImpl(event,'channelGoods');">
	<!-- 数据表格 -->
	<div region="center" style="width: 100%; height: 100%; border: 0;">
		<!-- 查询表单 -->
		<div class="condition-search">
			<div id="channelGoods_srchDiv">
				<form id="channelGoods_srchForm" class="frmSearch" action=""
					autocomplete='off'>
					<input type="hidden" name="bean" value="channelGoods"> <input
						type="hidden" name="method" value="page"> <input
						type="hidden" name="curCompanyFlag" value="1"> 
					<table class="tableForm" align="center" width="1000px">
						<tr>
							<th>名称</th>
							<td><input style="width: 140px;" name="name" id="name" /></td>
							<th>商品编码 </th>
							<td><input style="width: 140px;" name="code" id="code" /></td>
							<td colspan="80" align="center" class="btnbox"><a href="javascript:void(0)"
								class="easyui-linkbutton" onclick="tj_query('channelGoods')">查询</a>
							</td>
							<td colspan="80" align="center" class="btnbox"><a href="javascript:void(0)"
								class="easyui-linkbutton" onclick="addFunForDeploy('channelGoods','新建信息',400,400)">添加</a>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<!-- 查询表单 end-->
		<table id="channelGoods">
			<thead>
				<tr>
					<th data-options="field:'id',width:10,sortable : true,hidden:true">id</th>
					<th data-options="field:'code',width:80,sortable : true">商品编号</th>
					<th data-options="field:'name',width:80,sortable : true">名称</th>
					<th data-options="field:'goods_describe',width:80,sortable : true">描述</th>
					<th data-options="field:'photo_path',width:80,sortable : true">图片</th>
 					
					</tr>
			</thead>
		</table>
	</div>

	<div id="channelGoods_menu" class="easyui-menu">
		<div id="channelGoods_refreshItem" onclick="tj_query('channelGoods');">刷新</div>
		<div id="channelGoods_querryAllItem" onclick="realQuerryAll('channelGoods');">全部查询</div>
		<div id="channelGoods_tj_querryItem" onclick="simpleSearch('channelGoods');">条件查询</div>
		<!-- <div id="channelGoods_export" onclick="exportXls('exportXls')">导出</div>  -->
		<div class="menu-sep"></div>
		<div id="channelGoods_editItem" onclick="editFun('channelGoods','修改信息',780,250);">修改</div>
		<div id="channelGoods_newItem" onclick="addFunForDeploy('channelGoods','新建信息',150,150);">添加</div>
		<div id="channelGoods_deleteItem" onclick="updateStatus('channelGoods','DISABLED');">删除</div>
	
		<div class="menu-sep"></div>
<!-- 		<div   onclick="updateStatus('bisOperatorAccount','ENABLED');"><div class="icon-ok"></div>生效</div>
 -->	</div>
</body>
</html>