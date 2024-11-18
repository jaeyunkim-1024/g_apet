<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<tiles:insertDefinition name="common_my_mo">
	
	<tiles:putAttribute name="script.include" value="script.petlog"/> <!-- 지정된 스크립트 적용 -->
	
	<%-- 
	Tiles script.inline put
	불 필요시, 해당 영역 삭제 
	--%>
	<tiles:putAttribute name="script.inline">	
		<script>
			// action log 처리
			userActionLog('${petLogBase.petLogNo}', 'view');		
		</script>
			
	</tiles:putAttribute>

	<tiles:putAttribute name="content">
		<!-- 바디 - 여기위로 템플릿 -->
		<jsp:include page="/WEB-INF/view/petlog/include/includePetLogDetail.jsp" />	
	</tiles:putAttribute>
	
	<tiles:putAttribute name="layerPop">
		<jsp:include page="/WEB-INF/view/petlog/layerPetLogReplyReport.jsp" />	
<%-- <c:if test="${adminYn eq null or adminYn eq '' or  adminYn eq 'N'}">			 --%>
<%-- 		<jsp:include page="/WEB-INF/view/petlog/layerBottomRegist.jsp" />	 --%>
<%-- </c:if> --%>
	</tiles:putAttribute>	
</tiles:insertDefinition>