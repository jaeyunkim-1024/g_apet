<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.include" value="script.petshop"/>
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">
			$(document).ready(function(){
				<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
				$("#header_pc").addClass('noneAc');
				$(".mo-heade-tit .tit").html("패키지 상품");	
				$(".mo-header-backNtn").attr("onClick", "goPetShopMain();");
				</c:if>
				
				$(".btnPopClose").click(function(){
					filter.reset('Y');
				});
				
				$("button[name=addfilters]").click(function(){
// 					if($(this).hasClass("active")) {
						filter.filterAdd($(this).attr('id'), 'Y');
// 						$(this).css("pointer-events" ,"none");
// 					}
					filter.setDefault();
			    });
			});	
			
			$(window).bind("pageshow", function(event){
				if(event.originalEvent.persisted || window.performance && window.performance.navigation.type == 2){
					var state = window.history.state;
					if(state) {
						page = state.page;
						scrollPrevent = state.scrollPrevent;
						$("#contents").html(state.data);
						ui.disp.sld.foneline.using();
					}else {
						window.history.replaceState(null, null, null);
					}
				}else{
					window.history.replaceState(null, null, null);
				}
			});
			
			//상품보기
			var filter = {
				detail : function(popYn, order){
					page = 0;
					result = true;
					scrollPrevent = true;
					
					var filters = new Array();

					if(order == undefined) {
						order = $("li[class=active][id^=order]").children().val();
					}
					
					if(popYn != "N"){
						$(".remove-area span").each(function(){
					 		var filter = $(this).attr('id');
					 		if(filter == "GIFT") {
					 			filters.push("GIFTP");
					 		}
					 		filters.push(filter);
					 	});
					}else {
						$(".fil").each(function(){
							var filter = $(this).attr('id');
							if(filter == "GIFT") {
					 			filters.push("GIFTP");
					 		}
							filters.push(filter);
						});
					}
					
					var options = {
						url : "<spring:url value='/shop/getSortGoodsList' />"
						, type : "POST"
						, dataType : "html"
						, data : {
							dispClsfNo : '${view.dispClsfNo}'
							,dispCornNo : $("#dispCornNo_pack").val()
							,dispClsfCornNo : $("#dispClsfCornNo_pack").val()
							,dispType : $("#dispCornType_pack").val()
							,filters : filters
							,page : page
							,rows : rows
							,order : order
						}
						, done :	function(result){
							ui.popLayer.close('popFilter');
							$("#orderGoodsList").empty();
							$("#orderGoodsList").append(result);
							filter.pushUrl();
						}
					};
					ajax.call(options);
				},
				getCount : function(){
					var filters = new Array();
					$("button[name=addfilters][class=active]").each(function(){
				 		filters.push($(this).attr('id'));
				 		if($(this).attr('id') == "GIFT") {
				 			filters.push("GIFTP");
				 		}
				 	})
				 	if(filters.length > 0) {
				 		var options = {
								url : "<spring:url value='/shop/getPackageGoodsCount' />",
								data : {
									dispClsfNo : "${so.cateCdL}",
									dispClsfCornNo : $("#dispClsfCornNo_pack").val(),
									filters : filters
								}
								, done : function(data){
									var filters = data.filters;
									if(!filters) {
										$("#filterCnt").text("상품보기");
										$("#defaultText").text("선택하신 항목이 노출됩니다.");
									}else {
										$("#filterCnt").text(data.count+"개 상품보기");
										$("#defaultText").text("");
									}
							 		
							 		//지우기
									$("button[name=delfilters]").click(function(){
										var filterId = $(this).parent().attr('id');
		 								$("button[id="+filterId+"]").removeClass('active');
										$(".remove-tag[id="+filterId+"]").remove();
										filter.getCount();
									})
								}
							};
							ajax.call(options);
				 	}else {
				 		$("#filterCnt").text("상품보기");
						$("#defaultText").text("선택하신 항목이 노출됩니다.");
				 	}
					
				},
				filterDel : function(id, popYn){
					$("div[id=removeAreaPop] #" + id).remove();
// 					$("button[id="+id+"]").removeClass('active').css("pointer-events" ,"");
					if(popYn == 'N') {
						$("div[id=removeArea] #" + id).remove();
						filter.detail('N');
					}else {
						filter.getCount();
					}
				},
				filterAdd : function(id, popYn){
					var filterNm = filter.setFilterNm(id);
					var html = "<span class='remove-tag' name='removeArea' id='"+id+"'>"+filterNm+"<button class='close' name='delfilters'></button></span>";
					
					if($(".tag button[id="+id+"]").attr('class') == 'active'){
						$("#removeAreaPop").append(html);
					}else{
						$(".remove-tag[id="+id+"]").remove(); 
					}
					
					filter.getCount();
				},
				refresh : function(popYn){
					filter.reset(popYn);
					var order = $("li[class=active][id^=order]").children().val();
					$("#order_"+order).children().click();
					$("#uifiltbox").empty();
					$("#uifiltbox").removeClass('on');
					$(".sect.ct.packg > .list").removeClass("hasFilter");
// 					filter.detail(popYn);
				},
				reset : function(popYn){
					page = 0;
					result = true;
					scrollPrevent = true;
// 					$("button[name=addfilters]").css("pointer-events" ,"");
					if(popYn == 'N') {
						$("#btnFilter").removeClass('on');
						$("#btnFilter .n").text('');
						$(".fil").remove();
						filter.detail('N');
					}else {
						$("button[name=addfilters]").removeClass('active');
						$(".remove-tag").remove();
						filter.getCount();
					}
				},
				open : function(){
					ui.popLayer.open('popFilter');
					$("button[name=addfilters]").removeClass('active');
					$(".remove-tag").remove();
					
					var html = "";
					$(".fil").each(function(){
						var filterId = $(this).attr('id');
						var filterNm = filter.setFilterNm(filterId);
						$("button[id="+filterId+"]").addClass('active');
						filter.filterAdd(filterId);
					});
					if(filter.length > 0) {
						filter.getCount();
					}
				},
				setDefault : function(){
					if($("span[name=removeArea]").length > 0) {
						$("#defaultText").text("");
					}else {
						$("#defaultText").text("선택하신 항목이 노출됩니다.");
					}
				},
				setFilterNm : function(filterId){
					var filterNm = "";
					if('${frontConstants.GOODS_FRB_TP_1PLUS1}' == filterId) {
						filterNm = '1+1';
					}else if('${frontConstants.GOODS_FRB_TP_2PLUS1}' == filterId) {
						filterNm = '2+1';
					}else if('${frontConstants.GOODS_FRB_TP_GIFT}' == filterId) {
						filterNm = '사은품 증정';
					}else if('${frontConstants.GOODS_FRB_TP_ETC}' == filterId) {
						filterNm = '기타';
					}
					
					return filterNm;
				},
				pushUrl : function() {
					var params = new URLSearchParams(location.search);
					var searchParams = params.toString();
					var goUrl = window.location.pathname + "?"+searchParams;
					window.history.replaceState( {data : $("#contents").html(), page : page, scrollPrevent : scrollPrevent}, null, goUrl);
				}
			}
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
	<!-- 패키지 -->
	<input type="hidden" id="dispCornType_pack" value="${frontConstants.GOODS_MAIN_DISP_TYPE_PACKAGE}"/>
	<input type="hidden" id="dispCornNo_pack" value="${so.dispCornNo}"/>
	<input type="hidden" id="dispClsfCornNo_pack" value="${so.dispClsfCornNo}"/>
	<main class="container lnb page shop hm packg" id="container">
		<div class="pageHeadPc lnb">
			<div class="inr">
				<div class="hdt">
					<h3 class="tit">패키지 상품</h3>
				</div>
			</div>
		</div>
		<div class="inr">
			<!-- 본문 -->
			<div class="contents" id="contents">
				<section class="sect ct packg">
					<div class="sticky_filter_top">
						<div class="inr">
							<div class="uioptsorts packg">
								<div class="dx lt">
									<div class="tot">총 <em class="n" id="totalCount">${not empty cornerList.goodsCount ? cornerList.goodsCount : 0}</em>개 상품</div>
								</div>
								<div class="dx rt">
									<nav class="filter">
										<button type="button" class="bt filt" id="btnFilter" onclick="filter.open();">
											필터<i class="n"></i>
										</button>
									</nav>
									<nav class="uisort">	
										<button type="button" class="bt st" value=""></button>
										<div class="list">
											<ul class="menu">
												<li id="order_RCOM"><button type="button" class="bt" value="RCOM" onclick="filter.detail('N',this.value);"><spring:message code='front.web.view.common.menu.sort.orderrecommend.button.title'/></button></li>
												<li id="order_SALE"><button type="button" class="bt" value="SALE" onclick="filter.detail('N',this.value);"><spring:message code='front.web.view.common.menu.sort.orderSale.button.title'/></button></li>
												<li id="order_SCORE"><button type="button" class="bt" value="SCORE" onclick="filter.detail('N',this.value);"><spring:message code='front.web.view.common.menu.sort.orderScore.button.title'/></button></li>
												<li id="order_DATE"><button type="button" class="bt" value="DATE" onclick="filter.detail('N',this.value);"><spring:message code='front.web.view.common.menu.sort.orderDate.button.title'/></button></li>
												<li id="order_LOW"><button type="button" class="bt" value="LOW" onclick="filter.detail('N',this.value);"><spring:message code='front.web.view.common.menu.sort.orderLow.button.title'/></button></li>
												<li id="order_HIGH"><button type="button" class="bt" value="HIGH" onclick="filter.detail('N',this.value);"><spring:message code='front.web.view.common.menu.sort.orderHigh.button.title'/></button></li>
											</ul>
										</div>
									</nav>
								</div>
							</div>
							<div class="uifiltbox filOneLine" id="uifiltbox">
							</div>
						</div>
					</div>
					
					<ul class="list" id="orderGoodsList">
						<c:forEach var="goods" items="${cornerList.packageGoodsList}"  varStatus="status" >
						<c:if test="${(goods.salePsbCd ne frontConstants.SALE_PSB_30) || (goods.salePsbCd eq frontConstants.SALE_PSB_30 && goods.ostkGoodsShowYn eq 'Y')}">
						<li>
							<div class="gdset packg">
								<div class="h-bdg">
								<c:set var="loop_flag" value="false" />
								<c:forTokens  var="icons" items="${goods.icons}" delims=",">
									<c:if test="${not loop_flag }">
										<c:if test="${(icons eq '1+1') or (icons eq '2+1') or (icons eq '사은품')}">
											<c:set var="loop_flag" value="true" />
											<div class="bdg"><b class="n">${icons}</b></div>
										</c:if>
									</c:if>
								</c:forTokens>
								</div>
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
										<span class="prc"><em class="p"><fmt:formatNumber value="${goods.foSaleAmt}" type="number" pattern="#,###,###"/></em><i class="w">원</i></span>
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
	</main>
	<!-- 필터 팝업 -->
	<article class="popLayer a popFilter" id="popFilter">
	<div class="pbd">
		<div class="phd">
			<div class="in">
				<h1 class="tit">필터</h1>
				<button type="button" class="btnPopClose">닫기</button>
			</div>
		</div>
		<div class="pct">
			<main class="poptents b">
				<div class="remove-area" id="removeAreaPop">
					<b id="defaultText" style="color: #666">선택하신 항목이 노출됩니다.</b>
				</div>
				<section class="sect" data-sid="ui-tabs">
					<div data-ui-tab-ctn="tab_a" data-ui-tab-val="tab_a_1" class="active">
						<div class="filter-area">
							<div class="filter-item">
								<strong class="tit">구성/혜택</strong>
								<div class="tag">
									<c:forEach var="filter" items="${so.filterCondition }">
										<c:if test="${filter ne frontConstants.GOODS_FRB_TP_GIFTP}">
											<button id="${filter}" name="addfilters" class="">
												${filter eq frontConstants.GOODS_FRB_TP_1PLUS1 ? '1+1' : filter eq frontConstants.GOODS_FRB_TP_2PLUS1 ? '2+1' : filter eq frontConstants.GOODS_FRB_TP_GIFT ? '사은품 증정' : filter eq frontConstants.GOODS_FRB_TP_ETC ? '기타' : ''}
											</button>
										</c:if>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
				</section>
				<!-- tab -->
			</main>
		</div>
		<div class="pbt b">
			<div class="bts">
				<button type="button" class="btn xl d" onclick="filter.reset('Y');">초기화</button>
				<button type="button" class="btn xl a" id="filterCnt" onclick="filter.detail('Y');">상품보기</button>
			</div>
		</div>
	</div>
	</article>
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
		var filters = new Array();
		
		$("span[name=addfilters]").each(function(){
			var filter = $(this).attr('id');
			filters.push(filter);
		});
	 	
	 	var options = {
	 		url : "<spring:url value='/shop/getShopCornerPagingList' />"
			, type : "POST"
			, dataType : "html"
			, data : {
				cateCdL : cateCdL
				,dispCornNo : '${so.dispCornNo}'
				,dispClsfCornNo : '${so.dispClsfCornNo}'
				,dispType : '${so.dispType}'
		 		,filters : filters
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
				filter.pushUrl();
			}
		};
		ajax.call(options);
	}
	</script>
	</tiles:putAttribute>	
</tiles:insertDefinition>
