<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// 지역별 / 상픔주문 통계 리스트 생성
			createPlanningTeamByAreaGrid();
		});

		// 지역별 / 상픔주문 통계 리스트
		function createPlanningTeamByAreaGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/planningTeamByAreaListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : $("#planningTeamByAreaForm").serializeJson()
				, colModels : [
					// 지역별
					{name:"orderArea", label:"<spring:message code='column.statistics.by.area' />", width:"100", align:"center", sortable:false}
					// 매출액(PC비회원)
					, {name:"pcNomemAmt", label:"<spring:message code='column.statistics.by.area.header01' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 매출액(PC회원)
					, {name:"pcMemAmt", label:"<spring:message code='column.statistics.by.area.header02' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// total
					, {name:"pcTotAmt", label:"<spring:message code='column.statistics.by.area.header09' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 매출액(Mobile비회원)
					, {name:"mobileNomemAmt", label:"<spring:message code='column.statistics.by.area.header03' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 매출액(Mobile회원)
					, {name:"mobileMemAmt", label:"<spring:message code='column.statistics.by.area.header04' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// total
					, {name:"mobileTotAmt", label:"<spring:message code='column.statistics.by.area.header09' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 몰 total
					, {name:"totAmt", label:"<spring:message code='column.statistics.by.area.header10' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 주문건(PC비회원)
					, {name:"pcNomemQty", label:"<spring:message code='column.statistics.by.area.header05' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 주문건(PC회원)
					, {name:"pcMemQty", label:"<spring:message code='column.statistics.by.area.header06' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// total
					, {name:"pcTotQty", label:"<spring:message code='column.statistics.by.area.header09' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 주문건(Mobile비회원)
					, {name:"mobileNomemQty", label:"<spring:message code='column.statistics.by.area.header07' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 주문건(Mobile회원)
					, {name:"mobileMemQty", label:"<spring:message code='column.statistics.by.area.header08' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// total
					, {name:"mobileTotQty", label:"<spring:message code='column.statistics.by.area.header09' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 몰 total
					, {name:"totQty", label:"<spring:message code='column.statistics.by.area.header10' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
				]
					, footerrow : true
					, userDataOnFooter : true
					, gridComplete : function () {
						var pcNomemAmt = $("#planningTeamByAreaList" ).jqGrid('getCol', 'pcNomemAmt', false, 'sum');
						var pcMemAmt = $("#planningTeamByAreaList" ).jqGrid('getCol', 'pcMemAmt', false, 'sum');
						var pcTotAmt = $("#planningTeamByAreaList" ).jqGrid('getCol', 'pcTotAmt', false, 'sum');
						var mobileNomemAmt = $("#planningTeamByAreaList" ).jqGrid('getCol', 'mobileNomemAmt', false, 'sum');
						var mobileMemAmt = $("#planningTeamByAreaList" ).jqGrid('getCol', 'mobileMemAmt', false, 'sum');
						var mobileTotAmt = $("#planningTeamByAreaList" ).jqGrid('getCol', 'mobileTotAmt', false, 'sum');
						var totAmt = $("#planningTeamByAreaList" ).jqGrid('getCol', 'totAmt', false, 'sum');
						var pcNomemQty = $("#planningTeamByAreaList" ).jqGrid('getCol', 'pcNomemQty', false, 'sum');
						var pcMemQty = $("#planningTeamByAreaList" ).jqGrid('getCol', 'pcMemQty', false, 'sum');
						var pcTotQty = $("#planningTeamByAreaList" ).jqGrid('getCol', 'pcTotQty', false, 'sum');
						var mobileNomemQty = $("#planningTeamByAreaList" ).jqGrid('getCol', 'mobileNomemQty', false, 'sum');
						var mobileMemQty = $("#planningTeamByAreaList" ).jqGrid('getCol', 'mobileMemQty', false, 'sum');
						var mobileTotQty = $("#planningTeamByAreaList" ).jqGrid('getCol', 'mobileTotQty', false, 'sum');
						var totQty = $("#planningTeamByAreaList" ).jqGrid('getCol', 'totQty', false, 'sum');

						$("#planningTeamByAreaList" ).jqGrid('footerData', 'set',
							{
								orderArea : '합계 : '
								, pcNomemAmt : pcNomemAmt
								, pcMemAmt : pcMemAmt
								, pcTotAmt : pcTotAmt
								, mobileNomemAmt : mobileNomemAmt
								, mobileMemAmt : mobileMemAmt
								, mobileTotAmt : mobileTotAmt
								, totAmt : totAmt
								, pcNomemQty : pcNomemQty
								, pcMemQty : pcMemQty
								, pcTotQty : pcTotQty
								, mobileNomemQty : mobileNomemQty
								, mobileMemQty : mobileMemQty
								, mobileTotQty : mobileTotQty
								, totQty : totQty
							}
						);
					}
			}

			grid.create("planningTeamByAreaList", gridOptions);
		}

		// 검색
		function searchPlanningTeamByAreaList() {
			var dateCheck = $(":radio[name=dateCheck]:checked").val();
			if(dateCheck == '01') {
				$("#startDtm").val($("#startDtm01").val().replace(/\-/g,'') );
				$("#endDtm").val($("#endDtm01").val().replace(/\-/g,'') );
			} else if (dateCheck == '02') {
				$("#startDtm").val($("#startDtm02 option:selected").val() + $("#startDtm02Month option:selected").val() );
				$("#endDtm").val($("#endDtm02 option:selected").val() + $("#endDtm02Month option:selected").val() );
			} else if (dateCheck == '03') {
				$("#startDtm").val($("#startDtm03 option:selected").val() );
				$("#endDtm").val($("#endDtm03 option:selected").val() );
			}

			var orderArea = new Array();
			$("input[name=orderArea1]:checked").each(function() {
				orderArea.push($(this).val() );
			});
			$("#orderArea").val(orderArea);

			var options = {
				searchParam : $("#planningTeamByAreaForm").serializeJson()
			};

			console.log(options );

			grid.reload("planningTeamByAreaList", options);
		}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<form id="planningTeamByAreaForm" name="planningTeamByAreaForm" method="post" >
			<input type="hidden" name="startDtm" id="startDtm" value="" />
			<input type="hidden" name="endDtm" id="endDtm" value="" />
			<input type="hidden" name="orderArea" id="orderArea" value="" />
			<table class="table_type1">
				<caption>정보 검색</caption>
				<tbody>
					<tr>
						<!-- 기간별 (일별) -->
						<th scope="row" rowspan="3"><spring:message code="column.statistics.outer.period" /></th>
						<td>
							<label class="fRadio"><input type="radio" name="dateCheck" value="01" checked="checked" /><span>일별</span></label>
							<frame:datepicker startDate="startDtm01" endDate="endDtm01" startValue="${adminConstants.COMMON_START_DATE }" />
						</td>
						<!-- 판매 공간 -->
						<th scope="row"><spring:message code="column.order_common.page_gb_cd" /></th>
						<td>
							<label class="fRadio"><input type="radio" name="pageCheck" value="" checked="checked"> <span>전체</span></label>
							<label class="fRadio"><input type="radio" name="pageCheck" value="01"> <span>쇼룸</span></label>
							<label class="fRadio"><input type="radio" name="pageCheck" value="02"> <span><spring:message code="column.order_common.search_foreign_mall" /></span></label>

							<select name="pageGbCd" id="pageGbCd" title="선택상자" >
								<frame:select grpCd="${adminConstants.PAGE_GB}" defaultName="선택하세요"/>
							</select>
						</td>
					</tr>
					<tr>
						<!-- 기간별 (월별) -->
						<td>
							<label class="fRadio"><input type="radio" name="dateCheck" value="02" /><span>월별</span></label>
							<select class="w80" name="startDtm02" id="startDtm02">
								<frame:select grpCd="${adminConstants.YYYY}"/>
							</select>
							<select class="w50" name="startDtm02Month" id="startDtm02Month">
								<frame:select grpCd="${adminConstants.MM}"/>
							</select> ~
							<select class="w80" name="endDtm02" id="endDtm02">
								<frame:select grpCd="${adminConstants.YYYY}"/>
							</select>
							<select class="w50" name="endDtm02Month" id="endDtm02Month">
								<frame:select grpCd="${adminConstants.MM}"/>
							</select>
						</td>
						<!-- 주문 매체 -->
						<th scope="row"><spring:message code="column.order_common.ord_mda_cd" /></th>
						<td>
							<frame:radio name="ordMdaCd" grpCd="${adminConstants.ORD_MDA }" defaultName="전체" />
						</td>
					</tr>
					<tr>
						<!-- 기간별 (연도별) -->
						<td>
							<label class="fRadio"><input type="radio" name="dateCheck" value="03" /><span>연도별</span></label>
							<select class="w80" name="startDtm03" id="startDtm03">
								<frame:select grpCd="${adminConstants.YYYY}"/>
							</select> ~
							<select class="w80" name="endDtm03" id="endDtm03">
								<frame:select grpCd="${adminConstants.YYYY}"/>
							</select>
						</td>
						<!-- 회원 -->
						<th scope="row"><spring:message code="column.statistics.member" /></th>
						<td>
							<label class="fRadio"><input type="radio" name="memberYn" value="" checked="checked"> <span>전체</span></label>
							<label class="fRadio"><input type="radio" name="memberYn" value="Y"> <span>회원</span></label>
							<label class="fRadio"><input type="radio" name="memberYn" value="N"> <span>비회원</span></label>
						</td>
					</tr>
					<tr>
						<!-- 지역 -->
						<th scope="row"><spring:message code="column.statistics.area" /></th>
						<td colspan="3">
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="서울"> <span>서울</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="부산"> <span>부산</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="대구"> <span>대구</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="인천"> <span>인천</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="광주"> <span>광주</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="대전"> <span>대전</span></label><br/>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="울산"> <span>울산</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="세종"> <span>세종</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="경기"> <span>경기</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="강원"> <span>강원</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="충북"> <span>충북</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="충남"> <span>충남</span></label><br/>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="전북"> <span>전북</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="전남"> <span>전남</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="경북"> <span>경북</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="경남"> <span>경남</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="제주"> <span>제주</span></label>
							<label class="fCheck"><input type="checkbox" name="orderArea1" value="기타"> <span>기타</span></label>
						</td>
					</tr>
				</tbody>
			</table>
		</form>

		<div class="btn_area_center">
			<button type="button" onclick="searchPlanningTeamByAreaList();" class="btn btn-ok">검색</button>
			<button type="button" onclick="resetForm('planningTeamByAreaForm');" class="btn btn-cancel">초기화</button>
		</div>

		<div class="mModule">
			<table id="planningTeamByAreaList"></table>
		</div>
	</t:putAttribute>
</t:insertDefinition>