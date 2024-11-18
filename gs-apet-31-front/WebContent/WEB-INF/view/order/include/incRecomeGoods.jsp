<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript">
	$(document).ready(function(){
		<c:if test="${fn:length(cstrtList) > 0}">
			//추천상품 swipe
			$(".recoms").show();
			ui.order.cartrcm.using();
		</c:if>
	});
</script>

<div class="swiper-container slide">
	<ul class="swiper-wrapper list">
		<c:forEach var="goods" items="${cstrtList }">
			<li class="swiper-slide">
				<div class="boxset">
					<div class="thum">
						<!-- <div class="soldouts"><em class="ts">품절</em></div> -->
						<a href="${view.stDomain}/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="pic" data-content="${goods.goodsId}" data-url="${view.stDomain}/goods/indexGoodsDetail?goodsId=${goods.goodsId}">
							<img src="${fn:indexOf(goods.imgPath, 'cdn.ntruss.com') > -1 ? goods.imgPath : frame:optImagePath(goods.imgPath, frontConstants.IMG_OPT_QRY_270)}" alt="${goods.goodsNm }" class="img">
						</a>
						<button type="button" class="bt zzim ${goods.interestYn eq 'Y' ? 'on' : ''}" data-target="goods" data-action="interest" data-yn="N" data-goods-id="${goods.goodsId }" data-content="${goods.goodsId}" data-url="${view.stDomain}/goods/insertWish">찜하기</button>
						<%-- <button type="button" class="bt cart" onclick="cartGoods.insertCart('${goods.goodsId}', '${goods.itemNo }', '${goods.pakGoodsId }');" data-content="${goods.goodsId}" data-url="${view.stDomain}/goods/indexGoodsDetail?goodsId=${goods.goodsId}">장바구니담기</button> --%>
					</div>
					<div class="boxs">
						<div class="tit"><a href="${view.stDomain}/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="lk" data-content="${goods.goodsId}" data-url="${view.stDomain}/goods/indexGoodsDetail?goodsId=${goods.goodsId}">${goods.goodsNm }</a></div>
						<a class="inf" href="${view.stDomain}/goods/indexGoodsDetail?goodsId=${goods.goodsId}" data-content="${goods.goodsId}" data-url="${view.stDomain}/goods/indexGoodsDetail?goodsId=${goods.goodsId}">
							<span class="prc"><em class="p"><frame:num data="${goods.salePrc }"/></em><i class="w">원</i></span>
							<c:if test="${goods.orgSalePrc > goods.salePrc and ((goods.orgSalePrc - goods.salePrc)/goods.orgSalePrc * 100) > 1 }">
								<span class="pct"><em class="n"><fmt:parseNumber value="${(goods.orgSalePrc - goods.salePrc)/goods.orgSalePrc * 100}" integerOnly="true"/></em> <i class="w">%</i></span>
							</c:if>
						</a>
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