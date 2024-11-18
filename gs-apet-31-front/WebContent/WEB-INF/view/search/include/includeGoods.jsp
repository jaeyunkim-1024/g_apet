<c:forEach items="${result.goodsList}" var="goods" varStatus="idx" >
	<li class="scrhItem needAdbrix sg${goods.goodsId}" data-goodscnt="${result.goodsCount}" data-productid="${goods.goodsId}" data-productname="${goods.goodsNm}" data-price="${goods.foSaleAmt}" data-discount="${100-((goods.foSaleAmt * 100) / goods.orgSaleAmt)}" >
		<div class="gdset packg  schrt">
			<!-- <div class="num">2회구매</div> -->
			<div class="thum">
				<c:choose>
					<c:when test="${goods.salePsbCd == frontConstants.SALE_PSB_20}">
						<div class="soldouts" onclick="searchResult.goGoods('${goods.goodsId}');"><em class="ts">판매종료</em></div>
					</c:when>
					<c:when test="${goods.salePsbCd == frontConstants.SALE_PSB_10}">
						<div class="soldouts" onclick="searchResult.goGoods('${goods.goodsId}');"><em class="ts">판매중지</em></div>
					</c:when>
					<c:when test="${goods.salePsbCd == frontConstants.SALE_PSB_30}">
						<div class="soldouts" onclick="searchResult.goGoods('${goods.goodsId}');"><em class="ts"><spring:message code='front.web.view.common.goods.saleSoldOut.title'/></em></div>
					</c:when>
				</c:choose>
				<a href="javascript:searchResult.goGoods('${goods.goodsId}');" class="pic">
					<img class="img" src="${frame:optImagePath(goods.imgPath, frontConstants.IMG_OPT_QRY_740)}" alt="이미지" onerror="this.src='../../_images/common/icon-img-profile-default-m@2x.png'">
				</a>
				<button type="button" class="bt zzim ${goods.interestYn eq 'Y' ? 'on' : ''}" data-content='${goods.goodsId}' data-url="/goods/insertWish?goodsId=${goods.goodsId}" data-action="interest" data-yn="N" data-goods-id="${goods.goodsId}" data-target="goods">찜하기</button>
			</div>
			<div class="boxs">
				<p class="sname">${goods.bndNmKo }</p>
				<div class="tit"><a href="javascript:searchResult.goGoods('${goods.goodsId}');" class="lk">${goods.goodsNm}</a></div>
				<a href="javascript:searchResult.goGoods('${goods.goodsId}');" class="inf" >
					<span class="prc"><em class="p"><frame:num data="${goods.foSaleAmt}" /></em><i class="w">원</i></span>
					<fmt:parseNumber var = "foAmt" type = "number" value = "${goods.foSaleAmt}" />
					<fmt:parseNumber var = "orgAmt" type = "number" value = "${goods.orgSaleAmt}" />
					<c:if test="${goods.foSaleAmt != 0 && goods.orgSaleAmt != 0 && foAmt < orgAmt }">
						<fmt:parseNumber var="thisPercent" value="${100-((foAmt * 100) / orgAmt)}" integerOnly="true" />
						<c:if test="${thisPercent >= 1}">
							<span class="pct"><em class="n"><fmt:formatNumber value="${thisPercent}" type="percent" pattern="#,###,###,###"/></em><i class="w">%</i></span>
						</c:if>
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
</c:forEach>
