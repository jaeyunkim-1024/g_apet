<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">

	$(document).ready(function(){
		$("#divAttrInfs").trigger("click");
	}); // End Ready

</script>

<c:forEach items="${listOptionGoodsCstrtPak}" var="obj" varStatus="status">
<li>
	<div class="unitRes">
		<a class="box" href="javascript:" >
			<div class="infs" id="divAttrInfs" onclick="fnOption.exPaksAdd('add', ${obj.rownum }, '${obj.itemNo }', '${obj.saleAmt}', '${obj.imgPath}', '${obj.goodsNm}', '${obj.subGoodsId}', '${obj.minOrdQty}', '${obj.maxOrdQty}', '${obj.ordmkiYn}', '${status.count}', '${obj.salePsbCd}', '', '${obj.ioAlmYn}', '${so.saleAmt}')">
				<div class="cate">상품${obj.rownum }</div>
				<%-- <div class="cate">${obj.bndNmKo }</div> --%>
				<%-- <a href="javascript:" class="lk">${obj.cstrtShowNm}</a> --%>
				<span class="lk">${obj.goodsNm}</span>
			</div>
		</a>
		<div class="cots">
			<div class="price">
				<c:if test="${obj.salePsbCd eq frontConstants.SALE_PSB_00}">
					<em class="p"><fmt:formatNumber type="number" value="${obj.saleAmt}"/></em><i class="w">원</i>								
				</c:if>
				<c:if test="${obj.salePsbCd eq frontConstants.SALE_PSB_10}">
					<span class="bt sold">판매중지</span>
				</c:if>
				<c:if test="${obj.salePsbCd eq frontConstants.SALE_PSB_20}">
					<span class="bt sold">판매종료</span>
				</c:if>
				<c:if test="${obj.salePsbCd eq frontConstants.SALE_PSB_30}">
					<c:choose>
						<c:when test="${obj.ioAlmYn eq 'Y'}">
							<button type="button" class="bt alim">입고알림</button>
						</c:when>
						<c:otherwise>
							<span class="bt sold"><spring:message code='front.web.view.common.goods.saleSoldOut.title'/></span>
						</c:otherwise>
					</c:choose>
				</c:if>
			</div>
		</div>
	</div>
</li>
</c:forEach>
