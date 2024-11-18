<script type="text/javascript">

//삭제버튼 클릭시
$("button[name=delBtn]").on('click', function(){
	var delId = $(this).parents().attr('id');
	var delName = $(this).parent().attr('name')
	$(".remove-tag[id="+delId+"]").remove();
	
	if(delName == "filName"){
		$("button[id="+delId+"]").attr('class', '');
		filtDetail.count();
	}else{
		$("input:checkbox[id="+delId+"]").prop("checked", false);
		filtDetail.count();
	}
	filtDetail.count();
})
	
//브랜드 정렬
$("button[name=sortBtn]").on('click', function(){
	var sidx;
	var sord;
	if($(this).val() == "v_1"){
		sidx = "SALE_QTY";
		sord = "DESC";
		
	}else if($(this).val() == "v_2"){
		sidx = "BND_NM";
		sord = "ASC";
	}
	
	filtDetail.brand(sidx, sord, "btn");
});

//상세조건 선택
$("button[name=filList]").on('click', function(){
	var filId = $(this).attr('id');
	var filText = $(this).text();
	filtDetail.append(filId, filText, 'fil');
})

var filtDetail = {
		//브랜드
		brand : function(sidx, sord, param){
			
			if(param != "btn"){
				var sort = $("#sortId li[class=active]").children().attr("value");
				if(sort == "v_1"){
					sidx = "SALE_QTY";
					sord = "DESC";
				}else if(sort == "v_2"){
					sidx = "BND_NM";
					sord = "ASC";
				}
			}
			
			var dispClsfNo = $("li[class~=active] #filterDispClsfNo").attr('value');
			if(dispClsfNo == undefined){
				dispClsfNo = $("#cateCdM").val()
			}

			var options = {
		 		url : "<spring:url value='/shop/brandList'/>",
		 		data : {
		 			sord : sord,
		 			sidx : sidx,
		 			dispClsfNo : dispClsfNo
		 		},
		 		done : function(data){
		 			$(".brand-list").empty();
		 			var list = data.brand;
		 			var html = "";
		 			
		 			for(var i in list){
		 				html += "<li>";
		 				html += "<label class='checkbox' id='chkbnd'>";
		 				html += "<input type='checkbox' name='brandChk' id="+list[i].bndNo+"><span class='txt'>"+list[i].bndNm+"</span>";
		 				html += "</label>";
		 				html += "<span class='num'>"+list[i].bndCnt+"</span>";
		 				html += "</li>";
		 			}
		 			$(".brand-list").append(html);
		 			
		 			//체크클릭 시
					$("input[name=brandChk]").on('click', function(){
						var bndNo = $(this).attr('id');
						var bndNm = $(this).siblings().text();
						filtDetail.append(bndNo, bndNm, 'bnd');
					})
					
					//선택한 값이 있으면 유지
					if($(".remove-tag[name=bndName]").text() != null){
						$(".remove-tag[name=bndName]").each(function(){
							var sel = $(this).attr('id')
							$("input:checkbox[id="+sel+"]").prop("checked", true);
				 		});
					}
		 		}
		 	};
		 	ajax.call(options);	
		}
		//카운트
		,count : function(){
			var filters = new Array();
			var bndNos = new Array();
			var tags = new Array();
			
			$(".remove-tag[name=filName]").each(function(){
		 		var filId = $(this).attr('id');
		 		filters.push(filId);
			})
			
			$(".remove-tag[name=bndName]").each(function(){
		 		var bndNo = $(this).attr('id');
		 		bndNos.push(bndNo);
			})
			
			var dispClsfNo = $("li[class~=active][name^=dispClsfNo]").attr('id');
			if(dispClsfNo == undefined) {
				dispClsfNo = $("#cateCdM").val();
			}
			
		 	// 태그
	 		tags.push( $("#tags").val() );
		 	
			var options = {
					url : "<spring:url value='/shop/getGoodsCount' />",
					data : {
						dispClsfNo : dispClsfNo, 
						filters : filters,
						bndNos : bndNos,
						tags : tags
					}
					, done : function(data){
						var cnt = data.getGoodsCount;
						var filCnt = data.so.filters;
						var bndCnt = data.so.bndNos;

						if(filCnt == null && bndCnt == null){
							$("#filterCnt").text("상품보기");
						}else{
							$("#filterCnt").text(cnt+"개 상품보기");
						}
					}
				};
				ajax.call(options);
		}
		//append
		,append : function(id, text, param){
			
			var html = "";
			html += '<li class=${view.deviceGb == "PC" ? "" : "swiper-slide"}>';
			if(param == "fil" || param == "selFilt"){
				html += '<span class="remove-tag" name="filName" id='+id+'>';
			}else{
				html += '<span class="remove-tag" name="bndName" id='+id+'>';
			}
			html += text;
			html += '<button class="close" name="delBtn"></button>';
			html += '</span>';
			html += '</li>'
			
			if(param == "fil" && $("button[id="+id+"]").attr('class') == ''){
				$("#filterPopup").append(html);
			}
			else if(param == "selFilt" && $("button[id="+id+"]").attr('class') == ''){
				$("#filterPopup").append(html);
				$("button[id="+id+"]").attr("class" ,"active");
			}
			else if(param == "bnd" && $("input:checkbox[id="+id+"]").prop("checked")){
				$("#filterPopup").append(html);
			}
			else if(param == "selBnd"){
				$("#filterPopup").append(html);
				$("input:checkbox[id="+id+"]").prop("checked", true);
			}
			else{
				$(".remove-tag[id="+id+"]").remove(); 
			}
			
			//삭제버튼 클릭시
			$("button[name=delBtn]").on('click', function(){
				var delId = $(this).parents().attr('id');
				var delName = $(this).parent().attr('name')
				$(".remove-tag[id="+delId+"]").remove();
				
				if(delName == "filName"){
					$("button[id="+delId+"]").attr('class', '');
					filtDetail.count();
				}else{
					$("input:checkbox[id="+delId+"]").prop("checked", false);
					filtDetail.count();
				}
			})
				filtDetail.count();
		}
		,reset : function(){
			$(".remove-tag").remove();
			$(".tag button").removeClass('active');
			$("input:checkbox[name='brandChk']").prop("checked", false);
			filtDetail.count();
		},
}
</script>
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
<article class="popLayer a popFilter on" id="popFilter">
	<div class="pbd">
		<div class="phd">
			<div class="in">
				<h1 class="tit">필터</h1>
				<button type="button" class="btnPopClose">닫기</button>
			</div>
		</div>
		<div class="pct">
			<main class="poptents b filter"> <!-- 03.31 수정 : filter 클래스 추가 -->
				<div class="remove-area filOneLine fil_remove">				<!-- filOneLine클래스, fil_remove클래스 추가 2021.04.28 수정 -->
					<div class="${view.deviceGb eq frontConstants.DEVICE_GB_10 ? 'container' : 'swiper-container'}">
						<ul id="filterPopup" class="${view.deviceGb eq frontConstants.DEVICE_GB_10 ? '' : 'swiper-wrapper'}">
						</ul>
					</div>
				</div>
				<section class="sect k0426" data-sid="ui-tabs"><!-- 04.26 -->
					<ul class="uiTab a d">
						<li class="active">
							<a class="bt" id="filterDetail" data-ui-tab-btn="tab_a" data-ui-tab-val="tab_a_1" href="javascript:void(0);"><span>상세조건</span></a>
						</li>
						<li>
							<a class="bt" id="brandDetail" data-ui-tab-btn="tab_a" data-ui-tab-val="tab_a_2" href="javascript:filtDetail.brand('SALE_QTY', 'DESC');"><span>브랜드</span></a>
						</li>
					</ul>
					</ul>
					<div data-ui-tab-ctn="tab_a" data-ui-tab-val="tab_a_1" class="active">
						<div class="filter-area">
							<c:forEach items="${filter}" var="filter">
								<c:if test="${fn:length(filter.goodsFiltAttrList)> 0}">
									<div class="filter-item">
										<strong class="tit">${filter.filtGrpShowNm}</strong>
										<div class="tag" id="goodsTag">
											<c:forEach items="${filter.goodsFiltAttrList}" var="item" varStatus="idx">
												<c:set value="${item.filtGrpNo}_${item.filtAttrSeq}" var="filterBtn" />
												<button id="${item.filtGrpNo}_${item.filtAttrSeq}" name="filList" class="${fn:indexOf(filterTag, filterBtn) > -1 ? 'active' : '' }">${item.filtAttrNm}</button>
											</c:forEach>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>						
					</div>
					<div data-ui-tab-ctn="tab_a" data-ui-tab-val="tab_a_2">						
						<div class="brand-check">
							<nav class="uisort only_down"><!-- 04.22 : 수정 -->
								<button type="button" class="bt st">인기순</button>
								<div class="list">
									<ul class="menu" id="sortId">
										<li><button type="button" class="bt" value="v_1"  name="sortBtn">인기순</button></li>
										<li><button type="button" class="bt" value="v_2"  name="sortBtn">가나다순</button></li>
									</ul>
								</div>
							</nav>
							<ul class="brand-list">
							</ul>
						</div>
					</div>
				</section>								
			</main>
		</div>

		<div class="pbt b">
			<div class="bts">
				<button type="button" class="btn xl d" onclick="filtDetail.reset();">초기화</button>
				<button type="button" class="btn xl a" id="filterCnt" onclick="filter.detail();">상품보기</button>
			</div>
		</div>
	</div>
</article>