<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// 창고별재고통계 리스트 생성
			createWmsWareHouseGrid();
		});

		// 창고별재고통계 리스트
		function createWmsWareHouseGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/wmsWareHouseListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : $("#wmsWareHouseForm").serializeJson()
				, colModels : [
					// 원산지
					{name:"whsNm", label:"<spring:message code='column.whs_nm' />", width:"100", align:"center"}
					// 재고금액
					, {name:"stkAmt", label:"<spring:message code='column.stockAmount' />", width:"100", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 구성비
					, {name:"rate", label:"<spring:message code='column.componentRate' />", width:"200", align:"center", sortable:false, summaryType:"sum", formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:1, suffix: ' %', thousandsSeparator:','}}
				]
				, footerrow : true
				, userDataOnFooter : true
				, gridComplete : function () {
					
					var gridTitle = "합계";
					var stockAmt = $("#wmsWareHouseList" ).jqGrid('getCol', 'stkAmt', false, 'sum');
					var rate = $("#wmsWareHouseList" ).jqGrid('getCol', 'rate', false, 'sum');
					
					if(rate > 100){
						rate = 100;
					}
					
					$("#wmsWareHouseList" ).jqGrid('footerData', 'set',
						{
							whsNm : gridTitle
							, stkAmt : stockAmt
							, rate : rate
							
						}
					);
				}
			}

			grid.create("wmsWareHouseList", gridOptions);
		}

		// 검색
		function searchWmsWareHouseList() {
			var options = {
				searchParam : $("#wmsWareHouseForm").serializeJson()
			};

			grid.reload("wmsWareHouseList", options);
		}
		
		// 엑셀 다운로드
		function wmsWareHouseListExcelDownload() {
			createFormSubmit("wmsWareHouseListExcelDownload", "/statistics/wmsWareHouseListExcelDownload.do", $("#wmsWareHouseForm").serializeJson());
		}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<form id="wmsWareHouseForm" name="wmsWareHouseForm" method="post" >
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
			<button type="button" onclick="searchWmsWareHouseList();" class="btn btn-ok">검색</button>
			<button type="button" onclick="resetForm('wmsWareHouseForm');" class="btn btn-cancel">초기화</button>
		</div>
		
		<div class="mModule">
			<button type="button" onclick="wmsWareHouseListExcelDownload();" class="btn btn-add btn-excel">엑셀 다운로드</button>
			
			<table id="wmsWareHouseList"></table>
		</div>
	</t:putAttribute>
</t:insertDefinition>