<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.include" value="script.petshop"/>
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">
			$(document).ready(function(){
				<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">	
				$("#header_pc").addClass('noneAc');
				$(".mo-heade-tit .tit").html("자주 구매한 상품");	
				$(".mo-header-backNtn").attr("onClick", "goPetShopMain();");
				</c:if>
				// 정렬
				$("li[id^=order_] button").click(function(){
					getSortGoodsList($(this).val());
			    });
			});	
			
			function getSortGoodsList(order){
				var options = {
					url : "<spring:url value='/shop/getSortGoodsList' />"
					, type : "POST"
					, dataType : "html"
					, data : {
						dispClsfNo : '${view.dispClsfNo}',
						dispCornNo : $("#dispCornNo_offen").val(),
						dispClsfCornNo : $("#dispClsfCornNo_offen").val(),
						order: order,
						searchMonth: order,
					}
					, done :function(result){
						$("#orderGoodsList").empty();
						$("#orderGoodsList").append(result);
					}
				};
				ajax.call(options);
			}
			
			// 베스트 상품 초기 상품 셋팅
			function insertCart(goodsId, itemNo, ordmkiYn) {
				if(ordmkiYn != 'Y') {
					var goodsInfo = goodsId+":"+itemNo+":";
					commonFunc.insertCart(goodsInfo, '1', 'N');
				}else {
					ui.confirm("<spring:message code='front.web.view.order.cart.custom.product.go.detail' />",{ // 컨펌 창 옵션들
					    ycb:function(){
					    	location.href="/goods/indexGoodsDetail?goodsId="+goodsId;
					    },
					    ncb:function(){
					    },
					    ybt:"예", // 기본값 "확인"
					    nbt:"아니오"  // 기본값 "취소"
					});
				}
			}
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
	<main class="container lnb page shop hm often" id="container">
		<!-- 자주구매 -->
		<input type="hidden" id="dispCornType_offen" value="${frontConstants.GOODS_MAIN_DISP_TYPE_OFFEN}"/>
			<input type="hidden" id="dispCornNo_offen" value="${param.dispCornNo}"/>
		<input type="hidden" id="dispClsfCornNo_offen" value="${cornerList.offenGoodsList[0].dispClsfCornNo}"/>
		<div class="pageHeadPc lnb">
			<div class="inr">
				<div class="hdt">
					<h3 class="tit">자주 구매한 상품</h3>
				</div>
			</div>
		</div>
		<div class="inr">
			<!-- 본문 -->
			<div class="contents" id="contents">
				<section class="sect ct often">
					<div class="uioptsorts often mt04">
						<div class="dx lt">
							<div class="tot">총 <em class="n" id="totalCount">${not empty cornerList.goodsCount ? cornerList.goodsCount : 0}</em>개 상품</div>
						</div>
						<div class="dx rt">
							<nav class="uisort">
								<button type="button" class="bt st" value="v_1">최근1년</button>
								<div class="list">
									<ul class="menu">
										<li class="active" id="order_12"><button type="button" class="bt" value="12">최근1년</button></li>
										<li id="order_6"><button type="button" class="bt" value="6">최근6개월</button></li>
										<li id="order_3"><button type="button" class="bt" value="3">최근3개월</button></li>
									</ul>
								</div>
							</nav>
						</div>
					</div>
					<c:if test="${not empty cornerList.offenGoodsList}">
						<ul class="list" id="orderGoodsList">
							<c:forEach var="goods" items="${cornerList.offenGoodsList}"  varStatus="status" >
							<c:if test="${(goods.salePsbCd ne frontConstants.SALE_PSB_30) || (goods.salePsbCd eq frontConstants.SALE_PSB_30 && goods.ostkGoodsShowYn eq 'Y')}">
							<li>
								<div class="gdset oftct">
								<div class="num">${goods.ordQty}회구매</div>
									<div class="thum">
										<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="pic" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">
											<c:if test="${goods.salePsbCd == frontConstants.SALE_PSB_10}">
												<div class="soldouts"><em class="ts">판매중지</em></div>
											</c:if>
											<c:if test="${goods.salePsbCd == frontConstants.SALE_PSB_20}">
												<div class="soldouts"><em class="ts">판매종료</em></div>
											</c:if>
											<c:if test="${goods.salePsbCd == frontConstants.SALE_PSB_30}">
												<div class="soldouts"><em class="ts"><spring:message code='front.web.view.common.goods.saleSoldOut.title'/></em></div>
											</c:if>
											<img class="img" src="${frame:optImagePath(goods.imgPath, frontConstants.IMG_OPT_QRY_510)}" alt="${goods.goodsNm}" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'">
										</a>
										<button type="button" class="bt zzim ${goods.interestYn eq 'Y' ? 'on' : ''}" data-content='${goods.goodsId}' data-url="/goods/insertWish?goodsId=${goods.goodsId}" data-action="interest" data-yn="N" data-goods-id="${goods.goodsId}" data-target="goods">찜하기</button>
										<c:if test="${goods.salePsbCd == frontConstants.SALE_PSB_00}">
										<div class="bts"><a href="javascript:void(0);" class="bt cart" onclick="insertCart('${goods.goodsId}', ${goods.itemNo}, '${empty goods.ordmkiYn ? 'N' : goods.ordmkiYn}'); return false;" data-content="${goods.goodsId}" data-url="/order/insertCart">담기</a></div>
										</c:if>
									</div>
									<div class="boxs">
										<div class="tit">
											<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="lk" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" >${goods.goodsNm}</a>
										</div>
										<div class="inf">
											<span class="prc"><em class="p"><fmt:formatNumber value="${goods.foSaleAmt}" type="number" pattern="#,###,###"/></em><i class="w">원</i></span>
											<c:if test="${goods.orgSaleAmt > goods.saleAmt and ((goods.orgSaleAmt - goods.saleAmt)/goods.orgSaleAmt * 100) >= 1 }">
											<span class="pct"><em class="n"><fmt:parseNumber value="${100-((goods.foSaleAmt * 100) / goods.orgSaleAmt)}" integerOnly="true"/></em><i class="w">%</i></span>
											</c:if>
										</div>
									</div>
								</div>
							</li>
							</c:if>
							</c:forEach>
						</ul>
					</c:if>
					<c:if test="${empty cornerList.offenGoodsList}">
						<section class="no_data auto_h">
						<div class="inr">
							<div class="msg">자주 구매한 상품이 없습니다.</div>
						</div>
						</section>
					</c:if>
				</section>
			</div>
		</div>
	</main>
	<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
		<jsp:param name="floating" value="" />
	</jsp:include>
	</tiles:putAttribute>	
</tiles:insertDefinition>