<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %> 
<%@ page import="front.web.config.constants.FrontWebConstants" %> 
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<script type="text/javascript">

	$(document).ready(function(){

	}); // End Ready

	$(function() {

	});

	
	/*
	 * 취소, 교환, 반품, 화면 리로딩
	 */
	function searchClaimRequestList(){
		var mbrNo = '${session.mbrNo}';
		if(mbrNo == '0') {
			jQuery("<form action=\"/mypage/order/indexDeliveryDetailNoMem\" method=\"get\"><input type=\"hidden\" name=\"ordNo\" value=\"<c:out value="${claimBase.ordNo}" />\" /></form>").appendTo('body').submit();
		} else {
			$("#claim_request_list_form").attr("target", "_self");
			$("#claim_request_list_form").attr("action", "/mypage/order/indexClaimList");
			$("#claim_request_list_form").submit();
		} 
	}	

</script>

<div class="box_title_area">
	<h3>교환신청완료</h3>
</div>
 
<div class="completion_box mgt40">
	<div class="ment">교환신청이 접수되었습니다.</div>
	<c:if test="${session.mbrNo eq FrontWebConstants.NO_MEMBER_NO}">
	    <div class="sub_text">고객센터에서 확인 후 교환신청 진행을 도와드릴 예정입니다.  <strong>주문상세조회 에서 진행상황을 확인</strong>하실 수 있습니다.</div>
	</c:if>
	<c:if test="${session.mbrNo ne FrontWebConstants.NO_MEMBER_NO}">
		<div class="sub_text">고객센터에서 확인 후 교환신청 진행을 도와드릴 예정입니다.  <strong>[마이페이지 > 취소/교환/반품 ] 에서 진행상황을 확인</strong>하실 수 있습니다.</div>
	</c:if>		
</div>
<form id="claim_request_list_form" name="claim_request_list_form"></form>

<!-- 주문내역 -->
<table class="table_cartlist1">
	<caption>주문내역</caption>
	<colgroup>
		<col style="width:70px">
		<col style="width:auto">
		<col style="width:80px">
		<col style="width:15%">
		<col style="width:15%">
		<col style="width:16%"> 
	</colgroup>
	<thead>
		<tr>
			<th scope="col" colspan="2">상품정보</th>
			<th scope="col">구분</th>
			<th scope="col">수량</th>
			<th scope="col">배송/판매자</th>
			<th scope="col">교환사유</th> 
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${claimDetailList}" var="orderExchange" varStatus="idx">
			<tr>
				<td class="img_cell v_top"><a href="/goods/indexGoodsDetail?goodsId=<c:out value="${orderExchange.goodsId}"/>"><frame:goodsImage  imgPath="${orderExchange.imgPath}" goodsId="${orderExchange.goodsId}" seq="${orderExchange.imgSeq}" size="${ImageGoodsSize.SIZE_70.size}" gb="" /></a></td>
				<td class="align_left v_top">
					<div class="product_name">
						<div>[<c:out value="${orderExchange.bndNmKo}" />]</div>
						<div><a href="#"> <c:out value="${orderExchange.goodsNm}" />(<frame:num data="${orderExchange.ordQty}" />개)</a> </div>
						<div class="product_option">
							<span>
								<c:out value="${orderExchange.itemNm}" />
							</span>
						</div>
					</div>
				</td>
				<td>
					<c:if test="${orderExchange.clmDtlTpCd eq FrontWebConstants.CLM_DTL_TP_30}">
					변경전
					</c:if>
					<c:if test="${orderExchange.clmDtlTpCd eq FrontWebConstants.CLM_DTL_TP_40}">
					변경후
					</c:if>
				</td>
				<td><frame:num data="${orderExchange.clmQty}" /></td>
				<td><c:out value="${orderExchange.compNm}" /></td>
				<td>
					<frame:codeValue items="${clmRsnList}" dtlCd="${orderExchange.clmRsnCd}" />
					<c:if test="${not empty orderExchange.clmRsnContent}" >
						<div>${orderExchange.clmRsnContent}</div>
					</c:if>			
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table> 

<div class="btn_area_center">
	<c:if test="${session.mbrNo ne FrontWebConstants.NO_MEMBER_NO}">
		<a href="#" class="btn_h60_type1"  onclick="searchClaimRequestList();return false;">목록으로</a>
	</c:if>
</div>