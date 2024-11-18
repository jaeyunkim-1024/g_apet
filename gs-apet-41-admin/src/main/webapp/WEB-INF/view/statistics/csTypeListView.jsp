<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// CS유형별 리스트 생성
			createCsTypeGrid();
		});

		// CS유형별 리스트
		function createCsTypeGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/csTypeListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : $("#csTypeForm").serializeJson()
				, colModels : [
					// 상담경로
					{name:"cusPathCd", label:"<spring:message code='column.statistics.cs.cus_path_cd' />", width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_PATH}" />"}}
					// 상담사
					, {name:"cusCpltrNm", label:"<spring:message code='column.statistics.cs.cus_cpltr_nm' />", width:"100", align:"center", sortable:false}
					// 대분류
					, {name:"cusCtg1Cd", label:"<spring:message code='column.statistics.cs.cus_ctg1_cd' />", width:"200", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_CTG1}" />"}}
					// 중분류
					, {name:"cusCtg2Cd", label:"<spring:message code='column.statistics.cs.cus_ctg2_cd' />", width:"200", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_CTG2}" />"}}
					// 소분류
					, {name:"cusCtg3Cd", label:"<spring:message code='column.statistics.cs.cus_ctg3_cd' />", width:"200", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_CTG3}" />"}}
					// 건수
					, {name:"csCount", label:"<spring:message code='column.statistics.cs.count' />", width:"100", align:"center", sortable:false, summaryType:"sum"}
					// 비율
					, {name:"csRate", label:"<spring:message code='column.statistics.cs.rate' />", width:"100", align:"center", sortable:false, summaryType:"sum", formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' %', thousandsSeparator:','}}
				]
				, footerrow : true
				, userDataOnFooter : true
				, gridComplete : function () {
					var csCount = $("#csTypeList" ).jqGrid('getCol', 'csCount', false, 'sum');
					var csRate = $("#csTypeList" ).jqGrid('getCol', 'csRate', false, 'sum');

					$("#csTypeList" ).jqGrid('footerData', 'set',
						{
							cusCpltrNm : '합계 : '
							, csCount : csCount
							, csRate : csRate
						}
					);
				}
			}

			grid.create("csTypeList", gridOptions);
		}

		// 검색
		function searchCsTypeList() {
			var options = {
				searchParam : $("#csTypeForm").serializeJson()
			};

			grid.reload("csTypeList", options);
		}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<form id="csTypeForm" name="csTypeForm" method="post" >
			<table class="table_type1">
				<caption>정보 검색</caption>
				<tbody>
					<tr>
						<!-- CS 완료 일시 -->
						<th scope="row"><spring:message code="column.statistics.cs.cus_cplt_dtm" /></th>
						<td colspan="3">
							<frame:datepicker startDate="cusCpltDtmStart" endDate="cusCpltDtmEnd" startValue="${adminConstants.COMMON_START_DATE }"  />
						</td>
					</tr>
				</tbody>
			</table>
		</form>

		<div class="btn_area_center">
			<button type="button" onclick="searchCsTypeList();" class="btn btn-ok">검색</button>
			<button type="button" onclick="resetForm('csTypeForm');" class="btn btn-cancel">초기화</button>
		</div>

		<div class="mModule">
			<table id="csTypeList"></table>
		</div>
	</t:putAttribute>
</t:insertDefinition>