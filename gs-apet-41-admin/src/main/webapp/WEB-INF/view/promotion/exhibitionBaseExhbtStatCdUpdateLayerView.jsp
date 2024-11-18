<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<form id="exhibitionBaseExhbtStatCdUpdateForm" name="exhibitionBaseExhbtStatCdUpdateForm" method="post" >

				<table class="table_type1">
					<caption>기획전상태 일괄수정</caption>
					<tbody>

						<tr>
							<th scope="row"><spring:message code="column.exhbt_stat_cd" /></th> <!-- 기획전 승인 상태 코드 -->
							<td>
								<select name="exhbtStatCd" id="exhbtStatCd" title="<spring:message code="column.exhbt_stat_cd"/>">
									<frame:select grpCd="${adminConstants.EXHBT_STAT}" selectKey="${adminConstants.EXHBT_STAT_20}"/>
								</select>
							</td>
						</tr>

					</tbody>
				</table>

</form>