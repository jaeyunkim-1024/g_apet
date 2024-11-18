<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">
			var isApp = "${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}" || "${view.deviceGb}" == "${frontConstants.DEVICE_GB_20}";
			if(isApp){
				$(document).ready(function(){
					if("${not empty view.displayShortCutList}" == 'true') {
						/* 탭이동 종료 후 이벤트 */
						var idx = $("li[name=shortCut][class~=active]").data("shortcutidx");
						if(idx != 'undefined') {
							ui.disp.subnav.elSwiper.el.slideTo(idx-1);
						};
					}
				
					$(window).bind("pageshow", function(event){
						if(event.originalEvent.persisted || window.performance && window.performance.navigation.type == 2){
							var state = window.history.state;
							if(state) {
								$("#contents").html(state.data);
								ui.disp.sld.cate.using();
								ui.disp.sld.plans.using();
							}else {
								window.history.replaceState(null, null, null);
								exhbList();
							}
						}else{
							window.history.replaceState(null, null, null);
						}
					});
				});
			}

			function exhbList(dispNo){
				var dispClsfNo;
				if(dispNo == undefined){
					dispClsfNo = "${so.cateCdL}";
				}else{
					dispClsfNo = dispNo;
				}
				
				var options = {
					url : "<spring:url value='/event/exhibitionZoneList' />"
					, type : "POST"
					, dataType : "html"
					, data : {
						dispClsfNo : dispClsfNo
					}
					, done : function(result){
						$("#exhbSection").empty();
						$("#exhbSection").append(result);
						ui.disp.sld.plans.using();
						
						//뒤로가기
						var params = new URLSearchParams(location.search);
						var searchParams = params.toString();
						var goUrl = window.location.pathname + "?"+searchParams;
						window.history.replaceState( {data : $("#contents").html()}, null, goUrl);
					}
				};
				ajax.call(options);
			}

			function goodsDetail(exhbNo){
				var dispClsfNo ='${view.dispClsfNo}';
				var url = "/event/indexExhibitionDetail?exhbtNo="+exhbNo+"&dispClsfNo="+dispClsfNo;
				location.href = url;
			}

			function tagDetail(tagNm, tagNo){
				var url = "/shop/indexPetShopTagGoods?tagNm="+tagNm+"&tags="+tagNo;
				location.href = url;
			}
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
	<main class="container lnb page shop dm plans" id="container">
		<div class="pageHeadPc lnb">
			<div class="inr">
				<div class="hdt">
					<h3 class="tit"><spring:message code='front.web.view.common.title.exhibition' /></h3>
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
				<nav class="smain_cate_sld">
					<div class="swiper-container slide">
						<ul class="uiTab f swiper-wrapper list">
							<li class="swiper-slide active">
								<button type="button" class="btn" data-ui-tab-btn="tab_bests" onclick="exhbList(${so.cateCdL});"><spring:message code='front.web.view.brand.category.list.title'/></button>
							</li>
							<c:forEach items="${category}" var="category" varStatus="status">
								<li class="swiper-slide">
									<button type="button" class="btn" data-ui-tab-btn="tab_bests" onclick="exhbList(${category.dispClsfNo});">${category.dispClsfNm}</button>
								</li>
							</c:forEach>
						</ul>
					</div>
				</nav>
				<section id="exhbSection">
					<jsp:include page="/WEB-INF/view/event/include/exhibitionZoneList.jsp" />
				</section>
			</div>
		</div>
	</main>
	
	<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
		<jsp:param name="floating" value=""  />
	</jsp:include>
	
	</tiles:putAttribute>
</tiles:insertDefinition>