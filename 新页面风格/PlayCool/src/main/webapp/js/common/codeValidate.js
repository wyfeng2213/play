/**
 * 拒签原因编码验证
 */
function checkBisDenialReasonCode() {
		$.ajax({
			type : "GET",
			url : "checkBisDenialReasonCode",
			dataType : "json",
			data : {
				code : $("#codeId").val()
			},
			dataFilter : function(data) {
				var msg = eval("(" + data + ")");
				if(data != null && data != ""){
					$("#codeId").select();
					$("#codeId").focus();
					$("#bisDenialReason_msg").html("<b style='padding-left:10px;color:red;' align='right'>"+msg.additionalMsg.message+"</b>");
				}else{
					$("#bisDenialReason_msg").html(" ");
				}
			}
		});
}
/**
 * 平台编码验证
 */
function checkBisPlatFormCode() {
	$.ajax({
		type : "GET",
		url : "checkBisPlatFormCode",
		dataType : "json",
		data : {
			code : $("#codeId").val()
		},
		dataFilter : function(data) {
			var msg = eval("(" + data + ")");
			if(data != null && data != ""){
				$("#codeId").select();
				$("#codeId").focus();
				$("#bisPlatForm_msg").html("<b style='padding-left:10px;color:red;' align='right'>"+msg.additionalMsg.message+"</b>");
			}else{
				$("#bisPlatForm_msg").html(" ");
			}
		}
	});
}

/**
 * 收发货方编码验证
 */
function checkReceiverCode() {
	$.ajax({
		type : "GET",
		url : "checkReceiverCode",
		dataType : "json",
		data : {
			code : $("#codeId").val()
		},
		dataFilter : function(data) {
			var msg = eval("(" + data + ")");
			if(data != null && data != ""){
				$("#codeId").select();
				$("#codeId").focus();
				$("#bisReceiver_msg").html("<b style='padding-left:10px;color:red;' align='right'>"+msg.additionalMsg.message+"</b>");
			}else{
				$("#bisReceiver_msg").html(" ");
			}
		}
	});
}

/**
 * 司机编码验证
 */
function checkBisDriverCode() {
	$.ajax({
		type : "GET",
		url : "checkDriverCode",
		dataType : "json",
		data : {
			code : $("#codeId").val()
		},
		dataFilter : function(data) {
			var msg = eval("(" + data + ")");
			if(data != null && data != ""){
				$("#codeId").select();
				$("#codeId").focus();
				$("#bisDriver_msg").html("<b style='padding-left:10px;color:red;' align='right'>"+msg.additionalMsg.message+"</b>");
			}else{
				$("#bisDriver_msg").html(" ");
			}
		}
	});
}

/**
 * 串号规则编码验证
 */
function checkBisSerialNoRuleCode() {
	$.ajax({
		type : "GET",
		url : "checkBisSerialNoRuleCode",
		dataType : "json",
		data : {
			code : $("#codeId").val()
		},
		dataFilter : function(data) {
			var msg = eval("(" + data + ")");
			if(data != null && data != ""){
				$("#codeId").select();
				$("#codeId").focus();
				$("#bisSerialNoRule_msg").html("<b style='padding-left:10px;color:red;' align='right'>"+msg.additionalMsg.message+"</b>");
			}else{
				$("#bisSerialNoRule_msg").html(" ");
			}
		}
	});
}

/**
 * 省份编码验证
 */
function checkBisProvinceCode() {
	$.ajax({
		type : "GET",
		url : "checkBisProvinceCode",
		dataType : "json",
		data : {
			code : $("#codeId").val()
		},
		dataFilter : function(data) {
			var msg = eval("(" + data + ")");
			if(data != null && data != ""){
				$("#codeId").select();
				$("#codeId").focus();
				$("#bisProvince_msg").html("<b style='padding-left:10px;color:red;' align='right'>"+msg.additionalMsg.message+"</b>");
			}else{
				$("#bisProvince_msg").html(" ");
			}
		}
	});
}

/**
 * 城市编码验证
 */
function checkBisCityCode() {
	$.ajax({
		type : "GET",
		url : "checkBisCityCode",
		dataType : "json",
		data : {
			code : $("#codeId").val()
		},
		dataFilter : function(data) {
			var msg = eval("(" + data + ")");
			if(data != null && data != ""){
				$("#codeId").select();
				$("#codeId").focus();
				$("#bisCity_msg").html("<b style='padding-left:10px;color:red;' align='right'>"+msg.additionalMsg.message+"</b>");
			}else{
				$("#bisCity_msg").html(" ");
			}
		}
	});
}

/**
 * 区域编码验证
 */
function checkBisDistrictCode() {
	$.ajax({
		type : "GET",
		url : "checkBisDistrictCode",
		dataType : "json",
		data : {
			code : $("#codeId").val()
		},
		dataFilter : function(data) {
			var msg = eval("(" + data + ")");
			if(data != null && data != ""){
				$("#codeId").select();
				$("#codeId").focus();
				$("#bisDistrict_msg").html("<b style='padding-left:10px;color:red;' align='right'>"+msg.additionalMsg.message+"</b>");
			}else{
				$("#bisDistrict_msg").html(" ");
			}
		}
	});
}

function checkCode(name) {
	$.ajax({
		type : "GET",
		url : "checkCode",
		dataType : "json",
		data : {
			code : $("#codeId").val()
		},
		dataFilter : function(data) {
			var msg = eval("(" + data + ")");
			if(data != null && data != ""){
				$("#codeId").select();
				$("#codeId").focus();
				$("#"+name+"_msg").html("<b style='padding-left:10px;color:red;' align='right'>"+msg.additionalMsg.message+"</b>");
			}else{
				$("#"+name+"_msg").html(" ");
			}
		}
	});
}