<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<!-- Bootstrap -->
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/style.css' />" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/reset.css' />" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/animate.css' />" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/jquery-ui.min.css' />" type="text/css" />

<script src="<c:url value='/js/egovframework/whms/jquery-1.11.3.min.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/jquery-ui.min.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/front-ui.js' />" type="text/javascript"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/whms/jquery.navgoco.js' />"></script><!-- left menu js -->

<script type="text/javaScript">

	/** left 메뉴 script 사용 path */
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

	/** 메뉴생성 버튼 클릭 event */
	function fInsertMenuCreat() {
	    var chk = document.detailForm.chk;
	    var checkMenuNos = "";
	    var checkedCount = 0;
	    if(chk) {
	    	if(chk.length > 1) {
	            for(var i=0; i < chk.length; i++) {
	                if(chk[i].checked) {
	                    checkMenuNos += ((checkedCount==0? "" : ",") + chk[i].value);
	                    checkedCount++;
	                }
	            }
	        } else {
	            if(chk.checked) {
	                checkMenuNos = chk.value;
	            }
	        }
	    }
	    if(checkedCount == 0){
	        alert("선택된 메뉴가 없습니다.");
	        return false;
	    }
	    if(confirm("생성하시겠습니까?")) {
		    document.detailForm.checkedMenuNoForInsert.value=checkMenuNos;
		    document.detailForm.checkedAuthorForInsert.value="<c:out value='${resultVO.authorCode}'/>";
		    document.detailForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatInsert.do'/>";
		    document.detailForm.submit();
	    }
	}

	/** 전체선택 버튼 클릭 event */
	function fn_chk_all() {
		var chkAll = document.detailForm.chkAll.value;
		var chk = document.detailForm.chk;
		if("N" == chkAll) {
			if(chk) {
		    	if(chk.length > 1) {
		            for(var i=0; i < chk.length; i++) {
		            	document.detailForm.chk[i].checked = true;
		            }
		        } else {
		        	document.detailForm.chk[i].checked = true;
		        }
		    }
			document.detailForm.chkAll.value = "Y";
		} else {
			if(chk) {
		    	if(chk.length > 1) {
		            for(var i=0; i < chk.length; i++) {
		            	document.detailForm.chk[i].checked = false;
		            }
		        } else {
		        	document.detailForm.chk[i].checked = false;
		        }
		    }
			document.detailForm.chkAll.value = "N";
		}
	}

<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
</script>
</head>
<body oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
<noscript class="noScriptTitle"><spring:message code="common.noScriptTitle.msg" /></noscript>
<form name="selectOne">
	<input name="currentMenu" type="hidden" value="4020000" />
	<c:forEach var="result" items="${menulist}" varStatus="status" >
		<input type="hidden" name="tmp_menuNm" value="${result.menuNo}|${result.upperMenuId}|${result.menuNm}|${result.relateImagePath}|${result.relateImageNm}|${result.chkURL}|${result.upperMenuNm}"/>
	</c:forEach>
	<input name="vStartP" type="hidden" />
	<input name="chkURL" type="hidden" />
	<input id="modal_type" type="hidden" value="" />
</form>
<div id="subcontainer">
		<div class="swrap">
			<div class="subcont">
				<div class="left_area">
					<div class="lnav" id="lmenu">
						<c:forEach var="menu" items="${menulist}" varStatus="status" >
							<c:if test="${menu.childCnt != 0 }">
								<li id="li<c:out value='${menu.menuNo}'/>">
									<a href="javascript:choiceNodes('<c:out value="${menu.rowNumber}"/>')"><c:out value='${menu.menuNm}'/></a>
									<ul>
										<c:forEach var="menu_lv2" items="${menulist}" varStatus="status" >
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
				<div class="right_area p25">

					<div class="reg_searchbox"> 
							<!-- search_tb -->
							<div class="search_tb mb0"> <span class="select w100p">
							  <select name="searchCondition" id="searchCondition" disabled>
							      <option value="AUTHOR_CODE" selected>권한코드</option>
							    </select>
							  </span> <span class="input w250p">
							  <input type="text" placeholder="" id="searchKeyword" name="searchKeyword" value="<c:out value='${resultVO.authorCode}'/>" style="width:100%" readonly>
							  <input type="text" style="display: none;">
							  </span>
							  <button type="button" class="btn-type btn_ico black" onclick="fn_chk_all();">전체선택</button>
							  <button type="button" class="btn-type btn_ico black" onclick="fInsertMenuCreat();">메뉴생성</button>
							</div>
							<!-- // search_tb --> 
					</div>

					<form name="detailForm" method="post" action="" >
						<input name="checkedMenuNoForInsert" type="hidden" />
						<input name="checkedAuthorForInsert"  type="hidden"  />
						<input name="chkAll" type="hidden" value="N" />
						<input name="authorCode"  type="hidden" value="<c:out value='${resultVO.authorCode}'/>" >
						<div class="lnav menuCreat" id="lmenu">
							<c:forEach var="menu" items="${list_menulist}" varStatus="status" >
								<c:if test="${menu.childCnt != 0 }">
									<li id="li<c:out value='${menu.menuNo}'/>">
										<input type="checkbox" name="chk" class="checkField" value="<c:out value='${menu.menuNo}'/>" <c:if test="${menu.chkYeoBu >= 1 }">checked</c:if> >
										<a href="#"><c:out value='${menu.menuNm}'/></a>
										<ul>
											<c:forEach var="menu_lv2" items="${list_menulist}" varStatus="status" >
												<c:if test="${menu.menuNo == menu_lv2.upperMenuId }">
													<input type="checkbox" name="chk" class="checkField bottom" value="<c:out value='${menu_lv2.menuNo}'/>" <c:if test="${menu_lv2.chkYeoBu >= 1 }">checked</c:if>>
													<li id="li<c:out value='${menu_lv2.menuNo}'/>"><a href="#"><c:out value='${menu_lv2.menuNm}'/></a></li>
												</c:if>
											</c:forEach>
										</ul>
									</li>
								</c:if>
							</c:forEach>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

<div class="btn_up_layer"></div>
<script src="<c:url value='/js/egovframework/whms/needpopup.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/default.js' />" type="text/javascript"></script>

</body>
</html>

