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
	$("#deploy_addForm").ajaxSubmit(options);

}
</script>
<form class="cmxform" id="deploy_addForm" action="upFile" method="post"
				enctype="multipart/form-data" >

	<table class="table_border" border="1" style="width: 100%; height: 100%;">
		<tr>
			<td class="title" style="width: 190px"><span>*&nbsp;</span><span id="accountSpan"style="color:black;">流程名称</span></td>
			<td><input id="filename" name="filename"   class="easyui-validatebox"  data-options="required:true" missingMessage="该项为必填项"/></td>
		</tr>
		<tr>
			<td class="title" style="width: 190px"><span>*&nbsp;</span><span id="accountSpan"style="color:black;">流程文件</span></td>
			<td><input id="file" name="file" type="file" value="上传流程"  class="easyui-validatebox"  data-options="required:true" missingMessage="该项为必填项"/></td>
		</tr>

		<tr>
		<td><!-- <input type="submit"  value="上传文件" /> -->
		<input type="button" class="easyui-linkbutton" value="保存"
					onclick="save()" />
		</td>
		
		<!-- <td><input type="submit" value="上传"></td> -->
			<!-- <td align="center" valign="middle" colspan="6"><a
				href="javascript:void(0)" class="easyui-linkbutton"
				onclick="saveData('deploy',true,true,true);">保存</a>&nbsp;&nbsp;&nbsp; <a
				href="javascript:void(0)" class="easyui-linkbutton"
				onclick="resetForm('deploy');">重置</a>
			</td> -->
		</tr>

	</table>
</form>
<div class="msg" id="deploy_msg"
	style="width: 100%; height: 20px; position: absolute; bottom: 0; background-color: #E9F4F7;"></div>