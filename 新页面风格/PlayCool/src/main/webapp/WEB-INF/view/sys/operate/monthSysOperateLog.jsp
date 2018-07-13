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
	var curr_year = curr_time.getFullYear();
	var curr_month = curr_time.getMonth()+1;
	
	$.ms_DatePicker({
	    YearSelector: "#mYear",
	    MonthSelector: "#mMonth"
	},curr_year,curr_month);
	
	setTime('month');
	//默认加载数据
	loadData('dataChart','月度数据','getSysOperateLogData','dataTable');
	//右键菜单
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
				<input type="hidden" id="monthBeginDate" name="beginDate"/>
				<input type="hidden" id="monthEndDate" name="endDate"/>
				<table class="tableForm"  align="center" style="width:600px;">
					<tr>
						<th>查询日期</th>
						<td>
							<select id="mYear" name="mYear" class="sel_year">
			                </select>年 
			                <select id="mMonth"  name="mMonth" class="sel_month">
			                </select>月
						</td>					
						<td colspan="2" align="center">
							<a href="javascript:void(0)" class="easyui-linkbutton"onclick="tj_search('dataChart','月度数据','getSysOperateLogData','dataTable','month')">查询数据</a>
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
