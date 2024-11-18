<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<tiles:insertDefinition name="no_lnb">
	<tiles:putAttribute name="script.include" value="script.petshop"/>
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript" 	src="/_script/file.js"></script>
		<script type="text/javascript">
			userActionLog('${goods.goodsId}', 'view', document.referrer);
			var timeDealArr = new Array();
			
			// 데이터 레이어 선언
			var digitalData = digitalData || {};
			digitalData.productInfo = {
	             "name": "${goods.goodsNm}",                                                            
	             "id": "${goods.goodsId}",                                                       
	             "category": "${goods.cateNmLUnderbar} / ${goods.cateNmMUnderbar} / ${goods.cateNmSUnderbar}",   
	             "brand": "${goods.bndNmKo}",     
	             "price": "${goods.saleAmt}"
	        }; 
			
			$(function(){
				// 최근 본 상품 
				if("${goods.adminYn}" != "Y"){  //BO에서 왔을때는 최근본 상품목록 제외
					if("${session.mbrNo}" != "" && "${session.mbrNo}" != "${frontConstants.NO_MEMBER_NO}"){ // 로그인 여부
						// DB 입력 / 조회
						recentGoods.getListFromDb();
						recentGoods.setCookie();
					}else{
						// cookie 입력 / 조회
						recentGoods.getListFromCookie();
					}
				}

				/**
				 * 상품상세 모바일 헤더 html 변경
				 */
				$("#header_pc").addClass('noneAc');
				<c:if test="${deviceGb ne frontConstants.DEVICE_GB_10 }">
					//대표 이미지
					var imgPath = '${frame:optImagePath( dlgtImgPath , frontConstants.IMG_OPT_QRY_756 )}';
					$('#header_pc .mo-heade-tit img').attr('src',imgPath );
					
					$(".mo-header-backNtn").attr("onclick", "fncGoBack();");
				</c:if>

				<c:forEach var="price" items="${goodsPrices}" varStatus="status" >
					<c:if test="${price.goodsAmtTpCd eq '20'}">
						timeDealArr.push('${price.goodsPrcNo}_${price.goodsAmtTpCd}_${price.dealType}');
					</c:if>
				</c:forEach>

				fnDealTime();
				<c:if test="${view.deviceGb == frontConstants.DEVICE_GB_30 }">
				//애드브릭스
				onProductViewData.func = 'onProductView';
				onProductViewData.productModels.productId = '${goods.goodsId}';
				onProductViewData.productModels.productName = '${goods.goodsNm}';
				onProductViewData.productModels.price = ${goods.saleAmt};
				onProductViewData.productModels.quantity = 1;
				onProductViewData.productModels.discount = ${goods.orgSaleAmt-goods.saleAmt};
				onProductViewData.productModels.currency = 1;
				onProductViewData.productModels.categorys = [];
				onProductViewData.productModels.productDetailAttrs = {};
				onProductViewData.eventAttrs= {};
				// 호출
				toNativeAdbrix(onProductViewData);
				</c:if>

			});
			
			window.addEventListener("load", function(event) {

				// 연관상품 장바구니 썸네일 클릭시 장바구니 영역 자동 활성화
				fnOpenCartViewFromRelatedGoods(); 
			});
			
			function fncGoBack(){
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
				
				if("${requestScope['javax.servlet.forward.query_string']}".indexOf('home=shop') > -1){
					storageHist.goBack('/shop/home/');
				}else if (
						storageReferrer.get().indexOf('/shop/indexCategory') > -1
					|| storageReferrer.get().indexOf('/shop/indexBestGoodsList') > -1
					|| storageReferrer.get().indexOf('/shop/indexNewCategory') > -1
					|| storageReferrer.get().indexOf('/commonSearch') > -1
					|| storageReferrer.get().indexOf('/customer/inquiry/inquiryView') > -1
					|| storageReferrer.get().indexOf('/mypage/order/indexPurchaseRequest') > -1
					|| storageReferrer.get().indexOf('/mypage/order/indexPurchaseCompletion') > -1
					|| storageReferrer.get().indexOf('/mypage/order/indexCancelCompletion') > -1
					|| storageReferrer.get().indexOf('/mypage/order/indexReturnCompletion') > -1
					|| storageReferrer.get().indexOf('/mypage/order/indexExchangeCompletion') > -1
						) {
					storageHist.goHistoryBack(storageReferrer.get());
				} else if (storageReferrer.get().indexOf('/shop/indexLive') > -1 ) {
					storageHist.setHist(); // storageHist.goBack()에서 pop이후 이동하기 때문에 현재페이지를 push 해줌.
					storageHist.goBack();
				}else{
					storageHist.goBack();
				}
			}
			
			function fnDealTime() {
				
				for(var i in timeDealArr) {
					var goodsPrcNo = timeDealArr[i].split('_')[0];
					var goodsAmtTpCd = timeDealArr[i].split('_')[1];
					var dealType = timeDealArr[i].split('_')[2];
					var dre = $("#goodsPrcNo_"+goodsPrcNo).val();
					var timeDeal = new Date(dre.replace(/\s/, 'T'));
					
					var curTime = "${currentTime}";
					var serverTime = new Date(curTime.replace(/\s/, 'T'));
					var now = new Date();
					var dateGap = serverTime.getTime() - now.getTime();
					var realTime = timeDeal - dateGap;

					
					$("#time_"+goodsPrcNo).countdown(realTime, function(event) {
						
						var resultTime = ( event.strftime('%D') != 0 ? event.strftime('%D') + '<spring:message code ='front.web.view.common.day.title'/>  ' : '' ) + event.strftime('%H:%M:%S');
						
						if(goodsAmtTpCd == '20' && dealType == 'NOW') {
							document.getElementById("time_"+goodsPrcNo).innerHTML = '<em class="tt"><spring:message code ='front.web.view.goods.timedeal.title'/></em> <em class="tm">⌛️ '+ resultTime + ' <spring:message code ='front.web.view.common.remaining.title'/></em>';
						} else if(goodsAmtTpCd == '20' && dealType == 'SOON' ) {
							document.getElementById("time_"+goodsPrcNo).innerHTML = '<em class="tt"><spring:message code ='front.web.view.goods.timedeal.release.title'/></em> <em class="tm">'+ resultTime + ' <spring:message code ='front.web.view.common.remaining.title'/></em>';
						}
					}).on('finish.countdown', function () {
						if(goodsAmtTpCd == '20' && dealType == 'NOW') {
							ui.alert('<spring:message code ='front.web.view.goods.timedeal.end.msg'/>',{
							    ycb:function(){
							    	location.href="/shop/home";
							    },
							    ybt:"<spring:message code ='front.web.view.common.msg.confirmation'/>"
							});
						}
				    });
				}
			}
			
			// 배송 시간 카운트
			function deliveryTime(targetId, targetTime){
				
				var curTime = "${currentTime}";
				var serverTime = new Date(curTime.replace(/\s/, 'T'));
				var now = new Date();
				var dateGap = serverTime.getTime() - now.getTime();
				var realTime = targetTime - dateGap;
				
				$("[name='"+targetId+"Hour']").countdown(realTime, function(event) {
					$("[name='"+targetId+"Hour']").text(event.strftime('%H'));
					$("[name='"+targetId+"Min']").text(event.strftime('%M'));
	            });   
			}

			/**
			 * 숫자 세자리 ,
			 */
			/* function numberWithCommas(num) {
				return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			} */
			
			// 금액 콤마 처리.
			function numberWithCommas(x) {
				x = String(x);
				var pattern = /(-?\d+)(\d{3})/;
				while (pattern.test(x))
					x = x.replace(pattern, "$1,$2");
				return x;
			}
			
			// 콤마 삭제
			function removeComma(str) {
				str = String(str);
				return str.replace(/[^0-9\.]+/g, '');
			}

			/**
			 * 기획전
			 */
			function fnGoExhibit(exhbtGbCd, exhbtNo, dispClsfNo) {
				
				var lnbDispClsfNo = dispClsfNo;
				
					
				if('${frontConstants.PETSHOP_DOG_DISP_CLSF_NO}' == dispClsfNo ) { // 강아지
					lnbDispClsfNo = '${frontConstants.PETSHOP_MAIN_DOG_DISP_CLSF_NO}'
				} else if('${frontConstants.PETSHOP_CAT_DISP_CLSF_NO}' == dispClsfNo ) { // 고양이
					lnbDispClsfNo = '${frontConstants.PETSHOP_MAIN_CAT_DISP_CLSF_NO}'
				} else if('${frontConstants.PETSHOP_FISH_DISP_CLSF_NO}' == dispClsfNo ) { // 관상어
					lnbDispClsfNo = '${frontConstants.PETSHOP_MAIN_FISH_DISP_CLSF_NO}'
				} else if('${frontConstants.PETSHOP_ANIMAL_DISP_CLSF_NO}' == dispClsfNo ) { // 소동물
					lnbDispClsfNo = '${frontConstants.PETSHOP_MAIN_ANIMAL_DISP_CLSF_NO}'
				}
				
				if(exhbtGbCd == '10') {
					// 특별 기획전
					location.href='/event/indexSpecialExhibitionZone?exhbtNo='+exhbtNo+'&dispClsfNo='+lnbDispClsfNo;
				} else {
					location.href='/event/indexExhibitionDetail?exhbtNo='+exhbtNo+'&dispClsfNo='+lnbDispClsfNo;
				}
			}

			/**
			 * 공유하기 버튼
			 */
			 //APETQA-6549 2021/08/06 kjh02 
			function fnShare() {
				var goodsId = '<c:out value="${goods.goodsId}"/>';
		 	 	$.ajax({
					type: "POST",
					url: "/goods/getGoodsShortUrl",
					data : {goodsId : goodsId},
					dataType: "json",
					async: false,
					success: function (shortUrl) {
						//app인 경우
						var deviceGb = "${view.deviceGb}";
						var shareImg = '${frame:optImagePath( dlgtImgPath , frontConstants.IMG_OPT_QRY_756 )}';

						// APP인경우
						if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30 }"){
							// 데이터 세팅
							toNativeData.func = "onShare";
							toNativeData.image = "";
							toNativeData.subject = "${goods.goodsNm}";
							toNativeData.link = shortUrl;
							// 호출
							toNative(toNativeData);
						}else{
							//web인 경우
							copyToClipboard(shortUrl)
						}
						userActionLog(goodsId, 'share');
					},
					error: function (request, status, error) {
						ui.alert("<spring:message code ='front.web.view.common.share.fail.msg'/>");
					}
				});  
			}

			/**
			 * 초대코드 복사
			 * @param val
			 */
			function copyToClipboard(val){
				copyUrl("shrBtn")
				$("#shrBtn").attr("data-clipboard-text",val)
				fnGoodsUiToast("<spring:message code ='front.web.view.common.msg.result.share'/>", "share");
			}

			/**
			 * toast
			 * @param text
			 * @param cls
			 */
			function fnGoodsUiToast(text, cls){
				console.log("fnGoodsUiToast text : " + text);
				ui.toast(text,{
					cls : cls ,
					bot: 74, //바닥에서 띄울 간격
					sec:  3000 //사라지는 시간
				});
			}

			
			function fnSetUiShopPdPicGalleryTop(){
				ui.shop.pdPic.galleryTop = new Swiper(".pdDtPicSld .swiper-container", {
					observer: true,
					observeParents: true,
					watchOverflow:true,
					simulateTouch:false,
					spaceBetween:20,
					zoom:{
						maxRatio: 5
					},
					navigation: {
						nextEl: '.pdDtPicSld .sld-nav .bt.next',
						prevEl: '.pdDtPicSld .sld-nav .bt.prev',
					}
				});
			}
			
			function  fnSetUiShopPdPicGalleryThumbs(){
				ui.shop.pdPic.galleryThumbs = new Swiper(".pdDtThmSld .swiper-container", {
					observer: true,
					observeParents: true,
					// watchOverflow:true,
					spaceBetween: 10,
					//slidesPerView: "auto",
					slidesPerView: 7,
					//slidesPerGroup:1,
					// freeMode: true,
					navigation: {
						nextEl: '.pdDtThmSld .sld-nav .bt.next',
						prevEl: '.pdDtThmSld .sld-nav .bt.prev',
					}
				});
				
			}
			
			//상품 상세 이미지 팝업
			function detailGoodsImgPop(clickImg){
				var options = {
					url : "<spring:url value='/goods/includeGoodsCommentImgPop' />"
					, type : "POST"
					, dataType : "html"
					, data : {
							
					}
					, done : function(result){
						$("#goodsLayers").empty();
		 				$("#goodsLayers").html(result);
		 				
		 				var bigImgHtml = '';
						var thumbImgHtml = '';

						if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10 }"){
							fnSetUiShopPdPicGalleryTop();
							//fnSetUiShopPdPicGalleryThumbs();
						}else{
							fnSetUiShopPdPicGalleryTop();
							fnSetUiShopPdPicGalleryThumbs();
						}

						<c:forEach items="${goodsImgList }" var="img" varStatus="status">
							var img = "${img.imgPath}";
							if(img != null && img.indexOf('cdn.ntruss.com') == -1){
								img = "${frame:optImagePath('"+ img +"', frontConstants.IMG_OPT_QRY_756)}";
							}
						
							bigImgHtml += '<li class="swiper-slide">';
							bigImgHtml += '<div class="box swiper-zoom-container"><span class="pic"><img class="img" src="' + img + '" alt=""></span></div>';
							bigImgHtml += '</li>';
							
							thumbImgHtml += '<li class="swiper-slide">';
							thumbImgHtml += '<a href="javascript:" class="box"><span class="pic"><img class="img" src="'+ img + '" ></span></a>';
							thumbImgHtml += '</li>';
						</c:forEach>

						var initSwipeGalleryTop = false;
						if($("#popPdImgView").prop("style")["cssText"] == ""){
							initSwipeGalleryTop = true;
						}
						
						ui.popLayer.open("popPdImgView");
						
						$("#bigImgArea").html(bigImgHtml);
						$("#thumbImgArea").html(thumbImgHtml);
						$("#pdPopFlag").val("PD");
						$("#imgViewTitle").text("<spring:message code ='front.web.view.goods.img.see.title'/>");
					
						var selectIndex = $(clickImg).parents('ul[name=detailImg]').find('img').index(clickImg);
						
						//ui.shop.pdPic.evt();
						$(document).on("click",".pdDtThmSld .slide>li .box",function(){
							var my_idx = $(this).closest("li").index();
							$(this).closest("li").addClass("active").siblings("li").removeClass("active");
							ui.shop.pdPic.galleryTop.slideTo(my_idx);
						});
						
						ui.shop.pdPic.galleryTop.on('slideChangeTransitionEnd', function(swiper) {
							// this.galleryThumbs.slideTo(2);
							var idx = this.realIndex + 1 ;
							$(".pdDtThmSld .slide>li:nth-child("+ idx +")").addClass("active").siblings("li").removeClass("active");
							ui.shop.pdPic.galleryThumbs.slideTo(this.realIndex-3 < 0 ? 0 : this.realIndex-3);
						});
						
						if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10 }"){
							$(".pdDtThmSld .slide>li .box").eq(selectIndex).click();
						}else{
							if(initSwipeGalleryTop && selectIndex == 0){
								$(".pdDtThmSld .slide>li").eq(selectIndex).addClass("active");
							}else{
								$(".pdDtThmSld .slide>li .box").eq(selectIndex).click();
							}
						}
						//ui.shop.pdPic.galleryTop.slideTo(selectIndex);
					}
				};
				ajax.call(options);
			}
			
			function fnClosePopPdImgView(){
				var flag = $("#pdPopFlag").val();
				if(flag == "PD"){
					var activeImgIndex = $("#bigImgArea>li.swiper-slide-active").index();
					$(".pdThumbSlide .slide>li .box").eq(activeImgIndex).click();
					ui.popLayer.close('popPdImgView');
				}
			}

			function openPopupCoupon() {
				var goodsId = '<c:out value="${goods.goodsId}"/>';
				var goodsCstrtTpCd = '<c:out value="${goods.goodsCstrtTpCd}"/>';
				//쿠폰 목록 조회
				var fnGetCoupons = function(goodsId, goodsCstrtTpCd) {
					//다른 팝업 레이어 닫기
					ui.popBot.close('popDelInfo');   //배송정보 레이어 닫기
					ui.popBot.close('popGiftsInfo');   //사은품 레이어 닫기
					ui.popLayer.close('popRvPicView');   //상품 상세 이미지 팝업
					//쿠폰 팝업 열기
					ui.popLayer.open('popCpnGet');
				}
				fnGetCoupons();
			}
			
			// 최근본 상품 관련함수
			var recentGoods = {
				getListFromDb : function() {		//[로그인시]최근 본 상품 
					var options = {
							url : "<spring:url value='/goods/listRecentGoods' />"
							, type : "POST"
							, dataType : "html"
							, data : {
									rows : "${view.deviceGb eq frontConstants.DEVICE_GB_10 ? 7 : 10}"
									,goodsId : '${goods.goodsId }'
							}
							, done : function(result){
								$("#recentGoodsList").empty();
				 				$("#recentGoodsList").html(result);
				 				ui.shop.recent.using();
							}
						};
						ajax.call(options);
				},
				setCookie : function() {			// 쿠키 셋팅
					var recentCookie = $.cookie("<spring:eval expression="@bizConfig['envmt.gb']" />${frontConstants.COOKIE_RECENT_GOODS}");
				    var recentList = new Array();
				    var thisGoods = {
				    	goodsId : '${goods.goodsId}',
				    	sysRegDtm : new Date().getTime()
				    }
					if(recentCookie != "" && recentCookie != undefined ){	// 쿠키 있는 경우 
						recentList = JSON.parse(recentCookie);
						// 동일 goodsId 삭제 / 오래된 것 삭제
						for( var i=recentList.length -1 ; i >= 0 ; i--){
							var difDtm = thisGoods.sysRegDtm - recentList[i].sysRegDtm ;
							if(recentList[i].goodsId == thisGoods.goodsId || difDtm > 24*60*60*1000){  //동일 goodsId 및 24시간 이상
								recentList.splice(i, 1);
							}
						}
					}
				 	// 해당 goodsId 추가
					recentList.unshift(thisGoods);
					// goodsId 50개이상일 경우 삭제
					var limitCnt = 50;
					if(recentList.length > limitCnt){
						recentList.splice(limitCnt, recentList.length - limitCnt);
					}
					$.cookie("<spring:eval expression="@bizConfig['envmt.gb']" />${frontConstants.COOKIE_RECENT_GOODS}", JSON.stringify(recentList), {expires: 1, path: '/'});
				},
				getListFromCookie : function() {	//[비로그인]최근 본 상품 
				    var goodsIds = new Array();
					var recentCookie = $.cookie("<spring:eval expression="@bizConfig['envmt.gb']" />${frontConstants.COOKIE_RECENT_GOODS}");
				    var recentList = new Array();
				    var thisGoods = {
				    	goodsId : '${goods.goodsId}',
				    	sysRegDtm : new Date().getTime()
				    }
					if(recentCookie != "" && recentCookie != undefined ){	// 쿠키 있는 경우 
						recentList = JSON.parse(recentCookie);
						for(var idx in recentList){	// 기존 최근목록 호출용
							goodsIds.push(recentList[idx].goodsId);
						}
						// 동일 goodsId 삭제 / 오래된 것 삭제
						for( var i=recentList.length -1 ; i >= 0 ; i--){
							var difDtm = thisGoods.sysRegDtm - recentList[i].sysRegDtm ;
							if(recentList[i].goodsId == thisGoods.goodsId || difDtm > 24*60*60*1000){  //동일 goodsId 및 24시간 이상
								recentList.splice(i, 1);
							}
						}
					}
				 	// 해당 goodsId 추가
					recentList.unshift(thisGoods);
					// goodsId 50개이상일 경우 삭제
					var limitCnt = 50;
					if(recentList.length > limitCnt){
						recentList.splice(limitCnt, recentList.length - limitCnt);
					}
					$.cookie("<spring:eval expression="@bizConfig['envmt.gb']" />${frontConstants.COOKIE_RECENT_GOODS}", JSON.stringify(recentList), {expires: 1, path: '/'});
					
					var options = {
						url : "/goods/getrecentGoodsLsit"
						, type : "POST"
						, dataType : "html"
						, data : {
							rows : "${view.deviceGb eq frontConstants.DEVICE_GB_10 ? 7 : 10}"
							,goodsIds : goodsIds
						}
						, done : function(result){
							$("#recentGoodsList").empty();
			 				$("#recentGoodsList").html(result);
			 				ui.shop.recent.using();
						}
					};
					if(goodsIds.length > 0){
						ajax.call(options);
					}
				}
			}
			
			// TV, LOG, LIVE 페이지에서 연관상품의 장바구니 썸네일 클릭시 자동으로 장바구니 펼쳐지도록 처리
			function fnOpenCartViewFromRelatedGoods() {
				
				if ( location.search.indexOf("referFrom=relatedGoodsCartBtn") > -1 ) {
					// 장바구니 버튼 클릭
					$('.bt.btCart').click();
				}				
			}
			
		</script>
	</tiles:putAttribute>

	<tiles:putAttribute name="content">
		<main class="container page shop view" id="container">
			<div class="inr">
				<div class="contents" id="contents">
					<!-- 카테고리 -->
					<jsp:include page="/WEB-INF/view/goods/common/breadcrumb.jsp" />

					<div class="pdTops">

						<!-- 상품 이미지 영역 START -->
						<section class="pdPhoto">
							<!-- 이미지 왼쪽 상단 -->
							<div class="pdThumbSlide">
								<div class="swiper-container">
									<ul class="swiper-wrapper slide">
										<c:forEach items="${goodsImgList }" var="img" varStatus="status">
										<li class="swiper-slide">
											<a href="javascript:" class="box"><span class="pic"><img class="img" src="${frame:optImagePath( img.imgPath , frontConstants.IMG_OPT_QRY_758 )}"  /></span></a>
										</li>
										</c:forEach>
									</ul>
								</div>
							</div>

							<!-- 메인 이미지 영역 START -->
							<div class="pdPhotoSlide">
								<!-- 타임딜 / 재고임박 / 유통기한 임박 -->
								<div class="flags"> 
									<c:if test="${!empty exhibitions}">
										<c:forEach items="${exhibitions}" var="exhibition">
											<a href="javascript:fnGoExhibit('<c:out value="${exhibition.exhbtGbCd}"/>', '<c:out value="${exhibition.exhbtNo}"/>', '<c:out value="${exhibition.upDispClsfNo}"/>');" class="flg pl">
												<em class="tt">기획전</em> <em class="ts"><c:out value="${exhibition.exhbtNm}"/></em>
											</a>
										</c:forEach>
									</c:if>
									<%-- 타임딜 예정일 시 표기 : 타임딜 진행예정인 날짜와 시간 표시 --%>
									<%-- 타임딜 진행 시 표기 : 시작일시부터 마감일시까지, 0일일 시 일자는 숨김처리 --%>
									<c:if test="${!empty goodsPrices}">
										<c:forEach items="${goodsPrices}" var="price" varStatus="status">
											<c:if test="${price.goodsAmtTpCd eq '20' && price.dealType eq 'NOW'}">
												<input type="hidden" id="goodsPrcNo_${price.goodsPrcNo}" value="${price.saleEndDtm}"/>
												<div class="flg" id="time_${price.goodsPrcNo}"><em class="tt"><spring:message code ='front.web.view.goods.timedeal.title'/></em> <em class="tm">⌛️5<spring:message code ='front.web.view.common.day.title'/> 14:38:21 <spring:message code ='front.web.view.common.remaining.title'/></em></div>
											</c:if>
											<c:if test="${price.goodsAmtTpCd eq '20' && price.dealType eq 'SOON'}">
												<input type="hidden" id="goodsPrcNo_${price.goodsPrcNo}" value="${price.saleStrtDtm}"/>
												<div class="flg" id="time_${price.goodsPrcNo}"><em class="tt"><spring:message code ='front.web.view.goods.timedeal.release.title'/></em> <em class="tm"><c:out value="${price.saleStrtDtm}"/> <spring:message code ='front.web.view.goods.open.title'/></em> <em class="dc"><i class="p">20%</i><i class="t"><spring:message code ='front.web.view.goods.discount.title'/></i></em> </div>
											</c:if>
											<c:if test="${price.goodsAmtTpCd eq '40'}">
												<div class="flg"><em class="tt"><spring:message code ='front.web.view.goods.expirationDate.near.title'/></em> <em class="tm"><fmt:formatDate value="${price.expDt}" pattern="YY.MM.dd"/>까지</em></div>
											</c:if>
											<c:if test="${price.goodsAmtTpCd eq '50'}">
												<div class="flg"><em class="tt"><spring:message code ='front.web.view.goods.stock.near.title'/></em> <em class="tm"><frame:num data="${price.webStkQty}"/>개 남음</em> </div>
											</c:if>
										</c:forEach>
									</c:if>
								</div>
								<!-- 메인 이미지 슬라이드 -->
								<div class="swiper-container">
									<div class="swiper-pagination"></div>
									<ul class="swiper-wrapper slide" name="detailImg">
										<c:forEach items="${goodsImgList }" var="img" varStatus="status">
										<li class="swiper-slide">
											<a href="javascript:" class="box">
												<span class="pic">
												<c:if test="${view.deviceGb == frontConstants.DEVICE_GB_10 }">
													<img class="img" onclick="detailGoodsImgPop(this)" src="${frame:optImagePath( img.imgPath , frontConstants.IMG_OPT_QRY_756 )}" >
												</c:if>
												<c:if test="${view.deviceGb != frontConstants.DEVICE_GB_10 }">
													<img class="img" onclick="detailGoodsImgPop(this)" src="${frame:optImagePath( img.imgPath , frontConstants.IMG_OPT_QRY_794 )}" >
												</c:if>
												</span>
											</a>
										</li>
										</c:forEach>
									</ul>
								</div>
							</div>
							<!-- 메인 이미지 영역 END -->
						</section>
						<!-- 상품 이미지 영역 END -->

						<section class="pdInfos p1">

							<!-- 공유하기 -->
							<div class="share"><a href="javascript:void(0)" onclick="fnShare();" class="bt shr" id="shrBtn"><spring:message code ='front.web.view.common.button.share'/></a></div>

							<!-- 아이콘 -->
							<div class="flag">
								<c:set var="iconCnt" value="${not empty goods.cateIcon ? 4 : 5}" />
								<fmt:parseNumber var="iconIdx" value="0" />
								<c:if test="${not empty goods.cateIcon}">
									<em class="fg a"><c:out value="${goods.cateIcon}" escapeXml="false"/></em>
								</c:if>
								<c:forEach items="${fn:split(goods.icons,',')}" var="icon" varStatus="idx">
									<c:if test="${icon ne '타임세일' and icon ne 'MD추천' and icon ne '업체배송' and icon ne '무료배송'}">
										<c:if test="${iconIdx < iconCnt and icon != ''}" >
											<c:choose>
												<c:when test="${icon ne '1+1' and icon ne '2+1' and icon ne '사은품'}">
													<em class="fg c"><c:out value="${icon}" escapeXml="false"/></em>
												</c:when>
												<c:otherwise>
													<em class="fg b"><c:out value="${icon}" escapeXml="false"/></em>
												</c:otherwise>
											</c:choose>
										</c:if>
										<c:set var="iconIdx" value="${iconIdx + 1}"/>
									</c:if>
								</c:forEach>
							</div>

							<!-- 브랜드관 노출/비노출 영역 -->
							<c:if test="${!empty goods.bndNo}">
							<div class="pstore">
								<a href="<c:url value="/brand/indexBrandDetail?bndNo=${goods.bndNo}"/>" class="bt lk">${goods.bndNmKo}</a>
							</div>
							</c:if>

							<!-- 상품명 -->
							<div class="names" >${goods.goodsNm}<c:if test="${fn:length(goods.goodsNm) > 49 }">...</c:if></div>

							<!-- 후기 평점 -->
<%-- 							<c:url var="goodsScoreUrl" value="/goods/getGoodsScore"> --%>
<%-- 								<c:if test="${goods.adminYn eq 'Y'}"> --%>
<%-- 									<c:param name="goodsId" value="${goods.goodsId }"/> --%>
<%-- 								</c:if> --%>
<%-- 								<c:param name="goodsCstrtTpCd" value="${goods.goodsCstrtTpCd}"/> --%>
<%-- 							</c:url> --%>
<%-- 							<c:import url="${goodsScoreUrl}"/> --%>
							<script>
								$.get("/goods/getGoodsScore?goodsId=${goods.goodsId }&goodsCstrtTpCd=${goods.goodsCstrtTpCd}",function (html) { $(".pdInfos .prices").before(html);});
							</script>
							
							<!-- 가격 -->
							<div class="prices">
								<div class="price">
									<c:if test="${goods.orgSaleAmt > goods.saleAmt and ((goods.orgSaleAmt - goods.saleAmt)/goods.orgSaleAmt * 100) > 1 }">
										<span class="disc"><fmt:parseNumber value="${100-((goods.foSaleAmt * 100) / goods.orgSaleAmt)}" integerOnly="true"/>%</span>
									</c:if>
									<span class="prcs"><frame:num data="${goods.saleAmt}" /><i class="w"><spring:message code ='front.web.view.common.moneyUnit.title'/></i></span>
									<c:if test="${goods.orgSaleAmt > goods.saleAmt and ((goods.orgSaleAmt - goods.saleAmt)/goods.orgSaleAmt * 100) > 1 }">
										<span class="ogpc"><frame:num data="${goods.orgSaleAmt}" /><i class="w"><spring:message code ='front.web.view.common.moneyUnit.title'/></i></span>
									</c:if>
								</div>

								<!-- 쿠폰받기 -->
								<div class="coupon" id="isCoupon" style="display: none">
									<a href="javascript:;" onclick="openPopupCoupon();" class="bt cpn"><spring:message code ='front.web.view.goods.coupon.get.title'/></a>
								</div>
								<jsp:include page="/WEB-INF/view/goods/includeNew/includePopupCoupon.jsp" />	<!-- 쿠폰다운 -->
							</div>
							
							<%-- 일치율 비노출로 인해 임시 주석처리 / CSR-1142
							<!-- 맞춤추천 일치율 -->
							<c:url var="goodsRateUrl" value="/goods/getGoodsRate">
								<c:if test="${goods.adminYn eq 'Y'}">
									<c:param name="goodsId" value="${goods.goodsId }"/>
								</c:if>
							</c:url>
							<c:import url="${goodsRateUrl}"/>
							--%>

							<!-- MD PICK 노출/비노출 -->
							<c:if test="${goods.mdRcomYn eq 'Y' && !empty goods.mdRcomWds}">
							<div class="mdmsg mdmsg2">
								<div class="ment">${goods.mdRcomWds }</div>
							</div>
							</c:if>

							<!-- 연관태그 -->
							<div class="tags relaTags">
								<div class="tit"><spring:message code ='front.web.view.common.relatedTags.title'/></div>
								<div class="box">
									<ui class="tgs">
										<c:forEach items="${tagList}" var="goodsTags" end="9" varStatus="idx">
											<li><a href="/shop/indexPetShopTagGoods?tags=${goodsTags.tagNo}&tagNm=${goodsTags.tagNm}" class="tg">#<c:out value="${goodsTags.tagNm}" escapeXml="false"/></a></li>
										</c:forEach>
									</ui>
									<c:if test="${!empty tagList}">
										<div class="more"><a href="javascript:;" class="bt"><spring:message code ='front.web.view.common.seemore.title'/></a></div>
									</c:if>
								</div>
							</div>

							<hr class="hbar">

							<!-- 할인혜택 -->
							<div class="benefit">
								<div class="box">
									<div class="tit"><spring:message code ='front.web.view.goods.discount.benefit.title'/></div>
									<div class="ctn">
										<c:set var="gsPointValue" value="${(goods.saleAmt * memberGradeInfo.svmnRate) / 100}"/>
										<p>GS&POINT <em class="pt"><fmt:formatNumber value="${gsPointValue+(1-(gsPointValue%1))%1}" type="number" pattern="#,###,###"/>P</em> <spring:message code ='front.web.view.goods.save.title'/> </p>
									</div>
								</div>
							</div>

							<!-- 배송정보 -->
							<div class="deliys">
								<div class="box">
									<div class="tit"><spring:message code ='front.web.view.goods.delivery.information.title'/></div>
									<div class="ctn">
										<p><span class="dawn"><span name="dlvrAmt"></span></span></p>
										<p><span class="free"><span name="dlvrFree"></span></span></p>
									</div>
									<a href="javascript:;" class="bt more" onclick="ui.popBot.open('popDelInfo', {'pop':true});"><spring:message code ='front.web.view.common.seemore.title'/></a>
								</div>
								<!-- 배송 추가 정보 -->
								<jsp:include page="/WEB-INF/view/goods/includeNew/includeDeliveryInfo.jsp" />
							</div>

							<!-- 사은품 -->
							<c:url var="goodsGiftsUrl" value="/goods/listGoodsGifts">
								<c:if test="${goods.adminYn eq 'Y'}">
									<c:param name="goodsId" value="${goods.goodsId }"/>
								</c:if>
								<c:param name="goodsCstrtTpCd" value="${goods.goodsCstrtTpCd}"/>
							</c:url>
							<c:import url="${goodsGiftsUrl}"/>
						</section>
					</div>

					<!-- 상품 상세 텝 메뉴 -->
					<div class="pdCtns">
						<div class="tabMenu">
							<div class="inr">
								<ul class="uiTab a menu">
									<li data-btn-sid="pd-inf">
										<a class="bt"  href="javascript:;"><span class="tt"><spring:message code ='front.web.view.goods.information.title'/></span></a>
									</li>
									<li data-btn-sid="pd-mov" style="display:none;">
										<a class="bt"  href="javascript:;"><span class="tt"><spring:message code ='front.web.view.goods.related.Video.title'/></span> <i class="nm" id="contentsTabCnt">${goodsTotalCount.goodsContentsTotal }</i></a>
									</li>
									<li data-btn-sid="pd-rev">
										<a class="bt"  href="javascript:;"><span class="tt"><span class="tt"><spring:message code ='front.web.view.goods.review.title'/></span> <i class="nm" name="pdRevCnt" id="pdRevCnt">0</i></a>
									</li>
									<li data-btn-sid="pd-qna">
										<a class="bt"  href="javascript:;"><span class="tt">Q&amp;A</span> <%-- <i class="nm" name="pdQnaCnt">${goodsTotalCount.goodsQnaTotal }</i> --%></a>
									</li>
								</ul>
							</div>
						</div>

						<!-- 상품정보 -->
						<div class="tabCtns">
							<section class="sec inf" data-sid="pd-inf">
								<c:url var="goodsDetailUrl" value="/goods/getGoodsDetail">
									<c:if test="${goods.adminYn eq 'Y'}">
										<c:param name="goodsId" value="${goods.goodsId }"/>
									</c:if>
									<c:param name="goodsCstrtTpCd" value="${goods.goodsCstrtTpCd}"/>
									<c:param name="igdtInfoLnkYn" value="${goods.igdtInfoLnkYn}"/>
									<c:param name="isTwcCategory" value="${goods.isTwcCategory}"/>
								</c:url>
								<c:import url="${goodsDetailUrl}"/>
							</section>

							<!-- 관련영상 -->
							<section class="sec mov" data-sid="pd-mov" id="contentsMov">
								<jsp:include page="/WEB-INF/view/goods/includeNew/includeMovInfo.jsp" />
							</section>

							<!-- 후기 -->
							<section class="sec rev" data-sid="pd-rev">
								<c:url var="goodsCommentUrl" value="/goods/getGoodsComment">
									<c:if test="${goods.adminYn eq 'Y'}">
										<c:param name="goodsId" value="${goods.goodsId }"/>
									</c:if>
									<c:param name="goodsCstrtTpCd" value="${goods.goodsCstrtTpCd}"/>
								</c:url>
								<c:import url="${goodsCommentUrl}"/>
							</section>

							<!-- Qna -->
							<section class="sec qna" data-sid="pd-qna">
								<jsp:include page="/WEB-INF/view/goods/includeNew/includeGoodsQnaDetail.jsp" />
							</section>

							<!-- 함께 많이 보는 상품 -->
							<c:url var="goodsRecentDetailUrl" value="/goods/listGoodsRecentDetail">
								<c:if test="${goods.adminYn eq 'Y'}">
									<c:param name="goodsId" value="${goods.goodsId }"/>
								</c:if>
							</c:url>
							<c:import url="${goodsRecentDetailUrl}"/>

							<!-- 사용자 맞춤 추천상품 -->
							<c:url var="goodsCustomDetailUrl" value="/goods/listGoodsCustomDetail">
								<c:if test="${goods.adminYn eq 'Y'}">
									<c:param name="goodsId" value="${goods.goodsId }"/>
								</c:if>
							</c:url>
							<c:import url="${goodsCustomDetailUrl}"/>

							<!-- 최근 본 상품 ajax로 변경-->
<%-- 							<c:url var="goodsRecomdDetailUrl" value="/goods/listGoodsRecomdDetail"> --%>
<%-- 								<c:if test="${goods.adminYn eq 'Y'}"> --%>
<%-- 									<c:param name="goodsId" value="${goods.goodsId }"/> --%>
<%-- 								</c:if> --%>
<%-- 								<c:param name="rows" value="${view.deviceGb eq frontConstants.DEVICE_GB_10 ? 7 : 10}"/> --%>
<%-- 								<c:param name="goodsNm" value="${goods.goodsNm}"/> --%>
<%-- 								<c:param name="saleAmt" value="${goods.saleAmt}"/> --%>
<%-- 								<c:param name="orgSaleAmt" value="${goods.orgSaleAmt}"/> --%>
<%-- 								<c:param name="dlgtImgPath" value="${dlgtImgPath}"/> --%>
<%-- 								<c:param name="dlgtImgSeq" value="${dlgtImgSeq}"/> --%>
<%-- 							</c:url> --%>
<%-- 							<c:import url="${goodsRecomdDetailUrl}"/> --%>
							<section class="sec recent" id="recentGoodsList">
							</section>
						</div>
					</div>
				</div>
			</div>
		</main>

		<%-- 사용자 맞춤 추천상품 --%>
		<article class="uiPdOrdPan" id="uiPdOrdPan">
			<input type="hidden" name="goodsItemTotalAmt" id="goodsItemTotalAmt" value="${listItems.saleAmt}" />
			<button type="button" class="btDrag"><spring:message code ='front.web.view.common.open.and.close.btn'/></button>
			<div class="hdts">
				<div class="inr">
					<div class="bts"><button type="button" class="bt close"><spring:message code ='front.web.view.common.close.btn'/></button></div>
					<span class="tit"><spring:message code ='front.web.view.goods.select.title'/></span>
				</div>
			</div>
			<jsp:include page="/WEB-INF/view/goods/includeNew/includeGoodsOrdpanDetail.jsp" />
		</article>
		<jsp:include page="/WEB-INF/view/goods/includeNew/includeGoodsOrdpanCartNavs.jsp" />

       	<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
        	<jsp:param name="floating" value="${view.deviceGb eq frontConstants.DEVICE_GB_10 ? '' : 'top'}" />
        </jsp:include>

		<!-- popup 내용 부분입니다. -->
		<div class="layers" id="goodsLayers">
		</div>
		
		<div class="layers" id="petLogLayers">
			<jsp:include page="/WEB-INF/view/goods/include/indexPetLogCommentDetailList.jsp" />
		</div>

		<script>
        	window.onload = function() {
            	   // 상품 상세페이지 핀치 줌 되도록 수정.
               	$("meta[name=viewport]").attr("content",  "width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=4,  user-scalable=yes");
        	}
        </script>

	</tiles:putAttribute>

	<tiles:putAttribute name="popup">
	</tiles:putAttribute>

</tiles:insertDefinition>