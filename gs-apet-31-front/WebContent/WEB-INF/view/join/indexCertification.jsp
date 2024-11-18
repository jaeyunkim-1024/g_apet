<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<script type="text/javascript">
	window.name ="Parent_window";


	$(document).ready(function(){
	}); // End Ready

	$(function() {

	});

	/*
	 * Ipin 인증 팝업
	 */
	function openIpinPopup(){
		pop.ipin({callBackFnc : "cbCertificationInfo"});
	}

	/*
	 * CheckPlus 인증 팝업
	 */
	function openCheckPlusPopup(){
		pop.checkPlus({callBackFnc : "cbCertificationInfo"});
	}

	/*
	 * 인증결과 리턴
	 */
	function cbCertificationInfo(data){
		$("#certify_form_auth_type").val(data.authType);
		$("#certify_form_enc_data").val(data.encData);
		$("#certify_form_param_r1").val(data.paramR1);
		$("#certify_form_param_r2").val(data.paramR2);
		$("#certify_form_param_r3").val(data.paramR3);
		
		duplicateMember();
	}

	/*
	 * 인증내역 중복 가입체크
	 */
	function duplicateMember(){
		
		var options = {
			url : "<spring:url value='/join/getMemberDuplicate' />",
			data : $("#certify_form").serialize(),
			done : function(data){
				var resultCode = data.resultCode;
				var resultMsg = data.resultMsg;

				if(resultCode == "S"){
					$("#certify_form").attr("target", "_self");
					$("#certify_form").attr("action", "/join/indexTerms");
					$("#certify_form").submit();
				}else if(resultCode == "F"){
					$("#certify_form").attr("target", "_self");
					$("#certify_form").attr("action", "/join/indexCertificationResult");
					$("#certify_form").submit();
				}else if(resultCode == "L"){
					var y = resultMsg.substr(0,4);
					var m = resultMsg.substr(4,2);
					var d = resultMsg.substr(6,2);
					
					alert("고객님은 탈퇴하신 회원으로 탈퇴일로부터 2개월 간 회원가입이 제한됩니다.\n고객님의 재가입 가능일은 "+y+"년"+m+"월"+d+"일입니다.");
					location.reload();
					
				}else if(resultCode == "N"){
					
					alert("고객님은 1년 이상 로그인을 하지 않아 휴면상태로 전환되었습니다.\n휴면계정 해제 안내 페이지로 이동합니다.");
					location.href="/indexNotUsingAccount";
					
				}else{
					alert(resultMsg);
				}
			}
		};

		ajax.call(options);
		
	}
	
</script>

<form id="certify_form" name="certify_form" method="post">
	<input type="hidden" id="certify_form_auth_type" name="authType" value="" />
	<input type="hidden" id="certify_form_enc_data" name="encData" value="" />								
    <input type="hidden" id="certify_form_param_r1" name="paramR1" value="" />
    <input type="hidden" id="certify_form_param_r2" name="paramR2" value="" />
    <input type="hidden" id="certify_form_param_r3" name="paramR3" value="" />
</form>

<div class="join_step_box">
	<ul>
		<li class="on">
			<div class="step1">STEP01</div>
			<div class="text2">1.본인인증</div>
		</li>
		<li>
			<div class="step2">STEP02</div>
			<div class="text2">2.약관동의</div>
		</li>
		<li>
			<div class="step3">STEP03</div>
			<div class="text2">3.회원정보입력</div>
		</li>
		<li>
			<div class="step4">STEP04</div>
			<div class="text2">4.회원가입완료</div>
		</li>
	</ul>
</div>
<div class="join_content_box">
	<div class="join_content_box_in">
		<h2 class="join_title">STEP 01. 본인인증</h2>
		
		<div>
			<div class="t_center point2 mgt55">
				휴대폰 또는 아이핀 본인확인을 통해 ${view.stNm}에<br />
				회원으로 가입하시면 다양하고 특별한 혜택이 있습니다.
			</div>
			<div class="t_center mgt35 mgb28">
				<a href="#" class="btn_h60_type1" onclick="openCheckPlusPopup();return false;">휴대폰 인증</a>
				<a href="#" class="btn_h60_type1 mgl6" onclick="openCheckPlusPopup();return false;">아이핀 인증</a>
				<!-- TODO : 데모 작업을 위해 로직 하드코딩
				<a href="#" class="btn_h60_type1 mgl6" onclick="openIpinPopup();return false;">아이핀 인증</a>
				--> 
			</div>	
			
			<div class="t_center point2 mgt20 mgb40">
				<strong>만 14세 미만은 회원가입이 제한됩니다.</strong>
			</div>
		</div>
	</div>
</div>