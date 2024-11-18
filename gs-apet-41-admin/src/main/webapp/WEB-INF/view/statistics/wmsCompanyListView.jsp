<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// 업체별재고통계 리스트 생성
			createWmsCompanyGrid();
		});

		// 업체별재고통계 리스트
		function createWmsCompanyGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/wmsCompanyListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : $("#wmsCompanyForm").serializeJson()
				, colModels : [
					// 업체
					{name:"compNm", label:"<spring:message code='column.comp_nm' />", width:"100", align:"center"}
					// 재고금액
					, {name:"stkAmt", label:"<spring:message code='column.stockAmount' />", width:"100", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 구성비
					, {name:"rate", label:"<spring:message code='column.componentRate' />", width:"200", align:"center", sortable:false, summaryType:"sum", formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:1, suffix: ' %', thousandsSeparator:','}}
				]
				, footerrow : true
				, userDataOnFooter : true
				, gridComplete : function () {
					
					var gridTitle = "합계";
					var stockAmt = $("#wmsCompanyList" ).jqGrid('getCol', 'stkAmt', false, 'sum');
					var rate = $("#wmsCompanyList" ).jqGrid('getCol', 'rate', false, 'sum');
					
					if(rate > 100){
						rate = 100;
					}
					
					$("#wmsCompanyList" ).jqGrid('footerData', 'set',
						{
							compNm : gridTitle
							, stkAmt : stockAmt
							, rate : rate
							
						}
					);
				}
			}

			grid.create("wmsCompanyList", gridOptions);
		}

		// 검색
		function searchWmsCompanyList() {
			var options = {
				searchParam : $("#wmsCompanyForm").serializeJson()
			};

			grid.reload("wmsCompanyList", options);
		}
		
		// 엑셀 다운로드
		function wmsCompanyListExcelDownload() {
			createFormSubmit("wmsCompanyListExcelDownload", "/statistics/wmsCompanyListExcelDownload.do", $("#wmsCompanyForm").serializeJson());
		}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<form id="wmsCompanyForm" name="wmsCompanyForm" method="post" >
			<table class="table_type1">
				<caption>정보 검색</caption>
				<tbody>
					<tr>
						<!-- 검색조건 -->
						<th scope="row">조회일자</th>
						<td colspan="3">
							<frame:datepicker startDate="baseDt" format="yyyyMMdd" />
						</td>
					</tr>
				</tbody>
			</table>
		</form>

		<div class="btn_area_center">
			<button type="button" onclick="searchWmsCompanyList();" class="btn btn-ok">검색</button>
			<button type="button" onclick="resetForm('wmsCompanyForm');" class="btn btn-cancel">초기화</button>
		</div>
		
		<div class="mModule">
			<button type="button" onclick="wmsCompanyListExcelDownload();" class="btn btn-add btn-excel">엑셀 다운로드</button>
			<table id="wmsCompanyList"></table>
		</div>
	</t:putAttribute>
</t:insertDefinition>