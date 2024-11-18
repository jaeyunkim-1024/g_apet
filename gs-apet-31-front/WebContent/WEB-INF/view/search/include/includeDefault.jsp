<!-- 검색 페이지 -->
<div class="contents" id="contents">
	<!-- 공통 검색  -->
	<div class="search-wrap">
		<!-- 최근 태그  -->
		<c:if test="${session.mbrNo ne frontConstants.NO_MEMBER_NO}">
			<div class="lately-tag">
				<p class="tit">최근 검색어</p>
				<c:choose>
					<c:when test="${ empty listMemberSearchWord}">
						<p class="txt-info">검색 내역이 없습니다.</p>
					</c:when>
					<c:otherwise>
						<div class="scroll-x">
							<div class="scroll swiper-container keyword">
								<ul class="swiper-wrapper">
									<c:forEach items="${listMemberSearchWord}" var="thisLatelyTag" varStatus="idx">
										<li class="swiper-slide" data-seq="${thisLatelyTag.seq}" data-val="${thisLatelyTag.srchWord}" onclick="searchDafault.goLatelySearch(this);"><p class="tag">${thisLatelyTag.srchShortWord}<button class="remove" onclick="searchDafault.delLarelyTag(this);">삭제</button></p></li>
									</c:forEach>
								</ul>
							</div>
						</div>
						<script>
							$(function(){
								/* document 늦게 읽어지면 swiper 정상 작동 안되서 넣어 놨어요 */
								console.log(ui.check_brw.mo())
								if(ui.check_brw.mo()){
									var keyword = new Swiper('.swiper-container.keyword',{
										freeMode: false,
										slidesPerView: "auto",
									});
									setTimeout(function(){
										keyword.update();
									},1500)
								}
							})
						</script>
					</c:otherwise>
				</c:choose>
			</div>
		</c:if>
		<!-- // 최근 태그  -->
		
		<div class="block-wrap">
			<!-- 맞춤 추천  -->		
			<c:if test="${session.mbrNo ne frontConstants.NO_MEMBER_NO}">
				<!-- 추천태그 -->
				<div class="recommendation-tag">
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<c:if test="${interestTagList ne null && interestTagList.size() > 0}">
								<div class="swiper-slide" id="interestTagArea">
									<div class="cont">
										<p class="tit"><span>관심태그</span> 맞춤추천</p>
										<div class="tag-box">
											<c:forEach items="${interestTagList}" var="interestTag" varStatus="idx">
												<button class="tag" onclick="searchCommon.goResultPage('${interestTag.tagNm}');" data-content="${interestTag.tagNm}" data-url="/commonSearch">${interestTag.tagNm}</button>
											</c:forEach>
										</div>
									</div>
								</div>
							</c:if>
							<c:if test="${myPetTagList ne null && myPetTagList.size() > 0}">
								<div class="swiper-slide" id="myPetTagArea">
									<div class="cont">
										<p class="tit"><span>마이펫</span> 맞춤추천</p>
										<div class="tag-box">
											<c:forEach items="${myPetTagList}" var="myPetTag" varStatus="idx">
												<button class="tag" onclick="searchCommon.goResultPage('${myPetTag.tagNm}');" data-content="${myPetTag.tagNm}" data-url="/commonSearch">${myPetTag.tagNm}</button>
											</c:forEach>
										</div>
									</div>
								</div>
							</c:if>
							<c:if test="${myAcTagList ne null && myAcTagList.size() > 0}">
								<div class="swiper-slide" id="myAcTagArea">
									<div class="cont">
										<p class="tit"><span>내 활동</span> 맞춤추천</p>
										<div class="tag-box">
											<c:forEach items="${myAcTagList}" var="myAcTag" varStatus="idx">
												<button class="tag" onclick="searchCommon.goResultPage('${myAcTag.tagNm}');" data-content="${myAcTag.tagNm}" data-url="/commonSearch">${myAcTag.tagNm}</button>
											</c:forEach>
										</div>
									</div>
								</div>
							</c:if>
						</div>
						<!-- Add Pagination -->
						<div class="swiper-pagination"></div>
					</div>
				</div>
				<!-- // 추천태그 -->
			</c:if>
			
			<!-- 인기 검색어 -->
			<div class="search-list" <c:if test="${session.mbrNo eq frontConstants.NO_MEMBER_NO}">style="margin-top:0;"</c:if>>
				<div class="swiper-container t01">
					<p class="tit">인기 검색어</p>
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<ul class="item">
								<c:forEach var="fstPopWordList" items="${popWordList}" varStatus="fstStatus" begin="0" end="4">
									<li>
										<a href="javascript:searchCommon.goResultPage('${fstPopWordList.IBricksQuery}');" data-content="" data-url="/commonSearch">
											<span class="num">${fstStatus.index+1}</span>
											<p class="txt">${fstPopWordList.IBricksQuery}</p>
											<c:choose>
												<c:when test="${fstPopWordList.IBricksUpdown eq 'up' || fstPopWordList.IBricksUpdown eq 'down'}">
													<span class="ranking ${fstPopWordList.IBricksUpdown}">${fn:replace(fstPopWordList.IBricksDiff, '-', '')}</span>
												</c:when>
												<c:when test="${fstPopWordList.IBricksUpdown eq 'stay'}">
													<span class="ranking ${fstPopWordList.IBricksUpdown}"></span>
												</c:when>
											</c:choose>
										</a>
									</li>
								</c:forEach>
							</ul>
						</div>
						<c:if test="${fn:length(popWordList) > 5}">
							<div class="swiper-slide">
								<ul class="item">
									<c:forEach var="secPopWordList" items="${popWordList}" varStatus="secStatus" begin="5">
										<li>
											<a href="javascript:searchCommon.goResultPage('${secPopWordList.IBricksQuery}');" data-content="" data-url="/commonSearch">
												<span class="num">${secStatus.index+1}</span>
												<p class="txt">${secPopWordList.IBricksQuery}</p>
												<c:choose>
													<c:when test="${secPopWordList.IBricksUpdown eq 'up' || secPopWordList.IBricksUpdown eq 'down'}">
														<span class="ranking ${secPopWordList.IBricksUpdown}">${fn:replace(secPopWordList.IBricksDiff, '-', '')}</span>
													</c:when>
													<c:when test="${secPopWordList.IBricksUpdown eq 'stay'}">
														<span class="ranking ${secPopWordList.IBricksUpdown}"></span>
													</c:when>
												</c:choose>
											</a>
										</li>
									</c:forEach>
								</ul>
							</div>
						</c:if>
					</div>
					<c:if test="${fn:length(popWordList) > 5}"><div class="swiper-pagination"></div></c:if>
				</div>
				<!-- 하단 배너  -->
				<c:if test="${empty session.bizNo}">
				<div class="b-banner">
					<div class="swiper-container t02">
						<div class="swiper-wrapper">
							<c:forEach var="seriesItem" items="${seriesList}">
								<div class="swiper-slide">
									<a  class="box" href="/tv/series/petTvSeriesList/?srisNo=${seriesItem.srisNo}&sesnNo=1" data-content="" data-url="/tv/series/petTvSeriesList/?srisNo=${seriesItem.srisNo}&sesnNo=1">
										<img class="mo" src="${fn:indexOf(seriesItem.srisImgPath, 'cdn.ntruss.com') > -1 ? seriesItem.srisImgPath : frame:optImagePath(seriesItem.srisImgPath, frontConstants.IMG_OPT_QRY_70)}" alt="${seriesItem.srisDscrt}" >
									</a>
								</div>
							</c:forEach>
						</div>
						<div class="swiper-pagination"></div>
					</div>
				</div>
				</c:if>
				<!-- 하단 배너  -->
			</div>
			<!-- // 인기 검색어 -->
		</div>
	</div>
	<!-- // 공통 검색  -->
</div>
<!-- 검색 페이지 -->
		