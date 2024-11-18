<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<%@ page import="framework.common.constants.CommonConstants" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<script type="text/javascript">

	$(document).ready(function(){
		
	}); // End Ready
	
	
	
	$(function() {
		// 페이지 클릭 이벤트
		$("#claim_request_list_page a").click(function(){
			var page =$(this).children("span").html();
			$("#claim_list_page").val(page);
			reloadClaimRequestList();

			return false;
		});
	});
	
	/*
	 * 취소, 교환, 반품 조회 화면 리로딩
	 */
	function reloadClaimRequestList(){
		var action = "/mypage/order/indexClaimRequestList";
		
		$("#claim_request_list_form").attr("target", "_self");
		$("#claim_request_list_form").attr("action", action);
		$("#claim_request_list_form").submit();
	}
	
	/*
	 * 주문취소 신청 페이지 이동
	 */
	function goCancelRequest(ordNo, ordDtlSeq){
		var action = "/mypage/order/indexCancelRequest";
		
		$("#ord_no").val(ordNo);
		$("#ord_dtl_seq").val(ordDtlSeq);
		$("#claim_request_list_form").attr("target", "_self");
		$("#claim_request_list_form").attr("method", "post");
		$("#claim_request_list_form").attr("action", action);
		$("#claim_request_list_form").submit();
	}
	
	/*
	 * 주문 반품 신청 페이지 이동
	 */
	function goReturnRequest(ordNo, ordDtlSeq, rtnIngYn, rtnPsbYn){
		if(rtnIngYn == "Y"){
			alert("<spring:message code='front.web.view.claim.refund.claim_ing' />");
			return;
		}

		if(rtnPsbYn != "Y"){
			alert("<spring:message code='front.web.view.claim.refund.claim_psb' />");
			return;
		}
		
		var action = "/mypage/order/indexReturnRequest";
		
		$("#ord_no").val(ordNo);
		$("#ord_dtl_seq").val(ordDtlSeq);
		$("#claim_request_list_form").attr("target", "_self");
		$("#claim_request_list_form").attr("method", "post");
		$("#claim_request_list_form").attr("action", action);
		$("#claim_request_list_form").submit();
	}

	/*
	 * 주문 교환 신청 페이지 이동
	 */
	function goExchangeRequest(ordNo ,ordDtlSeq){
		var action = "/mypage/order/indexExchangeRequest";
		
		$("#ord_no").val(ordNo);
		$("#ord_dtl_seq").val(ordDtlSeq);
		$("#claim_request_list_form").attr("target", "_self");
		$("#claim_request_list_form").attr("method", "post");
		$("#claim_request_list_form").attr("action", action);
		$("#claim_request_list_form").submit();
	}
	
	/*
	 * 주문상세 페이지 이동
	 */
	function goOrderDetail(ordNo){
		var action = "/mypage/order/indexDeliveryDetail";
		
		var inputs = "<input type=\"hidden\" name=\"ordNo\" value=\""+ordNo+"\"/>";
		jQuery("<form action=\"" + action + "\" method=\"get\">"+inputs+"</form>").appendTo('body').submit();
	}
	
	//주문 전체 취소
	function allOrderCancel(ordNo){
		$("#ordNo").val(ordNo);
		$("#clmTpCd").val('${CommonConstants.CLM_TP_10}');
		
		if(confirm(ordNo +' <spring:message code="front.web.view.claim.confirm.cancel_accept" />')){
			// 신청하기
			insertAccess(ordNo);
		}
	}
	
	function insertAccess(){
		var options = {
				   url : "<spring:url value='/mypage/claimAllCancelAccept' />"
				, data : $("#claim_request_list_form").serialize()
				, done : function(data){
					alert('<spring:message code="front.web.view.claim.claim_cancel.success" />');
					if(data != null){
						reloadClaimRequestList();
					}
				}
			};
			ajax.call(options);
	}
	
</script>
<div class="box_title_area">
    <h3>취소/교환/반품</h3>
    <div class="sub_text2">
        취소/교환/반품 가능한 주문정보를 조회합니다.
    </div>
</div>

<c:if test="${session.mbrNo ne FrontWebConstants.NO_MEMBER_NO}">
<!-- 신청 현황 -->
<jsp:include page="../include/includeClaimSummary.jsp" />
<!-- 신청 현황 -->
</c:if>

<!-- 탭 -->
 <div class="tab_menu01 length4 mgt35">
	<ul>
		<li class="on"><a href="/mypage/order/indexClaimRequestList">취소/교환/반품 신청</a></li>
		<li><a href="/mypage/order/indexClaimList">취소/교환/반품 조회</a></li>
	</ul>
</div>
<!-- //탭 -->

<!-- 주문 목록 -->
<form id="claim_request_list_form">
	<input type="hidden" id="ord_no" name="ordNo" value="" />
	<input type="hidden" id="ord_dtl_seq" name="ordDtlSeq" value="" />
	<input type="hidden" id="clm_tp_cd" name="clmTpCd" value=""/>
	<input type="hidden" id="clmTpCd" name="clmTpCd" value=""/>
<div class="mgt20">
	<div class="point3">※ 주문취소/교환/반품이 가능한 상품에만 접수 버튼이 표시됩니다.</div>
	<table class="table_cartlist1 mgt10">
		<caption>주문내역</caption>
		<colgroup>
			<col style="width:16%">
			<col style="width:70px">
			<col style="width:auto">
			<col style="width:13%">
			<col style="width:13%">
			<col style="width:10%">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">주문번호</th>
				<th scope="col" colspan="2">상품정보</th>
				<th scope="col">배송/판매자</th>
				<th scope="col">주문상태</th>
				<th scope="col">주문관리</th>
			</tr>
		</thead>
		<tbody>
<c:choose>
<c:when test="${orderList ne '[]'}">
	<c:forEach items="${orderList}" var="order" varStatus="idx">
<%-- 		<input type="hidden" id="allClaimIngRtnYn${idx.index}" name="allClaimIngRtnYn" value="${order.allClaimIngRtnYn}" > --%>
		
		<!-- 배송/판매자 영역 rowspan 관련 변수 -->
		<c:set var="compSpan" value="1"/><!-- rowspan 설정 값 -->
		<c:set var="oriCompSpan" value=""/><!-- rowspan 적용 영역 -->
		<c:set var="oriCompNo" value="" /><!-- 비교용 업체 번호 -->
		<c:set var="ordSpan" value="1"/><!-- rowspan 설정 값 -->
		<c:set var="oriOrdSpan" value=""/><!-- rowspan 적용 영역 -->
		<c:set var="oriOrdNo" value="" />
		
		<c:forEach items="${order.orderClaimDetailList}" var="orderClaimDetailList" varStatus="dIdx">
			<c:set value="${orderClaimDetailList.ordDtlStatCd}" var="ordDtlStatCd"/>
			<c:choose>
            <c:when test="${dIdx.first}">
			     <c:set var="oriCompNo" value="${orderClaimDetailList.compNo}" />
			     <c:set var="oriOrdNo" value="${order.ordNo}" />
			<tr>
				<td rowspan="${fn:length(order.orderClaimDetailList)}" class="rowspan">
					<a href="#" onclick="goOrderDetail('${order.ordNo}');return false;" class="order_number">${order.ordNo}</a>
					<span class="order_date01">(<frame:timestamp date="${order.ordAcptDtm}" dType="H" />)</span>
					<a href="#" class="btn_h20_type6 mgt4" onclick="goOrderDetail('${order.ordNo}');return false;">주문상세보기</a>
					<c:if test="${order.ordCancelPsbYn eq FrontWebConstants.COMM_YN_Y and fn:length(order.orderClaimDetailList) > 1}">
						<a href="#" class="btn_h20_type6 mgt4"  onclick="goCancelRequest('${order.ordNo}');return false;">주문전체취소</a>
					</c:if>
				</td>
				<td class="img_cell v_top"><a href="/goods/indexGoodsDetail?goodsId=${orderClaimDetailList.goodsId}"><frame:goodsImage imgPath="${orderClaimDetailList.imgPath}" goodsId="${orderClaimDetailList.goodsId}" seq="${orderClaimDetailList.imgSeq}" size="${ImageGoodsSize.SIZE_70.size}" gb="" /></a></td>
				<td class="align_left v_top">
					<div class="product_name">
						<a href="/goods/indexGoodsDetail?goodsId=${orderClaimDetailList.goodsId}">[${orderClaimDetailList.bndNmKo}] ${orderClaimDetailList.goodsNm}</a>
						<div class="product_option">
							<span>${orderClaimDetailList.itemNm}</span>
						</div>
						<div class="product_cost"><frame:num data="${orderClaimDetailList.saleAmt}" />원/<c:out value="${orderClaimDetailList.rmnOrdQty - orderClaimDetailList.rtnQty - orderClaimDetailList.clmExcIngQty}" />개</div>
						<input type="hidden" id="selectCheck${dIdx.index}" name="selectCheck" value="${dIdx.index}" >
						<input type="hidden" id="selectChecked${dIdx.index}" name="selectChecked" value="${dIdx.index}" >
						<input type="hidden" id="goodsId${dIdx.index}" name="goodsId" value="${orderClaimDetailList.goodsId}" /> <!-- 상품id -->
						<input type="hidden" id="bndNmKo${dIdx.index}"  value="${orderClaimDetailList.bndNmKo}" /> <!-- 브랜드명 한글 -->
						<input type="hidden" id="goodsNm${dIdx.index}"  value="${orderClaimDetailList.goodsNm}" /> <!-- 상품명 -->
						<input type="hidden" id="itemNm${dIdx.index}" value="${orderClaimDetailList.itemNm}" /> <!-- 단품 명(옵션?) -->
						<input type="hidden" id="saleAmt${dIdx.index}"  value="${orderClaimDetailList.saleAmt}" /> <!-- 팬매금액 -->
						<input type="hidden" id="ordQty${dIdx.index}"  value="${orderClaimDetailList.ordQty}" /> <!-- 수량 -->
						<input type="hidden" id="payAmt${dIdx.index}"  name="arrPayAmt" value="${orderClaimDetailList.payAmt}" /> <!-- 주문금액 -->
						<input type="hidden" id="payMeansCd${dIdx.index}"   value="${orderClaimDetailList.payMeansCd}" /> <!-- 결제 수단 코드 -->
						<input type="hidden" id="ordDtlSeq${dIdx.index}" value="${orderClaimDetailList.ordDtlSeq}" />
						<input type="hidden" id="arrOrdDtlSeq${dIdx.index}" name="arrOrdDtlSeq"  value="${orderClaimDetailList.ordDtlSeq}" />
						<input type="hidden" id="cancelAll${dIdx.index}" name="cancelAll"  value="${order.cancelAll}" />
						<input type="hidden" id="ordDtlStatCd${dIdx.index}" name="ordDtlStatCd" value="${ordDtlStatCd}" />
					</div>
				</td>
				<td id="comp_span_${order.ordNo}_${dIdx.index}" class="rowspan">
				<c:set var="oriCompSpan" value="${dIdx.index}"/>
					<div>${orderClaimDetailList.compNm}</div>
				</td>
				<td class="rowspan"><div><frame:codeValue items="${ordDtlStatCdList}" dtlCd="${orderClaimDetailList.orderDtlCodeName}" /></div></td>
				<c:choose>
				<c:when test="${orderClaimDetailList.compareDtmYn eq FrontWebConstants.COMM_YN_Y}">
				    <c:choose>
					<c:when test="${ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_120
										or (ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_110 and fn:length(order.orderClaimDetailList) eq 1)}">
				<td class="rowspan">
				    <!-- div>주문취소가능</div -->
					<a href="#" onclick="goCancelRequest('${order.ordNo}','${orderClaimDetailList.ordDtlSeq}');return false;" class="btn_h20_type6 mgt4">주문취소</a>
				</td>
					</c:when>
					<%--c:when test="${(ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_160) or (ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_08) or (ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_13) or (ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_15) or (ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_20) or (ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_22) or(ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_23)}" --%>
					<c:when test="${(ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_160)}">				
						<td id="ord_span1_${order.ordNo}_${dIdx.index}" class="rowspan">
 							<c:if test="${ orderClaimDetailList.rmnOrdQty - orderClaimDetailList.rtnQty - orderClaimDetailList.clmExcIngQty > 0 }">	
								<a href="#" onclick="goReturnRequest('${order.ordNo}','${orderClaimDetailList.ordDtlSeq}','${orderClaimDetailList.allClaimIngRtnYn}', '${orderClaimDetailList.rtnPsbYn}');return false;" class="btn_h20_type6 mgt4">반품신청</a>
								<a href="#" onclick="goExchangeRequest('${order.ordNo}','${orderClaimDetailList.ordDtlSeq}');return false;" class="btn_h20_type6">교환신청</a>
 							</c:if>
						</td>
					</c:when>
					<c:otherwise>
				<td class="rowspan"><div><%--frame:codeValue items="${ordDtlStatCdList}" dtlCd="${orderClaimDetailList.ordDtlStatCd}" / --%></div></td>
					</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
				<td class="rowspan"><div></div></td>
				</c:otherwise>
				</c:choose>
			</tr>
			</c:when>
			<c:otherwise>
			<tr>
				<td class="img_cell v_top"><a href="/goods/indexGoodsDetail?goodsId=${orderClaimDetailList.goodsId}"><frame:goodsImage imgPath="${orderClaimDetailList.imgPath}" goodsId="${orderClaimDetailList.goodsId}" seq="${orderClaimDetailList.imgSeq}" size="${ImageGoodsSize.SIZE_70.size}" gb="" /></a></td>
				<td class="align_left v_top">
					<div class="product_name">
						<a href="/goods/indexGoodsDetail?goodsId=${orderClaimDetailList.goodsId}">[${orderClaimDetailList.bndNmKo}] ${orderClaimDetailList.goodsNm}</a>
						<div class="product_option">
							<span>${orderClaimDetailList.itemNm}</span>
						</div>
						<div class="product_cost"><frame:num data="${orderClaimDetailList.saleAmt}" />원/${orderClaimDetailList.rmnOrdQty - orderClaimDetailList.rtnQty - orderClaimDetailList.clmExcIngQty}개</div>
						
						<input type="hidden" id="selectCheck${dIdx.index}" name="selectCheck" value="${dIdx.index}" >
						<input type="hidden" id="selectChecked${dIdx.index}" name="selectChecked" value="${dIdx.index}" >
						<input type="hidden" id="goodsId${dIdx.index}" name="goodsId" value="${orderClaimDetailList.goodsId}" /> <!-- 상품id -->
						<input type="hidden" id="bndNmKo${dIdx.index}"  value="${orderClaimDetailList.bndNmKo}" /> <!-- 브랜드명 한글 -->
						<input type="hidden" id="goodsNm${dIdx.index}"  value="${orderClaimDetailList.goodsNm}" /> <!-- 상품명 -->
						<input type="hidden" id="itemNm${dIdx.index}" value="${orderClaimDetailList.itemNm}" /> <!-- 단품 명(옵션?) -->
						<input type="hidden" id="saleAmt${dIdx.index}"  value="${orderClaimDetailList.saleAmt}" /> <!-- 팬매금액 -->
						<input type="hidden" id="ordQty${dIdx.index}"  value="${orderClaimDetailList.ordQty}" /> <!-- 수량 -->
						<input type="hidden" id="payAmt${dIdx.index}"  name="arrPayAmt" value="${orderClaimDetailList.payAmt}" /> <!-- 주문금액 -->
						<input type="hidden" id="payMeansCd${dIdx.index}"   value="${orderClaimDetailList.payMeansCd}" /> <!-- 결제 수단 코드 -->
						<input type="hidden" id="ordDtlSeq${dIdx.index}" value="${orderClaimDetailList.ordDtlSeq}">
						<input type="hidden" id="arrOrdDtlSeq${dIdx.index}" name="arrOrdDtlSeq"  value="${orderClaimDetailList.ordDtlSeq}">
						<input type="hidden" id="cancelAll${dIdx.index}" name="cancelAll"  value="${order.cancelAll}" />
						<input type="hidden" id="ordDtlStatCd${dIdx.index}" name="ordDtlStatCd" value="${ordDtlStatCd}"/>
					</div>
				</td>
				<c:if test="${oriCompNo eq orderClaimDetailList.compNo}">
				    <c:set var="compSpan" value="${compSpan + 1}"/>
				<script>$("#comp_span_${order.ordNo}_${oriCompSpan}").attr("rowspan", '${compSpan}');</script>
				</c:if>
				<c:if test="${oriOrdNo eq order.ordNo}">
					<c:choose>
					<%--c:when test="${(sOrdDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_160) or (sOrdDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_08) or (sOrdDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_13) or (sOrdDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_15)}">
						<c:if test="${(ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_160) or (ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_08) or (ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_13) or (ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_15)}" --%>
                    <c:when test="${(sOrdDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_160)}">
                        <c:if test="${(ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_160)}">
					       <%--c:choose>
					       <c:when test="${sRtnPsbYn eq FrontWebConstants.COMM_YN_Y and orderClaimDetailList.rtnPsbYn eq FrontWebConstants.COMM_YN_Y}"  >
						      <c:set var="rowSpanYn" value="Y"/>
						      <c:set var="ordSpan" value="${ordSpan + 1}"/>
				<script>
					$("#ord_span_${order.ordNo}_${oriOrdSpan}").attr("rowspan", '${ordSpan}');
					$("#ord_span1_${order.ordNo}_${oriOrdSpan}").attr("rowspan", '${ordSpan}');
				</script>
					       </c:when>
					       <c:otherwise>
						      <c:set var="rowSpanYn" value="N"/>
					       </c:otherwise>
					       </c:choose--%>
					       <c:set var="rowSpanYn" value="N"/>
				        </c:if>
                    </c:when>
						<%--c:when test="${(sOrdDtlStatCd ne FrontWebConstants.ORD_DTL_STAT_160) or (sOrdDtlStatCd ne FrontWebConstants.ORD_DTL_STAT_08) or (sOrdDtlStatCd ne FrontWebConstants.ORD_DTL_STAT_13) or (sOrdDtlStatCd ne FrontWebConstants.ORD_DTL_STAT_15)}">
							<c:if test="${(ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_160) or (ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_08) or (ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_13) or (ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_15)}" --%>
                    <c:when test="${(sOrdDtlStatCd ne FrontWebConstants.ORD_DTL_STAT_160)}">
                        <c:if test="${(ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_160)}">
                            <c:set var="rowSpanYn" value="N"/>
						</c:if>
					</c:when>
					<c:otherwise>
						<c:set var="rowSpanYn" value="N"/>
					</c:otherwise>
					</c:choose>
				</c:if>
				<c:if test="${oriCompNo ne orderClaimDetailList.compNo}">
				    <c:set var="compSpan" value="1"/>
				    <c:set var="oriCompSpan" value="${dIdx.index}"/>
				    <c:set var="oriCompNo" value="${orderClaimDetailList.compNo}" />
				<td id="comp_span_${order.ordNo}_${dIdx.index}" class="rowspan" rowspan="1">
					<div><c:out value="${orderClaimDetailList.compNm}" /></div>
				</td>
				</c:if>
				<td class="rowspan"><div><frame:codeValue items="${ordDtlStatCdList}" dtlCd="${orderClaimDetailList.orderDtlCodeName}" type="S"/></div></td>
				<c:choose>
				<c:when test="${orderClaimDetailList.compareDtmYn eq FrontWebConstants.COMM_YN_Y}">
					<c:choose>
					<c:when test="${ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_120}">
						<td class="rowspan">
						    <!-- div>주문취소가능</div -->
							<a href="#" onclick="goCancelRequest('${order.ordNo}','${orderClaimDetailList.ordDtlSeq}');return false;" class="btn_h20_type6 mgt4">주문취소</a>
						</td>
					</c:when>
						<%--c:when test="${(ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_160) or (ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_08) or (ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_13) or (ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_15)}" --%>
					<c:when test="${(ordDtlStatCd eq FrontWebConstants.ORD_DTL_STAT_160)}">
						<td id="ord_span1_${order.ordNo}_${dIdx.index}" class="rowspan" rowspan="1">
	 						<c:if test="${ orderClaimDetailList.rmnOrdQty - orderClaimDetailList.rtnQty - orderClaimDetailList.clmExcIngQty > 0 }">
								<a href="#" onclick="goReturnRequest('${order.ordNo}','${orderClaimDetailList.ordDtlSeq}','${orderClaimDetailList.allClaimIngRtnYn}', '${orderClaimDetailList.rtnPsbYn}');return false;" class="btn_h20_type6 mgt4">반품신청</a>
								<a href="#" onclick="goExchangeRequest('${order.ordNo}','${orderClaimDetailList.ordDtlSeq}');return false;" class="btn_h20_type6">교환신청</a>
							</c:if>
						</td>
					</c:when>
					<c:otherwise>
				<%-- <td class="rowspan"><div><c:if test="${order.pageGbCd eq CommonConstants.PAGE_GB_SHOP9999}" ><frame:codeValue items="${ordDtlStatCdList}" dtlCd="${orderClaimDetailList.ordDtlStatCd}" /></c:if></div></td>  --%>
				<td class="rowspan"><div></div></td>
					</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
				<td class="rowspan"><div><frame:codeValue items="${ordDtlStatCdList}" dtlCd="${orderClaimDetailList.ordDtlStatCd}" /></div></td>
				</c:otherwise>
				</c:choose>
			</tr>
			</c:otherwise>
			</c:choose>
			<c:set value="${ordDtlStatCd}" var="sOrdDtlStatCd"/>
			<%--c:set value="${orderClaimDetailList.rtnPsbYn}" var="sRtnPsbYn"/ --%>
		</c:forEach>
	</c:forEach>
</c:when>
<c:otherwise>
            <tr>
                <td colspan="6" class="nodata">취소/교환/반품 가능한 주문내역이 없습니다.</td>
			</tr>
</c:otherwise>
</c:choose>
		</tbody>
	</table>
	<!-- 페이징 -->
	<input type="hidden" id="claim_list_page" name="page" value="<c:out value="${orderSO.page}" />" />
	<input type="hidden" id="claim_list_rows" name="rows" value="<c:out value="${orderSO.rows}" />" />
	<frame:listPage recordPerPage="${orderSO.rows}" currentPage="${orderSO.page}" totalRecord="${orderSO.totalCount}" indexPerPage="10" id="claim_request_list_page" />
	<!-- 페이징 -->
</div>
</form>
<!-- //주문 목록 -->

<!-- 취소/교환/반품 안내 -->
<div class="box_title_area mgt30">
	<h3>주문 배송 안내</h3>
</div>
<div class="info_order_state">
	<ul class="process_desc">
		<li class="process1">
			<div class="p_tit pos1">주문접수</div><span class="desc1">7일 이내 미입금 시<br/>주문이 취소됩니다.</span>
			<div class="p_tit pos2">결제완료</div><span class="desc2">결제가 완료되었습니다.</span>
			<div class="line_pass"><span class="arrow left"></span><span>배송지변경/주문취소 가능</span><span class="arrow right"></span></div>
		</li>
		<li class="process5">
			<div class="p_tit pos1">상품준비중</div><span class="desc1">판매자가 발송할 상품을<br/>준비중입니다.</span>
			<div class="p_tit pos2">배송중</div><span class="desc2">상품이 출고되어 배송중입니다.</span>
		</li>
		<li class="process4">
			<div class="p_tit">배송완료</div><span class="desc3">상품이 고객님께<br/>배송완료되었습니다.</span>
			<div class="line_pass"><span class="arrow left"></span><span>반품/교환/구매확정 가능</span><span class="arrow right"></span></div>
		</li>
	</ul>
</div>
<table class="order_cancel_desc_table">
	<tr>
		<th>주문취소</th>
		<td>
			<ul>
				<li>주문취소가 가능한 상품에만 주문취소 버튼이 표시됩니다. ('주문접수' 또는 '결제완료' 상태에서만 취소가 가능합니다.)</li>
				<li>묶음배송 상품 중 일부 취소로 무료배송 조건에 충족하지 않을 경우 고객이 배송비를 부담합니다. </li>
				<li>취소 후 환불은 결제수단에 따라 환불 소요기간이 상이합니다. 보다 상세 내용은 [상품페이지-배송/교환/환불] 에서 확인 가능합니다.</li>
			</ul>
		</td>
	</tr>
	<tr>
		<th>교환</th>
		<td>
			<ul>
				<li>교환은 배송완료 후 7일 이내 가능하며, 선택하신 교환사유에 따라 교환배송비가 발생될 수 있습니다.</li>
				<li>판매자귀책(제품하자, 오배송, 기타) 으로 요청 하셨더라도 상품 확인 결과에 따라 배송비 입금을 요청 드릴 수 있습니다.</li>
				<li>교환배송비 동봉으로 교환 접수를 하신 경우 교환배송비가 동봉되지 않으면 교환처리가 지연될 수 있습니다.</li>
				<li>포장 및 상품훼손, 또는 사용 여부에 따라 교환이 어려울 수 있으며, 상세 내용은 [상품페이지-배송/교환/환불] 에서 확인 가능합니다.</li>
				<li>교환 상품 반송 시 운송장은 교환이 완료될 때까지 보관해주시기 바랍니다.</li>
				<li>상품 재고가 없어 교환이 어려운 경우, 환불 처리 될 수 있습니다.</li>
			</ul>
		</td>
	</tr>
	<tr>
		<th>반품</th>
		<td>
			<ul>
				<li>반품은 배송완료 후 7일 이내 가능하며, 선택하신 반품사유에 따라 반품배송비가 발생될 수 있습니다.</li>
				<li>판매자귀책(제품하자, 오배송 등) 으로 요청 하셨더라도 상품 확인 결과에 따라 배송비가 차감 될 수 있습니다.</li>
				<li>포장 및 상품훼손, 또는 사용 여부에 따라 반품 및 환불이 어려울 수 있습니다.</li>
				<li>환불 불가한 경우에 대한 상세 내용은 [상품페이지-배송/교환/환불] 에서 확인 가능합니다.</li>
				<li>사은품 등이 포함되었을 경우, 함께 반품해 주셔야 합니다. </li>
				<li>환불은 반품완료 후 1~2영업일 내 처리됩니다.</li>
			</ul>
		</td>
	</tr>
</table>
<div class="mgt10 mgl6">※ 특정브랜드의 교환/환불에 대한 개별기준이 상품페이지에 있는 경우 브랜드의 개별기준이 우선 적용됩니다. </div>
<!-- //취소/교환/반품 안내 -->