<script type="text/javascript">
function setCateList(dispClsfNo, upDispClsfNo) {
	var dispClsfNo2 ='';	
	if('${frontConstants.PETSHOP_DOG_DISP_CLSF_NO}' == upDispClsfNo ) {			// 강아지
		dispClsfNo2 = '${frontConstants.PETSHOP_MAIN_DOG_DISP_CLSF_NO}'
	} else if('${frontConstants.PETSHOP_CAT_DISP_CLSF_NO}' == upDispClsfNo ) {	// 고양이
		dispClsfNo2 = '${frontConstants.PETSHOP_MAIN_CAT_DISP_CLSF_NO}'
	} else if('${frontConstants.PETSHOP_FISH_DISP_CLSF_NO}' == upDispClsfNo ) {	// 관상어
		dispClsfNo2 = '${frontConstants.PETSHOP_MAIN_FISH_DISP_CLSF_NO}'
	} else if('${frontConstants.PETSHOP_ANIMAL_DISP_CLSF_NO}' == upDispClsfNo ) {	// 소동물
		dispClsfNo2 = '${frontConstants.PETSHOP_MAIN_ANIMAL_DISP_CLSF_NO}'
	}
	
	location.href = "/shop/indexCategory?dispClsfNo="+dispClsfNo+"&dispClsfNo2="+dispClsfNo2+"&cateCdL="+upDispClsfNo+"&cateCdM="+dispClsfNo;
}

function goIndexLoginSettings() {
	location.href = "/indexLoginSettings?returnUrl=" + window.location.pathname;
}

//시리즈 팝업
function seriesOpen(){
	var options = {
		url : "<spring:url value='/tv/series/getSeriesList' />"
		, type : "POST"
		, dataType : "html"
		, data : { }
		, done : function(result){
			$("#gnbSrisListPopup").empty();
			$("#gnbSrisListPopup").html(result);
			ui.gnb.using("close"); //시리즈 목록 레이어 팝업 실행시 gnb메뉴(전체메뉴) 닫기
			ui.popLayer.open('popSeriesList');
		}
	};
	ajax.call(options);
}


function goMyPetLogGnb(){
	if( checkLoginGnb() && checkRegPetGnb() ){
		location.href = "${view.stDomain}/log/indexMyPetLog/${session.petLogUrl}?mbrNo=${session.mbrNo}";
	}
}


function checkLoginGnb(){
	if( "${session.isLogin()}" != "true" ){
		ui.confirm('로그인 후 서비스를 이용할 수 있어요.<br>로그인 할까요?',{ // 컨펌 창 옵션들
			ycb:function(){
				location.href = "${view.stDomain}/indexLogin";
			},
			ncb:function(){
				return false;
			},
			ybt:"로그인", // 기본값 "확인"
			nbt:"취소"  // 기본값 "취소"
		});
	}else{
		return true;
	}
}


function checkRegPetGnb(){	
	if( "${session.petNos}" == null || "${session.petNos}" == ""){
		ui.confirm('마이펫 등록 후 이용할 수 있어요<br/>펫정보를 등록할까요?',{ // 컨펌 창 옵션들
			ycb:function(){
				// 반려동물 등록 화면으로 이동.
				location.href = "${view.stDomain}/my/pet/petInsertView";
			},
			ncb:function(){
				//alert('취소');
				return false;
			},
			ybt:"예", // 기본값 "확인"
			nbt:"아니요"  // 기본값 "취소"
		});
	}else{
		return true;
	}
}

</script>
<nav class="gnb" id="gnb">
	<div class="inr">
		<div class="hdt">
			<div class="logo">aboutPet</div>
			<div class="bts"><button class="bt close">메뉴닫기</button></div>
		</div>
		<div class="cdt">
			<div class="menu">
				<ul class="list">
					<li class="tv ${view.seoSvcGbCd == frontConstants.SEO_SVC_GB_CD_20 ? 'active' : '' }">
						<a class="bt" href="javascript:;"><spring:message code='front.web.view.new.menu.tv' /></a> <!-- APET-1250 210728 kjh02  -->
						<div class="box">
							<ul class="sm">
								<li><a class="bt" href="/tv/petTvList?dispCornNo=567">신규영상</a></li>
								<li><a class="bt" href="/tv/petTvList?dispCornNo=568">인기영상</a></li>
								<li><a class="bt" href="/tv/petSchool">펫스쿨</a></li>
								<li><a class="bt" href="javascript:seriesOpen();">시리즈목록</a></li>
							</ul>
						</div>
					</li>
					<li class="log ${view.seoSvcGbCd == frontConstants.SEO_SVC_GB_CD_30 ? 'active' : '' }">
						<a class="bt" href="javascript:;"><spring:message code='front.web.view.new.menu.log' /></a> <!-- APET-1250 210728 kjh02  -->
						<div class="box">
							<ul class="sm">
								<li><a class="bt" href="javascript:goMyPetLogGnb();">MY <spring:message code='front.web.view.new.menu.log' /></a></li> <!-- APET-1250 210728 kjh02  -->
							</ul>
						</div>
					</li>
					<li class="shop ${view.seoSvcGbCd == frontConstants.SEO_SVC_GB_CD_10 ? 'active' : '' }">
						<a class="bt" href="javascript:;"><spring:message code='front.web.view.new.menu.store' /></a> <!-- APET-1250 210728 kjh02  -->
					<c:if test="${not empty view.displayCategoryList}">
						<div class="box">
							<div class="cate slideShop">
								<div class="swiper-container">
									<ul class="swiper-wrapper slide">
									<c:forEach var="allCategorylist" items="${view.displayCategoryList}"  varStatus="categoryIndex" >
										<c:if test="${allCategorylist.dispLvl == 1 && allCategorylist.subDispCateList != null}">
											<c:choose>
												<c:when test="${view.seoSvcGbCd == frontConstants.SEO_SVC_GB_CD_10}">
													<li class="swiper-slide ${allCategorylist.dispClsfNo == so.cateCdL ? 'active' : ''}"><a data-ui-tab-btn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_${allCategorylist.dispClsfNo}" href="javascript:;" class="bt">${allCategorylist.dispClsfNm }</a></li>
												</c:when>
												<c:otherwise>
													<li class="swiper-slide ${allCategorylist.dispPriorRank == 1 ? 'active' : ''}"><a data-ui-tab-btn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_${allCategorylist.dispClsfNo}" href="javascript:;" class="bt">${allCategorylist.dispClsfNm }</a></li>
												</c:otherwise>
											</c:choose>
										</c:if>
									</c:forEach>
									</ul>
								</div>
							</div>
							<c:forEach var="allCategorylist" items="${view.displayCategoryList}"  varStatus="categoryIndex" >
							<c:if test="${not empty allCategorylist.subDispCateList}">
								<c:choose>
									<c:when test="${view.seoSvcGbCd == frontConstants.SEO_SVC_GB_CD_10}">
										<div class="ctset ${allCategorylist.dispLvl == 1 && allCategorylist.dispClsfNo == so.cateCdL ? 'active' : ''}" data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_${allCategorylist.dispClsfNo}">
									</c:when>
									<c:otherwise>
										<div class="ctset ${allCategorylist.dispLvl == 1 && allCategorylist.dispPriorRank == 1 ? 'active' : ''}" data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_${allCategorylist.dispClsfNo}">
									</c:otherwise>
								</c:choose>
								<ul class="sm">
								<c:forEach var="subCategorylist" items="${allCategorylist.subDispCateList}"  varStatus="categoryIndex" >
								<c:if test="${subCategorylist.dispLvl == 2 && allCategorylist.dispClsfNo == subCategorylist.upDispClsfNo}">
									<li><a class="bt"  href="javascript:setCateList('${subCategorylist.dispClsfNo}', '${subCategorylist.upDispClsfNo}');">${subCategorylist.dispClsfNm }</a></li>
								</c:if>	
								</c:forEach>
								</ul>
							</div>
							</c:if>
							</c:forEach>
<!-- 							<div class="ctset" data-ui-tab-ctn="tab_shop_cate" data-ui-tab-val="tab_shop_cate_6"> -->
<!-- 								플레이스 -->
<!-- 							</div> -->
						</div>
					</c:if>
					</li>
					<li class="my ${view.seoSvcGbCd == frontConstants.SEO_SVC_GB_CD_40 ? 'active' : '' }">
						<a class="bt" href="javascript:;">MY</a>
						<div class="box">
							<div class="cate slideShop">
								<div class="swiper-container">
									<ul class="swiper-wrapper slide">
										<li class="swiper-slide active"><a data-ui-tab-btn="tab_my_cate" data-ui-tab-val="tab_my_cate_1" href="javascript:;" class="bt">내 활동</a></li>
										<li class="swiper-slide"><a data-ui-tab-btn="tab_my_cate" data-ui-tab-val="tab_my_cate_2" href="javascript:;" class="bt">내 쇼핑정보</a></li>
										<li class="swiper-slide"><a data-ui-tab-btn="tab_my_cate" data-ui-tab-val="tab_my_cate_3" href="javascript:;" class="bt">내 정보 관리</a></li>
									</ul>              
								</div>
							</div>
							<div class="ctset ctset1 active" data-ui-tab-ctn="tab_my_cate" data-ui-tab-val="tab_my_cate_1">
								<ul class="sm">
									<li><a class="bt" href="/my/pet/myPetListView" data-content="${session.mbrNo}" data-url="/my/pet/myPetListView">마이펫 관리</a></li>
									<li><a class="bt" href="/mypage/tv/myWishList">마이 찜리스트</a></li>
									<li><a class="bt" href="/tv/series/indexTvRecentVideo">최근 본 영상</a></li>
								</ul>
							</div>
							<div class="ctset ctset2" data-ui-tab-ctn="tab_my_cate" data-ui-tab-val="tab_my_cate_2">
								<ul class="sm">
									<li><a class="bt" href="/mypage/order/indexDeliveryList" data-url="/mypage/order/indexDeliveryList" data-content="${session.mbrNo}">주문/배송</a></li>
									<li><a class="bt" href="/customer/inquiry/inquiryView" data-url="/customer/inquiry/inquiryView" data-content="${session.mbrNo}"><spring:message code='front.web.view.new.menu.customer.inquiry'/></a></li>
									<li><a class="bt" href="/mypage/order/indexClaimList" data-url="/mypage/order/indexClaimList" data-content="${session.mbrNo}">취소/반품/교환</a></li>
									<li><a class="bt" href="/mypage/goodsCommentList" data-url="/mypage/goodsCommentList" data-content="${session.mbrNo}">상품 후기</a></li>
									<li><a class="bt" href="/mypage/indexIoAlarmList" data-url="/mypage/indexIoAlarmList" data-content="${session.mbrNo}">재입고 알림</a></li>
									<li><a class="bt" href="/mypage/service/indexAddressList" data-url="/mypage/service/indexAddressList" data-content="${session.mbrNo}">배송지 관리</a></li>
									<li><a class="bt" href="/mypage/info/coupon" data-url="/mypage/info/coupon" data-content="${session.mbrNo}">내 쿠폰</a></li>
									<li><a class="bt" href="/mypage/order/indexBillingCardList" data-content="${session.mbrNo}">결제 카드관리</a></li>
								</ul>
							</div>
							<div class="ctset ctset3" data-ui-tab-ctn="tab_my_cate" data-ui-tab-val="tab_my_cate_3">
								<ul class="sm">
									<li><a class="bt" href="/mypage/info/indexPswdUpdate" data-content="${session.mbrNo}" data-url="/mypage/info/indexPswdUpdate" >비밀번호 설정</a></li>
									<li><a class="bt" href="/mypage/info/indexManageCheck" data-content="${session.mbrNo}" data-url="/mypage/info/indexManageCheck" >회원정보 수정</a></li>
								</ul>
							</div>
						</div>
					</li>
				</ul>
			</div>
			<div class="link">
				<ul class="list">
					<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_30 }">
					<li><a href="/indexLoginSettings" class="bt" data-content="${session.mbrNo}" data-url="/indexLoginSettings" >설정</a></li>
					</c:if>
					<li><a href="/mypage/service/coupon" data-content="${session.mbrNo}" data-url="/mypage/service/coupon" class="bt">쿠폰존</a></li>
					<li><a href="/event/main" data-content="${session.mbrNo}" data-url="/event/main" class="bt">이벤트</a></li>
					<li><a href="/customer/faq/faqList" class="bt">FAQ</a></li>
					<li><a href="/customer/notice/indexNoticeList" class="bt">공지사항</a></li>
					<li><a href="javascript:void(0);" onclick ="openPartnershipInquiry()" class="bt">입점ㆍ제휴문의</a></li>
					<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_30 }">
					<li><a href="/indexSettingTerms" class="bt">서비스 이용약관</a></li><!-- 21.07.06 APET-1200 lcm01 -->
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</nav>

<div class="layers tv seriesHome" id="gnbSrisListPopup"></div>
