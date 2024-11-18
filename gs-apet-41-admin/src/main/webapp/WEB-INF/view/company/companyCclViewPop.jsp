<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">
			function companyCclInsert() {
				if(validate.check("companyCclViewForm")) {
					messager.confirm('<spring:message code="column.common.confirm.insert" />', function(r){
		                if (r){
		                	var options = {
								url : "<spring:url value='/company/companyCclInsert.do' />"
								, data : $("#companyCclViewForm").serializeJson()
								, callBack : function(result){
									reloadCompanyCclGrid();
									layer.close('companyCclView');
								}
							};

							ajax.call(options);
		                }
	            	});
				}
			}
		</script>
		<form name="companyCclViewForm" id="companyCclViewForm">
			<input type="hidden" name="compNo" id="compNo" value="${company.compNo}">
			<input type="hidden" name="stId" id="stId" value="${company.stId}">
			<jsp:include page="/WEB-INF/view/company/companyCclView.jsp" />
		</form>

