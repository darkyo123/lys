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

	/** datepicker 설정 */
	$( function() {
	    $( ".input_d" ).datepicker({
	    	changeMonth: true,
	        changeYear: true,
	        dateFormat: 'yy-mm-dd'
	    });
	} );

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
								if(returnData.dataList.length == 1) {
									$("#detailForm").submit();
								} else {
									// show dialog
									$("#tb").html("");
									for(var i=0; i<returnData.dataList.length; i++) {
										var result = returnData.dataList[i];
										var tmpHtml = "";
										tmpHtml = tmpHtml.concat("<tr class='usrTr' onClick='fn_detail_submit("+result.usrId+")'>");
										tmpHtml = tmpHtml.concat("<td>").concat(result.useGrpNm).concat("</td>");
										tmpHtml = tmpHtml.concat("<td>").concat((result.usrNm == null || result.usrNm == "") ? "" : result.usrNm.substr(0,1).concat("**")).concat("</td>");
										tmpHtml = tmpHtml.concat("<td>").concat(result.usrId).concat("</td>");
										tmpHtml = tmpHtml.concat("<td>").concat((result.birDt == null || result.birDt == "") ? "" : result.birDt.substr(0,1).concat("***-**-**")).concat("</td>");
										tmpHtml = tmpHtml.concat("<td>").concat((result.connTelno == null || result.connTelno == "") == null ? "" : "010-****-****").concat("</td>");
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

	/** 팝업에서 ID 선택 시 function */
	function fn_detail_submit(id) {
		$('#searchCondition').val("USR_ID").prop("selected", true);
		$("#searchKeyword").val(id);
		$("#detailForm").submit();
	}

	/** 문진표 수정 func */
	function updateData() {
		var $frm = $('#detailForm');
		var usrId = "<c:out value='${detailVO.usrId}'/>";
		if("" == usrId) {
			alert("검색된 사용자가 없습니다");
			return;
		} else {
			if(!validateQslt()) {
				return;
			} else {
				$.post('/whms/hi/qsltUpdateAjax.do', $frm.serialize(), function(r){
					if(r.result) {
						alert('수정되었습니다.');
						window.location.reload();
					} else {
						alert('수정되지 않았습니다.');
					}
				}, 'json');
			}
		}
	}

	/** 문진표 삭제 (해당 기능 없음) */
	function deleteData() {
		var $frm = $('#detailForm');
		var usrId = "<c:out value='${detailVO.usrId}'/>";
		if("" == usrId) {
			alert("검색된 사용자가 없습니다");
			return;
		} else {
			if(confirm("삭제하시겠습니까?")) {
				$.post('/whms/hi/qsltDeleteAjax.do', $frm.serialize(), function(r){
					if(r.result) {
						alert('삭제되었습니다.');
						window.location.href="/whms/hi/qsltList.do";
					} else {
						alert('삭제되지 않았습니다.');
					}
				}, 'json');
			}
		}
	}

	/** input type number maxlength */
	function maxLengthCheck(object){
		if (object.value.length > object.maxLength){
			object.value = object.value.slice(0, object.maxLength);
		}    
	}

	/** 음주여부 toggle */
	function toggleAlc() {
		var checkVal = $("input[name=AlcYn]:checked").val();
		if("Y" == checkVal) {
			$("#WekAlcCt").attr("readonly", false);
			$("#AdrkCt").attr("readonly", false);
		} else {
			$("#WekAlcCt").val("");
			$("#AdrkCt").val("");
			$("#WekAlcCt").attr("readonly", true);
			$("#AdrkCt").attr("readonly", true);
		}
	}

	/** 흡연여부 toggle */
	function toggleSmk() {
		var checkVal = $("input[name=SmkYn]:checked").val();
		if("Y" == checkVal) {
			$("#DysmkCt").attr("readonly", false);
		} else {
			$("#DysmkCt").val("");
			$("#DysmkCt").attr("readonly", true);
		}
	}

	/** 가족력여부 validation */
	function fn_check_fahs() {
		var fahs1Yn = $("input:checkbox[id='Fahs1Yn']").is(":checked");
		var fahs2Yn = $("input:checkbox[id='Fahs2Yn']").is(":checked");
		var fahs3Yn = $("input:checkbox[id='Fahs3Yn']").is(":checked");
		var fahs4Yn = $("input:checkbox[id='Fahs4Yn']").is(":checked");
		var fahs5Yn = $("input:checkbox[id='Fahs5Yn']").is(":checked");
		var fahs6Yn = $("input:checkbox[id='Fahs6Yn']").is(":checked");
		var fahsYn = $("input:checkbox[id='FahsYn']").is(":checked");
		if(fahsYn) {
			$("input:checkbox[id='Fahs1Yn']").attr("checked", false);
			$("input:checkbox[id='Fahs2Yn']").attr("checked", false);
			$("input:checkbox[id='Fahs3Yn']").attr("checked", false);
			$("input:checkbox[id='Fahs4Yn']").attr("checked", false);
			$("input:checkbox[id='Fahs5Yn']").attr("checked", false);
			$("input:checkbox[id='Fahs6Yn']").attr("checked", false);
			$("#FahsEtc").attr("readonly", true);
			$("#FahsEtc").val("");
		} else {
			var checkVal = $("input:checkbox[name=Fahs6Yn]:checked").is(":checked");
			if(checkVal) {
				$("#FahsEtc").attr("readonly", false);
			} else {
				$("#FahsEtc").val("");
				$("#FahsEtc").attr("readonly", true);
			}
		}
	}

	/** 일반증상 validation */
	function fn_check_havdis() {
		var havdis1Yn = $("input:checkbox[id='Havdis1Yn']").is(":checked");
		var havdis2Yn = $("input:checkbox[id='Havdis2Yn']").is(":checked");
		var havdis3Yn = $("input:checkbox[id='Havdis3Yn']").is(":checked");
		var havdis4Yn = $("input:checkbox[id='Havdis4Yn']").is(":checked");
		var havdis5Yn = $("input:checkbox[id='Havdis5Yn']").is(":checked");
		var havdis6Yn = $("input:checkbox[id='Havdis6Yn']").is(":checked");
		var havdis7Yn = $("input:checkbox[id='Havdis7Yn']").is(":checked");
		var havdis8Yn = $("input:checkbox[id='Havdis8Yn']").is(":checked");
		var havdisYn = $("input:checkbox[id='HavdisYn']").is(":checked");
		if(havdisYn) {
			$("input:checkbox[id='Havdis1Yn']").attr("checked", false);
			$("input:checkbox[id='Havdis2Yn']").attr("checked", false);
			$("input:checkbox[id='Havdis3Yn']").attr("checked", false);
			$("input:checkbox[id='Havdis4Yn']").attr("checked", false);
			$("input:checkbox[id='Havdis5Yn']").attr("checked", false);
			$("input:checkbox[id='Havdis6Yn']").attr("checked", false);
			$("input:checkbox[id='Havdis7Yn']").attr("checked", false);
			$("input:checkbox[id='Havdis8Yn']").attr("checked", false);
			$("#HavdisEtc").attr("readonly", true);
			$("#HavdisEtc").val("");
		} else {
			var checkVal = $("input:checkbox[name=Havdis7Yn]:checked").is(":checked");
			if(checkVal) {
				$("#HavdisEtc").attr("readonly", false);
			} else {
				$("#HavdisEtc").val("");
				$("#HavdisEtc").attr("readonly", true);
			}
		}
	}

	/** 호흡기계 증상 validation */
	function fn_check_repsym() {
		var repsym1Yn = $("input:checkbox[id='Repsym1Yn']").is(":checked");
		var repsym2Yn = $("input:checkbox[id='Repsym2Yn']").is(":checked");
		var repsym3Yn = $("input:checkbox[id='Repsym3Yn']").is(":checked");
		var repsym4Yn = $("input:checkbox[id='Repsym4Yn']").is(":checked");
		var repsym5Yn = $("input:checkbox[id='Repsym5Yn']").is(":checked");
		if(repsym5Yn) {
			$("input:checkbox[id='Repsym1Yn']").attr("checked", false);
			$("input:checkbox[id='Repsym2Yn']").attr("checked", false);
			$("input:checkbox[id='Repsym3Yn']").attr("checked", false);
			$("input:checkbox[id='Repsym4Yn']").attr("checked", false);
		}
	}

	/** 순환기계 증상 validation */
	function fn_check_cirsym() {
		var cirsym1Yn = $("input:checkbox[id='Cirsym1Yn']").is(":checked");
		var cirsym2Yn = $("input:checkbox[id='Cirsym2Yn']").is(":checked");
		var cirsym3Yn = $("input:checkbox[id='Cirsym3Yn']").is(":checked");
		var cirsym4Yn = $("input:checkbox[id='Cirsym4Yn']").is(":checked");
		var cirsym5Yn = $("input:checkbox[id='Cirsym5Yn']").is(":checked");
		var cirsym6Yn = $("input:checkbox[id='Cirsym6Yn']").is(":checked");
		var cirsym7Yn = $("input:checkbox[id='Cirsym7Yn']").is(":checked");
		if(cirsym7Yn) {
			$("input:checkbox[id='Cirsym1Yn']").attr("checked", false);
			$("input:checkbox[id='Cirsym2Yn']").attr("checked", false);
			$("input:checkbox[id='Cirsym3Yn']").attr("checked", false);
			$("input:checkbox[id='Cirsym4Yn']").attr("checked", false);
			$("input:checkbox[id='Cirsym5Yn']").attr("checked", false);
			$("input:checkbox[id='Cirsym6Yn']").attr("checked", false);
		}
	}

	/** 운동 혹은 사고 관련 validation */
	function toggleMoaci() {
		var checkVal = $("input[name=MoaciYn]:checked").val();
		if("Y" == checkVal) {
			$("input:checkbox[name=Moaci1Yn]").attr("disabled", false);
			$("input:checkbox[name=Moaci2Yn]").attr("disabled", false);
			$("input:checkbox[name=Moaci3Yn]").attr("disabled", false);
			$("input:checkbox[name=Moaci4Yn]").attr("disabled", false);
			$("input:checkbox[name=Moaci5Yn]").attr("disabled", false);
			$("input:checkbox[name=Moaci6Yn]").attr("disabled", false);
			$("input:checkbox[name=Moaci7Yn]").attr("disabled", false);
		} else {
			$("input:checkbox[name=Moaci1Yn]").attr("checked", false);
			$("input:checkbox[name=Moaci2Yn]").attr("checked", false);
			$("input:checkbox[name=Moaci3Yn]").attr("checked", false);
			$("input:checkbox[name=Moaci4Yn]").attr("checked", false);
			$("input:checkbox[name=Moaci5Yn]").attr("checked", false);
			$("input:checkbox[name=Moaci6Yn]").attr("checked", false);
			$("input:checkbox[name=Moaci7Yn]").attr("checked", false);
			$("input:checkbox[name=Moaci1Yn]").attr("disabled", true);
			$("input:checkbox[name=Moaci2Yn]").attr("disabled", true);
			$("input:checkbox[name=Moaci3Yn]").attr("disabled", true);
			$("input:checkbox[name=Moaci4Yn]").attr("disabled", true);
			$("input:checkbox[name=Moaci5Yn]").attr("disabled", true);
			$("input:checkbox[name=Moaci6Yn]").attr("disabled", true);
			$("input:checkbox[name=Moaci7Yn]").attr("disabled", true);
		}
	}

	/** 작업 관련 통증 validation */
	function toggleWkpn() {
		var checkVal = $("input[name=WkpnYn]:checked").val();
		if("Y" == checkVal) {
			$("input:checkbox[name=Wkpn1Yn]").attr("disabled", false);
			$("input:checkbox[name=Wkpn2Yn]").attr("disabled", false);
			$("input:checkbox[name=Wkpn3Yn]").attr("disabled", false);
			$("input:checkbox[name=Wkpn4Yn]").attr("disabled", false);
			$("input:checkbox[name=Wkpn5Yn]").attr("disabled", false);
			$("input:checkbox[name=Wkpn6Yn]").attr("disabled", false);
			$("input:checkbox[name=Wkpn7Yn]").attr("disabled", false);
		} else {
			$("input:checkbox[name=Wkpn1Yn]").attr("checked", false);
			$("input:checkbox[name=Wkpn2Yn]").attr("checked", false);
			$("input:checkbox[name=Wkpn3Yn]").attr("checked", false);
			$("input:checkbox[name=Wkpn4Yn]").attr("checked", false);
			$("input:checkbox[name=Wkpn5Yn]").attr("checked", false);
			$("input:checkbox[name=Wkpn6Yn]").attr("checked", false);
			$("input:checkbox[name=Wkpn7Yn]").attr("checked", false);
			$("input:checkbox[name=Wkpn1Yn]").attr("disabled", true);
			$("input:checkbox[name=Wkpn2Yn]").attr("disabled", true);
			$("input:checkbox[name=Wkpn3Yn]").attr("disabled", true);
			$("input:checkbox[name=Wkpn4Yn]").attr("disabled", true);
			$("input:checkbox[name=Wkpn5Yn]").attr("disabled", true);
			$("input:checkbox[name=Wkpn6Yn]").attr("disabled", true);
			$("input:checkbox[name=Wkpn7Yn]").attr("disabled", true);
		}
	}

	/** 산재 경험 validation */
	function toggleInddist() {
		var checkVal = $("input[name=InddistYn]:checked").val();
		if("Y" == checkVal) {
			$("input:checkbox[name=Inddist1Yn]").attr("disabled", false);
			$("input:checkbox[name=Inddist2Yn]").attr("disabled", false);
			$("input:checkbox[name=Inddist3Yn]").attr("disabled", false);
			$("input:checkbox[name=Inddist4Yn]").attr("disabled", false);
			$("input:checkbox[name=Inddist5Yn]").attr("disabled", false);
			$("input:checkbox[name=Inddist6Yn]").attr("disabled", false);
		} else {
			$("input:checkbox[name=Inddist1Yn]").attr("checked", false);
			$("input:checkbox[name=Inddist2Yn]").attr("checked", false);
			$("input:checkbox[name=Inddist3Yn]").attr("checked", false);
			$("input:checkbox[name=Inddist4Yn]").attr("checked", false);
			$("input:checkbox[name=Inddist5Yn]").attr("checked", false);
			$("input:checkbox[name=Inddist6Yn]").attr("checked", false);
			$("input:checkbox[name=Inddist1Yn]").attr("disabled", true);
			$("input:checkbox[name=Inddist2Yn]").attr("disabled", true);
			$("input:checkbox[name=Inddist3Yn]").attr("disabled", true);
			$("input:checkbox[name=Inddist4Yn]").attr("disabled", true);
			$("input:checkbox[name=Inddist5Yn]").attr("disabled", true);
			$("input:checkbox[name=Inddist6Yn]").attr("disabled", true);
		}
	}

	/** 저장 전 validation */
	function validateQslt() {
		var returnVal = true;
		if($("select[name=UseGrpCd]").val() == "") {
			alert("허브를 선택해주세요");
			$("select[name=UseGrpCd]").focus();
			return false;
		}
		if($("input[name=UsrNm]").val() == "") {
			alert("성명을 입력해주세요");
			$("input[name=UsrNm]").focus();
			return false;
		}
		if($("input[name=UsrAge]").val() == "") {
			alert("연령을 입력해주세요");
			$("input[name=UsrAge]").focus();
			return false;
		}
		if($("input[name=JobCareerYear]").val() == "") {
			alert("물류업무경력(년)을 입력해주세요");
			$("input[name=JobCareerYear]").focus();
			return false;
		}
		if($("input[name=JobCareerMonth]").val() == "") {
			alert("물류업무경력(개월)을 입력해주세요");
			$("input[name=JobCareerMonth]").focus();
			return false;
		}
		if($("input[name=UsrHet]").val() == "") {
			alert("키를 입력해주세요");
			$("input[name=UsrHet]").focus();
			return false;
		}
		if($("input[name=UsrWet]").val() == "") {
			alert("몸무게를 입력해주세요");
			$("input[name=UsrWet]").focus();
			return false;
		}
		if(!$("input:checkbox[name=Fahs1Yn]").is(":checked") && !$("input:checkbox[name=Fahs2Yn]").is(":checked")
				&& !$("input:checkbox[name=Fahs3Yn]").is(":checked") && !$("input:checkbox[name=Fahs4Yn]").is(":checked")
				&& !$("input:checkbox[name=Fahs5Yn]").is(":checked") && !$("input:checkbox[name=Fahs6Yn]").is(":checked")
				&& !$("input:checkbox[name=FahsYn]").is(":checked") ) {
			alert("가족력 관련 문의에 체크해주세요");
			return false;
		}
		var fahsChk = $("input:checkbox[name=Fahs6Yn]:checked").is(":checked");
		if(fahsChk) {
			if($("#FahsEtc").val() == "") {
				alert("가족력 기타 항목을 입력해주세요");
				$("#FahsEtc").focus();
				return false;
			}
		}
		var fahsYnChk = $("input:checkbox[name=FahsYn]:checked").is(":checked");
		if(fahsYnChk) {
			$("#FahsEtc").val("");
		}
		var alcChk = $("input[name=AlcYn]:checked").val();
		if("Y" == alcChk) {
			if($("#WekAlcCt").val() == "") {
				alert("음주 횟수를 입력해주세요.");
				$("#WekAlcCt").focus();
				return false;
			}
			if($("#AdrkCt").val() == "") {
				alert("음주 잔수를 입력해주세요.");
				$("#AdrkCt").focus();
				return false;
			}
		}
		var smkChk = $("input[name=SmkYn]:checked").val();
		if("Y" == smkChk) {
			if($("#DysmkCt").val() == "") {
				alert("흡연 갑수를 입력해주세요.");
				$("#DysmkCt").focus();
				return false;
			}
		}
		if(!$("input:checkbox[name=Havdis1Yn]").is(":checked") && !$("input:checkbox[name=Havdis2Yn]").is(":checked")
				&& !$("input:checkbox[name=Havdis3Yn]").is(":checked") && !$("input:checkbox[name=Havdis4Yn]").is(":checked")
				&& !$("input:checkbox[name=Havdis5Yn]").is(":checked") && !$("input:checkbox[name=Havdis6Yn]").is(":checked")
				&& !$("input:checkbox[name=Havdis7Yn]").is(":checked") && !$("input:checkbox[name=HavdisYn]").is(":checked") ) {
			alert("일반증상 질병관련 문의에 체크해주세요");
			return false;
		}
		var havdisChk = $("input:checkbox[name=Havdis7Yn]:checked").is(":checked");
		if(havdisChk) {
			if($("#HavdisEtc").val() == "") {
				alert("질병 관련 기타 항목을 입력해주세요");
				$("#HavdisEtc").focus();
				return false;
			}
		}
		var havdisYnChk = $("input:checkbox[name=HavdisYn]:checked").is(":checked");
		if(havdisYnChk) {
			$("#HavdisEtc").val("");
		}
		var moaciChk = $("input[name=MoaciYn]:checked").val();
		if("Y" == moaciChk) {
			if(!$("input:checkbox[name=Moaci1Yn]").is(":checked") && !$("input:checkbox[name=Moaci2Yn]").is(":checked")
					&& !$("input:checkbox[name=Moaci3Yn]").is(":checked") && !$("input:checkbox[name=Moaci4Yn]").is(":checked")
					&& !$("input:checkbox[name=Moaci5Yn]").is(":checked") && !$("input:checkbox[name=Moaci6Yn]").is(":checked")
					&& !$("input:checkbox[name=Moaci7Yn]").is(":checked") ) {
				alert("운동 혹은 사고 상해부위를 체크해주세요");
				return false;
			}
		}
		var wkpnChk = $("input[name=WkpnYn]:checked").val();
		if("Y" == wkpnChk) {
			if(!$("input:checkbox[name=Wkpn1Yn]").is(":checked") && !$("input:checkbox[name=Wkpn2Yn]").is(":checked")
					&& !$("input:checkbox[name=Wkpn3Yn]").is(":checked") && !$("input:checkbox[name=Wkpn4Yn]").is(":checked")
					&& !$("input:checkbox[name=Wkpn5Yn]").is(":checked") && !$("input:checkbox[name=Wkpn6Yn]").is(":checked")
					&& !$("input:checkbox[name=Wkpn7Yn]").is(":checked") ) {
				alert("작업 관련 통증 부위를 체크해주세요");
				return false;
			}
		}
		if(!$("input:checkbox[name=Repsym1Yn]").is(":checked") && !$("input:checkbox[name=Repsym2Yn]").is(":checked")
				&& !$("input:checkbox[name=Repsym3Yn]").is(":checked") && !$("input:checkbox[name=Repsym4Yn]").is(":checked")
				&& !$("input:checkbox[name=Repsym5Yn]").is(":checked") ) {
			alert("호흡기계 증상 관련 문의에 체크해주세요");
			return false;
		}
		if(!$("input:checkbox[name=Cirsym1Yn]").is(":checked") && !$("input:checkbox[name=Cirsym2Yn]").is(":checked")
				&& !$("input:checkbox[name=Cirsym3Yn]").is(":checked") && !$("input:checkbox[name=Cirsym4Yn]").is(":checked")
				&& !$("input:checkbox[name=Cirsym5Yn]").is(":checked") && !$("input:checkbox[name=Cirsym6Yn]").is(":checked") 
				&& !$("input:checkbox[name=Cirsym7Yn]").is(":checked") ) {
			alert("순환기계 증상 관련 문의에 체크해주세요");
			return false;
		}
		var inddistChk = $("input[name=InddistYn]:checked").val();
		if("Y" == inddistChk) {
			if(!$("input:checkbox[name=Inddist1Yn]").is(":checked") && !$("input:checkbox[name=Inddist2Yn]").is(":checked")
					&& !$("input:checkbox[name=Inddist3Yn]").is(":checked") && !$("input:checkbox[name=Inddist4Yn]").is(":checked")
					&& !$("input:checkbox[name=Inddist5Yn]").is(":checked") && !$("input:checkbox[name=Inddist6Yn]").is(":checked") ) {
				alert("산재 경험 상해부위를 체크해주세요");
				return false;
			}
		}
		return returnVal;
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

		var usrId = "<c:out value='${detailVO.usrId}'/>";

		if("" != usrId) {
			
			var fahsChk = $("input:checkbox[name=Fahs6Yn]:checked").is(":checked");
			if(fahsChk) {
				$("#FahsEtc").attr("readonly", false);
			} else {
				$("#FahsEtc").attr("readonly", true);
			}
			var alcChk = $("input[name=AlcYn]:checked").val();
			if("Y" == alcChk) {
				$("#WekAlcCt").attr("readonly", false);
				$("#AdrkCt").attr("readonly", false);
			} else {
				$("#WekAlcCt").attr("readonly", true);
				$("#AdrkCt").attr("readonly", true);				
			}
			var smkChk = $("input[name=SmkYn]:checked").val();
			if("Y" == smkChk) {
				$("#DysmkCt").attr("readonly", false);
			} else {
				$("#DysmkCt").attr("readonly", true);
			}
			var havdisChk = $("input:checkbox[name=Havdis7Yn]:checked").is(":checked");
			if(havdisChk) {
				$("#HavdisEtc").attr("readonly", false);
			} else {
				$("#HavdisEtc").attr("readonly", true);
			}
			var moaciChk = $("input[name=MoaciYn]:checked").val();
			if("Y" == moaciChk) {
				// 운동 혹은 사고 초기 diabled 해제
				$("input:checkbox[name=Moaci1Yn]").attr("disabled", false);
				$("input:checkbox[name=Moaci2Yn]").attr("disabled", false);
				$("input:checkbox[name=Moaci3Yn]").attr("disabled", false);
				$("input:checkbox[name=Moaci4Yn]").attr("disabled", false);
				$("input:checkbox[name=Moaci5Yn]").attr("disabled", false);
				$("input:checkbox[name=Moaci6Yn]").attr("disabled", false);
				$("input:checkbox[name=Moaci7Yn]").attr("disabled", false);
			} else {
				// 운동 혹은 사고 초기 diabled
				$("input:checkbox[name=Moaci1Yn]").attr("disabled", true);
				$("input:checkbox[name=Moaci2Yn]").attr("disabled", true);
				$("input:checkbox[name=Moaci3Yn]").attr("disabled", true);
				$("input:checkbox[name=Moaci4Yn]").attr("disabled", true);
				$("input:checkbox[name=Moaci5Yn]").attr("disabled", true);
				$("input:checkbox[name=Moaci6Yn]").attr("disabled", true);
				$("input:checkbox[name=Moaci7Yn]").attr("disabled", true);
			}
			var wkpnChk = $("input[name=WkpnYn]:checked").val();
			if("Y" == wkpnChk) {
				// 작업 통증 초기 disabled 해제
				$("input:checkbox[name=Wkpn1Yn]").attr("disabled", false);
				$("input:checkbox[name=Wkpn2Yn]").attr("disabled", false);
				$("input:checkbox[name=Wkpn3Yn]").attr("disabled", false);
				$("input:checkbox[name=Wkpn4Yn]").attr("disabled", false);
				$("input:checkbox[name=Wkpn5Yn]").attr("disabled", false);
				$("input:checkbox[name=Wkpn6Yn]").attr("disabled", false);
				$("input:checkbox[name=Wkpn7Yn]").attr("disabled", false);
			} else {
				$("input:checkbox[name=Wkpn1Yn]").attr("disabled", true);
				$("input:checkbox[name=Wkpn2Yn]").attr("disabled", true);
				$("input:checkbox[name=Wkpn3Yn]").attr("disabled", true);
				$("input:checkbox[name=Wkpn4Yn]").attr("disabled", true);
				$("input:checkbox[name=Wkpn5Yn]").attr("disabled", true);
				$("input:checkbox[name=Wkpn6Yn]").attr("disabled", true);
				$("input:checkbox[name=Wkpn7Yn]").attr("disabled", true);
			}
			var inddistChk = $("input[name=InddistYn]:checked").val();
			if("Y" == inddistChk) {
				// 산재 경험 초기 disabled 해제
				$("input:checkbox[name=Inddist1Yn]").attr("disabled", false);
				$("input:checkbox[name=Inddist2Yn]").attr("disabled", false);
				$("input:checkbox[name=Inddist3Yn]").attr("disabled", false);
				$("input:checkbox[name=Inddist4Yn]").attr("disabled", false);
				$("input:checkbox[name=Inddist5Yn]").attr("disabled", false);
				$("input:checkbox[name=Inddist6Yn]").attr("disabled", false);
			} else {
				// 산재 경험 초기 disabled
				$("input:checkbox[name=Inddist1Yn]").attr("disabled", true);
				$("input:checkbox[name=Inddist2Yn]").attr("disabled", true);
				$("input:checkbox[name=Inddist3Yn]").attr("disabled", true);
				$("input:checkbox[name=Inddist4Yn]").attr("disabled", true);
				$("input:checkbox[name=Inddist5Yn]").attr("disabled", true);
				$("input:checkbox[name=Inddist6Yn]").attr("disabled", true);
			}

		}

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
					<form id="detailForm" name="detailForm" action="<c:url value='/whms/hi/qsltList.do'/>" method="post">
						<input name="vStartP" type="hidden" value="<c:out value='${param.vStartP}'/>" />
						<input name="UsrId" type="hidden" value="<c:out value='${detailVO.usrId}'/>" />
						<input name="EmpTmpId" type="hidden" value="<c:out value='${detailVO.empTmpId}'/>" />
						<input name="InfrecYn" type="hidden" value="<c:out value='${detailVO.infrecYn}'/>" />
						<input name="UseYn" type="hidden" value="<c:out value='${detailVO.useYn}'/>" />
						<input name="targetDt" type="hidden" value="<c:out value='${detailVO.makeDt}'/>" />
						<input name="SysRgsDt" type="hidden" value="<c:out value='${detailVO.sysRgsDt}'/>" />
						<div class="reg_searchbox">
							<!-- search_tb -->
							<div class="search_tb mb0">
							 <div class="stb_left">
							  <span class="select w100p">
							    <select name="searchCondition" id="searchCondition" >
							      <option value="USR_NM" <c:if test="${empty searchVO.searchCondition || searchVO.searchCondition == 'USR_NM' }">selected</c:if> >이름</option>
							      <option value="USR_ID" <c:if test="${searchVO.searchCondition == 'USR_ID' }">selected</c:if> >ID</option>
							    </select>
							  </span>
							  <span class="input w250p"><input type="text" placeholder="" id="searchKeyword" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword }'/>" style="width:100%"/></span>
							  <button type="button" class="btn-type btn_ico gray_line" onClick="searchData()"><span class="i_search_bg">조회</span></button>
							 </div>
							 <div class="stb_right">
							  <!-- <button type="button" class="btn-type btn_ico gray_line" onClick=""><span class="i_del_bg">등록</span></button>  -->
							  <!-- <button type="button" class="btn-type btn_ico gray_line" onClick="deleteData()"><span class="i_del_bg">삭제</span></button> -->
							  <!-- <button type="button" class="btn-type btn_ico gray_line" onClick="updateData()"><span class="i_mwrite_bg">수정</span></button> -->
							 </div>
							 
							</div>
							<!-- // search_tb -->
							
							</div>
							
							<div class="reg_tit">
							  <h3>인적사항</h3>
							</div>
							
							<div class="reg_form">
							<ul>
								<li class="l_txt">허브명</li>
								<li class="r_area">
									<span class="select" style="margin:0; width:50%;">
										<select name="UseGrpCd">
											<c:choose>
												<c:when test="${empty detailVO}">
													<option value="">선택해주세요</option>
												</c:when>
												<c:otherwise>
													<c:forEach var="item" items="${useGrpCdList}" varStatus="status">
														<c:if test="${item.useGrpCd == detailVO.useGrpCd }">
															<option value="<c:out value='${item.useGrpCd}'/>" <c:if test="${item.useGrpCd == detailVO.useGrpCd }">selected</c:if> ><c:out value='${item.useGrpNm}'/></option>
														</c:if>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</select>
									</span>
								</li>
							</ul>
							  <ul>
							    <li class="l_txt">이름</li>
							    <li class="r_area">
							      <input type="text" name="UsrNm" id="UsrNm" maxlength="100" value="<c:out value='${detailVO.usrNm}'/>" placeholder="" class="w50" />
							    </li>
							  </ul>
							  <ul>
							    <li class="l_txt">성별</li>
							    <li class="r_area">
							      <input type="radio" id="SexSecd01" name="SexSecd" value="01" <c:if test="${detailVO.sexSecd == '01'}">checked</c:if> >
							      <label for="SexSecd01">남자</label>
							      <input type="radio" id="SexSecd02" name="SexSecd" value="02" <c:if test="${detailVO.sexSecd == '02'}">checked</c:if> >
							      <label for="SexSecd02">여자</label>
							    </li>
							  </ul>
							  <ul>
							    <li class="l_txt">연령</li>
							    <li class="r_area">
							      <input type="number" name="UsrAge" id="UsrAge" maxlength="3" oninput="maxLengthCheck(this)" value="<c:out value='${detailVO.usrAge}'/>" placeholder="" class="w100p" /><span>세</span>
							    </li>
							  </ul>
							  <ul>
							    <li class="l_txt">물류업무경력</li>
							    <li class="r_area">
							      <input type="number" name="JobCareerYear" id="JobCareerYear" maxlength="2" oninput="maxLengthCheck(this)" value="<c:out value='${detailVO.jobCareerYear}'/>" placeholder="" class="w100p" /><span>년</span><input type="number" name="jobCareerMonth" id="jobCareerMonth" maxlength="2" oninput="maxLengthCheck(this)" value="<c:out value='${detailVO.jobCareerMonth}'/>" placeholder="" class="w100p" /><span>개월</span>
							    </li>
							  </ul>
							  <ul>
							    <li class="l_txt">혈액형</li>
							    <li class="r_area">
							      <input type="radio" id="b01" name="BldtyCd" value="01" <c:if test="${detailVO.bldtyCd == '01'}">checked</c:if>>
							      <label for="b01">A</label>
							      <input type="radio" id="b02" name="BldtyCd" value="02" <c:if test="${detailVO.bldtyCd == '02'}">checked</c:if>>
							      <label for="b02">B</label>
							      <input type="radio" id="b03" name="BldtyCd" value="03" <c:if test="${detailVO.bldtyCd == '03'}">checked</c:if>>
							      <label for="b03">O</label>
							      <input type="radio" id="b04" name="BldtyCd" value="04" <c:if test="${detailVO.bldtyCd == '04'}">checked</c:if>>
							      <label for="b04">AB</label>
							    </li>
							  </ul>
							  <ul>
							    <li class="l_txt">키/몸무게</li>
							    <li class="r_area">
							      <input type="text" name="UsrHet" id="UsrHet" value="<c:out value='${detailVO.usrHet}'/>" placeholder="" class="w100p" /><span>cm</span>
							      <input type="text" name="UsrWet" id="UsrWet" value="<c:out value='${detailVO.usrWet}'/>" placeholder="" class="w100p" /><span>kg</span>
							    </li>
							  </ul>
							</div>
							<!-- // reg_form --> 
							
							<div class="reg_tit mt40">
							  <h3>가족력 &amp; 생활습관</h3>
							</div>
							
							<div class="reg_form">          
							  <ul>
							    <li class="l_100">부모, 형제 등 가족 중에 다음과 같은 질환으로 사망 또는 앓고 있는 질환이 있습니까?</li>
							    <li class="r_100">
							    <input type="checkbox" id="Fahs1Yn" name="Fahs1Yn" value="Y" onClick="fn_check_fahs()" <c:if test="${detailVO.fahs1Yn == 'Y'}">checked</c:if>>
							    <label for="Fahs1Yn">고혈압</label>
							    <input type="checkbox" id="Fahs2Yn" name="Fahs2Yn" value="Y" onClick="fn_check_fahs()" <c:if test="${detailVO.fahs2Yn == 'Y'}">checked</c:if>>
							    <label for="Fahs2Yn">당뇨병</label>
							    <input type="checkbox" id="Fahs3Yn" name="Fahs3Yn" value="Y" onClick="fn_check_fahs()" <c:if test="${detailVO.fahs3Yn == 'Y'}">checked</c:if>>
							    <label for="Fahs3Yn">뇌졸증</label>
							    <input type="checkbox" id="Fahs4Yn" name="Fahs4Yn" value="Y" onClick="fn_check_fahs()" <c:if test="${detailVO.fahs4Yn == 'Y'}">checked</c:if>>
							    <label for="Fahs4Yn">심장병</label>
							    <input type="checkbox" id="Fahs5Yn" name="Fahs5Yn" value="Y" onClick="fn_check_fahs()" <c:if test="${detailVO.fahs5Yn == 'Y'}">checked</c:if>>
							    <label for="Fahs5Yn">심근경색증</label>
							    <input type="checkbox" id="Fahs6Yn" name="Fahs6Yn" value="Y"  onClick="fn_check_fahs()" <c:if test="${detailVO.fahs6Yn == 'Y'}">checked</c:if>>
							    <label for="Fahs6Yn">기타</label>
							    <input type="text" name="FahsEtc" id="FahsEtc" maxlength="100" value="<c:out value='${detailVO.fahsEtc}'/>" placeholder="" class="w200p mr20"/>
							    <input type="checkbox" id="FahsYn" name="FahsYn" value="Y" onClick="fn_check_fahs()" <c:if test="${detailVO.fahsYn == 'Y'}">checked</c:if>>
							    <label for="FahsYn">해당사항 없음</label>
							    </li>
							  </ul>
							  <ul>
							    <li class="l_txt">음주</li>
							    <li class="r_area">
							      <input type="radio" id="AlcYn01" name="AlcYn" value="N" onClick="toggleAlc()" <c:if test="${detailVO.alcYn == 'N'}">checked</c:if>>
							      <label for="AlcYn01">술을 마시지 않는다.</label>
							      <input type="radio" id="AlcYn02" name="AlcYn" value="Y" onClick="toggleAlc()" <c:if test="${detailVO.alcYn == 'Y'}">checked</c:if>>
							      <label for="AlcYn02">술을 마신다.</label>
							      <span>일주일</span><input type="text" name="WekAlcCt" id="WekAlcCt" value="<c:out value='${detailVO.wekAlcCt}'/>" placeholder="" class="w100p" /><span>회</span>
							      <span>1회</span><input type="text" name="AdrkCt" id="AdrkCt" value="<c:out value='${detailVO.adrkCt}'/>" placeholder="" class="w100p" /><span>잔</span>
							    </li>
							  </ul>
							  <ul>
							    <li class="l_txt">흡연</li>
							    <li class="r_area">
							      <input type="radio" id="SmkYn01" name="SmkYn" value="N" onClick="toggleSmk()" <c:if test="${detailVO.smkYn == 'N'}">checked</c:if>>
							      <label for="SmkYn01">담배를 피우지 않는다.</label>
							      <input type="radio" id="SmkYn02" name="SmkYn" value="Y" onClick="toggleSmk()" <c:if test="${detailVO.smkYn == 'Y'}">checked</c:if>>
							      <label for="SmkYn02">담배를 피운다.</label>
							      <span>하루</span><input type="text" name="DysmkCt" id="DysmkCt" value="<c:out value='${detailVO.dysmkCt}'/>" placeholder="" class="w100p" /><span>갑</span>
							    </li>
							  </ul>
							</div>
							<!-- // reg_form -->
							
							<div class="reg_tit mt40">
							  <h3>일반증상</h3>
							  <p>상기사항은 취업 제한과 관련 인사상 불이익은 없으며, 입사 후 개인 건강관리 및 응급 상황시 초기 대응력을 높여 근로자의 생명을 보호하기 위한 조사사항이므로 솔직하게 작성해 주시기 바랍니다. 단, 허위 또는 미기입 후 발생되는 재해에 대해서는 본인에게 책임이 있을 수 있음을 알려 드립니다.</p>
							</div>
							
							<div class="reg_form">          
							  <ul>
							    <li class="l_100">의사로부터 다음과 같은 질병에 대해 진단 받은 적이나 복용하는 약이 있습니까?</li>
							    <li class="r_100">
							    <input type="checkbox" id="Havdis1Yn" name="Havdis1Yn" value="Y" onClick="fn_check_havdis()" <c:if test="${detailVO.havdis1Yn == 'Y'}">checked</c:if>>
							    <label for="Havdis1Yn">고혈압(약 복용중)</label>
							    <input type="checkbox" id="Havdis8Yn" name="Havdis8Yn" value="Y" onClick="fn_check_havdis()" <c:if test="${detailVO.havdis8Yn == 'Y'}">checked</c:if>>
							    <label for="Havdis8Yn">고혈압(약 미복용)</label>
							    <input type="checkbox" id="Havdis2Yn" name="Havdis2Yn" value="Y" onClick="fn_check_havdis()" <c:if test="${detailVO.havdis2Yn == 'Y'}">checked</c:if>>
							    <label for="Havdis2Yn">당뇨병</label>
							    <input type="checkbox" id="Havdis3Yn" name="Havdis3Yn" value="Y" onClick="fn_check_havdis()" <c:if test="${detailVO.havdis3Yn == 'Y'}">checked</c:if>>
							    <label for="Havdis3Yn">고지혈증</label>
							    <input type="checkbox" id="Havdis4Yn" name="Havdis4Yn" value="Y" onClick="fn_check_havdis()" <c:if test="${detailVO.havdis4Yn == 'Y'}">checked</c:if>>
							    <label for="Havdis4Yn">천식</label>
							    <input type="checkbox" id="Havdis5Yn" name="Havdis5Yn" value="Y" onClick="fn_check_havdis()" <c:if test="${detailVO.havdis5Yn == 'Y'}">checked</c:if>>
							    <label for="Havdis5Yn">뇌전증(간질)</label>
							    <input type="checkbox" id="Havdis6Yn" name="Havdis6Yn" value="Y" onClick="fn_check_havdis()" <c:if test="${detailVO.havdis6Yn == 'Y'}">checked</c:if>>
							    <label for="Havdis6Yn">통풍</label>
							    <p>
							    <input type="checkbox" id="Havdis7Yn" name="Havdis7Yn" value="Y" onClick="fn_check_havdis()" <c:if test="${detailVO.havdis7Yn == 'Y'}">checked</c:if>>
							    <label for="Havdis7Yn">기타</label>
							    <input type="text" name="HavdisEtc" id="HavdisEtc" maxlength="100" value="<c:out value='${detailVO.havdisEtc}'/>" placeholder="" class="w200p mr20" />
							    <input type="checkbox" id="HavdisYn" name="HavdisYn" value="Y" onClick="fn_check_havdis()" <c:if test="${detailVO.havdisYn == 'Y'}">checked</c:if>>
							    <label for="HavdisYn">해당사항 없음</label>
							    </p>
							    <div class="s_txt">기타 질환의 예 (뇌경색, 뇌졸증, 심근경색, 스텐트시술, 간염보균자, 디스크, 암, 결핵 등)</div>
							    </li>
							  </ul>
							  
							  <ul>
							    <li class="l_100">과거에 운동 혹은 사고로(교통사고, 넘어짐, 추락 등)인해 다친 적이 있습니까?</li>
							    <li class="r_100">
							    <input type="radio" id="MoaciYn01" name="MoaciYn" value="Y" onClick="toggleMoaci()" <c:if test="${detailVO.moaciYn == 'Y'}">checked</c:if>>
							    <label for="MoaciYn01">예</label>
							    <input type="radio" id="MoaciYn02" name="MoaciYn" value="N" onClick="toggleMoaci()" <c:if test="${detailVO.moaciYn == 'N'}">checked</c:if>>
							    <label for="MoaciYn02">아니오</label>
							    <div class="p_txt">예'인 경우 상해부위는?</div>
							    <input type="checkbox" id="Moaci1Yn" name="Moaci1Yn" value="Y" <c:if test="${detailVO.moaci1Yn == 'Y'}">checked</c:if>>
							    <label for="Moaci1Yn">목</label>
							    <input type="checkbox" id="Moaci2Yn" name="Moaci2Yn" value="Y" <c:if test="${detailVO.moaci2Yn == 'Y'}">checked</c:if>>
							    <label for="Moaci2Yn">어깨</label>
							    <input type="checkbox" id="Moaci3Yn" name="Moaci3Yn" value="Y" <c:if test="${detailVO.moaci3Yn == 'Y'}">checked</c:if>>
							    <label for="Moaci3Yn">팔/팔꿈치</label>
							    <input type="checkbox" id="Moaci4Yn" name="Moaci4Yn" value="Y" <c:if test="${detailVO.moaci4Yn == 'Y'}">checked</c:if>>
							    <label for="Moaci4Yn">허리</label>
							    <input type="checkbox" id="Moaci5Yn" name="Moaci5Yn" value="Y" <c:if test="${detailVO.moaci5Yn == 'Y'}">checked</c:if>>
							    <label for="Moaci5Yn">손/손목/손가락</label>
							    <input type="checkbox" id="Moaci6Yn" name="Moaci6Yn" value="Y" <c:if test="${detailVO.moaci6Yn == 'Y'}">checked</c:if>>
							    <label for="Moaci6Yn">다리/발목/발</label>
							    <input type="checkbox" id="Moaci7Yn" name="Moaci7Yn" value="Y" <c:if test="${detailVO.moaci7Yn == 'Y'}">checked</c:if>>
							    <label for="Moaci7Yn">기타</label>
							    </li>
							  </ul>
							  
							  <ul>
							    <li class="l_100">작업과 관련하여 통증이나 불편함을 느낀 적이 있습니까?</li>
							    <li class="r_100">
							    <input type="radio" id="WkpnYn01" name="WkpnYn" value="Y" onClick="toggleWkpn()"<c:if test="${detailVO.wkpnYn == 'Y'}">checked</c:if>>
							    <label for="WkpnYn01">예</label>
							    <input type="radio" id="WkpnYn02" name="WkpnYn" value="N" onClick="toggleWkpn()" <c:if test="${detailVO.wkpnYn == 'N'}">checked</c:if>>
							    <label for="WkpnYn02">아니오</label>
							    <div class="p_txt">예'인 경우 상해부위는?</div>
							    <input type="checkbox" id="Wkpn1Yn" name="Wkpn1Yn" value="Y" <c:if test="${detailVO.wkpn1Yn == 'Y'}">checked</c:if>>
							    <label for="Wkpn1Yn">목</label>
							    <input type="checkbox" id="Wkpn2Yn" name="Wkpn2Yn" value="Y" <c:if test="${detailVO.wkpn2Yn == 'Y'}">checked</c:if>>
							    <label for="Wkpn2Yn">어깨</label>
							    <input type="checkbox" id="Wkpn3Yn" name="Wkpn3Yn" value="Y" <c:if test="${detailVO.wkpn3Yn == 'Y'}">checked</c:if>>
							    <label for="Wkpn3Yn">팔/팔꿈치</label>
							    <input type="checkbox" id="Wkpn4Yn" name="Wkpn4Yn" value="Y" <c:if test="${detailVO.wkpn4Yn == 'Y'}">checked</c:if>>
							    <label for="Wkpn4Yn">허리</label>
							    <input type="checkbox" id="Wkpn5Yn" name="Wkpn5Yn" value="Y" <c:if test="${detailVO.wkpn5Yn == 'Y'}">checked</c:if>>
							    <label for="Wkpn5Yn">손/손목/손가락</label>
							    <input type="checkbox" id="Wkpn6Yn" name="Wkpn6Yn" value="Y" <c:if test="${detailVO.wkpn6Yn == 'Y'}">checked</c:if>>
							    <label for="Wkpn6Yn">다리/발목/발</label>
							    <input type="checkbox" id="Wkpn7Yn" name="Wkpn7Yn" value="Y" <c:if test="${detailVO.wkpn7Yn == 'Y'}">checked</c:if>>
							    <label for="Wkpn7Yn">기타</label>
							    </li>
							  </ul>
							  
							  <ul>
							    <li class="l_100">아래와 같은 증상을 느낀 적이 있습니까?</li>
							    <li class="r_100">
							    <div class="p_txt_none">호흡기계 증상</div>
							    <input type="checkbox" id="Repsym1Yn" name="Repsym1Yn" value="Y" onClick="fn_check_repsym()" <c:if test="${detailVO.repsym1Yn == 'Y'}">checked</c:if>>
							    <label for="Repsym1Yn">호흡곤란이 있다.</label>
							    <input type="checkbox" id="Repsym2Yn" name="Repsym2Yn" value="Y" onClick="fn_check_repsym()" <c:if test="${detailVO.repsym2Yn == 'Y'}">checked</c:if>>
							    <label for="Repsym2Yn">열, 인후통, 콧물, 기침, 두통이 있다.</label>
							    <input type="checkbox" id="Repsym3Yn" name="Repsym3Yn" value="Y" onClick="fn_check_repsym()"<c:if test="${detailVO.repsym3Yn == 'Y'}">checked</c:if>>
							    <label for="Repsym3Yn">기침과 가래가 많다.</label>
							    <input type="checkbox" id="Repsym4Yn" name="Repsym4Yn" value="Y" onClick="fn_check_repsym()" <c:if test="${detailVO.repsym4Yn == 'Y'}">checked</c:if>>
							    <label for="Repsym4Yn">천식이 있다.</label>
							    <input type="checkbox" id="Repsym5Yn" name="Repsym5Yn" value="Y" onClick="fn_check_repsym()" <c:if test="${detailVO.repsym5Yn == 'Y'}">checked</c:if>>
							    <label for="Repsym5Yn">없다.</label>
							    <div class="p_txt">순환기계 증상</div>
							    <input type="checkbox" id="Cirsym1Yn" name="Cirsym1Yn" value="Y" onClick="fn_check_cirsym()" <c:if test="${detailVO.cirsym1Yn == 'Y'}">checked</c:if>>
							    <label for="Cirsym1Yn">머리가 자주 아프다.</label>
							    <input type="checkbox" id="Cirsym2Yn" name="Cirsym2Yn" value="Y" onClick="fn_check_cirsym()" <c:if test="${detailVO.cirsym2Yn == 'Y'}">checked</c:if>>
							    <label for="Cirsym2Yn">작업, 수면중 가슴이 답답할 때가 있다.</label>
							    <input type="checkbox" id="Cirsym3Yn" name="Cirsym3Yn" value="Y" onClick="fn_check_cirsym()" <c:if test="${detailVO.cirsym3Yn == 'Y'}">checked</c:if>>
							    <label for="Cirsym3Yn">가슴에 통증이 있다.</label>
							    <input type="checkbox" id="Cirsym4Yn" name="Cirsym4Yn" value="Y" onClick="fn_check_cirsym()" <c:if test="${detailVO.cirsym4Yn == 'Y'}">checked</c:if>>
							    <label for="Cirsym4Yn">얼굴이 자주 붉어진다</label>
							    <input type="checkbox" id="Cirsym5Yn" name="Cirsym5Yn" value="Y" onClick="fn_check_cirsym()" <c:if test="${detailVO.cirsym5Yn == 'Y'}">checked</c:if>>
							    <label for="Cirsym5Yn">손, 발이 자주 저린다.</label>
							    <input type="checkbox" id="Cirsym6Yn" name="Cirsym6Yn" value="Y" onClick="fn_check_cirsym()" <c:if test="${detailVO.cirsym6Yn == 'Y'}">checked</c:if>>
							    <label for="Cirsym6Yn">심장이 두근거리고 맥박이 불규칙하다.</label>
							    <input type="checkbox" id="Cirsym7Yn" name="Cirsym7Yn" value="Y" onClick="fn_check_cirsym()" <c:if test="${detailVO.cirsym7Yn == 'Y'}">checked</c:if>>
							    <label for="Cirsym7Yn">없다.</label>
							    </li>
							  </ul>
							  
							  <ul>
							    <li class="l_100">산재 경험이 있습니까?</li>
							    <li class="r_100">
							    <input type="radio" id="InddistYn01" name="InddistYn" value="Y" onClick="toggleInddist()" <c:if test="${detailVO.inddistYn == 'Y'}">checked</c:if>>
							    <label for="InddistYn01">예</label>
							    <input type="radio" id="InddistYn02" name="InddistYn" value="N" onClick="toggleInddist()" <c:if test="${detailVO.inddistYn == 'N'}">checked</c:if>>
							    <label for="InddistYn02">아니오</label>
							    <div class="p_txt">예'인 경우 상해부위는?</div>
							    <input type="checkbox" id="Inddist1Yn" name="Inddist1Yn" value="Y" <c:if test="${detailVO.inddist1Yn == 'Y'}">checked</c:if>>
							    <label for="Inddist1Yn">추락</label>
							    <input type="checkbox" id="Inddist2Yn" name="Inddist2Yn" value="Y" <c:if test="${detailVO.inddist2Yn == 'Y'}">checked</c:if>>
							    <label for="Inddist2Yn">전도</label>
							    <input type="checkbox" id="Inddist3Yn" name="Inddist3Yn" value="Y" <c:if test="${detailVO.inddist3Yn == 'Y'}">checked</c:if>>
							    <label for="Inddist3Yn">협착</label>
							    <input type="checkbox" id="Inddist4Yn" name="Inddist4Yn" value="Y" <c:if test="${detailVO.inddist4Yn == 'Y'}">checked</c:if>>
							    <label for="Inddist4Yn">허리</label>
							    <input type="checkbox" id="Inddist5Yn" name="Inddist5Yn" value="Y" <c:if test="${detailVO.inddist5Yn == 'Y'}">checked</c:if>>
							    <label for="Inddist5Yn">찔림</label>
							    <input type="checkbox" id="Inddist6Yn" name="Inddist6Yn" value="Y" <c:if test="${detailVO.inddist6Yn == 'Y'}">checked</c:if>>
							    <label for="Inddist6Yn">기타</label>
							    </li>
							  </ul>
							  
							</div>
							<!-- // reg_form -->
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