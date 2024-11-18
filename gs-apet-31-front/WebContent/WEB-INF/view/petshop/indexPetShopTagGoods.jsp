<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.include" value="script.petshop"/>
	<tiles:putAttribute name="script.inline">
	<c:if test="${deviceGb ne frontConstants.DEVICE_GB_10 }">	
	<script type="text/javascript">
		$(document).ready(function(){
			$("#header_pc").addClass('noneAc');
			$(".mo-heade-tit .tit").html("#${so.tagNm}");	
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
				}else {
					window.history.replaceState(null, null, null);
				}
			}else{
				window.history.replaceState(null, null, null);
			}
		});
		
		//상품보기
		var filter = {
			detail : function(callback, order){
				page = 0;
				result = true;
				scrollPrevent = true;
				var filters = new Array();
			 	var filterNm = new Array();
				var bndNos = new Array();
				var tags = new Array();
				var dataAll = new Array();
				
				if(order == undefined) {
					order = $("li[class=active][id^=order]").children().val();
				}
				
				if(callback != "refresh" && callback != "del"){
					$(".remove-tag[name=bndName]").each(function(){
			 			var bndNo = $(this).attr('id');
						bndNos.push(bndNo);
			 		});
				 	
				 	$(".remove-tag[name=filName]").each(function(){
				 		var filter = $(this).attr('id');
				 		filters.push(filter);
				 	})
				 	
				 	$(".remove-tag").each(function(){
				 		var dataObj = new Object();
				 		dataObj.name = $(this).attr('name');
				 		dataObj.id = $(this).attr('id');
				 		dataObj.text = $(this).text();
				 		dataAll.push(dataObj);
				 	})
				 	
				}else if(callback == "del"){
					$("span[name=selFilt]").each(function(){
						var filter = $(this).attr('id');
						filters.push(filter);
					});
				 	
				 	$("span[name=selBnd]").each(function(){
				 		var bndNo = $(this).attr('id');
				 		bndNos.push(bndNo);
				 	})
				 	
				 	$("span[class='fil']").each(function(){
				 		var dataObj = new Object();
				 		dataObj.name = $(this).attr('name');
				 		dataObj.id = $(this).attr('id');
				 		dataObj.text = $(this).children('em').text();
				 		dataAll.push(dataObj);
				 	})
				}
				
				// 태그
		 		tags.push( $("#tags").val() );
				
				var options = {
					url : "<spring:url value='/shop/getSortTagGoodsList' />"
					, type : "POST"
					, dataType : "html"
					, data : {
						tags : tags,
				 		filters : filters,
				 		bndNos: bndNos,
						order: order,
						page : page
					}
					, done :	function(result){
						ui.popLayer.close('popFilter');
						$("#tagGoodsList").empty();
						$("#tagGoodsList").append(result);
						var html = "<ul class=${view.deviceGb == 'PC' ? '' : 'swiper-wrapper'}>";
						if(dataAll.length > 0) {
					 		for(var i in dataAll){
					 			html+="<li class=${view.deviceGb == 'PC' ? '' : 'swiper-slide'}>";
								if(dataAll[i].name == "filName" || dataAll[i].name == "selFilt"){
									html += "<span class='fil' id="+dataAll[i].id+" name='selFilt'>";
								}else{
									html += "<span class='fil' id="+dataAll[i].id+" name='selBnd'>";
								}
								html += "<em class=tt>"+dataAll[i].text+"</em>";
								html += "<button class='del' onclick='filter.filterDel(\"" +dataAll[i].id+ "\");'>필터삭제</button>"
								html += "</span></li>"
					 		}
					 		html+= "</ul>";
					 		$("#uifiltbox").addClass("on");
					 		$(".sect.ct.tag > .list").addClass("hasFilter");
							$(".flist").append(html);
							ui.disp.sld.foneline.using();
							var len = $(".fil").length;
							$ ("button[name=countName]").addClass('on');
							$("#filCount").text("("+len+")");
						}else{
							$(".flist").parent().removeClass("on");
							$(".sect.ct.tag > .list").removeClass("hasFilter");
							$("button[name=countName]").removeClass('on');
						}
						filter.pushUrl();
						//APETQA-5584
						var brSort = $("#sortId li[class=active]").children().attr("value");
						filter.brandSort = brSort;
					}
				};
				ajax.call(options);
			},
			filterDel : function(id){
				$("#"+id).remove();
				filter.detail('del');
			},
			refresh : function(refresh){
				$(".flist").children().remove();
				var order = $("#order_DATE").children().val();
				filter.detail(refresh, order);
			},
			open : function(){
				var filters = new Array();
				var dataAll = new Array();
				
				$(".fil[name=selFilt]").each(function(){
					var filter = $(this).attr('id');
					filters.push(filter);
				});
				
				var bndNos = new Array();
				$(".fil[name=selBnd]").each(function(){
					var bndNo = $(this).attr('id');
					bndNos.push(bndNo);
				});
				
				
				$("span[class='fil']").each(function(){
					var dataObj = new Object();
					dataObj.name = $(this).attr('name');
					dataObj.id = $(this).attr('id');
					dataObj.text = $(this).children('em').text();
					dataAll.push(dataObj);
				})
				
// 				var goodsIds = '${goodsIds}';
//				goodsIds = goodsIds.replace("[","").replace("]","");
				var options = {
						url : "<spring:url value='/shop/tagFilterPop' />"
						, type : "POST"
						, dataType : "html"
						, data : {
						filters : filters
						,bndNos : bndNos
						//,goodsIds : goodsIds
					}
					, done :	function(result){
						$(".popFilter").remove();
						$(".filterPop").append(result);
						ui.toggleClassOn.init();
						ui.order.filter.using();
						ui.popLayer.open('popFilter');

						for(var i in dataAll){
							var id = dataAll[i].id;
							var name = dataAll[i].name;
							var text = dataAll[i].text;
							filtDetail.append(id, text, name);
						}
					}
				};
					ajax.call(options);
			},
			pushUrl : function() {
				var params = new URLSearchParams(location.search);
				var searchParams = params.toString();
				var goUrl = window.location.pathname + "?"+searchParams;
				window.history.replaceState( {data : $("#contents").html(), page : page, scrollPrevent : scrollPrevent}, null, goUrl);
			},
			brandSort : "v_1"
		}
	</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<main class="container page shop ct tag" id="container">
			<input type="hidden" id="tags" value="${so.tags[0]}"/>
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<div class="pc-tit">
						<h2>#<c:out value="${so.tagNm}" escapeXml="false"/></h2>
					</div>
					<section class="sect ct tag" id="tagGoodsList">
						<div class="sticky_filter_top">
							<div class="inr">
								<div class="uioptsorts tag">
									<div class="dx lt">
										<div class="tot"><spring:message code='front.web.view.new.menu.store'/> 상품 <em class="n">${empty goodsCount ? 0 : goodsCount}개</em></div>  <!-- APET-1250 210728 kjh02  -->
									</div>
									<div class="dx rt">
										<nav class="filter">
											<button type="button" class="bt filt" id="btnFilter" onclick="filter.open();">
												필터<i class="n" id="filCount">()</i>
											</button>
										</nav>
										<nav class="uisort">
											<button type="button" class="bt st" value=""></button>
											<div class="list">
												<ul class="menu">
													<li id="order_SALE"><button type="button" class="bt" value="SALE" onclick="filter.detail('del',this.value);"><spring:message code='front.web.view.common.menu.sort.orderSale.button.title'/></button></li>
													<li id="order_SCORE"><button type="button" class="bt" value="SCORE" onclick="filter.detail('del',this.value);"><spring:message code='front.web.view.common.menu.sort.orderScore.button.title'/></button></li>
													<li id="order_DATE"><button type="button" class="bt" value="DATE" onclick="filter.detail('del',this.value);"><spring:message code='front.web.view.common.menu.sort.orderDate.button.title'/></button></li>
													<li id="order_LOW"><button type="button" class="bt" value="LOW" onclick="filter.detail('del',this.value);"><spring:message code='front.web.view.common.menu.sort.orderLow.button.title'/></button></li>
													<li id="order_HIGH"><button type="button" class="bt" value="HIGH" onclick="filter.detail('del',this.value);"><spring:message code='front.web.view.common.menu.sort.orderHigh.button.title'/></button></li>
												</ul>
											</div>
										</nav>
									</div>
								</div>
							</div>
						</div>
						<ul class="list" id="pagingGoods">
							<c:forEach var="goods" items="${categoryGoodsList}"  varStatus="status" >
							<c:if test="${(goods.salePsbCd ne frontConstants.SALE_PSB_30) || (goods.salePsbCd eq frontConstants.SALE_PSB_30 && goods.ostkGoodsShowYn eq 'Y')}">
							<li>
								<div class="gdset defgd">
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
									</div>
									<div class="boxs">
										<div class="tit">
											<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="lk" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">${goods.goodsNm}</a>
										</div>
										<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="inf" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">
											<span class="prc"><em class="p"><frame:num data="${goods.foSaleAmt}" /></em><i class="w">원</i></span>
											<c:if test="${goods.orgSaleAmt > goods.saleAmt and ((goods.orgSaleAmt - goods.saleAmt)/goods.orgSaleAmt * 100) >= 1 }">
											<span class="pct"><em class="n"><fmt:parseNumber value="${100-((goods.foSaleAmt * 100) / goods.orgSaleAmt)}" integerOnly="true"/></em><i class="w">%</i></span>
											</c:if>
										</a>
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
	<!-- 필터 팝업 인클루드  -->
	<section class="filterPop"></section>
<%-- 	<jsp:include page="/WEB-INF/view/petshop/include/petshopTagFilterPop.jsp"/>   --%>
	<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
		<jsp:param name="floating" value="" />
	</jsp:include>
	
	<script>
	var page = 1
	var rows = '${frontConstants.PAGE_ROWS_20}';
	var result = true;
	var scrollPrevent = true;
	var deviceGb = "${view.deviceGb}"
	var goodsCount ='${goodsCount}';
	
	$(function(){
		$(window).scroll(function(){
			var scrollTop = $(this).scrollTop();
			var both = $(document).innerHeight() - window.innerHeight - ($("#footer").innerHeight() || 0);
			if (both <= (scrollTop +3)) {
				if(result && scrollPrevent){
					var liLength = $("ul[id=pagingGoods]").children("li").length;
					if((liLength != goodsCount) && (liLength >= 20)){
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
		var filters = new Array();
		var bndNos = new Array();
		var tags = new Array();

		$("span[name=selFilt]").each(function(){
			var filter = $(this).attr('id');
			filters.push(filter);
		});
	 	
	 	//브랜드
	 	$("span[name=selBnd]").each(function(){
	 		var bndNo = $(this).attr('id');
	 		bndNos.push(bndNo);
	 	});
	 	
		 // 태그
 		tags.push( $("#tags").val() );
	 
	 	var options = {
			url : "<spring:url value='/shop/getGoodsPagingList' />"
			, type : "POST"
			, dataType : "html"
			, data : {
				tags : tags,
		 		filters : filters,
		 		bndNos: bndNos,
				order: order,
				page : page
			}
			, done :	function(html){
				$("#pagingGoods").append(html);
				if( $("#pagingGoods li").length % 20 != 0 || $("#pagingGoods li").length == goodsCount){
					result = false;					
				}else {
					scrollPrevent = true;
				}
				filter.pushUrl();
			}
		};
		ajax.call(options);
	}
	</script>
	</tiles:putAttribute>	
</tiles:insertDefinition>