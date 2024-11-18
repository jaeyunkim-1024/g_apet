<c:if test="${not empty pagePetLogMainList}">
<div id="petLogMainList" name="petLogMainList" data-page = ${so.recommendPage }>
<style>
.commentBoxAp.logcommentBox {
	overflow: hidden;
}

.commentBoxAp>.con.t2>.input {
	position: relative;
}

.tagList {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	background: #f7f7f7;
}

.tagList>ul {
	padding: 0 20px;
}

.tagList>ul>li {
	height: 46px;
	padding: 0 0 0 3px;
	font-size: 14rem;
	color: #669aff;
	line-height: 46px;
	border-bottom: 1px solid #ecedef;
}
</style>

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

			var swiper5 = new Array();
			$('.slideType5 .swiper-container').each(function(i,n){
				swiper5.push(new Swiper($(n), {
					slidesPerView: 5,
					spaceBetween: 16,
					navigation: {
						nextEl: $(n).parents(".slideType5").find('.swiper-button-next'),
						prevEl: $(n).parents(".slideType5").find('.swiper-button-prev'),
					},
				}));
			});
			var cu = null;
			
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
			// 시간 표시
			setTimeConvertPaging();
			
			// 게시글 내용에 링크추가.
			setContentLink();

			// 게시물 이미지 resize
			resizeLogImg();		
			
			//모바일 더보기 버튼
			moContxtMoreSet('${so.recommendPage}');
			
			substrUserInfo();
			
			newPostCount = Number("${so.newPostCount}");	
			upperScrollPage = $("[name=petLogMainList]").eq(0).data("page");
			
			// 신규 게시물 조회 제외 번호 set
			if(!$("#excludePetLogNo").val()){
				$("#excludePetLogNo").val("${so.excludeLogNo}");	
			}
			
			$("#excludeRecMbrNo").val("${so.excludeRecMbrNo}")			
			// 신규 게시물 노출 시작 시 기준 펫로그 번호 갱신
			if($(".logContentBox[data-new-yn=Y]").length > 0 && !$("#compareNewPetLogNo").val()){
				$("#compareNewPetLogNo").val($(".logContentBox[data-new-yn=Y]").eq(0).attr("id"))				
			}

			// 좋아할만한 펫로그 닉네임 클릭 시 해당 사용자 펫로그 홈으로 이동
			$(".log_userInfoBar").click(function(e){
				e.preventDefault();
			})
			
			
			//페이징 시 해당 페이지번호와 html을 배열에 저장 
			var htmlJson = new Object();
			htmlJson.page = "${so.recommendPage}";
			var html = '<div id="petLogMainList" name="petLogMainList" data-page="'+htmlJson.page+'">'
			html += $("[name=petLogMainList]").last().html();
			html += '</div>';
			htmlJson.html = html;
			if(htmlArr.length <= Number(htmlJson.page)-1 || htmlArr.length == 0){
				htmlArr.push(htmlJson)	
			}
		});
		
	
	    function setTimeConvertPaging(){	
			$('#pCon .txt .time').each(function(){
				if( $(this).text() != undefined && $(this).text() != '' && $(this).text().indexOf(":") > -1) {
					//console.log("1:"+$(this).text());
					var timeTxt = new Date($(this).text().replace(/\s/, 'T'));	
					//console.log("2:"+timeTxt);
					var converTime = elapsedTime(timeTxt, "년월일");
					//console.log("3:"+converTime);
					$(this).text(converTime);
				}
			});
	    }
		
	</script>
<c:forEach items="${pagePetLogMainList}" var="petLogBase" varStatus="idx">
					<div id="pSection" name="pSection">
					<section class="logContentBox" id="${petLogBase.petLogNo }" data-new-yn="${petLogBase.newPostYn }">
<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">					
						<!-- user content -->
						<div class="lcbConTxt">
							<!-- userInfo -->
								<c:choose>
									<c:when test="${not empty petLogBase.followTagNm and session.mbrNo ne petLogBase.mbrNo}">
										<div class="userInfo ${petLogBase.pstNm ne null and petLogBase.pstNm ne '' ? 't2' : ''} tagon">
											<div class="pic" onclick="location.href='/log/indexPetLogTagList?tag=${petLogBase.followTagNm}'">
									</c:when>
									<c:otherwise>
										<div class="userInfo ${petLogBase.pstNm ne null and petLogBase.pstNm ne '' ? 't2' : ''}">
											<div class="pic" onclick="javascript:goMyPetLog('${petLogBase.petLogUrl}','${petLogBase.mbrNo}',event);">
									</c:otherwise>
								</c:choose>							
								<c:choose>
									<c:when test="${petLogBase.prflImg ne null and petLogBase.prflImg ne ''}">
										<img src="${frame:optImagePath(petLogBase.prflImg, frontConstants.IMG_OPT_QRY_786)}" alt="dog">
									</c:when>
									<c:otherwise>
										<img src="../../_images/common/icon-img-profile-default-m@2x.png" alt="dog">
									</c:otherwise>
								</c:choose>
								</div>							
								<div class="con" id="pCon">
									<div class="txt">
									<c:if test="${not empty petLogBase.followTagNm and session.mbrNo ne petLogBase.mbrNo}">
										<a href="/log/indexPetLogTagList?tag=${petLogBase.followTagNm}" class="tag" data-orgin-tag="${petLogBase.followTagNm }">#${petLogBase.followTagNm}</a>
									</c:if>	
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
														<li><a class="bt"
															href="javascript:updatePetLog('${petLogBase.petLogNo}');"><b
																class="t">수정</b></a></li>
														<li><a class="bt"
															href="javascript:deletePetLog('${petLogBase.petLogNo}');"><b
																class="t">삭제</b></a></li>
													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when
																test="${petLogBase.rptpYn eq null or petLogBase.rptpYn eq 'N'}">
																<li><a class="bt"
																	href="javascript:layerPetLogReport('${petLogBase.petLogNo}','', '${recommendPage}','${petLogBase.rvwYn}');"
																	id="btRptp${recommendPage}_${petLogBase.petLogNo}"><b class="t">신고</b></a></li>
															</c:when>
															<c:otherwise>
																<c:set var="toastMsg" value="${petLogBase.rvwYn eq 'Y' ? '이미 신고한 후기에요':'이미 신고한 게시물이에요'}" />
																<li><a class="bt"
																	href="javascript:ui.toast('${toastMsg}',{ bot:70 });"
																	id="btRptp${recommendPage}_${petLogBase.petLogNo}">신고</a></li>
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
							<!-- // userInfo -->							
						</div>
						<!-- // user content -->
</c:if>						
					
					<!-- 이미지/동영상 영역 : S -->
								
						<c:choose>
							<c:when
								test="${petLogBase.vdPath ne null and petLogBase.vdPath ne ''}">
							<div class="lcbPicture">
								<!-- 							<button class="logBtnBasic28 icon_sound" onclick="player.mutedToggle();"></button> -->
								<div class="vthumbs" style="${view.deviceGb eq frontConstants.DEVICE_GB_10 ? 'position:relative;height:799px;':'height:100%;'}" video_id="${petLogBase.vdPath}"
									type="video_thumb_720p" lazy="scroll"
									uid="${petLogBase.mbrNo}|${session.mbrNo}" data-enChk="${petLogBase.encCpltYn }"></div>
							</div>
							</c:when>
							<c:otherwise>
								<c:set var="imgPathList"
									value="${fn:split(petLogBase.imgPathAll,'[|]')}" />
								<c:choose>
									<c:when test="${fn:length(imgPathList) > 1 }">
									<div class="lcbPicture sw">
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
															<c:set var="optImage"
																value="../../_images/_temp/temp_logsImg01.png" />
															<!-- 퍼블이미지 -->
														</c:otherwise>
													</c:choose>
													<li class="swiper-slide"><div class="inr"><img src="${optImage}" alt="img01" 
														style="${view.deviceGb eq frontConstants.DEVICE_GB_10 ? 'position:relative;height:799px;':'height:100%;'}"/></div></li>
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
												<c:set var="optImage"
													value="../../_images/_temp/temp_logsImg01.png" />
												<!-- 퍼블이미지 -->
											</c:otherwise>
										</c:choose>
										<img src="${optImage}" alt="img01" class="tempImgSize" style="${view.deviceGb eq frontConstants.DEVICE_GB_10 ? 'position:relative;height:799px;':'height:100%;'}" />
									</div>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
					<!-- 이미지/동영상 영역 : E -->					
					
					<div class="lcbWebRconBox">					
<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">					
						<!-- user content -->
						<div class="lcbConTxt">
							<!-- userInfo -->
								<c:choose>
									<c:when test="${not empty petLogBase.followTagNm and session.mbrNo ne petLogBase.mbrNo}">
										<div class="userInfo ${petLogBase.pstNm ne null and petLogBase.pstNm ne '' ? 't2' : ''} tagon">
											<div class="pic" onclick="location.href='/log/indexPetLogTagList?tag=${petLogBase.followTagNm}'">
									</c:when>
									<c:otherwise>
										<div class="userInfo ${petLogBase.pstNm ne null and petLogBase.pstNm ne '' ? 't2' : ''}">
											<div class="pic" onclick="javascript:goMyPetLog('${petLogBase.petLogUrl}','${petLogBase.mbrNo}',event);">
									</c:otherwise>
								</c:choose>							
								<c:choose>
									<c:when test="${petLogBase.prflImg ne null and petLogBase.prflImg ne ''}">
										<img src="${frame:optImagePath(petLogBase.prflImg, frontConstants.IMG_OPT_QRY_786)}" alt="dog">
									</c:when>
									<c:otherwise>
										<img src="../../_images/common/icon-img-profile-default-m@2x.png" alt="dog">
									</c:otherwise>
								</c:choose>
								</div>
								<div class="con" id="pCon">
									<div class="txt">
									<c:if test="${not empty petLogBase.followTagNm and session.mbrNo ne petLogBase.mbrNo}">
										<a href="/log/indexPetLogTagList?tag=${petLogBase.followTagNm}" class="tag" data-orgin-tag="${petLogBase.followTagNm }">#${petLogBase.followTagNm}</a>
									</c:if>							
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
														<li><a class="bt"
															href="javascript:updatePetLog('${petLogBase.petLogNo}');"><b
																class="t">수정</b></a></li>
														<li><a class="bt"
															href="javascript:deletePetLog('${petLogBase.petLogNo}');"><b
																class="t">삭제</b></a></li>
													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when
																test="${petLogBase.rptpYn eq null or petLogBase.rptpYn eq 'N'}">
																<li><a class="bt"
																	href="javascript:layerPetLogReport('${petLogBase.petLogNo}','', '${recommendPage}','${petLogBase.rvwYn}');"
																	id="btRptp${recommendPage}_${petLogBase.petLogNo}"><b class="t">신고</b></a></li>
															</c:when>
															<c:otherwise>
																<c:set var="toastMsg" value="${petLogBase.rvwYn eq 'Y' ? '이미 신고한 후기에요':'이미 신고한 게시물이에요'}" />
																<li><a class="bt"
																	href="javascript:ui.toast('${toastMsg}',{ bot:70 });"
																	id="btRptp${recommendPage}_${petLogBase.petLogNo}">신고</a></li>
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
							<!-- // userInfo -->
							<!-- content txt -->
					<c:if test="${petLogBase.dscrt ne null and petLogBase.dscrt ne ''}">
							<div class="lcbConTxt_content">${petLogBase.dscrt}</div>
					</c:if>
							<!-- // content txt -->
						</div>
						<!-- // user content -->
</c:if>						
						<!-- menu bar -->
						<div class="lcbmenuBar">
							<div class="inner">
								<ul class="bar-btn-area">
									<li id="likeBtn${recommendPage}_${petLogBase.petLogNo}"><c:choose>
											<c:when
												test="${petLogBase.likeYn ne null and petLogBase.likeYn eq 'Y'}">
												<button class="logBtnBasic btn-like on"
													onclick="savePetLogInterest('${petLogBase.petLogNo}', '10', 'D', '${recommendPage}');">${petLogBase.likeCnt}</button>
											</c:when>
											<c:otherwise>
												<button class="logBtnBasic btn-like"
													onclick="savePetLogInterest('${petLogBase.petLogNo}', '10', 'I', '${recommendPage}');">${petLogBase.likeCnt}</button>
											</c:otherwise>
										</c:choose></li>
									<li>
										<button class="logBtnBasic btn-comment"
											onClick="viewReply('${petLogBase.petLogNo}','${recommendPage}', this);"
											id="replyCnt${recommendPage}_${petLogBase.petLogNo}">${petLogBase.replyCnt}</button>
									</li>
									<li>
										<button class="logBtnBasic btn-share"
											data-message="링크가 복사되었어요"
											data-title="${petLogBase.nickNm}" title="COPY URL"
											onclick="sharePetLog('${petLogBase.petLogNo}', this.id, 'P');"
											id="share${recommendPage}_${petLogBase.petLogNo}"
											data-clipboard-text="${petLogBase.srtPath}">
											<span>공유</span>
										</button>
									</li>
									<c:if test="${empty session.bizNo}">
										<li class="ml20" id="bookBtn${recommendPage}_${petLogBase.petLogNo}">
											<c:choose>
												<c:when test="${petLogBase.bookmarkYn ne null and petLogBase.bookmarkYn eq 'Y'}">
													<button class="logBtnBasic btn-bookmark on" onclick="savePetLogInterest('${petLogBase.petLogNo}', '20', 'D', '${recommendPage}');">
														<span>북마크</span>
													</button>
												</c:when>
												<c:otherwise>
													<button class="logBtnBasic btn-bookmark" onclick="savePetLogInterest('${petLogBase.petLogNo}', '20', 'I', '${recommendPage}');">
														<span>북마크</span>
													</button>
												</c:otherwise>
											</c:choose>
										</li>
									</c:if>
								</ul>
								<c:if test="${petLogBase.goodsRltCnt > 0}">
									<div class="log_connectTingWrap">
										<buttron class="tvConnectedTing" onclick="$(this).next().trigger('click')">연관상품</buttron>
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
						<div class="contxtWrap" name="contxtWrap${so.recommendPage }">
							<div class="lcbConTxt_content">${petLogBase.dscrt}</div>
							<!-- more btn -->
							<button class="btn_logMain_more onWeb_b">더보기</button>
							<!-- // more btn -->
						</div>
					</c:if>
							<!-- // content txt -->
</c:if>	
						<!-- 댓글 -->
						<div class="commentBoxAp logcommentBox pop1"
							id="pop${recommendPage}_${petLogBase.petLogNo}"></div>
						<!-- //댓글 -->
					</div>				
					</section>
					</div>
</c:forEach>
<c:choose>
	<c:when test="${so.recommendPage == 1 and fn:length(likePetLogList) > 0}">
		<section class="logLikePet" id ="likePetLogList">
			<div class="logTitle_area">
				<a href="javascript:goLikePetLogList(null , ${so.recommendPage });" class="logTitle arr">좋아할만한 <spring:message code='front.web.view.new.menu.log'/> </a>  <!-- APET-1250 210728 kjh02  -->
			</div>
			<div class="slideType52">
				<div class="swiper-container">
					<div class="swiper-pagination"></div>
					<ul class="swiper-wrapper slide">
						<c:forEach items="${likePetLogList}" var="petLogBase" varStatus="idx">	
							<c:choose>
								<c:when test = "${view.deviceGb ne frontConstants.DEVICE_GB_10}">
									<c:if test = "${(idx.index < '6')}"> 
										<li class="swiper-slide">
											<a href="javascript:goLikePetLogList(${idx.index} ,${so.recommendPage }, ${petLogBase.petLogNo });" class="petLogCardBox">
												<c:if test="${petLogBase.rate ne null and petLogBase.rate ne '' and petLogBase.rate > 50 }">
													<p class="aiProbabilityBar" style ="z-index:1;">
														<span>${petLogBase.rate}%</span>일치
													</p>
												</c:if>
												<c:choose>
													<c:when test="${petLogBase.vdPath ne null and petLogBase.vdPath ne ''}">
														<!-- <span class="logIcon_pic i01" style="z-index:1;"></span> -->
														<div class="vthumbs" video_id="${petLogBase.vdPath}" type="video_thumb" uid="${petLogBase.mbrNo}|${session.mbrNo}" data-enChk="${petLogBase.encCpltYn }"></div>
													</c:when>
													<c:otherwise>
														<img src="${frame:optImagePath(petLogBase.imgPath1, frontConstants.IMG_OPT_QRY_773)}" alt="" />
													</c:otherwise>
												</c:choose>
												<div class="log_userInfoBar" id="likePetLogUserInfo" onclick="javascript:goMyPetLog('${petLogBase.petLogUrl}','${petLogBase.mbrNo}',event);">
													<c:choose>
														<c:when test="${petLogBase.prflImg ne null and petLogBase.prflImg ne ''}">
															<div class="pic">
																<img src="${frame:optImagePath(petLogBase.prflImg, frontConstants.IMG_OPT_QRY_786)}" alt="dog">
															</div>
														</c:when>
														<c:otherwise>
															<div class="pic">
																<img src="../../_images/common/icon-img-profile-default-m@2x.png" alt="dog">
															</div>
														</c:otherwise>
													</c:choose>
													<p>${petLogBase.nickNm}</p>
												</div>
											</a>
										</li>
									</c:if>
								</c:when>
								<c:otherwise>
									<li class="swiper-slide">
											<a href="javascript:goLikePetLogList(${idx.index} , ${so.recommendPage } ,${petLogBase.petLogNo } );" class="petLogCardBox">
												<c:if test="${petLogBase.rate ne null and petLogBase.rate ne '' and petLogBase.rate > 50 }">
													<p class="aiProbabilityBar" style ="z-index:1;">
														<span>${petLogBase.rate}%</span>일치
													</p>
												</c:if>
												<c:choose>
													<c:when test="${petLogBase.vdPath ne null and petLogBase.vdPath ne ''}">
														<div class="vthumbs" video_id="${petLogBase.vdPath}" type="video_thumb" uid="${petLogBase.mbrNo}|${session.mbrNo}" data-enChk="${petLogBase.encCpltYn }"></div>
													</c:when>
													<c:otherwise>
														<img src="${frame:optImagePath(petLogBase.imgPath1, frontConstants.IMG_OPT_QRY_773)}" alt="" />
													</c:otherwise>
												</c:choose>
												<div class="log_userInfoBar" id="likePetLogUserInfo" onclick="javascript:goMyPetLog('${petLogBase.petLogUrl}','${petLogBase.mbrNo}',event);">
													<c:choose>
														<c:when test="${petLogBase.prflImg ne null and petLogBase.prflImg ne ''}">
															<div class="pic">
																<img src="${frame:optImagePath(petLogBase.prflImg, frontConstants.IMG_OPT_QRY_786)}" alt="dog">
															</div>
														</c:when>
														<c:otherwise>
															<div class="pic">
																<img src="../../_images/common/icon-img-profile-default-m@2x.png" alt="dog">
															</div>
														</c:otherwise>
													</c:choose>
													<p>${petLogBase.nickNm}</p>
												</div>
											</a>
										</li>
								</c:otherwise>	
							</c:choose> 
						</c:forEach>
						<c:if test ="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
							<li class="swiper-slide more">
								<a href="javascript:goLikePetLogList(null , ${so.recommendPage });" class="petLogCardBox">더보기</a>
							</li>
						</c:if>
					</ul>
				</div>
				<div class="remote-area t1">
					<button class="swiper-button-next" type="button"></button>
					<button class="swiper-button-prev" type="button"></button>
				</div>
			</div>
		</section>
		<div class="banner-wrap logBanner">
			<div class="uibanners">
				<div class="banner_slide">
					<div class="swiper-container slide">
						<ul class="swiper-wrapper list">
							<c:forEach var="bannerList" items="${likePetLogBannerList}">
								<li class="swiper-slide">
									<c:choose>
										<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_30 }">
											<c:if test="${fn:indexOf(bannerList.bnrLinkUrl, '/tv/series/indexTvDetail') == -1}">
												<c:if test="${fn:indexOf(bannerList.bnrLinkUrl, '/event/detail') == -1}">
													<a href="${bannerList.bnrLinkUrl }" class="box">
														<img class="pc" src="${frame:optImagePath(bannerList.bnrImgPath, frontConstants.IMG_OPT_QRY_767)}" alt="배너">
														<img class="mo" src="${frame:optImagePath(bannerList.bnrMobileImgPath, frontConstants.IMG_OPT_QRY_742)}" alt="배너">
													</a>
												</c:if>
												<c:if test="${fn:indexOf(bannerList.bnrLinkUrl, '/event/detail') > -1}">
													<a href="${bannerList.bnrLinkUrl }&returnUrl=${requestScope['javax.servlet.forward.servlet_path']}" class="box">
														<img class="pc" src="${frame:optImagePath(bannerList.bnrImgPath, frontConstants.IMG_OPT_QRY_767)}" alt="배너">
														<img class="mo" src="${frame:optImagePath(bannerList.bnrMobileImgPath, frontConstants.IMG_OPT_QRY_742)}" alt="배너">
													</a>
												</c:if>
                              				</c:if>
                              				<c:if test="${fn:indexOf(bannerList.bnrLinkUrl, '/tv/series/indexTvDetail') > -1}">
                              					<a href="javascript:goUrl('onNewPage', 'TV', '${bannerList.bnrLinkUrl }')" class="box">
													<img class="pc" src="${frame:optImagePath(bannerList.bnrImgPath, frontConstants.IMG_OPT_QRY_767)}" alt="배너">
													<img class="mo" src="${frame:optImagePath(bannerList.bnrMobileImgPath, frontConstants.IMG_OPT_QRY_742)}" alt="배너">
												</a>
                              				</c:if>
										</c:when>
										<c:otherwise>
											<c:if test="${fn:indexOf(bannerList.bnrLinkUrl, '/event/detail') == -1}">
												<a href="${bannerList.bnrLinkUrl }" class="box">
													<img class="pc" src="${frame:optImagePath(bannerList.bnrImgPath, frontConstants.IMG_OPT_QRY_767)}" alt="배너">
													<img class="mo" src="${frame:optImagePath(bannerList.bnrMobileImgPath, frontConstants.IMG_OPT_QRY_742)}" alt="배너">
												</a>
											</c:if>
											<c:if test="${fn:indexOf(bannerList.bnrLinkUrl, '/event/detail') > -1}">
												<a href="${bannerList.bnrLinkUrl }&returnUrl=${requestScope['javax.servlet.forward.servlet_path']}" class="box">
													<img class="pc" src="${frame:optImagePath(bannerList.bnrImgPath, frontConstants.IMG_OPT_QRY_767)}" alt="배너">
													<img class="mo" src="${frame:optImagePath(bannerList.bnrMobileImgPath, frontConstants.IMG_OPT_QRY_742)}" alt="배너">
												</a>
											</c:if>
										</c:otherwise>
									</c:choose>
								</li>
							</c:forEach>
						</ul>
						<div class="swiper-pagination">
						</div>
						<div class="sld-nav">
							<button type="button" class="bt prev" tabindex="0" role="button" aria-label="Previous slide">이전</button>
							<button type="button" class="bt next" tabindex="0" role="button" aria-label="Next slide">다음</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</c:when>
	<c:when test ="${so.recommendPage == 3 and fn:length(petLogTagList) > 0}">
		<section class="logLikePet p1" id="popularTagList">
			<div class="logTitle_area">
				<div class="logTitle">인기 #태그</div>
			</div>
			<!-- slider -->
			<div class="slideType5 tab">
				<div class="swiper-container">
					<div class="swiper-pagination"></div>
					<ul class="swiper-wrapper slide">
						<c:choose>
							<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
								<c:forEach items="${petLogTagList}" var="petLogBase" varStatus="idx">
									<li class="swiper-slide">
										<a href="javascript:;" onclick="goPetLogTagList('${petLogBase.tagNm}');" class="petLogCardBox"> 
											<span class="tag">#<c:out value='${petLogBase.tagNm}' /></span> 
											<c:choose>
												<c:when test="${petLogBase.vdPath ne null and petLogBase.vdPath ne ''}">
													<!-- <span class="logIcon_pic i01" style="z-index:1;"></span> -->
													<div class="vthumbs" video_id="${petLogBase.vdPath}" type="video_thumb" uid="${petLogBase.mbrNo}|${session.mbrNo}" data-enChk="${petLogBase.encCpltYn }"></div>
												</c:when>
												<c:otherwise>
													<img src="${frame:optImagePath(petLogBase.imgPath1, frontConstants.IMG_OPT_QRY_772)}" alt="" />
												</c:otherwise>
											</c:choose>
									</a></li>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<li class="swiper-slide">
								<c:forEach items="${petLogTagList}" var="petLogBase" varStatus="idx">
										<div class="tag_area">
											<a href="javascript:;" onclick="goPetLogTagList('${petLogBase.tagNm}');" class="petLogCardBox"> 
												<span class="tag">#<c:out value='${petLogBase.tagNm}' /></span> 
												<c:choose>
													<c:when test="${petLogBase.vdPath ne null and petLogBase.vdPath ne ''}">
														<div class="vthumbs" video_id="${petLogBase.vdPath}" type="video_thumb" uid="${petLogBase.mbrNo}|${session.mbrNo}" data-enChk="${petLogBase.encCpltYn }"></div>
													</c:when>
													<c:otherwise>
														<img src="${frame:optImagePath(petLogBase.imgPath1, frontConstants.IMG_OPT_QRY_773)}" alt="img01" />
													</c:otherwise>
												</c:choose>
											</a>
										</div>
									</c:forEach></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
				<div class="remote-area t1">
					<button class="swiper-button-next" type="button"></button>
					<button class="swiper-button-prev" type="button"></button>
				</div>
			</div>
		</section>
		<div class="banner-wrap logBanner_last">
			<div class="uibanners">
				<div class="banner_slide">
					<div class="swiper-container slide">
						<ul class="swiper-wrapper list">
							<c:forEach var="bannerList" items="${popTagBannerList}">
								<li class="swiper-slide">
									<c:choose>
										<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_30 }">
											<c:if test="${fn:indexOf(bannerList.bnrLinkUrl, '/tv/series/indexTvDetail') == -1}">
                              					<a href="${bannerList.bnrLinkUrl }" class="box">
													<img class="pc" src="${frame:optImagePath(bannerList.bnrImgPath, frontConstants.IMG_OPT_QRY_767)}" alt="배너">
													<img class="mo" src="${frame:optImagePath(bannerList.bnrMobileImgPath, frontConstants.IMG_OPT_QRY_742)}" alt="배너">
												</a>
                              				</c:if>
                              				<c:if test="${fn:indexOf(bannerList.bnrLinkUrl, '/tv/series/indexTvDetail') > -1}">
                              					<a href="javascript:goUrl('onNewPage', 'TV', '${bannerList.bnrLinkUrl }')" class="box">
													<img class="pc" src="${frame:optImagePath(bannerList.bnrImgPath, frontConstants.IMG_OPT_QRY_767)}" alt="배너">
													<img class="mo" src="${frame:optImagePath(bannerList.bnrMobileImgPath, frontConstants.IMG_OPT_QRY_742)}" alt="배너">
												</a>
                              				</c:if>
										</c:when>
										<c:otherwise>
											<a href="${bannerList.bnrLinkUrl }" class="box">
												<img class="pc" src="${frame:optImagePath(bannerList.bnrImgPath, frontConstants.IMG_OPT_QRY_767)}" alt="배너">
												<img class="mo" src="${frame:optImagePath(bannerList.bnrMobileImgPath, frontConstants.IMG_OPT_QRY_742)}" alt="배너">
											</a>
										</c:otherwise>
									</c:choose>
								</li>
							</c:forEach>
						</ul>
						<div class="swiper-pagination"></div>
						<div class="sld-nav">
							<button type="button" class="bt prev" tabindex="0" role="button" aria-label="Previous slide">이전</button>
							<button type="button" class="bt next" tabindex="0" role="button" aria-label="Next slide">다음</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</c:when>
	<c:otherwise>
		<c:if test ="${fn:length(recMbrPetLogList) > 0 }">
		<section class="logLikePet p1" name="recMemberList" data-recyn ="${so.recYn }" data-page="${so.recMemberPage }">
			<div class="logTitle_area">
				<div class="logTitle">이 친구 어때요?</div>
			</div>
			<div class="slideType52">
				<div class="swiper-container">
					<div class="swiper-pagination"></div>
					<ul class="swiper-wrapper slide">
						<c:forEach items="${recMbrPetLogList}" var="petLogBase"
							varStatus="idx">
							<c:if test="${idx.first}">
								<li class="swiper-slide none_gradient">
									<div class="probabilityCard">
										<div>
											<c:choose>
												<c:when test="${petLogBase.prflImg ne null and petLogBase.prflImg ne ''}">
													<div class="pic" onclick="goMyPetLogWithRate('${petLogBase.petLogUrl}','${petLogBase.mbrNo}','${petLogBase.rate}',event);">
														<img src="${frame:optImagePath(petLogBase.prflImg, frontConstants.IMG_OPT_QRY_786)}" alt="dog">
													</div>
												</c:when>
												<c:otherwise>
													<div class="pic" onclick="goMyPetLogWithRate('${petLogBase.petLogUrl}','${petLogBase.mbrNo}','${petLogBase.rate}',event);">
														<img src="../../_images/common/icon-img-profile-default-m@2x.png" alt="dog">
													</div>
												</c:otherwise>
											</c:choose>
											<div class="nick" onclick="goMyPetLogWithRate('${petLogBase.petLogUrl}','${petLogBase.mbrNo}','${petLogBase.rate}',event);">${petLogBase.nickNm}</div>
											<c:if test="${petLogBase.rate ne null and petLogBase.rate ne '' and petLogBase.rate > 50 }">
												<div class="probability">${petLogBase.rate}%일치</div>
											</c:if>
											<c:choose>
												<c:when
													test="${petLogBase.followYn ne null and petLogBase.followYn eq 'Y'}">
													<a href="javascript:;"
														onclick="saveFollowMapMember('${petLogBase.mbrNo}', 'D' , this);"
														class="btn b sm size_follow">팔로잉</a>
												</c:when>
												<c:otherwise>
													<a href="javascript:;"
														onclick="saveFollowMapMember('${petLogBase.mbrNo}', 'I', this);"
														class="btn a sm size_follow">팔로우</a>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</li>
							</c:if>
							<!--  2021-04-26 rshoo79 이미지/비디오 구분 퍼블적용  -->
						<c:choose>
						  <c:when test="${idx.index < '6'}">
							<c:choose>
								<c:when test="${petLogBase.vdPath ne null and petLogBase.vdPath ne ''}">
									<!-- 동영상일 경우 -->
									<li class="swiper-slide i_video">
										<a href="javascript:goMyPetLogWithRate('${petLogBase.petLogUrl}','${petLogBase.mbrNo}','${petLogBase.rate}',event);" class="petLogCardBox">
											<span class="logIcon_pic i01" style="z-index:1;"></span> 
											<div class="vthumbs" video_id="${petLogBase.vdPath}" type="video_thumb" uid="${petLogBase.mbrNo}|${session.mbrNo}" data-enChk="${petLogBase.encCpltYn }"></div>
										</a>
									</li>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test ="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
											<li class="swiper-slide <c:if test="${petLogBase.imgPath2 ne null }">i_photo</c:if>">
												<a href="javascript:goMyPetLogWithRate('${petLogBase.petLogUrl}','${petLogBase.mbrNo}','${petLogBase.rate}',event);" class="petLogCardBox"> 
													<img src="${frame:optImagePath(petLogBase.imgPath1, frontConstants.IMG_OPT_QRY_772)}" style="width: 100%;" alt="" />
												</a>
											</li>																		
										</c:when>
										<c:otherwise>
											<li class="swiper-slide <c:if test="${petLogBase.imgPath2 ne null }">i_photo</c:if>">
												<a href="javascript:goMyPetLogWithRate('${petLogBase.petLogUrl}','${petLogBase.mbrNo}','${petLogBase.rate}',event);" class="petLogCardBox"> 
													<img src="${frame:optImagePath(petLogBase.imgPath1, frontConstants.IMG_OPT_QRY_773)}" style="width: 100%;" alt="" />
												</a>
											</li>	
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						   </c:when>
						</c:choose>
						</c:forEach>
						<c:if test ="${view.deviceGb ne frontConstants.DEVICE_GB_10 and (fn:length(recMbrPetLogList) > '5')}">
							<li class="swiper-slide more">
								<a href="javascript:goMyPetLogWithRate('${recMbrPetLogList[0].petLogUrl}','${recMbrPetLogList[0].mbrNo}','${recMbrPetLogList[0].rate}',event)" class="petLogCardBox">더보기</a>
							</li>
						</c:if>
					</ul>
				</div>
				<div class="remote-area t1">
					<button class="swiper-button-next" type="button"></button>
					<button class="swiper-button-prev" type="button"></button>
				</div>
			</div>
		</section>
		<div class="banner-wrap logBanner">
			<div class="uibanners">
				<div class="banner_slide">
					<div class="swiper-container slide">
						<ul class="swiper-wrapper list">
							<c:forEach var="bannerList" items="${recMemberBannerList}">
								<li class="swiper-slide">
									<c:choose>
										<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_30 }">
											<c:if test="${fn:indexOf(bannerList.bnrLinkUrl, '/tv/series/indexTvDetail') == -1}">
                              					<a href="${bannerList.bnrLinkUrl }" class="box">
													<img class="pc" src="${frame:optImagePath(bannerList.bnrImgPath, frontConstants.IMG_OPT_QRY_767)}" alt="배너">
													<img class="mo" src="${frame:optImagePath(bannerList.bnrMobileImgPath, frontConstants.IMG_OPT_QRY_742)}" alt="배너">
												</a>
                              				</c:if>
                              				<c:if test="${fn:indexOf(bannerList.bnrLinkUrl, '/tv/series/indexTvDetail') > -1}">
                              					<a href="javascript:goUrl('onNewPage', 'TV', '${bannerList.bnrLinkUrl }')" class="box">
													<img class="pc" src="${frame:optImagePath(bannerList.bnrImgPath, frontConstants.IMG_OPT_QRY_767)}" alt="배너">
													<img class="mo" src="${frame:optImagePath(bannerList.bnrMobileImgPath, frontConstants.IMG_OPT_QRY_742)}" alt="배너">
												</a>
                              				</c:if>
										</c:when>
										<c:otherwise>
											<a href="${bannerList.bnrLinkUrl }" class="box">
												<img class="pc" src="${frame:optImagePath(bannerList.bnrImgPath, frontConstants.IMG_OPT_QRY_767)}" alt="배너">
												<img class="mo" src="${frame:optImagePath(bannerList.bnrMobileImgPath, frontConstants.IMG_OPT_QRY_742)}" alt="배너">
											</a>
										</c:otherwise>
									</c:choose>
								</li>
							</c:forEach>
						</ul>
						<div class="swiper-pagination"></div>
						<div class="sld-nav">
							<button type="button" class="bt prev" tabindex="0" role="button" aria-label="Previous slide">이전</button>
							<button type="button" class="bt next" tabindex="0" role="button" aria-label="Next slide">다음</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		</c:if>
	</c:otherwise>
</c:choose>
</div>
</c:if>				
