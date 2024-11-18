<script type="text/javascript">
</script>
<nav class="lnb my" id="lnb">
	<div class="inr">
		<div class="myCate">
			<ul class="menu">
				<li class="open">
					<a class="bt " href="/mypage/indexMyPage/" data-url="/mypage/indexMyPage/" data-content="${session.mbrNo}"><b class="t">내 활동</b></a>
					<ul class="sm">
						<li class="${fn:indexOf(session.reqUri, '/my/pet') > -1 ? 'active' : '' }"><a class="bt" href="/my/pet/myPetListView;" data-url="/my/pet/myPetListView;" data-content="${session.mbrNo}"><b class="t">마이펫 관리</b></a></li>
						<li class="${fn:indexOf(session.reqUri, '/myWishList') > -1 ? 'active' : '' }"><a class="bt" href="/mypage/tv/myWishList" data-url="/mypage/tv/myWishList" data-content="${session.mbrNo}"><b class="t">마이 찜리스트</b></a></li>
						<%-- <li class="${fn:indexOf(session.reqUri, '/mypage/tv/myWishList') > -1 ? 'active' : '' }"><a class="bt" href="/mypage/tv/myWishList" data-url="/mypage/tv/myWishList" data-content="${session.mbrNo}">마이 찜리스트</b></a></li> --%>
						<li class="${fn:indexOf(session.reqUri, '/tv/series/indexTvRecentVideo') > -1 ? 'active' : '' }"><a class="bt" href="/tv/series/indexTvRecentVideo?listGb=MY" data-url="/tv/series/indexTvRecentVideo?listGb=MY" data-content="${session.mbrNo}"><b class="t">최근 본 영상</b></a></li>
						<li class="${fn:indexOf(session.reqUri, '/mypage/indexRecentViews') > -1 ? 'active' : '' }"><a class="bt" href="/mypage/indexRecentViews" data-url="/mypage/indexRecentViews" data-content="${session.mbrNo}" ><b class="t">최근 본 상품</b></a></li>
					</ul>
				</li>
				<li class="open">
					<a class="bt " href="javascript:;"><b class="t">내 쇼핑정보</b></a>
					<ul class="sm">
						<li class="${fn:indexOf(session.reqUri, '/mypage/order/indexDeliveryList') > -1 ? 'active' : '' }"><a class="bt" href="/mypage/order/indexDeliveryList" data-url="/mypage/order/indexDeliveryList" data-content="${session.mbrNo}"><b class="t">주문/배송</b></a></li>
						<li class="${fn:indexOf(session.reqUri, '/mypage/order/indexClaimList') > -1 ? 'active' : '' }"><a class="bt" href="/mypage/order/indexClaimList" data-url="/mypage/order/indexClaimList" data-content="${session.mbrNo}"><b class="t">취소/반품/교환</b></a></li>
						<li class="${fn:indexOf(session.reqUri, '/mypage/indexIoAlarmList') > -1 ? 'active' : '' }"><a class="bt" href="/mypage/indexIoAlarmList" data-url="/mypage/indexIoAlarmList" data-content="${session.mbrNo}"><b class="t">재입고 알림</b></a></li>
						<li class="${fn:indexOf(session.reqUri, '/mypage/info/coupon') > -1 ? 'active' : '' }"><a class="bt" href="/mypage/info/coupon"  data-url="/mypage/info/coupon" data-content="${session.mbrNo}"><b class="t">내 쿠폰</b></a></li>
						<li class="${fn:indexOf(session.reqUri, '/customer/inquiry/inquiryView') > -1 ? 'active' : '' }"><a class="bt" href="/customer/inquiry/inquiryView" data-url="/customer/inquiry/inquiryView" data-content="${session.mbrNo}"><b class="t"><spring:message code='front.web.view.new.menu.customer.inquiry'/></b></a></li>
						<li class="${fn:indexOf(session.reqUri, '/mypage/goodsCommentList') > -1 ? 'active' : '' }"><a class="bt" href="/mypage/goodsCommentList" data-url="/mypage/goodsCommentList" data-content="${session.mbrNo}"><b class="t">상품 후기</b></a></li>
						<li class="${fn:indexOf(session.reqUri, '/mypage/service/indexAddressList') > -1 ? 'active' : '' }"><a class="bt" href="/mypage/service/indexAddressList" data-url="/mypage/service/indexAddressList" data-content="${session.mbrNo}"><b class="t">배송지 관리</b></a></li>
						<li class="${fn:indexOf(session.reqUri, '/mypage/order/indexBillingCardList') > -1 ? 'active' : '' }"><a class="bt" href="/mypage/order/indexBillingCardList" data-url="/mypage/order/indexBillingCardList" data-content="${session.mbrNo}"><b class="t">결제 카드 관리</b></a></li>
					</ul>
				</li>
				<li class="open">
					<a class="bt " href="javascript:;"><b class="t">내 정보 관리</b></a>
					<ul class="sm">
						<li class="${fn:indexOf(session.reqUri, '/info/indexPswd') > -1 ? 'active' : '' }"><a class="bt" href="/mypage/info/indexPswdUpdate" data-url="/mypage/info/indexPswdUpdate" data-content="${session.mbrNo}"><b class="t">비밀번호 설정</b></a></li>
						<li class="${fn:indexOf(session.reqUri, '/info/indexManage') > -1 ? 'active' : '' }"><a class="bt" href="/mypage/info/indexManageCheck"><b class="t" data-url="/mypage/info/indexManageCheck" data-content="${session.mbrNo}">회원정보 수정</b></a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
</nav>