<c:forEach var="cornerList" items="${totalCornerList}"  varStatus="status" >
	<c:if test="${param.dispCornNo == cornerList.dispCornNo }">
		<!-- MD추천 -->
		<input type="hidden" id="dispCornNo_md" value="${param.dispCornNo}"/>
		<input type="hidden" id="dispClsfCornNo_md" value="${cornerList.mdGoodsList[0].dispClsfCornNo}"/>
		<section class="sect mn mdpic" id="goSection_${param.dispCornNo}">
			<div class="hdts">
				<a class="hdt" href="javascript:void(0);" id="goodsList_${cornerList.mdGoodsList[0].dispClsfCornNo}" onclick="loadCornerGoodsList(${view.dispClsfNo},${param.dispCornNo},${cornerList.mdGoodsList[0].dispClsfCornNo},'${frontConstants.GOODS_MAIN_DISP_TYPE_MD}');return false;">
					<span class="tit"> <spring:message code='front.web.view.petshop.md.goods.mdrecommend'/> <br> <spring:message code='front.web.view.petshop.md.goods.thisweek'/> <em class="b">${cornerList.dispCornNm}</em></span> <span class="more"><b class="t"><spring:message code='front.web.view.common.msg.fullscreen'/></b></span>
				</a>
			</div>
			<div class="mn_mdpic_sld">
				<div class="sld-nav">
					<button type="button" class="bt prev"><spring:message code='front.web.view.common.msg.previous'/></button>
					<button type="button" class="bt next"><spring:message code='front.web.view.common.msg.next'/></button>
				</div>
				<div class="swiper-container slide">
					<ul class="swiper-wrapper list">
						<c:forEach var="goods" items="${cornerList.mdGoodsList}"  varStatus="status" >
						<li class="swiper-slide">
							<div class="gdset mdpic">
								<div class="thum">
									<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="pic" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">
										<img class="img" src="${frame:optImagePath(goods.imgPath, frontConstants.IMG_OPT_QRY_794)}" alt="${goods.goodsNm}" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'">
									</a>
									<button type="button" class="bt zzim ${goods.interestYn eq 'Y' ? 'on' : ''}" data-content='${goods.goodsId}' data-url="/goods/insertWish?goodsId=${goods.goodsId}" data-action="interest" data-yn="N" data-goods-id="${goods.goodsId}" data-target="goods"><spring:message code='front.web.view.brand.button.wishBrand'/></button>
								</div>
								<div class="boxs">
									<div class="tit">
										<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="lk" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">${goods.goodsNm}</a>
									</div>
									<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="inf" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">
										<span class="prc"><em class="p"><fmt:formatNumber value="${goods.foSaleAmt}" type="number" pattern="#,###,###"/></em><i class="w">원</i></span>
										<c:if test="${goods.orgSaleAmt > goods.saleAmt and ((goods.orgSaleAmt - goods.saleAmt)/goods.orgSaleAmt * 100) >= 1 }">
										<span class="pct"><em class="n"><fmt:parseNumber value="${100-((goods.foSaleAmt * 100) / goods.orgSaleAmt)}" integerOnly="true"/></em><i class="w">%</i></span>
										</c:if>
									</a>
									<div class="txt">${goods.mdRcomWds}</div>
									<c:if test="${fn:length(goods.icons) > 0}">
									<div class="bdg">
									<c:forTokens  var="icons" items="${goods.icons}" delims="," begin="0" end="3">
										<em class="bd ${fn:indexOf(icons, '타임') > -1 ? 'd' : fn:indexOf(icons, '+') > -1 or fn:indexOf(icons, '사은품') > -1 ? 'b' : ''}">${icons }</em>
									</c:forTokens>
									</div>
									</c:if>
								</div>
							</div>
						</li>
						</c:forEach>
						<li class="swiper-slide mbtn" id="viewmore-7">
							<a href="javascript:void(0);" class="gotolist" onclick="loadCornerGoodsList(${view.dispClsfNo},${param.dispCornNo},${cornerList.mdGoodsList[0].dispClsfCornNo},'${frontConstants.GOODS_MAIN_DISP_TYPE_MD}');return false;">더보기</a>
						</li>
					</ul>
				</div>
			</div>
		</section>
	</c:if>
</c:forEach>