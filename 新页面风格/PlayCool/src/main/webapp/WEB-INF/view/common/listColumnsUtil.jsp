<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript">
	var columnsLayout = $.extend({},columnsLayout);/*定义全局对象*/
	
	//根据数据列头状态隐藏对应列
	columnsLayout.headerColumnsStatus =  function(t,name){
		var columnObj = t.datagrid('options').columns; 
		$.get("${pageContext.request.contextPath}/userTableColumns/getColumnsStatus",{name : name},function(datas){
			if(datas.length != 0){
				$.each(datas,function(i){
					if (datas[i].STATUS == 'DISABLED') {
						t.datagrid('hideColumn', datas[i].FIELD);
					}
				});
			}
		},"JSON");
		t.datagrid('hideColumn', columnObj[0][0].field);//默认隐藏id列
	};
	
	//保存列显示状态
	columnsLayout.updateStatus =  function(tableId,field,status){
		$.get("${pageContext.request.contextPath}/userTableColumns/updateStatus",{tableId : tableId , field : field , status : status},function(){},"JSON");
	};
	
	//系统每一次初始化数据库列头数据
	columnsLayout.initColumns =  function(tableId,array){
		$.get("${pageContext.request.contextPath}/userTableColumns/initColumns",{tableId : tableId , array : array},function(){},"JSON");
	};
	
	//拖动更新列头位置顺序
	columnsLayout.columnsMovingUpdate =  function(tableId ,fromPoint ,toPoint){
		$.get("${pageContext.request.contextPath}/userTableColumns/columnsMovingUpdate",{tableId : tableId , fromPoint : fromPoint ,toPoint : toPoint},function(){},"JSON");
	};
	
	//重新指定表格列显示顺序
	columnsLayout.initColumnsOrder =  function(t,name){
		var newColumns = new Array();
		var columns = new Array();
		var cols = t.datagrid('options').columns[0];  //源列数组
		$.get("${pageContext.request.contextPath}/userTableColumns/initColumnsOrder",{name : name},function(datas){
				if(datas.length != 0){
					$.each(datas,function(i){
						for(var j=0; j<cols.length; j++){  
							if (datas[i].FIELD == cols[j].field) {
								columns.push(cols[j]);
							}
						}
					});
					newColumns.push(columns);
					t.datagrid({//重载datagrid
	                 	columns : newColumns
	                 }).datagrid('columnMoving');
					sy.pageButtons(t);
				}
		},"JSON");
	};
	
	columnsLayout.saveColumns = function(name){
		var cols = $("#"+name).datagrid('options').columns[0];  //源列数组
		var array = new Array();
		for(var i=0; i<cols.length; i++){  
			var obj = new Object();
			obj.field = cols[i].field;
			if(cols[i].hidden == true){
				obj.status = 'DISABLED';
				obj.hidden = 'true';
			}else{
				obj.status = 'ENABLED';
				obj.hidden = 'false';
			}
			obj.sort = i;
			array.push(obj);
        }  
		$.ajax({
			type : "POST",
			url : "${pageContext.request.contextPath}/userTableColumns/saveColumns",
			dataType : "json",
			data : {
				array : JSON.stringify(array), 
				name : name
			},
			success : function(data) {
				$.messager.alert('提示','保存成功!','info');
			}
		});
	};
	
	columnsLayout.createColumns = function(t){
		var array = new Array();
		t.find("th").each(function(item, i) {
			var col_name = $(i)[0].innerHTML;
			var obj = new Object();
			var hidden =  "true"; //默认所有列显示
			var des = $(i).attr("data-options");
			des = des.replace(/\s+/g,''); //去掉所有空格
			var sortable = "true"; //默认可以排序
			var width = des.substring(des.indexOf("width:") + 6,des.indexOf(",",des.indexOf("width:"))); //取对应列width
			var id =  des.substring(des.indexOf("field:'") + 7,des.indexOf(",",des.indexOf("field:'")) - 1); //取对应列id
			var formatter = $(i).attr("formatter"); //取格式化信息
			var exists = des.indexOf("hidden");
			if (exists == -1) {
				hidden = "false";
				sortable = des.substring(des.indexOf("sortable:") + 9);
			}else{
				sortable = des.substring(des.indexOf("sortable:") + 9,des.indexOf(",",des.indexOf("sortable:")));
			}
			obj.field = id;
			obj.hidden = hidden;
			obj.width = width;
			obj.col_name = col_name;
			obj.sortable = sortable;
			if(formatter == undefined ){
				obj.formatter = "";
			}else{
				obj.formatter = formatter;
			}
			array.push(obj);
		});
		
		//判断当前表格是否已存在于数据库，如果不存在，生成表格表头数据，并返回表头newColumns
		var newColumns;
		$.ajax({
			type : "POST",
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			url : "${pageContext.request.contextPath}/userTableColumns/createColumns",
			async:false,
			data : {
				array : JSON.stringify(array), 
				tableId : t.attr("id")
			},
			dataType: "json",
			success : function(datas) {
				newColumns = datas.tds;
			}
		});
		return newColumns;
	};
</script>
