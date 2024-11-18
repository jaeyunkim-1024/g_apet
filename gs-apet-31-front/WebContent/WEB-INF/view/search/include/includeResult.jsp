<!-- 검색 결과 페이지 -->
<div class="contents" id="contents">
	<input type="hidden" value="<c:out value="${srchWord}" escapeXml="false" />" id="orgSrchWord">
	<!-- PC 타이틀 모바일에서 제거  -->
	<div class="pc-tit">
		<h2><span><c:out value="${srchWord}" escapeXml="false" /></span> 검색결과</h2>
	</div>
	<!-- // PC 타이틀 모바일에서 제거  -->
	<!-- tab -->
	<section class="sect petTabContent mode_fixed leftTab hmode_auto srchRslt">
		<!-- tab header -->
		<ul class="uiTab a line t2" <c:if test="${!empty session.bizNo}">data-bizYn="Y"</c:if>>
			
			<li id="srchTab1" <c:if test="${empty session.bizNo}"> onclick="searchResult.setTabFocusH();searchResult.setfocusedTab('tv');"</c:if>>
				<a class="bt" href="javascript:void(0);">
					<div>
						<spring:message code='front.web.view.new.menu.tv'/>  <!-- APET-1250 210728 kjh02  -->
						<c:choose>
							<c:when test="${(result.seriesCount + result.videoCount) > 999}">
								<div class="both-txt" id="tvCnt">999+</div>
							</c:when>
							<c:otherwise>
								<div class="both-txt" id="tvCnt">${result.seriesCount + result.videoCount}</div>
							</c:otherwise>
						</c:choose>
					</div>
				</a>
			</li>
			<li id="srchTab2" onclick="searchResult.setTabFocusH();searchResult.setfocusedTab('log');">
				<a class="bt" href="javascript:void(0);">
					<div>
						<spring:message code='front.web.view.new.menu.log'/>  <!-- APET-1250 210728 kjh02  -->
						<c:choose>
							<c:when test="${(result.memberCount + result.contentCount) > 999}">
								<div class="both-txt" id="logCnt">999+</div>
							</c:when>
							<c:otherwise>
								<div class="both-txt" id="logCnt">${result.memberCount + result.contentCount }</div>
							</c:otherwise>
						</c:choose>
					</div>
				</a>
			</li>
			<li id="srchTab3" <c:if test="${empty session.bizNo}"> onclick="searchResult.setTabFocusH();searchResult.setfocusedTab('shop');"</c:if>>
				<a class="bt" href="javascript:void(0);">
					<div>
						<spring:message code='front.web.view.new.menu.store'/>  <!-- APET-1250 210728 kjh02  -->
						<c:choose> 
							<c:when test="${(result.goodsCount) > 999}">
								<div class="both-txt" id="shopCnt">999+</div>
							</c:when>
							<c:when test="${(result.goodsCount) == null}">
								<div class="both-txt" id="shopCnt">0</div>
							</c:when>
							<c:otherwise>
								<div class="both-txt" id="shopCnt">${result.goodsCount}</div>
							</c:otherwise>
						</c:choose>
					</div>
				</a>
			</li>
			
		</ul>
		<!-- // tab header -->
		<!-- tab content -->
		<div class="uiTab_content">
			<ul>
				<li <c:if test="${!empty session.bizNo}">style="display:none;"</c:if>>
					<div class="tit-box">
						<p class="tit">시리즈 <span>${result.seriesCount}</span></p>
					</div>
					<div class="series-list tvTab">
						<ul id="tvSeriesArea">
							<jsp:include page="/WEB-INF/view/search/include/includeSeries.jsp"/>
						</ul>
					</div>
					<div class="moreload ts2" id="tvSeriesMoreBtn" style="display: none;">
						<button type="button" class="bt more" onclick="searchResult.getSearchResults('se_tv_series')">시리즈 더보기</button>
					</div>
					<!-- //시리즈  -->
					<!-- 동영상  -->
					<div class="tit-box">
						<p class="tit">동영상 <span id="videoCount">${result.videoCount}</span></p>
						<div class="right" id="tvSortArea">
							<nav class="uisort">
								<button type="button" class="bt st"></button>
								<div class="list">
									<ul class="menu" id="videoSortArea">
										<li><button type="button" class="bt" value="v_2" onclick="searchResult.setSort('video','latest')">최신순</button></li>
										<li><button type="button" class="bt" value="v_3" onclick="searchResult.setSort('video','pop_rank')">인기순</button></li>
										<!-- <li><button type="button" class="bt" value="v_1" onclick="searchResult.setSort('video','_score')">추천순</button></li> -->
									</ul>
								</div>
							</nav>
						</div>
					</div>
					<div class="watch-movie t2" id="tvVideoArea">
						<jsp:include page="/WEB-INF/view/search/include/includeVideo.jsp"/>
					</div>
					<!-- //동영상  -->
				</li>
				<li <c:if test="${!empty session.bizNo}">style="display:inline-block;"</c:if>>
					<!-- 사용자 -->
					<div class="tit-box">
						<p class="tit">친구 <span>${result.memberCount}</span></p>
					</div>
					<div class="series-list">
						<ul id="logMemberArea">
							<jsp:include page="/WEB-INF/view/search/include/includeMember.jsp"/>
						</ul>
					</div>
					<div class="moreload ts2" id="logMemberMoreBtn" style="display: none;">
						<button type="button" class="bt more" onclick="searchResult.getSearchResults('se_log_member')">친구 더보기</button>
					</div>
					<!-- //사용자 -->
					<!-- 로그 동영상 -->
					<div class="tit-box">
						<p class="tit">게시물 <span id="contentCount">${result.contentCount}</span></p>
						<div class="right" id="logSortArea">
							<nav class="uisort">
								<button type="button" class="bt st"></button>
								<div class="list">
									<ul class="menu">
										<li><button type="button" class="bt" value="v_2" onclick="searchResult.setSort('content','latest')">최신순</button></li>
										<li><button type="button" class="bt" value="v_3" onclick="searchResult.setSort('content','pop_rank')">인기순</button></li>
										<!-- <li><button type="button" class="bt" value="v_1" onclick="searchResult.setSort('content','_score')">추천순</button></li> -->
									</ul>
								</div>
							</nav>
						</div>
					</div>
					<div class="mylog-area">
						<div class="logPicMetric t2">
							<ul id="logContentArea">
								<jsp:include page="/WEB-INF/view/search/include/includeContent.jsp"/>
							</ul>
						</div>
					</div>
					<!-- // 로그 동영상 -->
				</li>
				<li <c:if test="${!empty session.bizNo}">style="display:none;"</c:if>>
					<ul class="petCate_tab mt20">
						<li class='${frontConstants.PETSHOP_DOG_DISP_CLSF_NO == cateCdL ? "active" : ""}' id="petGbcd_10" data-catecdl='${frontConstants.PETSHOP_DOG_DISP_CLSF_NO }'><a href="javascript:;" class="btn" onclick="searchCommon.goSearchShopCateCdL(${frontConstants.PETSHOP_MAIN_DOG_DISP_CLSF_NO});">강아지</a></li>
						<li class='${frontConstants.PETSHOP_CAT_DISP_CLSF_NO == cateCdL ? "active" : ""}' id="petGbcd_20" data-catecdl='${frontConstants.PETSHOP_CAT_DISP_CLSF_NO }'><a href="javascript:;" class="btn" onclick="searchCommon.goSearchShopCateCdL(${frontConstants.PETSHOP_MAIN_CAT_DISP_CLSF_NO});">고양이</a></li>
						<li class='${frontConstants.PETSHOP_FISH_DISP_CLSF_NO == cateCdL ? "active" : ""}' id="petGbcd_40" data-catecdl='${frontConstants.PETSHOP_FISH_DISP_CLSF_NO }'><a href="javascript:;" class="btn" onclick="searchCommon.goSearchShopCateCdL(${frontConstants.PETSHOP_MAIN_FISH_DISP_CLSF_NO});">관상어</a></li>
						<li class='${frontConstants.PETSHOP_ANIMAL_DISP_CLSF_NO == cateCdL ? "active" : ""}' id="petGbcd_50" data-catecdl='${frontConstants.PETSHOP_ANIMAL_DISP_CLSF_NO }'><a href="javascript:;" class="btn" onclick="searchCommon.goSearchShopCateCdL(${frontConstants.PETSHOP_MAIN_ANIMAL_DISP_CLSF_NO});">소동물</a></li>
					</ul>
					<script>
						$('.petCate_tab li').click(function(){
							$(this).addClass('active');
							$(this).siblings().removeClass('active');
						});
					</script>
					<!-- 브랜드 -->
					<div class="tit-box">
						<p class="tit">브랜드 <%-- <span id="brandCount">${result.brandCount}</span> --%></p>
					</div>
					<div class="mybrand-list t3">
						<div class="brand" id="shopBrandArea">
							<jsp:include page="/WEB-INF/view/search/include/includeBrand.jsp"/>
						</div>
						<div class="uimoreload" id="shopBrandMoreBtn" style="display: none;">
							<button type="button" class="bt more" onclick="searchResult.getSearchResults('se_shop_brand')">브랜드 더보기</button>
						</div>
					</div>
					<!-- // 브랜드 -->
					<!-- 상품 -->
					<div class="tit-box">
						<p class="tit">상품 <span id="goodsCount">${result.goodsCount}</span></p>
						<div class="right" id="shopSortArea">
							<nav class="uisort">
								<button type="button" id="filtBtn" class="bt filt st t1" value="v_1" onclick="filter.getPop();">필터<i class="n"></i></button>
							</nav>
							<nav class="uisort">
								<button type="button" class="bt st" value="v_1">인기순</button>
								<div class="list">
									<ul class="menu">
										<li><button type="button" class="bt" value="v_1" onclick="searchResult.setSort('goods','pop_rank')"><spring:message code='front.web.view.common.menu.sort.orderSale.button.title'/></button></li>
										<!-- <li><button type="button" class="bt" value="v_1" onclick="searchResult.setSort('goods','_score')">추천순</button></li> -->
										<li><button type="button" class="bt" value="v_2" onclick="searchResult.setSort('goods','review')"><spring:message code='front.web.view.common.menu.sort.orderScore.button.title'/></button></li>
										<li><button type="button" class="bt" value="v_3" onclick="searchResult.setSort('goods','latest')"><spring:message code='front.web.view.common.menu.sort.orderDate.button.title'/></button></li>
										<li><button type="button" class="bt" value="v_4" onclick="searchResult.setSort('goods','price_asc')"><spring:message code='front.web.view.common.menu.sort.orderLow.button.title'/></button></li>
										<li><button type="button" class="bt" value="v_5" onclick="searchResult.setSort('goods','price_desc')"><spring:message code='front.web.view.common.menu.sort.orderHigh.button.title'/></button></li>
									</ul>
								</div>
							</nav>
						</div>
						<div class="uifiltbox on filOneLine" id="uifiltbox" style="display: none">
<!-- 							<div class="flist swiper-container"> APET-1099 -->
							<div class="flist ${view.deviceGb == 'PC' ? '' : 'swiper-container'}">
<!-- 								<ul class="swiper-wrapper"> APET-1099 -->
								<ul class="${view.deviceGb == 'PC' ? '' : 'swiper-wrapper'}">
								</ul>
							</div>
							<div class="bts">
								<button type="button" class="bt refresh" onclick="filter.delFilter();">새로고침</button>
							</div>
						</div>
					</div>
					<section ></section>
					<div class="thumbnail-list t2">
						<ul id="shopGoodsArea">
							<jsp:include page="/WEB-INF/view/search/include/includeGoods.jsp"/>		
						</ul>
					</div>
					<!-- // 상품 -->			
				</li>
			</ul>
		</div>
		<!-- // tab content -->
	</section>
	<!-- // tab -->
</div>
<!-- 검색 결과 페이지 -->
		