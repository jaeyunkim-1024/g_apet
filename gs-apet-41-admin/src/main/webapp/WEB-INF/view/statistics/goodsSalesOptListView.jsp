<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// 상품옵션별 리스트 생성
			createGoodsSalesOptGrid();
		});

		// 상품옵션별 리스트
		function createGoodsSalesOptGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/goodsSalesOptListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : $("#goodsSalesOptForm").serializeJson()
				, colModels : [
					// 일자/주/월/년
					{name:"sumDate", label:"<spring:message code='column.statistics.outer.dwmy' />", width:"200", align:"center", sortable:false}
					// BOM코드
					, {name:"goodsBomCd", label:"<spring:message code='column.statistics.bom_cd' />", width:"150", align:"center", sortable:false, hidden : true}
					// BOM명
					, {name:"goodsBomNm", label:"<spring:message code='column.statistics.bom_nm' />", width:"250", align:"center", sortable:false}
					// BOM판매 갯수
					, {name:"ordQty", label:"<spring:message code='column.statistics.bom.sales.cnt' />", width:"150", align:"center", sortable:false}
					// 일간 평균 판매량
					, {name:"dayAvg", label:"<spring:message code='column.statistics.bom.sales.day.avg' />", width:"150", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:1, suffix: ' %', thousandsSeparator:','}}
					// 월간 평균 판매량
					, {name:"monthAvg", label:"<spring:message code='column.statistics.bom.sales.month.avg' />", width:"150", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:1, suffix: ' %', thousandsSeparator:','}}
				]
			}

			grid.create("goodsSalesOptList", gridOptions);
		}

		// 검색
		function searchGoodsSalesOptList() {
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
				searchParam : $("#goodsSalesOptForm").serializeJson()
			};

			grid.reload("goodsSalesOptList", options);
		}

		// 상품검색 초기화
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

		// 전시카테고리 검색
		function displayCategoryAddPop() {
			var options = {
				multiselect : false
				, plugins : [ "themes" ]
				, arrDispClsfCd : [_CATEGORY_SEARCH_LAYER_DISP_CLSF_10,_CATEGORY_SEARCH_LAYER_DISP_CLSF_30]
				, callBack : function(result) {
					if(result != null && result.length > 0) {
						var idx = $('#dispCtgList').getDataIDs();
						var message = new Array();
						for(var i in result){
							$("#dispNm").val(result[i].dispPath);
							$("#dispNo").val(result[i].dispNo);
							$("#dispLvl").val(result[i].dispLvl);
						}
						if(message != null && message.length > 0) {
							messager.alert(message.join("<br>"), "Info", "info");
						}
					}
				}
			}

			layerCategoryList.create(options);
		}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<form id="goodsSalesOptForm" name="goodsSalesOptForm" method="post" >
			<input type="hidden" name="startDtm" id="startDtm" value="" />
			<input type="hidden" name="endDtm" id="endDtm" value="" />
			<input type="hidden" name="dispNo" id="dispNo" value="" />
			<input type="hidden" name="dispLvl" id="dispLvl" value="" />
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
						<!-- 카테고리 -->
						<th scope="row" rowspan="2"><spring:message code="column.statistics.category_nm" /></th>
						<td rowspan="2">
							<input type="text" name="dispNm" id="dispNm" class="w300" value="" />
							<button type="button" class="btn" onclick="displayCategoryAddPop();" >검색</button>
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
						<!-- 상품 -->
						<th scope="row" rowspan="2"><spring:message code="column.statistics.goods" /></th>
						<td rowspan="2">
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
			<button type="button" onclick="searchGoodsSalesOptList();" class="btn btn-ok">검색</button>
			<button type="button" onclick="resetForm('goodsSalesOptForm');" class="btn btn-cancel">초기화</button>
		</div>

		<div class="mModule">
			<table id="goodsSalesOptList"></table>
		</div>
	</t:putAttribute>
</t:insertDefinition>