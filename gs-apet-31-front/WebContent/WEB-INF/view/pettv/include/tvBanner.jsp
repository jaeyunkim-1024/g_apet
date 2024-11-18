<c:forEach var="cornerList" items="${cornerList}"  varStatus="status" >
	<c:if test="${param.dispCornNo == cornerList.dispCornNo }">
		<div class="banner-wrap banner">
			<div class="uibanners">
				<div class="banner_slide">
					<div class="swiper-container slide">
						<ul class="swiper-wrapper list">
							<c:forEach var="bannerList" items="${cornerList.bannerList}">
								<li class="swiper-slide">
									<c:choose>
										<c:when test="${fn:indexOf(bannerList.bnrLinkUrl, '/tv/series/indexTvDetail') > -1 and view.deviceGb eq frontConstants.DEVICE_GB_30}">
											<a href="#" onclick="goUrl('onNewPage', 'TV', '${bannerList.bnrLinkUrl}'); return false;" class="box">
												<img class="pc" src="${fn:indexOf(bannerList.bnrImgPath, 'cdn.ntruss.com') > -1 ? bannerList.bnrImgPath : frame:optImagePath(bannerList.bnrImgPath, frontConstants.IMG_OPT_QRY_767)}" alt="배너">
												<img class="mo" src="${fn:indexOf(bannerList.bnrMobileImgPath, 'cdn.ntruss.com') > -1 ? bannerList.bnrMobileImgPath : frame:optImagePath(bannerList.bnrMobileImgPath, frontConstants.IMG_OPT_QRY_742)}" alt="배너">
											</a>
										</c:when>
										<c:otherwise>
											<c:if test="${fn:indexOf(bannerList.bnrLinkUrl, '/event/detail') == -1}">
			                   					<a href="#" onclick="fncGoUrl('${bannerList.bnrLinkUrl}'); return false;" class="box">
				                   					<img class="pc" src="${fn:indexOf(bannerList.bnrImgPath, 'cdn.ntruss.com') > -1 ? bannerList.bnrImgPath : frame:optImagePath(bannerList.bnrImgPath, frontConstants.IMG_OPT_QRY_767)}" alt="배너">
													<img class="mo" src="${fn:indexOf(bannerList.bnrMobileImgPath, 'cdn.ntruss.com') > -1 ? bannerList.bnrMobileImgPath : frame:optImagePath(bannerList.bnrMobileImgPath, frontConstants.IMG_OPT_QRY_742)}" alt="배너">
												</a>
			                   				</c:if>
			                   				<c:if test="${fn:indexOf(bannerList.bnrLinkUrl, '/event/detail') > -1}">
			                   					<a href="#" onclick="fncGoUrl('${bannerList.bnrLinkUrl}&returnUrl=${requestScope['javax.servlet.forward.servlet_path']}'); return false;" class="box">
				                   					<img class="pc" src="${fn:indexOf(bannerList.bnrImgPath, 'cdn.ntruss.com') > -1 ? bannerList.bnrImgPath : frame:optImagePath(bannerList.bnrImgPath, frontConstants.IMG_OPT_QRY_767)}" alt="배너">
													<img class="mo" src="${fn:indexOf(bannerList.bnrMobileImgPath, 'cdn.ntruss.com') > -1 ? bannerList.bnrMobileImgPath : frame:optImagePath(bannerList.bnrMobileImgPath, frontConstants.IMG_OPT_QRY_742)}" alt="배너">
												</a>
			                   				</c:if>
										</c:otherwise>
									</c:choose>
								</li>
							</c:forEach>  
						</ul>
						<div class="swiper-pagination"></div>
						<div class="sld-nav"><button type="button" class="bt prev">이전</button><button type="button" class="bt next">다음</button></div><!-- @@ 03.18 추가 -->
					</div>
				</div>
			</div>
		</div>
	</c:if>
</c:forEach>