<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function() {
			createGoodsGrid ();
		});
		
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

		// 상품 상세
		function viewGoodsDetail (goodsId, goodsTpCd ) {
			var url = "<spring:url value='/goods/goodsDetailView.do' />";
			var data = {
				goodsId : goodsId
			}
			var url = "/goods/goodsDetailView.do?goodsId=" + goodsId;
			var title = "상품 상세 - " + goodsId;
			
			if (goodsTpCd == "${adminConstants.GOODS_TP_10 }" ) {
				url = "/goods/goodsDetailView.do?goodsId=" + goodsId;
				title = "상품 상세 - " + goodsId;
			} else  if (goodsTpCd == "${adminConstants.GOODS_TP_20 }" ) {	// DEAL
				url = "/goods/goodsDealView.do?goodsId=" + goodsId;
				title = "Deal 상품 상세";
			} else  if (goodsTpCd == "${adminConstants.GOODS_TP_30 }" ) {	// GIFT
				url = "/goods/giftGoodsDetailView.do?goodsId=" + goodsId;
				title = "사은품 상세";
			}
			
			addTab(title, url);
		}

		// 상품 Grid
		function createGoodsGrid () {
			var gridOptions = {
				url : "<spring:url value='/goods/saleGoodsBaseGrid.do' />"
				, height : 400
				, searchParam : $("#goodsListForm").serializeJson()
				, colModels : [
					 _GRID_COLUMNS.goodsId
					, _GRID_COLUMNS.bndNmKo
					, _GRID_COLUMNS.goodsNm_b
					//, {name:"stNms", label:'<spring:message code="column.st_nm" />', width:"120", align:"center", sortable:false } /* 사이트 명 */
					, _GRID_COLUMNS.goodsStatCd
					, {name:"goodsTpCd", label:"<spring:message code='column.goods_tp_cd' />", width:"60", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.GOODS_TP }' showValue='false' />" } } /* 상품 유형 */
					, _GRID_COLUMNS.showYn
	                , {name:"mdlNm", label:"<spring:message code='column.mdl_nm' />", width:"100", align:"center", sortable:false } /* 모델명 */
					, {name:"saleAmt", label:"<spring:message code='column.sale_prc' />", width:"80", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
					, _GRID_COLUMNS.compNm
					, {name:"saleStrtDtm", label:"<spring:message code='column.sale_sale_strt_dtm' />", width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"${adminConstants.COMMON_DATE_FORMAT }" }
					, {name:"saleEndDtm", label:"<spring:message code='column.sale_sale_end_dtm' />", width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"${adminConstants.COMMON_DATE_FORMAT }" }
					, {name:"mmft", label:"<spring:message code='column.mmft' />", width:"120", align:"center", sortable:false } /* 제조사 */
					, _GRID_COLUMNS.sysRegrNm
					, _GRID_COLUMNS.sysRegDtm
					, _GRID_COLUMNS.sysUpdrNm
					, _GRID_COLUMNS.sysUpdDtm
				]
				, multiselect : true
				, onCellSelect : function (id, cellidx, cellvalue) {
					if(cellidx == 3) {
						var goodsTpCd = $("#goodsList").jqGrid ('getCell', id, 'goodsTpCd');
						viewGoodsDetail(id, goodsTpCd );
					}
				}
			}
			grid.create("goodsList", gridOptions);
		}

		// 상품 검색 조회
		function searchGoodsList () {
			var options = {
				searchParam : $("#goodsListForm").serializeJson()
			};
			grid.reload("goodsList", options);
		}

		// 초기화 버튼클릭
		function searchReset () {
			resetForm ("goodsListForm");
		}

		// 상품 가격 일괄 변경 할 거 체크되어 있는지 확인
		function batchUpdateGoodsSalePrice () {
			var grid = $("#goodsList");

			var rowids = grid.jqGrid('getGridParam', 'selarrrow');
			if(rowids.length <= 0 ) {
				messager.alert("<spring:message code='column.common.update.no_select' />", "Info", "info");
				return;
			}

			updateGoodsSalePriceProc ();
		}
		
		function updateGoodsSalePriceProc() {
			var saleUpdateEndDate = $("#saleUpdateEndDate").val();
			if(saleUpdateEndDate == ''){
				messager.alert("<spring:message code='column.common.no_sale_updateEndDate' />", "Info", "info");
				return;
			}
			messager.confirm("<spring:message code='column.common.confirm.batch_update' />",function(r){
				if(r){
					var goodsIds = new Array();
					var grid = $("#goodsList");
					
					var selectedIDs = grid.getGridParam ("selarrrow");
					for (var i = 0; i < selectedIDs.length; i++) {
						goodsIds.push (selectedIDs[i] );
					}
		
					var sendData = {
						goodsIds : goodsIds
						, saleUpdateEndDate : saleUpdateEndDate
					};
					console.debug (sendData );
					var options = {
						url : "<spring:url value='/goods/goodsSalePriceBatchUpdate.do' />"
						, data : sendData
						, callBack : function(data ) {
							//alert("<spring:message code='column.common.edit.final_msg' />");
							messager.alert("<spring:message code='column.goods.price.batch_edit.final_msg' arguments='"+data.goodsBaseSO.cntTotal+","+data.goodsBaseSO.cntSuccess+","+data.goodsBaseSO.cntFail+"' />", "Info", "info", function(){
								searchGoodsList ();
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

		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">

				<form id="goodsListForm" name="goodsListForm" method="post" >
					<input type="hidden" name="goodsAmtTpCd" id="goodsAmtTpCd" value="${adminConstants.GOODS_AMT_TP_20 }" />
	
					<table class="table_type1">
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.st_id" /></th> <!-- 사이트 ID -->
								<td colspan="3">
		                            <select id="stIdCombo" name="stId">
		                                <frame:stIdStSelect defaultName="사이트선택" />
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
					<button type="button" onclick="searchGoodsList();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>		

		<div class="mModule">
			<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}" >
			<div class="leftInner">
				<frame:datepicker startDate="saleUpdateEndDate" />
				<button type="button" onclick="batchUpdateGoodsSalePrice();" class="btn btn-add ml5" style="margin-bottom:0">세일 종료 일자 일괄 변경</button>
			</div>
			</c:if>

			<table id="goodsList" ></table>
			<div id="goodsListPage"></div>
		</div>

	</t:putAttribute>

</t:insertDefinition>