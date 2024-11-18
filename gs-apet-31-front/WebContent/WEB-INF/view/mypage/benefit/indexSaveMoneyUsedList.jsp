<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<script type="text/javascript">

	$(document).ready(function(){

		// 페이지 클릭 이벤트
		$("#benefit_list_page a").click(function(){
			var page =$(this).children("span").html();
			$("#benefit_list_page").val(page);
			pagingBenefitList();
		});
		
	}); // End Ready

	$(function() {

	});
	
	// 페이징
	function pagingBenefitList() {
		$("#benefit_list_form").attr("target", "_self");
		$("#benefit_list_form").attr("action", "/mypage/benefit/indexSaveMoneyUsedList");
		$("#benefit_list_form").submit();
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
		
		$("#benefit_list_page").val("1");	// 페이지 번호 초기화
		$("#benefit_list_form").attr("target", "_self");
		$("#benefit_list_form").attr("action", "/mypage/benefit/indexSaveMoneyUsedList");
		$("#benefit_list_form").submit();
	}
	
	/**********************************************************************
	 * 기간별 검색조건 관련 함수 End
	 ***********************************************************************/

</script>


<div class="box_title_area">
	<h3>적립금</h3>
	<div class="sub_text2">
		고객님께서 보유하신 적립금 현황을 확인하실 수 있습니다.
	</div>
</div>

<table class="table_type2 mgt10">
	<caption>적립금현황</caption>
	<colgroup>
		<col style="width:50%" />
		<col />
	</colgroup>
	<tbody>
		<tr class="font14">
			<td class="t_center"><strong class="point2">사용 가능한 적립금</strong></td>
			<td class="t_center"><strong class="point2">소멸예정 적립금(1개월 이내)</strong></td>
		</tr>
		<tr>
			<td class="t_center">
				<span class="font14">P</span>
				<div class="point_bold"><frame:num data="${view.svmnRmnAmt}" /></div>
			</td>
			<td class="t_center">
				<span class="font14">P</span>
				<div class="point_bold"><frame:num data="${lemnAmt}" /></div>
			</td>
		</tr>
	</tbody>
</table>

<form id="benefit_list_form">
	<div class="order_lookup_box border_none mgt40">
		<dl>
			<dt>기간별 조회</dt>
			<dd>
				<div class="btn_period_group">
					<a href="#" class="btn_period <c:if test="${memberSavedMoneySO.period eq '1'}">on</c:if>" onclick="searchPeriod(1);return false;">1개월</a>
					<a href="#" class="btn_period <c:if test="${memberSavedMoneySO.period eq '3'}">on</c:if>" onclick="searchPeriod(3);return false;">3개월</a>
					<a href="#" class="btn_period <c:if test="${memberSavedMoneySO.period eq '6'}">on</c:if>" onclick="searchPeriod(6);return false;">6개월</a>
					<a href="#" class="btn_period <c:if test="${memberSavedMoneySO.period eq '12'}">on</c:if>" onclick="searchPeriod(12);return false;">12개월</a>
					<input type="hidden" name="period" value="<c:out value="${memberSavedMoneySO.period}" />" />
				</div>
			</dd>
		</dl>
		<dl class="mgl20">
			<dt>날짜조회</dt>
			<dd>
				<span class="datepicker_wrap">
					<input type="text" readonly="readonly" class="datepicker" id="start_dt" name="prcsDtmStart" value="<frame:timestamp date="${memberSavedMoneySO.prcsDtmStart}" dType="H" />" title="날짜" />
				</span>
				-
				<span class="datepicker_wrap">
					<input type="text" readonly="readonly" class="datepicker" id="end_dt" name="prcsDtmEnd" value="<frame:timestamp date="${memberSavedMoneySO.prcsDtmEnd}" dType="H" />" title="날짜" />
				</span>
			</dd>
		</dl>
		<a href="#" class="btn_h25_type1 mgl10" onclick="searchDate();return false;">조회</a>
	</div>
	
	<div class="mgt10">
		<table class="table_cartlist1">
			<caption>포인트 내역</caption>
			<colgroup>
				<col style="width:15%">
				<col style="width:15%">
				<col style="width:auto">
				<col style="width:15%">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">발생일자<br/>(소멸일시)</th>
					<th scope="col">구분</th>
					<th scope="col">상세내역</th>
					<th scope="col">금액</th>
				</tr>
			</thead>
			<tbody>
			<c:if test="${memberSavedMoneyList ne '[]'}">
				<c:forEach items="${memberSavedMoneyList}" var="benefit" varStatus="idx">
				<tr>
					<td><frame:timestamp date="${benefit.sysRegDtm}" dType="H"/>
						<c:if test="${benefit.svmnPrcsCd eq FrontWebConstants.SVMN_PRCS_10}">
						<br/>(<frame:timestamp date="${benefit.vldDtm}" dType="H"/>)
						</c:if>
					</td>
					<td>
						<c:choose>
							<c:when test="${benefit.tblDvs eq 'M' }">적립</c:when>
							<c:otherwise>
								<c:if test="${benefit.svmnPrcsRsnCd eq FrontWebConstants.SVMN_PRCS_RSN_210 }">사용</c:if>
								<c:if test="${benefit.svmnPrcsRsnCd eq FrontWebConstants.SVMN_PRCS_RSN_110 }">취소</c:if>
								<c:if test="${benefit.svmnPrcsRsnCd eq FrontWebConstants.SVMN_PRCS_RSN_290 }">소멸</c:if>
							</c:otherwise>
						</c:choose>
					</td>
					<td class="t_left">
						<c:if test="${'M' eq benefit.tblDvs}">
						<frame:codeValue items="${svmnRsnCdList}" dtlCd="${benefit.svmnRsnCd}" /> 
							<c:if test="${benefit.svmnPrcsCd eq FrontWebConstants.SVMN_PRCS_10 and benefit.svmnRsnCd eq FrontWebConstants.SVMN_RSN_210}">(주문번호 - <c:out value="${benefit.ordNo}"/>)</c:if>
							<c:if test="${benefit.svmnPrcsCd eq FrontWebConstants.SVMN_PRCS_10 and benefit.svmnRsnCd eq FrontWebConstants.SVMN_RSN_110}"></c:if>
							<c:if test="${benefit.svmnPrcsCd eq FrontWebConstants.SVMN_PRCS_10 and benefit.svmnRsnCd eq FrontWebConstants.SVMN_RSN_900}">(<c:out value="${benefit.etcRsn}"/>)</c:if>
						</c:if>
						<c:if test="${'D' eq benefit.tblDvs}">
						<frame:codeValue items="${svmnPrcsRsnCdList}" dtlCd="${benefit.svmnPrcsRsnCd}" /><c:if test="${benefit.svmnPrcsRsnCd eq FrontWebConstants.SVMN_PRCS_RSN_210}">(주문번호 - <c:out value="${benefit.ordNo}"/>)</c:if>
						</c:if>
					</td>
					<td><frame:num data="${benefit.saveAmt}" />P</td>
				</tr>
				</c:forEach>
			</c:if>
			<c:if test="${memberSavedMoneyList eq '[]'}">
				<tr>
					<td colspan="6" class="nodata">조회 내역이 없습니다.</td>
				</tr>
			</c:if>
			</tbody>
		</table>
		<!-- 페이징 -->
		<input type="hidden" id="benefit_list_page" name="page" value="<c:out value="${memberSavedMoneySO.page}" />" />
		<input type="hidden" id="benefit_list_rows" name="rows" value="<c:out value="${memberSavedMoneySO.rows}" />" />
		<frame:listPage recordPerPage="${memberSavedMoneySO.rows}" currentPage="${memberSavedMoneySO.page}" totalRecord="${memberSavedMoneySO.totalCount}" indexPerPage="10" id="benefit_list_page" />
		<!-- 페이징 -->
	</div>
</form>
<!-- //주문 목록 -->
<div class="note_box1 mgt30">
	<h2 class="title">적립금 안내</h2>
	<ul class="ul_list_type1">
		<li>구매적립금은 주문하신 상품이 모두 구매확정 된 후, 자동으로 적립됩니다</li>
		<li>쿠폰, 적립금을 사용한 주문의 경우, 할인 받은 금액을 제외한 결제금액 기준으로 적립됩니다.</li>
		<li>적립금은 현금과 동일하게 사용 가능하며, 적립 사유에 따라 유효기간이 상이합니다.</li>
		<li>지급된 적립금은 유효기간 경과 시 자동으로 소멸됩니다.</li>
	</ul>
</div>