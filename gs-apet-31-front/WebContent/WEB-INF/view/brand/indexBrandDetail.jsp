<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.inline">
	<script>
	$(document).ready(function(){
		<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">	
		$(".mo-heade-tit .tit").html("${brand.bndNmKo }");	
		</c:if>
	});
	
	$(window).bind("pageshow", function(event){
		if(event.originalEvent.persisted || window.performance && window.performance.navigation.type == 2){
			var state = window.history.state;
			if(state) {
				page = state.page;
				scrollPrevent = state.scrollPrevent;
				$("#contents").html(state.data);
				ui.disp.subnav.init();
				if(state.idx != undefined){
					ui.disp.subnav.elSwiper.el.slideTo(state.idx-1);
				}
			}else {
				window.history.replaceState(null, null, null);
				uisortSet();
				brandGoodsList.list();
			}
		}else{
			window.history.replaceState(null, null, null);
			uisortSet();
			brandGoodsList.list();
		}
	});
	
	// 브랜드 찜
	function insertWishBrand(obj, bndNo) {
		var isLogin = "${session.isLogin()}";
		if(isLogin == "true"){
			var options = {
				url : "/brand/insertWish",
				data : {bndNo : bndNo},
				done : function(data) {
					if (data.actGubun =='add') {
						$(obj).addClass("on");
						fnUiToast("<spring:message code='front.web.view.common.msg.result.wish' />", "wish");
						userActionLog(bndNo, "interest");
					} else if (data.actGubun =='remove') {
						$(obj).removeClass("on");
						fnUiToast("<spring:message code='front.web.view.common.msg.result.wished' />", "wished");
						userActionLog(bndNo, "interest_d");
					}
				}
			};
			ajax.call(options);
		}else{
			location.href = "/indexLogin";
		}
	}
	
	//공유하기 버튼 클릭
	function shareBtnClick(bndNo, linkUrl, bndNmKo){
		userActionLog(bndNo, "share");
		//app인 경우
		var deviceGb = "${view.deviceGb}";
		if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30 }"){ // APP인경우
			// 데이터 세팅
			toNativeData.func = "onShare";
			toNativeData.image = $(".thum .pic .img").eq(0).attr("src");
			toNativeData.link = linkUrl;
			toNativeData.subject = bndNmKo;
			// 호출
			toNative(toNativeData);
		}else{
			//web인 경우
			copyToClipboard(linkUrl);
		}
	}
	
	function copyToClipboard(val){
		var textarea = document.createElement("textarea");
		document.body.appendChild(textarea);
		textarea.value = val;
		textarea.select();
		document.execCommand('copy');
		document.body.removeChild(textarea);
		fnUiToast("<spring:message code='front.web.view.common.msg.result.share' />", "share");
	}
	
	// toast
	function fnUiToast(text, cls){
		ui.toast(text,{
			cls : cls ,
			bot: 74, //바닥에서 띄울 간격
			sec:  3000 //사라지는 시간
		});
	}
	
	//검색API 클릭 이벤트(사용자 액션 로그 수집)
	function userActionLog(bndNo, action){	
		var mbrNo = "${session.mbrNo}";
		if (mbrNo != "${frontConstants.NO_MEMBER_NO}") {
			$.ajax({
				type: 'POST'
				, url : "/common/sendSearchEngineEvent"
				, dataType: 'json'
				, data : {
					"logGb" : "ACTION"
					, "mbr_no" : mbrNo
					, "section" : "shop" 
					, "content_id" : bndNo
					, "action" : action
					, "url" : document.location.href
					, "targetUrl" : document.location.href
				}
			});
		}
	}
	
	function uisortSet() {
		$("nav.uisort").each(function(){
			var $li = $(this).find(".menu>li");
			var txt = $li.filter(".active").find(".bt").text();
			if( $(this).find(".menu>li.active").length == 0 ) {
				txt = $(this).find(".menu>li:first-child").find(".bt").text();
				$(this).find(".menu>li:first-child").addClass("active");
			}
			$li.closest(".uisort").find(".bt.st").html(txt);
			var val = $(this).find(".menu>li.active .bt").attr("value");
			$li.closest(".uisort").find(".bt.st").attr("value",val);				
		});
	}
	
	var brandGoodsList = {
		bndNo : "${brand.bndNo}",
		list : function(dispClsfNo, order){
			page = 0;
			result = true;
			scrollPrevent = true;
			var init = false;
			if(dispClsfNo == undefined && order == undefined) {
				init = true;
				dispClsfNo = '${so.cateCdL}';
				order = $("li[id^=order]:first-child").children().val();
			}
			
			if(dispClsfNo == undefined) {
				dispClsfNo = $("li[class~=active][name=dispClsfNo]").children().data('dispclsfno');
			}
			
			if(order == undefined) {
				order = $("li[class~=active][id^=order]").children().val();
			}
			var options = {
				url : "<spring:url value='/brand/getBrandGoodsList' />"
				, type : "POST"
				, dataType : "html"
				, data : {
					bndNo : brandGoodsList.bndNo
					, dispClsfNo :dispClsfNo
					, order : order
					, page : page
				}
				, done : function(result){
					$("#sortGoodsList").empty();
					$("#sortGoodsList").append(result);
					$("#emTag_count").text(goodsCount);
					
					if(!init) {
						brandGoodsList.pushUrl(dispClsfNo);
					}
				}
			};
			ajax.call(options);
		},
		pushUrl : function(cateCdM) {
			var params = new URLSearchParams(location.search);
			params.set('cateCdM', cateCdM);
			var searchParams = params.toString();
			var goUrl = window.location.pathname + "?"+searchParams;
			var order = $("li[class=active][id^=order]").children().val();
			var idx = $("li[name=dispClsfNo][class~=active]").data("idx");
			window.history.replaceState( {data : $("#contents").html(), page : page, scrollPrevent : scrollPrevent, order : order, idx : idx}, null, goUrl);
		}
	}
	
	</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<main class="container lnb page shop dm brand" id="container">
			<input type="hidden" id="cateCdL" value="${so.cateCdL}"/>
			<input type="hidden" id="cateCdM" value="${so.cateCdM}"/>
			<input type="hidden" id="bndNo" value="${brand.bndNo}"/>
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<section class="sect dm brand tops">
						<div class="bts">
							<button type="button" class="bt zzim ${brand.interestYn eq 'Y' ? 'on' : ''}" onclick="insertWishBrand(this, '<c:out value="${brand.bndNo}" />');return false;"><spring:message code='front.web.view.brand.button.wishBrand' /></button>
							<button class="bt shar" data-message="<spring:message code='front.web.view.common.msg.result.share' />" id="share" title="COPY URL" data-clipboard-text="${snsShareVo.ogUrl }" onclick="shareBtnClick('${brand.bndNo}', '${shareUrl}', '${brand.bndNmKo}'); return false;" data-content="${brand.bndNo}" data-url="shareBtnClick();"><spring:message code='front.web.view.common.msg.result.share' /></button>
						</div>
						<div class="info ${empty (view.deviceGb eq frontConstants.DEVICE_GB_10 ? brand.bndItrdcImgPath : brand.bndItrdcMoImgPath) ? '' : 'isLogo'}">
							<div class="blogo">
								<div class="pic">
								<c:choose>
									<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
										<img class="img" src="${frame:optImagePath(brand.bndItrdcImgPath, frontConstants.IMG_OPT_QRY_785)}" alt="${brand.bndNmKo }" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'">
									</c:when>
									<c:otherwise>
										<img class="img" src="${frame:optImagePath(brand.bndItrdcMoImgPath, frontConstants.IMG_OPT_QRY_785)}" alt="${brand.bndNmKo }" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'">
									</c:otherwise>
								</c:choose>
								</div>
							</div>
							<div class="name-pet">
								<div class="bname">${brand.bndNmKo }</div>
								<div class="bpet" id="">${brand.cateIcon}</div>
							</div>
						</div>
					</section>
					<c:choose>
					<c:when test="${fn:length(categoryList) > 1}">
					<nav class="subtopnav cates relat">
						<div class="inr">
							<div class="swiper-container box">
								<ul class="swiper-wrapper menu">
									<li class="swiper-slide ${empty so.cateCdM ? 'active' : '' }" name="dispClsfNo" data-idx="1" onclick="focusCategory(1);">
										<a class="bt" id="dispClsfNo_${so.cateCdL}" data-dispclsfno="${so.cateCdL}" href="javascript:void(0);" onclick="brandGoodsList.list('${so.cateCdL}');"><spring:message code='front.web.view.brand.category.list.title' /></a>
									</li>
									<c:forEach var="category" items="${categoryList}"  varStatus="status" >
									<li class="swiper-slide ${so.cateCdM == category.cateCdM ? 'active' : '' }" name="dispClsfNo" data-idx="${status.count+1 }" onclick="focusCategory('${status.count+1 }');">
										<a class="bt" id="dispClsfNo_${category.cateCdM}" data-dispclsfno="${category.cateCdM}" href="javascript:void(0);" onclick="brandGoodsList.list('${category.cateCdM}');">${category.cateNmM}</a>
									</li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</nav>
					</c:when>
					<c:otherwise>
					<nav class="subtopnav cates relat" style="display:none;">
						<div class="inr">
							<div class="swiper-container box">
								<ul class="swiper-wrapper menu">
									<li class="swiper-slide active" name="dispClsfNo" data-idx="1" onclick="focusCategory(1);">
										<a class="bt" id="dispClsfNo_${so.cateCdL}" data-dispclsfno="${so.cateCdL}" href="javascript:brandGoodsList.list('${so.cateCdL}');"><spring:message code='front.web.view.brand.category.list.title' /></a>
									</li>
								</ul>
							</div>
						</div>
					</nav>
					</c:otherwise>
					</c:choose>

					<section class="sect dm brand">
						<div class="uioptsorts brand">
							<div class="dx lt">
								<div class="tot"><spring:message code='front.web.view.common.total.title' /> <em class="n" id="emTag_count"></em><spring:message code='front.web.view.common.total.goods.count.title' /></div>
							</div>
							<div class="dx rt">
								<nav class="uisort">
									<button type="button" class="bt st" value=""></button>
									<div class="list">
										<ul class="menu">
											<li id="order_SALE"><button type="button" class="bt" value="SALE" onclick="brandGoodsList.list(undefined,this.value);"><spring:message code='front.web.view.common.menu.sort.orderSale.button.title' /></button></li>
											<li id="order_SCORE"><button type="button" class="bt" value="SCORE"  onclick="brandGoodsList.list(undefined,this.value);"><spring:message code='front.web.view.common.menu.sort.orderScore.button.title' /></button></li>
											<li id="order_DATE"><button type="button" class="bt" value="DATE"  onclick="brandGoodsList.list(undefined,this.value);"><spring:message code='front.web.view.common.menu.sort.orderDate.button.title' /></button></li>
											<li id="order_LOW"><button type="button" class="bt" value="LOW"  onclick="brandGoodsList.list(undefined,this.value);"><spring:message code='front.web.view.common.menu.sort.orderLow.button.title' /></button></li>
											<li id="order_HIGH"><button type="button" class="bt" value="HIGH"  onclick="brandGoodsList.list(undefined,this.value);"><spring:message code='front.web.view.common.menu.sort.orderHigh.button.title' /></button></li>
										</ul>
									</div>
								</nav>
							</div>
						</div>
						<div class="gdlist" id="sortGoodsList">
						</div>
					</section>
				</div>
			</div>
		</main>
		<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
			<jsp:param name="floating" value="" />
		</jsp:include>
		
		<script>
		var page = 1
		var rows = '${frontConstants.PAGE_ROWS_20}';
		var result = true;
		var scrollPrevent = true;
		var deviceGb = "${view.deviceGb}"
		var goodsCount ='${goodsCount}'*1;
		
		$(function(){
			$(window).scroll(function(){
				var scrollTop = $(this).scrollTop();
				var both = $(document).innerHeight() - window.innerHeight - ($("#footer").innerHeight() || 0);
				if (both <= (scrollTop +3)) {
					if(result && scrollPrevent){
						var liLength = $("ul[id=brandUl]").children("li").length;
						if((liLength != goodsCount) && (liLength >= 20)){
							if(page == 1) {
								page = 1*rows
							} else {
								page = ((page/rows)+1) * rows
							}
							scrollPrevent = false;
							pagingGoodsList(page);
						}
					}
				};
			});
		});
		
		function pagingGoodsList(page){
			var dispClsfNo = $("li[class~=active][name^=dispClsfNo]").children().data("dispclsfno");
			var order = $("li[class=active][id^=order]").children().val();
			if(dispClsfNo == undefined) {
				dispClsfNo = '${so.cateCdL}';
			}
		 	var options = {
				url : "<spring:url value='/brand/getBrandGoodsPagingList' />"
				, type : "POST"
				, dataType : "html"
				, data : {
					bndNo : brandGoodsList.bndNo
					, dispClsfNo :dispClsfNo
					, order :order
					, page : page
				}
				, done :	function(html){
					$("#brandUl").append(html);
					if($("#brandUl li").length % 20 != 0 || $("#brandUl li").length == goodsCount){
						result = false;					
					}else {
						scrollPrevent = true;
					}
					brandGoodsList.pushUrl(dispClsfNo);
				}
			};
			ajax.call(options);
		}
		</script>
	</tiles:putAttribute>	
</tiles:insertDefinition>