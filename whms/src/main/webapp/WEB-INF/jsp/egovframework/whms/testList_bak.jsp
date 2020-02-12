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
	function fnInsert() {
		document.listForm.action="/whms/testRegist.do";
		document.listForm.submit();
	}
	function fnDetail(idx) {
		document.listForm.testIdx.value = idx;
		document.listForm.action = "/whms/testDetail.do";
		document.listForm.submit();
	}
</script>
</head>
<body>
	<form name="listForm" action="<c:url value='/whms/testList.do'/>" method="post">
		<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
		<input name="testIdx" type="hidden" value=""/>
		<input name="flag" type="hidden" value="L"/>
		<h1>List Example</h1>
		<hr/>
		<br>
		<table class="board_list" summary="<spring:message code="common.summary.list" />" style="width: 69%;">
			<thead>
				<tr>
					<th>Idx</th>
					<th>Title</th>
					<th>Content</th>
				</tr>
			</thead>
			<tbody class="ov">
			<c:if test="${fn:length(testList) == 0}">
				<tr>
					<td colspan="3"><spring:message code="common.nodata.msg" /></td>
				</tr>
			</c:if>
			<c:forEach var="test" items="${testList}" varStatus="status">
				<tr onClick="fnDetail('${test.testIdx}')" style="cursor:pointer;">
					<td><c:out value="${test.testIdx}" /></td>
					<td><c:out value="${test.title}" /></td>
					<td><c:out value="${test.content}" /></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<!-- paging navigation -->
		<div class="pagination" style="width: 69%;">
			<ul><ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnLinkPage"/></ul>
		</div>
		<div class="btn" style="width: 66%;text-align:center;">
			<button class="btn_s2" onClick="fnInsert();" >등록</button>
		</div>
	</form>
</body>
</html>