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
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/bootstrap.min.css' />" />
<link href="<c:url value='/css/egovframework/whms/wijmo/vendor/wijmo.min.css'/>" rel="stylesheet" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/wijmo/app.css'/>" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/style.css' />" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/reset.css' />" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/animate.css' />" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/jquery-ui.min.css' />" type="text/css" />

<script src="<c:url value='/js/egovframework/whms/jquery-1.11.3.min.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/jquery-ui.min.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/front-ui.js' />" type="text/javascript"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/whms/jquery.navgoco.js' />"></script><!-- left menu js -->

<script src="<c:url value='/js/egovframework/whms/wijmo/vendor/wijmo.min.js'/>" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/wijmo/vendor/wijmo.input.min.js'/>" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/wijmo/vendor/wijmo.grid.min.js'/>" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/wijmo/vendor/wijmo.grid.filter.min.js'/>" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/wijmo/vendor/wijmo.nav.min.js'/>" type="text/javascript"></script>
<script> 
wijmo.setLicenseKey ('14.51.236.196|14.51.236.206|14.51.236.235|203.236.236.136|61.33.235.245|www.cnkoh.co.kr|www.whmscnko.co.kr,825287534425196#B0tM3N7gjM5IDOiojIklkIs4nIxYXOxAjMiojIyVmdiwSZzxWYmpjIyNHZisnOiwmbBJye0ICRiwiI34zdv2EWDxkWSRVQ9JHZ5RUWVJmZxQjaMRlZ9QGZBZnSMljekR7LtlGdrY6VVlHO5dGOjhFO5g5bDFWYGl4L5IHSmdzawFUSBtmUD5keKh6YzhVQ92yTrZHe9BFZIZmV556QS54T6ljUwVWZ5FVTt9mdjxkRzhDVLRmSNNHU7o4ZudEdS5UcudHZrk5NIVGajVFO5YzUZNXYY5kVR3ycmdzMRlWTjZWe8t6a7kUek56TT9kbMVjRDR6UsJUUrUjYtdnUSh4MuRmb9UFan5keHxGdXpVeth6Q92SethWaDFnaN36Sox4ZJVGa4omcLJXcMRXdCtWSDljSM9GSMZ7UO3WRykEa5IXSTJEWll5LCFXZTBXe9hWYHNTcIBzb7Y5LV3SaqB7axUkcvkzVYVlMmF5dMJXZEZDM8QlbUJDbqlFRroURWd6SNNTSXtEeDpWbx4kUygGdEJlI0IyUiwiICN4Q9E4M9QjI0ICSiwSN4UDN5kTNxQTM0IicfJye#4Xfd5nIJBjMSJiOiMkIsIibvl6cuVGd8VEIgQXZlh6U8VGbGBybtpWaXJiOi8kI1xSfiUTSOFlI0IyQiwiIu3Waz9WZ4hXRgAicldXZpZFdy3GclJFIv5mapdlI0IiTisHL3JyS7gDSiojIDJCLi86bpNnblRHeFBCI73mUpRHb55EIv5mapdlI0IiTisHL3JCNGZDRiojIDJCLi86bpNnblRHeFBCIQFETPBCIv5mapdlI0IiTisHL3JyMDBjQiojIDJCLiUmcvNEIv5mapdlI0IiTisHL3JSV8cTQiojIDJCLi86bpNnblRHeFBCI4JXYoNEbhl6YuFmbpZEIv5mapdlI0IiTis7W0ICZyBlIsISMwAjMxADI5ADOwkTMwIjI0ICdyNkIsIicr9ybj9ybr96Yz5Ga79yd7dHLytmLvNmLo36auNmL7d7dsUDNy8SNzIjLzMjLxYDL6MTMuYzMy8iNzIjLzAjMsUzMy8iNzIjLxUjL4EDL6AjMuYzMy8SM58CNxwiN9EjL6MjMuETNuQTMiojIz5GRiwiIU6L1kWJ1oSJ1iojIh94QiwiI6kTMdI4N'); 
</script>
<script>

	/** wijmo grid 객체 */
	var tcMainGrid;
	/** wijmo popup 객체 */
	var dlgDetail;
	/** left 메뉴 script 사용 path */
	var path = location.origin;

	/** wijmo column 정의 */
	var flexColumns = [
		{ header: 'No', binding: "no", width: 80 },
		{ header: '구분', binding: 'loginType', isReadOnly: true, width: "1*" },
		{ header: 'IP', binding: 'conectIp', isReadOnly: true, width: "1*" },
		{ header: '성공여부', binding: 'loginYn', isReadOnly: true, width: "1*" },
		{ header: '일시', binding: 'creatDt', isReadOnly: true, width: "1*" }
	];

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

	/** Grid setting **/
	onload = function() {

		$("input[name=searchKeyword]").keydown(function(key) {
			if (key.keyCode == 13) {
				searchData();
			}
		});

		createGrid();

		/** grid data mapping script */
		function getData() {

			var searchCondition = $("select[name=searchCondition]").val();
			var searchKeyword = $("input[name=searchKeyword]").val();

			/** Data Initialize **/
		    var data = [];

		    /** Data binding Ajax **/
		    $.ajax({
				type:"POST",
				url:"<c:url value='/whms/sys/loginLogDataAjax.do' />",
				data:{
					"searchCondition": searchCondition,
					"searchKeyword": searchKeyword
				},
				dataType:'json',
				timeout:(1000*60),
				async: false,
				success:function(returnData, status) {
					if(status == "success") {
						if(returnData != null) {
							if(returnData.dataList.length != 0) {
								$(".text-number").text(returnData.dataList.length);
								for(var i=0; i<returnData.dataList.length; i++) {
									var result = returnData.dataList[i];
									data.push({
										no: (i+1),
										loginType: result.loginType,
										conectIp: result.conectIp,
										loginYn: result.loginYn,
										creatDt: result.creatDt
							        });
								}
							} else {
								$(".text-number").text(0);
							}
						} else {
							$(".text-number").text(0);
						}
					} else {
						$(".text-number").text(0);
						alert("ERROR!");return;
					} 
				}
			});

		    return data;
		}

		/** 검색 관련 function */
		function searchData() {
			tcMainGrid.dispose();
			createGrid();
		}

		/** grid 생성 */
		function createGrid() {

			// create a grid to show and edit the data
			tcMainGrid = new wijmo.grid.FlexGrid('#tcMainGrid', {
			    allowDelete: true,
			    autoGenerateColumns: false,
			    columns: flexColumns,
			    itemsSource: getData()
			});

			/** grid 첫번째 colume 숨김 */
			tcMainGrid.headersVisibility = "Column";

		}

		/** 조회 버튼 event */
		document.getElementById('btnSearch').addEventListener('click', function () {
			searchData();
		});

	}

	function chkPwd() {

		var id = "<c:out value='${loginVO.id}'/>";
		var pwOrigin = $("#userPw").val();
		var pw = $("#userNewPw").val();
		var pwConf = $("#userNewPwConf").val();

		//var check = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{8,20}$/;

		if(pwOrigin == "") {
			alert("현재 비밀번호를 입력해주세요.");
			return false;
		}

		var num = pw.search(/[0-9]/g);		// 숫자 포함 여부 체크

		if(pw.length < 8) {
			alert("8자리 이상 입력해주세요.");
			return false;
		}

		if(num < 0) {
			alert("최소 하나의 숫자가 필요합니다.");
			return false;
		}

		if(pw.match(id)) {
			alert('ID가 포함된 비밀번호는 사용하실 수 없습니다.');
			return false;
		}

		/* if(pw.length < 8 || pw.length > 20) {
			alert("8자리 ~ 20자리 이내로 입력해주세요.");
			return false;
		}

		if(!check.test(pw)) {
			alert("영문,숫자, 특수문자를 혼합하여 입력해주세요.");
			return false;
		}

		if(/(\w)\1\1\1/.test(pw)) {
			alert('같은 문자를 4번 이상 사용하실 수 없습니다.');
			return false;
		}

		var cnt = 0;
		for(var i=0; i<id.length; i++) {
			if(i+4 <= id.length) {
				var chk = id.substring(i, i+4);
				if(pw.match(chk)) {
					cnt++;
				}
			}
		}

		if(cnt > 0) {
			alert('ID와 4글자 이상 유사한 비밀번호는 사용하실 수 없습니다.');
			return false;
		} */

		if(pw != pwConf) {
			alert('확인 비밀번호가 일치하지 않습니다');
			return false;
		}

		$.ajax({
			type:"POST",
			url:"<c:url value='/whms/sys/userPwdChangeAjax.do' />",
			data:{
				"userPw": btoa(pwOrigin),
				"userPwNew": btoa(pw)
			},
			dataType:'json',
			timeout:(1000*60),
			async: false,
			success:function(returnData, status) {
				if(status == "success") {
					if(returnData.result != null) {
						if(returnData.result == "N") {
							alert("비밀번호 변경 후 1일 이후에 재변경 가능합니다");
						} else if(returnData.result == "D") {
							alert("기존에 사용하신 비밀번호 입니다");
						} else {
							alert("비밀번호 변경이 완료되었습니다");
							location.reload();
						}
					} else {
						alert("현재 비밀번호가 일치하지 않습니다");
					}
				} else {
					alert("패스워드 변경 작업 중 오류가 발생하였습니다");
				}
			},
			error: function() {
				alert("패스워드 변경 작업 중 오류가 발생하였습니다");
			}
		});

		return true;
	}

</script>
</head>
<body id="tbody" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
<form name="selectOne">
	<input name="currentMenu" type="hidden" value="<c:out value='${param.vStartP}'/>" />
	<c:forEach var="result" items="${list_menulist}" varStatus="status" >
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
				<div class="right_area p25">
			        <div class="reg_tit">
					  <h3>패스워드 변경</h3>
					</div>
					<div class="reg_searchbox right_div">
						<!-- search_tb -->
						<div class="search_tb mb0">
						  <button type="button" class="btn-type btn_ico black" onclick="chkPwd()">패스워드 변경</button>
						</div>
					</div>
					<div class="reg_form">
					  <ul>
					    <li class="l_txt">현재 비밀번호</li>
					    <li class="r_area">
					      <input type="password" name="userPw" id="userPw" maxlength="100" value="" placeholder="" class="w50" />
					    </li>
					  </ul>
					  <ul>
					    <li class="l_txt">신규 비밀번호</li>
					    <li class="r_area">
					      <input type="password" name="userNewPw" id="userNewPw" maxlength="100" value="" placeholder="" class="w50" />
					    </li>
					  </ul>
					  <ul>
					    <li class="l_txt">신규 비밀번호 확인</li>
					    <li class="r_area">
					      <input type="password" name="userNewPwConf" id="userNewPwConf" maxlength="100" value="" placeholder="" class="w50" />
					    </li>
					  </ul>
					</div>
					<div class="reg_searchbox" style="margin-top:15px;">
					<!-- search_tb -->
					<div class="search_tb mb0">       
					  <span class="select w100p">
					    <select name="searchCondition" id="searchCondition" >
					      <option value="LOGIN_TYPE" <c:if test="${empty searchVO.searchCondition || searchVO.searchCondition == 'LOGIN_TYPE' }">selected</c:if> >구분</option>
					      <option value="CONECT_IP" <c:if test="${searchVO.searchCondition == 'CONECT_IP' }">selected</c:if> >IP</option>
					      <option value="LOGIN_YN" <c:if test="${searchVO.searchCondition == 'LOGIN_YN' }">selected</c:if> >성공여부</option>
					      <option value="CREAT_DT" <c:if test="${searchVO.searchCondition == 'CREAT_DT' }">selected</c:if> >일시</option>
					    </select>
					  </span>
					  <span class="input w250p">
					  	<input type="text" placeholder="" id="searchKeyword" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword }'/>" style="width:100%" />
					  	<input type="text" style="display: none;" />
					  </span>
					  <button type="button" class="btn-type btn_ico black" id="btnSearch" onClick="searchData()"><span class="i_search_black">조회</span></button>
					</div>
					<!-- // search_tb -->
					</div>
					<div class="reg_tit" style="margin-top:15px;">
					  <h3>로그인 이력</h3>
					</div>
					<div id="tcMainGrid" style="max-height:210px;"></div>
					<span class="pull-right text-count">Total <span class="text-number">0</span></span>
				</div>
			</div>
		</div>
	</div>

<div class="btn_up_layer"></div>
<script src="<c:url value='/js/egovframework/whms/needpopup.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/default.js' />" type="text/javascript"></script>
</body>
</html>