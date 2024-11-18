<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<script type="text/javascript">


	$(document).ready(function(){
		
	}); // End Ready

	$(function() {
	});

	

</script>

<form id="claim_request_list_form">
	<input type="hidden" id="delivery_detail_ord_no" name="ordNo" value="" />
	<input type="hidden" id="delivery_detail_ord_dtl_seq" name="ordDtlSeq" value="" />
	<input type="hidden" id="clm_tp_cd" name="clmTpCd" value=""/>
</form>
<div class="box_title_area">
	<h3>주문상세조회</h3>
</div>

<!-- 주문번호 -->
<div class="order_number_box mgt10">
	<dl>
		<dt>주문번호</dt>
		<dd>
			<strong class="point2">${orderBase.ordNo}</strong>
		</dd>
	</dl>
	<div class="btn_group_abs">
	<c:if test="${orderBase.ordCancelPsbYn eq FrontWebConstants.COMM_YN_Y}">
		<c:if test="${fn:length(orderDetailList) > 1}">
			<a href="#" class="btn_h20_type5" onclick="orderDeliveryDetailBtn.goCancelRequest('${orderBase.ordNo}', '');return false;">주문전체취소</a>
		</c:if>
		<a href="#" class="btn_h20_type5" onclick="orderDeliveryDetailBtn.goAddressEdit('${orderBase.ordNo}');return false;">배송지수정</a>
	</c:if>
	</div>
</div>

<c:set var="vldQty" value="0" />

<!-- 주문내역 -->
<table class="table_cartlist1 mgt20">
	<caption>주문내역</caption>
	<colgroup>
		<col style="width:70px">
		<col style="width:auto">
		<col style="width:12%">
		<col style="width:5%">

		<col style="width:12%">
		<col style="width:9%">
		<col style="width:9%">
	</colgroup>
	<thead>
		<tr>
			<th scope="col" colspan="2">상품정보</th>
			<th scope="col">판매가</th>
			<th scope="col">수량</th>
			<th scope="col">합계</th>
			<th scope="col">주문상태</th>
			<th scope="col">주문관리</th>
		</tr>
	</thead>
	<tbody>


	<c:forEach items="${orderDetailList}" var="orderDetail" varStatus="idx">
	<c:set var="vldQty" value="${vldQty + orderDetail.vldOrdQty }" />
		<tr>
			<td class="img_cell v_top">
				<a href="/goods/indexGoodsDetail?goodsId=${orderDetail.goodsId }">
				<frame:goodsImage goodsId="${orderDetail.goodsId}" seq="${orderDetail.imgSeq}" imgPath="${orderDetail.imgPath}" size="${ImageGoodsSize.SIZE_70.size}" gb="" />
				</a>
			</td>
			<td class="align_left v_top">
				<div class="product_name">
					<a href="/goods/indexGoodsDetail?goodsId=${orderDetail.goodsId }">[${orderDetail.bndNmKo}] ${orderDetail.goodsNm}</a>
					<div class="product_option">
						<span>${orderDetail.itemNm}</span>
						<c:if test="${(orderDetail.itemMngYn eq FrontWebConstants.COMM_YN_Y) and ((orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_110) or (orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_120))}">
						<a href="#" class="btn_h16_type2" onclick="orderDeliveryDetailBtn.openOptionChange('${orderDetail.ordNo}', '${orderDetail.ordDtlSeq}');return false;">옵션변경</a>
						</c:if>
					</div>
				</div>
			</td>
			<td>
				<div>
				   	<frame:num data="${orderDetail.saleAmt - orderDetail.prmtDcAmt}"/>원
				</div>
			</td>
			<td>
				<frame:num data="${orderDetail.ordQty}" />
			</td>
			<td>
				<c:set var="goodsSaleAmt" value="${(orderDetail.saleAmt - orderDetail.prmtDcAmt) * orderDetail.ordQty}" />
				<b><frame:num data="${goodsSaleAmt}" />원</b>
			</td>
			<td>
				<frame:codeValue items="${ordDtlStatCdList}" dtlCd="${orderDetail.ordDtlStatCd}" type="S"/>
				<c:if test="${orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_150 or orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_160}">
				    <!-- 2017.9.29, 배송조회 연동 중단 처리 -->
				    <%--
					<c:if test="${orderDetail.clmIngYn eq FrontWebConstants.COMM_YN_N  and orderDetail.vldOrdQty > 0}">
						<div>
						   <a href="#" onclick="openDeliveryInquire('${orderDetail.ordNo}', '${orderDetail.ordDtlSeq}', '${FrontWebConstants.ORD_CLM_GB_10}');return false;" class="btn_h20_type6 fix_w65">배송조회</a>
						</div>
					</c:if>
					 --%>
				</c:if>
				<c:if test="${  orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_170}">
					<c:if test="${session.mbrNo ne FrontWebConstants.NO_MEMBER_NO }">
						<c:if test="${ orderDetail.goodsEstmRegYn eq FrontWebConstants.COMM_YN_N  }">
		                    <div>
		                        <a href="#" onclick="orderDeliveryDetailBtn.openGoodsComment('${orderDetail.goodsId}','${orderDetail.ordNo}','${orderDetail.ordDtlSeq}');return false;" class="btn_h20_type6 fix_w65">리뷰작성</a>
		                    </div>
		                </c:if>
						<c:if test="${ orderDetail.goodsEstmRegYn eq FrontWebConstants.COMM_YN_Y  }">
							<div>
							   <a href="/mypage/service/indexGoodsCommentList" class="btn_h20_type6 fix_w65 btn_disabled">리뷰보기</a>
		                    </div>
						</c:if>
					</c:if>
					<!-- 2017.9.29, 배송조회 연동 중단 처리 -->
                    <%--
					<div>
					   <a href="#" onclick="openDeliveryInquire('${orderDetail.ordNo}', '${orderDetail.ordDtlSeq}', '${FrontWebConstants.ORD_CLM_GB_10}');return false;" class="btn_h20_type6 fix_w65">배송조회</a>
					</div>
					--%>
				</c:if>
			</td>
			<td>
				<c:if test="${(orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_120
								or (orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_110 and fn:length(orderDetailList) eq 1)) 
	 							and orderDetail.rmnOrdQty > 0}">
	                <div>
					   <a href="#" class="btn_h20_type6 fix_w65" onclick="orderDeliveryDetailBtn.goCancelRequest('${orderDetail.ordNo}', '${orderDetail.ordDtlSeq}');return false;">주문취소</a>
					</div>
				</c:if>
	 			<c:if test="${orderDetail.ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_160}">
					<c:if test="${orderDetail.clmIngYn eq FrontWebConstants.COMM_YN_N  and orderDetail.vldOrdQty > 0}">
				         <div>
				             <a href="#" onclick="orderDeliveryDetailBtn.purchase('<c:out value='${orderDetail.ordNo}' />', '<c:out value='${orderDetail.ordDtlSeq}' />');return false;" class="btn_h20_type6 fix_w65">구매확정</a>
			             </div>
					</c:if>
		 			<c:if test="${ orderDetail.rmnOrdQty - orderDetail.rtnQty - orderDetail.clmExcIngQty > 0}">
						<div>
						   <a href="#" class="btn_h20_type6 fix_w65" onclick="orderDeliveryDetailBtn.goReturnRequest('${orderDetail.ordNo}', '${orderDetail.ordDtlSeq}' , '${orderDetail.rtnIngYn}', '${orderDetail.rtnPsbYn}');return false;">반품신청</a>
						</div>
						<div>
						   <a href="#" class="btn_h20_type6 fix_w65" onclick="orderDeliveryDetailBtn.goExchangeRequest('${orderDetail.ordNo}','${orderDetail.ordDtlSeq}');return false;" >교환신청</a>
						</div>
	 				</c:if>
				</c:if>
			</td>
		</tr>
		<!-- 클레임 내역 목록 -->
		<c:set var="claimExcRtn" value="" />
		<c:set var="claimView" value="" />
		<c:forEach items="${orderDetail.claimDetailList}" var="claimDetail" varStatus="cidx">
			<c:if test="${claimDetail.clmTpCd ne FrontWebConstants.CLM_TP_30}">
				<c:set var="claimView" value="Y" />
				<c:set var="claimExcRtn" value="" />
			</c:if>
			<c:if test="${claimDetail.clmTpCd eq FrontWebConstants.CLM_TP_30}">
				<c:if test="${claimDetail.clmDtlTpCd eq FrontWebConstants.CLM_DTL_TP_30}">
					<c:choose>
						<c:when test="${claimDetail.swapYn ne FrontWebConstants.COMM_YN_Y and claimDetail.clmDtlStatCd ne FrontWebConstants.CLM_DTL_STAT_360 }">
							<c:set var="claimView" value="Y" />
							<c:set var="claimExcRtn" value="Y" />
						</c:when>
						<c:otherwise>
							<c:set var="claimView" value="N" />
							<c:set var="claimExcRtn" value="N" />
						</c:otherwise>
					</c:choose>
				</c:if>
				<c:if test="${claimDetail.clmDtlTpCd eq FrontWebConstants.CLM_DTL_TP_40}">
					<c:if test="${claimExcRtn eq 'Y'}">
						<c:set var="claimView" value="N" />
					</c:if>
					<c:if test="${claimExcRtn eq 'N'}">
						<c:set var="claimView" value="Y" />
					</c:if>
				</c:if>
			</c:if>
			<c:if test="${claimView eq 'Y'}">
				<tr>
					<td class="img_cell v_top">
					</td>
					<td class="align_left v_top">
						<div class="product_name re">
							<span class="re"><frame:codeValue items="${clmTpCdList}" dtlCd="${claimDetail.clmTpCd}"  /></span>
							<a href="/goods/indexGoodsDetail?goodsId=${orderDetail.goodsId }">[${orderDetail.bndNmKo}] ${orderDetail.goodsNm}</a>
							<div class="product_option">
								<span>${claimDetail.itemNm}</span>
							</div>
						</div>
					</td>
					<td>
						<div>
					   	<frame:num data="${claimDetail.saleAmt - claimDetail.prmtDcAmt}"/>원
						</div>
					</td>
					<td>
					<frame:num data="${claimDetail.clmQty}" />
					</td>
					<td>
						<b><frame:num data="${(claimDetail.saleAmt - claimDetail.prmtDcAmt) * claimDetail.clmQty}" />원</b>
					</td>
					<td>
						<c:if test="${claimDetail.clmStatCd eq FrontWebConstants.CLM_STAT_20 }">
						<frame:codeValue items="${clmDtlStatCdList}" dtlCd="${claimDetail.clmDtlStatCd}"  type="S"/>
						</c:if>
						<c:if test="${claimDetail.clmStatCd ne FrontWebConstants.CLM_STAT_20 }">
						<frame:codeValue items="${clmTpCdList}" dtlCd="${claimDetail.clmTpCd}"  />
						<frame:codeValue items="${clmStatCdList}" dtlCd="${claimDetail.clmStatCd}"  />
						</c:if>
						<c:if test="${claimDetail.swapYn eq FrontWebConstants.COMM_YN_Y}"><br/>[맞교환]</c:if>
	 					<a href="#" class="btn_h20_type6" onclick="orderDeliveryDetailBtn.openClaimDetail('${claimDetail.clmNo}', '${claimDetail.clmDtlSeq}');return false;">상세정보</a>
	 					<c:if test="${claimDetail.clmTpCd ne FrontWebConstants.CLM_TP_10 }">
	 					<!-- 2017.9.29, 배송조회 연동 중단 처리 -->
	                    <%--
		 					<c:if test="${claimDetail.clmDtlStatCd ne FrontWebConstants.CLM_DTL_STAT_210 and claimDetail.clmDtlStatCd ne FrontWebConstants.CLM_DTL_STAT_220
		 									and claimDetail.clmDtlStatCd ne FrontWebConstants.CLM_DTL_STAT_310 and claimDetail.clmDtlStatCd ne FrontWebConstants.CLM_DTL_STAT_320
		 									and claimDetail.clmStatCd ne FrontWebConstants.CLM_STAT_40}">
								<br/>
								<a href="#" onclick="openDeliveryInquire('${claimDetail.clmNo}', '${claimDetail.clmDtlSeq}', '${FrontWebConstants.ORD_CLM_GB_20}');return false;" class="btn_h20_type6 fix_w65">배송조회</a>
		 					</c:if>
		 				--%>	
	 					</c:if>
					</td>
					<td>
						<div>
							<c:if test="${claimDetail.clmStatCd eq FrontWebConstants.CLM_STAT_10 and claimDetail.clmTpCd ne FrontWebConstants.CLM_TP_10 }">
		 					<a href="#" class="btn_h20_type6" onclick="orderDeliveryDetailBtn.cancelClaim('${claimDetail.clmNo}', '${claimDetail.clmTpCd}', '${session.mbrNo}');return false;">접수취소</a>
		 					</c:if>
						</div>
					</td>
				</tr>
			</c:if>
		</c:forEach>
	</c:forEach>
	</tbody>
</table>
<!-- // 주문내역 -->

<!-- 결제정보 -->
<div class="box_title_area mgt25">
	<h3>결제정보 </h3>
</div>

<table class="table_type1">
	<caption>결제정보</caption>
	<colgroup>
		<col style="width:15%" />
		<col style="width:auto" />
		<col style="width:15%" />
		<col style="width:35%" />
	</colgroup>
	<tbody>
		<tr>
			<th>총 상품금액</th>
			<td class="t_right"><strong class="point2"><frame:num data="${payInfo.goodsAmt}" />원</strong></td>
			<th>결제수단</th>
			<td>
				<frame:codeValue items="${payMeansCdList}" dtlCd="${payInfo.payMeansCd}" />
				<!-- 신용카드 -->
				<c:if test="${payInfo.payMeansCd eq FrontWebConstants.PAY_MEANS_10}">
	                 <a href="#" onClick="orderDeliveryDetailBtn.openCreditCard('${payInfo.ordNo}');return false;" class="btn_h20_type5 fix_w98 mgl5">신용카드전표</a>
	            </c:if>
			</td>
		</tr>
		<tr>
			<th>배송비</th>
			<td class="t_right"><frame:num data="${payInfo.dlvrAmt}" />원</td>
			<td class="rowspan" rowspan="4" colspan="2">
				<!-- 신용카드 -->
				<c:if test="${FrontWebConstants.PAY_MEANS_10 eq payInfo.payMeansCd}">
					<frame:codeValue items="${cardcCdList}" dtlCd="${payInfo.cardcCd}"/>카드<br />
					승인번호 : <frame:secret data="${payInfo.cfmNo}"/><br />
					승인일시 : <frame:timestamp date="${payInfo.cfmDtm}" dType="H" tType="HS"/>
				</c:if>
				<!-- 실시간계좌이체 및 가상 계좌 , 무통장-->
				<c:if test="${FrontWebConstants.PAY_MEANS_20 eq payInfo.payMeansCd or FrontWebConstants.PAY_MEANS_30 eq payInfo.payMeansCd or FrontWebConstants.PAY_MEANS_40 eq payInfo.payMeansCd}"><!-- 실시간계좌이체/가상계좌/무통장 -->
						은행명 : <frame:codeValue items="${bankCdList}" dtlCd="${payInfo.bankCd}"/>
						<c:if test="${FrontWebConstants.PAY_MEANS_20 ne payInfo.payMeansCd}">
						<br />계좌번호 : <c:out value="${payInfo.acctNo}"/>
						<br />예금주 : <c:out value="${payInfo.ooaNm}"/>
						</c:if>
						<c:if test="${FrontWebConstants.PAY_MEANS_20 ne payInfo.payMeansCd and FrontWebConstants.PAY_STAT_00 eq payInfo.payStatCd}">
							<c:if test="${FrontWebConstants.PAY_MEANS_40 eq payInfo.payMeansCd}">
							<br/>입금자 : <c:out value="${payInfo.dpstrNm}"/>
							</c:if>
							<br/><span class="fcolor_pink"><frame:timestamp date="${payInfo.dpstSchdDt}" dType="K" />까지 미입금시 주문취소</span>
						</c:if>
						<c:if test="${FrontWebConstants.PAY_STAT_01 eq payInfo.payStatCd}">
						<br/>결제일시 : <span class="fcolor999"><frame:timestamp date="${payInfo.payCpltDtm}" dType="H" tType="HS"/></span>
						</c:if>
				</c:if>
				
			</td>
		</tr>
		<tr>
			<th>적립금</th>
			<td class="t_right">
				<c:if test="${payInfo.svmnAmt ne 0}">(-)</c:if><frame:num data="${payInfo.svmnAmt}"/>원
			</td>
		</tr>
		<tr>
			<th>쿠폰할인</th>
			<td class="t_right">
			<c:if test="${payInfo.cpDcAmt ne 0}">(-)</c:if><frame:num data="${payInfo.cpDcAmt}"/>원
			</td>
		</tr>
		<tr>
			<th>결제금액</th>
			<td class="t_right">
				<frame:num data="${payInfo.payAmt}" />원
			</td>
		</tr>
	</tbody>
</table>
<!-- //결제정보 -->

<!-- 배송정보 -->
<div class="box_title_area mgt25">
	<h3>배송정보</h3>
</div>
<table class="table_type1">
	<caption>배송정보</caption>
	<colgroup>
		<col style="width:15%" />
		<col style="width:auto" />
		<col style="width:15%" />
		<col style="width:35%" />
	</colgroup>
	<tbody>
		<tr>
			<th>받으시는 분</th>
			<td colspan="3"><c:out value="${orderDlvraInfo.adrsNm}" /></td>
		</tr>
		<tr>
			<th>휴대폰 번호</th>
			<td><frame:mobile data="${orderDlvraInfo.mobile}" /></td>
			<th>전화번호</th>
			<td><frame:tel data="${orderDlvraInfo.tel}" /></td>
		</tr>
		<tr>
			<th>배송 주소</th>
			<td colspan="3">
				[우편번호] <c:out value="${orderDlvraInfo.postNoNew}"/><br/>
				[도로명주소] <c:out value="${orderDlvraInfo.roadAddr}" /> <c:out value="${orderDlvraInfo.roadDtlAddr}" /><br />
				[지번주소] <c:out value="${orderDlvraInfo.prclAddr}" /> <c:out value="${orderDlvraInfo.prclDtlAddr}" />
			</td>
		</tr>
		<tr>
			<th>배송 메시지</th>
			<td colspan="3"><c:out value="${orderDlvraInfo.dlvrMemo}" /></td>
		</tr>

	</tbody>
</table>
<!-- //배송정보 -->

<!-- 주문자정보 -->
<div class="box_title_area mgt25">
	<h3>주문자정보</h3>
</div>
<table class="table_type1">
	<caption>주문자정보</caption>
	<colgroup>
		<col style="width:15%" />
		<col style="width:auto" />
		<col style="width:15%" />
		<col style="width:35%" />
	</colgroup>
	<tbody>
		<tr>
			<th>주문하시는 분</th>
			<td colspan="3"><c:out value="${orderBase.ordNm}"/></td>
		</tr>
		<tr>
			<th>휴대폰 번호</th>
			<td><frame:mobile data="${orderBase.ordrMobile}"/></td>
			<th>전화번호</th>
			<td><frame:tel data="${orderBase.ordrTel}"/></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td colspan="3"><c:out value="${orderBase.ordrEmail}"/></td>
		</tr>
	</tbody>
</table>
<!-- //주문자정보 -->

<!-- 버튼영역 -->
<div class="btn_area_center">
<c:if test="${session.mbrNo ne FrontWebConstants.NO_MEMBER_NO}">
	<c:choose>
		<c:when test="${mgb eq 'oc'}">
			<a href="/mypage/order/indexClaimList" class="btn_h60_type1">취소/교환/반품조회 가기</a>
		</c:when>
		<c:otherwise>
			<a href="/mypage/order/indexDeliveryList" class="btn_h60_type1">주문/배송조회 가기</a>
		</c:otherwise>
	</c:choose>
</c:if>
<c:if test="${orderBase.ordStatCd eq FrontWebConstants.ORD_STAT_20 and vldQty > 0}">
	<a href="#" onclick="orderDeliveryDetailBtn.openPurchaseReceipt('${orderBase.ordNo}');return false;" class="btn_h60_type2">구매영수증 출력</a>
</c:if>
</div>
<!-- 버튼영역 -->