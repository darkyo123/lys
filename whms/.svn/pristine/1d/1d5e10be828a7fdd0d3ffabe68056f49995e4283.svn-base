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

	/** 보유질병 체크박스 validation */
	function fn_hide_check() {
		var checkVal = $("input[name=havdisYn]:checked").val();
		if("N" == checkVal) {
			$("#havdisUl").show();
		} else {
			$("#havdisUl").hide();
			$("#ad01").attr("checked", false);
			$("#ad02").attr("checked", false);
			$("#ad03").attr("checked", false);
			$("#ad04").attr("checked", false);
			$("#ad05").attr("checked", false);
			$("#ad06").attr("checked", false);
			$("#ad07").attr("checked", false);
			$("#ad08").attr("checked", false);
			$("#havdisEtc").val("");
		}
	}

	/** 가족력 체크박스 validation */
	function fn_check_fahs() {
		var fahs1Yn = $("input:checkbox[id='e01']").is(":checked");
		var fahs2Yn = $("input:checkbox[id='e02']").is(":checked");
		var fahs3Yn = $("input:checkbox[id='e03']").is(":checked");
		var fahs4Yn = $("input:checkbox[id='e04']").is(":checked");
		var fahs5Yn = $("input:checkbox[id='e05']").is(":checked");
		var fahs6Yn = $("input:checkbox[id='e06']").is(":checked");
		var fahsYn = $("input:checkbox[id='e07']").is(":checked");
		if(fahsYn) {
			$("input:checkbox[id='e01']").attr("checked", false);
			$("input:checkbox[id='e02']").attr("checked", false);
			$("input:checkbox[id='e03']").attr("checked", false);
			$("input:checkbox[id='e04']").attr("checked", false);
			$("input:checkbox[id='e05']").attr("checked", false);
			$("input:checkbox[id='e06']").attr("checked", false);
			$("#fahsEtc").attr("readonly", true);
			$("#fahsEtc").val("");
		} else {
			$("#fahsEtc").attr("readonly", false);
		}
	}

	/** 건강검진 실시여부 체크박스 validation */
	function fn_check_mecku() {
		var mecku1Yn = $("input:checkbox[id='hs01']").is(":checked");
		var mecku2Yn = $("input:checkbox[id='hs02']").is(":checked");
		var mecku3Yn = $("input:checkbox[id='hs03']").is(":checked");
		var mecku4Yn = $("input:checkbox[id='hs04']").is(":checked");
		var mecku5Yn = $("input:checkbox[id='hs05']").is(":checked");
		var mecku6Yn = $("input:checkbox[id='hs06']").is(":checked");
		if(mecku5Yn) {
			$("input:checkbox[id='hs01']").attr("checked", false);
			$("input:checkbox[id='hs02']").attr("checked", false);
			$("input:checkbox[id='hs03']").attr("checked", false);
			$("input:checkbox[id='hs04']").attr("checked", false);
			$("input:checkbox[id='hs06']").attr("checked", false);
		}
	}

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

	/** 팝업에서 ID 선택 시 function */
	function fn_detail_submit(id) {
		$('#searchCondition').val("USR_ID").prop("selected", true);
		$("#searchKeyword").val(id);
		$("#detailForm").submit();
	}

	/** 저장 전 필수항목 validation  */
	function validateBasicMedInfo() {
		var returnVal = true;
		var usrId = $("#usrId").val();
		if("" == usrId) {
			alert("사용자가 정보가 없습니다.");
			return false;
		} else {
			var sexSecd = $("input[name=sexSecd]:checked").val();
			if(sexSecd == undefined) {
				alert("성별을 선택해주세요");
				return false;
			}
			var usrNm = $("input[name=usrNm]").val();
			if("" == usrNm) {
				alert("이름을 입력해주세요");
				$("input[name=usrNm]").focus();
				return false;
			}
			var usrAge = $("input[name=usrAge]").val();
			if("" == usrAge) {
				alert("나이를 입력해주세요");
				$("input[name=usrAge]").focus();
				return false;
			}
			var smkYn = $("input[name=smkYn]:checked").val();
			if(smkYn == undefined) {
				alert("흡연여부를 선택해주세요");
				return false;
			}
			var connTelno = $("input[name=connTelno]").val();
			if("" == connTelno) {
				alert("연락처를 입력해주세요");
				$("input[name=connTelno]").focus();
				return false;
			}
			var acrRutnYn = $("input[name=acrRutnYn]:checked").val();
			if(acrRutnYn == undefined) {
				alert("신체활동을 선택해주세요");
				return false;
			}
			var birDt = $("input[name=birDt]").val();
			if("" == birDt) {
				alert("생년월일을 선택해주세요");
				return false;
			}
			var fahs1Yn = $("input:checkbox[id='e01']").is(":checked");
			var fahs2Yn = $("input:checkbox[id='e02']").is(":checked");
			var fahs3Yn = $("input:checkbox[id='e03']").is(":checked");
			var fahs4Yn = $("input:checkbox[id='e04']").is(":checked");
			var fahs5Yn = $("input:checkbox[id='e05']").is(":checked");
			var fahs6Yn = $("input:checkbox[id='e06']").is(":checked");
			var fahsYn = $("input:checkbox[id='e07']").is(":checked");
			if(!fahs1Yn && !fahs2Yn &&!fahs3Yn &&!fahs4Yn &&!fahs5Yn &&!fahs6Yn &&!fahsYn) {
				alert("가족력을 체크해주세요");
				return false;
			} else {
				if(fahsYn) {
					if(fahs1Yn || fahs2Yn || fahs3Yn || fahs4Yn || fahs5Yn || fahs6Yn) {
						alert("해당 없음의 경우 상위 항목 체크는 불가합니다");
						return false;
					}
				} else {
					if(fahs6Yn) {
						var fahsEtc = $("input[name=fahsEtc]").val();
						if("" == fahsEtc) {
							alert("기타 상세항목을 작성해주세요");
							$("input[name=fahsEtc]").focus();
							return false;
						}
					}
				}
			}
			var alcYn = $("input[name=alcYn]:checked").val();
			if(alcYn == undefined) {
				alert("음주여부를 선택해주세요");
				return false;
			}
			var mecku1Yn = $("input:checkbox[id='hs01']").is(":checked");
			var mecku2Yn = $("input:checkbox[id='hs02']").is(":checked");
			var mecku3Yn = $("input:checkbox[id='hs03']").is(":checked");
			var mecku4Yn = $("input:checkbox[id='hs04']").is(":checked");
			var mecku5Yn = $("input:checkbox[id='hs05']").is(":checked");
			var mecku6Yn = $("input:checkbox[id='hs06']").is(":checked");
			if(!mecku1Yn && !mecku2Yn &&!mecku3Yn &&!mecku4Yn &&!mecku5Yn &&!mecku6Yn) {
				alert("건강검진 실시여부를 체크해주세요");
				return false;
			}
			var hypctCt = $("input[name=hypctCt]").val();
			if("" == hypctCt) {
				alert("혈압(수축) 정보를 입력해주세요");
				$("input[name=hypctCt]").focus();
				return false;
			}
			var hyprxCt = $("input[name=hyprxCt]").val();
			if("" == hyprxCt) {
				alert("혈압(이완) 정보를 입력해주세요");
				$("input[name=hyprxCt]").focus();
				return false;
			}
			var plsCt = $("input[name=plsCt]").val();
			if("" == plsCt) {
				alert("맥박 정보를 입력해주세요");
				$("input[name=plsCt]").focus();
				return false;
			}
			var lstChkDt = $("input[name=lstChkDt]").val();
			if("" == lstChkDt) {
				alert("측정일자를 선택해주세요");
				$("input[name=lstChkDt]").focus();
				return false;
			}
			var havdisYn = $("input[name=havdisYn]:checked").val();
			if(havdisYn == undefined) {
				alert("보유질병 여부를 선택해주세요");
				return false;
			} else {
				if(havdisYn == "N") {
					var havdis1Yn = $("input:checkbox[id='ad01']").is(":checked");
					var havdis2Yn = $("input:checkbox[id='ad02']").is(":checked");
					var havdis3Yn = $("input:checkbox[id='ad03']").is(":checked");
					var havdis4Yn = $("input:checkbox[id='ad04']").is(":checked");
					var havdis5Yn = $("input:checkbox[id='ad05']").is(":checked");
					var havdis6Yn = $("input:checkbox[id='ad06']").is(":checked");
					var havdis7Yn = $("input:checkbox[id='ad07']").is(":checked");
					var havdis8Yn = $("input:checkbox[id='ad08']").is(":checked");
					if(!havdis1Yn && !havdis2Yn &&!havdis3Yn &&!havdis4Yn &&!havdis5Yn &&!havdis6Yn &&!havdis7Yn &&!havdis8Yn ) {
						alert("관련 질병내역을 선택해주세요");
						return false;
					} else {
						if(havdis7Yn) {
							var havdisEtc = $("input[name=havdisEtc]").val();
							if("" == havdisEtc) {
								alert("기타 상세항목을 작성해주세요");
								$("input[name=havdisEtc]").focus();
								return false;
							}
						}
					}
				}
			}
		}
		return returnVal;
	}

	/** 저장 관련 function */
	function saveData() {
		if(validateBasicMedInfo()) {
			if(confirm("저장하시겠습니까?")) {
				var params = $("#detailForm").serialize(); //{"UsrId":""};
				$.post('/whms/hi/basicMedInfoRegistAjax.do', params, function(r){
					if(r && r.success) {
						alert("정상적으로 등록되었습니다.");
						window.location.reload();
					} else {
						alert("등록하지 못했습니다. 작성 내용을 확인해주세요. \n오류내용: "+r.error_msg);
					}
				}, 'json');
			}
		}
	}

	/** input type number maxlength */
	function maxLengthCheck(object) {
		if (object.value.length > object.maxLength) {
			object.value = object.value.slice(0, object.maxLength);
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
	    /** 보유질병 관련 초기 숨김 처리 */
	    <c:if test="${!empty detailVO}">
	    	var havdisYn = "<c:out value='${detailVO.havdisYn}'/>";
	    	if("N" == havdisYn) {
	    		$("#havdisUl").show();
	    	}
	    </c:if>
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
					<form id="detailForm" name="detailForm" action="<c:url value='/whms/hi/basicMedInfo.do'/>" method="post">
						<input name="vStartP" type="hidden" value="<c:out value='${param.vStartP}'/>" />
						<input name="sysRgsDt" type="hidden" value="<c:out value='${detailVO.sysRgsDt}'/>" />
						<div class="reg_searchbox">
							<!-- search_tb -->
							<div class="search_tb mb0">       
							  <span class="select w100p">
							    <select name="searchCondition" id="searchCondition" >
							      <option value="USR_NM" <c:if test="${empty searchVO.searchCondition || searchVO.searchCondition == 'USR_NM' }">selected</c:if> >이름</option>
							      <option value="USR_ID" <c:if test="${searchVO.searchCondition == 'USR_ID' }">selected</c:if> >ID</option>
							    </select>
							  </span>
							  <span class="input w250p"><input type="text" placeholder="" id="searchKeyword" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword }'/>" style="width:100%" /></span>
							  <button type="button" class="btn-type btn_ico black" onClick="searchData()"><span class="i_search_black">조회</span></button>
							<button type="button" class="btn-type btn_ico black" onClick="saveData()">저장</button>
							</div>
							<!-- // search_tb -->
							</div>
							
							<div class="reg_tit">
							  <h3>기본정보</h3>
							</div>
							
							<div class="reg_form">
							  <ul>
							    <li class="l_txt">ID(식별자)</li>
							    <li class="r_area">
							      <input type="text" name="useGrpNm" id="useGrpNm" value="<c:out value='${detailVO.useGrpNm }'/>" placeholder="" class="w30 mr10"  readonly />
							      <input type="text" name="usrId" id="usrId" value="<c:out value='${detailVO.usrId }'/>" placeholder="" class="w30" readonly />
							      <input type="hidden" name="useGrpCd" id="useGrpCd" value="<c:out value='${detailVO.useGrpCd }'/>" />
							    </li>
							  </ul>
							  <ul>
							    <li class="l_txt">성별<img src="<c:url value='/images/egovframework/whms/i_check.png' />" alt=""></li>
							    <li class="r_area">
							      <input type="radio" id="sex01" name="sexSecd" value="01" <c:if test="${detailVO.sexSecd == '01'}"> checked</c:if> >
							      <label for="sex01">남자</label>
							      <input type="radio" id="sex02" name="sexSecd" value="02" <c:if test="${detailVO.sexSecd == '02'}"> checked</c:if>>
							      <label for="sex02">여자</label>
							    </li>
							  </ul>
							  <ul>
							    <li class="l_txt">이름<img src="<c:url value='/images/egovframework/whms/i_check.png' />" alt=""></li>
							    <li class="r_area">
							      <input type="text" name="usrNm" id="usrNm" maxlength="100" value="<c:out value='${detailVO.usrNm }'/>" placeholder="" class="w50" />
							    </li>
							  </ul>
							  <ul>
							    <li class="l_txt">나이<img src="<c:url value='/images/egovframework/whms/i_check.png' />" alt=""></li>
							    <li class="r_area">
							      <input type="number" name="usrAge" maxlength="3" oninput="maxLengthCheck(this)" id="usrAge" value="<c:out value='${detailVO.usrAge }'/>" placeholder="" class="w100p" /><span>세</span>
							    </li>
							  </ul>
							  <ul>
							    <li class="l_txt">흡연<img src="<c:url value='/images/egovframework/whms/i_check.png' />" alt=""></li>
							    <li class="r_area">
							      <input type="radio" id="sm01" name="smkYn" value="0" <c:if test="${detailVO.smkYn == '0'}"> checked</c:if>>
							      <label for="sm01">금연</label>
							      <input type="radio" id="sm02" name="smkYn" value="1" <c:if test="${detailVO.smkYn == '1'}"> checked</c:if> >
							      <label for="sm02">흡연</label>
							      <!-- <span>(금연:0, 흡연:1)</span> -->
							    </li>
							  </ul>
							  <ul>
							    <li class="l_txt">연락처<img src="<c:url value='/images/egovframework/whms/i_check.png' />" alt=""></li>
							    <li class="r_area">
							      <input type="text" name="connTelno" id="connTelno" maxlength="100" value="<c:out value='${detailVO.connTelno }'/>" placeholder="" class="w50" />
							    </li>
							  </ul>
							  <ul>
							    <li class="l_txt">신체활동<img src="<c:url value='/images/egovframework/whms/i_check.png' />" alt=""></li>
							    <li class="r_area">
							      <input type="radio" id="active01" name="acrRutnYn" value="0" <c:if test="${detailVO.acrRutnYn == '0'}"> checked</c:if>>
							      <label for="active01">규칙적</label>
							      <input type="radio" id="active02" name="acrRutnYn" value="1" <c:if test="${detailVO.acrRutnYn == '1'}"> checked</c:if>>
							      <label for="active02">부족</label>
							    </li>
							  </ul>
							  <ul>
							    <li class="l_txt">생년월일<img src="<c:url value='/images/egovframework/whms/i_check.png' />" alt=""></li>
							    <li class="r_area">
									<div class="datebox">
										<input type="text" name="birDt" id="birDt" value="<c:out value='${detailVO.birDt }'/>" placeholder="" class="input_d" readonly />
									</div>
							    </li>
							  </ul>
							  <ul>
							    <li class="l_txt">가족력(직계가족)<img src="<c:url value='/images/egovframework/whms/i_check.png' />" alt=""></li>
							    <li class="r_area">
							      <input type="checkbox" id="e01" name="fahs1Yn" value="Y" onClick="fn_check_fahs()" <c:if test="${detailVO.fahs1Yn == 'Y'}"> checked</c:if>>
							      <label for="e01">고혈압</label>
							      <input type="checkbox" id="e02" name="fahs2Yn" value="Y" onClick="fn_check_fahs()" <c:if test="${detailVO.fahs2Yn == 'Y'}"> checked</c:if>>
							      <label for="e02">당뇨병</label>
							      <input type="checkbox" id="e03" name="fahs3Yn" value="Y" onClick="fn_check_fahs()" <c:if test="${detailVO.fahs3Yn == 'Y'}"> checked</c:if>>
							      <label for="e03">뇌졸증</label>
							      <input type="checkbox" id="e04" name="fahs4Yn" value="Y" onClick="fn_check_fahs()" <c:if test="${detailVO.fahs4Yn == 'Y'}"> checked</c:if>>
							      <label for="e04">심장병</label>
							      <input type="checkbox" id="e05" name="fahs5Yn" value="Y" onClick="fn_check_fahs()" <c:if test="${detailVO.fahs5Yn == 'Y'}"> checked</c:if>>
							      <label for="e05">심근경색증</label>
							      <p class="mt0">
									<input type="checkbox" id="e06" name="fahs6Yn" value="Y" onClick="fn_check_fahs()" <c:if test="${detailVO.fahs6Yn == 'Y'}"> checked</c:if>>
							      	<label for="e06">기타</label>
							      	<input type="text" name="fahsEtc" id="fahsEtc" maxlength="100" value="<c:out value='${detailVO.fahs6Yn == "Y" ? detailVO.fahsEtc : "" }'/>" placeholder="" class="w70" />
							      </p>
							      <p class="mt0">
									<input type="checkbox" id="e07" name="fahsYn" value="Y" onClick="fn_check_fahs()" <c:if test="${detailVO.fahsYn == 'Y'}"> checked</c:if>>
									<label for="e07">해당사항 없음</label>
							      </p>
							    </li>
							  </ul>
							  <%-- <ul>
							    <li class="l_txt">가족력<img src="<c:url value='/images/egovframework/whms/i_check.png' />" alt=""></li>
							    <li class="r_area">
							      <input type="radio" id="f01" name="family" value="0" <c:if test="${detailVO.fahsCalcVal == 'N'}"> checked</c:if> readonly>
							      <label for="f01">없음</label>
							      <input type="radio" id="f02" name="family" value="0" <c:if test="${detailVO.fahsCalcVal == 'Y'}"> checked</c:if> readonly>
							      <label for="f02">한개 이상</label>
							      <span>(없음:0, 한개 이상:1)</span>
							    </li>
							  </ul> --%>
							  <ul>
							    <li class="l_txt">신장/몸무게</li>
							    <li class="r_area">
							      <input type="number" name="usrHet" id="usrHet" value="<c:out value='${empty detailVO ? "" : detailVO.usrHet }'/>" placeholder="" class="w100p" /><span>cm</span>
							      <input type="number" name="usrWet" id="usrWet" value="<c:out value='${empty detailVO ? "" :detailVO.usrWet }'/>" placeholder="" class="w100p" /><span>kg</span>
							    </li>
							  </ul>
							  <ul>
							    <li class="l_txt">음주<img src="<c:url value='/images/egovframework/whms/i_check.png' />" alt=""></li>
							    <li class="r_area">
							      <input type="radio" id="d01" name="alcYn"  value="0" <c:if test="${detailVO.alcYn == '0'}"> checked</c:if>>
							      <label for="d01">금주</label>
							      <input type="radio" id="d02" name="alcYn"  value="1" <c:if test="${detailVO.alcYn == '1'}"> checked</c:if>>
							      <label for="d02">음주</label>
							      <!-- <span>(금주:0, 음주:1)</span> -->
							    </li>
							  </ul>
							  <ul>
							    <li class="l_txt">BMI</li>
							    <li class="r_area">
							      <input type="text" name="bmiCt" id="bmiCt" maxlength="11" oninput="maxLengthCheck(this)" value="<c:out value='${detailVO.bmiCt }'/>" placeholder="" class="w150p" />
							    </li>
							  </ul>
							</div>
							<!-- // reg_form --> 

							<div class="reg_tit mt40">
							  <h3>건강 위험성 체크</h3>
							</div>

							<div class="reg_form">          
							  <ul>
							    <li class="l_txt">건강검진 실시여부<img src="<c:url value='/images/egovframework/whms/i_check.png' />" alt=""></li>
							    <li class="r_area">
							      <input type="checkbox" id="hs01" name="mecku1Yn" value="1" onClick="fn_check_mecku()" <c:if test="${detailVO.mecku1Yn == '1'}"> checked</c:if>>
							      <label for="hs01">배치전 건강진단</label>
							      <input type="checkbox" id="hs06" name="mecku6Yn" value="1" onClick="fn_check_mecku()" <c:if test="${detailVO.mecku6Yn == '1'}"> checked</c:if>>
							      <label for="hs06">배치후 건강진단</label>
							      <input type="checkbox" id="hs02" name="mecku2Yn" value="1" onClick="fn_check_mecku()" <c:if test="${detailVO.mecku2Yn == '1'}"> checked</c:if>>
							      <label for="hs02">특수 건강진단</label>
							      <input type="checkbox" id="hs03" name="mecku3Yn" value="1" onClick="fn_check_mecku()" <c:if test="${detailVO.mecku3Yn == '1'}"> checked</c:if>>
							      <label for="hs03">일반 건강진단</label>
							      <input type="checkbox" id="hs04" name="mecku4Yn" value="1" onClick="fn_check_mecku()" <c:if test="${detailVO.mecku4Yn == '1'}"> checked</c:if>>
							      <label for="hs04">미검진</label>
							      <input type="checkbox" id="hs05" name="mecku5Yn" value="1" onClick="fn_check_mecku()" <c:if test="${detailVO.mecku5Yn == '1'}"> checked</c:if>>
							      <label for="hs05">해당 없음</label>
							    </li>
							  </ul>
							  <ul>
							    <li class="l_txt">혈압(수축/이완)<img src="<c:url value='/images/egovframework/whms/i_check.png' />" alt=""></li>
							    <li class="r_area">
							      <input type="number" name="hypctCt" id="hypctCt" maxlength="11" oninput="maxLengthCheck(this)" value="<c:out value='${detailVO.hypctCt }'/>" placeholder="" class="w100p" />
							      <input type="number" name="hyprxCt" id="hyprxCt" maxlength="11" oninput="maxLengthCheck(this)" value="<c:out value='${detailVO.hyprxCt }'/>" placeholder="" class="w100p ml10" />
							      <span class="title_span ml15">맥박</span>
							      <input type="number" name="plsCt" id="plsCt" maxlength="11" oninput="maxLengthCheck(this)" value="<c:out value='${detailVO.plsCt }'/>" placeholder="" class="w100p" />
							      <span class="title_span ml15">측정일자</span>
							      <div class="datebox">
							      <input id="popModal_ex1" name="lstChkDt" type="text" title="" class="input_d" accesskey="S" value="<c:out value='${detailVO.lstChkDt }'/>"  placeholder="" readonly />
							      </div>
							    </li>
							  </ul>
							</div>
							<!-- // reg_form -->
							<div class="reg_tit mt40">
							  <h3>기타</h3>
							</div>
							
							<div class="reg_form">
							  <ul>
							    <li class="l_txt">보유질병(과거포함)<img src="<c:url value='/images/egovframework/whms/i_check.png' />" alt=""></li>
							    <li class="r_area">
							      <input type="radio" id="a01" name="havdisYn" value="Y" onClick="fn_hide_check();" <c:if test="${detailVO.havdisYn == 'Y'}"> checked</c:if>>
							      <label for="a01">없음</label>
							      <input type="radio" id="a02" name="havdisYn" value="N" onClick="fn_hide_check();" <c:if test="${detailVO.havdisYn == 'N'}"> checked</c:if>>
							      <label for="a02">있음</label>
							    </li>
							  </ul>
							  <ul id="havdisUl" style="display: none;">
									    <li class="l_txt">관련 질병내역</li>
									    <li class="r_area">
									      <input type="checkbox" id="ad01" name="havdis1Yn" value="Y" <c:if test="${detailVO.havdis1Yn == 'Y'}"> checked</c:if>>
									      <label for="ad01">고혈압(약 복용중)</label>
									      <input type="checkbox" id="ad08" name="havdis8Yn" value="Y" <c:if test="${detailVO.havdis8Yn == 'Y'}"> checked</c:if>>
									      <label for="ad08">고혈압(약 미복용)</label>
									      <input type="checkbox" id="ad02" name="havdis2Yn" value="Y" <c:if test="${detailVO.havdis2Yn == 'Y'}"> checked</c:if>>
									      <label for="ad02">당뇨병</label>
									      <input type="checkbox" id="ad03" name="havdis3Yn" value="Y" <c:if test="${detailVO.havdis3Yn == 'Y'}"> checked</c:if>>
									      <label for="ad03">고지혈증</label>
									      <input type="checkbox" id="ad04" name="havdis4Yn" value="Y" <c:if test="${detailVO.havdis4Yn == 'Y'}"> checked</c:if>>
									      <label for="ad04">천식</label>
									      <input type="checkbox" id="ad05" name="havdis5Yn" value="Y" <c:if test="${detailVO.havdis5Yn == 'Y'}"> checked</c:if>>
									      <label for="ad05">뇌전증(간질)</label>
									      <p class="mt0">
									      <input type="checkbox" id="ad06" name="havdis6Yn" value="Y" <c:if test="${detailVO.havdis6Yn == 'Y'}"> checked</c:if>>
							              <label for="ad06">통풍</label>
									      	<input type="checkbox" id="ad07" name="havdis7Yn" value="Y" <c:if test="${detailVO.havdis7Yn == 'Y'}"> checked</c:if>>
									      	<label for="ad07">기타</label>
									      	<input type="text" name="havdisEtc" id="havdisEtc" maxlength="100" value="<c:out value='${detailVO.havdis7Yn == "Y" ? detailVO.havdisEtc : "" }'/>" placeholder="" class="w70" />
									      </p>
									    </li>
									  </ul>
							</div>
							<!-- // reg_form -->

						<div class="btn_center mt20">
						  <button type="button" class="btn-type btn2 black" onClick="saveData()">저장</button>         
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