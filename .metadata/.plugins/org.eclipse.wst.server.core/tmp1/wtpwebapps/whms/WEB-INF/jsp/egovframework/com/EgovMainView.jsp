<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><spring:message code="comSymMnuMpm.mainView.mainViewTitle"/></title><!-- 행정안전부 공통서비스 테스트 사이트 -->
<script language="javascript" src="<c:url value='/js/egovframework/com/main.js' />"></script>
<script src="<c:url value='/js/egovframework/whms/jquery-1.11.3.min.js' />" type="text/javascript"></script>
<script language="javascript">
function chk_all(val) {

	var arr_chk = document.getElementsByName("chk");

		if (val == "Y") {

			for(i=0;i< arr_chk.length; i++) {
				arr_chk[i].checked =true;
			}
		}
		else if(val == "N") {
			for(i=0;i< arr_chk.length; i++) {
				arr_chk[i].checked =false;
			}
		}
}

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

<body topmargin="0" leftmargin="0" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">

<!-- header -->
<c:import url="./head.jsp" />

<!-- contents -->
<div>
<!-- bottom -->
<c:import url="./main_bottom.jsp" />
</div><!-- contents -->

</body>
</html>