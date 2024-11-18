<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<c:if test="${goodsBase.goodsCstrtTpCd ne adminConstants.GOODS_CSTRT_TP_ITEM && goodsBase.goodsCstrtTpCd ne adminConstants.GOODS_CSTRT_TP_SET}">
<script>
	messager.alert("<spring:message code='admin.web.view.app.goods.comment.copy.available.item.set'/>", "Info", "info", function () {
		//callBackSaveSeoInfo(result.seoInfoNo);
		layer.close("goodsCommentCopy");
	}););
</script>
</c:if>

<form id="goodsCommentCopyForm" name="goodsCommentCopyForm" method="post" >
	<table class="table_type1">
		<caption><spring:message code="admin.web.view.app.goods.copy"/></caption>
		<tbody>
			<tr>
				<!-- 복사 상품명 -->
				<th scope="row"><spring:message code='column.copy.comment.target.goods_nm'/></th>
				<td>
					${goodsBase.goodsNm }
				</td>
			</tr>
			<tr>
				<!-- 복사 대상 상품명 -->
				<th scope="row"><spring:message code='column.copy.comment.origin.goods_nm'/></th>
				<td>
					<input type="hidden" id="copyTargetGoodsId" name="goodsId" title="복사대상 상품 ID" value="${goodsBase.goodsId}" />
					<input type="hidden" id="fstGoodsId" name="fstGoodsId" title="원 상품 ID" value="" />
					<input type="text" class="w250 readonly validate[required]" id="fstGoodsNm" name="goodsNm" title="원 상품명" readonly="readonly" value="" />
					<button type="button" class="btn" onclick="goodsLayerView(); return false;">
						<spring:message code="admin.web.view.common.search"/>
					</button>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<p class="red-desc"></p>
</form>