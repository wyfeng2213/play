<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/common/taglibs.jsp"%>
<style type="text/css">
.table_border tr {
	height: 25px;
}

.table_border tr .title span {
	color: red;
}
.inputSelect{ 
	width:212px; 
}
</style>
<script type="text/javascript">
	//combogridCommon_bis_loanRule($('#loanRule_id'),true)
</script>
<form class="cmxform" id="bisSysWarning_addForm" method="post">
	<table class="table_border" border="1" width="100%" height="100%" >
			<tr>
						<td class="title" >
						<font color="red">*&nbsp;</font>类型
						</td>
						<td>
							<select id="type"  name="type" style="width: 100px" class="easyui-validatebox" data-options="required:true" missingMessage="该项为必填项" >
								<option value="SMS" selected>短信</option>
								<option value="EMAIL">邮箱</option>
							</select>
						</td>
						<td class="title" >
							<font color="red">*&nbsp;</font>号码
						</td>
						<td>
							<input type="text" name="content" id="content" class="easyui-validatebox" data-options="required:true" missingMessage="该项为必填项" />
						</td>
				
					</tr>
					
					<tr>
						<td class="title" >
							<font color="red">*&nbsp;</font>业务类型
						</td>
						<td colspan="3">
						<input type="text" name="businessType" id="businessType" class="easyui-validatebox" data-options="required:true" missingMessage="该项为必填项" />
						</td>
					</tr>
			
					<tr>
						<td class="title" >
							备注
						</td>
						<td colspan="3">
						<input type="text" name="description" id="description"  />
						</td>
					</tr>
		<tr>
			<td align="center" valign="middle" colspan="6"><a
				href="javascript:void(0)" class="easyui-linkbutton"
				onclick="saveData('bisSysWarning');">保存</a>&nbsp;&nbsp;&nbsp; <a
				href="javascript:void(0)" class="easyui-linkbutton"
				onclick="resetForm('bisSysWarning');">重置</a>
			</td>
		</tr>
	</table>
</form>
<div class="msg" id="bisSysWarning_msg"
	style="width: 100%; height: 20px; position: absolute; bottom: 0; background-color: #E9F4F7;"></div>