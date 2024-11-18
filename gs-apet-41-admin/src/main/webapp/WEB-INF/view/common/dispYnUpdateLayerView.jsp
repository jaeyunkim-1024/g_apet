<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<form id="dispYnUpdateForm" name="dispYnUpdateForm" method="post" >

				<table class="table_type1 popup">
					<caption>전시여부 일괄수정</caption>
					<tbody>

						<tr>
							<th scope="row"><spring:message code="column.disp_yn" /></th> <!-- 전시여부 -->
							<td>
								<frame:radio name="dispYn" grpCd="${adminConstants.DISP_YN }" />
							</td>
						</tr>

					</tbody>
				</table>


</form>