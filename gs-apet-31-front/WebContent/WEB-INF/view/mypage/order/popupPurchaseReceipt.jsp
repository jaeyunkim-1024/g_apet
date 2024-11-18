<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<script type="text/javascript">

	$(document).ready(function(){
	}); // End Ready

	$(function() {

	});

	function printPurchaseReceipt(){

		if(purchaseReceiptValidate()){
			var strFeature = "";
			strFeature += "width=650, height=800, all=yes";

			var objWin = window.open('', 'print', strFeature);
			objWin.document.write('<meta http-equiv="content-type" content="text/html; charset=utf-8">');
			objWin.document.write('<link rel="stylesheet" type="text/css" href="/_css/<c:out value="${view.stId}" />/common.css">');
			objWin.document.write('<link rel="stylesheet" type="text/css" href="/_css/<c:out value="${view.stId}" />/layout.css">');
			objWin.document.write('<link rel="stylesheet" type="text/css" href="/_css/<c:out value="${view.stId}" />/sub.css">');
			objWin.document.write('<link rel="stylesheet" type="text/css" href="/_css/common/cartlist.css">');
			objWin.document.write('<link rel="stylesheet" type="text/css" href="/_css/common/myroom.css">');
			objWin.document.write(pop_contents.innerHTML);

			if(navigator.userAgent.toLowerCase().indexOf('chrome') > -1){
				setTimeout(function() {objWin.document.close();objWin.focus();objWin.print();objWin.close();}, 500);
			} else {
				objWin.document.close();
				objWin.print();
				objWin.close();
			}
		}
	}

	var purchaseReceiptValidate = function(){
		return true;
	};

</script>

<!-- 팝업 내용 -->
<div id="pop_contents">

	<div class="receiptwrap">
		<h2>영수증 (공급받는자 보관용)</h2>

		<div class="ovflowh">
			<div class="order_info">
				<h3>주문자 정보</h3>
				<table>
					<caption>주문자정보</caption>
					<colgroup>
						<col style="width:104px">
						<col style="width:auto">
					</colgroup>
					<tbody>
						<tr>
							<th>주문번호</th>
							<td>No.<c:out value="${orderBase.ordNo}"/></td>
						</tr>
						<tr>
							<th>주문하신 분</th>
							<td><c:out value="${orderBase.ordNm}"/></td>
						</tr>
						<tr>
							<th>발급일자</th>
							<td><frame:timestamp date="${issueDay}" dType="H"/></td>
						</tr>
					</tbody>
				</table>
			</div>

			<div class="supplierwrap">
				<h3>판매자 정보</h3>
				<table>
					<caption>판매자정보</caption>
					<colgroup>
						<col style="width:35%">
						<col style="width:35%">
						<col style="width:30%">
					</colgroup>
					<tbody>
						<tr>
							<th scope="col">사업자등록번호</th>
							<td colspan="2">123-45-67890</td>
						</tr>
						<tr>
							<th scope="col">상호</th>
							<td>VECI</td>
							<td rowspan="2" class="last"><img src="<c:out value='${view.imgComPath}'/>/common/seal_img01.gif" alt="도장이미지" /></td>
						</tr>
						<tr>
							<th scope="col">대표이사</th>
							<td>홍길동</td>
						</tr>
						<tr>
							<th scope="col">소재지</th>
							<td colspan="2">서울특별시 성동구 성수일로 10 서울숲 ITCT 602호</td>
						</tr>
						<tr>
							<th scope="col">통신판매업 신고번호</th>
							<td colspan="2">2019-서울강남-1234</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		<c:set var ="goodsTotalAmt" value="0" />
		<div class="mgt20">
			<h3>구매내역</h3>
			<table>
				<caption>구매내역</caption>
				<colgroup>
					<col style="width:auto">
					<col style="width:15%">
					<col style="width:18%">
					<col style="width:10%">
					<col style="width:18%">
				</colgroup>
				<thead>
					<tr>
						<th class="t_center">상품명</th>
						<th class="t_center">판매가</th>
						<th class="t_center">할인금액</th>
						<th class="t_center">수량</th>
						<th class="t_center">합계</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${orderDetailList}" var="orderDetail" varStatus="dIdx">
				<c:if test="${(orderDetail.vldOrdQty  >  0) && (orderDetail.ordDtlStatCd ne FrontWebConstants.CLM_DTL_TP_20)}">
					<tr>
						<td class="t_center"><c:out value="${orderDetail.goodsNm}"/></td>
						<td class="t_center"><frame:num data="${orderDetail.saleAmt - orderDetail.prmtDcAmt}"/>원</td>
						<td class="t_center"><frame:num data="${orderDetail.cpDcAmt }"/>원</td>
						<td class="t_center"><c:out value="${orderDetail.vldOrdQty}"/></td>
						<td class="t_center">
							<c:set var="goodsAmt" value="${ (orderDetail.payAmt * orderDetail.vldOrdQty) + orderDetail.rmnPayAmt }" />
							<c:set var ="goodsTotalAmt" value="${goodsTotalAmt + goodsAmt}" />
							<frame:num data="${goodsAmt}"/>원
						</td>
					</tr>
				</c:if>
				</c:forEach>
				</tbody>
			</table>

			<div class="de_price">

				<fmt:formatNumber value="${goodsTotalAmt *(1/11)}" var="surtax" pattern=",###"/>
				<fmt:formatNumber value="${goodsTotalAmt -(goodsTotalAmt*(1/11))}" var="amountOfTax" pattern=",###"/>
				<dl>
					<dt>과세물품가액</dt>
					<dd><c:out value="${amountOfTax}"/>원</dd>
				</dl>
				<dl>
					<dt>부가세</dt>
					<dd><c:out value="${surtax}"/>원</dd>
				</dl>
				<dl>
					<dt>배송비</dt>
					<dd><frame:num data="${payInfo.dlvrAmt}"/>원</dd>
				</dl>
				<dl>
					<dt>적립금</dt>
					<dd>
						<c:if test="${payInfo.svmnAmt ne 0 }">(-)</c:if>
						<frame:num data="${payInfo.svmnAmt}"/>원
					</dd>
				</dl>
				<dl>
					<dt>쿠폰할인</dt>
					<dd>
						<c:if test="${payInfo.cpDcAmt ne 0 }">(-)</c:if>
						<frame:num data="${payInfo.cpDcAmt}"/>원
					</dd>
				</dl>
				<dl>
					<dt>총합계</dt>
					<dd><frame:num data="${payInfo.payAmt}"/>원</dd>
				</dl>

			</div>
		</div>

		<div class="mgt20">
			<h3>결제내역</h3>
			<table>
				<caption>결제내역</caption>
				<colgroup>
					<col style="width:30%">
					<col style="width:30%">
					<col style="width:auto">
				</colgroup>
				<thead>
					<tr>
						<th class="t_center">결제수단</th>
						<th class="t_center">금액</th>
						<th class="t_center">상세내역</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="t_center">
							<frame:codeValue items="${payMeansCdList}" dtlCd="${payInfo.payMeansCd}" />
						</td>
						<td class="t_center">
							<frame:num data="${payInfo.payAmt}"/>원
						</td>
						<td>
							<!-- 신용카드 -->
							<c:if test="${FrontMobileConstants.PAY_MEANS_10 eq payInfo.payMeansCd}">
								(<frame:codeValue items="${cardcCdList}" dtlCd="${payInfo.cardcCd}"/>)<br />
	                            승인번호 : <frame:secret data="${payInfo.cfmNo}"/><br />
	 				            승인일시 : <frame:timestamp date="${payInfo.cfmDtm}" dType="H" tType="HS"/>
							</c:if>
							<!-- 실시간계좌이체 및 가상 계좌 , 무통장-->
							<c:if test="${FrontMobileConstants.PAY_MEANS_20 eq payInfo.payMeansCd or FrontMobileConstants.PAY_MEANS_30 eq payInfo.payMeansCd or FrontMobileConstants.PAY_MEANS_40 eq payInfo.payMeansCd}">
								<br />
								<c:if test="${FrontMobileConstants.PAY_MEANS_20 ne payInfo.payMeansCd}">
								<c:out value="${payInfo.ooaNm}"/><br />
								</c:if>
								<frame:codeValue items="${bankCdList}" dtlCd="${payInfo.bankCd}"/>/<c:out value="${payInfo.acctNo}"/><br />
								<c:if test="${FrontMobileConstants.PAY_MEANS_20 ne payInfo.payMeansCd}">
								<c:if test="${FrontMobileConstants.PAY_STAT_00 eq payInfo.payStatCd}">
								입금자 : <c:out value="${payInfo.dpstrNm}"/><br />
								<span class="fcolor_pink"><frame:timestamp date="${payInfo.dpstSchdDt}" dType="K" />까지 미입금시 주문취소</span>
								</c:if>
								<c:if test="${FrontMobileConstants.PAY_STAT_01 eq payInfo.payStatCd}">
								결제일시 : <frame:timestamp date="${payInfo.payCpltDtm}" dType="H" tType="HS"/>
								</c:if>
								</c:if>
							</c:if>
						</td>
					</tr>
				</tbody>
			</table>
		</div>

		<p class="etc_text">
			※ 본 영수증은 거래명세표로 사용하실 수 있으며, 소득공제용 영수증 및 세금계산서로 활용할 수 없습니다. <br />
			세무상의 지출증빙서류가 필요하신 경우 주문상세조회 화면에서 현금영수증과 신용카드 전표를 출력하시기 바랍니다.
		</p>

	</div>

</div>
<!-- //팝업 내용 -->

<!-- 버튼 공간 -->
<div class="t_center">
	<a href="#" class="btn_pop_type1" onclick="printPurchaseReceipt();return false;">인쇄</a><a href="#" class="btn_pop_type2 mgl6" onclick="pop.close('<c:out value="${param.popId}" />');return false;">닫기</a>
</div>
<!-- //버튼 공간 -->
