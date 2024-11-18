<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				policyListGrid();

      			
	            $(document).on("keydown","#policySearchForm input",function(){
	      			if ( window.event.keyCode == 13 ) {
	      				reloadPolicyListGrid();
	    		  	}
	            });		
			});

			function policyListGrid(){
				var options = {
					url : "<spring:url value='/company/policyListGrid.do' />"
					, height : 400
					, colModels : [
						//업체 정책 번호
						{name:"compPlcNo", label:'<b><u><tt><spring:message code="column.comp_plc_no" /></tt></u></b>', width:"125", align:"center", classes:'pointer fontbold', sortable:false}
						, _GRID_COLUMNS.compNo
						, _GRID_COLUMNS.compNm
						  //업체 상태코드
                        , {name:"compStatCd", label:'<spring:message code="column.comp_stat_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.COMP_STAT}" />"}, sortable:false}

						//업체 정책 구분 코드
						, {name:"compPlcGbCd", label:'<spring:message code="column.comp_plc_gb_cd" />', width:"200", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.COMP_PLC_GB}" />"}, sortable:false}

						//전시 여부
						//, {name:"dispYn", label:'<spring:message code="column.disp_yn" />', width:"100", align:"center"}

						//정렬 순서
						//, {name:"sortSeq", label:'<spring:message code="column.sort_seq" />', width:"100", align:"center", formatter:'integer'}
						, _GRID_COLUMNS.sysRegrNm
						, _GRID_COLUMNS.sysRegDtm
						, _GRID_COLUMNS.sysUpdrNm
						, _GRID_COLUMNS.sysUpdDtm
					]
					, searchParam : $("#policySearchForm").serializeJson()
					, multiselect:'${adminSession.usrGrpCd}'!='10'? false:true
					, onCellSelect : function (ids, cellidx, cellvalue) {
						var rowdata = $("#policyList").getRowData(ids);
						if(cellidx != 0) {
							policyView(rowdata.compPlcNo);
						}else if(cellidx == 0 && '${adminSession.usrGrpCd}' == '20'){
							policyView(rowdata.compPlcNo);
						}
					}
					, gridComplete : function() {
						var gridRow =  $("#policyList").jqGrid('getRowData');
						if('${adminSession.usrGrpCd}' != '20'){
							$("#insertBtn").css("display","block");
						}else{
							if(gridRow.length == 0 && '${adminSession.usrGrpCd}' == '20') {
								$("#insertBtn").css("display","block");
							}	
						}
					}
				};
				grid.create("policyList", options);
			}

			function reloadPolicyListGrid() {
				var options = {
					searchParam : $("#policySearchForm").serializeJson()
				};
				grid.reload("policyList", options);
			}

			function policyView(compPlcNo) {
				if (compPlcNo == '')
					addTab('업체 정책 등록', '/company/policyView.do');
				else
					addTab('업체 정책 상세', '/company/policyView.do?compPlcNo=' + compPlcNo);
			}

			function policyDelete(){
				var grid = $("#policyList");
				var arrCompPlcNo = new Array();
				var rowids = grid.jqGrid('getGridParam', 'selarrrow');

				if(rowids != null && rowids.length <= 0 ) {
					messager.alert("<spring:message code='column.common.delete.no_select' />", "Info", "info");
					return;
				}

				messager.confirm('<spring:message code="column.common.confirm.delete" />', function(r){
	                if (r){
	                	for(var i in rowids) {
							var data = grid.getRowData(rowids[i]);
							arrCompPlcNo.push(data.compPlcNo);
						}

						var options = {
							url : "<spring:url value='/company/policyListDelete.do' />"
							, data : {
								arrCompPlcNo : arrCompPlcNo
							}
							, callBack : function(result) {
								messager.alert("<spring:message code='column.common.delete.final_msg' arguments='" + rowids.length + "' />", "Info", "info", function(){
									reloadPolicyListGrid();
								});
							}
						};
						ajax.call(options);
	                }
            	});
			}

			// 업체 검색
			function searchCompany() {
				var options = {
					multiselect : false
					, callBack : function(result) {
						if(result.length > 0) {
							$("#compNo").val(result[0].compNo);
							$("#compNm").val(result[0].compNm);
						}
					}
// <c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
//                     , showLowerCompany : 'Y'
// </c:if>
				}

				layerCompanyList.create(options);
			}
			
            // 하위 업체 검색
            function searchLowCompany () {
                var options = {
                    multiselect : false
                    , callBack : searchLowCompanyCallback
// <c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
//                     , showLowerCompany : 'Y'
// </c:if>
                }
                layerCompanyList.create (options );
            }
            // 업체 검색 콜백
            function searchLowCompanyCallback(compList) {
                if(compList.length > 0) {
                    $("#policySearchForm #lowCompNo").val (compList[0].compNo);
                    $("#policySearchForm #lowCompNm").val (compList[0].compNm);
                }
            }
            
            $(document).on("click", "input:checkbox[name=showAllLowComp]", function(e){
                if ($(this).is(":checked") == true) {
                    $("#showAllLowCompany").val("Y");   
                } else {
                    $("#showAllLowCompany").val("N");
                }
            });   
            
            // 초기화 버튼클릭
            function searchReset() {
                resetForm ("policySearchForm");
                <c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
                $("#policySearchForm #compNo").val('${adminSession.compNo}');
                $("#policySearchForm #showAllLowCompany").val("N");
                </c:if>
            }
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form name="policySearchForm" id="policySearchForm" method="post">
				<table class="table_type1">
					<caption>게시판 글 목록</caption>
					<c:choose>
						<c:when test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
							<tbody>
								<tr>
									<th scope="row"><spring:message code="column.comp_plc_gb_cd" /></th>
			                        <td>
			                            <select id="compPlcGbCd" name="compPlcGbCd" >
			                                <frame:select grpCd="${adminConstants.COMP_PLC_GB}" defaultName="전체" />
			                            </select>
			                        </td>
									<th scope="row"><spring:message code="column.disp_yn" /></th>
									<td>
										<select id="dispYn" name="dispYn" >
											<frame:select grpCd="${adminConstants.DISP_YN}" defaultName="전체" />
										</select>
									</td>
								</tr>
							</tbody>
						</c:when>
						<c:otherwise>	
							<tbody>
								<tr>
									<th scope="row"><spring:message code="column.comp_nm" /></th>
									<td>
										<frame:compNo funcNm="searchCompany" disableSearchYn="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? 'N' : 'Y'}" placeholder="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? '입점업체를 검색하세요' : ''}"/>
			                            <%-- <c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
			                            &nbsp;&nbsp;&nbsp;<frame:lowCompNo funcNm="searchLowCompany" placeholder="하위업체를 검색하세요"/>
			                            &nbsp;&nbsp;&nbsp;<input type="checkbox" id="showAllLowComp" name="showAllLowComp"><span>하위업체 전체 선택</span>
			                            <input type="hidden" id="showAllLowCompany" name="showAllLowCompany" value="N"/>
			                            </c:if> --%>
									</td>
									<th scope="row"><spring:message code="column.comp_plc_gb_cd" /></th>
			                        <td>
			                            <select id="compPlcGbCd" name="compPlcGbCd" >
			                                <frame:select grpCd="${adminConstants.COMP_PLC_GB}" defaultName="전체" />
			                            </select>
			                        </td>
								</tr>
								<tr>
			                        <th scope="row"><spring:message code="column.comp_stat_cd" /></th>
			                        <td>
			                            <select name="compStatCd" id="compStatCd" title="<spring:message code="column.comp_stat_cd" />">
			                                <frame:select grpCd="${adminConstants.COMP_STAT}" defaultName="전체"/>
			                            </select>
			                        </td>
									<th scope="row"><spring:message code="column.disp_yn" /></th>
									<td>
										<select id="dispYn" name="dispYn" >
											<frame:select grpCd="${adminConstants.DISP_YN}" defaultName="전체" />
										</select>
									</td>
								</tr>
							</tbody>
						</c:otherwise>
					</c:choose>				
				</table>
				</form>
	
				<div class="btn_area_center">
					<button type="button" onclick="reloadPolicyListGrid();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

		<div class="mModule">
			<button id="insertBtn" type="button" onclick="policyView('');" class="btn btn-add" style="display: none;">정책 등록</button>
			<c:if test="${adminSession.usrGrpCd ne adminConstants.USR_GRP_20 and companyBase.compTpCd eq adminConstants.COMP_TP_20 }">
				<button type="button" onclick="policyDelete();" class="btn btn-add">삭제</button>
			</c:if>
				
			<table id="policyList" ></table>
			<div id="policyListPage"></div>
		</div>

	</t:putAttribute>
</t:insertDefinition>
