<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="framework.common.constants.CommonConstants" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function() {
				createSplashGrid();
			});

			// 모바일 앱 Splash 그리드
			function createSplashGrid() {
				var options = {
					url : "<spring:url value='/mobileapp/splash/listGrid.do' />"
					, height : 400
					, searchParam : $("#mobileSearchForm").serializeJson()
					, colModels : [
						{name:"splashNo", label:'<spring:message code="column.splashNo" />', width:"110", key: true, align:"center"}
						, {name:"mobileOs", label:'<spring:message code="column.mobileOs" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${CommonConstants.MOBILE_OS_GB}" />"}}
						, {name:"title", label:'<spring:message code="column.ttl" />', width:"250", sortable:false}
						, {name:"linkType", label:'<spring:message code="column.splashType" />', width:"100", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${CommonConstants.APP_SPLASH_TP}" />"}}
						, {name:"link", label:'<spring:message code="column.url" />', width:"400", align:"left", sortable:false}
						, {name:"status", label:'<spring:message code="column.splashStatus" />', width:"100", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${CommonConstants.APP_SPLASH_STATUS}" />"}}
						, _GRID_COLUMNS.sysRegrNm
						, _GRID_COLUMNS.sysRegDtm
						, _GRID_COLUMNS.sysUpdrNm
						, _GRID_COLUMNS.sysUpdDtm
					]
					, multiselect : true
					, onCellSelect : function(id, cellidx, cellvalue) {
						if (cellidx != 0) {
							viewSplash(id);
						}
					}
				};
				grid.create("splashList", options);
			}

			// 모바일 앱 Splash 검색
			function searchSplashGrid() {
				var options = {
					searchParam : $("#mobileSearchForm").serializeJson()
				};

				grid.reload("splashList", options);
			}

			// 모바일 앱 Splash 상세 이동
			function regSplash() {
				addTab('앱 Splash 등록', '/mobileapp/splash/reg.do');
			}
			
			// 모바일 앱 Splash 상세 이동
			function viewSplash(splashNo) {
				addTab('앱 Splash 상세', '/mobileapp/splash/view.do?splashNo=' + splashNo);
			}
			
			// Splash 정보 삭제
			function deleteSplash() {
				var grid = $("#splashList");
				var splashNos = new Array();

				var rowids = grid.jqGrid('getGridParam', 'selarrrow');
				if (rowids.length <= 0) {
					messager.alert("<spring:message code='column.common.delete.no_select' />", "Info", "info");
					return;
				}

				messager.confirm('<spring:message code="column.common.confirm.delete" />', function(r){
					if(r){
						for (var i = rowids.length - 1; i >= 0; i--) {
							splashNos.push(rowids[i]);
						}

						var options = {
							url : "<spring:url value='/mobileapp/splash/delete.do' />"
							, data : {splashNos : splashNos}
							, callBack : function(data) {
								messager.alert("<spring:message code='column.common.delete.final_msg' arguments='" + data.delCnt + "' />", "Info", "info", function(){
									searchSplashGrid();
								});
							}
						};
						ajax.call(options);	
					}
				})
			}
			
	        // 초기화 버튼클릭
	        function searchReset() {
	        	resetForm ("mobileSearchForm");
	        }
	        
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form name="mobileSearchForm" id="mobileSearchForm" method="post">
					<table class="table_type1">
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.mobileOs" /></th>
								<td>
									<frame:radio name="mobileOs" grpCd="${CommonConstants.MOBILE_OS_GB}" defaultName="전체"/>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				
				<div class="btn_area_center">
					<button type="button" onclick="searchSplashGrid();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

		<div class="mModule">
			<button type="button" onclick="regSplash();" class="btn btn-add">Splash 등록</button>
			<button type="button" onclick="deleteSplash();" class="btn btn-add">삭제</button>
				
			<table id="splashList" class="grid"></table>
			<div id="splashListPage"></div>
		</div>

	</t:putAttribute>
</t:insertDefinition>