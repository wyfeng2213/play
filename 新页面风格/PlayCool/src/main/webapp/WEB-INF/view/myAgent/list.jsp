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
		bisCommon_rightMenuFun('myAgent');
	};
	$(function() {
		sy.createDatagrid($("#myAgent"), $("#myAgent_srchForm"), rMenu);
		Enter_query('myAgent');
	
	});

	var rightMenuFun = function() {
		var menuTarget = $("#myAgent_menu");
		var selections = $("#myAgent").datagrid('getSelections');
		var num = selections.length;
		if (num == 1) {//选中1行
			menuTarget.menu('enableItem', $('#myAgent_editItem'));
			menuTarget.menu('enableItem', $('#myAgent_searchBelowItem'));
		} else {//未选中全部不能操作
			menuTarget.menu('disableItem', $('#myAgent_editItem'));
			menuTarget.menu('disableItem', $('#myAgent_searchBelowItem'));
		}
	};
	
	var jq = top.jQuery;
	/**
	*打开 修改dialog 三次封装opendialog
	*@param name: dialog容器的id前缀名
	*@param title: dialog标题
	*@param width: dialog宽度
	*@param height: dialog宽度
	*/
	function approvalFun(name,title,width,height,parentName){
		var url = postPath+'/'+name+'/approval/';
		debugger;
		var selections = $("#"+name).datagrid('getSelections');
		if(selections.length == 1) {
			if (selections[0].id == undefined) {
				url +=  selections[0].ID;
			}else {
				url +=  selections[0].id;
			}
			
			var titlename='审批';
			 var content = '<iframe id="' + titlename + '" scrolling="auto" frameborder="0"  src="' + url + '" style="padding:0;margin:0;width:100%;height:100%;"></iframe>';
				// 生成新的选项卡，
				jq("#tabs").tabs('add', {
					 width:500,      //选项卡容器宽度
				        height:400 ,
					title : titlename,
					closable : true,
					content : content,
					iconCls : "icon-application",
					fit : true
				
				});
			
		}else {
			$.messager.alert('提示','请勾选一行记录!','warning');
		}
	}

</script>

</head>
<body class="easyui-layout conditionjs" style="width: 100%; height: 100%;"
	onkeydown="javascript:keyPressImpl(event,'myAgent');"
	onkeyup="javascript:keyReleaseImpl(event,'myAgent');">
	
	<!-- 数据表格 -->
	<div region="center" style="width: 100%; height: 100%; border: 0;">
	<!-- 查询表单 -->
	<div class="condition-search">
		<div id="myAgent_srchDiv">
			<form id="myAgent_srchForm" class="frmSearch" action=""
				autocomplete='off'>
				<input type="hidden" name="bean" value="myAgent"> <input
					type="hidden" name="method" value="page"> 
				<table class="tableForm" align="center" width="700px">
					<tr>
						<th>工单号</th>
						<td>
							<input style="width: 140px;" name="order_no"
							id="order_no" />
						</td>
						<!-- <th>申请人</th>
						<td>
							<input style="width: 100px;" name="apply_user_id"
							id="apply_user_id" />
						</td> -->
						<th>申请时间</th>
						<td>
							<input style="width: 100px;" name="apply_time"
							id="apply_time" />
						</td>
							
						<td colspan="8" align="center" class="btnbox"><a href="javascript:void(0)"
							class="easyui-linkbutton" onclick="tj_query('myAgent')">查询</a>
							
						</td>
						</tr>
				</table>
			</form>
		</div>
	</div>
	<!-- 查询表单 end-->
		<table id="myAgent">
			<thead>
				<tr>
					<th data-options="field:'id',width:80,sortable : true,hidden:true">id</th>
					<th data-options="field:'order_no',width:80,sortable : true">工单号</th>
					<!-- <th data-options="field:'flow_type',width:80,sortable : true">工单类型</th>
					<th data-options="field:'apply_user_id',width:80,sortable : true">申请人</th> -->
					<th data-options="field:'apply_time',width:80,sortable : true">申请时间</th>
					<th data-options="field:'cur_user_id',width:80,sortable : true">当前处理人</th>
					<th data-options="field:'flow_status',width:80,sortable : true">流程状态</th>
				</tr>

			</thead>
		</table>
	</div>

	<div id="myAgent_menu" class="easyui-menu">
		<div id="myAgent_refreshItem" onclick="tj_query('myAgent');">刷新</div>
		<div id="myAgent_querryAllItem" onclick="realQuerryAll('myAgent');">全部查询</div>
<!-- 		<div id="myAgent_tj_querryItem" onclick="simpleSearch('myAgent');">条件查询</div>
 -->
		<div class="menu-sep"></div>
		<div id="myAgent_editItem" onclick="approvalFun('myAgent','修改信息',1000,800);">审批</div>
		<div id="myAgent_deleteItem" onclick="updateDelFlag('myAgent','1');">删除</div>
		<div class="menu-sep"></div>
	</div>
</body>
</html>