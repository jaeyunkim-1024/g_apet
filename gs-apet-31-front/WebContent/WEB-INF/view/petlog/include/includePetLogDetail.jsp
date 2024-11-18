<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<c:if test="${adminYn ne null and adminYn ne '' and  adminYn eq 'Y'}">		
		<jsp:include page="/WEB-INF/tiles/include/meta.jsp" />	
		<jsp:include page="/WEB-INF/tiles/include/js/petlog.jsp" />
</c:if>

<c:choose>
<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
	<script>
	var swiperBox = new Array();
	$(document).ready(function(){
		var hTimer = setInterval(function(){
			$("#header_pc .tmenu .list li:eq(1)").addClass("active").siblings().removeClass("active")
			if($("#header_pc").length) clearInterval(hTimer);
		});

		$(".swiper-container.logMain").each(function(i,n){
			//PC
			/* 메인 스와이프 */
			swiperBox.push(new Swiper(".swiper-container.logMain", {
				slidesPerView: 1,
				slidesPerGroup: 1,
				freeMode: false,
				navigation: {
					nextEl: '.swiper-container.logMain .swiper-button-next',
					prevEl: '.swiper-container.logMain .swiper-button-prev',
				},
				pagination: {
					el: '.swiper-container.logMain .swiper-pagination',
					type: 'fraction',
				},
				on: {
					slideResetTransitionStart: function() {
						if ((this.snapIndex + 1) == this.imagesLoaded) {
							$(this.wrapperEl).find(".swiper-slide-active").removeClass("swiper-slide-active").addClass("si_last");
						} else {
							$(this.wrapperEl).find(".si_last").removeClass("si_last");
						}
					}
				}
			}));
		});
		$(".iconOm_arr").click(function(){
			//alert("222");
			$(this).parents(".lcbConTxt").toggleClass("active")
		});
		var swiper52 = new Array();
		$('.slideType52 .swiper-container').each(function(i,n){
			swiper52.push(new Swiper($(n), {
				slidesPerView: 5,
				slidesPerGroup:1,
				spaceBetween: 8,
				freeMode: true,
				navigation: {
					nextEl: $(n).parents(".slideType52").find('.swiper-button-next'),
					prevEl: $(n).parents(".slideType52").find('.swiper-button-prev'),
				}
			}));
		});

	});

	</script>
</c:when>
<c:otherwise>
	<script>
	var swiperBox = new Array();
	$(document).ready(function(){		
		//$("#header_pc").removeClass("mode0").addClass("mode1");
		
		$("#header_pc").removeClass("mode0");	
		$("#header_pc").addClass("mode7-1");
		$(".mo-heade-tit .tit").html("<spring:message code='front.web.view.include.title.log' />");	
	
		//MOBILE
		/* 메인 스와이프 */
		swiperBox.push(new Swiper(".swiper-container.logMain", {
			slidesPerView: 1.11,
			slidesPerGroup: 1,
			spaceBetween: 10,
			centeredSlides: true,
			freeMode: false,
			navigation: {
				nextEl: '.swiper-container.logMain .swiper-button-next',
				prevEl: '.swiper-container.logMain .swiper-button-prev',
			},
			pagination: {
				el: '.swiper-container.logMain .swiper-pagination',
				type: 'fraction',
			},
		}));
		/* 게시글 펼쳐보고 버튼 모바일 경우만 작동 */
		$(".btn_logMain_more").click(function(){
			$(this).closest(".contxtWrap").addClass("open");
			$(this).parent().find(".lcbConTxt_content").css('height', '');
		});	
		
		/* MO - 내용 더보기 버튼 처리.  */
		//펫로그 상세는 단건이기에 더보기 버튼에 페이지 1로 고정
		moContxtMoreSet("1");
		
		/* 펫로그 이미지 스와이퍼 */
		var swiper52 = new Array();
		$('.slideType52 .swiper-container').each(function(i,n){
			swiper52.push(new Swiper($(n), {
				slidesPerView: "2.5",
				slidesPerGroup:1,
				spaceBetween: 8,
				freeMode: true,
				navigation: {
					nextEl: $(n).parents(".slideType52").find('.swiper-button-next'),
					prevEl: $(n).parents(".slideType52").find('.swiper-button-prev'),
				}
			}));
		});			

	});
	</script>
</c:otherwise>
</c:choose>

	<style>
		.commentBoxAp.logcommentBox{overflow:hidden;}
		.commentBoxAp > .con.t2 > .input{position:relative;}
		.tagList{position:absolute; top:0; left:0; width:100%; background:#f7f7f7;}
		.tagList > ul{padding:0 20px;}
		.tagList > ul > li{height:46px; padding:0 0 0 3px; font-size:14rem; color:#669aff; line-height:46px; border-bottom:1px solid #ecedef;}
	</style>

<script>
	$(document).ready(function(){
		<c:choose>
			<c:when test="${adminYn ne null and adminYn ne '' and adminYn eq 'Y'}">
				$("#adminHideArea1").css("display","none");
				$("#adminHideArea2").css("display","none");
				//$("#contents").css("margin-top","20px");
			</c:when>
			<c:otherwise>
				<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
					//ajax.load("include_regist", "/log/indexIncludeRegist", {});
				</c:if>
			</c:otherwise>
		</c:choose>
		
// 		$('.con .txt .time').each(function(){
// 			if( $(this).text() != undefined && $(this).text() != '') {
// 				var converTime = elapsedTime(new Date($(this).text()));
// 				$(this).text(converTime);
// 			}
// 		});
				
		// 시간 표시
		setTimeConvert();
		
		// 게시글 내용에 링크추가.
		setContentLink();

		substrUserInfo();
	});
	
	//뒤로가기 시 마이 찜리스트 페이지 리로드
	/* history.pushState(null,null,'');
	window.onpopstate = function(event) { 
		history.replaceState(null,null,'/mypage/log/myWishList')
		location.href = location.href;
		} */
</script>
		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container page logmain" id="container">
			<div class="inr">
			<form id="petLogShareForm" name="petLogShareForm" method="post" onSubmit="return false;">
			<input type="hidden" id="shrChnlCd" name="shrChnlCd" /><!-- 공유채널코드 -->	
			<input type="hidden" name="petLogNo"/><!-- 펫로그번호 -->
			<input type="hidden" name="mbrNo" value="${session.mbrNo}" /><!-- 회원번호 -->		
			</form>
			<form id="petLogReplyForm" name="petLogReplyForm" method="post" onSubmit="return false;">
			<input type="hidden" id="contsStatCd" name="contsStatCd" value="10" /><!-- 컨텐츠 상태코드(10-노출, 20-미노출, 30-신고차단) -->
			<input type="hidden" id="aply" name="aply" /><!-- 댓글 -->	
			<input type="hidden" name="petLogNo"/><!-- 펫로그번호 -->	
			<input type="hidden" name="petLogAplySeq"/><!-- 댓글 순번 -->	
			<input type="hidden" name="mbrNo" value="${session.mbrNo}" /><!-- 회원번호 -->		
			</form>
			<form id="petLogInterestForm" name="petLogInterestForm" method="post" onSubmit="return false;">
			<input type="hidden" id="intsGbCd" name="intsGbCd" /><!-- 관심구분코드(10-좋아요, 20-찜) -->
			<input type="hidden" name="petLogNo"/><!-- 펫로그번호 -->	
			<input type="hidden" name="mbrNo" value="${session.mbrNo}" /><!-- 회원번호 -->	
			<input type="hidden" name="saveGb" /><!-- 등록/삭제 구분 -->	
			</form>			
				<!-- 본문 -->
				<div class="contents log main" id="contents">
					<section class="logContentBox">
<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">						
							<div class="lcbConTxt">
								<div class="userInfo ${petLogBase.pstNm ne null and petLogBase.pstNm ne '' ? 't2' : ''}">
							<c:choose>					
								<c:when test="${petLogBase.prflImg ne null and petLogBase.prflImg ne ''}">	
									<div class="pic"><img src="${frame:optImagePath(petLogBase.prflImg, frontConstants.IMG_OPT_QRY_786)}" alt="dog"></div>
								</c:when>
								<c:otherwise>
									<div class="pic"><img src="../../_images/common/icon-img-profile-default-m@2x.png" alt="dog"></div>
								</c:otherwise>
							</c:choose>
									<div class="con">
										<div class="txt">
											<a class="nickname" href="/log/indexMyPetLog/${petLogBase.petLogUrl}?mbrNo=${petLogBase.mbrNo}">${petLogBase.nickNm}</a>
											<span class="dotIcon2x2 onWeb_ib"></span>
											<span class="location">${petLogBase.pstNm}</span>
											<span class="dotIcon2x2"></span>
											<span class="time">${petLogBase.sysRegDtm}</span>
										</div>
									</div>
									<!-- select box -->
									<div class="menu dopMenuIcon" onclick="ui.popSel.open(this, event)" id="adminHideArea1">
										<div class="popSelect r">
											<input type="text" class="popSelInput">
											<div class="popSelInnerWrap" style="height: 0px;">
												<ul>
					<c:choose>					
						<c:when test="${session.mbrNo eq petLogBase.mbrNo}">									
														<li><a class="bt" href="javascript:updatePetLog('${petLogBase.petLogNo}');"><b class="t"><spring:message code='front.web.view.common.update' /></b></a></li>
														<li><a class="bt" href="javascript:deletePetLog('${petLogBase.petLogNo}');"><b class="t"><spring:message code='front.web.view.goods.delete.btn' /></b></a></li>
						</c:when>
						<c:otherwise>
							<c:choose>					
								<c:when test="${petLogBase.rptpYn eq null or petLogBase.rptpYn eq 'N'}">
														<li><a class="bt" href="javascript:layerPetLogReport('${petLogBase.petLogNo}','', '1');" id="btRptp1_${petLogBase.petLogNo}"><b class="t"><spring:message code='front.web.view.common.report.button.title' /></b></a></li>
								</c:when>
								<c:otherwise>
														<li><a class="bt" href="javascript:ui.toast('<spring:message code='front.web.view.petlog.report.contents.msg.toast' />',{ bot:70 });" id="btRptp1_${petLogBase.petLogNo}"><spring:message code='front.web.view.common.report.button.title' /></a></li>
								</c:otherwise>
							</c:choose>	
						</c:otherwise>
					</c:choose>												
												</ul>
											</div>
										</div>
									</div>
									<!-- // select box -->
								</div>
							</div>
</c:if>					
						<!-- 이미지/동영상 영역 : S -->
<!-- 						<div class="lcbPicture"> -->
	<c:choose>							
		<c:when test="${petLogBase.vdPath ne null and petLogBase.vdPath ne ''}">	
						<div class="lcbPicture">
<!-- 							<button class="logBtnBasic28 icon_sound" onclick="player.mutedToggle();"></button> -->
								<div class="vthumbs" style="position:relative;height:446px" video_id="${petLogBase.vdPath}" type="video_thumb_720p" lazy="scroll" uid="${petLogBase.mbrNo}|${session.mbrNo}"></div>
						</div>
		</c:when>
		<c:otherwise>
			<c:set var="imgPathList" value="${fn:split(petLogBase.imgPathAll,'[|]')}" />
			<c:choose>					
				<c:when test="${fn:length(imgPathList) > 1 }">				
						<div class="lcbPicture sw">
							<!-- slider -->
							<div class="swiper-container logMain">
								<div class="swiper-pagination"></div>
								<ul class="swiper-wrapper slide">
					<c:forEach items="${imgPathList}" var="imgPath">
						<c:choose>					
							<c:when test="${fn:indexOf(imgPath, '/log/') > -1 }" >
									<c:set var="optImage" value="${frame:optImagePath(imgPath, frontConstants.IMG_OPT_QRY_772)}" />
								<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
									<c:set var="optImage" value="${frame:optImagePath(imgPath, frontConstants.IMG_OPT_QRY_773)}" />
								</c:if>		
								<c:if test="${fn:indexOf(imgPath, '.gif') > -1 }">
									<c:set var="optImage"
										value="${frame:imagePath(imgPath)}" />
								</c:if>							
							</c:when>
							<c:otherwise>
									<c:set var="optImage" value="../../_images/_temp/temp_logsImg01.png" /><!-- 퍼블이미지 -->
							</c:otherwise>
						</c:choose>	
									<li class="swiper-slide"><div class="inr"><img src="${optImage}" alt="img01" 
										 style="position:relative;${view.deviceGb eq frontConstants.DEVICE_GB_10 ? 'height:799px;':'height:446px;'}" /></li>
					</c:forEach>	
								</ul>
								<div class="remote-area">
									<button class="swiper-button-next" type="button"></button>
									<button class="swiper-button-prev" type="button"></button>
								</div>
							</div>
							<!-- // slider -->
						</div>
				</c:when>
				<c:otherwise>				
						<div class="lcbPicture">
						<c:choose>					
							<c:when test="${fn:indexOf(imgPathList[0], '/log/') > -1 }" >
									<c:set var="optImage" value="${frame:optImagePath(imgPathList[0], frontConstants.IMG_OPT_QRY_772)}" />
								<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
									<c:set var="optImage" value="${frame:optImagePath(imgPathList[0], frontConstants.IMG_OPT_QRY_773)}" />
								</c:if>
								<c:if test="${fn:indexOf(imgPathList[0], '.gif') > -1 }">
									<c:set var="optImage"
										value="${frame:imagePath(imgPathList[0])}" />
								</c:if>							
							</c:when>
							<c:otherwise>
									<c:set var="optImage" value="../../_images/_temp/temp_logsImg01.png" /><!-- 퍼블이미지 -->
							</c:otherwise>
						</c:choose>
							<img src="${optImage}" alt="img01" 
								 style="position:relative;${view.deviceGb eq frontConstants.DEVICE_GB_10 ? 'height:799px;':'height:446px;'}" />
						</div>
				</c:otherwise>
			</c:choose>		
		</c:otherwise>
	</c:choose>			
<!-- 						</div>						 -->
						<!-- 이미지/동영상 영역 : E -->
						
						<div class="lcbWebRconBox">
<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">							
							<div class="lcbConTxt">
								<div class="userInfo">
							<c:choose>					
								<c:when test="${petLogBase.prflImg ne null and petLogBase.prflImg ne ''}">	
										<div class="pic"><img src="${frame:optImagePath(petLogBase.prflImg, frontConstants.IMG_OPT_QRY_786)}" alt="dog"></div>
								</c:when>
								<c:otherwise>
										<div class="pic"><img src="../../_images/common/icon-img-profile-default-m@2x.png" alt="dog"></div>
								</c:otherwise>
							</c:choose>
									<div class="con">
										<div class="txt">
											<a class="nickname" href="/log/indexMyPetLog/${petLogBase.petLogUrl}?mbrNo=${petLogBase.mbrNo}">${petLogBase.nickNm}</a>
											<span class="dotIcon2x2 onWeb_ib"></span>
									<c:if test="${petLogBase.pstNm ne null and petLogBase.pstNm ne ''}">
											<span class="location">${petLogBase.pstNm}</span>
											<span class="dotIcon2x2"></span>
									</c:if>
											<span class="time">${petLogBase.sysRegDtm}</span>
										</div>
									</div>
									<!-- select box -->
									<div class="menu dopMenuIcon" onclick="ui.popSel.open(this,event)">
										<div class="popSelect r">
											<input type="text" class="popSelInput">
											<div class="popSelInnerWrap" style="height: 0px;">
												<ul>
					<c:choose>					
						<c:when test="${session.mbrNo eq petLogBase.mbrNo}">									
														<li><a class="bt" href="javascript:updatePetLog('${petLogBase.petLogNo}');"><b class="t"><spring:message code='front.web.view.common.update' /></b></a></li>
														<li><a class="bt" href="javascript:deletePetLog('${petLogBase.petLogNo}');"><b class="t"><spring:message code='front.web.view.goods.delete.btn' /></b></a></li>
						</c:when>
						<c:otherwise>
							<c:choose>					
								<c:when test="${petLogBase.rptpYn eq null or petLogBase.rptpYn eq 'N'}">
														<li><a class="bt" href="javascript:layerPetLogReport('${petLogBase.petLogNo}','', '1');" id="btRptp1_${petLogBase.petLogNo}"><b class="t"><spring:message code='front.web.view.common.report.button.title' /></b></a></li>
								</c:when>
								<c:otherwise>
														<li><a class="bt" href="javascript:ui.toast('<spring:message code='front.web.view.petlog.report.contents.msg.toast' />',{ bot:70 });" id="btRptp1_${petLogBase.petLogNo}"><spring:message code='front.web.view.common.report.button.title' /></a></li>
								</c:otherwise>
							</c:choose>	
						</c:otherwise>
					</c:choose>												
												</ul>
											</div>
										</div>
									</div>
									<!-- // select box -->
								</div>
								<!-- content txt -->
						<c:if test="${petLogBase.dscrt ne null and petLogBase.dscrt ne ''}">
								<span class="iconOm_arr"></span>
								<div class="lcbConTxt_content" id="contentArea" >
									${petLogBase.dscrt}								
								</div>
						</c:if>
<%-- 								<textarea name="dscrt" id="dscrt" cols="30" rows="10" style="height:68px;display:none;">${petLogBase.dscrt}</textarea> --%>
								<!-- // content txt -->
							</div>
</c:if>							
							<!-- menu bar -->
							<div class="lcbmenuBar" id="adminHideArea2">
								<div class="inner">
									<ul class="bar-btn-area">
										<li id="likeBtn1_${petLogBase.petLogNo}">
		<c:choose>
			<c:when test="${petLogBase.likeYn ne null and petLogBase.likeYn eq 'Y'}">
											<button class="logBtnBasic btn-like on" onclick="savePetLogInterest('${petLogBase.petLogNo}', '10', 'D', '1');">${petLogBase.likeCnt}</button>
			</c:when>
			<c:otherwise>											
											<button class="logBtnBasic btn-like" onclick="savePetLogInterest('${petLogBase.petLogNo}', '10', 'I', '1');">${petLogBase.likeCnt}</button>
			</c:otherwise>
		</c:choose>
										</li>
										<li>
											<button class="logBtnBasic btn-comment" onClick="viewReply('${petLogBase.petLogNo}','1',this);" id="replyCnt1_${petLogBase.petLogNo}">${petLogBase.replyCnt}</button>
										</li>
										<li>
											<button class="logBtnBasic btn-share" data-message="<spring:message code='front.web.view.common.msg.result.share' />"
												data-title="${petLogBase.nickNm}" title="COPY URL"
												onclick="sharePetLog('${petLogBase.petLogNo}', this.id, 'P');"
												id="share1_${petLogBase.petLogNo}"
												data-clipboard-text="${petLogBase.srtPath}">
												<span>공유</span>
											</button>
										</li>										
										<%-- <li>
											<button class="logBtnBasic btn-share" data-message="URL을 복사하였습니다." title="COPY URL" onclick="sharePetLog('${petLogBase.petLogNo}', this.id, 'P');" id="share1_${petLogBase.petLogNo}" data-clipboard-text="${petLogBase.srtPath}"><span>공유</span></button>
										</li> --%>
										<li class="ml20" id="bookBtn1_${petLogBase.petLogNo}">
		<c:choose>
			<c:when test="${petLogBase.bookmarkYn ne null and petLogBase.bookmarkYn eq 'Y'}">
											<button class="logBtnBasic btn-bookmark on" onclick="savePetLogInterest('${petLogBase.petLogNo}', '20', 'D', '1');"><span><spring:message code='front.web.view.common.bookmark.title' /></span></button>
			</c:when>
			<c:otherwise>											
											<button class="logBtnBasic btn-bookmark" onclick="savePetLogInterest('${petLogBase.petLogNo}', '20', 'I', '1');"><span><spring:message code='front.web.view.common.bookmark.title' /></span></button>
			</c:otherwise>
		</c:choose>										
										</li>
									</ul>
		<c:if test ="${petLogBase.goodsRltCnt > 0 }">
									<div class="log_connectTingWrap">
										<button class="tvConnectedTing" onclick="$(this).next().trigger('click')"><spring:message code='front.web.view.common.relatedGoods.title' /></button>
										<button class="btn_connectTing" data-content="${petLogBase.petLogNo}" data-related-page="${idx.index }-${so.page}" data-url="getRelatedGoodsWithPetLog(this, '${petLogBase.petLogNo}')">
											<c:set var="gImg" value="${frame:optImagePath(petLogBase.goodsThumbImgPath,frontConstants.IMG_OPT_QRY_500)}" />
											<c:if test="${fn:indexOf(petLogBase.goodsThumbImgPath, 'cdn.ntruss.com') > -1 }" >
											<c:set var="gImg" value="${petLogBase.goodsThumbImgPath}" />      
											</c:if> 
				                        	<span>${petLogBase.goodsRltCnt}</span>
											<div class="inr_wrapBox"><img src="${gImg}" alt=""></div>
										</button>
									</div>
		</c:if>
								</div>
							</div>
							<!-- // menu bar -->
<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">						
						<!-- content txt -->
					<c:if test="${petLogBase.dscrt ne null and petLogBase.dscrt ne ''}">									
						<!-- 펫로그 상세는 단건이기에 name에 페이지1 로 고정 -->
						<div class="contxtWrap" name="contxtWrap1">
							<div class="lcbConTxt_content">${petLogBase.dscrt}</div>
							<!-- more btn -->
							<button class="btn_logMain_more onWeb_b"><spring:message code='front.web.view.common.seemore.title' /></button>
							<!-- // more btn -->
						</div>
					</c:if>
							<!-- // content txt -->
</c:if>								
							<!-- 댓글 -->
							<div class="commentBoxAp logcommentBox pop1" id="pop1_${petLogBase.petLogNo}">
							</div>
							<!-- //댓글 -->							
						</div>						
					</section>
					<!-- popup 내용 부분입니다. -->
					<!-- both popup -->
<!-- 					<div id="include_regist" class="commentBoxAp logpet" data-autoCloseUp="true" data-close="true" data-min="75px" data-max="180px" data-autoOpen="true" data-priceh="75px">data-priceh : 오픈 시 올라가는 높이 -->
<!-- 					</div> -->
					<!-- // both popup -->
					
				</div>
			</div>
		</main>