<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<style type="text/css">
		    .ui-jqgrid tr.jqgrow td { text-overflow: ellipsis; -o-text-overflow: ellipsis; white-space: nowrap; }
		    .underline {text-decoration:underline !important; text-underline-position: under;}
		</style>
		
		<script type="text/javascript">
			$(document).ready(function(){
				// 사용자 그리드
				createUserGrid();
				
	            $(document).on("keydown","#userSearchForm input",function(){
	      			if ( window.event.keyCode == 13 ) {
	      				reloadUserGrid();
	    		  	}
	            });					
			});

			// 사용자 그리드
			function createUserGrid(){
				var options = {
					url : "<spring:url value='/system/userListGrid.do' />"
					, height : 400
					, searchParam : $("#userSearchForm").serializeJson()
// 					, rownumbers : true
					, sortname : 'sysRegDtm'
					, sortorder : 'DESC'
					, colModels : [
						  {name:"rowNum", label : "No", width:"50",align:"center"}
						, {name:"validStDtm", hidden:true}
						, {name:"validEnDtm", hidden:true}
						, {name:"usrNo", hidden:true}
						, {name:"loginId",	label:'<spring:message code="column.usr_id" />',	width:"120",	align:"center",	sortable:false,	classes:'pointer underline'}
						, {name:"dpNm", 	label:'<spring:message code="column.dp_nm" />',		width:"110",	align:"center",	sortable:false}
						, {name:"usrNm", 	label:'<spring:message code="column.usr_nm" />', 	width:"120", 	align:"center", sortable:false}
// 						, {name:"usrGrpCd",	label:'<spring:message code="column.usr_grp_cd" />', width:"130", 	align:"center", sortable:false,	formatter:"select",	editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.USR_GRP}" />"}}
// 						, {name:"usrGbCd", 	label:'<spring:message code="column.usr_gb_cd" />', width:"130", 	align:"center", sortable:false,	formatter:"select",	editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.USR_GB}" />"}}
// 						, {name:"authNm", 	label:'<spring:message code="column.auth_nm" />', 	width:"130", 	align:"center", sortable:false}
						, {name:'mobile', label:'<spring:message code="column.mobile2" />', width:'120', align:'center', sortable:false}
						, _GRID_COLUMNS.email
						, {name:"lastLoginDtm",	label:'<spring:message code="column.last_access_dtm2" />',	width:"150", 	align:"center",	sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"usrStatCd",	label:'<spring:message code="column.stat" />',		width:"80", 	align:"center", sortable:false,	formatter:"select",	editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.USR_STAT}" />"}}
						, {name:"validDtm",		label:'<spring:message code="column.vld_prd_cd" />', 		width:"170", 	align:"center",	sortable:false}
						//, {name:"usrGrpCd", label:'<spring:message code="column.usr_grp_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.USR_GRP}" />"}}
						//, {name:"usrGbCd", label:'<spring:message code="column.usr_gb_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.USR_GB}" />"}}
						//, _GRID_COLUMNS.compNm
// 						, _GRID_COLUMNS.sysRegrNm
						, {name:'sysRegDtm', label:'<spring:message code="column.sys_reg_dt" />', width:'150', align:'center', formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", sortable:false}
						, {name:'regIdNm', label:'<spring:message code="column.reg_id_nm" />', width:'150', align:'center', sortable:false 
							, formatter : function(cellvalue, options, rowObject) {
								return rowObject.sysRegrNo + " (" + rowObject.sysRegrNm + ")";
							}
						}
						, {name:'usrIp', label:'<spring:message code="column.reg_ip" />', width:'120', align:'center', sortable:false}
// 						, _GRID_COLUMNS.sysUpdrNm
// 						, _GRID_COLUMNS.sysUpdDtm
					]
					, onSelectRow : function(ids) {
						var rowdata = $("#userList").getRowData(ids);
						userView(rowdata.usrNo);
					}
				};
				grid.create("userList", options);
			}
			
			/* function validDtmFormat(cellValue, options, rowObject){
				var validStDtm = rowObject.validStDtm;
				var validEnDtm = rowObject.validEnDtm;
				var returnStr = "";
				
				if(!validation.isNull(validStDtm) && !validation.isNull(validEnDtm)){
					returnStr = validStDtm + "~" + validEnDtm;	
				}
				
				return returnStr;
			} */

			// 사용자 그리드 리로드
			function reloadUserGrid(){
				var options = {
					searchParam : $("#userSearchForm").serializeJson()
				};

				grid.reload("userList", options);
			}

			// 사용자 상세 이동
			function userView(usrNo) {
				var url = "";
				var tabName = "";
				
				if("${usrGrpCdGb}" == "${adminConstants.USR_GRP_10}") {
					url = '/system/userView.do?usrNo=' + usrNo;
					tabName = "사용자 상세"; 
				} else {
					url = '/partner/partnerView.do?usrNo=' + usrNo;
					tabName = "파트너 사용자 상세";
				}
				addTab(tabName, url);
			}
			
			// 사용자 등록
			function userReg() {
				var url = "";
				var tabName = "";
				
				if("${usrGrpCdGb}" == "${adminConstants.USR_GRP_10}") {
					url = '/system/userView.do';
					tabName = "사용자 등록"; 
				} else {
					url = '/partner/partnerView.do';
					tabName = "파트너 사용자 등록";
				}
				addTab(tabName, url);
			}
			
	          // 업체 검색
            function searchCompany () {
                var options = {
                    multiselect : false
                    , callBack : searchCompanyCallback
                }
                layerCompanyList.create (options );
            }
            // 업체 검색 콜백
            function searchCompanyCallback(compList) {
                if(compList.length > 0) {
                    $("#userSearchForm #compNo").val (compList[0].compNo);
                    $("#userSearchForm #compNm").val (compList[0].compNm);
                }
            }
			
		     // 하위 업체 검색
	        /* function searchLowCompany () {
	            var options = {
	                multiselect : false
	                , callBack : searchLowCompanyCallback
<c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
	                , showLowerCompany : 'Y'
</c:if>             
	            }
	            layerCompanyList.create (options );
	        }
	        // 업체 검색 콜백
	        function searchLowCompanyCallback(compList) {
	            if(compList.length > 0) {
	                $("#userSearchForm #lowCompNo").val (compList[0].compNo);
	                $("#userSearchForm #lowCompNm").val (compList[0].compNm);
	            }
	        } */
	        
            /* $(document).on("click", "input:checkbox[name=showAllLowComp]", function(e){
            	if ($(this).is(":checked") == true) {
            		$("#showAllLowCompany").val("Y");	
            	} else {
            		$("#showAllLowCompany").val("N");
            	}
            }); */	        
	        
	        // 초기화 버튼클릭
	        function searchReset () {
	            resetForm ("userSearchForm");
	            /* <c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
	            $("#userSearchForm #compNo").val('${adminSession.compNo}');
	            </c:if> */
				var options = {
						searchParam : $("#userSearchForm").serializeJson()
					};

				grid.reload("userList", options);
	        }
	        
			function userBaseExcelDownload(){

				var d = $("#userSearchForm").serializeJson();

				createFormSubmit( "userBaseExcelDownload", "/system/userBaseExcelDownload.do", d );
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form name="userSearchForm" id="userSearchForm" method="post">
					<c:if test="${adminSession.usrGrpCd eq adminConstants.USR_GRP_20}">
						<input id="compNo" name="compNo" type="hidden" value="${adminSession.compNo }" />
					</c:if>
					<input type="hidden" id="usrGrpCd" name="usrGrpCd" value="${usrGrpCdGb }" />
						<table class="table_type1">
						<caption>사용자 목록</caption>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.usr_id" /></th>
								<td>
									<!-- 사용자 아이디 -->
									<input type="text" name="loginId" title="<spring:message code="column.usr_id" />" >
								</td>
								<th scope="row"><spring:message code="column.usr_nm" /></th>
								<td>
									<!-- 사용자 명 -->
									<input type="text" name="usrNm" title="<spring:message code="column.usr_nm" />" >
								</td>
								<th scope="row"><spring:message code="column.auth_nm" /></th>
								<td>
									<!-- 접근권한명 -->
									<select class="validate[required]" name="authNo" title="<spring:message code="column.auth_nm" />" >
										<option value="">전체</option>
										<c:forEach items="${auth}" var="item">
											<c:if test="${usrGrpCdGb eq adminConstants.USR_GRP_10 }">
												<c:if test="${item.authNo ne 103 }">
													<option value="${item.authNo}">${item.authNm}</option>
												</c:if>
											</c:if>
											<c:if test="${usrGrpCdGb eq adminConstants.USR_GRP_20 }">
												<c:if test="${item.authNo eq 103 }">
													<option value="${item.authNo}">${item.authNm}</option>
												</c:if>
											</c:if>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.usr_stat_cd" /></th>
								<td colspan="5">
									<!-- 사용자 상태 -->
									<select name="usrStatCd" id="usrStatCd" title="<spring:message code="column.usr_stat_cd" />">
										<frame:select grpCd="${adminConstants.USR_STAT}" defaultName="전체"/>
									</select>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				
				<div class="btn_area_center">
					<button type="button" onclick="reloadUserGrid();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

		<div class="mModule">
			<c:if test="${adminSession.usrGbCd ne adminConstants.USR_GB_3010 and adminSession.usrGbCd ne adminConstants.USR_GB_3020 }">
				<div id="resultArea">
					<button type="button" onclick="userReg('');" class="btn btn-add">사용자 등록</button>
					
					<button type="button" onclick="userBaseExcelDownload();" class="btn btn-add btn-excel right">엑셀 다운로드</button>
				</div>
			</c:if>
			
			<table id="userList" class="grid"></table>
			<div id="userListPage"></div>
		</div>

	</t:putAttribute>
</t:insertDefinition>