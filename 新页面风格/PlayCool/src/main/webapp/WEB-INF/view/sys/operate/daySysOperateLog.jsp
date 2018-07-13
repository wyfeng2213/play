<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="commonSysOperateLogStatistics.jsp"></jsp:include>

<style type="text/css">
	.progress{z-index: 2000} 
	.mask{position: fixed;top: 0;right: 0;bottom: 0;left: 0; z-index: 1000; background-color: #2F2F2F} 
</style>
</head>
<script type="text/javascript">
var curr_time = new Date();
var cur = curr_time.getFullYear() + "-" + "0"+(curr_time.getMonth() + 1) + "-" + ("0"+curr_time.getDate());
$(function(){
	//显示当前时间
	$("#queryDay").datebox("setValue", cur);
	setTime('day');
	//默认加载数据
	loadData('dataChart','日度数据','getSysOperateLogData','dataTable');
	rigntClick();
});

function forward(op){
	var s =$('#queryDay').datebox('getValue');
	s=s.replace(/-/g,'/'); 
	var t = Date.parse(s);
	var newDate;
	if(op == '+'){
		newDate = t + 1*24*60*60*1000;
	}else{
		newDate = t - 1*24*60*60*1000;
	}
	var t1 = new Date(newDate);
	var day=t1.getDate();
	var month=t1.getMonth() + 1;
	var year=t1.getFullYear();
	var val = year+"-"+ (month < 10 ? "0"+month : month) + "-" +(day < 10 ? "0"+day : day)+" "+"23:59:59";
	$('#queryDay').datebox('setValue', val);
	tj_search('dataChart','日度数据','getSysOperateLogData','dataTable','day');
}
function exportData(){
	location.href = 'exportXls?' + $("#srchForm").serialize();
}

</script>
<body class="easyui-layout" style="width:100%;height:100%;">
  	<!-- 查询表单 -->
		<div class="Search-box" region="north" title="查询条件" style="height:60px;">
			<form id="srchForm" class="frmSearch" action="" autocomplete='' method="post">
				<table class="tableForm"  align="center" style="width:900px;">
					<tr>
						<th>查询日期</th>
						<td>
							<a href="#" onclick="forward('-');"><<</a>
							<input id="queryDay" name="queryDay" type="text"  class="easyui-datebox" style="width:90px;"/>
							<a href="#" onclick="forward('+');">>></a>
						</td>
						<td colspan="4" align="center">
							<a href="javascript:void(0)" class="easyui-linkbutton"onclick="tj_search('dataChart','日度数据','getSysOperateLogData','dataTable','day')">查询数据</a>&nbsp;&nbsp;&nbsp;
						</td>					
					</tr> 
				</table>
			</form>
		</div>
	
	<!-- 数据 -->
		<div region="center" style="width:100%;height:100%;border:0;">
			<div id="content">
				<div id="dataChart" class="dataSeries" style="width: 95%; height: 350px; margin: 0 auto;"></div>
				<div id="topNChart" class="topN" style="width: 95%; height: 350px; margin: 0 auto;display: none;"></div>
				<div id="dataTable" class="dataSeries" onmousedown="" style="width: 95%;height：120px;margin:20px auto;"></div>
				<div id="topNTable" class="topN" style="width: 95%;height：120px;margin:20px auto;display: none;"></div>
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