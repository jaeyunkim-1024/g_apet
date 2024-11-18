<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// 입점업체 / 판매대행 상품판매순위 리스트 생성
			createEbizSalesRankGrid();
		});

		// 입점업체 / 판매대행 상품판매순위 리스트
		function createEbizSalesRankGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/ebizSalesRankListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : $("#ebizSalesRankForm").serializeJson()
				, colModels : [
					// 순위
					{name:"rownum", label:"<spring:message code='column.statistics.rank' />", width:"100", align:"center", sortable:false}
					// 기간
					, {name:"sumRef", label:"<spring:message code='column.statistics.ebiz.period' />", width:"200", align:"center", sortable:false}
					// 상품코드
					, {name:"goodsId", label:"<spring:message code='column.statistics.goods_cd' />", width:"150", align:"center", sortable:false}
					// 상품명
					, {name:"goodsNm", label:"<spring:message code='column.statistics.goods_nm' />", width:"300", align:"center", sortable:false}
					// 총수량
					, {name:"ordQty", label:"<spring:message code='column.statistics.total.cnt' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 매출액
					, {name:"saleAmt", label:"<spring:message code='column.statistics.sales.amount' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
				]
					, footerrow : true
					, userDataOnFooter : true
					, gridComplete : function () {
						var ordQty = $("#ebizSalesRankList" ).jqGrid('getCol', 'ordQty', false, 'sum');
						var saleAmt = $("#ebizSalesRankList" ).jqGrid('getCol', 'saleAmt', false, 'sum');

						$("#ebizSalesRankList" ).jqGrid('footerData', 'set',
							{
								sumRef : '합계 : '
								, ordQty : ordQty
								, saleAmt : saleAmt
							}
						);
					}
			}

			grid.create("ebizSalesRankList", gridOptions);
		}

		// 검색
		function searchEbizSalesRankList() {
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
				searchParam : $("#ebizSalesRankForm").serializeJson()
			};

			grid.reload("ebizSalesRankList", options);
		}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<form id="ebizSalesRankForm" name="ebizSalesRankForm" method="post" >
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
					<tr>
						<!-- 검색순위량(숫자만 입력 가능, Default는 10, 최대 100 까지 입력 가능) -->
						<th scope="row" rowspan="2"><spring:message code="column.statistics.search.rank" /></th>
						<td colspan="3">
							<input type="text" name="searchRank" value="100" /> 위까지 검색
						</td>
					</tr>
				</tbody>
			</table>
		</form>

		<div class="btn_area_center">
			<button type="button" onclick="searchEbizSalesRankList();" class="btn btn-ok">검색</button>
			<button type="button" onclick="resetForm('ebizSalesRankForm');" class="btn btn-cancel">초기화</button>
		</div>

		<div class="mModule">
			<table id="ebizSalesRankList"></table>
		</div>
	</t:putAttribute>
</t:insertDefinition>