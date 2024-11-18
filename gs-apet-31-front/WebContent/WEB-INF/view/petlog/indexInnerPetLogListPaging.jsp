<c:if test="${not empty petLogList}">	
<div name="petLogListView">
<c:choose>
<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
	<script>
	$(document).ready(function(){
		//$(window).scrollTop($("#<c:out value='${so.petLogNo}' />").offset().top);
			var hTimer = setInterval(function(){
				$("#header_pc .tmenu .list li:eq(1)").addClass("active").siblings().removeClass("active")
				if($("#header_pc").length) clearInterval(hTimer);
			});
			var swiperBox = new Array();
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
	<script>
	$(document).ready(function(){
		var index = "${selIdx}";
		var tiles = "${tiles}" == "" ? true : false;
		// 게시글 내용에 링크추가.
		setContentLink();
		// 시간 표시
		setTimeConvert();
		//유저 닉네임 , 태그 게시물 태그명 substr
		substrUserInfo();

		//처음 진입 시 더보기 버튼 세팅 스크립트 2번 실행되지 않게
		if(!tiles){
			moContxtMoreSet("${so.page}")	
		}
		
	});	
	
 	function substrUserInfo(){
   		$("section .lcbConTxt .userInfo .txt").each(function(i, v) {
   			//특수 문자 unescape처리 완료 된 이후에 substr하기 위해
   			var tag = $(v).find(".tag").data("orgin-tag")
   			var nickNm = $(v).find(".nickname").data("orgin-nick")
   			
   			if(tag && tag.length > 6){
   				$(v).find(".tag").html(tag.substr(0,6) + "...");
   			}
   			
   			if(nickNm && nickNm.length > 10){
   				$(v).find(".nickname").html(nickNm.substr(0,10) + "...");
   			}
   		})
   	}
	
    function setContentLink(){
    	$("section .lcbWebRconBox .lcbConTxt_content").each(function(i, v) {
			
			let strOriginal =  $(this).text();
			
			var inputString = strOriginal;
			//inputString = inputString.replace(/#[^#\s]+|@[^@\s]+/gm, function (tag){
			inputString = inputString.replace(/#[^#\s\<\>\@\&]+/gm, function (tag){
				
				return (tag.indexOf('#')== 0 && tag.length < 22) ? '<a href="/log/indexPetLogTagList?tag=' + encodeURIComponent(tag.replace('#','')) + '" style="color:#669aff;">' + tag + '</a>' : tag;
			});
			$(this).html(inputString);
		});
    }
    
    
    function setTimeConvert(){	
		$('.con .txt .time').each(function(){
			if( $(this).text() != undefined && $(this).text() != '') {
				if($(this).data("converted") != "Y"){
					var timeTxt = new Date($(this).text().replace(/\s/, 'T'));					
					var converTime = elapsedTime(timeTxt, "<spring:message code='front.web.view.petlog.datetime.info.msg.title' />");
					$(this).text(converTime);
					$(this).data("converted" , "Y");
				}
			}
		});
    }
    
	function resizeLogImg(){
		$(".logContentBox .lcbPicture img, .logContentBox .lcbPicture .vthumbs").each(function(i,n){
			let w = $(n).parent().innerWidth();
			let h = (w / 3) * 4 ;
			$(n).parent().attr("style","height:"+h + "px;");
		});
	}
</script>

<c:forEach items="${petLogList}" var="petLogBase" varStatus="idx">
					<section class="logContentBox" id="${petLogBase.petLogNo}" style="margin-top: 20px;">
<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">					
							<div class="lcbConTxt">
								<div class="userInfo ${petLogBase.pstNm ne null and petLogBase.pstNm ne '' ? 't2' : ''} ${pageType eq 'T' ? 'tag':''}">
								<c:choose>
									<c:when
										test="${petLogBase.prflImg ne null and petLogBase.prflImg ne ''}">
										<div class="pic"
											onclick="javascript:goMyPetLog('${petLogBase.petLogUrl}','${petLogBase.mbrNo}',event);">
											<img
												src="${frame:optImagePath(petLogBase.prflImg, frontConstants.IMG_OPT_QRY_786)}"
												alt="dog">
										</div>
									</c:when>
									<c:otherwise>
										<div class="pic"
											onclick="javascript:goMyPetLog('${petLogBase.petLogUrl}','${petLogBase.mbrNo}',event);">
											<img src="../../_images/common/icon-img-profile-default-m@2x.png" alt="dog">
										</div>
									</c:otherwise>
								</c:choose>	
									<div class="con">
										<div class="txt">
											<a class="nickname" href="/log/indexMyPetLog/${petLogBase.petLogUrl}?mbrNo=${petLogBase.mbrNo}" data-orgin-nick="${petLogBase.nickNm }">${petLogBase.nickNm}</a>										
											<span class="dotIcon2x2 onWeb_ib"></span>
											<span class="location">${petLogBase.pstNm}</span>
											<span class="dotIcon2x2"></span>
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
														<li><a class="bt" href="javascript:layerPetLogReport('${petLogBase.petLogNo}','', '1','${petLogBase.rvwYn}');" id="btRptp1_${petLogBase.petLogNo}"><b class="t"><spring:message code='front.web.view.common.report.button.title' /></b></a></li>
								</c:when>
								<c:otherwise>
														<c:set var="toastMsg" value="${petLogBase.rvwYn eq 'Y' ? '이미 신고한 후기에요':'이미 신고한 게시물이에요'}" />
														<li><a class="bt" href="javascript:ui.toast('${toastMsg}',{ bot:70 });" id="btRptp1_${petLogBase.petLogNo}"><spring:message code='front.web.view.common.report.button.title' /></a></li>
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
<!-- 					<div class="lcbPicture"> -->
							
					<c:choose>							
		<c:when test="${petLogBase.vdPath ne null and petLogBase.vdPath ne ''}">	
						<div class="lcbPicture">
							<c:if test="${petLogBase.rate ne null and petLogBase.rate ne '' and petLogBase.rate > 50 }"><div class="log_f_c_pop">${petLogBase.rate}<spring:message code='front.web.view.petlog.video.same.percent_rate.title' /></div></c:if>
<!-- 							<button class="logBtnBasic28 icon_sound" onclick="player.mutedToggle();"></button> -->
							<div class="vthumbs" style="${view.deviceGb eq frontConstants.DEVICE_GB_10 ? 'position:relative;height:799px;':'height:100%;'}" video_id="${petLogBase.vdPath}" type="video_thumb_720p" lazy="scroll" uid="${petLogBase.mbrNo}|${session.mbrNo}" data-enChk="${petLogBase.encCpltYn }"></div>
						</div>
		</c:when>
		<c:otherwise>
			<c:set var="imgPathList" value="${fn:split(petLogBase.imgPathAll,'[|]')}" />
			<c:choose>						
				<c:when test="${fn:length(imgPathList) > 1 }">				
						<div class="lcbPicture sw">
							<c:if test="${petLogBase.rate ne null and petLogBase.rate ne '' and petLogBase.rate > 50 }"><div class="log_f_c_pop">${petLogBase.rate}<spring:message code='front.web.view.petlog.video.same.percent_rate.title' /></div></c:if>
							<!-- slider -->
							<div class="swiper-container logMain">
								<div class="swiper-pagination"></div>
								<ul class="swiper-wrapper slide">
					<c:forEach items="${imgPathList}" var="imgPath">
						<c:choose>					
							<c:when test="${fn:indexOf(imgPath, '/log/') > -1 }">
								<c:set var="optImage"
									value="${frame:optImagePath(imgPath, frontConstants.IMG_OPT_QRY_772)}" />
								<c:if
									test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
									<c:set var="optImage"
										value="${frame:optImagePath(imgPath, frontConstants.IMG_OPT_QRY_773)}" />
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
										style="${view.deviceGb eq frontConstants.DEVICE_GB_10 ? 'position:relative;height:799px;':'height:100%;'}" /></div>
									</li>
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
							<c:if test="${petLogBase.rate ne null and petLogBase.rate ne '' and petLogBase.rate > 50 }"><div class="log_f_c_pop">${petLogBase.rate}<spring:message code='front.web.view.petlog.video.same.percent_rate.title' /></div></c:if>
						<c:choose>					
							<c:when test="${fn:indexOf(imgPathList[0], '/log/') > -1 }">
								<c:set var="optImage"
									value="${frame:optImagePath(imgPathList[0], frontConstants.IMG_OPT_QRY_772)}" />
								<c:if
									test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
									<c:set var="optImage"
										value="${frame:optImagePath(imgPathList[0], frontConstants.IMG_OPT_QRY_773)}" />
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
							<img src="${optImage}" alt="img01" class="tempImgSize" style="${view.deviceGb eq frontConstants.DEVICE_GB_10 ? 'position:relative;height:799px;':'height:100%;'}" />
						</div>
				</c:otherwise>
			</c:choose>		
		</c:otherwise>
	</c:choose>			
<!-- 						</div> -->
						<!-- 이미지/동영상 영역 : E -->
						
						<div class="lcbWebRconBox">
<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">						
							<div class="lcbConTxt">
								<div class="userInfo  ${pageType eq 'T' ? 'tag':''}">
<%-- 			<c:choose>	
				<c:when test="${pageType ne null and pageType eq 'T' }">			
									<div class="pic tag"></div>
				</c:when>
				<c:otherwise> --%>
						<c:choose>					
							<c:when test="${petLogBase.prflImg ne null and petLogBase.prflImg ne ''}">	
									<div class="pic"><img src="${frame:optImagePath(petLogBase.prflImg, frontConstants.IMG_OPT_QRY_786)}" alt="dog"></div>
							</c:when>
							<c:otherwise>
									<div class="pic"><img src="../../_images/common/icon-img-profile-default-m@2x.png" alt="dog"></div>
							</c:otherwise>
						</c:choose>						
<%-- 				</c:otherwise>
			</c:choose>	 --%>		
									<div class="con">
										<div class="txt">
											<a class="nickname" href="/log/indexMyPetLog/${petLogBase.petLogUrl}?mbrNo=${petLogBase.mbrNo}" data-orgin-nick="${petLogBase.nickNm }">${petLogBase.nickNm}</a>										
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
														<li><a class="bt" href="javascript:layerPetLogReport('${petLogBase.petLogNo}','', '1','${petLogBase.rvwYn}');" id="btRptp1_${petLogBase.petLogNo}"><b class="t"><spring:message code='front.web.view.common.report.button.title' /></b></a></li>
								</c:when>
								<c:otherwise>
														<c:set var="toastMsg" value="${petLogBase.rvwYn eq 'Y' ? '이미 신고한 후기에요':'이미 신고한 게시물이에요'}" />
														<li><a class="bt" href="javascript:ui.toast('${toastMsg}',{ bot:70 });" id="btRptp1_${petLogBase.petLogNo}"><spring:message code='front.web.view.common.report.button.title' /></a></li>
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
								<div class="lcbConTxt_content">${petLogBase.dscrt}</div>
							</c:if>
								<!-- // content txt -->
							</div>
</c:if>							
							<!-- menu bar -->
							<div class="lcbmenuBar">
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
											<button class="logBtnBasic btn-comment" onClick="viewReply('${petLogBase.petLogNo}','1', this);" id="replyCnt1_${petLogBase.petLogNo}">${petLogBase.replyCnt}</button>
										</li>
										<li>
											<button class="logBtnBasic btn-share" data-message="<spring:message code='front.web.view.common.msg.result.share' />" title="COPY URL" onclick="sharePetLog('${petLogBase.petLogNo}', this.id, 'P');" id="share1_${petLogBase.petLogNo}" data-title="${petLogBase.nickNm}" data-clipboard-text="${petLogBase.srtPath}"><span><spring:message code='front.web.view.common.sharing' /></span></button>
										</li>
										<c:if test="${empty session.bizNo}">
											<li class="ml20" id="bookBtn1_${petLogBase.petLogNo}">
											<c:choose>
												<c:when test="${petLogBase.bookmarkYn ne null and petLogBase.bookmarkYn eq 'Y'}">
													<button class="logBtnBasic btn-bookmark on" onclick="savePetLogInterest('${petLogBase.petLogNo}', '20', 'D', '1');">
														<span><spring:message code='front.web.view.common.bookmark.title' /></span>
													</button>
												</c:when>
												<c:otherwise>											
													<button class="logBtnBasic btn-bookmark" onclick="savePetLogInterest('${petLogBase.petLogNo}', '20', 'I', '1');">
														<span><spring:message code='front.web.view.common.bookmark.title' /></span>
													</button>
												</c:otherwise>
											</c:choose>										
											</li>
										</c:if>
									</ul>
		<c:if test="${petLogBase.goodsRltCnt > 0}">
									
									<div class="log_connectTingWrap">
										<buttron class="tvConnectedTing" onclick="$(this).next().trigger('click')"><spring:message code='front.web.view.common.relatedGoods.title' /></buttron>
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
						<div class="contxtWrap" name="contxtWrap${so.page }">
							<div class="lcbConTxt_content">${petLogBase.dscrt}</div>
							<!-- more btn -->
							<button class="btn_logMain_more onWeb_b"><spring:message code='front.web.view.common.seemore.title' /></button>
							<!-- // more btn -->
						</div>
					</c:if>
							<!-- // content txt -->
</c:if>
							<div class="commentBoxAp logcommentBox pop1" id="pop1_${petLogBase.petLogNo}">
							</div>
						</div>
					</section>
</c:forEach>
</div>
</c:if>