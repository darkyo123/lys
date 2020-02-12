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

$(document).ready(function() {
	$.ajax({
		type:"POST",
		url:"<c:url value='/uat/uia/getOtpKey.do' />",
		data:{
			"userSe": "USR",
			"id": opener.document.loginForm.id.value,
			"usrPwd": btoa(opener.document.loginForm.usrPwd.value)
		},
		dataType:'json',
		timeout:(1000*60),
		success:function(returnData, status) {
			if(status == "success") {
				if(returnData.result) {
					if(returnData.lockYn == "Y") {
						alert("로그인을 3회 실패하여 계정이 잠금상태입니다.\n관리자에게 연락바랍니다");
						self.close();
						return;
					} else {
						if(returnData.pwdChangeYn == "Y") {
							var url = "<c:url value='/uat/uia/pwdChangePopup.do' />";
				    	    var popupwidth = '600';
				    	    var popupheight = '320';
				    	    var title = '비밀번호 변경';

				    	    Top = (window.screen.height - popupheight) / 3;
				    	    Left = (window.screen.width - popupwidth) / 2;
				    	    if (Top < 0) Top = 0;
				    	    if (Left < 0) Left = 0;
				    	    Future = "fullscreen=no,toolbar=no,location=no,directories=no,status=no,menubar=no,   scrollbars=no,resizable=yes,left=" + Left + ",top=" + Top + ",width=" + popupwidth + ",height=" + popupheight;
				    	    PopUpWindow = window.open(url, title, Future);
				    	    PopUpWindow.focus();
						}
						var otpKey = returnData.result.otpkey;
						opener.$("input[name=otpLoad]").val("Y");
						$("#otpKey").val(otpKey);
						$("#qrImg").attr("src", "http://chart.apis.google.com/chart?cht=qr&chs=200x200&chl=otpauth://totp/".concat("https://www.whmscnko.co.kr").concat("%3Fsecret%3D").concat(otpKey));
					}
				} else {
					alert(returnData.message);
					self.close();
					return;
				}
			} else {
				alert("OTP key 조회에 실패했습니다.");
				console.log("rowEdit Error Occurred");
				return;
			}
		},
		error:function() {
			alert("데이터 처리 중 오류가 발생하였습니다");
		}
	});
});

function fn_send_otp() {
	if($("#otpVal").val() == "") {
		alert("인증번호를 입력해주세요;");
		return;
	} else {
    	$.ajax({
			type:"POST",
			url:"<c:url value='/uat/uia/checkOtpKey.do' />",
			data:{
				"id": opener.document.loginForm.id.value,
				"otpKey": $("#otpKey").val(),
				"otpVal": $("#otpVal").val()
			},
			dataType:'json',
			timeout:(1000*60),
			success:function(returnData, status) {
				if(status == "success") {
					if(returnData.result) {
						opener.$("input[name=otpChk]").val("Y");
						opener.actionLogin();
						self.close();
					} else {
						alert("인증번호가 일치하지 않습니다");
						opener.$("input[name=otpChk]").val("N");
					}
				} else {
					alert("데이터 처리 중 오류가 발생하였습니다");
					opener.$("input[name=otpChk]").val("N");
				}
			},
			error:function() {
				alert("데이터 처리 중 오류가 발생하였습니다");
				opener.$("input[name=otpChk]").val("N");
			}
		});
	}
}

function fn_regist_otp() {
	$("#otpNot").show();
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
					<h4 class="modal-title">OTP 인증코드 입력</h4>
				</div>
				<div class="modal-body">
					<div id="otpNot">
						<div class="section">
							<p class="text-center">Google OTP 앱을 설치하시고 OTP key 또는 QR Code를 스캔 해주세요</p>
							<p class="text-center">등록 후 OTP 인증코드를 입력하시면 로그인이 가능합니다</p>
						</div>
	
						<dt>OTP key</dt>
						<dd>
							<input class="form-control" type="text" maxlength="20" id="otpKey" readonly />
			            </dd>
	
			            <dt>QR Code</dt>
						<dd class="text-center">
							<img id="qrImg" src="" alt="Img loading..." title="Scan this qr code in google otp app" />
			            </dd>
					</div>
					<div id="otpOk">
						<dt>인증코드</dt>
			            <dd>
			            	<input class="form-control" type="password" maxlength="6" id="otpVal" />
			            </dd>
					</div>
				</div>
				<div class="modal-footer">
					<!-- <button type="button" id="btnRegistOtp" class="btn btn-success" onClick="fn_regist_otp();">OTP 신규등록</button> -->
					<button type="button" class="btn btn-primary wj-hide-ok" style="margin-right: 5px;" onClick="fn_send_otp()">OK</button>
				</div>
			</div>
		</div>
	</div>
<script src="<c:url value='/js/egovframework/whms/needpopup.js' />" type="text/javascript"></script>
</body>
</html>


