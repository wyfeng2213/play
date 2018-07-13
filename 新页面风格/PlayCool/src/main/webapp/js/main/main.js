var strPath = window.document.location.pathname;
var postPath = strPath.substring(0, strPath.substr(1).indexOf('/') + 1);		// 得到项目路径
var bisUserSiteTypeObj = {
		warehouse:'warehouse',
		platForm:'platForm',
		owner:'owner'
};
//<%--动态设置 消息区域和配置区域宽度--%>
var setMsgDivWidth = function(){
	var clientWidth = $(".top-bar").width();
	var userWidth = $(".top-bar_user").width();
	var spansWidth = 0;
	$('.top-bar_btn').children('span').each(function(i, n) {
		spansWidth += $(n).width();
	});
	$('.top-bar_btn').width(spansWidth+20);
	$("#top-bar_msg").width(clientWidth-userWidth-spansWidth-20);
};

$(document).ready(function() {
	$('body').bind("contextmenu",function(e){
		 e.preventDefault(); 
        return false;
	});
	showLeftTime();
	loadMenu();
	searchMenu();
	if ($("#main_warehouse_showText").val() == '仓库：') {
		showDefaultUserSite(bisUserSiteTypeObj.warehouse);
	}
	if ($("#main_platForm_showText").val() == '平台：') {
		showDefaultUserSite(bisUserSiteTypeObj.platForm);
	}
	if ($("#main_owner_showText").val() == '货主：') {
		showDefaultUserSite(bisUserSiteTypeObj.owner);
	}
	setTimeout(function() {
		setMsgDivWidth();
	}, 350);
});

function showLeftTime() {
	var now = new Date();
	var year = now.getFullYear();
	var month = now.getMonth() + 1;
	var day = now.getDate();
	var hours = now.getHours();
	var minutes = now.getMinutes();
	var weekday = now.getDay();
	var week;
	switch(weekday) {
		case 0:week="星期日";break; 
		case 1:week="星期一";break; 
		case 2:week="星期二";break; 
		case 3:week="星期三";break; 
		case 4:week="星期四";break; 
		case 5:week="星期五";break; 
		case 6:week="星期六";break; 
		default:week=""; 
	}
	$("#top_tool_bar_date").html("<font color='white' style='float:right;'><strong>" + year + "年" + month + "月" + day + "日 " + "&nbsp;" + week +"&nbsp; " + checkTime(hours) + ":" + checkTime(minutes) +"&nbsp;</strong><font color='gray'><strong>|</strong></font></font>");
	setTimeout(showLeftTime, 1000 * 60);
}

function checkTime(i) {
	if (i < 10) {
		i = "0" + i;
	}
	return i;
}




var setting = {
	data : {simpleData : {enable : true}},
	callback : {	onClick : addTab},
	view :{
        fontCss: getFontCss,
        dblClickExpand : false
    } 
};

function getFontCss(treeId, treeNode) {  
    return (!!treeNode.highlight) ? {color:"#A60000", "font-weight":"bold"} : {color:"#333", "font-weight":"normal"};  
} 

//var index = 0;
function addTab(event, treeId, treeNode, clickFlag) {
	//index++;
	var uri = treeNode.uri;
	if ( !uri) {
		var zTree = $.fn.zTree.getZTreeObj("na_menu");
		zTree.expandNode(treeNode);
	} else {
		msgObj.clearAllMsg();
		if ($('#tabs').tabs('exists', treeNode.name)) {
			$('#tabs').tabs('select', treeNode.name);
		} else {
			var content = '<iframe id="' + treeNode.id + '" scrolling="auto" frameborder="0"  src="' + treeNode.uri + '" style="padding:0;margin:0;width:100%;height:100%;"></iframe>';
			$('#tabs').tabs('add', {
				title : treeNode.name,
				content : content,
				closable : true,
				iconCls : "icon-application",
				fit : true
			});
		}
	};
	tabClose();
	tabCloseEven();
}

function tabClose() {
	/* 关闭TAB选项卡时清空消息 */
	$(".tabs-close").click(function() {
		msgObj.clearAllMsg();
	});
	/* 双击关闭TAB选项卡 */
	$(".tabs-inner").dblclick(function() {
		msgObj.clearAllMsg();
		var subtitle = $(this).children("span").text();
		if(subtitle != "欢迎使用") {
			$('#tabs').tabs('close', subtitle);
		}
	});
	
	/* 单击TAB选项卡 */
	$(".tabs-inner").click(function() {
		msgObj.clearAllMsg();
	});

	$(".tabs-inner").bind('contextmenu', function(e) {
		msgObj.clearMsg($("#top-bar_msg"));
		$('#mm').menu('show', {
			left : e.pageX,
			top : e.pageY
		});

		var subtitle = $(this).children("span").text();
		$('#mm').data("currtab", subtitle);
		return false;
	});
}

// 绑定右键菜单事件
function tabCloseEven() {
	//欢迎tabs
	//var homeTabs_title
	// 关闭当前
	$('#close').click(function() {
		var currtab_title = $('#mm').data("currtab");
		if(currtab_title == "欢迎使用") {
			$.messager.show({
				title:'提示',
				msg:'该界面不可关闭...'
			});
		}else {
			$('#tabs').tabs('close', currtab_title);
		}
	});
	// 全部关闭
	$('#closeall').click(function() {
		$('.tabs-inner span').each(function(i, n) {
			var t = $(n).text();
			if(t!="欢迎使用") {
				$('#tabs').tabs('close', t);
			}
		});
	});
	// 关闭除当前之外的TAB
	$('#closeother').click(function() {
		var currtab_title = $('#mm').data("currtab");
		$('.tabs-inner span').each(function(i, n) {
			var t = $(n).text();
			if (t != currtab_title && t!="欢迎使用") {
				$('#tabs').tabs('close', t);
			}
		});
	});
	// 关闭当前右侧的TAB
	$('#closeright').click(function() {
		var nextall = $('.tabs-selected').nextAll();
		if (nextall.length == 0) {
			return false;
		}
		nextall.each(function(i, n) {
			var t = $('a:eq(0) span', $(n)).text();
			if(t!="欢迎使用") {
				$('#tabs').tabs('close', t);
			}
		});
		return false;
	});
	// 关闭当前左侧的TAB
	$('#closeleft').click(function() {
		var prevall = $('.tabs-selected').prevAll();
		if (prevall.length == 0) {
			// alert('到头了，前边没有啦~~');
			return false;
		}
		prevall.each(function(i, n) {
			var t = $('a:eq(0) span', $(n)).text();
			if(t!="欢迎使用") {
				$('#tabs').tabs('close', t);
			}
		});
		return false;
	});
}

//加载菜单
function loadMenu() {
	$.ajax({
		url : 'user/getPermissions',
		async : false,
		type : 'POST',
		dataType : 'json',
		timeout : 60000,
		success : function(result) {

			var zNodes = result;
			$.fn.zTree.init($("#na_menu"), setting, zNodes);
			var treeObj = $.fn.zTree.getZTreeObj("na_menu");
			var nodes = treeObj.getNodes();
			var ln = nodes.length;
			for (var i = 0; i < ln; i++) {
				var _node = nodes[i];
				$("#" + treeObj.setting.treeId + "_" + _node.id + "_a").bind("mouseover", function() {
					$(this).addClass("selected");
				});
				$("#" + treeObj.setting.treeId + "_" + _node.id + "_a").bind("mouseout", function() {
					$(this).removeClass("selected");
				});
			}
		}
	});
}

/*function sub() {
	$($("#modifInputForm")).find(':input').each(function() {
		if ($(this).val() == "") {
			$(this).focus();
			$.messager.alert("提示", "填写信息不全", "info");
			return false;
		}
	});
};*/

//注销
function logout() {
	window.location.href = postPath+'/user/logout';
}

//验证原始密码
var pwdFlag = false;
function checkOldPwd(inputPwd) {
	$.ajax({
		url : 'user/checkOldPwd',
		data:{
			inputPwd:inputPwd.value
		},
		dataType : 'json',
		success : function(datas) {
			if (datas.success == true) {
				$("#oldPwdMsg").css("color", "green");
				pwdFlag = true;
			} else {
				$("#oldPwdMsg").css("color", "red");
				pwdFlag = false;
			}
			$("#oldPwdMsg").html(datas.messager);
		}
	});
}

$.extend($.fn.validatebox.defaults.rules, {
	/*必须和某个字段相等*/
	equalTo : {
		validator : function(value, param) {
			return $(param[0]).val() == value;
		},
		message : '信息不匹配'
	}
});

/*  
 * 清空objE为form表单   
 * objE可以为id or  class  
 */
var loginComboboxForm;
function clearForm(objE) {//objE为form表单    
	$(objE).find(':input').each(function() {
		$(this).val('');
	});
	$("#oldPwdMsg").html('');
}
function pwd() {
	clearForm($("#modifInputForm"));
	loginAndRegDialog = $('#modifPwdDialog').show().dialog({
		modal : true,
		title : '修改密码',
		closable : true,
		buttons : [ {
			id : 'btnModifPwd',
			text : '修改',
			handler : function() {
				var validated = $('#modifInputForm').form('validate');
				if (validated && pwdFlag) {
					var password = $("#password").val();
					$.ajax({
						url : 'user/modifPassword',
						type : 'POST',
						data:{
							password:password
						},
						success : function(data) {
							//var d = $.parseJSON(data);
							if (data == "successed") {
								loginAndRegDialog.dialog('close');
									$.messager.alert("提示", "修改密码成功!请重新登录...","info",function(){
										window.location.href = postPath+'/user/logout';
									});
								// $('#indexLayout').layout('panel', 'center').panel('setTitle', sy.fs('[{0}]，欢迎您！[{1}]', d.obj.name, d.obj.ip));
							} else {
								// loginComboboxForm.find('input[name=password]').focus();
								$.messager.alert("提示", "修改密码失败!");
							}
						}
					});
				} else {
					$.messager.alert("提示", "请正确填写信息!");
				}
			}
		},{
			id : 'btnExit',
			text : '退出',
			handler : function() {
				$('#modifPwdDialog').dialog('close');
			}
		} ]
	});
}

//全屏
function fullScreen() {
	$(".top-bg").hide();
	 $('#north_panle').panel('resize',{
		 height: 25
	});
	$('body').layout();
	//$('#mainPanle').panel('open').panel('refresh');
	$("#fullScreen").hide();
	$("#existFullScreen").show(); 
}
//退出全屏
function existFullScreen() {
	$(".top-bg").show();
	$('#north_panle').panel('resize',{
		 height: 86
	});
	$('body').layout();
	$("#fullScreen").show();
	$("#existFullScreen").hide();
}
//权限菜单展开与折叠
function menuOperater(type) {
	var treeObj = $.fn.zTree.getZTreeObj("na_menu");
	if(type == "expandAll") {
		treeObj.expandAll(true);
	} else if(type == "collapseAll") {
		treeObj.expandAll(false);
	}
}

//zTree模糊查询树节点（根据名称）
var lastNodeList = [];
function searchMenu() {
	$("#searchbox").searchbox({ 
		searcher:function(value,name){ 
			 var zTree = $.fn.zTree.getZTreeObj("na_menu");
		        var key = $.trim(value);
		        if (key != "") {
		            nodeList = zTree.getNodesByParamFuzzy("name", key);
		            for (var i = 0, l = lastNodeList.length; i < l; i++) { //上次查询的节点集合取消高亮
		                lastNodeList[i].highlight = false;
		                zTree.updateNode(lastNodeList[i]);
		            }
		            zTree.expandAll(false); //全部收缩
		            if (nodeList.length > 0) {
		                for (var i = 0, l = nodeList.length; i < l; i++) { //遍历找到的节点集合
		                    if (nodeList[i].getParentNode()) {
		                        zTree.expandNode(nodeList[i].getParentNode(), true, false, false); //展开其父节点
		                    }
		                    nodeList[i].highlight = true;
		                    zTree.updateNode(nodeList[i]);
		                }
		            } else {
		            	$.messager.show({
		            		title:'提示',
		            		msg:'<h3>没有找到符合条件的菜单!</h3>',
		            		timeout:3000,
		            		showType:'slide',
		            		width:300,
		            		height:150
		            	});
		            	//$.messager.alert("提示", "<font color='red'>没有找到符合条件的菜单!</font>");
		            }
		            zTree.refresh(); // 很重要，否则节点状态更新混乱。
		            lastNodeList = nodeList;
		            
		        }
		},
		height:18,
		prompt:'请输入菜单名' 
	});
}

var getUserSiteNameAndData = function(type){
	var getUserSiteObj = {};
	getUserSiteObj.name = "";
	getUserSiteObj.data = {};
	if(bisUserSiteTypeObj.warehouse == type){
		getUserSiteObj.name = "仓库";
		getUserSiteObj.data = {warehouseId:$("#main_"+type+"Options").val()};
	}else if(bisUserSiteTypeObj.platForm == type){
		getUserSiteObj.name = "平台";
		getUserSiteObj.data = {platFormId:$("#main_"+type+"Options").val()};
	}else if(bisUserSiteTypeObj.owner == type){
		getUserSiteObj.name = "货主";
		getUserSiteObj.data = {ownerId:$("#main_"+type+"Options").val()};
	}
	return getUserSiteObj;
};
//<%-- 跳转到切换页面 --%>
var toSwitchUserSitePage = function(url,type) {
	var name = getUserSiteNameAndData(type).name;
	$.ajax({
		url:url,
		method:'post',
		contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		dateType:'JSON',
		cache: false,
		success:function(data){
			var list = data.list;
			$("#main_"+type+"Options").children().remove();
			if(list != null){
				if(bisUserSiteTypeObj.owner == type && $("#main_"+type+"_id").val() !=  '-'&& $("#main_"+type+"_id").val() !=  ''){
					$("#main_"+type+"Options").append("<option value='-'>所有货主</option>");
				}
				$.each(list,function(index,item){
					if($("#main_"+type+"_id").val() != item.id){
						$("#main_"+type+"Options").append("<option value="+item.id+">"+item.name+"</option>");
					}
				});
				$("#switch_"+type+"_dialog").dialog({
					title: '切换'+name,    
					width: 335,    
					height: 82,
					closed: true,
					cache: false,    
					modal: true
				});
				if($("#main_"+type+"Options").children().length == 0){
					msgObj.showMsgService($(".msg"), "<b style='padding-left:5px;color:red;'>[您没有切换其他"+name+"的权限！]</b>");
				}else{
					$("#switch_"+type+"_dialog").dialog('open');
				}
			}else{
				msgObj.showMsgService($(".msg"), "<b style='padding-left:5px;color:red;'>[操作失败！请先创建"+name+"！]</b>");
			}
			
		}
	});
};

//<%-- 跳转到切换仓库界面 --%>
var toSwitchWarehousePage = function() {
	var url = postPath+'/wms/warehouse/toSwitchWarehousePage';
	toSwitchUserSitePage(url,bisUserSiteTypeObj.warehouse);
};
//<%-- 跳转到切换平台界面 --%>
var toSwitchPlatFormPage = function() {
	var url = postPath+'/wms/platForm/toSwitchPlatFormPage';
	toSwitchUserSitePage(url,bisUserSiteTypeObj.platForm);
};
//<%-- 跳转到切换货主界面 --%>
var toSwitchOwnerPage = function() {
	var url = postPath+'/wms/owner/toSwitchOwnerPage';
	toSwitchUserSitePage(url,bisUserSiteTypeObj.owner);
};

//<%-- 切换功能实现 --%>
var doSwitchUserSite = function(type) {
	var name = getUserSiteNameAndData(type).name;
	$.ajax({
		url:postPath+'/wms/'+type+'/change',
		method:'post',
		contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		data:getUserSiteNameAndData(type).data,
		dateType:'JSON',
		cache: false,
		success:function(data){
			if(data.additionalMsg.status == "成功"){
				if(bisUserSiteTypeObj.owner != type){
					$('.tabs-inner span').each(function(i, n) {
						var t = $(n).text();
						if(t!="欢迎使用") {
							$('#tabs').tabs('close', t);
						}
					});
				}
				$("#switch_"+type+"_dialog").dialog('close');
				$("#main_"+type+"_showText").val(name+"："+$("#main_"+type+"Options").find("option:selected").text());
				$("#main_"+type+"_showText").css('color','#0000FF');
				$("#main_"+type+"_id").val($("#main_"+type+"Options").val());
			}
			setTimeout(function() {
				setMsgDivWidth();
				msgObj.ajaxResponseMsg($(".msg"), data);
			}, 150);
		}
	});
	
};

//<%-- 切换仓库 --%>
var doSwitchWarehouse = function() {
	doSwitchUserSite(bisUserSiteTypeObj.warehouse);
};
//<%-- 切换货主 --%>
var doSwitchOwner = function() {
	doSwitchUserSite(bisUserSiteTypeObj.owner);
};
//<%-- 切换平台 --%>
var doSwitchPlatForm = function() {
	doSwitchUserSite(bisUserSiteTypeObj.platForm);
};

//<%-- 用户登录到主页显示默认配置 --%>
function showDefaultUserSite(type){
	$.ajax({
		url : 'bisUserSite/showDefaultUserSite/'+type,
		type : 'POST',
		dataType : 'json',
		timeout : 60000,
		success : function(result) {
			$("#main_"+type+"_showText").val(result.defaultName);
			if(result.defaultId == null && bisUserSiteTypeObj.owner != type){
				$("#main_"+type+"_showText").css('color','red');
			}else{
				$("#main_"+type+"_id").val(result.defaultId);
			}
		}
	});
}
