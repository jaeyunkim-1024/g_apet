<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// 판매매출순위 리스트 생성
			createOuterMallSalesRankGrid();

			$("#searchRank").val(10);
		});

		// 판매매출순위 리스트
		function createOuterMallSalesRankGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/outerMallSalesRankListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : $("#outerMallSalesRankForm").serializeJson()
				, colModels : [
					// 순위
					{name:"statsRank", label:"<spring:message code='column.statistics.rank' />", width:"100", align:"center", sortable:false}
					// 상품코드
					, {name:"goodsId", label:"<spring:message code='column.statistics.goods_cd' />", width:"200", align:"center", sortable:false}
					// 상품명
					, {name:"goodsNm", label:"<spring:message code='column.statistics.goods_nm' />", width:"300", align:"center", sortable:false}
					// BOM코드
					, {name:"goodsBomCd", label:"<spring:message code='column.statistics.bom_cd' />", width:"150", align:"center", sortable:false, hidden : true}
					// BOM명
					, {name:"goodsBomNm", label:"<spring:message code='column.statistics.bom_nm' />", width:"250", align:"center", sortable:false, hidden : true}
					// 옵션명
					, {name:"itemNm", label:"<spring:message code='column.statistics.attr.nm' />", width:"300", align:"center", sortable:false}
					// 비율
					, {name:"statsRate", label:"<spring:message code='column.statistics.cs.rate' />", width:"100", align:"center", sortable:false, summaryType:"sum", formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:1, suffix: ' %', thousandsSeparator:','}}
					// 옵션판매개수
					, {name:"ordQty", label:"<spring:message code='column.statistics.attr.quantity' />", width:"300", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
				]
				, footerrow : true
				, userDataOnFooter : true
				, gridComplete : function () {
					var statsRate = $("#outerMallSalesRankList" ).jqGrid('getCol', 'statsRate', false, 'sum');
					var ordQty = $("#outerMallSalesRankList" ).jqGrid('getCol', 'ordQty', false, 'sum');

					$("#outerMallSalesRankList" ).jqGrid('footerData', 'set',
						{
							goodsNm : '합계 : '
							, statsRate : statsRate
							, ordQty : ordQty
						}
					);
				}
			}

			grid.create("outerMallSalesRankList", gridOptions);
		}

		// 검색
		function searchOuterMallSalesRankList() {
			var options = {
				searchParam : $("#outerMallSalesRankForm").serializeJson()
			};

			grid.reload("outerMallSalesRankList", options);
		}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<form id="outerMallSalesRankForm" name="outerMallSalesRankForm" method="post" >
			<table class="table_type1">
				<caption>정보 검색</caption>
				<tbody>
					<tr>
						<!-- 기간별 (결제일 / 주문일, 결제일 Default) 결제일과 주문일은 동일 -->
						<th scope="row"><spring:message code="column.statistics.outer.period" /></th>
						<td>
							<frame:datepicker startDate="startDtm" endDate="endDtm" startValue="${adminConstants.COMMON_START_DATE }" />
						</td>
						<!-- 검색순위량(숫자만 입력 가능, Default는 10, 최대 100 까지 입력 가능) -->
						<th scope="row" rowspan="2"><spring:message code="column.statistics.search.rank" /></th>
						<td rowspan="2">
							<input type="text" name="searchRank" id="searchRank" value="" /> 위까지 검색
						</td>
					</tr>
					<tr>
						<!-- 업체 -->
						<th scope="row"><spring:message code="column.statistics.company_nm" /></th>
						<td>
							<select name="compNo">
								<c:forEach items="${companyList}" var="companyList">
									<option value="${companyList.compNo}">${companyList.compNm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</tbody>
			</table>
		</form>

		<div class="btn_area_center">
			<button type="button" onclick="searchOuterMallSalesRankList();" class="btn btn-ok">검색</button>
			<button type="button" onclick="resetForm('outerMallSalesRankForm');" class="btn btn-cancel">초기화</button>
		</div>

		<div class="mModule">
			<table id="outerMallSalesRankList"></table>
		</div>
	</t:putAttribute>
</t:insertDefinition>