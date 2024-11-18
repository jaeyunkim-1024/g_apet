<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:if test="${!empty goodsGifts}">
<div class="gifts">
	<div class="box">
		<div class="tit"><spring:message code='front.web.view.goods.gift.title' /></div>
		<div class="ctn">
			<p><span class="st"><spring:message code='front.web.view.goods.gift.title' /></span> <span class="tt"><spring:message code='front.web.view.goods.gift.presentation.target.goods.title' /></span></p>
		</div>
		<a href="javascript:;" class="bt more" onclick="ui.popBot.open('popGiftsInfo', {'pop':true});"><spring:message code='front.web.view.common.seemore.title' /></a>
	</div>
	<%--<jsp:include page="/WEB-INF/view/goods/includeNew/includePopupGifts.jsp" />--%>
	<!-- 사은품 안내 -->
	<div class="layers">
		<article class="popBot popGiftsInfo k0421" id="popGiftsInfo">
			<div class="pbd">
				<div class="phd">
					<div class="in">
						<h1 class="tit"><spring:message code='front.web.view.goods.gift.introduce.title' /></h1>
						<button type="button" class="btnPopClose"><spring:message code='front.web.view.common.close.btn' /></button>
					</div>
				</div>
				<div class="pct">
					<main class="poptents">
						<ul class="scgiftinfo">
							<c:forEach items="${goodsGifts}" var="gift">
								<li>
									<div class="hinf">
										<div class="tt"><c:out value="${gift.prmtNm}"/></div>
										<div class="ss"><spring:message code='front.web.view.goods.gift.purchase.presentation.title' /></div>
									</div>
									<div class="dinf">
										<div class="thum">
											<div class="pic">
												<c:if test="${gift.soldOutYn eq frontConstants.COMM_YN_Y}">
													<div class="soldouts"><em class="ts"><spring:message code='front.web.view.common.goods.saleSoldOut.title' /></em></div>
												</c:if>
<!-- 												직사각형을 정사각형으로 변경함. frontConstants.IMG_OPT_QRY_210 >>>> frontConstants.IMG_OPT_QRY_756 -->
												<img class="img" src="${frame:optImagePath( gift.imgPath , frontConstants.IMG_OPT_QRY_756 )}" />
											</div>
										</div>
										<div class="name">${gift.goodsNm}</div>
									</div>
								</li>
							</c:forEach>
						</ul>
					</main>
				</div>
			</div>
		</article>
	</div>
</div>
</c:if>