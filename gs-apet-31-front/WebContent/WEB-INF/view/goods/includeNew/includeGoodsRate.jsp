<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:if test="${not empty recommendGoodsRate}">
	<div class="match">
		<div class="msg">사용자 관심상품과 <fmt:parseNumber value="${recommendGoodsRate}" integerOnly="true"/>% 일치해요🎯</div>
	</div>
</c:if>