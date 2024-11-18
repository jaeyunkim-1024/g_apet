<dl class="sect shop line">
	<dt>
		<span><spring:message code='front.web.view.include.title.myshopping.information' /></span>
	</dt>
	<dd>
		<ul class="coupon">
			<li>
				<a class="my1" href="/mypage/info/coupon" data-url="/mypage/info/coupon" data-content="${session.mbrNo }">
					<c:if test="${couponCnt > 0}">
					<em>${couponCnt }</em>
					</c:if>
					<span><spring:message code='front.web.view.include.title.mycoupn' /></span>
				</a>
			</li>
			<li>
				<a class="my2" href="/mypage/indexRecentViews" data-url="/mypage/indexRecentViews" data-content="${session.mbrNo }">
				<%-- <c:if test="${fn:length(goodsDtlHistList) > 0}">
				<em>${fn:length(goodsDtlHistList) }</em>
				</c:if> --%>
				<span><spring:message code='front.web.view.include.title.recently.viewed.products' /></span></a>
			</li>
			<li>
				<a class="my3" href="/mypage/shop/myWishList" data-url="/mypage/shop/myWishList" data-content="${session.mbrNo }">
				<c:if test="${fn:length(myWishListGoods) > 0}">
				<em>${fn:length(myWishListGoods)}</em>
				</c:if>
				<span><spring:message code='front.web.view.include.title.mywish.products' /></span></a>
			</li>
			<li>
				<a class="my4" href="/order/indexCartList/">
				<c:if test="${view.cartCnt ne null and view.cartCnt ne '' and view.cartCnt ne '0'}">
							<em class="n">${view.cartCnt}</em>
				</c:if>
				<span><spring:message code='front.web.view.common.shoppingCart.title' /></span></a>
			</li>
		</ul>
		<div class="barwrap">
			<ul class="bar">
				<li>
					<a href="/mypage/order/indexDeliveryList"  data-url="/mypage/order/indexDeliveryList" data-content="${session.mbrNo }">
					<span class="tit"><spring:message code='front.web.view.include.title.order.and.delivery' /><c:if test="${orderSummary > 0}"><em>${orderSummary}</em></c:if></span>   
					<span class="next"></span>
					</a>
				</li>
				<li>
					<!-- <span class="tit new">취소/반품/교환</span> -->
					<a href="/mypage/order/indexClaimList"  data-url="/mypage/order/indexClaimList" data-content="${session.mbrNo }">
					<span class="tit"><spring:message code='front.web.view.include.title.cancel.return.exchange' /></span>
					<span class="next"></span>
					</a>
				</li>
				<li>
					<a href="/mypage/indexIoAlarmList"  data-url="/mypage/indexIoAlarmList" data-content="${session.mbrNo }">
					<span class="tit"><spring:message code='front.web.view.include.title.restock.alarm' /></span>
					<span class="next"></span>
					</a>
				</li>
				<li>
					<a href="/mypage/service/coupon"  data-url="/mypage/service/coupon" data-content="${session.mbrNo }">
					<span class="tit"><spring:message code='front.web.view.include.title.couponzone' /></span>
					<span class="next"></span>
					</a>
				</li>
			</ul>
			<ul class="bar line">
				<li>
					<a href="/customer/inquiry/inquiryView"  data-url="/customer/inquiry/inquiryView" data-content="${session.mbrNo }">
					<span class="tit"><spring:message code='front.web.view.new.menu.customer.inquiry' /></span>
					<span class="next"></span>
					</a>
				</li>
				<li>
					<a href="/mypage/goodsCommentList"  data-url="/mypage/goodsCommentList" data-content="${session.mbrNo }">
					<span class="tit"><spring:message code='front.web.view.mypage.comment.txt.comment.review' /></span>
					<span class="next"></span>
					</a>
				</li>
				<li>
					<a href="/mypage/service/indexAddressList" data-url="" data-content="${session.mbrNo }">
					<span class="tit"><spring:message code='front.web.view.include.title.address.lists' /></span>
					<span class="next"></span>
					</a>
				</li>
				<li>
					<a href="/mypage/order/indexBillingCardList"  data-url="/mypage/order/indexBillingCardList" data-content="${session.mbrNo }">
					<span class="tit"><spring:message code='front.web.view.include.title.payment.card.lists' /></span>
					<span class="next"></span>
					</a>
				</li>
			</ul>
		</div>
		<%-- <div class="line mt25">
			<p class="ex">어바웃펫에 친구를 초대하고 <span>혜택을 받아보세요.</span></p>
			<button class="btn add" onClick="location.href='/mypage/info/indexInvitePage'" data-content="${session.mbrNo }" data-url="/mypage/info/indexInvitePage">친구 초대하기</button>
		</div> --%>
		<div class="line mt25" style="cursor:pointer;" onClick="location.href='/mypage/info/indexInvitePage'" data-content="${session.mbrNo }" data-url="/mypage/info/indexInvitePage">
			<div class="invite">
				<span class="ex"><spring:message code='front.web.view.include.title.msg.toaboutpet' /> <em><spring:message code='front.web.view.include.title.msg.invite.friends' /></em><spring:message code='front.web.view.include.title.msg.then' /><span class="block"><spring:message code='front.web.view.include.title.msg.take.benefuts.with.friends' /></span></span>
			</div>
		</div>
	</dd>
</dl>
