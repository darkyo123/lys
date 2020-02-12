<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : EgovLoginUsr.jsp
  * @Description : Login 인증 화면
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.03.03    박지욱          최초 생성
  * @ 2011.09.25    서준식          사용자 관리 패키지가 미포함 되었을때에 회원가입 오류 메시지 표시
  * @ 2011.10.27    서준식          사용자 입력 탭 순서 변경
  * @ 2017.07.21    장동한 	    	로그인인증제한 작업
  *
  *  @author 공통서비스 개발팀 박지욱
  *  @since 2009.03.03
  *  @version 1.0
  *  @see
  *
  *  Copyright (C) 2009 by MOPAS  All right reserved.
  */
%>

<!DOCTYPE html>
<html>
<head>
<title><spring:message code="comUatUia.title" /></title><!-- 로그인 -->
<meta http-equiv="content-type" content="text/html; charset=utf-8">

<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/bootstrap.min.css' />" />
<link href="<c:url value='/css/egovframework/whms/wijmo/vendor/wijmo.min.css'/>" rel="stylesheet" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/wijmo/app.css'/>" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/whms/reset.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/whms/style.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/whms/animate.css' />" media="all">

<script src="<c:url value='/js/egovframework/whms/jquery-1.11.3.min.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/front-ui.js' />" type="text/javascript"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/whms/jquery.navgoco.js' />"></script><!-- left menu js -->

<script type="text/javaScript" language="javascript">

function fn_change_pwd() {
	var id = opener.opener.$("#id").val();
	var pwOrigin = opener.opener.$("input[name=usrPwd]").val();
	var pw = $("#userNewPw").val();
	var pwConf = $("#userNewPwConf").val();

	var num = pw.search(/[0-9]/g);		// 숫자 포함 여부 체크

	if(pw.length < 8) {
		alert("8자리 이상 입력해주세요.");
		return false;
	}

	if(num < 0) {
		alert("최소 하나의 숫자가 필요합니다.");
		return false;
	}

	if(pw.match(id)) {
		alert('ID가 포함된 비밀번호는 사용하실 수 없습니다.');
		return false;
	}

	if(pw != pwConf) {
		alert('확인 비밀번호가 일치하지 않습니다');
		return false;
	}

	$.ajax({
		type:"POST",
		url:"<c:url value='/whms/sys/userPwdChangeAjax.do' />",
		data:{
			"userId": id,
			"userPw": btoa(pwOrigin),
			"userPwNew": btoa(pw)
		},
		dataType:'json',
		timeout:(1000*60),
		async: false,
		success:function(returnData, status) {
			if(status == "success") {
				if(returnData.result != null) {
					if(returnData.result == "N") {
						alert("비밀번호 변경 후 1일 이후에 재변경 가능합니다");
					} else if(returnData.result == "D") {
						alert("기존에 사용하신 비밀번호 입니다");
					} else {
						alert("비밀번호 변경이 완료되었습니다");
						opener.opener.location.reload();
						opener.self.close();
						self.close();
					}
				} else {
					alert("현재 비밀번호가 일치하지 않습니다");
				}
			} else {
				alert("패스워드 변경 작업 중 오류가 발생하였습니다");
			}
		},
		error: function() {
			alert("패스워드 변경 작업 중 오류가 발생하였습니다");
		}
	});

	return true;
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

</script>
</head>
<body oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
	<div id="container">
		<div class="modal-dialog" id="dlgDetail">
			<div class="modal-content">
				<div class="modal-header">
					<!-- <button type="button" class="close wj-hide" aria-hidden="true">&times;</button> -->
					<h4 class="modal-title">비밀번호 변경</h4>
				</div>
				<div class="modal-body">
					<div class="section">
						<p class="text-center">비밀번호 변경 주기가 도래하였습니다</p>
					</div>

					<dt>신규 비밀번호</dt>
					<dd>
						<input class="form-control" type="password" maxlength="20" id="userNewPw" />
		            </dd>

		            <dt>신규 비밀번호 확인</dt>
					<dd>
						<input class="form-control" type="password" maxlength="20" id="userNewPwConf" />
		            </dd>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary wj-hide-ok" style="margin-right: 5px;" onClick="fn_change_pwd();">OK</button>
					<!-- <button type="button" class="btn btn-warning wj-hide-cancel">Cancel</button> -->
				</div>
			</div>
		</div>
	</div>
<script src="<c:url value='/js/egovframework/whms/needpopup.js' />" type="text/javascript"></script>
</body>
</html>


