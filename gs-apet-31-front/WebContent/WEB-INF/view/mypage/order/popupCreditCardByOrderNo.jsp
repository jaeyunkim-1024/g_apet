<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<jsp:useBean id="now" class="java.util.Date" />

<script type="text/javascript">

	$(document).ready(function(){

	}); // End Ready

	$(function() {

	});

	/*
	* 신용카드매출전표 출력 팝업
	*/
	function openCreditCardReceipt(dealNo){
		var params = {
				tid : dealNo
			}
		pop.cardReceipt(params);
	}


</script>

		<!-- pop_contents -->
		<div id="pop_contents" style="width:550px;">
		<p class="credit_num">주문번호 <span>${ orderSO.ordNo }</span></p>

		<table class="table_type1 mgt10">
			<colgroup>
				<col style="width:20%">
				<col style="width:20%;">
				<col style="width:20%">
				<col style="width:20%">
				<col style="width:20%">
			</colgroup>
			<tbody>
				<tr>
					<th scope="col" class="grade">일자</th>
					<th scope="col" class="grade">결제금액</th>
					<th scope="col" class="grade">승인번호</th>
					<th scope="col" class="grade">상태</th>
					<th scope="col" class="grade">신용카드 전표</th>
				</tr>
				<c:forEach items="${payInfoList }" var="payInfo" varStatus="status">
				<tr>
					<td class="grade"><frame:timestamp date="${payInfo.payCpltDtm }" dType="H" /></td>
					<td class="grade"><frame:num data="${payInfo.payAmt }"/></td>
					<td class="grade">${payInfo.cfmNo }</td>
					<td class="grade"><frame:codeValue items="${payGbCdList }"  dtlCd="${payInfo.payGbCd }"/></td>
					<td class="grade"><a href="#" onClick="openCreditCardReceipt('${payInfo.dealNo}')" class="btn_pop_type3">보기</a></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>

	</div>
	<!-- 버튼 공간 -->
	<div class="t_center mgb20">
		<a href="#" class="btn_pop_type1" onclick="pop.close('<c:out value="${param.popId}" />');return false;"">확인</a>
		<a href="#" class="btn_pop_type2 mgl6" onclick="pop.close('<c:out value="${param.popId}" />');return false;">취소</a>
	</div>
<!-- //버튼 공간 -->
	<!-- //pop_contents -->

