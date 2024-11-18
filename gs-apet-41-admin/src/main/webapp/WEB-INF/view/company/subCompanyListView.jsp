<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				createCompanyGrid();
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

			// 공급업체 리스트
			function createCompanyGrid(){
				var options = {
					url : "<spring:url value='/company/subCompanyListGrid.do' />"
					, height : 400
					, searchParam : $("#companySearchForm").serializeJson()
					, colModels : [
						{name:"compNo", label:'<b><u><tt><tt><spring:message code="column.comp_no" /></tt></tt></u></b>', width:"60", align:"center", sortable:false, formatter:'integer', classes:'pointer fontbold'}
						, _GRID_COLUMNS.compNm
                        , {name:"compStatCd", label:'<spring:message code="column.comp_stat_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.COMP_STAT}" />"}}
                        , {name:"compGbCd", label:'<spring:message code="column.comp_gb_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.COMP_GB}" />"}}
                        , {name:"compTpCd", label:'<spring:message code="column.comp_tp_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.COMP_TP}" />"}}
                        , {name:"ceoNm", label:'<spring:message code="column.ceo_nm" />', width:"100", align:"center"}
                        , {name:"bizNo", label:'<spring:message code="column.biz_no" />', width:"120", align:"center"}
                        , _GRID_COLUMNS.tel
                        , _GRID_COLUMNS.fax
                        , _GRID_COLUMNS.sysRegrNm
                        , _GRID_COLUMNS.sysRegDtm
                        , _GRID_COLUMNS.sysUpdrNm
                        , _GRID_COLUMNS.sysUpdDtm
					]
					, onSelectRow : function(ids) {
						var rowdata = $("#companyList").getRowData(ids);
						companyView(rowdata.compNo);
					}
				};
				grid.create("companyList", options);
			}

			function reloadCompanyGrid(){
				
				var options = {
					searchParam : $("#companySearchForm").serializeJson()
				};

				grid.reload("companyList", options);
			}

			function companyView(compNo) {
				addTab('하위 업체 상세', '/company/subCompanyView.do?compNo=' + compNo);
			}
			
            function registSubCompany() {
                addTab('하위 업체 등록', '/company/subCompanyInsertView.do');
            }			

			function searchCompany() {
				var options = {
					multiselect : false
					, callBack : function(result) {
						if(result.length > 0) {
							$("#compNo").val(result[0].compNo);
							$("#compNm").val(result[0].compNm);
						}
					}
<c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
                    , showLowerCompany : 'Y'
</c:if>
				}

				companyMgtLayerCompanyList.create(options);
			}

            // 초기화 버튼클릭
            function searchReset () {
                resetForm ("companySearchForm");
                <c:if test="${adminSession.usrGrpCd ne adminConstants.USR_GRP_10}">
                $("#companySearchForm #compNo").val('${adminSession.compNo}');
                </c:if>
            }
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form name="companySearchForm" id="companySearchForm" method="post">
					<c:choose>
					<c:when test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}" >
						<input type="hidden" id="adminYn" name="adminYn" value="Y"/>
						<input type="hidden" id="searchCompanyGb" name="searchCompanyGb" value="SB"/>
					</c:when>
					<c:when test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
					     <input type="hidden" id="upCompNo" name="upCompNo" value="${adminSession.compNo }"/>
					</c:when>
					</c:choose>
					<table class="table_type1">
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.comp_stat_cd" /></th>
								<td>
									<select name="compStatCd" id="compStatCd" title="<spring:message code="column.comp_stat_cd" />">
										<frame:select grpCd="${adminConstants.COMP_STAT}" defaultName="전체"/>
									</select>
								</td>
								<th scope="row"><spring:message code="column.comp_gb_cd" /></th>
								<td>
									<select name="compGbCd" id="compGbCd" title="<spring:message code="column.comp_gb_cd" />">
										<frame:select grpCd="${adminConstants.COMP_GB}" defaultName="전체"/>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.comp_tp_cd" /></th>
								<td>
									<select name="compTpCd" id="compTpCd" title="<spring:message code="column.comp_tp_cd" />">
										<frame:select grpCd="${adminConstants.COMP_TP}" defaultName="전체"/>
									</select>
								</td>
								<th scope="row"><spring:message code="column.comp_nm" /></th>
								<td>
									<frame:compNo funcNm="searchCompany" forceDefaultValue="true" />
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
					<button type="button" onclick="reloadCompanyGrid();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

		<div class="mModule">
			<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}" >
			<button type="button" onclick="registSubCompany();" class="btn btn-add">하위 업체 등록</button>
			</c:if>

			<table id="companyList"></table>
			<div id="companyListPage"></div>
		</div>

	</t:putAttribute>
</t:insertDefinition>