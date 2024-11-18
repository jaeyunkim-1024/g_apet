<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// 업체매출 리스트 생성
			createCorpSalesCompareGrid();
		});

		// 업체매출 리스트
		function createCorpSalesCompareGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/corpSalesCompareListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : $("#corpSalesCompareForm").serializeJson()
				, colModels : [
					// 순위
					{name:"corpRank", label:"<spring:message code='column.statistics.rank' />", width:"100", align:"center"}
					// 업체번호
					, {name:"compNo", label:"<spring:message code='column.statistics.corp.company_no' />", width:"100", align:"center", sortable:false}
					// 업체명
					, {name:"compNm", label:"<spring:message code='column.statistics.company_nm' />", width:"300", align:"center", sortable:false}
					// 비율
					, {name:"corpRate", label:"<spring:message code='column.statistics.cs.rate' />", width:"200", align:"center", sortable:false, summaryType:"sum", formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' %', thousandsSeparator:','}}
					// 상품주문수
					, {name:"ordQty", label:"<spring:message code='column.statistics.corp.ord_qty' />", width:"200", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 총판매금액
					, {name:"saleAmt", label:"<spring:message code='column.statistics.corp.sale_amt' />", width:"200", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
				]
				, footerrow : true
				, userDataOnFooter : true
				, gridComplete : function () {
					var corpRate = $("#corpSalesCompareList" ).jqGrid('getCol', 'corpRate', false, 'sum');
					var ordQty = $("#corpSalesCompareList" ).jqGrid('getCol', 'ordQty', false, 'sum');
					var saleAmt = $("#corpSalesCompareList" ).jqGrid('getCol', 'saleAmt', false, 'sum');

					$("#corpSalesCompareList" ).jqGrid('footerData', 'set',
						{
							compNo : '합계 : '
							, corpRate : corpRate
							, ordQty : ordQty
							, saleAmt : saleAmt
						}
					);
				}
			}

			grid.create("corpSalesCompareList", gridOptions);
		}

		// 검색
		function searchCorpSalesCompareList() {
			var options = {
				searchParam : $("#corpSalesCompareForm").serializeJson()
			};

			grid.reload("corpSalesCompareList", options);
		}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<form id="corpSalesCompareForm" name="corpSalesCompareForm" method="post" >
			<table class="table_type1">
				<caption>정보 검색</caption>
				<tbody>
					<tr>
						<!-- 주문 접수 일시 -->
						<th scope="row"><spring:message code="column.ord_acpt_dtm" /></th>
						<td colspan="3">
							<frame:datepicker startDate="ordAcptDtmStart" endDate="ordAcptDtmEnd" period="-7" />
						</td>
					</tr>
				</tbody>
			</table>
		</form>

		<div class="btn_area_center">
			<button type="button" onclick="searchCorpSalesCompareList();" class="btn btn-ok">검색</button>
			<button type="button" onclick="resetForm('corpSalesCompareForm');" class="btn btn-cancel">초기화</button>
		</div>

		<div class="mModule">
			<table id="corpSalesCompareList"></table>
		</div>
	</t:putAttribute>
</t:insertDefinition>