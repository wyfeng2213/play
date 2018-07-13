var strPath = window.document.location.pathname;
var postPath = strPath.substring(0, strPath.substr(1).indexOf('/') + 1);

//========================dialog形式弹出框 begin================================//
/**
 * 打开dialog再次封装
 * @param name {String} :父页面（即右键菜单所在的页面）table的ID名!!!!!!!
 * @param url :{String} 请求url
 * @param title {String} dialog标题
 * @param isMax {Boolean} 是否最大化窗口 true表示最大化，false表示根据后两个参数规定dialog大小
 * @param width {number} dialog宽度
 * @param height {number} dialog高度
 */
function openDialog(name,url,title,isMax,width,height) {
	var onCloseFun = function(name){
		$("#"+name+"_tempDialog").remove();
		refreshDatagrid(name);//关闭刷新父页面，该函数在listUtil.jsp
	};
	openDialogAdaptOnCloseFun(name,url,title,isMax,width,height,onCloseFun);
}
/**
 * openDialog 增强版 可自定义onClose事件-注意带上参数name
 */
function openDialogAdaptOnCloseFun(name,url,title,isMax,width,height,onCloseFun) {
	var dialogName = name+"_tempDialog";
	eventKey(dialogName);
	$("<div id='"+dialogName+"'></div>").appendTo('body');//将临时dialog容器添加到body中
	var target = $("#"+dialogName);
	target.dialog({    
		title: title,    
		width: width,    
		height: height,
		iconCls:"icon-application-edit",
		closed: true,
		cache: false,    
		modal: true,
		onClose: function(){
			onCloseFun(name);
		},
		onOpen:function() {
			if(isMax) {
				target.panel('maximize');
			}
			target.dialog('refresh',url);
		}
	});
	msgObj.clearMsg($('.msg'));//清除所有的消息提示div内容
	msgObj.clearMsg(parent.$('.msg'));//清除所有的消息提示div内容
	target.dialog('open');
}
/**
*打开 添加dialog 三次封装opendialog
*@param name: 对应请求url的controller的
*@param title: dialog标题
*@param width: dialog宽度
*@param height: dialog宽度
*@param parentName: 可不写，请求uri与tableId不相同时要加上此参数！！！
*/
function addFun(name,title,width,height,parentName) {
	var url = postPath+'/'+name+'/add';
	if("undefined" != typeof parentName){//如果parentName定义
		name = parentName;
	}
	openDialog(name,url,title,false,width,height);
}
/**
 *最大化打开 添加dialog 三次封装opendialog
 *@param name: 对应请求url的controller的
 *@param height: dialog宽度
 *@param parentName: 父页面datagrid-table的id名 可不写，请求uri与tableId不相同时要加上此参数！！！
 */
function addFun_max(name,title,parentName) {
	var url = postPath+'/'+name+'/add';
	if("undefined" != typeof parentName){//如果parentName定义
		name = parentName;
	}
	openDialog(name,url,title,true);
}

/**
*打开 修改dialog 三次封装opendialog
*@param name: dialog容器的id前缀名
*@param title: dialog标题
*@param width: dialog宽度
*@param height: dialog宽度
*/
function editFun(name,title,width,height,parentName){
	var url = postPath+'/'+name+'/edit/';
	if("undefined" != typeof parentName){
		name = parentName;
	}
	var selections = $("#"+name).datagrid('getSelections');
	if(selections.length == 1) {
		if (selections[0].id == undefined) {
			url +=  selections[0].ID;
		}else {
			url +=  selections[0].id;
		}
		openDialog(name,url,title,false,width,height);
	}else {
		$.messager.alert('提示','请勾选一行记录!','warning');
	}
}
/**
 *最大化打开 修改dialog 三次封装opendialog
 *@param name: dialog容器的id前缀名
 *@param title: dialog标题
 *@param parentName: 父页面datagrid-table的id名 可不写，请求uri与tableId不相同时要加上此参数！！！
 */
function editFun_max(name,title,parentName){
	var url = postPath+'/'+name+'/edit/';
	if("undefined" != typeof parentName){
		name = parentName;
	}
	var selections = $("#"+name).datagrid('getSelections');
	if(selections.length == 1) {
		url +=  selections[0].id;
		openDialog(name,url,title,true);
	}else {
		//msgObj.invalidSelectMsg(target);
		$.messager.alert('提示','请勾选一行记录!','warning');
	}
}

//===========================dialog形式弹出框 end=====================================//

/**
*重置表单
*适用于添加页面
*@param name: 添加表单id的前缀名
*/
function resetForm(name) {//name:添加表单的id前缀名
	$('#'+name+'_addForm').form('reset');
}

/**
*保存功能按钮
*适用于添加页面
*@param name: 添加表单id的前缀名
*@param isReset: 是否重置表单
*@param isRefreshData: 是否刷新datagrid数据
*/
function saveData(name,isReset,isRefreshData) {
	console.log("saveData---");
	var vldate = $('#'+name+'_addForm').form('validate');//验证表单数据
	// 针对组织类型 checkbox peng.wu
	if(name == "bisOrganization"){
		if(!formChecked()){
			vldate = false;
		}
	}
	var formData = $('#'+name+'_addForm').serialize();//序列化表单
	var urltest=postPath+'/'+name+'/add';
	console.log("url---"+urltest);
	if(vldate) {
		$.ajax({
			url:postPath+'/'+name+'/add',//请求url
			method:'post',
			data:formData,
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : 'json',
			cache: false,
			success : function(data){
				if (data.additionalMsg.status == "成功") {
					if("undefined" != typeof isReset){//是否重置表单
						resetForm(name);
						if("undefined" != typeof isRefreshData){//刷新datagrid数据
							refreshDatagrid(name,true);
						}
					}
				}
				msgObj.ajaxResponseMsg($('#'+name+'_msg'), data);
			}
		});
	} else {
		msgObj.validateFailMsg($('#'+name+'_msg'));
	}
}

/**
*修改 功能按钮
*适用于修改页面
*@param name: 修改表单id的前缀名 {String}
*/
function editData(name) {
	var formObj = $('#'+name+'_editForm');
	editData2(formObj);
}

//编辑 (参数为表单对象 {Object})
/**
*修改 功能按钮
*适用于修改页面 和添加页面保存后变为的修改按钮
*@param formObj: 修改页面的表单对象 {Object}
*/
function editData2(formObj) {
	var formObj_id = formObj.attr("id");
	var _index = formObj_id.indexOf("_");
	var name = formObj_id.substring(0,_index);
	var vldate = formObj.form('validate');
	var formData = formObj.serialize();
	if(vldate) {
		$.ajax({
			url:postPath+'/'+name+'/edit',//请求url
			method:'post',
			data:formData,
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : 'json',
			cache: false,
			success : function(data){
				msgObj.ajaxResponseMsg($('#'+name+'_msg'), data);
			}
		});
	} else {
		msgObj.validateFailMsg($('#'+name+'_msg'));
	}
}

//修改状态
function changeStatus(name,status){
	var selections = $("#"+name).datagrid('getSelections');
	if(selections.length != 1) {
		$.messager.alert('提示','请勾选一行记录!','warning');
	}else {
		$.ajax({
			url:'changeStatus?id='+selections[0].id+'&status='+status,
			method:'post',
			success:function(data){
				tj_query(name);
			}
		});
	}
}

/**
 *  删除数据 可批删
 */
function deleteByIds(name,_url){
	$.messager.confirm("消息提示", "删除之后将不可恢复，确定要删除选中数据 ?", function(r){
		if(r){
			var rows = $("#"+name).datagrid('getSelections');
			var _ids = [];
			for (var i = 0; i < rows.length; i++) {
				_ids.push(rows[i].id);
			}
			$.ajax({
				url:_url,
				method:'POST',
				dataType:"JSON",
				data:{
					ids:_ids.join(",")
				},
				success:function(data){
					msgObj.ajaxResponseMsg(parent.$(".msg"), data);
					refreshDatagrid(name,true);
				}
			});
		}
	});
}

/**
 * @param dialogName 按键 Esc   
 * @description 关闭 id 为 dialogName（参数） dialog
 */
function eventKey(dialogName) {
	document.onkeydown = function(event) {
			var e = event || window.event || arguments.callee.caller.arguments[0];
			if (e && e.keyCode == 27) { // 按 Esc 
				$("#"+dialogName).dialog('close');
			}  
		};
}

/**
 *  获取货品信息
 * @param 
 * @date   2014年8月28日 下午1:36:57
 */
var getBisProduct = function(){
	var grid = $('#product_id').combogrid('grid');	// 获取数据表格对象
	var row = grid.datagrid('getSelected');		// 获取选择的行
	$.ajax({
		url : postPath+'/bisProduct/getBisProduct',
		method : 'POST',
		data : {id : row.id},
		dataType : 'json',
		success : function(data){
			$("#unit").val(data.baseUnit);
		}
	});
};