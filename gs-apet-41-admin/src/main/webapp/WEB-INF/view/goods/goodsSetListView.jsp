<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">

<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			createGoodsSetGrid ();
		});

		// Set 상품 Grid
		function createGoodsSetGrid () {
			var param = $("#goodsSetListForm").serializeJson();
			var gridOptions = {
				url : "<spring:url value='/goods/goodsSetGrid.do' />"
				, height : 400
				, searchParam : param
				, colModels : [
					  _GRID_COLUMNS.goodsId
					, _GRID_COLUMNS.goodsNm
					, _GRID_COLUMNS.goodsStatCd
					, {name:"goodsTpCd", label:"<spring:message code='column.goods_tp_cd' />", width:"150", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.GOODS_TP }' showValue='false' />" } } /* 상품 유형 */
					, _GRID_COLUMNS.showYn
					, {name:"mdlNm", label:"<spring:message code='column.mdl_nm' />", width:"200", align:"center", sortable:false } /* 모델명 */
					, {name:"saleAmt", label:"<spring:message code='column.sale_prc' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
					, {name:"bigo", label:"<spring:message code='column.bigo' />", width:"200", align:"center", sortable:false } /* 비고 */
					, _GRID_COLUMNS.compNm
					, {name:"bndNmKo", label:"<spring:message code='column.bnd_nm' />", width:"200", align:"center", sortable:false } /* 브랜드명 */
					, {name:"mmft", label:"<spring:message code='column.mmft' />", width:"200", align:"center", sortable:false } /* 제조사 */
					, {name:"saleStrtDtm", label:"<spring:message code='column.sale_strt_dtm' />", width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"${adminConstants.COMMON_DATE_FORMAT }" }
					, {name:"saleEndDtm", label:"<spring:message code='column.sale_end_dtm' />", width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"${adminConstants.COMMON_DATE_FORMAT }" }
					, _GRID_COLUMNS.sysRegrNm
					, _GRID_COLUMNS.sysRegDtm
				]
				, multiselect : true
				, onCellSelect : function (ids, cellidx, cellvalue) {
					if(cellidx == 1) { // CODE 선택
						var rowdata = $("#goodsSetList").getRowData(ids);
	 					goodsView(rowdata.goodsId);	// 상세, 수정으로
					}
				}
			}
			grid.create("goodsSetList", gridOptions);
		}

		// Set 상품 검색
		function searchGoodsSetList(){
			var options = {
				searchParam : $("#goodsSetListForm").serializeJson()
			};
			grid.reload("goodsSetList", options);
		}

		// 초기화 버튼 클릭
		function searchReset() {
			resetForm ("goodsSetListForm");
		}

		// 세트 상품 등록
		function insertGoodsSetView() {
			addTab('세트 상품 등록', "<spring:url value='/goods/goodsSetView.do' />");
		}

		// 업체명 검색
		function searchCompany(){
			var options = {
				  multiselect : false
				, callBack : function(compList){
					if(compList.length > 0 ) {
						$("#goodsSetListForm #compNo").val (compList[0].compNo);
						$("#goodsSetListForm #compNm").val (compList[0].compNm);
					}
				}
			}
			layerCompanyList.create (options);
		}

		function selectBrandSeries (gubun ) {
			var options = null;
			if(gubun == "brand") {
				options = {
					multiselect : false
					, bndGbCd : '${adminConstants.BND_GB_20 }'
					<c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
					, compNo : '${adminSession.compNo}'
					, compNm : '${adminSession.compNm}'
					</c:if>
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
		
		// 세트 상품 상세 & 수정
		function goodsView(goodsId){
			addTab('세트 상품 상세', '/goods/goodsSetView.do?goodsId='+goodsId);
		}

		// 세트 상품 삭제
		function deleteGoodsSet(){
			var grid = $("#goodsSetList");
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
									searchGoodsSetList();
								});
							}
					};
					ajax.call(options);
				}
			});
		}
	</script>
</t:putAttribute>

<t:putAttribute name="content">

	<form id="goodsSetListForm" name="goodsSetListForm" method="post" >
		<input type="hidden" id="goodsTpCd" name="goodsTpCd" value="${adminConstants.GOODS_TP_02}" />

		<table class="table_type1">
			<caption>정보 검색</caption>
			<tbody>
				<tr>
					<th scope="row"><spring:message code="column.goods_stat_cd" /></th>	<!-- 상품 상태 -->
					<td>
						<select id="goodsStatCd" name="goodsStatCd" >
							<frame:select grpCd="${adminConstants.GOODS_STAT}" defaultName="선택" showValue="true" />
						</select>
					</td>
					<th scope="row"><spring:message code="column.goods.comp_no" /></th> <!-- 업체번호 -->
					<td>
						<frame:compNo funcNm="searchCompany" />
					</td>
				</tr>
				<tr>
					<th scope="row"><spring:message code="column.goods.brnd" /></th><!-- 브랜드/시리즈-->
					<td>
						<input type="hidden" id="bndNo" name="bndNo" title="<spring:message code="column.goods.brnd" />" value="" />
						<input type="text" class="readonly" id="bndNm" name="bndNm" title="<spring:message code="column.goods.brnd" />" value="" />
						<button type="button" class="btn" onclick="selectBrandSeries('brand');" >검색</button>
					</td>
					<th scope="row"><spring:message code="column.goods.series" /></th><!-- 브랜드/시리즈-->
					<td>
						<input type="hidden" id="seriesNo" name="seriesNo" title="<spring:message code="column.goods.series" />" value="" />
						<input type="text" class="readonly" id="seriesNm" name="seriesNm" title="<spring:message code="column.goods.series" />" value="" />
						<button type="button" class="btn" onclick="selectBrandSeries('series');" >검색</button>
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
			<button type="button" onclick="searchGoodsSetList();" class="btn btn-ok">검색</button>
			<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
		</div>

		<div class="mModule">
			<button type="button" onclick="insertGoodsSetView('');" class="btn btn-add">등록</button>
			<button type="button" onclick="deleteGoodsSet();" class="btn btn-add">삭제</button>
				
			<table id="goodsSetList" ></table>
			<div id="goodsSetListPage"></div>
		</div>

	</t:putAttribute>

</t:insertDefinition>