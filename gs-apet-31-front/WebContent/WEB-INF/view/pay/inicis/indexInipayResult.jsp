<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>



<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>INIpay</title>

<script type="text/javascript"  src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/jquery/jquery-1.11.3.min.js" ></script>

<script type="text/javascript">

	$(document).ready(function(){
		
		var data = {
				status : ""
				,message : ""
				,result : ""
		};
		
		data.status = $("#inpay_result_status").val();
		data.message = $("#inpay_result_message").val();
		data.result = $("#inpay_result_result").val();
		
		top.inipay.cbResult(data);
 	}); // End Ready


</script>
</head>

<body>
<input type="hidden" id="inpay_result_status" value="<c:out value="${status}" />" />
<input type="hidden" id="inpay_result_message" value="<c:out value="${message}" />" />
<input type="hidden" id="inpay_result_result" value="<c:out value="${result}" />" />
</body>
</html>
