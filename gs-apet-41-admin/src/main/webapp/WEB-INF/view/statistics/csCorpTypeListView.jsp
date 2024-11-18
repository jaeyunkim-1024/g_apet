<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// CS업체별 유형별 리스트 생성
			createCsCorpTypeGrid();
		});

		// CS업체별 유형별 리스트
		function createCsCorpTypeGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/csCorpTypeListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : $("#csCorpTypeForm").serializeJson()
				, colModels : [
					// 업체별
					{name:"bndNm", label:"<spring:message code='column.statistics.cs.bnd_nm' />", width:"100", align:"center"}
					// 상품명
					, {name:"goodsNm", label:"<spring:message code='column.statistics.cs.goods_nm' />", width:"200", align:"center", sortable:false}
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
					var csCount = $("#csCorpTypeList" ).jqGrid('getCol', 'csCount', false, 'sum');
					var csRate = $("#csCorpTypeList" ).jqGrid('getCol', 'csRate', false, 'sum');

					$("#csCorpTypeList" ).jqGrid('footerData', 'set',
						{
							goodsNm : '합계 : '
							, csCount : csCount
							, csRate : csRate
						}
					);
				}
			}

			grid.create("csCorpTypeList", gridOptions);
		}

		// 검색
		function searchCsCorpTypeList() {
			var options = {
				searchParam : $("#csCorpTypeForm").serializeJson()
			};

			grid.reload("csCorpTypeList", options);
		}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<form id="csCorpTypeForm" name="csCorpTypeForm" method="post" >
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
			<button type="button" onclick="searchCsCorpTypeList();" class="btn btn-ok">검색</button>
			<button type="button" onclick="resetForm('csCorpTypeForm');" class="btn btn-ok">초기화</button>
		</div>

		<div class="mModule">
			<table id="csCorpTypeList"></table>
		</div>
	</t:putAttribute>
</t:insertDefinition>