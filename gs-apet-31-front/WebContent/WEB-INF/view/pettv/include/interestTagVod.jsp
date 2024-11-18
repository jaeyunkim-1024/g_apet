<c:forEach var="cornerList" items="${cornerList}"  varStatus="status" >
	<c:if test="${param.dispCornNo == cornerList.dispCornNo }">
		<!-- 내가 등록한 관심 태그 --> 
		<section class="tag">
			<!-- 변경전 마크업 APET-1103 -->
			<%--<div class="title-area">
				<c:choose>
	            	<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
	                	<a id="hashTagVodList" href="/tv/hashTagList?tagNo=${cornerList.interestTagList[0].tagNo}" ><h1>내가 등록한 관심 <em class="tit">#TAG</em></h1></a>
					</c:when>
	                <c:otherwise>
	                	<h1>내가 등록한 관심 <em>#TAG</em></h1>
	                </c:otherwise>
                </c:choose>
				<div class="tag-zone">
					<ul id="tagUl">
						<c:forEach var="tagList" items="${cornerList.interestTagList}" begin="0" end="2" varStatus="status">
							<li><button type="button" id="tagVodListBtn${tagList.tagNo}" onclick="vodTagList('${tagList.tagNo}', '${cornerList.dupleVdIds }');">#${tagList.tagNm}</button></li>
						</c:forEach>
					</ul>
				</div>
			</div>--%>
			<!-- //변경전 마크업 APET-1103 -->
			<!-- 변경후 마크업 APET-1103 -->
			<div class="hdts">
				<c:choose>
	            	<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
	            		<a id="hashTagVodList" class="hdt" href="#" onclick="fncGoUrl('/tv/hashTagList?tagNo=${cornerList.interestTagList[0].tagNo}'); return false;">
							<span class="tit">내가 등록한 관심 <em>#TAG</em></span>
							<span class="more"><b class="t">전체보기</b></span>
						</a>
					</c:when>
	                <c:otherwise>
						<span class="tit">내가 등록한 관심 <em>#TAG</em></span>
	                </c:otherwise>
                </c:choose>
				<div class="tag-zone">
					<ul id="tagUl">
						<c:forEach var="tagList" items="${cornerList.interestTagList}" begin="0" end="${cornerList.showCnt-1}" varStatus="status">
							<li><button type="button" id="tagVodListBtn${tagList.tagNo}" onclick="vodTagList('${tagList.tagNo}', '${cornerList.dupleVdIds }');">#${tagList.tagNm}</button></li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<!-- //변경후 마크업 APET-1103 -->
			<div class="swiper-div newDn petTvMb">
				<div class="swiper-container">
					<ul class="swiper-wrapper" id="tagLists">
						<c:forEach var="interestVod" items="${cornerList.interestVodList }" begin="0" end="9">
						<li class="swiper-slide">
							<div class="thumb-box">
								<c:choose>
									<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_30}">
										<%-- 펫TV 홈/ 영상목록에서 자동재생 삭제로 인해 주석처리-CSR-1247
										<a href="javascript:goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${interestVod.vdId}&sortCd=&listGb=HOME')" name="autoFalse" class="thumb-img" style="background-image:url(${fn:indexOf(interestVod.thumPath, 'cdn.ntruss.com') > -1 ? interestVod.thumPath : frame:optImagePath(interestVod.thumPath, frontConstants.IMG_OPT_QRY_750)}); display:none;" data-content="${interestVod.vdId}" data-url="/tv/series/indexTvDetail?vdId=${interestVod.vdId}&sortCd=&listGb=HOME">
											<div class="time-tag"><span>${interestVod.totLnth}</span></div>
										</a>
										<div class="vthumbs autoTrue" video_id="${interestVod.outsideVdId}" type="video_thumb_360p" lazy="scroll" style="height:80px;" onclick="goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${interestVod.vdId}&sortCd=&listGb=HOME')">
											<a href="javascript:goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${interestVod.vdId}&sortCd=&listGb=HOME')" class="thumb-img" style="background-image:url(${fn:indexOf(interestVod.thumPath, 'cdn.ntruss.com') > -1 ? interestVod.thumPath : frame:optImagePath(interestVod.thumPath, frontConstants.IMG_OPT_QRY_750)});" data-content="${interestVod.vdId}" data-url="${view.stDomain}/tv/series/indexTvDetail?vdId=${interestVod.vdId}&sortCd=&listGb=HOME">
	                              	 			<div class="time-tag"><span>${interestVod.totLnth}</span></div>
	                              	 		</a>
                              	 		</div>
                              	 		--%>
                              	 		
                              	 		<a href="#" onclick="goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${interestVod.vdId}&sortCd=&listGb=HOME'); return false;" name="autoFalse" class="thumb-img" style="background-image:url(${fn:indexOf(interestVod.thumPath, 'cdn.ntruss.com') > -1 ? interestVod.thumPath : frame:optImagePath(interestVod.thumPath, frontConstants.IMG_OPT_QRY_750)});" data-content="${interestVod.vdId}" data-url="/tv/series/indexTvDetail?vdId=${interestVod.vdId}&sortCd=&listGb=HOME">
											<div class="time-tag"><span>${interestVod.totLnth}</span></div>
										</a>
                                	</c:when>
									<c:otherwise>
										<a href="#" onclick="fncGoUrl('/tv/series/indexTvDetail?vdId=${interestVod.vdId}&sortCd=&listGb=HOME'); return false;" class="thumb-img" style="background-image:url(${fn:indexOf(interestVod.thumPath, 'cdn.ntruss.com') > -1 ? interestVod.thumPath : frame:optImagePath(interestVod.thumPath, frontConstants.IMG_OPT_QRY_750)});" data-content="${interestVod.vdId}" data-url="/tv/series/indexTvDetail?vdId=${interestVod.vdId}&sortCd=&listGb=HOME">
											<div class="time-tag"><span>${interestVod.totLnth}</span></div>
										</a>
									</c:otherwise>
								</c:choose>
                                <div class="thumb-info top">
                                	<c:choose>
	                                	<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
	                                		<div class="round-img-pf" onclick="fncGoUrl('/tv/series/petTvSeriesList?srisNo=${interestVod.srisNo}&sesnNo=1');" style="background-image:url(${fn:indexOf(interestVod.srisPrflImgPath, 'cdn.ntruss.com') > -1 ? interestVod.srisPrflImgPath : frame:optImagePath(interestVod.srisPrflImgPath, frontConstants.IMG_OPT_QRY_785)}); cursor:pointer;"></div>
	                                	</c:when>
	                                	<c:otherwise>
	                                		<div class="round-img-pf" onclick="fncGoUrl('/tv/series/petTvSeriesList?srisNo=${interestVod.srisNo}&sesnNo=1');" style="background-image:url(${fn:indexOf(interestVod.srisPrflImgPath, 'cdn.ntruss.com') > -1 ? interestVod.srisPrflImgPath : frame:optImagePath(interestVod.srisPrflImgPath, frontConstants.IMG_OPT_QRY_786)}); cursor:pointer;"></div>
	                                	</c:otherwise>
                                	</c:choose>
                                    <div class="info">
                                        <div class="tlt">
	                                        <c:choose>
												<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_30}">
													<a href="#" onclick="goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${interestVod.vdId}&sortCd=&listGb=HOME'); return false;" data-content="${interestVod.vdId}" data-url="/tv/series/indexTvDetail?vdId=${interestVod.vdId}&sortCd=&listGb=HOME">
														${interestVod.ttl}
													</a>
			                                	</c:when>
												<c:otherwise>
													<a href="#" onclick="fncGoUrl('/tv/series/indexTvDetail?vdId=${interestVod.vdId}&sortCd=&listGb=HOME'); return false;" data-content="${interestVod.vdId}" data-url="/tv/series/indexTvDetail?vdId=${interestVod.vdId}&sortCd=&listGb=HOME">
														${interestVod.ttl}
													</a>
												</c:otherwise>
											</c:choose>
                                        </div>
                                        <div class="detail">
                                            <!--<span class="read play">${interestVod.hits}</span>-->
                                            <span class="read like" data-read-like="${interestVod.vdId}"><fmt:formatNumber type="number" value="${interestVod.likeCnt }"/></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        </c:forEach>
                        <!-- 더보기 버튼 -->
                        <c:choose>
                        	<c:when test="${fn:length(cornerList.interestVodList) == 10}">
                        		<li class="swiper-slide btn-more">
                        			<a href="#" onclick="fncGoUrl('/tv/hashTagList?tagNo=${cornerList.interestTagList[0].tagNo}'); return false;">
                            			<button type="button">
                                			<i>더보기</i>
                            			</button>
                            		</a>
                        		</li>
                        	</c:when>
                        	<c:otherwise>
                        		<li class="swiper-slide btn-more swiper-slide-next" style="margin-right: 8px;">
                                	<div style="width:62.53px;">
                                	</div>
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
</c:forEach>