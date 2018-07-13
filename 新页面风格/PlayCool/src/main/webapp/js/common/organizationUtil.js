$(function() {
	getOrgName();
});

/**
 *  获取组织(用户编辑)
 */
function getOrgName(){
	$.ajax({
        type : 'post',
        url : postPath+'/organization/getAllChannel',
        dataType : 'json',
        success : function(datas) {
        	if (datas != null) {
    			var option;
    			$.each(datas, function(i) {
    				if($("#organizationId").val() == datas[i].id){
    					option += "<option value='"+datas[i].id+"' selected>"+datas[i].name+"</option>";
    				}else{
    					option += "<option value='"+datas[i].id+"'>"+datas[i].name+"</option>";
    				}
    			});
    			$("#getOrgName").html(option);
    		}else{
    			$.messager.alert("系统提示", "登录失效,请重新登录。", "info", function(){
    				window.location.href = "/user/logout";
    			});
    		}
        } 
	});
}

//获取所有上级组织(添加组织)
function getAddChannel(){
	$.ajax({
        type : 'post',
        url : postPath+'/organization/getOrgs',
        dataType : 'json',
        success : function(datas) {
        	if (datas != null) {
        		var option = "<option value=' '>--无--</option>";
            	$.each(datas, function(i) {
            		option += "<option value='"+datas[i].id+"'>"+datas[i].name+"</option>";
            	});
            	$("#parentOrganization").html(option);
    		}else{
    			$.messager.alert("系统提示", "登入失效,请重新登入。", "info", function(){
    				window.location.href = "/user/logout";
    			});
    		}
        } 
	});
	getChannelType();
}

//获取去除自身的所有组织名称(组织编辑)
function getChannel(orgCode){
	$.ajax({
        type : 'post',
        url : postPath+'/organization/getOrgs',
        dataType : 'json',
        success : function(datas) {
        	if (datas != null) {
        		var option = "<option value=' '>--无--</option>";
            	$.each(datas, function(i) {
            		if(datas[i].code != orgCode) {
            			if($("#parentOrgId").val() == datas[i].id) {
            				option += "<option selected  value='"+datas[i].id+"'>"+datas[i].name+"</option>";
            			}else {
            				option += "<option value='"+datas[i].id+"'>"+datas[i].name+"</option>";
            			}
            		}
            	});
            	$("#parentOrganization").html(option);
    		}else{
    			$.messager.alert("系统提示", "登入失效,请重新登入。", "info", function(){
    				window.location.href = "/user/logout";
    			});
    		}
        } 
	});
	getChannelType();
}

function getChannelType(){
	$.ajax({
        type : 'post',
        url : postPath+'/organization/getChannelType',
        dataType : 'json',
        success : function(datas) {
        	if (datas != null) {
    			var option = "";/*<option value=' '>--请选择--</option>*/
    			$.each(datas, function(i) {
    					option += "<option value='"+datas[i].id+"' selected>"+datas[i].name+"</option>";
    			});
    			$("#getChannelType").html(option);
    		}else{
    			$.messager.alert("系统提示", "登入失效,请重新登入。", "info", function(){
    				window.location.href = "/user/logout";
    			});
    		}
        } 
	});
}
