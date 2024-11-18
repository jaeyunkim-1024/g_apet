<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">
			$(document).ready(function(){
				createExcelGrid();
			});

			// 기획전 상품 엑셀 파일 선택
			function resultXlsUpload(file) {
				loadExcelList(file);
			}

			// 기획전 상품 엑셀 파일 리스트
			function loadExcelList(file) {
				var columnNames = $("#displayGoodsUploadList").jqGrid('getGridParam', 'colModel');

				var cols = new Array();

				// resultMessage, successYn 제외
				for(var i = 2; i < columnNames.length; i++) {
					cols.push(columnNames[i].name);
				}

				var options = {
					searchParam : {
						  filePath : file.filePath
						, fileName : file.fileName
						, colName : cols + '' // JSON.stringify( )
					},
				};

				grid.reload("displayGoodsUploadList", options);
			}

			// 기획전 상품 업로드 그리드 리스트
			function createExcelGrid() {
				$.jgrid.gridUnload("#displayGoodsUploadList");

				var columns = new Array();

				columns.push({name :'successYn', label :'successYn', width :'100', align :'center', sortable : false });
				columns.push({name :'resultMessage', label :'resultMessage', width :'200', align :'center', sortable : false });
				columns.push({name :'dispClsfNo', label :'<spring:message code="column.disp_clsf_no" />', width :'100', align :'center', sortable : false });
				columns.push({name :'dispPriorRank', label :'<spring:message code="column.display_view.disp_prior_rank" />', width :'100', align :'center', sortable : false });
				columns.push({name :'goodsId', label :'<spring:message code="column.goods_id" />', width :'200', align :'center', sortable : false });

				var gridOptions = {
					url : "<spring:url value='/display/displayGoodsUploadGrid.do'/>"
					, paging : false
					, height : 400
					, searchParam : {
						  filePath : ''
						, fileName : ''
						, colName : ''
					}
					, colModels : columns
					, multiselect : false
					, gridComplete : function() {
						var rowIds = $("#displayGoodsUploadList").jqGrid("getDataIDs");
						for(var idx = 0; idx < rowIds.length; idx++) {
							var data = jQuery("#displayGoodsUploadList").getRowData(rowIds[idx]);

							if(data.successYn == "${adminConstants.COMM_YN_N}") {
								$("#displayGoodsUploadList").jqGrid('setCell', rowIds[idx], "successYn", "", {color:'red'});
							}
						}
					}
				}

				grid.create("displayGoodsUploadList", gridOptions);
			}

			// 기획전 상품 업로드
			function displayGoodsUpload() {
				var sendData = null;
				var displayGoodsUploadList = grid.jsonData("displayGoodsUploadList");

				for(var i = 0; i < displayGoodsUploadList.length; i++ ) {
					if(displayGoodsUploadList[i].successYn == "${adminConstants.COMM_YN_N}") {
						messager.alert("<spring:message code='admin.web.view.msg.display.goodsupload' />","Info","info");
						return;
					}
				}

				sendData = {
					dipslayGoodsUploadPOList : JSON.stringify(displayGoodsUploadList)
				}

				messager.confirm("<spring:message code='column.common.confirm.insert'/>",function(r){
					if(r){
						var options = {
								url : "<spring:url value='/display/displayGoodsUpload.do'/>"
								, data : sendData
								, callBack : function(data) {
									messager.alert("<spring:message code='column.common.regist.final_msg'/>","Info","info",function(){
										opener['reloadDisplayGoodsGrid']($("#displayGoodsUploadPopForm #dispClsfNo").val());
										popupClose();
									});
								}
							};

							ajax.call(options);				
					}
				});
			}
		</script>
			<form name="displayGoodsUploadPopForm" id="displayGoodsUploadPopForm">
				<input type="hidden" name="dispClsfNo" id="dispClsfNo" value="${displayGoods.dispClsfNo}">
			</form>
			<div class="mModule">
				<button type="button" class="btn btn-add" onclick="fileUpload.xls(resultXlsUpload);">파일선택</button>
				
				<table id="displayGoodsUploadList" ></table>
				<div id="displayGoodsUploadListPage"></div>
			</div>

