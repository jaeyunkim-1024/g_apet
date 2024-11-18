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
		//debugger;
		//상단 뒤로가기 버튼 클릭시      
        $(".mo-header-backNtn").bind("click", function(){
            if("${mngb}" == "OL"){
                storageHist.goBack();
            } else if("${mngb}" == "OD") {               
                storageHist.goBack('/mypage/order/indexDeliveryList');
            } else {
                storageHist.goBack();
            }
        });
	}); // End Ready

	$(function() {
		
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
	
	//주문삭제
	function goOrderDelete(ordNo){
		var url = window.location.href;
		ui.confirm("<spring:message code='front.web.view.order.claimlist.deletedorderlists.never.be.back' />" + "<spring:message code='front.web.view.order.claimlist.want.to.delete.deletedorderlists' />",{ // 컨펌 창 띄우기
			ycb:function(){
				var options = {
					   url : "<spring:url value='/mypage/order/ordDeleteProcess' />"
						, data : { ordNo : ordNo}
						, done : function(data){									
							if(url.indexOf("mngb") == -1){
								location.href="/mypage/order/indexClaimList";					
							}else if(url.indexOf("mngb") > -1){
								location.href="/mypage/order/indexDeliveryList";
							}
						}
					}; 
				ajax.call(options);									
			},					
			ybt:'<spring:message code='front.web.view.common.yes' />',
			nbt:'<spring:message code='front.web.view.common.no' />'
		});	
	}
	
	// 장바구니 담기
	function insertCart(goodsId, itemNo, pakGoodsId, ordmkiYn) {
		if(ordmkiYn != 'Y') {
			var goodsInfo = goodsId+":"+itemNo+":" + (pakGoodsId ? pakGoodsId : "");
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
							<!-- 전체 구매확정 여부 -->
							<c:set var="allCompleteYn" value="Y" />	
							
							<c:forEach items="${orderBase.orderCompanyListVO}" var="company">
							<c:forEach items="${company.orderInvoiceListVO}" var="invoice">
							<c:forEach items="${invoice.orderDlvrStatListVO}" var="dlvrStat">
							<c:forEach items="${dlvrStat.orderDetailListVO}" var="orderDetail">
								<%-- <c:if test="${orderDetail.clmIngYn eq 'Y'}">
									<c:set var="claimView" value="Y" />
								</c:if> --%>
								<c:if test="${orderDetail.ordDtlStatCd ne FrontWebConstants.ORD_DTL_STAT_170 and (orderDetail.rmnOrdQty - orderDetail.rtnQty  gt 0 or orderDetail.clmIngYn eq 'Y') }">
									<c:set var="allCompleteYn" value="N" />	
								</c:if>
								<c:if test="${orderDetail.ordDtlStatCd ne FrontWebConstants.ORD_DTL_STAT_110 and orderDetail.ordDtlStatCd ne FrontWebConstants.ORD_DTL_STAT_120 and orderDetail.ordDtlStatCd ne FrontWebConstants.ORD_DTL_STAT_130}">
									<c:set var="ordAllFlg" value="N" />
								</c:if>
								<c:if test="${orderDetail.ordDtlStatCd ne FrontWebConstants.ORD_DTL_STAT_110}">
									<c:set var="ord110Flg" value="N" />	
								</c:if>
							</c:forEach>
							<c:forEach items="${dlvrStat.claimDetailListVO}" var="orderDetail">
								<c:set var="ordAllFlg" value="N" />
								<%-- <c:set var="claimView" value="Y" /> --%>
								
								<c:if test="${dlvrStat.clmTpCd eq '10' or dlvrStat.clmTpCd eq '20' and dlvrStat.clmStatCd eq '30' and orderDetail.claimDetailVO.clmDtlStatCd eq '260' }">
									<c:set var="claimView" value="Y" />
								</c:if>
								<c:if test="${dlvrStat.clmStatCd eq FrontWebConstants.CLM_STAT_10 or dlvrStat.clmStatCd eq FrontWebConstants.CLM_STAT_20}">
									<c:set var="allCompleteYn" value="N" />	
								</c:if>
							</c:forEach>
							</c:forEach>
							</c:forEach>
							</c:forEach>
							<c:if test="${orderBase.cncPsbYn eq FrontWebConstants.COMM_YN_Y and ordAllFlg eq 'Y'}">						<!-- 주문 취소 가능 여부 eq Y -->
								<c:choose>
									<c:when test="${ord110Flg eq 'Y'}">
										<a href="javascript:void(0);" class="btn sm" data-content="${orderBase.ordNo}" data-url="/mypage/order/insertClaimCancelExchangeRefund" onclick="orderDeliveryDetailBtn.goCancelAllRequest('${orderBase.ordNo}');return false;">전체주문취소</a>
									</c:when>
									<c:otherwise>
										<a href="javascript:void(0);" class="btn sm" data-content="${orderBase.ordNo}" data-url="/mypage/order/indexCancelRequest" onclick="orderDeliveryDetailBtn.goCancelRequest('${orderBase.ordNo}', '');return false;">전체주문취소</a>
									</c:otherwise>
								</c:choose>
							</c:if>
							<c:if test="${orderBase.ordDeleteFlg eq 'Y'}">
								<a href="javascript:void(0);" class="btn sm" data-content="${orderBase.ordNo}" data-url="/mypage/order/orderDelete" onclick="goOrderDelete('${orderBase.ordNo}');return false;">주문내역삭제</a>
							</c:if>
						</div>
					<!-- </div> -->
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
									<p class="tit ${titClass }"><frame:codeValue items="${ordDtlStatCdList}" dtlCd="${dlvrStat.ordDtlStatCd}" type="S"/></p>
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

								<div class="g-box">
								<c:choose>
									<c:when test="${dlvrStat.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_110 }" >
										<c:set var="ordBankInfo" value="${fn:split(dlvrStat.orderDetailListVO[0].ordBankInfo,'|')}" />
										<c:forEach var="pgBank" items="${ordBankInfo}" varStatus="bnkIdx">
											<c:if test="${bnkIdx.count==1}"><c:set var="ordBankCd" value="${pgBank}" /></c:if>
											<c:if test="${bnkIdx.count==2}"><c:set var="ordBankNum" value="${pgBank}" /></c:if>
											<c:if test="${bnkIdx.count==3}"><c:set var="ordBankCmplDtm" value="${pgBank}" /></c:if>
										</c:forEach>
										<p class="lt t2"><frame:codeValue items="${bankCdList}" dtlCd="${ordBankCd}" />&nbsp;${ordBankNum}</p>
										<p class="rt"><frame:timestamp date="${ordBankCmplDtm}" dType="CC" tType="HM" />까지</p>
									</c:when>
									<c:otherwise>
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
										<c:if test="${dlvrStat.dlvrPrcsTpCd eq  FrontWebConstants.DLVR_PRCS_TP_10}">	<!--택배배송일때만 배송조회  -->
											<c:if test="${(dlvrStat.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_150 or dlvrStat.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_160 or dlvrStat.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_170) and dlvrStat.dlvrInvNo != null}">
												<a href="javascript:;" class="detail-btn" data-target="order" data-action="goodsflow" data-url="https://${pageContext.request.serverName }/mypage/order/goodsflow/${dlvrStat.orderDetailListVO[0].dlvrNo}" >배송조회</a>
											</c:if>
										</c:if>
				
									</c:otherwise>
								</c:choose>

								</div>
								</c:if>
								
								<c:forEach items="${dlvrStat.orderDetailListVO}" var="orderDetail" varStatus="idx">
									<c:set var="rmnOrdQty" value="${orderDetail.rmnOrdQty - orderDetail.rtnQty - orderDetail.clmExcIngQty - orderDetail.clmExcCpltQty}" />
									<c:if test="${rmnOrdQty > 0}">
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
	
										<div class="btn-bx ${btnSetClass}">
											<div class="btnSet">
												<c:if test="${(orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_120 or orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_130)
													and orderDetail.rmnOrdQty > 0}">
													<a href="javascript:void(0);" class="btn c" data-content="${orderBase.ordNo}" data-url="/mypage/order/indexCancelRequest" onclick="orderDeliveryDetailBtn.goCancelRequest('${orderBase.ordNo}', '${orderDetail.ordDtlSeq}');return false;">주문취소</a>
												</c:if>
												<c:if test="${orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_160}">
												<c:if test="${orderDetail.rmnOrdQty - orderDetail.rtnQty - orderDetail.clmExcIngQty - orderDetail.clmExcCpltQty > 0 }">
													<a href="javascript:void(0);" class="btn c" data-content="${orderBase.ordNo}" data-url="/mypage/order/indexExchangeRequest" onclick="orderDeliveryDetailBtn.goReturnRequest('${orderBase.ordNo}','${orderDetail.ordDtlSeq}' , '${orderDetail.clmIngYn}', '${orderDetail.rtnIngYn}', '${orderDetail.rtnPsbYn}');return false;">반품신청</a>
													<a href="javascript:void(0);" class="btn c" data-content="${orderBase.ordNo}" data-url="/mypage/order/indexReturnRequest" onclick="orderDeliveryDetailBtn.goExchangeRequest('${orderBase.ordNo}','${orderDetail.ordDtlSeq}', '${orderDetail.clmIngYn }', '${orderDetail.rtnIngYn}');return false;">교환신청</a>
												</c:if>
												</c:if>
												
												<c:if test="${orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_170}">
													<c:if test="${session.mbrNo ne FrontWebConstants.NO_MEMBER_NO }">
														<a href="javascript:void(0);"  onclick="insertCart('${orderDetail.goodsId}', '${orderDetail.itemNo}', '${orderDetail.pakGoodsId }' , '${empty orderDetail.mkiGoodsYn ? 'N' : orderDetail.mkiGoodsYn}')"; data-url="${view.stDomain}/order/indexCartList/" class="btn c">장바구니 담기</a>
													</c:if>
												</c:if>
												<a href="/customer/inquiry/inquiryView?popupChk=popOpen" data-content="${orderBase.ordNo}" data-url="/customer/inquiry/inquiryView" class="btn c">고객센터 문의</a>
											</div>
											<c:if test="${orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_150 || orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_160 || orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_170}">
												<c:if test="${orderDetail.clmIngYn eq FrontWebConstants.COMM_YN_N and orderDetail.vldOrdQty > 0 }">
													<div class="btnSet">
													<c:if test="${orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_160 or orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_150}">
														<a href="javascript:void(0);" class="btn b completeBtn" data-content="${orderBase.ordNo}" data-url="/mypage/order/purchaseProcess" onclick="orderDeliveryDetailBtn.purchase('<c:out value='${orderBase.ordNo}' />', '<c:out value='${orderDetail.ordDtlSeq}' />', '<c:out value='${orderDetail.ordDtlStatCd}' />');return false;">구매확정</a>
													</c:if>
												<c:if test="${  orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_170}">	
												<c:if test="${ orderDetail.goodsEstmRegYn ne FrontWebConstants.COMM_YN_Y  }">
														<a href="javascript:void(0);" data-content="${orderBase.ordNo}" data-url="/mypage/service/popupGoodsCommentReg" onclick="orderDeliveryDetailBtn.openGoodsComment('${orderDetail.goodsId}','${orderBase.ordNo}','${orderDetail.ordDtlSeq}', '', '');return false;" class="btn c completeBtn">후기작성</a>
												</c:if>
												<c:if test="${ orderDetail.goodsEstmRegYn eq FrontWebConstants.COMM_YN_Y  }">
														<a href="javascript:void(0);" data-content="${orderBase.ordNo}" data-url="/mypage/service/popupGoodsCommentReg" onclick="orderDeliveryDetailBtn.openGoodsComment('${orderDetail.goodsId}','${orderBase.ordNo}','${orderDetail.ordDtlSeq}', '${orderDetail.goodsEstmNo}', '${orderDetail.goodsEstmTp}' );return false;" class="btn c completeBtn">후기수정</a>
												</c:if>
												</c:if>
												</div>
											</c:if>
											</c:if>
										</div>
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

								<!-- 00원 결제 혹은 포인트로만 결제 -->
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
											<a href="javascript:void(0);" data-content="${orderDetail.claimDetailVO.clmNo}" data-url="/mypage/order/indexClaimDetail?clmNo=${orderDetail.claimDetailVO.clmNo}"
												onclick="orderDeliveryDetailBtn.goOrderClaimDetail('${orderDetail.claimDetailVO.clmNo}','${dlvrStat.clmTpCd}' )"
												class="btn c">
												<frame:codeValue items="${clmTpCdList}" dtlCd="${dlvrStat.clmTpCd}"  type="S"/> 상세
											</a>
											
											<c:if test="${session.mbrNo ne FrontWebConstants.NO_MEMBER_NO }">
											
											<c:if test="${dlvrStat.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_160 && dlvrStat.clmTpCd eq FrontWebConstants.CLM_TP_20 &&
											dlvrStat.viewClmDtlStatCd eq FrontWebConstants.CLM_DTL_STAT_260}">
												<a href="javascript:void(0);" onclick="insertCart('${orderDetail.goodsId}', '${orderDetail.itemNo}', '${orderDetail.pakGoodsId }' , '${empty orderDetail.mkiGoodsYn ? 'N' : orderDetail.mkiGoodsYn}')"; data-content="${orderDetail.goodsId}" data-url="${view.stDomain}/order/indexCartList/" class="btn c">장바구니 담기</a>
											</c:if>
											
											<c:if test="${dlvrStat.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_160 && dlvrStat.clmTpCd eq FrontWebConstants.CLM_TP_30 &&
											dlvrStat.viewClmDtlStatCd eq FrontWebConstants.CLM_DTL_STAT_450}">
												<a href="javascript:void(0);" onclick="insertCart('${orderDetail.goodsId}', '${orderDetail.itemNo}', '${orderDetail.pakGoodsId }' , '${empty orderDetail.mkiGoodsYn ? 'N' : orderDetail.mkiGoodsYn}')"; data-content="${orderDetail.goodsId}" data-url="${view.stDomain}/order/indexCartList/" class="btn c">장바구니 담기</a>
											</c:if>
											</c:if>
											
											<c:if test="${dlvrStat.clmTpCd ==  FrontWebConstants.CLM_TP_20 || dlvrStat.clmTpCd == FrontWebConstants.CLM_TP_30}">
													<a href="/customer/inquiry/inquiryView?popupChk=popOpen" data-content="${orderBase.ordNo}" data-url="/customer/inquiry/inquiryView" class="btn c">고객센터 문의</a>
											</c:if>
											
											
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
								<div class="adrreq">
								<!-- 배송요청사항 노출을 위해 주석 -->
								<%-- <c:if test="${orderDlvraInfo.dlvrDemandYn eq 'Y' }" > --%>
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
										<div class="txt custom_ellipsis_dlvr"><c:out value="${orderDlvraInfo.escapedDlvrDemand}" escapeXml="false"/></div>
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
									<c:if test="${frontPayInfo.orgGsPnt != 0}">
									<li>
										<div class="dt">GS&POINT 사용</div>
										<div class="dd">
											<span class="prc dis">
												<em class="p"><frame:num data="${frontPayInfo.orgGsPnt}"/></em><i class="w">P</i></span>
										</div>
									</li>
									</c:if>
									<c:if test="${frontPayInfo.orgMpPnt != 0}">
									<li>
										<div class="dt">우주코인 사용</div>
										<div class="dd">
											<span class="prc dis">
												<em class="p"><frame:num data="${frontPayInfo.orgMpPnt}"/></em><i class="w">C</i></span>
										</div>
									</li>
									</c:if>
									<c:if test="${frontPayInfo.orgAddMpPnt != 0}">
									<li>
										<div class="dt">우주코인 추가할인</div>
										<div class="dd">
											<span class="prc dis">
												<em class="p"><frame:num data="${frontPayInfo.orgAddMpPnt}"/></em><i class="w">원</i></span>
										</div>
									</li>
									</c:if>
								</ul>

							<c:if test="${claimView eq 'Y'}">
								<ul class="prcset">
									<li class="tit k0420_line">
										<div class="dt">환불 정보</div>
										<div class="dd">
											<span class="prc"><em class="p"><frame:num data="${frontPayInfo.refundAmt}" /></em><i class="w">원</i></span>
										</div>
									</li>

									<li ${prcAreaDisplayStyle}>
										<div class="dt">취소 상품금액</div>
										<div class="dd">
											<span class="prc"><em class="p"><frame:num data="${frontPayInfo.refundCnclGoodsAmt}" /></em><i class="w">원</i></span>
										</div>
									</li>

									<li ${prcAreaDisplayStyle}>
										<div class="dt">배송비</div>
										<div class="dd">
											<span class="prc"><em class="p"><frame:num data="${frontPayInfo.refundDlvrAmt}"/></em><i class="w">원</i></span>
										</div>
									</li>
									<li ${prcAreaDisplayStyle}>
										<div class="dt">쿠폰 할인</div>
										<div class="dd">
											<span class="prc dis"><em class="p"><frame:num data="${frontPayInfo.refundCpDcAmt}"/></em><i class="w">원</i></span>
										</div>
									</li>
									<c:if test="${frontPayInfo.refundAddMpPnt != 0}">
									<li ${prcAreaDisplayStyle}>
										<div class="dt">우주코인 추가할인</div>
										<div class="dd">
											<span class="prc dis"><em class="p"><frame:num data="${frontPayInfo.refundAddMpPnt}"/></em><i class="w">원</i></span>
										</div>
									</li>
									</c:if>
									
									<li ${prcAreaDisplayStyle}>
										<div class="dt">추가 배송비
											<div class="alert_pop" data-pop="popCpnGud">
													<div class="bubble_txtBox" style="width:267px;">
														<div class="tit">추가 배송비</div>
												<div class="info-txt">
															<ul>
																<li>
																	반품/교환 시 발생한 배송비 금액입니다.
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
											<span class="prc dis">
												<em class="p">
													<frame:num data="${frontPayInfo.clmDlvrcAmt > 0 ? frontPayInfo.clmDlvrcAmt * -1 : frontPayInfo.clmDlvrcAmt}"/>
												</em><i class="w">원</i>
											</span>
										</div>
									</li>
									

									<li>
										<div class="dt">포인트 사용</div>
										<div class="dd">
											<span class="prc dis"><em class="p"><frame:num data="${frontPayInfo.refundGsPnt + frontPayInfo.refundMpPnt}"/></em><i class="w">원</i></span>
										</div>
									</li>
 
								</ul>
							</c:if>

								<div class="tot">
									<div class="dt">총 결제금액</div>
									<div class="dd">
										<span class="prc"><em class="p"><frame:num data="${frontPayInfo.finalPayAmt}" /></em><i class="w">원</i></span>
									</div>
								</div>
							</div>
						</section>
						
						<c:if test="${not empty payInfo.payMeansCd and payInfo.payMeansCd ne FrontWebConstants.PAY_MEANS_00}">
						<section class="sect binf">
							<div class="hdts"><span class="tit">결제 수단</span></div>
							<div class="cdts">
								<div class="result">
									<div class="hd">
										<c:if test="${payInfo.payMeansCd ne FrontWebConstants.PAY_MEANS_00}">
										<em class="b"><frame:codeValue items="${payMeansCdList}" dtlCd="${payInfo.payMeansCd}" /></em>
										</c:if>
										
										<c:choose>
											<c:when test="${payInfo.payMeansCd eq FrontWebConstants.PAY_MEANS_10 or payInfo.payMeansCd eq FrontWebConstants.PAY_MEANS_11}">
			                 					<a href="javascript:void(0);" data-content="${payInfo.ordNo}" data-url="/mypage/order/popupCreditCardByOrderNo" onClick="orderDeliveryDetailBtn.openCreditCard('${payInfo.dealNo}');return false;" class="btn sm">카드영수증</a>
			            					</c:when>
			            					
			            					<c:when test="${payInfo.payMeansCd eq FrontWebConstants.PAY_MEANS_70 or payInfo.payMeansCd eq FrontWebConstants.PAY_MEANS_71 or payInfo.payMeansCd eq FrontWebConstants.PAY_MEANS_72 or payInfo.payMeansCd eq FrontWebConstants.PAY_MEANS_80 or payInfo.payMeansCd eq FrontWebConstants.PAY_MEANS_81}">	                 					
			            					</c:when>
			            					
			            					<c:otherwise>
			            						<c:if test="${FrontWebConstants.PAY_STAT_01 eq payInfo.payStatCd }" >
			            							<c:choose>
			            								<c:when test="${ cashReceiptCheck eq 0 and fiveDaysBefore eq true}" >
			            									<a href="javascript:void(0);" data-content="${payInfo.ordNo}" data-url="/mypage/order/popupCreditCardByOrderNo" onClick="orderDeliveryDetailBtn.openCashReceiptRequest('${payInfo.ordNo}', '${payInfo.payAmt}', $('.untcart .tit a').eq(0).text());return false;" class="btn sm">현금영수증 신청</a>
			            								</c:when>
			            								<c:when test="${ cashReceiptCheck eq 1 }">
			            									<a href="javascript:;"  class="btn sm" disabled>현금영수증 신청 완료</a>
			            								</c:when>
			            							</c:choose>
			            						</c:if>
			            					</c:otherwise>
			            				</c:choose>
									</div>
									<div class="dd">
									<c:if test="${FrontWebConstants.PAY_MEANS_10 eq payInfo.payMeansCd or FrontWebConstants.PAY_MEANS_11 eq payInfo.payMeansCd}">
										<!-- 신용카드 -->
										<frame:codeValue items="${cardcCdList}" dtlCd="${payInfo.cardcCd}"/> (${payInfo.maskedCardNo }) /
										<c:choose>
											<c:when test="${payInfo.instmntInfo eq FrontWebConstants.SINGLE_INSTMNT or empty payInfo.instmntInfo }">
												일시불
											</c:when>
											<c:otherwise>
												<c:if test="${payInfo.fintrYn eq FrontWebConstants.COMM_YN_Y}">무이자 할부 </c:if> ${payInfo.instmntInfo}개월
											</c:otherwise>
										</c:choose>
									</c:if>
									<c:if test="${FrontWebConstants.PAY_MEANS_20 eq payInfo.payMeansCd or FrontWebConstants.PAY_MEANS_30 eq payInfo.payMeansCd or FrontWebConstants.PAY_MEANS_40 eq payInfo.payMeansCd}"><!-- 실시간계좌이체/가상계좌/무통장 -->
										<frame:codeValue items="${bankCdList}" dtlCd="${payInfo.bankCd}"/><c:if test="${FrontWebConstants.PAY_MEANS_20 ne payInfo.payMeansCd}">(<c:out value="${payInfo.acctNo}"/>) /</c:if>
										<c:if test="${FrontWebConstants.PAY_MEANS_20 ne payInfo.payMeansCd and FrontWebConstants.PAY_STAT_00 eq payInfo.payStatCd}">
											<c:choose>
												<c:when test="${not empty orderBase.clmRsnCd}">
													미입금 취소
												</c:when>
												<c:otherwise>
													 입금대기 <frame:timestamp date="${payInfo.dpstSchdDt}" dType="CC" tType="HM" />까지
												</c:otherwise>
											</c:choose>
										</c:if>
										<c:if test="${FrontWebConstants.PAY_MEANS_20 ne payInfo.payMeansCd and FrontWebConstants.PAY_STAT_01 eq payInfo.payStatCd}">
											 입금완료
										</c:if>
									</c:if>
										<!-- 간편결제
										네이버페이-->
									</div>
									<%-- <c:if test="${payInfo.svmnAmt ne null and payInfo.svmnAmt ne 0}">
										<div class="hd">
											<em class="b">포인트 결제</em>
										</div>
									</c:if> --%>
								</div>
							</div>
						</section>
						</c:if>
						<c:if test="${(not empty frontPayInfo.sumIsuSchdPnt and frontPayInfo.sumIsuSchdPnt gt 0) or (not empty mpVO and mpVO.saveSchdPnt gt 0 and mpVO.mpRealLnkGbCd ne frontConstants.MP_REAL_LNK_GB_20)}">
							<section class="sect bprc">
								<div class="hdts"><span class="tit">포인트 적립</span></div>
								<div class="cdts">
									<ul class="prcset">
										<c:if test="${not empty frontPayInfo.sumIsuSchdPnt and frontPayInfo.sumIsuSchdPnt gt 0}">
											<li>
												<div class="dt">GS&POINT 적립
													<!-- alert -->
														<div class="alert_pop" data-pop="GSpoint">
															<div class="bubble_txtBox wooju"> 
																<div class="tit">GS&POINT 적립안내</div>
																<div class="info-txt">
																	<ul>
																		<li>GS&POINT는 최종 결제 금액에 대해 0.1% 적립됩니다.</li>
																		<li>적립 포인트 산정 시 쿠폰 할인 금액, 배송비, 취소/반품 상품 금액, 포인트 사용금액은 제외됩니다.</li>
																		<li>포인트는 구매확정 시 적립됩니다.</li>
																	</ul>
																</div>
															</div>
														</div>
													<!-- // alert -->
												</div>
												<!-- 21.08.10 APET-1258 lcm01 -->
												<div class="dd">
													<span class="prc"><em class="p"><fmt:formatNumber value="${frontPayInfo.sumIsuSchdPnt}" /></em><i class="w">P</i></span>
													<c:choose>
														<c:when test="${allCompleteYn eq 'Y' }">
															<span> 적립완료</span>
														</c:when>
														<c:otherwise>
															<span> 적립예정</span>
														</c:otherwise>
													</c:choose>
												</div>
												<!-- //21.08.10 APET-1258 lcm01 -->
											</li>
										</c:if>
										<c:if test="${not empty mpVO and mpVO.saveSchdPnt gt 0 and mpVO.mpRealLnkGbCd ne frontConstants.MP_REAL_LNK_GB_20}">
											<li>
												<div class="dt">
													우주코인
													<!-- alert -->
													<div class="alert_pop" data-pop="WJcoin">
														<div class="bubble_txtBox wooju"> 
															<div class="tit">우주코인 적립 안내</div>
															<div class="info-txt">
																<ul>
																	<li>우주코인은 최종 결제금액에 대해 <fmt:parseNumber value="${mpPntVO.saveRate}" integerOnly="true" />% 적립되며, 최대 <frame:num data="${mpPntVO.maxSavePnt}" />C까지 적립됩니다.</li> 
																	<li>적립 포인트 산정 시 쿠폰 할인 금액, 배송비, 취소/반품 상품 금액, 포인트 사용금액은 제외됩니다.</li>
																	<li>포인트는 구매확정 시 적립되며,  1일 1회만 적립됩니다.</li>
																	<li>여러개의 상품을 구매한 경우, 같이 구매한 상품이 모두 구매확정 되어야 포인트가 적립됩니다. </li>
																	<li>우주코인 적립은 SK텔레콤 주 서비스 정책에 따르며, 별도의 서비스 이용 수수료는 발생하지 않습니다.</li>
																</ul>
															</div>
														</div>
													</div>
													<!-- // alert -->
												</div>
												<div class="dd">
													<span class="prc">
														<c:if test="${(mpVO.saveSchdPnt + mpVO.addSaveSchdPnt) ge mpVO.maxSavePnt}">
															<em class="blt max">최대</em>
														</c:if>
														<c:choose>
															<c:when test="${not empty mpVO.addSaveSchdPnt and mpVO.addSaveSchdPnt gt 0 }">
																<em class="p"><fmt:formatNumber value="${mpVO.saveSchdPnt}" /></em></em><i class="w">C</i><em class="fc_blue"> + 추가 </em><em class="p"><fmt:formatNumber value="${mpVO.addSaveSchdPnt}" /></em><i class="w">C</i>
															</c:when>
															<c:otherwise>
																<em class="p"><fmt:formatNumber value="${mpVO.saveSchdPnt}" /></em><i class="w">C</i>
															</c:otherwise>
														</c:choose>
													</span>
													<c:choose>
														<c:when test="${mpVO.usePsbResCd eq '200' }">
															<span> 적립완료</span>
														</c:when>
														<c:otherwise>
															<span> 적립예정</span>
														</c:otherwise>
													</c:choose>
												</div>
											</li>
										</c:if>
									</ul>
								</div>
							</section>
						</c:if>
						<div class="my_btnWrap t2">
							<div class="btnSet">
								<a href="/mypage/order/indexDeliveryList" data-content="" data-url="/mypage/order/indexDeliveryList" class="btn lg d">주문/배송 목록</a>
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
			<article class="popBot popCpnGud k0427" id="WJcoin"><!-- 04.27 -->
				<div class="pbd">
					<div class="phd">
						<div class="in">
							<h1 class="tit">우주코인 적립 안내</h1>
							<button type="button" class="btnPopClose">닫기</button>
						</div>
					</div>
					<div class="pct">
						<main class="poptents">
							<ul class="tplist">
								<li>우주코인은 최종 결제금액에 대해 <fmt:parseNumber value="${mpPntVO.saveRate}" integerOnly="true" />% 적립되며, 최대 <frame:num data="${mpPntVO.maxSavePnt}" />C까지 적립됩니다.</li> 
								<li>적립 포인트 산정 시 쿠폰 할인 금액, 배송비, 취소/반품 상품 금액, 포인트 사용금액은 제외됩니다.</li>
								<li>포인트는 구매확정 시 적립되며,  1일 1회만 적립됩니다.</li>
								<li>여러개의 상품을 구매한 경우, 같이 구매한 상품이 모두 구매확정 되어야 포인트가 적립됩니다. </li>
								<li>우주코인 적립은 SK텔레콤 주 서비스 정책에 따르며, 별도의 서비스 이용 수수료는 발생하지 않습니다.</li>
							</ul>
						</main>
					</div>
				</div>
			</article>
		</div>
		
		<div class="layers">
			<article class="popBot popCpnGud k0427" id="GSpoint"><!-- 04.27 -->
				<div class="pbd">
					<div class="phd">
						<div class="in">
							<h1 class="tit">GS&POINT 적립 안내</h1>
							<button type="button" class="btnPopClose">닫기</button>
						</div>
					</div>
					<div class="pct">
						<main class="poptents">
							<ul class="tplist">
								<li>GS&POINT는 최종 결제 금액에 대해 0.1% 적립됩니다.</li>
								<li>적립 포인트 산정 시 쿠폰 할인 금액, 배송비, 취소/반품 상품 금액, 포인트 사용금액은 제외됩니다.</li>
								<li>포인트는 구매확정 시 적립됩니다. </li>
							</ul>
						</main>
					</div>
				</div>
			</article>
		</div>
	<!-- 바디 - 여기 밑으로 템플릿 -->
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
								<li>반품/교환 시 발생한 배송비 금액입니다.</li>
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