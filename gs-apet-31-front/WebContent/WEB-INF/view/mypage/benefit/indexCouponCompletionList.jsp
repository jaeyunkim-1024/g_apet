<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page import="front.web.config.constants.FrontWebConstants" %>

   
<script type="text/javascript"  src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/jquery//jquery.cycle2.min.js" ></script>



<script type="text/javascript">

	$(document).ready(function(){

	}); // End Ready

	$(function() {
		var v_index = null;

		// 페이지 클릭 이벤트
		$("#member_com_coupon_list_page a").click(function(){
			var page =$(this).children("span").html();
			$("#member_com_coupon_list_search_page").val(page);
			reloadComCouponList();
			
			return false;
		}); 
	});
	 
	
	/*
	 * 사용 완료 쿠폰 화면 리로딩
	 */
	function reloadComCouponList(){
		$("#coupon_list_form").attr("target", "_self");
		$("#coupon_list_form").attr("action", "/mypage/benefit/indexCouponCompletionList");
		$("#coupon_list_form").submit(); 
	} 
	
	/*
	 * 사용 완료 쿠폰 화면 탭 선택
	*/
	function selectComCouponsGb(){ 
		$("#member_com_coupon_list_search_page").val("1");
		reloadComCouponList();
	}
	
	/*
	 * 사용가능쿠폰 화면 로딩
	 */
	function selectCouponList(){ 
		$("#member_com_coupon_list_search_page").val("1");
		$("#coupon_list_form").attr("target", "_self");
		$("#coupon_list_form").attr("action", "/mypage/benefit/indexCouponPossibleList");
		$("#coupon_list_form").submit(); 
	}
	 
	/*
	 * 상세보기 버튼 팝업
	 */
	function openCouponTarget(cpNo){
		
		var options = {
				cpNo : cpNo
		};
			
		pop.couponTarget(options);

	}
</script>

<div class="box_title_area">
	<h3>쿠폰</h3>
	<div class="sub_text2">상품 구매 시 사용완료 한 쿠폰을 조회하실 수 있습니다.</div>
</div>

<!-- 탭 -->
<div class="tab_menu01 length5s mgt10">
	<ul>
		<li><a href="#" onclick="selectCouponList();return false;">사용가능 쿠폰</a></li>
		<li class="on"><a href="#" onclick="selectComCouponsGb();return false;">사용완료 쿠폰</a></li>
	</ul>
</div>

<!-- 주문내역 -->
<form id="coupon_list_form"> 
<input type="hidden" id="member_com_coupon_list_search_page" name="page" value="<c:out value="${so.page}" />" />
<input type="hidden" id="member_coupon_cp_no" name="couponCpNo" value="" />

<table class="table_cartlist1 mgt20">
	<caption>주문내역</caption>
	<colgroup>
		<col style="width:180px">
		<col style="width:auto">
		<col style="width:25%">
	</colgroup> 
	<thead>
		<tr>
			<th scope="col" colspan="2">쿠폰명</th>
			<th scope="col">처리상태</th>
		</tr>
	</thead> 
	<tbody>
		<c:if test="${memberCouponComList ne '[]'}">
		<c:forEach items="${memberCouponComList}" var="couponComList" varStatus="idx"> 
			<tr id="member_com_coupon">
			<c:if test="${not empty couponComList.cpImgPathnm}">
				<td class="img_end v_top pdl52">
					<img src="<c:out value="${view.imgDomain}" /><c:out value="${couponComList.cpImgPathnm}" />" alt="<c:out value="${couponComList.cpImgFlnm }"/>">
				</td>
			</c:if>
			<c:if test="${empty couponComList.cpImgPathnm}">
				<td class="cupon_end v_top pdl52">
					<div class="cupon_box">
						<span class="discount_num">
						<c:if test="${ couponComList.cpKindCd ne FrontWebConstants.CP_KIND_30 }">
							<c:if test="${ couponComList.cpAplCd eq FrontWebConstants.CP_APL_10}"> <c:out value="${couponComList.aplVal}" />%</c:if>
							<c:if test="${ couponComList.cpAplCd eq FrontWebConstants.CP_APL_20}"> <frame:num data="${couponComList.aplVal}" /></c:if>
						</c:if>
						<c:if test="${ couponComList.cpKindCd eq FrontWebConstants.CP_KIND_30 }">무료배송</c:if>
						</span>										
					</div>
				</td>
			</c:if>
				<td class="align_left">
					<div class="product_name">
						<div>
							<c:if test="${couponComList.webMobileGbCd eq FrontWebConstants.WEB_MOBILE_GB_10}">[PC웹 전용]</c:if>
							<c:if test="${couponComList.webMobileGbCd eq FrontWebConstants.WEB_MOBILE_GB_20}">[모바일 전용]</c:if>
							<span class="font_gray01"><c:out value="${couponComList.cpNm}" /></span>
						</div> 
						<div>
							사용조건 : <c:if test="${couponComList.minBuyAmt gt 0}"><frame:num data="${couponComList.minBuyAmt}" />원 이상 구매시 |</c:if>
									<c:if test="${couponComList.maxDcAmt gt 0}"> 최대 <frame:num data="${couponComList.maxDcAmt}" />원 할인</c:if>
							(※일부상품제외)
						</div> 
						<div>
							<c:if test="${couponComList.useStrtDtm ne null and couponComList.useEndDtm ne null}">
								사용기간 : <frame:timestamp date="${couponComList.useStrtDtm}" dType="C"/>	~<frame:timestamp date="${couponComList.useEndDtm}" dType="C"/>
							</c:if>	
						</div>  
					</div>
				</td> 
				<td>
					<c:if test="${couponComList.useYn eq 'Y'}">
					<div><strong>사용완료</strong></div> 
					<div class="prod_num"><a href="/mypage/order/indexDeliveryDetail?ordNo=${couponComList.ordNo}">(주문번호 <c:out value="${couponComList.ordNo}" />)</a></div>
					<div><frame:timestamp date="${couponComList.useDtm}" dType="C"/> </div>
					</c:if>
					<c:if test="${couponComList.useYn ne 'Y'}">
					<div><strong>기간만료</strong></div> 
					</c:if>					
				</td>
			</tr> 			
		</c:forEach> 
		</c:if>   
		<c:if test="${memberCouponComList eq '[]'}">
			<tr>
				<td colspan="4" class="noncoupon">사용한 쿠폰내역이 없습니다.</td>
			</tr> 
		</c:if>   
	</tbody>
</table>
</form>
<frame:listPage recordPerPage="${so.rows}" currentPage="${so.page}" totalRecord="${so.totalCount}" indexPerPage="10" id="member_com_coupon_list_page" />

<div class="note_box1 mgt30">
	<h2 class="title">쿠폰 안내</h2>
	<ul class="ul_list_type1">
		<li>쿠폰의 사용기준과 기간을 반드시 확인하여 주세요. (유효기간이 만료된 쿠폰은 자동 소멸)</li>
		<li>특가 상품 및 일부 상품에서는 쿠폰 적용이 제한될 수 있습니다.</li>
		<li>주문 결제하실 때 사용한 쿠폰은 주문취소 및 반품하실 경우 재발급되지 않습니다.</li>
		<li>상품발송 전 주문을 전체 취소하신 경우에는 쿠폰을 다시 사용하실 수 있습니다.<br>
		 (사용한 쿠폰의 유효기간이 남아 있을 경우에 한함)</li>
		<li>쿠폰 적용가능 상품은 해당 브랜드의 사정에 따라 변경될 수 있습니다.</li>
	</ul>
</div>