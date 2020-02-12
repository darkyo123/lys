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
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/style.css' />" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/reset.css' />" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/animate.css' />" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/jquery-ui.min.css' />" type="text/css" />

<script src="<c:url value='/js/egovframework/whms/jquery-1.11.3.min.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/jquery-ui.min.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/front-ui.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/wijmo/vendor/wijmo.min.js'/>" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/wijmo/vendor/wijmo.input.min.js'/>" type="text/javascript"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/whms/jquery.navgoco.js' />"></script><!-- left menu js -->
<script> 
wijmo.setLicenseKey ('14.51.236.196|14.51.236.206|14.51.236.235|203.236.236.136|61.33.235.245|www.cnkoh.co.kr|www.whmscnko.co.kr,825287534425196#B0tM3N7gjM5IDOiojIklkIs4nIxYXOxAjMiojIyVmdiwSZzxWYmpjIyNHZisnOiwmbBJye0ICRiwiI34zdv2EWDxkWSRVQ9JHZ5RUWVJmZxQjaMRlZ9QGZBZnSMljekR7LtlGdrY6VVlHO5dGOjhFO5g5bDFWYGl4L5IHSmdzawFUSBtmUD5keKh6YzhVQ92yTrZHe9BFZIZmV556QS54T6ljUwVWZ5FVTt9mdjxkRzhDVLRmSNNHU7o4ZudEdS5UcudHZrk5NIVGajVFO5YzUZNXYY5kVR3ycmdzMRlWTjZWe8t6a7kUek56TT9kbMVjRDR6UsJUUrUjYtdnUSh4MuRmb9UFan5keHxGdXpVeth6Q92SethWaDFnaN36Sox4ZJVGa4omcLJXcMRXdCtWSDljSM9GSMZ7UO3WRykEa5IXSTJEWll5LCFXZTBXe9hWYHNTcIBzb7Y5LV3SaqB7axUkcvkzVYVlMmF5dMJXZEZDM8QlbUJDbqlFRroURWd6SNNTSXtEeDpWbx4kUygGdEJlI0IyUiwiICN4Q9E4M9QjI0ICSiwSN4UDN5kTNxQTM0IicfJye#4Xfd5nIJBjMSJiOiMkIsIibvl6cuVGd8VEIgQXZlh6U8VGbGBybtpWaXJiOi8kI1xSfiUTSOFlI0IyQiwiIu3Waz9WZ4hXRgAicldXZpZFdy3GclJFIv5mapdlI0IiTisHL3JyS7gDSiojIDJCLi86bpNnblRHeFBCI73mUpRHb55EIv5mapdlI0IiTisHL3JCNGZDRiojIDJCLi86bpNnblRHeFBCIQFETPBCIv5mapdlI0IiTisHL3JyMDBjQiojIDJCLiUmcvNEIv5mapdlI0IiTisHL3JSV8cTQiojIDJCLi86bpNnblRHeFBCI4JXYoNEbhl6YuFmbpZEIv5mapdlI0IiTis7W0ICZyBlIsISMwAjMxADI5ADOwkTMwIjI0ICdyNkIsIicr9ybj9ybr96Yz5Ga79yd7dHLytmLvNmLo36auNmL7d7dsUDNy8SNzIjLzMjLxYDL6MTMuYzMy8iNzIjLzAjMsUzMy8iNzIjLxUjL4EDL6AjMuYzMy8SM58CNxwiN9EjL6MjMuETNuQTMiojIz5GRiwiIU6L1kWJ1oSJ1iojIh94QiwiI6kTMdI4N'); 
</script>
<script>

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

	/** 검색 관련 function */
	function searchData() {
		if($('#searchCondition').val()=='') {
			alert('검색 항목을 선택해주세요.');
			$('#searchCondition').focus();
			return false;
		}
		if($('#searchKeyword').val()=='') {
			alert('검색어를 입력해주세요.');
			$('#searchKeyword').focus();
			return false;
		}
		/** 검색조건이 이름일 경우 동명이인 처리 script */
		if($('#searchCondition').val() == "USR_NM") {
			$.ajax({
				type:"POST",
				url:"<c:url value='/whms/hi/summaryCheckList.do' />",
				data:{
					"searchCondition": $('#searchCondition').val(),
					"searchKeyword": $('#searchKeyword').val()
				},
				dataType:'json',
				timeout:(1000*60),
				async: false,
				success:function(returnData, status) {
					if(status == "success") {
						if(returnData != null) {
							if(returnData.dataList.length != 0) {
								if(returnData.dataList.length == 1) {			// 한명이면 submit
									$("#detailForm").submit();
								} else {														// 동명이인 존재시 팝업 호출
									// show dialog
									$("#tb").html("");
									for(var i=0; i<returnData.dataList.length; i++) {
										var result = returnData.dataList[i];
										var tmpHtml = "";
										tmpHtml = tmpHtml.concat("<tr class='usrTr' onClick='fn_detail_submit("+result.usrId+")'>");
										tmpHtml = tmpHtml.concat("<td>").concat(result.useGrpNm).concat("</td>");
										tmpHtml = tmpHtml.concat("<td>").concat((result.usrNm == null || result.usrNm == "") ? "" : result.usrNm).concat("</td>");
										tmpHtml = tmpHtml.concat("<td>").concat(result.usrId).concat("</td>");
										tmpHtml = tmpHtml.concat("<td>").concat((result.birDt == null || result.birDt == "") ? "" : result.birDt).concat("</td>");
										tmpHtml = tmpHtml.concat("<td>").concat((result.connTelno == null || result.connTelno == "") == null ? "" : result.connTelno).concat("</td>");
										tmpHtml = tmpHtml.concat("</tr>");
										$("#tb").append(tmpHtml);
									}
								    dlgDetail.show(true, function (s) {

								    });
								}
							} else {
								$("#detailForm").submit();
							}
						} else {
							$("#detailForm").submit();
						}
					} else {
						alert("조회 중 오류가 발생하였습니다. 관리자에게 문의하여 주십시오");
						return;
					}
				}
			});
		} else {
			$("#detailForm").submit();
		}
	}

	/** 동명이인 팝업에서 row 클릭 시 ID로 값 세팅하여 submit */
	function fn_detail_submit(id) {
		$('#searchCondition').val("USR_ID").prop("selected", true);
		$("#searchKeyword").val(id);
		$("#detailForm").submit();
	}

	/** 측정일 이동 관련 script */
	function selectDtm(value) {
		if(value != null && value != "") {
			$("input[name=paramDtm]").val(value);
			$("#detailForm").submit();			
		}
	}

	$(document).ready(function() {
		/** Enter 처리 */
	    $("input[name=searchKeyword]").keydown(function(key) {
			if (key.keyCode == 13) {
				searchData();
			}
		});
	    /** wijmo modal 세팅 */
		dlgDetail = new wijmo.input.Popup('#dlgDetail', {
		    removeOnHide: false
		});
	})

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
					<form id="detailForm" name="listForm" action="<c:url value='/whms/hi/summary.do'/>" method="post">
						<input name="vStartP" type="hidden" value="<c:out value='${param.vStartP}'/>" />
						<input name="paramDtm" type="hidden" value="" />
						<div class="reg_searchbox"> 
							<!-- search_tb -->
							<div class="search_tb mb0"> <span class="select w100p">
							  <select name="searchCondition" id="searchCondition" >
							      <option value="USR_NM" <c:if test="${empty searchVO.searchCondition || searchVO.searchCondition == 'USR_NM' }">selected</c:if> >이름</option>
							      <option value="USR_ID" <c:if test="${searchVO.searchCondition == 'USR_ID' }">selected</c:if> >ID</option>
							    </select>
							  </span> <span class="input w250p">
							  <input type="text" placeholder="" id="searchKeyword" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword }'/>" style="width:100%" />
							  <input type="text" style="display: none;" />
							  </span>
							  <button type="button" class="btn-type btn_ico black" onClick="searchData();"><span class="i_search_black">조회</span></button>
							</div>
							<!-- // search_tb --> 
							</div>
							<div class="summary_tab">
							  <ul>
							    <li><a href="javascript:selectDtm('<c:out value="${detailVO.prevDtm}"/>');">이전 측정일</a></li>
							    <li class="active"><a href="#">현재 측정일<span><c:out value='${detailVO.chkDay}'/></span></a></li>
							    <li><a href="javascript:selectDtm('<c:out value="${detailVO.nextDtm}"/>');">다음 측정일</a></li>
							  </ul>
							</div>

							<!-- 현재측정일 -->
							  <div class="summary_tit">
							    <h3><a href="/whms/hi/basicMedInfo.do?searchCondition=USR_ID&searchKeyword=${detailVO.usrId}&vStartP=2020000&chkURL=%2Fwhms%2Fhi%basicMedInfo.do">기본정보</a></h3>
							  </div>
							  <div class="table type2">
							    <table>
							      <colgroup>
							  <col width="150">
							  <col width="auto">
							  <col width="150">
							  <col width="150">
							  <col width="150">
							  <col width="150">
							  </colgroup>
							    <thead>
							      <tr>
							        <th>이름</th>
							        <th>ID (핀번호)</th>
							        <th>성별</th>
							        <th>생년월일</th>
							        <th>연락처</th>
							        <th>등록일</th>
							      </tr>
							    </thead>
							    <tbody>
							    	<c:choose>
							    	<c:when test="${empty detailVO }">
							    		<tr>
							    			<td colspan="6">데이터가 존재하지 않습니다.</td>
							    		</tr>
							    	</c:when>
									<c:otherwise>
										<tr>
											<td><c:out value='${detailVO.usrNm}'/></td>
											<td><c:out value='${detailVO.usrId}'/></td>
											<td><c:out value='${detailVO == null ? "" : detailVO.sexSecd == "01" ? "남자" : "여자"}'/></td>
											<td><c:out value='${detailVO.birDt}'/></td>
											<td><c:out value='${detailVO.connTelno}'/></td>
											<td><c:out value='${detailVO.sysRgsDt}'/></td>
										</tr>
									</c:otherwise>
									</c:choose>
							    </tbody>
							  </table>
							</div>
							<div class="summary_tit mt20">
							  <h3>근로 정보</h3>
							</div>
							<div class="table type2">
							  <table>
							    <colgroup>
							  <col width="33%">
							  <col width="auto">
							  <col width="33%">
							  </colgroup>
							    <thead>
							      <tr>
							      	<th>근무일수</th>
							        <th>연속 근무일수</th>
							        <th>야간연속 근무</th>
							      </tr>
							    </thead>
							    <tbody>
							    <c:choose>
							    	<c:when test="${empty detailVO }">
							    		<tr>
							    			<td colspan="3">데이터가 존재하지 않습니다.</td>
							    		</tr>
							    	</c:when>
							    	<c:otherwise>
										<tr>
											<td><c:out value="${detailVO.dutyDy}"/>일</td>
											<td><c:out value="${detailVO.contDutyDy}"/>일</td>
											<td><c:out value="${detailVO.ngcnDutyDy}"/>일</td>
										</tr>
							    	</c:otherwise>
						    	</c:choose>
							    </tbody>
							  </table>
							</div>
							<div class="summary_tit mt20">
							  <h3><a href="/whms/hi/qsltList.do?searchCondition=USR_ID&searchKeyword=${detailVO.usrId}&vStartP=2070000&chkURL=%2Fwhms%2Fhi%2FqsltList.do">문진 정보</a></h3>
							</div>
							<div class="table type2">
							  <table>
							    <colgroup>
							  <col width="33%">
							  <col width="auto">
							  <col width="33%">
							  </colgroup>
							    <thead>
							      <tr>
							        <th>가족력</th>
							        <th>생활습관</th>
							        <th>키 / 몸무게</th>
							      </tr>
							    </thead>
							    <tbody>
							    <c:choose>
							    	<c:when test="${empty detailVO }">
							    		<tr>
							    			<td colspan="3">데이터가 존재하지 않습니다.</td>
							    		</tr>
							    	</c:when>
							    	<c:otherwise>
										<tr>
											<td>
												<c:choose>
													<c:when test="${detailVO.fahsYn == 'Y'}" >
														없음
													</c:when>
													<c:otherwise>
														<c:if test="${detailVO.fahs1Yn == 'Y'}">고혈압 </c:if>
														<c:if test="${detailVO.fahs2Yn == 'Y'}">당뇨병 </c:if>
														<c:if test="${detailVO.fahs3Yn == 'Y'}">뇌졸증 </c:if>
														<c:if test="${detailVO.fahs4Yn == 'Y'}">심장병 </c:if>
														<c:if test="${detailVO.fahs5Yn == 'Y'}">심근경색증 </c:if>
														<c:if test="${detailVO.fahs6Yn == 'Y'}">기타 (<c:out value="${detailVO.fahsEtc }"/>) </c:if>
													</c:otherwise>
												</c:choose>
											</td>
											<td>술 <c:out value="${detailVO.alcYn == 'Y' ? detailVO.adrkCt : '0'}"/> 잔 / 담배 <c:out value="${detailVO.smkYn == 'Y' ? detailVO.dysmkCt : '0'}"/> 갑</td>
											<td><c:out value="${empty detailVO.usrHet ? 0 : detailVO.usrHet }"/> / <c:out value="${empty detailVO.usrWet ? 0 : detailVO.usrWet}"/></td>
										</tr>
							    	</c:otherwise>
						    	</c:choose>
							    </tbody>
							  </table>
							</div>
							<div class="summary_tit mt20">
							  <h3><a href="/whms/hi/healthMedInfo.do?searchCondition=USR_ID&searchKeyword=${detailVO.usrId}&vStartP=2040000&chkURL=%2Fwhms%2Fhi%2FhealthMedInfo.do">건강 검진 정보</a></h3>
							</div>
							<div class="table type2">
							  <table>
							    <colgroup>
							  <col width="33%">
							  <col width="auto">
							  <col width="33%">
							  </colgroup>
							    <thead>
							      <tr>
							        <th>최종 검진</th>
							        <th>검진 경과일</th>
							        <th>검진 회수</th>
							      </tr>
							    </thead>
							    <tbody>
							    <c:choose>
							    	<c:when test="${empty detailVO }">
							    		<tr>
							    			<td colspan="3">데이터가 존재하지 않습니다.</td>
							    		</tr>
							    	</c:when>
							    	<c:otherwise>
										<tr>
											<td><c:out value="${detailVO.lstMedDt}"/></td>
											<td><c:out value="${detailVO.medPrgsDct == null ? '0' : detailVO.medPrgsDct}"/>일</td>
											<td><c:out value="${detailVO.medCnt == null ? '0' : detailVO.medCnt}"/>회</td>
										</tr>
							    	</c:otherwise>
						    	</c:choose>
							    </tbody>
							  </table>
							</div>
							<div class="summary_tit mt20">
							  <h3><a href="/whms/hi/pressureMeasureInfo.do?searchCondition=USR_ID&searchKeyword=${detailVO.usrId}&vStartP=2030000&chkURL=%2Fwhms%2Fhi%2FpressureMeasureInfo.do">혈압 측정 정보</a></h3>
							</div>
							<div class="table type2">
							  <table>
							    <colgroup>
							  <col width="16%">
							  <col width="16%">
							  <col width="16%">
							  <col width="16%">
							  <col width="auto">
							  <col width="16%">
							  </colgroup>
							      <thead>
							        <tr>
							          <th>혈압수축</th>
							          <th>혈압이완</th>
							          <th>맥박</th>
							          <th>최종측정일</th>
							          <th>측정 경과일</th>
							          <th>측정 회수</th>
							        </tr>
							      </thead>
							      <tbody>
							      <c:choose>
							    	<c:when test="${empty detailVO }">
							    		<tr>
							    			<td colspan="6">데이터가 존재하지 않습니다.</td>
							    		</tr>
							    	</c:when>
							    	<c:otherwise>
										<tr>
											<td><c:out value="${detailVO.hypctCt}"/></td>
											<td><c:out value="${detailVO.hyprxCt}"/></td>
											<td><c:out value="${detailVO.plsCt}"/></td>
											<td><c:out value="${detailVO.chkDay}"/></td>
											<td><c:out value="${detailVO.lstPrgsDct == null ? '0' : detailVO.lstPrgsDct}"/>일</td>
											<td><c:out value="${detailVO.chkCnt == null ? '0' : detailVO.chkCnt}"/>회</td>
										</tr>
							    	</c:otherwise>
						    	</c:choose>
							      </tbody>
							    </table>
							  </div>
							  <div class="graybox">
							    <ul>
							      <li>교육이수<span><c:out value="${detailVO.eduCptYn }"/></span></li>
							      <li>고위험군<span><c:out value="${detailVO == null ? '' : detailVO.highDgrCd == '' ? 'N' : detailVO.highDgrCd == '21' ? 'Y'  : 'N'}"/></span></li>
							      <li>뇌심혈관<span><c:out value="${detailVO.brdevlYn }"/></span></li>
							    </ul>
							  </div>
 
					</form>
				</div>
			</div>
		</div>
	</div>

	<div class="modal-dialog" id="dlgDetail" style="display:none;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close wj-hide" aria-hidden="true">&times;</button>
				<h4 class="modal-title">사용자 선택</h4>
			</div>
			<div class="modal-body">
				<div class="table type1">
					<table>
						<colgroup>
							<col width="80">
							<col width="80">
							<col width="80">
							<col width="100">
							<col width="100">
						</colgroup>
						<thead>
							<tr>
								<th>허브명</th>
								<th>이름</th>
								<th>ID</th>
								<th>생년월일</th>
								<th>연락처</th>
							</tr>
						</thead>
						<tbody id="tb">
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-warning wj-hide-cancel" >Cancel</button>
			</div>
		</div>
	</div>

<div class="btn_up_layer"></div>
<script src="<c:url value='/js/egovframework/whms/needpopup.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/default.js' />" type="text/javascript"></script>
</body>
</html>