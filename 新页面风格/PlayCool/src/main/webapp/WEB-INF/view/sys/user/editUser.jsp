<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
<!--
	getOrgName();
//-->
</script>
<form class="cmxform" id="user_editForm" method="post">
		<table class="table_border" border="1" width="400px" height="310px">
					<tr>
						<td class="title" >
							<font color="red">*&nbsp;</font>账户
						</td>
						<td>
							<input name="code" id="code"   readonly="readonly" value="${user.code}" />
							<input type="hidden" id="id" name="id" value="${user.id }"/>
						</td>
					</tr>
					<tr>
						<td class="title" >
							<font color="red">*&nbsp;</font>昵称
						</td>
						<td>
							<input name="name" id="name"   value="${user.name}" class="easyui-validatebox" data-options="required:true" missingMessage="该项为必填项"/>
						</td>
					</tr>
 					<%-- <tr>
						<td class="title" >
							<font color="red">*&nbsp;</font>密码
						</td>
						<td>
							<input type="password" name="password" id="password"  value="${user.password}"
								class="easyui-validatebox" data-options="required:true"/>
						</td>
					</tr> --%>
					<tr>
						<td class="title" >
							<font color="red">*&nbsp;</font>性别
						</td>
						<td>
							<div class="radioDiv">
							 	<input type="radio" name="contact.sex" value="1"  <c:if test="${user.contact.sex eq 1}">checked </c:if>  />男
							 </div>
							<div class="radioDiv">
								 <input type="radio" name="contact.sex" value="0" <c:if test="${user.contact.sex eq 0}">checked </c:if>/>女
							</div>
						</td>
					</tr>
					<tr>
						<td class="title" ><font color="red">*&nbsp;</font>所属组织</td>
						<td>
							<select id="getOrgName"  name="organization.id" ></select>
							<input type="hidden" id="organizationId" value="${user.organization.id}"/>
						</td>
					</tr>
					 <tr>
						<td class="title" >&nbsp;&nbsp;语言
						</td>
						<td>
							<input name="locale" id="locale"   value="${user.locale}"   />
						</td>
					</tr>
				<tr>
						<td class="title" >&nbsp;&nbsp;电话
						</td>
						<td>
							<input name="contact.tel" id="tel"   value="${user.contact.tel }" class="easyui-validatebox" data-options="validType:'phone'"/>
						</td>
					</tr>
					<tr>
						<td class="title" >&nbsp;&nbsp;手机号
						</td>
						<td>
							<input name="contact.mobile" id="mobile"   value="${user.contact.mobile}"  class="easyui-validatebox" data-options="validType:'mobile'"/>
						</td>
					</tr>
					<tr>
						<td class="title" >&nbsp;&nbsp;邮箱
						</td>
						<td>
							<input name="contact.email" id="email"   value="${user.contact.email}" class="easyui-validatebox" data-options="validType:'email'" invalidMessage="请填写正确的邮件格式"/>
						</td>
					</tr>
					<tr>
						<td class="title" >&nbsp;&nbsp;QQ
						</td>
						<td>
							<input name="contact.qq" id="qq"   value="${user.contact.qq}" class="easyui-validatebox" data-options="validType:'qq'"/>
						</td>
					</tr>
					<%-- <tr>
					<td class="title" >&nbsp;&nbsp;状态 </td>
					<td>
						<div class="radioDiv">
							<input type="radio" name="enabled" id="enabled" value="true" <c:if test="${user.enabled eq true}">checked</c:if> />有效
						</div>
						<div class="radioDiv">
							<input type="radio" name="enabled" id="enabled" value="false" <c:if test="${user.enabled eq false}">checked</c:if> />失效
						</div>
					</td>
					</tr> --%>
					<tr>
						<td align="center" valign="middle" colspan="2">
							<a href="javascript:void(0)" class="easyui-linkbutton"onclick="editData('user');">保存</a>&nbsp;&nbsp;&nbsp;
							<!-- <a href="javascript:void(0)" class="easyui-linkbutton"onclick="previousPage();">关闭</a> -->
							<!-- <input type="button" value="提交" class="submit" id="save" onclick="saveSubmit('user');">
							<input type="button" value="取消" class="blue_mod_btn" onclick="parent.closeDialog();"> -->
						</td>
					</tr>
				</table>
	</fieldset>
</form>
<div id="user_msg" class="msg" style="width:100%;height:20px;position:absolute;bottom:0;background-color:#E9F4F7;">
</div>
