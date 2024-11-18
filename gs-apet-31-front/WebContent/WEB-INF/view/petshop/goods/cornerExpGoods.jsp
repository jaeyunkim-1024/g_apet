<!-- 할인상품 -->
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<c:forEach var="goods" items="${cornerList.expGoodsList}"  varStatus="status" >
<c:if test="${(goods.salePsbCd ne frontConstants.SALE_PSB_30) || (goods.salePsbCd eq frontConstants.SALE_PSB_30 && goods.ostkGoodsShowYn eq 'Y')}">
<li>
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
				<c:if test="${goods.expMngYn eq 'Y'}">
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