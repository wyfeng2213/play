<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/WEB-INF/view/common/memory.jsp"></jsp:include>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/statistics/highcharts.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/statistics/exporting.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/statistics/util/statistics-navigation.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/statistics/util/chartUtil.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/statistics/date/dateCount.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/statistics/date/datePicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/statistics/date/getDate.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/statistics/util/pageEvent.js"></script>

<style type="text/css">
	.progress{z-index: 2000} 
	.mask{position: fixed;top: 0;right: 0;bottom: 0;left: 0; z-index: 1000; background-color: #2F2F2F} 
</style>

<script type="text/javascript">
var title = "操作日志统计";
var yTitle = "数量（单位：个）";
var dataLabels = true;
var defaultSeriesType = 'column';//line, spline, area, areaspline, column, bar, pie , scatter

/**
 *  加载数据
 * @param chartContainer
 *            图表容器 div id
 * @param subtitle
 *            副标题 String
 * @param url
 *            请求 url
 * @param tableContainer
 *            表格容器 div id
 * @date   2014年12月24日 下午2:28:44
 */
function loadData(chartContainer,subtitle,url,tableContainer) {
	$.ajax({
		url : postPath+'/sysOperateLog/'+url,
		async : true,
		type : 'POST',
		contentType : "application/json; charset=utf-8",
		data : JSON.stringify(sy.serialieObject($("#srchForm"))),
		dataType : 'JSON',
		timeout : 60000,
		beforeSend:function(xhr){ 
			$("#progressImgage").show().css({ 
			"position": "fixed", 
			"top": "40%", 
			"left": "45%", 
			"margin-top": function () { return -1 * $("#progressImgage").height() / 2; }, 
			"margin-left": function () { return -1 * $("#progressImgage").width() / 2; } 
			}); 
			$("#maskOfProgressImage").show().css("opacity", "0.1"); 
		}, 
		error : function() {
			$.messager.show({
				title : '失败',
				msg : '请求错误，请重试！'
			});
		},
		success : function(result) {
			if(result.yData1.length>0) {
				var xAxis = result.xAxis;//X轴数组
				var series = []; //对象数组
				
				var yObject1 = {};
				var yData1 = result.yData1;
				
				yObject1.name = "次數";
				yObject1.data = yData1;
				
				series.push(yObject1);
				
				//	subtitle += "：" + pickDate; 
				createChart(chartContainer,title,subtitle,yTitle,dataLabels,defaultSeriesType,xAxis,series);
				
				$("#"+tableContainer).children().remove();//删除原来表格
				
				createTablePicking(tableContainer,800,xAxis,series,"操作名称", result.warehouseName);
			} else {
				$("#"+chartContainer).hide();
				$("#"+tableContainer).hide();
				
				var _row = $("#"+chartContainer);
				noDataShow(_row);  //无数据时滚动条显示问题修复
			}
		},
		complete:function(xhr){ 
			$("#progressImgage").hide(); 
			$("#maskOfProgressImage").hide(); 
		} 
	}); 
}

</script> 
</head>
<body>

</body>
</html>