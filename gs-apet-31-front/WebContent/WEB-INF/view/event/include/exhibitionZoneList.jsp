<c:forEach items="${exhibitionList}" var="item">
<section class="sect dm plans">
	<div class="pnlist">
		<ul class="list">
			<div class="gdset plans">
				<div class="pthum">
					<a href="javascript:goodsDetail(${item.exhbtNo});" class="pic">
						<img class="img pc" src="${fn:indexOf(item.bnrImgPath, 'cdn.ntruss.com')> -1 ? item.bnrImgPath  : frame:optImagePath(item.bnrImgPath, frontConstants.IMG_OPT_QRY_670) }" alt="<spring:message code='front.web.view.common.msg.image' />">
						<img class="img mo" src="${fn:indexOf(item.bnrMoImgPath, 'cdn.ntruss.com')> -1 ? item.bnrMoImgPath  : frame:optImagePath(item.bnrMoImgPath, frontConstants.IMG_OPT_QRY_660)}" alt="<spring:message code='front.web.view.common.msg.image' />">
					</a>
				</div>
				<div class="plans_slide">
					<div class="swiper-container slide">
						<ul class="swiper-wrapper glist">
							<c:forEach items="${item.exhibitionGoods}" var="goods" varStatus="status">
								<c:if test="${view.deviceGb eq 'PC'}">
									<c:choose>
										<c:when test="${status.index eq 4}">																							<!-- 직사각형을 정사각형으로 변경함. frontConstants.IMG_OPT_QRY_320 >>>> frontConstants.IMG_OPT_QRY_500 -->
											<li class="swiper-slide"><div class="thum"><a href="javascript:goodsDetail(${goods.exhbtNo});" class="pic"><img class="img" src="${frame:optImagePath(goods.imgPath, frontConstants.IMG_OPT_QRY_500)}" alt="<spring:message code='front.web.view.common.msg.image' />" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'"></a></div></li>
										</c:when>
										<c:otherwise>
											<li class="swiper-slide"><div class="thum"><a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="pic"><img class="img" src="${frame:optImagePath(goods.imgPath, frontConstants.IMG_OPT_QRY_500)}" alt="<spring:message code='front.web.view.common.msg.image' />" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'"></a></div></li>
										</c:otherwise>
									</c:choose>
								</c:if>
								<c:if test="${view.deviceGb eq 'MO'|| view.deviceGb eq 'APP'}">
										<c:choose>
										<c:when test="${status.index eq 2}">
											<li class="swiper-slide"><div class="thum"><a href="javascript:goodsDetail(${goods.exhbtNo});" class="pic"><img class="img" src="${frame:optImagePath(goods.imgPath, frontConstants.IMG_OPT_QRY_500)}" alt="<spring:message code='front.web.view.common.msg.image' />" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'"></a></div></li>
										</c:when>
										<c:otherwise>
											<li class="swiper-slide"><div class="thum"><a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="pic"><img class="img" src="${frame:optImagePath(goods.imgPath, frontConstants.IMG_OPT_QRY_500)}" alt="<spring:message code='front.web.view.common.msg.image' />" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'"></a></div></li>
										</c:otherwise>
									</c:choose>
								</c:if>
							</c:forEach>
						</ul>
					</div>
				</div>
				<div class="boxs">
					<div class="tag">
					<c:forEach items="${item.exhibitionTagList}" var="tag">
						<a class="tg" href="javascript:tagDetail('${tag.tagNm}', '${tag.tagNo}');"">#${tag.tagNm}</a> 
					</c:forEach>
					</div>
				</div>
			</div>
		</ul>
	</div>
</section>
</c:forEach>
