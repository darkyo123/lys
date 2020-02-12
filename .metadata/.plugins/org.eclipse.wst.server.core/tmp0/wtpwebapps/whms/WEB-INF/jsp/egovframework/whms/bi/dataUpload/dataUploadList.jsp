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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META name="viewport" content="user-scalable=no, width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<!-- Bootstrap -->
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/bootstrap.min.css' />" />
<link href="<c:url value='/css/egovframework/whms/wijmo/vendor/wijmo.min.css'/>" rel="stylesheet" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/wijmo/app.css'/>" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/style.css' />" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/reset.css' />" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/animate.css' />" type="text/css" />

<script src="<c:url value='/js/egovframework/whms/jquery-1.11.3.min.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/front-ui.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/jszip.min.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/c1xlsx.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/ExcelConverter.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/com/cmm/utl/EgovCmmUtl.js' />" type="text/javascript"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/whms/jquery.navgoco.js' />"></script><!-- left menu js -->

<script src="<c:url value='/js/egovframework/whms/wijmo/vendor/wijmo.min.js'/>" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/wijmo/vendor/wijmo.input.min.js'/>" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/wijmo/vendor/wijmo.grid.min.js'/>" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/wijmo/vendor/wijmo.grid.filter.min.js'/>" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/wijmo/vendor/wijmo.xlsx.min.js'/>" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/wijmo/vendor/wijmo.grid.xlsx.min.js'/>" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/wijmo/vendor/wijmo.nav.min.js'/>" type="text/javascript"></script>
<script> 
wijmo.setLicenseKey ('14.51.236.196|14.51.236.206|14.51.236.235|203.236.236.136|61.33.235.245|www.cnkoh.co.kr|www.whmscnko.co.kr,825287534425196#B0tM3N7gjM5IDOiojIklkIs4nIxYXOxAjMiojIyVmdiwSZzxWYmpjIyNHZisnOiwmbBJye0ICRiwiI34zdv2EWDxkWSRVQ9JHZ5RUWVJmZxQjaMRlZ9QGZBZnSMljekR7LtlGdrY6VVlHO5dGOjhFO5g5bDFWYGl4L5IHSmdzawFUSBtmUD5keKh6YzhVQ92yTrZHe9BFZIZmV556QS54T6ljUwVWZ5FVTt9mdjxkRzhDVLRmSNNHU7o4ZudEdS5UcudHZrk5NIVGajVFO5YzUZNXYY5kVR3ycmdzMRlWTjZWe8t6a7kUek56TT9kbMVjRDR6UsJUUrUjYtdnUSh4MuRmb9UFan5keHxGdXpVeth6Q92SethWaDFnaN36Sox4ZJVGa4omcLJXcMRXdCtWSDljSM9GSMZ7UO3WRykEa5IXSTJEWll5LCFXZTBXe9hWYHNTcIBzb7Y5LV3SaqB7axUkcvkzVYVlMmF5dMJXZEZDM8QlbUJDbqlFRroURWd6SNNTSXtEeDpWbx4kUygGdEJlI0IyUiwiICN4Q9E4M9QjI0ICSiwSN4UDN5kTNxQTM0IicfJye#4Xfd5nIJBjMSJiOiMkIsIibvl6cuVGd8VEIgQXZlh6U8VGbGBybtpWaXJiOi8kI1xSfiUTSOFlI0IyQiwiIu3Waz9WZ4hXRgAicldXZpZFdy3GclJFIv5mapdlI0IiTisHL3JyS7gDSiojIDJCLi86bpNnblRHeFBCI73mUpRHb55EIv5mapdlI0IiTisHL3JCNGZDRiojIDJCLi86bpNnblRHeFBCIQFETPBCIv5mapdlI0IiTisHL3JyMDBjQiojIDJCLiUmcvNEIv5mapdlI0IiTisHL3JSV8cTQiojIDJCLi86bpNnblRHeFBCI4JXYoNEbhl6YuFmbpZEIv5mapdlI0IiTis7W0ICZyBlIsISMwAjMxADI5ADOwkTMwIjI0ICdyNkIsIicr9ybj9ybr96Yz5Ga79yd7dHLytmLvNmLo36auNmL7d7dsUDNy8SNzIjLzMjLxYDL6MTMuYzMy8iNzIjLzAjMsUzMy8iNzIjLxUjL4EDL6AjMuYzMy8SM58CNxwiN9EjL6MjMuETNuQTMiojIz5GRiwiIU6L1kWJ1oSJ1iojIh94QiwiI6kTMdI4N'); 
</script>
<script>
	/** wijmo grid 객체 */
	var tcMainGrid;
	/** file upload 체크 */
	var fileUploadYn = "N";
	/** left 메뉴 script 사용 path */
	var path = location.origin;

	/** column 변경 임시 변수 */
	var flexColumns = null;
	/** 사용자 grid 컬럼 */
	var userColumns = [
		{ header: '허브코드', binding: 'useGrpCd', isReadOnly: true, width: 60 },
		{ header: '허브명', binding: 'useGrpNm', isReadOnly: true, width: 80 },
    	{ header: '이름', binding: 'usrNm', isReadOnly: true, width: 80 },
    	{ header: '성별', binding: 'sexSecd',  isReadOnly: true, width: 60 },
	    { header: '생년월일', binding: 'birDt',  isReadOnly: true, width: 100 },
    	{ header: '연락처', binding: 'connTelno',  isReadOnly: true, width: 100 },
    	{ header: '입사일', binding: 'entryDt',  isReadOnly: true, width: 100 },
    	{ header: '근무일수', binding: 'dutyDy',  isReadOnly: true, width: 80 },
    	{ header: '연속근무기간', binding: 'contDutyDy',  isReadOnly: true, width: 80 },
    	{ header: '야간연속근무기간', binding: 'ngcnDutyDy',  isReadOnly: true, width: 120 },
    	{ header: '고위험군구분', binding: 'highDgrCd',  isReadOnly: true },
    	{ header: '검진대상자', binding: 'medYn',  isReadOnly: true, width: 80 },
    	{ header: '교육일자', binding: 'eduDt', isReadOnly: true, width: 100 },
    	{ header: '교육이수여부', binding: 'eduCptYn',  isReadOnly: true, width: 100 }
    ];
	/** 건강진단 grid 컬럼 */
	var healthColumns = [
    	{ header: '검진종류', binding: 'meckuNm', isReadOnly: true },
    	{ header: '재검 여부', binding: 'rtychkYn',  isReadOnly: true, width: 80 },
    	{ header: '유해인자', binding: 'harmNm',  isReadOnly: true },
	    { header: '진단일자', binding: 'diagDt',  isReadOnly: true, width: 100 },
    	{ header: 'ID', binding: 'usrId',  isReadOnly: true },
    	{ header: '성명', binding: 'usrNm', isReadOnly: true, width: 80 },
    	{ header: '성별', binding: 'sexSecd',  isReadOnly: true, width: 60 },
    	{ header: '나이', binding: 'usrAge',  isReadOnly: true, width: 60 },
    	{ header: '입사일자', binding: 'entryDt',  isReadOnly: true, width: 100 },
    	{ header: '진단기관', binding: 'diagInstNm',  isReadOnly: true },
    	{ header: '차회 검진 기한', binding: 'nxtdDt',  isReadOnly: true, width: 100 },
    	{ header: '검진결과', binding: 'merstRmk', isReadOnly: true },
    	{ header: '유소견 이력', binding: 'dcviwHisNm',  isReadOnly: true },
    	{ header: '유소견 관리 내용', binding: 'dcviwCtlRmk',  isReadOnly: true },
    	{ header: '뇌심혈관계 평가 포함 여부', binding: 'brdevlYn', width: 160,  isReadOnly: true }
    ];
	/** 교육 grid 컬럼 */
	var eduColumns = [
    	{ header: '교육일자', binding: 'eduDt', isReadOnly: true, width: 100 },
    	{ header: '교육 종류', binding: 'eduKindNm',  isReadOnly: true },
    	{ header: '교육명', binding: 'eduNm',  isReadOnly: true },
	    /* { header: '업체명', binding: 'begNm',  isReadOnly: true }, */
    	{ header: 'ID', binding: 'usrId',  isReadOnly: true },
    	{ header: '성명', binding: 'usrNm',  isReadOnly: true, width: 80 },
    	{ header: '성별', binding: 'sexSecd',  isReadOnly: true, width: 60 },
    	{ header: '나이', binding: 'usrAge',  isReadOnly: true, width: 60 },
    	{ header: '교육기간', binding: 'eduDy',  isReadOnly: true },
    	{ header: '교육 시작', binding: 'eduStrDt',  isReadOnly: true, width: 100 },
    	{ header: '교육 종료', binding: 'eduEndDt',  isReadOnly: true, width: 100 },
    	{ header: '이수 여부', binding: 'eduCptYn', isReadOnly: true, width: 80 },
    	{ header: '교육강사', binding: 'eduTechNm',  isReadOnly: true, width: 80 },
    	{ header: '교육강사 자격', binding: 'eduTechQual',  isReadOnly: true }
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

	/** wijmo Excel Import script */
	function changeValue(obj) {
		if ($('#importFile')[0].files[0]) {
			wijmo.grid.xlsx.FlexGridXlsxConverter.loadAsync(tcMainGrid, $('#importFile')[0].files[0], { includeColumnHeaders: true });
			window.setTimeout("$('.text-number').text(tcMainGrid.rows.length) ", 100);
			window.setTimeout("tcMainGrid.isReadOnly = true; ", 100);
			fileUploadYn = "Y";
			var agent = navigator.userAgent.toLowerCase();
			if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ){
			    // ie 일때 input[type=file] init.
			    $("#importFile").replaceWith( $("#importFile").clone(true) );
			} else {
			    //other browser 일때 input[type=file] init.
			    $("#importFile").val("");
			}
		}
	}

	/** Grid setting **/
	onload = function() {

		if(flexColumns == null) flexColumns = userColumns;

		createGrid();

		function getData() {

			var condition = $("select[name=searchCondition]").val();
			var value = $("input[name=searchValue]").val();

			/** Data Initialize **/
		    var data = [];
			var searchCondition = condition == undefined ? null : condition;
			var searchKeyword = value == undefined ? null : value;

			var searchUrl = "<c:url value='/whms/bi/userManageDataAjax.do' />";

			var searchCondition = $("select[name=searchCondition]").val();
			if("H" == searchCondition) searchUrl = "<c:url value='/whms/hi/healthMedInfoDataAjax.do' />";
			if("E" == searchCondition) searchUrl = "<c:url value='/whms/hi/eduHistoryInfoDataAjax.do' />";

		    /** Data binding Ajax **/
		    $.ajax({
				type:"POST",
				url: searchUrl,
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
									if("U" == searchCondition) {
										data.push({
											useGrpCd: result.useGrpCd,
											useGrpNm: result.useGrpNm,
								            usrNm: result.usrNm,
								            sexSecd: result.sexSecd == "01" ? "남자" : "여자",
								            birDt: result.birDt,
								            connTelno: result.connTelno,
								            entryDt: result.entryDt,
								            dutyDy: result.dutyDy,
								            contDutyDy: result.contDutyDy,
								            ngcnDutyDy: result.ngcnDutyDy,
								            highDgrCd: result.highDgrNm,
								            medYn : result.medYn == "Y" ? "Y" : "N",
								            eduDt: result.eduDt,
								            eduCptYn: result.eduCptYn == "Y" ? "Y" : "N"
								        });
									} else if("H" == searchCondition) {
										data.push({
											harmNm: result.harmNm,
								            usrNm: result.usrNm,
								            usrId: result.usrId,
								            sexSecd: result.sexSecd == null ? "" : result.sexSecd == "01" ? "남자" : "여자",
								            birDt: result.birDt,
								            usrAge: result.usrAge,
								            entryDt: result.entryDt,
								            meckuCd: result.meckuCd,
								            meckuNm: result.meckuNm,
								            rtychkYn: result.rtychkYn == "Y" ? "Y" : "N",
								            diagDt: result.diagDt,
								            diagInstNm: result.diagInstNm,
								            nxtdDt : result.nxtdDt,
								            merstRmk: result.merstRmk,
								            dcviwHisNm: result.dcviwHisNm,
								            dcviwCtlRmk: result.dcviwCtlRmk,
								            brdevlYn: result.brdevlYn == "Y" ? "Y" : "N"
								        }); 
										} else if("E" == searchCondition) {
											data.push({
									            usrNm: result.usrNm,
									            usrId: result.usrId,
									            sexSecd: result.sexSecd == null ? "" : result.sexSecd == "01" ? "남자" : "여자",
									            usrAge: result.usrAge,
									            eduDt: result.eduDt,
									            eduKindNm: result.eduKindNm,
									            eduNm: result.eduNm,
									            eduDy: result.eduDy,
									            eduStrDt: result.eduStrDt,
									            eduEndDt: result.eduEndDt,
									            eduCptYn: result.eduCptYn == "Y" ? "Y" : "N",
									            eduTechNm: result.eduTechNm,
									            eduTechQual: result.eduTechQual
									        });
										}
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

		/** Edit 시 wijmo row -> modal 세팅 */
		function setInputValue(id, value) {
		    var input = document.getElementById(id);
		    if (input.type == 'checkbox') {
		        input.checked = value;
		    } else {
		        input.value = value;
		    }
		}

		/** 검색 관련 function */
		function searchData() {
			var searchCondition = $("select[name=searchCondition]").val();
			if("U" == searchCondition) flexColumns = userColumns;
			if("H" == searchCondition) flexColumns = healthColumns;
			if("E" == searchCondition) flexColumns = eduColumns;
			tcMainGrid.dispose();
			createGrid();
		}

		/** grid 생성 */
		function createGrid() {

			// create a grid to show and edit the data
			tcMainGrid = new wijmo.grid.FlexGrid('#tcMainGrid', {
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

		/** 샘플다운로드 버튼 event */
		document.getElementById('btnExport').addEventListener('click', function() {
			/* var searchCondition = $("select[name=searchCondition]").val();
			var fileNm = "userManage.xlsx";
			if("U" == searchCondition) fileNm = "userInfo.xlsx";
			if("H" == searchCondition) fileNm = "healthMedInfo.xlsx";
			if("E" == searchCondition) fileNm = "eduHistoryInfo.xlsx";
			wijmo.grid.xlsx.FlexGridXlsxConverter.saveAsync(tcMainGrid, { includeColumnHeaders: true, includeCellStyles: true }, fileNm); */

			/* var userAgent=navigator.userAgent.toLowerCase();

			var browser;

			if(userAgent.indexOf('edge')>-1){
				browser='edge';
			}else if(userAgent.indexOf('whale')>-1){
				browser='whale';
			}else if(userAgent.indexOf('chrome')>-1){
				browser='chrome';
			}else if(userAgent.indexOf('firefox')>-1){
				browser='firefox';
			}else{
				browser='ie';
			}

			var searchCondition = $("select[name=searchCondition]").val();

			if("ie" == browser) {
				var url = "<c:url value='/whms/bi/dataUploadListPop.do' />?searchCondition="+searchCondition;
		         var popupwidth = '1000';
		         var popupheight = '50';
		         var title = '파일 다운로드';

		         Top = (window.screen.height - popupheight) / 3;
		         Left = (window.screen.width - popupwidth) / 2;
		         if (Top < 0) Top = 0;
		         if (Left < 0) Left = 0;
		         Future = "fullscreen=no,toolbar=no,location=no,directories=no,status=no,menubar=no,   scrollbars=no,resizable=yes,left=" + Left + ",top=" + Top + ",width=" + popupwidth + ",height=" + popupheight;
		         PopUpWindow = window.open(url, title, Future);
		         PopUpWindow.focus();				
			} else {
				var searchCondition = $("select[name=searchCondition]").val();
				var fileNm = "userManage.xlsx";
				if("U" == searchCondition) fileNm = "userInfo.xlsx";
				if("H" == searchCondition) fileNm = "healthMedInfo.xlsx";
				if("E" == searchCondition) fileNm = "eduHistoryInfo.xlsx";
				wijmo.grid.xlsx.FlexGridXlsxConverter.saveAsync(tcMainGrid, { includeColumnHeaders: true, includeCellStyles: true }, fileNm);
			} */

			var searchCondition = $("select[name=searchCondition]").val();
			var fileNm = "userManage.xlsx";
			if("U" == searchCondition) fileNm = "userInfo.xlsx";
			if("H" == searchCondition) fileNm = "healthMedInfo.xlsx";
			if("E" == searchCondition) fileNm = "eduHistoryInfo.xlsx";
			location.href="<c:url value='/template/"+fileNm+"'/>";
		})

		/** 파일업로드 버튼 event */
		document.getElementById('btnImport').addEventListener('click', function() {
			$(".file_hide").click();
		})

		/** 저장 버튼 event */
		document.getElementById('btnSave').addEventListener('click', function() {
			$(".errorSpan").removeClass("red");
			$(".errorSpan").hide();
			var searchCondition = $("select[name=searchCondition]").val();
			if (fileUploadYn == "Y") {
				var arr = [];
				for (var r = 0; r < tcMainGrid.rows.length; r++) {
					var item = {};
					for (var c = 0; c <tcMainGrid.columns.length; c++) {
						item[c] = tcMainGrid.getCellData(r, c, false);
					}
					arr.push(item);
				}

				$.ajax({
					type:"POST",
					url:"<c:url value='/whms/bi/dataUploadSaveAjax.do' />",
					data:{
						"dataVal" : JSON.stringify(arr),
						"dataType" : $("select[name=searchCondition]").val()
					},
					dataType:'json',
					timeout:(1000*60),
					success:function(returnData, status) {
						fileUploadYn = "N";
						if(status == "success") {
							if(returnData.result == "Y") {
								$(".errorSpan").text("업로드에 성공하였습니다 (총 " + returnData.totalLine + " 건)");
								$(".errorSpan").show();
								tcMainGrid.dispose();
								createGrid();
							} else {
								$(".errorSpan").addClass("red");
								$(".errorSpan").text("Error!! " + returnData.error + " (총 " + returnData.totalLine + "건 / Line : " + returnData.errorLine + ")");
								$(".errorSpan").show();
								return;
							}
						} else { 
							//alert("ERROR!");
							console.log("save Error Occurred");
							return;
						}
					}
				});
			} else {
				alert("등록할 파일이 없습니다.");
				return;
			}

		});

	}
	
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
				<div class="right_area">
					<form name="listForm" action="<c:url value='/whms/bi/userManageList.do'/>" method="post">
						<input name="flag" type="hidden" value="L"/>
						<input name="paramId" type="hidden" value=""/>

						<div class="search_tb">
							<div class="stb_left">
								<span class="select w100p">
									<select name="searchCondition" >
									  <option value="U" selected>사용자</option>
									  <option value="H">건강진단</option>
									  <option value="E">교육</option>
									</select>
								</span>
								<button type="button" class="btn-type btn_ico gray_line" id="btnSearch"><span class="i_search_bg">조회</span></button>
							</div>
							<div class="stb_right">
								<button type="button" class="btn-type btn_ico gray_line" id="btnImport"><span class="i_fileup_bg">파일업로드</span></button>
								<input type="file" class="file_hide" id="importFile" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" onchange="changeValue(this)" />
								<button type="button" class="btn-type btn_ico gray_line" id="btnSave"><span class="i_write_bg">저장</span></button>
								<button type="button" class="btn-type btn_ico gray_line" id="btnExport"><span class="i_filedown_bg">샘플다운로드</span></button>
							</div>
						</div>

						<div id="tcMainGrid"></div>

						<span class="pull-left errorSpan" style="display:none"></span>
						<span class="pull-right text-count">Total <span class="text-number">0</span></span>

					</form>
				</div>
			</div>
		</div>
	</div>
<script src="<c:url value='/js/egovframework/whms/needpopup.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/default.js' />" type="text/javascript"></script>
</body>
</html>