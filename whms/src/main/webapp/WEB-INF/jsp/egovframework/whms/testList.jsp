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
<script src="<c:url value='/js/egovframework/whms/wijmo/app.js'/>" type="text/javascript"></script>
<script>
	var tcMainGrid;
	var cvTrackingChanges;
	var dlgDetail;

	var tcEditedGrid;
	var tcAddedGrid;
	//var tcRemovedGrid;

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

	$(document).ready(function() {
		/** wijmo modal 세팅 */
		dlgDetail = new wijmo.input.Popup('#dlgDetail', {
		    removeOnHide: false
		});
	});

	/** Grid setting **/
	onload = function() {

		/** Modal date format */
		var theInputDate = new wijmo.input.InputDate('#theInputDate', {
			valueChanged: function(s, e) {
				setDateTime(s.value);
			}
		});

		function setDateTime(value) {
		    theInputDate.value = value;
		}

		/** Modal number format */
		var theNumber = new wijmo.input.InputNumber('#theNumber', {
		  	valueChanged: function(s, e) {
		    	setNumber(s.value);
		    }
		});

		function setNumber(value) {
			theNumber.value = value;
		}

		createGrid();

		function getData() {

			/** Data Initialize **/
		    var data = [];
		    var idxs = [];
		    var titles = [];
		    var amounts = [];
		    var dates = [];

		    /** Data binding Ajax **/
		    $.ajax({
				type:"POST",
				url:"<c:url value='/whms/testDataAjax.do' />",
				dataType:'json',
				timeout:(1000*60),
				async: false,
				success:function(returnData, status) {
					if(status == "success") {
						if(returnData != null) {
							if(returnData.testList.length != 0) {
								for(var i=0; i<returnData.testList.length; i++) {
									idxs.push(returnData.testList[i].testIdx);
									titles.push(returnData.testList[i].title);
									amounts.push(returnData.testList[i].amount);
									if(returnData.testList[i].date != null) {
										dates.push(returnData.testList[i].date.substring(0,10));
									} else {
										dates.push("");
									}
								}
							}
						}
					} else {
						alert("ERROR!");return;
					} 
				}
			});

			/** Grid data mapping **/
		    for (var i = 0; i < idxs.length; i++) {
		        data.push({
		            idx: idxs[i],
		            date: dates[i],
		            amount: amounts[i],
		            title: titles[i]
		        });
		    }
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

		/** Row delete ajax */
		function rowDelete(item) {
			$.ajax({
				type:"POST",
				url:"<c:url value='/whms/testDeleteAjax.do' />",
				data:{
					"testIdx": item.idx
				},
				dataType:'json',
				timeout:(1000*60),
				success:function(returnData, status) {
					if(status == "success") {
						if(returnData) {
							tcMainGrid.dispose();
							createGrid();
						} else {
							console.log("rowDelete Ajax fail");
						}
					} else {
						console.log("rowDelete Error Occurred");
						return;
					} 
				}
			});
		}

		/** Row insert or edit ajax */
		function rowEdit(item, flag) {
			$.ajax({
				type:"POST",
				url:"<c:url value='/whms/testSaveAjax.do' />",
				data:{
					"flag": flag,
					"testIdx": item.idx,
					"date": item.date,
					"amount": item.amount,
					"title": item.title
				},
				dataType:'json',
				timeout:(1000*60),
				success:function(returnData, status) {
					if(status == "success") {
						if(returnData) {
							tcMainGrid.dispose();
							createGrid();
						} else {
							console.log("rowEdit Ajax fail");
						}
					} else { 
						//alert("ERROR!");
						console.log("rowEdit Error Occurred");
						return;
					}
				}
			});
		}

		/** grid 생성 */
		function createGrid() {
			// create CollectionView with change tracking enabled
			cvTrackingChanges = new wijmo.collections.CollectionView(getData(), {
			    trackChanges: true
			    /* pageSize: 10,
			    pageChanged: updateCurrentPage */
			});

			// create a grid to show and edit the data
			tcMainGrid = new wijmo.grid.FlexGrid('#tcMainGrid', {
			    allowAddNew: true,
			    allowDelete: true,
			    autoGenerateColumns: false,
			    /* onRowEditEnding: function(e) {
			    	var item = null;
			    	var flag = "";
			    	if(cvTrackingChanges.itemsAdded[0] != undefined) {
			    		item = cvTrackingChanges.itemsAdded[0];
			    		flag = "I";
			    	}
			    	if(cvTrackingChanges.itemsEdited[0] != undefined) {
			    		item = cvTrackingChanges.itemsEdited[0];
			    		flag = "U";
			    	}
			    	rowEdit(item, flag);
			    }, */
			    columns: [
			    	{ header: 'Idx', binding: 'idx', width: '1*', isReadOnly: true },
			    	{ header: 'Date', binding: 'date', format:'yyyy-MM-dd', width: '1*', isReadOnly: true },
			    	{ header: 'Amount', binding: 'amount', format: 'n2', width: '1*', isReadOnly: true },
				    { header: 'Title', binding: 'title', width: '2*', isReadOnly: true }
			    ],
			    itemsSource: cvTrackingChanges
			});
	
			// update pager status
			  /* cvTrackingChanges.onPageChanged();
			  function updateCurrentPage() {
			  	var curr = wijmo.format('Page {index:n0} of {cnt:n0}', {
			    	index: cvTrackingChanges.pageIndex + 1,
			      cnt: cvTrackingChanges.pageCount
			    });
			  	document.getElementById('spanCurrent').textContent = curr;
			  }
			  
			  // implement pager
			  document.getElementById('pager').addEventListener('click', function(e) {
					var btn = wijmo.closest(e.target, 'button');
			    var id = btn ? btn.id : '';
			  	switch (id) {
			    	case 'btnFirst':
			    		cvTrackingChanges.moveToFirstPage();
			        break;
			    	case 'btnPrev':
			    		cvTrackingChanges.moveToPreviousPage();
			        break;
			    	case 'btnNext':
			    		cvTrackingChanges.moveToNextPage();
			        break;
			    	case 'btnLast':
			    		cvTrackingChanges.moveToLastPage();
			        break;
			    }
			  }); */

			var theFilter = new wijmo.grid.filter.FlexGridFilter(tcMainGrid);
	
			/** Datepicker 설정 **/
			/* new CustomGridEditor(tcMainGrid, 'date', wijmo.input.InputDate, {
			    format: 'd'
			}); */
			/** Numberpicker 설정 **/
			/* new CustomGridEditor(tcMainGrid, 'amount', wijmo.input.InputNumber, {
			    format: 'n2',
			    step: 1
			}); */

			/** 특정 행에 css 주기 */
			/*  tcMainGrid.rows[0].cssClass = "testClass";
			  setTimeout(() => {
				  $(".testClass").css("background-color", "#ff0000");
				  $(".testClass").css("color", "#ffffff");
			}, 100); */

			// create gridS to show the changes (edits, additions, removals)
			var colDefs = [
			    { header: 'Idx', binding: 'idx', width: '1*', isReadOnly: true },
			    { header: 'Date', binding: 'date', format: 'd', width: '1*' },
			    { header: 'Amount', binding: 'amount', format: 'n2', width: '1*' },
			    { header: 'Title', binding: 'title', width: '2*' }
			];
			tcEditedGrid = new wijmo.grid.FlexGrid('#tcEditedGrid', {
			    isReadOnly: true,
			    autoGenerateColumns: false,
			    columns: colDefs,
			    itemsSource: cvTrackingChanges.itemsEdited
			});
			tcAddedGrid = new wijmo.grid.FlexGrid('#tcAddedGrid', {
			    isReadOnly: true,
			    autoGenerateColumns: false,
			    columns: colDefs,
			    itemsSource: cvTrackingChanges.itemsAdded
			});
			/* tcRemovedGrid = new wijmo.grid.FlexGrid('#tcRemovedGrid', {
			    isReadOnly: true,
			    autoGenerateColumns: false,
			    columns: colDefs,
			    itemsSource: cvTrackingChanges.itemsRemoved
			}); */
		}

		document.getElementById('btnAdd').addEventListener('click', function () {
			//var editedItem = cvTrackingChanges.addNew();
			$("#modal_type").val("I");
		    showDialog(null, 'Add Item');
		});

		document.getElementById('btnEdit').addEventListener('click', function () {
		    var editItem = cvTrackingChanges.currentItem;
		    cvTrackingChanges.editItem(editItem);
		    $("#modal_type").val("U");
		    showDialog(editItem, 'Edit Item');
		});

		document.getElementById('btnDelete').addEventListener('click', function () {
			if(cvTrackingChanges.currentItem.idx != undefined) {
				if(confirm("삭제하시겠습니까?")) {
					rowDelete(cvTrackingChanges.currentItem);
					//cvTrackingChanges.remove(cvTrackingChanges.currentItem);
				}
			} else {
				cvTrackingChanges.remove(cvTrackingChanges.currentItem);
			}
		});

		/** wijmo modal script */
		function showDialog(item, title) {

		    // update dialog inputs
		    if(item == null) {
		    	setInputValue('modal_idx', '');
		    	setDateTime(wijmo.Globalize.format(new Date()));
		    	setNumber(0);
		    	setInputValue('modal_title', '');
		    } else {
		    	setInputValue('modal_idx', item.idx != null ? item.idx : '');
		    	setDateTime(wijmo.Globalize.format(item.date));
		    	setNumber(item.amount == null || item.amount == "" ? 0 : item.amount);
		    	setInputValue('modal_title', item.title != null ? item.title : '');
		    }
		    title.innerHTML = title;

		    // show dialog
		    dlgDetail.show(true, function (s) {
		        if (s.dialogResult == 'wj-hide-ok') {
		            var item = makeItem();
		        	rowEdit(item, $("#modal_type").val());
		        } else {
		            // cancel changes
		            cvTrackingChanges.cancelEdit();
		            cvTrackingChanges.cancelNew();
		        }
		    });
		}

		/** modal data object화 */
		function makeItem() {
			var item = new Object();
			item.idx = $("#modal_idx").val();
			item.date = wijmo.Globalize.format(theInputDate.value, "yyyy-MM-dd");
			item.amount = theNumber.value;
			item.title = $("#modal_title").val();
			return item;
		}

	}
	
</script>
<script src="<c:url value='/js/egovframework/whms/wijmo/customGridEditor.js'/>" type="text/javascript"></script>
</head>
<body id="tbody">
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
					<form name="listForm" action="<c:url value='/whms/testList.do'/>" method="post">
						<input name="flag" type="hidden" value="L"/>
						<h3 class="text-left">List Example</h3>
						<div class="row-fluid well text-right">
						    <button type="button" id="btnAdd" class="btn btn-default btn_grid">
		                        Add
		                    </button>
		                    <button type="button" class="btn btn-default btn_grid" id="btnEdit">
								Edit
							</button>
						    <button class="btn btn-default btn_grid" type="button" id="btnDelete">
						        Delete
						    </button>
						</div>
						<div id="tcMainGrid"></div>
						<div id="tcEditedGrid" class="tcGrid" style="display: none;"></div>
						<div id="tcAddedGrid" class="tcGrid" style="display: none;"></div>

						<div class="modal-dialog" id="dlgDetail" style="display: none;">
						      <div class="modal-content">
						        <div class="modal-header">
						          <button type="button" class="close wj-hide" aria-hidden="true">
						          &times;</button>
						          <h4 class="modal-title">Edit Item</h4>
						        </div>
						        <div class="modal-body">
						          <dl class="dl-horizontal">
						            <dt>Idx</dt>
						            <dd>
						              <input 
						                  class="form-control" 
						                  type="text" 
						                  id="modal_idx"
						                  readonly />
						            </dd>
						            <dt>Date</dt>
						            <dd>
						              <input 
						                  formatted-model 
						                  class="form-control date"
						                  id="theInputDate" 
						                  type="text" 
						                  ng-model="currentItem.date" />
						            </dd>
						            <dt>Amount</dt>
						            <dd>
						              <input 
					              		  formatted-model
						                  class="form-control"
						                  id="theNumber" 
						                  type="text" 
						                  ng-model="currentItem.amount" />
						            </dd>
						            <dt>Title</dt>
						            <dd>
						              <input 
						                  class="form-control" 
						                  id="modal_title"
						                  type="text" 
						                  ng-model="currentItem.title" />
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
				
						<!-- <h5>See the changes here</h5>
						<h6>Items edited:</h6>
						<div id="tcEditedGrid" class="tcGrid" style="height:100px"></div>
						<h6>Items added:</h6>
						<div id="tcAddedGrid" class="tcGrid" style="height:100px"></div>
						<h6>Items removed:</h6>
						<div id="tcRemovedGrid" class="tcGrid" style="height:100px"></div> -->
						<%-- <br>
						<table class="board_list" summary="<spring:message code="common.summary.list" />">
							<thead>
								<tr>
									<th>Idx</th>
									<th>Title</th>
									<th>Content</th>
								</th>
							</thead>
							<tbody class="ov">
							<c:if test="${fn:length(testList) == 0}">
								<tr>
									<td colspan="3"><spring:message code="common.nodata.msg" /></td>
								</tr>
							</c:if>
							<c:forEach var="test" items="${testList}" varStatus="status">
								<tr onClick="fnDetail('${test.testIdx}')" style="cursor:pointer;">
									<td><c:out value="${test.testIdx}" /></td>
									<td><c:out value="${test.title}" /></td>
									<td><c:out value="${fn:substring(test.frstRegistPnttm,0,10)}" /></td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
						<!-- paging navigation -->
						<div class="pagination">
							<ul><ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnLinkPage"/></ul>
						</div>
						<div class="btn" style="text-align:center;">
							<button class="btn_s2" onClick="fnInsert();" >등록</button>
						</div> --%>
					</form>
				</div>
			</div>
		</div>
	</div>
<script src="<c:url value='/js/egovframework/whms/needpopup.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/default.js' />" type="text/javascript"></script>
</body>
</html>