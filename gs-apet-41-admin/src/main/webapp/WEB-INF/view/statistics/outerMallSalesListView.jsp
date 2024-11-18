<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// 외부몰별 매출 리스트 생성
			createOuterMallSalesGrid();
		});

		// 외부몰별 매출 리스트
		function createOuterMallSalesGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/outerMallSalesListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : $("#outerMallSalesForm").serializeJson()
				, colModels : [
					// 순위
					{name:"statsRank", label:"<spring:message code='column.statistics.rank' />", width:"100", align:"center", sortable:false}
					// 외부몰 코드
					, {name:"pageGbCd", label:"<spring:message code='column.statistics.outer.company_no' />", width:"100", align:"center", sortable:false}
					// 외부몰 업체명
					, {name:"pageGbNm", label:"<spring:message code='column.statistics.outer.company_nm' />", width:"300", align:"center", sortable:false}
					// 비율
					, {name:"statsRate", label:"<spring:message code='column.statistics.cs.rate' />", width:"200", align:"center", sortable:false, summaryType:"sum", formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:1, suffix: ' %', thousandsSeparator:','}}
					// 주문수
					, {name:"ordQty", label:"<spring:message code='column.statistics.outer.ord_qty' />", width:"200", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 주문상품수
					, {name:"ordGoodsQty", label:"<spring:message code='column.statistics.outer.ord_goods_qty' />", width:"200", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 총 판매금액
					, {name:"saleAmt", label:"<spring:message code='column.statistics.outer.sale_amt' />", width:"200", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
				]
				, footerrow : true
				, userDataOnFooter : true
				, gridComplete : function () {
					var statsRate = $("#outerMallSalesList" ).jqGrid('getCol', 'statsRate', false, 'sum');
					var ordQty = $("#outerMallSalesList" ).jqGrid('getCol', 'ordQty', false, 'sum');
					var ordGoodsQty = $("#outerMallSalesList" ).jqGrid('getCol', 'ordGoodsQty', false, 'sum');
					var saleAmt = $("#outerMallSalesList" ).jqGrid('getCol', 'saleAmt', false, 'sum');

					$("#outerMallSalesList" ).jqGrid('footerData', 'set',
						{
							pageGbCd : '합계 : '
							, statsRate : statsRate
							, ordQty : ordQty
							, ordGoodsQty : ordGoodsQty
							, saleAmt : saleAmt
						}
					);
				}
			}

			grid.create("outerMallSalesList", gridOptions);
		}

		// 검색
		function searchOuterMallSalesList() {
			var options = {
				searchParam : $("#outerMallSalesForm").serializeJson()
			};

			grid.reload("outerMallSalesList", options);
		}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<form id="outerMallSalesForm" name="outerMallSalesForm" method="post" >
			<table class="table_type1">
				<caption>정보 검색</caption>
				<tbody>
					<tr>
						<!-- 기간별 (결제일 / 주문일, 결제일 Default) 결제일과 주문일은 동일 -->
						<th scope="row"><spring:message code="column.statistics.outer.period" /></th>
						<td colspan="3">
							<frame:datepicker startDate="startDtm" endDate="endDtm" startValue="${adminConstants.COMMON_START_DATE }" />
						</td>
					</tr>
				</tbody>
			</table>
		</form>

		<div class="btn_area_center">
			<button type="button" onclick="searchOuterMallSalesList();" class="btn btn-ok">검색</button>
			<button type="button" onclick="resetForm('outerMallSalesForm');" class="btn btn-cancel">초기화</button>
		</div>

		<div class="mModule">
			<table id="outerMallSalesList"></table>
		</div>
	</t:putAttribute>
</t:insertDefinition>