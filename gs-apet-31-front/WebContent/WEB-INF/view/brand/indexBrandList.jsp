<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %> 

<script type="text/javascript">


	// Start Ready
	$(document).ready(function(){
	
		
	});
	// End Ready
	
	// Start Function
	$(function() {
		

	});
	// End Function
	
	
</script>
<c:if test="${charKoList.size() <= 0 && charEnList.size() <= 0}">
<div>
	<div class="no_data">해당하는 브랜드가 없습니다.</div>
</div>		
</c:if>

<c:if test="${charKoList.size() > 0}">
<c:forEach items="${charKoList}" var="initChar">
	<dl>
		<dt><c:out value="${initChar}" /></dt>
		<dd>
		<c:if test="${brandListKo.size() <= 0}">
			해당하는 브랜드가 없습니다.
		</c:if>		
		<c:forEach items="${brandListKo}" var="brandList">
			<c:if test="${initChar eq brandList.charNmKo}">
				<a href="#" onclick="goBrandGoods('<c:out value='${brandList.bndNo}'/>');return false;"><c:out value="${brandList.bndNmKo}" /> <c:out value="${brandList.bndNmEn}" /></a>
			</c:if>
		</c:forEach>
		</dd>
	</dl>
</c:forEach>
</c:if>
<c:if test="${charEnList.size() > 0}">
<c:forEach items="${charEnList}" var="initChar">
	<dl>
		<dt><c:out value="${initChar}" /></dt>
		<dd>
		<c:if test="${brandListEn.size() <= 0}">
			해당하는 브랜드가 없습니다.
		</c:if>				
		<c:forEach items="${brandListEn}" var="brandList">
			<c:if test="${initChar eq brandList.charNmEn}">
				<a href="#" onclick="goBrandGoods('<c:out value='${brandList.bndNo}'/>');return false;"><c:out value="${brandList.bndNmEn}" /> <c:out value="${brandList.bndNmKo}" /></a>
			</c:if>
		</c:forEach>
		</dd>
	</dl>
</c:forEach>
</c:if>
