<c:forEach var="cornerList" items="${totalCornerList}"  varStatus="status" >
	<c:if test="${param.dispCornNo == cornerList.dispCornNo }">
	<!-- 패키지 -->
	<input type="hidden" id="dispCornNo_pack" value="${param.dispCornNo}"/>
	<input type="hidden" id="dispClsfCornNo_pack" value="${cornerList.packageGoodsList[0].dispClsfCornNo}"/>
	<section class="sect mn packg" id="goSection_${param.dispCornNo}">
		<div class="hdts">
			<a class="hdt" href="javascript:void(0);" id="goodsList_${cornerList.packageGoodsList[0].dispClsfCornNo}" onclick="loadCornerGoodsList(${view.dispClsfNo},${param.dispCornNo},${cornerList.packageGoodsList[0].dispClsfCornNo},'${frontConstants.GOODS_MAIN_DISP_TYPE_PACKAGE}');return false;">
				<span class="tit"> <spring:message code='front.web.view.petshop.package.goods.full.configuration'/><br> <spring:message code='front.web.view.petshop.package.goods.full.cart'/> <em class="b">${cornerList.dispCornNm}</em></span> <span class="more"><b class="t"><spring:message code='front.web.view.common.msg.fullscreen'/></b></span>
			</a>
		</div>
		<div class="mn_packg_sld">
			<c:if test="${view.deviceGb != frontConstants.DEVICE_GB_10}">
			<div class="sld-nav">
				<button type="button" class="bt prev">이전</button>
				<button type="button" class="bt next">다음</button>
			</div>
			</c:if>
			<div class="swiper-container slide">
				<ul class="swiper-wrapper list">
					<c:forEach var="goods" items="${cornerList.packageGoodsList}"  varStatus="status" >
					<li class="swiper-slide">
						<div class="gdset packg">
							<div class="h-bdg">
							<c:set var="loop_flag" value="false" />
							<c:forTokens  var="icons" items="${goods.icons}" delims=",">
								<c:if test="${not loop_flag }">
									<c:if test="${(icons eq '1+1') or (icons eq '2+1') or (icons eq '사은품')}">
										<c:set var="loop_flag" value="true" />
										<div class="bdg"><b class="n">${icons}</b></div>
									</c:if>
								</c:if>
							</c:forTokens>
							</div>
							<div class="thum">
								<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="pic" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">
									<img class="img" src="${frame:optImagePath(goods.imgPath, frontConstants.IMG_OPT_QRY_510)}" alt="${goods.goodsNm}" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'">   
								</a>
								<button type="button" class="bt zzim ${goods.interestYn eq 'Y' ? 'on' : ''}" data-content='${goods.goodsId}' data-url="/goods/insertWish?goodsId=${goods.goodsId}" data-action="interest" data-yn="N" data-goods-id="${goods.goodsId}" data-target="goods">찜하기</button>
							</div>
							<div class="boxs">
								<div class="tit">
									<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="lk" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">${goods.goodsNm}</a>
								</div>
								<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="inf" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">
									<span class="prc"><em class="p"><fmt:formatNumber value="${goods.foSaleAmt}" type="number" pattern="#,###,###"/></em><i class="w"><spring:message code='front.web.view.common.moneyUnit.title'/></i></span>
									<c:if test="${goods.orgSaleAmt > goods.saleAmt and ((goods.orgSaleAmt - goods.saleAmt)/goods.orgSaleAmt * 100) >= 1 }">
									<span class="pct"><em class="n"><fmt:parseNumber value="${100-((goods.foSaleAmt * 100) / goods.orgSaleAmt)}" integerOnly="true"/></em><i class="w">%</i></span>
									</c:if>
								</a>
							</div>
						</div>
					</li>
					</c:forEach>
					<c:if test="${fn:length(cornerList.packageGoodsList)%2 != 0}">
					<li class="swiper-slide">
					</li>
					</c:if>
					<c:if test="${view.deviceGb != frontConstants.DEVICE_GB_10}">
					<li class="swiper-slide more">
						<a class="more_box" onclick="loadCornerGoodsList(${view.dispClsfNo},${param.dispCornNo},${cornerList.packageGoodsList[0].dispClsfCornNo},'${frontConstants.GOODS_MAIN_DISP_TYPE_PACKAGE}');return false;"><i class="ico_contents_more"></i><p>더보기</p></a>
					</li>
					</c:if>
				</ul>
			</div>
			<c:if test="${view.deviceGb == frontConstants.DEVICE_GB_10}">
			<div class="sld-nav">
				<button type="button" class="bt prev">이전</button>
				<button type="button" class="bt next">다음</button>
			</div>
			</c:if>
		</div>
	</section>
	</c:if>
</c:forEach>