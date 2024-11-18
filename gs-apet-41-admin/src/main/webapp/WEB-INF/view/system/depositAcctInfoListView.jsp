<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				createDepositAcctInfoGrid();
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

			// 그룹 코드 리스트
			function createDepositAcctInfoGrid(){
				var options = {
					url : "<spring:url value='/system/depositAcctInfoListGrid.do' />"
					, height : 400
					, searchParam : $("#depositAcctInfoSearchForm").serializeJson()
					, colModels : [
						  {name:"acctInfoNo", label:'<b><u><tt><spring:message code="column.acctInfoNo" /></tt></u></b>', width:"120", align:"center", formatter:'integer', classes:'pointer fontbold'}
						, {name:"stNm", label:'<spring:message code="column.st_nm" />', width:"150", align:"center", sortable:false}
						, {name:"bankCd", label:'<spring:message code="column.bank_cd" />', width:"120", align:"center" , formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.BANK}" />"}}
						, {name:"acctNo", label:'<b><u><tt><spring:message code="column.acct_no" /></tt></u></b>', width:"150", align:"center", classes:'pointer fontbold'}
						, {name:"ooaNm", label:'<spring:message code="column.ooa_nm" />', width:"150", align:"center"}
						, {name:"dispPriorRank", label:'<spring:message code="column.disp_prior_rank" />', width:"120", align:"center"}
						, {name:"sysRegrNm", label:'<spring:message code="column.sys_regr_nm" />', width:"100", align:"center"}
						, {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"sysUpdrNm", label:'<spring:message code="column.sys_updr_nm" />', width:"100", align:"center"}
						, {name:"sysUpdDtm", label:'<spring:message code="column.sys_upd_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
					]
					, onSelectRow : function(ids) {
						var rowdata = $("#depositAcctInfoList").getRowData(ids);
						depositAcctInfoView(rowdata.acctInfoNo);
					}
				};
				grid.create("depositAcctInfoList", options);
			}

			function reloadDepositAcctInfoGrid(){
				var options = {
					searchParam : $("#depositAcctInfoSearchForm").serializeJson()
				};

				grid.reload("depositAcctInfoList", options);
			}

			function depositAcctInfoView(acctInfoNo) {
				if (acctInfoNo == '')
					addTab('무통장 계좌 등록', '/system/depositAcctInfoView.do');
				else
					addTab('무통장 계좌 상세', '/system/depositAcctInfoView.do?acctInfoNo=' + acctInfoNo);
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
	
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">	
				<form name="depositAcctInfoSearchForm" id="depositAcctInfoSearchForm">
					<table class="table_type1">
						<caption>무통장 계좌 목록</caption>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.st_id" /></th> <!-- 사이트 ID -->
								<td>
									<frame:stId funcNm="searchSt()" />
								</td>
								<th scope="row"><spring:message code="column.bank_cd" /></th>
								<td>
									<select name="bankCd" id="bankCd" title="<spring:message code="column.bank_cd" />">
										<frame:select grpCd="${adminConstants.BANK}" defaultName="전체"/>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.acct_no" /></th>
								<td>
									<input type="text" class="w200"  name="acctNo" id="acctNo" title="<spring:message code="column.acct_no" />" >
								</td>
								 	
								<th scope="row"><spring:message code="column.ooa_nm" /></th>
								<td>
									<input type="text" class="w200"  name="ooaNm" id="ooaNm" title="<spring:message code="column.ooa_nm" />" >
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				<div class="btn_area_center">
					<button type="button" onclick="reloadDepositAcctInfoGrid();" class="btn btn-ok">검색</button>
					<button type="button" onclick="resetForm('depositAcctInfoSearchForm');" class="btn btb-cancel">초기화</button>
				</div>
			</div>
		</div>	
		
		<div class="mModule">
			<button type="button" onclick="depositAcctInfoView('');" class="btn btn-add">무통장 계좌 등록</button>
			<table id="depositAcctInfoList" class="grid"></table>
			<div id="depositAcctInfoListPage"></div>
		</div>

	</t:putAttribute>
</t:insertDefinition>
