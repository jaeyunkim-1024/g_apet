<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.include" value="script.petshop"/>
	<tiles:putAttribute name="script.inline">
		<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">	
		<script type="text/javascript">
			$(document).ready(function(){
				$(".mo-header-backNtn").attr("onClick", "goPetShopMain();");

				if("${not empty view.displayShortCutList}" == 'true') {
					/* 탭이동 종료 후 이벤트 */
					var idx = $("li[name=shortCut][class~=active]").data("shortcutidx");
					if(idx != 'undefined') {
						ui.disp.subnav.elSwiper.el.slideTo(idx-1);
					};
				}
			});	
		</script>
		</c:if>
	
		<script type="text/javascript">
			$(window).bind("pageshow", function(event){
				if(event.originalEvent.persisted || window.performance && window.performance.navigation.type == 2){
					var state = window.history.state;
					if(state) {
						page = state.page;
						scrollPrevent = state.scrollPrevent;
						$("#contents").html(state.data);
						ui.disp.sld.cate.using();
					}else {
						uisortSet();
						window.history.replaceState(null, null, null);
						newGoodsList.list();
					}
				}else{
					uisortSet();
					window.history.replaceState(null, null, null);
					newGoodsList.list();
				}
			});
			
			var newGoodsList = {
				list : function(cateCdM, order){
					page = 0;
					result = true;
					scrollPrevent = true;
					var init = false;
					if(cateCdM == undefined && order == undefined) {
						init = true;
						order = $("li[id^=order]:first-child").children().val();
						cateCdM = '${dispClsfNo}';
					}
					
					if(cateCdM == undefined) {
						cateCdM = $("li[class~=active][name^=dispClsfNo]").attr('id');
					}
					
					if(order == undefined) {
						order = $("li[class=active][id^=order]").children().val();
					}
					var options = {
						url : "<spring:url value='/shop/getNewGoodsList' />"
						, type : "POST"
						, dataType : "html"
						, data : {
							dispClsfNo : '${view.dispClsfNo}'
							,cateCdL : $("#cateCdL").val()
							,cateCdM : cateCdM
							,dispCornType : $("#dispCornType_new").val()
							,order : order
							,page : page
							,rows : rows
						}
						, done : function(result){
							$("#sortGoodsList").empty();
							$("#sortGoodsList").append(result);
							$("#emTag_count").text(goodsCount);
							if(!init) {
								newGoodsList.pushUrl(cateCdM);
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
		</script>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<main class="container lnb page shop dm newgd" id="container">
			<input type="hidden" id="cateCdL" value="${so.cateCdL}"/>
			<input type="hidden" id="dispCornType_new" value="${frontConstants.GOODS_MAIN_DISP_TYPE_NEW}"/>
			<div class="pageHeadPc lnb">
				<div class="inr">
					<div class="hdt">
						<h3 class="tit">신상품</h3>
					</div>
				</div>
			</div>
			<c:if test="${view.deviceGb != 'PC' && not empty view.displayShortCutList}">
				<nav class="subtopnav">
					<div class="inr">
						<div class="swiper-container box">
							<ul class="swiper-wrapper menu">
								<c:forEach var="icon" items="${view.displayShortCutList}"  varStatus="status" >
								<li class="swiper-slide ${fn:indexOf(icon.bnrMobileLinkUrl, session.reqUri) > -1 ? 'active' : ''}" name="shortCut" data-shortcutidx="${status.count }">
									<a class="bt" href="javascript:void(0);" onclick="goLink('${icon.bnrMobileLinkUrl}', true)">${icon.bnrText}</a>
								</li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</nav>
			</c:if>
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<nav class="smain_cate_sld">
						<div class="sld-nav">
							<button type="button" class="bt prev">이전</button>
							<button type="button" class="bt next">다음</button>
						</div>
						
						<div class="swiper-container slide">
							<ul class="uiTab f swiper-wrapper list">
								<li class="swiper-slide ${dispClsfNo eq so.cateCdL? 'active' : ''}" id="${so.cateCdL}" name="dispClsfNo">
									<button type="button" class="btn" data-ui-tab-btn="tab_bests" data-dispClsfNo="${so.cateCdL}" onclick="newGoodsList.list('${so.cateCdL }');">전체</button>
								</li>
								<c:forEach var="category" items="${categoryList}"  varStatus="status" >
								<li class="swiper-slide ${so.cateCdM eq category.cateCdM ? 'active' : ''}" id="${category.cateCdM}" name="dispClsfNo">
									<button type="button" class="btn" data-ui-tab-btn="tab_bests" data-dispClsfNo="${category.cateCdM}" onclick="newGoodsList.list('${category.cateCdM}');">${category.cateNmM}</button>
								</li>
								</c:forEach>
							</ul>
						</div>
					</nav>
					<section class="sect dm newgd">
						<div class="uioptsorts newgd">
							<div class="dx lt">
								<div class="tot"><spring:message code='front.web.view.common.total.title' /> <em class="n" id="emTag_count"></em><spring:message code='front.web.view.common.total.goods.count.title' /></div>
							</div>
							<div class="dx rt">
								<nav class="uisort">
									<button type="button" class="bt st" value=""></button>
									<div class="list">
										<ul class="menu">
											<li id="order_SALE"><button type="button" class="bt" value="SALE" onclick="newGoodsList.list(undefined,this.value);"><spring:message code='front.web.view.common.menu.sort.orderSale.button.title'/></button></li>
											<li id="order_SCORE"><button type="button" class="bt" value="SCORE" onclick="newGoodsList.list(undefined,this.value);"><spring:message code='front.web.view.common.menu.sort.orderScore.button.title'/></button></li>
											<li id="order_DATE"><button type="button" class="bt" value="DATE" onclick="newGoodsList.list(undefined,this.value);"><spring:message code='front.web.view.common.menu.sort.orderDate.button.title'/></button></li>
											<li id="order_LOW"><button type="button" class="bt" value="LOW" onclick="newGoodsList.list(undefined,this.value);"><spring:message code='front.web.view.common.menu.sort.orderLow.button.title'/></button></li>
											<li id="order_HIGH"><button type="button" class="bt" value="HIGH" onclick="newGoodsList.list(undefined,this.value);"><spring:message code='front.web.view.common.menu.sort.orderHigh.button.title'/></button></li>
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
						var liLength = $("ul[id=cate]").children("li").length;
						if((liLength != goodsCount) && (liLength >= rows)){
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
			var cateCdM = $("li[class~=active][name^=dispClsfNo]").attr('id');
			var order = $("li[class=active][id^=order]").children().val();
			if(cateCdM == undefined) {
				cateCdM = '${so.cateCdL}';
			}
		 	var options = {
				url : "<spring:url value='/shop/getNewGoodsPagingList' />"
				, type : "POST"
				, dataType : "html"
				, data : {
					cateCdL : $("#cateCdL").val()
					,cateCdM : cateCdM
					,dispCornType : $("#dispCornType_new").val()
					,order : order
					,page : page
					,rows : rows
				}
				, done :	function(html){
					$("#cate").append(html);
					if($("#cate li").length % rows != 0 || $("#cate li").length == goodsCount){
						result = false;					
					}else {
						scrollPrevent = true;
					}
					newGoodsList.pushUrl(cateCdM);
				}
			};
			ajax.call(options);
		}
		</script>
	</tiles:putAttribute>	
</tiles:insertDefinition>