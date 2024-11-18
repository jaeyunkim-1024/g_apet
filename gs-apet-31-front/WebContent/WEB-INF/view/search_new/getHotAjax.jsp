<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="framework.common.constants.CommonConstants" %> 

<c:set var = "cnt" value="${fn:length(hotList)}"/>
<ul>
<c:forEach var="hotList" items="${hotList}" varStatus="index">
	<li><a href="javascript:goDirectSearch('${hotList.keyword}');">${hotList.hotRanking}. ${hotList.keyword}</a></li>
	<c:if test="${index.count eq cnt}"></ul><div class="info_msg"><span class="date">${hotList.hotDate} 기준</span></div></c:if>
</c:forEach>