<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<form class="cmxform" id="role_editForm" method="post">
		<table class="table_border" border="1" width="340px" height="150px">
					<tr>
						<td class="title" >
							<font color="red">*&nbsp;</font>用户编号
						</td>
						<td>
							<input type="hidden" name="id" value="${role.id}"> 
							<input name="code" id="code"  value="${role.code}" readonly="readonly"  class="easyui-validatebox" data-options="required:true" />
						</td>
					</tr>
					<tr>
						<td class="title" >
							<font color="red">*&nbsp;</font>角色名称
						</td>
						<td>
							<input name="name" id="name" value="${role.name }"  class="easyui-validatebox" data-options="required:true" />
						</td>
					</tr>
				<%-- <tr>
					<td class="title" ><font color="red">*&nbsp;</font>状态
					</td>
					<td>
						<div class="radioDiv">
							<input type="radio" name="enabled" id="enabled" value="true" <c:if test="${role.enabled eq true}">checked</c:if>
							required />有效 
						</div>
						<div class="radioDiv">
							<input type="radio" name="enabled" id="enabled" value="false"
							<c:if test="${role.enabled eq false}">checked</c:if>
							required />失效
						</div>
					</td>
				</tr> --%>
				<tr>
						<td class="title" >
							 &nbsp;&nbsp;备注
						</td>
						<td>
							<textarea name="description" id="description" class="easyui-validatebox" validType="length[0,200]" invalidMessage="不能超过200个字符">${role.description}</textarea>
						</td>
					</tr>
					<tr>
						<td align="center" valign="middle" colspan="2">
							<a href="javascript:void(0)" class="easyui-linkbutton"onclick="editData('role');">保存</a>&nbsp;&nbsp;&nbsp;
							<!-- <a href="javascript:void(0)" class="easyui-linkbutton"onclick="previousPage();">关闭</a> -->
							<!-- <input type="button" value="提交" class="submit" id="save" onclick="saveSubmit('role');">
							<input type="button" value="取消" class="blue_mod_btn" onclick="parent.closeDialog();"> -->
						</td>
					</tr>
				</table>
	</fieldset>
</form>
<div id="role_msg" class="msg" style="width:100%;height:20px;position:absolute;bottom:0;background-color:#E9F4F7;">
</div>