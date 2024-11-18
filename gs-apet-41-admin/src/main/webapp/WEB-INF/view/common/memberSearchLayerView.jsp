<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">

	$(document).ready(function(){
		
		 $("#searchDtmStart, #searchDtmEnd").on("change",function(){
			$("#checkOptDate").val("").prop("selected",true);
		});
		 
        $("#searchWord").bind('keydown', function(e) {
            if(event.keyCode == 13) {
                $('#searchBtn').click();
                return false;
            }
        });
	});
	
	//검색날짜 변경
	function fncSrchDateChange() {
		var term = $("#checkOptDate").children("option:selected").val();
		if(term == "") {
			$("#searchDtmStart").val("");
			$("#searchDtmEnd").val("");
		} else {
			setSearchDate(term, "searchDtmStart", "searchDtmEnd");
		}
	}
</script>
			
<form id="layerMemberSearchForm" name="layerMemberSearchForm" method="post" >
	<table class="table_type1 popup">
		<caption>정보 검색</caption>
		<tbody>
			<tr>
				<th>회원구분</th>
				<td>
					<!-- 회원 구분 코드-->
					<select name="mbrGbCd" id="mbrGbCd">
						<option value="" selected="selected">전체</option>
						<frame:select grpCd="${adminConstants.MBR_GB_CD}" selectKey="${param.mbrGbCd }"
						 excludeOption="${adminConstants.MBR_GB_CD_40 },${adminConstants.MBR_GB_CD_30 },${adminConstants.MBR_GB_CD_50 }"/>
					</select>
				</td>
				<th><spring:message code="column.mobile"/>번호</th>
				<td>
					<!-- 휴대폰-->
					<input type="text" class="phoneNumber" name="mobile" id="mobile" placeholder="-없이 입력" title="<spring:message code="column.mobile"/>" value="${param.mobile }" style="width:60%;" />
				</td>
			</tr>
			<%-- <c:if test="${param.petRegYn != 'Y' }">
			<tr>
				<th>결제기간</th>
				<td colspan="3">
					<frame:datepicker startDate="searchDtmStart" startValue="${frame:addDay('yyyy-MM-dd',-7)}" endDate="searchDtmEnd" endValue="${frame:toDate('yyyy-MM-dd')}" />
					&nbsp;
					<select id="checkOptDate" name="checkOptDate" onchange="fncSrchDateChange();">
						<frame:select grpCd="${adminConstants.SELECT_PERIOD }"  defaultName="기간선택" excludeOption="${adminConstants.SELECT_PERIOD_30 },${adminConstants.SELECT_PERIOD_50 }"/>
					</select>
				</td>
			</tr>
			</c:if> --%>
			<tr>
				<th>검색어</th>
				<td colspan="3">
					<select name="searchType" id="searchType" title="<spring:message code="column.faq.search_text" />">
						<option value="" ${param.petRegYn != 'Y' and empty param.searchType ? 'selected="selected"' : ''}>전체</option>
						<option value="loginId" ${param.searchType == 'loginId' and param.petRegYn != 'Y' ? 'selected="selected"' : ''}>회원ID</option>
						<option value="memberNm" ${param.searchType == 'memberNm' and param.petRegYn != 'Y' ? 'selected="selected"' : ''}>회원명</option>
						<option value="nickNm" ${param.petRegYn == 'Y' or param.searchType == 'nickNm' ? 'selected="selected"' : ''} >닉네임</option> 
					</select>
 					<input type="text" class="" name="searchWord" id="searchWord" placeholder="검색어를 입력하세요"  value="${param.searchWord}" style="width:40%;" />
				</td>
				<input type="hidden"  name="petRegYn" id="petRegYn"  value="${param.petRegYn}" style="width:40%;" />
			</tr>
		</tbody>
	</table>
</form>

<div class="btn_area_center">
	<button type="button" onclick="layerMemberList.searchMemberList();" id="searchBtn" class="btn btn-ok">검색</button>
	<button type="button" onclick="layerMemberList.searchReset();" class="btn btn-cancel">초기화</button>
</div>

<div class="mModule">
	<table id="layerMemberList" ></table>
	<div id="layerMemberListPage"></div>
</div>

<style>
	.ui-widget-content {
	    border: 1px solid #d3d3d3;
	}
	.ui-state-hover {
	    border: 1px solid #d3d3d3 !important;
	}
</style>