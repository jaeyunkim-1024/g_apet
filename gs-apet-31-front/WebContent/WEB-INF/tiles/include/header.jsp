<script type="text/javascript">
	//개발자도구에서의 console.[log, debug] control	
	logger("<spring:eval expression="@bizConfig['envmt.gb']" />");
	
	$(document).ready(function(){

		// 딥링크 url 생성 및 처리
		if('${view.deepLinkYn}' == 'Y'){
			var options = {
				landingUri : window.location.href,
				osType : '${view.os}',
				deviceGb : '${view.deviceGb}'
			};
			deepLinkApp.call(options);
		}
		
// 		if("${view.os}" != "${frontConstants.DEVICE_TYPE}"){ 
		if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_10}"){
			$("meta[name=viewport]").attr("content","width=1300");
// 			}
		}else{
			$("meta[name=viewport]").attr("content","width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no");
		}

		//IE 진입 시 edge로 연결
		if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ){
			
			document.body.innerHTML = '';
		
			function edgeAlert(){
				alert("어바웃펫은 Internet Explorer를 지원하지 않습니다. \n크롬, 엣지 브라우저에 최적화 되어있습니다.")
				location.href = "microsoft-edge:" + location.href;
			}
			function closeIE(){
				open("","_self").close();
			}
			setTimeout(edgeAlert);
	        setTimeout(closeIE,200);
		}
		
		if(document.cookie.indexOf("DEVICE_GB") == -1){
			ipadCheck();
		}
		chcekLoginTagInfo(); 
		checkURL();
		
		setCartCnt();
		<c:forEach var="popup" items="${popupList}" varStatus="status">
		var params = {
				popupNo : "${popup.popupNo}",
				width : "${popup.wdtSz}",
				height: "${popup.heitSz}",
				left : "${popup.pstLeft}",
				top : "${popup.pstTop}",
				callBackFnc : ""
		}
		cookiedata = document.cookie;
		
		if(cookiedata.indexOf("popDispClsfNo<c:out value='${popup.popupNo}'/>=done") < 0){
			pop.dispClsfPopup(params);
			
			$("#popDispClsfNo<c:out value='${popup.popupNo}'/>").prev("div.ui-dialog-titlebar").parent().show();
			$("#popDispClsfNo<c:out value='${popup.popupNo}'/>").show();
		}else{
			$("#popDispClsfNo<c:out value='${popup.popupNo}'/>").prev("div.ui-dialog-titlebar").parent().hide();
		}

		</c:forEach>
		
		// 검색창 문구
		getSearchInputAutoComplete();
		
		$("li[id^=liTag_]").one('click', function(){
			$("li[id^=liTag_]").removeClass("active");
			$(this).addClass("active");
	    });
		
		$(document).on("click" , "#alertBtn" , function(){
			getAlertList();
		});
	});
	
	function getAlertList(){
		var options = {
				url : "/alertList"
				, dataType : "html"
				, done : function(html){
					$("#alertBtn").removeClass("on");
					if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_10}"){
						$("#alertDiv").html(html);	
					}else{
						location.href="/alertList"	
					}
				}
		}
		ajax.call(options);
	}
	
	// ipad check logic
	function ipadCheck(){
		const iPad = (navigator.userAgent.match(/(iPad)/) /* iOS pre 13 */ ||  (navigator.platform === 'MacIntel' && navigator.maxTouchPoints > 1) /* iPad OS 13 */);
		if(iPad){
			setCookie("DEVICE_GB", "MO" , 24 );
			window.location.reload();
		}
	}
	
	//회원 관심태그 등록 여부 체크
	function chcekLoginTagInfo(){
		if("${session.tagYn}" != "Y" && "${session.mbrNo}" > 0 && "${session.bizNo}" == ""){
			location.href = "/join/indexTag?isPBHR=Y&returnUrl="+location.pathname+location.search;
		}
	}
	
	function setCookie( name, value, expirehours ) {
		var todayDate = new Date();
		todayDate.setHours( todayDate.getHours() + expirehours );
		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
	}
	
	// 하루동안 열지않기
	function todaycloseWin(pNo) {
		setCookie("#popDispClsfNo"+pNo, "done" , 24 );
	}
	
	$(function() {
		$('.category_wrap').on('show', function(e, param1) {
			if (param1 == "cate") {
				$('.right_btn_wrap').hide();
				
				var options = {
					url : "/brand/listStyleBrand",
					done : function(data) {
						var html = "";
						for (var i=0; i<data.brandStyleList.length; i++) {
							var brand = data.brandStyleList[i];
							html += '<li><a href="/brand/indexBrandDetail?bndNo=' + brand.bndNo + '">' + brand.bndNm + '</a></li>';
						}
						$('.dep_box.style ul').html(html);
					}
				};
				ajax.call(options);
			}
		});
		
		$('.category_wrap').on('hide', function(e, param1) {
			if (param1 == "cate")
				$('.right_btn_wrap').show();
		});
	});	
	
	// 검색
	function goSearch(dispClsfNo){
		
		var searchWord = $("#srchWord").val();
		var srchShopWord = $("#srchShopWord").val();
		if( srchShopWord != "" &&  srchShopWord != undefined){
			searchWord = srchShopWord;
		}
		var srchShopDispClsfNo = convertDispClsfNo((dispClsfNo == "" || dispClsfNo == undefined) ? "${session.dispClsfNo != null ? session.dispClsfNo : frontConstants.PETSHOP_MAIN_DOG_DISP_CLSF_NO}" : dispClsfNo);
		// google Analytics 정보 전송
		search_data.search_term = searchWord;
		sendGtag('search');
		// 마지막 검색 페이지 진입 url 저장
		var lastUrl = window.location.href;
		if(lastUrl.indexOf("commonSearch") == -1){
			$.cookie("searchLastUrl", lastUrl, {path:'/'});
			$.cookie("searchLastFocus", "${view.seoSvcGbCd}", {path:'/'});
			location.href = "/commonSearch?focus=${view.seoSvcGbCd}"+((searchWord.trim() == "")? "":"&srchWord="+encodeURIComponent(searchWord.trim()))+"&cateCdL="+srchShopDispClsfNo;
		}else{
			var searchLastFocus = $.cookie("searchLastFocus");
			location.href = "/commonSearch?"+((searchLastFocus == "" || searchLastFocus == undefined )?"":"focus="+searchLastFocus)+((searchWord.trim() == "")? "":"&srchWord="+encodeURIComponent(searchWord.trim()))+"&cateCdL="+srchShopDispClsfNo;
		}
	}
	
	// 메뉴 활성화	
	function checkURL() {
		var pathname = location.pathname;
		
		//펫로그회원(bizNo이 있는 회원)이 펫로그가 아닌 다른 페이지에 접속하면 alert
		if(pathname.indexOf("/log/") < 0 && "${session.bizNo}" != "" && "${session.bizNo}" > 0 && pathname.indexOf("/my/pet/") < 0 && pathname.indexOf("/commonSearch") < 0){
			if(confirm("로그아웃 됩니다. 로그아웃 하시겠습니까?")){
				location.href="/logout";
			}else{
				history.back(-1);
			}
		}
		
		var menu = $('.top_area .nav').children("li");
		
		for (var i=0; i<menu.length; i++) {
			var url = $(menu[i]).find("a").attr("href");
			if (url == location.pathname)
				$(menu[i]).addClass("active");
		}
	}
	
	// 위시리스트 추가 - 상품상세제외
	function insertWish(obj, goodsId){
		if( $(".popToast").is(":visible") ) return;

		var options = {
			url : "<spring:url value='/goods/insertWish' />",
			data : {goodsId : goodsId},
			done : function(data){
				if(data.actGubun =='login'){
					//비로그인 시 처리 기획 없음.
					document.location.href = '/indexLogin?returnUrl='+encodeUriComponent(document.location.href);
				}else if(data.actGubun =='add'){
					$(obj).addClass("on");
					let msg = '<div class="link"><p class="tt">찜리스트에 추가되었어요</p><a href="/mypage/shop/myWishList" class="lk" data-content="" data-url="/mypage/shop/myWishList">바로가기</a></div>';
					ui.toast(msg,{
						bot:77
					});
					//if (confirm("위시리스트에 담겼습니다.\n확인하시겠습니까?")) location.href = "/mypage/interest/indexWishList";
				}else if(data.actGubun =='remove'){
					$(obj).removeClass("on");
					ui.toast("찜리스트에서 삭제되었어요", {
						bot:77
					})
					//alert("위시리스트에서 삭제되었습니다.");
				}else{
					let act = $(obj).hasClass("on") ? "취소" : "추가";
					ui.toast("찜 "+act+" 요청을 실패하였습니다", {
						bot:77
					});
					//alert('위시리스트 등록 또는 삭제에 실패하였습니다.');
				}
			}
		};
		ajax.call(options);
	}
	
	function insertWishS(obj, goodsId, query) {
		var options = {
			url : "/goods/insertWish",
			data : {goodsId : goodsId, search : "Y", returnUrl : document.URL+"?searchQuery="+query },
			done : function(data) {
				$(obj).addClass("click");
			}
		};
		ajax.call(options);
	}

	function goEvent(){
		var id = $(".tmenu .list .active").prop("id");
		var url = "";
		var eventGb2Cd = "${frontConstants.EVENT_GB2_CD_10}";
		//스토어
		if(id =="liTag_10"){
			eventGb2Cd = "${frontConstants.EVENT_GB2_CD_40}";
		}
		//tv
		else if(id =="liTag_20"){
			eventGb2Cd = "${frontConstants.EVENT_GB2_CD_20}";
		}
		//로그
		else if(id =="liTag_30"){
			eventGb2Cd = "${frontConstants.EVENT_GB2_CD_30}";
		}

		window.location.href = "/event/main";
	}
	
	$(function () {
		// 검색 메뉴
		$(".searchMenuContent").hide();
		$(".searchMenuContent:first").show();

		$("ul.searchMenu li").click(function () {
			$("ul.searchMenu li").removeClass("active");
			$(this).addClass("active");
			$(".searchMenuContent").hide()
			var activeTab = $(this).attr("rel");
			$("#" + activeTab).fadeIn()
		});
		
		//검색 : 카테고리
		$(".categorySub").hide();
		$(".categorySub:first").show();

		$("ul.searchCate li").click(function () {
			$("ul.searchCate li").removeClass("active");
			$(this).addClass("active");
			$(".categorySub").hide()
			var activeTab = $(this).attr("rel");
			$("#" + activeTab).fadeIn()
		});

		//검색 : 브랜드
		$(".brandSub").hide();
		$(".brandSub:first").show();

		$("ul.searchBrand li").click(function () {
			$("ul.searchBrand li").removeClass("active");
			$(this).addClass("active");
			$(".brandSub").hide()
			var activeTab = $(this).attr("rel");
			$("#" + activeTab).fadeIn()
		});

		//검색어 : 최근/인기검색어
		$(".searchKindSub").hide();
		$(".searchKindSub:first").show();

		$("ul.searchKind li").click(function () {
			$("ul.searchKind li").removeClass("active");
			$(this).addClass("active");
			$(".searchKindSub").hide()
			var activeTab = $(this).attr("rel");
			$("#" + activeTab).fadeIn()
		});
		
		// 검색 아이콘 클릭 시
		$(".btnSch").on("click", function(){
			goSearch();
		});
		// 검색 이벤트
		var thisUrl = window.location.href;
		if(thisUrl.indexOf("commonSearch") == -1){
			$("#srchWord, #srchShopWord").on("click", function(){
				goSearch();
			});
		}else{
			$(document).on("keypress","#srchWord, #srchShopWord",function(e){
				if ( event.keyCode == 13 ) {
					goSearch();
				}
			});
		}
	
		// 스크롤시 검색 포커스 해제
// 		$(window).scroll(function(){
// 			if(document.activeElement.name == 'srchWord'){
// 				$("#srchWord").blur();
// 			}
// 		});
		
		// 네이버 AI 데이터 관리
		let mbrNo, section, contentId, baseUrl, targetUrl, litd, lttd, agent = "";
		$("a, button").on("click", function(){
			// 회원번호
			mbrNo = "${session.sessionId}";
			if("" != "${session.mbrNo}"){
				mbrNo = "${session.mbrNo}";
			}
			
			// 요청구분
			section = "${view.seoSvcGbCd}";
			if("10" == section){
				section = "shop";
			} else if("20" == section){
				section = "tv";
			} else if("30" == section){
				section = "log";
			} else {
				section = "member";
			}
			
			// 콘텐츠/상품 번호/회원번호/태그번호(data-content)
			contentId = $(this).data("content");
			
			// 현재 URL
			if("" != $(this)[0].baseURI){
				baseUrl = $(this)[0].baseURI;
			}
			
			// 타겟 URL
			if("" != $(this).data("url") && "undefined" != typeof  $(this).data("url")){
				targetUrl = $(this).data("url");
			} else if("" != $(this)[0].href && "#" != $(this)[0].href){
				targetUrl = $(this)[0].href;
			} else if("" != $(this)[0].onclick){
				targetUrl = $(this)[0].onclick;
			}
			
			// Device, Device OS, 위도, 경도 추가
			if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
				agent = "APP_" + jscd.typeOs;
				
				// 위치정보 약관동의 여부
				var headerPstInfoAgrYn = "N";
				<c:if test="${session != null and session.pstInfoAgrYn == 'Y'}">
					headerPstInfoAgrYn = "Y";
				</c:if>
				
				// APP ibricks Interface
				var data = {
					      "mbr_no" : mbrNo
						, "section" : section
						, "content_id" : contentId
						, "action" : "etc"
						, "url" : baseUrl
						, "target_url" : targetUrl
						, "agent" : agent
						, "prclAddr" : ""
						, "roadAddr" : ""
						, "postNoNew" : ""
						, "timestamp" : ""
						, "pstInfoAgrYn" : headerPstInfoAgrYn
				};
				toNativeData.func = "onIbrixClick";
				toNativeData.parameters = JSON.stringify(data);
				toNative(toNativeData);
			} else {
				agent = "WEB_" + jscd.typeOs; 
		
				$.ajax({
					url : "/common/sendSearchEngineEvent"
					, data : {
						  "mbr_no" : mbrNo
						, "section" : section
						, "content_id" : contentId
						, "action" : "etc"
						, "url" : baseUrl
						, "targetUrl" : targetUrl
						, "agent" : agent
						, "prclAddr" : ""
						, "roadAddr" : ""
						, "postNoNew" : ""
						, "timestamp" : ""
					}
				});
			}
			// Device, Device OS, 위도, 경도 추가
		});
	});
	
	// APP용 Device, Device OS, 위도, 경도 추가
	function onCurrentLocCallBackIbricks(resultJson){
		var result = $.parseJSON(resultJson);
		agent = "APP_" + jscd.typeOs;
		if( result.authYn !== undefined && result.authYn == 'Y'){
			appLocAuthYn = "Y";
			lttd = result.latitude;
			litd = result.longitude;
			
			$.ajax({
				url : "/common/sendSearchEngineEvent"
				, data : {
					  "mbr_no" : mbrNo
					, "section" : section
					, "content_id" : contentId
					, "action" : "etc"
					, "url" : baseUrl
					, "target_url" : targetUrl
					, "litd" : litd
					, "lttd" : lttd
					, "agent" : agent
					, "timestamp" : ""
				}
			});
		}
	}
	// APP용 Device, Device OS, 위도, 경도 추가

	var clickCount = 0;
	// 메인으로 가기
	function goPetShopMain() {
		storageHist.goBack("/shop/home/?lnbDispClsfNo=${view.dispClsfNo}");
	}
	
	// 메인으로 가기 --> 코너로 포커스용 임시 주석
// 	function goPetShopMain(dispCornNo) {
// 		var form = document.createElement("form");
// 		document.body.appendChild(form);
// 		var url = "/shop/home/";
// 		form.setAttribute("method", "POST");
// 		form.setAttribute("action", url);

// 		var hiddenField = document.createElement("input");
// 		hiddenField.setAttribute("type", "hidden");
// 		hiddenField.setAttribute("name", "lnbDispClsfNo");
// 		hiddenField.setAttribute("value", '${view.dispClsfNo}');
// 		form.appendChild(hiddenField);
// 		document.body.appendChild(form);
// 		if(dispCornNo != undefined) {
// 			hiddenField = document.createElement("input");
// 			hiddenField.setAttribute("type", "hidden");
// 			hiddenField.setAttribute("name", "goSection");
// 			hiddenField.setAttribute("value", dispCornNo);
// 			form.appendChild(hiddenField);
// 			document.body.appendChild(form);
// 		}
		
// 		if(clickCount > 1) {
// 			return;
// 		}
// 		clickCount++;
// 		form.submit();
// 	}
	
	// 분류번호 보내기
	function sendDispClsfNo(dispClsfNo){
		var lnbDispClsfNo = dispClsfNo
		var cateCdL = convertDispClsfNo(dispClsfNo);
		var thisPath =  window.location.pathname + window.location.search;
		
		var form = document.createElement("form");
		document.body.appendChild(form);
		form.setAttribute("method", "POST");
		var url = "/shop/home";
		// 바로가기 영역, 샵홈 상품목록, 펫샵메인 -> 메인으로 이동
		if(thisPath.indexOf("shortCutYn=Y") == -1 && thisPath.indexOf("&dispCornNo=") == -1 && thisPath.indexOf("/shop/home") == -1 && thisPath.indexOf("/event/indexExhibitionZone") == -1 && thisPath.indexOf("/event/indexSpecialExhibitionZone") == -1 && thisPath.indexOf("/shop/indexBestGoodsList")) {
			form.setAttribute("method", "GET");
			url = '${session.reqUri}';
		}
		
		var hiddenField = document.createElement('input');
		hiddenField.setAttribute('type', 'hidden');
		hiddenField.setAttribute('name', 'lnbDispClsfNo');
		hiddenField.setAttribute('value', lnbDispClsfNo);
		form.appendChild(hiddenField);
		
		if(thisPath.indexOf("/shop/indexCategory") > -1) {
			hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "cateCdL");
			hiddenField.setAttribute("value", cateCdL);	// 12564
			form.appendChild(hiddenField);
			document.body.appendChild(form);
		}
		
		form.setAttribute("action", url);
		document.body.appendChild(form);
		form.submit();
	}
	
	// 바로 가기 영역
	function goLink(url, shortCutYn) {
		if(url.indexOf("dispClsfNo=") == -1) {
			var viewDispClsfNo = '${empty view.dispClsfNo ? frontConstants.PETSHOP_MAIN_DOG_DISP_CLSF_NO : view.dispClsfNo}';
			if(url.indexOf("?") > -1) {
				url += "&dispClsfNo="+viewDispClsfNo;
			}else {
				url += "?dispClsfNo="+viewDispClsfNo;
			}
		}
		if(shortCutYn){
			if(url.indexOf("?") > -1){		// 바로가기 구분값 추가
				url += "&shortCutYn=Y"
			}else{
				url += "?shortCutYn=Y"
			}
		}
		
		location.href = url;
	}
	
	function convertDispClsfNo(dispClsfNo) {
		var cateCdL = '${frontConstants.PETSHOP_DOG_DISP_CLSF_NO}';
		
		if('${frontConstants.PETSHOP_MAIN_CAT_DISP_CLSF_NO}' == dispClsfNo ) {	// 고양이
			cateCdL = '${frontConstants.PETSHOP_CAT_DISP_CLSF_NO}'
		} else if('${frontConstants.PETSHOP_MAIN_FISH_DISP_CLSF_NO}' == dispClsfNo ) {	// 관상어
			cateCdL = '${frontConstants.PETSHOP_FISH_DISP_CLSF_NO}'
		} else if('${frontConstants.PETSHOP_MAIN_ANIMAL_DISP_CLSF_NO}' == dispClsfNo ) {	// 소동물
			cateCdL = '${frontConstants.PETSHOP_ANIMAL_DISP_CLSF_NO}'
		}
		
		return cateCdL;	
	}
	
	function getSearchInputAutoComplete() { 
		$.post( "/shop/getSearchInputAutoComplete",	function( data ) {
			var srchText = "검색어를 입력해주세요.";
			if(data.searchBox != null && data.searchBox.bnrText != null && data.searchBox.bnrText != ''){
				srchText = data.searchBox.bnrText;
			}
			// 모바일 검색창
			$("#srchWordMO").text(srchText);
			// pc 검색창
			$("#srchWord").attr("placeholder", srchText);
			$("#srchShopWord").attr("placeholder", srchText);
		});
	}
	
	function clickLogin(){
		location.href = "/indexLogin?returnUrl="+location.pathname+location.search;
	}
	
	
	//장바구니 수 set, 캐시 이슈로 ajax 호출
	function setCartCnt(){
		$.ajax({
			url : "/order/getCartCnt"
			, dataType : "json"
			, type : "POST"
			, success : function(data){
				var $cartCntObj = $('.header .menu .cart').find('em');
				if($cartCntObj.length == 0){
					if(data.cartCnt != 0){
						var html = '<em class="n">'+data.cartCnt+'</em>';
						$('.header .menu .cart').html(html);
					}
				}else{
					if(data.cartCnt == 0){
						$cartCntObj.remove();
					}else{
						$cartCntObj.text(data.cartCnt);
					}
				}
			}
		});
	}

	function loadCornerGoodsList(dispClsfNo, dispCornNo, dispClsfCornNo, dispType, timeDeal) {
		var petNo = $("#petNo_rec").val();
		var form = document.createElement("form");
		document.body.appendChild(form);
		var url = "/shop/indexGoodsList";
		form.setAttribute("method", "GET");
		form.setAttribute("action", url);

		var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "dispClsfNo");
		hiddenField.setAttribute("value", dispClsfNo);
		form.appendChild(hiddenField);
		document.body.appendChild(form);
		hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "dispCornNo");
		hiddenField.setAttribute("value", dispCornNo);
		form.appendChild(hiddenField);
		document.body.appendChild(form);
		hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "dispClsfCornNo");
		hiddenField.setAttribute("value", dispClsfCornNo);
		form.appendChild(hiddenField);
		document.body.appendChild(form);
		hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "dispType");
		hiddenField.setAttribute("value", dispType);
		form.appendChild(hiddenField);
		document.body.appendChild(form);
		if(timeDeal != undefined) {
			hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "timeDeal");
			hiddenField.setAttribute("value", timeDeal);
			form.appendChild(hiddenField);
			document.body.appendChild(form);
		}
		if(dispType == '${frontConstants.GOODS_MAIN_DISP_TYPE_RCOM}') {
			hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "petNo");
			hiddenField.setAttribute("value", petNo);
			form.appendChild(hiddenField);
			document.body.appendChild(form);
		}
		form.submit();
	}
    
  	//등급 레이어팝업 스크립트 추가 2021.05.13
	var rankBox = function(){
		ui.popLayer.open('popLank',{
			ocb:function(){
				// console.log("popLank 열림");
			},
			ccb:function(){
				// console.log("popLank 닫힘");
			}
		});

		if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_10}") {
			$(".rank_pc").addClass("on");
		}else {										
			$(".rank_mo").addClass("on");
		}
	}
</script>

<c:set var="headerSet" value="set0"/>
<c:set var="classMode" value="mode0"/>
<c:if test="${fn:indexOf(session.reqUri, '/goods/') > -1 && view.deviceGb ne frontConstants.DEVICE_GB_10}">
	<c:set var="headerSet" value="set4-1"/>
	<c:set var="classMode" value="mode4"/>
</c:if>
<c:if test="${fn:indexOf(session.reqUri, '/shop/home') > -1 && view.deviceGb ne frontConstants.DEVICE_GB_10}">
	<c:set var="headerSet" value="set13"/>
	<c:set var="classMode" value="mode2"/>
</c:if>
<c:if test="${(fn:indexOf(session.reqUri, '/shop/indexGoodsList') > -1 or fn:indexOf(session.reqUri, '/petshopEventList') > -1) && view.deviceGb ne frontConstants.DEVICE_GB_10}">
	<c:set var="headerSet" value="set4"/>
	<c:set var="classMode" value="mode4"/>
</c:if>
<c:if test="${(fn:indexOf(session.reqUri, '/shop/indexLive') > -1 or fn:indexOf(session.reqUri, '/event/shop/main') > -1 or fn:indexOf(session.reqUri, '/shop/indexBestGoodsList') > -1 or fn:indexOf(session.reqUri, 'Category') > -1 or fn:indexOf(session.reqUri, 'Exhibition') > -1) && view.deviceGb ne frontConstants.DEVICE_GB_10}">
	<c:set var="headerSet" value="set13"/>
	<c:set var="classMode" value="mode10"/>
</c:if>
<c:if test="${(fn:indexOf(session.reqUri, '/order/indexCartList') > -1 or fn:indexOf(session.reqUri, '/brand/indexBrandDetail') > -1 or fn:indexOf(session.reqUri, '/shop/indexPetShopTagGoods') > -1) && view.deviceGb ne frontConstants.DEVICE_GB_10}">
	<c:set var="headerSet" value="set16"/>
	<c:set var="classMode" value="mode7-1 noneAc"/>
</c:if>
<c:if test="${(fn:indexOf(session.reqUri, '/order/indexOrderPayment') > -1) && view.deviceGb ne frontConstants.DEVICE_GB_10}">
	<c:set var="headerSet" value="set16"/>
	<c:set var="classMode" value="mode7-1"/>
</c:if>
<c:set var="petLogLink" value="N"/>
<c:if test="${fn:indexOf(session.reqUri, '/log/indexPetLogDetailView') > -1 && view.deviceGb ne frontConstants.DEVICE_GB_10 && view.shareAcc eq 'Y'}">
	<c:set var="petLogLink" value="Y"/>
	<c:set var="classMode" value="mode16"/>
</c:if>
<c:if test="${fn:indexOf(session.reqUri, '/commonSearch') > -1 }">
	<c:set var="headerSet" value="set19"/>
	<c:set var="classMode" value="mode14"/>
</c:if>
<c:if test="${(fn:indexOf(session.reqUri, '/order/indexBillingCardList') > -1) && view.deviceGb ne frontConstants.DEVICE_GB_10}">
	<c:set var="headerSet" value="set0"/>
	<c:set var="classMode" value="mode7"/>
</c:if>
<c:if test="${fn:indexOf(session.reqUri, '/log/home') > -1 }">
	<c:set var="headerSet" value="set1"/>
	<c:set var="classMode" value="mode1"/>
</c:if>
<%-- MY --%>
<c:if test="${(fn:indexOf(session.reqUri, '/mypage/info/indexPswdUpdate') > -1 or fn:indexOf(session.reqUri, '/mypage/info/indexPswdSet') > -1 or fn:indexOf(session.reqUri, '/indexLogin') > -1 
	 or fn:indexOf(session.reqUri, '/mypage/info/indexManageCheck') > -1 
	or fn:indexOf(session.reqUri, '/indexMyInfo') > -1) && view.deviceGb ne frontConstants.DEVICE_GB_10}">
	<c:set var="headerSet" value="set9"/>
	<c:set var="classMode" value="mode7"/>
</c:if>
<c:if test="${(fn:indexOf(session.reqUri, '/faq/faqList') > -1 or fn:indexOf(session.reqUri, '/mypage/info/indexManageDetail') > -1 
	or fn:indexOf(session.reqUri, '/event/detail') > -1 or fn:indexOf(session.reqUri, '/customer/notice/indexNoticeList') > -1
	or fn:indexOf(session.reqUri, '/event/main') > -1 or fn:indexOf(session.reqUri, '/indexSettingTerms') > -1) && view.deviceGb ne frontConstants.DEVICE_GB_10}">
	<c:set var="classMode" value="mode7-1"/>
	<c:set var="headerSet" value="set16"/>
</c:if>
<c:if test="${(fn:indexOf(session.reqUri, '/mypage/tv/myWishList') > -1 or fn:indexOf(session.reqUri, '/mypage/log/myWishList') > -1 or fn:indexOf(session.reqUri, '/mypage/shop/myWishList') > -1) && view.deviceGb ne frontConstants.DEVICE_GB_10}">
	<c:set var="classMode" value="mode16 noneAc"/>
	<c:set var="headerSet" value="set16"/>
</c:if>
<%-- TV --%>
<c:if test="${fn:indexOf(session.reqUri, '/tv/home') > -1 && view.deviceGb ne frontConstants.DEVICE_GB_10}">
	<c:set var="classMode" value="mode1"/>
	<c:set var="headerSet" value="set1"/>
</c:if>
<c:if test="${(fn:indexOf(session.reqUri, '/tv/hashTagList') > -1 or fn:indexOf(session.reqUri, '/tv/petTvList') > -1 or fn:indexOf(session.reqUri, '/tv/seriesTagList') > -1 or fn:indexOf(session.reqUri, '/tv/tagVodList') > -1) && view.deviceGb ne frontConstants.DEVICE_GB_10}">
	<c:set var="classMode" value="mode13"/>
	<c:set var="headerSet" value="set18"/>
</c:if>
<c:if test="${fn:indexOf(session.reqUri, '/tv/collectTags') > -1 && view.deviceGb ne frontConstants.DEVICE_GB_10}">
	<c:set var="classMode" value="mode7-1"/>
	<c:set var="headerSet" value="set16"/>
</c:if>
<c:if test="${fn:indexOf(session.reqUri, '/tv/series/petTvSeriesList') > -1 && view.deviceGb ne frontConstants.DEVICE_GB_10}">
	<c:set var="classMode" value="mode6"/>
	<c:set var="headerSet" value="set6"/>
</c:if>
<c:if test="${fn:indexOf(session.reqUri, '/customer/inquiry/inquiryView') > -1 && view.deviceGb ne frontConstants.DEVICE_GB_10}">
	<c:set var="classMode" value="mode16 noneAc"/>
	<c:set var="headerSet" value="set22"/>
</c:if>
<%-- 펫스쿨 메인 화면에서 직접 header를 넣어서 사용중이다. 추후 변경되어야 하면 여기 주석 풀고 (/gs-apet-31-front/WebContent/_html/inc/header_cu.html) 여기의 mode2-1을 수정 & petSchoolList.jsp 수정하자
<c:if test="${fn:indexOf(session.reqUri, '/tv/petSchool') > -1 && view.deviceGb ne frontConstants.DEVICE_GB_10}">
	<c:set var="classMode" value="mode2-1"/>
	<c:set var="headerSet" value="set2-1"/>
</c:if>
--%>
<c:if test="${fn:indexOf(session.reqUri, '/tv/series/indexTvRecentVideo') > -1 && view.deviceGb ne frontConstants.DEVICE_GB_10}">
	<c:set var="classMode" value="mode16"/>
	<c:set var="headerSet" value="set16"/>
</c:if>
<%-- //TV//--%>


<!-- header pc-->
<header class="header pc cu ${classMode}" data-header="${headerSet}" id="header_pc">
	<input type="password" style="display:none;"/><!-- 크롬 패스워드 자동완성 방지 -->
	<div class="hdr">
		<div class="inr">
			<div class="tdt">
				<c:if test="${session.mbrNo ne frontConstants.NO_MEMBER_NO}">
					<div class="usr">
						<c:choose>
							<c:when test="${session.mbrGrdCd eq frontConstants.MBR_GRD_10   }">
							<a class="rank_icon" href="javascript:rankBox();"><em class="lv vvip">VVIP</em></a>
							</c:when>
							<c:when test="${session.mbrGrdCd eq frontConstants.MBR_GRD_20   }">
							<a class="rank_icon" href="javascript:rankBox();"><em class="lv vip">VIP</em></a>
							</c:when>
							<c:when test="${session.mbrGrdCd eq frontConstants.MBR_GRD_30   }">
							<a class="rank_icon" href="javascript:rankBox();"><em class="lv family">패밀리</em></a>
							</c:when>
							<c:otherwise>
							<a class="rank_icon" href="javascript:rankBox();"><em class="lv welcome">웰컴</em></a>
							</c:otherwise>
						</c:choose>
						<a href="javascript:;" class="name"><b class="t">${session.loginId}</b><i class="i">님</i></a>
						<div class="sbm">
							<ul class="sm">
							<c:choose>
								<c:when test="${empty session.bizNo}">
									<li><a href="/mypage/info/indexPswdUpdate" data-content="${session.mbrNo}" data-url="/mypage/info/indexPswdUpdate" class="bt">비밀번호 설정</a></li>
									<li><a href="/mypage/info/indexManageDetail" data-content="${session.mbrNo}" data-url="/mypage/info/indexManageDetail" class="bt">회원정보 수정</a></li>
									<li><a href="/logout" data-content="${session.mbrNo}" data-url="/logout" class="bt">로그아웃</a></li>
								</c:when>
								<c:otherwise>
									<li><a href="/log/partnerPswdUpdate?returnUrl=/log/home" data-content="${session.mbrNo}" data-url="/log/partnerPswdUpdate" class="bt">비밀번호 설정</a></li>
									<li><a href="/logout" data-content="${session.mbrNo}" data-url="/logout" class="bt">로그아웃</a></li>
								</c:otherwise>
							</c:choose>
							</ul>
						</div>
					</div>
				</c:if>
				<ul class="menu">					
					<%-- <c:if test="${session.mbrNo ne frontConstants.NO_MEMBER_NO}">
					    <li>
					    	<a href="/logout">로그아웃</a>
					    </li>
					</c:if> --%>
					<c:if test="${session.mbrNo eq frontConstants.NO_MEMBER_NO}">
						<li><a href="/join/indexTerms?header=Y" class="bt">회원가입</a></li>
		                <li><a href="javascript:clickLogin();" class="bt">로그인</a></li>
		                <!-- <li><a href="javascript:;" class="bt">로그인/회원가입</a></li> -->
					</c:if>
					<c:if test="${empty session.bizNo}">
						<li><a href="javascript:goEvent();" class="bt">이벤트</a></li>
						<li class="custo">
							<a href="javascript:;" class="bt">고객센터</a>
							<div class="sbm">
								<ul class="sm">
									<li><a href="/customer/faq/faqList" class="bt">FAQ</a></li>
									<li><a href="/customer/inquiry/inquiryView" class="bt"><spring:message code='front.web.view.new.menu.customer.inquiry'/></a></li>
									<li><a href="/customer/notice/indexNoticeList" data-url="/customer/notice/indexNoticeList" data-content="" class="bt">공지사항</a></li>
								</ul>
							</div>
						</li>
					</c:if>
				</ul>
			</div>
			<div class="hdt">
				<!-- mobile -->
				<button class="mo-header-btnType02">취소</button><!-- on 클래스 추가 시 활성화 -->
				<!-- // mobile -->
				<c:if test="${view.btnGnbHide ne true and empty session.bizNo}">
<%-- 					<c:if test="${fn:indexOf(session.reqUri, '/indexLive') < 0}"> --%>
						<button class="btnGnb" type="button">메뉴</button>
<%-- 					</c:if> --%>
				</c:if>
				<!-- -->
				<c:choose>
					<c:when test="${fn:indexOf(session.reqUri, '/shop/') > -1}">
						<c:set var="svcGbNm" value="shop"/>
					</c:when>
					<c:when test="${fn:indexOf(session.reqUri, '/log/') > -1}">
						<c:set var="svcGbNm" value="log"/>
					</c:when>
					<c:when test="${fn:indexOf(session.reqUri, '/goods/') > -1}">
						<c:set var="svcGbNm" value=""/>
					</c:when>
					<c:otherwise>
						<c:set var="svcGbNm" value="tv"/>
					</c:otherwise>
				</c:choose>
				<c:if test="${fn:indexOf(session.reqUri, '/indexMyPage') < 0 or view.deviceGb eq frontConstants.DEVICE_GB_10}">
				<h1 class="logo ${svcGbNm}">
					<a class="bt" href="${view.deviceGb eq frontConstants.DEVICE_GB_10 ? '/shop/home/' : '#'}">AboutPet</a>
				</h1>
				</c:if>
				<c:if test="${view.seoSvcGbCd eq frontConstants.SEO_SVC_GB_CD_10}">
<%-- 					<c:if test="${fn:indexOf(session.reqUri , '/indexLive') < 0}"> --%>
						<nav class="menushop">
							<button type="button" class="bt st"></button>
							<div class="list">
								<ul class="menu">
									<li class="${frontConstants.PETSHOP_MAIN_DOG_DISP_CLSF_NO eq view.dispClsfNo ? 'active' : ''}"><a class="bt" href="javascript:void(0);" onclick="sendDispClsfNo(${frontConstants.PETSHOP_MAIN_DOG_DISP_CLSF_NO})"><b class="t" id="b_tag_${view.dispClsfNo}">강아지</b></a></li>
									<li class="${frontConstants.PETSHOP_MAIN_CAT_DISP_CLSF_NO eq view.dispClsfNo ? 'active' : ''}"><a class="bt" href="javascript:void(0);" onclick="sendDispClsfNo(${frontConstants.PETSHOP_MAIN_CAT_DISP_CLSF_NO})"><b class="t" id="b_tag_${view.dispClsfNo}">고양이</b></a></li>
									<li class="${frontConstants.PETSHOP_MAIN_FISH_DISP_CLSF_NO eq view.dispClsfNo ? 'active' : ''}"><a class="bt" href="javascript:void(0);" onclick="sendDispClsfNo(${frontConstants.PETSHOP_MAIN_FISH_DISP_CLSF_NO})"><b class="t" id="b_tag_${view.dispClsfNo}">관상어</b></a></li>
									<li class="${frontConstants.PETSHOP_MAIN_ANIMAL_DISP_CLSF_NO eq view.dispClsfNo ? 'active' : ''}"><a class="bt" href="javascript:void(0);" onclick="sendDispClsfNo(${frontConstants.PETSHOP_MAIN_ANIMAL_DISP_CLSF_NO})"><b class="t" id="b_tag_${view.dispClsfNo}">소동물</b></a></li>
								</ul>
							</div>
						</nav>
<%-- 					</c:if> --%>
				</c:if>
				<!-- -->
				<!-- mobile -->
				<c:choose>
					<c:when test="${petLogLink eq 'Y'}">
						<button class="mo-header-backNtn" onclick="storageHist.goBack('/log/home/')" style="display:block" >뒤로</button>
					</c:when>
					<c:when test="${fn:indexOf(requestScope['javax.servlet.forward.query_string'] ,'home=log') > -1}">
                        <button class="mo-header-backNtn" onclick="storageHist.goBack('/log/home/')">뒤로</button>
                    </c:when>
                    <c:when test="${fn:indexOf(requestScope['javax.servlet.forward.query_string'] ,'home=event') > -1}">
                        <button class="mo-header-backNtn" onclick="storageHist.goBack('/tv/home/')">뒤로</button>
                    </c:when>
                    <c:when test="${fn:indexOf(requestScope['javax.servlet.forward.query_string'] ,'home=shop') > -1}">
                        <button class="mo-header-backNtn" onclick="storageHist.goBack('/shop/home/')">뒤로</button>
                    </c:when>
                    <c:when test="${fn:indexOf(requestScope['javax.servlet.forward.query_string'] ,'home=my') > -1}">
                        <button class="mo-header-backNtn" onclick="storageHist.goBack('/mypage/indexMyPage/')">뒤로</button>
                    </c:when>
                    <c:when test="${fn:indexOf(requestScope['javax.servlet.forward.query_string'] ,'home=tv') > -1}">
                        <button class="mo-header-backNtn" onclick="storageHist.goBack('/tv/home/')">뒤로</button>
                    </c:when>
					<c:when test="${fn:indexOf(session.reqUri , 'liveGoodsDetail') > -1}">
						<button class="mo-header-backNtn" onclick="parent.postMessage({'action': 'pip_exit'}, '*')">뒤로</button>
					</c:when>
					<c:otherwise>
						<button class="mo-header-backNtn" onclick="storageHist.goBack();">뒤로</button>
					</c:otherwise>
				</c:choose>
				
				<div class="mo-heade-tit" <c:if test="${petLogLink eq 'Y'}"> style="display:flex;"</c:if> >
					<c:choose>
						<c:when test="${fn:indexOf(session.reqUri, '/goods/') > -1}">
							<div class="pic hide"><img src="" alt=""></div>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${petLogLink eq 'Y'}">
									<span class="tit"><spring:message code='front.web.view.new.menu.log' /></span>  <!-- APET-1250 210728 kjh02  -->
								</c:when>
								<c:otherwise>
									<span class="tit"></span>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</div>
				<c:if test="${fn:indexOf(session.reqUri , '/mypage/info/') == -1}">
					<div class="mo-header-rightBtn">
						<button class="mo-header-btnType01">
							<span class="mo-header-icon"></span>
							<%--시리즈목록--%>
						</button>
					</div>
				</c:if>
				<button class="mo-header-close"></button>
				<!-- // mobile -->
				<nav class="tmenu">
					<ul class="list">
				<c:choose>
					<c:when test="${empty session.bizNo}">
						<li id="liTag_20" class="${fn:indexOf(session.reqUri, '/tv/') > -1 ? fn:indexOf(session.reqUri, '/mypage/') > -1 or fn:indexOf(session.reqUri, '/indexTvRecentVideo') > -1 ? '' : 'active' : ''}"><a href="/tv/home/" class="bt"><spring:message code='front.web.view.new.menu.tv' /></a></li>
						<li id="liTag_30" class="${fn:indexOf(session.reqUri, '/log/') > -1 ? fn:indexOf(session.reqUri, '/mypage/') > -1 ? '' : 'active' : ''}"><a href="/log/home/" class="bt"><spring:message code='front.web.view.new.menu.log' /></a></li> <!-- APET-1250 210728 kjh02  -->
						<li id="liTag_10" class="${(fn:indexOf(session.reqUri, '/shop/') > -1 or fn:indexOf(session.reqUri, '/goods/') > -1 or fn:indexOf(session.reqUri, '/brand/') > -1 or fn:indexOf(session.reqUri, '/event/shop') > -1 or fn:indexOf(session.reqUri, 'Exhibition') > -1) ? fn:indexOf(session.reqUri, '/mypage/') > -1 ? '' : 'active' : ''}"><a href="/shop/home/" class="bt"><spring:message code='front.web.view.new.menu.store' /></a></li> <!-- APET-1250 210728 kjh02  -->
						<li id="liTag_00" class="${fn:indexOf(session.reqUri, '/my') > -1 or fn:indexOf(session.reqUri, '/indexLogin') > -1  or fn:indexOf(session.reqUri, '/login/') > -1 or fn:indexOf(session.reqUri, '/indexTvRecentVideo') > -1 or fn:indexOf(session.reqUri, '/customer/inquiry/inquiryView') > -1 ? 'active' : '' }"><a href="/mypage/indexMyPage/" class="bt">MY</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="javascript:;" class="bt"><spring:message code='front.web.view.new.menu.tv' /></a></li> <!-- APET-1250 210728 kjh02  -->
						<li id="liTag_30" class="${(fn:indexOf(session.reqUri, '/log/') > -1 and fn:indexOf(session.reqUri, '/partnerPswdUpdate') < 0)? 'active' : ''}"><a href="/log/home/" class="bt"><spring:message code='front.web.view.new.menu.log' /></a></li>  <!-- APET-1250 210728 kjh02  -->
						<li><a href="javascript:;" class="bt"><spring:message code='front.web.view.new.menu.store' /></a></li> <!-- APET-1250 210728 kjh02  -->
						<li id="liTag_00" class="${fn:indexOf(session.reqUri, '/partnerPswdUpdate') > -1 or fn:indexOf(session.reqUri, 'my') > -1? 'active' : '' }"><a href="/log/partnerPswdUpdate?returnUrl=/log/home" class="bt">MY</a></li>
					</c:otherwise>
				</c:choose>
					</ul>
				</nav>
			</div>
			<%-- <c:if test="${empty session.bizNo}"> --%>
<%-- 				<c:if test="${fn:indexOf(session.reqUri , '/indexLive') < 0}"> --%>
					<div class="cdt" <c:if test="${!empty session.bizNo and view.deviceGb ne 'PC' and fn:indexOf(session.reqUri, '/log/home') > -1 }">style="right:27px;"</c:if>>
						<c:if test="${fn:indexOf(session.reqUri , '/mypage/indexMyPage') < 0  or (fn:indexOf(session.reqUri , '/mypage/indexMyPage') > -1 and view.deviceGb eq 'PC' )}"  >
							<div class="schs">
								<div class="form <c:if test="${fn:indexOf(session.reqUri, '/commonSearch') > -1 }">open</c:if>">
									<div class="input del kwd"><input id="srchWord" name="srchWord" type="search" value="<c:out value="${srchWord}" escapeXml="false" />" autocomplete="off" ></div>
									<button type="button" class="btnSch" data-content="" data-url="/commonSearch">검색</button>
									<!-- 자동완성 드롭박스 -->
									<div class="key-word-list" id="key-word-list" style="display:none;"><ul></ul></div>
									<!-- 자동완성 드롭박스 -->
								</div>
							</div>
						</c:if>
						<c:if test="${empty session.bizNo}">
						<div class="menu">
							<button id="alertBtn" class="bt alim  <c:if test="${session.almRcvYn eq 'Y'}">on</c:if>" type="button">알림</button>
							<c:if test="${fn:indexOf(session.reqUri , '/mypage/indexMyPage') < 0  or (fn:indexOf(session.reqUri , '/mypage/indexMyPage') > -1 and view.deviceGb eq 'PC' )}"  >
								<button class="bt cart" type="button" onclick="location.href='/order/indexCartList/'" >
									<c:if test="${view.cartCnt ne null and view.cartCnt ne '' and view.cartCnt ne '0'}">
										<em class="n">${view.cartCnt}</em>
									</c:if>
								</button>
							</c:if>
							<button id="srchClsBtn" class="bt close" type="button" style="display: none;" onclick="searchCommon.srchClsBtn();">닫기</button>
							<div class="alims" id ="alertDiv">
							</div>
						</div>
						</c:if>
					</div>
<%-- 				</c:if> --%>

			<%-- </c:if> --%>
		</div>
	</div>
</header>

		
		<div class="layers">
			<!-- 레이어팝업 넣을 자리 -->
			<!-- 등급안내 팝업 추가 2021.05.13 -->
			<article class="popLayer a popLank " id="popLank">
				<div class="pbd">
					<div class="phd">
						<div class="in">
							<h1 class="tit"></h1>
							<button type="button" class="btnPopClose">닫기</button>
						</div>
					</div>
					<div class="pct">
						<main class="poptents">
							<div class="rankCont">
								<c:choose>
									<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
										<div class="rank_imgBox rank_pc">
											<img src="/_images/common/img-level-pc.png" alt="어바웃펫 패미리 등급별 혜택 이미지">
										</div>
									</c:when>
									<c:otherwise>
										<div class="rank_imgBox rank_mo">									
											<img src="/_images/common/img-level-mw.png" alt="어바웃펫 패미리 등급별 혜택 이미지">
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</main>
					</div>
				</div>
			</article>
			<!-- //등급안내 팝업 추가 2021.05.13 -->
		</div>
<!--// header pc-->