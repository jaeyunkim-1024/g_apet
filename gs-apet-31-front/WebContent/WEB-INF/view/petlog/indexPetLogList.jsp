<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<tiles:insertDefinition name="mypage_mo_nofooter">
	
	<tiles:putAttribute name="script.include" value="script.petlog"/> <!-- 지정된 스크립트 적용 -->
		
	<%-- 
	Tiles script.inline put
	불 필요시, 해당 영역 삭제 
	--%>
	<tiles:putAttribute name="script.inline">	
		
<c:choose>
<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
	<script>
	$(document).ready(function(){
		$(".lnb.my").hide();
		
		//$(window).scrollTop($("#<c:out value='${so.petLogNo}' />").offset().top);
			var hTimer = setInterval(function(){
				$("#header_pc .tmenu .list li:eq(1)").addClass("active").siblings().removeClass("active")
				if($("#header_pc").length) clearInterval(hTimer);
			});
			var swiperBox = new Array();
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
		$("#header_pc").removeClass("mode0");		

		//APP일 경우 encodingCheck call
		if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
			callAppFunc('onPetLogEncodingCheck' , 'onPetLogEncodingCheckCallback');	
		}
		
	<c:choose>
		<c:when test="${pageType ne null and pageType eq 'M' }">
			$("#header_pc").addClass("mode6");			
			//$("#header_pc .mo-header-rightBtn").prepend("<button class=\"logBtnBasic btn-share\"><span class=\"mo-header-icon\"></span></button>");
			$("#header_pc .mo-header-rightBtn")
			.prepend("<button class=\"logBtnBasic btn-share\" data-message=\"<spring:message code='front.web.view.common.msg.result.share' />\" title=\"COPY URL\" onclick=\"sharePetLog('${so.mbrNo}', this.id, 'M');\" id=\"share_${so.petLogUrl}\" data-title=\"${petLogBase.nickNm}\" data-clipboard-text=\"${so.petLogSrtUrl}\"><span><spring:message code='front.web.view.common.sharing' /></span></button>");
			
			
			<c:choose>
				<c:when test="${session.mbrNo eq so.mbrNo}">
					$(".mo-header-btnType01").remove();
					$("#header_pc .mo-header-rightBtn").append("<button class=\"mo-header-btnType01\"><span class=\"mo-header-icon\"></span><span class=\"txt\"><spring:message code='front.web.view.petlog.insert.make.button.title' /></span></button>");
					$(".mo-header-btnType01").attr("onClick","goPetLogInsertView();");	
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${followYn ne null and followYn eq 'Y'}">
							$(".mo-header-btnType01").text("<spring:message code='front.web.view.petlog.following.title' />");					
							$(".mo-header-btnType01").attr("onClick","saveFollowMapMember('${so.mbrNo}','D', this);");	
						</c:when>
						<c:otherwise>
							$(".mo-header-btnType01").text("<spring:message code='front.web.view.petlog.follow.title' />");					
							$(".mo-header-btnType01").attr("onClick","saveFollowMapMember('${so.mbrNo}','I', this);");	
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
			$(".mo-heade-tit .tit").html("${title}");
		</c:when>
		<c:when test="${pageType ne null and pageType eq 'L' }">
			$("#header_pc").addClass("mode13");
			$(".mo-heade-tit .tit").html("${title}");
		</c:when>
		<c:when test="${pageType ne null and pageType eq 'T' }">
			
		
			$("#header_pc").addClass("mode6");
			$(".mo-heade-tit .tit").html("#"+"${so.tag}");
			<c:choose>
				<c:when test="${tagFollowYn ne null and tagFollowYn eq 'Y'}">
					$(".mo-header-btnType01").text("<spring:message code='front.web.view.petlog.following.title' />");					
					$(".mo-header-btnType01").attr("onClick","saveFollowMapTag('${so.tagNo}', 'D' , this);");	
				</c:when>
				<c:otherwise>
					$(".mo-header-btnType01").text("<spring:message code='front.web.view.petlog.follow.title' />");					
					$(".mo-header-btnType01").attr("onClick","saveFollowMapTag('${so.tagNo}', 'I', this);");	
				</c:otherwise>
			</c:choose>		
		
		
		
		
		</c:when>
		<c:otherwise>
			$("#header_pc").addClass("mode13");	
			$(".mo-heade-tit .tit").html("${title}");
		</c:otherwise>
	</c:choose>
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
			
			$(".mo-header-backNtn").attr("onClick", "storageHist.goBack()");

			var goodsVal = "${goodsVal}";
			var $btn = $('.btn_connectTing[data-related-page=${selIdx}-${so.page}]');
			if($btn.length > 0){
				if(goodsVal != null && goodsVal.indexOf("cart") !== -1){
					getRelatedGoodsWithPetLog($btn, $btn.data('content'), 'Y');
				}else if(goodsVal != null && goodsVal != ""){
					getRelatedGoodsWithPetLog($btn, $btn.data('content'), 'N|'+goodsVal);
				}
			}
			
		});
	
	</script>
</c:otherwise>
</c:choose>
	<script>
	var petLogPage = Number("${so.page}");
	var upperScrollPage = Number("${so.page}");
	var result;
	var upperResult;
	var scrollPrevent = true;
	var index = "${selIdx}";
		function move_scroll(n , upper){
			moContxtMoreSet("${so.page}")
			if(n != 0){
				var $box = $(".logContentBox");
				var arr = new Array();
				$box.each(function(i,n){
					arr[i] = $(n).offset().top;
				});
				if(upper){
					$("html,body").scrollTop(arr[n] - 5);	
				}else{
					$("html,body").animate({"scrollTop":(arr[n] - 5)},300);				
				}
			}
		}
		
		
		$(document).ready(function(){ 
			result = $(".logContentBox").length < '${so.rows}' || $(".logContentBox").length * "${so.page}" == "${so.totalCount}" ? false : true;
			upperResult = upperScrollPage == 1 ? false : true;
		
			$(window).on("scroll , touchmove" , function(){ 
				if($(window).scrollTop()+1 >= ($(document).height() - $(window).height() - 100 )){  // MO web : 스크롤 안되는 오류  때문에 -100 함.(2021.04.26) 
					if(result && scrollPrevent){ 
						petLogPage++;
						scrollPrevent = false;
						pagingPetLog(petLogPage);	
					} 
			 	}
 				if($(window).scrollTop() == 0 && upperScrollPage != 1){
					if(upperResult && scrollPrevent){
						upperScrollPage--;
						scrollPrevent = false;
						pagingPetLog(upperScrollPage , "upper");
					}
				} 
			});
			
			// 게시글 내용에 링크추가.
			setContentLink();
			
			// 시간 표시
			setTimeConvert();
			
			// 게시물 이미지 resize
			resizeLogListImg();			

			substrUserInfo();
			
		});
		
		/* 게시물 img size */
		function resizeLogListImg(){
			$(".logContentBox .lcbPicture img, .logContentBox .lcbPicture .vthumbs").each(function(i,n){
				let w = $(n).parent().innerWidth();
				let h = (w / 3) * 4 ;
				$(n).parent().attr("style","height:"+h + "px;");
				if($(n).find(".vv_mutd_off").length > 1){
					$(n).find(".vv_mutd_off").last().remove();
					$(n).find(".v_mutd_on").last().remove();
				}
				
				if($(n).find(".v_mutd_on").length > 1){
					$(n).find(".vv_mutd_off").last().remove();
					$(n).find(".v_mutd_on").last().remove();
				}
			});
			move_scroll(index);
		}
		
		function pagingPetLog(petLogPage , upper){
			var tag = '${so.tag}';
			var mbrNo = "${pageType}" == "M" ? '${petLogList[0].mbrNo}' : null

			var data = {
				page : petLogPage
				, pageType : "${pageType}"
				, mbrNo : mbrNo
				, selIdx : "${selIdx}"
				, tiles : "N"
			}
			
			if(tag != null && tag != ''){
				$.extend(data, {tag : tag});
			}
			
			var options = {
					url : "/log/indexPetLogList"
					, data : data
					, dataType : "html"
					, done : function(html){
						// 페이징 한 요소가 있을 시 append
						if($(html).find(".logContentBox").length != 0){
							//$("#contents").append($(html).find("script"));
							//$("#contents").append($(html).find(".logContentBox"));
							if(upper){
								if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_10}"){
									$("#contents > .log_listviewTop").after(html);
								}else{
									$("#contents").prepend(html);
								}
								$("html , body").scrollTop($("[name=petLogListView]").eq(0).height())
							}else{
								$("#list-Box").append(html);
							}
							scrollPrevent = true;
						}
						// 더 이상 페이징 할 요소가 없을 시 페이징 x
						if($(html).find(".logContentBox").length < '${so.rows}'){
							result = false;
						}
						if(petLogPage == 1){
							upperResult = false;
						}
						// 게시물 이미지 resize
						// 영상 재생 처리
						onThumbAPIReady();
						resizeLogImg();
					}
			}
			ajax.call(options);
		}
	</script>
	<style>
		.commentBoxAp.logcommentBox{overflow:hidden;}
		.commentBoxAp > .con.t2 > .input{position:relative;}
		.tagList{position:absolute; top:0; left:0; width:100%; background:#f7f7f7;}
		.tagList > ul{padding:0 20px;}
		.tagList > ul > li{height:46px; padding:0 0 0 3px; font-size:14rem; color:#669aff; line-height:46px; border-bottom:1px solid #ecedef;}
	</style>	
		
	</tiles:putAttribute>
	
	<%-- 
	Tiles content put
	--%>			
	<tiles:putAttribute name="content"> 
		<!-- content 내용 부분입니다.	-->	
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

					<!-- PC 타이틀 영역 -->
				<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
 						<section class="log_listviewTop">
						<c:choose>		
							<c:when test="${pageType ne null and pageType eq 'T' }">
							<h1>#<c:out value="${so.tag}" /></h1>
							</c:when>
							<c:when test="${pageType ne null and pageType eq 'M' }">
							<div class="pic" onclick="goMyPetLog('${so.petLogUrl}','${so.mbrNo}',event);">							
								<c:set var="prflImg" value="${so.prflImg != null and so.prflImg != '' ? frame:optImagePath(so.prflImg, frontConstants.IMG_OPT_QRY_786) : '../../_images/common/icon-img-profile-default-m@2x.png'}" />
								<img src="${prflImg}" alt="dog">
							</div>
							<h1><a href="javascript:goMyPetLog('${so.petLogUrl}','${so.mbrNo}');">${title}</a></h1>
							</c:when>
							<c:otherwise>
							<h1>${title}</h1>
							</c:otherwise>
						</c:choose>
						</section>
				</c:if>
					<!-- PC 타이틀 영역 -->
			<div name = "petLogListView">		
				<div id="list-Box">
					<jsp:include page="/WEB-INF/view/petlog/indexInnerPetLogListPaging.jsp"/>
				</div>				
			<!-- 펫로그 메인 콘턴츠 area 리스트 -->
			</div>
		</div>
	</div>
</main>		
		
        <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
        	<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
	        	<jsp:param name="floating" value="talk" />
	        </jsp:include>
        </c:if>		
		
	</tiles:putAttribute>	
		
	<tiles:putAttribute name="layerPop">
		<jsp:include page="/WEB-INF/view/petlog/layerPetLogReplyReport.jsp" />
	</tiles:putAttribute>
	
</tiles:insertDefinition>