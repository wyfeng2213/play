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
</script>
<form class="cmxform" id="supplierGoods_addForm" method="supplierGoods">

	<table class="table_border" border="1" style="width: 100%; height: 100%;">
	<tr>
			<td class="title" style="width: 190px"><span>*&nbsp;</span><span id="accountSpan"style="color:black;">商品编号</span></td>
			<td><input id="code" name="code"   class="easyui-validatebox"  data-options="required:true" missingMessage="该项为必填项"/></td>
		</tr>
		<tr>
			<td class="title" style="width: 190px"><span>*&nbsp;</span><span id="accountSpan"style="color:black;">名称</span></td>
			<td><input id="name" name="name"   class="easyui-validatebox"  data-options="required:true" missingMessage="该项为必填项"/></td>
		</tr>
		
		<tr>
			<td class="title" style="width: 190px"><span>*&nbsp;</span><span id="accountSpan"style="color:black;">供应商URL</span></td>
			<td><input id="supplierUrl" name="supplierUrl"   class="easyui-validatebox"  data-options="required:true" missingMessage="该项为必填项"/></td>
		</tr>
		
		<tr>
			<td align="center" valign="middle" colspan="6"><a
				href="javascript:void(0)" class="easyui-linkbutton"
				onclick="saveData('supplierGoods',true,true,true);">保存</a>&nbsp;&nbsp;&nbsp; <a
				href="javascript:void(0)" class="easyui-linkbutton"
				onclick="resetForm('supplierGoods');">重置</a>
			</td>
		</tr>
	</table>
</form>
<div class="msg" id="media_msg"
	style="width: 100%; height: 20px; position: absolute; bottom: 0; background-color: #E9F4F7;"></div>