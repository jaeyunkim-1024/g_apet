<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<script type="text/javascript">

	var rdata = {
		code : "",
		message : "",
			reserveOrderNo : "",
			sellerOrderReferenceKey : "",
			paymentCertifyToken : "",
			totalPaymentAmt : "",
			cart_no : ""			
	};
	
	$(document).ready(function(){
		$("#pop_container").css("max-height", "none");
		
		<c:if test="${result.code eq '0'}">
		loadPaycoPage("<c:out value="${result.result.orderSheetUrl}" />");
		</c:if>
		<c:if test="${result.code ne '0'}">
		alert("<c:out value="${result.message}" />");
		retunPay({code:'<c:out value="${result.code}" />', message : '<c:out value="${result.message}" />'});
		</c:if>
		
	}); // End Ready

	$(function() {
		
	});

	function loadPaycoPage(url){
		$("#payco_pop_form").attr("target", "payco_iframe");
		$("#payco_pop_form").attr("action", url);
		$("#payco_pop_form").submit();
	}
	
	function retunPay(data){

		rdata = data;
		<c:out value="${param.callBackFnc}" />(rdata);
		
		pop.close("<c:out value="${param.popId}" />");

	}

</script>
<form id="payco_pop_form" method="post">
</form>
<iframe id="payco_iframe" name="payco_iframe" width="100%" height="560">

</iframe>
