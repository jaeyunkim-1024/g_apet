<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			var isUser;

			$(document).ready(function(){
				fnReset()
				searchDateChange();
				//날짜선택시 selectbox 기간선택문구로 변경 
				newSetCommonDatePickerEventOptions('#dispStrtDtm','#dispEndDtm', '#checkOptDate');
				newSetCommonDatePickerEventOptions('#sysRegDtmStart','#sysRegDtmEnd','#checkRegDate');
				
				createExhibitionGrid();
				
// 				$('#exhibitionListForm').on('reset', function(){
// 					setTimeout("fnReset()", 100);
// 				});

				//엔터키 
				$(document).on("keydown","#exhibitionListForm input",function(){
	    			if ( window.event.keyCode == 13 ) {
		    			reloadExhibitionGrid();
	  		  		}
	            });


			});
			
			// 초기화 버튼 클릭
			function searchReset(){
				resetForm ("exhibitionListForm");
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
					$("#exhibitionListForm #compNo").val (compList[0].compNo );
					$("#exhibitionListForm #compNm").val (compList[0].compNm );
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
	                $("#exhibitionListForm #lowCompNo").val (compList[0].compNo);
	                $("#exhibitionListForm #lowCompNm").val (compList[0].compNm);
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
					, height : 400
					, multiselect : true
					, searchParam : $("#exhibitionListForm").serializeJson()
					, colModels : [
						{name:"exhbtNo", label:'<spring:message code="column.exhbt_number" />', width:"80", align:"center", formatter:'integer', key:true, sortable:false, classes:'pointer fontbold'}
			            , {name:"exhbtGbCd", label:'<spring:message code="column.exhbt_gb_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.EXHBT_GB}" />"}}
	 					, {name:"bnrImgPath", label:'<spring:message code="column.exhbt_banner" />', width:"100", align:"center", formatter: function(cellvalue, options, rowObject) {
	 							if(rowObject.bnrImgPath != "") {
	 								return '<img src="${frame:imagePath( "'+rowObject.bnrImgPath+'" )}" style="width:80px; height:30px;"/>';
	 							} else {
	 								return '<img src="/images/noimage.png" style="width:80px; height:30px;" alt="NoImage" />';
	 							}
	 						}
	 					}
			            , {name:"exhbtNm", label:'<spring:message code="column.exhbt_nm" />', width:"250", align:"center",
			            	cellattr:function(){
	                            return 'style="text-overflow:ellipsis;white-space:nowrap;word-wrap:normal;width:100px;overflow:hidden";';
	                        }}
			            , {name:"mdUsrNm", label:'<spring:message code="column.exhbt_md_usr_nm" />', width:"100", align:"center", hidden:true}
			            , {name:"exhbtStatCd", label:'<spring:message code="column.exhbt_stat_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.EXHBT_STAT}" />"}}
			            , _GRID_COLUMNS.dispYn
			            , {name:"dispStrtDtm", label:'<spring:message code="column.disp_strt_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"dispEndDtm", label:'<spring:message code="column.disp_end_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"stNm", label:'<spring:message code="column.st_nm" />', width:"100", align:"center"}
						, _GRID_COLUMNS.sysRegDtm
						, _GRID_COLUMNS.sysUpdDtm
					]
					, onCellSelect : function (ids, cellidx, cellvalue) {
						if (cellidx > 0) {
							var rowdata = $("#exhibitionList").getRowData(ids);
							
							if (rowdata.exhbtGbCd == "${adminConstants.EXHBT_GB_10}" && isUser == "N") {
								exhibitionThemeGoodsView(rowdata.exhbtNo);
							} else {
								exhibitionBaseView(rowdata.exhbtNo);
							}
						}
					}
// 					, onSelectRow : function(ids) {
// 						var rowdata = $("#exhibitionList").getRowData(ids);
// 						exhibitionBaseView(rowdata.exhbtNo);
// 					}
				};
				grid.create("exhibitionList", options);
			}

			/* function reloadExhibitionGrid(){
				
				if(compareDateAlertOptions('sysRegDtmStart','sysRegDtmEnd','exhibitionList','term')){
					return;
				}
				if(compareDateAlertOptions('dispStrtDtm','dispEndDtm','exhibitionList','term')){
					return; 
				}
				
				var options = {
					searchParam : $("#exhibitionListForm").serializeJson()
				};
			
				
				//3. 얼럿이 없을때 조회
				if(gridReloadVariableTerm('sysRegDtmStart','sysRegDtmEnd','exhibitionList','term', options)){
					return;
				}
				if(gridReloadVariableTerm('dispStrtDtm','dispEndDtm','exhibitionList','term', options)){
					return;
				}
				   
				   
			} */
			
			function reloadExhibitionGrid(){
			
			    //1. 등록일 얼럿 호출
			    if(compareDateAlertOptions("sysRegDtmStart", "sysRegDtmEnd", "checkRegDate")){
			    	return;
			    }
			    if(compareDateAlertOptions("dispStrtDtm", "dispEndDtm", "checkOptDate")){
			    	return;
			    }
			    
			 	//2. 두번째 얼럿 = 첫번째에서 검증 후 호출 = alert이 있을 경우 중복 호출 하지 않도록 처리
				/*  if((startDate == "" && endDate != "") && (startDate != "" && endDate == "") == false && (eval(diffMonths) > 3 && term == '') == false) {
					compareDateAlertOptions("dispStrtDtm", "dispEndDtm", "checkOptDate")); 
			 	}
				*/
				var options = {
					searchParam : $("#exhibitionListForm").serializeJson()
				};
				
				//3. 얼럿이 없을때 조회
				if(gridReloadVariableTerm('sysRegDtmStart','sysRegDtmEnd','exhibitionList','term', options)){
					return;
				}
				if(gridReloadVariableTerm('dispStrtDtm','dispEndDtm','exhibitionList','term', options)){
					return;
				}
				 
			}


			function exhibitionBaseView(exhbtNo, copyYn) {
				if (exhbtNo == ''){
					addTab('기획전 등록', '/promotion/exhibitionBaseView.do');
				}else if(copyYn == "Y"){
					addTab('기획전 복사', '/promotion/exhibitionBaseView.do?exhbtNo=' +exhbtNo+ '&copyYn=Y');
				}else{
					addTab('기획전 상세', '/promotion/exhibitionBaseView.do?exhbtNo=' + exhbtNo);
				} 
			}

			function exhibitionThemeGoodsView(exhbtNo) {
				addTab('기획전 상세', '/promotion/exhibitionThemeGoodsView.do?exhbtNo=' + exhbtNo);
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
							, button : "<button type=\"button\" onclick=\"updateExhibitionStateBatch('dispYn');\" class=\"btn btn-ok\">확인</button>"
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
							, button : "<button type=\"button\" onclick=\"updateExhibitionStateBatch('exhbtStatCd');\" class=\"btn btn-ok\">확인</button>"
						}
						layer.create(config);
					}
				}
				ajax.call(options );
			}
			
			function updateExhibitionStateBatch(flag) {
				var exhbtNos = new Array();
				var grid = $("#exhibitionList");
				var selectedIDs = grid.getGridParam ("selarrrow");
				var statCds = new Array();
				
				if(selectedIDs.length <= 0 ) {
 					messager.alert("<spring:message code='column.common.update.no_select' />","Info","info");
 					return;
 				}
				
				messager.confirm("<spring:message code='column.common.confirm.batch_update' />",function(r){
					if(r){
						for (var i = 0; i < selectedIDs.length; i++) {
							var data = grid.getRowData(selectedIDs[i]);
							
							if(data.exhbtStatCd != '40' && flag == "dispYn") {
								exhbtNos.push(selectedIDs[i]);
							}else if(flag == "exhbtStatCd"){
								exhbtNos.push(selectedIDs[i]);
							}
			  			}
						
						if(exhbtNos == ""){
							messager.alert("종료된 기획전은 수정할 수 없습니다.","Info","info");
							return;
						}
						
						var sendData = {
							exhbtNos : exhbtNos
						};
						
						var updateUrl = "<spring:url value='/promotion/exhibitionStateBatchSave.do' />";
						if (flag == "dispYn") {
							$.extend(sendData, {
								dispYn : $("#dispYnSel").children("option:selected").val()
							});
							
						} else if (flag == "exhbtStatCd") {
							$.extend(sendData, {
								exhbtStatCd : $("#exhbtStatCdSel").children("option:selected").val()
							});
						}
						
						var options = {
							url : updateUrl
							, data : sendData
							, callBack : function(result){
								messager.alert("<spring:message code='column.common.edit.cnt.final_msg' arguments='" + result.exhibitionStateUpdateCount + "' />","Info","info",function(){
									reloadExhibitionGrid ();
// 									if (flag == "dispYn") {
// 										layer.close ("dispYnUpdate" );
// 									} else if (flag == "exhbtStatCd") {
// 										layer.close ("exhibitionBaseExhbtStatCdUpdate" );
// 									}
								});
							}
						};
						ajax.call(options);					
					}
				});
			}
			
			// 등록일 변경
			function searchDateChange(param) {
				var dispTerm = $("#checkOptDate").children("option:selected").val();
				var regTerm = $("#checkRegDate").children("option:selected").val();
				var disp = $("#checkOptDate").children("option:selected").val();//disp
				var reg = $("#checkRegDate").children("option:selected").val();//reg
				
				//전시기간	
				if(param == 'disp'){
					if(disp == ""){
						//disp = '40';
	 					$("#dispStrtDtm").val("");
	 					$("#dispEndDtm").val("");
					}else if(disp == "50"){
						//3개월 기간조회시에만 호출하는 메소드
	    				setSearchDateThreeMonth("dispStrtDtm", "dispEndDtm");	
					}else{
						setSearchDate(disp, "dispStrtDtm", "dispEndDtm");
					}
				//등록일
				}else if(param == 'reg'){
					if(reg == ""){
						//reg = '40';
						$("#sysRegDtmStart").val("");
	 					$("#sysRegDtmEnd").val("");
					}else if(reg == "50"){
						//3개월 기간조회시에만 호출하는 메소드
	    				setSearchDateThreeMonth("sysRegDtmStart", "sysRegDtmEnd");	
					}else{
						setSearchDate(reg, "sysRegDtmStart", "sysRegDtmEnd");
					}
					
				}else{
					setSearchDate(disp, "dispStrtDtm", "dispEndDtm");
					setSearchDate(reg, "sysRegDtmStart", "sysRegDtmEnd");
				}
			}
			
			//기획전 복사
			function copyExhibitionBase(){
				var grid = $("#exhibitionList");
				var exhbtNo = grid.getGridParam ("selarrrow");

				//한개만 복사되게
				if(exhbtNo.length > 1){
					messager.alert("<spring:message code='column.common.copy.multi_select' />","Info","info");
					return;
				}else if(exhbtNo.length <= 0 ) {
					messager.alert("<spring:message code='column.common.copy.no_select' />","Info","info");
					return;
				}
				
				exhibitionBaseView(exhbtNo, "Y");
				
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion"
			data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect"
			style="width: 100%">
			<div title="<spring:message code='admin.web.view.common.search' />"
				style="padding: 10px">
				<form name="exhibitionListForm" id="exhibitionListForm">
					<c:choose>
						<c:when test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}">
							<c:set value="Y" var="isUser" />
						</c:when>
						<c:otherwise>
							<c:set value="N" var="isUser" />
							<input type="hidden" id="sysRegrNo" name="sysRegrNo" value="${adminSession.usrNo}" />
						</c:otherwise>
					</c:choose>

					<table class="table_type1">
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<!-- 기획전 구분 코드-->
								<th><spring:message code="column.exhbt_gb_cd" /></th>
								<td>
									<select name="exhbtGbCd" id="exhbtGbCd" title="<spring:message code="column.exhbt_gb_cd"/>">
										<frame:select grpCd="${adminConstants.EXHBT_GB}" defaultName="전체"/>
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
								<!-- 담당 MD 번호 -->
								<th scope="row"><spring:message code="column.exhbt_md_usr_nm" /></th>
								<td>
									<input type="text" name="mdUsrNm" id="exhbtNm"	title="<spring:message code="column.exhbt_md_usr_nm" />">
								</td>
								<!-- 등록일 -->
								<th scope="row"><spring:message code="column.exhibition_view.sysRegDt" /></th> 
								<td colspan="3">
									<frame:datepicker startDate="sysRegDtmStart" endDate="sysRegDtmEnd"  startValue="${frame:toDate('yyyy-MM-dd') }" endValue="${frame:toDate('yyyy-MM-dd') }" />&nbsp;&nbsp;
									<select id="checkRegDate" name="checkRegDate" onchange="searchDateChange('reg');">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_40 }"  defaultName="기간선택" />
									</select>
								</td>
							</tr>
							<tr>
								<!-- 기획전 번호 -->
								<th scope="row"><spring:message code="column.exhbt_no" /></th>
								<td>
									<input type="text" name="exhbtNo" id="exhbtNo" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" title="<spring:message code="column.exhbt_no" />">
								</td>
								<!-- 기획전 명 -->
								<th scope="row"><spring:message code="column.exhbt_nm" /></th>
								<td>
									<input type="text" name="exhbtNm" id="exhbtNm"	title="<spring:message code="column.exhbt_nm" />">
								</td>
								<!-- 사이트 ID -->
								<th scope="row"><spring:message code="column.st_id" /></th>
								<td>
									<select id="stIdCombo" name="stId">
										<frame:stIdStSelect defaultName="사이트선택" />
									</select>
								</td>								
							</tr>
							<tr>
								<!-- 전시 기간 -->
								<th scope="row"><spring:message code="column.display_view.disp_date" /></th>
								<td colspan="5"> 
									<frame:datepicker startDate="dispStrtDtm" endDate="dispEndDtm"  startValue="${frame:toDate('yyyy-MM-dd') }" endValue="${frame:toDate('yyyy-MM-dd') }" />&nbsp;&nbsp;
									<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange('disp');">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_40}"  defaultName="기간선택" />
									</select>
								</td>
							</tr>
						</tbody>
					</table>
				</form>

				<div class="btn_area_center">
					<button type="button" onclick="reloadExhibitionGrid();"	class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

		<div class="mModule">
			<div id="resultArea" style="text-align: right;">
	<!-- 			<button type="button" onclick="copyExhibitionBase();"class="btn btn-add" style="display:none">기획전 복사</button> -->
				<c:if test="${isUser eq 'Y' }">
					<select name="dispYnSel" id="dispYnSel" title="<spring:message code="column.disp_yn" />" />">
						<frame:select grpCd="${adminConstants.DISP_YN }"/>
					</select>
					<button type="button" onclick="updateExhibitionStateBatch('dispYn');" class="btn btn-add">전시여부 일괄변경</button>
					
					<select name="exhbtStatCdSel" id="exhbtStatCdSel" title="<spring:message code="column.exhbt_stat_cd" />" />">
						<frame:select grpCd="${adminConstants.EXHBT_STAT}"/>
<%-- 						<frame:select grpCd="${adminConstants.EXHBT_STAT}" excludeOption="${adminConstants.EXHBT_STAT_10}"/> --%>
					</select>
					<button type="button" onclick="updateExhibitionStateBatch('exhbtStatCd');"class="btn btn-add">상태 일괄변경</button>
				</c:if>
				<button type="button" onclick="exhibitionBaseView('');"	class="btn btn-add" style="background-color: #0066CC;">+ 등록</button>
			</div>
			<table id="exhibitionList"></table>
			<div id="exhibitionListPage"></div>
		</div>

	</t:putAttribute>
</t:insertDefinition>
