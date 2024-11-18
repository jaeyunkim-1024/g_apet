<script type="text/javascript">
	var deviceGb = '<c:out value="${view.deviceGb}"/>';
	$(document).ready(function(){
// 		liveCheck(${view.dispClsfNo });	
		// 최근본상품 lnb 에서 이미지 안넣어주면
		if($("#lnb").length == 0 || rcntList == null || rcntList == undefined || rcntList == 'fail'){ 
			$.ajax({
				type: "POST",
				data : {mbrNo : '${session.mbrNo}'},
				url: "/shop/getOneGoodsDtlInqrHist",
				success: function (result) {
					var imgDomain = "<spring:eval expression="@bizConfig['naver.cloud.optimizer.domain']" />" ;
					if(result.dtlHist != undefined && result.dtlHist.imgPath != null){
						$(".rcntImgArea").attr("src",imgDomain + result.dtlHist.imgPath + "?type=f&w=70&h=70&quality=90&align=4");
						$(".rcntImgArea").attr("alt",result.dtlHist.goodsNm);
					}else{
						$(".rcntImgArea").attr("src","/_images/common/img-rc-vw-gds2.svg");
					}
				}
			});  
		}
		
	});
	// 라이브 시작 
	function startLive() {
		$.ajax({
			type: "POST",
			data :  { dispLvl : '${frontConstants.DISP_LVL_2}'
					, dispClsfCd : '${frontConstants.DISP_CLSF_30}'
					, liveYn : '${frontConstants.COMM_YN_Y}'
			},
			url: "<spring:url value='/shop/liveOnOff' />",
			success: function (data) {
				LiveOn();
				if(deviceGb == 'PC') {
					$("#liveCheck").addClass("beg_live on");
				}
			}
		});  
	}
	
	// 라이브 종료
	function endLive() {
		$.ajax({
			type: "POST",
			data : { dispLvl : '${frontConstants.DISP_LVL_2}'
				, dispClsfCd : '${frontConstants.DISP_CLSF_30}'
				, liveYn : '${frontConstants.COMM_YN_N}'
			},
			url: "<spring:url value='/shop/liveOnOff' />",
			success: function (data) {
				LiveOff();
				if(deviceGb == 'PC') {
					$("#liveCheck").removeClass("beg_live on");
				}
			}
		});  
	}
	
	// live 여부 check
	function liveCheck(dispClsfNo) {
		var options = {
			url : "<spring:url value='/shop/getDisplayBaseLiveCheck' />",
			data : { dispClsfNo : dispClsfNo
			},
			done : function(data){
				if(data.liveYn == "Y") {
					LiveOn();
				} else if(data.liveYn == "N") {
					LiveOff();
				}
			}
		};
		ajax.call(options);
	}
	
	// 라이브 on class
	function LiveOn() {
		$("#div_tag_live").attr("class","thum onair");
	}
	
	// 라이브 off class
	function LiveOff() {
// 		$("#a_tag_live").attr('onclick','').unbind('click'); 	라이브 클릭 막기
		$("#div_tag_live").attr("class","thum noair");
	}
	
</script>

<c:forEach var="cornerList" items="${totalCornerList}"  varStatus="status" >
<c:if test="${param.dispCornNo == cornerList.dispCornNo }">
<section class="sect mn gogos">
	<c:set var="itemCount" value="${fn:length(cornerList.shortCutList)}"/>
	<c:set var="devicePC" value="${view.deviceGb == frontConstants.DEVICE_GB_10}"/>
	<div class="${itemCount > 7 ? devicePC ? 'mn_gogos_sld shortcuts9' : 'shortcuts9' : 'mn_gogos_sld'}">
	<c:if test="${devicePC and itemCount > 7}">
		<div class="sld-nav">
			<button type="button" class="bt prev"><spring:message code='front.web.view.common.msg.previous'/></button>
			<button type="button" class="bt next"><spring:message code='front.web.view.common.msg.next'/></button>
		</div>
	</c:if>
		<c:choose>
			<c:when test="${devicePC or itemCount < 8}">
			<div class="swiper-container slide">
				<ul class="swiper-wrapper list">
					<c:forEach var="icon" items="${cornerList.shortCutList}"  varStatus="status" >
					<c:choose>
						<c:when test="${not empty icon.bnrImgPath}">
							<c:if test="${icon.bnrText.toUpperCase() == 'LIVE'}">
								<li class="swiper-slide">
									<a href="javascript:void(0);" class="box live" id="a_tag_live" onclick="goLink('${view.deviceGb == 'PC' ? icon.bnrLinkUrl : icon.bnrMobileLinkUrl}', '${icon.bnrText}' !=  '카테고리' ? true : false)">
									<div class="thum ${icon.liveYn == 'Y' ? 'onair' : 'noair'}" id="div_tag_live">
										<em class="rdo k0423"></em>
										<img src="${fn:endsWith(icon.bnrImgPath,'.svg') ? frame:imagePath(icon.bnrImgPath) : frame:optImagePath(icon.bnrImgPath, frontConstants.IMG_OPT_QRY_540)}" alt="${icon.bnrText}" class="img k0423" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'">
									</div>
									<div class="tt">${icon.bnrText}</div>
								</a>
							</li>
							</c:if>
							<c:if test="${icon.bnrText.toUpperCase() != 'LIVE'}">
							<li class="swiper-slide">
								<a href="javascript:void(0);" class="box recent" onclick="goLink('${view.deviceGb == 'PC' ? icon.bnrLinkUrl : icon.bnrMobileLinkUrl}', '${icon.bnrText}' !=  '카테고리' ? true : false)">
									<div class="gds">
										<img src="${fn:endsWith(icon.bnrImgPath,'.svg') ? frame:imagePath(icon.bnrImgPath) : frame:optImagePath(icon.bnrImgPath, frontConstants.IMG_OPT_QRY_540)}" alt="${icon.bnrText}" class="img">
									</div>
									<div class="tt">${icon.bnrText}</div>
								</a>
							</li>
							</c:if>
						</c:when>
						<c:otherwise>
							<li class="swiper-slide">
								<a href="javascript:void(0);" class="box" onclick="goLink('${view.deviceGb == 'PC' ? icon.bnrLinkUrl : icon.bnrMobileLinkUrl}', '${icon.bnrText}' !=  '카테고리' ? true : false)">
									<div class="imo">${icon.bnrImgNm}</div>
									<div class="tt">${icon.bnrText}</div>
								</a>
							</li>
						</c:otherwise>
					</c:choose>
					</c:forEach>
					<li class="swiper-slide">
						<a class="box recent" href="javascript:void(0);" onclick="location.href='/mypage/indexRecentViews/'" data-content="" data-url="/mypage/indexRecentViews/">
							<div class="gds latest"><img src="/_images/common/img-rc-vw-gds2.svg" alt="" class="img rcntImgArea"></div>
							<div class="tt"><spring:message code='front.web.view.goods.title.recently.viewed.products'/></div>
						</a>
					</li>
				</ul>
				<div class="swiper-pagination"></div>
			</div>
			<c:if test="${itemCount < 8}">
			<script>
			    var swiper = new Swiper('.mn_gogos_sld .swiper-container', {
			    	observer: true,
					observeParents: true,
					watchOverflow:true,
					simulateTouch:false,
					freeMode: false,
					slidesPerView: 8,
					slidesPerGroup:1,
					spaceBetween:34,						
					breakpoints: {
						1024: {
							spaceBetween:13,
							slidesPerView: "auto",
							slidesPerGroup:1,
							freeMode: true,
						}
					}
			    });
			</script>
			</c:if>
			</c:when>
			<c:otherwise>
			<c:set var="itemGroup" value="${itemCount%8}"/>
			<fmt:parseNumber var="itemGroupCount" value="${itemCount/8}" integerOnly="true" />
			<div class="swiper-container">
			    <div class="swiper-wrapper">
			      <div class="swiper-slide">
					<ul class="slide">
						<c:forEach var="icon" items="${cornerList.shortCutList}"  varStatus="status" begin="0" end="7">
						<c:choose>
							<c:when test="${not empty icon.bnrImgPath}">
								<c:if test="${icon.bnrText.toUpperCase() == 'LIVE'}">
								<li class="list">
										<a href="javascript:void(0);" class="box live" id="a_tag_live" onclick="goLink('${view.deviceGb == 'PC' ? icon.bnrLinkUrl : icon.bnrMobileLinkUrl}', '${icon.bnrText}' !=  '카테고리' ? true : false)">
										<div class="thum ${icon.liveYn == 'Y' ? 'onair' : 'noair'}" id="div_tag_live">
											<em class="rdo k0423"></em>
											<img src="${fn:endsWith(icon.bnrImgPath,'.svg') ? frame:imagePath(icon.bnrImgPath) : frame:optImagePath(icon.bnrImgPath, frontConstants.IMG_OPT_QRY_540)}" alt="${icon.bnrText}" class="img k0423" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'">
										</div>
										<div class="tt">${icon.bnrText}</div>
									</a>
								</li>
								</c:if>
								<c:if test="${icon.bnrText.toUpperCase() != 'LIVE'}">
								<li class="list">
									<a href="javascript:void(0);" class="box recent" onclick="goLink('${view.deviceGb == 'PC' ? icon.bnrLinkUrl : icon.bnrMobileLinkUrl}', '${icon.bnrText}' !=  '카테고리' ? true : false)">
										<div class="gds">
											<img src="${fn:endsWith(icon.bnrImgPath,'.svg') ? frame:imagePath(icon.bnrImgPath) : frame:optImagePath(icon.bnrImgPath, frontConstants.IMG_OPT_QRY_540)}" alt="${icon.bnrText}" class="img">
										</div>
										<div class="tt">${icon.bnrText}</div>
									</a>
								</li>
								</c:if>
							</c:when>
							<c:otherwise>
								<li class="list">
									<a href="javascript:void(0);" class="box" onclick="goLink('${view.deviceGb == 'PC' ? icon.bnrLinkUrl : icon.bnrMobileLinkUrl}', '${icon.bnrText}' !=  '카테고리' ? true : false)">
										<div class="imo">${icon.bnrImgNm}</div>
										<div class="tt">${icon.bnrText}</div>
									</a>
								</li>
							</c:otherwise>
						</c:choose>
						</c:forEach>
					</ul>
				  </div>
			      <div class="swiper-slide">
					<ul class="slide">
						 <c:forEach var="icon" items="${cornerList.shortCutList}"  varStatus="status" begin="8">
						<c:choose>
							<c:when test="${not empty icon.bnrImgPath}">
								<c:if test="${icon.bnrText.toUpperCase() == 'LIVE'}">
								<li class="list">
									<a href="javascript:void(0);" class="box live" id="a_tag_live" onclick="goLink('${view.deviceGb == 'PC' ? icon.bnrLinkUrl : icon.bnrMobileLinkUrl}', '${icon.bnrText}' !=  '카테고리' ? true : false)">
										<div class="thum ${icon.liveYn == 'Y' ? 'onair' : 'noair'}" id="div_tag_live">
											<em class="rdo k0423"></em>
											<img src="${fn:endsWith(icon.bnrImgPath,'.svg') ? frame:imagePath(icon.bnrImgPath) : frame:optImagePath(icon.bnrImgPath, frontConstants.IMG_OPT_QRY_540)}" alt="${icon.bnrText}" class="img k0423" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'">
										</div>
										<div class="tt">${icon.bnrText}</div>
									</a>
								</li>
								</c:if>
								<c:if test="${icon.bnrText.toUpperCase() != 'LIVE'}">
								<li class="list">
									<a href="javascript:void(0);" class="box recent" onclick="goLink('${view.deviceGb == 'PC' ? icon.bnrLinkUrl : icon.bnrMobileLinkUrl}', '${icon.bnrText}' !=  '카테고리' ? true : false)">
										<div class="gds"><img src="${fn:endsWith(icon.bnrImgPath,'.svg') ? frame:imagePath(icon.bnrImgPath) : frame:optImagePath(icon.bnrImgPath, frontConstants.IMG_OPT_QRY_540)}" alt="${icon.bnrText}" class="img"></div>
										<div class="tt">${icon.bnrText}</div>
									</a>
								</li>
								</c:if>
							</c:when>
							<c:otherwise>
								<li class="list">
									<a href="javascript:void(0);" class="box" onclick="goLink('${view.deviceGb == 'PC' ? icon.bnrLinkUrl : icon.bnrMobileLinkUrl}', '${icon.bnrText}' !=  '카테고리' ? true : false)">
										<div class="imo">${icon.bnrImgNm}</div>
										<div class="tt">${icon.bnrText}</div>
									</a>
								</li>
							</c:otherwise>
						</c:choose>
						</c:forEach>
						<li class="list">
							<a class="box recent" href="javascript:void(0);" onclick="location.href='/mypage/indexRecentViews/'" data-content="" data-url="/mypage/indexRecentViews/">
								<div class="gds latest"><img src="/_images/common/img-rc-vw-gds2.svg" alt="" class="img rcntImgArea"></div>
								<div class="tt"><spring:message code='front.web.view.goods.title.recently.viewed.products'/></div>
							</a>
						</li>
					</ul>
				  </div>
			    </div>
			    <!-- Add Pagination -->
			    <div class="swiper-pagination"></div>
			 </div>
			</c:otherwise>
		</c:choose>
	</div>
</section>
<c:if test="${fn:length(cornerList.shortCutList) > 7}">
<c:choose>
	<c:when test="${view.deviceGb == frontConstants.DEVICE_GB_10}">
		<script>
		    var swiper = new Swiper('.shortcuts9 .swiper-container', {
		    	slidesPerView: 8,
				slidesPerGroup:1,
				//spaceBetween:30,
				navigation: {
					nextEl: '.mn_gogos_sld .sld-nav .bt.next',
					prevEl: '.mn_gogos_sld .sld-nav .bt.prev'
				}
		    });
		    
		    setTimeout(function() {
				window.dispatchEvent(new Event('resize'));
			}, 1000);
		 </script> 
	</c:when>
	<c:otherwise>
		<script>
		   var swiper = new Swiper('.shortcuts9 .swiper-container', {
		   	/*slidesPerView: 8,
			slidesPerGroup:1,
			spaceBetween:34,
			navigation: {
				nextEl: '.mn_gogos_sld .sld-nav .bt.next',
				prevEl: '.mn_gogos_sld .sld-nav .bt.prev',
			},*/							
			breakpoints: {
				1024: {
					pagination: {
						el: '.swiper-pagination',
						clickable: true,
					  },
				}
			}
		   });
		</script> 
	</c:otherwise>
</c:choose>
 </c:if>
</c:if>
</c:forEach>