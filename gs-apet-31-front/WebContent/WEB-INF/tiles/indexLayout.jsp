<%--	
 - Class Name	: /tiles/b2c/indexLayout.jsp
 - Description	: B2C common Layout View
 - Since		: 2020.12.18
 - Author		: KKB
--%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<tiles:insertAttribute name="meta" />
<spring:eval var="envmtGbLO" expression="@bizConfig['envmt.gb']" />
<c:if test="${ envmtGbLO == 'prd' }"> 
<!-- Google Tag Manager -->
<!-- For Analysis Container -->
<script>
(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-NKC9BFM');
</script>

<!-- For Campaign Container -->
<script>
(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-M82SBBJ');
</script>
<!-- End Google Tag Manager -->

<script>
var digitalData = digitalData || {};
var ckLoginId = $.cookie("loginId");
digitalData.userInfo = {
  "loginStatus": (ckLoginId == '' || ckLoginId == undefined)? '' : "Logged In",
  "userId": (ckLoginId == '' || ckLoginId == undefined)? '' : ckLoginId  
};
</script>
</c:if>

<tiles:insertAttribute name="script.include" ignore="true"/>
<tiles:insertAttribute name="script.inline" ignore="true"/>
<jsp:include page="/WEB-INF/tiles/include/appDownPop.jsp"/>
<jsp:include page="/WEB-INF/tiles/include/popLayerEvent.jsp"/>
</head>

<body class="body">
<c:if test="${ envmtGbLO == 'prd' }"> 
<!-- Google Tag Manager (noscript) -->
<!-- For Analysis Container -->
<noscript>
<iframe src="//www.googletagmanager.com/ns.html?id=GTM-NKC9BFM"
height="0" width="0" style="display:none;visibility:hidden"></iframe>
</noscript>

<!-- For Campaign Container -->
<noscript>
<iframe src="//www.googletagmanager.com/ns.html?id=GTM-M82SBBJ"
height="0" width="0" style="display:none;visibility:hidden"></iframe>
</noscript>
<!-- End Google Tag Manager (noscript) -->
</c:if>

<tiles:importAttribute name="definitionNm" />
	<!-- 기본 컨텐츠 -->
	<div class="wrap" id="wrap">
		<input type="hidden" id="viewJsonData" value="${view.jsonData }">
		
		<c:if test="${definitionNm eq 'common' || definitionNm eq 'header_pc' || definitionNm eq 'noheader_mo' || definitionNm eq 'common_my_mo' || definitionNm eq 'mypage' || definitionNm eq 'header_only' || definitionNm eq 'no_lnb' || definitionNm eq 'mypage_mo_nofooter' || definitionNm eq 'mypage_mo_nomenubar' }">
			<c:choose>
				<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
					<!-- s : header 영역 -->
					<tiles:insertAttribute name="header" />
					<!-- e : header 영역 -->
					<!-- s : gnb 영역 -->
					<tiles:insertAttribute name="gnb" />
					<!-- e : gnb 영역 -->			
					<!-- s : LNB 영역 -->
					<c:if test="${definitionNm eq 'common' && view.seoSvcGbCd eq frontConstants.SEO_SVC_GB_CD_10 || definitionNm eq 'mypage' || definitionNm eq 'mypage_mo_nofooter' || definitionNm eq 'mypage_mo_nomenubar' }">
						<tiles:insertAttribute name="lnb" />
					</c:if>
					<!-- e : LNB 영역 -->
				</c:when>
				<c:otherwise>
					<c:if test="${definitionNm ne 'header_pc' }">
						<c:if test="${view.twcUserAgent eq false }">
							<!-- s : header 영역 -->
							<tiles:insertAttribute name="header" />
							<!-- e : header 영역 -->
						</c:if>
						<!-- s : gnb 영역 -->
						<tiles:insertAttribute name="gnb" />
						<!-- e : gnb 영역 -->
					</c:if>
				</c:otherwise>
			</c:choose>
		</c:if>
						
		<!-- s : 검색 영역 -->
<%-- 		<tiles:insertAttribute name="search" /> --%>
		<!-- e : 검색 영역 -->
				
		<!-- s : 본문영역 -->			
		<tiles:insertAttribute name="content" /> <!-- location 영역 포함  -->			
		<!-- e : 본문영역 -->
				
		<!-- s : layerPop 영역 -->
		<tiles:insertAttribute name="layerPop" />
		<!-- e : layerPop 영역 -->
		
		<!-- s : menubar 영역 -->
		<c:if test="${definitionNm eq 'common' || definitionNm eq 'common_my_mo' || definitionNm eq 'mypage' || definitionNm eq 'no_lnb' || definitionNm eq 'mypage_mo_nofooter' }">
			<tiles:insertAttribute name="menubar"/>
		</c:if>
		<!-- e : menubar 영역 -->
		
		<!-- s : footer 영역 -->
		<c:choose>
			<c:when test="${definitionNm eq 'common' || definitionNm eq 'mypage' || definitionNm eq 'no_lnb' }">
				<tiles:insertAttribute name="footer"/>
			</c:when>
			<c:when test="${definitionNm eq 'noheader_mo' || definitionNm eq 'common_my_mo' || definitionNm eq 'mypage_mo_nofooter' || definitionNm eq 'mypage_mo_nomenubar' }">				
				<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
					<tiles:insertAttribute name="footer"/>
				</c:if>
			</c:when>
		</c:choose>
		<!-- e : footer 영역 -->
	</div>
</body>
</html>