
/**<img src='${pageContext.request.contextPath}/images/block.png'/>
 * @param 默认加载 省市
 */
$(function(){
	$("input[class='inputSelectOrg']").css({"height":"40px","width":"220px"});
	var city = "",district = "";
	 $('#area_province').combobox({
		valueField:'id',
		textField:'name',
		editable:false,
		required: true,
		url:postPath+"/bisProvince/getBisProvinces",
		method:"get",
		formatter:function(row){
			return "<img class='item-img' src='"+postPath+"/images/block.png'/> <span class='item-text'>"+row.name+"</span>";
		},
		onLoadSuccess:function(){
			if($("#provinceId").val() != null){
				$(this).combobox("select",$("#provinceId").val());
			}
		},
		onChange:function(provinceId, oldValue){
			city.combobox('disable');
			district.combobox('disable');
			$("#provinceId").val(provinceId);
			$.get(postPath+"/bisCity/getBisCitys/"+provinceId,function(data){
				city.combobox("clear").combobox('loadData',data);
				district.combobox("clear");
			},'json');
			city.combobox('enable');
		}
	});
	
	city = $('#area_city').combobox({
		valueField:'id',
		textField:'name',
		editable:false,
		required: true,
		panelHeight:"auto",
		formatter:function(row){
			return "<img class='item-img' src='"+postPath+"/images/block.png'/> <span class='item-text'>"+row.name+"</span>";
		},
		onLoadSuccess:function(){
			if($("#cityId").val() != null){
				$(this).combobox("select",$("#cityId").val());
				$("#cityId").val("");
			}
		},
		onChange:function(cityId, oldValue){
			district.combobox('enable');
			//$("#cityId").val(cityId);
			$.get(postPath+"/bisDistrict/getBisDistricts/"+cityId,function(data){
				district.combobox("clear").combobox('loadData',data);
			},'json');
		}
	});
	
	district = $('#area_district').combobox({
		valueField:'id',
		textField:'name',
		editable:false,
		//panelHeight:"auto",
		formatter:function(row){
			return "<img class='item-img' src='"+postPath+"/images/block.png'/> <span class='item-text'>"+row.name+"</span>";
		},
		onLoadSuccess:function(){
			if($("#districtId").val() != null){
				$(this).combobox("select",$("#districtId").val());
				$("#districtId").val("");
			}
		},
		onChange:function(districtId, oldValue){
			//$("#districtId").val(districtId);
		}
	});
});
/*$(function(){
	$.get(postPath+"/bisProvince/getBisProvinces",function(datas){
		var option = "<option value=' '>-- 请选择 --</option>";
		$.each(datas, function(i) {
			if($("#provinceId").val() == datas[i].id){
				option += "<option value='"+datas[i].id+"' selected>"+datas[i].name+"</option>";
			}else{
				option += "<option value='"+datas[i].id+"'>"+datas[i].name+"</option>";
			}
		});
		$("#province").html(option);
	});
	if($("#cityId").val() != null && $("#cityId").val() != ""){
		loadCity($("#provinceId").val());
	}
});

*//**
 * @param 加载城市
 * @param provinceId 省市 ID
 *//*
function loadCity(provinceId){
	$("#provinceId").val(provinceId);
	$.get(postPath+"/bisCity/getBisCitys/"+provinceId,function(datas){
		var option = "<option value=' '>-- 请选择 --</option>";
		$.each(datas, function(i) {
			if($("#cityId").val() == datas[i].id){
				option += "<option value='"+datas[i].id+"' selected>"+datas[i].name+"</option>";
			}else{
				option += "<option value='"+datas[i].id+"'>"+datas[i].name+"</option>";
			}
		});
		$("#city").html(option);
	});
	if($("#districtId").val() != null && $("#districtId").val() != ""){
		loadDistrict($("#cityId").val());
	}
}

*//**
 * @param 加载区域 
 * @param cityId 城市 ID 
 *//*
function loadDistrict(cityId){
	$("#cityId").val(cityId);
	$.get(postPath+"/bisDistrict/getBisDistricts/"+cityId,function(datas){
		if(datas != null && datas != ""){
			var option = "<option value=' '>-- 请选择 --</option>";
			$.each(datas, function(i) {
				if($("#districtId").val() == datas[i].id){
					option += "<option value='"+datas[i].id+"' selected>"+datas[i].name+"</option>";
				}else{
					option += "<option value='"+datas[i].id+"'>"+datas[i].name+"</option>";
				}
			});
			$("#district").html(option);
		}
	});
}

$("#district").change(function(){
	$("#districtId").val($("#district").val());
});

$("#city").change(function(){
	//$("#cityId").val($("#city").val());
	loadDistrict($("#city").val());
});

$("#province").change(function(){
	$("#cityId").val("");
	$("#district").empty();
	loadCity($("#province").val());
});
*/