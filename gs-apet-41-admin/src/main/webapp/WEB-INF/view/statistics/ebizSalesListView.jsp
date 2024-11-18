<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// 입점업체 / 판매대행 매출비교 리스트 생성
			createEbizSalesGrid();
		});

		// 입점업체 / 판매대행 매출비교 리스트
		function createEbizSalesGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/ebizSalesListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : $("#ebizSalesForm").serializeJson()
				, colModels : [
					// 순위
					{name:"rownum", label:"<spring:message code='column.statistics.rank' />", width:"100", align:"center", sortable:false}
					// 기간
					, {name:"sumRef", label:"<spring:message code='column.statistics.ebiz.period' />", width:"200", align:"center", sortable:false}
					// 업체명
					, {name:"compNm", label:"<spring:message code='column.statistics.company_nm' />", width:"200", align:"center", sortable:false}
					// 업체유형
					, {name:"compTpCd", label:"<spring:message code='column.statistics.comp.kind' />", width:"150", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMP_TP }' showValue='false' />" } }
					// 판매수량(PC)
					, {name:"pcQty", label:"<spring:message code='column.statistics.ebiz.sales.header01' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 매출액(PC)
					, {name:"pcAmt", label:"<spring:message code='column.statistics.ebiz.sales.header02' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 판매수량(MOBILE)
					, {name:"moQty", label:"<spring:message code='column.statistics.ebiz.sales.header03' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 매출액(MOBILE)
					, {name:"moAmt", label:"<spring:message code='column.statistics.ebiz.sales.header04' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 수량합계
					, {name:"totQty", label:"<spring:message code='column.statistics.ebiz.sales.header05' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 매출합계
					, {name:"totAmt", label:"<spring:message code='column.statistics.ebiz.sales.header06' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
				]
					, footerrow : true
					, userDataOnFooter : true
					, gridComplete : function () {
						var pcQty = $("#ebizSalesList" ).jqGrid('getCol', 'pcQty', false, 'sum');
						var pcAmt = $("#ebizSalesList" ).jqGrid('getCol', 'pcAmt', false, 'sum');
						var moQty = $("#ebizSalesList" ).jqGrid('getCol', 'moQty', false, 'sum');
						var moAmt = $("#ebizSalesList" ).jqGrid('getCol', 'moAmt', false, 'sum');
						var totQty = $("#ebizSalesList" ).jqGrid('getCol', 'totQty', false, 'sum');
						var totAmt = $("#ebizSalesList" ).jqGrid('getCol', 'totAmt', false, 'sum');

						$("#ebizSalesList" ).jqGrid('footerData', 'set',
							{
								sumRef : '합계 : '
								, pcQty : pcQty
								, pcAmt : pcAmt
								, moQty : moQty
								, moAmt : moAmt
								, totQty : totQty
								, totAmt : totAmt
							}
						);
					}
			}

			grid.create("ebizSalesList", gridOptions);
		}

		// 검색
		function searchEbizSalesList() {
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
			}

			var options = {
				searchParam : $("#ebizSalesForm").serializeJson()
			};

			grid.reload("ebizSalesList", options);
		}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<form id="ebizSalesForm" name="ebizSalesForm" method="post" >
			<input type="hidden" name="startDtm" id="startDtm" value="" />
			<input type="hidden" name="endDtm" id="endDtm" value="" />
			<table class="table_type1">
				<caption>정보 검색</caption>
				<tbody>
					<tr>
						<!-- 기간별 (일별) -->
						<th scope="row" rowspan="3"><spring:message code="column.statistics.outer.period" /></th>
						<td>
							<label class="fRadio"><input type="radio" name="dateCheck" value="01" checked="checked" /><span>일별</span></label>
							<frame:datepicker startDate="startDtm01" endDate="endDtm01" startValue="${adminConstants.COMMON_START_DATE }" />
						</td>
						<!-- 판매 공간 -->
						<th scope="row" rowspan="3"><spring:message code="column.order_common.page_gb_cd" /></th>
						<td rowspan="3">
							<label class="fRadio"><input type="radio" name="pageCheck" value="" checked="checked"> <span>전체</span></label>
							<label class="fRadio"><input type="radio" name="pageCheck" value="01"> <span>쇼룸</span></label>
							<label class="fRadio"><input type="radio" name="pageCheck" value="02"> <span><spring:message code="column.order_common.search_foreign_mall" /></span></label>

							<select name="pageGbCd" id="pageGbCd" title="선택상자" >
								<frame:select grpCd="${adminConstants.PAGE_GB}" defaultName="선택하세요"/>
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
					<tr>
						<!-- 업체유형 -->
						<th scope="row"><spring:message code="column.statistics.comp.kind" /></th>
						<td>
							<frame:radio name="compTpCd" grpCd="${adminConstants.COMP_TP }" defaultName="전체" />
						</td>
						<!-- 업체검색 -->
						<th scope="row"><spring:message code="column.statistics.comp.search" /></th>
						<td>
							<select name="compNo">
								<option value="">선택하세요</option>
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
			<button type="button" onclick="searchEbizSalesList();" class="btn btn-ok">검색</button>
			<button type="button" onclick="resetForm('ebizSalesForm');" class="btn btn-cancel">초기화</button>
		</div>

		<div class="mModule">
			<table id="ebizSalesList"></table>
		</div>
	</t:putAttribute>
</t:insertDefinition>