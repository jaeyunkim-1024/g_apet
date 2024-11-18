<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// 판매순위 리스트 생성
			createGoodsSalesRankGrid();

			$("#searchRank").val(10);
		});

		// 판매순위 리스트
		function createGoodsSalesRankGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/goodsSalesRankListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : $("#goodsSalesRankForm").serializeJson()
				, colModels : [
					// 순위
					{name:"statsRank", label:"<spring:message code='column.statistics.rank' />", width:"100", align:"center", sortable:false}
					// BOM코드
					, {name:"goodsBomCd", label:"<spring:message code='column.statistics.bom_cd' />", width:"150", align:"center", sortable:false, hidden : true}
					// BOM명
					, {name:"goodsBomNm", label:"<spring:message code='column.statistics.bom_nm' />", width:"250", align:"center", sortable:false, hidden : true}
					// 판매량(조회기간)
					, {name:"ordQty", label:"<spring:message code='column.statistics.goods.sales.amount' />", width:"250", align:"center", sortable:false}
					// 총판매량(누적)
					, {name:"sumOrdQty", label:"<spring:message code='column.statistics.goods.sales.sum' />", width:"250", align:"center", sortable:false}
					// 등록일
					, {name:"sysRegDtm", label:"<spring:message code='column.statistics.goods.regdate' />", width:"250", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
				]
			}

			grid.create("goodsSalesRankList", gridOptions);
		}

		// 검색
		function searchGoodsSalesRankList() {
			var options = {
				searchParam : $("#goodsSalesRankForm").serializeJson()
			};

			grid.reload("goodsSalesRankList", options);
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
		<form id="goodsSalesRankForm" name="goodsSalesRankForm" method="post" >
			<input type="hidden" name="dispNo" id="dispNo" value="" />
			<input type="hidden" name="dispLvl" id="dispLvl" value="" />
				<table class="table_type1">
					<caption>정보 검색</caption>
					<tbody>
						<tr>
							<!-- 기간별 (결제일 / 주문일, 결제일 Default) 결제일과 주문일은 동일 -->
							<th scope="row"><spring:message code="column.statistics.outer.period" /></th>
							<td>
								<frame:datepicker startDate="startDtm" endDate="endDtm" startValue="${adminConstants.COMMON_START_DATE }" />
							</td>
							<!-- 판매 순위 (숫자만 입력 가능, Default는 10, 최대 100 까지 입력 가능) -->
							<th scope="row"><spring:message code="column.statistics.goods.sales.rank" /></th>
							<td>
								<input type="text" name="searchRank" id="searchRank" value="" /> 위까지 검색
							</td>
						</tr>
						<tr>
							<!-- 카테고리 -->
							<th scope="row"><spring:message code="column.statistics.category_nm" /></th>
							<td>
								<input type="text" name="dispNm" id="dispNm" class="w300" value="" />
								<button type="button" class="btn" onclick="displayCategoryAddPop();" >검색</button>
							</td>
							<!-- 상품 검색 -->
							<th scope="row"><spring:message code="column.statistics.goods.search" /></th>
							<td>
								<select name="pageGbCd" id="pageGbCd">
									<option value="type01" selected="selected">BOM코드</option>
									<option value="type02">BOM명</option>
									<option value="type03">상품명</option>
								</select>
								<input type="text" name="searchGoodsValue" id="searchGoodsValue" class="w180" value="" />
								<button type="button" class="btn" onclick="addDpaBomList();" >BOM검색</button>
							</td>
						</tr>
					</tbody>
				</table>
		</form>

		<div class="btn_area_center">
			<button type="button" onclick="searchGoodsSalesRankList();" class="btn btn-ok">검색</button>
			<button type="button" onclick="resetForm('goodsSalesRankForm');" class="btn btn-cancel">초기화</button>
		</div>

		<div class="mModule">
			<table id="goodsSalesRankList"></table>
		</div>
	</t:putAttribute>
</t:insertDefinition>