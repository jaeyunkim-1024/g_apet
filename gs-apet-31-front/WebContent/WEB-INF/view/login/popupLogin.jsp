<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<!doctype html>
<html lang="ko">
<head>
	<title><c:out value="${view.stNm}" /></title>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<link rel="shortcut icon" href="/_images/mall/mall_favicon.ico" />

	<link rel="stylesheet" type="text/css" href="/_css/common.css">
	<link rel="stylesheet" type="text/css" href="/_css/layout.css">

	<script type="text/javascript" src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/jquery/jquery-1.11.3.min.js" ></script>
	<script type="text/javascript" src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/jquery/jquery.blockUI.js" charset="utf-8"></script>

	<script type="text/javascript"  src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/clipboard.min.js"></script>
	<script type="text/javascript"  src="/_script/common.js" ></script>



	<script type="text/javascript">
	// 개발자도구에서의 console.[log, debug] control	
	logger("<spring:eval expression="@bizConfig['envmt.gb']" />");
	
	$(document).ready(function(){
	}); // End Ready

	$(function() {
		
		// 검색조건 Enter Key 이벤트
		$(".ipt").keypress(function() {
			if ( window.event.keyCode == 13 ) {
				ajaxLogin();
			}
		});


		$(".ord_ipt").keypress(function() {
			if ( window.event.keyCode == 13 ) {
				searchOrder();
			}
		});
	});

	/*
	 * 로그인처리
	 */
	function ajaxLogin(){
		if($("#popup_login_login_id").val() == ""){
			alert("아이디를 입력해 주세요.");
			$("#popup_login_login_id").focus();
			return;
		}

		if($("#popup_login_pasword").val() == ""){
			alert("비밀번호를 입력해 주세요.");
			$("#popup_login_pasword").focus();
			return;
		}

		
		var options = {
				url : "<spring:url value='/login' />",
				data : $("#popup_login_form").serialize(),
				done : function(data){
					var loginCd = data.resultCode;
					var loginMsg = data.resultMsg;

					if(loginCd == "S"){
						window.close();
					}else{
						alert(loginMsg);
						//휴면상태일 경우
						if(loginCd == "Q"){
//							location.href="/indexNotUsingAccount";	
						}
					}
					
				}
		};

		ajax.call(options);
		
	}
		
	</script>
</head>

<body>

		<div id="pop_contents" class="pop_login">
			<!-- 로그인 -->
			<h2 class="login_title">로그인</h2>
			<div class="input_area">
				<form id="popup_login_form">
				<input type="text" id="popup_login_login_id" name="loginId" class="login_input1 ipt" title="아이디" placeholder="아이디" />
				<input type="password" id="popup_login_pasword" name="pswd" class="login_input2 ipt" title="비밀번호" placeholder="비밀번호" autocomplete="off"/>
				</form>
				<a href="#" class="btn_login1" onclick="ajaxLogin();return false;">로그인</a>
			</div>
		</div>

</body>
</html>



