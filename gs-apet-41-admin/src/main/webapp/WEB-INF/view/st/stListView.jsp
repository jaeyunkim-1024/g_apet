<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function() {

				createStGrid ();

				//엔터 키 이벤트
				$(document).on("keydown","#stListForm input[type='text']",function(e) {
					if (e.keyCode == 13) {
						searchStList();
					}
				})
			});

			// 업체 검색
			function searchCompany () {
				var options = {
					multiselect : false
					, callBack : searchCompanyCallback
				}
				layerCompanyList.create (options );
			}
			function searchCompanyCallback (compList ) {
				if(compList.length > 0 ) {
					$("#stListForm #compNo").val (compList[0].compNo );
					$("#stListForm #compNm").val (compList[0].compNm );
				}
			}

			function searchStList() {
				var options = {
					searchParam : $("#stListForm").serializeJson()
				};
				grid.reload("stList", options);
			}

			function searchReset () {
				resetForm ("stListForm");
				searchStList();
			}

			// 사이트 등록
			function registSt () {
				addTab('사이트 등록', '/st/stInsertView.do');
			}

			// 사이트 삭제
			/* function deleteSt () {
                var grid = $("#stList");
                var bndNos = new Array();

                var rowids = grid.jqGrid('getGridParam', 'selarrrow');
                if(rowids.length <= 0 ) {
                    messager.alert("<spring:message code='column.common.delete.no_select' />", "Info", "info");
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
								searchStList ();
							});
						}
					};
					ajax.call(options);
				}
			})
		} */

			function createStGrid () {
				// stList
				var gridOptions = {
					url : "<spring:url value='/st/stStdInfoGrid.do' />"
					, height : 400
					, searchParam : $("#stListForm").serializeJson()
					, colModels : [
							{name:"stId", label:"<spring:message code='column.st_id' />", width:"110", key: true, align:"center"} /* 사이트 ID */
						, 	{name:"stNm", label:"<b><u><tt><spring:message code='column.st_nm' /></tt></u></b>", width:"150", align:"center", sortable:false, classes:'pointer fontbold' } /* 사이트 명 */
						, 	{name:"stUrl", label:"<spring:message code='column.st_url' />", width:"250", align:"center", sortable:false } /* 사이트 URL */
						, 	{name:"stMoUrl", label:"<spring:message code='column.st_mo_url' />", width:"250", align:"center", sortable:false } /* 사이트 URL */
						, 	{name:"dlgtEmail", label:"<spring:message code='column.dlgt_email' />", width:"200", align:"center", sortable:false } /* 대표 이메일 */
						, _GRID_COLUMNS.useYn
						, _GRID_COLUMNS.compNm
						//, {name:"compStatCd", label:"<spring:message code='column.comp_stat_cd' />", width:"100", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMP_STAT }' showValue='false' />" } } /* 업체 상태 */
						, {name:"csTelNo", label:"<spring:message code="column.cs_tel_no" />", width:"120", align:"center", sortable:false}
						, _GRID_COLUMNS.sysRegrNm
						, _GRID_COLUMNS.sysRegDtm
						, _GRID_COLUMNS.sysUpdrNm
						, _GRID_COLUMNS.sysUpdDtm
					]
					, multiselect : false
					, onSelectRow : function(ids) {
						var rowdata = $("#stList").getRowData(ids);
						viewStDetail(rowdata.stId);
					}
					/*, onCellSelect : function (id, cellidx, cellvalue) {
                        if(cellidx == 1) {
                            viewStDetail(id );
                        }
                    }*/
				}
				grid.create("stList", gridOptions);
			}

			// 사이트 상세
			function viewStDetail (stId ) {
				addTab('사이트 상세', '/st/stDetailView.do?stId=' + stId);
			}

		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form id="stListForm" name="stListForm" method="post" >
					<table class="table_type1">
						<caption>사이트 목록</caption>
						<tbody>
						<tr>
							<th scope="row">관리 <spring:message code="column.goods.comp_nm" /></th> <!-- 업체번호 -->
							<td>
								<frame:compNo funcNm="searchCompany" />
							</td>
							<th scope="row"><spring:message code="column.comp_stat_cd" /></th>
							<td>
								<select name="compStatCd" id="compStatCd" title="<spring:message code="column.comp_stat_cd" />">
									<frame:select grpCd="${adminConstants.COMP_STAT}" defaultName="전체"/>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.st_id" /></th> <!-- 사이트 ID -->
							<td>
								<input type="text" class="w200" name="stId" id="stId" />
									<%--<textarea rows="3" cols="30" id="stIdArea" name="stIdArea" ></textarea>--%>
							</td>
							<th scope="row"><spring:message code="column.st_nm" /></th> <!-- 사이트 명 -->
							<td>
								<input type="text" class="w200" name="stNm" id="stNm" />
							</td>
						</tr>
						</tbody>
					</table>
				</form>
				<div class="btn_area_center">
					<button type="button" onclick="searchStList();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>
		<div class="mModule">
			<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}" >
				<button type="button" onclick="registSt();" class="btn btn-add">사이트 등록</button>
				<!-- <button type="button" onclick="deleteSt();" class="btn btn-add">삭제</button> -->
			</c:if>
			<table id="stList"></table>
			<div id="stListPage"></div>
		</div>
	</t:putAttribute>
</t:insertDefinition>