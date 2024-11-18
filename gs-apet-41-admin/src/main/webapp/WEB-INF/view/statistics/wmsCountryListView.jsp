<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// 원산지별재고통계 리스트 생성
			createWmsCountryGrid();
		});

		// 원산지별재고통계 리스트
		function createWmsCountryGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/wmsCountryListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : $("#wmsCountryForm").serializeJson()
				, colModels : [
					// 재고금액
					, {name:"stkAmt", label:"<spring:message code='column.stockAmount' />", width:"100", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 구성비
					, {name:"rate", label:"<spring:message code='column.componentRate' />", width:"200", align:"center", sortable:false, summaryType:"sum", formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:1, suffix: ' %', thousandsSeparator:','}}
				]
				, footerrow : true
				, userDataOnFooter : true
				, gridComplete : function () {
					
					var gridTitle = "합계";
					var stockAmt = $("#wmsCountryList" ).jqGrid('getCol', 'stkAmt', false, 'sum');
					var rate = $("#wmsCountryList" ).jqGrid('getCol', 'rate', false, 'sum');
					
					if(rate > 100){
						rate = 100;
					}
					
					$("#wmsCountryList" ).jqGrid('footerData', 'set',
						{
							bomCtrOrgNm : gridTitle
							, stkAmt : stockAmt
							, rate : rate
							
						}
					);
				}
			}

			grid.create("wmsCountryList", gridOptions);
		}

		// 검색
		function searchWmsCountryList() {
			var options = {
				searchParam : $("#wmsCountryForm").serializeJson()
			};

			grid.reload("wmsCountryList", options);
		}
		
		// 엑셀 다운로드
		function wmsCountryListExcelDownload() {
			createFormSubmit("wmsCountryListExcelDownload", "/statistics/wmsCountryListExcelDownload.do", $("#wmsCountryForm").serializeJson());
		}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<form id="wmsCountryForm" name="wmsCountryForm" method="post" >
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
			<button type="button" onclick="searchWmsCountryList();" class="btn btn-ok">검색</button>
			<button type="button" onclick="resetForm('wmsCountryForm');" class="btn btn-cancel">초기화</button>
		</div>
		
		<div class="mModule">
			<button type="button" onclick="wmsCountryListExcelDownload();" class="btn btn-add btn-excel">엑셀 다운로드</button>
			
			<table id="wmsCountryList"></table>
		</div>
	</t:putAttribute>
</t:insertDefinition>