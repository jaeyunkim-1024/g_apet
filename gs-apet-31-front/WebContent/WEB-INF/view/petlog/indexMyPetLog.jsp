<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<tiles:insertDefinition name="common_my_mo">
	
	<tiles:putAttribute name="script.include" value="script.petlog"/> <!-- 지정된 스크립트 적용 -->
	<%-- 
	Tiles script.inline put
	불 필요시, 해당 영역 삭제 
	--%>
	<tiles:putAttribute name="script.inline">
<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">	
	<script>
	</script>
</c:if>	
	
	
	<script>
	var petLogPage = Number("${so.page}") == 1 ? 2 : Number("${so.page}")
	var upperScrollPage = Number("${so.page}");
	var pagingEndPage = Number("${so.totalCount}") % 12 == 0 ? (Number("${so.totalCount}")-1) / 12 : (Number("${so.totalCount}") / 12);
	var result;
	var upperResult;
	var scrollPrevent = true;
	var pageRow = ${frontConstants.PAGE_ROWS_12};
		$(function(){
			result = petLogPage >= pagingEndPage ? false : true;
			/* 스크롤 이벤트 : share 아이콘 이동 모바일만 적용  */
			scrollEvent();
			$(window).scroll(scrollEvent);
			function scrollEvent(){
				var check = ($(".mylog_area.info").css("float") == "none")?true:false;
				if(check){
					var $hbox = $(".pageHead .mdt");
					var $cen = $(".pageHead>.inr .cent"); // add -jy
					var $wrap = $(".mylog_userInfo .profile .pro_btn");
					var h = $(window).scrollTop();
					var $share = ($(".mylog_user .profile .logBtnBasic.btn-share").length)?$(".mylog_user .profile .logBtnBasic.btn-share"):$(".pageHead .mdt .logBtnBasic.btn-share");
					//var nick = $(".mylog_user > .profile > .nick").text(); //add - jy
					var nick = $(".nick").find("span").eq(0).text()
					var top = $wrap.offset().top + $wrap.height() - $(".pageHead .inr").height();
					//console.log("h len : " + $hbox.length)
					//console.log("s len : " + $share.length)
// 다른 사람 펫로그의 경우만	노출됨.				
<c:if test="${session.mbrNo ne petLogUser.mbrNo}">		
					var $bt = ($(".mylog_userInfo .profile .pro_btn .btn").length)?$(".mylog_userInfo .profile .pro_btn .btn"):$(".pageHead .mdt .btn"); // add-jy
					if(h >= top){
					 	$hbox.append($bt);
					 	//헤더 팔로잉 버튼이 기존 버튼 디자인과 다름
						$(".pageHead .mdt .btn").removeClass('c');
						$(".pageHead .mdt .btn").addClass('a'); 
					}else{
						$wrap.append($bt);
				 		 if($bt.text() == '팔로잉'){
						$(".mylog_userInfo .profile .pro_btn .btn").removeClass('a');
						$(".pageHead .mdt .btn").addClass('a');
						}   
					}		
					
</c:if>

					if(h >= top){
						$share.css("position", "relative");
						$share.css("z-index", "10");
						$("#headerShare").show()
						
						$cen.text(nick).css({top:"14px",left:"41px","text-align":"left"});//add - jy
						//console.log("down")
					}else{
						$share.removeAttr("style"); 
						$("#headerShare").hide()
						$cen.text("");//add - jy						
						//console.log("up")					
					};
				};
			};
			
			$(window).on("scroll , touchmove" , function(){
				upperResult = upperScrollPage == 1 ? false : true;
				if($(window).scrollTop()+1 >= ($(document).height() - $(window).height() - 100 )){  // MO web : 스크롤 안되는 오류  때문에 -100 함.(2021.04.26)
					if(result && scrollPrevent){
						petLogPage++;
						scrollPrevent = false;
						pagingMyPetLog(petLogPage);
					}
				}
				
				if($(window).scrollTop() == 0 && upperScrollPage != 1){
					if(upperResult && scrollPrevent){
						upperScrollPage--;
						scrollPrevent = false;
						pagingMyPetLog(upperScrollPage , "upper");
					}
				} 
			})
			
			if("${requestScope['javax.servlet.forward.query_string']}".indexOf('insertYn=Y') > -1){
				storageHist.replaceHist()
			}
		});
		function goPetLogListM(mbrNo , selIdx , page){
			var viewIdx = selIdx;
			var page = Number(page);
			// 첫 페이지 24개 일 시 페이지 및 index set
			if(viewIdx >= 12){
				if(page == 1){
					viewIdx = viewIdx-12;					
				}
				page = page+1;
				 
			}
			var param = "${so.rate}" != "" 
			? "?mbrNo=${petLogUser.mbrNo}&page="+page+"&backYn=Y&rate=${so.rate}"
			: "?mbrNo=${petLogUser.mbrNo}&page="+page+"&backYn=Y"
			
			storageHist.replaceHist("/log/indexMyPetLog/${petLogUrl}"+param)
			location.href = "/log/indexPetLogList?pageType=M&mbrNo="+mbrNo+"&selIdx="+viewIdx+"&page="+page
		}
	
					
		function pagingMyPetLog(petLogPage , upper){
			var options = {
					url : "/log/indexMyPetLog/<c:out value='${petLogUrl}'/>?mbrNo=<c:out value='${petLogUser.mbrNo}'/>"
					, data : {
						page : petLogPage
						, upper : upper
					}
					, dataType : "html"
					, done : function(html){
							if(upper){
								$("#myPetLogList").prepend(html);
								$("html,body").scrollTop($("[name=myPetLogli][data-page="+(petLogPage+1)+"]").eq(0).offset().top-$(".pageHead > .inr").height())
							}else{
								$("#myPetLogList").append(html);	
							}
							
							scrollPrevent = true;
							imgResize();
							thumbApi.ready();
							if(petLogPage >= pagingEndPage){
								result = false;								
							}
						}
					}
				ajax.call(options);
			}
		
		
	
		
	</script>
<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">	
	<script>
	// 이전 URL 이 펫로그 홈 일때 처리 
	$(function(){
		var currentState = history.state;
		var insertYn = "${insertYn}";
		if(insertYn == "Y"){
     		var newURL = window.location.href.replace(/\&insertYn\=./,'')
    		history.replaceState(null,null,newURL)
			ui.toast("<spring:message code='front.web.view.petlog.insert.profile.msg.toast' />")
		}
// 		if(document.referrer.indexOf("/log/home/") != -1){
// 		} else {
// 			if(insertYn == "Y"){
// 				$(".back").attr("onClick", "history.go(-3);");
// 				ui.toast("프로필이 저장되었어요.")
// 			}else{
// 				$(".back").attr("onClick", "goPetLogHome();");
// 			}
			
// 		}

		//APP일 경우 encodingCheck call
		if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
			callAppFunc('onPetLogEncodingCheck' , 'onPetLogEncodingCheckCallback');	
		}
	});
	
	</script>
</c:if>
	
	
	</tiles:putAttribute>
	
	<%-- 
	Tiles content put
	--%>			
	<tiles:putAttribute name="content"> 
		<main class="container page logmain" id="container">			
			<div class="inr">
				<!-- 본문 -->
				<div class="contents log my" id="contents">				
					<!-- 페이지 헤더 -->
					<!-- mobile -->
					<div class="pageHead logHeaderAc" style="height:0;">
						<div class="inr">
							<div class="hdt">
								<c:if test ="${fn:indexOf(requestScope['javax.servlet.forward.query_string'] , 'home=log' ) > -1}">
									<button class="back" type="button" onclick="storageHist.goBack('/log/home/')" <spring:message code='front.web.view.common.title.goback' /></button>
								</c:if>
								<c:if test ="${fn:indexOf(requestScope['javax.servlet.forward.query_string'] , 'home=log' ) <= -1}">
									<button class="back" type="button" onclick="storageHist.getOut('log/indexMyPetLog');" <spring:message code='front.web.view.common.title.goback' /></button>
								</c:if>
								<
							</div>
							<div class="cent" style ="top:14px;left:41px;text-align:left";><c:if test ="${so.page != 1}">${petLogUser.nickNm}</c:if><h2 class="subtit"></h2></div>
							<div class="mdt">
							<button class="logBtnBasic btn-share"  id="headerShare" style="<c:if test ="${so.page == 1 }">display:none</c:if>" data-message="<spring:message code='front.web.view.common.msg.result.share' />" data-title="${petLogUser.nickNm}" title="COPY URL" onclick="sharePetLog('${petLogUser.mbrNo}', this.id, 'M');" id="share_${petLogUser.petLogUrl}" data-clipboard-text="${petLogUser.petLogSrtUrl}"><span><spring:message code='front.web.view.common.sharing' /></span></button>
						<c:if test="${session.mbrNo eq petLogUser.mbrNo}">
								<button type="button" class="bt txt a make font" onclick="goPetLogInsertView();"><i class="ico"></i> <spring:message code='front.web.view.petlog.insert.make.button.title' /></button>
						</c:if>
							</div>
						</div>
					</div>
					<!-- // mobile -->
					<div id="myPetLogListInfo" class="mylog_area info" style="<c:if test ="${so.page != 1 }">display:none</c:if>">
						<div class="mylog_area_innerWrap">
						<!-- 사용자 정보 -->
						<div class="mylog_userInfo">
							<!-- 사용자 -->
							<div class="mylog_user">
								<div class="pic">
									<a>
					<c:choose>					
						<c:when test="${petLogUser.prflImg ne null and petLogUser.prflImg ne ''}">										
							<c:choose>
								<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
									<img src="${frame:optImagePath(petLogUser.prflImg, frontConstants.IMG_OPT_QRY_540)}" alt="">
								</c:when>
								<c:otherwise>
									<img src="${frame:optImagePath(petLogUser.prflImg, frontConstants.IMG_OPT_QRY_786)}" alt="">
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<img src="../../_images/common/icon-img-profile-default-m@2x.png" alt="">
						</c:otherwise>
					</c:choose>
									</a>
								</div>
								<div class="profile">
									<div class="nick scroll_tit_ac <c:if test="${session.mbrNo ne petLogUser.mbrNo and petLogUser.rate ne null and petLogUser.rate > 50}">log_match</c:if>">
									<span>${petLogUser.nickNm}</span>
									<c:if test="${session.mbrNo ne petLogUser.mbrNo and petLogUser.rate ne null and petLogUser.rate > 50}">		
										<span class="label_rec">${petLogUser.rate}%일치</span>
									</c:if>		
									</div>
									<div class="pro_btn scroll_move_wrap">
								<c:choose>
									<c:when test="${session.mbrNo eq petLogUser.mbrNo}">
										<a href="${view.stDomain}/log/indexMyProfileView" class="btn b">프로필 편집</a><!-- btn b : 클래스 일때 비 활성화 // btn a : 클래스 일때 활성화  -->
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${petLogUser.followYn ne null and petLogUser.followYn eq 'Y'}">
												<a href="javascript:;" onclick="saveFollowMapMember('<c:out value="${petLogUser.mbrNo}"/>', 'D' , this);" id="follow" class="btn c"><spring:message code='front.web.view.petlog.following.title' /></a>
												
											</c:when>
											<c:otherwise>
												<a href="javascript:;" onclick="saveFollowMapMember('<c:out value="${petLogUser.mbrNo}"/>', 'I', this);" id="follow" class="btn a"><spring:message code='front.web.view.petlog.follow.title' /></a>
											</c:otherwise>
										</c:choose>
									</c:otherwise>								
								</c:choose>
										<button class="logBtnBasic btn-share" data-message="<spring:message code='front.web.view.common.msg.result.share' />" data-title="${petLogUser.nickNm}" title="COPY URL" onclick="sharePetLog('${petLogUser.mbrNo}', this.id, 'M');" id="share_${petLogUser.petLogUrl}" data-clipboard-text="${petLogUser.petLogSrtUrl}"><span><spring:message code='front.web.view.common.sharing' /></span></button>
									</div>
								</div>
							</div>
						</div>	
						<!-- // 사용자 정보 -->
						
						<!-- APET-1104 210611 lju02 / 위치 이동 -->
						<!-- 자기소개 -->
						<div class="txt" style="white-space: pre-line;">
							<c:choose>
								<c:when test="${petLogUser.petLogItrdc ne null and petLogUser.petLogItrdc != ''}">${petLogUser.petLogItrdc}</c:when>
								<c:otherwise></c:otherwise>
							</c:choose>
						</div>
						<!-- //자기소개 -->
						<!-- //APET-1104 210611 lju02 / 위치 이동 -->
						<!-- 게시물 -->
						<div class="mylog_contents">
							<ul>
								<li>
									<a>
									<div class="tit"><spring:message code='front.web.view.petlog.content.title' /></div>
									<div class="num">${myPetLogTotalCount}</div>
									</a>
								</li>
								<li>
									<a href="javascript:goFollowList('follower','${petLogUser.mbrNo}');">
										<div class="tit"><spring:message code='front.web.view.petlog.follower.title' /></div>
										<div class="num">${petLogUser.followerCnt }</div>
									</a>
								</li>
								<li>
									<a href="javascript:goFollowList('following','${petLogUser.mbrNo}');">
										<div class="tit"><spring:message code='front.web.view.petlog.following.title' /></div>
										<div class="num">${petLogUser.followingCnt }</div>
									</a>
								</li>
							</ul>
						</div>
						<!-- // 게시물 -->
				</div>
			</div>
					<!-- // 페이지 헤더 -->			
					<div class="mylog_area con">
<c:choose>
	<c:when test="${myPetLogList ne '[]'}">					
						<div class="logPicMetric only3">			
							<ul id ="myPetLogList">
								<jsp:include page="/WEB-INF/view/petlog/indexMyPetLogPaging.jsp" />
<%-- 		<c:forEach items="${myPetLogList }" var="petLogBase" varStatus="status">								 --%>
<!-- 								<li> -->
<%-- 									<a href="javascript:goPetLogListM('${petLogBase.mbrNo }' , '${status.index }' , '${so.page }')" class="logPicBox"> --%>
<%-- 			<c:choose> --%>
<%-- 				<c:when test="${petLogBase.vdPath ne null and petLogBase.vdPath ne ''}"> --%>
<!-- 									<span class="logIcon_pic i01" style="z-index:1;"></span>동영상일 경우 -->
<%-- 									<div class="vthumbs" video_id="${petLogBase.vdPath}" type="video_thumb" style="height:100%" uid="${petLogBase.mbrNo}|${session.mbrNo}"></div>		 --%>
<%-- 				</c:when> --%>
<%-- 				<c:otherwise> --%>
<%-- 					<c:if test="${petLogBase.imgPath2 ne null and petLogBase.imgPath2 ne ''}"> --%>
<!-- 									<span class="logIcon_pic i02"></span>이미지가 여러개 일 경우 -->
<%-- 					</c:if> --%>
<%-- <%-- 									<img src="${petLogBase.imgPath1}" alt=""> --%> 
<%-- 					<c:choose>					 --%>
<%-- 						<c:when test="${petLogBase.imgPath1 ne null and petLogBase.imgPath1 ne ''}">										 --%>
<%-- 							<c:set var="optImage" value="${frame:optImagePath(petLogBase.imgPath1, frontConstants.IMG_OPT_QRY_500)}" /> --%>
<%-- 							<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }"> --%>
<%-- 								<c:set var="optImage" value="${frame:optImagePath(petLogBase.imgPath1, frontConstants.IMG_OPT_QRY_764)}" /> --%>
<%-- 							</c:if> --%>
<%-- <%-- 							<c:if test="${fn:indexOf(petLogBase.imgPath1, '.gif') > -1 }"> --%> 
<%-- <%-- 							<c:set var="optImage" value="${frame:imagePath(petLogBase.imgPath1)}" /> --%> 
<%-- <%-- 							</c:if> --%>
<%-- 							<img src="${optImage}" alt=""> --%>
<%-- 						</c:when> --%>
<%-- 						<c:otherwise> --%>
<!-- 								<img src="../../_images/_temp/temp_logimg003.jpg" alt=""> -->
<%-- 						</c:otherwise> --%>
<%-- 					</c:choose> --%>
<%-- 				</c:otherwise>	 --%>
<%-- 			</c:choose>							 --%>
<!-- 									</a> -->
<!-- 								</li> -->
<%-- 		</c:forEach> --%>
							</ul>
						</div>
	</c:when>
	<c:otherwise>						
						<!-- no data -->
<c:choose>
	<c:when test="${session.mbrNo eq petLogUser.mbrNo}">
                        <section class="no_data i4 log_po1">
                            <div class="inr">
                                <div class="msg">
						<spring:message code='front.web.view.petlog.insert.mypet_cute.msg.title.mobile.app' /><br />
                                    </div>
                                <div class="uimoreview onMo_b">
                                    <a href="javascript:goPetLogInsertView();" class="bt more"><spring:message code='front.web.view.petlog.insert.mypet.button.title' /></a>  <!-- APET-1250 210728 kjh02  -->
                                </div>
                            </div>
                        </section>						
	</c:when>
	<c:otherwise>					
						<section class="no_data i1 auto_h">
							<div class="inr">
								<div class="msg"><spring:message code='front.web.view.petlog.insert.notyet.contents.msg.title' /></div>  
							</div>
						</section>
	</c:otherwise>
</c:choose>		
						<!-- // no data -->			
					</div>
	</c:otherwise>
</c:choose>
				</div>
			</div>
		</main>
			
		<script>
		var timer = null;
		function imgResize(){
			if(timer !== null) clearInterval(timer);
			timer = setInterval(function(){
				var max = $("#myPetLogList li").length;
				var img = $("#myPetLogList li img").length;
				var vid = $("#myPetLogList li video").length;
				//console.log("max : " + max);
				//console.log("img : " + img);
				//console.log("vid : " + vid);
				if(max <= (img + vid)){
					$("#myPetLogList li").each(function(){
						$(this).find("img, video").height($(this).width());
					});
					$(".vthumbs>div>div>img").height("")
					clearInterval(timer);
				}
			},500);
		};
		
		$(function(){
			$(window).resize(imgResize);
			imgResize();
			
			$('.mylog_area_innerWrap div.txt').text($('.mylog_area_innerWrap div.txt').text().trim());
		});
		</script>
		<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
       	<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
        	<jsp:param name="floating" value="talk" />
        </jsp:include>
        </c:if>
		
	</tiles:putAttribute>
	
</tiles:insertDefinition>