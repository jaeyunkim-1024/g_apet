<script type="text/javascript">
	function seriesGnbDetail(sris, sesn){
		var callParam = "";
		if($("#callParam").val() != ""){
			if($("#srisNo").val() == sris){
				if("${callParam}".indexOf("-N") == -1){
					callParam = "&callParam="+$("#callParam").val()+"-N";
				}else{
					callParam = "&callParam="+$("#callParam").val();
				}
			}
		}
		
		var url;
		if(sesn == undefined){
			url = "/tv/series/petTvSeriesList?srisNo="+sris+"&sesnNo=1"+callParam;
		}else{
			url = "/tv/series/petTvSeriesList?srisNo="+sris+"&sesnNo="+sesn+callParam;
		}
		
		location.href = url;
		//storageHist.goBack(url);
	}
</script>
<article class="popLayer a popSeriesList" id="popSeriesList">
<div class="pbd">
	<div class="phd">
		<div class="in">
			<h1 class="tit">시리즈 목록</h1>
			<button type="button" class="btnPopClose">닫기</button>
		</div>
	</div>
	<div class="pct">
		<main class="poptents">
        <c:forEach items="${foSeriesList}" var="list">
			<section>
				<div class="channel-info" id="ch_${list.srisNo}">
					<a href="#" onclick="seriesGnbDetail(${list.srisNo}); return false;" class="round-img-pf" style="background-image:url(${fn:indexOf(list.srisPrflImgPath, 'cdn.ntruss.com') > -1 ? list.srisPrflImgPath : frame:optImagePath(list.srisPrflImgPath, frontConstants.IMG_OPT_QRY_785)});" data-content="" data-url="seriesGnbDetail(${list.srisNo});"></a>
					<div class="ch-name" onclick="seriesGnbDetail(${list.srisNo});">${list.srisNm}</div>
                </div>
				<div class="swiper-div k0421 petSeriesListGroup">
					<div class="swiper-container">
						<ul class="swiper-wrapper">
							<c:forEach items="${list.seasonList}" var="item" varStatus="idx">
							<li class="swiper-slide">
								<div class="thumb-box" id="srisId_${item.srisNo}_${item.sesnNo}">
									<a href="#" onclick="seriesGnbDetail(${item.srisNo}, ${item.sesnNo}); return false;" class="thumb-img" style="background-image:url(${fn:indexOf(item.sesnImgPath, 'cdn.ntruss.com') > -1 ? item.sesnImgPath : frame:optImagePath(item.sesnImgPath, frontConstants.IMG_OPT_QRY_753)}	);" data-content="" data-url="seriesGnbDetail(${item.srisNo}, ${item.sesnNo})"></a>
									<div class="thumb-info">
										<div class="info">
											<div class="paging">
												<c:if test="${fn:length(list.seasonList) > 1 }">
													<strong>${item.sesnNm}</strong>
													<em>/</em>
												</c:if>
												<span>${item.vdCnt}</span>개
											</div>
											<div class="tlt">
												<a href="#" onclick="seriesGnbDetail(${item.srisNo}, ${item.sesnNo}); return false;" data-content="" data-url="seriesGnbDetail(${item.srisNo}, ${item.sesnNo})">
													<% pageContext.setAttribute("newLineChar", "\n"); %>
													${fn:replace(item.sesnDscrt,newLineChar, '<br>')}
												</a>
											</div>
										</div>
									</div>
								</div>
							</li>
							</c:forEach>
						</ul>
					</div>
					<div class="remote-area">
						<button class="swiper-button-next" type="button"></button>
						<button class="swiper-button-prev" type="button"></button>
					</div>
				</div>
			</section>
		</c:forEach>
		</main>
	</div>
</div>
</article>

<c:choose>
	<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
		<script>
			//시리즈목록레이어 리스트 Swiper
			$(".swiper-div.petSeriesListGroup").each(function(idx){
				varslide = [];
				varslide[idx] = new Swiper($(this).find('.swiper-container'), {
					slidesPerView: 3,
					spaceBetween: 10,
					navigation: {
						nextEl: $(this).find('.swiper-button-next'),
						prevEl: $(this).find('.swiper-button-prev'),
					},
					observer: true,
					observeParents: true,
					watchOverflow:true,
					freeMode: false,
					breakpoints: {
						1024: {
							spaceBetween: 10,
							slidesPerView: 3,
							slidesPerGroup:1,
							freeMode: true,
						}
					}
				});
			});
		</script>
	</c:when>
	<c:otherwise>
		<script>
		//시리즈목록 레이어
		$(".popLayer.a .pct").each(function(idx){
		    varslide = [];
		    varslide[idx] = new Swiper($(this).find('.swiper-container'), {
		        slidesPerView: 'auto',
		        spaceBetween: 10, 
		        observer: true,
				observeParents: true,
				watchOverflow:true,
		        freeMode: false
		    });
		});
		
		/*
		var swiperpoptents = new Swiper('.poptents .swiper-container', {
			slidesPerView: 'auto',
			spaceBetween: 10,
		});*/
		</script>
	</c:otherwise>
</c:choose>