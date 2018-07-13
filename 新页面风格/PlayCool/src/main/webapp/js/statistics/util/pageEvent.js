//查询数据按钮
function tj_search(chartContainer,subtitle,uri,tableContainer,type) {
	$(".dataSeries").show();
	setTime(type);
	loadData(chartContainer,subtitle,uri,tableContainer);
}
//历史最高按钮
function historyMax(chartContainer,subtitle,uri,tableContainer) {
	$(".dataSeries").hide();
	$(".topN").show();
	loadData(chartContainer,subtitle,uri,tableContainer);
}
//右键事件
function rigntClick() {
	$("#dataTable,#topNTable").mousedown(function(e){ 
			 $('body').bind("contextmenu",function(e){
		         return false;
		    }); 
	      if(3 == e.which){ 
	    	   $('#menu').menu('show', {
	              left: e.pageX,
	              top: e.pageY
	          });  
		    return false;
	      }
	    }); 
}
//导出EXCEL
function exp2excel(url) { 
	var trs = $("#content").children("div :visible").eq(1).children("table").find("tr");
	var head = "";
	var field = "";
	for(var i=0;i<trs.length;i++) {
		var tds = trs.eq(i).find("td");
		for(var j=0;j<tds.length;j++) {
			if(i == 0) {
				head +=  tds.eq(j).html()+",";
			} else if(i == 1) {
				field += tds.eq(j).html()+",";
			}
		}
	}
	head = head.substring(0, head.length-1);
	field = field.substring(0, field.length-1);
	window.location.href = postPath+'/'+url+'/exp2excel?head='+head+"&field="+field;
}

//设置查询时间
function setTime(type) {
	if(type == 'day') {
		var beginDate = ""+$("#queryDay").datebox("getValue");
		$("#dayBeginDate").val(beginDate);
		var endDate = "";
		var dateTemp = new Date(beginDate);
		dateTemp.setDate(dateTemp.getDate()+1);
		endDate +=dateTemp.format("yyyy-MM-dd");
		$("#dayEndDate").val(endDate);
	} else if(type == 'week') {
		$("#weekBeginDate").val(getBeginDateOfWeek($("#mYear").val(),$("#mWeek").val()));
		$("#weekEndDate").val(getEndDateOfWeek($("#mYear").val(),$("#mWeek").val()));
	}else if(type == 'month') {
		$("#monthBeginDate").val(getMonthStartDateIdx($("#mYear").val(),$("#mMonth").val()));
		$("#monthEndDate").val(getMonthEndDateIdx($("#mYear").val(),$("#mMonth").val()));
	}else if(type == 'season') {
	}else if(type == 'year') {
	}
	
}

//根据季度值返回该季度初始月份
function getStartMonthBySeason(n) {
	if(n == 1) {
		return "01";
	}else if(n == 2) {
		return "04";
	}else if(n == 3) {
		return "07";
	}else if(n == 4) {
		return "10";
	}
}