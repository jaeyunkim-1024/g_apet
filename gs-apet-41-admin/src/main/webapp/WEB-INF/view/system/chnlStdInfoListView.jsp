<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				createChnlStdInfoGrid();

				$(document).on("keydown","#chnlStdInfoSearchForm table tbody tr td input[type='text']",function(e){
					if(e.keyCode == 13){
						reloadChnlStdInfoGrid();
					}
				});

				$(document).on("input paste change","#chnlId",function(){
					var inputVal = $(this).val().replace(/\D/gi,'');
					$(this).val(inputVal);
				})
			});
			
			function createChnlStdInfoGrid(){
				var options = {
					url : "<spring:url value='/system/chnlStdInfoListGrid.do' />"
					, height : 400
					, searchParam : $("#chnlStdInfoSearchForm").serializeJson()
					, colModels : [
						{name:"chnlId", label:'<spring:message code="column.chnl_id" />', width:"100", align:"center", formatter:'integer'} /* 채널 ID */
						, {name:"chnlNm", label:'<b><u><tt><spring:message code="column.chnl_nm" /></tt></u></b>', width:"200", align:"center", classes:'pointer fontbold'} /* 채널 명 */
						, {name:"chnlSht", label:'<spring:message code="column.chnl_sht" />', width:"100", align:"center"} /* 채널 약어 */
						, {name:"chnlGbCd", label:'<spring:message code="column.chnl_gb_cd" />', width:"100", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.CHNL_GB }' showValue='false' />" } } /* 채널 구분 코드 */
						, {name:"cclTgYn", label:'<spring:message code="column.ccl_tg_yn" />', width:"100", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMM_YN }' showValue='false' />" } } /* 정산 대상 여부 */
						, {name:"taxIvcIssueYn", label:'<spring:message code="column.tax_ivc_issue_yn" />', width:"110", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMM_YN }' showValue='false' />" } } /* 세금 계산서 발행 여부 */
						, _GRID_COLUMNS.sysRegrNm
						, _GRID_COLUMNS.sysRegDtm
						, _GRID_COLUMNS.sysUpdrNm
						, _GRID_COLUMNS.sysUpdDtm
					]
					, onSelectRow : function(ids) {
						var rowdata = $("#chnlStdInfoList").getRowData(ids);
						chnlStdInfoView(rowdata.chnlId);
					}
				};
				grid.create("chnlStdInfoList", options);
			}

			function reloadChnlStdInfoGrid(){
				var options = {
					searchParam : $("#chnlStdInfoSearchForm").serializeJson()
				};

				grid.reload("chnlStdInfoList", options);
			}

			function chnlStdInfoView(chnlId) {
				if (chnlId == '')
					addTab('채널 등록', '/system/chnlStdInfoView.do');
				else
					addTab('채널 상세', '/system/chnlStdInfoView.do?chnlId=' + chnlId);
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form name="chnlStdInfoSearchForm" id="chnlStdInfoSearchForm">
					<table class="table_type1">
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.chnl_id" /></th>
								<td>
									<input type="text" name="chnlId" id="chnlId" title="<spring:message code="column.chnl_id" />" >
								</td>
								<th scope="row"><spring:message code="column.chnl_nm" /></th>
								<td>
									<input type="text" name="chnlNm" id="chnlNm" title="<spring:message code="column.chnl_nm" />" >
								</td>
							</tr>
						</tbody>
					</table>
				</form>

				<div class="btn_area_center">
					<button type="button" onclick="reloadChnlStdInfoGrid();" class="btn btn-ok">검색</button>
					<button type="button" onclick="resetForm('chnlStdInfoSearchForm');" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

		<div class="mModule">
			<button type="button" onclick="chnlStdInfoView('');" class="btn btn-add">채널 등록</button>
			
			<table id="chnlStdInfoList" class="grid"></table>
			<div id="chnlStdInfoListPage"></div>
		</div>

	</t:putAttribute>
</t:insertDefinition>
