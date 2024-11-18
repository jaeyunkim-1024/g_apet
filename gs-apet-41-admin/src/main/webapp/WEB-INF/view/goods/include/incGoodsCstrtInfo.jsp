<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
	
	function searchCstrtGoods () {
		var cstrtGoodsOptions = setOptionGoodsListPop(true, false, "", false, false, "", "", "", searchCstrtGoodsCallback);
		layerGoodsList.create (cstrtGoodsOptions);
	}
	
	// 연관 상품
	function createGoodsCstrtList () {
		var goodsId = "${goodsBase.goodsId }";
		var goodsCstrtGbCd = "${adminConstants.GOODS_CSTRT_GB_20 }";
		var options = {
			url : "<spring:url value='/goods/goodsCstrtGrid.do' />"
			, searchParam : {goodsId : goodsId, goodsCstrtGbCd : goodsCstrtGbCd }
			, paging : false
			, cellEdit : true
			, height : 150
			, colModels : [
				{name:"goodsId", label:'', width:"100", align:"center", hidden:true, sortable:false }
				, {name:"goodsCstrtGbCd", label:'', width:"100", align:"center", hidden:true, sortable:false }
				, {name:"cstrtGoodsId", label:'<spring:message code="column.goods_id" />', width:"100", align:"center", key: true, sortable:false }
				, _GRID_COLUMNS.goodsNm
				, _GRID_COLUMNS.goodsStatCd
				, _GRID_COLUMNS.useYn
				, {name:"dispPriorRank", label:'<spring:message code="column.disp_prior_rank" />', width:"120", align:"center", editable:true, sortable:false, formatter:'integer'}
			]
			, multiselect : true
		};
		grid.create("goodsCstrtList", options);
	}
	
	function searchCstrtGoodsCallback (goodsList ) {
		var rowIds = null;
		var check = false;
		if(typeof goodsList !== "undefined" && goodsList.length > 0 ) {
			for(var i = 0; i < goodsList.length; i++ ) {
				// 중복 체크
				rowIds = $("#goodsCstrtList").jqGrid("getDataIDs");
				for(var idx = 0; idx < rowIds.length; idx++) {
					if(rowIds[idx] == goodsList[i].goodsId ) {
						check = true;
					}
				}
				if(!check ) {
					var cstrtGoods = {
						cstrtGoodsId : goodsList[i].goodsId
						, goodsNm : goodsList[i].goodsNm
						, goodsStatCd : goodsList[i].goodsStatCd
						, useYn : '${adminConstants.COMM_YN_Y }'
						, dispPriorRank : 0
						, goodsCstrtGbCd : '${adminConstants.GOODS_CSTRT_GB_20 }'
					}
					$("#goodsCstrtList").jqGrid("addRowData", goodsList[i].goodsId, cstrtGoods, "last", null );
					check = false;
				}
			}
		}
	}
	
</script>
				<div title="관련 상품" data-options="" style="padding:10px">
					<table class="table_type1">
						<caption>GOODS 등록</caption>
						<tbody>
							<tr>
								<th scope="row">관련 상품</th>	<!-- 연관상품 -->
								<td>
									<table>
										<colgroup>
											<col style="width:130px;">
											<col />
										</colgroup>
										<tr>
											<td style="vertical-align: text-top;">
												<div style="padding-bottom: 10px;">
													<button type="button" class="w90 btn" onclick="searchCstrtGoods ();" ><spring:message code="column.common.addition" /></button>
												</div>
												<div style="padding-bottom: 10px;">
													<button type="button" class="w90 btn" onclick="deleteGridRow ('goodsCstrtList');" ><spring:message code="column.common.delete" /></button>
												</div>
											</td>
											<td>
												<div class="mModule no_m">
													<table id="goodsCstrtList" class="grid"></table>
													<div id="goodsCstrtListPage"></div>
												</div>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<hr />