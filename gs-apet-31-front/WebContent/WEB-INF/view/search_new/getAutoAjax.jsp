<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="framework.common.constants.CommonConstants" %> 
var dq_searchKeyword='<c:out value="${searchVo.searchQuery}" />';
var dq_searchResultList=new Array<c:choose><c:when test="${not empty autoList}">
<c:forEach var="searchList" items="${autoList}" varStatus="status" >
    	<c:choose><c:when test="${status.count eq 1}">('</c:when><c:otherwise>,'</c:otherwise></c:choose>${searchList.keyword}|${searchList.autoCount}'
</c:forEach>
</c:when><c:otherwise>(''</c:otherwise></c:choose>);