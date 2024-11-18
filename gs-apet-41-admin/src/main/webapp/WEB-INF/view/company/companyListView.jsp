<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				$("#compGbCd").bind("change", function(){ changeCompGbCd(); });
				
				createCompanyGrid();
				changeCompGbCd();
				
	            $(document).on("keydown","#companySearchForm input",function(){
	      			if ( window.event.keyCode == 13 ) {
	      				reloadCompanyGrid();
	    		  	}
	            });					
			});
			
			function changeCompGbCd() {
				var value = $("#compGbCd").val();
				var html = "";

				if(value != "") {
					if(value == "${adminConstants.COMP_GB_10}") {
						html = '<frame:select grpCd="${adminConstants.COMP_TP}" usrDfn1Val="${adminConstants.COMP_GB_10}" defaultName="전체" />';
					} else if(value == "${adminConstants.COMP_GB_20}") {
						html = '<frame:select grpCd="${adminConstants.COMP_TP}" usrDfn1Val="${adminConstants.COMP_GB_20}" defaultName="전체" />';
					}
				} else {
					html = '<frame:select grpCd="${adminConstants.COMP_TP}" defaultName="전체" />';	
				}
				
				$("#compTpCd").html(html);
			}

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
					url : "<spring:url value='/company/companyListGrid.do' />"
					, height : 400
					, searchParam : $("#companySearchForm").serializeJson()
					, colModels : [
						  _GRID_COLUMNS.compNo_b
						, _GRID_COLUMNS.compNm
						, {name:"compStatCd", label:'<spring:message code="column.comp_stat_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.COMP_STAT}" />"}}
						, {name:"compGbCd", label:'<spring:message code="column.comp_gb_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.COMP_GB}" />"}}
						, {name:"compTpCd", label:'<spring:message code="column.comp_tp_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.COMP_TP}" />"}}
						, {name:"ceoNm", label:'<spring:message code="column.ceo_nm" />', width:"100", align:"center"}
						, {name:"bizNo", label:'<spring:message code="column.biz_no" />', width:"120", align:"center"}
						, _GRID_COLUMNS.tel
						, _GRID_COLUMNS.fax
						, {name:"cclTermCd", label:'<spring:message code="column.comp_ccl_term_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CCL_TERM}" />"},
							hidden:'${adminSession.usrGrpCd}'!='10'? true:false}
						, {name:"bigo", label:'<spring:message code="column.bigo" />', width:"100", align:"center"}
						, {name:"bizLicImgPath", label:'<spring:message code="column.biz_lic_img_path" />', width:"100", align:"center", formatter:function(cellValue, options, rowObject){
							if(cellValue != null && cellValue != "") {
								return "<button type='button' style='padding:3px 10px 3px 10px;' onclick='companyImageLayerView(\"" + cellValue + "\", \"사업자 등록증\");' class='btn'>보기</button>";
							} else {
								return "";
							}
						}}
						, {name:"cisRegYn", label:'<spring:message code="column.cis_reg_yn" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CIS_REG_YN}" />"}}
						, _GRID_COLUMNS.sysRegrNm
						, _GRID_COLUMNS.sysRegDtm
						, _GRID_COLUMNS.sysUpdrNm
						, _GRID_COLUMNS.sysUpdDtm
					]
					, onCellSelect : function (ids, cellidx, cellvalue) {
						// 사업자 등록증 제외
						if(cellidx != 11) {
							var rowdata = $("#companyList").getRowData(ids);
							companyView(rowdata.compNo);	
						}
					}
				};
				grid.create("companyList", options);
			}
			
			function companyImageLayerView(imgPath, title) {
				var options = {
						url : "<spring:url value='/company/companyImageLayerView.do' />"
						, data : { imgPath : imgPath }
						, dataType : "html"
						, callBack : function (data ) {
							var config = {
								id : "companyImageLayerView"
								, width : 1000
								, height : 800
								, top : 200
								, title : title
								, body : data
							}
							layer.create(config);
						}
					}
					ajax.call(options );
			}

			function reloadCompanyGrid(){
				var options = {
					searchParam : $("#companySearchForm").serializeJson()
				};

				grid.reload("companyList", options);
			}

			function companyView(compNo) {
				addTab('업체 상세', '/company/companyView.do?compNo=' + compNo);
			}
			
			function registCompany() {
				addTab('업체 등록', '/company/companyInsertView.do');
			}

			function searchCompany() {
				var options = {
					multiselect : false
					, data : {
//                         usrGbCd : '${usrGbCd}'
                    }
					, callBack : function(result) {
						if(result.length > 0) {
							$("#compNo").val(result[0].compNo);
							$("#compNm").val(result[0].compNm);
						}
					}
				}

				//companyMgtLayerCompanyList.create(options);
				layerCompanyList.create(options);
			}
			
            // 초기화 버튼클릭
            function searchReset () {
                resetForm ("companySearchForm");
                <c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
                $("#companySearchForm #compNo").val('${adminSession.compNo}');
                </c:if>
            }
            
            function getCisList() {
            	var options = {
            			url : "/company/getCisList.do"
            			, data : ""
            			, callBack : function(result) {
            				console.log(result);
            			}
            	}
            	
            	ajax.call(options);
            }
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
	<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}" >
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form name="companySearchForm" id="companySearchForm" method="post">
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
									</select>
								</td>
		                        <th scope="row"><spring:message code="column.st_id" /></th> <!-- 사이트 ID -->
		                        <td>
		                            <select id="stIdCombo" name="stId">
		                                <frame:stIdStSelect defaultName="사이트선택" />
		                            </select>
		                        </td>						
							</tr>
							<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}" >
							<tr>
							    <th scope="row"><spring:message code="column.comp_nm" /></th>
		                        <td>
		                            <frame:compNo funcNm="searchCompany" disableSearchYn="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? 'N' : 'Y'}"/>
		                        </td>
							    <th scope="row"><spring:message code="column.cis_reg_yn" /></th>
		                        <td>
		                        	<select id="cisRegYn" name="cisRegYn">
		                        		<frame:select grpCd="${adminConstants.CIS_REG_YN}" defaultName="전체"/>
	                        		</select>
		                        </td>
							</tr>
							</c:if>
						</tbody>
					</table>
				</form>
		
				<div class="btn_area_center">
					<button type="button" onclick="reloadCompanyGrid();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>
</c:if>
		<div class="mModule">
<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}" >
			<button type="button" onclick="registCompany();" class="btn btn-add">계약 업체 등록</button>
<!-- 			<button type="button" onclick="getCisList();" class="btn btn-add">GET CIS LIST</button> -->
</c:if>

			<table id="companyList"></table>
			<div id="companyListPage"></div>
		</div>

	</t:putAttribute>
</t:insertDefinition>