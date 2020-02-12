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
<META name="viewport" content="user-scalable=no, width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta name="description" content="Worker Health Management System">
<meta name="keywords" content="Worker Health Management System">
<title>Worker Health Management System</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/whms/hi/qslt/reset.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/whms/hi/qslt/style.css' />">
<!-- <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/com.css' />"> -->
</head>
<body>
<header id="header" class="gradient_bg">
 <h1>WHMS</h1>
</header>

<!-- @@@@ join_wrap @@@@ -->
<form name="registForm" id="registForm" action="<c:url value='/whms/hi/qsltRegistAjax.do'/>" method="post">
	<!--  <input name="UseGrpCd" type="hidden" value="<c:out value='${UseGrpCd}'/>"/>  -->
	<input name="UsrId" type="hidden" value="<c:out value='${UsrId}'/>"/>
	<input name="EmpTmpId" type="hidden" value="<c:out value='${EmpTmpId}'/>"/>
	<input name="flag" type="hidden" value="R"/>
	<input name="UseYn" type="hidden" value="Y"/>
	<input name="ActionMode" type="hidden" value="<c:out value='${ActionMode}'/>"/>
<div id="form_wrap">
 <div class="form_tit">신규 채용 건강 문진표</div>
 <div class="title">인적사항</div>
 <div class="whitebox_p15">    
    <div class="project_m_reg">
	<ul>
		<h2>허브명</h2>
		<li class="w100">
			<span class="select" style="margin:0; width:30%;">
				<select name="UseGrpCd">
					<option value="">선택해주세요</option>
					<c:forEach var="item" items="${useGrpCdList}" varStatus="status">
						<option value="<c:out value='${item.useGrpCd}'/>"><c:out value='${item.useGrpNm}'/></option>
					</c:forEach>
				</select>
			</span>
		</li>
	</ul>
      <ul>
        <h2>성명</h2>
        <li class="w100"><input type="text" name="UsrNm" id="UsrNm" maxlength="100" value="" placeholder="" class="w100" /></li>
      </ul>
      <ul>
        <h2>성별</h2>
        <li class="w100">
          <input type="radio" id="SexSecd01" name="SexSecd" value="01" checked>
          <label for="SexSecd01">남</label>
          <input type="radio" id="SexSecd02" name="SexSecd" value="02" >
          <label for="SexSecd02">여</label>
        </li>
      </ul>
      <ul>
        <h2>연령</h2>
        <li class="w100"><input type="number" name="UsrAge" id="UsrAge" maxlength="3" oninput="maxLengthCheck(this)" value="" placeholder="" class="w30" /><span class="txt_gr">세</span></li>
      </ul>
      <ul>
        <h2>물류업무경력</h2>
        <li class="w100"><input type="number" name="JobCareerYear" id="JobCareerYear" maxlength="2" oninput="maxLengthCheck(this)" value="" placeholder="" class="w30" /><span class="txt_gr">년</span><input type="number" name="JobCareerMonth" id="JobCareerMonth" maxlength="2" oninput="maxLengthCheck(this)" value="" placeholder="" class="w30" /><span class="txt_gr">개월</span></li>
      </ul>
      <ul>
        <h2>혈액형</h2>
        <li class="w100">
          <input type="radio" id="b01" name="BldtyCd" value="01" checked>
          <label for="b01">A</label>
          <input type="radio" id="b02" name="BldtyCd" value="02" >
          <label for="b02">B</label>
          <input type="radio" id="b03" name="BldtyCd" value="03" >
          <label for="b03">O</label>
          <input type="radio" id="b04" name="BldtyCd" value="04" >
          <label for="b04">AB</label>
        </li>
      </ul>
      
      <ul>
        <h2>키/몸무게</h2>
        <li class="w100"><input type="number" name="UsrHet" id="UsrHet" value="" placeholder="" class="w30" /><span class="txt_gr">cm</span><input type="number" name="UsrWet" id="UsrWet" value="" placeholder="" class="w30" /><span class="txt_gr">kg</span></li>
      </ul>
    </div>    
    <!-- // project_m_reg -->
 </div><!-- // whitebox_p15 -->
 
 <div class="title mt20">가족력 &amp; 생활습관</div>
 <div class="whitebox_p15">    
    <div class="project_m_reg">
      <ul>
        <h3>부모, 형제 등 가족 중에 다음과 같은 질환으로 사망 또는 앓고 있는 질환이 있습니까?</h3>
        <div class="gbox">
           <div class="chkbox">
            <input type="checkbox" id="Fahs1Yn" name="Fahs1Yn" value="Y" onClick="fn_check_fahs()">
            <label for="Fahs1Yn">고혈압</label>
            <input type="checkbox" id="Fahs2Yn" name="Fahs2Yn" value="Y" onClick="fn_check_fahs()">
            <label for="Fahs2Yn">당뇨병</label>
            <input type="checkbox" id="Fahs3Yn" name="Fahs3Yn" value="Y" onClick="fn_check_fahs()">
            <label for="Fahs3Yn">뇌졸증</label>
           </div>
           <div class="chkbox">
            <input type="checkbox" id="Fahs4Yn" name="Fahs4Yn" value="Y" onClick="fn_check_fahs()">
            <label for="Fahs4Yn">심장병</label>
            <input type="checkbox" id="Fahs5Yn" name="Fahs5Yn" value="Y" onClick="fn_check_fahs()">
            <label for="Fahs5Yn">심근경색증</label>
           </div>
           <div class="chkbox">
            <input type="checkbox" id="Fahs6Yn" name="Fahs6Yn" value="Y" onClick="fn_check_fahs()">
            <label for="Fahs6Yn">기타</label>
            <input type="text" name="FahsEtc" id="FahsEtc" value="" maxlength="100" placeholder="" class="w70" />
           </div>
           <div class="chkbox">
            <input type="checkbox" id="FahsYn" name="FahsYn" value="Y" onClick="fn_check_fahs()">
            <label for="FahsYn">해당사항 없음</label>
           </div>
        </div>
        
      </ul>
      
      <ul>
        <h3>생활습관</h3>
        <div class="gbox">
          <ul class="txtbox_wrap">
            <li class="txtbox_l50">술</li>
            <li class="txtbox_right">
              <div class="chkbox">
               <input type="radio" id="AlcYn_n" name="AlcYn" checked value="N" onClick="toggleAlc()">
               <label for="AlcYn_n">술을 마시지 않는다.</label>
              </div>
              <div class="chkbox">
               <input type="radio" id="AlcYn_y" name="AlcYn" value="Y" onClick="toggleAlc()">
               <label for="AlcYn_y">술을 마신다.</label>
              </div>
              <div class="chkbox">
                <span class="txt_gr">일주일</span><input type="number" name="WekAlcCt" id="WekAlcCt" value="" placeholder="" class="w20" /><span class="txt_gr">회</span>
                <span class="txt_gr">1회</span><input type="number" name="AdrkCt" id="AdrkCt" value="" placeholder="" class="w20" /><span class="txt_gr">잔</span>
              </div>
            </li>
          </ul>
        </div>
        
        <div class="gbox mt10">
          <ul class="txtbox_wrap">
            <li class="txtbox_l50">담배</li>
            <li class="txtbox_right">
              <div class="chkbox">
               <input type="radio" id="SmkYn_n" name="SmkYn" checked value="N" onClick="toggleSmk()">
               <label for="SmkYn_n">담배를 피우지 않는다.</label>
              </div>
              <div class="chkbox">
               <input type="radio" id="SmkYn_y" name="SmkYn" value="Y" onClick="toggleSmk()">
               <label for="SmkYn_y">담배를 피운다.</label>
              </div>
              <div class="chkbox">
                <span class="txt_gr">하루</span><input type="number" name="DysmkCt" id="DysmkCt" value="" placeholder="" class="w20" /><span class="txt_gr">갑</span>
              </div>
            </li>
          </ul>
        </div>
        
        
        
      </ul>
     
    </div>    
    <!-- // project_m_reg -->
 </div><!-- // whitebox_p15 -->
 
 <div class="title mt20">일반증상</div>
 <div class="whitebox_p15">    
    <div class="project_m_reg">
      <ul>
        <h3>의사로부터 다음과 같은 질병에 대해 진단 받은 적이나 복용하는 약이 있습니까?</h3>
        <div class="gbox">
           <div class="chkbox">
            <input type="checkbox" id="Havdis1Yn" name="Havdis1Yn" value="Y" onClick="fn_check_havdis()">
            <label for="Havdis1Yn">고혈압(약 복용중)</label>
            <input type="checkbox" id="Havdis8Yn" name="Havdis8Yn" value="Y" onClick="fn_check_havdis()">
            <label for="Havdis8Yn">고혈압(약 미복용)</label>
            <input type="checkbox" id="Havdis2Yn" name="Havdis2Yn" value="Y" onClick="fn_check_havdis()">
            <label for="Havdis2Yn">당뇨병</label>
           </div>
           <div class="chkbox">
           <input type="checkbox" id="Havdis3Yn" name="Havdis3Yn" value="Y" onClick="fn_check_havdis()">
            <label for="Havdis3Yn">고지혈증</label>
            <input type="checkbox" id="Havdis4Yn" name="Havdis4Yn" value="Y" onClick="fn_check_havdis()">
            <label for="Havdis4Yn">천식</label>
            <input type="checkbox" id="Havdis5Yn" name="Havdis5Yn" value="Y" onClick="fn_check_havdis()">
            <label for="Havdis5Yn">뇌전증(간질)</label>
            <input type="checkbox" id="Havdis6Yn" name="Havdis6Yn" value="Y" onClick="fn_check_havdis()">
            <label for="Havdis6Yn">통풍</label>
           </div>
           <div class="chkbox">
            <input type="checkbox" id="Havdis7Yn" name="Havdis7Yn" value="Y" onClick="fn_check_havdis()">
            <label for="Havdis7Yn">기타</label>
            <input type="text" name="HavdisEtc" id="HavdisEtc" maxlength="100" value="" placeholder="" class="w70" />
           </div>
           <div class="chkbox">
            <input type="checkbox" id="HavdisYn" name="HavdisYn" value="Y" onClick="fn_check_havdis()">
            <label for="HavdisYn">해당사항 없음</label>
           </div>
           <p>기타 질환의 예<br>
(뇌경색, 뇌졸증, 심근경색, 스텐트시술, 간염보균자, 디스크, 암, 결핵 등)</p>
        </div>
        
      </ul>
      
      <ul>
        <h3>과거에 운동 혹은 사고로(교통사고, 넘어짐, 추락 등)인해 다친 적이 있습니까?</h3>
        <div class="gbox">
          <div class="chkbox">
            <input type="radio" id="MoaciYn_y" name="MoaciYn" value="Y" onClick="toggleMoaci()">
            <label for="MoaciYn_y">예</label>
            <input type="radio" id="MoaciYn_n" name="MoaciYn" checked value="N" onClick="toggleMoaci()">
            <label for="MoaciYn_n">아니오</label>
           </div>
        </div>

        <div class="gbox mt10">
          <div class="txt14">'예'인 경우 상해부위는?</div>
          <div class="chkbox">
            <input type="checkbox" id="Moaci1Yn" name="Moaci1Yn" value="Y">
            <label for="Moaci1Yn">목</label>
            <input type="checkbox" id="Moaci2Yn" name="Moaci2Yn" value="Y">
            <label for="Moaci2Yn">어깨</label>
            <input type="checkbox" id="Moaci3Yn" name="Moaci3Yn" value="Y">
            <label for="Moaci3Yn">팔/팔꿈치</label>
            <input type="checkbox" id="Moaci4Yn" name="Moaci4Yn" value="Y">
            <label for="Moaci4Yn">허리</label>
           </div>
           <div class="chkbox">
            <input type="checkbox" id="Moaci5Yn" name="Moaci5Yn" value="Y">
            <label for="Moaci5Yn">손/손목/손가락</label>
            <input type="checkbox" id="Moaci6Yn" name="Moaci6Yn" value="Y">
            <label for="Moaci6Yn">다리/발목/발</label>
            <input type="checkbox" id="Moaci7Yn" name="Moaci7Yn" value="Y">
            <label for="Moaci7Yn">기타</label>
           </div>
        </div>
      </ul>
      
      <ul>
        <h3>작업과 관련하여 통증이나 불편함을 느낀 적이 있습니까?</h3>
        <div class="gbox">
          <div class="chkbox">
            <input type="radio" id="WkpnYn_y" name="WkpnYn" value="Y" onClick="toggleWkpn()">
            <label for="WkpnYn_y">예</label>
            <input type="radio" id="WkpnYn_n" name="WkpnYn" checked value="N" onClick="toggleWkpn()">
            <label for="WkpnYn_n">아니오</label>
           </div>
        </div>
        
        <div class="gbox mt10">
          <div class="txt14">'예'인 경우 상해부위는?</div>
          <div class="chkbox">
            <input type="checkbox" id="Wkpn1Yn" name="Wkpn1Yn" value="Y">
            <label for="Wkpn1Yn">목</label>
            <input type="checkbox" id="Wkpn2Yn" name="Wkpn2Yn" value="Y">
            <label for="Wkpn2Yn">어깨</label>
            <input type="checkbox" id="Wkpn3Yn" name="Wkpn3Yn" value="Y">
            <label for="Wkpn3Yn">팔/팔꿈치</label>
            <input type="checkbox" id="Wkpn4Yn" name="Wkpn4Yn" value="Y">
            <label for="Wkpn4Yn">허리</label>
           </div>
           <div class="chkbox">
            <input type="checkbox" id="Wkpn5Yn" name="Wkpn5Yn" value="Y">
            <label for="Wkpn5Yn">손/손목/손가락</label>
            <input type="checkbox" id="Wkpn6Yn" name="Wkpn6Yn" value="Y">
            <label for="Wkpn6Yn">다리/발목/발</label>
            <input type="checkbox" id="Wkpn7Yn" name="Wkpn7Yn" value="Y">
            <label for="Wkpn7Yn">기타</label>
           </div>
        </div>
      </ul>
      
      <ul>
        <h3>아래와 같은 증상을 느낀 적이 있습니까?</h3>
        <div class="gbox">
          <div class="txt14">호흡기계 증상</div>
          <div class="chkbox">
            <input type="checkbox" id="Repsym1Yn" name="Repsym1Yn" value="Y" onClick="fn_check_repsym()">
            <label for="Repsym1Yn">호흡곤란이 있다.</label>
          </div>
          <div class="chkbox">
            <input type="checkbox" id="Repsym2Yn" name="Repsym2Yn" value="Y" onClick="fn_check_repsym()">
            <label for="Repsym2Yn">열, 인후통, 콧물, 기침, 두통이 있다.</label>
          </div>
          <div class="chkbox">
            <input type="checkbox" id="Repsym3Yn" name="Repsym3Yn" value="Y" onClick="fn_check_repsym()">
            <label for="Repsym3Yn">기침과 가래가 많다.</label>
          </div>
          <div class="chkbox">
            <input type="checkbox" id="Repsym4Yn" name="Repsym4Yn" value="Y" onClick="fn_check_repsym()">
            <label for="Repsym4Yn">천식이 있다.</label>
          </div>
          <div class="chkbox">
            <input type="checkbox" id="Repsym5Yn" name="Repsym5Yn" value="Y" onClick="fn_check_repsym()">
            <label for="Repsym5Yn">없다.</label>
          </div>

        </div>
        
        <div class="gbox mt10">
          <div class="txt14">순환기계 증상</div>
          <div class="chkbox">
            <input type="checkbox" id="Cirsym1Yn" name="Cirsym1Yn" value="Y" onClick="fn_check_cirsym()">
            <label for="Cirsym1Yn">머리가 자주 아프다.</label>
          </div>
          <div class="chkbox">
            <input type="checkbox" id="Cirsym2Yn" name="Cirsym2Yn" value="Y" onClick="fn_check_cirsym()">
            <label for="Cirsym2Yn">작업, 수면중 가슴이 답답할 때가 있다.</label>
          </div>
          <div class="chkbox">
            <input type="checkbox" id="Cirsym3Yn" name="Cirsym3Yn" value="Y" onClick="fn_check_cirsym()">
            <label for="Cirsym3Yn">가슴에 통증이 있다.</label>
          </div>
          <div class="chkbox">
            <input type="checkbox" id="Cirsym4Yn" name="Cirsym4Yn" value="Y" onClick="fn_check_cirsym()">
            <label for="Cirsym4Yn">얼굴이 자주 붉어진다</label>
          </div>
          <div class="chkbox">
            <input type="checkbox" id="Cirsym5Yn" name="Cirsym5Yn" value="Y" onClick="fn_check_cirsym()">
            <label for="Cirsym5Yn">손, 발이 자주 저린다.</label>
          </div>
          <div class="chkbox">
            <input type="checkbox" id="Cirsym6Yn" name="Cirsym6Yn" value="Y" onClick="fn_check_cirsym()">
            <label for="Cirsym6Yn">심장이 두근거리고 맥박이 불규칙하다.</label>
          </div>
          <div class="chkbox">
            <input type="checkbox" id="Cirsym7Yn" name="Cirsym7Yn" value="Y" onClick="fn_check_cirsym()">
            <label for="Cirsym7Yn">없다.</label>
          </div>
          
        </div>
      </ul>
      
      <ul>
        <h3>산재 경험이 있습니까?</h3>
        <div class="gbox">
          <div class="chkbox">
            <input type="radio" id="InddistYn_y" name="InddistYn" value="Y" onClick="toggleInddist()">
            <label for="InddistYn_y">예</label>
            <input type="radio" id="InddistYn_n" name="InddistYn" checked value="N" onClick="toggleInddist()">
            <label for="InddistYn_n">아니오</label>
           </div>
        </div>

        <div class="gbox mt10">
          <div class="txt14">'예'인 경우 상해부위는?</div>
          <div class="chkbox">
            <input type="checkbox" id="Inddist1Yn" name="Inddist1Yn" value="Y">
            <label for="Inddist1Yn">추락</label>
            <input type="checkbox" id="Inddist2Yn" name="Inddist2Yn" value="Y">
            <label for="Inddist2Yn">전도</label>
            <input type="checkbox" id="Inddist3Yn" name="Inddist3Yn" value="Y">
            <label for="Inddist3Yn">협착</label>
            <input type="checkbox" id="Inddist4Yn" name="Inddist4Yn" value="Y">
            <label for="Inddist4Yn">허리</label>
           </div>
           <div class="chkbox">
            <input type="checkbox" id="Inddist5Yn" name="Inddist5Yn" value="Y">
            <label for="Inddist5Yn">찔림</label>
            <input type="checkbox" id="Inddist6Yn" name="Inddist6Yn" value="Y">
            <label for="Inddist6Yn">기타</label>
           </div>
        </div>
      </ul>

    </div>
    <!-- // project_m_reg -->
	</div><!-- // whitebox_p15 -->
	<div class="agree_check">
		<p>개인정보 수집활용에 동의하시겠습니까?</p>
		<p><input type="radio" id="InfrecYn_y" name="InfrecYn" value="Y"><label for="InfrecYn_y">예</label>
		<input type="radio" id="InfrecYn_n" name="InfrecYn" value="N"><label for="InfrecYn_n">아니오</label></p>
	</div>

	<div class="basic_b_btn"><button type="button" class="btn-type btn2 black" id="btn-write" >작성완료</button></div>
 
</div>
</form>
<!-- @@@@ // join_wrap @@@@ -->

<script src="<c:url value='/js/egovframework/whms/jquery-1.11.3.min.js' />" type="text/javascript"></script>
<script>

	$("html").keydown(function(e) {
		var k = window.event.keyCode;
		if(window.event.ctrlKey && k == 85) {
			alert("소스보기가 금지 되어있습니다");
			event.keyCode = 0;
			event.cancleBubble = true;
			event.returnValue = false;
		}
	});

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
				&& !$("input:checkbox[name=Havdis7Yn]").is(":checked") && !$("input:checkbox[name=Havdis8Yn]").is(":checked") 
				&& !$("input:checkbox[name=HavdisYn]").is(":checked") ) {
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
		if($(':radio[name="InfrecYn"]:checked').val() != "Y") {
			if(confirm("개인정보에 동의하시겠습니까?")) {
				$("#InfrecYn_y").attr("checked", true);
			} else {
				alert("건강관리프로그램 이용에 제한이 있을 수 있습니다. 관리자에게 문의하시기 바랍니다.");
				return false;
			}
		}
		return returnVal;
	}

	$(document).ready(function() {

		// 술, 담배 값 초기 readonly
		$("#WekAlcCt").attr("readonly", true);
		$("#AdrkCt").attr("readonly", true);
		$("#DysmkCt").attr("readonly", true);

		// 기타 초기 disabled
		$("#FahsEtc").attr("readonly", true);
		$("#HavdisEtc").attr("readonly", true);

		// 운동 혹은 사고 초기 diabled
		$("input:checkbox[name=Moaci1Yn]").attr("disabled", true);
		$("input:checkbox[name=Moaci2Yn]").attr("disabled", true);
		$("input:checkbox[name=Moaci3Yn]").attr("disabled", true);
		$("input:checkbox[name=Moaci4Yn]").attr("disabled", true);
		$("input:checkbox[name=Moaci5Yn]").attr("disabled", true);
		$("input:checkbox[name=Moaci6Yn]").attr("disabled", true);
		$("input:checkbox[name=Moaci7Yn]").attr("disabled", true);

		// 작업 통증 초기 disabled
		$("input:checkbox[name=Wkpn1Yn]").attr("disabled", true);
		$("input:checkbox[name=Wkpn2Yn]").attr("disabled", true);
		$("input:checkbox[name=Wkpn3Yn]").attr("disabled", true);
		$("input:checkbox[name=Wkpn4Yn]").attr("disabled", true);
		$("input:checkbox[name=Wkpn5Yn]").attr("disabled", true);
		$("input:checkbox[name=Wkpn6Yn]").attr("disabled", true);
		$("input:checkbox[name=Wkpn7Yn]").attr("disabled", true);

		// 산재 경험 초기 disabled
		$("input:checkbox[name=Inddist1Yn]").attr("disabled", true);
		$("input:checkbox[name=Inddist2Yn]").attr("disabled", true);
		$("input:checkbox[name=Inddist3Yn]").attr("disabled", true);
		$("input:checkbox[name=Inddist4Yn]").attr("disabled", true);
		$("input:checkbox[name=Inddist5Yn]").attr("disabled", true);
		$("input:checkbox[name=Inddist6Yn]").attr("disabled", true);

	});

	jQuery(function($){
		$('#btn-write').on('click', function(){
			$('#registForm').submit();
		});
		/** 문진표 저장 function */
		$('#registForm').on('submit', function(){
			if(!validateQslt()) {
				return false;
			}
			var form = this;
			// 이름/
			// 폼전송
			setTimeout(function(){
				var params = $(form).serialize(); //{"UsrId":""};
				$.post("<c:url value='/whms/hi/qsltRegistAjax.do'/>", params, function(r){
					if(r && r.success) {
						//alert("정상적으로 등록되었습니다.");
						window.location.href= "<c:url value='/whms/hi/qsltComplete.do'/>";
					} else {
						alert("등록하지 못했습니다. 작성 내용을 확인해주세요.\n오류내용 : "+r.error_msg);
					}
				}, 'json');
			}, 10);
			event.preventDefault();
			return false;
		});
	});
</script>
</body>
</html>