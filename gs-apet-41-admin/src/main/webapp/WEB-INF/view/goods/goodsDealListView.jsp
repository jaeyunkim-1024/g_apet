<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">

<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			createGoodsDealGrid ();
		});

		// Deal 상품 Grid
		function createGoodsDealGrid () {
			var param = $("#goodsDealListForm").serializeJson();
			var gridOptions = {
				url : "<spring:url value='/goods/goodsSetGrid.do' />"
				, height : 400
				, searchParam : param
				, colModels : [
					 _GRID_COLUMNS.goodsId
					, _GRID_COLUMNS.goodsNm
					, {name:"stNms", label:'<spring:message code="column.st_nm" />', width:"200", align:"center", sortable:false } /* 사이트 명 */
					, _GRID_COLUMNS.goodsStatCd
					, {name:"goodsTpCd", label:"<spring:message code='column.goods_tp_cd' />", width:"150", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.GOODS_TP }' showValue='false' />" } } /* 상품 유형 */
					, _GRID_COLUMNS.showYn
					, {name:"mdlNm", label:"<spring:message code='column.mdl_nm' />", width:"200", align:"center", sortable:false } /* 모델명 */
					, {name:"bigo", label:"<spring:message code='column.bigo' />", width:"200", align:"center", sortable:false } /* 비고 */
					, {name:"saleAmt", label:"<spring:message code='column.sale_prc' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
					, {name:"saleStrtDtm", label:"<spring:message code='column.sale_strt_dtm' />", width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"${adminConstants.COMMON_DATE_FORMAT }" }
					, {name:"saleEndDtm", label:"<spring:message code='column.sale_end_dtm' />", width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"${adminConstants.COMMON_DATE_FORMAT }" }
					, _GRID_COLUMNS.sysRegrNm
					, _GRID_COLUMNS.sysRegDtm
				]
				, multiselect : true
				, onCellSelect : function (ids, cellidx, cellvalue) {
					if(cellidx != 0) { // CODE 선택
						var rowdata = $("#goodsDealList").getRowData(ids);
	 					goodsView(rowdata.goodsId);
					}
				}
			}
			grid.create("goodsDealList", gridOptions);
		}
		
		// 사이트 검색
		function searchSt () {
			var options = {
				multiselect : false
				, callBack : searchStCallback
			}
			layerStList.create (options );
		}
		function searchStCallback (stList ) {
			if(stList.length > 0 ) {
				$("#stId").val (stList[0].stId );
				$("#stNm").val (stList[0].stNm );
			}
		}

		// Deal 상품 검색
		function searchGoodsDealList(){
			var options = {
				searchParam : $("#goodsDealListForm").serializeJson()
			};
			grid.reload("goodsDealList", options);
		}
		
		// 초기화 버튼클릭
		function searchReset () {
			resetForm ("goodsDealListForm");
			<c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
			$("#goodsDealListForm #compNo").val('${adminSession.compNo}');
			</c:if>
		}

		// Deal 상품 등록
		function insertGoodsDealView() {
			addTab('Deal 상품 등록', "<spring:url value='/goods/goodsDealView.do' />");
		}

		// 업체 검색
		function searchCompany () {
			var options = {
				multiselect : false
				, callBack : searchCompanyCallback
			}
			layerCompanyList.create (options );
		}
		function searchCompanyCallback (compList ) {
			if(compList.length > 0 ) {
				$("#goodsDealListForm #compNo").val (compList[0].compNo );
				$("#goodsDealListForm #compNm").val (compList[0].compNm );
			}
		}

		// 상품 상세 & 수정
		function goodsView(goodsId){
			addTab('Deal 상품 상세', '/goods/goodsDealView.do?goodsId=' + goodsId);
		}

		// 상품 삭제
		function deleteGoodsDeal(){
			var grid = $("#goodsDealList");
			var goodsNos = new Array();
			var rowids = grid.jqGrid('getGridParam', 'selarrrow');

			if(rowids != null && rowids.length <= 0 ) {
				messager.alert("<spring:message code='column.common.delete.no_select' />", "Info", "info");
				return;
			}

			messager.confirm("<spring:message code='column.common.confirm.delete' />",function(r){
				if(r){
					for(var i in rowids) {
						var data = grid.getRowData(rowids[i]);
						goodsNos.push({goodsId : data.goodsId});
					}
					var options = {
							url : "<spring:url value='/goods/goodsSetDelete.do' />"
							, data :{
								deleteGoodsStr : JSON.stringify(goodsNos)
							}
							, callBack : function(result) {
								messager.alert("<spring:message code='column.common.delete.final_msg' arguments='" + rowids.length + "' />", "Info", "info", function(){
									searchGoodsDealList();
								});
							}
					};
					ajax.call(options);
				}
			});
		}
		function selectBrandSeries (gubun ) {
			var options = null;
			if(gubun == "brand") {
				options = {
					multiselect : false
					, bndGbCd : '${adminConstants.BND_GB_20 }'
					, callBack : searchBrandCallback
				}
			} else {
				options = {
					multiselect : false
					, bndGbCd : '${adminConstants.BND_GB_10 }'
					, callBack : searchSeriesCallback
				}
			}
			layerBrandList.create (options );
		}
		function searchBrandCallback (brandList ) {
			if(brandList != null && brandList.length > 0 ) {
				$("#bndNo").val (brandList[0].bndNo );
				$("#bndNm").val (brandList[0].bndNmKo );
			}
		}
		function searchSeriesCallback (brandList ) {
			if(brandList != null && brandList.length > 0 ) {
				$("#seriesNo").val (brandList[0].bndNo );
				$("#seriesNm").val (brandList[0].bndNmKo );
			}
		}
		// 등록일 변경
		function searchDateChange() {
			var term = $("#checkOptDate").children("option:selected").val();
			if(term == "") {
				$("#sysRegDtmStart").val("");
				$("#sysRegDtmEnd").val("");
			} else {
				setSearchDate(term, "sysRegDtmStart", "sysRegDtmEnd");
			}
		}
	</script>
</t:putAttribute>

<t:putAttribute name="content">
	<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
		<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
			<form id="goodsDealListForm" name="goodsDealListForm" method="post" >
				<table class="table_type1">
					<caption>정보 검색</caption>
					<tbody>
						<tr>
							<th scope="row"><spring:message code="column.sys_reg_dtm" /></th> <!-- 기간 -->
							<td>
								<frame:datepicker startDate="sysRegDtmStart" endDate="sysRegDtmEnd" startValue="${adminConstants.COMMON_START_DATE }" />
								&nbsp;&nbsp;
								<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
									<frame:select grpCd="${adminConstants.SELECT_PERIOD }" defaultName="기간선택" />
								</select>
							</td>
							<th scope="row"><spring:message code="column.st_id" /></th> 
							<!-- 사이트 ID -->
							<td>
								<frame:stId funcNm="searchSt()" />
							</td>	
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.goods_stat_cd" /></th>	<!-- 상품 상태 -->
							<td>
								<select class="w175" id="goodsStatCd" name="goodsStatCd" >
									<frame:select grpCd="${adminConstants.GOODS_STAT }" defaultName="선택" showValue="true" />
								</select>
							</td>
							<th scope="row"><spring:message code="column.goods_tp_cd" /></th>	<!-- 상품 유형 -->
							<td>
								<select id="goodsTpCd" name="goodsTpCd" disabled="disabled">
									<frame:select grpCd="${adminConstants.GOODS_TP }" selectKey="${adminConstants.GOODS_TP_20}" defaultName="선택" showValue="true" />
								</select>
							</td>
						</tr>					
						<tr>
							<th scope="row"><spring:message code="column.goods_id" /></th> <!-- 상품 ID -->
							<td>
								<textarea rows="3" cols="30" id="goodsIdArea" name="goodsIdArea" ></textarea>
							</td>
							<th scope="row"><spring:message code="column.goods_nm" /></th> <!-- 상품 명 -->
							<td>
								<textarea rows="3" cols="30" id="goodsNmArea" name="goodsNmArea" ></textarea>
							</td>
						</tr>
					</tbody>
				</table>
			</form>

			<div class="btn_area_center">
				<button type="button" onclick="searchGoodsDealList();" class="btn btn-ok">검색</button>
				<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
			</div>
		</div>
	</div>

		<div class="mModule">
			<button type="button" onclick="insertGoodsDealView();" class="btn btn-add">등록</button>
			<button type="button" onclick="deleteGoodsDeal();" class="btn btn-add">삭제</button>
			
			<table id="goodsDealList" ></table>
			<div id="goodsDealListPage"></div>
		</div>

	</t:putAttribute>

</t:insertDefinition>