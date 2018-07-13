<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>utilPage</title>
</head>
<body>
</body>

<script type="text/javascript">
var sy = $.extend({},sy);/*定义全局对象*/
var reloades = $.extend({},reloades);/*定义全局对象*/
reloades  = $("div.main-data table");
var strPath = window.document.location.pathname;
var postPath = strPath.substring(0, strPath.substr(1).indexOf('/') + 1);		// 得到项目路径


   
sy.serialieObject = function(form) {/* 将from表单元素的值序列化成对象*/
	var o = {};
	$.each(form.serializeArray(), function(index) {
		if (o[this['name']]) {
			o[this['name']] = o[this['name']] + "," + $.trim(this['value']);
		} else {
			o[this['name']] = $.trim(this['value']);
		}
	});
	return o;
};

sy.serialieString = function(form) {/* 将from表单元素的值反序列化成参数字符串*/
	var s = "?";
	var obj = sy.serialieObject(form);
	for(var prop in obj){  
		s+=prop+"="+obj[prop]+"&";
    }
	s = s.substring(0, s.length-1);
	return s;
};

/////////////////////////////datagrid 相关 begin////////////////////////////////////////////////
/**
 * 创建datagrid公用调用函数
 * @param t {Object} :页面的table jq对象
 * @param srchForm :{Object} 页面的查询表单 jq对象
 * @param rightMenuFun :{function} 函数变量
 * @param isMsg {Boolean} 是否显示提示消息（右下角）——true为不显示，此参数不写或false为显示
 * @param pageSize {number} datagrid 的pageSize 如果此参数不写跟第一层页面的pageSize相等
 */
sy.createDatagrid = function(t,srchForm,rightMenuFun,isMsg,pageSize,isShowPageButton) {
	var queryParams =  sy.serialieObject(srchForm);
	/* var colss =  columnsLayout.createColumns(t);
	if(colss != ""){
		t.children().remove();
	} */
	var newColumns = null;
	sy.createDatagrid2(t,queryParams,rightMenuFun,isMsg,pageSize,newColumns,isShowPageButton);
};
/**
 * 创建datagrid公用调用函数
 * @param t {Object} :页面的table jq对象
 * @param queryParams :{Object} 查询参数
 * @param rightMenuFun :{function} 函数变量
 * @param isMsg {Boolean} 是否显示提示消息（右下角）——true为不显示，此参数不写或false为显示
 * @param pageSize {number} datagrid 的pageSize 如果此参数不写跟第一层页面的pageSize相等
 */
sy.createDatagrid2 = function(t,queryParams,rightMenuFun,isMsg,pageSize,newColumns,isShowPageButton) {
	var expand_num = 0;
	var name = t.attr('id');
	var intiPageSize;
	if(pageSize != null) {
		intiPageSize = pageSize;
	 console.info(pageSize);
	}else {
		intiPageSize = parseInt((window.document.body.clientHeight-86)/25);//大概的计算，不精确
	}
	t.datagrid({
		url:'${pageContext.request.contextPath}' + "/process", 
		fit:true,
		autoRowHeight:true,
		method:'POST',
		async:false,
		columns: newColumns,
		striped: true,
		pagination : true,//显示最下端的分页工具栏			
		pageSize : 28,//读取分页条数，即向后台读取数据时传过去的值			
		pageList : [5,10,30,50,100,150,200,300,28], //可以调整每页显示的数据，即调整pageSize每次向后台请求数据时的数据			
		queryParams : queryParams,
		frozenColumns : [ [ {
			field : 'ids',
			checkbox : true,
			formatter:function(value,row,index) {
				if (row != null && row.id != null) {
					return row.id;
				} else {
					return "";
				};
			}
		}]],
		onClickRow:function(index,row){
		    //-------------for TEST 结合SHIFT,CTRL,ALT键实现单选或多选----------------      
		     if(index != selectIndexs.firstSelectRowIndex && !inputFlags.isShiftDown ){    
		        selectIndexs.firstSelectRowIndex = index; //alert('firstSelectRowIndex, sfhit = ' + index);  
		    }             
		    if(inputFlags.isShiftDown ) {  
		        t.datagrid('clearSelections');                  
		        selectIndexs.lastSelectRowIndex = index;  
		        var tempIndex = 0;  
		        if(selectIndexs.firstSelectRowIndex > selectIndexs.lastSelectRowIndex ){  
		            tempIndex = selectIndexs.firstSelectRowIndex;  
		            selectIndexs.firstSelectRowIndex = selectIndexs.lastSelectRowIndex;  
		            selectIndexs.lastSelectRowIndex = tempIndex;  
		        }  
		        for(var i = selectIndexs.firstSelectRowIndex ; i <= selectIndexs.lastSelectRowIndex ; i++){  
		           t.datagrid('selectRow', i);     
		        };     
		    }
		    if(!inputFlags.isShiftDown && !inputFlags.isCtrlDown) {
		    	var l = t.datagrid('getSelections').length;
		    	t.datagrid('clearSelections');
		    	if(l != 0) {//l==0为单击已选行
    				t.datagrid('selectRow', index);
		    	}
		    }
		    //-------------for TEST 结合SHIFT,CTRL,ALT键实现单选或多选----------------  
		},
		rowStyler: function(index,row) {
			if (index%2 != 0){
				return 'height:23.2px;';//background-color:#D9E8FB;color:black;
			} else {
				return 'height:23.2px;';
			}
		},
		onBeforeLoad : function(queryParams){
			if(queryParams.hasOwnProperty('isMsgParam')){
				isMsg = true;
				delete queryParams.isMsgParam;
			}
			return true;
		},
		onLoadSuccess : function(data) {
			 //global.getMenu(name); 
			 //-------表格样式调整--------//
			//datagrid头部 table 的第一个tr 的td们，即columns的集合
		    var headerTds = t.parent().find(".datagrid-view2").children(".datagrid-header").find("table tr:first-child").children(":visible");
		    //datagrid主体 table 的第一个tr 的td们，即第一个数据行
		    var bodyTds = t.parent().find(".datagrid-view2").children(".datagrid-body").find("table tr:first-child").children(":visible");
		  	
		  	//datagrid-body宽度
			var bodyWidth = t.parent().find(".datagrid-view2").children(".datagrid-header").width();
			//datagrid-btable宽度
			var tableWidth = t.parent().find(".datagrid-view2").children(".datagrid-header").find(".datagrid-htable").width();
			
		    //循环设置对齐方式
		    for(var i=0;i<headerTds.length;i++) {
		        $("div:first-child", headerTds.get(i)).css("text-align", "left");
		        $("div:first-child", headerTds.get(i)).css("font-weight", "bold");
		        if (bodyTds.length>0) {
		            $("div:first-child", bodyTds.get(i)).css("text-align", "left");
		            $("div:first-child", bodyTds.get(i)).css("margin-left", "1px");
		        }
		    }  
			
			//如果tableWidth<bodyWidth扩充每一列(初始化)
		      if(parseInt(bodyWidth)-parseInt(tableWidth) > 10) { //
		    	var increment = (bodyWidth-tableWidth)/(headerTds.length);
		    	//循环扩充
		    	for(var i=0;i<headerTds.length;i++) {
		    		var headerTdWidth = $("div:first-child",headerTds.get(i)).width();
		    		var bodyTdWidth = $(headerTds.get(i)).width();
		        	$("div:first-child",headerTds.get(i)).width(headerTdWidth+increment);//列标题扩充
		        	if (bodyTds.length>0) {
		            	$(bodyTds.get(i)).width(bodyTdWidth+increment+1);//数据主体扩充
		            }
		        }
		    	//定义全局变量
		    	//expand_num = 1;
		    }else {//防止点击刷新时再扩充  if(!isInit)
		    	for(var i=0;i<headerTds.length;i++) {
		    		
		    		var headerTdWidth = $("div:first-child",headerTds.get(i)).width();
		    		var bodyTdWidth = $(headerTds.get(i)).width();
		    		
		        	$("div:first-child",headerTds.get(i)).width(headerTdWidth);//列标题扩充
		        	if (bodyTds.length>0) {
			            $(bodyTds.get(i)).width(bodyTdWidth+1);//数据主体扩充
		            }
		        }
		    } 
			
			var _body = t.parent().find(".datagrid-view2").children(".datagrid-body");
			var _row = t.parent().find(".datagrid-header-row");
			if(data.total == 0){ noData(_body,_row); } //无数据时滚动条显示问题修复
			//-----------提示消息--------------//
			if(!isMsg) {
	            /* $.messager.show({
					//title: "" + data.additionalMsg.status,
					msg:"耗时："+data.additionalMsg.processTime+" 秒!",
					timeout:1500,
					width:150,
					height:40
				}); */
				var msgTarget = parent.$('#top-bar_msg');
				msgObj.ajaxResponseMsg(msgTarget, data);
			}
			sy.createMenu(name,rightMenuFun); //创建右键菜单(放在此处防止列拖拽后右键菜单失效)
			if("undefined" == typeof isShowPageButton){
				sy.pageButtons(t);
			}
		},
		onLoadError : function() { 
			//$.messager.alert('错误', "加载失败！", 'error');
		}
	}).datagrid('columnMoving');
};

//创建右键菜单
sy.createMenu = function(name,rightMenuFun) {
	$("#"+name).parent().children(".datagrid-view2").children(".datagrid-body").mousedown(function(e){
		 $(document).bind("contextmenu",function(e){
			 e.preventDefault(); 
	         return false;
	 	 });
		 var menuLen = $("#"+name+"_menu").children().length;
		 if(menuLen != 0){
			 if(3 == e.which){ 
			   	if($("#"+name+"_menu").children().size() != 0){
			   		$("#"+name+"_menu").menu('show', {
			   	      	left : e.pageX,
			   	      	top : e.pageY
			   		});
			   	}
				var rows = $("#"+name).datagrid("getRows");
				if(rows.length == 0){
					$("#"+name+"_menu").menu("disableItem",$("#"+name+"_export"));
				}else{
					$("#"+name+"_menu").menu("enableItem",$("#"+name+"_export"));
				}	
				rightMenuFun();
				return false;
			 } 
		 } 
	});
};

//结合SHIFT,CTRL,ALT键实现单选或多选  
//-------------------------------------------------------------------------------  
var KEY = { SHIFT:16, CTRL:17, ALT:18, DOWN:40, RIGHT:39, UP:38, LEFT:37};    
var selectIndexs = {firstSelectRowIndex:0, lastSelectRowIndex:0};  


var inputFlags = {isShiftDown:false, isCtrlDown:false, isAltDown:false};  
  
sy.keyPress = function keyPress(event,t){//响应键盘按下事件  
    var e = event || window.event;    
    var code = e.keyCode | e.which | e.charCode;        
    switch(code) {    
        case KEY.SHIFT:    
        inputFlags.isShiftDown = true;  
        //t.datagrid('options').singleSelect = false;             
        break; 
        
     	case KEY.CTRL:  
        inputFlags.isCtrlDown = true;  
        //t.datagrid('options').singleSelect = false;             
        break;  
    /*
    case KEY.ALT:    
        inputFlags.isAltDown = true; 
        $('#dataListTable').datagrid('options').singleSelect = false;            
        break; 
    */    
   default:          
    }  
};  
  
sy.keyRelease = function keyRelease(event,t) { //响应键盘按键放开的事件  
    var e = event || window.event;    
    var code = e.keyCode | e.which | e.charCode;        
    switch(code) {    
        case KEY.SHIFT:   
        inputFlags.isShiftDown = false;  
        selectIndexs.firstSelectRowIndex = 0;  
        //t.datagrid('options').singleSelect = true;              
        break;  
     	case KEY.CTRL:  
        inputFlags.isCtrlDown = false;  
        selectIndexs.firstSelectRowIndex = 0;  
        //t.datagrid('options').singleSelect = false;  
        break;   
    /* 
    case KEY.ALT:    
        inputFlags.isAltDown = false; 
        selectIndexs.firstSelectRowIndex = 0; 
        $('#dataListTable').datagrid('options').singleSelect = true;             
        break; 
    */  
     default:          
    }  
};


//键盘按下事件
function keyPressImpl(event,name) {
	sy.keyPress(event, $("#"+name));
}

//键盘松开事件
function keyReleaseImpl(event,name) {
	sy.keyRelease(event, $("#"+name));
} 

//打开查询窗口
function simpleSearch(name) {
	var divName = name+"_srchDiv";
	$("#"+divName).dialog({modal:true,iconCls:'icon-search'});
	$("#"+divName).dialog('open');
}

//查找按钮  
function tj_query(name){
	//$("#"+name+"_srchDiv").dialog('close');
	refreshDatagrid(name);
}


function tj_query2(name){
	//$("#"+name+"_srchDiv").dialog('close');
	refreshDatagrid(name);
}

//刷新datagrid
function refreshDatagrid(name,isMsg) {
	var srcFormObj = $('#'+name+'_srchForm');
	var queryParams = sy.serialieObject(srcFormObj);
	if("undefined" != typeof isMsg){
		queryParams.isMsgParam = "-1";
	}
	$("#"+name).datagrid('reload',queryParams);  
}
//全部查找  重置
function querryAll(name) {
	sy.cleanSearch(name);
	tj_query(name);
}
//全部查找  清空表单数据
function realQuerryAll(name) {
	sy.realCleanSearch(name);
	tj_query(name);
}

//查找dialog回车查询功能
function Enter_query(name) {
	$("#"+name+"_srchForm").bind('keyup', function(event) {
		if (event.keyCode == "13") {
			tj_query(name);
		}
	});
	document.onkeydown = function(event) {
			var e = event || window.event || arguments.callee.caller.arguments[0];
			if (e && e.keyCode == 27) { // 按 Esc 
				$("#"+name+"_srchDiv").dialog('close');
			}
	};
}

//表格布局保存
function saveColumns(name){
	columnsLayout.saveColumns(name);
}

	//点击重置按钮触发事件		
	sy.cleanSearch = function(name) {
		$("#" + name + "_srchForm").form('reset');
	};
	//点击清空按钮触发事件		
	sy.realCleanSearch = function(name) {
		$("#" + name + "_srchForm table").form('clear');
	};

	/* function closeDialog(name) { // 关闭窗口
	 $('#'+name).dialog('close');
	 // 刷新
	 //$('#'+name).datagrid('reload');
	 parent.window.document.getElementById(name).datagrid('reload');
	 } */
	/**
	 * 为datagrid、treegrid增加表头菜单，用于显示或隐藏列，注意：冻结列不在此菜单中 
	 * start
	 */
	var createGridHeaderContextMenu = function(e, field) {
		e.preventDefault();
		var grid = $(this);/* grid本身 */
		var headerContextMenu = this.headerContextMenu;/* grid上的列头菜单对象 */
		if (!headerContextMenu) {
			var tmenu = $('<div style="width:100px;"></div>').appendTo('body');
			var fields = grid.datagrid('getColumnFields');
			for (var i = 0; i < fields.length; i++) {
				var fildOption = grid.datagrid('getColumnOption', fields[i]);
				if (!fildOption.hidden) {
					$('<div iconCls="icon-checked" field="' + fields[i] + '"/>')
							.html(fildOption.title).appendTo(tmenu);
				} else {
					$(
							'<div iconCls="icon-no_checked" field="' + fields[i] + '"/>')
							.html(fildOption.title).appendTo(tmenu);
				}
			}
			headerContextMenu = this.headerContextMenu = tmenu.menu({
				onClick : function(item) {
					var field = $(item.target).attr('field');
					if (item.iconCls == 'icon-checked') {
						grid.datagrid('hideColumn', field);
						$(this).menu('setIcon', {
							target : item.target,
							iconCls : 'icon-no_checked'
						});
					} else {
						grid.datagrid('showColumn', field);
						$(this).menu('setIcon', {
							target : item.target,
							iconCls : 'icon-checked'
						});
					}
				}
			});
		}
		headerContextMenu.menu('show', {
			left : e.pageX,
			top : e.pageY
		});
	};
	$.fn.datagrid.defaults.onHeaderContextMenu = createGridHeaderContextMenu;
	$.fn.treegrid.defaults.onHeaderContextMenu = createGridHeaderContextMenu;

	/**
	 * 为datagrid、treegrid增加表头菜单，用于显示或隐藏列，注意：冻结列不在此菜单中 
	 * end
	 */
	//自定义分页栏按钮
	sy.pageButtons = function(t) {
		var name = t.attr("id");
		var pager = t.datagrid('getPager'); // 得到datagrid的pager对象
		//按钮数组
		var buttonsArray = [/* {
			text : '保存',
			iconCls : 'icon-save',
			handler : function() {
				saveColumns(name);
			}
		}, */ {
			text : '功能性按钮',
			iconCls : 'icon-reload',
			handler : function() {
				sy.createMobileMenu(name);
			}	
		}];
		//查找按钮
		if($("#"+name+"_srchForm").find("table").eq(0).length > 0) {
			var querry_button = {
				text : '查找',
				iconCls : 'icon-search',
				handler : function() {
					simpleSearch(name);
				}	
			};
			buttonsArray.push(querry_button);
		}
		pager.pagination({
			buttons : buttonsArray
		});
	};

	//创建手机版右键菜单
	sy.createMobileMenu = function(name) {
		$("#"+name+"_menu").menu('show', {
		      	left :$(window).width()/2,
		      	top : $(window).height()/2-170
			});
	};
	///////////////////////////datagrid 相关 end///////////////////////////////////////

	//获取所选记录id
	sy.getSelectionsIds = function(t) {
		var ids = "";
		var selections = t.datagrid('getSelections');
		if (selections.length > 0) {
			for (var i = 0; i < selections.length; i++) {
				ids += selections[i].id + ",";
			}
			ids = ids.substring(0, ids.length - 1);
		}
		return ids;
	};

	//格式化显示enabled
	sy.format_enabled = function(value, row, index) {
		if (value) {
			return "是";
		} else {
			return "否";
		}
	};

	//根据%设置列宽
	sy.getWidth = function getWidth(percent) {
		return document.body.clientWidth * percent;
	};

	//日期格式化
	Date.prototype.format = function(format) {
		var o = {
			"M+" : this.getMonth() + 1, //month 
			"d+" : this.getDate(), //day 
			"h+" : this.getHours(), //hour 
			"m+" : this.getMinutes(), //minute 
			"s+" : this.getSeconds(), //second 
			"q+" : Math.floor((this.getMonth() + 3) / 3), //quarter 
			"S" : this.getMilliseconds()
		//millisecond 
		};

		if (/(y+)/.test(format)) {
			format = format.replace(RegExp.$1, (this.getFullYear() + "")
					.substr(4 - RegExp.$1.length));
		}

		for ( var k in o) {
			if (new RegExp("(" + k + ")").test(format)) {
				format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]
						: ("00" + o[k]).substr(("" + o[k]).length));
			}
		}
		return format;
	};

	function closelimitDialog() { // 关闭导出窗口
		$("#limitDialog").dialog('close');
	}

	function openlimitDialog() { // 关闭导出窗口
		$("#limitDialog").dialog('open');
	}

	//新增tabs
	function addTabs(title, url) {
		$("#menu").menu('hide');//隐藏本右键菜单
		var tabsObj = parent.$("#tabs");//获取父页面DOM
		if (tabsObj.tabs('exists', title)) {
			tabsObj.tabs('select', title);
		} else {
			var content = '<iframe scrolling="auto" frameborder="0"  src='
					+ url
					+ ' style="padding:0;margin:0;width:100%;height:100%;"></iframe>';
			tabsObj.tabs('add', {
				title : title,
				content : content,
				closable : true,
				fit : true
			});
		}
		parent.tabClose();//父页面js函数调用
		parent.tabCloseEven();
	}

	//编辑tabs
	function editTabs(title, name) { // 编辑窗口
		// 获取选中的对象
		var selectRow = $("#" + name).datagrid('getSelections');
		indexName = name;
		if (selectRow.length == 1) {
			var url = name + "/edit/" + selectRow[0].id;
			console.info(url);
			addTabs(title, url);
		} else {
			$.messager.alert('Warning', '请勾选一行记录', 'warning');
		}
	}

	//绑定
	function bind(title, name, url) {
		// 获取选中的对象
		var selectRow = $("#" + name).datagrid('getSelections');
		if (selectRow.length == 1) {
			url = url + '?id=' + selectRow[0].id + "&name=" + selectRow[0].name;
			addTabs(title, url);
		} else {
			$.messager.alert('提示', '请勾选一行记录!', 'warning');
		}
	}

	/**
	 * Datagrid no data show content 
	 *   if need please add to my list page table a class 'easy-table' attredate
	 * 		Then accroding self needs insert to show page
	 */
	function noData(_body, _row) {
		var idValue = $(".no-data-non-show-msg").attr("id");
		_body.html("<div style='width:" + _row.eq(1).width()
				+ "px;border:solid 0px;height:1px;'></div>");
		if (typeof (idValue) == "undefined") {
			_body
					.html("<div style='width:"
							+ _row.eq(1).width()
							+ "px;border:solid 0px;height:1px;'></div>"
							+ '<div width="'
							+ _row.eq(1).width()
							+ '" style="position:absolute; top:30%; left:36%; text-align: center;" colspan="6"><tr><td><h2>未找到符合条件的数据!</h2></td></tr></div>');
		}
		/* var idValue = $(".easy-table").attr("id");
		var imgName = "bluefaces_nodata.png";
		var message = "Sorry ! 没有搜索到相关数据...";
		if(typeof(idValue) != "undefined" ){
			if(idValue == 'wmsTask'){
				_png = "bluefaces_no.png";
				message = "Sorry ! 没有搜索到相关数据...";
			}
			if(idValue == 'wmsTaskLog'){
				_png = "bluefaces_no.png";
				message = "Sorry ! 没有搜索到相关作业日志...";
			}
			var _img = "<img src='${pageContext.request.contextPath}/images/"+ imgName +"'><h2>"+ message +"</h2>";
			_body.html('<div width="'+ _row.eq(1).width()+ '" style="position:absolute; top:30%; left:36%; text-align: center;" colspan="6"><tr><td>'+_img+'</td></tr></div>');
		} */
	}

	// get tag layout width - 170
	function getWidth() {
		return $(window).width() - 170;
	}

	// get tag layout height - 150
	function getHeight() {
		return $(window).height() - 150;
	}
	
	/**
	 * 	导出数据
	 * @param _url 请求
	 */
	function exportXls(_url){
		// 导出失效
		disabledExport();
		var formId = $("div[id*='_srchDiv'] form").attr("id");
		location.href = _url+'?' + $("#"+formId).serialize();
	}
	/** 导出按钮定时切换 begin */
	var loop = 0;
	var sh;
	// 按钮失效
	function disabledExport(){ 
		var _par = $("div[id*='_export']").parent();
		var _self = $("div[id*='_export']");
		_par.menu('disableItem', _self);
		loop=0;
		sh=setInterval(succ,30000);
	}
	// 定时任务
	function succ(){
		loop ++;
		if (loop > 1){
			enabledExport(); 
			clearInterval(sh);
			return; 
		}
	}
	// 恢复按钮功能
	function enabledExport()
	{ 
		var _par = $("div[id*='_export']").parent();
		var _self = $("div[id*='_export']");
		_par.menu('enableItem', _self);
	}
	/** 导出按钮定时切换 begin */
</script>
</html>