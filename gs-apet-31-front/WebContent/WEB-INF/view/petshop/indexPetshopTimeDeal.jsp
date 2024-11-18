<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.include" value="script.petshop"/>
	<tiles:putAttribute name="script.inline">	
		<script type="text/javascript">
			var goodsArr = new Array();
			$(document).ready(function(){
				<c:forEach var="timeDeal" items="${cornerList.timeDealList}">
				<c:if test="${timeDeal.dispType eq frontConstants.GOODS_MAIN_DISP_TYPE_DEAL_NOW}">
				goodsArr.push('${timeDeal.goodsId}');
				</c:if>
				</c:forEach>
				timeBefore()
				
				<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">	
				$(".mo-heade-tit .tit").html("파격특가 타임딜");	
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
			
			// 타임딜 시간 셋팅	
		    function timeBefore(){
	   	 		$("[id^='timeDeal_']").each(function(index) {
					var $this = $(this);
					var dre = $this.val();
					var timeDeal = new Date(dre.replace(/\s/, 'T'));
					
					$this.countdown(timeDeal, function(event) {
						var resultTime = ( event.strftime('%D') != 0 ? event.strftime('%D') + '일  ' : '' ) + event.strftime('%H:%M:%S');
						$("#time_"+goodsArr[index]).text( "⌛️ "+resultTime);
						}).on('finish.countdown', function () {
							$("#liTag_"+goodsArr[index]).hide();
	                   });
				 });
		    }
			
		    function pushUrl(dispType) {
				var params = new URLSearchParams(location.search);
				params.set('timeDeal', dispType);
				var searchParams = params.toString();
				var goUrl = window.location.pathname + "?"+searchParams;
				window.history.replaceState( {data : $("#contents").html(), page : page, scrollPrevent : scrollPrevent}, null, goUrl);
			}
		    
		    function pageReset() {
		    	page = 0;
				result = true;
				scrollPrevent = true;
			}
		</script>		
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
	<!-- 타임딜 -->
	<input type="hidden" id="dispCornType_deal" value="${frontConstants.GOODS_MAIN_DISP_TYPE_DEAL}"/>
	<main class="container lnb page shop hm tdeal" id="container">
		<div class="pageHeadPc lnb">
			<div class="inr">
				<div class="hdt">
					<h3 class="tit">파격특가 타임딜</h3>
				</div>
			</div>
		</div>
		
		<div class="inr">
			<!-- 본문 -->
			<div class="contents" id="contents">
				<section class="tabs tdeal">
					<ul class="uiTab e tmenu">			
					<c:set var="goodsCount" value="${not empty cornerList.goodsCount ? cornerList.goodsCount : 0}"/>
	                <c:set var="nowDealCount" value="${cornerList.timeDealList[0].dispType eq 'NOW' ? cornerList.timeDealList[0].dispTypeCount : 0}"/>
	                <c:set var="soonDealCount" value="${goodsCount - nowDealCount}"/>			
						<c:if test="${not empty cornerList.timeDealList}">
						<c:choose>
							<c:when test="${goodsCount == nowDealCount && cornerList.timeDealList[0].dispType == 'NOW'}">   
								<li class="active" id="btnNOW">
									<button type="button" class="btn" data-ui-tab-btn="tab_deal" data-ui-tab-val="tab_deal_a" data-dispType='NOW' onclick="pageReset()">진행중</button>
								</li>
							</c:when>
							<c:when test="${goodsCount == soonDealCount && cornerList.timeDealList[0].dispType != 'NOW'}"> 
								<li class="active" id="btnSOON">
									<button type="button" class="btn" data-ui-tab-btn="tab_deal" data-ui-tab-val="tab_deal_b" data-dispType='SOON' onclick="pageReset()">다음 타임딜</button>
								</li>
							</c:when>
							<c:otherwise>
								<li class="${so.timeDeal eq 'NOW' ? 'active' : empty so.timeDeal ? 'active' : '' }" id="btnNOW">
									<button type="button" class="btn" data-ui-tab-btn="tab_deal" data-ui-tab-val="tab_deal_a" data-dispType='NOW' onclick="pageReset()">진행중</button>
								</li>
								<li class="${so.timeDeal eq 'SOON' ? 'active' : '' }" id="btnSOON">
									<button type="button" class="btn" data-ui-tab-btn="tab_deal" data-ui-tab-val="tab_deal_b" data-dispType='SOON' onclick="pageReset()">다음 타임딜</button>
								</li>
							</c:otherwise>
						</c:choose>
						</c:if>
					</ul>
				</section>
				<div data-ui-tab-ctn="tab_deal" data-ui-tab-val="tab_deal_a" class="tbctn ${so.timeDeal eq 'NOW' ? 'active' : empty so.timeDeal ? 'active' : ''  }">
					<section class="sect ct tdeal">
						<ul class="list" id="orderGoodsListNOW">
							<c:forEach var="goods" items="${cornerList.timeDealList}">
							<c:if test="${goods.dispType eq frontConstants.GOODS_MAIN_DISP_TYPE_DEAL_NOW && ((goods.salePsbCd ne frontConstants.SALE_PSB_30) || (goods.salePsbCd eq frontConstants.SALE_PSB_30 && goods.ostkGoodsShowYn eq 'Y'))}">
							<li id="liTag_${goods.goodsId}" data-goodsid="${goods.goodsId}">
								<div class="gdset tdeal">
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
											<img class="img" src="${frame:optImagePath(goods.imgPath, frontConstants.IMG_OPT_QRY_510)}" alt="${goods.goodsNm}" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'">
										</a>
										<button type="button" class="bt zzim ${goods.interestYn eq 'Y' ? 'on' : ''}" data-content='${goods.goodsId}' data-url="/goods/insertWish?goodsId=${goods.goodsId}" data-action="interest" data-yn="N" data-goods-id="${goods.goodsId}" data-target="goods">찜하기</button>
										<input type="hidden" id="timeDeal_${goods.goodsId}" value="${goods.saleEndDtm}"/>
										<div class="time" id="time_${goods.goodsId}"></div>
									</div>
									<div class="boxs">
										<div class="tit"><a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="lk" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">${goods.goodsNm }</a></div>
										<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="inf" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">
											<span class="prc"><em class="p"><frame:num data="${goods.foSaleAmt}" /></em><i class="w">원</i></span>
											<c:if test="${goods.orgSaleAmt > goods.saleAmt and ((goods.orgSaleAmt - goods.saleAmt)/goods.orgSaleAmt * 100) >= 1 }">
											<span class="pct"><em class="n"><fmt:parseNumber value="${100-((goods.foSaleAmt * 100) / goods.orgSaleAmt)}" integerOnly="true"/></em><i class="w">%</i></span>
											</c:if>
										</a>
									</div>
								</div>
							</li>
							</c:if>
							</c:forEach>
						</ul>
					</section>
				</div>
				<div data-ui-tab-ctn="tab_deal" data-ui-tab-val="tab_deal_b" class="tbctn ${so.timeDeal eq 'SOON' ? 'active' : '' }">
					<section class="sect ct tdeal">
						<ul class="list" id="orderGoodsListSOON">
							<c:forEach var="goods" items="${cornerList.timeDealList}">
							<c:if test="${goods.dispType eq frontConstants.GOODS_MAIN_DISP_TYPE_DEAL_SOON && ((goods.salePsbCd ne frontConstants.SALE_PSB_30) || (goods.salePsbCd eq frontConstants.SALE_PSB_30 && goods.ostkGoodsShowYn eq 'Y'))}">
							<li>
								<div class="gdset tdeal">
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
											<img class="img" src="${frame:optImagePath(goods.imgPath, frontConstants.IMG_OPT_QRY_510)}" alt="${goods.goodsNm}" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'">
										</a>
										<button type="button" class="bt zzim" data-target="goods" data-action="interest" data-yn="N" data-goods-id="${goods.goodsId}">찜하기</button>
										<div class="time" id="time_${goods.goodsId}"><fmt:formatDate value="${goods.dealDate}" pattern="MM월 dd일 HH:mm"/></div>
									</div>
									<div class="boxs">
										<div class="tit"><a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="lk" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">${goods.goodsNm }</a></div>
										<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="inf" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">
											<span class="prc"><em class="p"><frame:num data="${goods.foSaleAmt}" /></em><i class="w">원</i></span>
											<c:if test="${goods.orgSaleAmt > goods.saleAmt and ((goods.orgSaleAmt - goods.saleAmt)/goods.orgSaleAmt * 100) >= 1 }">
											<span class="pct"><em class="n"><fmt:parseNumber value="${100-((goods.foSaleAmt * 100) / goods.orgSaleAmt)}" integerOnly="true"/></em><i class="w">%</i></span>
											</c:if>
										</a>
									</div>
								</div>
							</li>
							</c:if>
							</c:forEach>
						</ul>
					</section>
				</div>
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
		var nowDealCount ='${cornerList.timeDealList[0].dispType eq "NOW" ? cornerList.timeDealList[0].dispTypeCount : 0}'*1;
		var soonDealCount = goodsCount - nowDealCount
		var nowCount = 0;
		var dispClsfNo = '${view.dispClsfNo}'
		var cateCdL = '${so.cateCdL}'

		$(function(){
			$(window).scroll(function(){
				var scrollTop = $(this).scrollTop();
				var both = $(document).innerHeight() - window.innerHeight - ($("#footer").innerHeight() || 0);
				if (both <= (scrollTop +3)) {
					if(result && scrollPrevent){
						var dispType = $("li[id^=btn][class~=active] button").data("disptype");
						var liLength = $("#orderGoodsList"+dispType).children("li").length;
						nowCount = dispType == 'NOW' ? nowDealCount : soonDealCount;
						if((liLength != nowCount) && (liLength >= rows)){
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
			var dispType = $("li[id^=btn][class~=active] button").data("disptype");
		 	var options = {
				url : "<spring:url value='/shop/getShopCornerPagingList' />"
				, type : "POST"
				, dataType : "html"
				, data : {
					cateCdL : cateCdL
					,dispCornNo : '${so.dispCornNo}'
					,dispClsfCornNo : '${so.dispClsfCornNo}'
					,dispType : dispType
					,page : page
					,rows : rows
				}
				, done :	function(html){
					var $target = $("#orderGoodsList"+dispType);
					$target.append(html);
					goodsArr = [];
					$("#orderGoodsListNOW li[id^=liTag_]").each(function(){
						var goodsid = $(this).data("goodsid");
						goodsArr.push(goodsid);
					});
					timeBefore();
					if($target.children("li").length % rows != 0 || $target.children("li").length == nowCount){
						result = false;					
					}else {
						scrollPrevent = true;
					}
					pushUrl(dispType);
				}
			};
			ajax.call(options);
		}
	</script>
</tiles:putAttribute>	
</tiles:insertDefinition>