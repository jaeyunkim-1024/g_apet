<c:if test="${view.deviceGb == frontConstants.DEVICE_GB_10}">
<script type="text/javascript">
var liboxH = $(".filOneLine .container > ul").height(); // 필터리스트 박스 높이

/* 21.06.24 test */
$(".fil_remove .remove-tag .close").click(function(){
	$(this).parent().parent("li").css("display","none");
});

setTimeout(function(){
	function setMargin(liboxH){
		if(liboxH >= 90){ // 3줄 이상
			$(".filOneLine .container ul li").css("margin-bottom","5px");
		}else if(liboxH < 90){ //2줄 이하
			$(".filOneLine .container ul li").css("margin-bottom","8px");
		}
	}
	setMargin(liboxH);
	
	$("main button").click(function(){
		var liboxH = $(".filOneLine .container > ul").height(); // 필터리스트 박스 높이
		setMargin(liboxH);
	});
	
},500);
</script>
</c:if>
<!-- 필터 팝업 -->
<article class="popLayer a popFilter" id="popFilter">	<!--  popSample1 -> popFilter APET-1099 -->
	<div class="pbd">
		<div class="phd">
			<div class="in">
				<h1 class="tit">상세검색</h1>
				<button type="button" class="btnPopClose">닫기</button>
			</div>
		</div>
		<div class="pct">
			<main class="poptents b filter">
				<div class="remove-area filOneLine fil_remove" id="fitersOnPop">
					<div class="${view.deviceGb eq frontConstants.DEVICE_GB_10 ? 'container' : 'swiper-container'}">
						<ul id="filterPopup" class="${view.deviceGb eq frontConstants.DEVICE_GB_10 ? '' : 'swiper-wrapper'}">
						</ul>
					</div>
				</div>
				<section class="sect k0426" data-sid="ui-tabs">
					<ul class="uiTab a d">
						<li class="active">
							<a class="bt" id="filterDetail" data-ui-tab-btn="tab_a" data-ui-tab-val="tab_a_1" href="javascript:void(0);"><span>상세조건</span></a>
						</li>
						<li>
							<a class="bt" data-ui-tab-btn="tab_a" data-ui-tab-val="tab_a_2" href="javascript:void(0);"><span>브랜드</span></a>
						</li>
					</ul>
					
					<div data-ui-tab-ctn="tab_a" data-ui-tab-val="tab_a_1" class="active">
						<div class="filter-area">
							<c:forEach items="${filter}" var="filter">
								<div class="filter-item">
										<strong class="tit">${filter.filtGrpShowNm}</strong>
										<div class="tag" id="goodsTag">
											<c:forEach items="${filter.filtAttrs}" var="item" varStatus="idx">
												<button id="${filter.filtGrpNo}_${item.filtAttrSeq}" onclick="filter.btnActive(this);">${item.filtAttrNm}</button>
											</c:forEach>
										</div>
								</div>
							</c:forEach>
						</div>
					</div>
					<div data-ui-tab-ctn="tab_a" data-ui-tab-val="tab_a_2">
						<div class="brand-check">
							<nav class="uisort only_down">
								<button type="button" id="bndSortVal" class="bt st" value="v_2">인기순</button>
								<div class="list">
									<ul class="menu">
										<li class="active" ><button type="button" class="bt" value="v_2" onclick="filter.brandSort('10');">인기순</button></li>
										<li><button type="button" class="bt" value="v_1" onclick="filter.brandSort('');">가나다순</button></li>
									</ul>
								</div>
							</nav>
							<ul class="brand-list">
								<c:forEach items="${brandList}" var="brand">
									<li>
										<label class="checkbox">
											<input type="checkbox" id="brand_${brand.bndNo}" data-bndnm="${brand.bndNmKo}" onclick="filter.btnActive(this,true);" /><span class="txt">${brand.bndNmKo}</span>
										</label>
										<span class="num">${brand.docCount}</span>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</section>
				<!-- tab -->
			</main>
		</div>
		<div class="pbt b">
			<div class="bts">
				<button type="button" class="btn xl d" onclick="filter.resetFilterOnPop();">초기화</button>
				<button type="button" class="btn xl a" onclick="filter.apply(true);"><span id="preGoodsCnt"></span>상품보기</button>
			</div>
		</div>
	</div>
</article>
<!--// 필터 팝업 -->	