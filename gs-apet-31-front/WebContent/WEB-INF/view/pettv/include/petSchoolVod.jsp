 <c:forEach var="cornerList" items="${cornerList}"  varStatus="status" >
	<c:if test="${param.dispCornNo == cornerList.dispCornNo }">
 		<!-- 펫스쿨 --> 
        <section class="school petTvMb">
        	<!-- 변경전 마크업 APET-1103 -->
			<%--<div class="title-area">
				<a href="/tv/petSchool?pgCd=${cornerList.petSchoolList[0].petGbCd}" class="tit">펫스쿨🎓</a>
                <c:if test="${cornerList.petSchoolList[0].schlViewYn eq 'Y' }">
	                <p class="sub-tit">
	                 	<!--지난번 보던 <em>‘${cornerList.petSchoolList[0].ctgMnm}교육’</em> 다음 회차에요.-->
	                 	지난번 보던 교육을 이어보세요.
	                </p>
                </c:if>
                <c:if test="${cornerList.petSchoolList[0].schlViewYn eq null }">
	                <p class="sub-tit">
	                    <em>‘기초교육’</em>부터 시작해볼까요?
	                </p>
                </c:if>
            </div>--%>
            <!-- //변경전 마크업 APET-1103 -->
            <!-- 변경후 마크업 APET-1103 -->
            <div class="hdts">
				<a class="hdt" href="#" onclick="fncGoUrl('/tv/petSchool?pgCd=${cornerList.petSchoolList[0].petGbCd}'); return false;">
					<span class="tit">펫스쿨🎓</span>
					<c:if test="${cornerList.petSchoolList[0].schlViewYn eq 'Y' }">
		                <p class="sub-tit">
		                 	<!--지난번 보던 <em>‘${cornerList.petSchoolList[0].ctgMnm}교육’</em> 다음 회차에요.-->
		                 	지난번 보던 교육을 이어보세요.
		                </p>
		                <span class="more"><b class="t">전체보기</b></span>
	                </c:if>
	                <c:if test="${cornerList.petSchoolList[0].schlViewYn eq null }">
		                <p class="sub-tit">
		                    <em>‘기초교육’</em>부터 시작해볼까요?
		                </p>
		                <span class="more"><b class="t">전체보기</b></span>
	                </c:if>
				</a>
			</div>
			<!-- //변경후 마크업 APET-1103 -->
            <div class="swiper-div newDn">
                <div class="swiper-container">
                    <ul class="swiper-wrapper">
                    	<c:forEach var="vodHistList" items="${cornerList.petSchoolList }">
                        <li class="swiper-slide">
                            <c:choose>
								<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
									<div class="thumb-box" onclick="fncGoUrl('/tv/school/indexTvDetail?vdId=${vodHistList.vdId}');" style="cursor:pointer;" data-content="${vodHistList.vdId}" data-url="/tv/school/indexTvDetail?vdId=${vodHistList.vdId}">
										<a href="#" onclick="return false;" class="thumb-img" style="background-image:url(${fn:indexOf(vodHistList.thumPath, 'cdn.ntruss.com') > -1 ? vodHistList.thumPath : frame:optImagePath(vodHistList.thumPath, frontConstants.IMG_OPT_QRY_783)});" >
											<c:if test="${vodHistList.stepProgress ne null and vodHistList.stepProgress ne ''}">
												<div class="progress-bar" style="width:${vodHistList.stepProgress}%;"></div>
											</c:if>
										</a>
										<div class="thumb-info">
		                                    <div class="info">
		                                        <div class="tlt">
													[${vodHistList.ctgShtMnm}] ${vodHistList.ttl }
		                                        </div>
		                                    </div>
		                                </div>
									</div>
								</c:when>
								<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_20}">
									<div class="thumb-box" onclick="fncGoUrl('/tv/school/indexTvDetail?vdId=${vodHistList.vdId}');" style="cursor:pointer;" data-content="${vodHistList.vdId}" data-url="/tv/school/indexTvDetail?vdId=${vodHistList.vdId}">
										<a href="#" onclick="return false;" class="thumb-img" style="background-image:url(${fn:indexOf(vodHistList.thumPath, 'cdn.ntruss.com') > -1 ? vodHistList.thumPath : frame:optImagePath(vodHistList.thumPath, frontConstants.IMG_OPT_QRY_784)});">
											<c:if test="${vodHistList.stepProgress ne null and vodHistList.stepProgress ne ''}">
												<div class="progress-bar" style="width:${vodHistList.stepProgress}%;"></div>
											</c:if>
										</a>
										<div class="thumb-info">
		                                    <div class="info">
		                                        <div class="tlt">
													[${vodHistList.ctgShtMnm}] ${vodHistList.ttl }
		                                        </div>
		                                    </div>
		                                </div>
									</div>
								</c:when>
								<c:otherwise>
									<%-- APP에서 펫스쿨 상세 기존 onNewPage 호출 ==> 페이지 호출방식으로 변경 / 펫스쿨 상세는 pc, mo, app 모두 호출방식 동일함.
									<div class="vthumbs" video_id="${vodHistList.outsideVdId}" type="video_thumb_360p" lazy="scroll" style="height:80%px" onclick="goUrl('onNewPage', 'TV', '${view.stDomain}/tv/school/indexTvDetail?vdId=${vodHistList.vdId}')" >
									<a href="javascript:goUrl('onNewPage', 'TV', '${view.stDomain}/tv/school/indexTvDetail?vdId=${vodHistList.vdId}')" class="thumb-img" style="background-image:url(${fn:indexOf(vodHistList.thumPath, 'cdn.ntruss.com') > -1 ? vodHistList.thumPath : frame:optImagePath(vodHistList.thumPath, frontConstants.IMG_OPT_QRY_762)});" data-content="${vodHistList.vdId}" data-url="${view.stDomain}/tv/school/indexTvDetail?vdId=${vodHistList.vdId}">
										<c:if test="${vodHistList.stepProgress ne null and vodHistList.stepProgress ne ''}">
											<div class="progress-bar" style="width:${vodHistList.stepProgress}%;"></div>
										</c:if>
									</a>
									--%>
									
									<%-- 펫TV 홈/ 영상목록에서 자동재생 삭제로 인해 주석처리-CSR-1247
									<div class="thumb-box" onclick="fncGoSchoolDetail('${vodHistList.vdId}'); videoAllPauses();" style="cursor:pointer;" data-content="${vodHistList.vdId}" data-url="/tv/school/indexTvDetail?vdId=${vodHistList.vdId}">
										<div class="vthumbs" video_id="${vodHistList.outsideVdId}" type="video_thumb_360p" lazy="scroll" style="height:80px">
											<a href="#" onclick="return false;" class="thumb-img" style="background-image:url(${fn:indexOf(vodHistList.thumPath, 'cdn.ntruss.com') > -1 ? vodHistList.thumPath : frame:optImagePath(vodHistList.thumPath, frontConstants.IMG_OPT_QRY_784)});">
												<c:if test="${vodHistList.stepProgress ne null and vodHistList.stepProgress ne ''}">
													<div class="progress-bar" style="width:${vodHistList.stepProgress}%;"></div>
												</c:if>
											</a>
										</div>
										<div class="thumb-info">
		                                    <div class="info">
		                                        <div class="tlt">
													[${vodHistList.ctgShtMnm}] ${vodHistList.ttl }
		                                        </div>
		                                    </div>
		                                </div>
									</div>
									--%>
									
									<div class="thumb-box" onclick="fncGoUrl('/tv/school/indexTvDetail?vdId=${vodHistList.vdId}');" style="cursor:pointer;" data-content="${vodHistList.vdId}" data-url="/tv/school/indexTvDetail?vdId=${vodHistList.vdId}">
										<a href="#" onclick="return false;" class="thumb-img" style="background-image:url(${fn:indexOf(vodHistList.thumPath, 'cdn.ntruss.com') > -1 ? vodHistList.thumPath : frame:optImagePath(vodHistList.thumPath, frontConstants.IMG_OPT_QRY_784)});">
											<c:if test="${vodHistList.stepProgress ne null and vodHistList.stepProgress ne ''}">
												<div class="progress-bar" style="width:${vodHistList.stepProgress}%;"></div>
											</c:if>
										</a>
										<div class="thumb-info">
		                                    <div class="info">
		                                        <div class="tlt">
													[${vodHistList.ctgShtMnm}] ${vodHistList.ttl }
		                                        </div>
		                                    </div>
		                                </div>
									</div>
								</c:otherwise>
							</c:choose>
                        </li>
                        </c:forEach>
                        <!-- 더보기 버튼 -->
                        <c:choose>
	                        <c:when test="${session.mbrNo ne frontConstants.NO_MEMBER_NO and cornerList.petSchoolList[0].schlViewYn eq 'Y'}">
	                        	<li class="swiper-slide btn-more">
		                        	<a href="#" onclick="fncGoUrl('/tv/petSchool${cornerList.petSchoolList[0].ctgMnm}?pgCd=${cornerList.petSchoolList[0].petGbCd}'); return false;">
			                            <button type="button">
			                                <i>더보기</i>
			                            </button>
		                            </a>
	                        	</li>
	                        </c:when>
                        	<c:otherwise>
	                        	<li class="swiper-slide btn-more">
		                        	<a href="#" onclick="fncGoUrl('/tv/petSchool?pgCd=${cornerList.petSchoolList[0].petGbCd}'); return false;">
		                            <button type="button">
		                                <i>더보기</i>
		                            </button>
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
</c:forEach>