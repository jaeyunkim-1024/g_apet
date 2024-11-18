<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>

<script type="text/javascript">


	
	$(document).ready(function(){

		$("#receipt_frame").height($("#<c:out value="${param.popId}" />").height());
		
		$("#receipt_form").attr("target", "receipt_frame");
		$("#receipt_form").attr("action", "${receiptUrl}");
		$("#receipt_form").submit();
		
	}); // End Ready

	$(function() {
		

	});

	
</script>

<form id="receipt_form" name="receipt_form" method="post" >
</form>

<iframe id="receipt_frame" name="receipt_frame" width="100%" height="100%">
</iframe>

