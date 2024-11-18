<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.include" value="script.petshop"/>
	<tiles:putAttribute name="script.inline">
	<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">	
	<script type="text/javascript">
		$(document).ready(function(){
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
	<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">	
	<script type="text/javascript">
		function changeDispClsfNo(dispClsfNo){
			if('${frontConstants.PETSHOP_DOG_DISP_CLSF_NO}' == dispClsfNo ) {			// 강아지
				dispClsfNo = '${frontConstants.PETSHOP_MAIN_DOG_DISP_CLSF_NO}'
			} else if('${frontConstants.PETSHOP_CAT_DISP_CLSF_NO}' == dispClsfNo ) {	// 고양이
				dispClsfNo = '${frontConstants.PETSHOP_MAIN_CAT_DISP_CLSF_NO}'
			} else if('${frontConstants.PETSHOP_FISH_DISP_CLSF_NO}' == dispClsfNo ) {	// 관상어
				dispClsfNo = '${frontConstants.PETSHOP_MAIN_FISH_DISP_CLSF_NO}'
			} else if('${frontConstants.PETSHOP_ANIMAL_DISP_CLSF_NO}' == dispClsfNo ) {	// 소동물
				dispClsfNo = '${frontConstants.PETSHOP_MAIN_ANIMAL_DISP_CLSF_NO}'
			}
			
			 var form = document.createElement("form");
			 document.body.appendChild(form);
			 var url = "/shop/home/";
			 form.setAttribute("method", "POST");
			 form.setAttribute("action", url);
			
			 var hiddenField = document.createElement("input");
			 hiddenField.setAttribute("type", "hidden");
			 hiddenField.setAttribute("name", "lnbDispClsfNo");
			 hiddenField.setAttribute("value", dispClsfNo);
			 form.appendChild(hiddenField);
			 document.body.appendChild(form);
			 form.submit();
		}
	</script>
	</c:if>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<main class="container lnb page shop live mn" id="container">
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
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
					<nav class="location" style="display:none;">
						<ul class="loc">
							<li>
								<a href="javascript:;" class="bt st"><spring:message code='front.web.view.common.title.dog' /></a>
								<ul class="menu">
									<c:forEach items="${view.displayCategoryList}" var="category">
										<c:if test="${category.level eq 1}">
											<li class="${category.dispClsfNo eq so.cateCdL ? 'active' : ''}">
												<a class="bt" href="javascript:changeDispClsfNo('${category.dispClsfNo}');">${category.pathNm}</a>
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</li>
							<li>
								<a href="javascript:;" class="bt st"><spring:message code='front.web.view.common.title.exhibition' /></a>
								<ul class="menu" id="exhbNmMenu">
									<c:forEach items="${view.displayShortCutList}" var="detail">
										<li class="${fn:indexOf(detail.bnrLinkUrl, '/shop/indexLive') > -1 ? 'active' : ''}">
											<a class="bt" href="javascript:void(0);" onclick="goLink('${view.deviceGb eq 'PC' ? detail.bnrLinkUrl :detail.bnrMobileLinkUrl}')">
												${detail.bnrText}
											</a>
										</li>
									</c:forEach>
								</ul>
							</li>
						</ul>
						<!-- ui.gnb.location.set(); -->
					</nav>
					<!--라이브커머스 삽입 JS -->
					<div id="live_app"></div>

					<script>

						(function() {
							var ul = '<spring:eval expression="@bizConfig['aboutpet.sgr.live.url']" />';  //개발계 URL , 검증계 https://stgsgrlive.aboutpet.co.kr , 운영계 https://sgrlive.aboutpet.co.kr
							var w = window;
							if (w.Live24IO) {
								return (window.console.error || window.console.log || function(){})('Live24IO script included twice.');
							}
							var l24 = function() {
								l24.c(arguments);
							};
							l24.q = [];
							l24.c = function(args) {
								l24.q.push(args);
							};
							w.Live24IO = l24;
							function l() {
								if (w.Live24Initialized) {
									return;
								}
								w.Live24Initialized = true;
								var s = document.createElement('script');
								s.type = 'text/javascript';
								s.async = true;
								s.src = ul+'/web/v1/index.js';
								s.charset = 'UTF-8';
								var x = document.getElementsByTagName('script')[0];
								x.parentNode.insertBefore(s, x);
								var s = document.createElement('link');
								s.rel = 'stylesheet';
								s.href = ul+'/web/css/v1.css';
								var x = document.getElementsByTagName('link')[0];
								x.parentNode.insertBefore(s, x);
							}
							if (document.readyState === 'complete') {
								l();
							} else if (window.attachEvent) {
								window.attachEvent('onload', l);
							} else {
								window.addEventListener('DOMContentLoaded', l, false);
								window.addEventListener('load', l, false);
							}
						})();

						Live24IO('boot', {
							"site_key": "7144413e544bb0e5f2b58a385f338ca9", //사이트키 고정값 (필수)
							"ui_mode": "${view.deviceGb eq frontConstants.DEVICE_GB_10 ? 'PC' : 'MO'}", //UI 모드 (PC , MO)  (필수)
							"user_id": "${session.mbrNo eq frontConstants.NO_MEMBER_NO ? '' : session.loginId}", //로그인 회원 아이디 , 로그인 상태에서만 입력
							"user_seq": "${session.mbrNo eq frontConstants.NO_MEMBER_NO ? '' : session.mbrNo}", //유저 번호 , 로그인 상태에서만 입력
							"user_nickname": "${session.mbrNo eq frontConstants.NO_MEMBER_NO ? '' : session.nickNm}", //유저 닉네임 , 로그인 상태에서만 입력
							"user_profile_image": "${session.mbrNo eq frontConstants.NO_MEMBER_NO ? '' : session.prflImg}" //유저 프로필 , 로그인 상태에서만 입력
						});
					</script>

					<!-- 라이브커머스 삽입 JS-->
				</div>
			</div>
			<button id="liveGoodsBtn" style="display:none"></button>
		</main>

		<script>

			/**
			 * 연관 상품 화면 상품 아이디 받아오기
			 * @param goodsArr
			 */
			//callRelatedGoods([]);
			function callRelatedGoods(goodsArr) {
				var btn = $('#liveGoodsBtn');

				//goodsArr = ['GA250479724','GI000054497','GA250479724', 'GI250479786', 'GI250479831', 'GI250479838', 'GP250479845', 'GO250479846', 'GP250479852'];
				//goodsArr = ['GI000001181'];
				getRelatedGoodsWithLive(btn, goodsArr, "N");
			}

			/**
			 * 상품 상세
			 * @param goodsId
			 */
			function goGoodsDetail(goodsId) {
				openProductDetailPIP('/goods/liveGoodsDetail?goodsId='+goodsId);
			}

		</script>
		<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
			<jsp:param name="floating" value="" />
		</jsp:include>
	</tiles:putAttribute>
</tiles:insertDefinition>