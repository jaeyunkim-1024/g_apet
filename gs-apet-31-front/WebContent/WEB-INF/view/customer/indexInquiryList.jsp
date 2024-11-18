<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %> 
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<script type="text/javascript">

	$(document).ready(function(){
		
		// 페이지 클릭 이벤트
		$("#counsel_list_page a").click(function(){
			var page =$(this).children("span").html();
			$("#counsel_list_search_page").val(page);
			reloadCounselList();
		});
		
	}); // End Ready

	/*
	 * 답변조회 화면 리로딩 (페이징)
	 */
	function reloadCounselList(){
		$("#counsel_list_form").attr("target", "_self");
		$("#counsel_list_form").attr("action", "/customer/inquiry/indexInquiryList");
		$("#counsel_list_form").submit();
		
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
		
		$("#counsel_list_search_page").val("1");// 페이지 번호 초기화
		$("#counsel_list_form").attr("target", "_self");
		$("#counsel_list_form").attr("action", "/customer/inquiry/indexInquiryList");
		$("#counsel_list_form").submit();
	}
	
	/**********************************************************************
	 * 기간별 검색조건 관련 함수 End
	 ***********************************************************************/

</script>

<div class="box_title_area">
	<h3>1:1문의목록</h3>
	<div class="sub_text2">
		고객님께서 1:1 문의하신 내용에 대한 처리 현황을 확인하실 수 있습니다.
	</div>
</div>

<div class="order_lookup_box mgt10">
	<form id="counsel_list_form">
	<input type="hidden" id="counsel_list_search_page" name="page" value="<c:out value="${paging.page}" />" />
	<dl>
		<dt>기간별 조회</dt>
		<dd>
			<div class="btn_period_group">
				<a href="#" class="btn_period <c:if test="${counselSO.period eq '1'}">on</c:if>" onclick="searchPeriod(1);return false;">1개월</a>
				<a href="#" class="btn_period <c:if test="${counselSO.period eq '3'}">on</c:if>" onclick="searchPeriod(3);return false;">3개월</a>
				<a href="#" class="btn_period <c:if test="${counselSO.period eq '6'}">on</c:if>" onclick="searchPeriod(6);return false;">6개월</a>
				<a href="#" class="btn_period <c:if test="${counselSO.period eq '12'}">on</c:if>" onclick="searchPeriod(12);return false;">12개월</a>
				<input type="hidden" name="period" value="<c:out value="${counselSO.period}" />" />
			</div>
		</dd>
	</dl>
	<dl class="mgl20">
		<dt>날짜조회</dt>
		<dd>
			<span class="datepicker_wrap">
				<input type="text" readonly="readonly" class="datepicker" id="start_dt" name="cusAcptDtmStart" value="<frame:timestamp date="${counselSO.cusAcptDtmStart}" dType="H" />" title="날짜" />
			</span>
			-
			<span class="datepicker_wrap">
				<input type="text" readonly="readonly" class="datepicker" id="end_dt" name="cusAcptDtmEnd" value="<frame:timestamp date="${counselSO.cusAcptDtmEnd}" dType="H" />" title="날짜" />
			</span>
		</dd>
	</dl>
	<a href="#" onclick="searchDate();return false;" class="btn_h25_type1 mgl10">조회</a>
	</form>
</div>
<!-- 주문 목록 -->
<div class="mgt35">
	<table class="table_qna mgt10">
		<caption>질의응답</caption>
		<colgroup>
			<col style="width:18%">
			<col style="width:10%">
			<col style="width:42%">
			<col style="width:5%">
			<col style="width:25%">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">등록일시</th> 
				<th scope="col">상담유형</th>
				<th scope="col">문의제목</th>
				<th scope="col">아이디</th>
				<th scope="col">처리상태</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${counselList eq '[]'}">
			<tr>
				<td colspan="5" class="nodata">1:1 문의내역이 없습니다.</td>
			</tr>
			</c:if>
			<c:if test="${counselList ne '[]'}">
			<c:forEach items="${counselList}" var="counsel">
			<tr>
				<td><frame:timestamp date="${counsel.cusAcptDtm}" dType="H" tType="HS" /></td>
				<td>
					<frame:codeValue items="${cusCtg1CdList}" dtlCd="${counsel.cusCtg1Cd}"/>
				</td>
				<td style="text-align:left;"><c:out value="${counsel.ttl}" /></td>
				<td><frame:secret data="${counsel.eqrrMbrId}"/></td>
				<td>
					<frame:codeValue items="${cusStatCdList}" dtlCd="${counsel.cusStatCd}"/>
					<c:if test="${counsel.cusStatCd eq FrontWebConstants.CUS_STAT_30}"><br />(처리일자 <frame:timestamp date="${counsel.cusCpltDtm}" dType="C"  />)</c:if>
				</td>
			</tr>
			</c:forEach>
			</c:if>
		</tbody>
	</table>
	
	<!-- 페이징 -->
	<frame:listPage recordPerPage="${paging.rows}" currentPage="${paging.page}" totalRecord="${paging.totalRecord}" indexPerPage="10" id="counsel_list_page" />
	<!-- 페이징 -->
</div>
