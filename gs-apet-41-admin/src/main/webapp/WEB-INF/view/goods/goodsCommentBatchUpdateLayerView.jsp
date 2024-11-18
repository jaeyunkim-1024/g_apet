<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<form id="goodsCommentBatchUpdateForm" name="goodsCommentBatchUpdateForm" method="post" >

				<table class="table_type1">
					<caption>상품평 일괄 변경</caption>
					<tbody>

						<tr>
							<th scope="row"><spring:message code="column.sys_del_yn" /></th> <!-- 삭제여부 -->
							<td>
								<frame:radio name="sysDelYn" grpCd="${adminConstants.COMM_YN }" />
							</td>
						</tr>

					</tbody>
				</table>
</form>