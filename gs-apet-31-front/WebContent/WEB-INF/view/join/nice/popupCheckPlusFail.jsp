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

		
	}); // End Ready

	$(function() {
		
	});



</script>
</head>
<body>
	<c:if test="${ctfData.rtnCode eq 'true'}">
	<ul>
		<li><spring:message code="front.web.view.join.checkplus.fail.msg.01" /></li>
		<li><spring:message code="front.web.view.join.checkplus.fail.msg.02" /></li>
		<li><spring:message code="front.web.view.join.checkplus.fail.msg.03" /></li>
	</ul>
	<%-- 
	<ul>
		<li><spring:message code="front.web.view.join.checkplus.fail.msg.1" /></li>
		<li><spring:message code="front.web.view.join.checkplus.fail.msg.2" /></li>
		<li><spring:message code="front.web.view.join.checkplus.fail.msg.error_code" /> : <c:out value="${ctfData.errorCode}" /></li>
	</ul> 
	--%>
	</c:if>
	<c:if test="${ctfData.rtnCode ne 'true'}">
	<c:out value="${ctfData.rtnMsg}" />
	</c:if>
</body>
</html>