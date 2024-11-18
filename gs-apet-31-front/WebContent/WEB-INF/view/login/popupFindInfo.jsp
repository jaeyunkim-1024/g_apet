<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<script type="text/javascript">

	$(document).ready(function(){
	}); // End Ready

	$(function() {
		$('#loginTab').fnTab();
	});

	/*
	 * 로그인 아이디 이메일로 찾기
	 */
	function fineMemberLoginIdEmail(){
		if($("#login_id_find_email_mbr_nm").val() == ""){
			alert("성함을 입력해 주세요.");
			$("#login_id_find_email_mbr_nm").focus();
			return;
		}

		if($("#login_id_find_email_email").val() == ""){
			alert("이메일을 입력해 주세요.");
			$("#login_id_find_email_email").focus();
			return;
		}
		
		if(!valid.email.test($("#login_id_find_email_email").val())){
			alert("올바른 이메일 형식이 아닙니다.");
			$("#login_id_find_email_email").focus();
			return;
		}
		

		
		var options = {
			url : "<spring:url value='/findMemberLoginIdEmail' />",
			data : $("#login_id_find_email_form").serialize(),
			done : function(data){
				alert("아이디가 이메일로 발송되었습니다.");
				pop.close("<c:out value="${param.popId}" />");
			}
		};
		ajax.call(options);
	}
	
	/*
	 * 로그인 아이디 휴대폰으로 찾기
	 */
	function fineMemberLoginIdMobile(){

		if($("#login_id_find_mobile_mbr_nm").val() == ""){
			alert("성함을 입력해 주세요.");
			$("#login_id_find_mobile_mbr_nm").focus();
			return;
		}

		if($("#login_id_find_mobile_mobile").val() == ""){
			alert("휴대폰번호를 입력해 주세요.");
			$("#login_id_find_mobile_mobile").focus();
			return;
		}
		
		if(!valid.mobile.test($("#login_id_find_mobile_mobile").val())){
			alert("올바른 형식의 휴대폰번호가 아닙니다.");
			$("#login_id_find_mobile_mobile").focus();
			return;
		}

		var options = {
			url : "<spring:url value='/findMemberLoginIdMobile' />",
			data : $("#login_id_find_mobile_form").serialize(),
			done : function(data){
				alert("아이디가 휴대폰으로 발송되었습니다.");
				pop.close("<c:out value="${param.popId}" />");
			}
		};
		ajax.call(options);		
	}
	
	/*
	 * 비밀번호 이메일로 찾기
	 */
	function findMemberPasswordEmail(){
		if($("#password_find_email_login_id").val() == ""){
			alert("아이디를 입력해 주세요.");
			$("#password_find_email_login_id").focus();
			return;
		}

		if($("#password_find_email_email").val() == ""){
			alert("이메일을 입력해 주세요.");
			$("#password_find_email_email").focus();
			return;
		}
		
		if(!valid.email.test($("#password_find_email_email").val())){
			alert("올바른 이메일 형식이 아닙니다.");
			$("#password_find_email_email").focus();
			return;
		}
		
		var options = {
			url : "<spring:url value='/findMemberPasswordEmail' />",
			data : $("#password_find_email_form").serialize(),
			done : function(data){
				alert("비밀번호가 이메일로 발송되었습니다.");
				pop.close("<c:out value="${param.popId}" />");
			}
		};
		ajax.call(options);		
	}

	/*
	 * 비밀번호 휴대폰으로 찾기
	 */
	function findMemberPasswordMobile(){
		if($("#password_find_mobile_login_id").val() == ""){
			alert("아이디를 입력해 주세요.");
			$("#password_find_mobile_login_id").focus();
			return;
		}

		if($("#password_find_mobile_mobile").val() == ""){
			alert("휴대폰번호를 입력해 주세요.");
			$("#password_find_mobile_mobile").focus();
			return;
		}
		
		if(!valid.mobile.test($("#password_find_mobile_mobile").val())){
			alert("올바른 형식의 휴대폰번호가 아닙니다.");
			$("#password_find_mobile_mobile").focus();
			return;
		}

		var options = {
			url : "<spring:url value='/findMemberPasswordMobile' />",
			data : $("#password_find_mobile_form").serialize(),
			done : function(data){
				alert("비밀번호가 휴대폰으로 발송되었습니다.");
				pop.close("<c:out value="${param.popId}" />");
			}
		};
		ajax.call(options);				
	}
</script>

<div id="pop_contents" class="pop_login">
	<div id="loginTab" class="tab_style1 tab_login">
		<ul>
			<li><a href="#loginTabCont1" class="on">아이디 찾기</a></li>
			<li><a href="#loginTabCont2">비밀번호 찾기</a></li>
		</ul>
	</div>
	
	<!-- 아이디찾기 -->
	<div id="loginTabCont1" class="login_tab_cont ui-tab-content-default">
		<div class="radio_group">
			<label><input type="radio" name="loginRadio1" class="radio" checked="checked" onclick="$('#loginRadioTabCont1_2').hide();$('#loginRadioTabCont1_1').show();" /> 이메일로 받기</label>
			<label class="mgl14"><input type="radio" name="loginRadio1" class="radio" onclick="$('#loginRadioTabCont1_1').hide();$('#loginRadioTabCont1_2').show();" /> 휴대폰으로 받기</label>
		</div>
		<div id="loginRadioTabCont1_1" class="input_area">
			<form id="login_id_find_email_form">
			<input type="text" class="login_input1" id="login_id_find_email_mbr_nm" name="mbrNm" title="성함" placeholder="성함" />
			<input type="text" class="login_input2" id="login_id_find_email_email" name="email" title="이메일" placeholder="이메일" />
			</form>
			<a href="#" class="btn_login1" onclick="fineMemberLoginIdEmail();return false;">확인</a>
		</div>
		<div  id="loginRadioTabCont1_2" class="input_area" style="display:none;">
			<form id="login_id_find_mobile_form">
			<input type="text" class="login_input1" id="login_id_find_mobile_mbr_nm" name="mbrNm" title="성함" placeholder="성함" />
			<input type="text" class="login_input2" id="login_id_find_mobile_mobile" name="mobile" title="휴대번호" placeholder="휴대번호" />
			</form>
			<a href="#" class="btn_login1" onclick="fineMemberLoginIdMobile();return false;">확인</a>
		</div>
		<div class="add_text_box">
			회원가입하신 회원의 성함 및 이메일을 입력하신 후<br /> 확인 버튼을 누르시면 이메일 또는 휴대폰으로 가입하신 아이디가 전송됩니다.
		</div>
	</div>

	<!-- 아이디찾기 -->
	<div id="loginTabCont2" class="login_tab_cont ui-tab-content-default">
		<div class="radio_group">
			<label><input type="radio" name="loginRadio2" class="radio" checked="checked" onclick="$('#loginRadioTabCont2_2').hide();$('#loginRadioTabCont2_1').show();" /> 이메일로 받기</label>
			<label class="mgl14"><input type="radio" name="loginRadio2" class="radio" onclick="$('#loginRadioTabCont2_1').hide();$('#loginRadioTabCont2_2').show();" /> 휴대폰으로 받기</label>
		</div>
		<div id="loginRadioTabCont2_1" class="input_area">
			<form id="password_find_email_form">
			<input type="text" class="login_input1" id="password_find_email_login_id" name="loginId" title="아이디" placeholder="아이디" />
			<input type="text" class="login_input2" id="password_find_email_email" name="email" title="이메일" placeholder="이메일" />
			</form>
			<a href="#" class="btn_login1" onclick="findMemberPasswordEmail();return false;">임시비밀번호 발급받기</a>
		</div>
		<div  id="loginRadioTabCont2_2" class="input_area" style="display:none;">
			<form id="password_find_mobile_form">
			<input type="text" class="login_input1" id="password_find_mobile_login_id" name="loginId" title="아이디" placeholder="아이디" />
			<input type="text" class="login_input2" id="password_find_mobile_mobile" name="mobile" title="휴대번호" placeholder="휴대번호" />
			</form>
			<a href="#" class="btn_login1" onclick="findMemberPasswordMobile();return false;">임시비밀번호 발급받기</a>
		</div>
	</div>
</div>
