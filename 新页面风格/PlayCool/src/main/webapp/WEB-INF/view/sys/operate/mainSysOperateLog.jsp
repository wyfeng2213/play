<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="/WEB-INF/view/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<jsp:include page="/WEB-INF/view/common/memory.jsp"></jsp:include>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/statistics/util/statistics-navigation.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/statistics/statistics-navigation.css">
</head>
<script type="text/javascript">
	//显示数据
	function showData(type) {
		navCss(type);
		$("#main").children().remove();
		var content = "<iframe frameborder='0' width='100%' height='680px' src='${pageContext.request.contextPath}/sysOperateLog/"+type+"'></iframe>";
		$("#main").html(content);
	}
</script>
<body style="overflow: auto;">
	<div class="content">
		<div class="top"></div>
		<div class="navigation">
			<div class="nav_logo"></div>
			<div class="nav">
				<ul id="navMenu">
					<li><a href="javascript:showData('day');" target=""><strong class="dayText" style="color: red;">日度数据</strong></a></li>
					<li><a href="javascript:showData('week');" target=""><strong class="weekText">周度数据</strong></a></li>
					<li><a href="javascript:showData('month');" target=""><strong class="monthText">月度数据</strong></a></li>
					<!-- <li><a href="javascript:showData('season');" target=""><strong class="seasonText">季度数据</strong></a></li>
					<li><a href="javascript:showData('year');" target=""><strong class="yearText">年度数据</strong></a></li> -->
				</ul>
			</div>
		</div>
		<div id="main" class="main">
			<iframe frameborder="0" width="100%" height="650px" src="${pageContext.request.contextPath}/sysOperateLog/day"></iframe>
		</div>
	</div>
</body>
</html>