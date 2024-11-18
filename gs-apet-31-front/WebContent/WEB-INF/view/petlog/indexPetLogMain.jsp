<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@ page import="framework.common.util.DateUtil"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("replaceChar", "\n"); %>
<tiles:insertDefinition name="common_my_mo">

	<tiles:putAttribute name="script.include" value="script.petlog" />
	<!-- 지정된 스크립트 적용 -->
	<%-- 
	Tiles script.inline put
	불 필요시, 해당 영역 삭제 
	--%>
	<tiles:putAttribute name="script.inline">

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
		//$("#header_pc").removeClass("mode0").addClass("mode1");
		
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
		/* 인기태그 스와이퍼 */
		/* 2021.03.18 : 추가 */
		var swinerPopularTag = new Swiper('.slideType5.tab .swiper-container', {
               	slidesPerView: "auto",
				/*
				slidesPerView: "2.5",
				*/
				slidesPerGroup:1,
				spaceBetween: 20,
				freeMode: true,
			});
		/* // 2021.03.18 : 추가 */
			
		/* 04.09 : 추가 */
		var checkScroll = "up";
		var checkPosition = 0;
		var sw = true;
		$(".commentBoxAp.logpet:not(.app)").bind("popEndOpen",function(){
			checkScroll = "up";
		});
		$(window).scroll(function(){
			let st = $(this).scrollTop();
			let min = $(".commentBoxAp.logpet:not(.app)").attr("data-min").replace(/\D/g,'') / ($(window).innerHeight() * 0.01);
			let max = $(".commentBoxAp.logpet:not(.app)").attr("data-max").replace(/\D/g,'') / ($(window).innerHeight() * 0.01);
			var h =  $(".commentBoxAp.logpet:not(.app)").hasClass("open");
			var check_top = false;
			if(st <= 0 && sw){
				$(".commentBoxAp.logpet:not(.app)").addClass("up").stop().animate({height:(max + "%")},500,function(){
					$(this).addClass("up");
				});
			}else if( (checkScroll === null || checkPosition < st) && checkScroll == "up" && sw){
				checkScroll = "down";
				$(".commentBoxAp.logpet:not(.app)").stop().animate({height:(min + "%")},500,function(){
					$(this).removeClass("up");
				});
			}else if(checkPosition >= st && sw){
				checkScroll = "up";
			};
			checkPosition = st;
			if(st > 0){
				sw = true;
			}else{
				sw = false;
			}
		});
		/* //04.09 : 추가 */
		
	});
	</script>
	</c:otherwise>
</c:choose>
	<script>
		var isLoginMbrNo = "${session.mbrNo}"; // SGR 사용.
		
		$(document).ready(function(){
			
			videoSectionHide();
			
			// 시간 표시
			setTimeConvert();
			
			// 게시글 내용에 링크추가.
			setContentLink();
			
			// 게시물 이미지 resize
			resizeLogImg();
			
			//닉네임 , 태그팔로잉 태그 말줄임
			substrUserInfo();
			
			//APP일 경우 encodingCheck call
			if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
				callAppFunc('onPetLogEncodingCheck' , 'onPetLogEncodingCheckCallback');	
			}
			
			if( '${so.imgType}' != null && '${so.imgType}' == 'I' ) toastCallBack();
		
// 			// 페이지 로딩 시 가지고 있던 scrollTop만큼 이동			
// 			$("html,body").animate({"scrollTop":$.cookie("scrollTop")},300);
			
// 			// 페이지 이동시 현재 scrollTop 저장
// 			$(window).on("beforeunload", function (e){
// 				$.cookie("scrollTop" , $(document).scrollTop() , {path:'/'})
// 			});
		});
	</script>
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

	</tiles:putAttribute>

	<%-- 
	Tiles content put
	--%>
	<tiles:putAttribute name="content">
		<!-- content 내용 부분입니다.	-->
		<main class="container page logmain" id="container">
		<div class="inr">
			<form id="petLogShareForm" name="petLogShareForm" method="post"
				onSubmit="return false;">
				<input type="hidden" id="shrChnlCd" name="shrChnlCd" />
				<!-- 공유채널코드 -->
				<input type="hidden" name="petLogNo" />
				<!-- 펫로그번호 -->
				<input type="hidden" name="mbrNo" value="${session.mbrNo}" />
				<!-- 회원번호 -->
			</form>
			<form id="petLogReplyForm" name="petLogReplyForm" method="post"
				onSubmit="return false;">
				<input type="hidden" id="contsStatCd" name="contsStatCd" value="10" />
				<!-- 컨텐츠 상태코드(10-노출, 20-미노출, 30-신고차단) -->
				<input type="hidden" id="aply" name="aply" />
				<!-- 댓글 -->
				<input type="hidden" name="petLogNo" />
				<!-- 펫로그번호 -->
				<input type="hidden" name="petLogAplySeq" />
				<!-- 댓글 순번 -->
				<input type="hidden" name="mbrNo" value="${session.mbrNo}" />
				<!-- 회원번호 -->
			</form>
			<form id="petLogInterestForm" name="petLogInterestForm" method="post"
				onSubmit="return false;">
				<input type="hidden" id="intsGbCd" name="intsGbCd" />
				<!-- 관심구분코드(10-좋아요, 20-찜) -->
				<input type="hidden" name="petLogNo" />
				<!-- 펫로그번호 -->
				<input type="hidden" name="mbrNo" value="${session.mbrNo}" />
				<!-- 회원번호 -->
				<input type="hidden" name="saveGb" />
				<!-- 등록/삭제 구분 -->
			</form>
			<!-- 내가 쓴 게시물 , 팔로워 게시물 조회가 끝난 후 제외할 신규 게시물 펫로그 번호 --> 
			<input type ="hidden" id="excludePetLogNo" name="excludePetLogNo">
			<input type ="hidden" id="excludeRecMbrNo" name="excludeRecMbrNo">
			<!-- 최상단 펫로그 번호(페이징 도중 게시물이 등록되었을 시 제외하기 위해) -->
		 	<input type ="hidden" id="comparePetLogNo" name="comparePetLogNo" value ="${pagePetLogMainList[0].petLogNo }">
		 	<input type ="hidden" id="compareNewPetLogNo" name="compareNewPetLogNo">
		 	
			<!-- 본문 -->
			<div class="contents log main" id="contents">
				<div id="box-item" name="box-item">
					<jsp:include page="/WEB-INF/view/petlog/indexPetLogListPaging.jsp" />
				</div>
			</div>
		</div>
		</main>
		
		
<script>
var page = 1;
var recommendPage = 1;
var newPostCheckPage = Number("${so.newPostCheckPage}")   //신규 게시물 시작 페이지
var newPostPage = newPostCheckPage == 0 ? 1 : 0; // 신규 게시물이 바로 노출 시 1 아니면 0
var upperScrollPage;
var newPostCount;
var result = true;
var upperResult;
var scrollPrevent = true;
var htmlArr = new Array();
var recMemberPage; 
var boRecMemberPage;

$(function(){
	$(window).on("scroll , touchmove" , function(){
		if($(window).scrollTop()+1 >= ($(document).height() - $(window).height() - 100)){  // MO web : 스크롤 안되는 오류  때문에 -100 함.(2021.04.26)
			if(result && scrollPrevent){
				//신규 게시물 시작 page보다 page가 크면 신규 게시물 page++
				if(newPostCheckPage > page){
					page++;
				}else{
					page++;
					newPostPage++;
				}
				recommendPage++;
				scrollPrevent = false;
				pagingPetLog(page);	
			}
		}
		
// 		if($(window).scrollTop() == 0 && upperScrollPage != 1){
// 			upperResult = upperScrollPage == 1 ? false : true;
// 			if(upperResult && scrollPrevent){
// 				upperScrollPage--;
// 				scrollPrevent = false;
// 				pagingPetLog(upperScrollPage , "upper");
// 			} 
// 		}
	});
});



//페이징 시 이미 한번 로딩 된 페이지는 ajax 안태우고 배열에서 가져옴
// 	function pagingPetLog(petLogPage , upper){
// 	if($("[name=recMemberList]").length > 0){
// 		recMemberPage =	$("[name=recMemberList]").last().data("recyn") != "N"
//  			? Number($("[name=recMemberList]").data("page"))+1
//  			: $("[name=recMemberList]").data("page")	
// 	}
// 		if(upper){
// 			$("[name=box-item]").prepend(htmlArr[Number(petLogPage)-1].html)
// 			$("html,body").scrollTop($("[name=petLogMainList]").eq(1).find("[name=pSection]").first().offset().top);
// 			if($("[name=petLogMainList]").length > 2 ){
// 				$("[name=petLogMainList]").last().remove()
// 		}
// 			scrollPrevent = true;
// 			result = true;
// 			if(newPostPage > 0){
// 			newPostPage--;
// 		}		
// 			if(petLogPage == 1){
// 			upperResult = false;
// 		}
// 			thumbApi.ready();
// 		}else{
// 			var lastPage =  $("[name=petLogMainList]").last().data("page")
// 			if(htmlArr.length > lastPage && lastPage != 1){
// 				$("[name=box-item]").append(htmlArr[lastPage].html)
// 				if($("[name=petLogMainList]").length > 2 ){
// 					$("[name=petLogMainList]").first().remove();
// 				}
// 				upperResult = true;
// 				scrollPrevent = true;
// 				if(newPostCheckPage < page){
// 					newPostPage++;
// 				}
// 				if(newPostCount > 0 && newPostCount < newPostPage*5){
// 					result = false;
// 				}
// 				thumbApi.ready();
// 			}else{
// 				var options = {
// 	 	 			url : "/log/home"
// 	 	 			, data : {
// 	 	 				page : page												//내가 쓴 게시물 및 팔로워 게시물 page & 신규 게시물 체크 페이지와 비교 
// 	 	 				, recommendPage : recommendPage							//추천 게시물 page & 현재 페이지 위치 값
// 	 	 				, newPostPage : newPostPage								//신규 게시물 페이지
// 	 	 				, recMemberPage : recMemberPage							//이 친구 어때요 페이지
// 	 	 				, excludeLogNo : $("#excludePetLogNo").val()			//신규 게시물 추가 노출 시 신규 게시물 페이징 할때 제외할 신규 게시물 번호	
// 	 	 				, compareLogNo : $("#comparePetLogNo").val()			//내가 쓴 게시물 , 팔로워 게시물 최상단 게시물 번호 
// 	 	 				, compareNewLogNo : $("#compareNewPetLogNo").val()		//신규 게시물 최상단 게시물 번호
// 	 	 				, upper : upper
// 	 	 			}
// 	 	 			, dataType : "html"
// 	 	 			, done : function(html){
// 	 	 				if($(html).find(".logContentBox").length != 0){
// 		 					$("[name=box-item]").append(html);
// 	 		 				scrollPrevent = true;
// 	 	 				}
	 	 					
// 	 	 				if($(html).find(".logContentBox").length < 5){
// 	 	 					result = false;
// 	 	 				}
// 	 	 				thumbApi.ready()
// 				}
// 			}
// 			ajax.call(options)
// 		}

 
 	//페이징 시 이미 한번 로딩 된 페이지는 ajax 안태우고 배열에서 가져옴
 	function pagingPetLog(petLogPage , upper){
 		recMemberPage = $("[name=recMemberList][data-recyn=Y]").length > 0 ? $("[name=recMemberList][data-recyn=Y]").length+1 : 1;
 		boRecMemberPage = $("[name=recMemberList][data-recyn=N]").length > 0 ? $("[name=recMemberList][data-recyn=N]").length+1 : 1;
//  		if(upper){
//  			$("[name=box-item]").prepend(htmlArr[Number(petLogPage)-1].html)
//  			$("html,body").scrollTop($("[name=petLogMainList]").eq(1).find("[name=pSection]").first().offset().top);
//  			if($("[name=petLogMainList]").length > 2 ){
//  				$("[name=petLogMainList]").last().remove()
// 			}
//  			scrollPrevent = true;
//  			result = true;
//  			if(newPostPage > 0){
// 				newPostPage--;
// 			}		
//  			if(petLogPage == 1){
// 				upperResult = false;
// 			}
//  			thumbApi.ready();
//  		}else{
//  			var lastPage =  $("[name=petLogMainList]").last().data("page")
//  			if(htmlArr.length > lastPage && lastPage != 1){
//  				$("[name=box-item]").append(htmlArr[lastPage].html)
//  				if($("[name=petLogMainList]").length > 2 ){
//  					$("[name=petLogMainList]").first().remove();
//  					$("html,body").scrollTop($(document).height() - $(window).height() - $("[name=petLogMainList]").heigh())
//  				}
//  				upperResult = true;
//  				scrollPrevent = true;
//  				if(newPostCheckPage < page){
//  					newPostPage++;
//  				}
//  				if(newPostCount > 0 && newPostCount < newPostPage*5){
//  					result = false;
//  				}
//  				thumbApi.ready();
//  			}else{
// //  				신규 게시물 시작 page보다 page가 크면 신규 게시물 page++
// 				if(newPostCheckPage > page){
// 					page++;
// 				}else{
// 					page++;
// 					newPostPage++;
// 				}
// 				recommendPage++;
				
 				$.ajax({
 	 	 			url : "/log/home"
 	 	 			, data : {
 	 	 				page : page												//내가 쓴 게시물 및 팔로워 게시물 page & 신규 게시물 체크 페이지와 비교 
 	 	 				, recommendPage : recommendPage							//추천 게시물 page & 현재 페이지 위치 값
 	 	 				, newPostPage : newPostPage								//신규 게시물 페이지
 	 	 				, boRecMemberPage : boRecMemberPage						//이 친구 어때요 페이지 (BO)
 	 	 				, recMemberPage : recMemberPage							//이 친구 어때요 페이지
 	 	 				, excludeLogNo : $("#excludePetLogNo").val()			//신규 게시물 추가 노출 시 신규 게시물 페이징 할때 제외할 신규 게시물 번호	
 	 	 				, compareLogNo : $("#comparePetLogNo").val()			//내가 쓴 게시물 , 팔로워 게시물 최상단 게시물 번호 
 	 	 				, compareNewLogNo : $("#compareNewPetLogNo").val()		//신규 게시물 최상단 게시물 번호
 	 	 				, excludeRecMbrNo : $("#excludeRecMbrNo").val() 		// 이 친구 어때요 조회 제외 회원 번호 (BO 노출건)
 	 	 				, upper : upper											// 상단 페이징 스크롤 여부
 	 	 			}
 	 	 			, dataType : "html"
 	 	 			, success : function(html){
 	 	 				if($(html).find(".logContentBox").length != 0){
//  	 	 					if($("[name=petLogMainList]").length > 2){
//  	 	 						$("[name=petLogMainList]").first().remove();
//  	 	 						$("html,body").scrollTop($(document).height() - $(window).height())
//  	 	 					}
 	 	 					$("[name=box-item]").append(html);
 	 		 				scrollPrevent = true;
 	 	 				}
 	 	 					
 	 	 				if($(html).find(".logContentBox").length < 5){
 	 	 					result = false;
 	 	 				}
 	 	 				thumbApi.ready();
 	 	 			}
 	 	 		})
//  			}
//  		}
 	}
 

// 	$("#contents").on("scroll resize",function(){
// 		var scTop = $(this).scrollTop();
// 		var scBox = $(this).outerHeight();
// 		var scCtn = $(this).prop("scrollHeight");
// 		if (scCtn <= scTop + scBox && isScrBot == true) {
// 			isScrBot = false;
// 			setTimeout(function(){
// 				//fnCouponList(page ++);
// 				isScrBot = true;
// 			},500);
// 		}
// 	});
</script>		
        <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
        	<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
	        	<jsp:param name="floating" value="talk" />
	        </jsp:include>
        </c:if>
	</tiles:putAttribute>

	<tiles:putAttribute name="layerPop">
		<jsp:include page="/WEB-INF/view/petlog/layerPetLogReplyReport.jsp" />
		<jsp:include page="/WEB-INF/view/petlog/layerBottomRegist.jsp" />
	</tiles:putAttribute>
	



</tiles:insertDefinition>