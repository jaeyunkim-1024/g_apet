<tiles:insertDefinition name="common_my_mo">
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">		
			$(function() {
				if('${result.spellerKeyword}' != null && '${result.spellerKeyword}' != "null" && '${result.spellerKeyword}' != ""){
					searchResult.srchWord = '${result.spellerKeyword}';
					console.log("수정된 검색결과:${result.spellerKeyword}");
				}
				
				// 헤더 검색형 변경
				searchCommon.setHeader();
				
				if("${srchWord}" == '' && '${view.deviceGb}' == '${frontConstants.DEVICE_GB_10 }'){	// 마지막 이벤트로 포커스 이동 및 click 
					// 화면 진입시 포커스
					$("#srchWord").trigger("focus");
					$("#srchWord").trigger("click");
				}
				
				if("${srchWord}" != ''){	// 기본페이지
					// 결과수 제한 및 historyBack 결과 셋팅
					searchResult.chkFirstPage();
				}

				// 검색 자동완성
				searchCommon.autocomplete();
				
				// 검색 닫기 버튼 활성화
				$("#srchClsBtn").show();
				
				// 취소버튼 클릭시 이전진입 페이지로 이동
				$(".mo-header-rightBtn .mo-header-btnType01").click(function() {
					searchCommon.goLastUrl();
				});
				
				// adbrix data 전송
				searchResult.sendAdbrix();
				
				// 퍼블 스크립트 호출(높이 계산)
				ui.tapTouchAc.tab_height($(".uiTab_content > ul"));
			});

			/*
			*	공통 스크립트(default & result 페이지)
			*/
			var searchCommon ={
				goLastUrl : function() {				// 진입 url로 이동
					var lastUrl = $.cookie("searchLastUrl");
					history.replaceState("","",lastUrl);
					location.href = (lastUrl == "" || lastUrl == undefined)?"/":lastUrl;
				},
				setHeader : function() {				// 헤더 스타일 변경
					$(".mo-header-btnType01").addClass("gray");
					$(".mo-header-btnType01").text("취소");
					ui.headerSearech_input.set();
				},
				autoCnt : 0,
				autocomplete : function() { 			// 검색 자동완성
					$("#srchWord").attr("autocomplete","off");
					$("#srchWord").on("input", function(e) { 
						var thisAutoCnt = ++searchCommon.autoCnt;
			            $.ajax({
			                  url : "/searchAutoComplete"
			                , type : "GET"
			                , data : {searchText : $("#srchWord").val()} // 검색 키워드
			                , success : function(data){ // 성공
			                	let resBody = JSON.parse(data);
				                	if(resBody.STATUS.CODE == "200" && thisAutoCnt == searchCommon.autoCnt){
										let html = ''
										if( resBody.DATA.ITEMS.length > 0) {
											$("#key-word-list ul").empty();
											for(var i=0;i<resBody.DATA.ITEMS.length;i++){
												var thisWordData = resBody.DATA.ITEMS[i].HIGHLIGHT.replace(/\'\¶HS¶/gi, '').replace(/\¶HS¶/gi, '').replace(/\'\¶HE¶/gi, '').replace(/\¶HE¶/gi, '').replace(/&#39;/gi, '&#92;&#39;').replace(/'/gi, '&#39;').replace(/"/gi, '&quot;');
												html += '<li>';
												html += '	<a href="javascript:void(0);" data-content="" data-url="/commonSearchResults" onclick="searchCommon.goResultPage(\'' + thisWordData + '\');">';
												html += 		resBody.DATA.ITEMS[i].HIGHLIGHT.replace(/\¶HS¶/gi, '<span>').replace(/\¶HE¶/gi, '</span>');
												html += '	</a>';
												html += '</li>';
											}
											$("#key-word-list ul").html(html);
											$("#key-word-list").css("display", "block");
										}else {
											$("#key-word-list").css("display", "none");
										}
									}
				                }
				            });
				      
					});
					$("body").click(function(e) {
						if(!$(e.target).is($(".hdr .cdt .form")) && !$(e.target).is($(".key-word-list")) ) {
							$("#key-word-list").css("display", "none");
						}
					})
				},
				srchClsBtn : function() {				// 검색 닫기 버튼
					searchCommon.goLastUrl();
				},
				goResultPage : function(srchWord) { 	// 자동완성, 인기 검색어 클릭 시
					var searchLastFocus = $.cookie("searchLastFocus");
					var srchWrd = srchWord;
					var srchShopDispClsfNo = convertDispClsfNo("${session.dispClsfNo != null ? session.dispClsfNo : frontConstants.PETSHOP_MAIN_DOG_DISP_CLSF_NO}");
					location.href = "/commonSearch?srchWord=" + encodeURIComponent(srchWord) + ((searchLastFocus == "" || searchLastFocus == undefined )?"":"&focus="+searchLastFocus) +"&cateCdL="+srchShopDispClsfNo;
				},
				goSearchToCateCdL : function(cateCdL) { 	// 자동완성, 인기 검색어 클릭 시
					searchResult.isFilterLoaing = false;
					$.cookie("searchLastFocus", "10", {path:'/'});
					goSearch(cateCdL);					
				},
				goSearchShopCateCdL : function(cateCdL) {//샵탭 하단의 카테고리 클릭 시 페이지리로드 -> ajax 변경
					searchResult.isSelectedCate = true;
					var srchShopDispClsfNo = convertDispClsfNo((cateCdL == "" || cateCdL == undefined) ? "${session.dispClsfNo != null ? session.dispClsfNo : frontConstants.PETSHOP_MAIN_DOG_DISP_CLSF_NO}" : cateCdL);
					searchResult.selectedCateCdL = srchShopDispClsfNo;
					searchResult.goodsPage = 1;
					$("#popFilter").remove();					
					filter.delFilter(null);
				}
			}
			
			/*
			* 	default 페이지 스크립트
			*/
			var searchDafault = {
				goLatelySearch : function (obj) {		// 최근 검색어 결과페이지 이동
					var searchLastFocus = $.cookie("searchLastFocus");
					var srchWrd = $(obj).data("val");
					var srchShopDispClsfNo = convertDispClsfNo("${session.dispClsfNo != null ? session.dispClsfNo : frontConstants.PETSHOP_MAIN_DOG_DISP_CLSF_NO}");
					location.href = "/commonSearch?srchWord="+encodeURIComponent(srchWrd)+((searchLastFocus == "" || searchLastFocus == undefined )?"":"&focus="+searchLastFocus)+"&cateCdL="+srchShopDispClsfNo;
				},
				delLarelyTag : function (obj) {			// 최근 검색어 삭제
					event.stopPropagation(); // 상위 요소 이벤트 방지
					let seq = $(obj).parents("li").data("seq");
					let options = {
						url : "<spring:url value='search/delLatelyTag' />"
						, data : { seq : seq}
						, done : function(data){
							if(data.result == "S"){
								$(".lately-tag").find("li[data-seq="+ seq +"]").remove();
							}
							if($(".lately-tag").find("li").length == 0 ){ 
								$(".lately-tag").html('<p class="tit">최근 검색어</p><p class="txt-info">검색 내역이 없습니다.</p>');
							}
						}
					};
					ajax.call(options);
				}
			}
			
			/*
			* 	result 페이지 스크립트
			*/
			var searchResult ={
				srchWord : '${srchWord}',				// 검색어 변수
				focusedTab : "tv",						// 현재탭 변수
				isFilterLoaing : false,
				setTabFocusH : function() {
					var scrollTop = $(window).scrollTop();
					// 이전 탭의 현 스크롤위치 적용
					var isHeaderActive = "N/";
					if($(".header .hdr").hasClass("active")){
						isHeaderActive = "Y/";
					}
					if(searchResult.focusedTab == 'tv'){
						$("#srchTab1").data("focush", isHeaderActive+scrollTop);
					}else if(searchResult.focusedTab == 'log'){
						$("#srchTab2").data("focush", isHeaderActive+scrollTop);
					}else if(searchResult.focusedTab == 'shop'){
						$("#srchTab3").data("focush", isHeaderActive+scrollTop);
					}
				},
				setfocusedTab : function(gb) {			// 탭 클릭 이벤트
					var thisTabFocus = new Array();
					if('${view.deviceGb}' != '${frontConstants.DEVICE_GB_10 }'){
						// 스크롤 초기화
						window.scrollTo(0,0);
						if(gb == 'tv'){
							thisTabFocus = ($("#srchTab1").data("focush") != null && $("#srchTab1").data("focush") != undefined)? $("#srchTab1").data("focush").split("/"):null;
						}else if(gb == 'log'){
							thisTabFocus = ($("#srchTab2").data("focush") != null && $("#srchTab2").data("focush") != undefined)? $("#srchTab2").data("focush").split("/"):null;
						}else if(gb == 'shop'){
							thisTabFocus = ($("#srchTab3").data("focush") != null && $("#srchTab3").data("focush") != undefined)? $("#srchTab3").data("focush").split("/"):null;
						}
						if(thisTabFocus == null){
							$(".header .hdr").removeClass("active");
							$(".hmode_auto").removeClass("active");
						}else{
							if(thisTabFocus[0] == "Y"){
								$(".header .hdr").addClass("active");
								$(".hmode_auto").addClass("active");
							}else{
								$(".header .hdr").removeClass("active");
								$(".hmode_auto").removeClass("active");
							}
						}
					}
					
					if( searchResult.focusedTab != gb){
						searchResult.focusedTab = gb;
// 						if(gb == 'shop'){	// shop의 경우 필터 정보 미리 호출	
// 							if($("#popFilter").length == 0){
// 								searchResult.isFilterLoaing = true;
// 								$.get("/search/getFilterPop?srchWord="+'${srchWord}',function (html) { 
// 									$("body").append(html);
// 									searchResult.isFilterLoaing = false;
// 								});
// 							}
// 						}
						// 검색 로그
						$.ajax({
							url : "/common/sendSearchEngineEvent"
							, data : {
								 "logGb" : 'SEARCH'
								, "section" : 'category'
								, "index" : searchResult.focusedTab.toUpperCase()
								, "keyword" : '${srchWord}'
							}
						});
					}
					if('${view.deviceGb}' != '${frontConstants.DEVICE_GB_10 }' && thisTabFocus != null){
						setTimeout(function() {
							window.scrollTo(0,thisTabFocus[1]);
						}, 400)
					}
				},
				getSize : function(gb, setFstPage) {			//  페이지별 ITEM수 확인
					if(gb == 'se_tv_video'){
						return 8;
					}else if(gb == 'se_log_content'){
						if('${view.deviceGb}'=='${frontConstants.DEVICE_GB_10}'){
							return 10;
						}else{
							return 9;
						}
					}else if(gb == 'se_shop_goods'){
						return 10;
					}
					
					if( setFstPage == true ){   // 첫페이지인경우
						if('${view.deviceGb}'=='${frontConstants.DEVICE_GB_10}'){
							if(gb == 'se_tv_series'){
								return 5;
							}else if(gb == 'se_log_member'){
								return 5;
							}else if(gb == 'se_shop_brand'){
								return 10;
							}
						}else{
							if(gb == 'se_tv_series'){
								return 3;
							}else if(gb == 'se_log_member'){
								return 3;
							}else if(gb == 'se_shop_brand'){
								return 6;
							}
						}
					}else{	// 첫페이지가 아닌경우
						return 30;
					}
				},
				seriesPage : 1,						// 시리즈 페이지
				memberPage : 1,						// 사용자 페이지
				brandPage : 1,						// 브랜드 페이지
				videoPage : 1,							// 동영상 페이지
				contentPage :1,							// 로그 동영상 페이지
				goodsPage : 1,							// 상품 동영상 페이지
				videoSort : "latest",					// 동영상 정렬 기준
				contentSort : "latest",					// 로그 동영상 정렬 기준
				goodsSort : "pop_rank",					// 상품 정렬 기준
				focus : '${focus}',						// 마지막 포커스
				firstFocusItv : null,					// 포커스 이동 인터벌
				setSort : function(gb, val) {			// 정렬 기준 변경
					searchResult.focus ="";
					if(gb == 'video'){
						searchResult.videoSort = val;
						searchResult.videoPage = 1;
						searchResult.getSearchResults("se_tv_video", true, "");
					}else if(gb == 'content'){
						searchResult.contentSort = val;
						searchResult.contentPage = 1;
						searchResult.getSearchResults("se_log_content", true, "");
					}else if(gb == 'goods'){
						searchResult.goodsSort = val;
						searchResult.goodsPage = 1;
						searchResult.getSearchResults("se_shop_goods", true, "");
					}
				},
				selectedCateCdL : "${cateCdL}",
				isSelectedCate : false,
				chkFirstPage : function() { 			// 각페이지별 다른 ITEM수 제한 / 내용 없을 경우 문구 노출
					// history back 사용시 포커스 처리
					var printOrder = ["tv","log","shop"];
					if(searchResult.focus != ''){
						if(searchResult.focus.indexOf("lm") == 0 ||searchResult.focus.indexOf("lc") == 0 || searchResult.focus.indexOf("${frontConstants.SEO_SVC_GB_CD_30}") == 0){
							$("#srchTab2").trigger("click");
							printOrder = ["log","shop","tv"];
						}else if(searchResult.focus.indexOf("sb") == 0 ||searchResult.focus.indexOf("sg") == 0  || searchResult.focus.indexOf("${frontConstants.SEO_SVC_GB_CD_10}") == 0){
							$("#srchTab3").trigger("click");
							printOrder = ["shop","tv","log"];
						}
					}
					
					for(let k=0 ; k < printOrder.length ; k++ ){	// 포커스 된 탭부터 처리
						if(printOrder[k] == "tv"){
							// TV 페이지
							searchResult.firstTvPage();
						}else if(printOrder[k] == "log"){
							// LOG 페이지
							searchResult.firstLogPage();
						}else if(printOrder[k] == "shop"){
							// SHOP 페이지
							searchResult.firstShopPage();
						}
					}
					
					// 포커스 이동
					searchResult.firstFocusItv = setInterval(function() {
						if(searchResult.focus != ""){
							var thisFocus = $("."+searchResult.focus);
 							if(thisFocus.length > 0){
 								window.scrollTo(0,(thisFocus.offset().top- (window.innerHeight/2)));
 								searchResult.focus ="";
 								clearInterval(searchResult.firstFocusItv);
 							}
						}
					},500);
					
					
					// 높이 재계산
					setTimeout(function() {
						ui.tapTouchAc.tab_height($(".uiTab_content > ul"));
					}, 500);
				},
				firstTvPage : function() {
					var preNoItemHtml = '<section class="no_data txt"><div class="inr"><div class="msg">';
					var suNoItemHtml = ' 검색 결과가 없습니다.</div></div></section>';
					/*
					*	TV 시리즈			
					*/
					// 사이즈 조정
					let thisSeriesSize = searchResult.getSize("se_tv_series", true);
					$("#tvSeriesArea").find(".scrhItem").each( 				
							function(idx, obj) {
								if(idx >= thisSeriesSize){
									$(obj).remove();
								}
							});
					// 아이템 없음 표시
					if($("#tvSeriesArea").find(".scrhItem").length == 0){
						$("#tvSeriesArea").parent().before(preNoItemHtml+"시리즈"+suNoItemHtml);
					}
					// 더보기 버튼 컨트롤
					if('${result.seriesCount}'>$("#tvSeriesArea .scrhItem").length){
						$("#tvSeriesMoreBtn").show();
					}
					// history param 적용(더보기)
					if('${series}' != '' ){
						searchResult.seriesPage = '${series}';
						searchResult.getSearchResults('se_tv_series', false, searchResult.focus);
					}
					
					/*
					*	TV 비디오
					*/
					// 사이즈 조정
					let thisVideoSize = searchResult.getSize("se_tv_video", true);
					$("#tvVideoArea").find(".scrhItem").each(
							function(idx, obj) {
								if(idx >= thisVideoSize){
									$(obj).remove();
								}
							});
					// 아이템 없음 표시
					if($("#tvVideoArea").find(".scrhItem").length == 0){
						$("#tvVideoArea").before(preNoItemHtml+"동영상"+suNoItemHtml);
						$("#tvSortArea").hide();
					}
					// history param 적용(정렬)
					if('${vSort}' != ''){ 
						searchResult.videoSort = '${vSort}';
						
						if(searchResult.videoSort == 'latest'){
							$("#tvSortArea .uisort button .st").text("최신순");
							$("#tvSortArea .uisort .list ul li:eq(0)").addClass("active").siblings("li").removeClass("active");
						}else if(searchResult.videoSort == 'pop_rank'){
							$("#tvSortArea .uisort button .st").text("인기순");
							$("#tvSortArea .uisort .list ul li:eq(1)").addClass("active").siblings("li").removeClass("active");
						} 
						
						ui.sort.set();
					}
					// history param 적용(페이지)
					if('${video}' != ''){
						searchResult.videoPage = '${video}';
					}
					// history param 적용 재호출
					if('${video}' != '' || '${vSort}' != ''){
						searchResult.getSearchResults('se_tv_video', true, searchResult.focus);
					}
				},
				firstLogPage : function() {
					var preNoItemHtml = '<section class="no_data txt"><div class="inr"><div class="msg">';
					var suNoItemHtml = ' 검색 결과가 없습니다.</div></div></section>';
					/*
					*	LOG 멤버
					*/
					// 사이즈 조정
					let thisMemberSize = searchResult.getSize("se_log_member", true);
					$("#logMemberArea").find(".scrhItem").each(
							function(idx, obj) {
								if(idx >= thisMemberSize ){
									$(obj).remove();
								}
							});
					// 아이템 없음 표시
					if($("#logMemberArea").find(".scrhItem").length == 0){
						$("#logMemberArea").parent().before(preNoItemHtml+"친구"+suNoItemHtml);
					}
					// 더보기 버튼 컨트롤
					if('${result.memberCount}'>$("#logMemberArea .scrhItem").length){
						$("#logMemberMoreBtn").show();
					}
					// history param 적용(더보기)
					if('${member}'!= ''){
						searchResult.memberPage = '${member}';
						searchResult.getSearchResults('se_log_member', false, searchResult.focus);
					}
					
					/*
					*	LOG 게시물
					*/
					// 사이즈 조정
					let thisContentSize = searchResult.getSize("se_log_content", true);
					$("#logContentArea").find(".scrhItem").each(
							function(idx, obj) {
								if(idx >= thisContentSize ){
									$(obj).remove();
								}
							});
					// 아이템 없음 표시
					if($("#logContentArea").find(".scrhItem").length == 0){
						$("#logContentArea").parents(".mylog-area").before(preNoItemHtml+"게시물"+suNoItemHtml);
						$("#logSortArea").hide();
					}
					// history param 적용(정렬)
					if('${cSort}' != ''){
						searchResult.contentSort = '${cSort}';
						
						if(searchResult.contentSort == 'latest'){
							$("#logSortArea .uisort button .st").text("최신순");
							$("#logSortArea .uisort .list ul li:eq(0)").addClass("active").siblings("li").removeClass("active");
						}else if(searchResult.contentSort == 'pop_rank'){
							$("#logSortArea .uisort button .st").text("인기순");
							$("#logSortArea .uisort .list ul li:eq(1)").addClass("active").siblings("li").removeClass("active");
						}
						ui.sort.set();
					}
					// history param 적용(페이지)
					if('${content}' != ''){
						searchResult.contentPage = '${content}';
					}
					// history param 적용 재호출
					if('${content}' != '' || '${cSort}' != ''){
						searchResult.getSearchResults('se_log_content', true, searchResult.focus);
					}
				},
				firstShopPage : function() {
					var preNoItemHtml = '<section class="no_data txt" id="no_data_brand"><div class="inr"><div class="msg">';
					var suNoItemHtml = ' 검색 결과가 없습니다.</div></div></section>';
					/*
					*	SHOP 브랜드
					*/
					// 사이즈 조정
					let thisBrandSize = searchResult.getSize("se_shop_brand", true);
					$("#shopBrandArea").find(".scrhItem").each(
							function(idx, obj) {
								if(idx >= thisBrandSize ){
									$(obj).remove();
								}
							});
					// 아이템 없음 표시
					if($("#shopBrandArea").find(".scrhItem").length == 0){
						$("#shopBrandArea").parent().before(preNoItemHtml+"브랜드"+suNoItemHtml);
					}
					// 더보기 버튼 컨트롤
					if('${result.brandCount}'>$("#shopBrandArea .scrhItem").length){
						$("#shopBrandMoreBtn").show();
					}
					// history param 적용(더보기)
					if('${brand}' != ''){
						searchResult.brandPage = '${brand}';
						searchResult.getSearchResults('se_shop_brand', false, searchResult.focus);
					}
					
					/*
					*	상품
					*/
					// 사이즈 조정
					let thisGoodsSize = searchResult.getSize("se_shop_goods", true);
					$("#shopGoodsArea").find(".scrhItem").each(
							function(idx, obj) {
								if(idx >= thisGoodsSize ){
									$(obj).remove();
								}
							});
					
					// history param 적용(필터)
					if("${filtArrString}" != ""){ 
						var filtBoxHtml = "";
						var filtArr = "${filtArrString}".split(',');
						filter.appliedFetGbCd = [];
						filter.appliedFilters = [];
						filter.appliedBrands = [];
						for(var thisIdx in filtArr){
							var thisFiltVal = filtArr[thisIdx].split('@');
							// 바닥 필터 설정
							filtBoxHtml += '<li class=${view.deviceGb == "PC" ? "" : "swiper-slide"}><span class="fil" name='+thisFiltVal[0]+'><em class="tt">'+thisFiltVal[1]+'</em> <button class="del"onclick="filter.delFilter(\''+thisFiltVal[0]+'\');">필터삭제</button></span></li>';
							filter.setFilterVal(thisFiltVal[0]);
						}
						$("#uifiltbox .flist>ul").html(filtBoxHtml);
						$("#uifiltbox").show();
						if($("#uifiltbox ul .fil").length == 0){
							$(".uiTab_content .tit-box .uisort #filtBtn").removeClass("on");
							$(".uiTab_content .tit-box .uisort .n").html("");
						}else{
							$(".uiTab_content .tit-box .uisort #filtBtn").addClass("on");
							$(".uiTab_content .tit-box .uisort .n").html("("+$("#uifiltbox ul .fil").length+")");
						}
					}
					
					// history param 적용(정렬)
					if('${gSort}' != ''){
						searchResult.goodsSort = '${gSort}';

						if(searchResult.goodsSort == 'pop_rank'){
							$("#shopSortArea .uisort button .st").text("<spring:message code='front.web.view.common.menu.sort.orderSale.button.title'/>");
							$("#shopSortArea .uisort .list ul li:eq(0)").addClass("active").siblings("li").removeClass("active");
						}else if(searchResult.goodsSort == 'review'){
							$("#shopSortArea .uisort button .st").text("<spring:message code='front.web.view.common.menu.sort.orderScore.button.title'/>");
							$("#shopSortArea .uisort .list ul li:eq(1)").addClass("active").siblings("li").removeClass("active");
						}else if(searchResult.goodsSort == 'latest'){
							$("#shopSortArea .uisort button .st").text("<spring:message code='front.web.view.common.menu.sort.orderDate.button.title'/>");
							$("#shopSortArea .uisort .list ul li:eq(2)").addClass("active").siblings("li").removeClass("active");
						}else if(searchResult.goodsSort == 'price_asc'){
							$("#shopSortArea .uisort button .st").text("<spring:message code='front.web.view.common.menu.sort.orderLow.button.title'/>");
							$("#shopSortArea .uisort .list ul li:eq(3)").addClass("active").siblings("li").removeClass("active");
						}else if(searchResult.goodsSort == 'price_desc'){
							$("#shopSortArea .uisort button .st").text("<spring:message code='front.web.view.common.menu.sort.orderHigh.button.title'/>");
							$("#shopSortArea .uisort .list ul li:eq(4)").addClass("active").siblings("li").removeClass("active");
						}
						ui.sort.set();
					}
					// history param 적용(페이지)
					if('${goods}' != ''){
						searchResult.goodsPage = '${goods}';
					}
					// history param 적용 재호출
					if('${goods}' != '' || "${filtArrString}" != "" || '${gSort}' != '' ){
						searchResult.getSearchResults('se_shop_goods', true, searchResult.focus);
					}
					
					// 아이템 없음 표시
					preNoItemHtml = '<section class="no_data txt" id="no_data_goods"><div class="inr"><div class="msg">';
					if($("#shopGoodsArea").find(".scrhItem").length == 0){
						$("#shopGoodsArea").parent().before(preNoItemHtml+"상품"+suNoItemHtml);
						$("#shopSortArea").hide();
					}
				},
				afterAjaxShopPage : function() {					
					$("#shopBrandMoreBtn").hide();					
					$("#shopSortArea").show();
					
					var preNoItemHtml = '<section class="no_data txt" id="no_data_brand"><div class="inr"><div class="msg">';
					var suNoItemHtml = ' 검색 결과가 없습니다.</div></div></section>';
					/*
					*	SHOP 브랜드
					*/
					// 사이즈 조정
					let thisBrandSize = searchResult.getSize("se_shop_brand", true);
					$("#shopBrandArea").find(".scrhItem").each(
							function(idx, obj) {
								if(idx >= thisBrandSize ){
									$(obj).remove();
								}
					});
					// 아이템 없음 표시
					if($("#shopBrandArea").find(".scrhItem").length == 0){
						if($("#no_data_brand").length == 0){
							$("#shopBrandArea").parent().before(preNoItemHtml+"브랜드"+suNoItemHtml);
						}						
					}
					// 더보기 버튼 컨트롤
					if($("#ajaxBrandListSize").val() >$("#shopBrandArea .scrhItem").length){
						$("#shopBrandMoreBtn").show();
					}
					/*
					*	상품
					*/
					// 사이즈 조정
					let thisGoodsSize = searchResult.getSize("se_shop_goods", true);
					$("#shopGoodsArea").find(".scrhItem").each(
							function(idx, obj) {
								if(idx >= thisGoodsSize ){
									$(obj).remove();
								}
					});
					// 아이템 없음 표시
					preNoItemHtml = '<section class="no_data txt" id="no_data_goods"><div class="inr"><div class="msg">';
					if($("#shopGoodsArea").find(".scrhItem").length == 0){
						if($("#no_data_goods").length == 0){
							$("#shopGoodsArea").parent().before(preNoItemHtml+"상품"+suNoItemHtml);
						}
						$("#shopSortArea").hide();
						
					}
				},
				getSearchResults : function(targetGb, reload, histFocus) {		// 각 영역별 검색결과(타겟, 리로드 여부, historyback 포커스)			
					let index = "shop,log,tv";
					let tagetIndex = targetGb;
					let sort = "pop_rank";
					let from = "1"
					let size = "10"
					if(targetGb == "se_tv_series"){
						index = "tv";
						if(histFocus != "" && histFocus != undefined){
							size = searchResult.getSize('se_tv_series', true) + ((searchResult.seriesPage -1) * searchResult.getSize('se_tv_series'));
						}else{
							size = searchResult.getSize('se_tv_series', true) + ((++searchResult.seriesPage -1) * searchResult.getSize('se_tv_series'));
						}
					}else if(targetGb == "se_tv_video"){
						index = "tv";
						sort = searchResult.videoSort;
						if(histFocus != ""){
							from = 1;
							size = searchResult.videoPage * searchResult.getSize('se_tv_video');
						}else{
							from = ++searchResult.videoPage;
							size = searchResult.getSize('se_tv_video');
						}
					}else if(targetGb == "se_log_member"){
						index = "log";
						if(histFocus != "" && histFocus != undefined){
							size = searchResult.getSize('se_log_member', true) + ((searchResult.memberPage -1) * searchResult.getSize('se_log_member'));
						}else{
							size = searchResult.getSize('se_log_member', true) + ((++searchResult.memberPage -1) * searchResult.getSize('se_log_member'));
						}
					}else if(targetGb == "se_log_content"){
						index = "log";
						sort = searchResult.contentSort;
						if(histFocus != "" && histFocus != undefined){
							from = 1;
							size = searchResult.contentPage * searchResult.getSize('se_log_content');
						}else{
							from = ++searchResult.contentPage;
							size = searchResult.getSize('se_log_content');
						}
					}else if(targetGb == "se_shop_brand"){
						index = "shop";
						if(histFocus != "" && histFocus != undefined){
							size = searchResult.getSize('se_shop_brand', true) + ((searchResult.brandPage -1) * searchResult.getSize('se_shop_brand'));
						}else{
							size = searchResult.getSize('se_shop_brand', true) + ((++searchResult.brandPage -1) * searchResult.getSize('se_shop_brand'));
						}
					}else if(targetGb == "se_shop_goods"){
						index = "shop";
						sort = searchResult.goodsSort;
						if(histFocus != "" && histFocus != undefined){
							from = 1;
							size = searchResult.goodsPage * searchResult.getSize('se_shop_goods');
						}else{
							from = ++searchResult.goodsPage;
							size = searchResult.getSize('se_shop_goods');
						}
					}
					
					if(reload){
						from = 1;
					}
					let options = {
						 url : "/commonSearchResults"
						, dataType : "html"
						,data : {
							srchWord : $("#orgSrchWord").val(),
							cateCdL: searchResult.selectedCateCdL,//전체카테고리 처리 완료
							index : index,
							targetGb : targetGb,
							sort : sort,
							from : from,
							size : size,
							tagetIndex :tagetIndex							
						}
						,done : function(html) {
							if(targetGb == "se_tv_series"){
	 							$("#tvSeriesArea").html(html);
	 							var totCnt = '${result.seriesCount}';
	 							var thisListCnt = $("#tvSeriesArea .scrhItem").length;
	 							if( totCnt <= thisListCnt){
	 								$("#tvSeriesMoreBtn").hide();
	 							}
	 						}else if(targetGb == "se_tv_video"){
	 							if(reload){
	 								$("#tvVideoArea").html(html);
	 								if(histFocus == ""){
		 								searchResult.videoPage = 1;
	 								}
	 							}else{
	 								$("#tvVideoArea").append(html);
	 							}
	 						}else if(targetGb == "se_log_member"){
	 							$("#logMemberArea").html(html);
	 							var totCnt = '${result.memberCount}';
	 							var thisListCnt = $("#logMemberArea .scrhItem").length;
	 							if( totCnt <= thisListCnt){
	 								$("#logMemberMoreBtn").hide();
	 							}
	 						}else if(targetGb == "se_log_content"){
	 							if(reload){
	 								$("#logContentArea").html(html);
	 								if(histFocus == ""){
	 									searchResult.contentPage = 1;
	 								}
	 							}else{
	 								$("#logContentArea").append(html);
	 							}
	 						}else if(targetGb == "se_shop_brand"){
	 							if(html != ""){
	 								$("#no_data_brand").remove();
	 							}else{
	 								var preNoItemHtml = '<section class="no_data txt" id="no_data_brand"><div class="inr"><div class="msg">';
	 								var suNoItemHtml = ' 검색 결과가 없습니다.</div></div></section>';	 								
	 								if($("#no_data_brand").length == 0){
	 									$("#shopBrandArea").parent().before(preNoItemHtml+"브랜드"+suNoItemHtml);
	 								}	 								
	 							}
	 							$("#shopBrandArea").html(html);
	 							var totCnt = '${result.brandCount}';
	 							var thisListCnt = $("#shopBrandArea .scrhItem").length;
	 							if( totCnt <= thisListCnt){
	 								$("#shopBrandMoreBtn").hide();
	 							}
	 							if(searchResult.isSelectedCate){//동물카테고리 변경 시						 			
						 			searchResult.isSelectedCate = false;
						 			searchResult.afterAjaxShopPage();
						 		}
	 						}else if(targetGb == "se_shop_goods"){
	 							if(reload){
	 								if(html != ""){
		 								$("#no_data_goods").remove();
		 								$("#shopSortArea").show();
		 							}else{
		 								var preNoItemHtml = '<section class="no_data txt" id="no_data_goods"><div class="inr"><div class="msg">';
		 								var suNoItemHtml = ' 검색 결과가 없습니다.</div></div></section>';
		 								if($("#no_data_goods").length == 0){
		 									$("#shopGoodsArea").parent().before(preNoItemHtml+"상품"+suNoItemHtml);
		 								}
		 								$("#shopSortArea").hide();
		 							}
	 								$("#shopGoodsArea").html(html);
	 								// 상위 카운트 재 계산
 									var thisSearchGoodsCnt =  (html == "" )? 0 : $("#shopGoodsArea .scrhItem").first().data("goodscnt");
 									$("#goodsCount").html(thisSearchGoodsCnt == 0?"":parseInt(thisSearchGoodsCnt));
 							 		var brandCount = ($("#brandCount").text() == '')? 0 : parseInt($("#brandCount").text());
 							 		$("#shopCnt").html((thisSearchGoodsCnt + brandCount > 999)? "999+": thisSearchGoodsCnt + brandCount);
 							 		if(searchResult.focus == ''){
 							 			searchResult.goodsPage = 1;
 							 		}
 							 		if(searchResult.isSelectedCate){//동물카테고리 변경 시
 							 			searchResult.getSearchResults('se_shop_brand', false, searchResult.focus); 							 			
 							 		}
	 							}else{
	 								$("#shopGoodsArea").append(html);
	 							}
	 									 							
		 						// adbrix data 전송
	 							searchResult.sendAdbrix();
	 						}
																					
							// 퍼블 스크립트 호출(높이 계산)
							ui.tapTouchAc.tab_height($(".uiTab_content > ul"));
							
							
							
							// 레이지로드 제한 풀기
							if(histFocus == ""){
								searchResult.lazyLoading = false;
							}
						}
					};
					if(targetGb == "se_shop_goods"){
						if(filter.appliedFetGbCd.length != 0){
							$.extend(options.data, {petGbCd:filter.appliedFetGbCd.join(",")});
						}
						if(filter.appliedBrands.length != 0){
							$.extend(options.data, {bndNo:filter.appliedBrands.join(",")});
						}
						if(filter.appliedFilters.length != 0){
							$.extend(options.data, {filter:JSON.stringify(filter.appliedFilters)});
						}
					}
					ajax.call(options);
				},
				lazyLoading : false,
				lazyLoadResults : function() {		// 레이지 로드 결과
					// 추가적인 레이지 로드 호출 안받도록 제한
					if(searchResult.lazyLoading) return;
					searchResult.lazyLoading = true;
					
					if(searchResult.focusedTab == "tv"){
						let videoCnt = $("#videoCount").html();
						let nowCnt = $("#tvVideoArea .scrhItem").length;
						if(parseInt(videoCnt) > nowCnt){
							searchResult.getSearchResults("se_tv_video", false, "");
						}else{
							searchResult.lazyLoading = false;
						}
					}else if(searchResult.focusedTab == "log"){
						let contentCnt = $("#contentCount").html();
						let nowCnt = $("#logContentArea .scrhItem").length;
						if(parseInt(contentCnt) > nowCnt){
							searchResult.getSearchResults("se_log_content", false, "");
						}else{
							searchResult.lazyLoading = false;
						}
					}else if(searchResult.focusedTab == "shop"){
						let goodsCnt = $("#goodsCount").html();
						let nowCnt = $("#shopGoodsArea .scrhItem").length;
						if(parseInt(goodsCnt) > nowCnt){
							searchResult.getSearchResults("se_shop_goods", false, "");
						}else{
							searchResult.lazyLoading = false;
						}
					}
				},
				sendAdbrix : function() {					// 에드브릭스 데이터 전송
					if('${srchWord}' != '' && '${view.deviceGb}' == '${frontConstants.DEVICE_GB_30}'  ){
						var products = new Array();
						var goodsLi = $("#shopGoodsArea .needAdbrix");
						goodsLi.each(function(index, item){
							var thisProduct = {
								productId : $(item).data("productid"),
								productName : $(item).data("productname"),
								price : $(item).data("price"),
								quantity : 1, 
								discount : $(item).data("discount"),
								currency : 1,
								categorys : [
								],
								productDetailAttrs : {	
								}
							}
							products.push(thisProduct);
							$(item).removeClass("needAdbrix");
						});
						onSearchData.keyword = '${srchWord}';
						onSearchData.productModels = products;
						toNativeAdbrix(onSearchData);
					}
				},
				setHistoryState : function (gb, obj) {					// history replace
					var stateUrl = "";
					if(searchResult.seriesPage != 1){
						stateUrl += '&series='+searchResult.seriesPage;
					}
					if(searchResult.memberPage != 1){
						stateUrl += '&member='+searchResult.memberPage;
					}
					if(searchResult.brandPage != 1){
						stateUrl += '&brand='+searchResult.brandPage;
					}
					if(searchResult.focus != ''){
						stateUrl += '&focus='+searchResult.focus;
					}
					if(searchResult.videoPage != 1){
						stateUrl += '&video='+searchResult.videoPage;
					}
					if(searchResult.contentPage != 1){
						stateUrl += '&content='+searchResult.contentPage;
					}
					if(searchResult.goodsPage != 1){
						stateUrl += '&goods='+searchResult.goodsPage;
					}
					if(searchResult.videoSort != "latest"){
						stateUrl += '&vSort='+searchResult.videoSort;
					}
					if(searchResult.contentSort != "latest"){
						stateUrl += '&cSort='+searchResult.contentSort;
					}
					if(searchResult.goodsSort != "pop_rank"){
						stateUrl += '&gSort='+searchResult.goodsSort;
					}
					
					var filtArr = new Array();
					$("#uifiltbox li").each(function() {
						filtArr.push($(this).find("span").attr("name")+"@"+$(this).find(".tt").text());
					});
					if(filtArr.length != 0){
						stateUrl += '&filtArrString='+filtArr.join(",");
					}
					
					var filtBSort = $("#bndSortVal").val();
					if(filtBSort == "v_1"){ 		//  브랜드 필터 가나다
						stateUrl += '&filtBSort=20';
					}
					
					//var url = "/commonSearch?srchWord=${srchWord}&cateCdL=${cateCdL}"+stateUrl;
					var url = "/commonSearch?srchWord=${srchWord}&cateCdL="+searchResult.selectedCateCdL+stateUrl;
					if(searchResult.selectedCateCdL == null || searchResult.selectedCateCdL == 0){
						url = "/commonSearch?srchWord=${srchWord}"+stateUrl;
					}
					
					storageHist.replaceHist(url);
					history.replaceState("","",url);
				},
				goSeries : function(srisNo, sesnNo) {
					var url = '/tv/series/petTvSeriesList?srisNo='+srisNo+'&sesnNo='+sesnNo;
					// 액션 로그
					searchResult.actionLog("tv",url);
					
					// 이동
					searchResult.focus = "ts"+srisNo+sesnNo;
					searchResult.setHistoryState("se_tv_series");
					location.href = url;
				},
				goMember : function(petLogUrl, mbrNo) {
					var url = '/log/indexMyPetLog/'+((petLogUrl == "")? "null":petLogUrl)+'?mbrNo='+mbrNo;
					// 액션 로그
					searchResult.actionLog("log",url);
					
					// 이동
					searchResult.focus = "lm"+mbrNo;
					searchResult.setHistoryState("se_log_member");
					location.href = url;
				},
				goBrand : function(bndNo) {
					var cateCdL = $(".petCate_tab").children("li[class~=active]").data("catecdl");
					var url = "/brand/indexBrandDetail?bndNo="+bndNo+"&cateCdL="+cateCdL;
					//TODO 전체 카테고리 검색 시 처리. 우선 cateCdL 제거.2021-06-25
					if(cateCdL == undefined){
						url = "/brand/indexBrandDetail?bndNo="+bndNo;
					}
					// 액션 로그
					searchResult.actionLog("shop",url);
					
					// 이동
					searchResult.focus = "sb"+bndNo;
					searchResult.setHistoryState("se_shop_brand");
					location.href = url;
				},
				goVideo : function(vdId) {
					// 검색 로그
					searchResult.searchLog(vdId);
					
					// 이동
					searchResult.focus = "tv"+vdId;
					searchResult.setHistoryState("se_tv_video");
					if(vdId.indexOf('E') == 0){
						/* APP에서 펫스쿨 상세 기존 onNewPage 호출 ==> 페이지 호출방식으로 변경 / 펫스쿨 상세는 pc, mo, app 모두 호출방식 동일함.
						if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true"){
							toNativeData.func = "onNewPage";
							toNativeData.type = "TV";
							toNativeData.url = "${view.stDomain}/tv/school/indexTvDetail?vdId="+vdId;
							toNative(toNativeData);
						}else{*/
							location.href = "/tv/school/indexTvDetail?vdId="+vdId;
						//}
					}else{
						$.cookie("backToSrch", location.href, {path:'/'});
						if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true"){
							toNativeData.func = "onNewPage";
							toNativeData.type = "TV";
							toNativeData.url = "${view.stDomain}/tv/series/indexTvDetail?vdId="+vdId+"&listGb=SEARCH";
							toNative(toNativeData);
						}else{
							location.href = "/tv/series/indexTvDetail?vdId="+vdId+"&listGb=SEARCH";
						}
					}
				},
				goContent : function(petLogNo) {
					// 검색 로그
					searchResult.searchLog(petLogNo);
					
					// 이동
					searchResult.focus = "lc"+petLogNo;
					searchResult.setHistoryState("se_log_content");
					location.href = "/log/indexPetLogDetailView?petLogNo="+petLogNo;
				},
				goGoods : function(goodsId) {
					// 검색 로그
					searchResult.searchLog(goodsId);
					
					// 이동
					searchResult.focus = "sg"+goodsId;
					searchResult.setHistoryState("se_shop_goods");
					location.href = "/goods/indexGoodsDetail?goodsId="+goodsId;
				},
				searchLog : function(contentId) {			// 검색 로그
					$.ajax({
						url : "/common/sendSearchEngineEvent"
						, data : {
							"logGb" : 'SEARCH'
							, "section" : 'content'
							, "index" : searchResult.focusedTab.toUpperCase()
							, "content_id" : contentId
							, "keyword" : '${srchWord}'
						}
					});
				},
				actionLog : function(section, targetUrl) {			// 액션 로그
					$.ajax({
						url : "/common/sendSearchEngineEvent"
						, data : {
							"logGb" : 'ACTION'
							, "section" : section
							, "action" : "etc"
							, "url" : location.href
							, "targetUrl" : targetUrl
						}
					});
				}
			}
			
			/*
			* 	상품 필터
			*/
			var filter = {
				getPop : function(){						// 필터 팝업 컨트롤
					// 필터 팝업 열기
					if(filter.appliedCnt != ''){
						$("#preGoodsCnt").html(filter.appliedCnt);
					}else if($("#uifiltbox ul .fil").length > 0){
						var filterdGoodsCnt = $("#goodsCount").text();
						$("#preGoodsCnt").html((filterdGoodsCnt != "" && filterdGoodsCnt != 0 )?filterdGoodsCnt+"개&nbsp;":"" );
					}
					if($("#popFilter").length != 0 ){
						filter.open();
					}else{
						waiting.start();
						if(searchResult.isFilterLoaing){
							var openPopInterval = setInterval(function() {
								if($("#popFilter").length != 0){
									clearInterval(openPopInterval);
									filter.open();
									waiting.stop();
								}
							}, 500);
						}else{
							searchResult.isFilterLoaing = true;
							$.get("/search/getFilterPop?srchWord="+searchResult.srchWord+"&cateCdL="+searchResult.selectedCateCdL,function (html) { 
								searchResult.isFilterLoaing = false;
								if($("#popFilter").length == 0){	// 필터 정보 추가전 상품탭 진입시 호출된 필터정보 들어가 있는지 다시 한번 확인
									$("body").append(html);
								}
								filter.open();
								waiting.stop();
							});
						}
					}
				},
				filterFirstOpen : true,
				open : function() {									// 필터 팝업 오픈
					// 브랜드 클릭 해제
					$(".brand-list li .checkbox").css("pointer-events", "");
					
					// history param 적용(필터의 브랜드 정렬)			
					var filtBSort = $("#bndSortVal").val();
					if("${filtBSort}" == "20" && filter.filterFirstOpen){
						$("#bndSortVal").val("v_1");
						$("#bndSortVal").text("가나다순");
						$("#bndSortVal").next().find("ul li").removeClass("active");
						$("#bndSortVal").next().find("ul li:eq(1)").addClass("active");
						filter.filterFirstOpen = false;
						filter.brandSort('');
					}
					
					// 바닥 필터 팝업에 적용
					let filterHtml ="";
					$("#popFilter .tag button").removeClass("active");
					$("#popFilter .brand-list input").prop("checked", false);
					$(".uifiltbox ul .fil").each(function() {
						let thisName = $(this).attr("name");
						let thisTxt = $(this).find(".tt").text();
						$("#"+thisName).addClass("active");
						if(thisName.indexOf("brand_") < 0){		// 필터
							$("#popFilter .tag button[id='"+thisName+"']").addClass("active");
						}else{								// 브랜드
							$("#popFilter .brand-list input[id='"+thisName+"']").prop("checked", true);
							/// [21.06.15 CSR-1075] 필터, 브랜드 항목 토글시키기. 토글방지 css 해제시킴.
							$("#popFilter .brand-list input[id='"+thisName+"']").parent(".checkbox").css("pointer-events", "");
						}	
						filterHtml +='<li class=${view.deviceGb == "PC" ? "" : "swiper-slide"}><span class="remove-tag" name="'+ thisName+'">'+ thisTxt+'<button class="close" onclick="filter.delFilterOnPop(\''+thisName+'\');"></button></span></li>';
					});
					$("#fitersOnPop #filterPopup").html(filterHtml);
					//20210531 수정. kwj. 필터 취소 후 다시 오픈했을경우 검색카운트 제거.
					if(filterHtml == ""){
						$("#preGoodsCnt").html("");
					}
					ui.popLayer.open('popFilter',{ 				// 콜백사용법
					    ocb:function(){
					        $("#filterDetail").click();
					    },
					    ccb:function(){
					    }
					});
				},
				btnActive : function(obj, isBrand) {				// 팝업내 필터 체크
					let thisObjId = $(obj).attr("id");
					
					if(!isBrand && !$(obj).hasClass("active")){					// 필터
						$(obj).toggleClass("active");
						let filterHtml ='<li class=${view.deviceGb == "PC" ? "" : "swiper-slide"}><span class="remove-tag" name="'+ thisObjId+'">'+ $(obj).text()+'<button class="close" onclick="filter.delFilterOnPop(\''+thisObjId+'\');"></button></span></li>';
						$("#fitersOnPop #filterPopup").append(filterHtml);
						filter.chkGoodsCnt();
					} 
					// [21.06.15 CSR-1075] 필터, 브랜드 항목 토글시키기
					// 브랜드가 아니고(=상세조건) 이미 선택된 필터를 또 다시 클릭했을 경우.
					else if ( !isBrand && $(obj).hasClass("active") ) {
						// 헤딩필터 없애기, 필터 active css 없애기
						filter.delFilterOnPop( thisObjId ); // 파라미터는 필터의 'id명' 임.
					}
					// 브랜드이고 선택안된 상태에서 클릭 했을경우
					else if ( isBrand && $(obj).is(":checked") == true ) {
						let filterHtml ='<li class=${view.deviceGb == "PC" ? "" : "swiper-slide"}><span class="remove-tag" name="'+ thisObjId+'">'+ $(obj).data("bndnm")+'<button class="close" onclick="filter.delFilterOnPop(\''+thisObjId+'\');"></button></span></li>';
						$("#fitersOnPop #filterPopup").append(filterHtml);
						filter.chkGoodsCnt();
					}
					// 브랜드이고 선택된 상태에서 다시 선택한 경우
					else if ( isBrand && $(obj).is(":checked") == false ) {

						// 헤딩브랜드 없애기, 브랜트 체크박스 active css 없애기
						filter.delFilterOnPop( thisObjId ); // 파라미터는 필터의 'id명' 임.
					}
				},
				chkGoodsCnt : function() {							// 팝업 필터 적용시 상품 개수 확인
					var stndrPopArea = $("#fitersOnPop #filterPopup>li");
					var popFetGbCd = [];
					var popBrands = [];
					var popFilters = [];
					stndrPopArea.each(function() {
						let thisName = $(this).find("span").attr("name");
						if(thisName.indexOf("brand_") != -1 ){			// 브랜드
							popBrands.push(thisName.replace("brand_",""));
						}else if(thisName.indexOf("petGbcd_") != -1 ){	// 펫구분 코드
							 popFetGbCd.push(thisName.replace("petGbcd_",""));
						}else{											// 필터
							let nos = thisName.split('_');
							let nosMap = 
								{
									FILTER_CD : nos[0],
									FILTER_VAL : [nos[1]]
								}
							let exstnKey = false;							
							
							for(let i=0 ; i < filter.appliedFilters.length ; i++){
								/* if( popFilters[i].FILTER_CD == nos[0]){
									popFilters[i].FILTER_VAL.push(nos[1]);
									exstnKey = true;
								} */
								if( filter.appliedFilters[i].FILTER_CD == nos[0]){
									if(!filter.appliedFilters[i].FILTER_VAL.includes(nos[1])){
										filter.appliedFilters[i].FILTER_VAL.push(nos[1]);
										exstnKey = true;
									}
																		
								}
							}
							if(!exstnKey){
								popFilters.push(nosMap);
							}
						}
					})
					
					let options = {
						 url : "/commonSearchGoodsCnt"
						,data : {
							srchWord : $("#orgSrchWord").val(),
							//cateCdL: '${cateCdL}' //전체카테고리 처리 완료
							cateCdL: searchResult.selectedCateCdL //전체카테고리 처리 완료
						}
						,done : function(data) {			

							// [210611. APETQA-5691] 필터값 선택 모두 해제시, '상품보기'버튼 영역에 상품개수 표시 금지
                            if ( $("#fitersOnPop #filterPopup>li").length == 0 ) {
                                $("#preGoodsCnt").html("");
                            } else {
                                $("#preGoodsCnt").html((data.result.goodsCount == null)?"0개&nbsp;":data.result.goodsCount+"개&nbsp;");
                            }
						}
					};
					if(popFetGbCd.length != 0){
						$.extend(options.data, {petGbCd:popFetGbCd.join(",")});
					}
					if(popBrands.length != 0){
						$.extend(options.data, {bndNo:popBrands.join(",")});
					}
					if(popFilters.length != 0){
						$.extend(options.data, {filter:JSON.stringify(popFilters)});
					}
					ajax.call(options);
				},
				delFilterOnPop : function(name) {					// 팝업내 필터 삭제
					$("#fitersOnPop #filterPopup>li").each(function() {
						if(name == $(this).find("span").attr("name")){
							$(this).remove();
							// 필터 선택값 다시 확인
							if(name.indexOf("brand_") < 0){		// 필터
								$("#popFilter .tag button[id='"+name+"']").removeClass("active");
							}else{								// 브랜드
								$("#popFilter .brand-list input[id='"+name+"']").prop("checked", false);					
								$("#popFilter .brand-list input[id='"+name+"']").parent(".checkbox").css("pointer-events", "");
							}	
						}
					});
					filter.chkGoodsCnt();
				},
				delFilter : function(name) {						// 필터 삭제
					if(name == null){
						$("#uifiltbox .flist>ul").html('');
						$("#uifiltbox").hide();
					}else{
						$("#uifiltbox ul .fil").each(function() {
							if(name == $(this).attr("name")){
								$(this).remove();
							}
						});
					}
					filter.apply(); // 적용
				},
				resetFilterOnPop : function() {						// 팝업내 필터 삭제
					$("#fitersOnPop #filterPopup").html("");
					$("#popFilter .tag button").removeClass("active");
					$("#popFilter .brand-list input").prop("checked", false);
				},
				brandSort : function(gb) { 						// 필터 브랜드 정렬

					// [21.06.16 CSR-1075] 통합검색 팝업 - 필터/브랜드 헤딩토글, 브랜드 통합검색으로 정렬
					// gb: 인기순 / v_2 / filter.brandSort('10') / pop_rank
					//    가나다순 / v_1 / filter.brandSort('') / bnd_nm_asc
					
					let bndSort = "";
				
					if ( gb == '10') {
						bndSort = 'pop_rank';
					} else if ( gb == '' ) {
						bndSort = 'bnd_nm_asc';
					}
					
					let options = {
							url : "<spring:url value='search/getBrandListForSearch' />"
							, data : {srchWord : searchResult.srchWord
									 	//, cateCdL : '${cateCdL}'
									 	, cateCdL : searchResult.selectedCateCdL
										, bndSort : bndSort }
							, done : function(data){
								
								console.log(data);
								
								var thisHtml ='';
								for(idx in data.brandList){
									thisHtml += '<li>';
									thisHtml += '<label class="checkbox">';
									thisHtml += '<input type="checkbox" id="brand_'+data.brandList[idx].BND_NO+'" data-bndnm="'+data.brandList[idx].BND_NM_KO+'" onchange="filter.btnActive(this,true)"; /><span class="txt">'+data.brandList[idx].BND_NM_KO+'</span>';
								
									thisHtml += '</label>';
									thisHtml += '<span class="num">'+data.brandList[idx].DOC_COUNT+'</span>'; // [21.06.15 CSR-1075] 브랜드 정렬시 해당 브랜드 검색 개수 표시
									thisHtml += '</li>';
								}
								if(gb == 10){
									$("#bndSortVal").val('v_2');
								}else{
									$("#bndSortVal").val('v_1');
								}
								$("#popFilter .brand-list").html(thisHtml);
								$("#fitersOnPop #filterPopup>li").each(function() {
									let thisName = $(this).find("span").attr("name");
									if(thisName.indexOf("brand_") != -1 ){			// 브랜드
										$("#popFilter .brand-list input[id='"+thisName+"']").prop("checked", true);
									}
								})
							}
						};
						ajax.call(options);
				},
				appliedCnt : "",									// 필터 적용시킨 상품 개수
				apply : function(isFromPop) {						// 필터 적용 상품 호출
					searchResult.goodsPage = 0;
					if(isFromPop){	// 팝업으로부터 왔을 경우 바닥페이지 셋팅
						// 적용된 필터 결과 페이지에 셋팅
						let filtBoxHtml = "";
						$("#fitersOnPop #filterPopup>li").each(function() {
							let thisName = $(this).find(".remove-tag").attr("name");
							let thisTxt = $(this).find(".remove-tag").text();
							filtBoxHtml += '<li class=${view.deviceGb == "PC" ? "" : "swiper-slide"}><span class="fil" name='+thisName+'><em class="tt">'+thisTxt+'</em> <button class="del"onclick="filter.delFilter(\''+thisName+'\');">필터삭제</button></span></li>';
						});
						$("#uifiltbox .flist>ul").html(filtBoxHtml);
						$("#uifiltbox").show();
					}
				
					// 필터 개수 적용
					if($("#uifiltbox ul .fil").length == 0){
						$(".uiTab_content .tit-box .uisort #filtBtn").removeClass("on");
						$("#uifiltbox").hide();
						$(".uiTab_content .tit-box .uisort .n").html("");
					}else{
						$(".uiTab_content .tit-box .uisort #filtBtn").addClass("on");
						$(".uiTab_content .tit-box .uisort .n").html("("+$("#uifiltbox ul .fil").length+")");
					}
					
					filter.appliedFetGbCd = [];
					filter.appliedFilters = [];
					filter.appliedBrands = [];
					let stndrArea = $("#uifiltbox .fil");
					stndrArea.each(function() {
						let thisName = $(this).attr("name");
						filter.setFilterVal(thisName);
					})
					
					// 검색 결과 호출
					searchResult.getSearchResults("se_shop_goods", true, "");
					
					$("#popFilter .btnPopClose").click();
					filter.appliedCnt = $("#preGoodsCnt").html();
				},
				setFilterVal : function(thisName) {					// 변수에 필터값 적용
					if(thisName.indexOf("brand_") != -1 ){			// 브랜드
						filter.appliedBrands.push(thisName.replace("brand_",""));
					}else if(thisName.indexOf("petGbcd_") != -1 ){	// 펫구분 코드
						filter.appliedFetGbCd.push(thisName.replace("petGbcd_",""));
					}else{											// 필터
						let nos = thisName.split('_');
						let nosMap = 
							{
								FILTER_CD : nos[0],
								FILTER_VAL : [nos[1]]
							}
						let exstnKey = false;
						
						for(let i=0 ; i < filter.appliedFilters.length ; i++){
							if( filter.appliedFilters[i].FILTER_CD == nos[0]){
								filter.appliedFilters[i].FILTER_VAL.push(nos[1]);
								exstnKey = true;
							}
						}
						if(!exstnKey){
							filter.appliedFilters.push(nosMap);
						}
					}
				},
				appliedFetGbCd : [],
				appliedFilters : [],
				appliedBrands : []
			}
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container  page 1dep 2dep" id="container">
			<div class="inr">
				<c:choose>
					<c:when test="${ isDefault == true }">
						<jsp:include page="/WEB-INF/view/search/include/includeDefault.jsp"/>
					</c:when>
					<c:otherwise>
						<jsp:include page="/WEB-INF/view/search/include/includeResult.jsp"/>
					</c:otherwise>
				</c:choose>
			</div>
		</main>
		
		<script>
			// 퍼블의 swipe 구현 부분
			setTimeout(function(){
				var check = ($('link[href *= "style.mo.css"]').length) ? true : false;
				if(check) {
					var swiper = new Swiper('.recommendation-tag .swiper-container', {
						slidesPerView: 'auto', /*APETQA-5515*/
						centeredSlides: false,
						spaceBetween: 0,
						pagination: {
							el: '.swiper-pagination',
							clickable: true,
						},
					});
					var swiper2 = new Swiper('.search-list .swiper-container.t01', {
						slidesPerView: '1',
						centeredSlides: false,
						spaceBetween: 0,
						pagination: {
							el: '.search-list .swiper-pagination',
							clickable: true,
						},
					});
					
				}
	
			},50);
			var swiper3 = new Swiper('.search-list .b-banner .swiper-container.t02', {
				slidesPerView: '1',
				centeredSlides: false,
				spaceBetween: 0,
				pagination: {
					el: '.search-list .b-banner .swiper-pagination',
					clickable: true,
				}
			});
			
			// lazy load
			if("${srchWord}" != ''){
				$(function(){
					$(window).scroll(function(){
						var scrollTop = $(this).scrollTop();
						var both = $(document).innerHeight() - window.innerHeight - ($("#footer").innerHeight() || 0);
						var scrollHeight = $(this).prop('scrollHeight');
						if (both <= (scrollTop +3)) {
							if($("#srchTab1").hasClass("active")){
								searchResult.focusedTab = 'tv';
							}else if($("#srchTab2").hasClass("active")){
								searchResult.focusedTab = 'log';
							}else if($("#srchTab3").hasClass("active")){
								searchResult.focusedTab = 'shop';
							}
							searchResult.lazyLoadResults();
						};
					});
				})
			}
		</script>
		
		<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
			<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
				<jsp:param name="floating" value="" />
			</jsp:include>
		</c:if>

	</tiles:putAttribute>
</tiles:insertDefinition>