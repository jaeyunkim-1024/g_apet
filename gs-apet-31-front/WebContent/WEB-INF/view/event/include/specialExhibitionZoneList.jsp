<script type="text/javascript">
$(document).ready(function(){
	$("#input_"+'${so.thmNo}').val('${so.page}');
});
exhGoods.cnt =  "${fn:length(exhGoods)}";
exhGoods.soPage = "${so.page }"
</script>
<c:forEach items="${exhGoods}" var="goods">
	<li>
		<div class="gdset defgd">
			<div class="thum">
				<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="pic">
				<!-- 직사각형을 정사각형으로 변경함. frontConstants.IMG_OPT_QRY_320 >>>> frontConstants.IMG_OPT_QRY_500 -->
				<img class="img" src="${frame:optImagePath(goods.imgPath, frontConstants.IMG_OPT_QRY_500)}" alt="<spring:message code='front.web.view.common.msg.image' />" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'">
					<c:if test="${goods.salePsbCd == frontConstants.SALE_PSB_10}">
						<div class="soldouts"><em class="ts"><spring:message code='front.web.view.common.goods.saleStop.title' /></em></div>
					</c:if>
					<c:if test="${goods.salePsbCd == frontConstants.SALE_PSB_20}">
						<div class="soldouts"><em class="ts"><spring:message code='front.web.view.common.goods.saleEnd.title' /></em></div>
					</c:if>
					<c:if test="${goods.salePsbCd == frontConstants.SALE_PSB_30}">
						<div class="soldouts"><em class="ts"><spring:message code='front.web.view.common.goods.saleSoldOut.title' /></em></div>
					</c:if>
				</a>
				<button type="button" class="bt zzim ${goods.webStkQty ne 0 && goods.interestYn == 'Y' ? 'on' : ''}" data-target="goods" data-action="interest" data-yn="N" data-goods-id="${goods.goodsId}"><spring:message code='front.web.view.brand.button.wishBrand' /></button>
			</div>
			<div class="boxs">
				<div class="tit"><a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="lk">${goods.goodsNm}</a></div>
				<a href="javascript:;" class="inf">
					<span class="prc"><em class="p"><frame:num data="${goods.saleAmt}"/></em><i class="w"><spring:message code='front.web.view.common.moneyUnit.title' /></i></span>
					<c:if test="${goods.orgSaleAmt > goods.saleAmt and ((goods.orgSaleAmt - goods.saleAmt)/goods.orgSaleAmt * 100) >= 1 }">
						<span class="pct"><em class="n">
						<fmt:parseNumber value="${100-((goods.foSaleAmt * 100) / goods.orgSaleAmt)}" integerOnly="true"/>
						</em><i class="w">%</i></span>
					</c:if>
				</a>
			</div>
		</div>
	</li>
</c:forEach>
