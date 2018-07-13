$(function(){
    var strPath = window.document.location.pathname;
    var postPath = strPath.substring(0, strPath.substr(1).indexOf('/') + 1);
	// 获取组织类型
	$.ajax({
        type : 'post',
        url : postPath+'/organization/getChannelType',
        dataType : 'json',
        success : function(datas) {
        	if (datas != null) {
    			var option = "<option value=''>--请选择--</option>";
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
	
	// 获取组织名称
	$.ajax({
        type : 'post',
        url : postPath+'/organization/getOrgs',
        dataType : 'json',
        success : function(datas) {
        	if (datas != null) {
    			var option = "<option value=''>--请选择--</option>";
    			$.each(datas, function(i) {
    				if($("#parentOrgId").val() == datas[i].id){
    					option += "<option value='"+datas[i].id+"' selected>"+datas[i].name+"</option>";
    				} else {
        				option += "<option value='"+datas[i].id+"'>"+datas[i].name+"</option>";
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
	
	$.post(postPath+'/permission/getPermissionNames', function(datas) {
		if (datas != null) {
			var option = "<option vlaue=''>--请选择--</option>";
			$.each(datas, function(i) {
				if($("#parentPer").val()==datas[i].id){
					option += "<option value='"+datas[i].id+"' selected >"+datas[i].name+"</option>";
				}
					option += "<option value='"+datas[i].id+"'>"+datas[i].name+"</option>";
			});
			$("#parentPermission").html(option);
		}
	}, 'json');
});

