<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<form class="cmxform" id="user_addForm" method="post" >
		<table class="table_border" border="1" width="400px" height="300px">
					<tr>
						<td class="title" > <font color="red">*&nbsp;</font>账户
						</td>
						<td>
							<input name="code" id="code"  class="easyui-validatebox" data-options="required:true" missingMessage="该项为必填项"/>
						</td>
					</tr>
					<tr>
						<td class="title" >
							<font color="red">*&nbsp;</font>密码
						</td>
						<td>
							<input type="password" name="password" id="password" class="easyui-validatebox" data-options="required:true,validType:'password'" missingMessage="该项为必填项" />
						</td>
					</tr>
					<tr>
						<td class="title" >
							<font color="red">*&nbsp;</font>确认密码
						</td>
						<td>
							<input  type="password" name="repassword" id="repassword" required="true" class="easyui-validatebox"  validType="equalTo['#password']" missingMessage="该项为必填项" invalidMessage="两次输入密码不匹配" />
						</td>
					</tr>
					<tr>
						<td class="title" >
							<font color="red">*&nbsp;</font>昵称
						</td>
						<td>
							<input name="name" id="name"  class="easyui-validatebox" data-options="required:true" missingMessage="该项为必填项" />
						</td>
					</tr>
					<tr>
						<td class="title" ><font color="red">*&nbsp;</font>所属组织</td>
						<td>
							<select id="getOrgName"  name="organization.id" class="easyui-validatebox" data-options="required:true" ></select>
						</td>
					</tr>
					<tr>
						<td class="title" >
							<font color="red">*&nbsp;</font>性别
						</td>
						<td>
							<div class="radioDiv">
								 <input type="radio" name="contact.sex" value="1" checked="checked"/>男
							</div>
							<div class="radioDiv">
								 <input type="radio" name="contact.sex" value="0"/>女
							</div>
						</td>
					</tr>
					<tr>
						<td class="title" >&nbsp;&nbsp;语言
						</td>
						<td>
							<input name="locale" id="locale" />
						</td>
					</tr>
					<tr>
						<td class="title" >&nbsp;&nbsp;手机号</td>
						<td><input name="contact.mobile" id="mobile"class="easyui-validatebox" data-options="validType:'mobile'"/></td>
					</tr>
					<tr>
						<td class="title" >&nbsp;&nbsp;电话
						</td>
						<td>
							<input name="contact.tel" id="tel" class="easyui-validatebox" data-options="validType:'phone'"/>
						</td>
					</tr>
					<tr>
						<td class="title" > &nbsp;&nbsp;邮箱
						</td>
						<td>
							<input name="contact.email" id="email"  class="easyui-validatebox" data-options="validType:'email'" invalidMessage="请填写正确的邮件格式" />
						</td>
					</tr>
					<tr>
						<td class="title" >&nbsp;&nbsp;QQ </td>
						<td>
							<input name="contact.qq" id="qq" class="easyui-validatebox" data-options="validType:'qq'"/>
						</td>
					</tr>
					<!-- <tr>
						<td class="title" >
							 &nbsp;&nbsp;状态
						</td>
						<td>
							<div class="radioDiv"> 
								<input type="radio" name="enabled" id="enabled"  value="true"  checked="checked"  />有效
							</div>
							<div class="radioDiv">
								<input type="radio" name="enabled" id="enabled" value="false"  />失效
							</div>
						</td>
					</tr> -->
					<tr>
						<td align="center" valign="middle" colspan="2">
						<a href="javascript:void(0)" class="easyui-linkbutton"onclick="saveData('user');">保存</a>&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" class="easyui-linkbutton"onclick="resetForm('user');">重置</a>
							<!-- <input type="button" value="保存" class="submit" id="save" onclick="saveSubmit('user');">&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="button" value="关闭" class="blue_mod_btn" onclick="previousPage();"> -->
						</td>
					</tr>
				</table>
</form>
<div id="user_msg" class="msg" style="width:100%;height:20px;position:absolute;bottom:0;background-color:#E9F4F7;">
</div>
<script type="text/javascript">
<!--
	getOrgName();
//-->
</script>