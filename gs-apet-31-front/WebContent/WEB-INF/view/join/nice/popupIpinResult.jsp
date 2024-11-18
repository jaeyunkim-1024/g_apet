<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>VALUEFACTORY</title>

<script type="text/javascript"  src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/jquery/jquery-1.11.3.min.js" ></script>


<script type="text/javascript">


	$(document).ready(function(){
		<c:if test="${ctfData.rtnCode eq 'true'}">
		returnCertificationInfo();
		</c:if>
		<c:if test="${ctfData.rtnCode ne 'true'}">
		$("#ipin_result_msg").html("<c:out value="${ctfData.rtnMsg}" />");
		</c:if>
		
	}); // End Ready

	$(function() {
		
	});

	/*
	 * 인증이 완료된 데이터를  상위 창에 리턴
	 */
	function returnCertificationInfo(){
		var data = {
			authType : "10",
			encData : "<c:out value="${encData}" />",
			paramR1 : "<c:out value="${paramR1}" />",
			paramR2 : "<c:out value="${paramR2}" />",
			paramR3 : "<c:out value="${paramR3}" />"
		};
		top.returnIpin(data);
	}



</script>
</head>
<body>
	<div id="ipin_result_msg">
	</div>
</body>
</html>