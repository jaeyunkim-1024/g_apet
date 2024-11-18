<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %> 
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<script type="text/javascript">

	<%--
	//외부 연동 Block 처리
	$(document).ready(function(){
		goodsAnalytics();
	}); // End Ready

	$(function() {

	});

	function goodsAnalytics(){
		
		try{
			ga('require', 'ecommerce');
			
			ga('ecommerce:addTransaction', { 
			  'id': '<c:out value="${claimBase.ordNo}" />', // 시스템에서 생성된 주문번호. 필수. 
			  'affiliation': '<c:out value="${view.stNm}" />', // 제휴사이름. 선택사항. 쿠폰이름 같은거 넣어도 된다.
			  'revenue': '<c:out value="${claimPay.totAmt * -1}"/>', // 구매총액. 필수. 배송비 및 세금 기타 모든 비용 포함
			  'shipping': '<c:out value="${(claimPay.orgDlvrcAmt * -1) + claimPay.newRtnOrgDlvrcAmt + claimPay.clmDlvrcAmt}"/>', // 배송비. 선택사항. 
			  'tax': '0' // 세금. 선택사항.
			});
			
			<c:forEach items="${claimDetailList}" var="claimDetail">
			ga('ecommerce:addItem', { 
				  'id': '<c:out value="${claimBase.ordNo}" />', //시스템에서 생성된 주문번호. 필수. 
				  'name': '<c:out value="${claimDetail.goodsNm}" />', // 제품명. 필수. 
				  'sku': '<c:out value="${claimDetail.itemNm}" />', // SKU 또는 제품고유번호. 선택사항. 
				  'category': '<c:out value="${claimDetail.dispClsfNm}" />(<c:out value="${claimDetail.dispClsfNo}" />)', // 제품 분류. 
				  'price': '<c:out value="${claimDetail.saleAmt - claimDetail.prmtDcAmt}" />', // 제품 단가. 
				  'quantity': '<c:out value="${claimDetail.clmQty * -1}" />' // 제품 수량.
			});
			</c:forEach>
	
			ga('ecommerce:send');
		}catch (e){
			
		}
	}
	--%>	
	/*
	 * 취소, 교환, 반품, as조회 화면 리로딩
	 */
	function searchClaimRequestList(){
		var mbrNo = '${session.mbrNo}';
		 
		if(mbrNo == '0') {
			jQuery("<form action=\"/mypage/order/indexDeliveryDetail\" method=\"get\"><input type=\"hidden\" name=\"ordNo\" value=\"<c:out value="${claimBase.ordNo}" />\" /></form>").appendTo('body').submit();
		} else {
			$("#claim_request_list_form").attr("target", "_self");
			$("#claim_request_list_form").attr("action", "/mypage/order/indexClaimList");
			$("#claim_request_list_form").submit();
		} 
	}	
	
</script>

<div class="box_title_area">
	<h3>주문취소완료</h3>
</div>

<div class="completion_box mgt40">
	<div class="ment">주문취소가 완료되었습니다.</div>
	<c:if test="${session.mbrNo eq FrontWebConstants.NO_MEMBER_NO}">
	    <div class="sub_text">고객센터에서 확인 후 주문취소 진행을 도와드릴 예정입니다.  <strong>주문상세조회 에서 진행상황을 확인</strong>하실 수 있습니다.</div>
	</c:if>
	<c:if test="${session.mbrNo ne FrontWebConstants.NO_MEMBER_NO}">
		<div class="sub_text">고객센터에서 확인 후 주문취소 진행을 도와드릴 예정입니다.  <strong>[마이페이지 > 취소/교환/반품 ] 에서 진행상황을 확인</strong>하실 수 있습니다.</div>
	</c:if>		
</div> 
<form id="claim_request_list_form" name="claim_request_list_form"></form>

<!-- 주문내역 -->

<table class="table_cartlist1">
	<caption>주문내역</caption>
	<colgroup>
		<col style="width:70px">
		<col style="width:auto">
		<col style="width:15%">
		<col style="width:15%">
		<col style="width:20%">
	</colgroup> 
	<thead>
		<tr>
			<th scope="col" colspan="2">상품정보</th>
			<th scope="col">수량</th>
			<th scope="col">배송/판매자</th> 
			<th scope="col">취소사유</th>
		</tr>
	</thead> 
	<tbody> 
		<c:forEach items="${claimDetailList}" var="orderCancel" varStatus="idx">
		<tr>
			<td class="img_cell v_top"><a href="/goods/indexGoodsDetail?goodsId=<c:out value="${orderCancel.goodsId}"/>"><frame:goodsImage imgPath="${orderCancel.imgPath}" goodsId="${orderCancel.goodsId}" seq="${orderCancel.imgSeq}" size="${ImageGoodsSize.SIZE_70.size}" gb="" /></a></td>
			<td class="align_left v_top">
				<div class="product_name">
					<div>[<c:out value="${orderCancel.bndNmKo}" />]</div>
					<div><a href="#"> <c:out value="${orderCancel.goodsNm}" />(<frame:num data="${orderCancel.ordQty}" />개)</a> </div>
					<div class="product_option">
						<span><c:out value="${orderCancel.itemNm}" /></span>
					</div>
				</div>
			</td> 
			<td><frame:num data="${orderCancel.clmQty}" /></td>
			<td><c:out value="${orderCancel.compNm}" /></td>
			<td>
				<frame:codeValue items="${clmRsnList}" dtlCd="${orderCancel.clmRsnCd}" />
				<c:if test="${not empty orderCancel.clmRsnContent}" >
					<div>${orderCancel.clmRsnContent}</div>
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