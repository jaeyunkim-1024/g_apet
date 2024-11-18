<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<jsp:useBean id="now" class="java.util.Date" />

<script type="text/javascript">

	$(document).ready(function(){

		// 페이지 클릭 이벤트
		$("#receipt_list_page a").click(function(){
			var page =$(this).children("span").html();
			$("#receipt_list_page").val(page);
			pagingReceiptList();
		});

	}); // End Ready

	$(function() {

	});

	// 페이징
	function pagingReceiptList() {
		$("#receipt_list_form").attr("target", "_self");
		$("#receipt_list_form").attr("action", "/mypage/order/indexReceiptList");
		$("#receipt_list_form").submit();
	}

	/**********************************************************************
	 * 기간별 검색조건 관련 함수 Start
	 ***********************************************************************/

	// Calendar 생성
	$(function() {
		calendar.range("start_dt", "end_dt", {yearRange : 'c-10:c'});
	});

	// 기간선택 시 날짜 설정
	function searchPeriod(period) {
		$("input[name=period]").val(period);
		calendar.autoRange("start_dt", "end_dt", period);
		searchList();
	}

	// 날짜 조회 버튼 선택
	function searchDate(period) {
		$("input[name=period]").val("");
		searchList();
	}

	// 조회
	function searchList() {
		var startDt = new Date($("#start_dt").val());
		var endDt = new Date($("#end_dt").val());

		var diff = endDt.getTime() - startDt.getTime();

		if ( 365 < Math.floor(diff/(1000*60*60*24)) ) {
			alert("조회기간은 최대 12개월까지 설정가능 합니다.");
			return;
		}

		$("#receipt_list_page").val("1");	// 페이지 번호 초기화
		$("#receipt_list_form").attr("target", "_self");
		$("#receipt_list_form").attr("action", "/mypage/order/indexReceiptList");
		$("#receipt_list_form").submit();
	}

	/**********************************************************************
	 * 기간별 검색조건 관련 함수 End
	 ***********************************************************************/
	/*
	 * 세금계산서 신청

	function openTaxInvoiceRequest(ordNo, ordDtlSeq){
		var params = {
				ordNo : ordNo
			}
		pop.taxInvoiceRequest(params);
	} */

	/*
	 * 현금영수증 신청
	 */
	function openCashReceiptRequest(ordNo, cashRctNo){
		var params = {
				ordNo : ordNo,
				cashRctNo : cashRctNo
			}
		pop.cashReceiptRequest(params);
	}

    /*
    * 구매영수증 출력 팝업
    */
    function openPurchaseReceipt(ordNo){
        var params = {
                ordNo : ordNo
            }
        pop.purchaseReceipt(params);
    }

	/*
	* 현금영수증 출력 팝업
	*/
	function openCashReceipt(lnkDealNo){
		var params = {
				tid : lnkDealNo
			}
		pop.cashReceipt(params);
	}

	/*
	* 신용카드매출전표 출력 팝업
	*/
	function openCreditCard(ordNo){
		var params = {
				ordNo : ordNo
			}
		pop.creditCard(params);
	}

	function openGoodsDetail(goodsId){
		location.href = "/goods/indexGoodsDetail?goodsId="+goodsId;
	}

	/*
	 * 주문상세 페이지 이동
	 */
	function goOrderDetail(ordNo){
		var inputs = "<input type=\"hidden\" name=\"ordNo\" value=\""+ordNo+"\"/>";
		jQuery("<form action=\"/mypage/order/indexDeliveryDetail\" method=\"get\">"+inputs+"</form>").appendTo('body').submit();
	}

</script>

<div class="box_title_area">
	<h3>영수증 신청/조회</h3>
	<div class="sub_text2">
		주문 건에 대한 영수증 신청/조회가 가능합니다.
	</div>
</div>

<form id="receipt_list_form">
	<c:if test="${FrontWebConstants.NO_MEMBER_NO ne session.mbrNo}">
	<div class="order_lookup_box mgt10">
		<dl>
			<dt>기간별 조회</dt>
			<dd>
				<div class="btn_period_group">
					<a href="#" class="btn_period <c:if test="${orderSO.period eq '1'}">on</c:if>" onclick="searchPeriod(1);return false;">1개월</a>
					<a href="#" class="btn_period <c:if test="${orderSO.period eq '3'}">on</c:if>" onclick="searchPeriod(3);return false;">3개월</a>
					<a href="#" class="btn_period <c:if test="${orderSO.period eq '6'}">on</c:if>" onclick="searchPeriod(6);return false;">6개월</a>
					<a href="#" class="btn_period <c:if test="${orderSO.period eq '12'}">on</c:if>" onclick="searchPeriod(12);return false;">12개월</a>
					<input type="hidden" name="period" value="<c:out value="${orderSO.period}" />" />
				</div>
			</dd>
		</dl>
		<dl class="mgl20">
			<dt>날짜조회</dt>
			<dd>
				<span class="datepicker_wrap">
					<input type="text" readonly="readonly" class="datepicker" id="start_dt" name="ordAcptDtmStart" value="<frame:timestamp date="${orderSO.ordAcptDtmStart}" dType="H" />" title="날짜" />
				</span>
				-
				<span class="datepicker_wrap">
					<input type="text" readonly="readonly" class="datepicker" id="end_dt" name="ordAcptDtmEnd" value="<frame:timestamp date="${orderSO.ordAcptDtmEnd}" dType="H" />" title="날짜" />
				</span>
			</dd>
		</dl>
		<a href="#" class="btn_h25_type1 mgl10" onclick="searchDate();return false;">조회</a>
	</div>
	</c:if>

	<!-- 주문 목록 -->
	<div class="mgt20">
		<table class="table_cartlist1">
			<caption>주문내역</caption>
			<colgroup>
				<col style="width:16%">
				<col style="width:70px">
				<col style="width:auto">
				<col style="width:13%">
				<col style="width:13%">
				<col style="width:13%">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">주문번호</th>
					<th scope="col" colspan="2">상품정보</th>
					<th scope="col">결제금액</th>
					<th scope="col">진행상태</th>
					<th scope="col">발급신청/내역</th>
				</tr>
			</thead>
			<tbody>
<c:if test="${receiptList ne '[]'}">
	<fmt:formatDate value="${now}" pattern="yyyyMMdd" var="today" />
	<c:forEach items="${receiptList}" var="receiptList" varStatus="idx">
		<c:set var="rowCount" value="${fn:length(receiptList.orderDetailTaxListVO)}"/>
		<c:forEach items="${receiptList.orderDetailTaxListVO}" var="receiptDetail" varStatus="dIdx">
			<c:choose>
			<c:when test="${dIdx.first}">
                <tr>
					<td <c:if test="${rowCount > 1}">class="rowspan"</c:if> rowspan="${rowCount}">
						<a href="#" onclick="goOrderDetail('${receiptList.ordNo}');return false;" class="order_number"><c:out value="${receiptList.ordNo}"/></a>
						<span class="order_date01">(<frame:timestamp date="${receiptList.ordAcptDtm}" dType="H" />)</span>
					   <a class="btn_h20_type6 mgt4" href="#" onclick="openPurchaseReceipt('<c:out value="${receiptList.ordNo}" />');return false;">구매영수증</a>
					</td>
					<td class="img_cell v_top">
						<a href="#" onclick="openGoodsDetail('${receiptDetail.goodsId}');return false;">
                            <frame:goodsImage goodsId="${receiptDetail.goodsId}" seq="${receiptDetail.imgSeq}" imgPath="${receiptDetail.imgPath}" size="${ImageGoodsSize.SIZE_70.size}" gb="" />
                        </a>
					</td>
					<td class="align_left v_top">
                        <div class="product_name">
							<a href="#" onclick="openGoodsDetail('${receiptDetail.goodsId}');return false;">[<c:out value="${receiptDetail.bndNmKo}"/>] <c:out value="${receiptDetail.goodsNm}"/></a>
								<div class="product_option">
								    <span><c:out value="${receiptDetail.itemNm}"/></span>
								</div>
								<div class="product_cost"><frame:num data="${receiptDetail.saleAmt}" />원 / <c:out value="${receiptDetail.vldOrdQty}" />개</div>
						</div>
					</td>
					<td <c:if test="${rowCount > 1}">class="rowspan"</c:if> rowspan="${rowCount}">
						<strong class="point4"><frame:num data="${receiptList.payAmtTotal}" />원</strong>
					</td>
					<td <c:if test="${rowCount > 1}">class="rowspan"</c:if> rowspan="${rowCount}">
						<div>
				<c:forEach items="${receiptDetail.payBaseVOList }" var="payBase" varStatus="pIdx">
				<c:if test="${payBase.payMeansCd eq FrontWebConstants.PAY_MEANS_20 or payBase.payMeansCd eq FrontWebConstants.PAY_MEANS_30 or payBase.payMeansCd eq FrontWebConstants.PAY_MEANS_40}">
				<!-- 현금성 결제 : 실시간계좌이체, 무통장, 가상계좌 111-->
	                <c:choose>
					<c:when test="${receiptList.cashReceiptVO.isuGbCd eq FrontWebConstants.ISU_GB_20}"><!-- 현금영수증 수동 -->
					    <c:if test="${receiptList.cashReceiptVO.cashRctStatCd eq FrontWebConstants.CASH_RCT_STAT_10}">접수완료</c:if>
						<c:if test="${receiptList.cashReceiptVO.cashRctStatCd eq FrontWebConstants.CASH_RCT_STAT_20}">발행완료</c:if>
						<c:if test="${receiptList.cashReceiptVO.cashRctStatCd eq FrontWebConstants.CASH_RCT_STAT_90}">발행오류</c:if>
					</c:when>
					<c:when test="${receiptList.cashReceiptVO.isuGbCd eq FrontWebConstants.ISU_GB_10}"><!-- 현금영수증 자동-->
						<%-- c:if test="${receiptDetail.cashRctStatCd eq FrontWebConstants.CASH_RCT_STAT_10}">미발행</c:if>
						<c:if test="${receiptDetail.cashRctStatCd eq FrontWebConstants.CASH_RCT_STAT_20}">발행완료</c:if>
						<c:if test="${receiptDetail.cashRctStatCd eq FrontWebConstants.CASH_RCT_STAT_90}">발행오류</c:if--%>
					</c:when>
					<c:otherwise>
                                                미발급
					</c:otherwise>
					</c:choose>
				</c:if>
				<c:if test="${receiptList.payMeansCd eq FrontWebConstants.PAY_MEANS_10}">
				<!-- 신용카드 -->
							발급완료<br/>(신용카드 결제)
				</c:if>
				</c:forEach>
                        </div>
					</td>
					<td <c:if test="${rowCount > 1}">class="rowspan"</c:if> rowspan="${rowCount}">
	            <c:forEach items="${receiptDetail.payBaseVOList }" var="payBase" varStatus="pIdx">
	            <c:if test="${payBase.payMeansCd eq FrontWebConstants.PAY_MEANS_20 or payBase.payMeansCd eq FrontWebConstants.PAY_MEANS_30 or payBase.payMeansCd eq FrontWebConstants.PAY_MEANS_40}">
	            <!-- 현금성 결제 : 실시간계좌이체, 무통장, 가상계좌 22-->
	                <c:choose>
					<c:when test="${receiptList.cashReceiptVO.cashRctStatCd eq FrontWebConstants.CASH_RCT_STAT_10}"><!-- 현금영수증상태코드 : 접수 -->
                        <c:choose>
                        <c:when test="${receiptList.cashReceiptVO.isuGbCd eq FrontWebConstants.ISU_GB_10}"><!-- 현금영수증 자동-->
                        <div><a href="#" onclick="openCashReceiptRequest('<c:out value="${receiptList.ordNo}" />','<c:out value="${receiptList.cashRctNo}" />');return false;" class="btn_h20_type5 fix_w98">현금영수증 신청</a></div>
                        </c:when>
                        <c:otherwise>
                        <div>현금영수증</div>
                        </c:otherwise>
                        </c:choose>
					</c:when>
					<c:when test="${receiptList.cashReceiptVO.cashRctStatCd eq FrontWebConstants.CASH_RCT_STAT_20}"><!-- 현금영수증상태코드 :발행 -->
                        <c:choose>
                        <c:when test="${receiptList.cashReceiptVO.isuGbCd eq FrontWebConstants.ISU_GB_10}"><!-- 현금영수증 자동-->
                        <div><a href="#" onclick="openCashReceiptRequest('<c:out value="${receiptList.ordNo}" />','<c:out value="${receiptList.cashRctNo}" />');return false;" class="btn_h20_type5 fix_w98">현금영수증 신청</a></div>
                        </c:when>
                        <c:otherwise>
                         <div><a href="#" onclick="openCashReceipt('<c:out value="${receiptList.cashReceiptVO.lnkDealNo}" />');return false;" class="btn_h20_type5 fix_w98">현금영수증 보기</a></div>
                        </c:otherwise>
                        </c:choose>
					</c:when>
					<c:otherwise>
					    <c:choose>
                        <c:when test="${receiptList.cashReceiptVO.isuGbCd eq FrontWebConstants.ISU_GB_10}"><!-- 현금영수증 자동-->
                        <div><a href="#" onclick="openCashReceiptRequest('<c:out value="${receiptList.ordNo}" />','<c:out value="${receiptList.cashRctNo}" />');return false;" class="btn_h20_type5 fix_w98">현금영수증 신청</a></div>
                        </c:when>
                        <c:otherwise>
                        <div>고객센터 문의 요망</div>
                        </c:otherwise>
                        </c:choose>
					</c:otherwise>
					</c:choose>
				</c:if>
				<!-- 신용카드 -->
				<c:if test="${payBase.payMeansCd eq FrontWebConstants.PAY_MEANS_10}">
	                   <div>
	                       <a href="#" onClick="openCreditCard('${payBase.ordNo}');return false;" class="btn_h20_type5 fix_w98">신용카드전표</a>
	                   </div>
				</c:if>
				</c:forEach>
					</td>
				</tr>
	        </c:when>
			<c:otherwise>
				<tr>
	                <td class="img_cell v_top">
				    	<a href="#" onclick="openGoodsDetail('${receiptDetail.goodsId}');return false;">
	                        <frame:goodsImage goodsId="${receiptDetail.goodsId}" seq="${receiptDetail.imgSeq}" imgPath="${receiptDetail.imgPath}" size="${ImageGoodsSize.SIZE_70.size}" gb="" />
						</a>
					</td>
					<td class="align_left v_top">
						<div class="product_name">
							<a href="#" onclick="openGoodsDetail('${receiptDetail.goodsId}');return false;">[<c:out value="${receiptDetail.bndNmKo}"/>] <c:out value="${receiptDetail.goodsNm}"/></a>
	                        <div class="product_option">
	                            <span><c:out value="${receiptDetail.itemNm}"/></span>
						    </div>
						    <div class="product_cost"><frame:num data="${receiptDetail.saleAmt}" />원 / <c:out value="${receiptDetail.vldOrdQty}" />개</div>
	                    </div>
					</td>
				</tr>
			</c:otherwise>
            </c:choose>
	   </c:forEach>
    </c:forEach>
</c:if>
<c:if test="${receiptList eq '[]'}">
				<tr>
				    <td colspan="6" class="nodata">최근 주문내역이 없습니다.</td>
				</tr>
</c:if>
            </tbody>
		</table>
		<!-- 페이징 -->
		<input type="hidden" id="receipt_list_page" name="page" value="<c:out value="${orderSO.page}" />" />
		<input type="hidden" id="receipt_list_rows" name="rows" value="<c:out value="${orderSO.rows}" />" />
		<frame:listPage recordPerPage="${orderSO.rows}" currentPage="${orderSO.page}" totalRecord="${orderSO.totalCount}" indexPerPage="5" id="receipt_list_page" />
		<!-- 페이징 -->
	</div>
	<!-- //주문 목록 -->
</form>

<div class="note_box1 mgt30">
	<h2 class="title"> 신용카드전표·현금영수증 안내사항</h2>
	<h3 class="note_title1 mgt25">영수증(신용카드전표·현금영수증) 발급 안내</h3>
	<br/>
	<h4  class="note_title2"><span class="pos_a">※</span> 신용카드전표</h4>
	<ul class="ul_list_type1">
		<li>신용카드전표는 신용카드 결제 시 자동 발급되며, 세금계산서 대용으로 매입세액공제를 받을 수 있습니다. </li>
	</ul>
	<br/>
	<h4  class="note_title2"><span class="pos_a">※</span> 현금영수증</h4>
	<ul class="ul_list_type1">
		<li>현금영수증은 실시간계좌이체, 가상계좌 결제 시 발행 가능합니다. </li>
		<li>매입세액공제를 위한 세금계산서를 원하실 경우 사업자증빙용으로 현금영수증을 신청해주시기 바랍니다. </li>
		<li>주문 시 현금영수증을 신청하신 경우 결제 완료 이후 출력이 가능하며, 결제완료 후 현금영수증을 신청하신 경우 1시간 이내 내용을 확인하실 수 있습니다.  </li>
	</ul>
	<br/>
	<h4  class="note_title2"><span class="pos_a">※</span> 구매영수증</h4>
	<ul class="ul_list_type1">
		<li>구매영수증은 거래명세표로 사용하실 수 있으나, 법적인 효력은 없습니다. </li>
		<li>세무상의 지출증빙서류가 필요하신 경우 현금영수증 또는 신용카드 전표를 확인해주시기 바랍니다.</li>
	</ul>
</div>