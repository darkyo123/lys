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

	function updateAdditionalData() {
		var makeDt = $.trim($('[name=makeDt]').val());
		//if(makeDt=='') {
			//alert('건강검진이력이 없어 저장하지 못했습니다.');
		//} else {
			setTimeout(function(){$.post('/whms/hi/updateAdditionalHealthMedInfoDataAjax.do', $("#detailForm").serialize(), function(r){
				if(r && r.result) {
					alert('수정했습니다.');
					window.location.reload();
				} else {
					alert('수정하지 못했습니다.');
				}
			}, 'json');}, 10);
		//}
		return false;
	}

	$(document).ready(function() {
		$( ".input_d" ).datepicker({
	    	changeMonth: true,
	        changeYear: true,
	        dateFormat: 'yy-mm-dd'
	    });
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
					<form name="detailForm" id="detailForm" action="<c:url value='/whms/hi/healthAnaysisInfo.do'/>" method="GET">
						<input name="vStartP" type="hidden" value="<c:out value='${param.vStartP}'/>" />
						<input name="useGrpCd" type="hidden" value="<c:out value='${detailVO.useGrpCd}'/>" readonly />
						<input name="usrId" type="hidden" value="<c:out value='${detailVO.usrId}'/>" readonly />
						<input name="makeDt" type="hidden" value="<c:out value='${detailVO.makeDt}'/>" readonly />
						<div class="reg_searchbox"> 
							<!-- search_tb -->
							<div class="search_tb mb0">
							  <div class="stb_left"> <span class="select w100p">
							  	<select name="searchCondition" id="searchCondition">
							      <option value="USR_NM" <c:if test="${empty searchVO.searchCondition || searchVO.searchCondition == 'USR_NM' }">selected</c:if> >이름</option>
							      <option value="USR_ID" <c:if test="${searchVO.searchCondition == 'USR_ID' }">selected</c:if> >ID</option>
							    </select>
							    </span> <span class="input w250p">
							    <input type="text" placeholder="" id="searchKeyword" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword }'/>" style="width:100%" />
							    </span>
							    <button type="button" class="btn-type btn_ico gray_line" onClick="searchData()"><span class="i_search_bg">조회</span></button>
							  </div>
							  <div class="stb_right">
							    <button type="button" class="btn-type btn_ico gray_line" onClick="updateAdditionalData()"><span class="i_mwrite_bg">수정</span></button>
							  </div>
							</div>
							<!-- // search_tb --> 
							</div>
							<div class="summary_tit mt10">
							  <h3>기본정보</h3>
							</div>
							<div class="table type2">
							  <table>
							    <colgroup>
							  <col width="auto">
							  <col width="auto">
							  <col width="auto">
							  <col width="auto">
							  <col width="auto">
							  <col width="auto">
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
						    			<td colspan="6">검색 데이터가 존재하지 않습니다.</td>
						    		</c:when>
						    		<c:otherwise>
										<tr>
									        <td><c:out value="${detailVO.usrNm}"/></td>
									        <td><c:out value="${detailVO.usrId}"/></td>
									        <td><c:if test="${detailVO.sexSeCd == '01'}">남자</c:if><c:if test="${detailVO.sexSeCd == '02'}">여자</c:if></td>
									        <td><c:out value="${detailVO.birDt}"/></td>
									        <td><c:out value="${detailVO.connTelNo}"/></td>
									        <td><c:out value="${detailVO.sysRgsDt}"/></td>
									      </tr>
						    		</c:otherwise>
						    	</c:choose>
							    </tbody>
							  </table>
							</div>
							<div class="summary_tit mt10">
							  <h3>혈압<span>수축/이완/연령</span></h3>
							</div>
							<div class="h_infobox">
							  <ul>
							    <li class="h_left01">
							      <div class="table type4">
							        <table>
							          <colgroup>
							        <col width="34%">
							        <col width="33%">
							        <col width="33%">
							        </colgroup>
							        <thead>
							          <tr>
							            <th></th>
							            <th>수축기 혈압</th>
							            <th>이완기 혈압</th>
							          </tr>
							        </thead>
							        <tbody>
							          <tr class="<c:choose><c:when test="${(detailVO.hypctCt>=91) && (detailVO.hypctCt<120)}">active</c:when><c:otherwise>bg01</c:otherwise></c:choose>">
							            <td class="bg01">혈압 정상수치</td>
							            <td>120미만</td>
							            <td>80미만</td>
							          </tr>
							          <tr class="<c:choose><c:when test="${(detailVO.hypctCt<=90)}">active</c:when><c:otherwise>bg01</c:otherwise></c:choose>">
							            <td class="bg01">저혈압수치</td>
							            <td>90이하</td>
							            <td>60이하</td>
							          </tr>
							          <tr class="<c:choose><c:when test="${(detailVO.hypctCt>=120) && (detailVO.hypctCt<139)}">active</c:when><c:otherwise>bg01</c:otherwise></c:choose>">
							            <td class="bg01">고혈압 전단계</td>
							            <td>120~139</td>
							            <td>80~89</td>
							          </tr>
							          <tr class="<c:choose><c:when test="${(detailVO.hypctCt>=140) && (detailVO.hypctCt<159)}">active</c:when><c:otherwise>bg01</c:otherwise></c:choose>">
							            <td class="bg01">고혈압 1단계</td>
							            <td>140~159</td>
							            <td>90~99</td>
							          </tr>
							          <tr class="<c:choose><c:when test="${(detailVO.hypctCt>=160)}">active</c:when><c:otherwise>bg01</c:otherwise></c:choose>">
							            <td class="bg01">고혈압 2단계</td>
							            <td>160이상</td>
							            <td>100이상</td>
							          </tr>
							        </tbody>
							      </table>
							    </div>
							  </li>
							  <li class="h_left02">
							    <div class="table type4">
							      <table>
							        <colgroup>
							        <col width="20%">
							        <col width="20%">
							        <col width="20%">
							        <col width="20%">
							        <col width="20%">
							        </colgroup>
							        <thead>
							          <tr>
							            <th rowspan="2">나이(연령)</th>
							            <th colspan="2">남자</th>
							            <th colspan="2">여자</th>
							          </tr>
							           <tr>
							            <th class="tbg01">최저혈압</th>
							            <th class="tbg02">최고혈압</th>
							            <th class="tbg01">최저혈압</th>
							            <th class="tbg02">최고혈압</th>
							          </tr>
							        </thead>
							        <tbody>
							          <tr class="<c:if test="${(detailVO.usrAge>=10) && (detailVO.usrAge<20)}">active01</c:if>">
							            <td class="bg01">10대</td>
							            <td>59~79</td>
							            <td>110~134</td>
							            <td>57~75</td>
							            <td>101~123</td>
							          </tr>
							          <tr class="<c:if test="${(detailVO.usrAge>=20) && (detailVO.usrAge<30)}">active01</c:if>">
							            <td class="bg01">20대</td>
							            <td>64~84</td>
							            <td>113~137</td>
							            <td>60~78</td>
							            <td>103~125</td>
							          </tr>
							          <tr class="<c:if test="${(detailVO.usrAge>=30) && (detailVO.usrAge<40)}">active01</c:if>">
							            <td class="bg01">30대</td>
							            <td>67~89</td>
							            <td>114~142</td>
							            <td>63~83</td>
							            <td>106~134</td>
							          </tr>
							          <tr class="<c:if test="${(detailVO.usrAge>=40) && (detailVO.usrAge<50)}">active01</c:if>">
							            <td class="bg01">40대</td>
							            <td>71~95</td>
							            <td>126~150</td>
							            <td>68~90</td>
							            <td>112~146</td>
							          </tr>
							          <tr class="<c:if test="${(detailVO.usrAge>=50) && (detailVO.usrAge<60)}">active01</c:if>">
							            <td class="bg01">50대</td>
							            <td>73~97</td>
							            <td>121~159</td>
							            <td>70~94</td>
							            <td>117~159</td>
							          </tr>
							          <tr class="<c:if test="${(detailVO.usrAge>=60) && (detailVO.usrAge<70)}">active01</c:if>">
							            <td class="bg01">60대</td>
							            <td>73~95</td>
							            <td>124~166</td>
							            <td>71~93</td>
							            <td>124~166</td>
							          </tr>
							          <tr class="<c:if test="${(detailVO.usrAge>=70)}">active01</c:if>">
							            <td class="bg01">70대~</td>
							            <td>71~95</td>
							            <td>128~170</td>
							            <td>68~94</td>
							            <td>131~173</td>
							          </tr>
							        </tbody>
							      </table>
							    </div>
							  </li>
							  <li class="h_right">
							        <p>
							        	<c:choose>
							        		<c:when test='${(detailVO.highDgr == "고위험군")}'><span class="red">고위험군</span></c:when>
							        		<c:when test='${(detailVO.highDgr == "고위험군(예비)")}'><span class="red">고위험군(예비)</span></c:when>
							        		<c:when test='${(detailVO.highDgr == "일반관리")}'><span class="maincolor">일반관리</span></c:when>
							        		<c:when test='${(detailVO.highDgr == "정상")}'><span class="green">정상</span></c:when>
							        		<c:otherwise><span class=""></span></c:otherwise>
							        	</c:choose>
							        </p>
							    </li>
							  </ul>
							</div>
							
							<div class="summary_tit mt20">
							  <h3>뇌심혈관<span>자동평가</span></h3>
							</div>
							<div class="reg_form mt10">
							  <ul>
							    <li class="w_15">허브명</li>
							    <li class="w_35">
							      <input type="text" name="" id="" value="<c:out value='${detailVO.useGrpNm}'/>" placeholder="" class="w50" disabled /><!-- <span class="btn-type btn3 lgray">조회</span> -->           
							    </li>
							    <li class="w_15">성별</li>
							    <li class="w_35">
							      <input type="radio" id="sex01" name="sex" <c:if test="${detailVO.sexSeCd == '01'}">checked</c:if> disabled>
							      <label for="sex01">남자</label>
							      <input type="radio" id="sex02" name="sex" <c:if test="${detailVO.sexSeCd == '02'}">checked</c:if> disabled>
							      <label for="sex02">여자</label>
							    </li>
							  </ul>
							  <ul>
							    <li class="w_15">이름</li>
							    <li class="w_35">
							      <input type="text" name="" id="" value="<c:out value='${detailVO.usrNm}'/>" placeholder="" class="w50" disabled />
							    </li>
							    <li class="w_15">물류경력</li>
							    <li class="w_35">
							      <input type="text" name="" id="" value="<c:out value='${detailVO.jobCareer}'/>" placeholder="" class="w30" disabled />
							    </li>
							  </ul>
							  <ul>
							    <li class="w_15">혈압(수축)</li>
							    <li class="w_35">
							      <input type="text" name="" id="" value="<c:out value='${detailVO.hypctCt}'/>" placeholder="" class="w100p" disabled />
							      <span>mmHg</span>
							    </li>
							    <li class="w_15">혈압(이완)</li>
							    <li class="w_35">
							      <input type="text" name="" id="" value="<c:out value='${detailVO.hyprxCt}'/>" placeholder="" class="w100p" disabled />
							      <span>mmHg</span>
							    </li>
							  </ul>
							  
							  <ul>
							    <li class="w_15">이하지지혈증<img src="<c:url value='/images/egovframework/whms/i_check.png' />" alt=""></li>
							    <li class="w_35">
							      <input type="text" name="dyslipidemia1" id="dyslipidemia1" value="<c:out value='${detailVO.dyslipidemia1}'/>" placeholder="" class="w100p" />
							      <span>mL</span>
							    </li>
							    <li class="w_15">이상지지혈증<img src="<c:url value='/images/egovframework/whms/i_check.png' />" alt=""></li>
							    <li class="w_35">
							      <input type="text" name="dyslipidemia2" id="dyslipidemia2" value="<c:out value='${detailVO.dyslipidemia2}'/>" placeholder="" class="w100p" />
							      <span>HDL, mL</span>
							    </li>
							  </ul>
							  
							  <ul>
							    <li class="w_15">신장</li>
							    <li class="w_35">
							      <input type="text" name="" id="" value="<c:out value='${detailVO.usrHet}'/>" placeholder="" class="w100p" disabled /><span>cm</span>
							    </li>
							    <li class="w_15">몸무게</li>
							    <li class="w_35">
							      <input type="text" name="" id="" value="<c:out value='${detailVO.usrWet}'/>" placeholder="" class="w100p" disabled /><span>kg</span>
							    </li>
							  </ul>
							 <ul>
							    <li class="w_15">표적장기손상<img src="<c:url value='/images/egovframework/whms/i_check.png' />" alt=""></li>
							    <li class="w_35">
							      <input type="radio" id="p01" name="targetOrganDamage" value="0" <c:if test="${detailVO.targetOrganDamage == '0'}">checked</c:if> >
							      <label for="p01">0</label>
							      <input type="radio" id="p02" name="targetOrganDamage" value="1" <c:if test="${detailVO.targetOrganDamage == '1'}">checked</c:if> >
							      <label for="p02">1</label>
							      <span>(없음:0, 1개이상:1)</span>
							    </li>
							    <li class="w_15">기타보유질병</li>
							    <li class="w_35">
							      <input type="radio" id="e01" name="etc" <c:if test="${detailVO.havdisYn == 'N'}">checked</c:if> disabled >
							      <label for="e01">0</label>
							      <input type="radio" id="e02" name="etc" <c:if test="${detailVO.havdisYn == 'Y'}">checked</c:if> disabled >
							      <label for="e02">1</label>
							      <span>(없음:0, 1개이상:1)</span>
							    </li>
							  </ul>
							  
							  <ul>
							    <li class="w_15">가족력</li>
							    <li class="w_35">
							      <input type="radio" id="f01" name="family" <c:if test="${detailVO.fahsYn == 'N'}">checked</c:if> disabled>
							      <label for="f01">0</label>
							      <input type="radio" id="f02" name="family" <c:if test="${detailVO.fahsYn == 'Y'}">checked</c:if> disabled >
							      <label for="f02">1</label>
							      <span>(없음:0, 1개이상:1)</span>
							    </li>
							    <li class="w_15">연락처</li>
							    <li class="w_35">
							      <input type="text" name="" id="" value="<c:out value='${detailVO.connTelNo}'/>" placeholder="" class="w50" disabled />
							    </li>
							  </ul>
							  <ul>
							    <li class="w_15">흡연</li>
							    <li class="w_35">
							      <input type="radio" id="sm01" name="smoking" <c:if test="${detailVO.smkYn == 'N'}">checked</c:if> disabled>
							      <label for="sm01">0</label>
							      <input type="radio" id="sm02" name="smoking" <c:if test="${detailVO.smkYn == 'Y'}">checked</c:if> disabled >
							      <label for="sm02">1</label>
							      <span>(금연:0, 흡연:1)</span>
							    </li>
							    <li class="w_15">음주</li>
							    <li class="w_35">
							      <input type="radio" id="d01" name="drink" <c:if test="${detailVO.alcYn == 'N'}">checked</c:if> disabled>
							      <label for="d01">0</label>
							      <input type="radio" id="d02" name="drink" <c:if test="${detailVO.alcYn == 'Y'}">checked</c:if> disabled >
							      <label for="d02">1</label>
							      <span>(금주:0, 음주:1)</span>
							    </li>
							  </ul>
							</div>
							<!-- // reg_form --> 
							<div class="h_graybox">
							    <p>BMI : <c:out value='${detailVO.bmi}'/></p>
							    <p>
							      <input type="radio" id="b01" name="b" checked>
							      <label for="b01">정상</label>
							      <input type="radio" id="b02" name="b" >
							      <label for="b02">저위험</label>
							      <input type="radio" id="b03" name="b" >
							      <label for="b03">중등도위험</label>
							      <input type="radio" id="b04" name="b" >
							      <label for="b04">고위험</label>
							    </p>
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