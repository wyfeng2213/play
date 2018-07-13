<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/view/common/taglibs.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/base.css">
<jsp:include page="/WEB-INF/view/common/memory.jsp"></jsp:include>
	</head>
<body>
		<div class="a-container">
			<form id= "addForm" action="addSave" method="post"
				enctype="multipart/form-data" >
				<div class="title">商品信息</div>
				<!-- <div class="subtitle">填写信息</div> -->
				<table class="tableapply">
				<input t id="targetId" type="hidden" value="${goodInfo.id }"/>
					<tr>
						<!-- <td class="bname">工单号：</td><td><input class="inputstyle" value="" type="text"></td> -->
						<td class="bname">商品编号：</td><td><input class="inputstyle" value="${goodInfo.id }"  readonly="readonly" type="text"></td>
					</tr>
					<tr>
						<td class="bname">商品名称：</td><td><input id="name" name="name" type="text"  readonly="readonly" value="${goodInfo.name }"/></td>
						
					</tr>
					<tr>
						<td class="bnameUrl">商品名Url：</td><td><input id="supplierUrl" name="supplierUrl" type="text"  readonly="readonly" value="${goodInfo.supplierUrl }"/></td>
						
					</tr>
				
					<tr class="btn">
						<!-- <td colspan="2" class="bleft"><input type="button" value="保存" class="buttonstyle"/></td> -->
						<td colspan="2" class="bleft"><input type="button" value="同意" class="buttonstyle" onclick="updateFlowStatus('myAgent','1',$('#targetId'))"/></td>
						<!-- <td colspan="2" class="bright"><input type="button" value="不同意" class="buttonstyle" onclick="updateFlowStatus('myAgent','2',$('#targetId'))"/></td> -->
					</tr>
				</table>
			</form>
		</div>
<script type="text/javascript">
function updateFlowStatus(name, flowStatus, targetId) {
	var url = postPath + '/' + name + '/updateFlowStatus';
	if ("undefined" != typeof parentName) {
		name = parentName;
	}
	var ids =targetId.val();
	var msgTarget;
		
		// 与后台交互
		$.ajax({
			url : url,
			method : 'post',
			data : {
				ids : ids,
				flowStatus : flowStatus
			},
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType : 'json',
			success : function() {
				alert("操作成功！");
			}
		});
	
}
			
//提交
	
			
</script>
	</body>
</html>