<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<form class="cmxform" id="permission_addForm" method="post" >
		<table class="table_border" border="1" width="400px" height="300px">
					<tr>
						<td class="title" > <font color="red">*&nbsp;</font>权限编号 </td>
						<td> <input name="code" id="code"  class="easyui-validatebox" data-options="required:true" missingMessage="该项为必填项"/> </td>
					</tr>
					<tr>
						<td class="title" > <font color="red">*&nbsp;</font>权限名称 </td>
						<td> <input name="name" id="name"  class="easyui-validatebox" data-options="required:true" missingMessage="该项为必填项"/> </td>
					</tr>
					<tr>
						<td class="title" > <font color="red">*&nbsp;</font>上级权限名称 </td>
						<td>  
							<select name="parentPermission.id" id="parentPermission"  ></select>
						</td>
					</tr>
					<tr>
						<td class="title" > <font color="red">*&nbsp;</font>类型 </td>
						<td> 
							<select name="type" id="type">
								<option value="MENU" selected="selected">MENU</option>
								<option value="BUTTON">BUTTON</option>
							</select></td>
					</tr>
					<tr>
						<td class="title" >&nbsp;&nbsp;图标类名 </td>
						<td> <input name="iconSkin" id="iconSkin" /> </td>
					</tr>
					<tr>
						<td class="title" >&nbsp;&nbsp;链接地址 </td>
						<td> <input name="url" id="url" /> </td>
					</tr>
					<tr>
						<td class="title" > <font color="red">*&nbsp;</font>优先级 </td>
						<td> <input name="priority" id="priority"  class="easyui-numberbox" data-options="required:true" min="1" validType="" missingMessage="必须填写不小于1的数字" /> </td>
					</tr>
					<!-- <tr>
						<td class="title" > <font color="red">*&nbsp;</font>是否根节点 </td>
						<td>
							<div class="radioDiv">
								<input type="radio" name="beTop" id="beTop"  value="true" />是
							</div>
							<div class="radioDiv">
								<input type="radio" name="beTop" id="beTop"  value="false" checked="checked" />否
							</div>
						</td>
					</tr> -->
					<tr>
						<td class="title" >&nbsp;&nbsp;内容 </td>
						<td> <input name="content" id="content" /> </td>
					</tr>
					<!-- <tr>
						<td class="title" > <font color="red">*&nbsp;</font>状态</td>
						<td> 
							<div class="radioDiv">
								<input type="radio" name="enabled" id="enabled"  value="true"  checked="checked" />有效
							</div>
							<div class="radioDiv">
								<input type="radio" name="enabled" id="enabled" value="false" />失效
							</div>
						</td>
					</tr> -->
					<tr>
						<td class="title" >  &nbsp;&nbsp;备注 </td>
						<td> <textarea name="description" id="description" class="easyui-validatebox" validType="length[0,200]" invalidMessage="不能超过200个字符"  ></textarea> </td>
					</tr>
					<tr>
						<td align="center" valign="middle" colspan="2">
							<a href="javascript:void(0)" class="easyui-linkbutton"onclick="saveData('permission');">保存</a>&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"onclick="resetForm('permission');">重置</a>
							<!-- <input type="button" value="提交" class="submit" id="save" onclick="saveSubmit('permission');">
							<input type="button" value="取消" class="blue_mod_btn" onclick="parent.closeDialog();"> -->
						</td>
					</tr>
				</table>
</form>
<div id="permission_msg" class="msg" style="width:100%;height:20px;position:absolute;bottom:0;background-color:#E9F4F7;">
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common/permissionUtil.js"></script>