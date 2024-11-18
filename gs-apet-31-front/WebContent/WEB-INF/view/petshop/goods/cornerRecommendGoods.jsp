<script type="text/javascript">
	$(document).ready(function(){
		if('main' == '${so.callGb}') {
			var petGbCd = '${recommendGoodsList[0].petGbCd}';
			if ('${frontConstants.PET_GB_20}' == petGbCd) {
				$("#petGbCd").text("🐱");
			}else {
				$("#petGbCd").text("🐶");
			}
		}else if('corner' == '${so.callGb}'){
			goodsCount = '${recommendGoodsList[0].goodsCount}';
			petNo = '${so.petNo}';
		}
	});	
</script>
<input type="hidden" id="otherPetNo" value="${so.petNo}"/>
<input type="hidden" id="otherPetNm" value="${recommendGoodsList[0].petNm}"/>
<c:forEach var="goods" items="${recommendGoodsList}">
<c:choose>
	<c:when test="${so.callGb eq 'corner'}">
	<li>
		<div class="gdset recom" id="recom_${goods.goodsId}">
<%-- 			<c:if test="${goods.intRate > 50}"> --%>
<%-- 			<div class="bdg"><b class="n">${goods.intRate}</b><i class="w">%</i> <b class="t">일치</b></div> --%>
<%-- 			</c:if> --%>
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
					<span class="prc"><em class="p"><fmt:formatNumber value="${goods.saleAmt}" type="number" pattern="#,###,###"/></em><i class="w">원</i></span>
				</a>
				<c:if test="${not empty goods.goodsTagList}" >
				<div class="tag">
					<c:forEach var="goodsTag" items="${goods.goodsTagList}" begin="0" end="2">
						<a href="/shop/indexPetShopTagGoods?tags=${goodsTag.tagNo}&tagNm=${goodsTag.tagNm}" class="tg">#${goodsTag.tagNm }</a>
					</c:forEach>
				</div>
				</c:if>
			</div>
		</div>
	</li>
	</c:when>
	<c:otherwise>
	<li class="swiper-slide">
		<div class="gdset recom" id="recom_${goods.goodsId}">
<%-- 			<c:if test="${goods.intRate > 50}"> --%>
<%-- 			<div class="bdg"><b class="n">${goods.intRate}</b><i class="w">%</i> <b class="t">일치</b></div> --%>
<%-- 			</c:if> --%>
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
					<span class="prc"><em class="p"><fmt:formatNumber value="${goods.saleAmt}" type="number" pattern="#,###,###"/></em><i class="w">원</i></span>
				</a>
				<c:if test="${not empty goods.goodsTagList}" >
				<div class="tag">
					<c:forEach var="goodsTag" items="${goods.goodsTagList}" begin="0" end="2">
						<a href="/shop/indexPetShopTagGoods?tags=${goodsTag.tagNo}&tagNm=${goodsTag.tagNm}" class="tg">#${goodsTag.tagNm }</a>
					</c:forEach>
				</div>
				</c:if>
			</div>
		</div>
	</li>
	</c:otherwise>
</c:choose>
</c:forEach>

