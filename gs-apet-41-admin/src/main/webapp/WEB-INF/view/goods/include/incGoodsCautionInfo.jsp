<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
				<div title="주의 사항" data-options="" style="padding:10px">
					<table class="table_type1">
						<caption>GOODS 등록</caption>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.goods_caution" /></th>	<!-- 상품 주의사항 -->
								<td>
									<textarea name="content_caution" id="content_caution" cols="30" rows="10" style="width: 100%">${goodsCaution.content }</textarea>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<hr />