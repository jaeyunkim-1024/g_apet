<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
	//베스트 자동/수동 세팅
	var dispType = '<c:out value="${dispType}"/>';
	var step = 10;
	if('${view.deviceGb}' != 'PC') {
		step = 5
	}
	var isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent) ? true : false;
	
	$(document).ready(function(){
		
		// 순차적으로 베스트상품리스트 불러오기
		$.each($(".best_category_wrap ul li"), function(index) {
			if($(this).data('caterel') != 0) {
				getBestGoodsList( $(this).children('button').data("dispclsfno"), index);
			}
		});
		
		if(!isMobile) {
			var galleryThumbs = new Swiper(".best_category", {
				observer: true,
				observeParents: true,
				watchOverflow:true,
				simulateTouch:true,
				spaceBetween:8,
				slidesPerView: "auto",
				freeMode: true
			});
			
			$(".best_category .swiper-slide button").on('click', function () {
				var index = $(this).parents().data("caterel");
				galleryMain.activeIndex = index;
				$(this).parent().addClass("active").siblings("li").removeClass("active");
				galleryMain.slideTo(index);
				count=1
				initView('bestGoodsList', step*count,'block', index, galleryMain);
			});
			
			//카테고리(썸네일)스와이프
			var galleryMain = new Swiper(".best_list", {
				spaceBetween: 20,
				effect: "fade",
				fadeEffect:{
					crossFade: true
				},
				allowTouchMove: false,
				autoHeight:true,
				thumbs: {
					swiper: galleryThumbs
				}
			});
			
			$("#bestGoodsMore").click(function(){
				galleryMain.updateAutoHeight(300);
			})
		}
		else {
			//카테고리(썸네일)스와이프
			var galleryThumbs = new Swiper(".best_category", {
				slidesPerView: 'auto',
				freeMode: true,
				watchSlidesVisibility: true,
				watchSlidesProgress: true
			});
			
			$(".best_category .swiper-slide button").on('click', function () {
				$(this).parent().addClass("active").siblings("li").removeClass("active");
			});
			
			//제품목록스와이프
			var galleryMain = new Swiper(".best_list", {
				spaceBetween: 20,
				watchOverflow: true,
				watchSlidesVisibility: true,
				watchSlidesProgress: true,
				preventInteractionOnTransition: true,
				autoHeight: true,		//컨텐츠 높이별 스와이퍼 컨테이너 높이 자동조절
				navigation: {
					nextEl: '.swiper-button-next',
					prevEl: '.swiper-button-prev'
				}, 
				thumbs: {
					swiper: galleryThumbs
				}
				,on: {
					transitionEnd: function () {
						var activeThumNum = $(".best_list .swiper-slide-active").data('rel');
						count=1
						initView('bestGoodsList', step*count,'block', activeThumNum, galleryMain);
						$(".best_category .swiper-slide").removeClass("active");
						$(".best_category .swiper-slide").eq(activeThumNum).addClass("active");
					},
					slideChangeTransitionEnd: function(){
						galleryThumbs.slideTo(galleryMain.activeIndex);
					}
				}
			});
			
			$("#bestGoodsMore").click(function(){
				galleryMain.updateAutoHeight(300);
			})
		}
		
		// 베스트 상품 숨기기
		initView('bestGoodsList', step);
	});
	
	// 베스트 상품 초기 상품 셋팅
	function initView(el_id, view_item_count, style, index, galleryMain) {
		if(view_item_count == step) {
			$("#bestGoodsMore").show();
			$("#goBestGoodsList").hide();
		}
		index = (index != undefined) ? index : 0;
		var listId = el_id+index;
		var menu = document.getElementById(listId);
		var menu_list = menu.getElementsByTagName('li');
		var menu_count = menu_list.length;
		style = (typeof(style) != 'undefined' && style != '') ? style : 'block';
		if(view_item_count >= menu_count) {
			$("#bestGoodsMore").hide();
			$("#goBestGoodsList").show();
		}
		for(var i=0;i<menu_count;i++){
// 			if(i<view_item_count) menu_list[i].style.display = style;
			if(i<view_item_count) menu_list[i].style.removeProperty("display");
			else menu_list[i].style.display = 'none';
		}
		if(galleryMain != undefined) {
			galleryMain.updateAutoHeight(300);
		}
	}

	function getBestGoodsList(dispClsfNo, index) {
		$.ajax({
			method: "POST"
			, url : "<spring:url value='/shop/getBestGoodsList' />"
			, data: { dispClsfNo : dispClsfNo
					, dispClsfCornNo : $("#dispClsfCornNo_best").val()
// 					, salePeriodYn : '${frontConstants.COMM_YN_Y}'
					, dispType : $("#dispType_best").val()
					, totalCount : 20
					, stId : '${view.stId}'
			}
			, dataType: "json" 
		})
		.done(function(data) {
			$("#bestGoodsList" + index).empty();
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
				html += '<div class="num">';
				html += '<em class="b">'+(i*1+1)+'</em> ';
				
				// if(dispType == 'AUTO') {
				//	rasingClass = (item[i].rasing == 0) ? 'nn' : (item[i].rasing > 0 ? 'up' : 'dn');
				//	rasing = Math.abs(item[i].rasing);
				//	html += '<em class="udn '+rasingClass+'" '+rasingStyle+'>'+rasing+'</em> ';
				//}
				
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
				html += '<span class="prc"><em class="p">'+AddComma(item[i].foSaleAmt)+'</em><i class="w">원</i></span>';
				if( item[i].orgSaleAmt > item[i].saleAmt && (100 - (item[i].foSaleAmt*100) / item[i].orgSaleAmt) >= 1) {
					amt = (100 - (item[i].foSaleAmt*100) / item[i].orgSaleAmt).toFixed(0);
					html += '&nbsp<span class="pct"><em class="n">'+amt+'</em><i class="w">%</i></span>';
				}
				html += '</a></div></div></li>';
			}
			$("#bestGoodsList"+ index).append(html);
		});
	}
	
	function AddComma(num) {
		var regexp = /\B(?=(\d{3})+(?!\d))/g;
		return num.toString().replace(regexp, ',');
	}
	
	var count =1;
	function bestGoodsMore(){
		step = 10;
		if('${view.deviceGb}' != 'PC') {
			step = 5
		}
		count++
		var idx = $("button[id^=dispClsfNo_]").parents("[class~=active]").data("caterel");
		initView('bestGoodsList', step*count,'block', idx);
		if(step*count == 20) {
			$("#bestGoodsMore").hide();
			$("#goBestGoodsList").show();
		}
	}
	
	function goBestGoodsList(dispClsfNo, dispCornNo, dispClsfCornNo) {
		var dispType = $("#dispType_best").val();
		if(dispType == '${frontConstants.GOODS_MAIN_DISP_TYPE_BEST_AUTO}') {
			location.href="/shop/indexBestGoodsList?dispClsfNo="+dispClsfNo+"&dispCornNo="+dispCornNo;
		}else {
			location.href="/shop/indexBestGoodsList?dispClsfNo="+dispClsfNo+"&dispCornNo="+dispCornNo+"&dispClsfCornNo="+dispClsfCornNo;
		}
	}
</script>
<c:forEach var="cornerList" items="${totalCornerList}"  varStatus="status" >
	<c:if test="${param.dispCornNo == cornerList.dispCornNo }">
	<!-- 베스트 -->
	<input type="hidden" id="dispCornNo_best" value="${param.dispCornNo}"/>
	<input type="hidden" id="dispClsfCornNo_best" value="${cornerList.bestGoodsList[0].dispClsfCornNo}"/>
	<input type="hidden" id="dispType_best" value="${dispType}"/>
	<div class="sect mn best20    gallery-container" id="bestSection" tabindex="-1">
		<div class="hdts">
			<a class="hdt" href="javascript:void(0);" id="goodsList_${cornerList.bestGoodsList[0].dispClsfCornNo}" onclick="goBestGoodsList(${view.dispClsfNo}, ${param.dispCornNo}, ${cornerList.bestGoodsList[0].dispClsfCornNo});">
				<span class="tit"> 베스트랭킹</span> <span class="more"><b class="t">전체보기</b></span>
			</a>
		</div>
		<div class="best_category_wrap">
			<div class="best_category slide swiper-container gallery-thumbs">
				<ul class="swiper-wrapper">
					<c:set var="lastIndex" value=""/>
					<li class="swiper-slide active" data-caterel="0" name="cateLi">
						<button type="button" id="dispClsfNo_${so.cateCdL }" data-ui-tab-btn="tab_best" data-ui-tab-val="tab_best_b" data-dispClsfNo="${so.cateCdL }" data-filter="">전체</button>
					</li>
					<c:if test="${not empty cornerList.bestGoodsCategoryList && dispType == 'MANUAL'}">
						<c:forEach var="category" items="${cornerList.bestGoodsCategoryList}" varStatus="idx">
						<c:set var="lastIndex" value="${lastIndex + 1}"/>
						<li class="swiper-slide" data-caterel="${lastIndex}" name="cateLi">
							<button type="button" id="dispClsfNo_${category.cateNmM}" data-ui-tab-btn="tab_best" data-ui-tab-val="tab_best_b" data-dispClsfNo="${category.cateCdM}" data-filter="<fmt:formatNumber minIntegerDigits="2" value="${category.cateSeq}" type="number"/>_${category.cateNmM}">${category.cateNmM}</button>
						</li>
						</c:forEach>
					</c:if>
					<c:if test="${empty cornerList.bestGoodsCategoryList && dispType == 'AUTO'}">
						<c:forEach var="allCategorylist" items="${view.displayCategoryList}">
							<c:if test="${allCategorylist.dispClsfNo == so.cateCdL && allCategorylist.dispLvl == 1 && allCategorylist.subDispCateList != null}">
								<c:forEach var="subCategorylist" items="${allCategorylist.subDispCateList}"  varStatus="idx" >
									<c:if test="${subCategorylist.bestCategoryYn == 'Y' && subCategorylist.dispLvl == 2 && allCategorylist.dispClsfNo == subCategorylist.upDispClsfNo}">
										<c:set var="lastIndex" value="${lastIndex + 1}"/>
										<li class="swiper-slide" data-caterel="${lastIndex}" name="cateLi">
											<button type="button" id="dispClsfNo_${subCategorylist.dispClsfNo}" data-ui-tab-btn="tab_best" data-ui-tab-val="tab_best_b" data-dispClsfNo="${subCategorylist.dispClsfNo}">${subCategorylist.dispClsfNm }</button>
										</li>
									</c:if>
								</c:forEach>
							</c:if>
						</c:forEach>
					</c:if>
				</ul>
			</div>
		</div>
		<div class="best_list     swiper-container gallery-main " >
			<div class="swiper-wrapper">
				<c:forEach begin="0" end="${lastIndex}" varStatus="divIndex">
				<div class="swiper-slide"  data-rel="${divIndex.index }">
					<ul class="list" id="bestGoodsList${divIndex.index }">
						<c:if test="${divIndex.index > 0 ? false : true}">
						<c:set var="initItemCnt" value="${view.deviceGb == 'PC'? 10:5}"/>
						<c:forEach var="goods" items="${cornerList.bestGoodsList}"  varStatus="status">
						<c:choose>
						 <c:when test="${status.index < initItemCnt }">
							<li>
						 </c:when>
						 <c:otherwise>
						 	<li style="display: none;">
						 </c:otherwise>
						</c:choose>
							<div class="gdset bests">
								<div class="num">
									<em class="b">${status.count }</em>
									<c:if test="${not empty cornerList.bestGoodsList && cornerList.bestGoodsList[0].dispType != 'MANUAL'  && false}">
									<em class="udn ${goods.rasing == 0 ? 'nn' : goods.rasing < 0 ? 'dn' : 'up'}">${Math.abs(goods.rasing)}</em></c:if>
								</div>
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
				</c:forEach>
			</div>
		</div>
		<!-- 상품더보기버튼 -->
		<div class="moreload" id="bestGoodsMoreBtn">
			<button type="button" class="bt more" id="bestGoodsMore" onclick="bestGoodsMore();">상품 더보기</button>
			<button type="button" class="bt more best" id="goBestGoodsList" style="display: none;" onclick="goBestGoodsList(${view.dispClsfNo}, ${param.dispCornNo}, ${cornerList.bestGoodsList[0].dispClsfCornNo});">베스트 상품 전체보기</button>
		</div>
		<!-- //상품더보기버튼 -->
	</div>
	</c:if>
</c:forEach>