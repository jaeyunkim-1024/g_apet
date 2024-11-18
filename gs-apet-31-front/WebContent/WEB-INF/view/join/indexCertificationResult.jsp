<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<script type="text/javascript">
	$(document).ready(function(){
	}); // End Ready

	$(function() {

	});
	
</script>

<div class="join_step_box">
	<ul>
		<li class="on">
			<div class="text1">STEP01</div>
			<div class="text2">본인인증</div>
		</li>
		<li>
			<div class="text1">STEP02</div>
			<div class="text2">약관동의</div>
		</li>
		<li>
			<div class="text1">STEP03</div>
			<div class="text2">회원정보입력</div>
		</li>
		<li>
			<div class="text1">STEP04</div>
			<div class="text2">회원가입완료</div>
		</li>
	</ul>
</div>
<div class="join_content_box">
	<div class="join_content_box_in">
		<h2 class="join_title">STEP 01. 본인인증</h2>
		<div class="t_center point2 mgt65">
			고객님은 이미 ${view.stNm}에 가입되어 있습니다.
		</div>
		<div class="t_center mgt35 mgb28">
			<a href="/indexLogin" class="btn_h60_type1">로그인하기</a>
			<a href="#" onclick="pop.loginFind({});return false;" class="btn_h60_type2 mgl6">아이디/비밀번호 찾기</a>
		</div>
	</div>
</div>
