<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// 중카테고리별 매출현황 리스트 생성
			createEbizMiddleSalesGrid();
		});

		// 중카테고리별 매출현황 리스트
		function createEbizMiddleSalesGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/ebizMiddleSalesListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : $("#ebizMiddleSalesForm").serializeJson()
				, colModels : [
					// 대카명
					{name:"dispClsfNmDepth1", label:"<spring:message code='column.statistics.ebiz.large.nm' />", width:"200", align:"center", sortable:false}
					// 중카명
					, {name:"dispClsfNmDepth2", label:"<spring:message code='column.statistics.ebiz.middle.nm' />", width:"300", align:"center", sortable:false}
					// 수량
					, {name:"ordQty", label:"<spring:message code='column.statistics.ebiz.cnt' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 매출
					, {name:"saleAmt", label:"<spring:message code='column.statistics.ebiz.sales' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 비중
					, {name:"saleRate", label:"비중", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
				]
					, footerrow : true
					, userDataOnFooter : true
					, gridComplete : function () {
						var ordQty = $("#ebizMiddleSalesList" ).jqGrid('getCol', 'ordQty', false, 'sum');
						var saleAmt = $("#ebizMiddleSalesList" ).jqGrid('getCol', 'saleAmt', false, 'sum');
						var saleRate = $("#ebizMiddleSalesList" ).jqGrid('getCol', 'saleRate', false, 'sum');

						$("#ebizMiddleSalesList" ).jqGrid('footerData', 'set',
							{
								dispClsfNmDepth2 : '합계 : '
								, ordQty : ordQty
								, saleAmt : saleAmt
								, saleRate : Math.round(saleRate)
							}
						);
					}
			}

			grid.create("ebizMiddleSalesList", gridOptions);
		}

		// 검색
		function searchEbizMiddleSalesList() {
			$("#startDtm").val($("#startDtm01").val().replace(/\-/g,'') );
			$("#endDtm").val($("#endDtm01").val().replace(/\-/g,'') );

			var options = {
				searchParam : $("#ebizMiddleSalesForm").serializeJson()
			};

			grid.reload("ebizMiddleSalesList", options);
		}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<form id="ebizMiddleSalesForm" name="ebizMiddleSalesForm" method="post" >
			<input type="hidden" name="startDtm" id="startDtm" value="" />
			<input type="hidden" name="endDtm" id="endDtm" value="" />
			<table class="table_type1">
				<caption>정보 검색</caption>
				<tbody>
					<tr>
						<!-- 기간별 (결제일 / 주문일, 결제일 Default) 결제일과 주문일은 동일 -->
						<th scope="row"><spring:message code="column.ord.payCpltDtm" /></th>
						<td>
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
				</tbody>
			</table>
		</form>

		<div class="btn_area_center">
			<button type="button" onclick="searchEbizMiddleSalesList();" class="btn btn-ok">검색</button>
			<button type="button" onclick="resetForm('ebizMiddleSalesForm');" class="btn btn-cancel">초기화</button>
		</div>

		<div class="mModule">
			<table id="ebizMiddleSalesList"></table>
		</div>
	</t:putAttribute>
</t:insertDefinition>