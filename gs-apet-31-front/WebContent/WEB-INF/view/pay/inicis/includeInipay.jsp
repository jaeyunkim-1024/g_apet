<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>

<!doctype html>
<html lang="ko">
<head>
<script type="text/javascript"  src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/jquery/jquery-1.11.3.min.js" ></script>
<script language="javascript" type="text/javascript" src="${pgSession.scrtPth}" charset="UTF-8"></script>

<script type="text/javascript">


	
	$(document).ready(function(){

		INIStdPay.pay('SendPayForm_id');

	}); // End Ready

	$(function() {
		

	});
	
</script>
</head>
<body>
<form id="SendPayForm_id" name="SendPayForm_id" method="post" >

<input type="hidden" name="version" value="${pgSession.version}" />		<!-- version -->
<input type="hidden" name="mid" value="${pgSession.mid}" />	<!-- 상점아이디 -->
<input type="hidden" name="goodname" value="${prodNm}" />			<!-- 상품명 -->
<input type="hidden" name="oid" value="${param.ordNo}" />	<!-- 가맹점 주문 번호 -->
<input type="hidden" name="price" value="${param.payAmt}" />	<!-- 결제 금액 -->
<input type="hidden" name="currency" value="${pgSession.currency}" />	<!-- 결제 단위 -->
<input type="hidden" name="buyername" value="${param.ordNm}" />	<!-- 주문자 -->
<input type="hidden" name="buyertel" value="${param.ordrMobile}" />	<!-- 주문자 핸드폰 -->
<input type="hidden" name="buyeremail" value="${param.ordrEmail}" />	<!-- 주문자 이메일 -->
<input type="hidden" name="timestamp" value="${pgSession.timestamp}" />	<!-- 세션 : 인증시간 -->
<input type="hidden" name="signature" value="${pgSession.signature}" />	<!-- signature -->
<input type="hidden" name="charset" value="${pgSession.returnCharset}" />	<!-- Return Charset -->
<input type="hidden" name="returnUrl" value="${pgSession.returnUrl}" />	<!-- Return Url -->
<input type="hidden" name="closeUrl" value="${pgSession.closeUrl}" />	<!-- Close Url -->
<input type="hidden" name="mKey" value="${pgSession.mkey}" />	<!-- mKey -->
<input type="hidden" name="merchantData" value="" />	<!-- 가맹점 관리데이터 -->
<input type="hidden" name="gopaymethod" value="${pgSession.gopaymethod}" />	<!-- 결제수단 -->

<%-- 신용카드 추가 정보 --%>
<input type="hidden" name="quotabase" value="${pgSession.cardQuotaBase}" />	<!-- 할부 개월 설정 -->
<input type="hidden" name="nointerest" value="${pgSession.cardNointerest}" />	<!-- 가맹점 무이자 정보 설정 -->

<input type="hidden" name="acceptmethod" value="${pgSession.acceptmethod}" />	<!-- 추가 요청 필드 -->

</form>
</body>
</html>