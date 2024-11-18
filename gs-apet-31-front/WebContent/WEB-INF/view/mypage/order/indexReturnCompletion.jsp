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
	// GTM
	var digitalData = digitalData || {};
	var refundInfo = {};
	var products = new Array();
	var actionField = {
			order_id : "${claimBase.ordNo}"
		}
	refundInfo.actionField = actionField;
	<c:forEach items="${claimDetailList}" var="item">
		var thisProduct = {};
		var thisOpt = new Array();
		thisProduct.name = "${item.goodsNm}";
		thisProduct.id = "${item.goodsId}";
		thisProduct.quantity = "${item.clmQty}";
		products.push(thisProduct);
	</c:forEach>
	refundInfo.products = products;
	digitalData.refundInfo = refundInfo;
	
	
		$(function(){
			setTimeout(function(){
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
				};
			},1000);
		});
	
		
		/*
		 * 취소, 교환, 반품, as조회 화면 리로딩
		 */
		function searchClaimRequestList(){
			var mbrNo = '${session.mbrNo}';
			 
			if(mbrNo == '0') {
				jQuery("<form action=\"/mypage/order/indexDeliveryDetail\" method=\"get\"><input type=\"hidden\" name=\"ordNo\" value=\"<c:out value="${claimBase.ordNo}" />\" /></form>").appendTo('body').submit();
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
		<main class="container lnb page shop my" id="container">
			<div class="inr">
				
				<div class="contents" id="contents">				
					<div class="exchange-area pc-reposition success2">
						<div class="complete i2"><!-- i1 : 취소 //i2 : 반품  //i3 : 교환 // -->
						 	<span>반품 신청</span>이 정상적으로 <br>
							완료되었습니다.
						</div>
						<div class="item-box pc-reposition">
							<p class="tit">예상 환불 금액</p>
							<div class="price-area">
								<c:set var="refundPay" value="0"/>
								<c:set var="mainRefundPay" value="0"/>
								<c:set var="gsRefundPay" value="0"/>
								<c:set var="mpRefundPay" value="0"/>
								<c:set var="mainpayMeansNm" value=""/>
								<c:forEach items="${payInfoList}" var="payInfo">
									<c:set var="refundPay" value="${refundPay +  payInfo.payAmt}"/>
									<c:choose>
										<c:when test="${FrontWebConstants.PAY_MEANS_80 eq payInfo.payMeansCd }">
											<c:set var="gsRefundPay" value="${payInfo.payAmt }"/>
										</c:when>
										<c:when test="${FrontWebConstants.PAY_MEANS_81 eq payInfo.payMeansCd }">
											<c:set var="mpRefundPay" value="${payInfo.payAmt }"/>
										</c:when>
										<c:otherwise>
											<c:set var="mainRefundPay" value="${payInfo.payAmt }"/>
											<c:set var="mainpayMeansNm" value="${payInfo.payMeansNm }"/>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<c:if test="${(mpRefundPay - claimPay.mpRefundUseAmt) ne 0}">
									<c:set var="refundPay" value="${refundPay - (mpRefundPay - claimPay.mpRefundUseAmt)}"/>
								</c:if>
								
								<ul class="addPoint delivery">
									<li class="ttl"><span>환불 금액</span>	<span class="savePoint"><frame:num data="${refundPay}"/>원</span></li>
									<c:if test="${mainRefundPay gt 0 }">
										<li ><span>${mainpayMeansNm} 환불</span>	<span class="savePoint"><frame:num data="${mainRefundPay}"/>원</span></li>
									</c:if>
									<c:if test="${gsRefundPay gt 0 }">
										<li ><span>GS&POINT 환불</span>				<span class="savePoint"><frame:num data="${gsRefundPay}"/>P</span></li>
									</c:if>
									<c:if test="${claimPay.mpRefundUseAmt gt 0 }">
										<li ><span>우주코인 환불</span>				<span class="savePoint"><frame:num data="${claimPay.mpRefundUseAmt}"/>C</span></li>
									</c:if>
								</ul>
							</div>
						</div>
						
						<div class="item-box  pc-reposition">
							<p class="tit">수거지</p>
							
							<div class="sub-tit c1">
								<span id="adrsNmView" name="adrsNmView"><c:out value="${deliveryInfo.gbNm}"/></span>				
							</div>
							<p class="txt-t1 pc-resize-tit">
							
							<c:choose>						
								<c:when test="${deliveryInfo.roadAddr ne null}">
									[<c:out value="${deliveryInfo.postNoNew}"/>] <span id="roadAddrView" name="roadAddrView"><c:out value="${deliveryInfo.roadAddr}"/></span> <span id="roadDtlAddrView" name="roadDtlAddrView"><c:out value="${deliveryInfo.roadDtlAddr}"/></span>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${deliveryInfo.prclAddr ne null &&  deliveryInfo.prclAddr ne ''}">
									 		<span id="prclAddrViewDiv" >[<c:out value="${deliveryInfo.postNoOld}"/>] <span id="prclAddrView" name="prclAddrView"><c:out value="${deliveryInfo.prclAddr}"/></span> <span id="prclDtlAddrView" name="prclDtlAddrView"><c:out value="${deliveryInfo.prclDtlAddr}"/></span></span>
										</c:when>
										<c:otherwise>
									 		<span id="prclAddrViewDiv" style="display: none;">[<c:out value="${deliveryInfo.postNoOld}"/>] <span id="prclAddrView" name="prclAddrView"></span> <span id="prclDtlAddrView" name="prclDtlAddrView"><c:out value="${deliveryInfo.prclDtlAddr}"/></span></span>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
									
							</p>
							<p class="txt-t2 pc-resize-tit"><span id="adrsNmView" name="adrsNmView"><c:out value="${deliveryInfo.adrsNm}"/></span> / <span id="mobileView" name="mobileView"><frame:mobile data="${deliveryInfo.mobile}"/></span></p>
							<p class="txt-t2 pc-resize-tit"><span id="dlvrMemoView" name="dlvrMemoView"><c:out value="${deliveryInfo.dlvrMemo}"/></span></p>
						</div>					
						
					<div class="item-box pc-reposition">		
							<c:forEach items="${payInfoList}" var="payInfo" varStatus="status"> 											
								<c:if test="${payInfo.payMeansCd ne null and payInfo.payMeansCd ne FrontWebConstants.PAY_MEANS_00}">
									<c:if test="${payInfo.payMeansCd eq FrontWebConstants.PAY_MEANS_10}">
										<p class="tit pc-m0">환불수단</p>
										<p class="order-text"><strong><frame:codeValue items="${payMeansCdList}" dtlCd="${payInfo.payMeansCd}" /></strong><frame:codeValue items="${cardcCdList}" dtlCd="${payInfo.cardcCd}"/>(${payInfo.cardNo })</p>
									</c:if>	
									<c:if test="${payInfo.payMeansCd eq FrontWebConstants.PAY_MEANS_20}">
										<p class="tit pc-m0">환불수단</p>
										<p class="order-text"><strong><frame:codeValue items="${payMeansCdList}" dtlCd="${payInfo.payMeansCd}" /></strong><frame:codeValue items="${bankCdList}" dtlCd="${payInfo.bankCd}"/></p>
									</c:if>	
									<c:if test="${payInfo.payMeansCd eq FrontWebConstants.PAY_MEANS_30}">
										<c:if test="${not empty claimPay.acctNo}">		
											<p class="tit pc-m0">환불계좌</p>
											<p class="order-text"><strong> ${claimPay.ooaNm }</strong><frame:codeValue items="${bankCdList}" dtlCd="${claimPay.bankCd}"/>(${claimPay.acctNo })</p>						
										</c:if>
									</c:if>
									<c:if test="${payInfo.payMeansCd ne FrontWebConstants.PAY_MEANS_10 and payInfo.payMeansCd ne FrontWebConstants.PAY_MEANS_20 and payInfo.payMeansCd ne FrontWebConstants.PAY_MEANS_30 and payInfo.payMeansCd ne FrontWebConstants.PAY_MEANS_80 and payInfo.payMeansCd ne FrontWebConstants.PAY_MEANS_81}">
										<p class="tit pc-m0">환불수단</p>
										<p class="order-text"><strong>일반결제</strong><frame:codeValue items="${payMeansCdList}" dtlCd="${payInfo.payMeansCd}" /></p>
									</c:if>
								</c:if>
							</c:forEach>		
							<div class="info-txt pc-reposition" >
								<ul>
									<li>반품은 상품 수거 후 상품 이상 유무를 확인한 뒤 주문 시 결제 수단으로 환불됩니다.<br/>가상계좌 결제의 경우 입력하신 환불 계좌로 환불 됩니다.</li>
									<li>결제수단에 따라 환불 소요 기간에 차이가 있습니다. (영업일 기준)<br/>신용카드 : 3~7일 소요<br/>실시간 계좌이체 : 2일 소요<br/>가상계좌 : 1일 소요</li>
									<li>카드사/은행 사정에 따라 환불 일정이 달라질 수 있습니다.</li>
									<li>사은품이 있을 경우 같이 반송해야하며 사은품 누락 시 교환/반품이 불가할 수 있습니다.</li>
								</ul>
							</div>
						</div>
						<div class="btnSet space pc-reposition">
							<a href="/mypage/order/indexClaimList" data-content="" data-url="/mypage/order/indexClaimList" class="btn lg d">취소/반품/교환 목록</a>
							<a href="/shop/home/" class="btn lg b">계속 쇼핑하기</a>
						</div>
						
						<c:if test="${fn:length(cartReSetList) > 0}" >
						<div class="exchange-area pc-reposition pc-padding-top50">
							<div class="cart-add pc-reposition">
								<p class="tit">
									상품을 다시 장바구니에 <br>
									담으시겠어요?
								</p>
								<div class="scroll-x">
									<div class="scroll swiper-container">
										<ul class="scroll-list swiper-wrapper">
										
										<c:forEach items="${cartReSetList}" var="orderReturn" varStatus="idx">	
											<li class="swiper-slide">
												<div class="cart">
													<div class="pic">												
														<a href="/goods/indexGoodsDetail?goodsId=${not empty orderReturn.pakGoodsId ? orderReturn.pakGoodsId : orderReturn.goodsId }" data-url="/goods/indexGoodsDetail?goodsId=${not empty orderReturn.pakGoodsId ? orderReturn.pakGoodsId : orderReturn.goodsId }"/>
														
														<img src="${fn:indexOf(orderReturn.imgPath, 'cdn.ntruss.com') > -1 ? orderReturn.imgPath : frame:optImagePath(orderReturn.imgPath, frontConstants.IMG_OPT_QRY_270)}" alt="${orderReturn.goodsNm }" class="img">
														</a>
													</div>
													<div class="name">
														<div class="tit"><c:out value="${orderReturn.goodsNm}" /></div>
														<div class="stt">1개 / <c:out value="${orderReturn.itemNm}" /></div>
														<div class="price">
															<span class="prc"><em class="p"><frame:num data="${orderReturn.saleAmt - orderReturn.prmtDcAmt}" /></em><i class="w">원</i></span>
														</div>
														<a href="javascript:;" onclick="cartGoods.insertCart('${orderReturn.goodsId}', '${orderReturn.itemNo }', '${orderReturn.pakGoodsId }', '', '', 'N');" data-content="${orderReturn.goodsId}" data-url="${view.stDomain}/order/indexCartList/" class="btn sm icon2">담기</a>
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
	
