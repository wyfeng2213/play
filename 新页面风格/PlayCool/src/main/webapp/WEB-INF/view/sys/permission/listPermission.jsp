<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../../common/memory.jsp"></jsp:include>

<script type="text/javascript">
	var pageId, srchForm, treeGrid, rightMenuFun = function() {
		var selections = $("#permission").datagrid('getSelections');
		$("#permission_menu").menu("disableItem", $("[id$='_do']"));
		if(selections.length == 1) {
			if(selections[0].enabled == true)  
				$("#permission_menu").menu('enableItem', $('#permission_edit_do'));
			if(selections[0].url != null) 
				$("#permission_menu").menu('enableItem', $('#permission_bindButton_do'));
		} 
	};
	
	$(function() {
		//$('body').layout('collapse','north');
// 		srchForm = $("#permission_srchForm");		
// 		sy.createDatagrid($("#permission"),srchForm,rightMenuFun);
// 		Enter_query('permission');
 		treeGrid = $("#permission").treegrid({
			url:'treeGrid',
			idField : 'id',
			fit:true,
			fitColumns:true,
			treeField : 'code',
			parentField : 'pid',
			method:'post',
			pagination:true,
			rownumbers:true,
			toggleOnClick:true,
			frozenColumns:[[
				{ field: 'ck', checkbox: true }
			]],
			onClickRow : function(row){
				$(this).treegrid("toggle",row.id);
			},
			onDblClickCell : function(name,row) {
				if(row.url != null){
					openBindMenu('permission','绑定按钮',900,450,'permission');
				}
			},
			onLoadSuccess : function(data) { 
// 				global.getMenu("permission");
				pageId = global.pageId;
				delete $(this).treegrid('options').queryParams['id'];
			},
			onContextMenu:function(e,row){
				e.preventDefault();
				if($("#permission_menu").children().length != 0){
					if(3 == e.which){ 
				  		$("#permission_menu").menu('show', {
				  	      	left : e.pageX,
				  	      	top : e.pageY
				  		});
				  		rightMenuFun();
						return false;
					} 
				} 
			}
		}); 
		
	});
	
	function createToolbar($t){
		$t.datagrid({
			singleSelect: true,
			toolbar: [{
				text: '增加按钮', 
				iconCls: 'icon-add', 
				handler: function () {
					if (endEditing()){
			        	var menuLength = $t.datagrid('getRows').length;
			            $t.datagrid('appendRow',{
			            		status:"ENABLED",
			            		btOrder:menuLength + 1, 
			            		type : "0",
			            		btMethod : "function('')"
			            });
			            editIndex = $t.datagrid('getRows').length - 1;
			            $t.datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
			        }
				}
			},'-',{
				text: '保存', 
				iconCls: 'icon-save', 
				handler: function () { 
					if (endEditing()) $t.datagrid('acceptChanges');
				}
			},'-',{
				text: '放弃', 
				iconCls: 'icon-undo', 
				handler: function () {
					$t.datagrid('rejectChanges');
			        editIndex = undefined;
				}
			},'-',{
				text: '移除按钮', 
				iconCls: 'icon-remove', 
				handler: function () {
					row = $t.datagrid('getSelected');
					if(row != null && typeof row.id != "undefined"){
						editIndex = $t.datagrid('getRowIndex', row); 
						if (editIndex == undefined){ return }
						$t.datagrid('cancelEdit', editIndex).datagrid('deleteRow', editIndex);
			            editIndex = undefined;
			            $.ajax({
			            	url : postPath + "/menuButton/deleteById",
			            	type : "POST",
			            	data : {id : row.id},
			            	dataType : "JSON",
			            	success : function(data){$t.datagrid("reload");}
			            });
					}
				}
			},'-',{
				text: '增加分割线', 
				iconCls: 'icon-add', 
				handler: function () {
					if (endEditing()){
			        	var menuLength = $t.datagrid('getRows').length;
			            $t.datagrid('appendRow',{
			            		status:"ENABLED",
			            		btOrder:menuLength + 1, 
			            		type : "1",
			            		name : "分割线"
			            });
			            editIndex = $t.datagrid('getRows').length - 1;
			            $t.datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
			            $t.datagrid('acceptChanges');
			            $t.datagrid('unselectRow', editIndex);
			        }
				}
			}],
			onDblClickCell : function(index){
				if (editIndex != index){
		            if (endEditing()){
		                $t.datagrid('selectRow', index).datagrid('beginEdit', index);
		                editIndex = index;
		            } else  $t.datagrid('selectRow', editIndex);
		        }
			}, 
			onAfterEdit:function(rowIndex, rowData, changes){ 
				rowData.pageId = $("#thisPageId").val();
				$.ajax({
					url: postPath + "/menuButton/insertOrUpdate",
					data : rowData,
					type : "POST",
					dataType : "JSON",
					success : function(data){  $t.datagrid("reload"); }
				})
			}
		});
	}
	
	//格式化图片类型
	function icon_skin(value, row, index) {
		if(row != null && row.iconSkin != null) {
			return row.iconSkin;
		} else {
			return "-";
		}
	}
	
	function openBindMenu(name,title,width,height,parentName){
		var url = postPath+'/'+name+'/bindMenuByPageId/';
		if("undefined" != typeof parentName){
			name = parentName;
		}
		var selections = $("#"+name).datagrid('getSelections');
		if(selections.length == 1) {
			url +=  selections[0].id;
			openDialog(name,url,title,false,width,height);
		}
	}
</script>
</head>
<body class="easyui-layout" style="width:100%;height:100%;" onkeydown="javascript:keyPressImpl(event,'permission');" onkeyup="javascript:keyReleaseImpl(event,'permission');">
  	
  	<div id="permission_srchDiv" class="easyui-dialog" closed="true" title="查找" style="width:590px;height:200px;">
			<form id="permission_srchForm" class="frmSearch" action="" autocomplete='off'>
				<input type="hidden" name="bean" value="permission">
				<input type="hidden" name="method" value="page">
				<table class="tableForm"  align="center" style="width : 520px;">
					<tr>							
						<th>权限编号</th> 
						<td><input name="code"/></td>	
						<th>权限名称</th>
						<td><input name="name"/></td>				
					</tr>
					<tr>
						<th>上级权限名称</th>
						<td><input name="parentName"/></td>
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
							<a href="javascript:void(0)" class="easyui-linkbutton"onclick="tj_query('permission')">查询</a>&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"onclick="sy.cleanSearch('permission')">重置</a>
						</td>
					</tr>					
				</table>
			</form>
		</div>
		
	<!-- 数据表格 -->
		<div region="center" style="width:100%;height:100%;border:0;">
			<table id="permission" style="text-align:center;">
				<thead>   
			       <tr>  
			       	   <th data-options="field:'id',width:120,sortable : true,hidden:'true'">ID</th>			        
					   <th data-options="field:'code',width:150,sortable : true">权限编号</th>
			           <th data-options="field:'name',width:150,sortable : true">权限名称</th>
			           <th data-options="field:'parent_permission_name',width:100,sortable : true" formatter = 'parentPermissionId'>上级权限名称</th>
			           <th data-options="field:'type',width:50,sortable : true">类型</th>
			           <th data-options="field:'icon_skin',width:120,sortable : true" formatter='icon_skin'>图标类名</th>
			           <th data-options="field:'url',width:180,sortable : true">链接地址</th>
			           <th data-options="field:'content',width:100,sortable : true">内容</th> 
			           <!-- <th data-options="field:'beTop',width:80,sortable : true" formatter = 'sy.format_enabled'>是否根节点</th> -->
			           <th data-options="field:'priority',width:50,sortable : true">优先级</th>  
			           <th data-options="field:'description',width:150,sortable : true">备注</th>
			           <th data-options="field:'enabled',width:70,sortable : true" formatter = 'format_enabled'>状态</th>
			       </tr>   
			   </thead>
			</table>
		</div>
		
	<div id="showDialog" class="easyui-dialog" shadow="false" closed="true" buttons="#dlg-buttons" title="权限管理" style="width: 500px; height: 360px;">
		<iframe scrolling="auto" id='openReceiveFeedBack' name="openReceiveFeedBack" frameborder="0" src="" style="width: 100%; height: 98%;"></iframe>
	</div>	

	<div id="editDialog"></div>
	
	<div id="permission_menu" class="easyui-menu" style="width: 120px;">
		<div onclick="tj_query('permission');">刷新</div>
		<div onclick="querryAll('permission');">全部查找</div>
		<div onclick="simpleSearch('permission');">条件查找</div>
		<div class="menu-sep"></div>
		<div onclick="addFun('permission','新建权限',430,375);;">新建</div>
		<div id="permission_edit" onclick="editFun('permission','新建权限',430,375);">编辑</div>
	</div>
</body>
</html>
