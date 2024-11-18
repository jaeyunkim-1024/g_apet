<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// 판매유형별 리스트 생성
			createEbizClassSalesGrid();
		});

		// 판매유형별 리스트
		function createEbizClassSalesGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/ebizClassSalesListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : $("#ebizClassSalesForm").serializeJson()
				, colModels : [
					// 일자
					{name:"sumRef", label:"<spring:message code='column.statistics.ebiz.date' />", width:"200", align:"center", sortable:false}
					, {name:"stpOQty", label:" 상품수량[자사]", width:"200", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"stpOAmt", label:" 매출[자사]", width:"200", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"stpAQty", label:" 상품수량[판매대행]", width:"200", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"stpAAmt", label:" 매출[판매대행]", width:"200", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"stpIQty", label:" 상품수량[입점]", width:"200", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"stpIAmt", label:" 매출[입점]", width:"200", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"dodotAm", label:" 합계", width:"200", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"sttOQty", label:"외부몰 상품수량[자사]", width:"200", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"sttOAmt", label:"외부몰 매출[자사]", width:"200", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"sttAQty", label:"외부몰 상품수량[판매대행]", width:"200", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"sttAAmt", label:"외부몰 매출[판매대행]", width:"200", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"outAmt ", label:"외부몰 합계", width:"200", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"totOQty", label:"상품수량[자사]", width:"200", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"totOAmt", label:"매출[자사]", width:"200", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"totAQty", label:"상품수량[판매대행]", width:"200", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"totAAmt", label:"매출[판매대행]", width:"200", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"totIQty", label:"상품수량[입점]", width:"200", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"totIAmt", label:"매출[입점]", width:"200", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
					, {name:"totAmt", label:"전체 합계", width:"200", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
				]
					, footerrow : true
					, userDataOnFooter : true
					, gridComplete : function () {
						var stpOQty   = $("#ebizClassSalesList" ).jqGrid('getCol','stpOQty', false,'sum');
						var stpOAmt   = $("#ebizClassSalesList" ).jqGrid('getCol','stpOAmt', false,'sum');
						var stpAQty   = $("#ebizClassSalesList" ).jqGrid('getCol','stpAQty', false,'sum');
						var stpAAmt   = $("#ebizClassSalesList" ).jqGrid('getCol','stpAAmt', false,'sum');
						var stpIQty   = $("#ebizClassSalesList" ).jqGrid('getCol','stpIQty', false,'sum');
						var stpIAmt   = $("#ebizClassSalesList" ).jqGrid('getCol','stpIAmt', false,'sum');
						var dodotAm   = $("#ebizClassSalesList" ).jqGrid('getCol','dodotAm', false,'sum');
						var sttOQty   = $("#ebizClassSalesList" ).jqGrid('getCol','sttOQty', false,'sum');
						var sttOAmt   = $("#ebizClassSalesList" ).jqGrid('getCol','sttOAmt', false,'sum');
						var sttAQty   = $("#ebizClassSalesList" ).jqGrid('getCol','sttAQty', false,'sum');
						var sttAAmt   = $("#ebizClassSalesList" ).jqGrid('getCol','sttAAmt', false,'sum');
						var outAmt    = $("#ebizClassSalesList" ).jqGrid('getCol','outAmt ', false,'sum');
						var totOQty   = $("#ebizClassSalesList" ).jqGrid('getCol','totOQty', false,'sum');
						var totOAmt   = $("#ebizClassSalesList" ).jqGrid('getCol','totOAmt', false,'sum');
						var totAQty   = $("#ebizClassSalesList" ).jqGrid('getCol','totAQty', false,'sum');
						var totAAmt   = $("#ebizClassSalesList" ).jqGrid('getCol','totAAmt', false,'sum');
						var totIQty   = $("#ebizClassSalesList" ).jqGrid('getCol','totIQty', false,'sum');
						var totIAmt   = $("#ebizClassSalesList" ).jqGrid('getCol','totIAmt', false,'sum');
						var totAmt    = $("#ebizClassSalesList" ).jqGrid('getCol','totAmt ', false,'sum');

						$("#ebizClassSalesList" ).jqGrid('footerData', 'set',
							{
								sumRef : '합계 : '
								, stpOQty : stpOQty
								, stpOAmt : stpOAmt
								, stpAQty : stpAQty
								, stpAAmt : stpAAmt
								, stpIQty : stpIQty
								, stpIAmt : stpIAmt
								, dodotAm : dodotAm
								, sttOQty : sttOQty
								, sttOAmt : sttOAmt
								, sttAQty : sttAQty
								, sttAAmt : sttAAmt
								, outAmt  : outAmt
								, totOQty : totOQty
								, totOAmt : totOAmt
								, totAQty : totAQty
								, totAAmt : totAAmt
								, totIQty : totIQty
								, totIAmt : totIAmt
								, totAmt  : totAmt
							}
						);
					}
			}

			grid.create("ebizClassSalesList", gridOptions);
		}

		// 검색
		function searchEbizClassSalesList() {
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
				searchParam : $("#ebizClassSalesForm").serializeJson()
			};

			grid.reload("ebizClassSalesList", options);
		}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<form id="ebizClassSalesForm" name="ebizClassSalesForm" method="post" >
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
			<button type="button" onclick="searchEbizClassSalesList();" class="btn btn-ok">검색</button>
			<button type="button" onclick="resetForm('ebizClassSalesForm');" class="btn btn-cancel">초기화</button>
		</div>

		<div class="mModule">
			<table id="ebizClassSalesList"></table>
		</div>
	</t:putAttribute>
</t:insertDefinition>