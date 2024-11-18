 <c:forEach var="cornerList" items="${cornerList}"  varStatus="status" >
	<c:if test="${param.dispCornNo == cornerList.dispCornNo }">
 		<c:if test="${session.mbrNo ne frontConstants.NO_MEMBER_NO and fn:length(cornerList.customList) > 0}">
            <!-- 맞춤영상 --> 
            <section class="fit">
            	<!-- 변경전 마크업 APET-1103 -->
                <%--<div class="title-area">
                    <a href="/tv/petTvList?dispCornNo=${param.dispCornNo}"  class="tit">
                        <em id="nickNm">${session.nickNm }</em>님을 위한 맞춤 영상👍
                    </a>
                </div>--%>
                <!-- //변경전 마크업 APET-1103 -->
                <!-- 변경후 마크업 APET-1103 -->
                <div class="hdts">
					<a class="hdt" href="#" onclick="fncGoUrl('/tv/petTvList?dispCornNo=${param.dispCornNo}'); return false;">
						<span class="tit"><em id="nickNm">${session.nickNm }</em>님을 위한 맞춤 영상👍</span>
						<span class="more"><b class="t">전체보기</b></span>
					</a>
				</div>
                <!-- //변경후 마크업 APET-1103 -->
                <div class="swiper-div newDn petTvMb">
                    <div class="swiper-container">
                        <ul class="swiper-wrapper">
                        	<c:forEach var="optimalVodList" items="${cornerList.customList}">
                            <%--
							<li class="swiper-slide">
                                <div class="thumb-box">
                                	<c:choose>
									<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
										<!--(http://jira.aboutpet.co.kr/browse/CSR-1142) 해당이슈의 요청으로 인해 임시로 추천 일치율 미노출로 수정->2021.05.26 by dslee
										<c:if test="${optimalVodList.intRate >= 50}">
											<span class="match"><em>${optimalVodList.intRate}%</em>일치</span>
										</c:if>
										-->
									<c:choose>
										<c:when test="${optimalVodList.vdGbCd eq frontConstants.VD_GB_20 }">
											<a href="/tv/series/indexTvDetail?vdId=${optimalVodList.vdId}&sortCd=&listGb=HOME" class="thumb-img" style="background-image:url(${fn:indexOf(optimalVodList.thumPath, 'cdn.ntruss.com') > -1 ? optimalVodList.thumPath : frame:optImagePath(optimalVodList.thumPath, frontConstants.IMG_OPT_QRY_753)});" data-content="${optimalVodList.vdId}" data-url="/tv/series/indexTvDetail?vdId=${optimalVodList.vdId}&sortCd=&listGb=HOME">
                                    			<div class="time-tag"><span>${optimalVodList.totLnth}</span></div>
                                    		</a>
										</c:when>
										<c:otherwise>
											<a href="/tv/school/indexTvDetail?vdId=${optimalVodList.vdId}" class="thumb-img" style="background-image:url(${fn:indexOf(optimalVodList.thumPath, 'cdn.ntruss.com') > -1 ? optimalVodList.thumPath : frame:optImagePath(optimalVodList.thumPath, frontConstants.IMG_OPT_QRY_753)});" data-content="${optimalVodList.vdId}" data-url="/tv/school/indexTvDetail?vdId=${optimalVodList.vdId}">
                                    			<div class="time-tag"><span>${optimalVodList.totLnth}</span></div>
                                    		</a>
										</c:otherwise>
									</c:choose>
                                    </c:when>
                                    <c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_20}">
                                    	<!--(http://jira.aboutpet.co.kr/browse/CSR-1142) 해당이슈의 요청으로 인해 임시로 추천 일치율 미노출로 수정->2021.05.26 by dslee
										<c:if test="${optimalVodList.intRate >= 50}">
											<span class="match"><em>${optimalVodList.intRate}%</em>일치</span>
										</c:if>
										-->
									<c:choose>
										<c:when test="${optimalVodList.vdGbCd eq frontConstants.VD_GB_20 }">
											<a href="/tv/series/indexTvDetail?vdId=${optimalVodList.vdId}&sortCd=&listGb=HOME" class="thumb-img" style="background-image:url(${fn:indexOf(optimalVodList.thumPath, 'cdn.ntruss.com') > -1 ? optimalVodList.thumPath : frame:optImagePath(optimalVodList.thumPath, frontConstants.IMG_OPT_QRY_762)});" data-content="${optimalVodList.vdId}" data-url="/tv/series/indexTvDetail?vdId=${optimalVodList.vdId}&sortCd=&listGb=HOME">
                                    			<div class="time-tag"><span>${optimalVodList.totLnth}</span></div>
                                    		</a>
										</c:when>
										<c:otherwise>
											<a href="/tv/school/indexTvDetail?vdId=${optimalVodList.vdId}" class="thumb-img" style="background-image:url(${fn:indexOf(optimalVodList.thumPath, 'cdn.ntruss.com') > -1 ? optimalVodList.thumPath : frame:optImagePath(optimalVodList.thumPath, frontConstants.IMG_OPT_QRY_762)});" data-content="${optimalVodList.vdId}" data-url="/tv/school/indexTvDetail?vdId=${optimalVodList.vdId}">
                                    			<div class="time-tag"><span>${optimalVodList.totLnth}</span></div>
                                    		</a>
										</c:otherwise>
									</c:choose>
                                    </c:when>
									<c:otherwise>
										<!--(http://jira.aboutpet.co.kr/browse/CSR-1142) 해당이슈의 요청으로 인해 임시로 추천 일치율 미노출로 수정->2021.05.26 by dslee
										<c:if test="${optimalVodList.intRate >= 50}">
											<span class="match"><em>${optimalVodList.intRate}%</em>일치</span>
										</c:if>
										-->
										<a href="javascript:goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${optimalVodList.vdId}&sortCd=&listGb=HOME')" name="autoFalse" class="thumb-img" style="background-image:url(${fn:indexOf(optimalVodList.thumPath, 'cdn.ntruss.com') > -1 ? optimalVodList.thumPath : frame:optImagePath(optimalVodList.thumPath, frontConstants.IMG_OPT_QRY_762)}); display:none;" data-content="${optimalVodList.vdId}" data-url="/tv/series/indexTvDetail?vdId=${optimalVodList.vdId}&sortCd=&listGb=HOME">
                                   			<div class="time-tag"><span>${optimalVodList.totLnth}</span></div>
                                   		</a>
                                   		<div class="vthumbs autoTrue" video_id="${optimalVodList.outsideVdId}" type="video_thumb_360p" lazy="scroll" style="height:80%px;" onclick="goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${optimalVodList.vdId}&sortCd=&listGb=HOME')">
										<a href="javascript:goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${optimalVodList.vdId}&sortCd=&listGb=HOME')" class="thumb-img" style="background-image:url(${fn:indexOf(optimalVodList.thumPath, 'cdn.ntruss.com') > -1 ? optimalVodList.thumPath : frame:optImagePath(optimalVodList.thumPath, frontConstants.IMG_OPT_QRY_762)});" data-content="${optimalVodList.vdId}" data-url="${view.stDomain}/tv/series/indexTvDetail?vdId=${optimalVodList.vdId}&sortCd=&listGb=HOME">
                                        	<div class="time-tag"><span>${optimalVodList.totLnth}</span></div>
                                    	</a>
                                    	</div>
									</c:otherwise>
								</c:choose>
                                    <div class="thumb-info top">
                                    	<c:choose>
                                    	<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
                                    		<div class="round-img-pf" onclick="srisDetail(${optimalVodList.srisNo});" style="background-image:url(${fn:indexOf(optimalVodList.srisPrflImgPath, 'cdn.ntruss.com') > -1 ? optimalVodList.srisPrflImgPath : frame:optImagePath(optimalVodList.srisPrflImgPath, frontConstants.IMG_OPT_QRY_785)});"></div>
                                    	</c:when>
                                    	<c:otherwise>
                                    		<div class="round-img-pf" onclick="srisDetail(${optimalVodList.srisNo});" style="background-image:url(${fn:indexOf(optimalVodList.srisPrflImgPath, 'cdn.ntruss.com') > -1 ? optimalVodList.srisPrflImgPath : frame:optImagePath(optimalVodList.srisPrflImgPath, frontConstants.IMG_OPT_QRY_786)});"></div>
                                    	</c:otherwise>
                                    	</c:choose>
                                        <div class="info">
                                            <div class="tlt">${optimalVodList.ttl}</div>
                                            <div class="detail">
                                                <!--<span class="read play">${optimalVodList.hits}</span>-->
                                                <span class="read like">${optimalVodList.likeCnt}</span>
                                                
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </li>
                           	--%>
                           
							<li class="swiper-slide">
                                <div class="thumb-box">
                                	<c:choose>
										<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
											<!--(http://jira.aboutpet.co.kr/browse/CSR-1142) 해당이슈의 요청으로 인해 임시로 추천 일치율 미노출로 수정->2021.05.26 by dslee
											<c:if test="${optimalVodList.intRate >= 50}">
												<span class="match"><em>${optimalVodList.intRate}%</em>일치</span>
											</c:if>
											-->
											<a href="#" onclick="fncGoUrl('/tv/series/indexTvDetail?vdId=${optimalVodList.vdId}&sortCd=&listGb=HOME'); return false;" class="thumb-img" style="background-image:url(${fn:indexOf(optimalVodList.thumPath, 'cdn.ntruss.com') > -1 ? optimalVodList.thumPath : frame:optImagePath(optimalVodList.thumPath, frontConstants.IMG_OPT_QRY_753)});" data-content="${optimalVodList.vdId}" data-url="/tv/series/indexTvDetail?vdId=${optimalVodList.vdId}&sortCd=&listGb=HOME">
                                    			<div class="time-tag"><span>${optimalVodList.totLnth}</span></div>
                                    		</a>
	                                    </c:when>
	                                    <c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_20}">
	                                    	<!--(http://jira.aboutpet.co.kr/browse/CSR-1142) 해당이슈의 요청으로 인해 임시로 추천 일치율 미노출로 수정->2021.05.26 by dslee
											<c:if test="${optimalVodList.intRate >= 50}">
												<span class="match"><em>${optimalVodList.intRate}%</em>일치</span>
											</c:if>
											-->
											<a href="#" onclick="fncGoUrl('/tv/series/indexTvDetail?vdId=${optimalVodList.vdId}&sortCd=&listGb=HOME'); return false;" class="thumb-img" style="background-image:url(${fn:indexOf(optimalVodList.thumPath, 'cdn.ntruss.com') > -1 ? optimalVodList.thumPath : frame:optImagePath(optimalVodList.thumPath, frontConstants.IMG_OPT_QRY_762)});" data-content="${optimalVodList.vdId}" data-url="/tv/series/indexTvDetail?vdId=${optimalVodList.vdId}&sortCd=&listGb=HOME">
                                    			<div class="time-tag"><span>${optimalVodList.totLnth}</span></div>
                                    		</a>
	                                    </c:when>
										<c:otherwise>
											<!--(http://jira.aboutpet.co.kr/browse/CSR-1142) 해당이슈의 요청으로 인해 임시로 추천 일치율 미노출로 수정->2021.05.26 by dslee
											<c:if test="${optimalVodList.intRate >= 50}">
												<span class="match"><em>${optimalVodList.intRate}%</em>일치</span>
											</c:if>
											-->
											
											<%-- 펫TV 홈/ 영상목록에서 자동재생 삭제로 인해 주석처리-CSR-1247
											<a href="javascript:goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${optimalVodList.vdId}&sortCd=&listGb=HOME')" name="autoFalse" class="thumb-img" style="background-image:url(${fn:indexOf(optimalVodList.thumPath, 'cdn.ntruss.com') > -1 ? optimalVodList.thumPath : frame:optImagePath(optimalVodList.thumPath, frontConstants.IMG_OPT_QRY_762)}); display:none;" data-content="${optimalVodList.vdId}" data-url="/tv/series/indexTvDetail?vdId=${optimalVodList.vdId}&sortCd=&listGb=HOME">
	                                   			<div class="time-tag"><span>${optimalVodList.totLnth}</span></div>
	                                   		</a>
	                                   		<div class="vthumbs autoTrue" video_id="${optimalVodList.outsideVdId}" type="video_thumb_360p" lazy="scroll" style="height:80%px;" onclick="goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${optimalVodList.vdId}&sortCd=&listGb=HOME')">
												<a href="javascript:goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${optimalVodList.vdId}&sortCd=&listGb=HOME')" class="thumb-img" style="background-image:url(${fn:indexOf(optimalVodList.thumPath, 'cdn.ntruss.com') > -1 ? optimalVodList.thumPath : frame:optImagePath(optimalVodList.thumPath, frontConstants.IMG_OPT_QRY_762)});" data-content="${optimalVodList.vdId}" data-url="${view.stDomain}/tv/series/indexTvDetail?vdId=${optimalVodList.vdId}&sortCd=&listGb=HOME">
		                                        	<div class="time-tag"><span>${optimalVodList.totLnth}</span></div>
		                                    	</a>
	                                    	</div>
	                                    	--%>
	                                    	
	                                    	<a href="#" onclick="goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${optimalVodList.vdId}&sortCd=&listGb=HOME'); return false;" name="autoFalse" class="thumb-img" style="background-image:url(${fn:indexOf(optimalVodList.thumPath, 'cdn.ntruss.com') > -1 ? optimalVodList.thumPath : frame:optImagePath(optimalVodList.thumPath, frontConstants.IMG_OPT_QRY_762)});" data-content="${optimalVodList.vdId}" data-url="/tv/series/indexTvDetail?vdId=${optimalVodList.vdId}&sortCd=&listGb=HOME">
	                                   			<div class="time-tag"><span>${optimalVodList.totLnth}</span></div>
	                                   		</a>
										</c:otherwise>
									</c:choose>
                                    <div class="thumb-info top">
                                    	<c:choose>
	                                    	<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
	                                    		<div class="round-img-pf" onclick="fncGoUrl('/tv/series/petTvSeriesList?srisNo=${optimalVodList.srisNo}&sesnNo=1');" style="background-image:url(${fn:indexOf(optimalVodList.srisPrflImgPath, 'cdn.ntruss.com') > -1 ? optimalVodList.srisPrflImgPath : frame:optImagePath(optimalVodList.srisPrflImgPath, frontConstants.IMG_OPT_QRY_785)}); cursor:pointer;"></div>
	                                    	</c:when>
	                                    	<c:otherwise>
	                                    		<div class="round-img-pf" onclick="fncGoUrl('/tv/series/petTvSeriesList?srisNo=${optimalVodList.srisNo}&sesnNo=1');" style="background-image:url(${fn:indexOf(optimalVodList.srisPrflImgPath, 'cdn.ntruss.com') > -1 ? optimalVodList.srisPrflImgPath : frame:optImagePath(optimalVodList.srisPrflImgPath, frontConstants.IMG_OPT_QRY_786)}); cursor:pointer;"></div>
	                                    	</c:otherwise>
                                    	</c:choose>
                                        <div class="info">
                                        	<div class="tlt">
                                        		<c:choose>
			                                    	<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_30}">
			                                    		<a href="#" onclick="goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${optimalVodList.vdId}&sortCd=&listGb=HOME'); return false;" data-content="${optimalVodList.vdId}" data-url="/tv/series/indexTvDetail?vdId=${optimalVodList.vdId}&sortCd=&listGb=HOME">
				                                   			${optimalVodList.ttl}
				                                   		</a>
			                                    	</c:when>
			                                    	<c:otherwise>
			                                    		<a href="#" onclick="fncGoUrl('/tv/series/indexTvDetail?vdId=${optimalVodList.vdId}&sortCd=&listGb=HOME'); return false;" data-content="${optimalVodList.vdId}" data-url="/tv/series/indexTvDetail?vdId=${optimalVodList.vdId}&sortCd=&listGb=HOME">
		                                            		${optimalVodList.ttl}
		                                            	</a>
			                                    	</c:otherwise>
		                                    	</c:choose>
                                        	</div>
                                            <div class="detail">
                                                <!--<span class="read play">${optimalVodList.hits}</span>-->
                                                <span class="read like" data-read-like="${optimalVodList.vdId}"><fmt:formatNumber type="number" value="${optimalVodList.likeCnt}"/></span>
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
	</c:if>
</c:forEach>