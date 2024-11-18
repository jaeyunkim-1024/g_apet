<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
	<style>
		.authButton	{ padding:5px }
		.authButton:hover { text-decoration:none; background-color:#f2f2f2 }
	</style>
	
	<script type="text/javascript">
		var authNo = -1;
		
		$(document).on('userAuthMenuViewInit', function(e, param1) {
			createUserAuthMenuGrid();
		});
		
		function createUserAuthMenuGrid(){
			var options = {
				url : "<spring:url value='/system/userAuthMenuListGrid.do' />"			
				, height : 370
				, paging : false
				, searchParam : {
					authNo : authNo
				}
				, colModels : [
					{name:"menuNmOne", label:'<spring:message code="column.menu_nm_one" />', width:"200", align:"center", sortable:false, classes:'fontbold'}
					, {name:"menuNmTwo", label:'<spring:message code="column.menu_nm_two" />', width:"200", align:"center", sortable:false}
					, {name:"menuNmThree", label:'<spring:message code="column.menu_nm_three" />', width:"200", align:"center", sortable:false}
				]
			};		
			grid.create("userAuthMenuList", options);	
		}
		
		$(".authButton").on('click', function(obj){
			var authButtonStyle = { 'padding':'5px', 'text-decoration':'none', 'background-color':'#f2f2f2' };
			
			$(".authButton").removeAttr("style");
			$("#" + obj.target.id).css(authButtonStyle);
			
			authNo = obj.target.id;
			
			reloadGrid();
		});
		
		function reloadGrid(){
			var options = {
				searchParam : {
					authNo : authNo
				}
			};

			grid.reload("userAuthMenuList", options);
		}

	</script>
		
	<table class="table_type1 mg5">
		<caption>사용자 등록</caption>
		<tbody>
			<%-- <tr>
				<th><spring:message code="column.usr_id" /></th>
				<td>
					${userBase.loginId }
				</td>
				<th><spring:message code="column.usr_nm" /></th>
				<td>
					${userBase.usrNm }
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.dp_nm" /></th>
				<td colspan="3">
					${userBase.dpNm }
				</td>
			</tr> --%>
			<tr>
				<th><spring:message code="column.auth_nm" /></th>
				<td colspan="3">
					<c:forEach items="${userAuthList}" var="item">
						<c:if test="${usrGrpCdGb eq adminConstants.USR_GRP_10 }">
							<c:if test="${item.authNo ne 103 }">
								<a id="${item.authNo }" name="${item.authNo }" class="authButton" >${item.authNm }</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</c:if>
						</c:if>
						<c:if test="${usrGrpCdGb eq adminConstants.USR_GRP_20 }">
							<c:if test="${item.authNo eq 103 }">
								<a id="${item.authNo }" name="${item.authNo }" class="authButton" >${item.authNm }</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</c:if>
						</c:if>
					</c:forEach>
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.user_menu" /></th>
				<td colspan="3">
					<table id="userAuthMenuList" class="grid"></table>
				</td>
			</tr>
		</tbody>
	</table>
