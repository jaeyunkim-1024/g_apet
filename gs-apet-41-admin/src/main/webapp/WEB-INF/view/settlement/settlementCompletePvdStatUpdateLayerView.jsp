<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<form id="settlementCompletePvdStatUpdateForm" name="settlementCompletePvdStatUpdateForm" method="post" >
	<table class="table_type1">
		<caption>지급 여부 일괄 변경</caption>
		<tbody>
			<tr>
				<th scope="row"><spring:message code="column.settlement.pvd_stat_cd" /><strong class="red">*</strong></th>
				<td>
					<!-- 지급 상태 -->
					<select name="pvdStatCd" title="<spring:message code="column.settlement.pvd_stat_cd"/>">
						<frame:select grpCd="${adminConstants.PVD_STAT}" />
					</select>
				</td>
			</tr>
		</tbody>
	</table>
</form>