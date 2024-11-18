<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<form id="goodsPriceBulkOrdEndYnUpdateForm" name="goodsPriceBulkOrdEndYnUpdateForm" method="post" >

				<table class="table_type1">
					<caption>공동구매 상태 일괄수정</caption>
					<tbody>

						<tr>
							<th scope="row"><spring:message code="column.bulk_ord_end_yn_stat" /></th> <!-- 공동구매 종료 여부 -->
							<td>
								<select name="bulkOrdEndYn" id="bulkOrdEndYn" title="<spring:message code="column.bulk_ord_end_yn"/>">
									<frame:select grpCd="${adminConstants.BULK_ORD_END_YN}" selectKey="${adminConstants.BULK_ORD_END_YN_N}"/>
								</select>
							</td>
						</tr>

					</tbody>
				</table>

</form>