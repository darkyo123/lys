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

<script src="<c:url value='/js/egovframework/whms/wijmo/vendor/wijmo.min.js'/>" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/wijmo/vendor/wijmo.input.min.js'/>" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/wijmo/vendor/wijmo.grid.min.js'/>" type="text/javascript"></script>
<script> 
wijmo.setLicenseKey ('14.51.236.196|14.51.236.206|14.51.236.235|203.236.236.136|61.33.235.245|www.cnkoh.co.kr|www.whmscnko.co.kr,825287534425196#B0tM3N7gjM5IDOiojIklkIs4nIxYXOxAjMiojIyVmdiwSZzxWYmpjIyNHZisnOiwmbBJye0ICRiwiI34zdv2EWDxkWSRVQ9JHZ5RUWVJmZxQjaMRlZ9QGZBZnSMljekR7LtlGdrY6VVlHO5dGOjhFO5g5bDFWYGl4L5IHSmdzawFUSBtmUD5keKh6YzhVQ92yTrZHe9BFZIZmV556QS54T6ljUwVWZ5FVTt9mdjxkRzhDVLRmSNNHU7o4ZudEdS5UcudHZrk5NIVGajVFO5YzUZNXYY5kVR3ycmdzMRlWTjZWe8t6a7kUek56TT9kbMVjRDR6UsJUUrUjYtdnUSh4MuRmb9UFan5keHxGdXpVeth6Q92SethWaDFnaN36Sox4ZJVGa4omcLJXcMRXdCtWSDljSM9GSMZ7UO3WRykEa5IXSTJEWll5LCFXZTBXe9hWYHNTcIBzb7Y5LV3SaqB7axUkcvkzVYVlMmF5dMJXZEZDM8QlbUJDbqlFRroURWd6SNNTSXtEeDpWbx4kUygGdEJlI0IyUiwiICN4Q9E4M9QjI0ICSiwSN4UDN5kTNxQTM0IicfJye#4Xfd5nIJBjMSJiOiMkIsIibvl6cuVGd8VEIgQXZlh6U8VGbGBybtpWaXJiOi8kI1xSfiUTSOFlI0IyQiwiIu3Waz9WZ4hXRgAicldXZpZFdy3GclJFIv5mapdlI0IiTisHL3JyS7gDSiojIDJCLi86bpNnblRHeFBCI73mUpRHb55EIv5mapdlI0IiTisHL3JCNGZDRiojIDJCLi86bpNnblRHeFBCIQFETPBCIv5mapdlI0IiTisHL3JyMDBjQiojIDJCLiUmcvNEIv5mapdlI0IiTisHL3JSV8cTQiojIDJCLi86bpNnblRHeFBCI4JXYoNEbhl6YuFmbpZEIv5mapdlI0IiTis7W0ICZyBlIsISMwAjMxADI5ADOwkTMwIjI0ICdyNkIsIicr9ybj9ybr96Yz5Ga79yd7dHLytmLvNmLo36auNmL7d7dsUDNy8SNzIjLzMjLxYDL6MTMuYzMy8iNzIjLzAjMsUzMy8iNzIjLxUjL4EDL6AjMuYzMy8SM58CNxwiN9EjL6MjMuETNuQTMiojIz5GRiwiIU6L1kWJ1oSJ1iojIh94QiwiI6kTMdI4N'); 
</script>
<script type="text/javaScript" language="javascript">

/** wijmo popup 객체 */
var dlgDetail;

var dlgDetailPwd;

var dlgDetailSecure;

function checkLogin(userSe) {
    // 일반회원
    if (userSe == "GNR") {
        document.loginForm.rdoSlctUsr[0].checked = true;
        document.loginForm.rdoSlctUsr[1].checked = false;
        document.loginForm.rdoSlctUsr[2].checked = false;
        document.loginForm.userSe.value = "GNR";
    // 기업회원
    } else if (userSe == "ENT") {
        document.loginForm.rdoSlctUsr[0].checked = false;
        document.loginForm.rdoSlctUsr[1].checked = true;
        document.loginForm.rdoSlctUsr[2].checked = false;
        document.loginForm.userSe.value = "ENT";
    // 업무사용자
    } else if (userSe == "USR") {
        document.loginForm.rdoSlctUsr[0].checked = false;
        document.loginForm.rdoSlctUsr[1].checked = false;
        document.loginForm.rdoSlctUsr[2].checked = true;
        document.loginForm.userSe.value = "USR";
    }
}

function chkPwd() {

	var id = $("#id").val();
	var pwOrigin = $("input[name=usrPwd]").val();
	var pw = $("#userNewPw").val();
	var pwConf = $("#userNewPwConf").val();

	var num = pw.search(/[0-9]/g);		// 숫자 포함 여부 체크

	if(pw.length < 6) {
		alert("6자리 이상 입력해주세요.");
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
						location.reload();
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

function actionLogin() {
	if (document.loginForm.id.value =="") {
        alert("<spring:message code="comUatUia.validate.idCheck" />"); <%-- 아이디를 입력하세요 --%>
    } else if (document.loginForm.usrPwd.value =="") {
        alert("<spring:message code="comUatUia.validate.passCheck" />"); <%-- 비밀번호를 입력하세요 --%>
    } else {
    	var otpChk = $("input[name=otpChk]").val();
    	if(otpChk == "N") {
    		var otpLoad = $("input[name=otpLoad]").val();
    		if(otpLoad == "N") {
    			$.ajax({
    				type:"POST",
    				url:"<c:url value='/uat/uia/getOtpKey.do' />",
    				data:{
    					"userSe": "USR",
    					"id": document.loginForm.id.value,
    					"usrPwd": btoa(document.loginForm.usrPwd.value)
    				},
    				dataType:'json',
    				timeout:(1000*60),
    				success:function(returnData, status) {
    					if(status == "success") {
    						if(returnData.result) {
    							if(returnData.lockYn == "Y") {
    								alert("로그인을 3회 실패하여 계정이 잠금상태입니다.\n관리자에게 연락바랍니다");
    								return;
    							} else {
	    							if(returnData.pwdChangeYn == "Y") {
	    								dlgDetailPwd.show(true, function (s) {
		    				                if (s.dialogResult == 'wj-hide-ok') {
		    				                	chkPwd();
		    				                } else {
		    				                }
		    				            });
	    							} else {
		    							var otpKey = returnData.result.otpkey;
		    							$("input[name=otpLoad]").val("Y");
		    							$("#otpKey").val(otpKey);
		    							$("#qrImg").attr("src", "http://chart.apis.google.com/chart?cht=qr&chs=200x200&chl=otpauth://totp/".concat("https://www.whmscnko.co.kr").concat("%3Fsecret%3D").concat(otpKey));
		    							dlgDetail.show(true, function (s) {
		    				                if (s.dialogResult == 'wj-hide-ok') {
		    				                	if($("#otpVal").val() == "") {
		    				                		alert("인증번호를 입력해주세요;");
		    				                		return;
		    				                	} else {
		    					                	$.ajax({
		    					        				type:"POST",
		    					        				url:"<c:url value='/uat/uia/checkOtpKey.do' />",
		    					        				data:{
		    					        					"id": document.loginForm.id.value,
		    					        					"otpKey": $("#otpKey").val(),
		    					        					"otpVal": $("#otpVal").val()
		    					        				},
		    					        				dataType:'json',
		    					        				timeout:(1000*60),
		    					        				success:function(returnData, status) {
		    					        					if(status == "success") {
		    					        						if(returnData.result) {
		    					        							$("input[name=otpChk]").val("Y");
		    					        							actionLogin();
		    					        						} else {
		    					        							alert("인증번호가 일치하지 않습니다");
		    					        							$("input[name=otpChk]").val("N");
		    					        						}
		    					        					} else {
		    					        						alert("데이터 처리 중 오류가 발생하였습니다");
		    					        						$("input[name=otpChk]").val("N");
		    					        					}
		    					        				},
		    					        				error:function() {
		    					        					alert("데이터 처리 중 오류가 발생하였습니다");
		    					        					$("input[name=otpChk]").val("N");
		    					        				}
		    					        			});
		    				                	}
		    				                } else {
		    				                }
		    				            });
	    							}
    							}
    						} else {
    							alert(returnData.message);
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
    		} else {
    			dlgDetail.show(true, function (s) {
	                if (s.dialogResult == 'wj-hide-ok') {
	                	if($("#otpVal").val() == "") {
	                		alert("인증번호를 입력해주세요;");
	                		return;
	                	} else {
		                	$.ajax({
		        				type:"POST",
		        				url:"<c:url value='/uat/uia/checkOtpKey.do' />",
		        				data:{
		        					"id": document.loginForm.id.value,
		        					"otpKey": $("#otpKey").val(),
		        					"otpVal": $("#otpVal").val()
		        				},
		        				dataType:'json',
		        				timeout:(1000*60),
		        				success:function(returnData, status) {
		        					if(status == "success") {
		        						if(returnData.result) {
		        							$("input[name=otpChk]").val("Y");
		        							actionLogin();
		        						} else {
		        							alert("인증번호가 일치하지 않습니다");
		        							$("input[name=otpChk]").val("N");
		        						}
		        					} else {
		        						alert("데이터 처리 중 오류가 발생하였습니다");
		        						$("input[name=otpChk]").val("N");
		        					}
		        				},
		        				error:function() {
		        					alert("데이터 처리 중 오류가 발생하였습니다");
		        					$("input[name=otpChk]").val("N");
		        				}
		        			});
	                	}
	                } else {
	                }
	            });
    		}
    	} else {
    		document.loginForm.action="<c:url value='/uat/uia/actionLogin.do'/>";
            document.loginForm.usrPwd.value = btoa(document.loginForm.usrPwd.value);
            //document.loginForm.j_username.value = document.loginForm.userSe.value + document.loginForm.username.value;
            //document.loginForm.action="<c:url value='/j_spring_security_check'/>";
            document.loginForm.submit();
    	}
    }
}

function actionCrtfctLogin() {
    document.defaultForm.action="<c:url value='/uat/uia/actionCrtfctLogin.do'/>";
    document.defaultForm.submit();
}

function goFindId() {
    document.defaultForm.action="<c:url value='/uat/uia/egovIdPasswordSearch.do'/>";
    document.defaultForm.submit();
}

function goRegiUsr() {
	
	var useMemberManage = '${useMemberManage}';

	if(useMemberManage != 'true'){
		<%-- 사용자 관리 컴포넌트가 설치되어 있지 않습니다. \n관리자에게 문의하세요. --%>
		alert("<spring:message code="comUatUia.validate.userManagmentCheck" />");
		return false;
	}

    var userSe = document.loginForm.userSe.value;
 
    // 일반회원
    if (userSe == "GNR") {
        document.loginForm.action="<c:url value='/uss/umt/EgovStplatCnfirmMber.do'/>";
        document.loginForm.submit();
    // 기업회원
    } else if (userSe == "ENT") {
        document.loginForm.action="<c:url value='/uss/umt/EgovStplatCnfirmEntrprs.do'/>";
        document.loginForm.submit();
    // 업무사용자
    } else if (userSe == "USR") {
    	<%-- 업무사용자는 별도의 회원가입이 필요하지 않습니다. --%>
        alert("<spring:message code="comUatUia.validate.membershipCheck" />");
    }
}

function goGpkiIssu() {
    document.defaultForm.action="<c:url value='/uat/uia/egovGpkiIssu.do'/>";
    document.defaultForm.submit();
}

function setCookie (name, value, expires) {
    document.cookie = name + "=" + escape (value) + "; path=/; expires=" + expires.toGMTString();
}

function getCookie(Name) {
    var search = Name + "=";
    if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면
        offset = document.cookie.indexOf(search);
        if (offset != -1) { // 쿠키가 존재하면
            offset += search.length;
            // set index of beginning of value
            end = document.cookie.indexOf(";", offset);
            // 쿠키 값의 마지막 위치 인덱스 번호 설정
            if (end == -1)
                end = document.cookie.length;
            return unescape(document.cookie.substring(offset, end));
        }
    }
    return "";
}

function saveid(form) {
    var expdate = new Date();
    // 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
    if (form.checkId.checked)
        expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
    else
        expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제조건
    setCookie("saveid", form.id.value, expdate);
}

function getid(form) {
    form.checkId.checked = ((form.id.value = getCookie("saveid")) != "");
}

function fnInit() {
	/* if (document.getElementById('loginForm').message.value != null) {
	    var message = document.getElementById('loginForm').message.value;
	} */
    /* if (${message} != "") {
        alert(${message});
    } */

    /* *************************
    document.loginForm.rdoSlctUsr[0].checked = false;
    document.loginForm.rdoSlctUsr[1].checked = false;
    document.loginForm.rdoSlctUsr[2].checked = true;
    document.loginForm.userSe.value = "USR";
    document.loginForm.id.value="TEST1";
    document.loginForm.password.value="rhdxhd12";
    **************************** */

    //getid(document.loginForm);
    // 포커스
    //document.loginForm.rdoSlctUsr.focus();
    
    //getid(document.loginForm);
    
    //fnLoginTypeSelect("typeGnr");

    /** Enter 처리 */
    $("input[name=usrPwd]").keydown(function(key) {
		if (key.keyCode == 13) {
			actionLogin();
		}
	});

    <c:if test="${not empty fn:trim(message) &&  message ne ''}">
    alert("${message}");    
    </c:if>

}

function fnLoginTypeSelect(objName){

	document.getElementById("typeGnr").className = "";
	document.getElementById("typeEnt").className = "";
	document.getElementById("typeUsr").className = "";
	
	document.getElementById(objName).className = "on";

	if(objName == "typeGnr"){ //일반회원
		document.loginForm.userSe.value = "GNR";
	}else if(objName == "typeEnt"){	//기업회원
		 document.loginForm.userSe.value = "ENT";
	}else if(objName == "typeUsr"){	//업무사용자
		 document.loginForm.userSe.value = "USR";
	}

}

function fnShowLogin(stat) {
	if (stat < 1) {	//일반로그인
		$(".login_input").eq(0).show();
		$(".login_input").eq(1).hide();
	} else {		//공인인증서 로그인
		$(".login_input").eq(0).hide();
		$(".login_type").hide();
		$(".login_input").eq(1).show();
	}
}

function fn_regist_otp() {
	$("#otpNot").show();
}

function fn_show_secure() {
	dlgDetailSecure.show(true, function (s) {
        if (s.dialogResult == 'wj-hide-ok') {
        } else {
        }
    });
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
	/** 운영서버 IP 접속 시 replace */
	var hostname = location.hostname;
	if(hostname == "61.33.235.245") {
		location.href = "https://www.whmscnko.co.kr:3979";
	}
	<c:if test="${not empty parentYn}">
    if("${parentYn}" == "N") {
    	parent.location.href = "<c:url value='/uat/uia/egovLoginUsr.do'/>";
    }
    </c:if>
    /** wijmo modal 세팅 */
	dlgDetail = new wijmo.input.Popup('#dlgDetail', {
	    removeOnHide: false
	});

	dlgDetailPwd = new wijmo.input.Popup('#dlgDetailPwd', {
	    removeOnHide: false
	});
	
	dlgDetailSecure = new wijmo.input.Popup('#dlgDetailSecure', {
	    removeOnHide: false
	});
});

</script>
</head>

<body class="gradient_loginbg" onLoad="fnInit();" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
<div id="container">
	<div class="main_text">
		<h2><img src="<c:url value='/images/egovframework/whms/logo_m01.png'/>" alt="" /></h2>
		<h3>보건관리시스템</h3>
		<p><span class="lgreen01 f_700">W</span>orker <span class="lgreen02 f_700">H</span>ealth <span class="lblue03 f_700">M</span>anagement <span class="lblue04 f_700">S</span>ystem</p>
	</div>
	<div class="section_main01">
		<p><img src="<c:url value='/images/egovframework/whms/bimg02.png'/>" alt="" /></p>
	</div>
  <!--// section_main -->
	<div class="main_loginbox01">
		<form id="loginForm" name="loginForm" method="POST" action="<c:url value='/uat/uia/actionLogin.do'/>" onsubmit="">
			<input type="hidden" id="message" name="message" value="<c:out value='${message}'/>">
			<input name="userSe" type="hidden" value="USR"/>
			<input name="j_username" type="hidden"/>
			<input type="text" placeholder="아이디" id="id" name="id"/>
			<input type="password" placeholder="비밀번호" name="usrPwd"  maxlength="12" />
			<input type="hidden" name="otpLoad" value="N" />
			<input type="hidden" name="otpChk" value="N" />
			<button type="button" class="btn" onClick="actionLogin()"><span>로그인</span></button>
		</form>
	</div>
	<div class="div_warning">
		<img src="<c:url value='/images/egovframework/whms/logo_cj.png'/>" alt="" />
		<p class="warning_main">본 시스템은 CJ그룹 임직원에 한하여 사용하실 수 있습니다. 불법적인 접근 및 사용 시 관련 법규에 의해 처벌될 수 있습니다. <a href="javascript:fn_show_secure()">[인트라넷 보안지침]</a></p>
		<p class="warning_bottom">Copyright ⓒ cj.cj.net. All rights reserved.</p>
	</div>
		<div class="modal-dialog" id="dlgDetail" style="display: none;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close wj-hide" aria-hidden="true">&times;</button>
					<h4 class="modal-title">OTP 인증코드 입력</h4>
				</div>
				<div class="modal-body">
					<div id="otpNot" style="display: none;">
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
					<button type="button" id="btnRegistOtp" class="btn btn-success" onClick="fn_regist_otp();">OTP 신규등록</button>
					<button type="button" class="btn btn-primary wj-hide-ok" style="margin-right: 5px;">OK</button>
					<button type="button" class="btn btn-warning wj-hide-cancel">Cancel</button>
				</div>
			</div>
		</div>

		<div class="modal-dialog" id="dlgDetailPwd" style="display: none;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close wj-hide" aria-hidden="true">&times;</button>
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
					<button type="button" class="btn btn-primary wj-hide-ok" style="margin-right: 5px;">OK</button>
					<button type="button" class="btn btn-warning wj-hide-cancel">Cancel</button>
				</div>
			</div>
		</div>

		<div class="modal-dialog" id="dlgDetailSecure" style="display: none;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close wj-hide" aria-hidden="true">&times;</button>
					<h4 class="modal-title">인트라넷 보안지침</h4>
				</div>
				<div class="modal-body modal-secure">
					<div class="section">
						<p class="secureTitle">1.인터넷 보안</p>
						<p>* 인터넷을 통해 불건전 사이트에 접속하는 것을 금지한다.</p>
						<p>* 인터넷으로 다운 받은 자료는 사용하기 전 반드시 컴퓨터 바이러스 검색을 실시 한다.</p>
						<p>* 인터넷을 통해 해킹 프로그램 등의 불법 소프트웨어 및 저작권에 위반되는 파일을 다운로드 하지 않는다.</p>
						<p>* 인터넷 상에서 해킹과 관련된 모든 행위를 금지한다.</p>
						<p class="secureTitle">2.CJ 보안</p>
						<p>* 패스워드 설정 정책</p>
						<p>* 패스워드는 최소한 90일에 한번씩은 의무적으로 변경한다.</p>
						<p>* 패스워드는 최소 6자 이상으로 구성한다.</p>
						<p>* 패스워드는 아이디를 포함해서는 안된다.</p>
						<p>* 패스워드에는 숫자가 최소 1자 이상 포함되어야 한다.</p>
						<p>* 다음 게시물을 게시하여서는 안된다.</p>
						<p>* 개인이나 부서를 모독하거나 명예를 손상시키는 게시물</p>
						<p>* 개인간, 부서간 상호 비방하는 내용으로 감정을 자극하거나 사기를 저하시키는 게시물</p>
						<p>* 질서를 문란케 하거나, 혼란을 초래할 수 있는 게시물</p>
						<p>* 회사 발전을 저해하거나, 명예를 실추시키는 게시물</p>
						<p>* 사회 윤리나 미풍양속에 위배되는 게시물</p>
						<p>* 기타 업무 수행에 방해가 되는 게시물</p>
						<p>* 접속할 시는 ID와 패스워드를 통해 인증을 받아 사용할 수 있도록 하여,</p>
						<p>관계자 이외의 사용자가 사용하는 것을 금지한다.</p> 
						<p>또한 타인의 사용자 ID을 도용하거나 사용해서는 안된다.</p>
						<p>* 파일이 포함된 게시물을 업로드 하기 전에 바이러스 검사를 하며,</p>
						<p>첨부파일을 다운로드 받을 때에도 바이러스 검사를 한다.</p>
						<p>* 승인되지 않은 게시물을 올리는 것을 금지한다.</p>
						<p class="secureTitle">3.기타</p>
						<p>* PC에 임의로 접근하여, 파일의 열람, 변조하거나, 삭제하는 것을 금지한다.</p>
						<p>* 인가되지 않은 행위를 금지한다.</p>
						<p>* 사용되는 소프트웨어는 불법 프로그램을 설치하는 것을 금지한다.</p>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-warning wj-hide-cancel">Cancel</button>
				</div>
			</div>
		</div>
	</div>
<script src="<c:url value='/js/egovframework/whms/needpopup.js' />" type="text/javascript"></script>
</body>
</html>


