<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="framework.common.constants.CommonConstants" %>

<c:if test="${empty orderSO.migMemno }">
<div class="inr-box piner">
	<div class="oder-step">
		<div class="step-list">
			<ul>
				<li id="stepOne">
					<a href="javascript:void(0);" data-content="${session.mbrNo}" data-url="/mypage/order/indexDeliveryList?page=${orderSO.page}&rows=${orderSO.rows}&period=${orderSO.period}&ordAcptDtmStart=<frame:timestamp date="${orderSO.ordAcptDtmStart}" dType="" />&ordAcptDtmEnd=<frame:timestamp date="${orderSO.ordAcptDtmEnd}" dType="H" />&arrOrdDtlStatCd=110" onclick="orderDeliveryList.searchStauts('110','stepOne');return false;"><p class="num">${(orderSummary.ordAcpt > 99)? '99+' : orderSummary.ordAcpt }</p></a>
					<p class="txt">입금대기</p>
				</li>
				<li id="stepTwo">
					<a href="javascript:void(0);" data-content="${session.mbrNo}" data-url="/mypage/order/indexDeliveryList?page=${orderSO.page}&rows=${orderSO.rows}&period=${orderSO.period}&ordAcptDtmStart=<frame:timestamp date="${orderSO.ordAcptDtmStart}" dType="H" />&ordAcptDtmEnd=<frame:timestamp date="${orderSO.ordAcptDtmEnd}" dType="H" />&arrOrdDtlStatCd=120" onclick="orderDeliveryList.searchStauts('1230','stepTwo');return false;">$<p class="num">${(orderSummary.ordCmplt > 99)? '99+' : orderSummary.ordCmplt }</p></a>
					<p class="txt">결제완료</p>
				</li>
				<li id="stepThree">
					<a href="javascript:void(0);" data-content="${session.mbrNo}" data-url="/mypage/order/indexDeliveryList?page=${orderSO.page}&rows=${orderSO.rows}&period=${orderSO.period}&ordAcptDtmStart=<frame:timestamp date="${orderSO.ordAcptDtmStart}" dType="H" />&ordAcptDtmEnd=<frame:timestamp date="${orderSO.ordAcptDtmEnd}" dType="H" />&arrOrdDtlStatCd=1340" onclick="orderDeliveryList.searchStauts('140','stepThree');return false;"><p class="num">${(orderSummary.ordShpRdy > 99)? '99+' : orderSummary.ordShpRdy }</p></a>
					<p class="txt">배송준비중</p>
				</li>
				<li id="stepFour">
					<a href="javascript:void(0);" data-content="${session.mbrNo}" data-url="/mypage/order/indexDeliveryList?page=${orderSO.page}&rows=${orderSO.rows}&period=${orderSO.period}&ordAcptDtmStart=<frame:timestamp date="${orderSO.ordAcptDtmStart}" dType="H" />&ordAcptDtmEnd=<frame:timestamp date="${orderSO.ordAcptDtmEnd}" dType="H" />&arrOrdDtlStatCd=150" onclick="orderDeliveryList.searchStauts('150','stepFour');return false;"><p class="num">${(orderSummary.ordShpIng > 99)? '99+' : orderSummary.ordShpIng }</p></a>
					<p class="txt">배송중</p>
				</li>
				<li id="stepFive">
					<a href="javascript:void(0);" data-content="${session.mbrNo}" data-url="/mypage/order/indexDeliveryList?page=${orderSO.page}&rows=${orderSO.rows}&period=${orderSO.period}&ordAcptDtmStart=<frame:timestamp date="${orderSO.ordAcptDtmStart}" dType="H" />&ordAcptDtmEnd=<frame:timestamp date="${orderSO.ordAcptDtmEnd}" dType="H" />&arrOrdDtlStatCd=160" onclick="orderDeliveryList.searchStauts('160','stepFive');return false;"><p class="num">${(orderSummary.ordShpCmplt > 99)? '99+' : orderSummary.ordShpCmplt }</p></a>
					<p class="txt">배송완료</p>
				</li>
				<li id="stepSix">
					<a href="javascript:void(0);" data-content="${session.mbrNo}" data-url="/mypage/order/indexDeliveryList?page=${orderSO.page}&rows=${orderSO.rows}&period=${orderSO.period}&ordAcptDtmStart=<frame:timestamp date="${orderSO.ordAcptDtmStart}" dType="H" />&ordAcptDtmEnd=<frame:timestamp date="${orderSO.ordAcptDtmEnd}" dType="H" />&arrOrdDtlStatCd=170" onclick="orderDeliveryList.searchStauts('170','stepSix');return false;"><p class="num">${(orderSummary.pchseCnfm > 99)? '99+' : orderSummary.pchseCnfm }</p></a>
					<p class="txt">구매확정</p>
				</li>
			</ul>
		</div>
	</div>
</div>
</c:if>
<c:choose>
	<c:when test="${!empty orderList}">
		<c:forEach items="${orderList}" var="orderBase" varStatus="idx">
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
						</c:forEach>
					</c:forEach>
				</c:forEach>
			</c:forEach>
			<div class="inr-box statusDeliveryList">
				<div class="item-list">
					<div class="top">
						<div class="tit">
							<p class="data"><frame:timestamp date="${orderBase.ordAcptDtm}" dType="C" /></p>
							<a href="javascript:void(0);" class="detail-btn" data-content="${orderBase.ordNo}" data-url="/mypage/order/indexDeliveryDetail?ordNo=${orderBase.ordNo}" onclick="orderDeliveryListBtn.goOrderDetail('${orderBase.ordNo}');return false;">주문상세 </a>
						</div>
						<c:if test="${orderBase.cncPsbYn eq FrontWebConstants.COMM_YN_Y and ordAllFlg eq 'Y'}">						<!-- 주문 취소 가능 여부 eq Y -->
							<c:choose>
								<c:when test="${ord110Flg eq 'Y'}">
									<a href="javascript:void(0);" class="btn sm" data-content="${orderBase.ordNo}" data-url="/mypage/order/insertClaimCancelExchangeRefund" onclick="orderDeliveryListBtn.goCancelAllRequest('${orderBase.ordNo}');return false;">전체주문취소</a>
								</c:when>
								<c:otherwise>
									<a href="javascript:void(0);" class="btn sm" data-content="${orderBase.ordNo}" data-url="/mypage/order/indexCancelRequest" onclick="orderDeliveryListBtn.goCancelRequest('${orderBase.ordNo}', '');return false;">전체주문취소</a>
								</c:otherwise>
							</c:choose>
						</c:if>
		
						<c:if test="${orderBase.ordDeleteFlg eq 'Y'}">												<!-- 주문내역삭제 버튼 Flag eq Y -->
							<a href="javascript:void(0);" class="btn sm ord-del-btn" data-content="${orderBase.ordNo}" data-url="/mypage/order/orderDelete" onclick="orderDeliveryListBtn.goOrderDelete('${orderBase.ordNo}');return false;">주문내역삭제</a>
						</c:if>
					</div>
				</div>
				<c:forEach items="${orderBase.orderCompanyListVO}" var="company" varStatus="idx">
					<c:forEach items="${company.orderInvoiceListVO}" var="invoice" varStatus="idx">
						<c:forEach items="${invoice.orderDlvrStatListVO}" var="dlvrStat" varStatus="idx">
							<c:set var="dlvrDtm" value="" />
							<c:set var="dlvrDtmWeek" value="100" />
							<c:set var="dlvrDtmTxt" value="" />
							<!-- 파랑 t3   결제완료 배송중 배송준비중   -->
							<!-- 빨강 t4  입금대기 반품신청  반품진행중  교환신청 교환진행중 -->
							<!-- 검정   구매확정 배송완료 반품완료 CLM_DTL_STAT 260 반품거부 250 교환완료 450 교환거부 350  -->
							<!-- 회색 t2 주문취소 110 120 -->
							<c:set var="titClass" value="${dlvrStat.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_110 ? 't4':
					 			(dlvrStat.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_120 or dlvrStat.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_140 or dlvrStat.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_150 or dlvrStat.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_130) ? 't3': ''}"/>
							<!-- dvlrClass (배송 아이콘  :: 배송 처리 유형 코드 eq 택배배송 ? 'icon-t t2' : ((배송 처리 유형 코드 eq  당일배송)? 'icon-t' : ((배송 처리 유형 코드 eq  새벽배송)? 'icon-t t3' : ''))-->
							<c:set var="dvlrClass" value="${dlvrStat.dlvrPrcsTpCd eq FrontWebConstants.DLVR_PRCS_TP_10 ? 'icon-t t2': dlvrStat.dlvrPrcsTpCd eq  FrontWebConstants.DLVR_PRCS_TP_20 ? 'icon-t':dlvrStat.dlvrPrcsTpCd eq  FrontWebConstants.DLVR_PRCS_TP_21 ? 'icon-t t3':''}"/>
							<%-- 주문 리스트 --%>
							<c:set var="isExistOrderDetail" value="N" />
							<c:forEach items="${dlvrStat.orderDetailListVO}" var="orderDetail" varStatus="idx">
								<c:if test="${orderDetail.rmnOrdQty - orderDetail.rtnQty - orderDetail.clmExcIngQty - orderDetail.clmExcCpltQty > 0}">
									<c:set var="isExistOrderDetail" value="Y" />
								</c:if>
							</c:forEach>
										
							<c:if test="${not empty dlvrStat.orderDetailListVO && isExistOrderDetail eq 'Y'}">
							
								<div class="item-list">
									<div class="bottom">
										<div class="t-box">
												<c:choose>
													<c:when test="${fn:indexOf(session.reqUri,'indexPetsbeDeliveryList')>-1 and dlvrStat.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_110}">
														<p class="tit t2">
															주문취소
														</p>
													</c:when>
													<c:otherwise>
														<p class="tit ${titClass}" data-target="${dlvrStat.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_110 ? 'petsbe' : ''}">
															<frame:codeValue items="${ordDtlStatCdList}" dtlCd="${dlvrStat.ordDtlStatCd}" type="S"/>
														</p>
													</c:otherwise>
												</c:choose>
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
					
										<div class="g-box dlvr-current-status">
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
															<c:when test="${dlvrStat.dlvrPrcsTpCd eq  FrontWebConstants.DLVR_PRCS_TP_10 
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
														<a href="javascript:;" class="detail-btn" data-target="order" data-action="goodsflow" data-url="https://${pageContext.request.serverName}/mypage/order/goodsflow/${dlvrStat.orderDetailListVO[0].dlvrNo}" >배송조회</a>
													</c:if>
												</c:if>
						
											</c:otherwise>
										</c:choose>
					
										</div>
										
										<c:forEach items="${dlvrStat.orderDetailListVO}" var="orderDetail" varStatus="idx">
											<c:set var="rmnOrdQty" value="${orderDetail.rmnOrdQty - orderDetail.rtnQty - orderDetail.clmExcIngQty - orderDetail.clmExcCpltQty}" />
											<c:if test="${rmnOrdQty > 0}">
											<div class="float-bx">
												<div class="untcart"><!-- .disabled -->
													<div class="box">
														<div class="tops">
															<div class="pic">
																<a href="javascript:void(0);" data-content="${orderBase.ordNo}" data-url="/mypage/order/indexDeliveryDetail?ordNo=${orderBase.ordNo}" onclick="orderDeliveryListBtn.goOrderDetail('${orderBase.ordNo}');return false;">
																<img src="${fn:indexOf(orderDetail.imgPath, 'cdn.ntruss.com') > -1 ? orderDetail.imgPath : frame:optImagePath(orderDetail.imgPath, frontConstants.IMG_OPT_QRY_500)}" alt="${orderDetail.goodsNm }" class="img">
																</a>
															</div>
															<div class="name">
																<div class="tit k0421">
																	<a href="javascript:void(0);" data-content="${orderBase.ordNo}" data-url="/mypage/order/indexDeliveryDetail?ordNo=${orderBase.ordNo}" onclick="orderDeliveryListBtn.goOrderDetail('${orderBase.ordNo}');return false;">${orderDetail.goodsNm}</a>
																</div>
																<div class="stt">
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
																<c:if test="${ orderDetail.goodsCstrtTpCd ne FrontWebConstants.GOODS_CSTRT_TP_SET && orderDetail.mkiGoodsYn eq 'Y' && not empty orderDetail.mkiGoodsOptContent }"> <!-- 상품 구성 유형 : 세트인경우 노출 안함 -->
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
													or (orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_130))
													and orderDetail.rmnOrdQty > 0 ? '':'pc-t2'}" />  
						
												<div class="btn-bx ${btnSetClass}">
													<div class="btnSet">
														<c:if test="${(orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_120 or orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_130)
															and orderDetail.rmnOrdQty > 0}">
															<a href="javascript:void(0);" class="btn c" data-content="${orderBase.ordNo}" data-url="/mypage/order/indexCancelRequest" onclick="orderDeliveryListBtn.goCancelRequest('${orderBase.ordNo}', '${orderDetail.ordDtlSeq}');return false;">주문취소</a>
														</c:if>
														<c:if test="${orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_160}">
															<c:if test="${orderDetail.rmnOrdQty - orderDetail.rtnQty - orderDetail.clmExcIngQty - orderDetail.clmExcCpltQty > 0 }">
																<a href="javascript:void(0);" class="btn c" data-content="${orderBase.ordNo}" data-url="/mypage/order/indexExchangeRequest" onclick="orderDeliveryListBtn.goReturnRequest('${orderBase.ordNo}','${orderDetail.ordDtlSeq}' , '${orderDetail.clmIngYn}', '${orderDetail.rtnIngYn}', '${orderDetail.rtnPsbYn}');return false;">반품신청</a>
																<a href="javascript:void(0);" class="btn c" data-content="${orderBase.ordNo}" data-url="/mypage/order/indexReturnRequest" onclick="orderDeliveryListBtn.goExchangeRequest('${orderBase.ordNo}','${orderDetail.ordDtlSeq}', '${orderDetail.clmIngYn }', '${orderDetail.rtnIngYn}');return false;">교환신청</a>
															</c:if>
														</c:if>
														<c:if test="${  orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_170}">
															<c:if test="${session.mbrNo ne FrontWebConstants.NO_MEMBER_NO }">
																<a href="javascript:void(0);" onclick="cartGoods.insertCart('${orderDetail.goodsId}', '${orderDetail.itemNo }', '${orderDetail.pakGoodsId }','','','N');" data-content="${orderDetail.goodsId}" data-url="${view.stDomain}/order/indexCartList/" class="btn c add-cart-btn">장바구니 담기</a>
															</c:if>
														</c:if>
														<a href="/customer/inquiry/inquiryView?popupChk=popOpen" data-content="${orderBase.ordNo}" data-url="/customer/inquiry/inquiryView" class="btn c cs-btn">고객센터 문의</a>
													</div>
													<c:if test="${orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_150 || orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_160 || orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_170}">
														<c:if test="${orderDetail.clmIngYn eq FrontWebConstants.COMM_YN_N and orderDetail.vldOrdQty > 0 }">
															<div class="btnSet">
															<c:if test="${orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_160 or orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_150}">
																<a href="javascript:void(0);" class="btn b completeBtn" data-content="${orderBase.ordNo}" data-url="/mypage/order/purchaseProcess" onclick="orderDeliveryListBtn.purchase('<c:out value='${orderBase.ordNo}' />', '<c:out value='${orderDetail.ordDtlSeq}' />', '<c:out value='${orderDetail.ordDtlStatCd}' />');return false;">구매확정</a>
															</c:if>
															<c:if test="${  orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_170}">
																<c:if test="${ orderDetail.goodsEstmRegYn ne FrontWebConstants.COMM_YN_Y  }">
																	<a href="javascript:void(0);" data-content="${orderBase.ordNo}" data-url="/mypage/service/popupGoodsCommentReg" onclick="orderDeliveryListBtn.openGoodsComment('${orderDetail.goodsId}','${orderBase.ordNo}','${orderDetail.ordDtlSeq}', '', '');return false;" class="btn c completeBtn">후기작성</a>
																</c:if>
																<c:if test="${ orderDetail.goodsEstmRegYn eq FrontWebConstants.COMM_YN_Y  }">
																	<a href="javascript:void(0);" data-content="${orderBase.ordNo}" data-url="/mypage/service/popupGoodsCommentReg" onclick="orderDeliveryListBtn.openGoodsComment('${orderDetail.goodsId}','${orderBase.ordNo}','${orderDetail.ordDtlSeq}', '${orderDetail.goodsEstmNo}', '${orderDetail.goodsEstmTp}' );return false;" class="btn c completeBtn">후기수정</a>
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
								</div>
							
							</c:if>
									
							<%-- 클레임리스트 --%>
							<c:if test="${not empty dlvrStat.claimDetailListVO}">
							
							<div class="item-list">
								<div class="bottom">
									<div class="t-box">
										<!-- 파랑 t3   결제완료 배송중 배송준비중   -->
										<!-- 검정   구매확정 배송완료 반품완료 CLM_DTL_STAT 260 반품거부 250 교환완료 450 교환거부 350  -->
										<!-- 회색 t2 주문취소 110 120 -->
										<!-- 빨강 t4  입금대기 반품신청  반품진행중  교환신청 교환진행중 -->
										<c:set var="clmTitClass" value="${( dlvrStat.viewClmDtlStatCd eq FrontWebConstants.CLM_DTL_STAT_110 or dlvrStat.viewClmDtlStatCd eq FrontWebConstants.CLM_DTL_STAT_120 ) ? 't2':
										 (dlvrStat.viewClmDtlStatCd eq FrontWebConstants.CLM_DTL_STAT_250
										  or dlvrStat.viewClmDtlStatCd eq FrontWebConstants.CLM_DTL_STAT_260
										   or dlvrStat.viewClmDtlStatCd eq FrontWebConstants.CLM_DTL_STAT_350
										    or dlvrStat.viewClmDtlStatCd eq FrontWebConstants.CLM_DTL_STAT_450) ? '': 't4'}"/>
										<p class="tit ${clmTitClass}">
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
									
									<c:forEach items="${dlvrStat.claimDetailListVO}" var="orderDetail" varStatus="idx">
									<div class="float-bx">
										<div class="untcart"><!-- .disabled -->
											<div class="box">
												<div class="tops">
													<div class="pic">
														<a href="javascript:void(0);" data-content="${orderBase.ordNo}" data-url="/mypage/order/indexDeliveryDetail?ordNo=${orderBase.ordNo}" onclick="orderDeliveryListBtn.goOrderDetail('${orderBase.ordNo}');return false;">
														<img src="${fn:indexOf(orderDetail.imgPath, 'cdn.ntruss.com') > -1 ? orderDetail.imgPath : frame:optImagePath(orderDetail.imgPath, frontConstants.IMG_OPT_QRY_500)}" alt="${orderDetail.goodsNm }" class="img">
														</a>
													</div>
													<div class="name">
														<div class="tit k0421">
															<a href="javascript:void(0);" data-content="${orderBase.ordNo}" data-url="/mypage/order/indexDeliveryDetail?ordNo=${orderBase.ordNo}" onclick="orderDeliveryListBtn.goOrderDetail('${orderBase.ordNo}');return false;">${orderDetail.goodsNm}</a>
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
														<c:if test="${ orderDetail.goodsCstrtTpCd ne FrontWebConstants.GOODS_CSTRT_TP_SET && orderDetail.mkiGoodsYn eq 'Y' && not empty orderDetail.mkiGoodsOptContent }"> <!-- 상품 구성 유형 : 세트인경우 노출 안함 -->
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
													onclick="orderDeliveryListBtn.goOrderClaimDetail('${orderDetail.claimDetailVO.clmNo}','${dlvrStat.clmTpCd}' )" 
													class="btn c">
													<frame:codeValue items="${clmTpCdList}" dtlCd="${dlvrStat.clmTpCd}"  type="S"/> 상세
												</a>
											<c:if test="${dlvrStat.viewClmDtlStatCd eq FrontWebConstants.CLM_DTL_STAT_260 || dlvrStat.viewClmDtlStatCd eq FrontWebConstants.CLM_DTL_STAT_450 }">
												<a href="javascript:void(0);" onclick="cartGoods.insertCart('${orderDetail.goodsId}', '${orderDetail.itemNo }', '${orderDetail.pakGoodsId }', '', '', 'N');" data-content="${orderDetail.goodsId}" data-url="${view.stDomain}/order/indexCartList/" class="btn c">장바구니 담기</a>
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
		<div class="statusDeliveryList" id="noDataDeliveryList">
			<section class="no_data i1 auto_h">
				<div class="inr">
					<div class="msg">주문 내역이 없습니다.</div>
				</div>
			</section>
		</div>
	</c:otherwise>	
</c:choose>
<div class="btn_fixed_wrap t2">
			<button class="btn_round" onclick="searchAllOrder();" style="display:none;">전체주문보기</button><!-- 하단 gnb 있을 시 t2추가 -->
</div>