<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/WEB-INF/view/common/memory.jsp"></jsp:include>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common/bisCommon.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common/organizationUtil.js"></script>
<script type="text/javascript">
	//右键菜单项生效失效逻辑代码，注：函数名必须为rightMenuFun()!!!
	var rightMenuFun = function() {
		var selections = $("#user").datagrid('getSelections');
		var menuTarget = $("#user_menu");
		
		menuTarget.menu("disableItem", $("[id$='_do']"));
		menuTarget.menu("disableItem", $("#user_enabledItem"));
		menuTarget.menu("disableItem", $("#user_disabledItem"));
		
		var num = selections.length;
		if(num == 1) {//选中1行
			if(selections[0].enabled == true) {
				menuTarget.menu("enableItem", $("[id$='_do']"));
				menuTarget.menu("enableItem", $("#user_disabledItem"));
			} else {
				menuTarget.menu("enableItem", $("#user_enabledItem"));
			}
		} else if (num > 1) {
			var isSame = 1;
			for(var i = 1;i<num;i++) {
				if(selections[i].enabled != selections[0].enabled) {
					isSame = 0;
				}
			}
			//如果状态相同
			if(isSame == 1) {
				//如果状态全为‘生效’
				if(selections[0].enabled == true) {
					menuTarget.menu("enableItem", $("#user_disabledItem"));
				} else {
					menuTarget.menu("enableItem", $("#user_enabledItem"));
				}
			}
		}
		/* if(selections.length == 1) {
			if(selections[0].enabled == true)  
				$("#user_menu").menu('enableItem', $('#role_edit_do'));
			$("#user_menu").menu('enableItem', $("[id$='_do']"));
			if(selections[0].enabled == false)  
				$("#user_menu").menu('disableItem', $('#role_edit_do'));
		}  */
	};
	
	var srchForm ;
	$(function() {
		//$('body').layout('collapse','north');
		srchForm = $("#user_srchForm");		
		sy.createDatagrid($("#user"),srchForm,rightMenuFun);
		//getLegalChannel($("#organizationId"),"install");
		Enter_query('user');
	});
	
	function exportExcel(){
		// 导出失效
		disabledExport();
		//var formId = $("div[id*='_srchDiv'] form").attr("id");
		location.href = 'exportExcel?' + $("#user_srchDiv").serialize();
	}
	
	//重置密码
	var resetPwd = function() {
		var selections = $("#user").datagrid('getSelections');
		var num = selections.length;
		var password=$("#password").val();
		if (num == 1) {//选中1行
		 jQuery.messager.confirm('提示:','确定重置密码吗?',function(event){   
				if(event){
						$
								.ajax({
									url:postPath+'/user/resetPwd',//请求url 
									method : 'post',
									data : {
										id : selections[0].id,
										password:password
									},
									contentType : "application/x-www-form-urlencoded; charset=UTF-8",
									dataType : 'json',
									cache : false,
									success : function(data){
										if (data.additionalMsg.status == "成功") {
											alert('重置成功!密码为：abc123');
											msgObj.ajaxResponseMsg($('#user_msg'), data);
											tj_query('user');
											
										}else{	
											msgObj.ajaxResponseMsg($('#user_msg'), data);
										}
									}
								});
						}else{   
						}   
					}); 
			}else {
				$.messager.alert('提示','请勾选一行记录!','warning');
			}
		};
</script>
</head>

<body class="easyui-layout" style="width:100%;height:100%;" onkeydown="javascript:keyPressImpl(event,'user');" onkeyup="javascript:keyReleaseImpl(event,'user');">
<!-- 查询表单 -->
	<div id="user_srchDiv" class="easyui-dialog" closed="true" title="查找" style="width:590px;height:200px;">
			<form id="user_srchForm" class="frmSearch" action="" autocomplete='off'>
				<input type="hidden" name="bean" value="user">
				<input type="hidden" name="method" value="page">
				<table class="tableForm"  align="center" style="width :500px;">
					<tr>							
						<th>账户</th> 
						<td><input id="userName" name="code"/></td>	
						<th>昵称</th>
						<td><input id="userAlias" name="name"/></td>
					</tr>
					<tr>						
						<th>所属组织</th>
						<td><input id="orgName" name="orgName"/></td>						
					</tr>
					<tr>
						<td colspan="6" align="center">
							<a href="javascript:void(0)" class="easyui-linkbutton"onclick="tj_query('user')">查询</a>&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"onclick="sy.cleanSearch('user')">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		
	<div id="showDialog" class="easyui-dialog" shadow="false" modal="true" closed="true" buttons="#dlg-buttons" title="用户管理" style="width: 420px; height: 365px;">
		<iframe scrolling="no" id='openReceiveFeedBack' name="openReceiveFeedBack" frameborder="0" src="" style="width: 100%; height: 98%;"></iframe>
	</div>	
		
	<div region="center" style="width:100%;height: 100%;border:0;">
		<table id="user">
			<thead>   
			       <tr> 
			       	   <th data-options="field:'id',width:120,sortable : true,hidden:true">ID</th> 			        
					   <th data-options="field:'code',width:120,sortable : true">账户</th>
			           <th data-options="field:'name',width:120,sortable : true">昵称</th>
			           <th data-options="field:'contact_sex',width:120,sortable : true" formatter='format_sex'>性别</th>
			           <th data-options="field:'org_name',width:120,sortable : true" formatter='format_orgName'>所属组织</th>
			           <th data-options="field:'locale',width:120,sortable : true">语言</th>
			           <th data-options="field:'contact_mobile',width:120,sortable : true" formatter='format_mobile'>手机</th>   
			           <th data-options="field:'contact_tel',width:120,sortable : true" formatter='format_tel'>电话</th>
			           <th data-options="field:'contact_email',width:120,sortable : true" formatter="format_email">邮箱</th>
			           <th data-options="field:'contact_qq',width:120,sortable : true" formatter="format_qq">QQ</th>
			           <!-- <th data-options="field:'lastPwd',width:100,sortable : true" formatter = 'format_lastPwd'>最后一次密码</th> -->
			           <!-- <th data-options="field:'lastMdPwdTime',width:100,sortable : true" formatter = 'format_lastPwdTime'>最后修改时间</th> -->
			           <th data-options="field:'enabled',width:120,sortable : true" formatter="format_enabled">状态</th>
			       </tr>   
			   </thead>
		</table>
	</div>

	<!--右键菜单div-->
	<div id="user_menu" class="easyui-menu">
		<div onclick="tj_query('user');">刷新</div>
		<div onclick="querryAll('user');">全部查找</div>
		<div onclick="simpleSearch('user');">条件查找</div>
		<div class="menu-sep"></div>
		<div class="addItem" data-options="name:'add'" onclick="addFun('user','新建用户',430,375);">新建</div>
		<div id="user_edit_do" onclick="editFun('user','编辑用户',430,375);">编辑</div>
		<div class="menu-sep"></div>
		<div id="user_bindRole_do" onclick="bindRole('user', '绑定角色', 1000, 450);">绑定角色</div>
		<div class="menu-sep"></div>
		<div id="user_enabledItem"  onclick="updateStatus('user','1');">生效</div>
 		<div id="user_disabledItem" onclick="updateStatus('user','0');">失效</div>
 		<div class="menu-sep"></div>
 		<div id="resetPwd_disabledItem" onclick="resetPwd()">重置密码</div>
<!--  		<div id="user_export" onclick="exportExcel()">导出</div> -->
	</div>
</body>
</html>