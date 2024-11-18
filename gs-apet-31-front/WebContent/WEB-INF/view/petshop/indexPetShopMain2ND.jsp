<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<c:forEach var="cornerList" items="${totalCornerList}"  varStatus="status" >
	<jsp:include page="/WEB-INF/view/petshop/include/${cornerList.dispCornPage}">
		<jsp:param value="${cornerList.dispCornNo}" name="dispCornNo"/>
	</jsp:include>
</c:forEach>
