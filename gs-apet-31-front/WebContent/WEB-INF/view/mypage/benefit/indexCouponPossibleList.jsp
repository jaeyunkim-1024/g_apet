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
		$("#member_coupon_list_page a").click(function(){
			var page =$(this).children("span").html();
			$("#member_coupon_list_search_page").val(page);
			reloadCouponList();
			
			return false;
		}); 
	});
	 
	/*
	 * 사용가능쿠폰 화면 리로딩
	 */
	function reloadCouponList(){
		$("#coupon_list_form").attr("target", "_self");
		$("#coupon_list_form").attr("action", "/mypage/benefit/indexCouponPossibleList");
		$("#coupon_list_form").submit(); 
	}
	
	/*
	 * 사용가능쿠폰 화면 탭 선택
	*/
	function selectCouponsGb(){ 
		$("#member_coupon_list_search_page").val("1");
		reloadCouponList();
	}
	 
	/*
	 * 사용 완료 쿠폰 화면 선택
	 */
	function selectComCouponList(){ 
		$("#member_coupon_list_search_page").val("1");
		$("#coupon_list_form").attr("target", "_self");
		$("#coupon_list_form").attr("action", "/mypage/benefit/indexCouponCompletionList");
		$("#coupon_list_form").submit(); 
	} 
	
	/*
	 * 쿠폰 등록 팝업 호출
	 */
	function openCouponsPopup(sMbrNo){ 
		var params = {
			mbrNo : sMbrNo,
			callBackFnc : "cbcouponApply"	
		}; 
		pop.couponApply(params);	 
	}
	 
	/*
	 * 쿠폰 등록  CallBack
	 */
	function cbcouponApply(data){ 
		$("#member_coupon_list_search_page").val("1");
		reloadCouponList();
		
		return false;
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
	<div class="sub_text2">상품 구매 시 사용가능 한 쿠폰을 조회하실 수 있습니다.</div>
</div>
 
<!-- 탭 -->
<div class="tab_menu01 length5s mgt10">
	<ul>
		<li class="on"><a href="#" onclick="selectCouponsGb();return false;">사용가능 쿠폰</a></li>
		<li><a href="#" onclick="selectComCouponList();return false;">사용완료 쿠폰</a></li>
	</ul>
</div>
<form id="coupon_list_form">
<input type="hidden" id="member_coupon_list_search_page" name="page" value="<c:out value="${so.page}" />" /> 
 
<div class="t_right mgt15">
	<a href="#" class="btn_h25_type2 mgr10" onclick="openCouponsPopup('${session.mbrNo}');return false;">쿠폰등록</a>
</div>
   
<!-- 주문내역 -->  
<table class="table_cartlist1 mgt10">
	<caption>주문내역</caption>
	<colgroup>
		<col style="width:22%">
		<col style="width:180px">
		<col style="width:auto">
	</colgroup>
	<thead>  
		<tr>
			<th scope="col">발급일자</th>
			<th scope="col" colspan="2">쿠폰명</th>
		</tr> 
	</thead>
	<tbody> 
	 
	<c:if test="${memberCouponPossibleList ne '[]'}">
	<c:forEach items="${memberCouponPossibleList}" var="couponPossibleList" varStatus="idx"> 
		<tr id="member_coupon">
			<td><frame:timestamp date="${couponPossibleList.sysRegDtm}" dType="C"/></td>
		<c:if test="${not empty couponPossibleList.cpImgPathnm}">
			<td class="img_ing v_top">
				<img src="<c:out value="${view.imgDomain}" /><c:out value="${couponPossibleList.cpImgPathnm}" />" alt="<c:out value="${couponPossibleList.cpImgFlnm }"/>">
			</td>
		</c:if>
		<c:if test="${empty couponPossibleList.cpImgPathnm}">
			<td class="cupon_ing v_top"><div class="cupon_box"><span class="discount_num">
				<c:if test="${ couponPossibleList.cpKindCd ne FrontWebConstants.CP_KIND_30 }">
					<c:if test="${ couponPossibleList.cpAplCd eq FrontWebConstants.CP_APL_10}"> <c:out value="${couponPossibleList.aplVal}" />%</c:if>
					<c:if test="${ couponPossibleList.cpAplCd eq FrontWebConstants.CP_APL_20}"> <frame:num data="${couponPossibleList.aplVal}" /></c:if>
				</c:if>
				<c:if test="${ couponPossibleList.cpKindCd eq FrontWebConstants.CP_KIND_30 }">무료배송</c:if>
			</span></div></td>
		</c:if>
			<td class="align_left">
				<div class="product_name"> 
					<div>
						<c:if test="${couponPossibleList.webMobileGbCd eq FrontWebConstants.WEB_MOBILE_GB_10}">[PC웹 전용]</c:if>
						<c:if test="${couponPossibleList.webMobileGbCd eq FrontWebConstants.WEB_MOBILE_GB_20}">[모바일 전용]</c:if>
						<span class="font_gray01"><c:out value="${couponPossibleList.cpNm}" /></span>
					</div>
					<div>
						사용조건 : <c:if test="${couponPossibleList.minBuyAmt gt 0}"><frame:num data="${couponPossibleList.minBuyAmt}" />원 이상 구매시 |</c:if>
								<c:if test="${couponPossibleList.maxDcAmt gt 0}"> 최대<frame:num data="${couponPossibleList.maxDcAmt}" />원 할인</c:if>
						(※일부상품제외)
					</div>
					<div>
						<c:if test="${couponPossibleList.useStrtDtm ne null and couponPossibleList.useEndDtm ne null}">
							사용기간 : <frame:timestamp date="${couponPossibleList.useStrtDtm}" dType="C"/> ~ <frame:timestamp date="${couponPossibleList.useEndDtm}" dType="C"/>
						</c:if>
					</div>  
				</div>
			</td>
		</tr> 
	</c:forEach> 
	</c:if> 
	<c:if test="${memberCouponPossibleList eq '[]'}">
			<tr>
				<td colspan="4" class="noncoupon">사용가능 한 쿠폰이 없습니다.</td>
			</tr> 
		</c:if> 
	</tbody>
</table>

<frame:listPage recordPerPage="${so.rows}" currentPage="${so.page}" totalRecord="${so.totalCount}" indexPerPage="10" id="member_coupon_list_page" />
</form>
<div class="note_box1 mgt30">
	<h2 class="title">쿠폰 안내</h2>
	<ul class="ul_list_type1">
		<li>쿠폰은 사용조건에 따라 사용이 가능하며 특가 상품 및 일부 상품에서는 쿠폰 적용이 제한될 수 있습니다.</li>
		<li>유효기간이 만료된 쿠폰은 자동 소멸되며, [마이페이지-쿠폰]에서 확인이 가능합니다.</li>
		<li>일부 쿠폰의 경우 주문취소 및 반품 시 재발급되지 않습니다.</li>
		<li>쿠폰은 사정에 의하여 사전 안내 없이 변경 또는 조기종료 될 수 있습니다.</li>
	</ul>
</div>