<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="framework.front.constants.FrontConstants" %>
<%--<tiles:insertDefinition name="default">--%>
<%--	<tiles:putAttribute name="script.inline">--%>

<%--	</tiles:putAttribute>--%>
<%--</tiles:insertDefinition>--%>

<script type="text/javascript">
</script>
<c:if test="${empty session.bizNo}">
<nav class="cartNavs" id="cartNavs">
	<div class="inr">
		<div class="pdinfo">
			<div class="box">
<!-- 				직사각형을 정사각형으로 변경함. frontConstants.IMG_OPT_QRY_210 >>>> frontConstants.IMG_OPT_QRY_756 -->
				<span class="pic"><img class="img" src="${frame:optImagePath( dlgtImgPath != null ? dlgtImgPath : '', frontConstants.IMG_OPT_QRY_756)}" onerror="this.src='${view.noImgPath}'" alt=""></span>
				<div class="disc">
					<div class="names">${goods.goodsNm}</div>
					<div class="price">
						<em class="p"><fmt:formatNumber value="${goods.saleAmt}" type="number" pattern="#,###,###"/></em><i class="w">원</i>
					</div>
				</div>
			</div>
		</div>

		<div class="btns">
			<div class="zims">
				<button type="button" class="bt btZZim ${goods.interestYn eq 'Y'  ? 'on' : ''}" id="goodsWish"
					data-content='${goods.goodsId}' data-url="/goods/insertWish?goodsId=${goods.goodsId}" data-action="interest" data-yn="N" data-goods-id="${goods.goodsId}" data-target="goods" ><span class="t">찜하기</span></button><!-- .on class명 있으면 찜한 상태임 -->
			</div>
			<!-- soldOutYn 품절 여부 0보다 크면 Y -->
			<div class="obts">
				<c:set var="goodsIdStr" value="${goods.goodsId}"/>
				<c:if test="${goods.dlgtSubGoodsId != null}">
					<c:set var="goodsIdStr" value="${goods.dlgtSubGoodsId}:${goods.goodsId}"/>
				</c:if>
				<c:choose>
					<c:when test="${goods.goodsTpCd ne frontConstants.GOODS_TP_40}">
						<button type="button" class="bt btCart" onclick="fnCartItems('N')"><span class="t" >장바구니</span></button>
						<c:if test="${goods.salePsbCd eq frontConstants.SALE_PSB_00}" > <!-- 판매가능 -->
							<c:choose>
								<c:when test="${goods.totalSalePsbCd eq frontConstants.SALE_PSB_00}" > <!-- 판매가능 -->
									<button type="button" class="bt btOrde" onclick="fnCartItems('Y')" ><span class="t" >구매하기</span></button>
								</c:when>
								<c:when test="${goods.totalSalePsbCd eq frontConstants.SALE_PSB_10}" > <!-- 판매중지 -->
									<button type="button" class="bt btSold" onclick="ui.toast('판매 중지되어 구매하실 수 없는 상품이에요')" ><span class="t">판매중지</span></button> 
								</c:when>
								<c:when test="${goods.totalSalePsbCd eq frontConstants.SALE_PSB_20}" > <!-- 판매종료 -->
									<button type="button" class="bt btSold" onclick="ui.toast('판매 종료되어 구매할 수 없는 상품이에요')" ><span class="t">판매종료</span></button>
								</c:when>
								<c:when test="${goods.totalSalePsbCd eq frontConstants.SALE_PSB_30}" > <!-- 품절 -->
									<c:if test="${goods.ioAlmYn eq 'N'}" >
										<button type="button" class="bt btSold" onclick="ui.toast('품절되어 구매하실 수 없는 상품이에요')" ><span class="t" ><spring:message code='front.web.view.common.goods.saleSoldOut.title'/></span></button>
									</c:if>
									<c:if test="${goods.ioAlmYn eq 'Y'}" >
										<button type="button" class="bt btAlim"
										        data-target="goods"
										        data-action="ioAlarm"
										        data-goods-id="${goodsIdStr}"
										        data-content="${goodsIdStr}"><span class="t" >입고알림</span></button>
									</c:if>
								</c:when>
							</c:choose>
						</c:if>
						<c:if test="${goods.salePsbCd eq frontConstants.SALE_PSB_10}" > <!-- 판매중지 -->
							<button type="button" class="bt btSold" onclick="ui.toast('판매 중지되어 구매하실 수 없는 상품이에요')" ><span class="t">판매중지</span></button> 
						</c:if>
						<c:if test="${goods.salePsbCd eq frontConstants.SALE_PSB_20}" > <!-- 판매종료 -->
							<button type="button" class="bt btSold" onclick="ui.toast('판매 종료되어 구매할 수 없는 상품이에요')" ><span class="t">판매종료</span></button>
						</c:if>
						<c:if test="${goods.salePsbCd eq frontConstants.SALE_PSB_30}" > <!-- 품절 -->
							<c:if test="${goods.ioAlmYn eq 'N'}" >
								<button type="button" class="bt btSold" onclick="ui.toast('품절되어 구매하실 수 없는 상품이에요')" ><span class="t" ><spring:message code='front.web.view.common.goods.saleSoldOut.title'/></span></button>
							</c:if>
							<c:if test="${goods.ioAlmYn eq 'Y'}" >
								<button type="button" class="bt btAlim"
								        data-target="goods"
								        data-action="ioAlarm"
								        data-goods-id="${goodsIdStr}"
								        data-content="${goodsIdStr}"><span class="t" >입고알림</span></button>
							</c:if>
						</c:if>
					</c:when>
					<c:otherwise>
					 	<c:choose>
							<c:when test="${goods.reservationType eq 'SOON'}" > <!-- 판매가능 -->
								<button type="button" class="bt btOrde" onclick="fnCartItems('Y')" ><span class="t" >구매하기</span></button>
							</c:when>
							<c:when test="${goods.reservationType eq 'NOW'}" > <!-- 판매가능 -->
								<c:choose>
									<c:when test="${goods.salePsbCd eq frontConstants.SALE_PSB_00}" > 
										<button type="button" class="bt btOrde" onclick="fnCartItems('Y')" ><span class="t" >구매하기</span></button>
									</c:when>
									<c:when test="${goods.salePsbCd eq frontConstants.SALE_PSB_10}" > <!-- 판매중지 -->
										<button type="button" class="bt btSold" onclick="ui.toast('판매 중지되어 구매하실 수 없는 상품이에요')" ><span class="t">판매중지</span></button> 
									</c:when>
									<c:when test="${goods.salePsbCd eq frontConstants.SALE_PSB_20}" > <!-- 판매종료 -->
										<button type="button" class="bt btSold" onclick="ui.toast('판매 종료되어 구매할 수 없는 상품이에요')" ><span class="t">판매종료</span></button>
									</c:when>
									<c:when test="${goods.salePsbCd eq frontConstants.SALE_PSB_30}" > <!-- 품절 -->
										<c:if test="${goods.ioAlmYn eq 'N'}" >
											<button type="button" class="bt btSold" onclick="ui.toast('품절되어 구매하실 수 없는 상품이에요')"><span class="t" ><spring:message code='front.web.view.common.goods.saleSoldOut.title'/></span></button>
										</c:if>
										<c:if test="${goods.ioAlmYn eq 'Y'}" >
											<button type="button" class="bt btAlim"
											        data-target="goods"
											        data-action="ioAlarm"
											        data-goods-id="${goodsIdStr}"
											        data-content="${goodsIdStr}"><span class="t" >입고알림</span></button>
										</c:if>
									</c:when>
								</c:choose>
							</c:when>
							<c:when test="${goods.reservationType eq 'PAST'}" >
								<button type="button" class="bt btSold" onclick="ui.toast('판매 종료되어 구매할 수 없는 상품이에요')" ><span class="t">판매종료</span></button>
							</c:when>
					 	</c:choose>
					</c:otherwise>	
				</c:choose>
			</div>
		</div>
	</div>
</nav>
</c:if>