<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="shortcut icon" href="ico/favicon.ico">
<link href="${pageContext.request.contextPath}/css/themes/gray/easyui.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/html/list.css">
<jsp:include page="../common/header.jsp"></jsp:include>
<jsp:include page="../common/taglibs.jsp"></jsp:include>
<jsp:include page="../common/listUtil.jsp"></jsp:include>
<title>Insert title here</title>
<script type="text/javascript">
	function exportExcel(){
		var srchForm = $("#srchForm",window.parent.document);
		var ids = parent.getSelections();
		var parentParms = sy.serialieString(srchForm);
		var val=$('input:radio[name="exportType"]:checked').val();
		if(val == null) {
			alert("请选择导出类型");
		} else if(val =="1") {
			if(ids){
				parent.closelimitDialog();
				window.location.href = "exportExcel?ids="+ids;
			}else {
				alert("请先选择记录行！");
			}
		} else if(val =="2") {
			parent.closelimitDialog();
			window.location.href = "exportExcel"+parentParms+"&ids=";
		}
	}

</script>
</head>
<body>
<form class="cmxform" id="commentForm" method="post" action="">
	<fieldset>
		<legend>导出类型</legend>
		<table width="100%" class="table_border">
					<tr>
						<td align="center" valign="middle">
							<input id="exportSelections" type="radio" name="exportType" value="1" />导出所选中的记录
						</td>
					</tr>
					<tr>
						<td align="center" valign="middle">
							<input id="exportAll" type="radio" name="exportType" value="2"/>导出所有查询结果
						</td>
					</tr>
					<tr></tr>
					<tr>
						<td align="center" valign="middle">
							<input type="button" value="确认" onclick="exportExcel();" class="submit" id="save">&nbsp;
							<input type="button" value="返回" class="blue_mod_btn" onclick="parent.closelimitDialog();">
						</td>
					</tr>
				</table>
	</fieldset>
</form>
</body>
</html>