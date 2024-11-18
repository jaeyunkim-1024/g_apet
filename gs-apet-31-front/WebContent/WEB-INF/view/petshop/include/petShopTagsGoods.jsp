<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<script type="text/javascript">
	
$(document).ready(function(){
	// 정렬
	$("li[id^=order_] button").click(function(){
		filter.detail('del', $(this).val());
    });
	
	goodsCount = ${goodsCount};
});
	
</script>
<div class="sticky_filter_top">		
	<div class="inr">
		<div class="uioptsorts tag">
			<div class="dx lt">
				<div class="tot"><spring:message code='front.web.view.petshop.tags.goods.product'/><em class="n">${goodsCount}<spring:message code='front.web.view.common.goods.count.number'/></em></div>
			</div>
			<div class="dx rt">
				<nav class="filter">
					<button type="button" class="bt filt" name="countName" id="btnFilter" onclick="filter.open();">
						<spring:message code='front.web.view.common.msg.filter'/><i class="n" id="filCount"></i>
					</button>
				</nav>
				<nav class="uisort">
					<c:choose>
						<c:when test="${so.order == 'SALE'}"><button type="button" class="bt st" value="SALE"><spring:message code='front.web.view.common.menu.sort.orderSale.button.title'/></button></c:when>
						<c:when test="${so.order == 'SCORE'}"><button type="button" class="bt st" value="SCORE"><spring:message code='front.web.view.common.menu.sort.orderScore.button.title'/></button></c:when>
						<c:when test="${so.order == 'DATE'}"><button type="button" class="bt st" value="DATE"><spring:message code='front.web.view.common.menu.sort.orderDate.button.title'/></button></c:when>
						<c:when test="${so.order == 'LOW'}"><button type="button" class="bt st" value="LOW"><spring:message code='front.web.view.common.menu.sort.orderLow.button.title'/></button></c:when>
						<c:when test="${so.order == 'HIGH'}"><button type="button" class="bt st" value="HIGH"><spring:message code='front.web.view.common.menu.sort.orderHigh.button.title'/></button></c:when>
					</c:choose>
					<div class="list">
						<ul class="menu">
							<li class="${so.order == 'SALE' ? 'active' : '' }"id="order_SALE"><button type="button" class="bt" value="SALE" onclick="filter.detail('del',this.value);"><spring:message code='front.web.view.common.menu.sort.orderSale.button.title'/></button></li>
							<li class="${so.order == 'SCORE' ? 'active' : '' }"id="order_SCORE"><button type="button" class="bt" value="SCORE" onclick="filter.detail('del',this.value);"><spring:message code='front.web.view.common.menu.sort.orderScore.button.title'/></button></li>
							<li class="${so.order == 'DATE' ? 'active' : '' }" id="order_DATE"><button type="button" class="bt" value="DATE" onclick="filter.detail('del',this.value);"><spring:message code='front.web.view.common.menu.sort.orderDate.button.title'/></button></li>
							<li class="${so.order == 'LOW' ? 'active' : '' }"id="order_LOW"><button type="button" class="bt" value="LOW" onclick="filter.detail('del',this.value);"><spring:message code='front.web.view.common.menu.sort.orderLow.button.title'/></button></li>
							<li class="${so.order == 'HIGH' ? 'active' : '' }"id="order_HIGH"><button type="button" class="bt" value="HIGH" onclick="filter.detail('del',this.value);"><spring:message code='front.web.view.common.menu.sort.orderHigh.button.title'/></button></li>
						</ul>
					</div>
				</nav>
			</div>
		</div>
		<div class="uifiltbox filOneLine" id="uifiltbox">
			<div class="flist ${view.deviceGb == 'PC' ? '' : 'swiper-container'}">
			</div>
			<div class="bts">
				<button type="button" class="bt refresh" onclick="filter.refresh('refresh');"><spring:message code='front.web.view.common.msg.refresh'/></button>
			</div>
		</div>
	</div>
</div>
<ul class="list" id="pagingGoods">
<c:forEach var="goods" items="${categoryGoodsList}"  varStatus="status" >
<c:if test="${(goods.salePsbCd ne frontConstants.SALE_PSB_30) || (goods.salePsbCd eq frontConstants.SALE_PSB_30 && goods.ostkGoodsShowYn eq 'Y')}">
<li>
	<div class="gdset cates">
		<div class="thum">
			<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="pic" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">
				<c:if test="${goods.salePsbCd == frontConstants.SALE_PSB_10}">
					<div class="soldouts"><em class="ts"><spring:message code='front.web.view.common.goods.saleStop.title'/></em></div>
				</c:if>
				<c:if test="${goods.salePsbCd == frontConstants.SALE_PSB_20}">
					<div class="soldouts"><em class="ts"><spring:message code='front.web.view.common.goods.saleEnd.title'/></em></div>
				</c:if>
				<c:if test="${goods.salePsbCd == frontConstants.SALE_PSB_30}">
					<div class="soldouts"><em class="ts"><spring:message code='front.web.view.common.goods.saleSoldOut.title'/></em></div>
				</c:if>
				<img class="img" src="${frame:optImagePath(goods.imgPath, frontConstants.IMG_OPT_QRY_510)}" alt="${goods.goodsNm}" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'">
			</a>
			<button type="button" class="bt zzim ${goods.interestYn eq 'Y' ? 'on' : ''}" data-content='${goods.goodsId}' data-url="/goods/insertWish?goodsId=${goods.goodsId}" data-action="interest" data-yn="N" data-goods-id="${goods.goodsId}" data-target="goods"><spring:message code='front.web.view.brand.button.wishBrand'/></button>
		</div>
		<div class="boxs">
			<div class="tit">
				<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="lk" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" >${goods.goodsNm}</a>
			</div>
			<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="inf" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">
				<span class="prc"><em class="p"><frame:num data="${goods.foSaleAmt}" /></em><i class="w"><spring:message code='front.web.view.common.moneyUnit.title'/></i></span>
				<c:if test="${goods.orgSaleAmt > goods.saleAmt and ((goods.orgSaleAmt - goods.saleAmt)/goods.orgSaleAmt * 100) >= 1 }">
				<span class="pct"><em class="n"><fmt:parseNumber value="${100-((goods.foSaleAmt * 100) / goods.orgSaleAmt)}" integerOnly="true"/></em><i class="w">%</i></span>
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