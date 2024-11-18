<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">
			var isUser;
			
			$(document).ready(function(){
				fnReset()
				searchDateChange();
				setCommonDatePickerEvent('#dispStrtDtm','#dispEndDtm');
				setCommonDatePickerEvent('#sysRegDtmStart','#sysRegDtmEnd');
				createExhibitionGrid();
			});
			
			// 초기화 버튼 클릭
			function searchReset(){
				resetForm ("exhibitionListPopForm");
				searchDateChange();
				fnReset();
			}

			function fnReset() {
// 				$("#sysRegDtm").val("");
				
				isUser = "N";
				if ("${adminConstants.USR_GRP_10}" == "${adminSession.usrGrpCd}") {
					isUser = "Y";
				}
			}
			
			// 등록일 변경
			function searchDateChange(param) {
				var disp = $("#checkOptDate").children("option:selected").val();//disp
				var reg = $("#checkRegDate").children("option:selected").val();//reg
				
				//전시기간	
				if(param == 'disp'){
					if(disp == ""){
						disp = '40';
	 					$("#dispStrtDtm").val($("#dispStrtDtm").data("origin"));
	 					$("#dispEndDtm").val($("#dispEndDtm").data("origin"));
					}
					setSearchDate(disp, "dispStrtDtm", "dispEndDtm");
				//등록일
				}else if(param == 'reg'){
					if(reg == ""){
						reg = '40';
						$("#sysRegDtmStart").val($("#sysRegDtmStart").data("origin"));
	 					$("#sysRegDtmEnd").val($("#sysRegDtmEnd").data("origin"));;
					}
					setSearchDate(reg, "sysRegDtmStart", "sysRegDtmEnd");
				}
				else{
					setSearchDate(disp, "dispStrtDtm", "dispEndDtm");
					setSearchDate(reg, "sysRegDtmStart", "sysRegDtmEnd");
				}
			}
			
			// 업체 검색
			function searchCompany () {
				var options = {
					multiselect : false
					, callBack : searchCompanyCallback
					<c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
	                	, showLowerCompany : 'Y'
					</c:if>
				}
				layerCompanyList.create (options );
			}
			function searchCompanyCallback (compList ) {
				if(compList.length > 0 ) {
					$("#exhibitionListPopForm #compNo").val (compList[0].compNo );
					$("#exhibitionListPopForm #compNm").val (compList[0].compNm );
				}
			}
			
	        // 하위 업체 검색
	        function searchLowCompany () {
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
	                $("#exhibitionListPopForm #lowCompNo").val (compList[0].compNo);
	                $("#exhibitionListPopForm #lowCompNm").val (compList[0].compNm);
	            }
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
			
			function createExhibitionGrid(){
				var options = {
					url : "<spring:url value='/promotion/exhibitionListGrid.do' />"
					, height : 250
					, multiselect : true
					, searchParam : $("#exhibitionListPopForm").serializeJson()
					, colModels : [
						{name:"exhbtNo", label:'<spring:message code="column.exhbt_no" />', width:"90", align:"center", formatter:'integer', key:true }
			            , {name:"exhbtGbCd", label:'<spring:message code="column.exhbt_gb_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.EXHBT_GB}" />"}}
			            , {name:"bnrImgPath", label:'<spring:message code="column.exhbt_banner" />', width:"100", align:"center", formatter: function(cellvalue, options, rowObject) {
	 							if(rowObject.bnrImgPath != "") {
	 								return '<img src="${frame:imagePath( "'+rowObject.bnrImgPath+'" )}" style="width:80px; height:30px;"/>';
	 							} else {
	 								return '<img src="/images/noimage.png" style="width:80px; height:30px;" alt="NoImage" />';
	 							}
 							}
 						}
			            , {name:"exhbtNm", label:'<spring:message code="column.exhbt_nm" />', width:"300", align:"center", cellattr:function(){
		                	return 'style="text-overflow:ellipsis;white-space:nowrap;word-wrap:normal;width:100px;overflow:hidden";';
	          		 	 }}
			            , {name:"exhbtStatCd", label:'<spring:message code="column.exhbt_stat_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.EXHBT_STAT}" />"}}
			            , {name:"dispYn", label:'<spring:message code="column.disp_yn" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.DISP_YN}" />"}}
						, {name:"dispStrtDtm", label:'<spring:message code="column.disp_strt_dtm" />', width:"140", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"dispEndDtm", label:'<spring:message code="column.disp_end_dtm" />', width:"140", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"stNm", label:'<spring:message code="column.st_nm" />', width:"100", align:"center"}
						, {name:"sysUpdDtm", label:'<spring:message code="column.sys_upd_dtm" />', width:"140", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
			            , {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_dtm" />', width:"140", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
// 						, {name:"sysUpdrNm", label:'<spring:message code="column.sys_updr_nm" />', width:"100", align:"center"}
// 						, {name:"sysRegrNm", label:'<spring:message code="column.sys_regr_nm" />', width:"100", align:"center"}
// 						, {name:"stId", label:'<spring:message code="column.st_id" />', width:"100", align:"center" , hidden:true}
					]
				};
				grid.create("exhibitionList", options);
			}

			function reloadExhibitionGrid(){
				var dispStrtDtm = $("#dispStrtDtm").val().replace(/-/gi, "");
				var dispEndDtm = $("#dispEndDtm").val().replace(/-/gi, "");
				var diffMonths = getDiffMonths(dispStrtDtm, dispEndDtm);
			
				//등록일
				var sysRegStart = $("#sysRegDtmStart").val().replace(/-/gi, "");
				var sysRegEnd = $("#sysRegDtmEnd").val().replace(/-/gi, "");
				var sysMonths = getDiffMonths(sysRegStart, sysRegEnd); 
				
				if ( eval(diffMonths) > 3.5 || eval(sysMonths) > 3.5) {
					messager.alert("검색기간은 3개월을 초과할 수 없습니다.","info","info");
					return;
				}else if(parseInt(dispStrtDtm) > parseInt(dispEndDtm)){
					messager.alert("등록일 검색기간 시작일은 종료일과 같거나 이전이여야 합니다.", "Info", "info");
// 					$(sDtm).val($(eDtm).val());
					return;
				}
				
				var options = {
						searchParam : $("#exhibitionListPopForm").serializeJson()
					};
					
				
				grid.reload("exhibitionList", options);
			}
 

			 

			function updateDispYn() {
				var grid = $("#exhibitionList");

				var rowids = grid.jqGrid('getGridParam', 'selarrrow');
				if(rowids.length <= 0 ) {
					messager.alert("<spring:message code='column.common.update.no_select' />","Info","info");
					return;
				}

				var options = {
					url : "<spring:url value='/common/dispYnUpdateLayerView.do' />"
					, data : { }
					, dataType : "html"
					, callBack : function (data ) {
						var config = {
							id : "dispYnUpdate"
							, width : 500
							, height : 200
							, top : 200
							, title : "전시여부 일괄수정"
							, body : data
							, button : "<button type=\"button\" onclick=\"updateExhibitionBase('dispYn');\" class=\"btn_type1\">확인</button>"
						}
						layer.create(config);
					}
				}
				ajax.call(options );
			}

			function updateExhbtStatCd() {
				var grid = $("#exhibitionList");

				var rowids = grid.jqGrid('getGridParam', 'selarrrow');
				if(rowids.length <= 0 ) {
					messager.alert("<spring:message code='column.common.update.no_select' />","Info","info");
					return;
				}

				var options = {
					url : "<spring:url value='/promotion/exhibitionBaseExhbtStatCdUpdateLayerView.do' />"
					, data : { }
					, dataType : "html"
					, callBack : function (data ) {
						var config = {
							id : "exhibitionBaseExhbtStatCdUpdate"
							, width : 500
							, height : 200
							, top : 200
							, title : "기획전상태 일괄수정"
							, body : data
							, button : "<button type=\"button\" onclick=\"updateExhibitionBase('exhbtStatCd');\" class=\"btn_type1\">확인</button>"
						}
						layer.create(config);
					}
				}
				ajax.call(options );
			}
			
			function updateExhibitionBase(flag) {
				messager.confirm("<spring:message code='column.common.confirm.batch_update' />",function(r){
					if(r){
						var exhbtNos = new Array();
						var grid = $("#exhibitionList");
						var selectedIDs = grid.getGridParam ("selarrrow");
						for (var i = 0; i < selectedIDs.length; i++) {
							exhbtNos.push (selectedIDs[i] );
						}

						var sendData = {
							exhbtNos : exhbtNos
						};
						
						if (flag == "dispYn") {
							$.extend(sendData, {
								dispYn : $("#dispYnUpdateForm :radio[name=dispYn]:checked").val()
							});
						} else if (flag == "exhbtStatCd") {
							$.extend(sendData, {
								exhbtStatCd : $("#exhibitionBaseExhbtStatCdUpdateForm #exhbtStatCd").val()
							});
						}

						var options = {
							url : "<spring:url value='/promotion/exhibitionBaseSave.do' />"
							, data : sendData
							, callBack : function(result){
								messager.alert("<spring:message code='column.common.edit.final_msg' />","Info","info",function(){
									reloadExhibitionGrid ();
									if (flag == "dispYn") {
										layer.close ("dispYnUpdate" );
									} else if (flag == "exhbtStatCd") {
										layer.close ("exhibitionBaseExhbtStatCdUpdate" );
									}
								});								
							}
						};

						ajax.call(options);				
					}
				});
			}
		</script>
	
		<form name="exhibitionListPopForm" id="exhibitionListPopForm">
			<c:choose>
				<c:when test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}">
					<c:set value="Y" var="isUser"/> 
				</c:when>
				<c:otherwise>
					<c:set value="N" var="isUser"/> 
					<input type="hidden" id="sysRegrNo" name="sysRegrNo" value="${adminSession.usrNo}" />
				</c:otherwise>
			</c:choose>
		
			<table class="table_type1 popup">
				<caption>정보 검색</caption>
				<tbody>
					<tr>
						<!-- 기획전 구분 코드-->
						<th><spring:message code="column.exhbt_gb_cd"/></th>
						<td>
							<select name="exhbtGbCd" id="exhbtGbCd" title="<spring:message code="column.exhbt_gb_cd"/>">
								<frame:select grpCd="${adminConstants.EXHBT_GB}" defaultName="전체" showValue="true" />
							</select>
						</td>
						<!-- 전시 여부 -->
						<th scope="row"><spring:message code="column.disp_yn" /></th>
                        <td>
                           <select name="dispYn" id="dispYn" title="<spring:message code="column.disp_yn"/>">
								<frame:select grpCd="${adminConstants.DISP_YN}" defaultName="전체"/>
							</select>
                        </td>
                        <!-- 기획전 승인 상태 코드 -->
						<th scope="row"><spring:message code="column.exhbt_stat_cd" /></th>
						<td>
							<select name="exhbtStatCd" id="exhbtStatCd" title="<spring:message code="column.exhbt_stat_cd"/>">
								<frame:select grpCd="${adminConstants.EXHBT_STAT}" defaultName="전체"/>
							</select>
						</td>
					</tr>
					<tr>
						<!-- 담당 MD 명 -->
						<th scope="row"><spring:message code="column.exhbt_md_usr_nm" /></th>
						<td>
							<input type="text" name="mdUsrNm" id="exhbtNm"	title="<spring:message code="column.exhbt_md_usr_nm" />">
						</td>
						<!-- 등록일 -->
						<th scope="row"><spring:message code="column.exhibition_view.sysRegDt" /></th> 
						<td colspan="3">
							<frame:datepicker startDate="sysRegDtmStart" endDate="sysRegDtmEnd"  startValue="${frame:toDate('yyyy-MM-dd') }" endValue="${frame:toDate('yyyy-MM-dd') }"/>&nbsp;&nbsp;
							<select id="checkRegDate" name="checkRegDate" onchange="searchDateChange('reg');">
								<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_40 }"  defaultName="기간선택" />
							</select>
						</td>
					</tr>
					<tr>
						<!-- 기획전 번호 -->
						<th scope="row"><spring:message code="column.exhbt_no" /></th>
						<td>
							<input type=text name="exhbtNo" id="exhbtNo" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" title="<spring:message code="column.exhbt_no" />" >
						</td>					
						<!-- 기획전 명 -->
						<th scope="row"><spring:message code="column.exhbt_nm" /></th>
						<td>
							<input type="text" name="exhbtNm" id="exhbtNm" title="<spring:message code="column.exhbt_nm" />" >
						</td>
						<!-- 사이트 ID -->
	                    <th scope="row"><spring:message code="column.st_id" /></th> <!-- 사이트 ID -->
	                    <td>
                            <select id="stIdCombo" name="stId">
                                <frame:stIdStSelect defaultName="사이트선택" />
                            </select>
	                    </td>
					</tr>
					<tr>
						<!-- 기간 -->
						<th scope="row"><spring:message code="column.display_view.disp_date" /></th>
						<td colspan="5">
							<frame:datepicker startDate="dispStrtDtm" endDate="dispEndDtm"  startValue="${frame:toDate('yyyy-MM-dd') }" endValue="${frame:toDate('yyyy-MM-dd') }"/>&nbsp;&nbsp;
							<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange('disp');">
								<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_40 }"  defaultName="기간선택" />
							</select>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	
		<div class="btn_area_center">
			<button type="button" onclick="reloadExhibitionGrid();" class="btn btn-ok">검색</button>
			<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
		</div>

		<div class="mModule">
			<table id="exhibitionList" ></table>
			<div id="exhibitionListPage"></div>
		</div>

