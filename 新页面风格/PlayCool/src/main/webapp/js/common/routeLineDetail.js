/**<img src='${pageContext.request.contextPath}/images/block.png'/>
 * @param 默认加载 途径省市区地址
 */
$(function(){
	$("input[id^='from_area_']").css({"height":"40px","width":"220px"});
	var city = "",district = "",address="";
	 $('#way_area_province').combobox({
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
	
	city = $('#way_area_city').combobox({
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
			$.get(postPath+"/bisDistrict/getBisDistricts/"+cityId,function(data){
				district.combobox("clear").combobox('loadData',data);
			},'json');
		}
	});
	
	district = $('#way_area_district').combobox({
		valueField:'id',
		textField:'name',
		editable:false,
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
			address.combobox('enable');
			$.get(postPath+"/bisTransLocation/getBisTransLocation/"+districtId,function(data){
				address.combobox("clear").combobox('loadData',data);
			},'json');
		}
	});
	
	address = $('#way_area_address').combobox({
		valueField:'id',
		textField:'address',
		editable:false,
		formatter:function(row){
			return "<img class='item-img' src='"+postPath+"/images/block.png'/> <span class='item-text'>"+row.address+"</span>";
		},
		onLoadSuccess:function(){
			if($("#id").val() != null){
				$(this).combobox("select",$("#id").val());
				$("#id").val("");
			}
		},
		onChange:function(districtId, oldValue){
		}
	});
});

//添加路线信息详情
function saveRouteLineDetail(name){
	var vldate = $('#'+name+'_addForm').form('validate');//验证表单数据
	var formData = $('#'+name+'_addForm').serialize();//序列化表单
	if(vldate) {
		$.ajax({
			url:postPath+'/'+name+'/add',//请求url
			method:'post',
			data:formData,
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : 'json',
			cache: false,
			success : function(data){
				if(data.additionalMsg.status == "成功"){
					refreshDatagrid(name);
					resetForm(name);
				}
				msgObj.ajaxResponseMsg($("#"+name+"_msg"), data);
			}
		});
	} else {
		$.messager.alert("提示", "表单信息填写不完整，带<font color='red'>*</font>为必填项！","info");
	}
}