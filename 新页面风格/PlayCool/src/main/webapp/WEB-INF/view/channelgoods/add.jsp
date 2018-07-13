<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/common/taglibs.jsp"%>
<style type="text/css">
.table_border tr {
	height: 23px;
}

.table_border tr .title span {
	color: red;
}
.inputSelect{ 
	width:612px; 
}
</style>
<script type="text/javascript">
$(function(){
	combogrid_supplier_id($("#_supplier_id"),true,$("#supplierId"));
	
});

function getGood(){
	var supplierId = $("#supplierId").val();
	console.log("supplierId--"+supplierId);
	 $.ajax({
			url : "getSupplierGoods",
			data : {
				"supplierId" : supplierId
			},
			type : "POST",
			dataType : "json",
			success : function (datas) {
				var jsonObject = datas.goodsJsonStr;
				creatTable(jsonObject);
				/* alert(jsonObject); */
					
			},
			error : function (xhr, status) {
				alert("商品获取失败！");
			}
		});
}

function creatTable(json){
/* 	var table = $("<table></table>"); */
	
	 $.each(json, function (index, item) {
		/*  var tr = $("<tr></tr>"); */
         //循环获取数据  
         var name = json[index].name;
         var supplierId = json[index].supplierId;
        
        console.log("name--"+name);
        console.log("supplierId--"+supplierId);
       /*  $("#goodListTable").append(tr); */
     });
}

function creatGoodList(supplierId){
		var spanClass = "checkbox";
		var input_type =  "checkbox";
		var input_name =  "id";
		var input_class =  "checkboxclass";
		var input_value = supplierId;
		var span = $("<span class='" + spanClass + "'>" +888 + "</span>");
		var input =  $("<input type='" + input_type + "'name='" + input_name + "'class='" + input_class + "'/>");
		input.appendTo(span);
	
}



function combogrid_supplier_id(target,required,supplierId) {

	var queryParamsObj = { //查询参数对象
			bean: 'supplier',
			method: 'page',
			delFlag: '0'
	};
	createCombogrid__MapResult(target,queryParamsObj,required,supplierId);
}

function createCombogrid__MapResult(target, queryParamsObj, required,supplierId) {
	target
			.combogrid({
				panelWidth : 300, // 面板宽度
				panelHeight : 308, // 面板高度
				mode : 'remote',
				method : 'post',
				url :  postPath +'/process',
				queryParams : queryParamsObj,
				pagination : true,
				pageSize : 10,
				pageList : [ 5, 10, 15 ],
				required : required,
				idField : 'id', // combogrid的值，传到后台
				textField : 'name', // 显示的值
				columns : [ [ {
					field : 'name',
					title : '供应商',
					width : 280,
					sortable : true
				}] ],
				onSelect : function(index, row) {
					var grid = target.combogrid('grid');	// 获取数据表格对象
					var row = grid.datagrid('getSelected');		// 获取选择的行
					var id=row.id;
					supplierId.val(id);
					getGood();
				}
				,
				onLoadSuccess : function(data) {
					var paramsObj = target.combogrid('grid')
							.datagrid('options').queryParams;
					if ("undefined" == typeof paramsObj.q && data.total == 0) {
					} else if (data.total == 0) {// 没有符合查询条件的数据
						target.focus();
						target.combogrid('grid').datagrid('load',
								queryParamsObj);
					}
				}
			});
	}





//保存
 function save() {
	var filename = $("#filename").val();
	var options = {
		url : 'upFile',
		type : 'POST',
		dataType : 'json',
		success : function() {
			
				alert("部署成功！");

		}
	};
	$("#channelgoods_addForm").ajaxSubmit(options);

} 
</script>
<form class="cmxform" id="channelgoods_addForm" action="upFile" method="post"
				enctype="multipart/form-data" >

	<table class="table_border" border="1" style="width: 100%; height: 100%;">
		<tr>
			<td class="bname">供应商：</td><td>
			<!-- 	<select id="_supplier_id" name="firstdir" >
		<option  id="supplierId" name="supplierId" >--999--</option>
		</select>  -->
			<input id="_supplier_id" value = "--请选择供应商--"/><input id="supplierId" name="supplierId" type="hidden" value="0"/>
			</td>
		</tr>
		
		<tr>
			
		<td class="bname" >商品列表：</td><td colspan="3">
		<table id = "goodListTable">
		</table>
		
						<%-- <c:forEach items="${goodsList}" var="item" >
							<span class="checkbox"><input type="checkbox" name="id" class="checkboxclass" value="${item.id }"/>
							${item.name }</span>
						</c:forEach> --%>
						<!-- <input id="id" name="id" type="hidden"/> -->
		</td>
		</tr>
		<!-- <tr>
			<td class="title" style="width: 190px"><span>*&nbsp;</span><span id="accountSpan"style="color:black;">流程文件</span></td>
			<td><input id="file" name="file" type="file" value="上传流程"  class="easyui-validatebox"  data-options="required:true" missingMessage="该项为必填项"/></td>
		</tr> -->

		<!-- <tr>
		<td><input type="submit"  value="上传文件" />
		<input type="button" class="easyui-linkbutton" value="保存"
					onclick="save()" />
		</td>
		
		</tr> -->

	</table>
</form>
<div class="msg" id="channelgoods_msg"
	style="width: 100%; height: 20px; position: absolute; bottom: 0; background-color: #E9F4F7;"></div>
	
<script type="text/javascript">

</script>