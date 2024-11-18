<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<tiles:insertDefinition name="default">
	<tiles:putAttribute name="script.inline">
	
	<script type="text/javascript">
		var referrer = ""; 
		var appSettingData = "";
		
		$(document).ready(function(){
			$(".menubar").remove();
			
			// 이전 url
			referrer = document.referrer.replace(/^[^:]+:\/\/[^/]+/, '').replace(/#.*/, '');
			
			$("#infoRcvYn").bind("change", function(){ 
				var infoRcvYn = $("#settingArea #infoRcvYn").is(":checked") == true ? "Y" : "N";
				updateInfoRcyYn(infoRcvYn);
				if(infoRcvYn == "Y") {
					onPushActivation();
				}
			});
		
			onSettingInfos();

			checkAppVersion();
		})
		
		// 앱 버전 체크
		function checkAppVersion() {
			var mobileOs = "";
			if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}" && "${view.os}" != "${frontConstants.DEVICE_TYPE_10}") {
				mobileOs = "${frontConstants.MOBILE_OS_GB_I}";
			} else {
				mobileOs = "${frontConstants.MOBILE_OS_GB_A}";
			}
			
			var options = {
					url : "<spring:url value='/common/checkAppVersion' />"
					, data : { mobileOs : mobileOs }
					, done : function(result) {
						var result = result.versionInfo;
						
						if(result.appVer > appSettingData.appVersion) {
							$("#latestArea").hide();
							$("#updateArea").show();
							$("#updateArea").attr("href", result.updateUrl).attr("data-content", "").attr("data-url", result.updateUrl);
						} else {
							$("#latestArea").show();
							$("#updateArea").hide();
						}
					}
			}
			ajax.call(options);
		}

		//앱 설정정보 조회
		function onSettingInfos() {
			toNativeData.func = "onSettingInfos";
			toNativeData.callback = "appSettingInfosCallBack";
			toNative(toNativeData);	
		}
	
		function appSettingInfosCallBack(result){
			appSettingData = JSON.parse(result);
			var mainPage = appSettingData.mainPage;
			var mainPageNm = "";
			
			 // APET-1250 210728 kjh02 
			if(mainPage == "TV")		mainPageNm = "<spring:message code='front.web.view.new.menu.tv'/>";
			else if(mainPage == "LOG")	mainPageNm = "<spring:message code='front.web.view.new.menu.log'/>"; 
			else if(mainPage == "SHOP")	mainPageNm = "<spring:message code='front.web.view.new.menu.store'/>"; 
			
			$("#mainPageNm").text(mainPageNm);
			$("#version").text("V" + appSettingData.appVersion);
		}
				
		function logout() {
			ui.confirm("<spring:message code='front.web.view.index.login.settings.msg.logout'/>",{ 
			    ycb:function(){
			    	location.href = "/logout?returnUrl=/indexLoginSettings";
			    },
			    ncb:function(){
			    },
			    ybt:'확인',
			    nbt:'취소'
			});
		}
		
		function onPushActivation() {
			toNativeData.func = "onPushActivation";
			toNativeData.isLive = "N";
			toNative(toNativeData);	
		}
		
		function goBack() {
			storageHist.goBack();
// 			if(storageReferrer.get().indexOf('/shop/indexCategory') > -1
// 				|| storageReferrer.get().indexOf('/shop/indexBestGoodsList') > -1
// 				|| storageReferrer.get().indexOf('/shop/indexNewCategory') > -1
// 				|| storageReferrer.get().indexOf('/event/indexExhibitionZone') > -1
// 				|| storageReferrer.get().indexOf('/commonSearch') > -1){
// 				storageHist.goHistoryBack(storageReferrer.get());
// 			}else{
// 				storageHist.goBack();
// 			}
		}
	</script>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<!-- mobile -->
		<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
			<header class="header pc cu mode7 logHeaderAc" data-header="set9">
				<div class="hdr">
					<div class="inr">
						<div class="hdt">
							<button class="mo-header-backNtn" onclick="goBack();" data-content="" data-url="goBack();"><spring:message code='front.web.view.common.msg.back'/></button>
							<div class="mo-heade-tit"><span class="tit"><b class=e><spring:message code='front.web.view.common.msg.setting'/></b></span></div>
						</div>
					</div>
				</div>
			</header>
		</c:if>
		<!-- // mobile -->
		
		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container page sett" id="container">

			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">

					<!-- PC 타이틀 모바일에서 제거  -->
					<div class="pc-tit">
						<h2><spring:message code='front.web.view.login.popup.title'/></h2>
					</div>
					<!-- // PC 타이틀 모바일에서 제거  -->
					
					<!-- 설정 컨텐츠 영역 -->
					<div id="settingArea" class="setlist">
						<dl>
							<dt class="mb0"><spring:message code='front.web.view.login.popup.title'/></dt><!-- 2021.04.08 클래스 mb0 추가 -->
							<dd>
								<c:choose>
									<c:when test="${empty session.loginId }">
										<ul>
											<li class="ti"><spring:message code='front.web.view.index.login.settings.msg.request.login'/></li>
											<li class="r"><a href="/indexLogin?returnUrl=/indexLoginSettings" class="btn sm" data-content="" data-url="/indexLogin?returnUrl=/indexLoginSettings"><spring:message code='front.web.view.login.popup.title'/></a></li>
										</ul>
									</c:when>
									<c:otherwise>
										<div class="link">
											<a href="/indexMyInfo?returnUrl=/indexLoginSettings" data-content="" data-url="/indexMyInfo?returnUrl=/indexLoginSettings">
												<span class="ti">
													${session.loginId }
													<span class="nickname">${session.nickNm }</span><!-- 2021.04.08 클래스 HTML 추가 -->
												</span>
												<span class="r next"></span>
											</a>
										</div>
									</c:otherwise>
								</c:choose>
							</dd>
						</dl>
						<c:if test="${not empty session.loginId }">
							<dl>
								<dt><spring:message code='front.web.view.index.login.settings.msg.main.setting.title'/></dt>
								<dd>
									<ul onclick="location.href='/setting/indexSettingMain'">
										<li class="ti"><spring:message code='front.web.view.index.login.settings.msg.main.setting.service'/></li>
										<li class="r">
											<em id="mainPageNm" class="strong"></em>
											<a href="/setting/indexSettingMain" class="next" data-content="" data-url="/setting/indexSettingMain"></a>
										</li>
									</ul>
								</dd>
							</dl>
							<dl>
								<dt><spring:message code='front.web.view.index.login.settings.msg.set.notice'/></dt>
								<dd>
									<ul>
										<li class="ti"><spring:message code='front.web.view.index.login.settings.msg.set.app.push'/></li>
										<li class="r">
											<!-- TODO 조은지 : 세션의 정보수신동의여부에 따라 checked   -->
											<div class="uiChk"><input id="infoRcvYn" name="infoRcvYn" type="checkbox" <c:if test="${empty session.loginId or session.infoRcvYn eq 'Y'}">checked</c:if>><em></em></div>
										</li>
									</ul>
									<!-- <ul>
										<li class="ti">이벤트성 알림 동의</li>
										<li class="r">
											<div class="uiChk"><input type="checkbox" checked=""><em></em></div>
										</li>
									</ul> -->
								</dd>
							</dl>
						</c:if> 
						<dl>
							<dt><spring:message code='front.web.view.index.login.settings.msg.set.videoplayer'/></dt>
							<dd>
								<ul onclick="location.href='/setting/indexSettingAutoPlay'">
									<li class="ti"><spring:message code='front.web.view.index.login.settings.msg.set.autoplay'/></li>
									<li class="r">
										<a href="/setting/indexSettingAutoPlay" class="next" data-content="" data-url="/setting/indexSettingAutoPlay"></a>
									</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt><spring:message code='front.web.view.common.terms.and.conditions'/></dt>
							<dd>
								<ul onclick="location.href='/indexSettingTerms'">
									<li class="ti"><spring:message code='front.web.view.common.terms.and.conditions.for.service'/></li>
									<li class="r">
										<a href="/indexSettingTerms" class="next"></a>
									</li>
								</ul>
								<!-- <ul>
									<li class="ti">개인정보 취급방침</li>
									<li class="r">
										<a href="#" onclick="openTerms('${frontConstants.TERMS_GB_ABP_MEM_PRIVACY}');return false;" class="next"></a>
									</li>
								</ul>
								<ul>
									<li class="ti">위치정보 동의</li>
									<li class="r">
										<a href="#" onclick="openTerms('${frontConstants.TERMS_GB_ABP_MEM_LOCATION_INFO}');return false;" class="next"></a>
									</li>
								</ul> -->
							</dd>
						</dl>
						<dl>
							<dt><spring:message code='front.web.view.index.login.settings.msg.version.info'/></dt>
							<dd>
								<ul>
									<li class="ti"><spring:message code='front.web.view.index.login.settings.msg.version.current'/> <i id="version"></i></li>
									<li class="r">
										<em id="latestArea"><spring:message code='front.web.view.index.login.settings.msg.version.notice.recent'/></em>
										<a id="updateArea" class="btn sm"><spring:message code='front.web.view.index.login.settings.msg.update'/></a>
									</li>
								</ul>
							</dd>
						</dl>
					</div>
					<!-- // 설정 컨텐츠 영역 -->
				</div>
			</div>
		</main>
		<jsp:include  page="/WEB-INF/tiles/include/menubar.jsp" />
	</tiles:putAttribute>
</tiles:insertDefinition>
