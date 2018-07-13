<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

<form class="cmxform" id="bisSysWarning_editForm" method="post">
		<table class="table_border" border="1" width="100%" height="100%">
					<tr>
						<td class="title" > <font color="red">*&nbsp;</font>类型
						</td>
						<td>
						<input type="hidden" name="id" value="${bisSysWarning.id}"/> 
							<select id="type"  name="type" class="easyui-validatebox"  style="width: 100px" data-options="required:true" missingMessage="该项为必填项" >
								<option value="SMS" <c:if test="${bisSysWarning.type eq 'SMS' }">selected="selected"</c:if>>短信</option>
								<option value="EMAIL" <c:if test="${bisSysWarning.type eq 'EMAIL' }">selected="selected"</c:if>>邮箱</option>
							</select>
						</td>
						<td class="title" >
							<font color="red">*&nbsp;</font>号码
						</td>
						<td>
							<input type="text" name="content" id="content" value="${bisSysWarning.content}" class="easyui-validatebox" data-options="required:true" missingMessage="该项为必填项" />
						</td>
					</tr>
					
				  <tr>
						<td class="title" >
							<font color="red">*&nbsp;</font>业务类型
						</td>
						<td colspan="3">
						<input type="text" name="businessType" id="businessType"  value="${bisSysWarning.businessType}" class="easyui-validatebox" data-options="required:true" missingMessage="该项为必填项" />
						</td>
					</tr>
					
					
					<tr>
						<td class="title" >
							备注
						</td>
						<td colspan="3">
						<input type="text" name="description" id="description"  value="${bisSysWarning.description}"/>
						</td>
					</tr>
			
			
					<tr>
						<td align="center" valign="middle" colspan="6">
							<a href="javascript:void(0)" class="easyui-linkbutton"onclick="editData('bisSysWarning');">保存</a>&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
				</table>
</form>
<div id="bisSysWarning_msg" class="msg" style="width:100%;height:20px;position:absolute;bottom:0;background-color:#E9F4F7;">
</div>