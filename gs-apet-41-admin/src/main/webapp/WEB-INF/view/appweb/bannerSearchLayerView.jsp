<%--	
 - Description	: 공통 배너 조회 팝업 View
 - Since		: 2020.12.22
 - Author		: CJA
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">
	$(document).ready(function() {
		searchDateChange();
	});
	
	function searchDateChange() {
		var term = $("#bannerSearchForm #checkOptDate").children("option:selected").val();
		if(term == "") {
			$("#bannerSearchForm #regStrtDtm").val("");
			$("#bannerSearchForm #regEndDtm").val("");
		} else {
			setSearchDate(term, "bannerSearchForm #regStrtDtm", "bannerSearchForm #regEndDtm");
		}
	}
	
</script>


<form name="bannerSearchForm" id="bannerSearchForm" method="post">
		<input type="hidden" id="stId" name="stId" value="${bannerSO.stId }" /> 
		<table class="table_type1">
			<caption>배너 조회</caption>
			<tbody>
				<tr>
					<th scope="row"><spring:message code="column.regdate" /><strong class="red">*</strong></th>
					<td colspan="3">
						<!-- 등록일--> 
						<frame:datepicker startDate="regStrtDtm"
										  startValue="${frame:toDate('yyyy-MM-dd') }"
										  endDate="regEndDtm" 
										  endValue="${frame:toDate('yyyy-MM-dd') }"/>&nbsp;&nbsp;
						<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();" style="width: 120px !important;">
							<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_50 }" defaultName="기간선택" />
						</select>
					</td>					
				</tr>
				<tr>
					<th scope="row"><spring:message code="column.use_yn" /></th>
					<td>
						<frame:radio name="useYn" grpCd="${adminConstants.USE_YN }" defaultName="전체" />
					</td>
					<th scope="row"><spring:message code="column.bnr_tp_cd_nm" /></th>
					<td>
						<!-- 배너 타입명-->
						<select class="wth100" name="bnrTpCd" id="bnrTpCd" title="<spring:message code="column.bnr_tp_cd_nm"/>">
							<frame:select grpCd="${adminConstants.BNR_TP_CD}" defaultName="전체" />
						</select>
					</td>
				</tr>
				<tr>
					<th scope="row"><spring:message code="column.search_val" /></th>
					<td colspan="3">
						<!-- 검색어 -->
						<input type="text" name="searchVal" id="searchVal" />
					</td>
				</tr>
			</tbody>
		</table>
</form>
				<div class="btn_area_center">
					<button type="button" onclick="layerBannerList.searchBannerList();" class="btn btn-ok">검색</button>
					<button type="button" onclick="layerBannerList.searchReset();" class="btn btn-cancel">초기화</button>
				</div>
				<hr />

				<div class="mModule">
					<table id="layerBannerList" ></table>
					<div id="layerBannerListPage"></div>
				</div>