<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				createUserHistGrid();
				
				//엔터키 	
				$(document).on("keydown","#userAuthHistForm input",function(){
	    			if ( window.event.keyCode == 13 ) {
		    			reloadUserAuthHistGrid();
	  		  		}
	            });
			});
			
			// userAuthHistList 그리드
	 		function createUserHistGrid() {
				var options = {
					url : "<spring:url value='/system/userAuthHistGrid.do' />",
					height : 400,
					searchParam : $("#userAuthHistForm").serializeJson(),
					colModels : [
						{name:"rowIndex", label:'<spring:message code="column.no.en" />', width:"80", align:"center", classes:'cursor_default', sortable:false}
						, {name : "histNo",label : "<spring:message code='column.hist_no' />" ,width : "80", key : true, align : "center", hidden:true}
						, _GRID_COLUMNS.sysRegDtm
						, {name : "loginId",label : "<spring:message code='column.usr_id' />" ,width : "150", align : "center"} 
						, {name : "usrNm",label : "<spring:message code='column.usr_nm' />" ,width : "150", align : "center"}
						, {name : "bfrAuthNm",label : "<spring:message code='column.chg_bfr_auth_nm' />",width : "150", align : "center"}
						, {name : "authNm",label : "<spring:message code='column.chg_aft_auth_nm' />",width : "150", align : "center"}
						, {name : "sysRegrNm", label : "<spring:message code='column.sys_regr_nm' />", width : "100", align : "center"}
						],
						loadComplete : function(result) {
							totalCount = result.records;
							$("#searchCnt").text("(" + totalCount + ")");
						}
				};
				grid.create("userAuthHistList", options);
			}
			
			//그리드 검색
			function reloadUserAuthHistGrid() {
				var options = {
						searchParam : $("#userAuthHistForm").serializeJson()
				};
				grid.reload("userAuthHistList", options);
			}
			
			//접근 이력 권한 검색 초기화
			function searchReset() {
				resetForm("userAuthHistForm");
				reloadUserAuthHistGrid();
			}
			
			// 접근 이력 권한 엑셀 다운로드
			function userAuthHistListExcelDownload() {
				var data = $("#userAuthHistForm").serializeJson();
				createFormSubmit("userAuthHistListExcelDownload", "/system/userAuthHistListExcelDownload.do", data);
			}
			
		</script>
	 	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion"
			data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect"
			style="width: 100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding: 10px">
				<form name="userAuthHistForm" id="userAuthHistForm">
					<table class="table_type1">
						<caption>접근 권한 이력</caption>
						<tbody>
							<tr>
								<th><spring:message code="column.usr_nm" /></th>
								<td colspan="3">
									<input type="text" name="usrNm" id="usrNm" />
								</td>
								<th><spring:message code="column.chg_nm" /></th>
								<td colspan="3">
									<input type="text" name="sysRegrNm" id="sysRegrNm" />
								</td>
							</tr>
						</tbody>
					</table>
				</form>

				<div class="btn_area_center">
					<button type="button" onclick="reloadUserAuthHistGrid();" class="btn btn-ok">조회</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>
		
		<div class="mModule">
			검색결과 <span id="searchCnt"></span>
			<table id="userAuthHistList"></table>
			<div id="userAuthHistListPage"></div>
			
			<div class="mButton">
				<div class="rightInner">
					<button type="button" onclick="userAuthHistListExcelDownload();" class="btn btn-add btn-excel"><spring:message code='column.common.btn.excel_download' /></button>
				</div>
			</div>
		</div>
	</t:putAttribute>
</t:insertDefinition>