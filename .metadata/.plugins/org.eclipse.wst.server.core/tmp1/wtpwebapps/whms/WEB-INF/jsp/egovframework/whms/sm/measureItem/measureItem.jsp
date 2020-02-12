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
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/style.css' />" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/reset.css' />" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/animate.css' />" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/jquery-ui.min.css' />" type="text/css" />

<script src="<c:url value='/js/egovframework/whms/wijmo/vendor/wijmo.min.js'/>" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/wijmo/vendor/wijmo.grid.min.js'/>" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/wijmo/vendor/wijmo.chart.min.js'/>" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/wijmo/vendor/wijmo.input.min.js'/>" type="text/javascript"></script>

<script src="<c:url value='/js/egovframework/whms/jquery-1.11.3.min.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/jquery-ui.min.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/front-ui.js' />" type="text/javascript"></script>
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

	$( function() {
	    $( ".input_d" ).datepicker({
	    	changeMonth: true,
	        changeYear: true,
	        dateFormat: 'yy-mm-dd'
	    });
	} );

/* 	$( function() {
	    $( ".date_select" ).datepicker({
	    	changeMonth: true,
	        changeYear: true,
	        dateFormat: 'yy-mm-dd',
			showOn: "button",
			buttonImage: "<c:url value='/images/egovframework/whms/icon_calendar.png' />",
			buttonImageOnly: true,
			buttonText: "Select date"
	    });
	} );
 */
 
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
		$("#detailForm").submit();
	}

	/** Grid setting **/
	/*
	onload = function() {
		<c:choose>
			<c:when test="${not empty detailVO }">
				//generate some random data
				var appData = [];
				var xAxis = [];
	
				<c:forEach var="date" items="${detailVO.monthList}" varStatus="status">
					xAxis.push("<c:out value='${date.monthVal}'/>");
					 appData.push({
				    	 xAxis: "<c:out value='${date.monthVal}'/>"+"월",
				         hypctCt: parseFloat("<c:out value='${date.avgHypctCt}'/>"),
				         hyprxCt: parseFloat("<c:out value='${date.avgHyprxCt}'/>")
				     });
				</c:forEach>
	
				 // create FlexChart
				 var gettingStartedChart = new wijmo.chart.FlexChart('#chartDiv');
		
				 // initialize FlexChart's properties
				 gettingStartedChart.initialize({
				   itemsSource: appData,
				   bindingX: 'xAxis',
				   series: [
				     { name: '수축', binding: 'hypctCt' },
				     { name: '이완', binding: 'hyprxCt' }
				   ]
				 });
		
				 gettingStartedChart.legend.position = 0;
				 gettingStartedChart.chartType = 4;
			 </c:when>
			 <c:otherwise>
			//generate some random data
				var appData = [];
				var xAxis = [];
	
				<c:forEach var="date" items="${monthList}" varStatus="status">
					xAxis.push("<c:out value='${date.monthVal}'/>");
					 appData.push({
				    	 xAxis: "<c:out value='${date.monthVal}'/>"+"월",
				         hypctCt: parseFloat("<c:out value='${date.avgHypctCt}'/>"),
				         hyprxCt: parseFloat("<c:out value='${date.avgHyprxCt}'/>")
				     });
				</c:forEach>
	
				 // create FlexChart
				 var gettingStartedChart = new wijmo.chart.FlexChart('#chartDiv');
		
				 // initialize FlexChart's properties
				 gettingStartedChart.initialize({
				   itemsSource: appData,
				   bindingX: 'xAxis',
				   series: [
				     { name: '수축', binding: 'hypctCt' },
				     { name: '이완', binding: 'hyprxCt' }
				   ]
				 });
		
				 gettingStartedChart.legend.position = 0;
				 gettingStartedChart.chartType = 4;
			 </c:otherwise>
		 </c:choose>

 	}
 */
	$(document).ready(function() {
		/** Enter 처리 */
	    $("input[name=searchKeyword]").keydown(function(key) {
			if (key.keyCode == 13) {
				searchData();
			}
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
        <!-- navi -->
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
        <!-- // navi --> 
      </div>
      <!-- // left_area -->
      
      <div class="right_area"> 
        <div class="summary_tit">
          <h3>측정항목별 회원통계</h3>
        </div>
        <div class="stat_search"> 
          <ul>
            <li class="tit_area">교육강사</li>
            <li class="cont_area">
              <div class="select w100p">
              <select name="" >
                <option value=""selected>전체</option>
                <option value="">aaa</option>
                <option value="">bbb</option>
                <option value="">ccc</option>
              </select>
              </div>
            </li>
          </ul>
          <ul>
            <li class="tit_area">기간선택</li>
            <li class="cont_area">
              <div class="datebox">
              <input id="popModal_ex1" name="txtInfo" type="text" title="" class="input_d" accesskey="S" value=""  placeholder="" readonly />
              </div>
              <span class="txt">~</span>
              <div class="datebox">
              <input id="popModal_ex2" name="txtInfo" type="text" title="" class="input_d" accesskey="S" value=""  placeholder="" readonly />
              </div>
              <button class="btn-type btn_ico gray_line" onClick="">당일</button>
              <button class="btn-type btn_ico gray_line" onClick="">3일</button>
              <button class="btn-type btn_ico gray_line" onClick="">일주일</button>
              <button class="btn-type btn_ico gray_line" onClick="">한달</button>
            </li>
          </ul>
          <div class="btn_area"><button type="button" class="btn-type btn_ico black" onClick=""><span class="i_search_black">조회</span></button></div>
        </div>
        
        <div class="stat_tab">
          <ul>
            <li><a href="#stab1">요약</a></li>
            <li><a href="#stab2">성별</a></li>
            <li><a href="#stab3">연령별</a></li>
            <li><a href="#stab4">지역별</a></li>
            <li><a href="#stab5">직업별</a></li>
            <li><a href="#stab6">측정건수</a></li>
          </ul>
        </div>
        
        <div id="stab1" class="stat_content">
          <img src="<c:url value='/images/egovframework/whms/graph_sample2.jpg' />" alt="" />
        </div>
        <div id="stab2" class="stat_content">
          <img src="<c:url value='/images/egovframework/whms/graph_sample1.jpg' />" alt="" />
        </div>
        <div id="stab3" class="stat_content">
          <img src="<c:url value='/images/egovframework/whms/graph_sample2.jpg' />" alt="" />
        </div>
        <div id="stab4" class="stat_content">
          <img src="<c:url value='/images/egovframework/whms/graph_sample1.jpg' />" alt="" />
        </div>
        <div id="stab5" class="stat_content">
          <img src="<c:url value='/images/egovframework/whms/graph_sample2.jpg' />" alt="" />
        </div>
        <div id="stab6" class="stat_content">
          <img src="<c:url value='/images/egovframework/whms/graph_sample1.jpg' />" alt="" />
        </div>
        
       
       
       <div class="talk_sty1 right"><h3>각종통계 현황 : 연령별, 성별, 고위험군별 측정 데이타</h3></div>
        
        
       
      </div>
      <!-- // right_area --> 
      
    </div>
    <!-- // subcont --> 
    
  </div>
  <!-- // swrap -->
  
</div>
<!-- // subcontainer -->

<!-- calendar popup -->
<div style="display:none">
<div id="content1">
	<div class="ca_box">
        <div class="cdate">
          <a href="#"><img src="<c:url value='/images/egovframework/whms/arr_l.png' />" alt="" /></a>2018년 5월
          <a href="#"><img src="<c:url value='/images/egovframework/whms/arr_r.png' />" alt="" /></a>
        </div>
        
        <!-- calendar-tbl -->
        <table class="calendar-tbl">
          <caption>
          calendar-tbl
          </caption>
          <colgroup>
          <col width="14.2%">
          <col width="14.2%">
          <col width="14.2%">
          <col width="14.2%">
          <col width="14.2%">
          <col width="14.2%">
          <col width="auto">
          </colgroup>
          <thead>
            <tr>
              <th scope="col"><span class="red">일</span></th>
              <th scope="col">월</th>
              <th scope="col">화</th>
              <th scope="col">수</th>
              <th scope="col">목</th>
              <th scope="col">금</th>
              <th scope="col"><span class="blue01">토</span></th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td></td>
              <td></td>
              <td></td>
              <td>1</td>
              <td>2</td>
              <td>3</td>
              <td>4</td>
            </tr>
            <tr>
              <td>5</td>
              <td>6</td>
              <td>7</td>
              <td>8</td>
              <td>9</td>
              <td>10</td>
              <td>11</td>
            </tr>
            <tr>
              <td>12</td>
              <td>13</td>
              <td>14</td>
              <td>15</td>
              <td>16</td>
              <td>17</td>
              <td>18</td>
            </tr>
            <tr>
              <td>19</td>
              <td>20</td>
              <td>21</td>
              <td>22</td>
              <td>23</td>
              <td>24</td>
              <td>25</td>
            </tr>
            <tr>
              <td>26</td>
              <td>27</td>
              <td>28</td>
              <td>29</td>
              <td>30</td>
              <td>31</td>
              <td></td>
            </tr>
          </tbody>
        </table>
        <!-- // calendar-tbl -->       
        <div class="popModal_footer"><button type="button" class="btn-type pop01 default" data-popmodal-but="ok">ok</button></div>
    </div>
	
</div>
</div>
<script src="<c:url value='/js/egovframework/whms/popModal.js' />"></script>
<script>
$(function(){
	$('#popModal_ex1').click(function(){
		$('#popModal_ex1').popModal({
			html : $('#content1'),
			placement : 'bottomRight',
			showCloseBut : false,
			onDocumentClickClose : false,
			onDocumentClickClosePrevent : '',
			overflowContent : false,
			inline : false,
			asMenu : false,
			beforeLoadingContent : 'Please, wait...',
			onOkBut : function() {},
			onCancelBut : function() {},
			onLoad : function() {},
			onClose : function() {}
		});
		
	});

   $('#popModal_ex2').click(function(){
    $('#popModal_ex2').popModal({
        html : $('#content1'),
        placement : 'bottomRight',
        showCloseBut : false,
			onDocumentClickClose : false,
			onDocumentClickClosePrevent : '',
			overflowContent : false,
			inline : false,
			asMenu : false,
			beforeLoadingContent : 'Please, wait...',
			onOkBut : function() {},
			onCancelBut : function() {},
			onLoad : function() {},
			onClose : function() {}
  });
 });
 
 
});
</script>

<!-- // calendar popup -->

<div class="btn_up_layer"></div>
<script src="<c:url value='/js/egovframework/whms/needpopup.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/default.js' />" type="text/javascript"></script>
</body>
</html>