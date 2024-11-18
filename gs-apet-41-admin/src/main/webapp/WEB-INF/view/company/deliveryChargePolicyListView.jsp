<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				createCompanyGrid();
				
	            $(document).on("keydown","#companySearchForm input",function(){
	      			if ( window.event.keyCode == 13 ) {
	      				reloadCompanyGrid();
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

			// 공급업체 리스트
			function createCompanyGrid(){
				var options = {
					url : "<spring:url value='/company/deliveryChargePolicyListGrid.do' />"
					, height : 400
					, searchParam : $("#companySearchForm").serializeJson()
					, colModels : [
				           	{name:"compNo", label:'<spring:message code="column.comp_no" />', hidden:true }
				           	
							, {name:"dlvrcPlcNo", label:'<b><u><tt><spring:message code="column.dlvrc_plc_no" /></tt></u></b>', width:"90", align:"center", formatter:'integer', classes:'pointer fontbold', sortable:false}
							, _GRID_COLUMNS.compNm
							, {name:"plcNm", label:'<b><u><tt><spring:message code="column.plc_nm" /></tt></u></b>', width:"200", align:"center", classes:'pointer fontbold', sortable:false}
							, {name:"histStrtDtm", label:'<spring:message code="column.hist_strt_dtm" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", sortable:false}
							, {name:"cfmYn", label:'<spring:message code="column.confirmYn" />', width:"60", align:"center" , formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.COMM_YN}"/>"}, sortable:false}
							, {name:"cfmUsrNo", label:'<spring:message code="column.confirm_user_no" />', width:"100", align:"center", hidden:true}
							, {name:"cfmUsrNm", label:'<spring:message code="column.confirm_user_no" />', width:"100", align:"center", sortable:false}
							, {name:"cfmPrcsDtm", label:'<spring:message code="column.cfm_dtm" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", sortable:false}
							, {name:"delYn", label:'<spring:message code="column.del_yn" />', width:"60", align:"center" , formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.DEL_YN}"/>"}, sortable:false}
                            , {name:"rtnExcMan", label:'<spring:message code="column.rtn_exc_man" />', width:"130", align:"center", sortable:false}
                            , {name:"rtnExcTel", label:'<spring:message code="column.rtn_exc_tel" />', width:"120", align:"center", sortable:false}							
							, {name:"dftHdcCd", label:'<spring:message code="column.dft_hdc_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.HDC}"/>"}, sortable:false}
							, {name:"rtnaPostNoNew", label:'<spring:message code="column.rtna_post_no_new" />', width:"120", align:"center", sortable:false}
							, {name:"rtnaRoadAddr", label:'<spring:message code="column.rtna_road_addr" />', width:"300", align:"center", sortable:false}
							, {name:"rtnaRoadDtlAddr", label:'<spring:message code="column.rtna_road_dtl_addr" />', width:"200", align:"center", sortable:false}
							, {name:"rlsaPostNoNew", label:'<spring:message code="column.rlsa_post_no_new" />', width:"120", align:"center", sortable:false}
							, {name:"rlsaRoadAddr", label:'<spring:message code="column.rlsa_road_addr" />', width:"300", align:"center", sortable:false}
							, {name:"rlsaRoadDtlAddr", label:'<spring:message code="column.rlsa_road_dtl_addr" />', width:"200", align:"center", sortable:false}
							, _GRID_COLUMNS.sysRegrNm
							, _GRID_COLUMNS.sysRegDtm
							, _GRID_COLUMNS.sysUpdrNm
							, _GRID_COLUMNS.sysUpdDtm
						]
					, onSelectRow : function(ids) {
						var rowdata = $("#companyList").getRowData(ids);
						companyDeliveryView(rowdata.compNo, rowdata.dlvrcPlcNo, rowdata.cfmYn);
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

			// 업체 배송정책 상세 보기
			function companyDeliveryView(compNo, dlvrcPlcNo, cfmYn) {
				var options = {
					url : "<spring:url value='/company/companyDeliveryChargePolicyViewPop.do' />"
					, data : {
						compNo: compNo,
						dlvrcPlcNo: dlvrcPlcNo,
						viewDlvrPlcyDetail: 'Y'
			         }
					, dataType : "html"
					, callBack : function (data) {
						var btn = '', height = 800;
						if ('${adminConstants.USR_GB_1010}' == '${adminSession.usrGbCd}') {
							if (cfmYn == 'N') {
								btn += '<button type="button" class="btn btn-ok" onclick="updateCompanyChargePolicy();">승인</button>'
									+ '<button type="button" class="ml10 btn btn-add" onclick="deleteCompanyDelivery();">삭제</button>';
									
								height = 750;
							}
						}
						
						var config = {
							id : "companyDeliveryChargePolicyView"
							, width : 1400
							, height : height
							, top : 50
							, title : "업체 배송정책 보기"
							, body : data
							, button : btn
						}
						layer.create(config);
					}
				}
				ajax.call(options );
			}

			function searchCompany() {
				var options = {
					multiselect : false
					, data : {
                        usrGbCd : '${usrGbCd}'
                    }
					, callBack : function(result) {
						if(result.length > 0) {
							$("#compNo").val(result[0].compNo);
							$("#compNm").val(result[0].compNm);
						}
					}
				}

				companyMgtLayerCompanyList.create(options);
			}
			
            // 초기화 버튼클릭
            function searchReset () {
                resetForm ("companySearchForm");
                <c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
                $("#companySearchForm #compNo").val('${adminSession.compNo}');
                </c:if>
            }
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form name="companySearchForm" id="companySearchForm" method="post">
					<input type="hidden" id="mdUsrNo" name="mdUsrNo" value="${adminSession.usrNo }"/>
					<table class="table_type1">
						<caption>정보 검색</caption>
						<c:choose>
							<c:when test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
								<tbody>
									<tr>
										<th scope="row"><spring:message code="column.confirmYn" /></th>
										<td>
											<select name="cfmYn" id="cfmYn" title="<spring:message code="column.confirmYn" />">
												<frame:select grpCd="${adminConstants.COMM_YN}" defaultName="전체"/>
											</select>
										</td>
									</tr>
								</tbody>
							</c:when>
							<c:otherwise>
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
										<th scope="row"><spring:message code="column.confirmYn" /></th>
										<td>
											<select name="cfmYn" id="cfmYn" title="<spring:message code="column.confirmYn" />">
												<frame:select grpCd="${adminConstants.COMM_YN}" defaultName="전체"/>
											</select>
										</td>
										<%-- <th scope="row"><spring:message code="column.comp_nm" /></th>
										<td>
											<frame:compNo funcNm="searchCompany" disableSearchYn="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? 'N' : 'Y'}"/>
										</td> --%>
									</tr>
									<%-- <c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}" >
									<tr>
										<th scope="row"><spring:message code="column.st_id" /></th> <!-- 사이트 ID -->
										<td colspan="3">
											<frame:stId funcNm="searchSt()" />
										</td>
									</tr>
									</c:if> --%>
								</tbody>
							</c:otherwise>
						</c:choose>
					</table>
				</form>
			
		
				<div class="btn_area_center">
					<button type="button" onclick="reloadCompanyGrid();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

 		<div class="mModule">
			<table id="companyList" class="grid"></table>
			<div id="companyListPage"></div>
		</div>

	</t:putAttribute>
</t:insertDefinition>