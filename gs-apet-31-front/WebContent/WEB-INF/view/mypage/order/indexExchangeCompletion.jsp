	<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
	<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
	<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
	<%@ page import="front.web.config.constants.FrontWebConstants" %> 
	<%@ page import="framework.common.enums.ImageGoodsSize" %>
	
	<c:choose>
		<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
			<c:set var="titleName" value="common" />
		</c:when>						
		<c:otherwise>
			<c:set var="titleName" value="default" />
		</c:otherwise>					
	</c:choose>	
	<tiles:insertDefinition name="${titleName }">
	<tiles:putAttribute name="script.include" value="script.order"/>
	<tiles:putAttribute name="script.inline">
	<script type="text/javascript" 	src="/_script/cart/cart.js"></script>
	<script type="text/javascript">
	
	
		$(function(){
			/*setTimeout(function(){*/
				/* pc일 경우 스와이퍼처리 */
				var check = ($("link[href *= 'style.pc.css']").length > 0)?true:false;
				if(check){
					// Swiper 상품
					var swiperFit = new Swiper('.scroll-x .swiper-container', {
						slidesPerView: 3,
						spaceBetween: 18, 
						navigation: {
							nextEl: '.scroll-x .swiper-button-next',
							prevEl: '.scroll-x .swiper-button-prev',
						}
					});
				}
		/*	},1000);*/
		});
	
		
		/*
		 * 취소, 교환, 반품, 화면 리로딩
		 */
		function searchClaimRequestList(){
			var mbrNo = '${session.mbrNo}';
			if(mbrNo == '0') {
				jQuery("<form action=\"/mypage/order/indexDeliveryDetailNoMem\" method=\"get\"><input type=\"hidden\" name=\"ordNo\" value=\"<c:out value="${claimBase.ordNo}" />\" /></form>").appendTo('body').submit();
			} else {
				$("#claim_request_list_form").attr("target", "_self");
				$("#claim_request_list_form").attr("action", "/mypage/order/indexClaimList");
				$("#claim_request_list_form").submit();
			} 
		}	
	
	</script>
	
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
	
		<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
			<jsp:include page="/WEB-INF/tiles/include/lnb_my.jsp" />
			<jsp:include  page="/WEB-INF/tiles/include/menubar.jsp" />
		</c:if>
	
		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container lnb page shop order" id="container">
			<div class="inr">
				
				<div class="contents" id="contents">
					<div class="exchange-area pc-reposition success2">
						<div class="complete i3"><!-- i1 : 취소 //i2 : 반품  //i3 : 교환 // -->
						 	<span>교환 신청</span>이 정상적으로 <br>
						 	완료되었습니다.
						</div>					
						
						<div class="item-box  pc-reposition">
							<p class="tit">수거지</p>
							
							<div class="sub-tit mb">
								<span id="adrsNmView" name="adrsNmView"><c:out value="${rtrnaInfo.gbNm}"/></span>				
							</div>
							<p class="txt-t1 pc-resize-tit">
							
							<c:choose>						
								<c:when test="${rtrnaInfo.roadAddr ne null}">
									[<c:out value="${rtrnaInfo.postNoNew}"/>] <span id="roadAddrView" name="roadAddrView"><c:out value="${rtrnaInfo.roadAddr}"/></span> <span id="roadDtlAddrView" name="roadDtlAddrView"><c:out value="${rtrnaInfo.roadDtlAddr}"/></span>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${rtrnaInfo.prclAddr ne null &&  rtrnaInfo.prclAddr ne ''}">
									 		<span id="prclAddrViewDiv" >[<c:out value="${rtrnaInfo.postNoOld}"/>]  <span id="prclAddrView" name="prclAddrView"><c:out value="${rtrnaInfo.prclAddr}"/></span> <span id="prclDtlAddrView" name="prclDtlAddrView"><c:out value="${rtrnaInfo.prclDtlAddr}"/></span></span>
										</c:when>
										<c:otherwise>
									 		<span id="prclAddrViewDiv" style="display: none;">[<c:out value="${rtrnaInfo.postNoOld}"/>]  <span id="prclAddrView" name="prclAddrView"></span> <span id="prclDtlAddrView" name="prclDtlAddrView"><c:out value="${rtrnaInfo.prclDtlAddr}"/></span></span>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
									
							</p>
							<p class="txt-t2 pc-resize-tit"><span id="adrsNmView" name="adrsNmView"><c:out value="${rtrnaInfo.adrsNm}"/></span> / <span id="mobileView" name="mobileView"><frame:mobile data="${rtrnaInfo.mobile}"/></span></p>
							<p class="txt-t2 pc-resize-tit"><span id="dlvrMemoView" name="dlvrMemoView"><c:out value="${rtrnaInfo.dlvrMemo}"/></span></p>
						</div>
						
						<div class="item-box pc-reposition">
							<p class="tit">교환 배송지</p>
							<div class="sub-tit mb">
								<span id="adrsNmView" name="adrsNmView"><c:out value="${dlvraInfo.gbNm}"/></span>				
							</div>
							<p class="txt-t1 pc-resize-tit">
							
							<c:choose>						
								<c:when test="${dlvraInfo.roadAddr ne null}">
									[<c:out value="${dlvraInfo.postNoNew}"/>] <span id="roadAddrView" name="roadAddrView"><c:out value="${dlvraInfo.roadAddr}"/></span> <span id="roadDtlAddrView" name="roadDtlAddrView"><c:out value="${dlvraInfo.roadDtlAddr}"/></span>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${dlvraInfo.prclAddr ne null &&  dlvraInfo.prclAddr ne ''}">
									 		<span id="prclAddrViewDiv" >[<c:out value="${dlvraInfo.postNoOld}"/>] <span id="prclAddrView" name="prclAddrView"><c:out value="${dlvraInfo.prclAddr}"/></span> <span id="prclDtlAddrView" name="prclDtlAddrView"><c:out value="${dlvraInfo.prclDtlAddr}"/></span></span>
										</c:when>
										<c:otherwise>
									 		<span id="prclAddrViewDiv" style="display: none;">[<c:out value="${dlvraInfo.postNoOld}"/>] <span id="prclAddrView" name="prclAddrView"></span> <span id="prclDtlAddrView" name="prclDtlAddrView"><c:out value="${dlvraInfo.prclDtlAddr}"/></span></span>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
									
							</p>
							<p class="txt-t2 pc-resize-tit"><span id="adrsNmView" name="adrsNmView"><c:out value="${dlvraInfo.adrsNm}"/></span> / <span id="mobileView" name="mobileView"><frame:mobile data="${dlvraInfo.mobile}"/></span></p>
							<p class="txt-t2 pc-resize-tit"><span id="dlvrMemoView" name="dlvrMemoView"><c:out value="${dlvraInfo.dlvrMemo}"/></span></p>
							<div class="info-txt">
								<ul>
									<li>교환은 상품 수거 후 상품 이상 유무를 확인한 뒤 교환 상품이 배송 됩니다.</li>
									<li>사은품이 있을 경우 같이 반송해야하며 사은품 누락 시 교환/반품이 불가할 수 있습니다.</li>
								</ul>
							</div>
						</div>					
						
						<div class="btnSet space pc-reposition">
							<a href="/mypage/order/indexClaimList" data-content="" data-url="/mypage/order/indexClaimList" class="btn lg d">취소/반품/교환 목록</a>
							<a href="/shop/home/" class="btn lg b">계속 쇼핑하기</a>
						</div>
						
						<c:if test="${fn:length(cartReSetList) > 0}" >
						<div class="cart-add pc-reposition">
							<p class="tit">
								상품을 다시 장바구니에 <br>
								담으시겠어요?
							</p>
							<div class="scroll-x">
								<div class="scroll swiper-container">
									<ul class="scroll-list swiper-wrapper">
									
									<c:forEach items="${cartReSetList}" var="orderExchange" varStatus="idx">	
										<li class="swiper-slide">
											<div class="cart">
												<div class="pic">												
													<a href="/goods/indexGoodsDetail?goodsId=${not empty orderExchange.pakGoodsId ? orderExchange.pakGoodsId : orderExchange.goodsId }" data-content="${not empty orderExchange.pakGoodsId ? orderExchange.pakGoodsId : orderExchange.goodsId }" data-url="/goods/indexGoodsDetail?goodsId=${not empty orderExchange.pakGoodsId ? orderExchange.pakGoodsId : orderExchange.goodsId }" >												
													<img src="${fn:indexOf(orderExchange.imgPath, 'cdn.ntruss.com') > -1 ? orderExchange.imgPath : frame:optImagePath(orderExchange.imgPath, frontConstants.IMG_OPT_QRY_270)}" alt="${orderExchange.goodsNm }" class="img">
													</a>
												</div>
												<div class="name">
													<div class="tit"><c:out value="${orderExchange.goodsNm}" /></div>
													<div class="stt">1개 / <c:out value="${orderExchange.itemNm}" /></div>
													<div class="price">
														<span class="prc"><em class="p"><frame:num data="${orderExchange.saleAmt - orderExchange.prmtDcAmt}" /></em><i class="w">원</i></span>
													</div>
													<a href="javascript:;" onclick="cartGoods.insertCart('${orderExchange.goodsId}', '${orderExchange.itemNo }', '${orderExchange.pakGoodsId }', '', '', 'N');" data-content="${orderExchange.goodsId}" data-url="${view.stDomain}/order/indexCartList/" class="btn sm icon2">담기</a>
												</div>
											</div>
										</li>
									</c:forEach>	
										
									</ul>
									<div class="swiper-pagination"></div>
								</div>
								<div class="remote-area">
									<button class="swiper-button-next" type="button"></button>
									<button class="swiper-button-prev" type="button"></button>
								</div>
							</div>
							
						</div>
						</c:if>		
				</div>	
						
				
			</div>
	
		
	
		</main>
		
		<div class="layers">			
		</div>
		<!-- 바디 - 여기 밑으로 템플릿 -->
	
	</tiles:putAttribute>
	</tiles:insertDefinition>	