/**
 * 
 */

//  获取权限name
$(function(){
	$.post(postPath+'/permission/getPermissionNames', function(datas) {
		if (datas != null) {
			var option = "<option value=''>--无--</option>";
			$.each(datas, function(i) {
				if($("#parentPer").val()==datas[i].id){
					option += "<option value='"+datas[i].id+"' selected >"+datas[i].name+"</option>";
				}else{
					option += "<option value='"+datas[i].id+"'>"+datas[i].name+"</option>";
				}
			});
			$("#parentPermission").html(option);
		}
	}, 'json');
});