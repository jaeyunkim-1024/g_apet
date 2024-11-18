<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<c:set var="prcAreaDisplayStyle" value="${not empty oldStdOrdNo and oldStdOrdNo < orderBase.ordNo ? '' : 'style=\"display:none;\"' }" />

<jsp:useBean id="now" class="java.util.Date" />

<tiles:insertDefinition name="common">
<tiles:putAttribute name="script.include" value="script.order"/>
<tiles:putAttribute name="script.inline">
<script type="text/javascript" 	src="/_script/cart/cart.js"></script>
<script type="text/javascript">
	/**
	 * 모바일 타이틀 수정
	 */
	$(document).ready(function(){	
		$("#header_pc").removeClass("mode0");
		$("#header_pc").addClass("mode16");
		$("#header_pc").attr("data-header", "set22");
		$("#header_pc").addClass("noneAc");
		$(".mo-heade-tit .tit").html("주문상세");

		if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10}"){
			$("footer").remove();
			$(".menubar").remove();
		}
		
		//상단 뒤로가기 버튼 클릭시
		$(".mo-header-backNtn").removeAttr("onclick");		
		$(".mo-header-backNtn").bind("click", function(){
			fnGoPetsbeDeliveryList();
		});

		var $delBtn = $(".btnSet , .opts");
		$delBtn.not("#continue-btn").remove();
	}); // End Ready


	function fnGoPetsbeDeliveryList(){
		var data = {
			migMemno : "${session.migMemno}"
		};
		createFormSubmit('indexPetsbeDeliveryListForm','/mypage/order/indexPetsbeDeliveryList',data);
	}
</script>
</tiles:putAttribute>

<tiles:putAttribute name="content">

	<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
		<jsp:include page="/WEB-INF/tiles/include/lnb_my.jsp" />
		<jsp:include  page="/WEB-INF/tiles/include/menubar.jsp" />
	</c:if>

	<!-- 바디 - 여기위로 템플릿 -->
	<main class="container lnb page shop order my" id="container">

	<form id="claim_request_list_form">
		<input type="hidden" id="delivery_detail_ord_no" name="ordNo" value="" />
		<input type="hidden" id="delivery_detail_ord_dtl_seq" name="ordDtlSeq" value="" />
		<input type="hidden" id="clm_tp_cd" name="clmTpCd" value=""/>
		<input type="hidden" id="clm_rsn_cd" name="clmRsnCd" value="" />
		<input type="hidden" id="mngb" name="mngb" value="OD" />
	</form>

		<div class="inr">
			<!-- 본문 -->
			<div class="contents" id="contents">
				<!-- PC 타이틀 모바일에서 제거  -->
				<div class="pc-tit">
					<h2>주문 상세</h2>
				</div>
				<!-- // PC 타이틀 모바일에서 제거  -->
				<!-- 주문 배송 -->

				<div class="delivery-oder-area">
				<div class="inr-box border-on">
					<div class="item-list">
						<div class="top b">
							<div class="tit">
								<p class="data"><frame:timestamp date="${orderBase.ordAcptDtm}" dType="C" /></p>
								<span class="icon-left-gap">주문번호 ${orderBase.ordNo}</span>
							</div>
							<c:set var="claimView" value="N" />
							<c:set var="ordAllFlg" value="Y" />
							<c:set var="ord110Flg" value="Y" />	
							
							<c:forEach items="${orderBase.orderCompanyListVO}" var="company">
							<c:forEach items="${company.orderInvoiceListVO}" var="invoice">
							<c:forEach items="${invoice.orderDlvrStatListVO}" var="dlvrStat">
							<c:forEach items="${dlvrStat.orderDetailListVO}" var="orderDetail">
								<c:if test="${orderDetail.ordDtlStatCd ne FrontWebConstants.ORD_DTL_STAT_110 and orderDetail.ordDtlStatCd ne FrontWebConstants.ORD_DTL_STAT_120 and orderDetail.ordDtlStatCd ne FrontWebConstants.ORD_DTL_STAT_130}">
									<c:set var="ordAllFlg" value="N" />
								</c:if>
								<c:if test="${orderDetail.ordDtlStatCd ne FrontWebConstants.ORD_DTL_STAT_110}">
									<c:set var="ord110Flg" value="N" />	
								</c:if>
							</c:forEach>
							<c:forEach items="${dlvrStat.claimDetailListVO}" var="orderDetail">
								<c:set var="ordAllFlg" value="N" />
								<c:if test="${dlvrStat.clmTpCd eq '10' or dlvrStat.clmTpCd eq '20' and dlvrStat.clmStatCd eq '30' and orderDetail.claimDetailVO.clmDtlStatCd eq '260' }">
									<c:set var="claimView" value="Y" />
								</c:if>
							</c:forEach>
							</c:forEach>
							</c:forEach>
							</c:forEach>
						</div>
					<!-- </div> -->
					<c:set var="sumIsuSchdPnt" value="0"/>
					<c:forEach items="${orderBase.orderCompanyListVO}" var="company" varStatus="idx">
					<c:forEach items="${company.orderInvoiceListVO}" var="invoice" varStatus="idx">
					<c:forEach items="${invoice.orderDlvrStatListVO}" var="dlvrStat" varStatus="idx">
					<!-- 파랑 t3   결제완료 배송중 배송준비중   -->
					<!-- 빨강 t4  입금대기 반품신청  반품진행중  교환신청 교환진행중 -->
					<!-- 검정   구매확정 배송완료 반품완료 CLM_DTL_STAT 260 반품거부 250 교환완료 450 교환거부 350  -->
					<!-- 회색 t2 주문취소 110 120 -->
					<c:set var="titClass" value="${dlvrStat.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_110 ? 't4':
					 (dlvrStat.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_120 or dlvrStat.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_140 or dlvrStat.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_150 or dlvrStat.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_130) ? 't3': ''}"/>
					<c:set var="dvlrClass" value="${dlvrStat.dlvrPrcsTpCd eq FrontWebConstants.DLVR_PRCS_TP_10 ? 'icon-t t2': dlvrStat.dlvrPrcsTpCd eq  FrontWebConstants.DLVR_PRCS_TP_20 ? 'icon-t':dlvrStat.dlvrPrcsTpCd eq  FrontWebConstants.DLVR_PRCS_TP_21 ? 'icon-t t3':''}"/>
						<c:if test="${not empty dlvrStat.orderDetailListVO}">
						<c:set var="dlvrDtm" value="" />
						<c:set var="dlvrDtmWeek" value="100" />
						<c:set var="dlvrDtmTxt" value="" />

						<!-- <div class="item-list"> -->
							<div class="bottom">
								<c:set var="isExistOrderDetail" value="N" />
								<c:forEach items="${dlvrStat.orderDetailListVO}" var="orderDetail" varStatus="idx">
									<c:if test="${orderDetail.rmnOrdQty - orderDetail.rtnQty - orderDetail.clmExcIngQty - orderDetail.clmExcCpltQty > 0}">
										<c:set var="isExistOrderDetail" value="Y" />
									</c:if>
								</c:forEach>
								
								<c:if test="${isExistOrderDetail eq 'Y' }">
								<div class="t-box">
										<c:choose>
											<c:when test="${fn:indexOf(session.reqUri,'indexPetsbeDeliveryDetail')>-1 and dlvrStat.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_110}">
												<p class="tit t2">주문취소</p>
											</c:when>
											<c:otherwise>
												<p class="tit ${titClass }"><frame:codeValue items="${ordDtlStatCdList}" dtlCd="${dlvrStat.ordDtlStatCd}" type="S"/></p>
											</c:otherwise>
										</c:choose>
									<p class="icon-t ${dvlrClass }">
										<c:choose>
										<c:when test="${dlvrStat.compGbCd eq '10'}">
											<frame:codeValue items="${ordDtlPrcsTPList}" dtlCd="${dlvrStat.dlvrPrcsTpCd}" type="H"/>
										</c:when>
										<c:otherwise>
											택배배송
										</c:otherwise>
										</c:choose>
									</p>
								</div>

								<c:choose>
									<c:when test="${dlvrStat.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_110 }" >
										<c:set var="ordBankInfo" value="${fn:split(dlvrStat.orderDetailListVO[0].ordBankInfo,'|')}" />
										<c:forEach var="pgBank" items="${ordBankInfo}" varStatus="bnkIdx">
											<c:if test="${bnkIdx.count==1}"><c:set var="ordBankCd" value="${pgBank}" /></c:if>
											<c:if test="${bnkIdx.count==2}"><c:set var="ordBankNum" value="${pgBank}" /></c:if>
											<c:if test="${bnkIdx.count==3}"><c:set var="ordBankCmplDtm" value="${pgBank}" /></c:if>
										</c:forEach>
										<c:if test="${not empty ordBankCd and not empty ordBankCmplDtm}">
											<div class="g-box">
												<p class="lt t2"><frame:codeValue items="${bankCdList}" dtlCd="${ordBankCd}" />&nbsp;${ordBankNum}</p>
												<p class="rt"><frame:timestamp date="${ordBankCmplDtm}" dType="CC" tType="HM" />까지</p>
											</div>
										</c:if>
									</c:when>
									<c:otherwise>
										<div class="g-box">
										<p class="lt">
										<c:choose>
											<c:when test="${dlvrStat.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_160 or dlvrStat.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_170 }" >
												<c:set var="dlvrDtm" value="${dlvrStat.orderDetailListVO[0].dlvrCpltDtm}" />
												<c:set var="dlvrDtmWeek" value="${dlvrStat.orderDetailListVO[0].dlvrCpltDtmWeek}" />
												<c:set var="dlvrDtmTxt" value="배송 완료" />
											</c:when>
											<c:otherwise >
												<c:choose>
													<c:when test="${dlvrStat.orderDetailListVO[0].dlvrPrcsTpCd eq  FrontWebConstants.DLVR_PRCS_TP_10 
													and dlvrStat.compGbCd eq '20'}">
														<c:set var="dlvrDtmTxt" value="배송 평균 2~7일 소요 예정" />
													</c:when>
													<c:when test="${dlvrStat.dlvrPrcsTpCd eq  FrontWebConstants.DLVR_PRCS_TP_10 
															    and  dlvrStat.compGbCd eq '10'      }"> 
																<c:set var="dlvrDtmTxt" value="배송 평균 1~2일 소요 예정" />
															</c:when>
													<c:otherwise >
														<c:set var="dlvrDtm" value="${dlvrStat.orderDetailListVO[0].ordDt}" />
														<c:set var="dlvrDtmWeek" value="${dlvrStat.orderDetailListVO[0].ordDtWeek}" />
														<c:set var="dlvrDtmTxt" value="도착 예정" />
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
										<frame:timestamp date="${dlvrDtm}" dType="KK" />
										<c:choose>
											<c:when test="${dlvrDtmWeek eq 0}" >(월)</c:when>
											<c:when test="${dlvrDtmWeek eq 1}" >(화)</c:when>
											<c:when test="${dlvrDtmWeek eq 2}" >(수)</c:when>
											<c:when test="${dlvrDtmWeek eq 3}" >(목)</c:when>
											<c:when test="${dlvrDtmWeek eq 4}" >(금)</c:when>
											<c:when test="${dlvrDtmWeek eq 5}" >(토)</c:when>
											<c:when test="${dlvrDtmWeek eq 6}" >(일)</c:when>
											<c:otherwise></c:otherwise>
										</c:choose>
											&nbsp;${dlvrDtmTxt}
				
										</p>
										</div>
									</c:otherwise>
								</c:choose>
								</c:if>
								
								<c:forEach items="${dlvrStat.orderDetailListVO}" var="orderDetail" varStatus="idx">
									<c:set var="rmnOrdQty" value="${orderDetail.rmnOrdQty - orderDetail.rtnQty - orderDetail.clmExcIngQty - orderDetail.clmExcCpltQty}" />

<%-- 
예제1) A상품 3개 구매확정후 지급 포인트는 35p

1개 반품완료
	차감 포인트 = 1 / 3 * 35 = 11.6667 을 절하하여 11p 차감처리
	이전 35p에 대해 포인트취소요청하고  35-11 = 24p 포인트지급 요청
	잔여 수량 = 2, 지급포인트 = 24p

1개 추가 반품 완료
	차감 포인트 = 1 / 2 * 24 = 12 을 절하하여 12p 차감처리
	이전 24p에 대해 포인트취소요청하고  24 -12 = 12p  포인트지급 요청
	잔여 수량 = 1, 지급포인트 = 12p

마지막 1개 추가 반품 완료
	차감 포인트 = 1 / 1 * 12 = 12 를 절하하여 12p 차감처리
	이전 12p에 대해 포인트취소요청하고 12-12=0 이므로 포인트지급 요청 하지 않음
	잔여 수량 = 0, 지급포인트 = 0p 
--%>									 
									<c:if test="${rmnOrdQty > 0}">
										<c:set var="sumIsuSchdPnt" value="${sumIsuSchdPnt + orderDetail.isuSchdPnt }" />
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
	<%-- 														${orderDetail.rmnOrdQty - orderDetail.rtnQty - orderDetail.clmExcIngQty}개 --%>
	<!-- 														/ -->
	<%-- 														<c:choose> --%>
	<%-- 														<c:when test="${not empty orderDetail.optGoodsNm}" > --%>
	<%-- 															옵션 : ${orderDetail.optGoodsNm } --%>
	<%-- 														</c:when> --%>
	<%-- 														<c:when test="${fn:length(orderDetail.pakItemNm) > 0 }" > --%>
	<%-- 														<c:forTokens var="goodsOpt" items="${orderDetail.pakItemNm }" delims="|" varStatus="pakStatus"> --%>
	<%-- 															${goodsOpt} --%>
	<%-- 														</c:forTokens> --%>
	<%-- 														</c:when> --%>
	<%-- 														<c:otherwise> --%>
	<%-- 															${orderDetail.itemNm} --%>
	<%-- 														</c:otherwise> --%>
	<%-- 														</c:choose> --%>
															${rmnOrdQty}개 
															<c:choose>
																<c:when test="${orderDetail.goodsCstrtTpCd eq FrontWebConstants.GOODS_CSTRT_TP_PAK && not empty orderDetail.optGoodsNm}">	<!-- 상품 구성 유형 : 묶음 -->
																/ ${fn:replace(orderDetail.optGoodsNm, '/', ' / ')}
																</c:when>
																<c:when test="${orderDetail.goodsCstrtTpCd eq FrontWebConstants.GOODS_CSTRT_TP_ATTR && not empty orderDetail.pakItemNm}">	<!-- 상품 구성 유형 : 옵션 -->
																/ ${fn:replace(orderDetail.pakItemNm, '|', ' / ')}
																</c:when>
															</c:choose>
														</div>
														<c:if test="${orderDetail.mkiGoodsYn eq 'Y' && not empty orderDetail.mkiGoodsOptContent }">
														<c:forTokens var="optContent" items="${orderDetail.mkiGoodsOptContent }" delims="|" varStatus="conStatus">
															<div class="stt">각인문구${conStatus.count} : ${optContent}</div>
														</c:forTokens>
														</c:if>
														<div class="prcs">
															<span class="prc"><em class="p"><frame:num data="${orderDetail.saleAmt * rmnOrdQty }" /></em><i class="w">원</i></span>
														</div>
													</div>
												</div>
											</div>
										</div>
										<c:if test="${not empty orderDetail.subGoodsNm}">
											<div class="b-txt">
												<strong class="tit">사은품</strong> ${fn:replace(orderDetail.subGoodsNm , "," ,", ")}												
											</div>
										</c:if>
										 <c:set var="btnSetClass" value="${(orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_120
											or orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_130)
											and orderDetail.rmnOrdQty > 0 ? '':'pc-t2'}" /> 
	
										<%--<div class="btn-bx ${btnSetClass}">
											<div class="btnSet">
												<c:if test="${(orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_120 or orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_130)
													and orderDetail.rmnOrdQty > 0}">
													<a href="#" class="btn c" data-content="${orderBase.ordNo}" data-url="/mypage/order/indexCancelRequest" onclick="orderDeliveryDetailBtn.goCancelRequest('${orderBase.ordNo}', '${orderDetail.ordDtlSeq}');return false;">주문취소</a>
												</c:if>
												<c:if test="${orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_160}">
												<c:if test="${orderDetail.rmnOrdQty - orderDetail.rtnQty - orderDetail.clmExcIngQty - orderDetail.clmExcCpltQty > 0 }">
													<a href="#" class="btn c" data-content="${orderBase.ordNo}" data-url="/mypage/order/indexExchangeRequest" onclick="orderDeliveryDetailBtn.goReturnRequest('${orderBase.ordNo}','${orderDetail.ordDtlSeq}' , '${orderDetail.clmIngYn}', '${orderDetail.rtnIngYn}', '${orderDetail.rtnPsbYn}');return false;">반품신청</a>
													<a href="#" class="btn c" data-content="${orderBase.ordNo}" data-url="/mypage/order/indexReturnRequest" onclick="orderDeliveryDetailBtn.goExchangeRequest('${orderBase.ordNo}','${orderDetail.ordDtlSeq}', '${orderDetail.clmIngYn }', '${orderDetail.rtnIngYn}');return false;">교환신청</a>
												</c:if>
												</c:if>
												<c:if test="${orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_170}">
												<c:if test="${session.mbrNo ne FrontWebConstants.NO_MEMBER_NO }">
													<c:if test="${ orderDetail.goodsEstmRegYn ne FrontWebConstants.COMM_YN_Y  }">
														<a href="#" data-content="${orderBase.ordNo}" data-url="/mypage/service/popupGoodsCommentReg" onclick="orderDeliveryDetailBtn.openGoodsComment('${orderDetail.goodsId}','${orderBase.ordNo}','${orderDetail.ordDtlSeq}', '', '');return false;" class="btn c completeBtn">후기작성</a>
													</c:if>
													<c:if test="${ orderDetail.goodsEstmRegYn eq FrontWebConstants.COMM_YN_Y  }">
														<a href="#" data-content="${orderBase.ordNo}" data-url="/mypage/service/popupGoodsCommentReg" onclick="orderDeliveryDetailBtn.openGoodsComment('${orderDetail.goodsId}','${orderBase.ordNo}','${orderDetail.ordDtlSeq}', '${orderDetail.goodsEstmNo}', '${orderDetail.goodsEstmTp}' );return false;" class="btn c completeBtn">후기수정</a>
													</c:if>
													<a href="#" onclick="cartGoods.insertCart('${orderDetail.goodsId}', '${orderDetail.itemNo }', '${orderDetail.pakGoodsId }');" data-content="${orderDetail.goodsId}" data-url="${view.stDomain}/order/indexCartList/" class="btn c">장바구니 담기</a>
												</c:if>
												</c:if>
												<a href="/customer/inquiry/inquiryView?popupChk=popOpen" data-content="${orderBase.ordNo}" data-url="/customer/inquiry/inquiryView" class="btn c">고객센터 문의</a>
											</div>
											<c:if test="${orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_150 || orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_160}">
											<c:if test="${orderDetail.clmIngYn eq FrontWebConstants.COMM_YN_N and orderDetail.vldOrdQty > 0 }">
												<div class="btnSet">
													<a href="#" class="btn b completeBtn" data-content="${orderBase.ordNo}" data-url="/mypage/order/purchaseProcess" onclick="orderDeliveryDetailBtn.purchase('<c:out value='${orderBase.ordNo}' />', '<c:out value='${orderDetail.ordDtlSeq}' />', '<c:out value='${orderDetail.ordDtlStatCd}' />');return false;">구매확정</a>
												</div>
											</c:if>
											</c:if>
										</div>--%>
									</div>
									</c:if>
								</c:forEach>
							</div>
						<!-- </div> -->
						</c:if>

						<%-- 클레임리스트 --%>
						<c:if test="${not empty dlvrStat.claimDetailListVO}">
						<!-- <div class="item-list"> -->
							<div class="bottom">
								<div class="t-box">
									<c:set var="clmTitClass" value="${( dlvrStat.viewClmDtlStatCd eq FrontWebConstants.CLM_DTL_STAT_110 or dlvrStat.viewClmDtlStatCd eq FrontWebConstants.CLM_DTL_STAT_120 ) ? 't2':
										 (dlvrStat.viewClmDtlStatCd eq FrontWebConstants.CLM_DTL_STAT_250 or dlvrStat.viewClmDtlStatCd eq FrontWebConstants.CLM_DTL_STAT_260 or dlvrStat.viewClmDtlStatCd eq FrontWebConstants.CLM_DTL_STAT_350 or dlvrStat.viewClmDtlStatCd eq FrontWebConstants.CLM_DTL_STAT_450) ? '': 't4'}"/>
									<p class="tit ${clmTitClass }">
										<frame:codeValue items="${clmDtlStatCdList}" dtlCd="${dlvrStat.viewClmDtlStatCd}" type="S"/>
									</p>
									<p class="icon-t ${dvlrClass }">
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
<%-- 														<c:choose> --%>
<%-- 														<c:when test="${not empty orderDetail.optGoodsNm}" > --%>
<%-- 															옵션 : ${orderDetail.optGoodsNm } --%>
<%-- 														</c:when> --%>
<%-- 														<c:when test="${fn:length(orderDetail.pakItemNm) > 0 }" > --%>
<%-- 														<c:forTokens var="goodsOpt" items="${orderDetail.pakItemNm }" delims="|" varStatus="pakStatus"> --%>
<%-- 															${goodsOpt} --%>
<%-- 														</c:forTokens> --%>
<%-- 														</c:when> --%>
<%-- 														<c:otherwise> --%>
<%-- 															${orderDetail.itemNm} --%>
<%-- 														</c:otherwise> --%>
<%-- 														</c:choose> --%>
														<c:choose>
															<c:when test="${orderDetail.goodsCstrtTpCd eq FrontWebConstants.GOODS_CSTRT_TP_PAK && not empty orderDetail.optGoodsNm}">	<!-- 상품 구성 유형 : 묶음 -->
															/ ${fn:replace(orderDetail.optGoodsNm, '/', ' / ')}
															</c:when>
															<c:when test="${orderDetail.goodsCstrtTpCd eq FrontWebConstants.GOODS_CSTRT_TP_ATTR && not empty orderDetail.pakItemNm}">	<!-- 상품 구성 유형 : 옵션 -->
															/ ${fn:replace(orderDetail.pakItemNm, '|', ' / ')}
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
											<strong class="tit">사은품</strong> ${fn:replace(orderDetail.subGoodsNm , "," ,", ")}
										</div>
									</c:if>
									<div class="btn-bx pc-t2">
										<div class="btnSet">
											<a href="#" data-content="${orderDetail.claimDetailVO.clmNo}" data-url="/mypage/order/indexClaimDetail?clmNo=${orderDetail.claimDetailVO.clmNo}"
												onclick="orderDeliveryDetailBtn.goOrderClaimDetail('${orderDetail.claimDetailVO.clmNo}','${dlvrStat.clmTpCd}' )"
												class="btn c">
												<frame:codeValue items="${clmTpCdList}" dtlCd="${dlvrStat.clmTpCd}"  type="S"/> 상세
											</a>
										</div>
									</div>
								</div>
								</c:forEach>
							</div>
						<!-- </div> -->
						</c:if>

					</c:forEach>
					</c:forEach>
					</c:forEach>
					</div>
					</div>
					
					<div class="ordersets pc-cut">
						<section class="sect addr">
							<div class="hdts"><span class="tit">배송지</span></div>
							<div class="cdts">
								<div class="adrset">
									<div class="name">
										<em class="t g"><c:if test="${not empty orderDlvraInfo.gbNm }" ><c:out value="${orderDlvraInfo.escapedGbNm}" escapeXml="false" /></c:if></em>
									</div>
									<div class="adrs">
										[<c:out value="${orderDlvraInfo.postNoNew}"/>] <c:out value="${orderDlvraInfo.roadAddr}" /> <c:out value="${orderDlvraInfo.escapedRoadDtlAddr}" escapeXml="false"/>
									</div>
									<div class="tels"><c:out value="${orderDlvraInfo.escapedAdrsNm}" escapeXml="false" />/<frame:mobile data="${orderDlvraInfo.mobile}" /></div>
								</div>


								<c:choose>
									<c:when test="${not empty orderDlvraInfo.goodsRcvPstCd and not empty orderDlvraInfo.pblGateEntMtdCd}">
										<div class="adrreq ${orderDlvraInfo.goodsRcvPstCd}">
											<!-- 배송요청사항 노출을 위해 주석 -->
											<div class="pwf">
												<em class="t">
													<c:choose>
														<c:when test="${orderDlvraInfo.goodsRcvPstCd eq FrontWebConstants.GOODS_RCV_PST_40 }" >
															<c:out value="${orderDlvraInfo.escapedGoodsRcvPstEtc}" escapeXml="false" />
														</c:when>
														<c:otherwise>
															<frame:codeValue items="${goodsRcvPstList}" dtlCd="${orderDlvraInfo.goodsRcvPstCd}" />
														</c:otherwise>
													</c:choose>
												</em>
												<em class="p">
													<frame:codeValue items = "${pblGateEntMtdList}" dtlCd="${orderDlvraInfo.pblGateEntMtdCd }"/>&nbsp;
													<c:if test="${orderDlvraInfo.pblGateEntMtdCd eq frontConstants.PBL_GATE_ENT_MTD_10}">
														<c:out value="${orderDlvraInfo.escapedPblGatePswd}" escapeXml="false"/>
													</c:if>
												</em>
												<c:if test="${not empty orderDlvraInfo.escapedDlvrMemo}">
													<div class="txt custom_ellipsis_dlvr"><c:out value="${orderDlvraInfo.escapedDlvrMemo}" escapeXml="false"/></div>
												</c:if>
											</div>
												<%-- </c:if> --%>
											<c:if test="${not empty orderDlvraInfo.dlvrCpltPicUrl }">
												<div class="if_add_pic">
													<ul>
														<li><img src="${orderDlvraInfo.dlvrCpltPicUrl}" alt="배송완료  이미지" onClick="ui.addPopPic(this)"></li>
													</ul>
												</div>
											</c:if>
										</div>
									</c:when>
									<c:when test="${not empty orderDlvraInfo.goodsRcvPstCd or not empty orderDlvraInfo.pblGateEntMtdCd}">
										<div class="adrreq ${orderDlvraInfo.goodsRcvPstCd}">
											<!-- 배송요청사항 노출을 위해 주석 -->
											<div class="pwf">
												<em class="t">
													<c:if test="${not empty orderDlvraInfo.goodsRcvPstCd}">
														<c:choose>
															<c:when test="${orderDlvraInfo.goodsRcvPstCd eq FrontWebConstants.GOODS_RCV_PST_40 }" >
																<c:out value="${orderDlvraInfo.escapedGoodsRcvPstEtc}" escapeXml="false" />
															</c:when>
															<c:otherwise>
																<frame:codeValue items="${goodsRcvPstList}" dtlCd="${orderDlvraInfo.goodsRcvPstCd}" />
															</c:otherwise>
														</c:choose>
													</c:if>
													<c:if test="${not empty orderDlvraInfo.pblGateEntMtdCd}">
														<frame:codeValue items = "${pblGateEntMtdList}" dtlCd="${orderDlvraInfo.pblGateEntMtdCd }"/>&nbsp;
														<c:if test="${orderDlvraInfo.pblGateEntMtdCd eq frontConstants.PBL_GATE_ENT_MTD_10}">
															<c:out value="${orderDlvraInfo.escapedPblGatePswd}" escapeXml="false"/>
														</c:if>
													</c:if>
												</em>
												<c:if test="${not empty orderDlvraInfo.escapedDlvrMemo}">
													<div class="txt custom_ellipsis_dlvr"><c:out value="${orderDlvraInfo.escapedDlvrMemo}" escapeXml="false"/></div>
												</c:if>
											</div>
												<%-- </c:if> --%>
											<c:if test="${not empty orderDlvraInfo.dlvrCpltPicUrl }">
												<div class="if_add_pic">
													<ul>
														<li><img src="${orderDlvraInfo.dlvrCpltPicUrl}" alt="배송완료  이미지" onClick="ui.addPopPic(this)"></li>
													</ul>
												</div>
											</c:if>
										</div>
									</c:when>
									<c:otherwise>
										<c:if test="${not empty orderDlvraInfo.escapedDlvrMemo}">
										<div class="adrreq">
											<div class="txt custom_ellipsis_dlvr"><c:out value="${orderDlvraInfo.escapedDlvrMemo}" escapeXml="false"/></div>
										</div>
										</c:if>
									</c:otherwise>
								</c:choose>
							</div>
						</section>
						<section class="sect bprc">
							<div class="hdts"><span class="tit">결제 정보</span></div>
							<div class="cdts">
								<ul class="prcset">

								<c:if test="${claimView eq 'Y'}">
									<li class="tit k0420">
										<div class="dt">최초 결제 정보</div>
										<div class="dd">
											<span class="prc"><em class="p"><frame:num data="${frontPayInfo.orgPayAmt}" /></em><i class="w">원</i></span>
										</div>
									</li>
								</c:if>
									<li ${prcAreaDisplayStyle}>
										<div class="dt">상품금액</div>
										<div class="dd">
											<span class="prc"><em class="p"><frame:num data="${frontPayInfo.orgGoodsAmt}" /></em><i class="w">원</i></span>
										</div>
									</li>
									<li ${prcAreaDisplayStyle}>
										<div class="dt">배송비</div>
										<div class="dd">
											<span class="prc"><em class="p"><frame:num data="${frontPayInfo.orgDlvrAmt}" /></em><i class="w">원</i></span>
										</div>
									</li>
									<li ${prcAreaDisplayStyle}>
										<div class="dt">쿠폰 할인</div>
										<div class="dd">
											<span class="prc dis"><em class="p"><frame:num data="${frontPayInfo.orgCpDcAmt}"/></em><i class="w">원</i></span>
										</div>
									</li>
									<li>
										<div class="dt">포인트 사용</div>
										<div class="dd">
											<span class="prc dis"><em class="p"><frame:num data="${frontPayInfo.orgPnt}"/></em><i class="w">P</i></span>
										</div>
									</li>
								</ul>

								<div class="tot">
									<div class="dt">총 결제금액</div>
									<div class="dd">
										<span class="prc"><em class="p"><frame:num data="${frontPayInfo.finalPayAmt}" /></em><i class="w">원</i></span>
									</div>
								</div>
							</div>
						</section>
							<c:set var="size" value="${fn:length(payInfoList)}"/>
							<c:if test="${size gt 0}">
								<section class="sect binf">
									<div class="hdts"><span class="tit">결제 수단</span></div>
									<div class="cdts">
										<c:forEach var="payInfo" items="${payInfoList}">
											<div class="result">
												<div class="hd">
													<em class="b"><frame:codeValue items="${payMeansCdList}" dtlCd="${payInfo.payMeansCd}" /></em>
												</div>
												<div class="dd">
													<c:if test="${'fc' eq payInfo.payMeansCd or 'pc' eq payInfo.payMeansCd}">
														<!-- 신용카드 -->
														<frame:codeValue items="${cardcCdList}" dtlCd="${payInfo.cardcCd}"/>
														<c:if test="${not empty payInfo.maskedCardNo}">(${payInfo.maskedCardNo})</c:if> /
														<c:choose>
															<c:when test="${payInfo.instmntInfo eq FrontWebConstants.SINGLE_INSTMNT or empty payInfo.instmntInfo }">
																일시불
															</c:when>
															<c:otherwise>
																<c:if test="${payInfo.fintrYn eq FrontWebConstants.COMM_YN_Y}">무이자 할부 </c:if> ${payInfo.instmntInfo}개월
															</c:otherwise>
														</c:choose>
													</c:if>

													<!-- 실시간계좌이체/가상계좌/무통장 -->
													<c:if test="${payInfo.payMeansCd eq 'eb' or payInfo.payMeansCd eq 'fb' or payInfo.payMeansCd eq 'pb' or payInfo.payMeansCd eq 'eb'
														or payInfo.payMeansCd eq 'fv' or payInfo.payMeansCd eq 'pv' or payInfo.payMeansCd eq 'gb'}">

														<frame:codeValue items="${bankCdList}" dtlCd="${payInfo.bankCd}"/>

														<c:if test="${payInfo.payMeansCd ne 'eb' and payInfo.payMeansCd ne 'fb' and payInfo.payMeansCd ne 'pb' or payInfo.payMeansCd eq 'eb'
														or payInfo.payMeansCd eq 'fv' or payInfo.payMeansCd eq 'pv' or payInfo.payMeansCd eq 'gb'}">
															(<c:out value="${payInfo.acctNo}"/>) /
														</c:if>

														<c:if test="${payInfo.payMeansCd ne 'eb' and payInfo.payMeansCd ne 'fb' and payInfo.payMeansCd ne 'pb'
												and FrontWebConstants.PAY_STAT_00 eq payInfo.payStatCd}">
															<c:choose>
																<c:when test="${not empty orderBase.clmRsnCd}">
																	미입금 취소
																</c:when>
																<c:otherwise>
																	입금대기 <frame:timestamp date="${payInfo.dpstSchdDt}" dType="CC" tType="HM" />까지
																</c:otherwise>
															</c:choose>
														</c:if>
														<c:if test="${payInfo.payMeansCd ne 'eb' and payInfo.payMeansCd ne 'fb' and payInfo.payMeansCd ne 'pb'
												and FrontWebConstants.PAY_STAT_01 eq payInfo.payStatCd}">
															입금완료
														</c:if>
													</c:if>
												</div>
											</div>
										</c:forEach>
									</div>
								</section>
							</c:if>

						<c:if test="${sumIsuSchdPnt ne 0}">
						<section class="sect bprc">
							<div class="hdts"><span class="tit">포인트 적립/혜택</span></div>
							<div class="cdts">
								<ul class="prcset">
									<li>
										<div class="dt">GS&POINT 적립
											<span class="alert_pop" data-pop="popCpnGud">
												<span class="bubble_txtBox" style="width:267px;">
													<span class="tit">구매 적립</span>
													<span class="info-txt">
														<span>
															<span>
																결제 금액 기준 총 적립 포인트입니다.
															</span>
															<span>
																포인트는 구매확정 시 지급됩니다.
															</span>
															<span>
																적립 포인트 산정 시 쿠폰 할인 금액, 배송비, 취소/반품 상품 금액은 제외됩니다.
															</span>
														</span>
													</span>
												</span>
											</span>
										</div>
										<div class="dd">
											<span class="prc">
												<em class="p">
													<fmt:formatNumber value="${sumIsuSchdPnt}" />
												</em>
												<i class="w">P</i>
											</span>
										</div>
									</li>
								</ul>
							</div>
							</section>
							</c:if>
							<div class="my_btnWrap t2">
								<div class="btnSet" id="continue-btn">
									<a href="javascript:void(0);" data-content="" onclick="fnGoPetsbeDeliveryList();" data-url="/mypage/order/indexDeliveryList" class="btn lg d">주문/배송 목록</a>
									<a href="/shop/home/" class="btn lg b">계속 쇼핑하기</a>
								</div>
							</div>
						
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
						<h1 class="tit">이용안내</h1>
						<button type="button" class="btnPopClose">닫기</button>
					</div>
				</div>
				<div class="pct">
					<main class="poptents">
						<ul class="tplist">
							<li>결제 금액 기준 총 적립 포인트입니다.</li>
							<li>포인트는 구매확정 시 지급됩니다.</li>
							<li>적립 포인트 산정 시 쿠폰 할인 금액, 배송비, 취소/반품 상품 금액은 제외됩니다.</li>
						</ul>
					</main>
				</div>
			</div>
		</article>
	</div>
	<!-- 바디 - 여기 밑으로 템플릿 -->


</tiles:putAttribute>
</tiles:insertDefinition>