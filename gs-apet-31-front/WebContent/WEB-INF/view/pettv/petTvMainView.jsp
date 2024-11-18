<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.inline">
		<script src="<spring:eval expression="@bizConfig['vod.player.api.url']" />/thumb_api/v1.js"></script>
		<style>
	        /* 소리가 켜져있을때 아이콘 */
	        .v_mutd_on{
	            width:30px;
	            height:30px;
	            border-radius:100%;
	            background-color:rgba(0,0,0,0.5);
	            background-image:url(<spring:eval expression="@bizConfig['aboutpet.sgr.url']" />/dist/images/speaker-high-fill-white.svg);
	            background-position:center;
	            background-size:50%;
	            background-repeat:no-repeat;
				/*position:absolute; top:20px; right:20px;*/
	        };
	       
	        /* 음소거 상태의 아이콘 */
	        .v_mutd_off{
	            width:30px;
	            height:30px;
	            border-radius:100%;
	            background-color:rgba(0,0,0,0.5);
	            background-image:url(<spring:eval expression="@bizConfig['aboutpet.sgr.url']" />/dist/images/speaker-slash-fill-white.svg);
	            background-position:center;
	            background-size:50%;
	            background-repeat:no-repeat;
				/*position:absolute; top:20px; right:20px;*/
	        };
	    </style>
		<c:choose>
			<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
				<script>
					var swiperTag;
				  
				  	$(document).ready(function(){
					  	$("[id^=tagVodListBtn]").eq(0).addClass('on');
					  
					  	//$("#tagLists").css("height", "234.97px");
					  	
		            	// Swiper 메인
						var swiperMain = new Swiper('.main .swiper-container', {
							loop: true,
							speed: 600,
							slideToClickedSlide: true,
							slidesPerView: "auto",
							slidesPerGroup:1,
							freeMode: false,
							centeredSlides: true,
							pagination: {
								el: '.swiper-pagination',
							},
							navigation: {
								nextEl: '.main .swiper-button-next',
								prevEl: '.main .swiper-button-prev',
							},
							breakpoints: {
								1300: {
									slidesPerView: "auto",
								}
							}
						});
						
						// Swiper 펫스쿨
						var swiperSchool = new Swiper('.school .swiper-container', {
							slidesPerView: 5,
							spaceBetween: 50,
							navigation: {
								nextEl: '.school .swiper-button-next',
								prevEl: '.school .swiper-button-prev',
							}
						});
						
						// Swiper 독점
						var swiper3 = new Swiper('.alone .swiper-container', {
							slidesPerView: 3,
							spaceBetween: 18,
							centeredSlides: false,
							navigation: {
								nextEl: '.alone .swiper-button-next',
								prevEl: '.alone .swiper-button-prev',
							}
						});
						
						// Swiper 신규
						var swiperNew = null;
						$(".main .swiper-slide:eq("+(swiperMain.activeIndex)+")").prevAll().addClass("preve");
						swiperNew = new Swiper('.new .swiper-container', {
							slidesPerView: 3,
							spaceBetween: 18,
							navigation: {
								nextEl: '.new .swiper-button-next',
								prevEl: '.new .swiper-button-prev',
							}
						});
						
						if($("#ulId li").length > 4) {
			            	$('.new .swiper-button-next').removeClass("swiper-button-disabled");
			            }
						
						// Swiper 맞춤
						var swiperFit = new Swiper('.fit .swiper-container', {
							slidesPerView: 4,
							spaceBetween: 16,
							navigation: {
								nextEl: '.fit .swiper-button-next',
								prevEl: '.fit .swiper-button-prev',
							}
						});
						
						// Swiper 인기
						var swiperPopul = new Swiper('.popul .swiper-container', {
							slidesPerView: 4,
							spaceBetween: 16,
							navigation: {
								nextEl: '.popul .swiper-button-next',
								prevEl: '.popul .swiper-button-prev',
							}
						});
						
						// Swiper 태그 관심
						swiperTag = new Swiper('.tag .swiper-container', {
							slidesPerView: 4,
							spaceBetween: 16,
							navigation: {
								nextEl: '.tag .swiper-button-next',
								prevEl: '.tag .swiper-button-prev',
							}
						});
						
						// Swiper 최근
						var swiperRecent = new Swiper('.recent .swiper-container', {
							slidesPerView: "auto",
							spaceBetween: 22,
							navigation: {
								nextEl: '.recent .swiper-button-next',
								prevEl: '.recent .swiper-button-prev',
							}
						});
						
						// progress
						var wTimer = null;
						if($(".circlePie").length && $(".recent").css("display") !== "none"){
							var price = $(".circlePie").width();
							//$(window).resize(function(){
							$(document).ready(function(){
								if(wTimer !== null) {clearTimeout(wTimer);}
								wTimer = setTimeout(function(){
									price = $(".circlePie").width();
									createPie();
								},1000);
							});
							//createPie();
							function createPie(p){
								$(".circlePie").each(function(i,n){
									var can = document.createElement("canvas");
									var ctx = can.getContext("2d");
									var p = ($(n).data("p") !== undefined)?$(n).data("p"):80;
									//console.log("price : " + price);
									can.width = price;
									can.height = price;
									ctx.beginPath();
									//ctx.fillStyle = "black";
									ctx.moveTo((price / 2),(price / 2));
									ctx.translate((price / 2),(price / 2));
									//ctx.arc(0,0,60,Math.PI * 0, Math.PI * 0.1,false);
									ctx.fill();
									ctx.font = 'bold 20px serif';
									$(n).html("").append(can);
									drowC(p,can,ctx);
								});
								function drowC(angle,can,ctx){
									var n = 0;
									var max = 30;
									var angle = (angle * 3.6) * (2 / 36);
									var add = (angle / max);
									var timer = setInterval(function(){
										n += add;
										if(n >= angle) n = angle;
										ctx.translate(-10,-10);
										ctx.clearRect(0,0,can.width,can.height);
										ctx.translate(10,10);
										ctx.rotate(Math.PI * -0.5);
										ctx.beginPath();
										ctx.fillStyle="#669aff";
										ctx.moveTo(0,0);
										ctx.arc(0,0,(price / 2),Math.PI*0,Math.PI*(n * 0.1),false);
										ctx.fill();
										ctx.closePath();
										ctx.beginPath();
										ctx.arc(0,0,((price / 2) - 4),0,Math.PI*2);
										ctx.fillStyle="white";
										ctx.fill();
										ctx.closePath();
										ctx.textAlign = "center";
										ctx.fillStyle ="red";
										ctx.rotate(Math.PI * 0.5);
										if(n >= max){
											clearInterval(timer);
										};
									},50)
								};
							};
						};
						
						// Swiper TV 전시 - 시리즈 TAG, 동영상 TAG, 시리즈(미고정), 동영상(미고정)
						$(".exhibition").each(function(index, element){
							var $this = $(this);
							$this.addClass('list' + index);
							
							var seriesSwiper = new Swiper('.list' + index + ' .swiper-container', {
								slidesPerView : 4,
								spaceBetween: 16,
								navigation: {
									nextEl: $(".list" + index)
										.find(".remote-area ")
										.children(".swiper-button-next"),
									prevEl: $(".list" + index)
										.find(".remote-area ")
										.children(".swiper-button-prev"),
								}
							});
						});
					});
				  
					//관심 태그 관련 영상 목록(PC)
					function vodTagList(tagNo, dupleVdIds) {
						$("[id^=tagVodListBtn]").removeClass('on');
						$("#tagVodListBtn"+tagNo).addClass('on');
						
			          	$("#tagLists").empty();
			          	var options = {
		          			url : "/tv/tvTagVodList"
		          			, data : {
		          				tagNo : tagNo
		          				, dupleVdIds : dupleVdIds
		          			}
		          			, done : function(data) {
		          				for(i in data.tagVodList) {
		          					if(data.tagVodList[i].thumPath.indexOf('cdn.ntruss.com') != -1){
						              	thumPath = data.tagVodList[i].thumPath;
						          	}else{
						              	thumPath = "${frame:optImagePath('"+ data.tagVodList[i].thumPath +"', frontConstants.IMG_OPT_QRY_750)}";
						          	}
								  
								  	if(data.tagVodList[i].srisPrflImgPath.indexOf('cdn.ntruss.com') != -1){
						              	srisPrflImgPath = data.tagVodList[i].srisPrflImgPath;
						          	}else{
					          			srisPrflImgPath = "${frame:optImagePath('"+ data.tagVodList[i].srisPrflImgPath +"', frontConstants.IMG_OPT_QRY_785)}";
						          	}
								  
		          					var html = '';
		          					html += '<li class="swiper-slide">';
		          					html += 	'<div class="thumb-box">';
		           					html += 		'<a href="#" onclick="fncGoUrl(\'/tv/series/indexTvDetail?vdId='+data.tagVodList[i].vdId+'&sortCd=&listGb=HOME\'); return false;" class="thumb-img" style="background-image:url(' + thumPath + ');">';
		       					 	html += 			'<div class="time-tag"><span>'+ data.tagVodList[i].totLnth +'</span></div>';
		       					 	html += 		'</a>';
		          					html += 		'<div class="thumb-info top">';
		         					html += 			'<div class="round-img-pf" onclick="fncGoUrl(\'/tv/series/petTvSeriesList?srisNo='+data.tagVodList[i].srisNo+'&sesnNo=1\');" style="background-image:url(' + srisPrflImgPath + '); cursor:pointer;"></div>';
		          					html += 			'<div class="info">';
		          					html += 				'<div class="tlt">';
		          					html += 					'<a href="#" onclick="fncGoUrl(\'/tv/series/indexTvDetail?vdId='+data.tagVodList[i].vdId+'&sortCd=&listGb=HOME\'); return false;">';
		       					 	html += 						data.tagVodList[i].ttl;
		       					 	html += 					'</a>';
		          					html +=					'</div>';
		          					html += 				'<div class="detail">';
		          					/* html += 					'<span class="read play">' + data.tagVodList[i].hits + '</span>'; */
		          					html += 					'<span class="read like">'+ data.tagVodList[i].likeCnt +'</span>';
		          					html += 				'</div>';
		          					html += 			'</div>';
		          					html += 		'</div>';
		          					html += 	'</div>';
		          					html += '</li>';
		          					 
		          					$("#tagLists").append(html);
		          				}
		          			
			          			var url = "fncGoUrl('/tv/hashTagList?tagNo="+tagNo+"'); return false;";
								$("#hashTagVodList").attr("onclick", url);
									
								swiperTag.update();
								swiperTag.slideTo(0);
		          			}
			          	};
			          	ajax.call(options);
			        }
					
					//링크이동 버튼
					function orderPageBtnClick(linkUrl, title){
						if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30 }"){ // APP인경우
							if (linkUrl.indexOf("http://") > -1 || linkUrl.indexOf("https://")  > -1 ) {
								// 데이터 세팅
								toNativeData.func = 'onOrderPage';
								toNativeData.url = linkUrl;
								toNativeData.title = title;
								// 호출
								toNative(toNativeData);
							}else {
								location.href=linkUrl;
								//storageHist.goBack(linkUrl);
							}
						}else{
							location.href=linkUrl;
							//storageHist.goBack(linkUrl);
						}
					}
				</script>
	       	</c:when>
	       	<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_20 }">
				<script>
					var swiperTag;
				 
					$(document).ready(function() {
						//initView('ulId', 3);
						
						$("#header_pc").addClass("show");
						
						$("[id^=tagVodListBtn]").eq(0).addClass('on');
						
						//$("#tagLists").css("height", "153px");
						
						if("${session.mbrNo}" != "${FrontWebConstants.NO_MEMBER_NO}") {
						  	var nickNm = $("#nickNm").text().length;
						  	if(nickNm > 7) {
							  	$("#nickNm").text($("#nickNm").text().substr(0, 7)+ '...');
						  	}
					  	}
						
			         	// Swiper 메인
						var swiperMain = new Swiper('.main .swiper-container', {
							loop: true,
							speed: 600,
							slidesPerView: "auto",
							slidesPerGroup:1,
							freeMode: false,
							pagination: {
								el: '.swiper-pagination',
							}
						});
						
						// Swiper 펫스쿨
						var swiperSchool = new Swiper('.school .swiper-container', {
							slidesPerView: "auto",
							spaceBetween: 8,
							navigation: {
								nextEl: '.school .swiper-button-next',
								prevEl: '.school .swiper-button-prev',
							}
						});
						
						// Swiper 독점
						var swiper3 = new Swiper('.alone .swiper-container', {
							slidesPerView: "auto",
							spaceBetween: 8,
							centeredSlides: true,
							slideToClickedSlide: true,
							loop: true,
							loopAdditionalSlides: 2,		//루프 생성 후 복제할 슬라이드 수 추가
							navigation: {
								nextEl: '.alone .swiper-button-next',
								prevEl: '.alone .swiper-button-prev',
							}
						});
						
						// Swiper 맞춤
						var swiperFit = new Swiper('.fit .swiper-container', {
							slidesPerView: "auto",
							spaceBetween: 8, 	//APET-1219 210901 lju02 - 간격 수정
							navigation: {
								nextEl: '.fit .swiper-button-next',
								prevEl: '.fit .swiper-button-prev',
							}
						});
						
						// Swiper 인기
						var swiperPopul = new Swiper('.popul .swiper-container', {
							slidesPerView: "auto",
							spaceBetween: 8, 	//APET-1219 210901 lju02 - 간격 수정
							navigation: {
								nextEl: '.popul .swiper-button-next',
								prevEl: '.popul .swiper-button-prev',
							}
						});
						
						// Swiper 태그 관심
						swiperTag = new Swiper('.tag .swiper-container', {
							slidesPerView: "auto",
							spaceBetween: 8, 	//APET-1219 210901 lju02 - 간격 수정
							navigation: {
								nextEl: '.tag .swiper-button-next',
								prevEl: '.tag .swiper-button-prev',
							}
						});
			            
			         	// Swiper 최근
						var swiperRecent = new Swiper('.recent .swiper-container', {
							slidesPerView: "auto",
							spaceBetween: 22,
							navigation: {
								nextEl: '.recent .swiper-button-next',
								prevEl: '.recent .swiper-button-prev',
							},	//APET-1219 210901 lju02 - 아래 추가하면서 콤마 추가 필수
							breakpoints: {	//APET-1219 210901 lju02 - 모바일에서의 간격 추가
								800: {
									spaceBetween: 8,
								}
							}
						});
						
						// progress
						var wTimer = null;
						if($(".circlePie").length && $(".recent").css("display") !== "none"){
							var price = $(".circlePie").width();
							//$(window).resize(function(){
							$(document).ready(function(){
								if(wTimer !== null) {clearTimeout(wTimer);}
								wTimer = setTimeout(function(){
									price = $(".circlePie").width();
									createPie();
								},1000);
							});
							//createPie();
							function createPie(p){
								$(".circlePie").each(function(i,n){
									var can = document.createElement("canvas");
									var ctx = can.getContext("2d");
									var p = ($(n).data("p") !== undefined)?$(n).data("p"):80;
									can.width = price;
									can.height = price;
									ctx.beginPath();
									//ctx.fillStyle = "black";
									ctx.moveTo((price / 2),(price / 2));
									ctx.translate((price / 2),(price / 2));
									//ctx.arc(0,0,60,Math.PI * 0, Math.PI * 0.1,false);
									ctx.fill();
									ctx.font = 'bold 20px serif';
									$(n).html("").append(can);
									drowC(p,can,ctx);
								});
								function drowC(angle,can,ctx){
									var n = 0;
									var max = 30;
									var angle = (angle * 3.6) * (2 / 36);
									var add = (angle / max);
									var timer = setInterval(function(){
										n += add;
										if(n >= angle) n = angle;
										ctx.translate(-10,-10);
										ctx.clearRect(0,0,can.width,can.height);
										ctx.translate(10,10);
										ctx.rotate(Math.PI * -0.5);
										ctx.beginPath();
										ctx.fillStyle="#669aff";
										ctx.moveTo(0,0);
										ctx.arc(0,0,(price / 2),Math.PI*0,Math.PI*(n * 0.1),false);
										ctx.fill();
										ctx.closePath();
										ctx.beginPath();
										ctx.arc(0,0,((price / 2) - 4),0,Math.PI*2);
										ctx.fillStyle="white";
										ctx.fill();
										ctx.closePath();
										ctx.textAlign = "center";
										ctx.fillStyle ="red";
										ctx.rotate(Math.PI * 0.5);
										if(n >= max){
											clearInterval(timer);
										};
									},50)
								};
							};
						};
						
						// Swiper TV 전시 - 시리즈 TAG, 동영상 TAG, 시리즈(미고정), 동영상(미고정)
						$(".exhibition").each(function(index, element){
							var $this = $(this);
							$this.addClass('list' + index);
							
							var seriesSwiper = new Swiper('.list' + index + ' .swiper-container', {
								slidesPerView : "auto",
								spaceBetween: 8,
								navigation: {
									nextEl: $(".list" + index)
										.find(".remote-area ")
										.children(".swiper-button-next"),
									prevEl: $(".list" + index)
										.find(".remote-area ")
										.children(".swiper-button-prev"),
								}
							});
						});
					});
					
					function initView(el_id, view_item_count, style) {
						var menu = document.getElementById(el_id);
						var menu_list = menu.getElementsByTagName('li');
						var menu_count = menu_list.length;
						style = (typeof(style) != 'undefined') ? style : 'block';
						
						for(var i=0;i<menu_count;i++){
							if(i<view_item_count) menu_list[i].style.display = style;
							else menu_list[i].style.display = 'none';
						}
					}
				
					//관심 태그 관련 영상 목록(MO-WEB)
					function vodTagList(tagNo, dupleVdIds) {
						$("[id^=tagVodListBtn]").removeClass('on');
						$("#tagVodListBtn"+tagNo).addClass('on');
						
			        	$("#tagLists").empty();
			        	var options = {
		        			url : "/tv/tvTagVodList"
		        			, data : {
		        				tagNo : tagNo
		        				, dupleVdIds : dupleVdIds
		        			}
		        			, done : function(data) {
		        				for(i in data.tagVodList) {
		        					if(data.tagVodList[i].thumPath.indexOf('cdn.ntruss.com') != -1){
						              	thumPath = data.tagVodList[i].thumPath;
						          	}else{
						              	thumPath = "${frame:optImagePath('"+ data.tagVodList[i].thumPath +"', frontConstants.IMG_OPT_QRY_750)}";
						          	}
								  
								  	if(data.tagVodList[i].srisPrflImgPath.indexOf('cdn.ntruss.com') != -1){
						              	srisPrflImgPath = data.tagVodList[i].srisPrflImgPath;
						          	}else{
						              	srisPrflImgPath = "${frame:optImagePath('"+ data.tagVodList[i].srisPrflImgPath +"', frontConstants.IMG_OPT_QRY_786)}";
						          	}
								  
		        					var html = '';
		        					html += '<li class="swiper-slide">';
		        					html += 	'<div class="thumb-box">';
		        					html += 		'<a href="#" onclick="fncGoUrl(\'/tv/series/indexTvDetail?vdId='+data.tagVodList[i].vdId+'&sortCd=&listGb=HOME\'); return false;" class="thumb-img" style="background-image:url(' + thumPath + ');">';
		        					html += 			'<div class="time-tag"><span>'+ data.tagVodList[i].totLnth +'</span></div>';
		        					html += 		'</a>';
		        					html += 		'<div class="thumb-info top">';
		        					html += 			'<div class="round-img-pf" onclick="fncGoUrl(\'/tv/series/petTvSeriesList?srisNo='+data.tagVodList[i].srisNo+'&sesnNo=1\');" style="background-image:url(' + srisPrflImgPath + '); cursor:pointer;"></div>';
		        					html += 			'<div class="info">';
		        					html += 				'<div class="tlt">';
		           					html += 					'<a href="#" onclick="fncGoUrl(\'/tv/series/indexTvDetail?vdId='+data.tagVodList[i].vdId+'&sortCd=&listGb=HOME\'); return false;">'+data.tagVodList[i].ttl;+'</a>';
		           					html +=					'</div>';
		        					html += 				'<div class="detail">';
		        					/* html += 					'<span class="read play">' + data.tagVodList[i].hits + '</span>'; */
		        					html += 					'<span class="read like">'+ data.tagVodList[i].likeCnt +'</span>';
		        					html += 				'</div>';
		        					html += 			'</div>';
		        					html += 		'</div>';
		        					html += 	'</div>';
		        					html += '</li>';
		        					 
		        					$("#tagLists").append(html);
								}
		        			
		        				if(data.tagVodList.length == 10) {
		        					var btnHtml = '';
			        				btnHtml += 	'<li class="swiper-slide btn-more">';
			        				btnHtml += 		'<a href="#" onclick="fncGoUrl(\'/tv/hashTagList?tagNo='+tagNo+'\'); return false">';
			        				btnHtml += 			'<button type="button">';
			        				btnHtml += 				'<i>더보기</i>';
			        				btnHtml += 		'</button>';
			        				btnHtml += 		'</a>';
			        				btnHtml += 	'</li>';
		    					
		    						$("#tagLists").append(btnHtml);
		        				} else {
		        					var btnHtml = '';
		        					btnHtml += 	'<li class="swiper-slide btn-more swiper-slide-next" style="margin-right: 8px;">'
		        					btnHtml += 		'<div style="width:62.53px;">'
		        					btnHtml += 		'</div>'
		        					btnHtml += 	'</li>'
		        				
		        					$("#tagLists").append(btnHtml);
		        				}
		        			
		        				swiperTag.update();
		    		            swiperTag.slideTo(0);
		        			}
			        	};
			        	ajax.call(options);
			        }
					
					//링크이동 버튼
					function orderPageBtnClick(linkUrl, title){
						if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30 }"){ // APP인경우
							if (linkUrl.indexOf("http://") > -1 || linkUrl.indexOf("https://")  > -1 ) {
								// 데이터 세팅
								toNativeData.func = 'onOrderPage';
								toNativeData.url = linkUrl;
								toNativeData.title = title;
								// 호출
								toNative(toNativeData);
							}else {
								location.href=linkUrl;
								//storageHist.goBack(linkUrl);
							}
						}else{
							location.href=linkUrl;
							//storageHist.goBack(linkUrl);
						}
					}
		    	</script>
		    	<!-- 20210126 변경 끝 -->
			</c:when>
			<c:otherwise>
				<script>
					//App 자동재생여부 default
					let autoPlayFlag = false;
					var swiperTag;
					
					$(document).ready(function() {
						//initView('ulId', 3);
						
						$("[id^=tagVodListBtn]").eq(0).addClass('on');
						
						//$("#tagLists").css("height", "153px");
						
						if("${session.mbrNo}" != "${FrontWebConstants.NO_MEMBER_NO}") {
							  var nickNm = $("#nickNm").text().length;
							  if(nickNm > 7) {
								  $("#nickNm").text($("#nickNm").text().substr(0, 7)+ '...');
							  }
						}
						
						//자동재생 제어
						//fncAutoFlag(); 펫TV 홈/ 영상목록에서 자동재생 삭제로 인해 주석처리-CSR-1247
						
			         	// Swiper 메인
						var swiperMain = new Swiper('.main .swiper-container', {
							loop: true,
							speed: 600,
							slidesPerView: "auto",
							slidesPerGroup:1,
							freeMode: false,
							pagination: {
								el: '.swiper-pagination',
							}
						});
						
						// Swiper 펫스쿨
						var swiperSchool = new Swiper('.school .swiper-container', {
							slidesPerView: "auto",
							spaceBetween: 8,
							navigation: {
								nextEl: '.school .swiper-button-next',
								prevEl: '.school .swiper-button-prev',
							}
						});
						
						// Swiper 독점
						var swiper3 = new Swiper('.alone .swiper-container', {
							slidesPerView: "auto",
							spaceBetween: 8,
							centeredSlides: true,
							slideToClickedSlide: true,
							loop: true,
							loopAdditionalSlides: 2,		//루프 생성 후 복제할 슬라이드 수 추가
							navigation: {
								nextEl: '.alone .swiper-button-next',
								prevEl: '.alone .swiper-button-prev',
							}
						});
						
						// Swiper 맞춤
						var swiperFit = new Swiper('.fit .swiper-container', {
							slidesPerView: "auto",
							spaceBetween: 8, 	//APET-1219 210901 lju02 - 간격 수정
							navigation: {
								nextEl: '.fit .swiper-button-next',
								prevEl: '.fit .swiper-button-prev',
							}
						});
						
						// Swiper 인기
						var swiperPopul = new Swiper('.popul .swiper-container', {
							slidesPerView: "auto",
							spaceBetween: 8, 	//APET-1219 210901 lju02 - 간격 수정
							navigation: {
								nextEl: '.popul .swiper-button-next',
								prevEl: '.popul .swiper-button-prev',
							}
						});
						
						// Swiper 태그 관심
						swiperTag = new Swiper('.tag .swiper-container', {
							slidesPerView: "auto",
							spaceBetween: 8, 	//APET-1219 210901 lju02 - 간격 수정
							navigation: {
								nextEl: '.tag .swiper-button-next',
								prevEl: '.tag .swiper-button-prev',
							}
						});
						
						// Swiper 최근
						var swiperRecent = new Swiper('.recent .swiper-container', {
							slidesPerView: "auto",
							spaceBetween: 22,
							navigation: {
								nextEl: '.recent .swiper-button-next',
								prevEl: '.recent .swiper-button-prev',
							},	//APET-1219 210901 lju02 - 아래 추가하면서 콤마 추가 필수
							breakpoints: {	//APET-1219 210901 lju02 - 모바일에서의 간격 추가
								800: {
									spaceBetween: 8,
								}
							}
						});
						
						// progress
						var wTimer = null;
						if($(".circlePie").length && $(".recent").css("display") !== "none"){
							var price = $(".circlePie").width();
							//$(window).resize(function(){
							$(document).ready(function(){
								if(wTimer !== null) {clearTimeout(wTimer);}
								wTimer = setTimeout(function(){
									price = $(".circlePie").width();
									createPie();
								},1000);
							});
							//createPie();
							function createPie(p){
								$(".circlePie").each(function(i,n){
									var can = document.createElement("canvas");
									var ctx = can.getContext("2d");
									var p = ($(n).data("p") !== undefined)?$(n).data("p"):80;
									can.width = price;
									can.height = price;
									ctx.beginPath();
									//ctx.fillStyle = "black";
									ctx.moveTo((price / 2),(price / 2));
									ctx.translate((price / 2),(price / 2));
									//ctx.arc(0,0,60,Math.PI * 0, Math.PI * 0.1,false);
									ctx.fill();
									ctx.font = 'bold 20px serif';
									$(n).html("").append(can);
									drowC(p,can,ctx);
								});
								function drowC(angle,can,ctx){
									var n = 0;
									var max = 30;
									var angle = (angle * 3.6) * (2 / 36);
									var add = (angle / max);
									var timer = setInterval(function(){
										n += add;
										if(n >= angle) n = angle;
										ctx.translate(-10,-10);
										ctx.clearRect(0,0,can.width,can.height);
										ctx.translate(10,10);
										ctx.rotate(Math.PI * -0.5);
										ctx.beginPath();
										ctx.fillStyle="#669aff";
										ctx.moveTo(0,0);
										ctx.arc(0,0,(price / 2),Math.PI*0,Math.PI*(n * 0.1),false);
										ctx.fill();
										ctx.closePath();
										ctx.beginPath();
										ctx.arc(0,0,((price / 2) - 4),0,Math.PI*2);
										ctx.fillStyle="white";
										ctx.fill();
										ctx.closePath();
										ctx.textAlign = "center";
										ctx.fillStyle ="red";
										ctx.rotate(Math.PI * 0.5);
										if(n >= max){
											clearInterval(timer);
										};
									},50)
								};
							};
						};
						
						// Swiper TV 전시 - 시리즈 TAG, 동영상 TAG, 시리즈(미고정), 동영상(미고정)
						$(".exhibition").each(function(index, element){
							var $this = $(this);
							$this.addClass('list' + index);
							
							var seriesSwiper = new Swiper('.list' + index + ' .swiper-container', {
								slidesPerView : "auto",
								spaceBetween: 8,
								navigation: {
									nextEl: $(".list" + index)
										.find(".remote-area ")
										.children(".swiper-button-next"),
									prevEl: $(".list" + index)
										.find(".remote-area ")
										.children(".swiper-button-prev"),
								}
							});
						});
					});
					
					/*function initView(el_id, view_item_count, style) {
						var menu = document.getElementById(el_id);
						var menu_list = menu.getElementsByTagName('li');
						var menu_count = menu_list.length;
						style = (typeof(style) != 'undefined') ? style : 'block';
						
						for(var i=0;i<menu_count;i++){
							if(i<view_item_count) menu_list[i].style.display = style;
							else menu_list[i].style.display = 'none';
						}
					}*/
					
					/* 펫TV 홈/ 영상목록에서 자동재생 삭제로 인해 주석처리-CSR-1247
					window.onload = function() {
						if(autoPlayFlag == true) {
			            	//자동재생 여부 true인 경우 인기영상 순위 append
			    			for(var i = 0; i < $("#popVod li").length; i++) {
			    				$("#popVod li").eq(i).children('.thumb-box').append("<strong class='ranking' style='z-index:999;'>"+(i+1)+"</strong>");
			    			}
			            }
					}
					
					//자동재생여부
					function fncAutoFlag(){
						if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true"){ //APP
							//자동재생여부 판단
							// 데이터 세팅
							toNativeData.func = "onIsAutoPlay";
							toNativeData.callback = "appIsAutoPlay";
							// APP 호출
							toNative(toNativeData);
						}
					}
					
					//App 자동재생여부값
					function appIsAutoPlay(jsonString){
						var parseData = JSON.parse(jsonString);
						var autoPlay = parseData.isAutoPlay;
						
						if(autoPlay == "Y"){
							autoPlayFlag = true;
							$(".autoTrue").show();
						}else{
							autoPlayFlag = false;
							$("a[name=autoFalse]").show();
							$(".autoTrue").hide();
						}
					}
					
					function onThumbAPIReady() {
					    thumbApi.ready();
					};
					*/
			        
					$(".v_mutd_off, .v_mutd_on").on("click", function(e) {
						e.preventDefault();
					});
					
					//관심 태그 관련 영상 목록(APP)
					function vodTagList(tagNo, dupleVdIds) {
						$("[id^=tagVodListBtn]").removeClass('on');
						$("#tagVodListBtn"+tagNo).addClass('on');
						
			        	$("#tagLists").empty();
			        	var options = {
		        			url : "/tv/tvTagVodList"
		        			, data : {
		        				tagNo : tagNo
		        				, dupleVdIds : dupleVdIds
		        			}
		        			, done : function(data) {
			        			for(i in data.tagVodList) {
			        				if(data.tagVodList[i].thumPath.indexOf('cdn.ntruss.com') != -1){
							        	thumPath = data.tagVodList[i].thumPath;
							        }else{
							            thumPath = "${frame:optImagePath('"+ data.tagVodList[i].thumPath +"', frontConstants.IMG_OPT_QRY_750)}";
							        }
			        				
			        				if(data.tagVodList[i].srisPrflImgPath.indexOf('cdn.ntruss.com') != -1){
							            srisPrflImgPath = data.tagVodList[i].srisPrflImgPath;
							        }else{
							            srisPrflImgPath = "${frame:optImagePath('"+ data.tagVodList[i].srisPrflImgPath +"', frontConstants.IMG_OPT_QRY_786)}";
							        }
									  
			        				var html = '';
		        					html += '<li class="swiper-slide">';
		   							html += 	'<div class="thumb-box">';
			   							
			   						<%-- 펫TV 홈/ 영상목록에서 자동재생 삭제로 인해 주석처리-CSR-1247
			   						if(autoPlayFlag == true) {
			   							html +=		'<div class="vthumbs autoTrue" video_id="'+data.tagVodList[i].outsideVdId+'" type="video_thumb_360p" lazy="scroll" style="height:80px" onclick="goUrl(\'onNewPage\', \'TV\', \'${view.stDomain}/tv/series/indexTvDetail?vdId='+data.tagVodList[i].vdId+'&sortCd=&listGb=HOME\');">';
			     						html += 		'<a href="javascript:goUrl(\'onNewPage\', \'TV\', \'${view.stDomain}/tv/series/indexTvDetail?vdId='+data.tagVodList[i].vdId+'&sortCd=&listGb=HOME\')" class="thumb-img" style="background-image:url(' + thumPath + ');">';
			         					html += 			'<div class="time-tag"><span>'+ data.tagVodList[i].totLnth +'</span></div>';
			         					html += 		'</a>';
			         					html += 	'<div>';
			   					 	} else {
			   						 	html += 	'<a href="javascript:goUrl(\'onNewPage\', \'TV\', \'${view.stDomain}/tv/series/indexTvDetail?vdId='+data.tagVodList[i].vdId+'&sortCd=&listGb=HOME\')" name="autoFalse" class="thumb-img" style="background-image:url(' + thumPath + ');">';
			  					 		html += 		'<div class="time-tag"><span>'+ data.tagVodList[i].totLnth +'</span></div>';
			  					 	 	html += 	'</a>';
			   					 	}
			   					 	--%>
			   					 	
		   					 		html += 		'<a href="#" onclick="goUrl(\'onNewPage\', \'TV\', \'${view.stDomain}/tv/series/indexTvDetail?vdId='+data.tagVodList[i].vdId+'&sortCd=&listGb=HOME\'); return false;" name="autoFalse" class="thumb-img" style="background-image:url(' + thumPath + ');">';
						 			html += 			'<div class="time-tag"><span>'+ data.tagVodList[i].totLnth +'</span></div>';
						 	 		html += 		'</a>';
						 	 		html += 		'<div class="thumb-info top" style="margin-top: 10px;">';
						 	 		html += 			'<div class="round-img-pf" onclick="fncGoUrl(\'/tv/series/petTvSeriesList?srisNo='+data.tagVodList[i].srisNo+'&sesnNo=1\');" style="background-image:url(' + srisPrflImgPath + '); cursor:pointer;"></div>';
						 	 		html += 			'<div class="info">';
			        				html += 				'<div class="tlt">';
			        				html += 					'<a href="#" onclick="goUrl(\'onNewPage\', \'TV\', \'${view.stDomain}/tv/series/indexTvDetail?vdId='+data.tagVodList[i].vdId+'&sortCd=&listGb=HOME\'); return false;">'+ data.tagVodList[i].ttl +'</a>';
			        				html +=					'</div>';
			        				html += 				'<div class="detail">';
			        				//html += 					'<span class="read play">' + data.tagVodList[i].hits + '</span>';
			        				html += 					'<span class="read like">'+ data.tagVodList[i].likeCnt +'</span>';
			        				html += 				'</div>';
			        				html += 			'</div>';
			        				html += 		'</div>';
				   					html += 	'</div>';
				   					html += '</li>';
		        					 
		        					$("#tagLists").append(html);
								}
			        			
			        			if(data.tagVodList.length == 10) {
			        				var btnHtml = '';
				        			btnHtml += 	'<li class="swiper-slide btn-more">';
				        			btnHtml += 		'<a href="#" onclick="fncGoUrl(\'/tv/hashTagList?tagNo='+tagNo+'\'); return false;">';
				        			btnHtml += 			'<button type="button">';
				        			btnHtml += 				'<i>더보기</i>';
				        			btnHtml += 			'</button>';
				        			btnHtml += 		'</a>';
				        			btnHtml += 	'</li>';
				      				
				      				$("#tagLists").append(btnHtml);
			        			} else {
			        				var btnHtml = '';
			        				btnHtml += 	'<li class="swiper-slide btn-more swiper-slide-next" style="margin-right: 8px;">'
			        				btnHtml += 		'<div style="width:62.53px;">'
			        				btnHtml += 		'</div>'
			        				btnHtml += 	'</li>'
			        				
			        				$("#tagLists").append(btnHtml);
			        			}
			        			
			        			swiperTag.update();
			      	            swiperTag.slideTo(0);
					            //onThumbAPIReady(); 펫TV 홈/ 영상목록에서 자동재생 삭제로 인해 주석처리-CSR-1247
		        			}
			        	};
			        	ajax.call(options);
			        }
					
					//링크이동 버튼
					function orderPageBtnClick(linkUrl, title){
						if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30 }"){ // APP인경우
							if (linkUrl.indexOf("http://") > -1 || linkUrl.indexOf("https://")  > -1 ) {
								// 데이터 세팅
								toNativeData.func = 'onOrderPage';
								toNativeData.url = linkUrl;
								toNativeData.title = title;
								// 호출
								toNative(toNativeData);
							}else {
								location.href=linkUrl;
								//storageHist.goBack(linkUrl);
							}
						}else{
							location.href=linkUrl;
							//storageHist.goBack(linkUrl);
						}
					}
					
					//APP일 경우 영상 상세 이동 URL 페이지 호출
					function goUrl(funcNm, type, url) {
					  	//videoAllPauses();
						toNativeData.func = funcNm;
						toNativeData.type = type;
						toNativeData.url = url;
						
						toNative(toNativeData);
					}
		    	</script>
			</c:otherwise>
		</c:choose>
		<script type="text/javascript">
			var mn = parseInt("${session.mbrNo}");
			if(window.opener != null && mn != 0 && $(opener.document).find("#sns-connecting").length>0){
				window.opener.adapter();
				window.opener.childWin = null;
				self.close();
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
		<main class="container page tv home" id="container">
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<c:forEach var="cornerList" items="${cornerList}"  varStatus="status" >
						<c:import url="/WEB-INF/view/pettv/include/${cornerList.dispCornPage}">
							<c:param name="dispCornNo" value="${cornerList.dispCornNo}" />
						</c:import>
					</c:forEach>
				</div>
			</div>
		</main>
		
		 <!-- 플로팅 버튼 -->
        <jsp:include page="/WEB-INF/tiles/include/floating.jsp">
             <jsp:param name="floating" value="${view.deviceGb eq frontConstants.DEVICE_GB_10 ? '' : 'talk'}"  />
        </jsp:include>
				
	</tiles:putAttribute>
</tiles:insertDefinition>
