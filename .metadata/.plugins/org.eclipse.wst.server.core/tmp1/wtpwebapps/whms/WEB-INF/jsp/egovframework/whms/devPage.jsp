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
<!-- Bootstrap -->
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/style.css' />" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/reset.css' />" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/animate.css' />" type="text/css" />

<script src="<c:url value='/js/egovframework/whms/jquery-1.11.3.min.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/front-ui.js' />" type="text/javascript"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/whms/jquery.navgoco.js' />"></script><!-- left menu js -->

<script>

	var path = location.origin;

	/** Left Menu 동작 script */
	function choiceNodes(nodeNum) {
		var nodeValues = document.selectOne.tmp_menuNm[nodeNum].value.split("|");
		if(nodeValues[5].indexOf("dir") < 0) {				// directory가 아니면 페이지 이동
			document.selectOne.vStartP.value=nodeValues[0];
			document.selectOne.chkURL.value=nodeValues[5];
			parent.parent.document.getElementById("main_top").contentWindow.document.getElementById("upper_menu_nm").innerHTML = nodeValues[6];
			parent.parent.document.getElementById("main_top").contentWindow.document.getElementById("menu_nm").innerHTML = nodeValues[2];
	 	    document.selectOne.action = "<c:url value='/sym/mnu/mpm/EgovMainMenuRight.do'/>";
		    document.selectOne.submit();
		} else {
			top.location.href=path + "/sym/mnu/mpm/EgovMainMenuIndex.do?menuNo="+nodeValues[0]+"&chkURL=dir";
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
<script src="<c:url value='/js/egovframework/whms/wijmo/customGridEditor.js'/>" type="text/javascript"></script>
</head>
<body id="tbody" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
<form name="selectOne">
	<input name="currentMenu" type="hidden" value="<c:out value='${param.vStartP}'/>" />
	<c:forEach var="result" items="${list_menulist}" varStatus="status" >
		<input type="hidden" name="tmp_menuNm" value="${result.menuNo}|${result.upperMenuId}|${result.menuNm}|${result.relateImagePath}|${result.relateImageNm}|${result.chkURL}|${result.upperMenuNm}"/>
	</c:forEach>
	<input name="vStartP" type="hidden" />
	<input name="chkURL" type="hidden" />
</form>
	<div id="subcontainer">
		<div class="swrap">
			<div class="subcont">
				<div class="left_area">
					<div class="lnav" id="lmenu">
						<c:forEach var="menu" items="${list_menulist}" varStatus="status" >
							<c:if test="${menu.childCnt != 0 }">
								<li id="li<c:out value='${menu.menuNo}'/>">
									<a href="javascript:choiceNodes('<c:out value="${menu.rowNumber}"/>')"><c:out value='${menu.menuNm}'/></a>
									<ul>
										<c:forEach var="menu_lv2" items="${list_menulist}" varStatus="status" >
											<c:if test="${menu.menuNo == menu_lv2.upperMenuId }">
												<li id="li<c:out value='${menu_lv2.menuNo}'/>"><a href="javascript:choiceNodes('<c:out value="${menu_lv2.rowNumber}"/>')"><c:out value='${menu_lv2.menuNm}'/></a></li>
											</c:if>
										</c:forEach>
									</ul>
								</li>
							</c:if>
						</c:forEach>
					</div>
				</div>
				<div class="right_area">
					<div class="prepare">
						본페이지는 현재 <span class="f_500 maincolor">준비중</span>입니다.
					</div>
				</div>
			</div>
		</div>
	</div>
<script src="<c:url value='/js/egovframework/whms/needpopup.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/default.js' />" type="text/javascript"></script>
</body>
</html>