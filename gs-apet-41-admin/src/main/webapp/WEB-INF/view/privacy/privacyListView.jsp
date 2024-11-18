<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function() {

			createPrivacyGrid ();
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

		function searchPrivacyList () {
			var options = {
				searchParam : $("#privacyListForm").serializeJson()
			};
			grid.reload("privacyList", options);
		}

		function searchReset () {
			resetForm ("privacyListForm" );
		}

		// 개인정보처리방침 등록
		function registPrivacy () {
			addTab('개인정보방침 등록', '/privacy/privacyInsertView.do');
		}

		// 개인정보처리방침 삭제
		/* function deletePrivacy () {
			var grid = $("#privacyList");
			var bndNos = new Array();

			var rowids = grid.jqGrid('getGridParam', 'selarrrow');
			if(rowids.length <= 0 ) {
				messager.alert('<spring:message code="column.common.delete.no_select" />', "Info", "info");
				return;
			}

			messager.confirm("<spring:message code='column.common.confirm.delete' />", function(r){
				if(r){
					for (var i = rowids.length - 1; i >= 0; i--) {
						bndNos.push (rowids[i] );
					}

					console.debug (bndNos );
					var options = {
						url : "<spring:url value='/st/stDelete.do' />"
						, data : {bndNos : bndNos }
						, callBack : function(data ) {
							messager.alert("<spring:message code='column.common.delete.final_msg' arguments='" + data.delCnt + "' />", "Info", "info", function(){
								searchPrivacyList ();	
							});
						}
					};
					ajax.call(options);
				}
			})

		} */

		function createPrivacyGrid () {
			// privacyList
			var gridOptions = {
				url : "<spring:url value='/privacy/privacyPolicyGrid.do' />"
				, height : 400
				, searchParam : $("#privacyListForm").serializeJson()
				, colModels : [
					{name:"policyNo", label:"<spring:message code='column.policy_no' />", width:"120", key: true, align:"center"} /* 처리 방침 번호 */
					, {name:"verInfo", label:"<b><u><tt><spring:message code='column.version_info' /></tt></u></b>", width:"200", align:"center", sortable:false , classes:'pointer fontbold'} /* 버전 정보 */
					, _GRID_COLUMNS.useYn
					, _GRID_COLUMNS.stId
					, _GRID_COLUMNS.stNm
					, _GRID_COLUMNS.sysRegrNm
					, _GRID_COLUMNS.sysRegDtm
					, _GRID_COLUMNS.sysUpdrNm
					, _GRID_COLUMNS.sysUpdDtm
					]
				, onSelectRow : function(ids) {
					var rowdata = $("#privacyList").getRowData(ids);
					viewPrivacyDetail(rowdata.policyNo);
				}
			}
			grid.create("privacyList", gridOptions);
		}

		// 사이트 상세
		function viewPrivacyDetail (policyNo ) {
			addTab('개인정보방침 상세', '/privacy/privacyDetailView.do?policyNo=' + policyNo);
		}

		</script>
	</t:putAttribute>
	<t:putAttribute name="content">

		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form id="privacyListForm" name="privacyListForm" method="post" >
					<table class="table_type1">
						<caption>개인정보처리 목록</caption>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.policy_no" /></th> <!-- 처리방침 번호 -->
								<td>
									<textarea rows="3" cols="30" id="policyNoArea" name="policyNoArea" ></textarea>
								</td>
								<th scope="row"><spring:message code="column.version_info" /></th> <!-- 버전 정보 -->
								<td>
									<textarea rows="3" cols="30" id="versionInfoArea" name="versionInfoArea" ></textarea>
								</td>
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.st_id" /></th> <!-- 사이트 ID -->
								<td colspan="3">
		                            <select id="stIdCombo" name="stId">
		                                <frame:stIdStSelect defaultName="사이트선택" />
		                            </select>
								</td>
							</tr>
						</tbody>
					</table>
				</form>

				<div class="btn_area_center">
					<button type="button" onclick="searchPrivacyList();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

				<div class="mModule">
					<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}" >
						<button type="button" onclick="registPrivacy();" class="btn btn-add">개인정보처리방침 등록</button>
					</c:if>
					
					<table id="privacyList" class="grid"></table>
					<div id="privacyListPage"></div>
				</div>

	</t:putAttribute>

</t:insertDefinition>