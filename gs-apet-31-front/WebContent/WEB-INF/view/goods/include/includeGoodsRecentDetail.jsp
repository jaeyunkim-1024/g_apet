<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">

</script>
<c:if test="${not empty listGoodsCstrt}">
<section class="sec recomd">
	<div class="hdts">
		<span class="tit"><em class="t">함께 많이 보는 상품</em></span>
		<p class="p">많은 분들이 이 상품에도 관심을 갖고 있어요.</p>
	</div>
	<div class="cdts">
		<div class="ui_recomd_slide">
			<!-- ui.shop.recomd.using(); -->
			<div class="swiper-container slide">
				<ul class="swiper-wrapper list">
					<c:forEach items="${listGoodsCstrt}" var="item" end="9" varStatus="idx">
						<li class="swiper-slide">
							<div class="recomdSet">
								<div class="thum">
									<a href="/goods/indexGoodsDetail?goodsId=${item.cstrtGoodsId}" class="pic">
										<c:if test="${item.soldOutYn eq 'Y'}">
											<div class="soldouts"><em class="ts"><spring:message code='front.web.view.common.goods.saleSoldOut.title'/></em></div>
										</c:if>
<!-- 										직사각형을 정사각형으로 변경함. frontConstants.IMG_OPT_QRY_340 >>>> frontConstants.IMG_OPT_QRY_500 -->
										<img class="img" src="${frame:optImagePath( item.imgPath , frontConstants.IMG_OPT_QRY_500 )}" alt="" />
									</a>
									<button type="button" class="bt zzim<c:if test="${item.interestYn eq 'Y'}">on</c:if>" data-content="${item.goodsId}" data-target="goods" data-action="interest">찜하기</button>
								</div>
								<div class="boxs">
									<div class="tit"><a href="/goods/indexGoodsDetail?goodsId=${item.cstrtGoodsId}" class="lk">${item.goodsNm}</a></div>
									<div class="inf">
										<span class="prc"><em class="p"><fmt:formatNumber type="number" value="${item.saleAmt}"/></em><i class="w">원</i></span>
										<c:if test="${item.orgSaleAmt > item.saleAmt and ((item.orgSaleAmt - item.saleAmt)/item.orgSaleAmt * 100) > 1 }">
											<span class="pct"><em class="n"><fmt:formatNumber value="${(item.orgSaleAmt - item.saleAmt)/item.orgSaleAmt * 100}" type="percent" pattern="#,###,###"/></em><i class="w">%</i></span>
										</c:if>

									</div>
								</div>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
			<div class="sld-nav">
				<button type="button" class="bt prev">이전</button>
				<button type="button" class="bt next">다음</button>
			</div>
		</div>
	</div>
</section>
</c:if>
