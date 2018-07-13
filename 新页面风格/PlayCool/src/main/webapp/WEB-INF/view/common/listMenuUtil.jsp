<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript">
	var pageId , global = $.extend({},global);/*定义全局对象*/
	
	global.getMenu = function(name){
		//var iframe_id = parent.$("#tabs iframe[src*='"+name+"/']").attr("id");
		var iframe_id = parent.$("#tabs").children("div:last-child").children("div:visible").children().children("iframe").attr("id");
		var isSecondPage = $("div[id$='_tempDialog']").length;
		if(typeof(iframe_id) != "undefined" && isSecondPage == 0){
			global.pageId = iframe_id;
			$("#"+name+"_menu").children().remove();
			$("#"+name+"_menu").empty();
			$.get("${pageContext.request.contextPath}/menuButton/getMenusByUserPage",{pageId : iframe_id},function(datas){
				if(datas.length != 0){
					$.each(datas,function(i){
						if(datas[i].type != 1){
			   				$("#"+name+"_menu").menu('appendItem', {  	
			   					id: datas[i].nodeId,
			   				    text: datas[i].name,  	
			   				    iconCls: datas[i].iconCls, 
			   				    onclick: datas[i].btMethod
			   				});
						}else{
							if(datas.length - 1 != i){
		   						$("<div class='menu-sep'></div>").appendTo("#"+name+"_menu");
							}
						}
					});
				}
			},"JSON");
		}
	}
	 
	global.showMenu = function(e, _obj, rightMenuFun) {
		 _obj.mousedown(function(e) {
			$('body').bind("contextmenu", function(e) {
				e.preventDefault();
				return false;
			});
			if (3 == e.which) {
				if ($("#" + name + "_menu").children().size() != 0) {
					$("#" + name + "_menu").menu('show', {
						left : e.pageX,
						top : e.pageY
					});
				}
				rightMenuFun();
				return false;
			}
		});
	};
</script>
