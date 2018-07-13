<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/WEB-INF/view/common/memory.jsp"></jsp:include>

<script type="text/javascript">
	var srchForm, _datagrid, editIndex = undefined, rightMenuFun = function() { };
	$(function() {
		//$('body').layout('collapse','north');
		srchForm = $("#menuButton_srchForm");
		var $t = $("#menuButton");
		$("#thisPageId").val("${pageId }");
		sy.createDatagrid2($t,sy.serialieObject(srchForm),rightMenuFun);
		createToolbar($t);
		Enter_query('menuButton');
	});
	
    function endEditing(){
        if (editIndex == undefined){return true}
        if ($('#menuButton').datagrid('validateRow', editIndex)){
            $('#menuButton').datagrid('endEdit', editIndex);
            editIndex = undefined;
            return true;
        } else return false;
    }
    
    function getChanges(){
        var rows = $('#menuButton').datagrid('getChanges');
        alert(rows.length+' rows are changed!');
    }
</script>
</head>
<body class="easyui-layout" style="width:100%;height:100%;" onkeydown="javascript:keyPressImpl(event,'menuButton');" onkeyup="javascript:keyReleaseImpl(event,'menuButton');">

  	<div id="menuButton_srchDiv" class="easyui-dialog" closed="true" title="查找" style="width:400px;height:300px;">
		<form id="menuButton_srchForm" class="frmSearch">
			<input type="hidden" id="thisPageId" name="pageId" >
			<input type="hidden" name="bean" value="menuButton">
			<input type="hidden" name="method" value="page">
		</form>
	</div>
	
	<div region="center" style="width:100%;height:100%;border:0;" >
		<table id="menuButton" >
			<thead>   
		       <tr>  
		       	   <th data-options="field:'id',width:80,sortable : true,hidden:'true'">ID</th>	
		       	   <th data-options="field:'pageId',width:80,sortable : true,hidden:'true'">PAGE_ID</th>		        
				   <th data-options="field:'nodeId',width:120,sortable : true,editor:'text'">按钮(id)</th>
		           <th data-options="field:'name',width:120,sortable : true,editor:'text'">按钮名称(value)</th>
		           <th data-options="field:'iconCls',width:100,sortable : true,editor:'text'">按钮(iconCls)</th>
		           <th data-options="field:'btMethod',width:250,sortable : true,editor:'text'">按钮(onClick)</th>
		           <th data-options="field:'btOrder',width:50,sortable : true,editor:'numberbox'">排序</th>  
		           <th data-options="field:'status',width:70,sortable : true,editor:'text'">状态</th>
		           <th data-options="field:'type',width:70,sortable : true,editor:'text'">类型</th>
		           <th data-options="field:'description',width:150,sortable : true,editor:'text'">备注</th>
		       </tr>   
		   </thead>
		</table>
	</div>
</body>
</html>
