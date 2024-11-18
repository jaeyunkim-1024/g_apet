<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<form id="goodsCopyForm" name="goodsCopyForm" method="post" >
	<table class="table_type1">
		<caption><spring:message code="admin.web.view.app.goods.copy"/></caption>
		<tbody>
			<tr>
				<!-- 복사대상 상품명 -->
				<th scope="row"><spring:message code="column.copy.goods_nm" /></th>
				<td>
					${goodsBase.goodsNm }
				</td>
			</tr>
			<tr>
				<!-- 업체명 -->
				<th scope="row"><spring:message code="column.goods.comp_nm" /></th>
				<td>
					${goodsBase.compNm }
				</td>
			</tr>
			<!-- 브랜드
			<tr>
				<th scope="row"><spring:message code="column.goods.brnd" /></th>
				<td>
					${goodsBase.bndNmKo }
				</td>
			</tr>
			-->
			<tr>
				<!-- 신규 상품명 -->
				<th scope="row"><spring:message code="column.copy.new_goods_nm" /></th>
				<td>
					<c:if test="${!empty goodsBase.stId}">
						<input type="hidden" id="stId" name="stId" value="${goodsBase.stId }" class="validate[required]"/>
					</c:if>
					<input type="hidden" id="goodsId" name="goodsId" value="${goodsBase.goodsId }" />
					<input type="text" class="w250 validate[required, maxSize[50]]" id="goodsNm" name="goodsNm"
					       title="<spring:message code="column.copy.new_goods_nm" />"
					       value="[<spring:message code="admin.web.view.app.goods.button.copy"/>] <c:out value="${goodsBase.goodsNm }"/>"
					/>
				</td>
			</tr>
			<!-- 신규 상품 가격
			<tr>
				<th scope="row"><spring:message code="column.copy.new_sale_amt" /></th> // 신규 상품 가격
				<td>
					<input type="text" class="w250 comma validate[required]" id="saleAmt" name="saleAmt" title="<spring:message code="column.copy.new_sale_amt" />" value="" />
				</td>
			</tr>
			-->
			<tr>
				<!-- 비고 -->
				<th scope="row"><spring:message code="column.bigo" /></th>
				<td>
					<textarea rows="3" cols="40" id="bigo" name="bigo" title="<spring:message code="column.bigo" />" ></textarea>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<p class="red-desc"><spring:message code="admin.web.view.app.goods.copy.desc"/></p>
</form>