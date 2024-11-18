<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// 상품옵션별 리스트 생성
			createOuterMallSalesOptGrid();
		});

		// 상품옵션별 리스트
		function createOuterMallSalesOptGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/outerMallSalesOptListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : $("#outerMallSalesOptForm").serializeJson()
				, colModels : [
					// 일자/월/년
					{name:"sumDate", label:"<spring:message code='column.statistics.outer.dmy' />", width:"300", align:"center", sortable:false}
					// 옵션명
					, {name:"itemNm", label:"<spring:message code='column.statistics.attr.nm' />", width:"300", align:"center", sortable:false}
					// 비율
					, {name:"statsRate", label:"<spring:message code='column.statistics.cs.rate' />", width:"300", align:"center", sortable:false, summaryType:"sum", formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:1, suffix: ' %', thousandsSeparator:','}}
					// 옵션판매개수
					, {name:"ordQty", label:"<spring:message code='column.statistics.attr.quantity' />", width:"300", align:"center", sortable:false, summaryType:"sum", formatter:'integer'}
				]
				, footerrow : true
				, userDataOnFooter : true
				, gridComplete : function () {
					var statsRate = $("#outerMallSalesOptList" ).jqGrid('getCol', 'statsRate', false, 'sum');
					var ordQty = $("#outerMallSalesOptList" ).jqGrid('getCol', 'ordQty', false, 'sum');

					$("#outerMallSalesOptList" ).jqGrid('footerData', 'set',
						{
							sumDate : '합계 : '
							, statsRate : statsRate
							, ordQty : ordQty
						}
					);
				}
			}

			grid.create("outerMallSalesOptList", gridOptions);
		}

		// 검색
		function searchOuterMallSalesOptList() {
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
				searchParam : $("#outerMallSalesOptForm").serializeJson()
			};

			grid.reload("outerMallSalesOptList", options);
		}

		// 판매공간 초기화
		$(document).on("change", "#pageGbCd", function(e) {
			$("#searchGoodsValue").val("");
		});

		// BOM검색
		function addDpaBomList() {
			var bomKindCds = new Array();

			bomKindCds.push('${adminConstants.BOM_KIND_DSA}');
			bomKindCds.push('${adminConstants.BOM_KIND_DCA}');
			bomKindCds.push('${adminConstants.BOM_KIND_DPA}');
			bomKindCds.push('${adminConstants.BOM_KIND_BSA}');
			bomKindCds.push('${adminConstants.BOM_KIND_BCA}');
			bomKindCds.push('${adminConstants.BOM_KIND_BPA}');

			var options = {
				bomKindCds : bomKindCds
				, multiselect : false
				, callBack : addDpaBomListCallback
			}
//			layerBomList.create (options);
		}

		// BOM검색 결과
		function addDpaBomListCallback(bomList) {
			var rowIds = null;
			var check = false;
			if(typeof bomList !== "undefined" && bomList.length > 0) {
				for(var i = 0; i < bomList.length; i++) {
					// 중복 체크
					bomList[i].bomCd = "";
					rowIds = $("#dpaBomList").jqGrid("getDataIDs");
					for(var idx = 0; idx < rowIds.length; idx++) {
						if(rowIds[idx] == bomList[i].cstrtBomCd) {
							check = true;
						}
					}
					if(!check) {
						if($("#pageGbCd option:selected").val() == "type01") {
							$("#searchGoodsValue").val(bomList[i].cstrtBomCd);
						} else if($("#pageGbCd option:selected").val() == "type02") {
							$("#searchGoodsValue").val(bomList[i].bomNm);
						}

						check = false;
					}
				}
			}
		}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<form id="outerMallSalesOptForm" name="outerMallSalesOptForm" method="post" >
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
							<select name="pageGbCd" id="pageGbCd">
								<option value="type01" selected="selected">BOM코드</option>
								<option value="type02">BOM명</option>
								<option value="type03">상품명</option>
							</select>
							<input type="text" name="searchGoodsValue" id="searchGoodsValue" class="w180" value="" />
							<button type="button" class="btn" onclick="addDpaBomList();" >BOM검색</button>
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
			<button type="button" onclick="searchOuterMallSalesOptList();" class="btn btn-ok">검색</button>
			<button type="button" onclick="resetForm('outerMallSalesOptForm');" class="btn btn-cacnel">초기화</button>
		</div>

		<div class="mModule">
			<table id="outerMallSalesOptList"></table>
		</div>
	</t:putAttribute>
</t:insertDefinition>