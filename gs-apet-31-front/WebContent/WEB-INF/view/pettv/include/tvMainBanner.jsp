 <c:forEach var="cornerList" items="${cornerList}"  varStatus="status" >
	<c:if test="${param.dispCornNo == cornerList.dispCornNo }">
		<!-- 메인 슬라이드 -->
		<section class="main">
			<div class="swiper-div">
				<div class="swiper-container">
					<ul class="swiper-wrapper">
	                   	<c:forEach var="mainBannerList" items="${cornerList.mainBannerList }">
							<li class="swiper-slide">
	                          	<div class="thumb-box">
	                              	<div class="dummyImg">
	                              	  	<c:if test="${mainBannerList.vdId eq null }">
	                              			<c:choose> 
	                              				<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
	                              					<c:if test="${fn:indexOf(mainBannerList.bnrLinkUrl, '/event/detail') == -1}">
	                              						<a href="#" onclick="fncGoUrl('${mainBannerList.bnrLinkUrl }'); return false;" class="thumb-img" data-content="${mainBannerList.bnrNo}" data-url="${mainBannerList.bnrLinkUrl }" style="background-image:url(${fn:indexOf(mainBannerList.bnrImgPath, 'cdn.ntruss.com') > -1 ? mainBannerList.bnrImgPath : frame:optImagePath(mainBannerList.bnrImgPath, frontConstants.IMG_OPT_QRY_788)});"></a>
	                              					</c:if>
	                              					<c:if test="${fn:indexOf(mainBannerList.bnrLinkUrl, '/event/detail') > -1}">
	                              						<a href="#" onclick="fncGoUrl('${mainBannerList.bnrLinkUrl }&returnUrl=${requestScope['javax.servlet.forward.servlet_path']}'); return false;" class="thumb-img" data-content="${mainBannerList.bnrNo}" data-url="${mainBannerList.bnrLinkUrl }" style="background-image:url(${fn:indexOf(mainBannerList.bnrImgPath, 'cdn.ntruss.com') > -1 ? mainBannerList.bnrImgPath : frame:optImagePath(mainBannerList.bnrImgPath, frontConstants.IMG_OPT_QRY_788)});"></a>
	                              					</c:if>
	                              				</c:when>
	                              				<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_20 }">
	                              					<c:if test="${fn:indexOf(mainBannerList.bnrMobileLinkUrl, '/event/detail') == -1}">
	                              						<a href="#" onclick="fncGoUrl('${mainBannerList.bnrMobileLinkUrl }'); return false;" class="thumb-img" data-content="${mainBannerList.bnrNo}" data-url="${mainBannerList.bnrMobileLinkUrl }" style="background-image:url(${fn:indexOf(mainBannerList.bnrMobileImgPath, 'cdn.ntruss.com') > -1 ? mainBannerList.bnrMobileImgPath : frame:optImagePath(mainBannerList.bnrMobileImgPath, frontConstants.IMG_OPT_QRY_789)});"></a>
	                              					</c:if>
	                              					<c:if test="${fn:indexOf(mainBannerList.bnrMobileLinkUrl, '/event/detail') > -1}">
	                              						<a href="#" onclick="fncGoUrl('${mainBannerList.bnrMobileLinkUrl }&returnUrl=${requestScope['javax.servlet.forward.servlet_path']}'); return false;" class="thumb-img" data-content="${mainBannerList.bnrNo}" data-url="${mainBannerList.bnrMobileLinkUrl }" style="background-image:url(${fn:indexOf(mainBannerList.bnrMobileImgPath, 'cdn.ntruss.com') > -1 ? mainBannerList.bnrMobileImgPath : frame:optImagePath(mainBannerList.bnrMobileImgPath, frontConstants.IMG_OPT_QRY_789)});"></a>
	                              					</c:if>
	                              				</c:when>
	                              				<c:otherwise>
	                              					<c:if test="${fn:indexOf(mainBannerList.bnrMobileLinkUrl, '/tv/series/indexTvDetail') == -1}">
	                              						<c:if test="${fn:indexOf(mainBannerList.bnrMobileLinkUrl, '/event/detail') == -1}">
	                              							<a href="#" onclick="fncGoUrl('${mainBannerList.bnrMobileLinkUrl }'); return false;" class="thumb-img" data-content="${mainBannerList.bnrNo}" data-url="${mainBannerList.bnrMobileLinkUrl }" style="background-image:url(${fn:indexOf(mainBannerList.bnrMobileImgPath, 'cdn.ntruss.com') > -1 ? mainBannerList.bnrMobileImgPath : frame:optImagePath(mainBannerList.bnrMobileImgPath, frontConstants.IMG_OPT_QRY_789)});"></a>
		                              					</c:if>
		                              					<c:if test="${fn:indexOf(mainBannerList.bnrMobileLinkUrl, '/event/detail') > -1}">
		                              						<a href="#" onclick="fncGoUrl('${mainBannerList.bnrMobileLinkUrl }&returnUrl=${requestScope['javax.servlet.forward.servlet_path']}'); return false;" class="thumb-img" data-content="${mainBannerList.bnrNo}" data-url="${mainBannerList.bnrMobileLinkUrl }" style="background-image:url(${fn:indexOf(mainBannerList.bnrMobileImgPath, 'cdn.ntruss.com') > -1 ? mainBannerList.bnrMobileImgPath : frame:optImagePath(mainBannerList.bnrMobileImgPath, frontConstants.IMG_OPT_QRY_789)});"></a>
		                              					</c:if>
	                              					</c:if>
	                              					<c:if test="${fn:indexOf(mainBannerList.bnrMobileLinkUrl, '/tv/series/indexTvDetail') > -1}">
	                              						<a href="#" onclick="goUrl('onNewPage', 'TV', '${mainBannerList.bnrMobileLinkUrl }'); return false;" class="thumb-img" data-content="${mainBannerList.bnrNo}" data-url="${mainBannerList.bnrMobileLinkUrl }" style="background-image:url(${fn:indexOf(mainBannerList.bnrMobileImgPath, 'cdn.ntruss.com') > -1 ? mainBannerList.bnrMobileImgPath : frame:optImagePath(mainBannerList.bnrMobileImgPath, frontConstants.IMG_OPT_QRY_789)});"></a>
	                              					</c:if>
	                              				</c:otherwise>
	                              			</c:choose>
	                                  	</c:if>
	                                  	<c:if test="${mainBannerList.bnrNo eq null }">
	                                  		<c:choose>
		                                  		<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
		                                  			<a href="#" onclick="fncGoUrl('/tv/series/indexTvDetail?vdId=${mainBannerList.vdId }&sortCd=&listGb=HOME'); return false;" class="thumb-img" data-content="${mainBannerList.vdId }" data-url="/tv/series/indexTvDetail?vdId=${mainBannerList.vdId }&sortCd=&listGb=HOME" style="background-image:url(${fn:indexOf(mainBannerList.bnrImgPath, 'cdn.ntruss.com') > -1 ? mainBannerList.bnrImgPath : frame:optImagePath(mainBannerList.bnrImgPath, frontConstants.IMG_OPT_QRY_788)});"></a>
		                                  		</c:when>
		                                  		<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_20}">
		                                  			<a href="#" onclick="fncGoUrl('/tv/series/indexTvDetail?vdId=${mainBannerList.vdId }&sortCd=&listGb=HOME'); return false;" class="thumb-img" data-content="${mainBannerList.vdId }" data-url="/tv/series/indexTvDetail?vdId=${mainBannerList.vdId }&sortCd=&listGb=HOME" style="background-image:url(${fn:indexOf(mainBannerList.bnrMobileImgPath, 'cdn.ntruss.com') > -1 ? mainBannerList.bnrMobileImgPath : frame:optImagePath(mainBannerList.bnrMobileImgPath, frontConstants.IMG_OPT_QRY_789)});"></a>
		                                  		</c:when>
		                                  		<c:otherwise>
		                                  			<a href="#" onclick="goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${mainBannerList.vdId }&sortCd=&listGb=HOME'); return false;" class="thumb-img" data-content="${mainBannerList.vdId }" data-url="${view.stDomain}/tv/series/indexTvDetail?vdId=${mainBannerList.vdId }&sortCd=&listGb=HOME" style="background-image:url(${fn:indexOf(mainBannerList.bnrMobileImgPath, 'cdn.ntruss.com') > -1 ? mainBannerList.bnrMobileImgPath : frame:optImagePath(mainBannerList.bnrMobileImgPath, frontConstants.IMG_OPT_QRY_789)});"></a>
		                                  		</c:otherwise>
	                                  		</c:choose>
	                                  	</c:if>
	                              	</div>
	                              	<div class="thumb-info">
										<div class="info">
		                                  	<p class="sub">
			                                  	<c:forEach var="bannerTagList" items="${mainBannerList.bannerTagList }">
			                                      	<a href="#" onclick="fncGoUrl('/tv/collectTags?tagNo=${bannerTagList.tagNo }'); return false;" class="sub">#${bannerTagList.tagNm }</a>
			                                  	</c:forEach>
		                                  	</p>
											<c:if test="${mainBannerList.vdId eq null }">
		                              			<c:choose> 
		                              				<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
		                              					<c:if test="${fn:indexOf(mainBannerList.bnrLinkUrl, '/event/detail') == -1}">
		                              						<a href="#" onclick="fncGoUrl('${mainBannerList.bnrLinkUrl }'); return false;" data-content="${mainBannerList.bnrNo}" data-url="${mainBannerList.bnrLinkUrl }">
		                              						<div class="tlt">
		                              							${mainBannerList.bnrText}
	                              							</div>
		                              						</a>
		                              					</c:if>
		                              					<c:if test="${fn:indexOf(mainBannerList.bnrLinkUrl, '/event/detail') > -1}">
		                              						<a href="#" onclick="fncGoUrl('${mainBannerList.bnrLinkUrl }&returnUrl=${requestScope['javax.servlet.forward.servlet_path']}'); return false;" data-content="${mainBannerList.bnrNo}" data-url="${mainBannerList.bnrLinkUrl }">
		                              							<div class="tlt">
			                              							${mainBannerList.bnrText}
		                              							</div>
		                              						</a>
		                              					</c:if>
		                              				</c:when>
		                              				<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_20 }">
		                              					<c:if test="${fn:indexOf(mainBannerList.bnrMobileLinkUrl, '/event/detail') == -1}">
		                              						<a href="#" onclick="fncGoUrl('${mainBannerList.bnrMobileLinkUrl }'); return false;" data-content="${mainBannerList.bnrNo}" data-url="${mainBannerList.bnrMobileLinkUrl }">
		                              							<div class="tlt">
			                              							${mainBannerList.bnrText}
		                              							</div>
		                              						</a>
		                              					</c:if>
		                              					<c:if test="${fn:indexOf(mainBannerList.bnrMobileLinkUrl, '/event/detail') > -1}">
		                              						<a href="#" onclick="fncGoUrl('${mainBannerList.bnrMobileLinkUrl }&returnUrl=${requestScope['javax.servlet.forward.servlet_path']}'); return false;" data-content="${mainBannerList.bnrNo}" data-url="${mainBannerList.bnrMobileLinkUrl }">
		                              							<div class="tlt">
			                              							${mainBannerList.bnrText}
		                              							</div>
		                              						</a>
		                              					</c:if>
		                              				</c:when>
		                              				<c:otherwise>
		                              					<c:if test="${fn:indexOf(mainBannerList.bnrMobileLinkUrl, '/tv/series/indexTvDetail') == -1}">
		                              						<c:if test="${fn:indexOf(mainBannerList.bnrMobileLinkUrl, '/event/detail') == -1}">
		                              							<a href="#" onclick="fncGoUrl('${mainBannerList.bnrMobileLinkUrl }'); return false;" data-content="${mainBannerList.bnrNo}" data-url="${mainBannerList.bnrMobileLinkUrl }">
		                              								<div class="tlt">
				                              							${mainBannerList.bnrText}
			                              							</div>
		                              							</a>
			                              					</c:if>
			                              					<c:if test="${fn:indexOf(mainBannerList.bnrMobileLinkUrl, '/event/detail') > -1}">
			                              						<a href="#" onclick="fncGoUrl('${mainBannerList.bnrMobileLinkUrl }&returnUrl=${requestScope['javax.servlet.forward.servlet_path']}'); return false;" data-content="${mainBannerList.bnrNo}" data-url="${mainBannerList.bnrMobileLinkUrl }">
			                              							<div class="tlt">
				                              							${mainBannerList.bnrText}
			                              							</div>
			                              						</a>
			                              					</c:if>
		                              					</c:if>
		                              					<c:if test="${fn:indexOf(mainBannerList.bnrMobileLinkUrl, '/tv/series/indexTvDetail') > -1}">
		                              						<a href="#" onclick="goUrl('onNewPage', 'TV', '${mainBannerList.bnrMobileLinkUrl }'); return false;" data-content="${mainBannerList.bnrNo}" data-url="${mainBannerList.bnrMobileLinkUrl }">
		                              							<div class="tlt">
			                              							${mainBannerList.bnrText}
		                              							</div>
		                              						</a>
		                              					</c:if>
		                              				</c:otherwise>
		                              			</c:choose>
		                                  	</c:if>
		                                  	<c:if test="${mainBannerList.bnrNo eq null }">
		                                  		<c:choose>
			                                  		<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_30}">
			                                  			<a href="#" onclick="goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${mainBannerList.vdId }&sortCd=&listGb=HOME'); return false;" data-content="${mainBannerList.vdId }" data-url="${view.stDomain}/tv/series/indexTvDetail?vdId=${mainBannerList.vdId }&sortCd=&listGb=HOME">
			                                  				<div class="tlt">
		                              							${mainBannerList.bnrText}
	                              							</div>
			                                  			</a>
			                                  		</c:when>
			                                  		<c:otherwise>
			                                  			<a href="#" onclick="fncGoUrl('/tv/series/indexTvDetail?vdId=${mainBannerList.vdId }&sortCd=&listGb=HOME'); return false;" data-content="${mainBannerList.vdId }" data-url="/tv/series/indexTvDetail?vdId=${mainBannerList.vdId }&sortCd=&listGb=HOME">
			                                  				<div class="tlt">
		                              							${mainBannerList.bnrText}
	                              							</div>
			                                  			</a>
			                                  		</c:otherwise>
		                                  		</c:choose>
		                                  	</c:if>
                                      		<c:if test="${mainBannerList.vdId eq null }">
		                              			<c:choose> 
		                              				<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
		                              					<c:if test="${fn:indexOf(mainBannerList.bnrLinkUrl, '/event/detail') == -1}">
		                              						<a href="#" onclick="fncGoUrl('${mainBannerList.bnrLinkUrl }'); return false;" data-content="${mainBannerList.bnrNo}" data-url="${mainBannerList.bnrLinkUrl }">
		                              							<div class="detail"><span>${mainBannerList.bnrDscrt }</span></div>
		                              						</a>
		                              					</c:if>
		                              					<c:if test="${fn:indexOf(mainBannerList.bnrLinkUrl, '/event/detail') > -1}">
		                              						<a href="#" onclick="fncGoUrl('${mainBannerList.bnrLinkUrl }&returnUrl=${requestScope['javax.servlet.forward.servlet_path']}'); return false;" data-content="${mainBannerList.bnrNo}" data-url="${mainBannerList.bnrLinkUrl }">
		                              							<div class="detail"><span>${mainBannerList.bnrDscrt }</span></div>
		                              						</a>
		                              					</c:if>
		                              				</c:when>
		                              				<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_20 }">
		                              					<c:if test="${fn:indexOf(mainBannerList.bnrMobileLinkUrl, '/event/detail') == -1}">
		                              						<a href="#" onclick="fncGoUrl('${mainBannerList.bnrMobileLinkUrl }'); return false;" data-content="${mainBannerList.bnrNo}" data-url="${mainBannerList.bnrMobileLinkUrl }">
		                              							<div class="detail"><span>${mainBannerList.bnrDscrt }</span></div>
		                              						</a>
		                              					</c:if>
		                              					<c:if test="${fn:indexOf(mainBannerList.bnrMobileLinkUrl, '/event/detail') > -1}">
		                              						<a href="#" onclick="fncGoUrl('${mainBannerList.bnrMobileLinkUrl }&returnUrl=${requestScope['javax.servlet.forward.servlet_path']}'); return false;" data-content="${mainBannerList.bnrNo}" data-url="${mainBannerList.bnrMobileLinkUrl }">
		                              							<div class="detail"><span>${mainBannerList.bnrDscrt }</span></div>
		                              						</a>
		                              					</c:if>
		                              				</c:when>
		                              				<c:otherwise>
		                              					<c:if test="${fn:indexOf(mainBannerList.bnrMobileLinkUrl, '/tv/series/indexTvDetail') == -1}">
		                              						<c:if test="${fn:indexOf(mainBannerList.bnrMobileLinkUrl, '/event/detail') == -1}">
		                              							<a href="#" onclick="fncGoUrl('${mainBannerList.bnrMobileLinkUrl }'); return false;" data-content="${mainBannerList.bnrNo}" data-url="${mainBannerList.bnrMobileLinkUrl }">
		                              								<div class="detail"><span>${mainBannerList.bnrDscrt }</span></div>
		                              							</a>
			                              					</c:if>
			                              					<c:if test="${fn:indexOf(mainBannerList.bnrMobileLinkUrl, '/event/detail') > -1}">
			                              						<a href="#" onclick="fncGoUrl('${mainBannerList.bnrMobileLinkUrl }&returnUrl=${requestScope['javax.servlet.forward.servlet_path']}'); return false;" data-content="${mainBannerList.bnrNo}" data-url="${mainBannerList.bnrMobileLinkUrl }">
			                              							<div class="detail"><span>${mainBannerList.bnrDscrt }</span></div>
			                              						</a>
			                              					</c:if>
		                              					</c:if>
		                              					<c:if test="${fn:indexOf(mainBannerList.bnrMobileLinkUrl, '/tv/series/indexTvDetail') > -1}">
		                              						<a href="#" onclick="goUrl('onNewPage', 'TV', '${mainBannerList.bnrMobileLinkUrl }'); return false;" data-content="${mainBannerList.bnrNo}" data-url="${mainBannerList.bnrMobileLinkUrl }">
		                              							<div class="detail"><span>${mainBannerList.bnrDscrt }</span></div>
		                              						</a>
		                              					</c:if>
		                              				</c:otherwise>
		                              			</c:choose>
		                                  	</c:if>
		                                  	<c:if test="${mainBannerList.bnrNo eq null }">
		                                  		<c:choose>
			                                  		<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_30}">
			                                  			<a href="#" onclick="goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${mainBannerList.vdId }&sortCd=&listGb=HOME'); return false;" data-content="${mainBannerList.vdId }" data-url="${view.stDomain}/tv/series/indexTvDetail?vdId=${mainBannerList.vdId }&sortCd=&listGb=HOME">
			                                  				<div class="detail"><span>${mainBannerList.bnrDscrt }</span></div>
			                                  			</a>
			                                  		</c:when>
			                                  		<c:otherwise>
			                                  			<a href="#" onclick="fncGoUrl('/tv/series/indexTvDetail?vdId=${mainBannerList.vdId }&sortCd=&listGb=HOME'); return false;" data-content="${mainBannerList.vdId }" data-url="/tv/series/indexTvDetail?vdId=${mainBannerList.vdId }&sortCd=&listGb=HOME">
			                                  				<div class="detail"><span>${mainBannerList.bnrDscrt }</span></div>
			                                  			</a>
			                                  		</c:otherwise>
		                                  		</c:choose>
											</c:if>
	                                  	</div>
	                              	</div>
	                          	</div>
	                      	</li>
						</c:forEach>
					</ul>
					<div class="swiper-pagination"></div>
				</div>
				<!-- <div class="back-img" style="background-image:url(../../_images/tv/@temp03.jpg);"></div> -->
				<div class="back-img" style="background-image:url(${fn:indexOf(cornerList.mainBannerList[0].bnrImgPath, 'cdn.ntruss.com') > -1 ? cornerList.mainBannerList[0].bnrImgPath : frame:optImagePath(cornerList.mainBannerList[0].bnrImgPath, frontConstants.IMG_OPT_QRY_788)});"></div>
					<div class="remote-area">
						<button class="swiper-button-next" type="button"></button>
						<button class="swiper-button-prev" type="button"></button>
					</div>
			</div>
			<!-- //Swiper -->
		</section>
	</c:if>
</c:forEach>