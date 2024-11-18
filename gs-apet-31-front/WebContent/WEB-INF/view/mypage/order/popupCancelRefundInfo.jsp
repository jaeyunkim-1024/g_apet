<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %> 

<%@ page import="front.web.config.constants.FrontWebConstants" %>

<script type="text/javascript">

	$(document).ready(function(){
	}); // End Ready

	$(function() {


	});

</script>

<c:set value="${claimBaseVO.claimDetailRefundListVO[0]}" var="setClaimDetailRefund"/>
<div id="pop_contents">
	<h2 class="pop_tit1 mgt10"><frame:codeValue items="${clmTpCdList}" dtlCd="${setClaimDetailRefund.clmTpCd}" /> 정보</h2>
	<table class="table_type1">
		<caption>클레임정보</caption>
		<colgroup>
			<col style="width:15%">
			<col style="width:auto">
			<col style="width:15%">
			<col style="width:35%">
		</colgroup>
		<tbody>
			<tr>
				<th>신청사유</th>
				<td colspan="3">
					<frame:codeValue items="${clmRsnCdList}" dtlCd="${setClaimDetailRefund.clmRsnCd}"/>
					<c:if test="${not empty setClaimDetailRefund.clmRsnContent}">
						(${setClaimDetailRefund.clmRsnContent})
<%-- 										 <div>${setClaimDetailRefund.clmRsnContent}</div> --%>
					</c:if>
				</td>
			</tr>
			<tr>
				<th>신청일</th>
				<td><frame:timestamp date="${claimBaseVO.acptDtm}" dType="H"/></td>
				<th>주문상태</th>
				<td>
<%-- 					<frame:codeValue items="${clmDtlStatCdList}" dtlCd="${setClaimDetailRefund.clmDtlStatCd}" /> --%>
<%-- 					<c:if test="${setClaimDetailRefund.clmStatCd eq FrontWebConstants.CLM_STAT_40}"> --%>
<%-- 						<frame:codeValue items="${clmStatCdList}" dtlCd="${setClaimDetailRefund.clmStatCd}" /> --%>
<%-- 					</c:if> --%>
					<c:if test="${setClaimDetailRefund.clmStatCd eq FrontWebConstants.CLM_STAT_20 }">
						<frame:codeValue items="${clmDtlStatCdList}" dtlCd="${setClaimDetailRefund.clmDtlStatCd}"  type="S"/>
					</c:if>
					<c:if test="${setClaimDetailRefund.clmStatCd ne FrontWebConstants.CLM_STAT_20 }">
						<frame:codeValue items="${clmTpCdList}" dtlCd="${setClaimDetailRefund.clmTpCd}"  />
						<frame:codeValue items="${clmStatCdList}" dtlCd="${setClaimDetailRefund.clmStatCd}"  />
					</c:if>
					<c:if test="${claimBaseVO.swapYn eq FrontWebConstants.COMM_YN_Y}"><br/>[맞교환]</c:if>
				</td>
			</tr>
			<c:if test="${(setClaimDetailRefund.clmTpCd eq FrontWebConstants.CLM_TP_20 or setClaimDetailRefund.clmTpCd eq FrontWebConstants.CLM_TP_30)
							and setClaimDetailRefund.clmStatCd ne FrontWebConstants.CLM_STAT_40}">
				<tr>
					<th>주문자</th>
					<td>${claimBaseVO.ordNm}</td>
					<th>휴대전화</th>
					<td>
						<frame:mobile data="${deliveryInfo.mobile}"/>
						<c:if test="${deliveryInfo.tel ne null &&  deliveryInfo.tel ne ''}">
						 	/ <frame:tel data="${deliveryInfo.tel}"/>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td colspan="3">
						<c:if test="${deliveryInfo.roadAddr ne null}">
						 [도로명주소] <c:out value="${deliveryInfo.roadAddr}"/>, <c:out value="${deliveryInfo.roadDtlAddr}"/><%--  , <c:out value="${deliveryInfo.postNoOld}"/>  --%>
						</c:if>
						<%-- <c:if test="${deliveryInfo.prclAddr ne null}">
							<c:if test="${deliveryInfo.roadAddr ne null}"><br></c:if>					
						[지번주소] <c:out value="${deliveryInfo.prclAddr}"/>, <c:out value="${deliveryInfo.prclDtlAddr}"/> ,  <c:out value="${deliveryInfo.postNoNew}"/> 
						</c:if>	 --%>
					</td>
				</tr>
				<c:if test="${setClaimDetailRefund.clmTpCd eq FrontWebConstants.CLM_TP_30}">
					<c:set value="${claimRefundPayVO.orgDlvrcAmt - claimRefundPayVO.newRtnOrgDlvrcAmt - claimRefundPayVO.clmDlvrcAmt}" var="dlvrcAmt"/> 
					<tr>
						<th>교환 정보</th>
						<td colspan="3">${setClaimDetailRefund.clmQty}개/${setClaimDetailRefund.itemNm}</td>
					</tr>
					<c:if test="${dlvrcAmt*-1 > 0}">
						<tr>
							<th>교환배송비</th>
							<td colspan="3"><frame:num data="${dlvrcAmt*-1}"/> 원</td>
						</tr>
					</c:if>
				</c:if>
			</c:if>
		</tbody>
	</table>
	
	<c:if test="${(setClaimDetailRefund.clmTpCd eq FrontWebConstants.CLM_TP_10 or setClaimDetailRefund.clmTpCd eq FrontWebConstants.CLM_TP_20)
					and setClaimDetailRefund.clmStatCd ne FrontWebConstants.CLM_STAT_40 and claimBaseVO.ordStatCd ne FrontWebConstants.ORD_STAT_10}">		
		<h2 class="pop_tit1 mgt30">환불정보</h2>
		<!-- 환불 정보 -->
		<div class="price_area">
			<div class="total_price">
				<table>
					<caption>환불정보</caption>
						<colgroup>
							<col style="width:33%" />
							<col style="width:33%" />
							<col style="width:auto" />
						</colgroup>
						<thead>									
						<tr>
							<th scope="col">취소/반품금액</th>
							<th scope="col" style="border-left:1px solid #dadada;">차감금액</th>
							<th scope="col">환불금액</th>
						</tr>
						</thead>
						<tbody>
						<tr>
							<td class="cost_cell border_other">
								<div class="posr">
									<span id="goodsAmt"><frame:num data="${claimRefundPayVO.goodsAmt + claimRefundPayVO.orgDlvrcAmt - claimRefundPayVO.cpDcAmt}"/></span> 
								</div>
							</td>
							<td class="cost_cell font_red">
								<div class="posr">
									<span class="icon_plus"><img src="<c:out value='${view.imgComPath}' />/common/total_count_th3.png" alt="-"></span>
									<span id="goodsAddAmt"><frame:num data="${claimRefundPayVO.clmDlvrcAmt + claimRefundPayVO.newRtnOrgDlvrcAmt}"/></span>
								</div>
							</td>
							<td class="cost_cell">
								<div class="posr">
									<span class="icon_plus"><img src="<c:out value='${view.imgComPath}' />/common/total_count_th2.png" alt="="></span>
									<span id="goodsTotalAmt"><frame:num data="${claimRefundPayVO.totAmt}"/></span>
								</div>
							</td>
						</tr> 
						<tr class="detail_cell">
							<td>
								<dl>
									<dt>상품금액</dt>
									<dd><frame:num data="${claimRefundPayVO.goodsAmt}"/> 원</dd>
								</dl>
								<dl>
									<dt>쿠폰할인</dt>
									<dd><c:if test="${claimRefundPayVO.cpDcAmt > 0}">(-) </c:if><frame:num data="${claimRefundPayVO.cpDcAmt}"/> 원</dd>
								</dl>
								<dl>
									<dt>배송비</dt>
									<dd><frame:num data="${claimRefundPayVO.orgDlvrcAmt}"/> 원</dd>
								</dl>
							</td>
							<td>
								<dl>
									<dt>추가배송비</dt>
									<dd><frame:num data="${claimRefundPayVO.newRtnOrgDlvrcAmt + claimRefundPayVO.clmDlvrcAmt }"/> 원</dd>
								</dl>
							</td>
							<td>
								<c:forEach items="${claimRefundPayVO.claimRefundPayDetailListVO}" var="claimRefundPayDetail" varStatus="dIdx">
									<dl>
									<c:choose>
										<c:when test="${claimRefundPayDetail.payMeansCd eq FrontWebConstants.PAY_MEANS_20 
															or claimRefundPayDetail.payMeansCd eq FrontWebConstants.PAY_MEANS_30
															or claimRefundPayDetail.payMeansCd eq FrontWebConstants.PAY_MEANS_40}">
											<dt>환불계좌입금</dt>
										</c:when>
										<c:when test="${claimRefundPayDetail.payMeansCd eq FrontWebConstants.PAY_MEANS_10}">
											<dt>신용카드</dt>
										</c:when>
										<c:otherwise>
											<dt>적립금</dt>
										</c:otherwise>
									</c:choose>
									</dl>
									<dd>
										<frame:num data="${claimRefundPayDetail.payAmt}"/> 원<br />
									</dd>
								</c:forEach>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</c:if>
		<!-- //환불 금액 -->	
</div>