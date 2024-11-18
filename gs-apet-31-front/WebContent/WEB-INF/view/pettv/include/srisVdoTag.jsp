<c:forEach var="cornerList" items="${cornerList}"  varStatus="status" >
	<c:if test="${param.dispCornNo == cornerList.dispCornNo }">
		<c:if test="${cornerList.dispCornTpCd eq '130' or cornerList.dispCornTpCd eq '132' }">
		<!--  TV 전시 - 시리즈 TAG, 시리즈(미고정) -->
		<section class="exhibition series">
			<div class="hdts">
				<a class="hdt" href="#" onclick="fncGoUrl('/tv/seriesTagList?dispCornNo=${param.dispCornNo}'); return false;">
					<span class="tit">${cornerList.dispCornNm }</span>
					<span class="more"><b class="t">전체보기</b></span>
				</a>
			</div>
			<div class="swiper-div newDn petTvMb">
				<div class="swiper-container">
					<ul class="swiper-wrapper">
						<c:forEach var="seriesTagList" items="${cornerList.seriesTagList}" varStatus="idx" begin="0" end="${cornerList.showCnt-1}">
							<li class="swiper-slide">
								<div class="thumb-box">
									<a href="#" onclick="fncGoUrl('/tv/series/petTvSeriesList?srisNo=${seriesTagList.srisNo}&sesnNo=1'); return false;" class="thumb-img" style="background-image:url(${fn:indexOf(seriesTagList.srisImgPath, 'cdn.ntruss.com') > -1 ? seriesTagList.srisImgPath : frame:optImagePath(seriesTagList.srisImgPath, frontConstants.IMG_OPT_QRY_100)});"></a>
								</div>
							</li>
						</c:forEach>
						<!-- 더보기 버튼 . 10개 이하 보여주지 않음-->
						<li class="swiper-slide btn-more">
							<c:if test="${fn:length(cornerList.seriesTagList) gt cornerList.showCnt }" >
							<button type="button" onclick="fncGoUrl('/tv/seriesTagList?dispCornNo=${param.dispCornNo}'); return false;">
								<i>더보기</i>
							</button>
							</c:if>
						</li>
					</ul>
				</div>
				
				<div class="remote-area">
					<button class="swiper-button-next" type="button"></button>
					<button class="swiper-button-prev" type="button"></button>
				</div>
			</div>
		</section>
		<!--  //TV 전시 - 시리즈 TAG -->
		</c:if>
		<c:if test="${cornerList.dispCornTpCd eq '131' or cornerList.dispCornTpCd eq '133' }">
		<!--  TV 전시 - 동영상 TAG, 동영상(미고정) -->
		<section class="exhibition video">
			<div class="hdts">
				<a class="hdt" href="#" onclick="fncGoUrl('/tv/tagVodList?dispCornNo=${param.dispCornNo}'); return false;">
					<span class="tit">${cornerList.dispCornNm }</span>
					<span class="more"><b class="t">전체보기</b></span>
				</a>
			</div>
			<div class="swiper-div newDn petTvMb">
				<div class="swiper-container">
					<ul class="swiper-wrapper">
						<c:forEach var="tagVodList" items="${cornerList.tagVodList}" varStatus="idx" begin="0" end="${cornerList.showCnt-1}">
							<li class="swiper-slide">
								<div class="thumb-box">
									<c:choose>
                                    	<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_30}">
                                    		<a href="#" onclick="goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${tagVodList.vdId}&sortCd=&listGb=HOME'); return false;" class="thumb-img" style="background-image:url(${fn:indexOf(tagVodList.thumPath, 'cdn.ntruss.com') > -1 ? tagVodList.thumPath : frame:optImagePath(tagVodList.thumPath, frontConstants.IMG_OPT_QRY_100)});" data-content="${tagVodList.vdId}" data-url="/tv/series/indexTvDetail?vdId=${tagVodList.vdId}&sortCd=&listGb=HOME">
												<div class="time-tag"><span>${tagVodList.totLnth}</span></div>
											</a>
                                    	</c:when>
                                    	<c:otherwise>
                                    		<a href="#" onclick="fncGoUrl('/tv/series/indexTvDetail?vdId=${tagVodList.vdId}&sortCd=&listGb=HOME'); return false;" class="thumb-img" style="background-image:url(${fn:indexOf(tagVodList.thumPath, 'cdn.ntruss.com') > -1 ? tagVodList.thumPath : frame:optImagePath(tagVodList.thumPath, frontConstants.IMG_OPT_QRY_100)});" data-content="${tagVodList.vdId}" data-url="/tv/series/indexTvDetail?vdId=${tagVodList.vdId}&sortCd=&listGb=HOME">
												<div class="time-tag"><span>${tagVodList.totLnth}</span></div>
											</a>
                                    	</c:otherwise>
                                   	</c:choose>
									<div class="thumb-info top">
										<c:choose>
	                                    	<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
	                                    		<div class="round-img-pf" onclick="fncGoUrl('/tv/series/petTvSeriesList?srisNo=${tagVodList.srisNo}&sesnNo=1');" style="background-image:url(${fn:indexOf(tagVodList.srisPrflImgPath, 'cdn.ntruss.com') > -1 ? tagVodList.srisPrflImgPath : frame:optImagePath(tagVodList.srisPrflImgPath, frontConstants.IMG_OPT_QRY_785)}); cursor:pointer;"></div>
	                                    	</c:when>
	                                    	<c:otherwise>
	                                    		<div class="round-img-pf" onclick="fncGoUrl('/tv/series/petTvSeriesList?srisNo=${tagVodList.srisNo}&sesnNo=1');" style="background-image:url(${fn:indexOf(tagVodList.srisPrflImgPath, 'cdn.ntruss.com') > -1 ? tagVodList.srisPrflImgPath : frame:optImagePath(tagVodList.srisPrflImgPath, frontConstants.IMG_OPT_QRY_786)}); cursor:pointer;"></div>
	                                    	</c:otherwise>
                                    	</c:choose>
										<div class="info">
											<div class="tlt">
												<c:choose>
			                                    	<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_30}">
			                                    		<a href="#" onclick="goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${tagVodList.vdId}&sortCd=&listGb=HOME'); return false;" data-content="${tagVodList.vdId}" data-url="/tv/series/indexTvDetail?vdId=${tagVodList.vdId}&sortCd=&listGb=HOME">
				                                   			${tagVodList.ttl}
				                                   		</a>
			                                    	</c:when>
			                                    	<c:otherwise>
			                                    		<a href="#" onclick="fncGoUrl('/tv/series/indexTvDetail?vdId=${tagVodList.vdId}&sortCd=&listGb=HOME'); return false;" data-content="${tagVodList.vdId}" data-url="/tv/series/indexTvDetail?vdId=${tagVodList.vdId}&sortCd=&listGb=HOME">
		                                            		${tagVodList.ttl}
		                                            	</a>
			                                    	</c:otherwise>
		                                    	</c:choose>
											</div>
											
											<div class="detail">
												<!--<span class="read play">${tagVodList.hits}</span>-->
												<span class="read like" data-read-like="${tagVodList.vdId}"><fmt:formatNumber type="number" value="${tagVodList.likeCnt}"/></span>
											</div>
										</div>
									</div>
								</div>
							</li>
						</c:forEach>
						<!-- 더보기 버튼 . 10개 이하 보여주지 않음-->
						<li class="swiper-slide btn-more">
							<c:if test="${fn:length(cornerList.tagVodList) gt cornerList.showCnt }" >
							<button type="button" onclick="fncGoUrl('/tv/tagVodList?dispCornNo=${param.dispCornNo}'); return false;">
								<i>더보기</i>
							</button>
							</c:if>
						</li>
					</ul>
				</div>
				
				<div class="remote-area">
					<button class="swiper-button-next" type="button"></button>
					<button class="swiper-button-prev" type="button"></button>
				</div>
			</div>
			<!-- //Swiper -->
		</section>
		<!--  //TV 전시 - 동영상 TAG -->
		</c:if>
	</c:if>
</c:forEach>