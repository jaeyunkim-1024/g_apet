<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<script type="text/javascript">

	$(document).ready(function(){
	}); // End Ready

	$(function() {


	});

</script>

<div id="pop_contents">

	<h2 class="pop_tit1 mgt10">회원등급 산정기준</h2>

	<table class="table_type1 mgt10 mgb20">
		<colgroup>
			<col style="width:110px;">
			<col style="width:auto;">
		</colgroup>
		<tbody>
			<tr>
				<th scope="col" class="grade">구분</th>
				<th scope="col" class="grade">상세조건</th>
			</tr>
			<tr>
				<td class="grade">등급 변경일</td>
				<td class="grade t_left">매월 1일</td>
			</tr>
			<tr>
				<td class="grade">대상고객</td>
				<td class="grade t_left">${view.stNm } 모든 회원</td>
			</tr>
			<tr>
				<td class="grade">등급 기준</td>
				<td class="grade t_left">최근 6개월 간 주문건수 또는 주문금액 <br /><span class="point3">(ex. 2017년 02월 01일 ~ 2017년 07월 31일)</span></td>
			</tr>
			<tr>
				<td class="grade">혜택 지급방법</td>
				<td class="grade t_left">자동지급(매월 1일 순차적으로 발급)</td>
			</tr>
		</tbody>
	</table>
		
	<h2 class="pop_tit1 mgt10">회원등급별 혜택</h2>

	<table class="table_type1 mgt10">
		<colgroup>
			<col style="width:110px;">
			<col style="width:auto;">
			<col style="width:15%">
			<col style="width:21%">
		</colgroup>
		<tbody>
			<tr>
				<th scope="col" class="grade">등급</th>
				<th scope="col" class="grade">조건</th>
				<th scope="col" class="grade">구매적립금</th>
				<th scope="col" class="grade">할인쿠폰</th>
			</tr>
			<c:forEach items="${mbrCodeList }" var="mbrCode">
				<c:if test="${mbrCode.dtlCd eq  FrontWebConstants.MBR_GRD_10}">
				<tr>
					<td class="grade"><img src="/_images/mall/sub/grade_d.png" alt="DIA"></td>
					<td class="grade t_left"><span class="grade_d">${mbrCode.dtlNm }</span><br>
						<c:choose>
							<c:when test="${fn:length(mbrCode.usrDfn1Val)>6 }"><c:out value="${fn:substring(mbrCode.usrDfn1Val,0,3)}"/></c:when>
							<c:otherwise><c:out value="${fn:substring(mbrCode.usrDfn1Val,0,2)}" /></c:otherwise>
						</c:choose>
						만원 이상 또는 ${mbrCode.usrDfn2Val }회 이상 주문
					</td>
					<td class="grade">${mbrCode.usrDfn3Val }%</td>
					<td class="grade">1,000원 X 5장<br> 무료배송 X 3장</td>
				</tr>
				</c:if>
				<c:if test="${mbrCode.dtlCd eq  FrontWebConstants.MBR_GRD_20}">
				<tr>
					<td class="grade"><img src="/_images/mall/sub/grade_g.png" alt="GOLD"></td>
					<td class="grade t_left"><span class="grade_g">${mbrCode.dtlNm }</span><br>
						<c:choose>
							<c:when test="${fn:length(mbrCode.usrDfn1Val)>6 }"><c:out value="${fn:substring(mbrCode.usrDfn1Val,0,3)}"/></c:when>
							<c:otherwise><c:out value="${fn:substring(mbrCode.usrDfn1Val,0,2)}" /></c:otherwise>
						</c:choose>
						만원 이상 또는 ${mbrCode.usrDfn2Val }회 이상 주문
					</td>
					<td class="grade">${mbrCode.usrDfn3Val }%</td>
					<td class="grade">1,000원 X 4장<br> 무료배송 X 2장</td>
				</tr>
				</c:if>
				<c:if test="${mbrCode.dtlCd eq  FrontWebConstants.MBR_GRD_30}">
				<tr>
					<td class="grade"><img src="/_images/mall/sub/grade_s.png" alt="SILVER"></td>
					<td class="grade t_left"><span class="grade_s">${mbrCode.dtlNm }</span><br>
						<c:choose>
							<c:when test="${fn:length(mbrCode.usrDfn1Val)>6 }"><c:out value="${fn:substring(mbrCode.usrDfn1Val,0,3)}"/></c:when>
							<c:otherwise><c:out value="${fn:substring(mbrCode.usrDfn1Val,0,2)}" /></c:otherwise>
						</c:choose>
						만원 이상 또는 ${mbrCode.usrDfn2Val }회 이상 주문
					</td>
					<td class="grade">${mbrCode.usrDfn3Val }%</td>
					<td class="grade">1,000원 X 3장<br> 무료배송 X 1장</td>
				</tr>
				</c:if>
				<c:if test="${mbrCode.dtlCd eq  FrontWebConstants.MBR_GRD_40}">
				<tr>
					<td class="grade"><img src="/_images/mall/sub/grade_b.png" alt="BRONZE"></td>
					<td class="grade t_left"><span class="grade_b">${mbrCode.dtlNm }</span><br>
						<c:choose>
							<c:when test="${fn:length(mbrCode.usrDfn1Val)>6 }"><c:out value="${fn:substring(mbrCode.usrDfn1Val,0,3)}"/></c:when>
							<c:otherwise><c:out value="${fn:substring(mbrCode.usrDfn1Val,0,2)}" /></c:otherwise>
						</c:choose>
						만원 이상 또는 ${mbrCode.usrDfn2Val }회 이상 주문
					</td>
					<td class="grade">${mbrCode.usrDfn3Val }%</td>
					<td class="grade">1,000원  * 2장</td>
				</tr>
				</c:if>
				<c:if test="${mbrCode.dtlCd eq  FrontWebConstants.MBR_GRD_40}">
				<tr>
					<td class="grade"><img src="/_images/mall/sub/grade_f.png" alt="FAMILY"></td>
					<td class="grade t_left"><span class="grade_f">${mbrCode.dtlNm }</span><br>신규가입 / 미구매 회원</td>
					<td class="grade">${mbrCode.usrDfn3Val }%</td>
					<td class="grade">1,000원 X 1장</td>
				</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
	
	<table class="mgt20">
		<colgroup>
			<col style="width:130px;">
			<col style="width:160px">
			<col style="width:160px">
		</colgroup>
		<tbody>
			<tr>
				<th scope="col" class="v_top t_left"><h2 class="pop_tit1">신규 회원 특별 혜택</h2></th>
				<td class="v_top t_left">
					<div class="other_cupon">
						<div class="discount_cont">할인쿠폰<br>
						<span class="discount_num">1,000</span>원</div>
						<img src="${view.imgPath }/common/coupon_bg_ty01.png" alt="쿠폰">
					</div>
					<ul class="other_cupon_txt">
						<li>- 1만원 이상 주문 시 사용 가능</li>
						<li>- 유효기간 : 가입 후 30일</li>
					</ul>

				</td>
				<td class="v_top t_left">
					<div class="other_cupon">
						<div class="discount_cont">적립금<br>
						<span class="discount_num">3,000</span>원</div>
						<img src="${view.imgPath }/common/coupon_bg_ty01.png" alt="쿠폰">
					</div>
					<ul class="other_cupon_txt">
						<li>- 유효기간 : 가입 후 7일</li>
					</ul>

				</td>
			</tr>
		</tbody>
	</table>
	<div class="note_box1 mgt30">
		<h2 class="title">꼭! 알아두세요.</h2>
		<ul class="ul_list_type1">
			<li>구매내역은 배송완료 시점을 기준으로 산정하며, 구매 횟수는 상품수량이 아닌 주문번호 기준입니다.</li>
			<li>고객 등급 최종 선정 시 취소, 반품, 미 입금 구매분은 제외됩니다.</li>
			<li>적용 금액은 쿠폰, 적립금 등을 제외한 실 결제 금액 기준으로 인정합니다.</li>
			<li>기간 내 회원 혜택 미사용 시 자동 소멸됩니다.</li>
			<li>일부 쿠폰의 경우 주문취소 및 반품 시 재발급되지 않습니다.</li>
			<li>쿠폰, 적립금의 자세한 사항은 [마이페이지-혜택관리]에서 확인이 가능합니다.</li>
			<li>회원등급별 혜택은 사용조건에 따라 적용이 가능합니다.</li>
			<li>회원등급별 혜택 종류, 지급 방식 등은 내부 정책에 의해 변경될 수 있습니다.</li>
			<li>부당한 방법으로 획득한 회원혜택은 사후 심사를 통해 재조정될 수 있습니다.</li>
			<li>자세한 사항은 고객센터 내 FAQ를 참고 부탁드립니다.</li>
		</ul>
	</div>
</div>