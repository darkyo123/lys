<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>HeadMenu</title>
<script type="text/javascript">
var getContextPath = "${pageContext.request.contextPath}";
</script>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/whms/reset.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/whms/style.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/whms/animate.css' />" media="all">
<script src="<c:url value='/js/egovframework/whms/jquery-1.11.3.min.js' />" type="text/javascript"></script>
<%-- <script language="javascript" src="<c:url value='/js/egovframework/com/main.js' />"></script> --%>
<script type="text/javascript">

	function fn_main_headPageMove(menuNo, url){
		document.selectOne.vStartP.value=menuNo;
		document.selectOne.chkURL.value=url;
	    /* document.selectOne.action = "<c:url value='/sym/mnu/mpm/EgovMainMenuLeft.do'/>";
	    document.selectOne.target = "main_left";
	    document.selectOne.submit(); */
 	    document.selectOne.action = "<c:url value='/sym/mnu/mpm/EgovMainMenuRight.do'/>";
	    document.selectOne.target = "main_right";
	    document.selectOne.submit();
	}

	function actionLogout()
	{
		document.selectOne.action = "<c:url value='/uat/uia/actionLogout.do'/>";
		document.selectOne.target = "_top";
		document.selectOne.submit();
		//top.document.location.href = "<c:url value='/j_spring_security_logout'/>";
	}

	function fn_remote() {
		top.document.location.href = "http://helpu.kr/cnko/";
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
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight= "0" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
<form name="selectOne">
<input name="vStartP" type="hidden" />
<input name="chkURL" type="hidden" />
</form>

	<header id="header">
      <div class="headWrap">
        <div class="logo">
          <a href="<c:url value='/uat/uia/egovLoginUsr.do' />" target=_top><img src="<c:url value='/images/egovframework/whms/logo.png' />" alt="" /></a>
          <h3>Ver 1.0</h3>
        </div>
        <div class="menu" id="upper_menu_nm"><c:out value='${menu_nm.upperMenuNm}'/></div>
        <div class="location">
          <ul>
            <li><img src="<c:url value='/images/egovframework/whms/i_home.png' />" alt="" /></li>
            <li id="menu_nm" class="lo01"><c:out value='${menu_nm.menuNm}'/></li>
          </ul>
        </div>
        <div class="remote">
        	<a href="javascript:fn_remote();">원격지원</a>
        </div>
        <div class="logout">
        	<a href="javascript:actionLogout();">로그아웃</a>
        </div>
        <!-- // location --> 
      </div>
      <!-- // headWrap --> 
    </header>

    <%-- <div id="gnb">
    <div id="top_logo"><a href="<c:url value='/sym/mnu/mpm/EgovMainMenuHome.do' />" target=_top><img src="<c:url value='/images/egovframework/com/cmm/main/logo_01.gif' />" alt="egovframe" /></a></div>
    <div id="use_descri">
		<ul>
			<li>공통서비스 테스트 사이트</li>
			<li><a href="javascript:actionLogout()"><img src="<c:url value='/images/egovframework/com/cmm/main/logout_btn.gif' />" alt="로그아웃" /></a></li>
		</ul>
    </div>
    </div> --%>
    
    <%-- <div id="new_topnavi">
        <ul>
			<li><a href="<c:url value='/sym/mnu/mpm/EgovMainMenuHome.do' />" target="_top">HOME</a></li>
			<c:forEach var="result" items="${list_headmenu}" varStatus="status">
			   <li class="gap"> l </li>
			   <li><a href="javascript:fn_main_headPageMove('<c:out value="${result.menuNo}"/>','<c:out value="${result.chkURL}"/>')"><c:out value="${result.menuNm}"/></a></li>
			</c:forEach>
        </ul>
    </div> --%>
</body>
</html>
