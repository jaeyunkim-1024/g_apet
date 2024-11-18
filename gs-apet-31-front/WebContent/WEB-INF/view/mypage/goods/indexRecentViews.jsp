<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<tiles:insertDefinition name="mypage">
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">
			$(document).ready(function(){
				$("#header_pc").removeClass("mode0");
				$("#header_pc").addClass("mode16");
				$("#header_pc").addClass("noneAc");
				$("#header_pc").attr("data-header", "set22");
				$(".mo-heade-tit .tit").html("<spring:message code='front.web.view.goods.title.recently.viewed.products' />");
				
				if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10}"){
					$("footer").remove();
				}
				var listGb = "${so.listGb}";
				$(".mo-header-backNtn").attr("onclick");
				$(".mo-header-backNtn").bind("click", function(){
					storageHist.goBack("/mypage/indexMyPage/");
				});
			});
			
			function fnDeleteGoodsRecent(obj, goodsId){
				
				if($(obj).data('content') === ""){
					ui.toast("<spring:message code='front.web.view.goods.toast.notavailable.delete.products' />");
				}else{
					var mbrNo = "${session.mbrNo}";
					var thisGoodsId = $(obj).data('content');
					// DB 삭제
					var options = {
						url : "/mypage/deleteRecentGoods",
						data : { goodsId : thisGoodsId },
						done : function(data) {
							if(data.resultCnt > 0){
								//최근 본 상품 삭제 엑션로그 추가
								$.ajax({
									type: 'POST'
									, url : "/common/sendSearchEngineEvent"
									, dataType: 'json'
									, data : {
										"logGb" : "ACTION"
										, "mbr_no" : mbrNo
										, "section" : "shop" 
										, "content_id" : goodsId
										, "action" : "delete"
										, "url" : document.location.href
										, "targetUrl" : document.location.href
										, "litd" : ""
										, "lttd" : ""
										, "prclAddr" : ""
										, "roadAddr" : ""
										, "postNoNew" : ""
										, "timestamp" : ""
									}
								});

							}
						}
					};
					if (mbrNo != "${frontConstants.NO_MEMBER_NO}") {
						ajax.call(options);	
					}
					
					// 쿠키 삭제
					var recentCookie = $.cookie("<spring:eval expression="@bizConfig['envmt.gb']" />${frontConstants.COOKIE_RECENT_GOODS}");
				    var recentList = new Array();
					if(recentCookie != "" && recentCookie != undefined ){	// 쿠키 있는 경우 
						recentList = JSON.parse(recentCookie);
						// 동일 goodsId 삭제 / 오래된 것 삭제
						for( var i=recentList.length -1 ; i >= 0 ; i--){
							if(recentList[i].goodsId == thisGoodsId ){  //동일 goodsId 및 24시간 이상
								recentList.splice(i, 1);
							}
						}
					}
					$.cookie("<spring:eval expression="@bizConfig['envmt.gb']" />${frontConstants.COOKIE_RECENT_GOODS}", JSON.stringify(recentList), {expires: 1, path: '/'});
					
					// UI
					$(obj).parents('.item').remove();
					ui.toast("<spring:message code='front.web.view.goods.toast.deleted.recent.viewed.products' />");
					
					if($(".lately-goods .item").length < 1){
						$("#noneBoxPoint").show();
					}
				}
			}
			function userActionLog(contId, action, url, targetUrl){	
				var mbrNo = "${session.mbrNo}";
				if (mbrNo != "${frontConstants.NO_MEMBER_NO}") {
					$.ajax({
						type: 'POST'
						, url : "/common/sendSearchEngineEvent"
						, dataType: 'json'
						, data : {
							"logGb" : "ACTION"
							, "mbr_no" : mbrNo
							, "section" : "shop" 
							, "content_id" : contId
							, "action" : action
							, "url" : (url != null && url) != '' ? url : document.location.href
							, "targetUrl" : (targetUrl != null && targetUrl != '') ? targetUrl : document.location.href
							, "litd" : ""
							, "lttd" : ""
							, "prclAddr" : ""
							, "roadAddr" : ""
							, "postNoNew" : ""
							, "timestamp" : ""
						}
					});
				}
			}
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<main class="container lnb page 1dep 2dep" id="container">
			<div class="inr">
				<div class="contents" id="contents">
						<!-- PC 타이틀 모바일에서 제거  -->
						<div class="pc-tit">
							<h2><spring:message code='front.web.view.goods.title.recently.viewed.products' /></h2>
						</div>
						<!-- // PC 타이틀 모바일에서 제거  -->


						<!-- 컨텐츠가 없을 경우 style 제거 -->
						<!-- 03.17 수정 -->
						<section id="noneBoxPoint" class="no_data i5" style="${fn:length(goodsDtlHistList) < 1 ? '' :
						'display:none'}">
							<div class="inr">
								<div class="msg">
									<spring:message code='front.web.view.goods.comment.no.recent.viewed.products.recommand.to.look.products' />
								</div>
								<div class="uimoreview">
									<a href="/shop/home" class="bt more"><spring:message code='front.web.view.common.link.go.to.petshop' /></a>   <!-- APET-1250 210728 kjh02  -->
								</div>
							</div>
						</section>
						<!-- // 03.17 수정 -->
						<!-- 컨텐츠가 없을 경우 style 제거 -->

						<!-- 최근 본 상품 -->
						<div class="lately-goods">
							<c:forEach var="goods" items="${goodsDtlHistList}">
								<div class="item">
									<div class="pic">
										<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="pic">
											<!-- 직사각형을 정사각형으로 변경함. frontConstants.IMG_OPT_QRY_30 >>>> frontConstants.IMG_OPT_QRY_758 -->
											<img class="img" src="${frame:optImagePath( goods.imgPath, frontConstants.IMG_OPT_QRY_758)}" onerror="this.src='../../_images/_temp/goods_1.jpg'" alt="<spring:message code='front.web.view.common.msg.image' />">
											<c:choose>
												<c:when test="${goods.salePsbCd == frontConstants.SALE_PSB_20}">
													<div class="soldouts"><em class="ts">판매종료</em></div>
												</c:when>
												<c:when test="${goods.salePsbCd == frontConstants.SALE_PSB_10}">
													<div class="soldouts"><em class="ts">판매중지</em></div>
												</c:when>
												<c:when test="${goods.salePsbCd == frontConstants.SALE_PSB_30}">
													<div class="soldouts"><em class="ts"><spring:message code='front.web.view.common.goods.saleSoldOut.title'/></em></div>
												</c:when>
											</c:choose>
										</a>
										<button type="button" class="bt zzim ${goods.interestYn eq 'Y' ? 'on' : ''}"
											data-content='${goods.goodsId}' data-url="/goods/insertWish?goodsId=${goods.goodsId}"
											data-goods-id="${goods.goodsId}" data-target="goods" data-action="interest" data-yn="N"
											><spring:message code='front.web.view.brand.button.wishBrand' />
										</button>
									</div>
									<div class="text-box">
										<p class="t1">
											<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="lk">${goods.goodsNm}</a>
										</p>
										<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="inf">
											<span class="prc"><em class="p"><fmt:formatNumber value="${goods.saleAmt }" type="number" pattern="#,###,###"/></em><i class="w"><spring:message code='front.web.view.common.moneyUnit.title' /></i></span>
											<c:if test="${goods.orgSaleAmt > goods.saleAmt and ((goods.orgSaleAmt - goods.saleAmt)/goods.orgSaleAmt * 100) > 1 }">
												<span class="pct"><em class="n"><fmt:formatNumber value="${(goods.orgSaleAmt-goods.saleAmt)/goods.orgSaleAmt * 100}" type="percent" pattern="#,###,###"/></em><i class="w">%</i></span>
											</c:if>
										</a>
										<a href="javascript:" onclick="fnDeleteGoodsRecent(this, '${goods.goodsId}');"
											data-content="${goods.goodsId}" data-url="/mypage/deleteRecentViewGoods"
											class="btn close" ><spring:message code='front.web.view.goods.delete.btn' /></a>
									</div>
								</div>
							</c:forEach>
						</div>
						<!-- // 최근 본 상품  -->
					</div>
				</div>	
			</main>
			<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}" >
				<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
		        	<jsp:param name="floating" value="talk" />
		        </jsp:include>
	        </c:if>
	</tiles:putAttribute>
</tiles:insertDefinition>
