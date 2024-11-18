<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
	<div title="상세 정보" data-options="" style="padding:10px">
		<table class="table_type1">
			<caption>GOODS 등록</caption>
			<tbody>
				<tr>
					<th scope="row"><spring:message code="column.goods_content_pc" /><strong class="red offLineCntrl"><c:if test="${goodsBase.webMobileGbCd eq null || goodsBase.webMobileGbCd ne adminConstants.WEB_MOBILE_GB_30}">*</c:if></strong></th>	<!-- 상품 상세설명 [PC] -->
					<td>
						<textarea name="contentPc" id="contentPc" class="validate[required]" cols="30" rows="10" style="width: 100%">${goodsDesc.contentPc }</textarea>
					</td>
				</tr>
				<tr>
					<th scope="row"><spring:message code="column.goods_content_mobile" /></th>	<!-- 상품 상세설명 [MOBILE] -->
					<td>
						<textarea name="contentMobile" id="contentMobile" cols="30" rows="10" style="width: 100%">${goodsDesc.contentMobile }</textarea>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<hr />