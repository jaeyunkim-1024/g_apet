<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="framework.common.constants.CommonConstants" %>
			<c:choose>
			<c:when test="${!empty orderList}">

				<c:forEach items="${orderList}" var="orderBase" varStatus="idx">
				<c:set var="ordAllFlg" value="N" />
				<c:forEach items="${orderBase.orderCompanyListVO}" var="company">
				<c:forEach items="${company.orderInvoiceListVO}" var="invoice">
				<c:forEach items="${invoice.orderDlvrStatListVO}" var="dlvrStat">
				<c:forEach items="${dlvrStat.orderDetailListVO}" var="orderDetail">
					<c:if test="${orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_110}">
						<c:set var="ordAllFlg" value="Y" />
					</c:if>
				</c:forEach>
				
				<c:forEach items="${dlvrStat.claimDetailListVO}" var="orderDetail">
					<c:if test="${orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_110}">
						<c:set var="ordAllFlg" value="Y" />
					</c:if>
				</c:forEach>
				</c:forEach>
				</c:forEach>
				</c:forEach>
				<div class="inr-box">
					<div class="item-list">
						<div class="top">
							<div class="tit">
								<p class="data"><frame:timestamp date="${orderBase.ordAcptDtm}" dType="C" /></p>
								<a href="#" class="detail-btn" data-content="${orderBase.ordNo}" data-url="/mypage/order/indexDeliveryDetail?ordNo=${orderBase.ordNo}" onclick="orderClaimList.goOrderDetail('${orderBase.ordNo}');return false;">주문상세 </a>
							</div>
							<c:if test="${orderBase.ordDeleteFlg eq 'Y'}">
								<a href="#" class="btn sm" onclick="goOrderDelete('${orderBase.ordNo}');return false;">주문내역삭제</a>
							</c:if>
						</div>
					</div>
					<c:forEach items="${orderBase.orderCompanyListVO}" var="company" varStatus="idx">
					<c:forEach items="${company.orderInvoiceListVO}" var="invoice" varStatus="idx">
					<c:forEach items="${invoice.orderDlvrStatListVO}" var="dlvrStat" varStatus="idx">
						<!--클레임 상태 색상 설정 -->
						<!--빨강 t4 : 반품신청/반품진행중/교환신청/교환진행중-->
						<!--회색 t2 : 주문취소-->
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
													<a href="#" data-content="${orderBase.ordNo}" data-url="/mypage/order/indexDeliveryDetail?ordNo=${orderBase.ordNo}" onclick="orderClaimList.goOrderDetail('${orderBase.ordNo}');return false;">
													<img src="${fn:indexOf(orderDetail.imgPath, 'cdn.ntruss.com') > -1 ? orderDetail.imgPath : frame:optImagePath(orderDetail.imgPath, frontConstants.IMG_OPT_QRY_500)}" alt="${orderDetail.goodsNm }" class="img">
													</a>
												</div>
												<div class="name">
													<div class="tit k0421">
														<a href="#" data-content="${orderBase.ordNo}" data-url="/mypage/order/indexDeliveryDetail?ordNo=${orderBase.ordNo}" onclick="orderClaimList.goOrderDetail('${orderBase.ordNo}');return false;">${orderDetail.goodsNm}</a>
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
									<div class="btn-bx pc-t2">
										<div class="btnSet">
											<a href="#" onclick="goClaimDetail('${orderDetail.claimDetailVO.clmNo}', '${dlvrStat.clmTpCd }');return false;" class="btn c">
												<frame:codeValue items="${clmTpCdList}" dtlCd="${dlvrStat.clmTpCd}"  type="S"/> 상세
											</a>
										<c:if test="${dlvrStat.viewClmDtlStatCd eq FrontWebConstants.CLM_DTL_STAT_260 || dlvrStat.viewClmDtlStatCd eq FrontWebConstants.CLM_DTL_STAT_450 }">
											<a href="javascript:void(0);" onclick="insertCart('${orderDetail.goodsId}', '${orderDetail.itemNo}', '${orderDetail.pakGoodsId }' , '${empty orderDetail.mkiGoodsYn ? 'N' : orderDetail.mkiGoodsYn}'); return false;" data-url="${view.stDomain}/order/indexCartList/" class="btn c">장바구니 담기</a>
										</c:if>
										<c:if test="${dlvrStat.clmTpCd eq FrontWebConstants.CLM_TP_20 || dlvrStat.clmTpCd eq FrontWebConstants.CLM_TP_30 }">
											<a href="/customer/inquiry/inquiryView?popupChk=popOpen" data-content="${orderBase.ordNo}" data-url="/customer/inquiry/inquiryView" class="btn c">고객센터 문의</a>
										</c:if>
										</div>
									</div>
								</div>
								</c:forEach>
							</div>
						</div>
						</c:if>
					</c:forEach>
					</c:forEach>
					</c:forEach>
					</div>
				</c:forEach>
				</c:when>
			<c:otherwise>
				<div class="noneBoxPoint" style="display: flex;">
					<div>
						<span class="noneBoxPoint_img2"></span>
						<div class="noneBoxPoint_infoTxt" style="color:#666;">취소/반품/교환 내역이 없습니다.</div>
					</div>
				</div>
			</c:otherwise>
			</c:choose>