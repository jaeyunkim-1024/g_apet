 <c:forEach var="cornerList" items="${cornerList}"  varStatus="status" >
	<c:if test="${param.dispCornNo == cornerList.dispCornNo }">
		<!-- 인기영상 --> 
        <section class="popul">
        	<!-- 변경전 마크업 APET-1103 -->
            <%--<div class="title-area">
                <a href="/tv/petTvList?dispCornNo=${param.dispCornNo}" class="tit">
                    지금 뜨는 인기영상
                </a>
            </div>--%>
            <!-- //변경전 마크업 APET-1103 -->
            <!-- 변경후 마크업 APET-1103 -->
            <div class="hdts">
				<a class="hdt" href="#" onclick="fncGoUrl('/tv/petTvList?dispCornNo=${param.dispCornNo}'); return false;">
					<span class="tit">지금 뜨는 인기영상</span>
					<span class="more"><b class="t">전체보기</b></span>
				</a>
			</div>
            <!-- //변경후 마크업 APET-1103 -->
            <div class="swiper-div newDn petTvMb">
                <div class="swiper-container">
                    <ul class="swiper-wrapper" id="popVod">
                    	<c:forEach var="vodList" items="${cornerList.popularList}" varStatus="status">
	                        <li class="swiper-slide">
	                            <div class="thumb-box">
	                            	<c:choose>
										<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
		                                	<a href="#" onclick="fncGoUrl('/tv/series/indexTvDetail?vdId=${vodList.vdId}&sortCd=&listGb=HOME'); return false;" class="thumb-img" style="background-image:url(${fn:indexOf(vodList.thumPath, 'cdn.ntruss.com') > -1 ? vodList.thumPath : frame:optImagePath(vodList.thumPath, frontConstants.IMG_OPT_QRY_753)});" data-content="${vodList.vdId}" data-url="/tv/series/indexTvDetail?vdId=${vodList.vdId}&sortCd=&listGb=HOME">
		                                    	<strong class="ranking">${status.count}</strong>
		                                    	<div class="time-tag"><span>${vodList.totLnth }</span></div>
		                                	</a>
		                                </c:when>
		                                <c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_20}">
		                                	<a href="#" onclick="fncGoUrl('/tv/series/indexTvDetail?vdId=${vodList.vdId}&sortCd=&listGb=HOME'); return false;" class="thumb-img" style="background-image:url(${fn:indexOf(vodList.thumPath, 'cdn.ntruss.com') > -1 ? vodList.thumPath : frame:optImagePath(vodList.thumPath, frontConstants.IMG_OPT_QRY_762)});" data-content="${vodList.vdId}" data-url="/tv/series/indexTvDetail?vdId=${vodList.vdId}&sortCd=&listGb=HOME">
		                                    	<strong class="ranking">${status.count}</strong>
		                                    	<div class="time-tag"><span>${vodList.totLnth }</span></div>
		                                	</a>
		                                </c:when>
										<c:otherwise>
											<%-- 펫TV 홈/ 영상목록에서 자동재생 삭제로 인해 주석처리-CSR-1247
											<a href="javascript:goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${vodList.vdId}&sortCd=&listGb=HOME')" name="autoFalse" class="thumb-img" style="background-image:url(${fn:indexOf(vodList.thumPath, 'cdn.ntruss.com') > -1 ? vodList.thumPath : frame:optImagePath(vodList.thumPath, frontConstants.IMG_OPT_QRY_762)}); display:none;" data-content="${vodList.vdId}" data-url="/tv/series/indexTvDetail?vdId=${vodList.vdId}&sortCd=&listGb=HOME">
		                                    	<strong class="ranking">${status.count}</strong>
		                                    	<div class="time-tag"><span>${vodList.totLnth }</span></div>
		                                	</a>
											<div class="vthumbs autoTrue" video_id="${vodList.outsideVdId}" type="video_thumb_360p" lazy="scroll" style="height:80%px;" onclick="goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${vodList.vdId}&sortCd=&listGb=HOME')">
												<a href="javascript:goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${vodList.vdId}&sortCd=&listGb=HOME')" class="thumb-img" style="background-image:url(${fn:indexOf(vodList.thumPath, 'cdn.ntruss.com') > -1 ? vodList.thumPath : frame:optImagePath(vodList.thumPath, frontConstants.IMG_OPT_QRY_762)});" data-content="${vodList.vdId}" data-url="${view.stDomain}/tv/series/indexTvDetail?vdId=${vodList.vdId}&sortCd=&listGb=HOME">
			                                    	<strong class="ranking">${status.count}</strong>
			                                    	<div class="time-tag"><span>${vodList.totLnth }</span></div>
			                                	</a>
		                                	</div>
		                                	--%>
		                                	
		                                	<a href="#" onclick="goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${vodList.vdId}&sortCd=&listGb=HOME'); return false;" name="autoFalse" class="thumb-img" style="background-image:url(${fn:indexOf(vodList.thumPath, 'cdn.ntruss.com') > -1 ? vodList.thumPath : frame:optImagePath(vodList.thumPath, frontConstants.IMG_OPT_QRY_762)});" data-content="${vodList.vdId}" data-url="/tv/series/indexTvDetail?vdId=${vodList.vdId}&sortCd=&listGb=HOME">
		                                    	<strong class="ranking">${status.count}</strong>
		                                    	<div class="time-tag"><span>${vodList.totLnth }</span></div>
		                                	</a>
										</c:otherwise>
									</c:choose>
	                                <div class="thumb-info top">
	                                	<c:choose>
	                                    	<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
	                                    		<div class="round-img-pf" onclick="fncGoUrl('/tv/series/petTvSeriesList?srisNo=${vodList.srisNo}&sesnNo=1');" style="background-image:url(${fn:indexOf(vodList.srisPrflImgPath, 'cdn.ntruss.com') > -1 ? vodList.srisPrflImgPath : frame:optImagePath(vodList.srisPrflImgPath, frontConstants.IMG_OPT_QRY_785)}); cursor:pointer;"></div>
	                                    	</c:when>
	                                    	<c:otherwise>
	                                    		<div class="round-img-pf" onclick="fncGoUrl('/tv/series/petTvSeriesList?srisNo=${vodList.srisNo}&sesnNo=1');" style="background-image:url(${fn:indexOf(vodList.srisPrflImgPath, 'cdn.ntruss.com') > -1 ? vodList.srisPrflImgPath : frame:optImagePath(vodList.srisPrflImgPath, frontConstants.IMG_OPT_QRY_786)}); cursor:pointer;"></div>
	                                    	</c:otherwise>
	                                    </c:choose>
	                                    <div class="info">
											<div class="tlt">
												<c:choose>
													<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_30}">
														<a href="#" onclick="goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${vodList.vdId}&sortCd=&listGb=HOME'); return false;" data-content="${vodList.vdId}" data-url="/tv/series/indexTvDetail?vdId=${vodList.vdId}&sortCd=&listGb=HOME">
					                                    	${vodList.ttl}
					                                	</a>
					                                </c:when>
													<c:otherwise>
														<a href="#" onclick="fncGoUrl('/tv/series/indexTvDetail?vdId=${vodList.vdId}&sortCd=&listGb=HOME'); return false;" data-content="${vodList.vdId}" data-url="/tv/series/indexTvDetail?vdId=${vodList.vdId}&sortCd=&listGb=HOME">
					                                    	${vodList.ttl}
					                                	</a>
													</c:otherwise>
												</c:choose>
											</div>
	                                        <div class="detail">
	                                            <!--<span class="read play">${vodList.hits }</span>-->
	                                            <span class="read like" data-read-like="${vodList.vdId}"><fmt:formatNumber type="number" value="${vodList.likeCnt }"/></span>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </li>
                        </c:forEach>
                        <!-- 더보기 버튼 -->
                        <li class="swiper-slide btn-more">
                        	<a href="#" onclick="fncGoUrl('/tv/petTvList?dispCornNo=${param.dispCornNo}'); return false;">
                            	<button type="button">
                            		<i>더보기</i>
                            	</button>
                            </a>
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
	</c:if>
</c:forEach>