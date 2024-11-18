<%--
  Created by IntelliJ IDEA.
  User: ssh
  Date: 2021-02-17
  Time: 오후 2:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<div id="goodsRelated">
<!--
view.deviceGb               : ${view.deviceGb}
FrontWebConstants.DEVICE_GB_10 : ${FrontWebConstants.DEVICE_GB_10}
relatedWith                 : ${relatedWith}
vdId                        : ${vdId}
petLogNo                    : ${petLogNo}
-->
<c:set var="target" value=""/>
<c:set var="callbackUi" value=""/>

<c:if test="${relatedWith eq 'TV'}">
	<c:choose>
		<c:when test="${view.deviceGb eq FrontWebConstants.DEVICE_GB_10}">
			<c:set var="target" value="#container"/>
			<c:set var="callbackUi">
				$(".prd-layer .btn-close").off("click").on("click", function(e) {
					$('.prd-layer').slideUp('300');
				});

				$(".prd-layer").stop().animate({bottom:0},250);
				new Swiper($(".prd-layer").find('.swiper-container'), {
					slidesPerView: "auto",
					spaceBetween: 20,
					observer: true,
					observeParents: true,
					watchOverflow:true,
					freeMode: false,
					navigation: {
						nextEl: $(".prd-layer").find('.swiper-button-next'),
						prevEl: $(".prd-layer").find('.swiper-button-prev'),
					},
					breakpoints: {
						1023: {
							spaceBetween: 8,
							slidesPerView: "auto",
							slidesPerGroup:1,
							freeMode: true,
						}
					}
				});

				$('.prd-layer').slideDown('300');
				
				$(".page.tv .prd-layer .top").click(function(e){
					e.stopPropagation();
				});
			</c:set>
		</c:when>
		<c:otherwise>
			<c:set var="target" value="#wrap"/>
			<c:set var="callbackUi">
				cartGoods.reloadMiniCart();
				ui.commentBox.open("#goodsRelatedBottomSheet");
				ui.tapTouchAc.init();
			</c:set>
		</c:otherwise>
	</c:choose>
</c:if>

<c:if test="${relatedWith eq 'LOG'}">
	<c:choose>
		<c:when test="${view.deviceGb eq FrontWebConstants.DEVICE_GB_10}">
			<c:set var="target" value=".lcbWebRconBox"/>
			<c:set var="callbackUi">
				ui.commentBox.open(".pop-relation-box");
				new Swiper($(".pop-relation-box").find('.swiper-container'), {
					slidesPerView: "auto",
					spaceBetween: 20,
					observer: true,
					observeParents: true,
					watchOverflow:true,
					freeMode: false,
					navigation: {
						nextEl: $(".pop-relation-box").find('.swiper-button-next'),
						prevEl: $(".pop-relation-box").find('.swiper-button-prev'),
					},
					breakpoints: {
						1023: {
							spaceBetween: 8,
							slidesPerView: "auto",
							slidesPerGroup:1,
							freeMode: true,
						}
					}
				});
			</c:set>
		</c:when>
		<c:otherwise>
			<c:set var="target" value="#popconTingContents"/>
			<c:set var="callbackUi">
				cartGoods.reloadMiniCart();
				<!-- ui.commentBox.open("#goodsRelatedBottomSheet"); -->
				ui.tapTouchAc.init();
			</c:set>
		</c:otherwise>
	</c:choose>
</c:if>

<c:if test="${relatedWith eq 'LIVE'}">
	<c:choose>
		<c:when test="${view.deviceGb eq FrontWebConstants.DEVICE_GB_10}">
		</c:when>
		<c:otherwise>
			<c:set var="target" value="#wrap"/>
			<c:set var="callbackUi">
				cartGoods.reloadMiniCart();
				ui.commentBox.open("#goodsRelatedBottomSheet");
				ui.tapTouchAc.init();
			</c:set>
		</c:otherwise>
	</c:choose>
</c:if>

<script type="text/template" id="relatedGoodsWrap">
	<c:choose>
		<c:when test="${view.deviceGb eq FrontWebConstants.DEVICE_GB_10}">

			<%-- PC인 경우. TV, 로그  -------------------------------------------------------------------------------------------------------------%>
			<c:if test="${relatedWith eq 'TV'}">
				<div class="prd-layer" style="bottom: 0px;">
					<div class="top">
						<div class="inner">
							<h2>연관상품</h2>
							<button class="btn-close" type="button"><span>닫기</span></button>
						</div>
					</div>
					<div class="cont">
						<div class="swiper-div">
							<div class="swiper-container space swiper-container-initialized swiper-container-horizontal">
								<ul class="swiper-wrapper" style="transition-duration: 0ms; transform: translate3d(0px, 0px, 0px);">
									{data}
								</ul>
								<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
							<c:if test="${goodsList != null and fn:length(goodsList)>8}">
								<div class="remote-area">
									<button class="swiper-button-next" type="button"></button>
									<button class="swiper-button-prev" type="button"></button>
								</div>
							</c:if>
							</div>
						<!-- //Swiper -->
					</div>
				</div>
			</c:if>
			<c:if test="${relatedWith eq 'LOG'}">
				<div class="commentBoxAp type01 popconTingBox pop-relation-box open ton" style="bottom: 0px; height: 90%;" data-priceh="60%">
					<div class="head h2 bnone">
						<div class="con">
							<div class="tit">
								연관상품
								<!--
									PC / LOG
									view.deviceGb         : ${view.deviceGb}
									relatedWith           : ${relatedWith}
									-->
							</div>
							<a href="javascript:;" class="close" onclick="ui.commentBox.close(this)"></a>
						</div>
					</div>
					<div class="con">
						<!-- tab -->
						<section class="sect petTabContent">
							<!-- tab header -->
							<ul class="uiTab b">
								<li class="active">
									<a class="bt" href="javascript:;">연관상품</a>
								</li>
								<li class="">
									<a class="bt active" href="javascript:;">장바구니</a>
								</li>
							</ul>
							<!-- // tab header -->
							<!-- tab content -->
							<div class="uiTab_content" style="height:calc(100vh - 135px)">
								<ul style="left: 0%;">
									<li class="active">
										<!-- 연관 상품 -->
										<div class="cart-tit-only-pc">
											<span class="ico-log-relation"></span>연관상품
											<button class="ctop-close" onclick="ui.commentBox.close(this)"></button>
										</div>
										<div class="cart-area">
											<div class="all-check">
												<label class="checkbox t01">
													<input type="checkbox"><span class="txt">전체 선택</span>
												</label>
											</div>
											<div class="check-list swiper-container swiper-none-mo swiper-container-initialized swiper-container-horizontal">
												<ul class="list swiper-wrapper" style="left: 0%; transform: translate3d(-712px, 0px, 0px); transition-duration: 0ms;">
														{data}
												</ul>
												<p class="info-t1">최근에 장바구니에 담은 상품 5개까지만 노출됩니다.</p>
												<div class="btn-area">
													<a href="javascript:;" class="btn round">바로구매 <span class="arrow"></span></a>
												</div>
											</div>
											<div class="swiper-none-mo-arr remote-area t1">
												<button class="swiper-button-next" type="button"></button>
												<button class="swiper-button-prev" type="button"></button>
											</div>
										</div>
										<!-- // 연관 상품 -->
									</li>
									<li>
										<!-- 장바구니 -->
										<div class="product-area" style="padding:20px 20px 0;">
										</div>
										<!-- // 장바구니 -->
									</li>
								</ul>
							</div>
							<!-- // tab content -->
						</section>
						<!-- // tab -->
					</div>
				</div>
			</c:if>
		</c:when>
		<c:otherwise>
			
			<%-- 모바일인 경우. TV, 로그, LIVE  -------------------------------------------------------------------------------------------------------------%>
			<div class="commentBoxAp type01 handHead popconTingBox pop-relation-box uiPdOrdPan ton tabMode" data-priceh="60%" id="goodsRelatedBottomSheet">
				<!-- tabMode 클래스 추가 시 : 탭해더 부분 display:block ; // backMode 클래스 추가 시 : 뒤로가기 버튼 display:block -->
				<div class="head h2 bnone" id="divHandHead">
					<div class="con">
						<button class="mo-header-backNtn t2" onclick="backToGoodsRelatedList();" id="btnBack">뒤로</button>
						<div class="small-pic" id="divSmallPic"></div>
						<div class="tit type-ab" id="divBackModeTit" ><span></span></div><!--  04.13 -->
						<div class="tit" id="divTabModeTit">
							<!-- tab header -->
							<section class="sect petTabHeader">
								<ul class="uiTab b">
									<li>
										<button class="bt active" id="btn_rel" href="javascript:;" data-id="goods" data-content="" data-url="" onclick="ui.lock.using(true);">
											<c:choose>
												<c:when test="${relatedWith eq 'LIVE'}">판매상품</c:when>
												<c:otherwise>연관상품</c:otherwise>
											</c:choose>
										</button>
									</li>
									<c:if test="${empty session.bizNo}">
									<li class="bt">
										<button class="bt" id="btn_cart" href="javascript:;" data-id="cart" data-content="" data-url="" onclick="cartGoods.reloadMiniCart();">장바구니</button>
									</li>		
									</c:if>
								</ul>
							</section>
							<!-- // tab header -->
						</div>
						<c:choose>
							<c:when test="${relatedWith eq 'LIVE'}">
								<a href="javascript:;" class="close" onClick="javascript:fnHandHeadCloseLive(this);"></a>
							</c:when>
							<c:when test="${relatedWith eq 'LOG'}">
								<a href="javascript:;" class="close" onClick="fnClosePetLogRelatedGoods();"></a>
							</c:when>
							<c:otherwise>
								<a href="javascript:;" class="close" onClick="javascript:fnHandHeadClose(this);"></a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="con" id="goodsRelatedBottomListNCart">
					<!-- tab -->
					<section class="sect petTabContent">
						<!-- tab content -->
						<div class="uiTab_content">
							<ul>
								<li>
									<!-- 연관 상품 -->
									<div class="product-area" style="padding:20px 20px 0;">
										{data}
									</div>
									<!-- // 연관 상품 -->
								</li>
								<li data-section-id="miniCart" id="miniCart">
									<!-- 장바구니 -->
									<c:choose>
										<c:when test="${relatedWith eq 'LOG'}">
											<div class="cart-area cmb_inr_scroll">
												<div class="all-check">
													<label class="checkbox t01">
														<input type="checkbox"><span class="txt">전체 선택</span>
													</label>
												</div>
												<div class="check-list">
													<ul class="list">
													</ul>
													<p class="info-t1">최근에 장바구니에 담은 상품 5개까지만 노출됩니다.</p>
													<div class="btn-area">
														<a href="javascript:;" class="btn round">장바구니 전체보기 <span class="arrow"></span></a>
													</div>
												</div>
											</div>
										</c:when>
										<c:otherwise>
											<div class="all-check">
												<label class="checkbox t01">
													<input type="checkbox"><span class="txt">전체 선택</span>
												</label>
											</div>
											<div class="mo-inner-scroll">
												<div class="cart-tit-only-pc">
													<span class="ico-log-relation"></span>장바구니
													<button class="ctop-close" onclick="ui.commentBox.close(this)"></button>
												</div>
												<div class="cart-area">
													<div class="check-list swiper-container swiper-none-mo">
														<ul class="list swiper-wrapper" style="left: 0%;">
														</ul>
														<p class="info-t1">최근에 장바구니에 담은 상품 5개까지만 노출됩니다.</p>
														<div class="btn-area">
															<a href="javascript:;" class="btn round">장바구니 전체보기 <span class="arrow"></span></a>
														</div>
													</div>
												</div>
											</div>
										</c:otherwise>
									</c:choose>
									<!-- // 장바구니 -->
								</li>
							</ul>
						</div>
						<!-- // tab content -->
					</section>
					<!-- // tab -->
				</div>
			</div>
		</c:otherwise>
	</c:choose>
</script>

<script type="text/template" id="relatedGoodsRow">
	<c:choose>
		<c:when test="${view.deviceGb eq FrontWebConstants.DEVICE_GB_10}">
			<%--
			swiper-slide-prev
			swiper-slide-active
			swiper-slide-next
			--%>
			<c:if test="${relatedWith eq 'TV'}">
				<li class="swiper-slide" style="margin-right: 20px;">
					<div class="thumb-box">
						<a href="/goods/indexGoodsDetail?goodsId={goodsId}" class="thumb-img" style="background-image:url(${frame:optImagePath('{imgPath}', frontConstants.IMG_OPT_QRY_756)});" target="_blank" data-content="{goodsId}" data-url="/goods/indexGoodsDetail?goodsId={goodsId}" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'">
							{soldOut}
							<c:if test="${session.mbrNo ne frontConstants.NO_MEMBER_NO}">
							<button class="btn-zzim {zzimYnClass}" type="button" data-content="{goodsId}" data-url="" data-target="goods" data-action="interest" data-goods-id="{goodsId}"><span>북마크</span></button>
							</c:if>
						</a>
						<button class="btn-basket"
								type="button"
								data-content="{goodsId}"
								data-url=""
								data-ORD-MKI-YN="{ordmkiYn}"
								data-ITEM-NO="{itemNo}"
								data-DLGT-SUB-GOODS-ID="{dlgtSubGoodsId}"
								data-CSTRT-TP="{goodsCstrtTpCd}" 
								onClick="event.stopPropagation(); fnAddToCartAtBottomSheet('{goodsId}')"
								{displayNoneCartBtn}
							> <span>장바구니</span> </button>
						
						<div class="thumb-info">
							<div class="info">
								<div class="tlt"><a href="/goods/indexGoodsDetail?goodsId={goodsId}" target="_blank" data-content="{goodsId}" data-url="/goods/indexGoodsDetail?goodsId={goodsId}">{goodsNm}</a></div>
								<div class="price">
									<a href="/goods/indexGoodsDetail?goodsId={goodsId}" target="_blank" data-content="{goodsId}" data-url="/goods/indexGoodsDetail?goodsId={goodsId}">
										<span><em>{saleAmt}</em>원</span>
										<strong class="discount">{discount}</strong>
									</a>
								</div>
							</div>
						</div>
					</div>
				</li>
			</c:if>
			<c:if test="${relatedWith eq 'LOG'}">
				<li class="swiper-slide" style="margin-right: 8px;">
					<div class="untcart">
						<label class="checkbox"><input type="checkbox"><span class="txt"></span></label>
						<div class="box">
							<div class="tops">
								<div class="pic">
									<a href="/goods/indexGoodsDetail?goodsId={goodsId}" target="_blank" data-content="{goodsId}" data-url="/goods/indexGoodsDetail?goodsId={goodsId}">
										{soldOut}
										<img src="${frame:optImagePath('{imgPath}', frontConstants.IMG_OPT_QRY_756)}" alt="상품" class="img" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'">
									</a>
									<button class="keep {zzimYnClass}" data-content="{goodsId}" data-url="" data-target="goods" data-action="interest" data-goods-id="{goodsId}" style="z-index: 2;">보관하기</button>
									<button class="btn-basket"
											type="button"
											data-content="{goodsId}"
											data-url=""
											data-ORD-MKI-YN="{ordmkiYn}"
											data-ITEM-NO="{itemNo}"
											data-DLGT-SUB-GOODS-ID="{dlgtSubGoodsId}"
											data-CSTRT-TP="{goodsCstrtTpCd}" 
											onClick="event.stopPropagation(); fnAddToCartAtBottomSheet('{goodsId}')"
											{displayNoneCartBtn}
									> <span>장바구니</span> </button>
								</div>
								<div class="name">
									<div class="tit"><a href="/goods/indexGoodsDetail?goodsId={goodsId}" target="_blank" data-content="{goodsId}" data-url="/goods/indexGoodsDetail?goodsId={goodsId}">{goodsNm}</a></div>
									<div class="stt">한입 맛보기 습식사료 체험 추가 증정</div>
								</div>
							</div>

							<div class="amount">
								<div class="uispiner">
									<input type="text" value="1" class="amt" disabled="">
									<button type="button" class="bt minus">수량더하기</button>
									<button type="button" class="bt plus">수량빼기</button>
								</div>
								<div class="prcs">
									<span class="prc">
										<a href="/goods/indexGoodsDetail?goodsId={goodsId}" target="_blank" data-content="{goodsId}" data-url="/goods/indexGoodsDetail?goodsId={goodsId}">
											<em class="p">{saleAmt}</em>
											<i class="w">원</i>
										</a>
									</span>
									{discount}
									<button class="btn sm a buy" data-goods-id="{goodsId}">바로구매</button>
								</div>
							</div>
						</div>
					</div>
				</li>
			</c:if>
		</c:when>
		<c:otherwise>
			<div class="item">
				<div class="img-box">
					<a href="/goods/indexGoodsDetail?goodsId={goodsId}" target="_blank" data-content="{goodsId}"
					   data-url="/goods/indexGoodsDetail?goodsId={goodsId}">
						{soldOut}
						<img src="${frame:optImagePath('{imgPath}', frontConstants.IMG_OPT_QRY_757)}" alt="{goodsNm}" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'">
					</a>
					<button class="keep {zzimYnClass}" id="btnZzim{goodsId}" data-content="{goodsId}" data-url="" data-target="goods" data-action="interest" data-goods-id="{goodsId}">보관하기</button>
						<%--
						<button class="cart"
								data-content="{goodsId}"
								data-url=""
								data-ORD-MKI-YN="{ordmkiYn}"
								data-ITEM-NO="{itemNo}"
								data-DLGT-SUB-GOODS-ID="{dlgtSubGoodsId}"
								data-CSTRT-TP="{goodsCstrtTpCd}">장바구니</button>
						--%>
					<button class="cart"
							data-content="{goodsId}"
							data-url=""
							data-ORD-MKI-YN="{ordmkiYn}"
							data-ITEM-NO="{itemNo}"
							data-DLGT-SUB-GOODS-ID="{dlgtSubGoodsId}"
							data-CSTRT-TP="{goodsCstrtTpCd}" 
							onClick="event.stopPropagation(); fnAddToCartAtBottomSheet('{goodsId}')"
							{displayNoneCartBtn}
							> 장바구니 </button>

				</div>
				<div class="tit"><a href="/goods/indexGoodsDetail?goodsId={goodsId}" target="_blank" data-content="{goodsId}" data-url="/goods/indexGoodsDetail?goodsId={goodsId}">{goodsNm}</a></div>
				<div class="price">
					<a href="/goods/indexGoodsDetail?goodsId={goodsId}" target="_blank" data-content="{goodsId}" data-url="/goods/indexGoodsDetail?goodsId={goodsId}">
						<strong class="num">{saleAmt}</strong>
						<span>원</span>
					</a>
					<strong class="discount">{discount}</strong>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
</script>

<script>
	//App일때 영상상세에서 로그인 화면으로 화면 닫고 이동해야해서 추가된 함수
	function fncGoodsAppCloseMoveLogin(url){
		if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true" && document.location.href.indexOf("/tv/series/indexTvDetail") > -1){
			// 데이터 세팅
			toNativeData.func = "onCloseMovePage";
			toNativeData.moveUrl = "${view.stDomain}/indexLogin?returnUrl="+url;
			// APP 호출
			toNative(toNativeData);
		}else{
			location.href = '/indexLogin?returnUrl=' + url;
		}
	}
	
	//영상상세에서 다른화면 호출시 처리부분
	function fncGoodsAppCloseMove(url){
		var $btn = $(".petTabHeader .uiTab li[class*='active']").find("button");
		var callGoodsId = "";
		if(!$("#divTabModeTit").is(":visible")){
			callGoodsId = "-"+$("#goodsWish").data("goodsId");
		}
		
		if(document.location.href.indexOf("/tv/series/indexTvDetail") > -1){
			//App일때 영상상세에서 화면 닫고 이동해야함
			if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true"){
				var callParam = "";
				if(sortCd != ""){
					callParam = nowVdId+"."+sortCd+"."+listGb+"."+$btn.data("id")+callGoodsId;
				}else{
					callParam = nowVdId+"."+listGb+"."+$btn.data("id")+callGoodsId;
				}

				// 데이터 세팅
				toNativeData.func = "onCloseMovePage";
				toNativeData.moveUrl = "${view.stDomain}"+url+"?callParam="+callParam;
				// APP 호출
				toNative(toNativeData);
			}else{
				if("${view.deviceGb eq frontConstants.DEVICE_GB_20}" == "true"){
					var replaceUrl = document.location.href+"-"+$btn.data("id")+callGoodsId;
					history.replaceState("", "", replaceUrl);
					storageHist.replaceHist(replaceUrl);
				}

				location.href = url;
			}
		}else if(document.location.href.indexOf("/tv/school/indexTvDetail") > -1){
			if("${view.deviceGb ne frontConstants.DEVICE_GB_10}" == "true"){
				var replaceUrl = document.location.href+"&goodsVal="+$btn.data("id")+callGoodsId;
				history.replaceState("", "", replaceUrl);
				storageHist.replaceHist(replaceUrl);
			}

			location.href = url;
		}else if(document.location.href.indexOf("/log/indexPetLogList") > -1){
			if("${view.deviceGb ne frontConstants.DEVICE_GB_10}" == "true"){
				var replaceUrl = document.location.href.split('&selIdx=')[0];
				if(!$("#divTabModeTit").is(":visible")){
					replaceUrl = replaceUrl + "&selIdx="+$("#popconTing").data("idx")+"&page="+petLogPage+"&goodsVal="+$("#goodsWish").data("goodsId");
				}else{
					replaceUrl = replaceUrl + "&selIdx="+$("#popconTing").data("idx")+"&page="+petLogPage+"&goodsVal=cart"
				}

				history.replaceState("", "", replaceUrl);
				storageHist.replaceHist(replaceUrl);
			}
			location.href = url;
		}else{
			location.href = url;
		}
	}
	
	var goodsRelatedList = ${goodsListJson};
	function relatedGoodsCallback($btn, tabMove) {
		if(!goodsRelatedList || goodsRelatedList.length == 0) {
			ui.toast("<spring:message code ='front.web.view.goods.no.relatedGoods.msg'/>");
			return;
		}

		<c:if test="${view.deviceGb ne FrontWebConstants.DEVICE_GB_10}">
			let cartJsUrl = "/_script/cart/cart.js";
			if($("script[src='"+cartJsUrl+"']").length == 0) {
				$('<script src="'+cartJsUrl+'"></' + 'script>').appendTo(document.body);
			}
	
			ui.lock.using(true);
		</c:if>

		let $target;
		<c:choose>
			<c:when test="${view.deviceGb eq FrontWebConstants.DEVICE_GB_10 and relatedWith eq 'TV'}">
				$target = $("<c:out value="${target}"/>");
			</c:when>
			<c:when test="${view.deviceGb ne FrontWebConstants.DEVICE_GB_10 and relatedWith eq 'LOG'}">
				$target = $("<c:out value="${target}"/>");
			</c:when>
			<c:otherwise>
				$target = $btn.closest("<c:out value="${target}"/>");
			</c:otherwise>
		</c:choose>
		
		let callback = function($btn) {
			//console.log("callback executed!");
			<c:if test="${view.deviceGb ne FrontWebConstants.DEVICE_GB_10}">
				$(".pop-relation-box .item a").on("click", function(e) {
					//console.log("상품요약 호출!");
					$("#goodsSummary").remove();
					let $this = $(this);
					let goodsId = $this.data("content");
					//console.log("goodsId: "+goodsId);
					getGoodsSummary($this);
					
					e.preventDefault();
					return false;
				});
				
				if(tabMove == "Y"){
					$(".petTabHeader .uiTab li").removeClass('active');
					$(".petTabHeader .uiTab li").eq(1).addClass("active");
					$("#btn_cart").trigger("click");
				}else{
					var goodsParam = tabMove.split("|");
					if(goodsParam.length > 1){
						var bottomGoodsId = goodsParam[1];
						$(".pop-relation-box .item a").each(function(index, item){
							let $this = $(this);
							if(bottomGoodsId == $this.data("content")){
								getGoodsSummary($this);
								return false;
							}
						});
					}
				}
			</c:if>
			
			<c:if test="${relatedWith eq 'LOG' && view.deviceGb eq FrontWebConstants.DEVICE_GB_10}">
				$(function(){
					$(".discount").css("font-size", "16rem").css("font-weight", "700").css("color", "#ff7777");
				});
			</c:if>

			${callbackUi}
		};
		
		// console.log("relatedGoodsCallback2 - goodsRelatedList: " + goodsRelatedList );
		
		
		relatedGoodsCallback2($target, goodsRelatedList, callback);
	}
	
	function fnClosePetLogRelatedGoods(){
		ui.popLayer.close('popconTing');
		window.postMessage({action: 'logPopVodEnd'}, "*");
		<c:if test="${relatedWith eq 'LOG' && view.deviceGb ne FrontWebConstants.DEVICE_GB_10}">
			var vdId = '${petLogBase.vdPath}';
			$('#-playbtn_'+vdId).attr('id', 'playbtn_'+vdId);
			$('#video_'+vdId).attr('video_id', vdId);
		</c:if>
	}
	
	<c:if test="${relatedWith ne 'LIVE'}">
	function goGoodsDetail(goodsId) {
		location.href='/goods/indexGoodsDetail?goodsId='+goodsId;
	}
	</c:if>
		
	
	// [21.08.05] 장바구니 썸네일 클릭시 장바구니에 넣음.	
	var objArrGoodsRelatedList = eval(goodsRelatedList);

	//전역 상품 객체 초기화 - 상품선택시 goodsId를 사용하여 생성함.
	var goodsObjAddToCartAtBottomSheet = {}

	function fnAddToCartAtBottomSheet( goodsId ) {
			
		// 전역변수(goodsObjAddToCartAtBottomSheet)의 데이터(list)에서 해당 상품의 객체를 추출한다. 
		fnSetgoodsObjAddToCartAtBottomSheet(goodsId);
				
		// 장바구니 함수에 넣을 파라미터.
		var goodsIdStr = ""; 
		
		// 주문제작 상품 >> 팝업 노출됨.
		if ( goodsObjAddToCartAtBottomSheet.ordmkiYn == 'Y' ) {
			
			ui.confirm('주문제작 상품은 상품상세에서 확인 후 장바구니에 추가할 수 있어요.<br/>상품상세로 이동할까요?', { // 컨펌 창 옵션들
				ycb: function () {
					document.location.href = '/goods/indexGoodsDetail?goodsId='+goodsId;
				},
				ncb: function () {
					return false;
				},
				ybt: "예", // 기본값 "확인"
				nbt: "아니오"  // 기본값 "취소"
			});
		}
		// 단품, 셋트 상품인 경우 옵션창 노출되지 않고 바로 장바구니에 담기고 토스트 알림
		else if ( goodsObjAddToCartAtBottomSheet.goodsCstrtTpCd == "ITEM" || goodsObjAddToCartAtBottomSheet.goodsCstrtTpCd == "SET" ) {

			if( goodsObjAddToCartAtBottomSheet.reservationType === "SOON" ){

				var reservationDate = new Date(goodsObjAddToCartAtBottomSheet.reservationStrtDtm).dateFormat('MM월dd일');
				ui.toast( "사전예약 상품은 "+ reservationDate +"부터 구매할 수 있어요", {
					cls :  "reservation" ,
					bot: 74, //바닥에서 띄울 간격
					sec:  3000 //사라지는 시간
				});
				
				return;
			}
			
			goodsIdStr = goodsObjAddToCartAtBottomSheet.goodsId+":"+goodsObjAddToCartAtBottomSheet.itemNo+":";
			
			// 장바구니 등록			

			// 단품, SET 일 경우, 최소구매 수량으로 장바구니 추가함.
			var minOrdQty = goodsObjAddToCartAtBottomSheet.minOrdQty;
			if( minOrdQty == null || minOrdQty == undefined || minOrdQty == "" ) {
				console.log("minOrdQty 이 널일 경우: " + minOrdQty);
				minOrdQty = 1;
			}
			console.log("minOrdQty: " + minOrdQty);
			commonFunc.insertCart(goodsIdStr, minOrdQty, 'N');
		
		}
		// 묶음상품, 옵션상품인 경우 옵션창 노출  >> 장바구니/구매하기 
		else if ( goodsObjAddToCartAtBottomSheet.goodsCstrtTpCd == "PAK" || goodsObjAddToCartAtBottomSheet.goodsCstrtTpCd == "ATTR" ) {
			
			// 옵션, 패키지인 경우, PC, 모바일 분리해야함.
			<c:choose>
			<c:when test="${view.deviceGb eq FrontWebConstants.DEVICE_GB_10}" >
				// [PC] 상세페이지로 이동. &referFrom=relatedGoodsCartBtn 파라미터를 통해 상품상세에서 자동으로 옵션 선택 레이어가 나옴.
				var url ="/goods/indexGoodsDetail?goodsId="+goodsObjAddToCartAtBottomSheet.goodsId + "&referFrom=relatedGoodsCartBtn";
				window.open(url, '_blank');
			</c:when>
			<c:otherwise>	
			
 				// [모바일] 옵션창을 바로 보여줌. 기존 제품상세보기 + 장바구니클릭
				var url = "/goods/popupGoodsSummary/"+goodsObjAddToCartAtBottomSheet.goodsId;
				
				waiting.start();
				
				var options = {
					url : url,
					//data: data,
					dataType: "html",
					done : function(data) {
						//console.log("data: " + data );
						$("#goodsRelatedBottomSheet").append(data);
						$("#goodsRelatedBottomSheet").addClass("goodsSummary");
						
						setTimeout(function() {					
							goodsSummaryCallback();
							
							// 로딩후 바로 옵션창 나오게 하는 class 처리
							$(".commentBoxAp .product-option").addClass("none");
							$(".commentBoxAp .product-buy").removeClass("none");
							
							waiting.stop();
						}, 0);
					},
					fail: function() {
						waiting.stop();
						console.log("failt????? TT");
					}
				};
				
				ajax.call(options);
			</c:otherwise>
		</c:choose>
		}
		
	}
	
	// 장바구니에 넣을 상품의 정보를 셋팅한다.
	function fnSetgoodsObjAddToCartAtBottomSheet( goodsId ) {
	
		for ( var i=0; i<objArrGoodsRelatedList.length; i++ ) {
			
			if ( objArrGoodsRelatedList[i].goodsId == goodsId ) {
				goodsObjAddToCartAtBottomSheet = objArrGoodsRelatedList[i];
				
				console.log("연관상품 클릭: goodsObjAddToCartAtBottomSheet: " + JSON.stringify(goodsObjAddToCartAtBottomSheet));
				break;
			}
		}
	}

</script>
</div>
