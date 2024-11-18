<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// 대카테고리별 매출현황 리스트 생성
			createEbizLargeSalesGrid();
		});

		// 대카테고리별 매출현황 리스트
		function createEbizLargeSalesGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/ebizLargeSalesListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : $("#ebizLargeSalesForm").serializeJson()
				, colModels : [
					// 일자
					{name:"sumRef", label:"집계구분", width:"200", align:"center", sortable:false}
					// 대카명
					, {name:"dispClsfNm", label:"<spring:message code='column.statistics.ebiz.large.nm' />", width:"300", align:"center", sortable:false}
					// 수량
					, {name:"saleAmt", label:"<spring:message code='column.statistics.ebiz.sales' />", width:"150", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					// 매출
					, {name:"saleRate", label:"판매 비중%", width:"150", align:"center", sortable:false, formatter:'integer'}
					, {name:"totAmt", label:"<spring:message code='column.statistics.ebiz.sales' />", width:"150", align:"center", sortable:false, formatter:'integer'}
				]
					, footerrow : true
					, userDataOnFooter : true
					, gridComplete : function () {
						var saleAmt = $("#ebizLargeSalesList" ).jqGrid('getCol', 'saleAmt', false, 'sum');

						$("#ebizLargeSalesList" ).jqGrid('footerData', 'set',
							{
								dispClsfNm : '합계 : '
								, saleAmt : saleAmt
							}
						);
					}
			}

			grid.create("ebizLargeSalesList", gridOptions);
		}

		// 검색
		function searchEbizLargeSalesList() {
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
				searchParam : $("#ebizLargeSalesForm").serializeJson()
			};

			grid.reload("ebizLargeSalesList", options);
		}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<form id="ebizLargeSalesForm" name="ebizLargeSalesForm" method="post" >
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
			<button type="button" onclick="searchEbizLargeSalesList();" class="btn btn-ok">검색</button>
			<button type="button" onclick="resetForm('ebizLargeSalesForm');" class="btn btn-cancel">초기화</button>
		</div>

		<div class="mModule">
			<table id="ebizLargeSalesList"></table>
		</div>
	</t:putAttribute>
</t:insertDefinition>