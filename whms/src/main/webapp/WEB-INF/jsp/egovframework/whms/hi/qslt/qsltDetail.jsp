<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/com.css' />">
<script>
	function fnList() {
		document.detailForm.action="/whms/qsltList.do";
		document.detailForm.submit();
	}
	function fnUpdate() {
		document.detailForm.action="/whms/qsltUpdate.do";
		document.detailForm.submit();
	}
	function fnDelete() {
		if(confirm("삭제하시겠습니까?")) {
			document.detailForm.action="/whms/qsltDelete.do";
			document.detailForm.submit();
		}
	}
</script>
</head>
<body>
	<form name="detailForm" action="<c:url value='/whms/qsltList.do'/>" method="post">
		<input name="UsrId" type="hidden" value="<c:out value='${detailVO.UsrId}'/>"/>
		<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
		<!-- <input name="flag" type="hidden" value="V"/> --> 
		<h1>Detail Example</h1>
		<hr/>
		<br>
		<table class="wTable" summary="<spring:message code="common.summary.regist" />" style="width: 69%;">
			<colgroup>
				<col style="width: 30%"/>
				<col style="width: 70%"/>
			</colgroup>
			<tbody class="ov">
				<!-- <tr>
					<th style="text-align:center;">Title</th>
					<td><c:out value="${detailVO.title}"/></td>
				</tr>
				<tr>
					<th style="text-align:center;">Content</th>
					<td><c:out value="${detailVO.content}"/></td>
				</tr> -->
			</tbody>
		</table>
		<div class="btn" style="width: 73%;text-align:center;">
			<button class="btn_s2" onClick="fnUpdate(); return false;" >수정</button>
			<button class="btn_s2" onClick="fnDelete(); return false;" >삭제</button>
			<button class="btn_s2" onClick="fnList(); return false;" >목록</button>
		</div>
	</form>
</body>
</html>