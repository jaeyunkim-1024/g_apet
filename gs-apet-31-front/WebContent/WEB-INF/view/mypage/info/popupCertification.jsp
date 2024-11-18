<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<script type="text/javascript">

	$(document).ready(function(){
		
	}); // End Ready

	/*
	 * Ipin 인증 팝업
	 */
	function openIpinPopup(){
		// 2016.12.15, 이성용
		return 0;
		
		pop.ipin({callBackFnc : "cbCertificationInfo"});
	}

	/*
	 * CheckPlus 인증 팝업
	 */
	function openCheckPlusPopup(){
		// 2016.12.15, 이성용
		return 0;
		
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
		
		callMemberCertification();
	}
	
	/*
	 * 회원인증하기 호출
	 */
	function callMemberCertification(){
		var options = {
				url : "<spring:url value='/mypage/info/memberCertification' />",
				data : $("#certify_form").serialize(),
				done : function(data){
					
					var resultCode = data.resultCode;
					var resultMsg = data.resultMsg;

					if(resultCode == "S"){
						alert("회원인증에 성공하였습니다. 재 로그인 해주세요.");
						waiting.start();
						location.href="/logout";
						
					}else if(resultCode == "F"){
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

<div>
	<div class="t_center point2 mgt55">
		기존 회원의 경우 회원인증을 받으셔야 정상적인 이용이 가능합니다.
	</div>
	<div class="t_center mgt35 mgb28">
		<a href="#" class="btn_h60_type1" onclick="openCheckPlusPopup();return false;">휴대폰 인증</a>
		<a href="#" class="btn_h60_type1 mgl6" onclick="openIpinPopup();return false;">아이핀 인증</a>
	</div>		
</div>