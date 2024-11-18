<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<%--
<form id="mbrGrdUpdateForm" name="mbrGrdUpdateForm" method="post" >
				<table class="table_type1">
					<caption>회원 등급 일괄 변경</caption>
					<tbody>
						<tr>
							<th scope="row"><spring:message code="column.mbr_stat_cd" /><strong class="red">*</strong></th>
							<td>
								<!-- 회원 등급 코드-->
								<select name="mbrGrdCd" title="<spring:message code="column.mbr_grd_cd"/>">
									<frame:select grpCd="${adminConstants.MBR_GRD}" />
								</select>
							</td>
						</tr>
					</tbody>
				</table>
</form>--%>

<form id="mbrStatUpdateForm" name="mbrStatUpdateForm" method="post" >
	<table class="table_type1">
		<caption>회원 상태 변경</caption>
		<tbody>
		<tr>
			<th scope="row"><spring:message code="column.mbr_stat_cd" /><strong class="red">*</strong></th>
			<td>
				<!-- 회원 등급 코드-->
				<select name="mbrStatCd" title="회원 상태">
					<frame:select grpCd="${adminConstants.MBR_STAT_CD}"  selectKey="${mbrStatCd}"/>
				</select>
			</td>
		</tr>
		</tbody>
	</table>
</form>
