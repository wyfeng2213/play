<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>快速查找</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.9.1.js"></script>
<script type="text/javascript">
	/* $(function() {
		var headerTds = parent.$(".datagrid-view2").children(".datagrid-header").find("table tr:first-child").children(":visible");
		//alert(headerTds.length);
		for(var i=0;i<headerTds.length;i++) {
			alert(headerTds[i].text);
		}
	}); */
</script>
</head>
<body>
	<div>
		<table>
			<tr>
				<td>属性：</td>
				<td><select name="field">
					<option value=""></option>
				</select></td>
			</tr>
			<tr>
				<td>条件：</td>
				<td><select name="condition">
					<option id="" value=""></option>
					<option id="" value="EQ">等于</option>
					<option id="" value="NOT">不等于</option>
					<option id="" value="GT">大于</option>
					<option id="" value="GE">大于等于</option>
					<option id="" value="LT">小于</option>
					<option id="" value="LE">小于等于</option>
					<option id="" value="IS_NULL">为空</option>
					<option id="" value="NOT_NULL">不为空</option>
					<option id="" value="IN">包含</option>
					<option id="" value="NOT_IN">不包含</option>
					<option id="" value="BOTH">全模糊</option>
					<option id="" value="LEFT">左模糊</option>
					<option id="" value="RIGHT">右模糊</option>
					<option id="" value="BETWEEN">介于...之间</option>
				</select></td>
			</tr>
			<tr style="display: none;">
				<td>值1：</td>
				<td></td>
			</tr>
			<tr style="display: none;">
				<td>值2：</td>
				<td></td>
			</tr>
		</table>
	</div>
	<div>
		<table>
			<tr>
				<td><input type="button" value="查询" name=""/></td>
				<td><input type="button" value="重置" name=""/></td>
			</tr>
		</table>
	</div>
</body>
</html>