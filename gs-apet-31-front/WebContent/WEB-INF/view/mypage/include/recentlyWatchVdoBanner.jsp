<dl class="sect watch">
	<c:choose>
		<c:when test="${recentVdoList ne '[]' }">
			<dt>
				<a href="/tv/series/indexTvRecentVideo?listGb=MY" data-url="/tv/series/indexTvRecentVideo?listGb=MY" data-content="${session.mbrNo }">
				<span><spring:message code='front.web.view.include.title.recently.viewed.videos' /></span>
				<span class="next all" ><spring:message code='front.web.view.include.title.totalview' /></span>
				</a>
			</dt>
			<dd class="recent">
				<div class="swiper-div">
					<div class="swiper-container">
						<ul class="swiper-wrapper">
							<c:forEach items="${recentVdoList }" var="recentItem" > 
							<li class="swiper-slide">
								<div class="thumb-box">
									<div class="circular">
										<c:if test="${recentItem.vdGbCd eq '10' }">
											<a href="/tv/school/indexTvDetail?vdId=${recentItem.vdId}" data-content="${recentItem.vdId}" data-url="${view.stDomain}/tv/series/indexTvDetail?vdId=${recentItem.vdId}&sortCd=&listGb=HOME">
												<div class="inner" style="background-image:url(${fn:indexOf(recentItem.acPrflImgPath, 'cdn.ntruss.com') > -1 ? recentItem.acPrflImgPath : frame:optImagePath(recentItem.acPrflImgPath, frontConstants.IMG_OPT_QRY_10)});"></div>
                                        	</a>
										</c:if>
										<c:if test="${recentItem.vdGbCd eq '20' }">
											<a href="/tv/series/indexTvDetail?vdId=${recentItem.vdId}&sortCd=&listGb=HOME" data-content="${recentItem.vdId}" data-url="${view.stDomain}/tv/series/indexTvDetail?vdId=${recentItem.vdId}&sortCd=&listGb=HOME">
												<div class="inner" style="background-image:url(${fn:indexOf(recentItem.acPrflImgPath, 'cdn.ntruss.com') > -1 ? recentItem.acPrflImgPath : frame:optImagePath(recentItem.acPrflImgPath, frontConstants.IMG_OPT_QRY_10)});"></div>
                                        	</a>
										</c:if>
										<!-- <div class="inner" style="background-image:url(../../_images/tv/@temp01.jpg);"></div> -->
										<div class="circlePie" data-p="${recentItem.progressBar}"></div>
									</div>
									<div class="info">
										<div class="tlt">${recentItem.ttl}</div>
									</div>
								</div>
							</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</dd>
		</c:when> 
		<c:otherwise>
			<dt>
				<c:if test="${view.deviceGb eq 'PC' }">
				<a href="javascript:location.href='/tv/home';" data-url="/tv/home/" data-content="${session.mbrNo }">
				</c:if>
				<c:if test="${view.deviceGb ne 'PC' }">
				<a href="javascript:location.href='/tv/series/indexTvRecentVideo?listGb=MY';" data-url="/tv/series/indexTvRecentVideo?listGb=MY" data-content="${session.mbrNo }">
				</c:if>
					<span><spring:message code='front.web.view.include.title.recently.viewed.videos' /></span>
					<span class="next all"><spring:message code='front.web.view.include.go.to.pettv.btn' /></span>
				</a>
				
			</dt>
			<dd>
				<p class="nodata"><spring:message code='front.web.view.include.title.no.recent.videos.recommand.watch.pettv' /></p>
			</dd>
		</c:otherwise>
	</c:choose>
</dl>