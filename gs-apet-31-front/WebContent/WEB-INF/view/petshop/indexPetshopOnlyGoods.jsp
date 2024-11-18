<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.include" value="script.petshop"/>
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">
			$(document).ready(function(){
				<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">	
				$(".mo-heade-tit .tit").html("어바웃샵 단독 상품");	
				$(".mo-header-backNtn").attr("onClick", "goPetShopMain();");
				</c:if>
			});	
			
			$(window).bind("pageshow", function(event){
				if(event.originalEvent.persisted || window.performance && window.performance.navigation.type == 2){
					var state = window.history.state;
					if(state) {
						page = state.page;
						scrollPrevent = state.scrollPrevent;
						$("#contents").html(state.data);
					}else {
						window.history.replaceState(null, null, null);
					}
				}else{
					window.history.replaceState(null, null, null);
				}
			});
			
			function getSortGoodsList(order){
				page = 0;
				result = true;
				scrollPrevent = true;
				
				var options = {
					url : "<spring:url value='/shop/getSortGoodsList' />"
					, type : "POST"
					, dataType : "html"
					, data : {
						dispClsfNo : '${view.dispClsfNo}'
						,dispCornNo : $("#dispCornNo_only").val()
						,dispClsfCornNo : $("#dispClsfCornNo_only").val()
						,dispType : $("#dispCornType_only").val()
						,page : page
						,rows : rows
						,order: order
					}
					, done :function(result){
						$("#orderGoodsList").empty();
						$("#orderGoodsList").append(result);
						pushUrl();
					}
				};
				ajax.call(options);
			}
			
			function pushUrl() {
				var params = new URLSearchParams(location.search);
				var searchParams = params.toString();
				var goUrl = window.location.pathname + "?"+searchParams;
				window.history.replaceState( {data : $("#contents").html(), page : page, scrollPrevent : scrollPrevent}, null, goUrl);
			}
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
	<!-- 단독상품 -->
	<input type="hidden" id="dispCornType_only" value="${frontConstants.GOODS_MAIN_DISP_TYPE_PETSHOP}"/>
	<input type="hidden" id="dispCornNo_only" value="${so.dispCornNo}"/>
	<input type="hidden" id="dispClsfCornNo_only" value="${so.dispClsfCornNo}"/>
	<main class="container lnb page shop hm exclu" id="container">
		<div class="pageHeadPc lnb">
			<div class="inr">
				<div class="hdt">
					<h3 class="tit">어바웃샵 단독 상품</h3>
				</div>
			</div>
		</div>
		<div class="inr">
			<!-- 본문 -->
			<div class="contents" id="contents">
				<section class="sect ct exclu">
					<div class="uioptsorts exclu">
						<div class="dx lt"></div>
						<div class="dx rt">
							<nav class="uisort">	
								<button type="button" class="bt st" value=""></button>
								<div class="list">
									<ul class="menu">
										<li id="order_RCOM"><button type="button" class="bt" value="RCOM" onclick="getSortGoodsList(this.value)"><spring:message code='front.web.view.common.menu.sort.orderrecommend.button.title'/></button></li>
										<li id="order_SALE"><button type="button" class="bt" value="SALE" onclick="getSortGoodsList(this.value)"><spring:message code='front.web.view.common.menu.sort.orderSale.button.title'/></button></li>
										<li id="order_SCORE"><button type="button" class="bt" value="SCORE" onclick="getSortGoodsList(this.value)"><spring:message code='front.web.view.common.menu.sort.orderScore.button.title'/></button></li>
										<li id="order_DATE"><button type="button" class="bt" value="DATE" onclick="getSortGoodsList(this.value)"><spring:message code='front.web.view.common.menu.sort.orderDate.button.title'/></button></li>
										<li id="order_LOW"><button type="button" class="bt" value="LOW" onclick="getSortGoodsList(this.value)"><spring:message code='front.web.view.common.menu.sort.orderLow.button.title'/></button></li>
										<li id="order_HIGH"><button type="button" class="bt" value="HIGH" onclick="getSortGoodsList(this.value)"><spring:message code='front.web.view.common.menu.sort.orderHigh.button.title'/></button></li>
									</ul>
								</div>
							</nav>
						</div>
					</div>
					<ul class="list" id="orderGoodsList">
						<c:forEach var="goods" items="${cornerList.onlyGoodsList}"  varStatus="status" >
						<c:if test="${(goods.salePsbCd ne frontConstants.SALE_PSB_30) || (goods.salePsbCd eq frontConstants.SALE_PSB_30 && goods.ostkGoodsShowYn eq 'Y')}">
						<li>
							<div class="gdset exclu">
								<div class="thum">
									<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="pic" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">
										<c:if test="${goods.salePsbCd == frontConstants.SALE_PSB_10}">
											<div class="soldouts"><em class="ts">판매중지</em></div>
										</c:if>
										<c:if test="${goods.salePsbCd == frontConstants.SALE_PSB_20}">
											<div class="soldouts"><em class="ts">판매종료</em></div>
										</c:if>
										<c:if test="${goods.salePsbCd == frontConstants.SALE_PSB_30}">
											<div class="soldouts"><em class="ts"><spring:message code='front.web.view.common.goods.saleSoldOut.title'/></em></div>
										</c:if>
										<img class="img" src="${frame:optImagePath(goods.bannerPath, view.deviceGb eq frontConstants.DEVICE_GB_10 ? frontConstants.IMG_OPT_QRY_776 : frontConstants.IMG_OPT_QRY_777)}" alt="${goods.goodsNm}" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'">
									</a>
									<button type="button" class="bt zzim ${goods.interestYn eq 'Y' ? 'on' : ''}" data-content='${goods.goodsId}' data-url="/goods/insertWish?goodsId=${goods.goodsId}" data-action="interest" data-yn="N" data-goods-id="${goods.goodsId}" data-target="goods">찜하기</button>
								</div>
								<div class="boxs">
									<div class="tit">
										<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="lk" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">${goods.goodsNm}</a>
									</div>
									<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="inf" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">
										<span class="prc"><em class="p"><fmt:formatNumber value="${goods.foSaleAmt}" type="number" pattern="#,###,###"/></em><i class="w">원</i></span>
										<c:if test="${goods.orgSaleAmt > goods.saleAmt and ((goods.orgSaleAmt - goods.saleAmt)/goods.orgSaleAmt * 100) >= 1 }">
										<span class="pct"><em class="n"><fmt:parseNumber value="${100-((goods.foSaleAmt * 100) / goods.orgSaleAmt)}" integerOnly="true"/></em><i class="w">%</i></span>
										</c:if>
									</a>
									<div class="txt">${goods.mdRcomWds}</div>
									<c:if test="${fn:length(goods.icons) > 0}">
									<div class="bdg">
									<c:forTokens  var="icons" items="${goods.icons}" delims="," begin="0" end="3">
										<em class="bd ${fn:indexOf(icons, '타임') > -1 ? 'd' : fn:indexOf(icons, '+') > -1 or fn:indexOf(icons, '사은품') > -1 ? 'b' : ''}">${icons }</em>
									</c:forTokens>
									</div>
									</c:if>
								</div>
							</div>
						</li>
						</c:if>
						</c:forEach>
					</ul>
				</section>
			</div>
		</div>
	</main>
	<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
		<jsp:param name="floating" value="" />
	</jsp:include>
	
	<script>
		var page = 1
		var rows = '${so.rows}';
		var result = true;
		var scrollPrevent = true;
		var deviceGb = "${view.deviceGb}"
		var goodsCount ='${not empty cornerList.goodsCount ? cornerList.goodsCount : 0}'*1;
		var dispClsfNo = '${view.dispClsfNo}'
		var cateCdL = '${so.cateCdL}'
		
		$(function(){
			$(window).scroll(function(){
				var scrollTop = $(this).scrollTop();
				var both = $(document).innerHeight() - window.innerHeight - ($("#footer").innerHeight() || 0);
				if (both <= (scrollTop +3)) {
					if(result && scrollPrevent){
						var liLength = $("#orderGoodsList").children("li").length;
						if((liLength != goodsCount) && (liLength >= rows)){
							if(page == 1) {
								page = 1*rows
							} else {
								page = ((page/rows)+1) * rows
							}
							scrollPrevent = false;
							pagingCategoryList(page);
						}
					}
				};
			});
		});

		function pagingCategoryList(page){
			var order = $("li[class=active][id^=order]").children().val();
		 	var options = {
				url : "<spring:url value='/shop/getShopCornerPagingList' />"
				, type : "POST"
				, dataType : "html"
				, data : {
					cateCdL : cateCdL
					,dispCornNo : '${so.dispCornNo}'
					,dispClsfCornNo : '${so.dispClsfCornNo}'
					,dispType : '${so.dispType}'
					,page : page
					,rows : rows
					,order : order
				}
				, done :	function(html){
					$("#orderGoodsList").append(html);
					if($("#orderGoodsList li").length % rows != 0 || $("#orderGoodsList li").length == goodsCount){
						result = false;					
					}else {
						scrollPrevent = true;
					}
					pushUrl();
				}
			};
			ajax.call(options);
		}
	</script>
</tiles:putAttribute>	
</tiles:insertDefinition>