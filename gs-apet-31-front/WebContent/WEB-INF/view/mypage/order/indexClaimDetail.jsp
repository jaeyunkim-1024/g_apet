	<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
	<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ page import="front.web.config.constants.FrontWebConstants" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
	<%@ page import="framework.common.enums.ImageGoodsSize" %>
	
	<c:set var="prcAreaDisplayStyle" value="${not empty oldStdOrdNo and oldStdOrdNo < orderBase.ordNo ? '' : 'style=\"display:none;\"' }" />

	<jsp:useBean id="now" class="java.util.Date" />
	
	<tiles:insertDefinition name="mypage">
	<tiles:putAttribute name="script.include" value="script.order"/>
	<tiles:putAttribute name="script.inline">

	<c:set value="${claimBaseVO.claimDetailRefundListVO[0]}" var="setClaimDetailRefund"/>
	
	<script type="text/javascript">
	/**
	 * 모바일 타이틀 수정
	 */
	$(document).ready(function(){
		$("#header_pc").removeClass("mode0");
		$("#header_pc").addClass("mode16");
// 		$("#header_pc").addClass("noneAc");
		$("#header_pc").addClass("logHeaderAc");
		$("#header_pc").attr("data-header", "set22");
		$(".mo-heade-tit .tit").html($('h2').text());
		$(".refund_valZero").hide();
		$(".refund_val").css("margin-top","0px");
	}); // End Ready

	$(function() {
	    //재배송조회 이벤트 추가 - 2021.05.17 by kek01
		$(document).off("click", '[data-target="order"][data-action="goodsflow"]')
		.on("click", '[data-target="order"][data-action="goodsflow"]', function(e) {
			e.stopPropagation();

			let $this = $(this);
			let url = $this.data("url");

			if("${view.deviceGb eq frontConstants.DEVICE_GB_30}"=="true") {
				var parameters = {
					"func" : "onOrderPage",
					"url" : url,
					"title" : "배송조회"
				};
				if("${view.os eq frontConstants.DEVICE_TYPE_10}"=="true") {
					// Android
					window.AppJSInterface.onOrderPage(JSON.stringify(parameters));
				} else {
					// iOS(Dictionary)
					window.webkit.messageHandlers.AppJSInterface.postMessage(parameters);
				}
			} else {
				window.open(url,"","width=498,height=640, scrollbars=yes,resizable=no");
			}
			e.preventDefault();
		});		
	});

	</script>
	

	</tiles:putAttribute>

	<tiles:putAttribute name="content">

		<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
			<%-- <jsp:include page="/WEB-INF/tiles/include/lnb_my.jsp" />  해당 부분 중복되어 주석처리하였습니다.(APETQA-5079)--%>
			<jsp:include  page="/WEB-INF/tiles/include/menubar.jsp" />
		</c:if>
		<main class="container lnb page shop order my" id="container">
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<!-- PC 타이틀 모바일에서 제거  -->
					<div class="pc-tit">
						<h2><frame:codeValue items="${clmTpCdList}" dtlCd="${setClaimDetailRefund.clmTpCd}" type="S"/>상세</h2>
					</div>
					<!-- // PC 타이틀 모바일에서 제거  -->
					<!-- 주문 배송 -->

					<div class="delivery-oder-area">
						<div class="inr-box border-on cucu">
							<div class="item-list">
								<div class="top b">
									<div class="tit">
										<p class="data"><frame:timestamp date="${orderBase.ordAcptDtm}" dType="C" /></p>
										<span class="icon-left-gap">주문번호 ${orderBase.ordNo}</span>
									</div>
								</div>
							</div>
						<c:forEach items="${orderBase.orderCompanyListVO}" var="company" varStatus="idx">
						<c:forEach items="${company.orderInvoiceListVO}" var="invoice" varStatus="idx">
						<c:forEach items="${invoice.orderDlvrStatListVO}" var="dlvrStat" varStatus="idx">
							<!--클레임 상태 색상 설정 -->
							<!--빨강 : 반품신청/반품진행중/교환신청/교환진행중-->
							<!--회색 : 주문취소-->
							<!--검정 : 반품완료/반품거부/교환완료/교환거부-->
							<c:set var="dvlrClass" value="${dlvrStat.dlvrPrcsTpCd eq FrontWebConstants.DLVR_PRCS_TP_10 ? 'icon-t t2': dlvrStat.dlvrPrcsTpCd eq  FrontWebConstants.DLVR_PRCS_TP_20 ? 'icon-t':dlvrStat.dlvrPrcsTpCd eq  FrontWebConstants.DLVR_PRCS_TP_21 ? 'icon-t t3':''}"/>
							<c:set var="titClass" value="t4"/>
							<c:choose>
								<c:when test="${ orderDetail.claimDetailVO.clmStatCd ne FrontWebConstants.CLM_STAT_40 and (
										dlvrStat.viewClmDtlStatCd eq FrontWebConstants.CLM_DTL_STAT_250
										or dlvrStat.viewClmDtlStatCd eq FrontWebConstants.CLM_DTL_STAT_260
										or dlvrStat.viewClmDtlStatCd eq FrontWebConstants.CLM_DTL_STAT_350
										or dlvrStat.viewClmDtlStatCd eq FrontWebConstants.CLM_DTL_STAT_450
									) }">
									<c:set var="titClass" value=""/>
								</c:when>
								<c:when test="${ dlvrStat.clmTpCd eq FrontWebConstants.CLM_DTL_TP_10 or orderDetail.claimDetailVO.clmStatCd eq FrontWebConstants.CLM_STAT_40 or (dlvrStat.viewClmDtlStatCd eq FrontWebConstants.CLM_DTL_STAT_110 or dlvrStat.viewClmDtlStatCd eq FrontWebConstants.CLM_DTL_STAT_120)}">
									<c:set var="titClass" value="g"/>
								</c:when>
							</c:choose>

							<c:if test="${not empty dlvrStat.claimDetailListVO}">
							<div class="item-list">
								<div class="bottom">
									<div class="t-box">
										<p class="tit ${titClass} ">
											<!--클레임 상태 텍스트 설정 -->
											<!--주문 취소 -->
											<%-- <frame:codeValue items="${clmTpCdList}" dtlCd="${dlvrStat.clmTpCd}"/> --%>
											<frame:codeValue items="${clmDtlStatCdList}" dtlCd="${dlvrStat.viewClmDtlStatCd}" type="S"/>
										</p>
										<p class="${dvlrClass }">
											<c:choose>
											<c:when test="${dlvrStat.compGbCd eq '10'}">
												<frame:codeValue items="${ordDtlPrcsTPList}" dtlCd="${dlvrStat.dlvrPrcsTpCd}" type="H"/>
											</c:when>
											<c:otherwise>
												업체배송
											</c:otherwise>
											</c:choose>
										</p>
									</div>
									<c:if test='${dlvrStat.dlvrInvNo ne null and dlvrStat.dlvrInvNo ne "" and dlvrStat.clmTpCd eq FrontWebConstants.CLM_TP_30 and dlvrStat.dlvrPrcsTpCd eq FrontWebConstants.DLVR_PRCS_TP_10 }'><!-- 교환배송 and 택배배송일때만 재배송조회  -->
									<div class="g-box">
										<p class="lt"></p>
										<p class="rt">
 											<a href="javascript:;" class="detail-btn" data-target="order" data-action="goodsflow" data-url="https://${pageContext.request.serverName}/mypage/order/goodsflow/${dlvrStat.claimDetailListVO[0].dlvrNo}" >재배송 조회</a>
											<%-- <a href="javascript:;" class="detail-btn" data-target="order" data-action="goodsflow" data-url="http://${pageContext.request.serverName}:${pageContext.request.serverPort}/mypage/order/goodsflow/${dlvrStat.claimDetailListVO[0].dlvrNo}" >재배송 조회</a> --%> 
										</p>
									</div>
									</c:if>
									<c:if test="${orderBase.payMeansCd ne FrontWebConstants.PAY_MEANS_00 and orderBase.payMeansCd ne FrontWebConstants.PAY_MEANS_80 and orderBase.payMeansCd ne FrontWebConstants.PAY_MEANS_81}">
									<c:if test="${(dlvrStat.clmTpCd eq FrontWebConstants.CLM_TP_10 or (dlvrStat.viewClmDtlStatCd eq FrontWebConstants.CLM_DTL_STAT_260)) and orderBase.payMeansCd ne null}">
									<ul class="opts">
										<li class="opt">
											<c:if test="${orderBase.payMeansCd eq FrontWebConstants.PAY_MEANS_10
																or orderBase.payMeansCd eq FrontWebConstants.PAY_MEANS_11
																or orderBase.payMeansCd eq FrontWebConstants.PAY_MEANS_70 
																or orderBase.payMeansCd eq FrontWebConstants.PAY_MEANS_71 
																or orderBase.payMeansCd eq FrontWebConstants.PAY_MEANS_72}">
												<span class="dt">결제 취소 : 영업일 기준 3~7일 소요</span>
											</c:if>
											<c:if test="${orderBase.payMeansCd eq FrontWebConstants.PAY_MEANS_20}">
												<span class="dt">환불 : 영업일 기준 2일 소요</span>
											</c:if>
											<c:if test="${orderBase.payMeansCd eq FrontWebConstants.PAY_MEANS_30}">
												<c:if test="${orderBase.payStatCd eq FrontWebConstants.PAY_STAT_00}">
													<span class="dt">입금대기 취소</span>
												</c:if> 
												<c:if test="${orderBase.payStatCd ne FrontWebConstants.PAY_STAT_00}">
													<span class="dt">환불 : 영업일 기준 1일 소요</span>
												</c:if>
											</c:if>
										</li>
									</ul>
									</c:if>
									</c:if>
									
									<%-- 클레임리스트 --%>
									<c:forEach items="${dlvrStat.claimDetailListVO}" var="orderDetail" varStatus="idx">
									<div class="float-bx">
										<div class="untcart"><!-- .disabled -->
											<div class="box">
												<div class="tops">
													<div class="pic">
														<a href="/goods/indexGoodsDetail?goodsId=${not empty orderDetail.pakGoodsId ? orderDetail.pakGoodsId : orderDetail.goodsId }" data-url="/goods/indexGoodsDetail?goodsId=${not empty orderDetail.pakGoodsId ? orderDetail.pakGoodsId : orderDetail.goodsId }">
														<img src="${fn:indexOf(orderDetail.imgPath, 'cdn.ntruss.com') > -1 ? orderDetail.imgPath : frame:optImagePath(orderDetail.imgPath, frontConstants.IMG_OPT_QRY_500)}" alt="${orderDetail.goodsNm }" class="img">
														</a>
													</div>
													<div class="name">
														<div class="tit k0421">
															<a href="/goods/indexGoodsDetail?goodsId=${not empty orderDetail.pakGoodsId ? orderDetail.pakGoodsId : orderDetail.goodsId }" data-url="/goods/indexGoodsDetail?goodsId=${not empty orderDetail.pakGoodsId ? orderDetail.pakGoodsId : orderDetail.goodsId }">
																${orderDetail.goodsNm}
															</a>
														</div>
														<div class="stt">
															${orderDetail.claimDetailVO.clmQty }개
															<c:choose>
																<c:when test="${orderDetail.goodsCstrtTpCd eq FrontWebConstants.GOODS_CSTRT_TP_PAK && not empty orderDetail.optGoodsNm}">	<!-- 상품 구성 유형 : 묶음 -->
																| ${fn:replace(orderDetail.optGoodsNm, '/', ' / ')}
																</c:when>
																<c:when test="${orderDetail.goodsCstrtTpCd eq FrontWebConstants.GOODS_CSTRT_TP_ATTR && not empty orderDetail.pakItemNm}">	<!-- 상품 구성 유형 : 옵션 -->
																| 	${fn:replace(orderDetail.pakItemNm, '|', ' / ')}
																</c:when>
															</c:choose>
														</div>
														<c:if test="${orderDetail.mkiGoodsYn eq 'Y' && not empty orderDetail.mkiGoodsOptContent }">
														<c:forTokens var="optContent" items="${orderDetail.mkiGoodsOptContent }" delims="|" varStatus="conStatus">
															<div class="stt">각인문구${conStatus.count} : ${optContent}</div>
														</c:forTokens>
														</c:if>
														<div class="prcs">
															<span class="prc"><em class="p"><frame:num data="${orderDetail.claimDetailVO.saleAmt * orderDetail.claimDetailVO.clmQty}" /></em><i class="w">원</i></span>
														</div>
													</div>
												</div>
											</div>
										</div>
										<c:if test="${not empty orderDetail.subGoodsNm}">
											<div class="b-txt">
												<strong class="tit">사은품</strong> ${orderDetail.subGoodsNm}
											</div>
										</c:if>
									</div>
									</c:forEach>
								</div>
							</div>
							</c:if>
						</c:forEach>
						</c:forEach>
						</c:forEach>
							<!-- 모바일 일경우 아래를 실행시킴 -->
							<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10}">
							<div class="cdts-area">
								<ul class="prcset">
									<!--취소일시 MO-->
									<c:if test="${(setClaimDetailRefund.clmTpCd eq FrontWebConstants.CLM_TP_10)}">
									<li>
										<div class="dt">취소일시</div>
										<div class="dd">
											<span class="prc"><em class="p"><frame:timestamp date="${claimBaseVO.acptDtm}" dType="C" tType="HM"/></em></span>
										</div>
									</li>
									</c:if>
									<!--반품일시 MO-->
									<c:if test="${(setClaimDetailRefund.clmTpCd eq FrontWebConstants.CLM_TP_20)}">
									<li class="tit">
										<div class="dt">반품신청일시</div>
										<div class="dd">
											<span class="prc"><em class="p"><frame:timestamp date="${claimBaseVO.acptDtm}" dType="C" tType="HM"/></em></span>
										</div>
									</li>
									</c:if>
									<!--교환일시 MO-->
									<c:if test="${(setClaimDetailRefund.clmTpCd eq FrontWebConstants.CLM_TP_30)}">
									<li class="tit">
										<div class="dt">교환신청일시</div>
										<div class="dd">
											<span class="prc"><em class="p"><frame:timestamp date="${claimBaseVO.acptDtm}" dType="C" tType="HM"/></em></span>
										</div>
									</li>
									</c:if>
								</ul>
							</div>
							</c:if>

						</div>
						<div class="ordersets pc-cut">
							<!-- PC일경우 아래를 실행시킴 -->
							<section class="sect addr onWeb_b">
								<div class="hdts"><span class="tit"><frame:codeValue items="${clmTpCdList}" dtlCd="${setClaimDetailRefund.clmTpCd}" type="S"/> 정보</span></div>
								<!--취소일시 MO-->
								<c:if test="${(setClaimDetailRefund.clmTpCd eq FrontWebConstants.CLM_TP_10)}">
								<div class="cdts-area">
									<ul class="prcset">
										<li>
											<div class="dt">취소일시</div>
											<div class="dd">
												<span class="prc"><em class="p"><frame:timestamp date="${claimBaseVO.acptDtm}" dType="C" tType="HM"/></em></span>
											</div>
										</li>
									</ul>
								</div>
								</c:if>
								<!--반품일시 MO-->
								<c:if test="${(setClaimDetailRefund.clmTpCd eq FrontWebConstants.CLM_TP_20)}">
								<div class="cdts-area">
									<ul class="prcset">
										<li class="tit">
											<div class="dt">반품신청일시</div>
											<div class="dd">
												<span class="prc"><em class="p"><frame:timestamp date="${claimBaseVO.acptDtm}" dType="C" tType="HM"/></em></span>
											</div>
										</li>
									</ul>
								</div>
								</c:if>
								<!--교환일시 MO-->
								<c:if test="${(setClaimDetailRefund.clmTpCd eq FrontWebConstants.CLM_TP_30)}">
								<div class="cdts-area">
									<ul class="prcset">
										<li class="tit">
											<div class="dt">교환신청일시</div>
											<div class="dd">
												<span class="prc"><em class="p"><frame:timestamp date="${claimBaseVO.acptDtm}" dType="C" tType="HM"/></em></span>
											</div>
										</li>
									</ul>
								</div>
								</c:if>
							</section>
							<section class="sect addr">
								<div class="hdts"><span class="tit"><frame:codeValue items="${clmTpCdList}" dtlCd="${setClaimDetailRefund.clmTpCd}" type="S" /> 사유</span></div>
								<div class="cdts">
									<div class="adrset">
										<div class="name">
											<em class="t g"><frame:codeValue items="${clmRsnCdList}" dtlCd="${setClaimDetailRefund.clmRsnCd}"/></em>
										</div>
										<div class="adrs" style="margin-top:2px;">
											${setClaimDetailRefund.clmRsnContent}
										</div>
									</div>
								</div>
							</section>

							<c:if test="${(setClaimDetailRefund.clmTpCd eq FrontWebConstants.CLM_TP_20 or setClaimDetailRefund.clmTpCd eq FrontWebConstants.CLM_TP_30)
								and setClaimDetailRefund.clmStatCd ne FrontWebConstants.CLM_STAT_40}">
							<section class="sect addr">
								<div class="hdts">
									<span class="tit">수거지</span>
									<!-- <a href="javascript:;" class="onMo_b ab_r btn sm">반송조회</a>모바일용 -->
								</div>
								<div class="cdts">
									<c:if test="${ setClaimDetailRefund.clmTpCd ne FrontWebConstants.CLM_TP_30}">
										<div class="adrset">
											<c:if test="${ deliveryInfo.gbNm ne null}">
											<div class="name">
												<em class="t g">${deliveryInfo.gbNm}</em>
												<!--<a href="javascript:;" class="onWeb_if ab_r btn sm">반송조회</a>pc용 -->
											</div>
											</c:if>
											<div class="adrs">
												<c:if test="${deliveryInfo.roadAddr ne null}">
													[<c:out value="${deliveryInfo.postNoNew}"/>] <c:out value="${deliveryInfo.roadAddr}"/>, <c:out value="${deliveryInfo.roadDtlAddr}"/>
												</c:if>
											</div>
											<div class="tels">${deliveryInfo.adrsNm} | <frame:mobile data="${deliveryInfo.mobile}"/></div>
										</div>
									</c:if>
									<c:if test="${ setClaimDetailRefund.clmTpCd eq FrontWebConstants.CLM_TP_30}">
										<div class="adrset">
											<c:if test="${ rtrnaInfo.gbNm ne null}">
											<div class="name">
												<em class="t g">${rtrnaInfo.gbNm}</em>
												<!-- <a href="javascript:;" class="onWeb_if ab_r btn sm">반송조회</a>pc용 -->
											</div>
											</c:if>
											<div class="adrs">
												<c:if test="${rtrnaInfo.roadAddr ne null}">
													[<c:out value="${rtrnaInfo.postNoNew}"/>] <c:out value="${rtrnaInfo.roadAddr}"/>, <c:out value="${rtrnaInfo.roadDtlAddr}"/>
												</c:if>
											</div>
											<div class="tels">${rtrnaInfo.adrsNm} | <frame:mobile data="${rtrnaInfo.mobile}"/></div>
										</div>
									</c:if>
								</div>
							</section>
							<c:if test="${setClaimDetailRefund.clmTpCd eq FrontWebConstants.CLM_TP_20}">
							<section class="sect binf">
								<div class="hdts"><span class="tit">반품 배송비</span></div>
								<div class="cdts">
									<div class="result">
										<div class="hd"><em class="b">
											<frame:num data="${claimRefundPayVO.clmDlvrcAmt}"/>원</em>
											<c:if test="${claimRefundPayVO.clmDlvrcAmt > 0 }"> 
												<i class="t c">환불금 차감</i>
											</c:if>
										</div>
									</div>
								</div>
							</section>
							</c:if>
							</c:if>
							<!--취소/반품 이고    클레임접수상태 취소 및  주문 접수 상태가 아닐때-->
							<c:if test="${(setClaimDetailRefund.clmTpCd eq FrontWebConstants.CLM_TP_10 or setClaimDetailRefund.clmTpCd eq FrontWebConstants.CLM_TP_20)
								and setClaimDetailRefund.clmStatCd ne FrontWebConstants.CLM_STAT_40 and claimBaseVO.ordStatCd ne FrontWebConstants.ORD_STAT_10}">
							<section class="sect bprc">
								<div class="hdts"><span class="tit">환불 정보</span></div>
								<div class="cdts">
									<c:set var="refundPay" value="0"/>
									<c:set var="mainRefundPay" value="0"/>
									<c:set var="gsRefundPay" value="0"/>
									<c:set var="mpRefundPay" value="0"/>
									<c:set var="mainpayMeansNm" value=""/>
									<c:forEach items="${claimRefundPayVO.claimRefundPayDetailListVO}" var="payInfo">
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
									
									<c:if test="${(mpRefundPay - claimRefundPayVO.mpRefundUseAmt) ne 0}">
										<c:set var="refundPay" value="${refundPay - (mpRefundPay - claimRefundPayVO.mpRefundUseAmt)}"/>
									</c:if>
									
									
									<ul class="addPoint delivery">
										<li class="ttl"><span>환불 금액</span>	<span class="savePoint"><frame:num data="${refundPay}"/>원</span></li>
										<c:if test="${mainRefundPay ne 0}">	
										  <c:if test="${PayBaseVO.payGbCd eq '40' || mainRefundPay < 0}">
											<c:set var="mainPay" value="${refundPay - (mainRefundPay + gsRefundPay + claimRefundPayVO.mpRefundUseAmt)}"/>
												<c:if test="${mainPay ne 0}">
											<li ><span><frame:codeValue items="${payMeansCdList}" dtlCd="${setClaimDetailRefund.payMeansCd}"/> 환불</span> <span class="savePoint">
											<frame:num data="${mainPay}"/>원</span></li>
												</c:if>
										  </c:if>	
										</c:if>
										<c:set var="payBaseInfo" value="${PayBaseVO}"/>
										<c:if test="${mainRefundPay ne 0 }">
											<c:if test="${PayBaseVO.payGbCd eq '40'}">
												<li ><span>추가 결제금액 환불</span>	<span class="savePoint"><frame:num data="${mainRefundPay}"/>원</span></li>
											</c:if>
											<c:if test="${PayBaseVO.payGbCd ne '40'}">
												<c:if test="${mainRefundPay > 0}">
													<li ><span>${mainpayMeansNm} 환불</span>	<span class="savePoint"><frame:num data="${mainRefundPay}"/>원</span></li>
												</c:if>
												<c:if test="${mainRefundPay < 0}">
													<li ><span>추가 결제금액</span>	<span class="savePoint"><frame:num data="${mainRefundPay}"/>원</span></li>
												</c:if>
											</c:if>
										</c:if>
										
										<c:if test="${gsRefundPay ne 0 }">
											<li ><span>GS&POINT 환불</span>				<span class="savePoint"><frame:num data="${gsRefundPay}"/>P</span></li>
										</c:if>
										<c:if test="${claimRefundPayVO.mpRefundUseAmt ne 0}">
											<li ><span>우주코인 환불</span>				<span class="savePoint"><frame:num data="${claimRefundPayVO.mpRefundUseAmt}"/>C</span></li>
										</c:if>
									</ul>
									<ul class="prcset" ${prcAreaDisplayStyle}>
										<li>
											<div class="dt">상품 금액</div>
											<div class="dd">
												<span class="prc"><em class="p"><frame:num data="${claimRefundPayVO.goodsAmt}"/></em><i class="w">원</i></span>
											</div>
										</li>
										<li>
											<div class="dt">배송비</div>
											<div class="dd">
												<span class="prc">
													<em class="p">
													<frame:num data="${claimRefundPayVO.orgDlvrcAmt}"/> 
													</em><i class="w">원</i></span>
											</div>
										</li>
										<li>
											<div class="dt">쿠폰 할인</div>
											<div class="dd">
												<span class="prc dis"><em class="p"><c:if test="${claimRefundPayVO.cpDcAmt + claimRefundPayVO.addCpDcAmt > 0}">-</c:if><frame:num data="${claimRefundPayVO.cpDcAmt + claimRefundPayVO.addCpDcAmt}"/></em><i class="w">원</i></span>
											</div>
										</li>
										<c:if test="${(mpRefundPay - claimRefundPayVO.mpRefundUseAmt) ne 0}">
											<li>
												<div class="dt">우주코인 추가할인</div>
												<div class="dd">
													<span class="prc dis"><em class="p">-<frame:num data="${mpRefundPay - claimRefundPayVO.mpRefundUseAmt }"/></em><i class="w">원</i></span>
												</div>
											</li>
										</c:if>
										<c:if test="${claimRefundPayVO.clmDlvrcAmt != 0}">
											<li>
												<div class="dt">추가 배송비
													<div class="alert_pop" data-pop="popCpnGud">
														<div class="bubble_txtBox" style="width:267px;">
															<div class="tit">추가 배송비</div>
															<div class="info-txt">
																<ul>
																	<li>
																		취소/반품/교환 시 발생한 배송비 금액입니다.
																	</li>
																	<li>
																		도서/산간지역의 경우 반품/교환 시 추가 배송비가 발생할 수 있습니다.
																	</li>
																	<li>
																		취소/반품/교환으로 인해 무료배송 조건이 충족되지 못할경우 배송비가 추가로 발생할 수 있습니다.
																	</li>
																</ul>
															</div>
														</div>
													</div>
												</div>
												<div class="dd">
													<span class="prc dis"><em class="p">
														-<frame:num data="${claimRefundPayVO.clmDlvrcAmt}"/>
													</em><i class="w">원</i></span>
												</div>
											</li>
										</c:if>

									</ul>

									<!-- div class="tot">
										<div class="dt">총 결제금액</div>
										<div class="dd">
											<span class="prc"><em class="p">32,500</em><i class="w">원</i></span>
										</div>
									</div -->
								</div>
							</section>
							<!-- 가상계좌로 결제하지 않은 경우 -->
							<c:if test="${setClaimDetailRefund.payMeansCd ne '30' and orderBase.payMeansCd ne frontConstants.PAY_MEANS_00 and orderBase.payMeansCd ne frontConstants.PAY_MEANS_80 and orderBase.payMeansCd ne frontConstants.PAY_MEANS_81}">
							<section class="sect binf">
								<div class="hdts"><span class="tit">환불 수단</span></div>
								<div class="cdts">
									<div class="result">
										<div class="hd"><em class="b" style="color:#669aff;"><frame:codeValue items="${payMeansCdList}" dtlCd="${setClaimDetailRefund.payMeansCd}"/></em>
											<!-- 무통장입금 이외 결제수단 : 신용카드 type 으로 show -->
											<c:if test="${setClaimDetailRefund.payMeansCd ne '20' and !empty(setClaimDetailRefund.orgCardNo)}">
												<i class="t c"><frame:codeValue items="${cardcCdList}" dtlCd="${setClaimDetailRefund.orgCardcCd}"/> (${setClaimDetailRefund.orgCardNo})</i>
											</c:if>
											<!-- 무통장입금 -->
											<c:if test="${setClaimDetailRefund.payMeansCd eq '20' and !empty(setClaimDetailRefund.orgBankCd)}">
												<em class="b">${setClaimDetailRefund.orgOoaNm}</em><i class="t c"><frame:codeValue items="${bankCdList}" dtlCd="${setClaimDetailRefund.orgBankCd}"/></i>
											</c:if>
										</div>
									</div>
								</div>
							</section>
							</c:if>
							<!-- 가상계좌로 결제한 경우 환불계좌 받은 부분 show  -->
							<c:forEach items="${claimRefundPayVO.claimRefundPayDetailListVO}" var="claimRefundPayDetail" varStatus="idx">
								<c:if test="${claimRefundPayDetail.payMeansCd eq '30' && claimRefundPayDetail.payGbCd eq frontConstants.PAY_GB_20}">
									<section class="sect binf">
										<div class="hdts"><span class="tit">환불 계좌</span></div>
										<div class="cdts">
											<div class="result">
												<div class="hd">
													<em class="b" style="color:#669aff;">${claimRefundPayDetail.ooaNm}</em>
													<i class="t c"><frame:codeValue items="${bankCdList}" dtlCd="${claimRefundPayDetail.bankCd}"/>(${claimRefundPayDetail.maskedAcctNo})</i>
												</div>
											</div>
										</div>
									</section>
								</c:if>
							</c:forEach>
							</c:if>

							<c:set value="addr" var="btnClass"/>
							<c:if test="${ setClaimDetailRefund.clmTpCd ne FrontWebConstants.CLM_TP_30}">
								<c:set value="bprc" var="btnClass"/>
							</c:if>
							<section class="sect ${btnClass}">
								<c:if test="${ setClaimDetailRefund.clmTpCd eq FrontWebConstants.CLM_TP_30}">
									<div class="hdts"><span class="tit">교환 배송지</span></div>
									<div class="cdts">
										<div class="adrset">
											<c:choose>
												<c:when test="${empty dlvraInfo and dlvraInfo eq null }">
												
													<div class="name">
														<em class="t g">${rtrnaInfo.gbNm}</em>
													</div>
													<div class="adrs">
														<c:if test="${rtrnaInfo.roadAddr ne null}">
															[<c:out value="${rtrnaInfo.postNoNew}"/>] <c:out value="${rtrnaInfo.roadAddr}"/>, <c:out value="${rtrnaInfo.roadDtlAddr}"/>
														</c:if>
													</div>
												</c:when>
												<c:otherwise>
													<div class="name">
														<em class="t g">${dlvraInfo.gbNm}</em>
													</div>
													<div class="adrs">
														[<c:out value="${dlvraInfo.postNoNew}"/>] <c:out value="${dlvraInfo.roadAddr}"/>, <c:out value="${dlvraInfo.roadDtlAddr}"/>
													</div>
													<div class="tels">${dlvraInfo.adrsNm} | <frame:mobile data="${dlvraInfo.mobile}"/></div>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</c:if>
								<div class="bts">
									<div class="btnSet">
										<a href="/mypage/order/indexClaimList" data-content="" data-url="/mypage/order/indexClaimList" class="btn lg d">취소/반품/교환 목록</a>
										<a href="/shop/home/" class="btn lg b">계속 쇼핑하기</a>
									</div>
								</div>
							</section>

						</div>
					</div>
					<!-- // 주문 배송 -->

				</div>

			</div>
		</main>
		<div class="layers">
			<!-- 04.20 : 추가 -->
			<!-- 쿠폰이용안내 -->
			<!-- @@ PC에선 하단 팝업.  MO에선 툴팁으로 해달래요 ㅜㅜ -->
			<article class="popBot popCpnGud" id="popCpnGud">
				<div class="pbd">
					<div class="phd">
						<div class="in">
							<h1 class="tit">추가 배송비</h1>
							<button type="button" class="btnPopClose">닫기</button>
						</div>
					</div>
					<div class="pct">
						<main class="poptents">
							<ul class="tplist">
								<li>취소/반품/교환 시 발생한 배송비 금액입니다.</li>
								<li>도서/산간지역의 경우 반품/교환 시 추가 배송비가 발생할 수 있습니다.</li>
								<li>취소/반품/교환으로 인해 무료배송 조건이 충족되지 못할경우 배송비가 추가로 발생할 수 있습니다.</li>
							</ul>
						</main>
					</div>
				</div>
			</article>
		</div>

	</tiles:putAttribute>
	</tiles:insertDefinition>