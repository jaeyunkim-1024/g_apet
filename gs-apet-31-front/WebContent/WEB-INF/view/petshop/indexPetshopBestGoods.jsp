<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.include" value="script.petshop"/>
	<tiles:putAttribute name="script.inline">
	<script type="text/template" id="bestTemplate">
	<li data-dispclsfno="{{dispClsfNo}}">
		<div class="gdset bests">
			<div class="num">
				<em class="b">{{count}}</em>
				<em class="udn {{rasingClass}}" {{rasingStyle}}>{{rasing}}</em>
			</div>
			<div class="thum">
				<a href="/goods/indexGoodsDetail?goodsId={{goodsId}}" class="pic" data-content='{{goodsId}}' data-url="/goods/indexGoodsDetail?goodsId={{goodsId}}">
					<img class="img" src="{{imgSrc}}" alt="{{goodsNm}}" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'">
				</a>
				<button type="button" class="bt zzim {{zzimCalss}}" data-content='{{goodsId}}' data-url="/goods/insertWish?goodsId={{goodsId}}" data-action="interest" data-yn="N" data-goods-id="{{goodsId}}" data-target="goods">찜하기</button>
			</div>
			<div class="boxs">
				<div class="tit">
					<a href="/goods/indexGoodsDetail?goodsId={{goodsId}}" class="lk" data-content='{{goodsId}}' data-url="/goods/indexGoodsDetail?goodsId={{goodsId}}">{{goodsNm}}</a>
				</div>
				<a href="/goods/indexGoodsDetail?goodsId={{goodsId}}" class="inf" data-content='{{goodsId}}' data-url="/goods/indexGoodsDetail?goodsId={{goodsId}}">
					<span class="prc"><em class="p">{{foSaleAmt}}</em><i class="w">원</i></span>
					<span class="pct" {{rateStyle}}><em class="n">{{rate}}</em><i class="w">%</i></span>
				</a>
			</div>
		</div>
	</li>
	</script>
	
	<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">	
	<script type="text/javascript">
		$(document).ready(function(){
			//$(".mo-header-backNtn").attr("onClick", "goPetShopMain('${so.dispCornNo}');");
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
		//베스트 자동/수동 세팅
		var dispType = '<c:out value="${dispType}"/>';
		//PC/모바일
		var deviceGb = '<c:out value="${view.deviceGb}"/>';
		var selectedDispClsfNo = null;
		//베스트20 목록
		var bestList = [];
		var bestListPeriod = [];
		var template = document.querySelector("#bestTemplate").innerHTML;

		<c:forEach var="goods" items="${bestGoodsList}"  varStatus="status">
			var count = '${status.count }';
			var filterInfo = '${goods.filterInfo }';
			var goodsId = '${goods.goodsId}';
			var goodsNm = '${goods.goodsNm }';
			var rasing = '${goods.rasing }';
			// var rasingStyle = dispType == 'AUTO' ? '' : 'style="display:none"';
			var rasingStyle = 'style="display:none"' ;
			var rasingClass = (rasing == 0) ? 'nn' : ( rasing > 0 ? 'up' : 'dn');
			rasing = Math.abs(rasing);
			var imgPath = '${goods.imgPath }';
			var imgSrc = '${frame:optImagePath(goods.imgPath, frontConstants.IMG_OPT_QRY_510)}';
			var interestYn = '${goods.interestYn}';
			var zzimCalss = (interestYn == 'Y') ? 'on' : '';
			var foSaleAmt = '${goods.foSaleAmt }'*1;
			var orgSaleAmt = '${goods.orgSaleAmt }'*1;
			var saleAmt = '${goods.saleAmt }'*1;
			var rate = 0;
			var rateStyle = 'style="display:none"';
			if(orgSaleAmt > saleAmt && ((orgSaleAmt - saleAmt) / orgSaleAmt * 100 ) >= 1 ) {
				rateStyle = 'style="display:"';
				rate = Math.floor(100 - (foSaleAmt * 100) / orgSaleAmt);
			}

			var best = template.replace(/{{count}}/gi, count)
				.replace(/{{dispClsfNo}}/gi, filterInfo)
				.replace(/{{goodsId}}/gi, goodsId)
				.replace(/{{goodsNm}}/gi, goodsNm)
				.replace(/{{rasing}}/gi, rasing)
				.replace(/{{rasingClass}}/gi, rasingClass)
				.replace(/{{imgSrc}}/gi, imgSrc)
				.replace(/{{zzimCalss}}/gi, zzimCalss)
				.replace(/{{rasingStyle}}/gi, rasingStyle)
				.replace(/{{foSaleAmt}}/gi, numberWithCommas(foSaleAmt))
				.replace(/{{rateStyle}}/gi, rateStyle)
				.replace(/{{rate}}/gi, rate);

			bestList.push(best);

		</c:forEach>
		
		$(document).ready(function(){
			// 베스트 20 목록 조회
			if(dispType == 'AUTO') {
				getGoodsBestAuto(0, bestList, 'filterBestList');
			}
			
			// 카테고리별 클릭시 이벤트
			$("button[id^=dispClsfNo_]").click(function(){
				var dispClsfNo = $(this).data("dispclsfno");
				if(dispType == 'AUTO') {
					var nowPeriod = $("li[name=range][class=active]").data("range");
					getGoodsBestManual(dispClsfNo, nowPeriod);
				}else {
					getGoodsBestManual(dispClsfNo);
				}
			});
			
			 $("li[name=range]").children('a').click(function(){
				var period = $(this).parent().data("range");
				var dispClsfNoPeriod = $("button[id^=dispClsfNo_][class~=active]").data("dispclsfno");
				getGoodsBestManual(dispClsfNoPeriod, period);
			 });
		});
		
		// 자동 베스트 상품 셋팅
		function getGoodsBestAuto(dispClsfNo, target, targetNm) {
			$('#bestGoodsList').html('');
			var targetNm = [];
			if(dispClsfNo) {
				//선택한 필터
				selectedDispClsfNo = dispClsfNo;
	
				$.each(target, function(i, v){
					var filterInfo = $(v).data('dispclsfno').split(',');
					var idx = $.inArray(dispClsfNo, filterInfo);
					if(idx > -1) {
						targetNm.push(v);
					}
				});
			} else {
				selectedDispClsfNo = null;
				targetNm = target.slice();
			}
	
			var liCnt = 0;
			//목록 담기
			$.each(targetNm, function(i, v){
				//html 세팅
				liCnt ++;
				var rowNum = liCnt;
				$('#bestGoodsList').append(v);
				$('#bestGoodsList li:eq('+(rowNum -1)+') div.num > em:eq(0)').text(rowNum);
			});
		}
		// 콤마
		function numberWithCommas(x) {
			x = String(x);
			var pattern = /(-?\d+)(\d{3})/;
			while (pattern.test(x))
				x = x.replace(pattern, "$1,$2");
			return x;
		}
		// 카테고리별  수동 베스트 상품 
		function getGoodsBestManual(dispClsfNo, period) {
			var options = {
				url : "<spring:url value='/shop/getBestGoodsList' />",
				data : { dispClsfNo : dispClsfNo
						, dispClsfCornNo : $("#dispClsfCornNo_best").val()
//	 					, salePeriodYn : '${frontConstants.COMM_YN_Y}'
						, period : period
						, dispType : dispType
						, totalCount : 50
						, stId : '${view.stId}'
				},
				done : function(data){
					$("#bestGoodsList").empty();
					var html = "";
					var item = data.getBestGoodsList;
					var amt = 0;
					var imgPath = "";
					var defaultImg = "this.src='\../../_images/common/img_default_thumbnail_2@2x.png\'";
					var zzimCalss = "";
					var rasing = 0;
					var rasingClass = "";
					//var rasingStyle = (dispType == 'AUTO' ? '' : 'style="display:none"');
					var rasingStyle = 'style="display:none"';
					for(var i in item){
						imgPath = "${frame:optImagePath('"+ item[i].imgPath +"', frontConstants.IMG_OPT_QRY_510)}";
						zzimCalss = (item[i].interestYn == 'Y' ? "on" : "");
						html += '<li>';
						html += '<div class="gdset bests">';
						html += '<div class="num"> ';
						html += '<em class="b">'+(i*1+1)+'</em> ';
						
						// if(dispType == 'AUTO') {
						//	rasingClass = (item[i].rasing == 0) ? 'nn' : (item[i].rasing > 0 ? 'up' : 'dn');
						//	rasing = Math.abs(item[i].rasing);
						//	html += '<em class="udn '+rasingClass+'" '+rasingStyle+'>'+rasing+'</em> ';
						// }
						
						html += '</div>';
						html += '<div class="thum">';
						html += '<a href="/goods/indexGoodsDetail?goodsId='+item[i].goodsId+'" class="pic" data-content="'+item[i].goodsId+'" data-url="/goods/indexGoodsDetail?goodsId='+item[i].goodsId+'">';
						html += '<img class="img" src="'+imgPath+'" alt="'+item[i].goodsNm+'" onerror="'+defaultImg+'">';
						html += '</a>';
						html += '<button type="button" class="bt zzim '+zzimCalss+'" data-content="'+item[i].goodsId+'" data-url="/goods/insertWish?goodsId='+item[i].goodsId+'" data-action="interest" data-yn="N" data-goods-id="'+item[i].goodsId+'" data-target="goods">찜하기</button>';
						html += '</div>';
						html += '<div class="boxs">';
						html += '<div class="tit">';
						html += '<a href="/goods/indexGoodsDetail?goodsId='+item[i].goodsId+'" class="lk" data-content="'+item[i].goodsId+'" data-url="/goods/indexGoodsDetail?goodsId='+item[i].goodsId+'">'+item[i].goodsNm+'</a>';
						html += '</div>';
						html += '<a href="/goods/indexGoodsDetail?goodsId='+item[i].goodsId+'" class="inf" data-content="'+item[i].goodsId+'" data-url="/goods/indexGoodsDetail?goodsId='+item[i].goodsId+'">';
						html += '<span class="prc"><em class="p">'+numberWithCommas(item[i].foSaleAmt)+'</em><i class="w">원</i></span>';
						if( item[i].orgSaleAmt > item[i].saleAmt && (100 - (item[i].foSaleAmt*100) / item[i].orgSaleAmt) >= 1) {
							amt = Math.floor(100 - (item[i].foSaleAmt*100) / item[i].orgSaleAmt);
							html += '&nbsp<span class="pct"><em class="n">'+amt+'</em><i class="w">%</i></span>';
						}
						html += '</a></div></div></li>';
					}
					$("#bestGoodsList").append(html);
				}
			};
			ajax.call(options);
		}
		
		function getGoodsBestAutoPeriod(period, dispClsfNoPeriod) {
			var options = {
					url : "<spring:url value='/shop/getBestGoodsList' />",
				data : { 
						dispClsfNo : '${so.cateCdL }'
						, dispClsfCornNo : $("#dispClsfCornNo_best").val()
// 						, salePeriodYn : '${frontConstants.COMM_YN_N}'
						, dispType : dispType
						, period : period
						, totalCount : 50
						, stId : '${view.stId}'
				},
				done : function(data){
					
					var item = data.getBestGoodsList;
					bestListPeriod = [];
					var templatePeriod = document.querySelector("#bestTemplate").innerHTML;
					$("#bestGoodsList").empty();
					for(var i in item){
						var countPeriod = i+1;
						var filterInfoPeriod = item[i].filterInfo;
						var goodsIdPeriod = item[i].goodsId;
						var goodsNmPeriod = item[i].goodsNm;
						var rasingPeriod = item[i].rasing;
						// var rasingStylePeriod = dispType == 'AUTO' ? 'style="display:"' : 'style="display:none"';
						var rasingStylePeriod = 'style="display:none"' ;
						var rasingClassPeriod = (rasingPeriod == 0) ? 'nn' : ( rasingPeriod > 0 ? 'up' : 'dn');
						rasingPeriod = Math.abs(rasingPeriod);
						var imgPathPeriod = item[i].imgPath;
						var imgSrcPeriod = "${frame:optImagePath('"+ item[i].imgPath +"', frontConstants.IMG_OPT_QRY_510)}";
						var interestYnPeriod = item[i].interestYn;
						var zzimCalssPeriod = (interestYnPeriod == 'Y') ? 'on' : '';
						var foSaleAmtPeriod = item[i].foSaleAmt;
						var orgSaleAmtPeriod = item[i].orgSaleAmt;
						var saleAmtPeriod = item[i].saleAmt;
						var ratePeriod = 0;
						var rateStylePeriod = 'style="display:none"';
						if(orgSaleAmtPeriod > saleAmtPeriod && ((orgSaleAmtPeriod - saleAmtPeriod) / orgSaleAmtPeriod * 100 ) >= 1 ) {
							rateStylePeriod = 'style="display:"';
							ratePeriod = Math.floor(100 - (foSaleAmtPeriod * 100) / orgSaleAmtPeriod);
						}
						
						var bestPeriod = templatePeriod.replace(/{{count}}/gi, countPeriod)
						.replace(/{{dispClsfNo}}/gi, filterInfoPeriod)
						.replace(/{{goodsId}}/gi, goodsIdPeriod)
						.replace(/{{goodsNm}}/gi, goodsNmPeriod)
						.replace(/{{rasing}}/gi, rasingPeriod)
						.replace(/{{rasingClass}}/gi, rasingClassPeriod)
						.replace(/{{imgSrc}}/gi, imgSrcPeriod)
						.replace(/{{zzimCalss}}/gi, zzimCalssPeriod)
						.replace(/{{rasingStyle}}/gi, rasingStylePeriod)
						.replace(/{{foSaleAmt}}/gi, numberWithCommas(foSaleAmtPeriod))
						.replace(/{{rateStyle}}/gi, rateStylePeriod)
						.replace(/{{rate}}/gi, ratePeriod);
	
						 bestListPeriod.push(bestPeriod);
					}
					getGoodsBestAuto(dispClsfNoPeriod, bestListPeriod, 'filterBestListPeriod');
				}
			};
			ajax.call(options);
		}
	</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
	<!-- 베스트 -->
	<input type="hidden" id="dispCornType_best" value="${frontConstants.GOODS_MAIN_DISP_TYPE_BEST}"/>
	<input type="hidden" id="dispClsfCornNo_best" value="${so.dispClsfCornNo}"/>
	<input type="hidden" id="dispType_best" value="${dispType}"/>
	<main class="container lnb page shop dm bests" id="container">
			<div class="pageHeadPc lnb">
				<div class="inr">
					<div class="hdt">
						<h3 class="tit">베스트</h3>
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
					<c:if test="${not empty bestGoodsList}">
					<nav class="smain_cate_sld">
						<div class="sld-nav">
							<button type="button" class="bt prev">이전</button>
							<button type="button" class="bt next">다음</button>
						</div>
						<div class="swiper-container slide">
							<ul class="uiTab f swiper-wrapper list">
								<li class="swiper-slide active">
									<button type="button" class="btn active" id="dispClsfNo_${so.cateCdL }" data-ui-tab-btn="tab_best" data-ui-tab-val="tab_best_b" data-dispClsfNo="${so.cateCdL }" data-filter="">전체</button>
								</li>
								<c:if test="${not empty bestGoodsList && bestGoodsList[0].dispType == 'MANUAL'}">
									<c:forEach var="category" items="${bestGoodsCategoryList}"  varStatus="status" >
										<li class="swiper-slide">
											<button type="button" class="btn" id="dispClsfNo_${category.cateNmM}" data-ui-tab-btn="tab_best" data-ui-tab-val="tab_best_b" data-dispClsfNo="${category.cateCdM}" data-filter="<fmt:formatNumber minIntegerDigits="2" value="${category.cateSeq}" type="number"/>_${category.cateNmM}">${category.cateNmM}</button>
										</li>
									</c:forEach>
								</c:if>
								<c:if test="${not empty bestGoodsList && bestGoodsList[0].dispType == 'AUTO'}">
									<c:forEach var="allCategorylist" items="${view.displayCategoryList}">
										<c:if test="${allCategorylist.dispClsfNo == so.cateCdL && allCategorylist.dispLvl == 1 && allCategorylist.subDispCateList != null}">
											<c:forEach var="subCategorylist" items="${allCategorylist.subDispCateList}"  varStatus="categoryIndex" >
												<c:if test="${subCategorylist.bestCategoryYn == 'Y' && subCategorylist.dispLvl == 2 && allCategorylist.dispClsfNo == subCategorylist.upDispClsfNo}">
													<li class="swiper-slide">
														<button type="button" class="btn" id="dispClsfNo_${subCategorylist.dispClsfNo}" data-ui-tab-btn="tab_best" data-ui-tab-val="tab_best_b" data-dispClsfNo="${subCategorylist.dispClsfNo}">${subCategorylist.dispClsfNm }</button>
													</li>
												</c:if>
											</c:forEach>
										</c:if>
									</c:forEach>
								</c:if>
							</ul>
						</div>
					</nav>
					</c:if>
					
					<c:if test="${not empty bestGoodsList && bestGoodsList[0].dispType != 'MANUAL'}">
					<nav class="tab bests">
						<ul class="uiTab g tmenu">
							<li class="active" name="range" data-range="DAY">
								<a class="bt" data-ui-tab-btn="tab_bests_range" href="javascript:;"><span>일간</span></a>
							</li>
 							<li name="range" data-range="WEEK">
 								<a class="bt" data-ui-tab-btn="tab_bests_range" href="javascript:;"><span>주간</span></a>
 							</li>
							<li name="range" data-range="MONTH">
								<a class="bt" data-ui-tab-btn="tab_bests_range" href="javascript:;"><span>월간</span></a>
							</li>
						</ul>
					</nav>
					</c:if>
					<section class="sect dm bests">
						<div class="ranklist">
							<ul class="list" id="bestGoodsList">
							<c:if test="${dispType == 'MANUAL'}">
							<c:forEach var="goods" items="${bestGoodsList}"  varStatus="status">
							<li>
								<div class="gdset bests">
									<div class="num"><em class="b">${status.count }</em></div>
									<div class="thum">
										<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="pic" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">
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
							</c:forEach>
							</c:if>
							</ul>
						</div>
					</section>
				</div>
			</div>
		</main>
		<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
			<jsp:param name="floating" value="" />
		</jsp:include>
	</tiles:putAttribute>
</tiles:insertDefinition>