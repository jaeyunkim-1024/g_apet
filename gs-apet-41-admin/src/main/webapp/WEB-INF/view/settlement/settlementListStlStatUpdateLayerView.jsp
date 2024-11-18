<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<form id="settlementListStlStatUpdateForm" name="settlementListStlStatUpdateForm" method="post" >
	<table class="table_type1">
		<caption>정산 여부 일괄 변경</caption>
		<tbody>
			<tr>
				<th scope="row"><spring:message code="column.settlement.stl_stat_cd" /><strong class="red">*</strong></th>
				<td>
					<!-- 정산 여부 -->
					<select name="stlStatCd" title="<spring:message code="column.settlement.stl_stat_cd"/>">
						<frame:select grpCd="${adminConstants.STL_STAT}" />
					</select>
				</td>
			</tr>
		</tbody>
	</table>
</form>