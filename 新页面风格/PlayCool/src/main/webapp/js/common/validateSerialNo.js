/**
 * 验证串码长度和数量
 */

/**
 * @param serialNo_target 输入区域jquery对象
 * @param serialNo_length 串码长度
 * @param maxNum 可输入串码的最大数量
 * @param msg_target 消息提示区域jquery对象
 * 
 * @return 校验不通过返回false;通过则返回串号数组
 */
var validateSerialNo = function(serialNo_target,serialNo_length,maxNum,msg_target){
	var serialNoArray = [];//录入的串号数组
	var serialNo_value = serialNo_target.val();
	var serialNo_Array = $.trim(serialNo_value).split("\n");
	for(var i = 0;i<serialNo_Array.length;i++){
		var seriaNo = $.trim(serialNo_Array[i]);//得到每行数据
		/* 串号格式校验 */
		if(seriaNo != ""){
			if(seriaNo.length == serialNo_length){//串号格式验证通过
				serialNoArray.push(seriaNo);
			}else{//不通过
				msgObj.showMsgService(msg_target, "<b style='padding-left:5px;color:red;'>[输入的第"+(i+1)+"行的串号长度为"+seriaNo.length+",必须为"+serialNo_length+"位！]</b>");
				return false;
			}
		}
	}
	var serialNoArray_length = serialNoArray.length;
	/* 录入串号数量校验 */
	if(serialNoArray_length>0){//有效的串号数量大于0
		if(serialNoArray_length<=maxNum){//录入数量小于等于待录入数量
			msgObj.clearMsg(msg_target);
			return serialNoArray;
		}else{//录入数量大于待录入数量
			msgObj.showMsgService(msg_target, "<b style='padding-left:5px;color:red;'>[输入串号数量为"+serialNoArray_length+"，大于待输入数量"+maxNum+"！]</b>");
			return false;
		}
	}else{//空字符串
		msgObj.showMsgService(msg_target, "<b style='padding-left:5px;color:red;'>[请输入有效的串号,串号不能为空！]</b>");
		return false;
	}
};

/**
 * 不校验长度，只校验是否为空和数量
 * @param serialNo_target 输入区域jquery对象
 * @param maxNum 可输入串码的最大数量
 * @param msg_target 消息提示区域jquery对象
 * 
 * @return 校验不通过返回false;通过则返回串号数组
 */
var validateSnNoLength = function(serialNo_target,maxNum,msg_target){
	var serialNoArray = [];//录入的串号数组
	var serialNo_value = serialNo_target.val();
	var serialNo_Array = $.trim(serialNo_value).split("\n");
	for(var i = 0;i<serialNo_Array.length;i++){
		var seriaNo = $.trim(serialNo_Array[i]);//得到每行数据
		if(seriaNo != ""){
			serialNoArray.push(seriaNo);
		}
	}
	var serialNoArray_length = serialNoArray.length;
	/* 录入串号数量校验 */
	if(serialNoArray_length>0){//有效的串号数量大于0
		if(serialNoArray_length<=maxNum){//录入数量小于等于待录入数量
			msgObj.clearMsg(msg_target);
			return serialNoArray;
		}else{//录入数量大于待录入数量
			msgObj.showMsgService(msg_target, "<b style='padding-left:5px;color:red;'>[输入串号数量为"+serialNoArray_length+"，大于待输入数量"+maxNum+"！]</b>");
			return false;
		}
	}else{//空字符串
		msgObj.showMsgService(msg_target, "<b style='padding-left:5px;color:red;'>[请输入有效的串号,串号不能为空！]</b>");
		return false;
	}
};

/**
 * 得到有效的串号数组
 * @param serialNo_target 输入区域jquery对象
 * 
 * @return 串号数组
 */
var getSerialNoArray = function(serialNo_target){
	var serialNoArray = [];
	var serialNo_value = serialNo_target.val();
	var serialNo_Array = $.trim(serialNo_value).split("\n");
	for(var i = 0;i<serialNo_Array.length;i++){
		var seriaNo = $.trim(serialNo_Array[i]);
		if(seriaNo != ""){
			serialNoArray.push(seriaNo);
		}
	}
	return serialNoArray;
};