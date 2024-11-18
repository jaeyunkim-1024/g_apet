<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="blankLayout">
<t:putAttribute name="content">
<c:choose>
<c:when test="${not empty result && result eq true }">
OK
</c:when>
<c:otherwise>
FAIL
</c:otherwise>
</c:choose>

</t:putAttribute>
</t:insertDefinition>