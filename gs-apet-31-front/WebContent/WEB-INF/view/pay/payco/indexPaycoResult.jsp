<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>


<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>Insert title here</title>

<script type="text/javascript"  src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/jquery/jquery-1.11.3.min.js" ></script>

<script type="text/javascript">

	$(document).ready(function(){
		returnTop();
 	}); // End Ready

	$(function() {
	});
 	
 	function returnTop(){
 		var data = {
 			code : "<c:out value="${result.code}" />",
 			message : "<c:out value="${result.message}" />",
 			reserveOrderNo : "<c:out value="${result.reserveOrderNo}" />",
 			sellerOrderReferenceKey : "<c:out value="${result.sellerOrderReferenceKey}" />",
 			paymentCertifyToken : "<c:out value="${result.paymentCertifyToken}" />",
 			totalPaymentAmt : "<c:out value="${result.totalPaymentAmt}" />",
 			cart_no : "<c:out value="${result.cart_no}" />"
 		};
 		top.retunPay(data);
 	}

</script>

<body>
</body>
</html>
