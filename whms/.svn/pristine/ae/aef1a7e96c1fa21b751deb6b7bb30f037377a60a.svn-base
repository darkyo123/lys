<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<HTML lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<META name="viewport" content="user-scalable=no, width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta name="description" content="Worker Health Management System">
<meta name="keywords" content="Worker Health Management System">
<title>Worker Health Management System</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/whms/hi/qslt/reset.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/whms/hi/qslt/style.css' />">
<script src="<c:url value='/js/egovframework/whms/jquery-1.11.3.min.js' />" type="text/javascript"></script>
<!-- <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/com.css' />"> -->
<script>
$("html").keydown(function(e) {
	var k = window.event.keyCode;
	if(window.event.ctrlKey && k == 85) {
		alert("소스보기가 금지 되어있습니다");
		event.keyCode = 0;
		event.cancleBubble = true;
		event.returnValue = false;
	}
});
</script>
</head>
<body oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
<header id="header" class="gradient_bg">
 <h1>WHMS</h1>
</header>

<!-- @@@@ join_wrap @@@@ -->
<form name="registForm" id="registForm" action="<c:url value='/whms/hi/qsltRegistAjax.do'/>" method="post">
	<!--  <input name="UseGrpCd" type="hidden" value="<c:out value='${UseGrpCd}'/>"/>  -->
	<input name="UsrId" type="hidden" value="<c:out value='${UsrId}'/>"/>
	<input name="EmpTmpId" type="hidden" value="<c:out value='${EmpTmpId}'/>"/>
	<input name="flag" type="hidden" value="R"/>
	<input name="UseYn" type="hidden" value=""/>
	<input name="ActionMode" type="hidden" value="<c:out value='${ActionMode}'/>"/>
<div id="form_wrap">
 <div class="form_tit">신규 채용 건강 문진표</div>
 <div class="whitebox_p15">    
    <div class="project_m_reg">
      <ul style="text-align:center;">
        <h2 style="margin-top:8px;">문진표 작성에 성공하였습니다.</h2>
        <h2>닫기 버튼을 눌러주세요</h2>
      </ul>
    </div>    
    <!-- // project_m_reg -->
 </div><!-- // whitebox_p15 -->
</div>
</form>
<!-- @@@@ // join_wrap @@@@ -->
</body>
</html>