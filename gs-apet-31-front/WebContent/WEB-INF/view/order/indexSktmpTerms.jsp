<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<tiles:insertDefinition name="default">
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">
			$(document).ready(function(){
				//닫기
				$(document).on("click" , ".btnPopClose" , function(){
					window.self.close();
				});
			});
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<c:forEach items="${termsList }" var="term" varStatus="stat">
		<!-- 이용 약관 -->
		<c:if test="${stat.index eq termsIndex}">
		<article class="popLayer win a popWoozooTerm" id="mpTermsContentPop_bc${stat.index }">
			${term.content }
		</article>
		</c:if>
		</c:forEach>
	</tiles:putAttribute>
</tiles:insertDefinition>