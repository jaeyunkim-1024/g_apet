<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>Insert title here</title>

<script type="text/javascript"  src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/jquery/jquery-1.11.3.min.js" ></script>


<script type="text/javascript">


	$(document).ready(function(){
		<c:if test="${ctfData.rtnCode eq 'true'}">
		returnCertificationInfo();
		</c:if>
		<c:if test="${ctfData.rtnCode ne 'true'}">
		$("#checkplus_result_msg").html("<c:out value="${ctfData.rtnMsg}" />");
		</c:if>
		
	}); // End Ready

	$(function() {
		
	});

	/*
	 * 인증데이터 리턴
	 */
	function returnCertificationInfo(){
		var data = {
			authType : "20",
			encData : "<c:out value="${EncodeData}" />",
			paramR1 : "<c:out value="${paramR1}" />",
			paramR2 : "<c:out value="${paramR2}" />",
			paramR3 : "<c:out value="${paramR3}" />"
		};

		top.returnCheckPlus(data);
	}


</script>
</head>
<body>
	<div id="checkplus_result_msg">
	</div>
</body>
</html>