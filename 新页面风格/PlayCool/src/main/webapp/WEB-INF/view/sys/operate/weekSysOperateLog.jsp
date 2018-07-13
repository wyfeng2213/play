<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<jsp:include page="commonSysOperateLogStatistics.jsp"></jsp:include>

<script type="text/javascript"> 
var curr_time = new Date();
$(function() { 
	//显示当前日期
	var curr_time = new Date();
	var curr_year = 0;
	var curr_week = theWeek();
	if(curr_week == "nextYear") {//12月有最后几天计入下一年的第一周
		curr_year = curr_time.getFullYear() + 1;
		curr_week = 1;
	} else {
		curr_year = curr_time.getFullYear();
	}
	
	$.ms_DatePicker({
	    YearSelector: "#mYear",
	    WeekSelector: "#mWeek"
	},curr_year,null,curr_week);
	
	setTime('week');
	
	//默认加载数据
	loadData('dataChart','周度数据','getSysOperateLogData','dataTable');
	
	rigntClick();
});

function exportData(){
	location.href = 'exportXls?' + $("#srchForm").serialize();
}
 
</script>
</head> 

<body class="easyui-layout" style="width:100%;height:100%;">
  	<!-- 查询表单 -->
		<div class="Search-box" region="north" title="查询条件" style="height:75px;">
			<form id="srchForm" class="frmSearch" action="" autocomplete='off' method="post">
				<table class="tableForm"  align="center" style="width:700px;">
					<tr>
						<th>查询日期</th>
						<td>
							<select id="mYear" class="sel_year" name="mYear">
			                </select>年 
			                <select id="mWeek" class="sel_week" name="mWeek">
			                </select>
						</td>
						<th>时间段</th>
						<td>
							<input type="text" id="weekBeginDate" name="beginDate" style="background-color: #DFDFDF;width: 75px;"readonly="readonly" />—
							<input type="text" id="weekEndDate" name="endDate" style="background-color: #DFDFDF;width: 75px;"readonly="readonly" />
						</td>
						<td colspan="4" align="center">
							<a href="javascript:void(0)" class="easyui-linkbutton"onclick="tj_search('dataChart','周度数据','getSysOperateLogData','dataTable','week')">查询数据</a>&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
				</table>
			</form>
		</div>
	
	<!-- 数据 -->
		<div region="center" style="width:100%;height:100%;border:0;">
			<div id="content">
				<div id="dataChart" class="dataSeries" style="width: 95%; height: 400px; margin: 0 auto;"></div>
				<div id="dataTable" class="dataSeries" onmousedown="" style="width: 95%;height：350px;margin:20px auto;"></div>
			</div>
		</div>
		
	<!--右键菜单div-->
		<div id="menu" class="easyui-menu" style="width: 100px;">
			<div onclick="exportData();">导出Excel</div>
		</div>
	<!--进度条-->	
		<img id="progressImgage" class="progress" style="display:none" alt="" src="${pageContext.request.contextPath}/images/chart_processbar.gif"/> 
		<div id="maskOfProgressImage" class="mask" style="display:none"></div> 
</body>
</html>
