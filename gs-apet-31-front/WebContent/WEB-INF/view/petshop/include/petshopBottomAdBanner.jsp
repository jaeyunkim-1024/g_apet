<script type="text/javascript">
//링크이동 버튼
// function orderPageBtnClick(linkUrl, title){
// 	if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30 }"){ // APP인경우
// 		if (linkUrl.indexOf("http://") > -1 || linkUrl.indexOf("https://")  > -1 ) {
// 			// 데이터 세팅
// 			toNativeData.func = 'onOrderPage';
// 			toNativeData.url = linkUrl;
// 			toNativeData.title = title;
// 			// 호출
// 			toNative(toNativeData);
// 		}else {
// 			location.href=linkUrl;
// 		}
// 	}else{
// 		location.href=linkUrl;
// 	}
// }
</script>
<c:forEach var="cornerList" items="${totalCornerList}"  varStatus="status" >
	<c:if test="${param.dispCornNo == cornerList.dispCornNo }">
		<!-- 배너 -->
		<section class="sect mn bannr">
			<div class="uibanners">
				<div class="banner_slide">
					<div class="swiper-container slide">
						<ul class="swiper-wrapper list">
							<c:forEach var="banner" items="${cornerList.bottomAdBannerList}"  varStatus="status" >
							<li class="swiper-slide">
								<%--<a href="#" class="box" onclick="orderPageBtnClick('${banner.bnrLinkUrl}', '${banner.bnrTtl}'); return false;"> --%>
								<c:if test="${fn:indexOf(banner.bnrLinkUrl, '/event/detail') == -1}">
									<a href="${banner.bnrLinkUrl}" class="box">
										<img class="img mo" src="${frame:optImagePath(banner.bnrMobileImgPath, frontConstants.IMG_OPT_QRY_742)}" alt="${banner.bnrTtl}">
										<img class="img pc" src="${frame:optImagePath(banner.bnrImgPath, frontConstants.IMG_OPT_QRY_795)}" alt="${banner.bnrTtl}">
									</a>
								</c:if>
								<c:if test="${fn:indexOf(banner.bnrLinkUrl, '/event/detail') > -1}">
									<a href="${banner.bnrLinkUrl}&returnUrl=${requestScope['javax.servlet.forward.servlet_path']}" class="box">
										<img class="img mo" src="${frame:optImagePath(banner.bnrMobileImgPath, frontConstants.IMG_OPT_QRY_742)}" alt="${banner.bnrTtl}">
										<img class="img pc" src="${frame:optImagePath(banner.bnrImgPath, frontConstants.IMG_OPT_QRY_795)}" alt="${banner.bnrTtl}">
									</a>
								</c:if>
							</li>
							</c:forEach>
						</ul>
						<div class="swiper-pagination"></div>
						<div class="sld-nav"><button type="button" class="bt prev">이전</button><button type="button" class="bt next">다음</button></div>
					</div>
				</div>
			</div>
		</section>
	</c:if>
</c:forEach>