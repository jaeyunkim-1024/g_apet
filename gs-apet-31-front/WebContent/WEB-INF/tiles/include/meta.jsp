<title>${not empty seoInfo.pageTtl ? seoInfo.pageTtl : not empty exMessage ? exMessage : view.stNm}</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<meta name="format-detection" content="telephone=no">
<meta name="theme-color" content="#ffffff">
<c:if test="${view.nocache eq true}">
	<meta http-equiv="Cache-Control" content="no-cache">
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Expires" content="0">
</c:if>

<link rel="canonical" href="${seoInfo.canonicalUrl}">
<meta name="author" content="${seoInfo.pageAthr}" />
<meta name="description" content="${seoInfo.pageDscrt}">
<meta name="keywords" content="${seoInfo.pageKwd}">

<meta name="twitter:card" content="Summary">
<meta name="twitter:site" content="트위터 사이트">
<meta name="twitter:creator" content="트위터 계정">
<meta name="twitter:url" content="https://www.aboutpet.co.kr/">
<meta name="twitter:title" content="${seoInfo.pageTtl}">
<meta name="twitter:description" content="${seoInfo.pageDscrt}">
<meta name="twitter:image" content="${seoInfo.openGraphImg}">

<!--
	http://jira.aboutpet.co.kr/browse/CSR-1481
	TO-DO :: 보안을 위해 컨텐트에 담겨있는 키 값 추후 business.xml 로 관리
-->
<meta name="facebook-domain-verification" content="uu7h1zvexafeyqd6spqluy926dx1n1" />

<meta property="og:type" content="website">
<meta property="og:site_name" content="${seoInfo.pageTtl}">
<meta property="og:locale" content="ko">
<meta property="og:url" content="https://www.aboutpet.co.kr/">
<meta property="og:title" content="${seoInfo.pageTtl}">
<meta property="og:description" content="${seoInfo.pageDscrt}">
<meta property="og:image" content="/_images/common/aboutpet_logo@2x.png" />
<meta property="og:image:url" content="/_images/common/aboutpet_logo@2x.png" />
<meta property="og:image:type" content="image/jpeg" />
<meta property="og:image:width" content="300" />
<meta property="og:image:height" content="300" />

<link href="/_images/common/favicon.ico" rel="shrtcut icon">
<link href="/_images/common/favicon.png" rel="apple-touch-icon-precomposed">

<c:choose>
	<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
		<link rel="stylesheet" type="text/css" href="/_css/style.pc.css">
	</c:when>
	<c:otherwise>
		<link rel="stylesheet" type="text/css" href="/_css/style.mo.css">
	</c:otherwise>
</c:choose>

<%-- 사이트 속도 개선 요청건-CSS, JS 을 CDN에서 다운로드로 인한 style.mo.css/style.mo.css의  jquery-ui.css를 meta 로 옮겨옴. --%>
<link rel="stylesheet" type="text/css" href="<spring:eval expression="@bizConfig['cdn.domain']" />/_css/jquery-ui.css">

<script async src="https://www.googletagmanager.com/gtag/js?id=<spring:eval expression="@bizConfig['google.analytics.key']" />"></script>
<script type="text/javascript" 	src="/_script/googleAnalytics.js"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', "<spring:eval expression="@bizConfig['google.analytics.key']" />");
</script>

<script type="text/javascript"  src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/jquery/jquery-3.3.1.min.js" ></script>
<script type="text/javascript"  src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/jquery/jquery-ui.min.js"></script>
<script type="text/javascript"  src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/jquery/jquery.ui.datepicker-ko.js" ></script>
<script type="text/javascript"  src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/jquery/jquery.blockUI.js" charset="utf-8"></script>
<script type="text/javascript"  src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/jquery/jquery.inputmask.bundle.min.js" charset="utf-8"></script>
<script type="text/javascript"  src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/jquery/jquery.number.min.js" charset="utf-8"></script>
<script type="text/javascript"  src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/jquery/jquery.form.min.js" ></script>
<script type="text/javascript"  src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/jquery/jquery.countdown.js" ></script>
<script type="text/javascript"  src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/jquery/jquery.cookie.js" ></script>
<script type="text/javascript"  src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/swiper.min.js"></script>
<script type="text/javascript"  src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/clipboard.min.js"></script>
<script type="text/javascript"  src="/_script/common.js" ></script>
<script type="text/javascript"  src="/_script/popup.js" ></script>
<script type="text/javascript" 	src="/_script/ui.js"></script>
<script type="text/javascript" 	src="/_script/deviceChk.js"></script>	<!-- // APP용 Device, Device OS, 위도, 경도 추가 -->
<!-- kakao map -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<spring:eval expression="@bizConfig['kakao.app.key.javascript']" />&libraries=services"></script>
<script type="text/javascript" 	src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/kakao-map.js"></script>
<!-- app interface --> 
<script type="text/javascript" 	src="/_script/app-interface.js"></script>
<!-- adbrix -->
<%-- <c:if test="${view.deviceGb eq commonConstants.DEVICE_GB_30}"> --%>
	<script type="text/javascript" 	src="/_script/adbrix.js"></script>
<%-- </c:if> --%>
 
<c:choose>
	<c:when test="${view.deviceGb eq commonConstants.DEVICE_GB_10 }">
		<script type="text/javascript" 	src="/_script/ui.pc.js"></script>
	</c:when>
	<c:otherwise>
		<script type="text/javascript" 	src="/_script/ui.mo.js"></script>
	</c:otherwise>
</c:choose>

<%-- 네이버 Map --%>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=<spring:eval expression="@bizConfig['naver.cloud.client.id']" />&submodules=geocoder"></script>
<script type="text/javascript">
//	const viewJsonData = JSON.parse(decodeURIComponent('${view.jsonData}'));
</script>

<script type="text/javascript">
	let tempFuncNm = ""; //onBackSelected 함수 호출 시 넘긴함수명으로 callBack함수에서 실행될 함수명
	
	$(document).ready(function(){
		/* 안드로이드 계열에서 저장되는 것 막음 / javascript Ready Function에 추가 */
		/*$(document).bind("contextmenu", function(e) {
		    return false;
		});*/
		
		document.addEventListener("contextmenu", e => { 
		    e.target.matches("img") && e.preventDefault()
		    e.target.matches("video") && e.preventDefault()
			e.target.className=="thumb-img" && e.preventDefault()
		});
		
		//Device 뒤로가기 버튼 기능을 웹에서 처리시 사용(Y:웹에서 백기능 처리, N:앱에서 처리)
		//페이지로딩시 Device 뒤로가기 버튼 기능 앱에서 처리로 리셋
		if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}") {
			toNativeData.func = "onBackSelected";
			toNativeData.isIntercepter = "N";
			toNative(toNativeData);
			
			tempFuncNm = ""; //함수명 초기화
		}
	});

	$(window).on('pageshow', function() { storageReferrer.set(); });
	
	// mw/pc 자동 로그아웃 30분 
	var checkActionTimeOut;
	if('${session.mbrNo}' != '${frontConstants.NO_MEMBER_NO}' && '${view.deviceGb}' != '${frontConstants.DEVICE_GB_30}'){
	    resetLoginTimeOut();
	    $(document).on('click keypress' , 'body' , function(){
	        resetLoginTimeOut();
	    });
	}
	function resetLoginTimeOut() {
		if('${session.mbrNo}' != '${frontConstants.NO_MEMBER_NO}' && '${view.deviceGb}' != '${frontConstants.DEVICE_GB_30}'){
		    window.clearTimeout(checkActionTimeOut);
		    checkActionTimeOut = setTimeout(function() {
		        location.href="/logout/";
		    }, 30 * 60 * 1000);
		}		   
	}
	
	// 설정 -> 앱 푸시 설정 토글시
	// 앱에서 호출하기 위해 공통으로 푸출
	function updateInfoRcyYn(checkYn) {
		if("${session.loginId}" != null && "${session.loginId}" != "") {
			var toastText = (checkYn == "Y") ? "<spring:message code='front.web.view.common.msg.setting'/>" : "<spring:message code='front.web.view.common.msg.remove'/>";
					
			var options = {
					url : "<spring:url value='/updateInfoRcvYn' />"
					, data : { mbrNo : "${session.mbrNo}", infoRcvYn : checkYn }
					, done : function(result) {
						if(result == "${frontConstants.CONTROLLER_RESULT_CODE_SUCCESS}") {
							if(checkYn != "Y") {
								ui.toast("<spring:message code='front.web.view.index.login.settings.msg.app.push.notice1'/>" +" "+toastText +"<spring:message code='front.web.view.index.login.settings.msg.app.push.notice2'/>");	
							}	
						}
					}
			}
			ajax.call(options);
		}
	}
	
	// APP용 ibricks Callback function
	function interfaceIbricksCallback(responseData){
		var response = $.parseJSON(responseData);
		$.ajax({
			url : "/common/sendSearchEngineEvent"
			, data :{
			      "mbr_no" : response.mbrNo
					, "section" : response.section
					, "content_id" : response.contentId
					, "action" : response.action
					, "url" : response.baseUrl
					, "target_url" : response.targetUrl
					, "agent" : response.agent
					, "litd" : response.litd
					, "lttd" : response.lttd
					, "prclAddr" : response.prclAddr
					, "roadAddr" : response.roadAddr
					, "postNoNew" : response.postNoNew
					, "timestamp" : ""
			}
		});
	}

	// APP용 페이지 이동 Callback function
	function fnGoIndexOrderPayment(data){
		var obj = JSON.parse(data);
		createFormSubmit("indexOrderPaymentForm","/order/indexOrderPayment",obj);
	}
	
	//App일때 영상상세(onNewPage로 띄움)에서 좋아요, 찜 선택 또는 해제시 영상상세를 호출한 화면의 좋아요, 찜 숫자 변경되도록 하기위해 필요한 함수
	//영상상세에서 onCallMainScript 호출시 받는 callback 함수임.
	function appCallMainScript(data){
		var parseData = JSON.parse(data);
		var detailVdId = parseData.vdId; //영상ID
		var detailGb = parseData.intrGbCd; //구분코드(10=좋아요, 20=찜)
		
		if(detailGb == "10"){
			$.ajax({
				type: 'POST',
				url: '/tv/series/selectLikeCount',
				dataType: 'json',
				data : {
					vdId : detailVdId
					, intrGbCd : detailGb
				},
				success: function(data) {
					var likeCnt = data.likeCnt;
					//console.log("["+detailVdId+"]의 좋아요 건수=" + likeCnt);
					
					$("[data-read-like='"+detailVdId+"']").html(fnComma(likeCnt));
				},
				error: function(request,status,error) {
					ui.alert("오류가 발생되었습니다. 다시 시도하여 주십시오.");
				}
			});
			
			if($("[data-btn-like='"+detailVdId+"']").hasClass("on")){
				$("[data-btn-like='"+detailVdId+"']").removeClass("on");
			}else{
				$("[data-btn-like='"+detailVdId+"']").addClass("on");
			}
		}else if(detailGb == "20"){
			if($("[data-btn-bookmark='"+detailVdId+"']").hasClass("on")){
				$("[data-btn-bookmark='"+detailVdId+"']").removeClass("on");
			}else{
				$("[data-btn-bookmark='"+detailVdId+"']").addClass("on");
			}
		}
	}
	
	//Device 뒤로가기 버튼 기능을 웹에서 처리시 사용(Y:웹에서 백기능 처리, N:앱에서 처리)-호출 함수
	function fncDeviceBackWebUse(funcNm){
		tempFuncNm = funcNm; //호출할 함수명 셋팅
		
		toNativeData.func = "onBackSelected";
		toNativeData.isIntercepter = "Y";
		toNative(toNativeData);
	}
	
	//Device 뒤로가기 버튼 기능을 웹에서 처리시 사용(Y:웹에서 백기능 처리, N:앱에서 처리)-리턴함수
	function appBackSelected(){
		window[tempFuncNm](); //함수 호출
	}
</script>
<style type="text/css">
	/* 아이폰 계열에서 저장되는 것 막음 / css 에 추가 */
	img, video {
		/* 화면을 길게 누르고 있을때 뜨는 팝업이나 액션시트를 제어 */
		-webkit-touch-callout:none;
		/* 텍스트나 이미지를 선택할 수 있게 하는 여부를 제어 */
		/*-webkit-user-select:none;*/
		/* 링크를 터치했을때 나오는 기본 영역의 색상을 제어 */
		/*-webkit-tap-highlight-color:transparent;*/
	}
</style>

<script>
// 히스토리 관련 함수( 모바일 < 버튼을 위함 )
var storageHist = {
	isReady : true,
	histCnstn : "StorageHistory",		// storage 저장 상수
	isApp : ("${view.deviceGb}" == "APP")? true : false,
	cnvrtFullUrl : function(url) { 
		var fullUrl = url;
		if(url.indexOf('aboutpet.co.kr') < 0 && url.indexOf('localhost')  < 0 ){
			fullUrl = "${view.stDomain}"+((url.indexOf("/") != 0)?"/":"")+url;
		}			
		return fullUrl;
	},
	getHist : function() { 	// sessionStorage에 저장된 history 목록 확인
		var hist = sessionStorage.getItem(storageHist.StorageHistory);
		return (hist == null)?new Array():JSON.parse(hist);
	},
	setHist : function() {	//sessionStorage에 history 저장
		/* var sessionStorageCnt = 30; */
		var thisHistory = {
				url : window.location.href,
				histLength : window.history.length
			}
		var sessionHistory = storageHist.getHist();
		if(sessionHistory == null || sessionHistory.length == 0){				// 처음 셋팅
			var histArray = new Array();
			histArray.push(thisHistory);
			sessionStorage.setItem(storageHist.StorageHistory, JSON.stringify(histArray));
		}else{ 									// 추가
			if(sessionHistory[sessionHistory.length-1].histLength >= thisHistory.histLength){	// 브라우저 뒤로가기 고려하여 히스토리 조정(뒤로가기시 해당 페이지까지 히스토리 삭제)
				var theUrlIdx;
				sessionHistory.forEach(function(item, index, array) {
					if(item.url == thisHistory.url){
						theUrlIdx = index;
					}
				});
				if(theUrlIdx != null && theUrlIdx != undefined){
					var removeCnt = sessionHistory.length - theUrlIdx;
					sessionHistory.splice(theUrlIdx, removeCnt);
					sessionStorage.setItem(storageHist.StorageHistory, JSON.stringify(sessionHistory));
				}
			}
			
			if(sessionHistory[sessionHistory.length-1].url != thisHistory.url){
				sessionHistory.push(thisHistory);
				sessionStorage.setItem(storageHist.StorageHistory, JSON.stringify(sessionHistory));
			}
		}
	},
	replaceHist : function(url) {		// sessionStorage의 hisory 목록 replace또는 remove
		var sessionHistory = storageHist.getHist();
		sessionHistory.pop();	// remove
		if(url){				// url 추가
			var thisHistory = {
				url : storageHist.cnvrtFullUrl(url),
				histLength : window.history.length
			}
			sessionHistory.push(thisHistory);
		}
		sessionStorage.setItem(storageHist.StorageHistory, JSON.stringify(sessionHistory));
		return (sessionHistory.length == 0)?"/":sessionHistory[sessionHistory.length-1].url;
	},
	goHistoryBack : function(url){
		if(storageHist.isReady){
			storageHist.isReady = false;
			var fullUrl = storageHist.cnvrtFullUrl(url);
			storageHist.clearUp(fullUrl);
			history.back();
		}
	},
	goBack : function(url){ 		// 이전페이지 / 페이지 이동
	
		if(storageHist.isReady){
			storageHist.isReady = false;
			if(url){	// url로 이동(해당 url 이후 삭제)
				var fullUrl = storageHist.cnvrtFullUrl(url);
				storageHist.clearUp(fullUrl);
				location.href = fullUrl;
			}else{		// 이전페이지
				var lastUrl = storageHist.replaceHist();
				location.href = lastUrl;
			}
		}
	},
	getOut : function(url, firstUrl) {		// 진입페이지로 이동(url을 포함하지 않는 최근 목록으로 이동, firstUrl이 true경우 url을 벗어난 가장 상위 url로 이동)
		if(storageHist.isReady){
			storageHist.isReady = false;
			var lastUrl = storageHist.clearUp(url, true, firstUrl);
			location.href = lastUrl;
		}
	},
	clearUp : function(url, part, firstUrl) {					// 해당 url까지 히스토리 목록 삭제하기 (part가 true이면 해당 url포함 목록 삭제)
		var sessionHistory = storageHist.getHist();
		var theUrlIdx;
		var isFinding = true;
		if(part){		// url을 포함하고 있으면 삭제
			sessionHistory.forEach(function(item, index, array) {
				if(firstUrl){
					if(isFinding){
						if(item.url.indexOf(url) != -1 ){
							theUrlIdx = index;
							isFinding = false;
						}
					}
				}else{
					if(item.url.indexOf(url) == -1 ){
						theUrlIdx = index+1;
					}
				}
			});
		}else{			// 해당 url까지 삭제
			sessionHistory.forEach(function(item, index, array) {
				if(item.url == url){
					theUrlIdx = index+1;
				}
			});
		}
		
		if(theUrlIdx != null && theUrlIdx != undefined){
			var removeCnt = sessionHistory.length - theUrlIdx;
			sessionHistory.splice(theUrlIdx, removeCnt);
			sessionStorage.setItem(storageHist.StorageHistory, JSON.stringify(sessionHistory));
		}
		return (sessionHistory.length == 0)?"/":sessionHistory[sessionHistory.length-1].url;
	},
	clearHist : function() {			// history 전체 삭제
		sessionStorage.removeItem(storageHist.StorageHistory);
	},
	setPage : function() {
		var thisUrl = window.location.href;
		if(thisUrl.indexOf('?returnUrl=') == -1 && thisUrl.indexOf('&returnUrl=') == -1 && (thisUrl.indexOf('/tv/home')>0 ||thisUrl.indexOf('/log/home')>0 || thisUrl.indexOf('/shop/home')>0 || thisUrl.indexOf('/mypage/indexMyPage')>0)){  // history clear
			storageHist.clearHist();
			storageHist.setHist();
		}else{	// history 저장
			storageHist.setHist();
		}
	}
}

// Native App에서 referrer 를 주지 않고 있어서 js로 처리함.
var storageReferrer = {
	set : function() {
		sessionStorage.setItem('storageReferrer', sessionStorage.getItem('storageCurrent'));
		sessionStorage.setItem('storageCurrent', window.location.href);
	},
	get : function() {
		return sessionStorage.getItem('storageReferrer');
	}
}

// sessionStorage 저장 호출 / 메인은 clear

var isOnpageshow = false;
window.onpageshow = function (event) {
	if (event.persisted) {
		storageHist.setPage();
		isOnpageshow = true;
		storageHist.isReady = true;
	}
}
if(!isOnpageshow){
	storageHist.setPage();
	storageHist.isReady = true;
}
//console.log("storageHist",storageHist.getHist());
</script>