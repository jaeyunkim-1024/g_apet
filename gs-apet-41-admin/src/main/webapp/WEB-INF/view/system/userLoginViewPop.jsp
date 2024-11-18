<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">
			$(document).on('userLoginViewInit', function(e, param1) {
				// 사용자 그리드
				createUserLoginGrid();
			});
			
			// 사용자 그리드
			function createUserLoginGrid(){
				var options = {
					url : "<spring:url value='/system/userLoginListGrid.do' />"
					, height : 370
					, searchParam : {
						usrNo : '${userBase.usrNo}'
					}
					, colModels : [
						// 사용자 번호
						{name:"usrNo", label:'<spring:message code="column.usr_no" />', width:"120", align:"center", sortable:false}
						, {name:"usrNm", label:'<spring:message code="column.usr_nm" />', width:"130", align:"center", sortable:false}
						, {name:"loginId", label:'<spring:message code="column.login_id" />', width:"150", align:"center", sortable:false}
						// 로그인 IP
						, {name:"loginIp", label:'<spring:message code="column.login_ip" />', width:"180", align:"center", sortable:false}
						// 로그인 일시
						, {name:"loginDtm", label:'<spring:message code="column.login_dtm" />', width:"170", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
					]
				};
				grid.create("userLoginList", options);
				
			}

		</script>

		<table id="userLoginList" ></table>
		<div id="userLoginListPage"></div>
