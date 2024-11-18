<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			var bbsId = $("#bbsId").val();
			$(document).ready(function(){
				if(bbsId != ""){
					boardGrid(bbsId);
				}
			
				//엔터키 	
				$(document).on("keydown","#boardListForm input",function(){
	    			if ( window.event.keyCode == 13 ) {
		    			reloadBoardGrid();
	  		  		}
	            });
				
				
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

			// 게시판 리스트
			function boardGrid(bbsId){
				var options = {
					url : "<spring:url value='/system/boardList.do' />"
					, height : 400
					, searchParam : $("#boardListForm").serializeJson()
					, colModels : [
							  {name:"bbsId", label:'<spring:message code="column.bbs_id" />', width:"150", align:"center", classes:'pointer'}
							, {name:"bbsNm", label:'<spring:message code="column.bbs_nm" />', width:"200", align:"center"}
							, {name:"bbsTpCd", label:'<spring:message code="column.bbs_tp_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.BBS_TP}" />"}}
							, {name:"uploadExt", label:'<spring:message code="column.upload_ext" />', width:"200", align:"center", sortable:false}
							, {name:"atchFlCnt", label:'<spring:message code="column.atch_fl_cnt" />', width:"100", align:"center", sortable:false, formatter:'integer'}
							, {name:"gbUseYn", label:'<spring:message code="column.gb_use_yn" />', width:"100", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.GB_USE_YN}" />"}}
							, {name:"scrUseYn", label:'<spring:message code="column.scr_use_yn" />', width:"100", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.SCR_USE_YN}" />"}}
							, {name:"flUseYn", label:'<spring:message code="column.fl_use_yn" />', width:"100", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.FL_USE_YN}" />"}}
							, {name:"stId", label:"<spring:message code='column.st_id' />", width:"110", align:"center", hidden:true} /* 사이트 ID */
							, _GRID_COLUMNS.stNm
							, _GRID_COLUMNS.sysRegrNm
							, _GRID_COLUMNS.sysRegDtm
							, _GRID_COLUMNS.sysUpdrNm
							, _GRID_COLUMNS.sysUpdDtm
							
						]
					, onSelectRow : function(ids) {
						var rowdata = $("#boardGroupList").getRowData(ids);

						//게시판 등록, 상세 조회
						boardView(rowdata.bbsId);
					}
				};
				grid.create("boardGroupList", options);
			}

			// 게시판 리스트 검색 조회
			function reloadBoardGrid(){
				var options = {
					searchParam : $("#boardListForm").serializeJson()
				};
				grid.reload("boardGroupList", options);
			}

			//게시판 상세 화면
			function boardView(bbsId) {
				addTab('게시판 정보 상세', '/system/boardView.do?bbsId=' + bbsId);
			}
			
			//게시판 등록 화면
			function boardReg() {
				addTab('게시판 정보 상세', '/system/boardReg.do');
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
			<!-- 코드 넣는곳 -->
			<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
				<div title="검색" style="padding:10px">
					<form name="boardListForm" id="boardListForm" method="post">
					<input type="hidden" id="stId" name="stId" value="1"/>
					<table class="table_type1">
						<caption>게시판 목록</caption>
						<tbody>
							<tr>
								<th><spring:message code="column.bbs_id" /></th>
								<td>
									<input type="text" name="bbsId" id="bbsId" title="<spring:message code="column.bbs_id" />" value=""/>
								</td>
								<th><spring:message code="column.bbs_nm" /></th>
								<td>
									<input type="text" name="bbsNm" id="bbsNm" title="<spring:message code="column.bbs_nm" />" value=""/>
								</td>
							</tr>
							<%-- <tr>
								<th scope="row"><spring:message code="column.st_id" /></th> <!-- 사이트 ID -->
								<td colspan="3">
									<frame:stId funcNm="searchSt()" />
								</td>
							</tr> --%>
						</tbody>
					</table>
					</form>
				
		
					<div class="btn_area_center">
						<button type="button" onclick="reloadBoardGrid();" class="btn btn-ok">검색</button>
						<button type="button" onclick="resetForm('boardListForm');" class="btn btn-cancel">초기화</button>
					</div>
				</div>
			</div>
			<div class="mModule">
				<button type="button" onclick="boardView('');" class="btn btn-add">게시판 등록</button>
				
				<table id="boardGroupList"></table>
				<div id="boardGroupListPage"></div>
			</div>
	</t:putAttribute>
</t:insertDefinition>
