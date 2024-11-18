<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<script type="text/javascript">

	$(document).ready(function(){
		$("#pop_container").css("max-height", "none");
		
		<c:if test="${checkPlus.rtnCode eq 'true'}">
		loadChekPlusPage();
		</c:if>
		<c:if test="${checkPlus.rtnCode ne 'true'}">
		alert("<c:out value="${checkPlus.rtMmsg}" />");
		pop.close("<c:out value="${param.popId}" />");
		</c:if>
		
	}); // End Ready

	$(function() {
		
	});

	/*
	 * 휴대폰 인증 페이지 호출
	 */
	function loadChekPlusPage(){
		/* TODO : 데모 작업을 위해 로직 하드코딩
		$("#checkplus_form").attr("target", "checkplus_iframe");
		$("#checkplus_form").attr("action", "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb");
		$("#checkplus_form").submit();
		*/
		$("#checkplus_form").attr("target", "checkplus_iframe");
		$("#checkplus_form").attr("action", "/join/popupCheckPlusSuccess");
		$("#checkplus_form").submit();
	}

	/*
	 * 인증정보 부모창에 리턴
	 */
	function returnCheckPlus(data){
		console.log(data);
		<c:out value="${param.callBackFnc}" />(data);
		
		pop.close("<c:out value="${param.popId}" />");
	}

</script>
<form id="checkplus_form" method="post">
	<input type="hidden" name="m" value="checkplusSerivce">						<!-- 필수 데이타로, 누락하시면 안됩니다. -->
    <input type="hidden" name="EncodeData" value="<c:out value="${checkPlus.encData}" />">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
    
    <!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
    	 해당 파라미터는 추가하실 수 없습니다. -->
    <input type="hidden" name="param_r1" value="<c:out value="${checkPlus.paramR1}" />">
    <input type="hidden" name="param_r2" value="<c:out value="${checkPlus.paramR2}" />">
    <input type="hidden" name="param_r3" value="<c:out value="${checkPlus.paramR3}" />">
</form>

<iframe id="checkplus_iframe" name="checkplus_iframe" width="100%" height="710px">

</iframe>
