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

<script src="<c:url value='/js/egovframework/whms/jquery-1.11.3.min.js' />" type="text/javascript"></script>
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
		{ header: '선택', binding: "check", width: 60 },
		{ header: 'No', binding: "no", width: 60 },
    	{ header: '허브코드', binding: 'useGrpCd', width: "1*", isReadOnly: true },
    	{ header: '허브명', binding: 'useGrpNm', width: "1*", isReadOnly: true },
    	{ header: '이름', binding: 'usrNm', width: "1*", isReadOnly: true },
    	{ header: 'ID', binding: 'usrId', width: "1*", isReadOnly: true },
    	{ header: '성별', binding: 'sexSecd', width: "1*", isReadOnly: true },
	    { header: '생년월일', binding: 'birDt', width: "1*", isReadOnly: true },
    	{ header: '연락처', binding: 'connTelno', width: "1*", isReadOnly: true }
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

	/** Grid setting **/
	onload = function() {

		/** Enter 처리 */
	    $("input[name=searchValue]").keydown(function(key) {
			if (key.keyCode == 13) {
				searchData();
			}
		});

		createGrid();

		/** grid data mapping script */
		function getData() {

			var condition = $("select[name=searchCondition]").val();
			var value = $("input[name=searchValue]").val();

			/** Data Initialize **/
		    var data = [];
			var searchCondition = condition == undefined ? null : condition;
			var searchKeyword = value == undefined ? null : value;

		    /** Data binding Ajax **/
		    $.ajax({
				type:"POST",
				url:"<c:url value='/whms/sys/hubManageDataAjax.do' />",
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
							            useGrpNm: result.useGrpNm,
							            useGrpCd: result.useGrpCd,
							            usrId: result.usrId,
							            usrNm: result.usrNm,
							            sexSecd: result.sexSecd == null ? "" : result.sexSecd == "01" ? "남자" : "여자",
										birDt: result.birDt,
										connTelno: result.connTelno,
					            		check: false
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

		/** Row insert or edit ajax */
		function rowEdit(item, flag) {
			$.ajax({
				type:"POST",
				url:"<c:url value='/whms/sys/hubManageSaveAjax.do' />",
				data:{
					"usrIds": $("input[name=usrIds]").val(),
					"useGrpCd" : item
				},
				dataType:'json',
				timeout:(1000*60),
				success:function(returnData, status) {
					if(returnData.result) {
						alert("수정이 완료되었습니다.");
						tcMainGrid.dispose();
						createGrid();
					} else {
						console.log("rowEdit Ajax fail");
						alert(returnData.errorMsg);
					}
				}
			});
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

		/** 수정 버튼 event */
		document.getElementById('btnEdit').addEventListener('click', function () {

			// 초기화
			$("input[name=usrIds]").val("");

			var editItem = null;
			var cnt = 0;
			var usrIds = "";
			for(var i=0; i<tcMainGrid.rows.length; i++) {
				if(tcMainGrid.rows[i]._data.check) {
					editItem = tcMainGrid.rows[i]._data;
					usrIds = usrIds.concat(editItem.usrId).concat(",");
					cnt++;
				}
			}

			if(cnt == 0) {
				alert("수정할 사용자가 없습니다.");
				return;
			}

			if("" != usrIds) {
				usrIds = usrIds.substring(0, usrIds.length-1);
			}

			$("input[name=usrIds]").val(usrIds);

		    $("#modal_type").val("U");
		    showDialog(editItem, '허브 수정');
		});

		/** wijmo modal script */
		function showDialog(item, title) {

		    // update dialog inputs
		    $("select[name=useGrpCd] option").eq(0).attr("selected", true);
		    $(".modal-title").text(title);

		    // show dialog
		    dlgDetail.show(true, function (s) {
		        if (s.dialogResult == 'wj-hide-ok') {
		        	rowEdit($("#modal_useGrpCd").val(), $("#modal_type").val());
		        } else {
		        }
		    });
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
						<input name="usrIds" type="hidden" value=""/>

						<div class="search_tb">
							<div class="stb_left">
								<span class="select w100p">
									<select name="searchCondition" id="searchCondition">
									  <option value="USR_NM" <c:if test="${empty searchVO.searchCondition || searchVO.searchCondition == 'USR_NM' }">selected</c:if>>이름</option>
									  <option value="USE_GRP_NM" <c:if test="${searchVO.searchCondition == 'USE_GRP_NM' }">selected</c:if>>허브명</option>
									</select>
								</span>
								<span class="input w250p">
									<input type="text" placeholder="" name="searchValue" id="searchValue" value="<c:out value='${searchVO.searchKeyword }'/>" style="width:100%"/>
									<input type="text" style="display: none;" />
								</span>
								<button type="button" class="btn-type btn_ico gray_line" id="btnSearch"><span class="i_search_bg">조회</span></button>
							</div>
							<div class="stb_right">
								<button type="button" class="btn-type btn_ico gray_line" id="btnEdit"><span class="i_mwrite_bg">수정</span></button>
							</div>
						</div>

						<div id="tcMainGrid"></div>

						<span class="pull-right text-count">Total <span class="text-number">0</span></span>
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
						          <h4 class="modal-title">허브 수정</h4>
						        </div>
						        <div class="modal-body">
						          <dl class="dl-horizontal">
						            <dt>허브 선택</dt>
						            <dd>
						            	<span class="select w100" style="border: none;">
						            		<select class="form-control" name="useGrpCd" id="modal_useGrpCd">
												<c:forEach var="item" items="${useGrpCdList}" varStatus="status">
													<option value="<c:out value='${item.useGrpCd}'/>" ><c:out value='${item.useGrpNm}'/></option>
												</c:forEach>
											</select>
										</span>
						            </dd>
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