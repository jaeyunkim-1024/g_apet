<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.include" value="script.petshop"/>
	<tiles:putAttribute name="script.inline">
	<c:if test="${deviceGb ne frontConstants.DEVICE_GB_10 }">	
	<script type="text/javascript">
		$(document).ready(function(){
			$(".mo-header-backNtn").attr("onClick", "goPetShopMain();");
			/* 탭이동 종료 후 이벤트 */
			var idx = $("li[id^=upDispClsfNo_][class~=active]").data("cateidx");
			if(idx != 'undefined') {
				ui.disp.subnav.elSwiper.el.slideTo(idx-1);
			};
			
			ui.loading.show(); // 로딩 열기
		});
	</script>
	</c:if>
	<script type="text/javascript">
		$(window).bind("pageshow", function(event){
			if(event.originalEvent.persisted || window.performance && window.performance.navigation.type == 2){
				var state = window.history.state;
				if(state) {
					$("#contents").html('');
					page = state.page;
					scrollPrevent = state.scrollPrevent;
					$("#contents").html(state.data);
					$("#order_"+state.order).click();
					ui.disp.sld.recmd.using();
					ui.disp.sld.cbanr.using();
					ui.disp.sld.foneline.using();
				}else {
					window.history.replaceState(null, null, null);
				}
			}else{
				window.history.replaceState(null, null, null);
			}
		
			ui.loading.hide(); // 로딩 닫기
		});
		
		function setMCateList(dispClsfNo, upDispClsfNo, scateYN) {
			var dispClsfNo2 ='${view.dispClsfNo}';
			var url = "/shop/indexCategory?dispClsfNo="+dispClsfNo+"&dispClsfNo2="+dispClsfNo2+"&cateCdL="+upDispClsfNo+"&cateCdM="+dispClsfNo;
			var cateCdL = $("#cateCdL").val();
			var cateCdM = $("#cateCdM").val();
			if(scateYN == 'Y') {
				url = "/shop/indexCategory?dispClsfNo="+dispClsfNo+"&dispClsfNo2="+dispClsfNo2+"&cateCdL="+cateCdL+"&cateCdM="+cateCdM;
			}
			location.href = url;
		}
		
		// 소분류 상품 가져오기
		function getScateGoodsList(dispClsfNo, upDispClsfNo, sCateYn) {
			page = 0;
			result = true;
			scrollPrevent = true;
			
			if(sCateYn == 'N') {
				dispClsfNo = $("#cateCdM").val();
			}
			
			var options = {
				url : "<spring:url value='/shop/getScateGoodsList' />"
				, type : "POST"
				, dataType : "html"
				, data : {
					dispClsfNo : dispClsfNo
					, dispClsfNo2 :  $("input[id^=dispClsfNo_]").val()
					, cateCdL : $("#cateCdL").val()
					, cateCdM : $("#cateCdM").val()
					, order : $("li[class=active][id^=order]").children().val()
					, page : page
				}
				, done : function(html){
					$("#sCateGoodsList").empty();
					$("#sCateGoodsList").append(html);
					filter.pushUrl(dispClsfNo);
					filter.reset();
					ui.disp.sld.recmd.using();
				}
			};
			ajax.call(options);
		}

		//상품보기
		var filter = {
			detail : function(callback, order){
				page = 0;
				result = true;
				scrollPrevent = true;
				var dispClsfNo = $("li[class~=active][name^=dispClsfNo]").attr('id');
				var filters = new Array();
				var bndNos = new Array();
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
				 
				//필터 삭제시
				}else if(callback == "del"){
					$("span[name=selFilt]").each(function(){
						var filter = $(this).attr('id');
						filters.push(filter);
					});
				 	
				 	//브랜드
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
				
				var options = {
					url : "<spring:url value='/shop/getScateGoodsList' />"
					, type : "POST"
					, dataType : "html"
					, data : {
						dispClsfNo : dispClsfNo,
						dispClsfNo2 :  $("input[id^=dispClsfNo_]").val(),
						cateCdL : $("#cateCdL").val(),
						cateCdM : $("#cateCdM").val(),
				 		filters : filters,
				 		bndNos: bndNos,
						order: order,
						page : page
					}
					, done :	function(result){
						ui.popLayer.close('popFilter');
						$("#order").val(order);
						$("#filters").val(filters);
						$("#bndNos").val(bndNos);
						$("#sCateGoodsList").empty();
						$("#sCateGoodsList").append(result);
						ui.disp.sld.recmd.using();
						
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
					 		$(".flist").append(html);
					 		ui.disp.sld.foneline.using();
					 		var len = $(".fil").length;
							$("button[name=countName]").addClass('on');
							$("#filCount").text("("+len+")");
						}else{
							$(".flist").parent().removeClass("on");
							$("button[name=countName]").removeClass('on');
						}
						filter.pushUrl(dispClsfNo);
					}
				};
				ajax.call(options);
			},
			//필터삭제
			filterDel : function(id){
				$("span[id="+id+"]").remove();
				filter.detail('del');
			},
			//새로고침
			refresh : function(refresh){
				$(".flist").children().remove();
				var order = $("#order_SALE").children().val();
// 				$("#order_DATE").children().click();
				filter.detail(refresh, order);
			},
			reset : function(){
				$(".remove-tag").remove();
				$(".tag button").removeClass('active');
				$(".flist").parent().removeClass("on");
			},
			open : function(){
				var dispClsfNo = $("li[class~=active] #filterDispClsfNo").attr('value');
				var dataAll = new Array();
				
				if(dispClsfNo == undefined){
					dispClsfNo = $("#cateCdM").val();
				}
				
				var filters = new Array();
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
					
				
				var options = {
						url : "<spring:url value='/shop/categoryFilterPop' />"
						, type : "POST"
						, dataType : "html"
						, data : {
							dispClsfNo : dispClsfNo,
							filters : filters,
							bndNos : bndNos
						}
						, done :	function(html){
							$(".popFilter").remove();
							$(".filterPop").append(html);
							ui.toggleClassOn.init();
							ui.order.filter.using();
							ui.popLayer.open('popFilter');
							
							for(var i in dataAll){
								var id = dataAll[i].id;
								var name = dataAll[i].name;
								var text = dataAll[i].text;
								filtDetail.append(id, text, name);
							}
							filtDetail.count();
						}
					};
					ajax.call(options);
			},
			pushUrl : function(dispClsfNo) {
				var params = new URLSearchParams(location.search);
				params.set('dispClsfNo', dispClsfNo);
				var searchParams = params.toString();
				var goUrl = window.location.pathname + "?"+searchParams;
				var order = $("li[class=active][id^=order]").children().val();
				window.history.replaceState( {data : $("#contents").html(), order : order, page : page, scrollPrevent : scrollPrevent}, null, goUrl);
			}
		}
		
		
	</script>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<main class="container lnb page shop ct cate" id="container">
			<form id="categoryListForm">
				<input type="hidden" name="cateCdL" id="cateCdL" value="${mCategoryList[0].upDispClsfNo}"/>
				<input type="hidden" name="cateCdM" id="cateCdM" value="${sCategoryList[0].upDispClsfNo}"/>
			</form>
			<nav class="subtopnav">
				<div class="inr">
					<div class="swiper-container box">
						<ul class="swiper-wrapper menu">
							<c:forEach var="mCate" items="${mCategoryList}"  varStatus="status" >
							<li class="swiper-slide ${dispClsfNo == mCate.dispClsfNo ? 'active' : ''}" id="upDispClsfNo_${mCate.dispClsfNo}" data-cateidx="${status.count }">
								<a class="bt" href="javascript:void(0);" onclick="javascript:setMCateList('${mCate.dispClsfNo}', '${mCate.upDispClsfNo}', 'N');">${mCate.dispClsfNm }</a>
							</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</nav>
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<c:set var="listBanner_flag" value="false" />
					<c:if test="${not empty totalCornerList[0].listBanner }">
					<c:set var="listBanner_flag" value="true" />
					<section class="sect ct bannr">
						<div class="ct_bannr_sld">
							<span class="pagination"></span>
							<div class="swiper-container slide">
								<div class="sld-nav"><button type="button" class="bt prev">이전</button><button type="button" class="bt next">다음</button></div>
								<ul class="swiper-wrapper list">
									<c:forEach var="banner" items="${totalCornerList[0].listBanner }"  varStatus="status" >
									<li class="swiper-slide">
										<c:if test="${fn:indexOf(banner.bnrLinkUrl, '/event/detail') == -1}">
											<a href="${banner.bnrLinkUrl}" class="box">
												<img class="img mo" src="${frame:optImagePath(banner.bnrMobileImgPath, frontConstants.IMG_OPT_QRY_750)}" alt="${banner.bnrText}">
												<img class="img pc" src="${frame:optImagePath(banner.bnrImgPath, frontConstants.IMG_OPT_QRY_778)}" alt="${banner.bnrText}">
											</a>
										</c:if>
										<c:if test="${fn:indexOf(banner.bnrLinkUrl, '/event/detail') > -1}">
											<a href="${banner.bnrLinkUrl}&returnUrl=${requestScope['javax.servlet.forward.servlet_path']}" class="box">
												<img class="img mo" src="${frame:optImagePath(banner.bnrMobileImgPath, frontConstants.IMG_OPT_QRY_750)}" alt="${banner.bnrText}">
												<img class="img pc" src="${frame:optImagePath(banner.bnrImgPath, frontConstants.IMG_OPT_QRY_778)}" alt="${banner.bnrText}">
											</a>
										</c:if>
									</li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</section>
					</c:if>
					<c:set var="ulClass" value="false" />
					<c:forEach var="sCate" items="${sCategoryList}"  varStatus="status" >
						<c:if test="${fn:length(sCate.dispClsfNm) > 10}">
							<c:set var="ulClass" value="true" />
						</c:if>
					</c:forEach>
					<section class="sect ct ctabs" ${listBanner_flag ? 'style="margin-top: 30px;"' : ''}>
						<ul class="uiTab h menu ${ulClass ? 'type02' : '' }" id="sCateList">
							<li class="${so.dispClsfNo == so.cateCdM ? 'active' : ''}" id="${so.dispClsfNo}" name="dispClsfNo" ><a href="javascript:getScateGoodsList('', '', 'N');" class="bt" data-ui-tab-btn="tab_cate" data-ui-tab-val="tab_cate_1">전체</a></li>	
							<c:forEach var="sCate" items="${sCategoryList}"  varStatus="status" >
							<li class="swiper-slide ${sCate.dispClsfNo == so.dispClsfNo ? 'active' : ''}" id="${sCate.dispClsfNo}" name="dispClsfNo"><a href="javascript:getScateGoodsList('${sCate.dispClsfNo}', '${sCate.upDispClsfNo}', 'Y');" class="bt" data-ui-tab-btn="tab_cate" data-ui-tab-val="tab_cate_${status.count}">${sCate.dispClsfNm }</a>
								<input type="hidden" id="filterDispClsfNo" value="${sCate.dispClsfNo}"/>
								<input type="hidden" name="dispClsfNmLength" value="${fn:length(sCate.dispClsfNm) > 10}"/>
							</li>
							</c:forEach>
						</ul>
					</section>
					<section id="sCateGoodsList">
						<section class="sect ct cates">
							<div class="sticky_filter">
								<div class="inr">
									<div class="uioptsorts cates">
										<div class="dx lt">
											<div class="tot">총 <em class="n">${goodsCount}</em>개 상품</div>
										</div>
										<div class="dx rt">
											<nav class="filter">
												<button type="button" class="bt filt" id="btnFilter" onclick="filter.open();">필터<i class="n" id="filCount">()</i></button>
											</nav>
											<nav class="uisort only_down">
												<button type="button" class="bt st" value=""></button>
												<div class="list">
													<ul class="menu">
														<li id="order_SALE"><button type="button" class="bt" value="SALE" onclick="filter.detail('del', this.value);"><spring:message code='front.web.view.common.menu.sort.orderSale.button.title'/></button></li>
														<li id="order_SCORE"><button type="button" class="bt" value="SCORE" onclick="filter.detail('del', this.value);"><spring:message code='front.web.view.common.menu.sort.orderScore.button.title'/></button></li>
														<li id="order_DATE"><button type="button" class="bt" value="DATE" onclick="filter.detail('del', this.value);"><spring:message code='front.web.view.common.menu.sort.orderDate.button.title'/></button></li>
														<li id="order_LOW"><button type="button" class="bt" value="LOW" onclick="filter.detail('del', this.value);"><spring:message code='front.web.view.common.menu.sort.orderLow.button.title'/></button></li>
														<li id="order_HIGH"><button type="button" class="bt" value="HIGH" onclick="filter.detail('del', this.value);"><spring:message code='front.web.view.common.menu.sort.orderHigh.button.title'/></button></li>
													</ul>
												</div>
											</nav>
										</div>
									</div>
								</div>
							</div>
							<ul class="list" id="pagingGoods">
								<jsp:include page="/WEB-INF/view/petshop/include/petShopCategoryPaging.jsp"/>
							</ul>
						</section>
					</section>
				</div>
			</div>
		</main>
	<!-- 필터 팝업 인클루드  -->
	<section class="filterPop"></section>
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
		var dispClsfNo = $("li[class~=active][name^=dispClsfNo]").attr('id');
		var order = $("li[class=active][id^=order]").children().val();
		var filters = new Array();
		var bndNos = new Array();

		$("span[name=selFilt]").each(function(){
			var filter = $(this).attr('id');
			filters.push(filter);
		});
	 	
	 	//브랜드
	 	$("span[name=selBnd]").each(function(){
	 		var bndNo = $(this).attr('id');
	 		bndNos.push(bndNo);
	 	});
	 	
	 	var options = {
			url : "<spring:url value='/shop/getGoodsPagingList' />"
			, type : "POST"
			, dataType : "html"
			, data : {
				dispClsfNo : dispClsfNo,
				dispClsfNo2 :  $("input[id^=dispClsfNo_]").val(),
				cateCdL : $("#cateCdL").val(),
				cateCdM : $("#cateCdM").val(),
		 		filters : filters,
		 		bndNos: bndNos,
				order: order,
				page : page
			}
			, done :	function(html){
				$("#pagingGoods").append(html);
				if($("#pagingGoods li").length % rows != 0 || $("#pagingGoods li").length == goodsCount){
					result = false;					
				}else {
					scrollPrevent = true;
				}
				filter.pushUrl(dispClsfNo);
			}
		};
		ajax.call(options);
	}
		
	window.onload = function(){ 
		ui.loading.hide(); //로딩 닫기
	}

	</script>
	</tiles:putAttribute>	
</tiles:insertDefinition>