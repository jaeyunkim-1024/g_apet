<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<c:if test="${not empty recentGoods}">
<!-- 	<section class="sec recent"> -->
	<div class="hdts">
		<span class="tit">
			<a href="/mypage/indexRecentViews" data-content="" data-url="/mypage/indexRecentViews" class="t">최근 본 상품</a>
		</span>
	</div>
	<div class="cdts">
		<div class="ui_recent_slide">
			<!-- ui.shop.recent.using(); -->
			<div class="swiper-container slide">
				<ul class="swiper-wrapper list">
					<c:forEach items="${recentGoods}" var="item" varStatus="idx">
						<c:if test="${idx.index < 10}" >
							<li class="swiper-slide">
								<div class="recomdSet">
									<div class="thum">
										<a href="/goods/indexGoodsDetail?goodsId=${item.goodsId}" data-content='${item.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${item.goodsId}" class="pic" title="${item.goodsNm}">
											<c:choose>
												<c:when test="${item.salePsbCd == frontConstants.SALE_PSB_20}">
													<div class="soldouts"><em class="ts">판매종료</em></div>
												</c:when>
												<c:when test="${item.salePsbCd == frontConstants.SALE_PSB_10}">
													<div class="soldouts"><em class="ts">판매중지</em></div>
												</c:when>
												<c:when test="${item.salePsbCd == frontConstants.SALE_PSB_30}">
													<div class="soldouts"><em class="ts"><spring:message code='front.web.view.common.goods.saleSoldOut.title'/></em></div>
												</c:when>
											</c:choose>
<!-- 											직사각형을 정사각형으로 변경함. frontConstants.IMG_OPT_QRY_340 >>>> frontConstants.IMG_OPT_QRY_500 -->
											<img class="img" src="${frame:optImagePath( item.imgPath , frontConstants.IMG_OPT_QRY_500 )}" onerror="this.src='../../_images/_temp/goods_1.jpg'" alt="이미지">
										</a>
									</div>
								</div>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
<!-- </section> -->
</c:if>