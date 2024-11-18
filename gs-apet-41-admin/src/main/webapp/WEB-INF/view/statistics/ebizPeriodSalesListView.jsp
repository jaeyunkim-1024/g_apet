<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// 기간별 리스트 생성
			createEbizPeriodSalesGrid();
		});

		// 기간별 리스트
		function createEbizPeriodSalesGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/ebizPeriodSalesListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : $("#ebizPeriodSalesForm").serializeJson()
				, colModels : [
					// 일자
					{name:"sumDate", label:"<spring:message code='column.statistics.ebiz.date' />", width:"200", align:"center", sortable:false}
					// 주문건수(PC)
					, {name:"pcOrdQty", label:"<spring:message code='column.statistics.ebiz.period.header01' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 상품수량(PC)
					, {name:"pcQty", label:"<spring:message code='column.statistics.ebiz.period.header02' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 매출(PC)
					, {name:"pcSaleAmt", label:"<spring:message code='column.statistics.ebiz.period.header03' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 주문건수(MOBILE)
					, {name:"moOrdQty", label:"<spring:message code='column.statistics.ebiz.period.header04' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 상품수량(MOBILE)
					, {name:"moQty", label:"<spring:message code='column.statistics.ebiz.period.header05' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 매출(MOBILE)
					, {name:"moSaleAmt", label:"<spring:message code='column.statistics.ebiz.period.header06' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 주문건수(쇼룸)
					, {name:"srOrdQty", label:"<spring:message code='column.statistics.ebiz.period.header07' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 상품수량(쇼룸)
					, {name:"srQty", label:"<spring:message code='column.statistics.ebiz.period.header08' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 매출(쇼룸)
					, {name:"srSaleAmt", label:"<spring:message code='column.statistics.ebiz.period.header09' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 합계
					, {name:"dodotAmt", label:"<spring:message code='column.statistics.ebiz.class.header05' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 주문건수(마켓)
					, {name:"mkOrdQty", label:"<spring:message code='column.statistics.ebiz.period.header10' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 상품수량(마켓)
					, {name:"mkQty", label:"<spring:message code='column.statistics.ebiz.period.header11' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 매출(마켓)
					, {name:"mkSaleAmt", label:"<spring:message code='column.statistics.ebiz.period.header12' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 전체 합계
					, {name:"totAmt", label:"<spring:message code='column.statistics.ebiz.class.header07' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
				]
					, footerrow : true
					, userDataOnFooter : true
					, gridComplete : function () {
						var pcOrdQty 	= $("#ebizPeriodSalesList" ).jqGrid('getCol', 'pcOrdQty', 	false, 'sum');
						var pcQty 	 	= $("#ebizPeriodSalesList" ).jqGrid('getCol', 'pcQty', 		false, 'sum');
						var pcSaleAmt 	= $("#ebizPeriodSalesList" ).jqGrid('getCol', 'pcSaleAmt', 	false, 'sum');
						var moOrdQty 	= $("#ebizPeriodSalesList" ).jqGrid('getCol', 'moOrdQty', 	false, 'sum');
						var moQty 		= $("#ebizPeriodSalesList" ).jqGrid('getCol', 'moQty', 		false, 'sum');
						var moSaleAmt	= $("#ebizPeriodSalesList" ).jqGrid('getCol', 'moSaleAmt', 	false, 'sum');
						var srOrdQty 	= $("#ebizPeriodSalesList" ).jqGrid('getCol', 'srOrdQty', 	false, 'sum');
						var srQty 	 	= $("#ebizPeriodSalesList" ).jqGrid('getCol', 'srQty', 		false, 'sum');
						var srSaleAmt 	= $("#ebizPeriodSalesList" ).jqGrid('getCol', 'srSaleAmt', 	false, 'sum');
						var dodotAmt 	= $("#ebizPeriodSalesList" ).jqGrid('getCol', 'dodotAmt', 	false, 'sum');
						var mkOrdQty 	= $("#ebizPeriodSalesList" ).jqGrid('getCol', 'mkOrdQty', 	false, 'sum');
						var mkQty 	 	= $("#ebizPeriodSalesList" ).jqGrid('getCol', 'mkQty', 		false, 'sum');
						var mkSaleAmt 	= $("#ebizPeriodSalesList" ).jqGrid('getCol', 'mkSaleAmt', 	false, 'sum');
						var totAmt 	 	= $("#ebizPeriodSalesList" ).jqGrid('getCol', 'totAmt', 	false, 'sum');

						$("#ebizPeriodSalesList" ).jqGrid('footerData', 'set',
							{
								sumDate : '합계 : '
								, pcOrdQty  : pcOrdQty
								, pcQty 	: pcQty
								, pcSaleAmt : pcSaleAmt
								, moOrdQty  : moOrdQty
								, moQty 	: moQty
								, moSaleAmt : moSaleAmt
								, srOrdQty  : srOrdQty
								, srQty 	: srQty
								, srSaleAmt : srSaleAmt
								, dodotAmt  : dodotAmt
								, mkOrdQty  : mkOrdQty
								, mkQty 	: mkQty
								, mkSaleAmt : mkSaleAmt
								, totAmt 	: totAmt
							}
						);
					}
			}

			grid.create("ebizPeriodSalesList", gridOptions);
		}

		// 검색
		function searchEbizPeriodSalesList() {
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
			} else if (dateCheck == '04') {
				$("#startDtm").val($("#startDtm04 option:selected").val() + $("#startDtm04Week option:selected").val() );
				$("#endDtm").val($("#endDtm04 option:selected").val() + $("#endDtm04Week option:selected").val() );
			}


			var options = {
				searchParam : $("#ebizPeriodSalesForm").serializeJson()
			};

			grid.reload("ebizPeriodSalesList", options);
		}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<form id="ebizPeriodSalesForm" name="ebizPeriodSalesForm" method="post" >
			<input type="hidden" name="startDtm" id="startDtm" value="" />
			<input type="hidden" name="endDtm" id="endDtm" value="" />
			<table class="table_type1">
				<caption>정보 검색</caption>
				<tbody>
					<tr>
						<!-- 기간별 (일별) -->
						<th scope="row" rowspan="4"><spring:message code="column.statistics.outer.period" /></th>
						<td>
							<label class="fRadio"><input type="radio" name="dateCheck" value="01" checked="checked" /><span>일별</span></label>
							<frame:datepicker startDate="startDtm01" endDate="endDtm01" startValue="${adminConstants.COMMON_START_DATE }" />
						</td>
						<!-- 판매 공간 -->
						<th scope="row" rowspan="4"><spring:message code="column.order_common.page_gb_cd" /></th>
						<td rowspan="4">
							<label class="fRadio"><input type="radio" name="pageCheck" value="" checked="checked"> <span>전체</span></label>
							<label class="fRadio"><input type="radio" name="pageCheck" value="01"> <span>쇼룸</span></label>
							<label class="fRadio"><input type="radio" name="pageCheck" value="02"> <span><spring:message code="column.order_common.search_foreign_mall" /></span></label>

							<select name="pageGbCd" id="pageGbCd" title="선택상자" >
								<frame:select grpCd="${adminConstants.PAGE_GB}" defaultName="선택하세요"/>
							</select>
						</td>
					</tr>
					<tr>
						<!-- 기간별 (주별) -->
						<td>
							<label class="fRadio"><input type="radio" name="dateCheck" value="04" /><span>주별</span></label>
							<select class="w80" name="startDtm04" id="startDtm04">
								<frame:select grpCd="${adminConstants.YYYY}"/>
							</select>
							<select class="w50" name="startDtm04Week" id="startDtm04Week">
								<frame:select grpCd="${adminConstants.WW}"/>
							</select> ~
							<select class="w80" name="endDtm04" id="endDtm04">
								<frame:select grpCd="${adminConstants.YYYY}"/>
							</select>
							<select class="w50" name="endDtm04Week" id="endDtm04Week">
								<frame:select grpCd="${adminConstants.WW}"/>
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
					</tr>
				</tbody>
			</table>
		</form>

		<div class="btn_area_center">
			<button type="button" onclick="searchEbizPeriodSalesList();" class="btn btn-ok">검색</button>
			<button type="button" onclick="resetForm('ebizPeriodSalesForm');" class="btn btn-cancel">초기화</button>
		</div>

		<div class="mModule">
			<table id="ebizPeriodSalesList"></table>
		</div>
	</t:putAttribute>
</t:insertDefinition>