<c:forEach var="cornerList" items="${cornerList}"  varStatus="status" >
	<c:if test="${param.dispCornNo == cornerList.dispCornNo }">
		<c:if test="${fn:length(cornerList.recentlyList) > 0 and session.mbrNo ne frontConstants.NO_MEMBER_NO}">
			<!-- 최근 본 영상 --> 
			<section class="recent"> <!-- 없을경우  style="display:none" -->
				<!-- 변경전 마크업 APET-1103 -->
				<%--<div class="title-area">
					<a href="/tv/series/indexTvRecentVideo?listGb=TV"  class="tit">최근 본 영상</a>
				</div>--%>
				<!-- //변경전 마크업 APET-1103 -->
				<!-- 변경후 마크업 APET-1103 -->
				<div class="hdts">
					<a class="hdt" href="#" onclick="fncGoUrl('/tv/series/indexTvRecentVideo?listGb=TV'); return false;">
						<span class="tit">최근 본 영상</span>
						<span class="more"><b class="t">전체보기</b></span>
					</a>
				</div>
				<!-- //변경후 마크업 APET-1103 -->
				<div class="swiper-div newDn petTvMb">
					<div class="swiper-container">
						<ul class="swiper-wrapper">
							<c:forEach var="watchHistList" items="${cornerList.recentlyList}" begin="0" end="${cornerList.showCnt-1}">
							<li class="swiper-slide">
								<div class="thumb-box">
									<div class="circular">
                                     	<c:choose>
											<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
												<c:if test="${watchHistList.vdGbCd eq frontConstants.VD_GB_10 }">
	                                     			<a href="#" onclick="fncGoUrl('/tv/school/indexTvDetail?vdId=${watchHistList.vdId}'); return false;" data-content="${watchHistList.vdId}" data-url="/tv/school/indexTvDetail?vdId=${watchHistList.vdId}">
		                                     			<div class="inner" style="background-image:url(${fn:indexOf(watchHistList.acPrflImgPath, 'cdn.ntruss.com') > -1 ? watchHistList.acPrflImgPath : frame:optImagePath(watchHistList.acPrflImgPath, frontConstants.IMG_OPT_QRY_763)});"></div>
		                                         	</a>
	                                     		</c:if>
	                                     		<c:if test="${watchHistList.vdGbCd eq frontConstants.VD_GB_20 }">
	                                     			<a href="#" onclick="fncGoUrl('/tv/series/indexTvDetail?vdId=${watchHistList.vdId}&sortCd=&listGb=HOME'); return false;" data-content="${watchHistList.vdId}" data-url="/tv/series/indexTvDetail?vdId=${watchHistList.vdId}&sortCd=&listGb=HOME">
	                                     				<div class="inner" style="background-image:url(${fn:indexOf(watchHistList.acPrflImgPath, 'cdn.ntruss.com') > -1 ? watchHistList.acPrflImgPath : frame:optImagePath(watchHistList.acPrflImgPath, frontConstants.IMG_OPT_QRY_763)});"></div>
		                                         	</a>
	                                     		</c:if>
	                                        </c:when>
	                                        <c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_20}">
												<c:if test="${watchHistList.vdGbCd eq frontConstants.VD_GB_10 }">
	                                     			<a href="#" onclick="fncGoUrl('/tv/school/indexTvDetail?vdId=${watchHistList.vdId}'); return false;" data-content="${watchHistList.vdId}" data-url="/tv/school/indexTvDetail?vdId=${watchHistList.vdId}">
		                                     			<div class="inner" style="background-image:url(${fn:indexOf(watchHistList.acPrflImgPath, 'cdn.ntruss.com') > -1 ? watchHistList.acPrflImgPath : frame:optImagePath(watchHistList.acPrflImgPath, frontConstants.IMG_OPT_QRY_764)});"></div>
		                                         	</a>
	                                     		</c:if>
	                                     		<c:if test="${watchHistList.vdGbCd eq frontConstants.VD_GB_20 }">
	                                     			<a href="#" onclick="fncGoUrl('/tv/series/indexTvDetail?vdId=${watchHistList.vdId}&sortCd=&listGb=HOME'); return false;" onclick="videoAllPauses();" data-content="${watchHistList.vdId}" data-url="/tv/series/indexTvDetail?vdId=${watchHistList.vdId}&sortCd=&listGb=HOME">
		                                     			<div class="inner" style="background-image:url(${fn:indexOf(watchHistList.acPrflImgPath, 'cdn.ntruss.com') > -1 ? watchHistList.acPrflImgPath : frame:optImagePath(watchHistList.acPrflImgPath, frontConstants.IMG_OPT_QRY_764)});"></div>
		                                         	</a>
	                                     		</c:if>
	                                        </c:when>
											<c:otherwise>
												<c:if test="${watchHistList.vdGbCd eq frontConstants.VD_GB_10 }">
													<%-- APP에서 펫스쿨 상세 기존 onNewPage 호출 ==> 페이지 호출방식으로 변경 / 펫스쿨 상세는 pc, mo, app 모두 호출방식 동일함.
													<a href="javascript:goUrl('onNewPage', 'TV', '${view.stDomain}/tv/school/indexTvDetail?vdId=${watchHistList.vdId}')" data-content="${watchHistList.vdId}" data-url="${view.stDomain}/tv/school/indexTvDetail?vdId=${watchHistList.vdId}">
													--%>
													
													<a href="#" onclick="fncGoUrl('/tv/school/indexTvDetail?vdId=${watchHistList.vdId}'); return false;" data-content="${watchHistList.vdId}" data-url="/tv/school/indexTvDetail?vdId=${watchHistList.vdId}">
														<div class="inner" style="background-image:url(${fn:indexOf(watchHistList.acPrflImgPath, 'cdn.ntruss.com') > -1 ? watchHistList.acPrflImgPath : frame:optImagePath(watchHistList.acPrflImgPath, frontConstants.IMG_OPT_QRY_764)});"></div>
		                                         	</a>
												</c:if>
												<c:if test="${watchHistList.vdGbCd eq frontConstants.VD_GB_20 }">
													<a href="#" onclick="goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${watchHistList.vdId}&sortCd=&listGb=HOME'); return false;" data-content="${watchHistList.vdId}" data-url="${view.stDomain}/tv/series/indexTvDetail?vdId=${watchHistList.vdId}&sortCd=&listGb=HOME">
														<div class="inner" style="background-image:url(${fn:indexOf(watchHistList.acPrflImgPath, 'cdn.ntruss.com') > -1 ? watchHistList.acPrflImgPath : frame:optImagePath(watchHistList.acPrflImgPath, frontConstants.IMG_OPT_QRY_764)});"></div>
		                                         	</a>
												</c:if>
											</c:otherwise>
										</c:choose>
										<c:if test="${watchHistList.progressBar ne null and watchHistList.progressBar ne '' and watchHistList.progressBar > 10}">
                                         	<div class="circlePie" data-p="${watchHistList.progressBar}"></div>
										</c:if>
									</div>
									<div class="info k0429">
										<div class="tlt">
											<c:choose>
												<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_30}">
													<c:if test="${watchHistList.vdGbCd eq frontConstants.VD_GB_10 }">
														<a href="#" onclick="fncGoUrl('/tv/school/indexTvDetail?vdId=${watchHistList.vdId}'); return false;" data-content="${watchHistList.vdId}" data-url="/tv/school/indexTvDetail?vdId=${watchHistList.vdId}">
															${watchHistList.ttl}
			                                         	</a>
													</c:if>
													<c:if test="${watchHistList.vdGbCd eq frontConstants.VD_GB_20 }">
														<a href="#" onclick="goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${watchHistList.vdId}&sortCd=&listGb=HOME'); return false;" data-content="${watchHistList.vdId}" data-url="${view.stDomain}/tv/series/indexTvDetail?vdId=${watchHistList.vdId}&sortCd=&listGb=HOME">
															${watchHistList.ttl}
			                                         	</a>
													</c:if>
		                                        </c:when>
												<c:otherwise>
													<c:if test="${watchHistList.vdGbCd eq frontConstants.VD_GB_10 }">
		                                     			<a href="#" onclick="fncGoUrl('/tv/school/indexTvDetail?vdId=${watchHistList.vdId}'); return false;" data-content="${watchHistList.vdId}" data-url="/tv/school/indexTvDetail?vdId=${watchHistList.vdId}">
			                                     			${watchHistList.ttl}
			                                         	</a>
		                                     		</c:if>
		                                     		<c:if test="${watchHistList.vdGbCd eq frontConstants.VD_GB_20 }">
		                                     			<a href="#" onclick="fncGoUrl('/tv/series/indexTvDetail?vdId=${watchHistList.vdId}&sortCd=&listGb=HOME'); return false;" data-content="${watchHistList.vdId}" data-url="/tv/series/indexTvDetail?vdId=${watchHistList.vdId}&sortCd=&listGb=HOME">
		                                     				${watchHistList.ttl}
			                                         	</a>
		                                     		</c:if>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
							</li>
							</c:forEach>
							<!-- 더보기 버튼 -->
							<c:choose>
								<c:when test="${fn:length(cornerList.recentlyList) >= cornerList.showCnt }">
									<li class="swiper-slide btn-more">
										<a href="#" onclick="fncGoUrl('/tv/series/indexTvRecentVideo?listGb=TV'); return false;">
											<button type="button">
											    <i>더보기</i>
											</button>
                                 		</a>
                             		</li>
                             	</c:when>
                             	<c:otherwise>
                             		<li class="swiper-slide btn-more">
                             			<a href="#">
                                 		</a>
                             		</li>
                             	</c:otherwise>
							</c:choose>
						</ul>
					</div>
					<div class="remote-area">
						<button class="swiper-button-next" type="button"></button>
						<button class="swiper-button-prev" type="button"></button>
					</div>
				</div>
				<!-- //Swiper -->
			</section>
		</c:if>
	</c:if>
</c:forEach>