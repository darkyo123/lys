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
<script src="<c:url value='/js/egovframework/whms/front-ui.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/jquery-ui.min.js' />" type="text/javascript"></script>
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
		{ header: '선택', binding: "check", width: 60 },
		{ header: 'No', binding: "no", width: 0 },
		{ header: '고위험군', binding: 'highDgrCd',  isReadOnly: true, cssClass: 'text-health' },
		{ header: 'Hub', binding: 'useGrpNm', isReadOnly: true, width: 80 },
		{ header: '팀', binding: 'begCd', isReadOnly: true, width: 100 },
    	{ header: '이름', binding: 'usrNm', isReadOnly: true, cssClass: 'text-cursor', width: 80 },
	    { header: '생년월일', binding: 'birDt',  isReadOnly: true, width: 100 },
    	{ header: '입사일자', binding: 'entryDt',  isReadOnly: true, width: 100 },
    	{ header: '수축', binding: 'hypctCt',  isReadOnly: true, cssClass: 'text-cursor', width: 80 },
    	{ header: '이완', binding: 'hyprxCt',  isReadOnly: true, cssClass: 'text-cursor', width: 80 },
    	{ header: '맥박', binding: 'plsCt',  isReadOnly: true, cssClass: 'text-cursor', width: 80 },
    	{ header: '최종측정일', binding: 'lstChkDt',  isReadOnly: true, cssClass: 'text-cursor', width: 100 },
    	{ header: '측정도래일', binding: 'nextChkDt',  isReadOnly: true, cssClass: 'text-cursor', width: 100 },
    	{ header: '유소견여부', binding: 'dcviwYn', isReadOnly: true, width: 80 },
    	{ header: '최근문진일', binding: 'makeDt',  isReadOnly: true, width: 100 },
    	{ header: '문진도래일', binding: 'nextMakeDt',  isReadOnly: true, width: 100 },
    	{ header: '근무일수', binding: 'dutyDy',  isReadOnly: true, cssClass: 'text-cursor', width: 80 },
    	{ header: '연속근무기간', binding: 'contDutyDy',  isReadOnly: true, cssClass: 'text-cursor', width: 80 },
    	{ header: 'ID', binding: 'usrId',  isReadOnly: true },
    	{ header: '성별', binding: 'sexSecd',  isReadOnly: true, width: 60 },
    	{ header: '연락처', binding: 'connTelno',  isReadOnly: true, width: 120 },
    	{ header: '허브코드', binding: 'useGrpCd', isReadOnly: true, width: 0 }
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

	$(document).ready(function() {
		/** wijmo modal 세팅 */
		dlgDetail = new wijmo.input.Popup('#dlgDetail', {
		    removeOnHide: false
		});
	});

	$( function() {
	    $( ".input_d" ).datepicker({
	    	changeMonth: true,
	        changeYear: true,
	        dateFormat: 'yy-mm-dd'
	    });
	} );

	/** Grid setting **/
	onload = function() {

		$("input[name=searchBegCd]").keydown(function(key) {
			if (key.keyCode == 13) {
				searchData();
			}
		});
		$("input[name=searchName]").keydown(function(key) {
			if (key.keyCode == 13) {
				searchData();
			}
		});

		/** Modal date format */
		var theInputDate = new wijmo.input.InputDate('#modal_birDt', {
			isRequired: false,
			valueChanged: function(s, e) {
				setDateTime(s.value);
			}
		});

		function setDateTime(value) {
		    theInputDate.value = value;
		}

/* 		var theInputDate2 = new wijmo.input.InputDate('#modal_entryDt', {
			valueChanged: function(s, e) {
				setDateTime2(s.value);
			}
		});

		function setDateTime2(value) {
		    theInputDate2.value = value;
		}
 */
		var theInputDate3 = new wijmo.input.InputDate('#modal_entryDt', {
			isRequired: false,
			valueChanged: function(s, e) {
				setDateTime3(s.value);
			}
		});

		function setDateTime3(value) {
		    theInputDate3.value = value;
		}

		//flexColums.push( { header: '테스트', binding: 'test',  isReadOnly: true } );

		createGrid();

		/** grid data mapping script */
		function getData() {

			var begCd = $("input[name=searchBegCd]").val();
			var name = $("input[name=searchName]").val();
			var startDt = $("input[name=searchStartDt]").val();
			var endDt = $("input[name=searchEndDt]").val();
			var highDgrCd = $("select[name=searchHighDgrCd]").val();

			/** Data Initialize **/
		    var data = [];
			var searchBegCd = begCd == undefined ? null : begCd;
			var searchName = name == undefined ? null : name;
			var searchStartDt = startDt == undefined ? null : startDt;
			var searchEndDt = endDt == undefined ? null : endDt;
			var searchHighDgrCd = highDgrCd == undefined ? null : highDgrCd;

		    /** Data binding Ajax **/
		    $.ajax({
				type:"POST",
				url:"<c:url value='/whms/bi/userManageDataAjax.do' />",
				data:{
					"searchBegCd": searchBegCd,
					"searchName": searchName,
					"searchStartDt": searchStartDt,
					"searchEndDt": searchEndDt,
					"searchHighDgrCd": searchHighDgrCd
				},
				dataType:'json',
				timeout:(1000*60),
				async: false,
				success:function(returnData, status) {
					if(status == "success") {
						if(returnData != null) {
							if(returnData.dataList.length != 0) {
								$("#searchGuide").hide();
								$(".text-number").text(returnData.dataList.length);
								for(var i=0; i<returnData.dataList.length; i++) {
									var result = returnData.dataList[i];
									data.push({
										no: (i+1),
										useGrpCd: result.useGrpCd,
										useGrpNm: result.useGrpNm,
							            usrNm: result.usrNm,
							            usrId: result.usrId,
							            sexSecd: result.sexSecd == null ? "" : result.sexSecd == "01" ? "남자" : "여자",
							            birDt: (result.birDt == null || result.birDt == "") ? "" : result.birDt,
							            connTelno: result.connTelno == null ? "" : result.connTelno,
							            entryDt: result.entryDt,
							            dutyDy: result.dutyDy,
							            contDutyDy: result.contDutyDy,
							            ngcnDutyDy: result.ngcnDutyDy,
							            highDgrCd: result.highDgrNm,
							            medYn : result.medYn == "Y" ? "Y" : "N",
					            		hypctCt: result.hypctCt == null ? "" : result.hypctCt,
					            		hyprxCt: result.hyprxCt == null ? "" : result.hyprxCt,
					            		plsCt: result.plsCt == null ? "" : result.plsCt,
					            		dcviwYn: result.dcviwYn == null || result.dcviwYn == "" ? "N" : result.dcviwYn,
					            		begCd: result.begCd,
					            		makeDt: result.makeDt,
					            		lstChkDt: result.lstChkDt,
					            		nextMakeDt: result.nextMakeDt,
					            		nextChkDt: result.nextChkDt,
					            		check: false
							        });
								}
							} else {
								$("#searchGuide").show();
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
			if($('#searchCondition').val()=='') {
				alert('검색 항목을 선택해주세요.');
				$('#searchCondition').focus();
				return false;
			}
			if($('#searchValue').val()=='') {
				alert('검색어를 입력해주세요.');
				$('#searchValue').focus();
				return false;
			}
			tcMainGrid.dispose();
			createGrid();
		}

		/** Row delete ajax */
		function rowDelete() {
			var useGrpCds = "";
			var idxs = "";
			for(var i=0; i<tcMainGrid.rows.length; i++) {
				if(tcMainGrid.rows[i]._data.check) {
					idxs = idxs.concat(tcMainGrid.rows[i]._data.usrId).concat(",");
					useGrpCds = useGrpCds.concat(tcMainGrid.rows[i]._data.useGrpCd).concat(",");
				}
			}
			if(idxs != "") {
				idxs = idxs.substring(0, idxs.length-1);
				useGrpCds = useGrpCds.substring(0, useGrpCds.length-1);
			}
			$.ajax({
				type:"POST",
				url:"<c:url value='/whms/bi/userManageDeleteAjax.do' />",
				data:{
					"usrId": idxs,
					"useGrpCd": useGrpCds
				},
				dataType:'json',
				timeout:(1000*60),
				success:function(returnData, status) {
					if(status == "success") {
						if(returnData) {
							alert("정상적으로 처리되었습니다.");
							tcMainGrid.dispose();
							createGrid();
						} else {
							console.log("rowDelete Ajax fail");
							alert("삭제에 실패했습니다.");
						}
					} else {
						console.log("rowDelete Error Occurred");
						alert("삭제에 실패했습니다.");
					} 
				}
			});
		}

		/** Row insert or edit ajax */
		function rowEdit(item, flag) {
			$.ajax({
				type:"POST",
				url:"<c:url value='/whms/bi/userManageSaveAjax.do' />",
				data:{
					"flag": flag,
					"useGrpCd": item.useGrpCd,
					"usrId" : item.usrId,
					"usrNm": item.usrNm,
					"begCd": item.begCd,
					"sexSecd": item.sexSecd,
					"birDt": item.birDt,
					"connTelno": item.connTelno,
					"entryDt": item.entryDt,
					"dutyDy": item.dutyDy,
					"contDutyDy": item.contDutyDy
					/* "highDgrCd": item.highDgrCd */
				},
				dataType:'json',
				timeout:(1000*60),
				success:function(returnData, status) {
					if(status == "success") {
						if(returnData.result) {
							alert("정상적으로 처리되었습니다.");
							tcMainGrid.dispose();
							createGrid();
						} else {
							console.log("rowEdit Ajax fail");
							alert("처리에 실패했습니다.");
						}
					} else { 
						alert("처리에 실패했습니다.");
						console.log("rowEdit Error Occurred");
						return;
					}
				}
			});
		}

		/** grid 생성 */
		function createGrid() {

			// create a grid to show and edit the data
			tcMainGrid = new wijmo.grid.FlexGrid('#tcMainGrid', {
			    allowDelete: true,
			    autoGenerateColumns: false,
			    frozenColumns: 6,
			    columns: flexColumns,
			    itemsSource: getData(),
			    selectionChanged: function(s, e) {								// grid 클릭 시 event
			    	if (tcMainGrid.selection.isSingleCell) {						// 선택된게 한개의 cell인 경우
			    		var sel = tcMainGrid.selection;
			    		var useGrpCd = tcMainGrid.cells.getCellData(sel.row, 21, false);				// useGrpCd
						var userId = tcMainGrid.cells.getCellData(sel.row, 18, false);					// usrId
						var moveCol = [2, 5, 8, 9, 10, 11, 12, 16, 17];											// 이동 컬럼 정의
						for(var i=0; i<moveCol.length; i++) {
							if(sel.col == moveCol[i]) {
								if(moveCol[i] == 2 || moveCol[i] == 5 || moveCol[i] == 16 || moveCol[i] == 17) {			// 이름, 근무일수, 연속근무기간 클릭 시 작업자 별 상세 조회 정보 이동
									var moveUrl = $("#li1020000").find("a").attr("href").replace("javascript:", "");
									document.selectOne.paramGrpCd.value=useGrpCd;
									document.selectOne.paramId.value=userId;
									eval(moveUrl);
								} else {																								// 혈압 정보 클릭 시 혈압 측정 정보 이동
									var moveUrl = $("#li2010000").find("a").attr("href").replace("javascript:", "");
									document.selectOne.paramGrpCd.value=useGrpCd;
									document.selectOne.paramId.value=userId;
									eval(moveUrl);
								}
							}
						}
					}
			    }
			});

			/** grid 첫번째 colume 숨김 */
			tcMainGrid.headersVisibility = "Column";

			//다중 헤더 추가
			for (var i = 0; i < 1; i++) {
			    var hr = new wijmo.grid.Row();
			    tcMainGrid.columnHeaders.rows.push(hr);
			}

			// 컬럼 헤더에 데이터 추가 및 컬럼 헤더 병합
			tcMainGrid.allowMerging = wijmo.grid.AllowMerging.AllHeaders;

			for (var r = 0; r < tcMainGrid.columnHeaders.rows.length; r++) {
				tcMainGrid.columnHeaders.rows[0].allowMerging = true;
			    for (var c = 0; c < tcMainGrid.columnHeaders.columns.length; c++) {
			    	if(r == 0) {
			    		if (c == 0) {
				    		tcMainGrid.columnHeaders.setCellData(r, c, "선택");
				    	} else if (c == 1) {
				        	tcMainGrid.columnHeaders.setCellData(r, c, "No");
				        } else if (c == 2) {
				        	tcMainGrid.columnHeaders.setCellData(r, c, "고위험군");
				        } else if (c >=3 && c <= 7) {
				        	tcMainGrid.columnHeaders.setCellData(r, c, "기본정보");
				        } else if (c >=8 && c <= 12) {
				        	tcMainGrid.columnHeaders.setCellData(r, c, "혈압정보");
				        } else if (c >=13 && c <= 15) {
				        	tcMainGrid.columnHeaders.setCellData(r, c, "문진정보");
				        } else if (c >=16 && c <= 17) {
				        	tcMainGrid.columnHeaders.setCellData(r, c, "근무정보");
				        } else {
				        	tcMainGrid.columnHeaders.setCellData(r, c, "구분");
				        }
			    	}
			    	tcMainGrid.columnHeaders.columns[c].allowMerging = true;
	        		tcMainGrid.columnHeaders.align = "center";
			    }
			}

			// 해더의 vertical align 설정
			 tcMainGrid.formatItem.addHandler(function (s, e) {
			   if (e.panel.cellType === wijmo.grid.CellType.ColumnHeader) {
			       e.cell.innerHTML = '<div>' + e.cell.innerHTML + '</div>';
			       wijmo.setCss(e.cell.children[0], {
			           position: 'relative',
			           top: '50%',
			           transform: 'translateY(-50%)'
			       });
			   }
			});

		}

		/** 조회 버튼 event */
		document.getElementById('btnSearch').addEventListener('click', function () {
			searchData();
		});

		/** 등록 버튼 event */
		document.getElementById('btnAdd').addEventListener('click', function () {
			$("#modal_type").val("I");
		    showDialog(null, '사용자 등록');
		});

		/** 수정 버튼 event */
		document.getElementById('btnEdit').addEventListener('click', function () {
			var editItem = null;
			var cnt = 0;
			for(var i=0; i<tcMainGrid.rows.length; i++) {
				if(tcMainGrid.rows[i]._data.check) {
					editItem = tcMainGrid.rows[i]._data;
					cnt++;
				}
			}

			if(cnt == 0) {
				alert("수정할 사용자가 없습니다.");
				return;
			}

			if(cnt > 1) {
				alert("한 건의 데이터만 수정 가능합니다.");
				return;
			}
		    $("#modal_type").val("U");
		    showDialog(editItem, '사용자 수정');
		});

		/** 삭제 버튼 event */
		document.getElementById('btnDelete').addEventListener('click', function () {
			var idxs = "";
			for(var i=0; i<tcMainGrid.rows.length; i++) {
				if(tcMainGrid.rows[i]._data.check) {
					idxs = idxs.concat(tcMainGrid.rows[i]._data.usrId);
					if(i != tcMainGrid.rows.length-1) {
						idxs = idxs.concat(",");
					}
				}
			}
			if("" == idxs) {
				alert("삭제할 사용자가 없습니다.");
				return;
			}
			if(confirm("삭제하시겠습니까?")) {
				rowDelete();
			}
		});

		/** wijmo modal script */
		function showDialog(item, title) {

		    // update dialog inputs
		    if(item == null) {
		    	setInputValue('modal_idx', '');
		    	setInputValue('modal_usrNm', '');
		    	setInputValue('modal_begCd', '');
		    	setInputValue('modal_connTelno', '');
		    	setInputValue('modal_dutyDy', '');
		    	setInputValue('modal_contDutyDy', '');
		    	$("input[name=sexSecd]").attr("checked", false);
		    	/* $("input[name=highDgrCd]").attr("checked", false); */
		    	$("select[name=useGrpCd] option").attr("disabled", false);
		    	$("select[name=useGrpCd] option").eq(0).attr("selected", true);
		    	setDateTime(null);
		    	setDateTime3(null);
		    } else {

		    	/** select, radio 초기화 */
		    	$("select[name=useGrpCd] option").attr("selected", false);
		    	$('input:radio[name=sexSecd]').prop("checked", false);
		    	/* $('input:radio[name=highDgrCd]').prop("checked", false); */

		    	$.ajax({
					type:"POST",
					url:"<c:url value='/whms/bi/userManageSingleDataAjax.do' />",
					data:{
						"useGrpCd": item.useGrpCd,
						"usrId" : item.usrId
					},
					async: false,
					dataType:'json',
					timeout:(1000*60),
					success:function(returnData, status) {
						if(status == "success") {
							if(returnData.data) {
								var data = returnData.data;
								setInputValue('modal_usrNm', data.usrNm != null ? data.usrNm : '');
								setInputValue('modal_connTelno', data.connTelno != null ? data.connTelno : '');
								
								setInputValue('modal_useGrpCd', item.useGrpCd != null ? item.useGrpCd : '');
						    	setInputValue('modal_idx', item.usrId != null ? item.usrId : '');
						    	setInputValue('modal_begCd', item.begCd != null ? item.begCd : '');
						    	setInputValue('modal_dutyDy', item.dutyDy != null ? item.dutyDy : '');
						    	setInputValue('modal_contDutyDy', item.contDutyDy != null ? item.contDutyDy : '');
						    	var sexVal = item.sexSecd == "남자" ? "01" : "02";
						    	$("select[name=useGrpCd] option").each(function() {
									if($(this).val() == item.useGrpCd) {
										$(this).attr("selected", true);
									}
						    	});
						    	$("select[name=useGrpCd] option").not(":selected").attr("disabled", "disabled");
						    	$('input:radio[name=sexSecd]:input[value=' + sexVal + ']').prop("checked", true);
						    	/* var highDgrVal = item.highDgrCd == null || item.highDgrCd == "" ? "" : item.highDgrCd == "고위험군" ? "21" : item.highDgrCd == "고위험군(예비)" ? "22" : item.highDgrCd == "일반관리" ? "23" : "24"; */
						    	/* if(highDgrVal != "") {
						    		$('input:radio[name=highDgrCd]:input[value=' + highDgrVal + ']').prop("checked", true);
						    	} */
						    	item.entryDt == null || item.entryDt == "" ? "" : setDateTime3(wijmo.Globalize.format(item.entryDt));
						    	data.birDt == null || data.birDt == "" ? setDateTime(null) : setDateTime(wijmo.Globalize.format(data.birDt));

							} else {
								console.log("singleData Ajax fail");
								alert("처리에 실패했습니다.");
							}
						} else {
							alert("처리에 실패했습니다.");
							console.log("singleData Error Occurred");
							return;
						}
					}
				});
		    }
		    $(".modal-title").text(title);

		    // show dialog
		    dlgDetail.show(true, function (s) {
		        if (s.dialogResult == 'wj-hide-ok') {
		            var item = makeItem();
		        	rowEdit(item, $("#modal_type").val());
		        } else {
		        }
		    });
		}

		/** modal data object화 */
		function makeItem() {
			var item = new Object();
			item.useGrpCd = $("#modal_useGrpCd").val();
			item.usrId = $("#modal_idx").val();
			item.usrNm = $("#modal_usrNm").val();
			item.begCd = $("#modal_begCd").val();
			item.sexSecd = $(":input:radio[name=sexSecd]:checked").val();
			item.birDt = wijmo.Globalize.format(theInputDate.value, "yyyy-MM-dd");
			item.connTelno = $("#modal_connTelno").val();
			item.entryDt = wijmo.Globalize.format(theInputDate3.value, "yyyy-MM-dd");
			item.dutyDy = $("#modal_dutyDy").val();
			item.contDutyDy = $("#modal_contDutyDy").val();
			//item.highDgrCd = $(":input:radio[name=highDgrCd]:checked").val();
			return item;
		}

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
	<input name="paramGrpCd" type="hidden" value="" />
	<input name="paramId" type="hidden" value="" />
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
							<div class="stb_left"></div>
							<div class="stb_right">
								<button type="button" class="btn-type btn_ico gray_line" id="btnSearch"><span class="i_search_bg">조회</span></button>
								<button type="button" class="btn-type btn_ico gray_line" id="btnAdd"><span class="i_write_bg">등록</span></button>
								<button type="button" class="btn-type btn_ico gray_line" id="btnDelete"><span class="i_del_bg">삭제</span></button>
								<button type="button" class="btn-type btn_ico gray_line" id="btnEdit"><span class="i_mwrite_bg">수정</span></button>
								<!-- <button type="button" class="btn-type btn_ico gray_line" id="btnPrint"><span class="i_print_bg">출력</span></button> -->
							</div>
						</div>
						
						<div class="stat_search mt0">
							<ul>
							  <li class="all_area">
							    <div class="stit">
							    		구분
								    	<%-- <select name="searchCondition" id="searchCondition">
											<option value="USR_NM" <c:if test="${empty searchVO.searchCondition || searchVO.searchCondition == 'USR_NM' }">selected</c:if> >이름</option>
											<option value="USR_ID" <c:if test="${searchVO.searchCondition == 'USR_ID' }">selected</c:if> >ID</option>
										</select> --%>
							    	<input type="text" name="searchBegCd" id="" value="<c:out value='${searchVO.searchBegCd}'/>" placeholder="팀" class="w100p ml10 height_34 p_center" />
							    	<input type="text" name="searchName" id="" value="<c:out value='${searchVO.searchName}'/>" placeholder="이름" class="w100p ml10 height_34 p_center" />
						    	</div>
						    	<div class="stit">
						    		조회일자
						    		<div class="datebox ml10 height_34">
								    <input id="popModal_ex1" name="searchStartDt" type="text" title="" class="input_d" accesskey="S" value="<c:out value='${searchVO.searchStartDt}'/>"  placeholder="" readonly />
								    </div>
								    <span class="txt">~</span>
								    <div class="datebox height_34">
								    <input id="popModal_ex2" name="searchEndDt" type="text" title="" class="input_d" accesskey="S" value="<c:out value='${searchVO.searchEndDt}'/>"  placeholder="" readonly />
								    </div>
						    	</div>
							    <div class="stit">
							    	고위험군
							    	<span class="select w150p ml10 height_34">
								    	<select name="searchHighDgrCd" id="searchHighDgrCd">
								    		<option value="">선택하세요</option>
											<option value="21" <c:if test="${searchVO.searchHighDgrCd == '21' }">selected</c:if> >고위험군</option>
											<option value="22" <c:if test="${searchVO.searchHighDgrCd == '22' }">selected</c:if> >고위험군(예비)</option>
											<option value="23" <c:if test="${searchVO.searchHighDgrCd == '23' }">selected</c:if> >일반관리</option>
											<option value="24" <c:if test="${searchVO.searchHighDgrCd == '24' }">selected</c:if> >정상</option>
											<option value="25" <c:if test="${searchVO.searchHighDgrCd == '25' }">selected</c:if> >공백</option>
										</select>
									</span>
						    	</div>
							  </li>
							</ul>
						</div>

						<div id="tcMainGrid"></div>

						<span class="pull-right text-count">Total <span class="text-number">0</span></span>

						<div id="searchGuide" style="clear: both;text-align: center;font-size: 13px;color: #ff0000;">검색 조건을 입력해주세요.</div>
						<!-- <div id="pager">
							<button type="button" id="btnFirst" class="btn"><span class="wj-glyph-step-backward"></span></button>
							<button type="button" id="btnPrev" class="btn"><span class="wj-glyph-left"></span></button>
							&nbsp;&nbsp;&nbsp;<span id="spanCurrent"></span>&nbsp;&nbsp;&nbsp;
							<button type="button" id="btnNext" class="btn"><span class="wj-glyph-right"></span></button>
							<button type="button" id="btnLast" class="btn"><span class="wj-glyph-step-forward"></span></button>
						</div> -->

						<div class="modal-dialog" id="dlgDetail" style="display: none;">
						      <div class="modal-content">
						        <div class="modal-header">
						          <button type="button" class="close wj-hide" aria-hidden="true">
						          &times;</button>
						          <h4 class="modal-title">Edit Item</h4>
						        </div>
						        <div class="modal-body">
						          <dl class="dl-horizontal">
						          <dt>허브명</dt>
						            <dd>
						              <span class="select w100" style="border: none;">
										<select class="form-control" name="useGrpCd" id="modal_useGrpCd">
											<c:choose>
												<c:when test="${loginVO.authorType == 'U' }">
													<c:forEach var="item" items="${useGrpCdList}" varStatus="status">
														<c:if test="${item.useGrpCd == loginVO.authorCd }">
															<option value="<c:out value='${item.useGrpCd}'/>" ><c:out value='${item.useGrpNm}'/></option>
														</c:if>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<c:forEach var="item" items="${useGrpCdList}" varStatus="status">
														<option value="<c:out value='${item.useGrpCd}'/>" ><c:out value='${item.useGrpNm}'/></option>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</select>
						              </span>
						            </dd>
						            <dt>ID</dt>
						            <dd>
						              <input 
						                  class="form-control" 
						                  type="text" 
						                  id="modal_idx"
						                  readonly />
						            </dd>
						            <dt>이름</dt>
						            <dd>
						              <input 
						                  id="modal_usrNm" 
						                  class="form-control"
						                   maxlength="100" 
						                  type="text"  />
						            </dd>
						            <dt>팀</dt>
						            <dd>
						              <input 
						                  id="modal_begCd" 
						                  class="form-control"
						                   maxlength="100" 
						                  type="text" />
						            </dd>
						            <dt>성별</dt>
						            <dd>
						            	<ul class="modal_ul">
							               <li class="w100">
									          <input type="radio" id="SexSecd01" name="sexSecd" value="01">
									          <label for="SexSecd01">남자</label>
									          <input type="radio" id="SexSecd02" name="sexSecd" value="02" >
									          <label for="SexSecd02">여자</label>
									        </li>
								        </ul>
						            </dd>
						            <dt>생년월일</dt>
						            <dd>
						              <input 
						                  class="form-control input_d" 
						                  id="modal_birDt"
						                   maxlength="12"
						                  type="text" />
						            </dd>
						          	<dt>연락처</dt>
						            <dd>
						              <input 
						                  class="form-control" 
						                  id="modal_connTelno"
						                  type="text"
						                  maxlength="13" />
						            </dd>
						            <dt>입사일</dt>
						            <dd>
						              <input 
						                  class="form-control input_d" 
						                  id="modal_entryDt"
						                  type="text" />
						            </dd>
						            <dt>근무일수</dt>
						            <dd>
						              <input 
						                  class="form-control" 
						                  id="modal_dutyDy"
						                  maxlength="50"
						                  type="number" />
						            </dd>
						            <dt>연속근무기간</dt>
						            <dd>
						              <input 
						                  class="form-control" 
						                  id="modal_contDutyDy"
						                  maxlength="10"
						                  type="number" />
						            </dd>
						          	<!-- <dt>고위험구분</dt>
						            <dd>
						            	<ul class="modal_ul">
							               <li class="w100">
									          <input type="radio" id="highDgrCd01" name="highDgrCd" value="21">
									          <label for="highDgrCd01">고위험군</label>
									          <input type="radio" id="highDgrCd02" name="highDgrCd" value="22" >
									          <label for="highDgrCd02">고위험군(예비)</label>
									          <input type="radio" id="highDgrCd03" name="highDgrCd" value="23" >
									          <label for="highDgrCd03">일반관리</label>
									          <input type="radio" id="highDgrCd04" name="highDgrCd" value="24" >
									          <label for="highDgrCd04">정상</label>
								        	</li>
							        	</ul>
						            </dd> -->
						          	</dl>
						        </div>
						        <div class="modal-footer">
						        	<button 
						              type="button" 
						              class="btn btn-primary wj-hide-ok" 
						              style="margin-right:5px;">
						           OK</button>
					        	  <button 
						              type="button" 
						              class="btn btn-warning wj-hide-cancel" >
						            Cancel</button>
						        </div>
						      </div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
<script src="<c:url value='/js/egovframework/whms/needpopup.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/default.js' />" type="text/javascript"></script>
</body>
</html>