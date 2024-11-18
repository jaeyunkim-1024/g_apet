<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">

</script>

<c:if test="${not empty listGoodsCookie}">
	<div class="hdts">
	<span class="tit">
		<a href="javascript:" class="t">최근 본 상품</a>
	</span>
	</div>
	<div class="cdts">
		<div class="ui_recent_slide">
			<!-- ui.shop.recent.using(); -->
			<div class="swiper-container slide">
				<ul class="swiper-wrapper list">
						<%--				<c:forEach items="${listGoodsCookie}" var="goodsCookie">--%>
					<c:forEach items="${listGoodsCookie}" var="item" varStatus="idx">
						<li class="swiper-slide">
							<div class="recomdSet">
								<div class="thum">
									<c:if test="${item.soldOutYn eq 'Y'}">
										<div class="soldouts"><em class="ts"><spring:message code='front.web.view.common.goods.saleSoldOut.title'/></em></div>
									</c:if>
									<a href="/goods/indexGoodsDetail?goodsId=${item.goodsId}" class="pic">
<%--										<img class="img" src="/images/noimage.png" alt="이미지" >--%>
<%--										<img class="img" src="${item.imgPath}" alt="이미지" onerror="this.src='/images/noimage.png'">--%>
<%--										<img class="img" src="../../_images/_temp/goods_1.jpg" alt="이미지">--%>
<!-- 										직사각형을 정사각형으로 변경함. frontConstants.IMG_OPT_QRY_340 >>>> frontConstants.IMG_OPT_QRY_500 -->
										<img class="img" src="${frame:optImagePath( item.imgPath , frontConstants.IMG_OPT_QRY_500 )}" alt="" />
									</a>
								</div>
							</div>
						</li>
					</c:forEach>
<%--						<li class="swiper-slide">--%>
<%--							<div class="recomdSet">--%>
<%--								<div class="thum"><a href="javascript:;" class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="이미지"></a></div>--%>
<%--							</div>--%>
<%--						</li>--%>
				</ul>
			</div>
		</div>
	</div>
</c:if>
