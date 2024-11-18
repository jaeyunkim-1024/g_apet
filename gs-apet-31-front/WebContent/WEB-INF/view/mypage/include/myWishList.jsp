<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<tiles:insertDefinition name="mypage">
	<tiles:putAttribute name="script.inline">
	<script src="<spring:eval expression="@bizConfig['vod.player.api.url']" />/thumb_api/v1.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				$("#header_pc").removeClass("mode0");
				//$("#header_pc").addClass("mode16");
				//$("#header_pc").addClass("noneAc");
				//$("#header_pc").attr("data-header", "set16");
				$(".mo-heade-tit .tit").html("<spring:message code='front.web.view.include.title.mywishlists.page' />");
				$(".mo-header-backNtn").removeAttr("onclick");
				
				if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10}"){
					$("footer").remove()
				}
			
				$(".mo-header-backNtn").click(function(){
					if("${callParam}" != ""){
						//App & 펫TV 영상상세 화면에서 호출일때만 callParam값이 있다.
						var callParam = "${callParam}";
						var params = callParam.split(".");
						var url = "";
						if(params.length == 3){
							url = "${view.stDomain}/tv/series/indexTvDetail?vdId="+params[0]+"&sortCd=&listGb="+params[1]+"-"+params[2];
						}else{
							url = "${view.stDomain}/tv/series/indexTvDetail?vdId="+params[0]+"&sortCd="+params[1]+"&listGb="+params[2]+"-"+params[3];
						}
						
						// 데이터 세팅
						toNativeData.func = "onNewPage";
						toNativeData.type = "TV";
						toNativeData.url = url;
						// 호출
						toNative(toNativeData);
					}
					
					storageHist.goBack();
				});
				
				
				// TODO 임시처리 변경 필요.
				/* if("${seoSvcGbCd}" === "tv"){
					$(".petTabContent .uiTab li").eq(0).click();
				}else if("${seoSvcGbCd}" === "log"){
					$(".petTabContent .uiTab li").eq(1).click();
				}else if("${seoSvcGbCd}" === "shop"){
					$(".petTabContent .uiTab li").eq(2).click();
				} */
				
				/*$(".petTabContent").bind("tabMoveEvent",function(){
					console.log(71803478120374801234)
				}).bind("tabEndEvent",function(){
					console.log("ekekekekekek")
				})*/
			});
			
			function userActionLog(vdId, action){	
				var mbrNo = "${session.mbrNo}";
				if (mbrNo != "${frontConstants.NO_MEMBER_NO}") {
					$.ajax({
						type: 'POST'
						, url : "/common/sendSearchEngineEvent"
						, dataType: 'json'
						, data : {
							"logGb" : "ACTION"
							, "mbr_no" : mbrNo
							, "section" : "tv" 
							, "content_id" : vdId
							, "action" : action
							, "url" : document.location.href
							, "targetUrl" : document.location.href
							, "litd" : ""
							, "lttd" : ""
							, "prclAddr" : ""
							, "roadAddr" : ""
							, "postNoNew" : ""
							, "timestamp" : ""
						}
					});
				}
			}
			
			$(window).on("load", function(){
				if("${seoSvcGbCd}" === "tv"){
					$(".petTabContent .uiTab li").eq(0).click();
				}else if("${seoSvcGbCd}" === "log"){
					$(".petTabContent .uiTab li").eq(1).click();
				}else if("${seoSvcGbCd}" === "shop"){
					$(".petTabContent .uiTab li").eq(2).click();
				}
			});
			
			function onThumbAPIReady() {
			    thumbApi.ready();
			}
			
			//찜 해제 컨텐츠
			function favoritesBtn(obj, mbrNo, vdId) {
				petTvLikeDibs(obj, vdId, mbrNo, "20");
				
				$(obj).closest('li').remove();
				//var vodCnt = $(".uiTab_content li.active").eq(0).find('.favorites').length;
				var vodCnt = $("#boxTvPoint ul li").length;
				$(".both-txt").eq(0).text(vodCnt);
				
				if($("#boxTvPoint ul li").length <= 0) {
					/*$(".uiTab_content ul").removeAttr('style');
					
					var html = '';
					html += '<div class="noneBoxPoint" id="noneBoxTvPoint">'
					//html += 	'<section class="no_data i7 auto_h">'
					html += 	'<section class="no_data i7" style="height:calc(100vh - 110px);">'
					html += 		'<div class="inr">'
					html += 			'<div class="msg">'
					html += 				'<spring:message code='front.web.view.include.content.no.add.videos.mywishlists' /><br />'
					html += 				'<spring:message code='front.web.view.include.content.together.pets' /><strong><spring:message code='front.web.view.common.pettv.title' /></strong><spring:message code='front.web.view.include.content.watch.please' />'
					html += 			'</div>'
					html += 			'<div class="uimoreview">'
					html += 				'<a href="/tv/home" class="bt more" data-url="/tv/home"><spring:message code='front.web.view.include.go.to.pettv.btn' /></a>'
					html += 			'</div>'
					html += 		'</div>'
					html += 	'</section>'
					html += '</div>'
					
					//$(".uiTab_content ul li").eq(0).append(html);
					$("#tab_tv").html(html);
					
					ui.nodata_set.init();*/
					
					$(".uiTab_content ul").css("height", "");
					$("#noneBoxTvPoint").css("display", "block");
					$("#boxTvPoint").css("display", "none");
				}
			}
			     
			// 브랜드 더보기 7개 이상일때 더보기 정의 없음 TODO
			function fnBrandMore(){
				var firstDefaultCnt = 10;
				if(${view.deviceGb ne frontConstants.DEVICE_GB_10}){
					firstDefaultCnt = 6;	
				}
				var page = $("#brandPage .brand a").length < firstDefaultCnt + 1 ? 1 : parseInt($("#brandPage").data('page')) + 1; 
				var options = {
					url : "/mypage/interest/pageMemberInterestBrand"
					, data : { page : page , returnUrl : document.URL+"?searchQuery="}
					, done : function(data) {
						
						var brandList = data.wishListBrand;
						console.log(brandList)
						if(brandList.length > 0) {
							var brandHtml = '';
							$(brandList).each(function(i,n){
								brandHtml += '<a href="/brand/indexBrandDetail?bndNo='+brandList[i].bndNo+'" data-content="'+brandList[i].bndNo+'" data-url="/brand/indexBrandDetail?bndNo='+brandList[i].bndNo+'" class="btn">'+ brandList[i].bndNmKo.substring(0, 8) +'</a>';
							})
							
							if(parseInt(data.brandSO.page) < 2){
								$("#brandPage .brand").html(brandHtml);
							}else{
								$("#brandPage .brand").append(brandHtml);	
							}
							
							$("#brandPage").data('page', data.brandSO.page);
							
							if(data.brandSO.totalPageCount === data.brandSO.page){
								$("#brandPage .uimoreload").hide();
							}
						}
					}
				};
				ajax.call(options);
			}
			
			//APP 영상 상세 이동 URL 페이지 호출
			function goUrl(funcNm, type, url) {
				toNativeData.func = funcNm;
				toNativeData.type = type;
				toNativeData.url = url;
					
				//console.log(toNativeData.func);
				//console.log(toNativeData.type);
				//console.log(toNativeData.url);
					
				toNative(toNativeData);
			}

			//탭 선택시 해당탭에 해당하는 url로 replace
			function fncClickReplaceUrl(val){
				if(val == "TV"){
					history.replaceState("", "", "/mypage/tv/myWishList");
					storageHist.replaceHist("/mypage/tv/myWishList");
				}else if(val == "LOG"){
					history.replaceState("", "", "/mypage/log/myWishList");
					storageHist.replaceHist("/mypage/log/myWishList");
				}else if(val == "SHOP"){
					history.replaceState("", "", "/mypage/shop/myWishList");
					storageHist.replaceHist("/mypage/shop/myWishList");
				}
			}
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<main class="container lnb page my" id="container">
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<!-- PC 타이틀 모바일에서 제거  -->
					<div class="pc-tit">
						<h2><spring:message code='front.web.view.include.title.mywishlists.page' /></h2>
					</div>
					<!-- // PC 타이틀 모바일에서 제거  -->
					<!-- tab -->
					<section class="sect petTabContent mode_fixed leftTab hmode_auto myZzim">
						<!-- tab header -->
						<ul class="uiTab a line t2">
							<li class="${not empty seoSvcGbCd && seoSvcGbCd eq 'tv' ? 'active' : ''}">
								<a class="bt" href="javascript:fncClickReplaceUrl('TV');">
									<div>
										<spring:message code='front.web.view.include.title.tv' />
										<div class="both-txt">
											${fn:length(myWishListTv)}
										</div>
									</div>
								</a>
							</li>
							<li class="${not empty seoSvcGbCd && seoSvcGbCd eq 'log' ? 'active' : ''}">
								<a class="bt" href="javascript:fncClickReplaceUrl('LOG');">
									<div>
										<spring:message code='front.web.view.include.title.log' />
										<div class="both-txt">
											${fn:length(myWishListLog)}
										</div>
									</div>
								</a>
							</li>
							<li class="${not empty seoSvcGbCd && seoSvcGbCd eq 'shop' ? 'active' : ''}">
								<a class="bt" href="javascript:fncClickReplaceUrl('SHOP');">
									<div>
										<spring:message code='front.web.view.new.menu.store' />
										<div class="both-txt">
<%-- 											${fn:length(myWishListGoods) + fn:length(myWishListBrand)} --%>
											${fn:length(myWishListGoods)}
										</div>
									</div>
								</a>
							</li>
						</ul>
						<!-- // tab header -->
						<!-- tab content -->
						<div class="uiTab_content">
							<ul>
								<li class="${not empty seoSvcGbCd && seoSvcGbCd eq 'tv' ? 'active' : ''}" id="tab_tv">
									<div class="noneBoxPoint" id="noneBoxTvPoint" <c:if test="${not empty myWishListTv && fn:length(myWishListTv) > 0 }">style="display:none;"</c:if>>
										<%--<section class="no_data i7 auto_h">--%>
										<section class="no_data i7" style="height:calc(100vh - 110px);">
											<div class="inr">
												<div class="msg">
												<spring:message code='front.web.view.include.content.no.add.videos.mywishlists' /><br />
												<spring:message code='front.web.view.include.content.together.pets' /><strong><spring:message code='front.web.view.new.menu.tv' /></strong><spring:message code='front.web.view.include.content.watch.please' /> <!-- APET-1250 210728 kjh02  -->
												</div>
												<div class="uimoreview">
													<a href="/tv/home" class="bt more" data-url="/tv/home"><spring:message code='front.web.view.include.go.to.pettv.btn' /></a>  <!-- APET-1250 210728 kjh02  -->
												</div>
											</div>
										</section>
									</div>
									
									<div class="thumbnail-list movie" id="boxTvPoint" <c:if test="${empty myWishListTv || fn:length(myWishListTv) == 0 }">style="display:none;"</c:if>>
										<ul>
										<c:forEach var="myWishListTv" items="${myWishListTv }">
											<li>
												<div class="item">
													<c:choose>
														<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
															<c:if test="${myWishListTv.vdGbCd eq frontConstants.VD_GB_10 }">
																<span class="favorites k0423" onclick="favoritesBtn(this, '${myWishListTv.mbrNo}', '${myWishListTv.vdId}');"><spring:message code='front.web.view.common.favorites' /></span>
																<a href="/tv/school/indexTvDetail?vdId=${myWishListTv.vdId}" class="pic">		
																	<!-- 자동생성썸네일 이미지 옵티마이저 적용 -->															
																	<c:if test="${myWishListTv.thumAutoYn eq 'Y' }">
																		<img class="img" src="${frame:optImagePathSgr(myWishListTv.thumPath, frontConstants.IMG_OPT_QRY_787)}" alt="이미지" data-content="${myWishListTv.vdId}" data-url="/tv/school/indexTvDetail?vdId=${myWishListTv.vdId}">
																	</c:if>
																	<c:if test="${myWishListTv.thumAutoYn ne 'Y' }">
																		<img class="img" src="${fn:indexOf(myWishListTv.thumPath, 'cdn.ntruss.com') > -1 ? myWishListTv.thumPath : frame:optImagePath(myWishListTv.thumPath, frontConstants.IMG_OPT_QRY_787)}" alt="이미지" data-content="${myWishListTv.vdId}" data-url="/tv/school/indexTvDetail?vdId=${myWishListTv.vdId}">
																	</c:if>																
																</a>
															</c:if>
															<c:if test="${myWishListTv.vdGbCd eq frontConstants.VD_GB_20 }">
																<span class="favorites k0423" onclick="favoritesBtn(this, '${myWishListTv.mbrNo}', '${myWishListTv.vdId}');"><spring:message code='front.web.view.common.favorites' /></span>
																<a href="/tv/series/indexTvDetail?vdId=${myWishListTv.vdId}&sortCd=&listGb=WISH" class="pic"><img class="img" src="${fn:indexOf(myWishListTv.thumPath, 'cdn.ntruss.com') > -1 ? myWishListTv.thumPath : frame:optImagePath(myWishListTv.thumPath, frontConstants.IMG_OPT_QRY_780)}" alt="이미지" data-content="${myWishListTv.vdId}" data-url="/tv/series/indexTvDetail?vdId=${myWishListTv.vdId}&sortCd=&listGb=WISH"></a>
															</c:if>
														</c:when>
														<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_20}">
															<c:if test="${myWishListTv.vdGbCd eq frontConstants.VD_GB_10 }">
																<span class="favorites k0423" onclick="favoritesBtn(this, '${myWishListTv.mbrNo}', '${myWishListTv.vdId}');"><spring:message code='front.web.view.common.favorites' /></span>
																<a href="/tv/school/indexTvDetail?vdId=${myWishListTv.vdId}" class="pic">
																	<!-- 자동생성썸네일 이미지 옵티마이저 적용 -->
																	<c:if test="${myWishListTv.thumAutoYn eq 'Y' }">
																		<img class="img" src="${frame:optImagePathSgr(myWishListTv.thumPath, frontConstants.IMG_OPT_QRY_782)}" alt="이미지" data-content="${myWishListTv.vdId}" data-url="/tv/school/indexTvDetail?vdId=${myWishListTv.vdId}">
																	</c:if>
																	<c:if test="${myWishListTv.thumAutoYn ne 'Y' }">
																		<img class="img" src="${fn:indexOf(myWishListTv.thumPath, 'cdn.ntruss.com') > -1 ? myWishListTv.thumPath : frame:optImagePath(myWishListTv.thumPath, frontConstants.IMG_OPT_QRY_782)}" alt="이미지" data-content="${myWishListTv.vdId}" data-url="/tv/school/indexTvDetail?vdId=${myWishListTv.vdId}">
																	</c:if>																	
																</a>
															</c:if>
															<c:if test="${myWishListTv.vdGbCd eq frontConstants.VD_GB_20 }">
																<span class="favorites k0423" onclick="favoritesBtn(this, '${myWishListTv.mbrNo}', '${myWishListTv.vdId}');"><spring:message code='front.web.view.common.favorites' /></span>
																<a href="/tv/series/indexTvDetail?vdId=${myWishListTv.vdId}&sortCd=&listGb=WISH" class="pic"><img class="img" src="${fn:indexOf(myWishListTv.thumPath, 'cdn.ntruss.com') > -1 ? myWishListTv.thumPath : frame:optImagePath(myWishListTv.thumPath, frontConstants.IMG_OPT_QRY_781)}" alt="이미지" data-content="${myWishListTv.vdId}" data-url="/tv/series/indexTvDetail?vdId=${myWishListTv.vdId}&sortCd=&listGb=WISH"></a>
															</c:if>
														</c:when>
														<c:otherwise>
															<c:if test="${myWishListTv.vdGbCd eq frontConstants.VD_GB_10 }">																
																<span class="favorites k0423" onclick="favoritesBtn(this, '${myWishListTv.mbrNo}', '${myWishListTv.vdId}');"><spring:message code='front.web.view.common.favorites' /></span>
																<a href="/tv/school/indexTvDetail?vdId=${myWishListTv.vdId}" class="pic">
																	<!-- 자동생성썸네일 이미지 옵티마이저 적용 -->
																	<c:if test="${myWishListTv.thumAutoYn eq 'Y' }">
																		<img class="img" src="${frame:optImagePathSgr(myWishListTv.thumPath, frontConstants.IMG_OPT_QRY_782)}" alt="이미지" data-content="${myWishListTv.vdId}" data-url="/tv/school/indexTvDetail?vdId=${myWishListTv.vdId}">
																	</c:if>
																	<c:if test="${myWishListTv.thumAutoYn ne 'Y' }">
																		<img class="img" src="${fn:indexOf(myWishListTv.thumPath, 'cdn.ntruss.com') > -1 ? myWishListTv.thumPath : frame:optImagePath(myWishListTv.thumPath, frontConstants.IMG_OPT_QRY_782)}" alt="이미지" data-content="${myWishListTv.vdId}" data-url="/tv/school/indexTvDetail?vdId=${myWishListTv.vdId}">
																	</c:if>
																</a>
															</c:if>
															<c:if test="${myWishListTv.vdGbCd eq frontConstants.VD_GB_20 }">
																<span class="favorites k0423" onclick="favoritesBtn(this, '${myWishListTv.mbrNo}', '${myWishListTv.vdId}');"><spring:message code='front.web.view.common.favorites' /></span>
																<a href="javascript:goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${myWishListTv.vdId}&sortCd=&listGb=WISH')" class="pic"><img class="img" src="${fn:indexOf(myWishListTv.thumPath, 'cdn.ntruss.com') > -1 ? myWishListTv.thumPath : frame:optImagePath(myWishListTv.thumPath, frontConstants.IMG_OPT_QRY_781)}" alt="이미지" data-content="${myWishListTv.vdId}" data-url="${view.stDomain}/tv/series/indexTvDetail?vdId=${myWishListTv.vdId}&sortCd=&listGb=WISH"></a>
															</c:if>
														</c:otherwise>
													</c:choose>
													<span type="button" class="time">${myWishListTv.totLnth }</span>
													<p class="progressbar" style="width:${myWishListTv.stepProgress}%;"><spring:message code='front.web.view.include.process.videos.status' /></p>
												</div>
												<div class="tit">
												<c:if test="${myWishListTv.vdGbCd eq frontConstants.VD_GB_10}">
													${myWishListTv.ctgMnm}<br>
												</c:if>
													<c:choose>
													<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10 or view.deviceGb eq frontConstants.DEVICE_GB_20}">
														<c:if test="${myWishListTv.vdGbCd eq frontConstants.VD_GB_10 }">
															<a href="/tv/school/indexTvDetail?vdId=${myWishListTv.vdId}">${myWishListTv.ttl }</a>
														</c:if>
														<c:if test="${myWishListTv.vdGbCd eq frontConstants.VD_GB_20 }">
															<a href="/tv/series/indexTvDetail?vdId=${myWishListTv.vdId}&sortCd=&listGb=WISH">${myWishListTv.ttl }</a>
														</c:if>
													</c:when>
													<c:otherwise>
														<c:if test="${myWishListTv.vdGbCd eq frontConstants.VD_GB_10 }">
															<%-- APP에서 펫스쿨 상세 기존 onNewPage 호출 ==> 페이지 호출방식으로 변경 / 펫스쿨 상세는 pc, mo, app 모두 호출방식 동일함.
															<a href="javascript:goUrl('onNewPage', 'TV', '${view.stDomain}/tv/school/indexTvDetail?vdId=${myWishListTv.vdId}')">${myWishListTv.ttl }</a>
															--%>
															
															<a href="/tv/school/indexTvDetail?vdId=${myWishListTv.vdId}">${myWishListTv.ttl }</a>
														</c:if>
														<c:if test="${myWishListTv.vdGbCd eq frontConstants.VD_GB_20 }">
															<a href="javascript:goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${myWishListTv.vdId}&sortCd=&listGb=WISH')">${myWishListTv.ttl }</a>
														</c:if>
													</c:otherwise>
													</c:choose>
												</div>
											</li>
										</c:forEach>
										</ul>
									</div>
								</li>
								<li class="${not empty seoSvcGbCd && seoSvcGbCd eq 'log' ? 'active' : ''}" id="tab_log">
									<div class="noneBoxPoint" id="noneBoxLogPoint" <c:if test="${not empty myWishListLog && fn:length(myWishListLog) > 0 }">style="display:none;"</c:if>>
										<%--<section class="no_data i7 auto_h">--%>
										<section class="no_data i7" style="height:calc(100vh - 110px);">
											<div class="inr">
												<div class="msg">
													<spring:message code='front.web.view.include.content.no.add.post.wishlists' /><br />
													<spring:message code='front.web.view.include.content.look.your.friends.daliy.life.pets' />
												</div>
												<div class="uimoreview">
													<a href="/log/home" class="bt more" data-url="/log/home"><spring:message code='front.web.view.include.go.to.petlog.btn' /></a> <!-- APET-1250 210728 kjh02  -->
												</div>
											</div>
										</section>
									</div>
									
									<div class="mylog-area" id="boxLogPoint" <c:if test="${empty myWishListLog || fn:length(myWishListLog) == 0 }">style="display:none;"</c:if>>
										<div class="logPicMetric">
											<ul>
												<c:forEach items="${myWishListLog }" var="myWishListLog">
													<li>
														<c:choose>
															<c:when test="${myWishListLog.vdPath ne null and myWishListLog.vdPath != ''}">
																<a href="/log/indexPetLogDetailView?petLogNo=${myWishListLog.petLogNo}" class="logPicBox">
																	<span class="logIcon_pic i01"></span>
																	<div class="vthumbs" video_id="${myWishListLog.vdPath}" type="video_thumb" style="height:100%" uid="${myWishListLog.mbrNo}|${session.mbrNo}"></div>
																</a>
															</c:when>
															<c:otherwise>
																<a href="/log/indexPetLogDetailView?petLogNo=${myWishListLog.petLogNo}" class="logPicBox">
																<c:if test="${myWishListLog.imgCnt > 1 }">
																	<span class="logIcon_pic i02"></span>
																</c:if>
																<img src="${fn:indexOf(myWishListLog.imgPath1, 'cdn.ntruss.com') > -1 ? myWishListLog.imgPath1 : frame:optImagePath(myWishListLog.imgPath1, frontConstants.IMG_OPT_QRY_480)}" alt="">
																<!-- <img src="../../_images/_temp/temp_logimg001.jpg" alt=""> -->
																</a>
															</c:otherwise>
														</c:choose>
													</li>
												</c:forEach>
											</ul>
										</div>
									</div>
								</li>
								<li class="${not empty seoSvcGbCd && seoSvcGbCd eq 'shop' ? 'active' : ''}" id="tab_shop">
									<div class="noneBoxPoint" id="noneBoxShopPoint" <c:if test="${(not empty myWishListBrand && fn:length(myWishListBrand) > 0) || (not empty myWishListGoods && fn:length(myWishListGoods) > 0) }">style="display:none;"</c:if>>
										<%--<section class="no_data i7 auto_h">--%>
										<section class="no_data i7" style="height:calc(100vh - 110px);">
											<div class="inr">
												<div class="msg">
													<spring:message code='front.web.view.include.content.no.add.products.wishlists' /><br>
													<spring:message code='front.web.view.include.content.look.for.petproducts' />
												</div>
												<div class="uimoreview">
													<a href="/shop/home" class="bt more" data-url="/shop/home"><spring:message code='front.web.view.common.link.go.to.petshop' /></a> <!-- APET-1250 210728 kjh02  -->
												</div>
											</div>
										</section>
									</div>
									
									<div class="mybrand-list t4" id="brandPage" data-page="${mbSO.page}" <c:if test="${empty myWishListBrand || fn:length(myWishListBrand) == 0 }">style="display:none;"</c:if>>
										<div class="brand">
											<c:forEach items="${myWishListBrand }" var="myWishListBrand">
												<a href="/brand/indexBrandDetail?bndNo=${myWishListBrand.bndNo}" data-content='${myWishListBrand.bndNo}' data-url="/brand/indexBrandDetail?bndNo=${myWishListBrand.bndNo}" class="btn">
													${fn:substring(myWishListBrand.bndNmKo, 0, 8)}
												</a>
											</c:forEach>
										</div>
										<!-- PC 일경우 10개 이상, APP,MO일경우 6개 이상 일때 더보기 노출 -->
										<c:set var="moreCount" value="${view.deviceGb eq frontConstants.DEVICE_GB_10 ? 10 : 6}" />
										<c:if test="${mbSO.totalCount > moreCount}">
											<div class="uimoreload">
												<button type="button" class="bt more"><span onclick="fnBrandMore();"><spring:message code='front.web.view.include.brand.view.more' /></span></button>
											</div>
										</c:if>
									</div>
									
									<div class="thumbnail-list" id="boxShopPoint" <c:if test="${empty myWishListGoods || fn:length(myWishListGoods) == 0 }">style="display:none;"</c:if>>
										<ul>
											<c:forEach items="${myWishListGoods }" var="goods">
												<li>
													<div class="gdset packg">
														<div class="thum">
															<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="pic">
																<img class="img" src="${frame:optImagePath( goods.imgPath, frontConstants.IMG_OPT_QRY_764)}" onerror="this.src='${view.noImgPath}'" alt="이미지">
																<c:if test="${goods.soldOutYn == 'Y'}">
																	<div class="soldouts"><em class="ts"><spring:message code='front.web.view.common.goods.saleSoldOut.title' /></em></div>
																</c:if>
															</a>
															<span class="bt zzim on" 
																data-action="interest"
																data-yn="N"
																data-goods-id="${goods.goodsId}"
																data-target="goods"
																data-content='${goods.goodsId}'
																data-delyn='Y'
																data-url="/goods/insertWish?goodsId=${goods.goodsId}"><spring:message code='front.web.view.common.favorites' /></span>
														</div>
														<div class="boxs">
															<div class="tit">
																<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="lk">${goods.goodsNm}</a>
															</div>
															<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="inf">
																<span class="prc"><em class="p"><fmt:formatNumber value="${goods.saleAmt }" type="number" pattern="#,###,###"/></em><i class="w"><spring:message code='front.web.view.common.moneyUnit.title' /></i></span>
																<c:if test="${((goods.orgSaleAmt-goods.saleAmt)/goods.orgSaleAmt * 100) >= 1 and (goods.orgSaleAmt-goods.saleAmt) != 0}">
																	<span class="pct"><em class="n"><fmt:parseNumber value="${(goods.orgSaleAmt - goods.saleAmt)/goods.orgSaleAmt * 100}" integerOnly="true"/></em><i class="w"><spring:message code='front.web.view.common.brand.persent.title' /></i></span>
																</c:if>
															</a>
														</div>
													</div>
												</li>
											</c:forEach>
										</ul>
									</div>
								</li>
							</ul>
						</div>
					</section>
					<!-- // tab -->
				</div>
			</div>
		</main>
		<!-- // tab content -->
		<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}" >
			<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
	        	<jsp:param name="floating" value="" />
	        </jsp:include>
        </c:if>
        
		
	</tiles:putAttribute>
</tiles:insertDefinition>

		<div class="layers">
			<!-- 레이어팝업 넣을 자리 -->
		</div>
