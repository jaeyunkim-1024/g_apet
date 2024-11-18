<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				createUnmatchedGrid();
				
	            $(document).on("keydown","#unmatchedSearchForm input",function(){
	      			if ( window.event.keyCode == 13 ) {
	      				reloadUnmatchedGrid();
	    		  	}
	            });				
			});
			
			function searchReset() {
				$("#tagNm").val("");
				reloadUnmatchedGrid('del');
			}
			
			// 엑셀 다운로드
			function forbiddenWordListExcelDownload() {
				var data = $("#unmatchedSearchForm").serializeJson();
				createFormSubmit("unmatchedListExcelDownload", "/system/unmatchedListExcelDownload.do", data);
			}
			
			// 금지어 그리드
	 		function createUnmatchedGrid() {
				var options = {
					url : "<spring:url value='/system/createUnmatchedGrid.do' />",
					height : 400,
					sortname : "TAG_NM",
					sortorder : "ASC",
					searchParam : $("#unmatchedSearchForm").serializeJson(),
					multiselect : true, 
					colModels : [
						{name : "tagNo",label : "<spring:message code='column.bnr_no' />" ,width : "80", key : true, align : "center", hidden : true}
						,{ name : "rowIndex" , label : "No" , align : "center" , width : "50"}
						, {name : "tagNm",label : "<spring:message code='column.tag_nm_unmatched' />" ,width : "400", align : "center"}
						, _GRID_COLUMNS.sysRegrNm
						, _GRID_COLUMNS.sysRegDtm
						]
				};
				grid.create("forbiddenWordList", options);
			}
			
	 		// 그리드  검색
			function reloadUnmatchedGrid(check) {
	 			if(check != "del") {
	 				if($("#tagNm").val() == '') {
		 				messager.alert("금지어를 입력해주세요.","Info","info");
						return;
		 			}
	 			}
	 			
				var options = {
					searchParam : $("#unmatchedSearchForm").serializeJson()
				};

				grid.reload("forbiddenWordList", options);
			}
			
	 		function unmatchedInsertView() {
	 			var options = {
						url : '/system/insertUnmatchedViewPop.do'
						, dataType : 'html'
						, callBack : function (data ) {
							var config = {
								id : "insertUnmatchedView"
								, width : 500
								, height : 250
								, top : 200
								, title : "금지어 등록"
								, body : data
								, button : "<button type=\"button\" onclick=\"insertUnmatched();\" class=\"btn btn-ok\">등록</button>"
							}
							layer.create(config);
							$("#insertUnmatchedView_dlg-buttons").find(".btn-cancel").text("취소");
						}
					}
					ajax.call(options );
	 		}
	 		
	 		//금지어 삭제
	 		function deleteUnmatched() {
	 			var grid = $("#forbiddenWordList");
	 			var unmatchedItems = new Array();
	 			
	 			var rowids = grid.jqGrid('getGridParam', 'selarrrow');
	 			if(rowids.length <= 0 ) {
					messager.alert("삭제할 금지어를 선택해주세요.","Info","info");
					return;
				} else {
					for(var i = 0; i < rowids.length; i++) {
						var data = $("#forbiddenWordList").getRowData(rowids[i]);
						
						unmatchedItems.push(data);
					}

					sendData = {
							unmatchedItems : JSON.stringify(unmatchedItems)
	 				};
				}
	 			
	 			var options = {
	 					url : "<spring:url value='/system/deleteUnmatched.do' />",
						data : sendData,
						callBack : function(data) {
							messager.alert("<spring:message code='column.common.delete.final_msg' arguments='" + rowids.length  + "' />","Info","info",function() {
								reloadUnmatchedGrid('del');
							});
						}
					};
					ajax.call(options);
	 			}
		</script>
 	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion"
			data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect"
			style="width: 100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding: 10px">
				<form name="unmatchedSearchForm" id="unmatchedSearchForm">
					<table class="table_type1">
						<caption>금지어 목록</caption>
						<tbody>
							<tr>
								<th><spring:message code="column.bnr_search" /></th>
								<td colspan="3">
									<input type="text" name="tagNm" id="tagNm" placeholder="금지어 입력 "/>
								</td>
							</tr>
						</tbody>
					</table>
				</form>

				<div class="btn_area_center">
					<button type="button" onclick="reloadUnmatchedGrid();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>
		
		<div class="mModule">
			<div class="mButton">
				<div class="rightInner">
					<button type="button" onclick="deleteUnmatched();" class="btn btn-add"><spring:message code='column.common.delete' /></button>
					<button type="button" onclick="unmatchedInsertView();" class="btn btn-add">등록</button>
				</div>
			</div>

			<table id="forbiddenWordList"></table>
			<div id="forbiddenWordListPage"></div>
			
			<div class="mButton">
				<div class="rightInner">
					<button type="button" onclick="forbiddenWordListExcelDownload();" class="btn btn-add btn-excel"><spring:message code='column.common.btn.excel_download' /></button>
				</div>
			</div>
		</div>
	</t:putAttribute>
</t:insertDefinition>