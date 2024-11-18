<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="title">견적서 목록</t:putAttribute>
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// 견적서 리스트 생성
			createEstimateGrid();
			createEstimateGoodsGrid();
			
			$("#tgNm").keydown(function(event) {
				if(event.keyCode == 13) {
					$('#search').click();
					return false;
				}
			});
			
		});
		

		// 초기화 버튼클릭
		function searchReset () {
			resetForm ("estimateForm");
		}

		function searchEstimate () {
			var options = {
				searchParam : $("#estimateForm").serializeJson()
			};
			$("#estimateGoodsList").jqGrid('clearGridData');
			$("#estmNo").val('' );
			grid.reload("estimateList", options);
		}
		
		// 견적서 리스트
		function createEstimateGrid() {
			var gridOptions = {
				url : "<spring:url value='/order/estimateListGrid.do'/>"
				, datatype : 'local'
				, height : 200
				, searchParam : $("#estimateForm").serializeJson()
				, colModels : [
					{name:"estmNo", label:"<spring:message code='column.estm_no' />", width:"100", align:"center"}
					,{name:"mbrNo", label:"<spring:message code='column.mbr_no' />", width:"100", align:"center"}
					,{name:"mbrNm", label:"<spring:message code='column.mbr_nm' />", width:"100", align:"center"}
					,{name:"estmDt", label:"<spring:message code='column.estm_dt' />", width:"100", align:"center"}
					,{name:"tgNm", label:"<spring:message code='column.tg_nm' />", width:"100", align:"center"}
					,{name:"tel", label:"<spring:message code='column.tel' />", width:"100", align:"center"}
					,{name:"email", label:"<spring:message code='column.email' />", width:"150", align:"center"}
					,{name:"dlvrReqDt", label:"<spring:message code='column.dlvr_req_dt' />", width:"100", align:"center"}
					
				]
				, footerrow : false
				, userDataOnFooter : false
				, gridComplete : function () {
				}
				, onSelectRow : function(ids) {
					var rowdata = $("#estimateList").getRowData(ids);
					$("#estmNo").val(rowdata.estmNo );
					reloadEstimateGoodsGrid(rowdata.estmNo );
				}
			}

			grid.create("estimateList", gridOptions);
		}

		// 검색
		function searchEstimateList() {
			var options = {
				searchParam : $("#estimateForm").serializeJson()
			};

			grid.reload("estimateList", options);
		}
		
		// 견적서 리스트
		function createEstimateGoodsGrid() {
			var gridOptions = {
				url : "<spring:url value='/order/estimateDetailListGrid.do'/>"
				, datatype : 'local'
				, height : 200
				, searchParam : $("#estimateForm").serializeJson()
				, colModels : [
					{name:"estmNo", label:"<spring:message code='column.estm_no' />", width:"100", align:"center"}
					,{name:"goodsId", label:"<spring:message code='column.goods_id' />", width:"100", align:"center", hidden:true}
					,{name:"itemNo", label:"<spring:message code='column.item_no' />", width:"100", align:"center", hidden:true}
					,{name:"goodsNm", label:"<spring:message code='column.goods_nm' />", width:"200", align:"center"}
					,{name:"itemNm", label:"<spring:message code='column.item_nm' />", width:"100", align:"center"}
					,{name:"dlvrClsfNm", label:"<spring:message code='column.dlvr_clsf_nm' />", width:"100", align:"center"}
					,{name:"saleAmt", label:"<spring:message code='column.sale_amt' />", width:"100", align:"center", formatter:'integer', summaryType:"sum"}
					,{name:"qty", label:"<spring:message code='column.qty' />", width:"100", align:"center", formatter:'integer', summaryType:"sum"}
					
				]
				, footerrow : true
				, userDataOnFooter : false
				, gridComplete : function () {

					var saleAmt = $("#estimateGoodsList" ).jqGrid('getCol', 'saleAmt', false, 'sum');
					var qty = $("#estimateGoodsList" ).jqGrid('getCol', 'qty', false, 'sum');
					var asbAmt = $("#estimateGoodsList" ).jqGrid('getCol', 'asbAmt', false, 'sum');
					
					$("#estimateGoodsList" ).jqGrid('footerData', 'set',
							{
								estmNo : '합계 : '
								, saleAmt : saleAmt
								, qty : qty
								, asbAmt : asbAmt
							}
						);
					
				}
				
			}

			grid.create("estimateGoodsList", gridOptions);
		}
		
		function reloadEstimateGoodsGrid (estmNo ) {
			var options = {
					searchParam : {
						estmNo : estmNo
					}
				};
				grid.reload("estimateGoodsList", options);
		}
		
		// 엑셀 다운로드
		function estimateListExcelDownload() {
			createFormSubmit("estimateListExcelDownload", "/order/estimateListExcelDownload.do", $("#estimateForm").serializeJson());
		}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect, gridResizeYn:'N'" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form id="estimateForm" name="estimateForm" method="post" >
				<input type="hidden" name="estmNo" id="estmNo" value="" />
					<table class="table_type1">
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.estm_dt" /></th>
								<td>
									<frame:datepicker startDate="strtDtm" endDate="endDtm" startValue="${adminConstants.COMMON_START_DATE }" />
								</td>
								<!-- Start 날짜 수정 2016-08-10 pkt -->
								<script>
									$(function(){
										$("#strtDtm").val(f_today("Y"));
									});
								</script>
								<th scope="row"><spring:message code="column.tg_nm" /></th>
								<td>
									<input type="text" name="tgNm" id="tgNm" value="" />
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				<div class="btn_area_center">
					<button type="button" onclick="searchEstimateList();" class="btn btn-ok" id="search">검색</button>
					<button type="button" onclick="resetForm('estimateForm');" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>
		<div class="mTitle mt30">
			<h2> 견적서 리스트</h2>
		</div>
		<div class="mModule no_m">
			<table id="estimateList"></table>
		</div>
		
		<div class="mTitle mt30">
			<h2> 견적서 상세 리스트</h2>
		</div>
		<div class="mModule no_m">
			<table id="estimateGoodsList"></table>
		</div>
		
	</t:putAttribute>
</t:insertDefinition>