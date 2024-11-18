<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">

	/* $(function() {
		<c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}" >
		$("#userSearchShowAllLowCompany").click(function(){
			 if ($(this).is(":checked")) {
				$("#userSearchCompNo").val ('${adminSession.compNo}' );
				$("#userSearchCompNm").val ('${adminSession.compNm}' );
			 }else{
				$("#userSearchCompNo").val ('');
				$("#userSearchCompNm").val ('');
			 }
		});
		</c:if>
	}); */

	function searchUserCompany(){
		layerCompanyList.create({multiselect:false, callBack:cbUserCompany});
	}
	
	function cbUserCompany(compList){
		if(compList.length > 0 ) {
			$("#userSearchCompNo").val (compList[0].compNo );
			$("#userSearchCompNm").val (compList[0].compNm );
		}
	}
</script>

<form id="layerUserSearchForm" name="layerUserSearchForm" method="post" >
	<table class="table_type1 popup">
		<caption>사용자 검색</caption>
		<tbody>
		
			<tr>
				<th scope="row"><spring:message code="column.usr_gb_cd" /></th>
				<td> 
					<select name="usrGbCd" id="usrGbCd" title="<spring:message code="column.usr_gb_cd" />"  <c:if test="${!empty param.usrGbCd}">disabled="disabled"</c:if>>
						<frame:select grpCd="${adminConstants.USR_GB}" defaultName="전체" selectKey="${param.usrGbCd}" usrDfn2Val="${adminSession.usrGrpCd eq adminConstants.USR_GRP_10 ? adminConstants.USR_GB_BO  :  adminConstants.USR_GB_PO}" />
					</select>
				</td>
				<th scope="row"><spring:message code="column.usr_stat_cd" /></th>
				<td>
					<select  name="usrStatCd" id="usrStatCd" title="<spring:message code="column.usr_stat_cd" />" <c:if test="${!empty param.usrStatCd}">disabled="disabled"</c:if>>
						<frame:select grpCd="${adminConstants.USR_STAT}" defaultName="전체" selectKey="${param.usrStatCd}" />
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row"><spring:message code="column.usr_id" /></th>
				<td>
					<input type="text" name="loginId" title="<spring:message code="column.login_id" />" >
				</td>
				<th scope="row"><spring:message code="column.usr_nm" /></th>
				<td>
					<input type="text" name="usrNm" title="<spring:message code="column.usr_nm" />" >
				</td>
			</tr>
               <tr>
                   <th scope="row"><spring:message code="column.goods.comp_no" /></th> <!-- 업체번호 -->
                   <td colspan="3">
                   	<input type="hidden" name="compNo" id="userSearchCompNo" value="${param.compNo}" />
                   	<input type="text" id="userSearchCompNm" value="${param.compNm}" class="readonly" readonly="readonly"  />
                   	<c:if test="${empty param.compNo}">
					<button type="button" onclick="searchUserCompany();" class="btn">검색</button>
					</c:if>
                   </td>
               </tr>
		</tbody>
	</table>
</form>
 
	<div class="btn_area_center mb30">
		<button type="button" onclick="layerUserList.searchUserList();" class="btn btn-ok">검색</button>
		<button type="button" onclick="layerUserList.searchReset();" class="btn btn-cancel">초기화</button>
	</div>
	
	<table id="layerUserList" ></table>
	<div id="layerUserListPage"></div>
