<c:forEach var="cornerList" items="${totalCornerList}"  varStatus="status" >
	<c:if test="${param.dispCornNo == cornerList.dispCornNo }">
		<!-- 할인상품 -->
		<input type="hidden" id="dispCornNo_ex" value="${param.dispCornNo}"/>
		<input type="hidden" id="dispClsfCornNo_ex" value="${cornerList.expGoodsList[0].dispClsfCornNo}"/>
		<section class="sect mn discn" id="goSection_${param.dispCornNo}">
			<div class="hdts">
				<a class="hdt" href="javascript:void(0);" id="goodsList_${cornerList.expGoodsList[0].dispClsfCornNo}" onclick="loadCornerGoodsList(${view.dispClsfNo},${param.dispCornNo},${cornerList.expGoodsList[0].dispClsfCornNo},'${frontConstants.GOODS_AMT_TP_40}');return false;">
					<span class="tit"> 오늘까지 딱! <br><em class="b">할인상품 - ${cornerList.dispCornNm}</em></span> <span class="more"><b class="t">전체보기</b></span>
				</a>
			</div>
			<div class="mn_discn_sld">
				<div class="sld-nav">
					<button type="button" class="bt prev">이전</button>
					<button type="button" class="bt next">다음</button>
				</div>
				<div class="swiper-container slide">
					<ul class="swiper-wrapper list">
						<c:forEach var="goods" items="${cornerList.expGoodsList}"  varStatus="status" >
						<c:if test="${(goods.salePsbCd ne frontConstants.SALE_PSB_30) || (goods.salePsbCd eq frontConstants.SALE_PSB_30 && goods.ostkGoodsShowYn eq 'Y')}">
						<li class="swiper-slide">
							<div class="gdset discn">
								<div class="thum">
									<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="pic" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">
										<c:if test="${goods.salePsbCd == frontConstants.SALE_PSB_10}">
											<div class="soldouts"><em class="ts">판매중지</em></div>
										</c:if>
										<c:if test="${goods.salePsbCd == frontConstants.SALE_PSB_20}">
											<div class="soldouts"><em class="ts">판매종료</em></div>
										</c:if>
										<c:if test="${goods.salePsbCd == frontConstants.SALE_PSB_30}">
											<div class="soldouts"><em class="ts"><spring:message code='front.web.view.common.goods.saleSoldOut.title'/></em></div>
										</c:if>
										<img class="img" src="${frame:optImagePath(goods.imgPath, frontConstants.IMG_OPT_QRY_510)}" alt="${goods.goodsNm}" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'">
									</a>
									<button type="button" class="bt zzim ${goods.interestYn eq 'Y' ? 'on' : ''}" data-content='${goods.goodsId}' data-url="/goods/insertWish?goodsId=${goods.goodsId}" data-action="interest" data-yn="N" data-goods-id="${goods.goodsId}" data-target="goods">찜하기</button>
								</div>
								<div class="boxs">
									<div class="tit">
										<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="lk" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" >${goods.goodsNm}</a>
									</div>
									<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="inf" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">
										<span class="prc"><em class="p"><fmt:formatNumber value="${goods.foSaleAmt}" type="number" pattern="#,###,###"/></em><i class="w">원</i></span>
										<c:if test="${goods.orgSaleAmt > goods.saleAmt and ((goods.orgSaleAmt - goods.saleAmt)/goods.orgSaleAmt * 100) >= 1 }">
										<span class="pct"><em class="n"><fmt:parseNumber value="${100-((goods.foSaleAmt * 100) / goods.orgSaleAmt)}" integerOnly="true"/></em><i class="w">%</i></span>
										</c:if>
										<c:if test="${goods.expMngYn eq 'Y' && not empty goods.expDt}">
										<div class="pds">
											<em class="tt">유통기한</em> <em class="ss"><fmt:formatDate value="${goods.expDt}" pattern="yyyy.MM.dd"/>까지</em>
										</div>
										</c:if>
									</a>
								</div>
							</div>
						</li>
						</c:if>
						</c:forEach>
						<li class="swiper-slide mbtn" id="viewmore-4">
							<a href="javascript:void(0);" class="gotolist" onclick="loadCornerGoodsList(${view.dispClsfNo},${param.dispCornNo},${cornerList.expGoodsList[0].dispClsfCornNo}, '${frontConstants.GOODS_AMT_TP_40}');return false;">더보기</a>
						</li>
					</ul>
				</div>
			</div>
		</section>
	</c:if>
</c:forEach>