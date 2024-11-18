<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<script type="text/javascript">

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
		
		saveMemberUse();
	}

	/*
	 * 인증내역 중복 가입체크
	 */
	function saveMemberUse(){
		
		var options = {
				url : "<spring:url value='/saveMemberUse' />",
				data : $("#certify_form").serialize(),
				done : function(data){
					var resultCode = data.resultCode;
					var resultMsg = data.resultMsg;
					
					alert(resultMsg);
					
					if(resultCode == "S"){
						location.href="/indexLogin";
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


<div class="join_content_box">
	<div class="join_content_box_in">
		<h2 class="join_title">휴면계정 해제 안내</h2>
		<div class="t_center point2 mgt55">
			회원님의 아이디는 1년 이상 로그인하지 않아 휴면 상태로 전환되었습니다.<br />
			본인인증을 통해 휴면상태를 해제하신 후 ${view.stNm}을 이용하실 수 있습니다.
		</div>
		<div class="t_center mgt35 mgb28">
			<a href="#" class="btn_h60_type1" onclick="openCheckPlusPopup();return false;">휴대폰 인증</a>
			<a href="#" class="btn_h60_type1 mgl6" onclick="openIpinPopup();return false;">아이핀 인증</a>
		</div>
	</div>
</div>

