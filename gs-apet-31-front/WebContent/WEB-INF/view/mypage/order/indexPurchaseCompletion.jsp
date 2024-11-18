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
	<script type="text/javascript">
	
		$(function(){
			$("#moreBtn").click(function(){
				location.href="/mypage/goodsCommentList";
			});
		});
		
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
					<!-- 본문 -->
					<div class="contents" id="contents">
						<div class="exchange-area pc-reposition success">
							<div class="complete i1"><!-- i1 : 취소 //i2 : 반품  //i3 : 교환 // -->
								<span>구매확정</span>이 완료되었습니다.
								<c:if test="${isuSchdPnt ne 0 or (not empty mpVO and mpVO.usePsbResCd eq '200')}">
									<div class="addPoint">
										<ul>
											<c:if test="${isuSchdPnt ne 0 }">
												<li><span>GS&POINT</span><span class="savePoint"><b><frame:num data="${isuSchdPnt}" />P</b> 적립완료</span></li>
											</c:if>
											<c:if test="${not empty mpVO and mpVO.usePsbResCd eq '200'}">
												<li><span>우주코인</span><span class="savePoint"><b><frame:num data="${mpVO.savePnt}" />C</b> 적립완료</span></li>
											</c:if>
										</ul>
									</div>
								</c:if>
								
							</div>
							<div class="btnSet space pc-reposition pc-bt0">
								<a href="/mypage/order/indexDeliveryList" data-content="" data-url="/mypage/order/indexDeliveryList" class="btn lg d">주문/배송 목록</a>
								<a href="/shop/home/" class="btn lg b">계속 쇼핑하기</a>
							</div>
						</div>
						
						<div class="exchange-area pc-reposition pc-padding-top50">
							<div class="item-new-titBar mt">
								바로 상품후기를 <br />
								작성하시겠어요?
							</div>
							
							<div class="item-box pc-reposition t2 mo-bt0">
								<div class="oder-cancel t3">
									<ul>
										
								<c:forEach items="${orderDetailList}" var="orderDetail" varStatus="idx">															
										<li>										
											<div class="untcart <c:if test="${idx.first}">cancel</c:if> re-t2">
												<div class="box">
													<div class="tops">
														<div class="pic"><a href="/goods/indexGoodsDetail?goodsId=${not empty orderDetail.pakGoodsId ? orderDetail.pakGoodsId : orderDetail.goodsId }" data-content="${not empty orderDetail.pakGoodsId ? orderDetail.pakGoodsId : orderDetail.goodsId }" data-url="/goods/indexGoodsDetail?goodsId=${not empty orderDetail.pakGoodsId ? orderDetail.pakGoodsId : orderDetail.goodsId }" >
														<img src="${fn:indexOf(orderDetail.imgPath, 'cdn.ntruss.com') > -1 ? orderDetail.imgPath : frame:optImagePath(orderDetail.imgPath, frontConstants.IMG_OPT_QRY_270)}" alt="${orderDetail.goodsNm }" class="img">
														</a></div>
														<div class="name">
															<div class="tit" style="padding-top:0px">${orderDetail.goodsNm}</div>
															<div class="stt"><frame:num data="${orderDetail.ordQty}" />개 / ${orderDetail.itemNm}</div>
															<div class="price">
																<c:set var="goodsSaleAmt" value="${(orderDetail.saleAmt - orderDetail.prmtDcAmt) * orderDetail.ordQty}" />
																<span class="prc"><em class="p"><frame:num data="${goodsSaleAmt}" /></em><i class="w">원</i></span>
															</div>
														</div>
														<c:if test="${  orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_170}">
															<c:if test="${session.mbrNo ne FrontWebConstants.NO_MEMBER_NO }">
																<c:if test="${ orderDetail.goodsEstmRegYn eq FrontWebConstants.COMM_YN_N  }">	
																	<a href="#" data-content="${orderBase.ordNo}" data-url="/mypage/service/popupGoodsCommentReg" onclick="orderDeliveryDetailBtn.openGoodsComment('${orderDetail.goodsId}','${orderBase.ordNo}','${orderDetail.ordDtlSeq}', '', '');return false;" class="btn cu">후기작성</a>
																</c:if>
																<c:if test="${ orderDetail.goodsEstmRegYn eq FrontWebConstants.COMM_YN_Y  }">
																	<a href="/mypage/goodsCommentList" data-content="" data-url="/mypage/goodsCommentList" class="btn cu">후기보기</a>
																</c:if>
															</c:if>
														</c:if>
														
													</div>
												</div>
											</div>
										</li>
								</c:forEach>
									</ul>
								</div>
							</div>
							<div class="item-box-newBtn">
								<button type="button" class="btn-r i1" id="moreBtn"><span>상품후기 더보기</span></button>
							</div>
						</div>
						
					
					</div>
	
				</div>
		</main>
		
		<div class="layers" id="emptyLayers">			
		</div>
		<!-- 바디 - 여기 밑으로 템플릿 -->
	
	</tiles:putAttribute>
	</tiles:insertDefinition>	
	
