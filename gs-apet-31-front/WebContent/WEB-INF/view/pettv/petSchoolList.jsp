<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.inline">
	<script src="<spring:eval expression="@bizConfig['vod.player.api.url']" />/thumb_api/v1.js"></script>
		<script>
		var tab_length = 0;	
		var lastScroll = 0;
			/* 탭메뉴 */
			$(document).ready(function() {
				initPetschoolHome();
				
				if("${vdHist}" != null) {
				  	var obj = $(".uiTab li span");
				  	for(var i = 0; i < obj.length; i++){
					 	if($(obj[i]).text() == "${vdHist}") {
					 		$(obj[i]).closest('a').click();
				  	 	}
				  	}
			  	}
				
				/*if("${petGbCd}" == "20"){// petGbCd:20(고양이)
				  	$(".menushop>button").text("고양이");
				  	$(".menushop .menu>li").removeClass("active");
				  	$(".menushop .menu>li").each(function(i, o){
					  	if(o.id == "selPetGb20"){
						  	$(this).addClass("active");
					  	}
				  	});
			  	}*/
			});
			
			function initPetschoolHome(){
				lastScroll = 0;
				tab_length = 0;
				// Swiper main
				$(".main").each(function(idx){
		            varslide = [];
		            varslide[idx] = new Swiper($(this).find('.swiper-container'), {
		                slidesPerView: 1,
						slidesPerGroup:1,
		                pagination: {
							el: '.main .swiper-pagination',
						},
						navigation: {
							nextEl: '.main .swiper-button-next',
							prevEl: '.main .swiper-button-prev',
							// disabledClass: 'disabled'
						},
		                observer: true,
		                freeMode: false,
						watchOverflow:true,
						observeParents: true,
		            });
		        });
				
				var ctgCheck = $("li[name=ctgNm]").length;
				if(ctgCheck != null && ctgCheck > 0){
					for(var i = 0; i < ctgCheck; i++){
						var newCheck = $("section[name=ctgContList]")[i];
						if($(newCheck).find('i[name=newIcon]').length > 0){
							$($("li[name=ctgNm]")[i]).addClass('new');
						}
					}
				}
		
				/* 21.08.02 APETQA-4826 lcm01 : 스크립트 변경 */
				// 탭 5개 이상 모바일만
				tab_length = $('.uiTab li > a').length;
				if(tab_length > 4 && "${view.deviceGb}" != "${frontConstants.DEVICE_GB_10 }"){
					var tabmn = new Swiper('.tab-menu > .swiper-container', {
						slidesPerView: 'auto',
						/*spaceBetween: 18,*/ //21.08.18
						freeMode: false,
						/*preventClicks: true,*/  //21.08.18
				        preventClicks: false,  //21.08.18
						preventClicksPropagation: false,
						observer: true,
						observeParents: true
					});
					
					if(tab_length > 4){
						tabmn.params.spaceBetween = 18;
						if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10 }"){
							$('.uiTab').css("padding-left","18px");  //모바일에서만
						}
					}else{
						tabmn.params.spaceBetween = 0;
					}
					
					tabmn.update();
				}
				
				$(document).on("scroll", onScroll);
				
				$('.uiTab li > a[href^="#"]').on('click', function() {
					$('.uiTab > li > a.active').each(function(){
						$(this).removeClass('active');
					});
					$(this).addClass('active');
					
					$(document).off("scroll");
					var t = 0;//$("#header_pc").height() || 0; 퍼블에는 $("#header_pc") 가 존재하지 않아 실제 와 차이 발생하여 0처리함.
					var h = $(".pageHead").height() || $(".header > .hdr").height();
					var target = this.hash;
					$target = $(target);
					var top = $target.offset().top - h - t;					
					if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_10 }"){
						top = top - 53;
					}else{
						if(top < $(window).scrollTop()){
							top = top - 56;
						}
					}
					$('html, body').stop().animate({scrollTop: top}, 500, 'swing', function () {
						window.location.hash = target;
						$(document).on("scroll", onScroll);
					});
				});
				
				var divSize = $(".deucation section").length;
				  
			  	for(var i = 0; i < divSize; i++) {
				  	var divId = $(".deucation section").eq(i).attr("id");
				  
				  	var liLength = $("#"+divId+" ul li").length;
				  	var progressLength = $("#"+divId+" ul li .progress-bar").length;
				  	$("#liSize" + i).text(liLength+"개");
				  	$("#listSizeOk" + i).text(progressLength+"개");
			  	}
			}
			
			function muCenter(target){
				var snbwrap = $('.tab-menu .uiTab');
				var targetPos = target.parent().position();
				var box = $('.tab-menu');
				var boxHarf = box.width()/2;
				var pos;
				var listWidth = 0;
				
				snbwrap.find('.swiper-slide').each(function(){
					listWidth += $(this).outerWidth(true);
				})
				
				if(tab_length > 4){listWidth += 15;}
				
				if(listWidth > $(document).outerWidth(true)){
					var selectTargetPos = targetPos.left + target.outerWidth()/2;
					
					if (selectTargetPos <= boxHarf) { // left
						pos = 0;
					}else if ((listWidth - selectTargetPos) <= boxHarf) { //right
						pos = listWidth-box.width();
					}else {
						pos = selectTargetPos - boxHarf;
					}				
					snbwrap.css({
						"transform": "translate3d("+ (pos*-1) +"px, 0, 0)",
						"transition-duration": "500ms"
					})	
				}
			}
				
			var onScroll = function(){  //21.08.18
				var scroll = $(this).scrollTop();
				var h = $('.pageHead').height() || $(".header > .hdr").height();
				var titH = $(".tab-cont .tit-area").outerHeight();
				var tabH = $(".tab-menu .inner").outerHeight();
				var docHeight = $(document).height();
				var winHeight = $(window).height();
				
				if(scroll > lastScroll){ //scroll 내릴 때
					var obj = new Object();
					
					for(var i=1; i<=tab_length; i++) obj[i] = $("#e"+i).position().top - h -titH;
					
					for(var j=1; j<=tab_length; j++){
						if(j!=tab_length){
							if(obj[j] < scroll && scroll < obj[j+1]){
								$(".uiTab li > a").removeClass("active");
								$(".uiTab li:nth-child("+j+") > a").addClass("active");
								muCenter($(".uiTab li:nth-child("+j+") > a"));	
							}
						}else{
							if(obj[tab_length] < scroll){
								$(".uiTab li > a").removeClass("active");
								$(".uiTab li:nth-child("+j+") > a").addClass("active");
								muCenter($(".uiTab li:nth-child("+j+") > a"));	
							}
						}
					}
	
					$(window).scroll(function() {						
						if($(window).scrollTop() + $(window).height() >= $(document).height()) {
							$(".uiTab li > a").removeClass("active");
							$(".uiTab li:nth-child("+tab_length+") > a").addClass("active");
							muCenter($(".uiTab li:nth-child("+tab_length+") > a"));	
						}
					});
	
				} else {// scroll 올릴 때
					var conMid = new Object();
					var tabChg = new Object();
					for(var i=1; i<=tab_length; i++) conMid[i] = ($("#e"+i+" .edu-list").outerHeight())/2; 
					for(var i=1; i<=tab_length; i++) tabChg[i] = $("#e"+i+" .edu-list").position().top + conMid[i] - h;
					var conTop0 = $(".tab-cont").position().top - h - titH - 40;
					
					for(var i=tab_length; i>=1; i--){
						if(scroll < conTop0){
							$(".uiTab li > a").removeClass("active");
						}else{
							if(scroll < tabChg[i] && scroll >= tabChg[i-1]){
								$(".uiTab li > a").removeClass("active");
								$(".uiTab li:nth-child("+i+") > a").addClass("active");
								muCenter($(".uiTab li:nth-child("+i+") > a"));
								return;
							} else if(scroll > conTop0 &&  scroll <= tabChg[tab_length]) {
								$(".uiTab li > a").removeClass("active");
								$(".uiTab li:nth-child(1) > a").addClass("active");
								muCenter($(".uiTab li:nth-child(1) > a"));
								
							}
						}
					}
				}
				
				lastScroll = scroll;
			}
		  
		  	function fnPetGb(petGbCd){
			  	var renewURL = location.href;
			  	var urlParam = location.search;
			  	renewURL = renewURL.replace(urlParam,'');
			  	renewURL += '?pgCd='+petGbCd;
			  	history.replaceState("","",renewURL);
			  	fnAjaxPetGb(petGbCd);
			  	//location.href = "/tv/petSchool?pgCd="+petGbCd;
		  	}
		  
		  	//petGb 목록 ajax
			function fnAjaxPetGb(petGbCd) {
				var options = {
					url : "/tv/petSchoolGb"
					, data : {
						petGbCd : petGbCd
					}
					, done : function(result) {
						$('html, body').scrollTop(0);
						var html = '';
						if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_10 }") {
							$("#mainBannerLi").empty();
							for(i in result.mainBanner) {
								if(result.mainBanner[i].bnrImgPathPc.indexOf('cdn.ntruss.com') != -1){
						        	thumPath = result.mainBanner[i].bnrImgPathPc;
						        }else{
						        	thumPath = "${frame:optImagePath('"+ result.mainBanner[i].bnrImgPathPc +"', frontConstants.IMG_OPT_QRY_350)}";
						        }
								html += '<li class="swiper-slide">';
								html += '	<div class="thumb-box">'
								html += '		<a href="#" onclick="fncGoUrl(\'/tv/school/indexTvDetail?vdId='+result.mainBanner[i].vdId+'\'); return false;" class="thumb-img" style="background-image:url('+thumPath+');"></a>'
								html += '	<div>'
								html += '</li>'
							}
							$("#mainBannerLi").append(html);
						} else if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_20}" && result.memberVO.petSchlYn == 'Y' || "${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}" && result.memberVO.petSchlYn == 'Y') {
							$("#mainBannerLi").empty();
							for(i in result.mainBanner) {
								if(result.mainBanner[i].bnrImgPathS.indexOf('cdn.ntruss.com') != -1){
						        	thumPath = result.mainBanner[i].bnrImgPathS;
						        }else{
						        	thumPath = "${frame:optImagePath('"+ result.mainBanner[i].bnrImgPathS +"', frontConstants.IMG_OPT_QRY_792)}";
						        }
								html += '<li class="swiper-slide">';
								html += '	<div class="thumb-box">'
								html += '		<a href="#" onclick="fncGoUrl(\'/tv/school/indexTvDetail?vdId='+result.mainBanner[i].vdId+'\'); return false;" class="thumb-img" style="background-image:url('+thumPath+');"></a>'
								html += '	<div>'
								html += '</li>'
							}
							$("#mainBannerLi").append(html);
						} else {
							$("#mainBannerLi").empty();
							for(i in result.mainBanner) {
								if(result.mainBanner[i].bnrImgPathL.indexOf('cdn.ntruss.com') != -1){
						        	thumPath = result.mainBanner[i].bnrImgPathL;
						        }else{
						        	thumPath = "${frame:optImagePath('"+ result.mainBanner[i].bnrImgPathL +"', frontConstants.IMG_OPT_QRY_751)}";
						        }
								html += '<li class="swiper-slide">';
								html += '	<div class="thumb-box">'
								html += '		<a href="#" onclick="fncGoUrl(\'/tv/school/indexTvDetail?vdId='+result.mainBanner[i].vdId+'\'); return false;" class="thumb-img" style="background-image:url('+thumPath+');"></a>'
								html += '	<div>'
								html += '</li>'
							}
							$("#mainBannerLi").append(html);
						}
						
						$(".deucation").empty();
						
						var html = '';
						for(var i = 0; i < result.listGb.length; i++) {
							html += '<section data-sid="edu0'+(i+1)+'" data-index="'+i+'" id="e'+(i+1)+'">';
							html += '	<div class="tit-area">';
							html += '		<h3>'+result.listGb[i]+'</h3>';
							html += '		<div class="level">';
							html += '			<div class="lv3">'
							html += '				<span>난이도1</span>';
							html += '			</div>';
							html += '			<strong>: 난이도</strong>';
							html += '		</div>';
							html += '	</div>';
							
							html += '	<p class="info-text">';
							html += '	반려동물과 보호자의 유대감을 쌓는 첫 걸음! 차근차근 함께 학습해 보아요.';
							html += '	</p>';

							html += '	<div class="edu-list">';
							html += '		<div class="list-total">총 <em class="baseCnt" id="liSize'+i+'">개</em> 중 <em class="nth" id="listSizeOk'+i+'">개</em> 학습완료</div>';
							html += '		<ul id="baseEduLi">';
							for(var j = 0; j < result.getList.length; j++) {
								if(result.getList[j].thumPath != null && result.getList[j].thumPath.indexOf('cdn.ntruss.com') != -1){
           				        	thumPath = result.getList[j].thumPath;
           				        }else{
           				        	thumPath = "${frame:optImagePath('"+ result.getList[j].thumPath +"', frontConstants.IMG_OPT_QRY_784)}";
           				        }
								
								var lodCd;
               					if(result.getList[j].lodCd == "${frontConstants.APET_LOD_10}") {
               						lodCd = '1';
               					} else if(result.getList[j].lodCd == "${frontConstants.APET_LOD_20}") {
               						lodCd = '2';
               					} else {
               						lodCd = '3';
               					}
								
								if(result.listGb[i] == result.getList[j].ctgMnm) {
									html += '	<li>'
									if(result.getList[j].newYn == 'Y') {
										html += '	<i class="icon-n">N</i>'
									}
									html += '		<div class="thumb-box" onclick="fncGoSchoolDetail(\''+ result.getList[j].vdId +'\')" style="cursor:pointer;" data-content="'+result.getList[j].vdId+'" data-url="/tv/school/indexTvDetail?vdId='+result.getList[j].vdId+'">';
									html += '			<a href="#" onclick="return false;" class="thumb-img" style="background-image:url('+thumPath+');">';
									if(result.getList[j].stepProgress != null && result.getList[j].stepProgress != '') {
										html += '			<div class="progress-bar" style="width:'+result.getList[j].stepProgress+';"></div>';
									}
									html += '			</a>';
									html += '			<div class="thumb-info gray">';
									html += '				<a href="#" onclick="return false;" class="tlt" style="overflow:hidden; text-overflow:ellipsis; white-space:nowrap; display:block;">'+result.getList[j].ttl+'</a>';
									html += '				<span class="level lv'+lodCd+'">';
									html += '					<span>난이도1</span>';
									html += '					<span>난이도2</span>';
									html += '					<span>난이도3</span>';
									html += '				</span>'
									html += '			</div>';
									html += '		</div>';
									html += '	</li>';
								}
							}
							html += '		</ul>';
							html += '	</div>';
							html += '</section>';
						}
						$(".deucation").append(html);

						var divSize = $(".deucation section").length;
						for(var i = 0; i < divSize; i++) {
							var divId = $(".deucation section").eq(i).attr("id");
								  
							var liLength = $("#"+divId+" ul li").length;
							var progressLength = $("#"+divId+" ul li .progress-bar").length;
							$("#liSize" + i).text(liLength+"개");
							$("#listSizeOk" + i).text(progressLength+"개");
						}
							  
						$(".tab-menu ul").empty();
							 
						var menuHtml ='';
						for(var i = 0; i < divSize; i++) {
						 	menuHtml += '<li  class="swiper-slide" data-btn-sid="edu0'+(i+1)+'">'
						 	menuHtml +=	'	<a class="bt" href="#e'+(i+1)+'"><span>'+result.listGb[i]+'</span></a>'
						 	menuHtml += '</li>'
						}
						$(".tab-menu ul").append(menuHtml);
						
						initPetschoolHome();
					}
				};
				ajax.call(options);
			}
			
			function onThumbAPIReady() {
			    thumbApi.ready();
			};
			
			//APP일 경우 영상 상세 이동 URL 페이지 호출
			function goUrl(funcNm, type, url) {
				toNativeData.func = funcNm;
				toNativeData.type = type;
				toNativeData.url = url;
				
				toNative(toNativeData);
			}
			
			//앱에서 뒤로가기
			function backHistory() {
				/*if(document.referrer.indexOf("tv/home") > -1){
					location.href = document.referrer;
				} else {
					history.go(-1);
				}*/
				
				//location.href = "/tv/home";
				//storageHist.getOut("${requestScope['javax.servlet.forward.servlet_path']}");
				storageHist.goBack();
			}
			
			//펫스쿨 상세 이동
			function fncGoSchoolDetail(vdId){
				location.href="/tv/school/indexTvDetail?vdId="+vdId;
				//storageHist.goBack("/tv/school/indexTvDetail?vdId="+vdId);
			}
			
			//페이지 이동[storageHist사용]
			function fncGoStoragHist(url){
				storageHist.goBack(url);
			}
			
			//페이지 이동
			function fncGoUrl(url){
				location.href = url;
			}
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">		  
		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container page tv schoolHome" id="container">
			<div class="inr">			
				<!-- 본문 -->
				<div class="contents" id="contents">
                    <div class="inner-wrap">

						<!-- 모바일 서브헤드 -->
<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
<header class="header pc cu mode2-1" data-header="set2-1" style="height:0;">
	<div class="hdr">
		<div class="inr">
			<div class="tdt">
				<div class="usr">
					<em class="lv vvip">VVIP</em>
					<em class="lv vip">VIP</em>
					<em class="lv family">패밀리</em>
					<em class="lv welcome">웰컴</em>
					<a href="javascript:;" class="name"><b class="t">홍길동</b><i class="i">님</i></a>
					<div class="sbm">
						<ul class="sm">
							<li><a href="javascript:;" class="bt">비밀번호 설정</a></li>
							<li><a href="javascript:;" class="bt">회원정보 수정</a></li>
							<li><a href="javascript:;" class="bt">로그아웃</a></li>
						</ul>
					</div>
				</div>
				<ul class="menu">
					<li><a href="javascript:;" class="bt">회원가입</a></li>
					<li><a href="javascript:;" class="bt">로그인</a></li>
					<li><a href="javascript:;" class="bt">이벤트</a></li>
					<li class="custo">
						<a href="javascript:;" class="bt">고객센터</a>
						<div class="sbm">
							<ul class="sm">
								<li><a href="javascript:;" class="bt">FAQ</a></li>
								<li><a href="javascript:;" class="bt">1:1문의</a></li>
								<li><a href="javascript:;" class="bt">공지사항</a></li>
							</ul>
						</div>
					</li>
				</ul>
			</div>
			<div class="hdt">
				<!-- mobile -->
				<button class="mo-header-btnType02">취소</button><!-- on 클래스 추가 시 활성화 -->
				<!-- // mobile -->
				<button class="btnGnb" type="button">메뉴</button>
				<!-- -->
				<h1 class="logo shop" style="display:none;"><a class="bt" href="../../_html/shop/Shop_01.html">AboutPet</a></h1>
				<!-- -->
				
				<!-- mobile -->
				<button class="mo-header-backNtn" onclick="backHistory();" style="display:block">뒤로</button>
				<h2 class="subtit" style="font-size: 18rem; font-weight: 700; margin-left: 0; text-overflow: ellipsis; overflow: hidden; white-space: nowrap; max-width: 35vh; display: inline-block; vertical-align: middle; margin-right: 10px;">펫스쿨</h2>
				<nav class="menushop">
					<button type="button" class="bt st">강아지</button>
					<div class="list">
						<ul class="menu">
							<c:forEach var="petGbs" items="${petGbs}">
								<li id="selPetGb${petGbs.dtlCd}" <c:if test="${petGbCd eq petGbs.dtlCd }">class="active"</c:if>><a class="bt" href="#" onclick="fnPetGb('${petGbs.dtlCd}'); return false;"><b class="t">${petGbs.dtlNm }</b></a></li>
							</c:forEach>
						</ul>
					</div>
				</nav>
				
				<div class="mo-heade-tit"><span class="tit">타이틀</span></div>
				<div class="mo-header-rightBtn">
					<button class="mo-header-btnType01">
						<span class="mo-header-icon"></span>
						시리즈목록
					</button>
				</div>
				<button class="mo-header-close"></button>
				<!-- // mobile -->
				<nav class="tmenu">
					<ul class="list">
						<li class="tv"><a href="../../_html/tv/TV_01.html" class="bt">펫TV</a></li>
						<li class="log"><a href="../../_html/log/LOG_01.html" class="bt">펫로그</a></li>
						<li class="shop"><a href="../../_html/shop/Shop_01.html" class="bt">펫샵</a></li>
						<li class="my"><a href="../../_html/my/MY_01_01.html" class="bt">MY</a></li>
					</ul>
				</nav>
			</div>
			<div class="cdt">
				<div class="schs">
					<div class="form">
						<input type="text" class="kwd" placeholder="어바웃펫이 만든 깐깐사료 30% 할인">
						<button type="button" class="btnSch">검색</button>
						<div class="key-word-list" style="display:none;"><!-- 자동완성 드롭박스 -->
							<ul>
								<li><a href="javascript:;">고양이 <span>사료</span></a></li>
								<li><a href="javascript:;">강아지 <span>사료</span></a></li>
								<li><a href="javascript:;">애견 <span>사료</span></a></li>
								<li><a href="javascript:;">개<span>사료</span></a></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="menu">
					<button class="bt alim on" type="button">알림</button><!-- .on 알림있음-->
					<button class="bt cart" type="button"><em class="n">2</em>장바구니</button>
					<button class="bt close" type="button">닫기</button>
					<div class="alims">
						<ul class="alist">
							<li class="log">
								<a href="javascript:;" class="box">
									<div class="aht"><em class="tt">펫로그</em> <i class="tm">3분전</i></div>
									<div class="adt">
										<p class="msg">고독한 재롱이 님이 회원님의 사진을 좋아합니다.</p>
									</div>
								</a>
							</li>
							<li class="shop">
								<a href="javascript:;" class="box">
									<div class="aht"><em class="tt">펫Shop</em> <i class="tm">1시간 전</i></div>
									<div class="adt">
										<p class="msg">‘이달의 츄르’ 제품이 재입고 되었습니다.</p>
									</div>
								</a>
							</li>
							<li class="tv">
								<a href="javascript:;" class="box">
									<div class="aht"><em class="tt">펫TV</em> <i class="tm">13시간 전</i></div>
									<div class="adt">
										<p class="msg">달려라 우리 몽자 님이 댓글에서 회원님에게 메세지를 남겼습니다.</p>
									</div>
								</a>
							</li>
							<li class="cm">
								<a href="javascript:;" class="box">
									<div class="aht"><em class="tt">공통 알림</em> <i class="tm">2020년 9월 1일</i></div>
									<div class="adt">
										<p class="msg">업데이트 사항이 공지되었습니다.</p>
									</div>
								</a>
							</li>
							<li class="ev">
								<a href="javascript:;" class="box">
									<div class="aht"><em class="tt">이벤트</em> <i class="tm">2020년 9월 1일</i></div>
									<div class="adt">
										<p class="msg">새로운 이벤트가 등록되었습니다.</p>
									</div>
								</a>
							</li>
							<li class="live">
								<a href="javascript:;" class="box">
									<div class="aht"><em class="tt">라이브</em> <i class="tm">2020년 9월 1일</i></div>
									<div class="adt">
										<p class="msg">새로운 이벤트가 등록되었습니다.</p>
									</div>
								</a>
							</li>
							<!-- <li class="nodata">
								<p class="msg">새로운 알림이 없습니다.</p>
							</li> -->
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</header>
</c:if>
						<%-- <div class="pageHead" style="height:0px; display:none;">
							<div class="inr">
								<div class="hdt">
									<button class="back" type="button" onclick="backHistory();">뒤로가기</button>
									<h2 class="subtit">펫스쿨</h2>
									<nav class="menushop" id="topMenu">
										<button type="button" class="bt st">강아지</button>
										<div class="list">
											<ul class="menu">
												<c:forEach var="petGbs" items="${petGbs}">
													<li id="selPetGb${petGbs.dtlCd}"><a class="bt" href="#" onclick="fnPetGb('${petGbs.dtlCd}'); return false;"><b class="t">${petGbs.dtlNm }</b></a></li>
												</c:forEach>
											</ul>
										</div>
									</nav>
								</div>
								<div class="mdt">
									<button class="bt schs" type="button">검색</button>
									<button class="bt gnbs btnGnb" type="button">메뉴</button>
								</div>
							</div>
						</div> --%>
                        
						<div class="pc-subtit">
							<h2>펫스쿨</h2>
							<c:if test="${fn:length(petGbs) > 0}">
							<nav class="menushop" id="topMenu">
								<button type="button" class="bt st"></button>
								<div class="list">
									<ul class="menu">
										<c:forEach var="petGbs" items="${petGbs}">
											<li id="selPetGb${petGbs.dtlCd}" <c:if test="${petGbCd eq petGbs.dtlCd }">class="active"</c:if>><a class="bt" href="#" onclick="fnPetGb('${petGbs.dtlCd}'); return false;">${petGbs.dtlNm }</a></li>
										</c:forEach>
									</ul>
								</div>
							</nav>
							</c:if>
						</div>
						<!-- //pc-subtit -->
						
						<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
						<section class="main">
							<div class="swiper-div h-div" id="mainBanner">
								<div class="swiper-container space">
									<ul class="swiper-wrapper" id="mainBannerLi">
										<c:forEach var="mainBanner" items="${mainBanner}">
										<li class="swiper-slide">
											<div class="thumb-box">
												<%-- APP에서 펫스쿨 상세 기존 onNewPage 호출 ==> 페이지 호출방식으로 변경 / 펫스쿨 상세는 pc, mo, app 모두 호출방식 동일함.
												<c:choose>
													<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10 or view.deviceGb eq frontConstants.DEVICE_GB_20}">
														<a href="/tv/school/indexTvDetail?vdId=${mainBanner.vdId}" class="thumb-img" style="background-image:url(${fn:indexOf(mainBanner.bnrImgPathPc, 'cdn.ntruss.com') > -1 ? mainBanner.bnrImgPathPc : frame:optImagePath(mainBanner.bnrImgPathPc, frontConstants.IMG_OPT_QRY_350)});"></a>
													</c:when>
													<c:otherwise>
														<a href="javascript:goUrl('onNewPage', 'TV', '${view.stDomain}/tv/school/indexTvDetail?vdId=${mainBanner.vdId}')" class="thumb-img" style="background-image:url(${fn:indexOf(mainBanner.bnrImgPathPc, 'cdn.ntruss.com') > -1 ? mainBanner.bnrImgPathPc : frame:optImagePath(mainBanner.bnrImgPathPc, frontConstants.IMG_OPT_QRY_350)});"></a>
													</c:otherwise>
												</c:choose>
												--%>
												
												<a href="#" onclick="fncGoUrl('/tv/school/indexTvDetail?vdId=${mainBanner.vdId}'); return false;" class="thumb-img" style="background-image:url(${fn:indexOf(mainBanner.bnrImgPathPc, 'cdn.ntruss.com') > -1 ? mainBanner.bnrImgPathPc : frame:optImagePath(mainBanner.bnrImgPathPc, frontConstants.IMG_OPT_QRY_350)});"></a>
											</div>
										</li>
										</c:forEach>
									</ul>
									<div class="swiper-pagination"></div>
								</div>
								<div class="remote-area">
									<button type="button" class="swiper-button-prev"></button>
									<button type="button" class="swiper-button-next"></button>
								</div><!-- 03.30 추가 -->
							</div>
							<!-- //Swiper -->
						</section>
						</c:if>
						
						<c:if test="${((view.deviceGb eq frontConstants.DEVICE_GB_20 and memberVO.petSchlYn eq 'N') or (view.deviceGb eq frontConstants.DEVICE_GB_20 and session.mbrNo eq frontConstants.NO_MEMBER_NO))
						or ((view.deviceGb eq frontConstants.DEVICE_GB_30 and memberVO.petSchlYn eq 'N') or (view.deviceGb eq frontConstants.DEVICE_GB_30 and session.mbrNo eq frontConstants.NO_MEMBER_NO))}">
						<section class="main">
							<div class="swiper-div h-div" id="mainBanner">
								<div class="swiper-container">
									<ul class="swiper-wrapper" id="mainBannerLi">
										<c:forEach var="mainBanner" items="${mainBanner}">
										<li class="swiper-slide">
											<div class="thumb-box">
												<%-- APP에서 펫스쿨 상세 기존 onNewPage 호출 ==> 페이지 호출방식으로 변경 / 펫스쿨 상세는 pc, mo, app 모두 호출방식 동일함.
												<c:choose>
													<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10 or view.deviceGb eq frontConstants.DEVICE_GB_20}">
														<a href="/tv/school/indexTvDetail?vdId=${mainBanner.vdId}" class="thumb-img" style="background-image:url(${fn:indexOf(mainBanner.bnrImgPathL, 'cdn.ntruss.com') > -1 ? mainBanner.bnrImgPathL : frame:optImagePath(mainBanner.bnrImgPathL, frontConstants.IMG_OPT_QRY_90)});"></a>
													</c:when>
													<c:otherwise>
														<a href="javascript:goUrl('onNewPage', 'TV', '${view.stDomain}/tv/school/indexTvDetail?vdId=${mainBanner.vdId}')" class="thumb-img" style="background-image:url(${fn:indexOf(mainBanner.bnrImgPathL, 'cdn.ntruss.com') > -1 ? mainBanner.bnrImgPathL : frame:optImagePath(mainBanner.bnrImgPathL, frontConstants.IMG_OPT_QRY_90)});"></a>
													</c:otherwise>
												</c:choose>
												--%>
												
												<a href="#" onclick="fncGoUrl('/tv/school/indexTvDetail?vdId=${mainBanner.vdId}'); return false;" class="thumb-img" style="background-image:url(${fn:indexOf(mainBanner.bnrImgPathL, 'cdn.ntruss.com') > -1 ? mainBanner.bnrImgPathL : frame:optImagePath(mainBanner.bnrImgPathL, frontConstants.IMG_OPT_QRY_751)});"></a>
											</div>
										</li>
										</c:forEach>
									</ul>
									<div class="swiper-pagination"></div>
								</div>
								<div class="remote-area">
									<button type="button" class="swiper-button-prev"></button>
									<button type="button" class="swiper-button-next"></button>
								</div><!-- 03.30 추가 -->
							</div>
							<!-- //Swiper -->
						</section>
						</c:if>
						
						<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_20 and memberVO.petSchlYn eq 'Y'
						or view.deviceGb eq frontConstants.DEVICE_GB_30 and memberVO.petSchlYn eq 'Y'}">
						<section class="main">
							<div class="swiper-div small" id="mainBanner">
								<div class="swiper-container space">
									<ul class="swiper-wrapper" id="mainBannerLi">
										<c:forEach var="mainBanner" items="${mainBanner}">
										<li class="swiper-slide">
											<div class="thumb-box">
												<%-- APP에서 펫스쿨 상세 기존 onNewPage 호출 ==> 페이지 호출방식으로 변경 / 펫스쿨 상세는 pc, mo, app 모두 호출방식 동일함.
												<c:choose>
													<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10 or view.deviceGb eq frontConstants.DEVICE_GB_20}">
														<a href="/tv/school/indexTvDetail?vdId=${mainBanner.vdId}" class="thumb-img" style="background-image:url(${fn:indexOf(mainBanner.bnrImgPathS, 'cdn.ntruss.com') > -1 ? mainBanner.bnrImgPathS : frame:optImagePath(mainBanner.bnrImgPathS, frontConstants.IMG_OPT_QRY_90)});"></a>
													</c:when>
													<c:otherwise>
														<a href="javascript:goUrl('onNewPage', 'TV', '${view.stDomain}/tv/school/indexTvDetail?vdId=${mainBanner.vdId}')" class="thumb-img" style="background-image:url(${fn:indexOf(mainBanner.bnrImgPathS, 'cdn.ntruss.com') > -1 ? mainBanner.bnrImgPathS : frame:optImagePath(mainBanner.bnrImgPathS, frontConstants.IMG_OPT_QRY_90)});"></a>
													</c:otherwise>
												</c:choose>
												--%>
											
												<a href="#" onclick="fncGoUrl('/tv/school/indexTvDetail?vdId=${mainBanner.vdId}'); return false;" class="thumb-img" style="background-image:url(${fn:indexOf(mainBanner.bnrImgPathS, 'cdn.ntruss.com') > -1 ? mainBanner.bnrImgPathS : frame:optImagePath(mainBanner.bnrImgPathS, frontConstants.IMG_OPT_QRY_792)});"></a>
											</div>
										</li>
										</c:forEach>
									</ul>
									<div class="swiper-pagination"></div>
								</div>
								<div class="remote-area">
									<button type="button" class="swiper-button-prev"></button>
									<button type="button" class="swiper-button-next"></button>
								</div><!-- 03.30 추가 -->
							</div>
							<!-- //Swiper -->
						</section>
						</c:if>

						<section class="tab-menu">
							<div class="inner swiper-container">
								<ul class="uiTab a swiper-wrapper">
								<c:forEach var="listGb" items="${listGb}" varStatus="idx">
									<li data-btn-sid="edu0${idx.count }"  class="swiper-slide" name="ctgNm">
										<a class="bt" href="#e${idx.count}"><span>${listGb}</span></a>
									</li>
								</c:forEach>
								</ul>
							</div>
						</section>
						<div class="deucation tab-cont">
						<c:forEach var="listGb" items="${listGb}" varStatus="idx">
							<section data-sid="edu0${idx.count}" data-index="${idx.index}" id="e${idx.count }" name="ctgContList">
								<div class="tit-area">
									<h3>${listGb}</h3>
									<div class="level">
										<div class="lv3"><!-- 난이도별 class lv1, lv2, lv3 -->
											<span>난이도1</span>
										</div>
										<strong>: 난이도</strong>
									</div>
								</div>
								
								<p class="info-text">
									반려동물과 보호자의 유대감을 쌓는 첫 걸음! 차근차근 함께 학습해 보아요.
								</p>

								<div class="edu-list" id="baseEdu">
									<div class="list-total">총 <em class="baseCnt" id="liSize${idx.index }">개</em> 중 <em class="nth" id="listSizeOk${idx.index}">개</em> 학습완료</div>
									<ul id="baseEduLi">
									<c:forEach var="educationList" items="${educationList }">
									<c:if test="${educationList.ctgMnm eq listGb}">
										<li>
											<c:if test="${educationList.newYn eq 'Y' }">
												<i class="icon-n" name="newIcon">N</i>
											</c:if>
											<div class="thumb-box" onclick="fncGoSchoolDetail('${educationList.vdId}');" style="cursor:pointer;" data-content="${educationList.vdId}" data-url="/tv/school/indexTvDetail?vdId=${educationList.vdId}">
												<%-- APP에서 펫스쿨 상세 기존 onNewPage 호출 ==> 페이지 호출방식으로 변경 / 펫스쿨 상세는 pc, mo, app 모두 호출방식 동일함.
												<c:choose>
													<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10 or view.deviceGb eq frontConstants.DEVICE_GB_20}">
														<a href="/tv/school/indexTvDetail?vdId=${educationList.vdId}" class="thumb-img" style="background-image:url(${fn:indexOf(educationList.thumPath, 'cdn.ntruss.com') > -1 ? educationList.thumPath : frame:optImagePath(educationList.thumPath, frontConstants.IMG_OPT_QRY_30)});" data-content="${educationList.vdId}" data-url="/tv/school/indexTvDetail?vdId=${educationList.vdId}">
															<c:if test="${educationList.stepProgress ne null and educationList.stepProgress ne ''}">
																<div class="progress-bar" style="width:${educationList.stepProgress}%;"></div>
															</c:if>
														</a>
													</c:when>
													<c:otherwise>
														<a href="javascript:goUrl('onNewPage', 'TV', '${view.stDomain}/tv/school/indexTvDetail?vdId=${educationList.vdId}')" class="thumb-img" style="background-image:url(${fn:indexOf(educationList.thumPath, 'cdn.ntruss.com') > -1 ? educationList.thumPath : frame:optImagePath(educationList.thumPath, frontConstants.IMG_OPT_QRY_30)});" data-content="${educationList.vdId}" data-url="${view.stDomain}/tv/school/indexTvDetail?vdId=${educationList.vdId}">
															<c:if test="${educationList.stepProgress ne null and educationList.stepProgress ne ''}">
																<div class="progress-bar" style="width:${educationList.stepProgress}%;"></div>
															</c:if>
														</a>
													</c:otherwise>
												</c:choose>
												--%>
												
												<a href="#" onclick="return false;" class="thumb-img" style="background-image:url(${fn:indexOf(educationList.thumPath, 'cdn.ntruss.com') > -1 ? educationList.thumPath : frame:optImagePath(educationList.thumPath, frontConstants.IMG_OPT_QRY_784)});">
													<c:if test="${educationList.stepProgress ne null and educationList.stepProgress ne ''}">
														<div class="progress-bar" style="width:${educationList.stepProgress}%;"></div>
													</c:if>
												</a>
												<div class="thumb-info gray">
													<%-- APP에서 펫스쿨 상세 기존 onNewPage 호출 ==> 페이지 호출방식으로 변경 / 펫스쿨 상세는 pc, mo, app 모두 호출방식 동일함.
													<c:choose>
														<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10 or view.deviceGb eq frontConstants.DEVICE_GB_20}">
															<a href="/tv/school/indexTvDetail?vdId=${educationList.vdId}" class="tlt">${educationList.ttl}</a>
														</c:when>
														<c:otherwise>
															<a href="javascript:goUrl('onNewPage', 'TV', '${view.stDomain}/tv/school/indexTvDetail?vdId=${educationList.vdId}')" class="tlt">${educationList.ttl}</a>
														</c:otherwise>
													</c:choose>
													--%>
													
													<a href="#" onclick="return false;" class="tlt" style="overflow:hidden; text-overflow:ellipsis; white-space:nowrap; display:block;">${educationList.ttl}</a>
													<span class="level lv${educationList.lodCd}"><!-- 난이도별 class lv1, lv2, lv3 -->
														<span>난이도1</span>
														<span>난이도2</span>
														<span>난이도3</span>
													</span>
												</div>
											</div>
										</li>
										</c:if>
										</c:forEach>
									</ul>
								</div>
							</section>
							</c:forEach>
						</div>
                    </div>
				</div>
            </div>
        </main>
        
        <!-- 플로팅 버튼 -->
        <jsp:include page="/WEB-INF/tiles/include/floating.jsp">
             <jsp:param name="floating" value="${view.deviceGb eq frontConstants.DEVICE_GB_10 ? '' : 'talk'}"  />
        </jsp:include>
        
	</tiles:putAttribute>
</tiles:insertDefinition>