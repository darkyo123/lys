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
		document.registForm.action="/whms/testList.do";
		document.registForm.submit();
	}
	function fnRegist() {
		if(confirm("등록하시겠습니까?")) {
			document.registForm.action="/whms/testRegist.do";
			document.registForm.submit();
		}
	}
</script>
</head>
<body>
	<form name="registForm" action="<c:url value='/whms/test.do'/>" method="post">
		<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
		<input name="flag" type="hidden" value="R"/>
		<h1>Regist Example</h1>
		<hr/>
		<br>
		<table class="wTable" summary="<spring:message code="common.summary.regist" />" style="width: 69%;">
			<colgroup>
				<col style="width: 30%"/>
				<col style="width: 70%"/>
			</colgroup>
			<tbody class="ov">
				<tr>
					<th style="text-align:center;">Title</th>
					<td><input type="text" name="title" value="" /></td>
				</tr>
				<tr>
					<th style="text-align:center;">Content</th>
					<td>
						<textarea name="content"></textarea>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="btn" style="width: 70%;text-align:center;">
			<button class="btn_s2" onClick="fnRegist(); return false;" >저장</button>
			<button class="btn_s2" onClick="fnList(); return false;" >목록</button>
		</div>
	</form>
</body>
</html>