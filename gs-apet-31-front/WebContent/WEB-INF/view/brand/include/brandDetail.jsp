<script type="text/javascript">
goodsCount = ${goodsCount}

$(document).ready(function(){
	var metaImgPath = $(".thum .pic .img").eq(0).attr("src");
	// 공유하기 이미지 셋팅
	$("meta[property='og\\:image']").attr("content", metaImgPath);
	$("meta[property='og\\:image:url']").attr("content", metaImgPath);
});

function focusCategory(idx) {
	ui.disp.subnav.elSwiper.el.slideTo(idx-1);
}

</script>
<ul class="list" id="brandUl">
	<c:forEach var="goods" items="${brandGoodsList}"  varStatus="status" >
	<c:if test="${(goods.salePsbCd ne frontConstants.SALE_PSB_30) || (goods.salePsbCd eq frontConstants.SALE_PSB_30 && goods.ostkGoodsShowYn eq 'Y')}">
	<li>
		<div class="gdset defgd">
			<div class="thum">
				<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="pic" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">
					<c:if test="${goods.salePsbCd == frontConstants.SALE_PSB_10}">
						<div class="soldouts"><em class="ts"><spring:message code='front.web.view.common.goods.saleStop.title' /></em></div>
					</c:if>
					<c:if test="${goods.salePsbCd == frontConstants.SALE_PSB_20}">
						<div class="soldouts"><em class="ts"><spring:message code='front.web.view.common.goods.saleEnd.title' /></em></div>
					</c:if>
					<c:if test="${goods.salePsbCd == frontConstants.SALE_PSB_30}">
						<div class="soldouts"><em class="ts"><spring:message code='front.web.view.common.goods.saleSoldOut.title' /></em></div>
					</c:if>
					<img class="img" src="${frame:optImagePath(goods.imgPath, frontConstants.IMG_OPT_QRY_510)}" alt="${goods.goodsNm}" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'">
				</a>
				<button type="button" class="bt zzim ${goods.interestYn eq 'Y' ? 'on' : ''}" data-content='${goods.goodsId}' data-url="/goods/insertWish?goodsId=${goods.goodsId}" data-action="interest" data-yn="N" data-goods-id="${goods.goodsId}" data-target="goods"><spring:message code='front.web.view.brand.button.wishBrand' /></button>
			</div>
			<div class="boxs">
				<div class="tit">
					<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="lk" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">${goods.goodsNm}</a>
				</div>
				<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="inf" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">
					<span class="prc"><em class="p"><fmt:formatNumber value="${goods.foSaleAmt}" type="number" pattern="#,###,###"/></em><i class="w"><spring:message code='front.web.view.common.moneyUnit.title' /></i></span>
					<c:if test="${goods.orgSaleAmt > goods.saleAmt and ((goods.orgSaleAmt - goods.saleAmt)/goods.orgSaleAmt * 100) >= 1 }">
					<span class="pct"><em class="n"><fmt:parseNumber value="${100-((goods.foSaleAmt * 100) / goods.orgSaleAmt)}" integerOnly="true"/></em><i class="w"><spring:message code='front.web.view.common.brand.persent.title' /></i></span>
				</c:if>
				</a>
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
	</c:if>
	</c:forEach>
</ul>