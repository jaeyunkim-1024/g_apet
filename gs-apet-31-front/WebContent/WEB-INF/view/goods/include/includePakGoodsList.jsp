<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">

	$(document).ready(function(){
	}); // End Ready

</script>

<c:forEach items="${listGoodsCstrtPak}" var="obj" varStatus="status">
<c:if test="${obj.goodsStatCd ne frontConstants.GOODS_STAT_10}"><!-- 묶음 대기상태 제외  -->
<c:set var="goodsIdStr" value="${obj.subGoodsId}:${obj.goodsId}"/>
	<li onclick="fnOption.exPaksAdd('add', ${obj.rownum }, '${obj.itemNo }', '${obj.saleAmt}', '${obj.imgPath}', '${obj.goodsNm}', '${obj.subGoodsId}', '${obj.minOrdQty}', '${obj.maxOrdQty}', '${obj.ordmkiYn}', '${status.count}', '${obj.salePsbCd}', '', '${obj.ioAlmYn}', '${so.saleAmt}')">
		<div class="unitSel gpic <c:if test="${obj.salePsbCd ne frontConstants.SALE_PSB_00}"> soldout </c:if>">
			<a class="box" href="javascript:;" >
				<div class="thum">
					<div class="pic">
<!-- 						직사각형을 정사각형으로 변경함. frontConstants.IMG_OPT_QRY_340 >>>> frontConstants.IMG_OPT_QRY_500 -->
						<img class="img" src="${frame:optImagePath( obj.imgPath , frontConstants.IMG_OPT_QRY_500 )}" onerror="this.src='${view.noImgPath}'" alt="상품">
						<c:if test="${obj.salePsbCd eq frontConstants.SALE_PSB_10}">
							<em class="sold">판매중지</em>
						</c:if>
						<c:if test="${obj.salePsbCd eq frontConstants.SALE_PSB_20}">
							<em class="sold">판매종료</em>
						</c:if>
						<c:if test="${obj.salePsbCd eq frontConstants.SALE_PSB_30}">
							<em class="sold"><spring:message code='front.web.view.common.goods.saleSoldOut.title'/></em>
						</c:if>
					</div>
				</div>
				<div class="infs">
					<div class="cate">상품${obj.rownum }</div>
					<span class="lk" style="word-break:break-all;">
						<%-- ${obj.cstrtShowNm} --%>
						${obj.goodsNm}
						<c:choose>
							<%-- ${goods.orgSaleAmt} --%>
							<c:when test="${obj.saleAmt > so.saleAmt}">
								(+<fmt:formatNumber value="${(obj.saleAmt - so.saleAmt)}" type="percent" pattern="#,###,###"/>원)
							</c:when>
							<c:when test="${obj.saleAmt < so.saleAmt}">
								(-<fmt:formatNumber value="${(so.saleAmt - obj.saleAmt)}" type="percent" pattern="#,###,###"/>원)
							</c:when>
						</c:choose>
					</span>
				</div>
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
								<button type="button" class="bt alim" onClick="fnRegAlim(event, this);"
												data-target="goods"
										        data-action="ioAlarm"
										        data-goods-id="${goodsIdStr}"
										        data-content="${goodsIdStr}">입고알림</button>
							</c:when>
							<c:otherwise>
								<span class="bt sold"><spring:message code='front.web.view.common.goods.saleSoldOut.title'/></span>
							</c:otherwise>
						</c:choose>
					</c:if>
				</div>
			</a>
		</div>
	</li>
</c:if>
</c:forEach>
