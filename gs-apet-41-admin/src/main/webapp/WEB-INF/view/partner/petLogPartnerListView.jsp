<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				newSetCommonDatePickerEvent('#searchStDate','#searchEnDate');
				searchDateChange();
				createPetLogPartnerGrid();
				
	            $(document).on("keydown","#petLogPartnerSearchForm input",function(){
	      			if ( window.event.keyCode == 13 ) {
	      				reloadPetLogPartnerGrid();
	    		  	}
	            });					
			});
			
			//기간선택
			function searchDateChange() {
				var term = $("#checkOptDate").children("option:selected").val();
				if(term == "") {
					$("#searchStDate").val("");
					$("#searchEnDate").val("");
				} else if(term == "50") {
					setSearchDateThreeMonth("searchStDate","searchEnDate");
				} else {
					setSearchDate(term, "searchStDate", "searchEnDate");
				}
			}

			function createPetLogPartnerGrid(){
				var options = {
					url : "<spring:url value='/partner/partnerListGrid.do' />"
					, height : 400
					, searchParam : $("#petLogPartnerSearchForm").serializeJson()
					, rownumbers : true
					, sortname : 'sysRegDtm'
					, sortorder : 'DESC'
					, colModels : [
						{name:"bizNo", hidden:true}
						, {name:"mbrNo",  	label:'<spring:message code="column.mbr_no" />',	width:"110",	align:"center",	sortable:false}
						, {name:"loginId",	label:'<spring:message code="column.ptn_id" />',	width:"120",	align:"center",	sortable:false,	classes:'pointer underline'}
						, {name:"bizNm", 	label:'<spring:message code="column.ptn_nm" />', 	width:"120", 	align:"center", sortable:false}
						, _GRID_COLUMNS.email
						, {name:"statCd",	label:'<spring:message code="column.ptn_stat_cd" />', width:"130", 	align:"center", sortable:false,	formatter:"select",	editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.STAT}" />"}}
						, {name:"lastLoginDtm",	label:'<spring:message code="column.last_login_dtm" />',	width:"150", 	align:"center",	sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"ptnDate",		label:'<spring:message code="column.ptn_date" />', 		width:"170", 	align:"center",	sortable:false}
					]
					, onSelectRow : function(ids) {
						var rowdata = $("#petLogPartnerList").getRowData(ids);
						petLogPartnerView(rowdata);
					}
				};
				grid.create("petLogPartnerList", options);
			}

			function reloadPetLogPartnerGrid(){
				compareDateAlert('searchStDate','searchEnDate','term');
				$("input[name=mbrGbCd]").val("${adminConstants.MBR_GB_CD_30 }");
				var options = {
					searchParam : $("#petLogPartnerSearchForm").serializeJson()
				};
				
				var searchStDateVal = $("#searchStDate").val();
				var searchEnDateVal = $("#searchEnDate").val();
				
		    	var dispStrtDtm = $("#searchStDate").val().replace(/-/gi, "");
				var dispEndDtm = $("#searchEnDate").val().replace(/-/gi, "");
				var diffMonths = getDiffMonths(dispStrtDtm, dispEndDtm);
				var term = $("#checkOptDate").children("option:selected").val();
		
				if((searchStDateVal != "" && searchEnDateVal != "") || (searchStDateVal == "" && searchEnDateVal == "")){ // 시작날짜 종료날짜 둘다 있을 때 시작날짜 종료날짜 둘다 없을 때만 조회
					if(term == "50" || diffMonths <= 3){ 				//날짜 3개월 이상 차이 날때 조회 X term이 3개월일 때는 예외적 허용 예를들어 2월 28일과 5월 31일은 90일이 넘기때문
						grid.reload("petLogPartnerList", options);
					}
				}
			}

			function petLogPartnerView(data) {
				var url = '/partner/petLogPartnerView.do?mbrNo=' + data.mbrNo + '&bizNo=' + data.bizNo;
				addTab('펫로그 파트너 상세', url);
			}
			
			function petLogPartnerInsertView() {
				addTab('펫로그 파트너 등록', '/partner/petLogPartnerInsertView.do');
			}       
	        
			
			//초기화
	        function searchReset () {
	            resetForm ("petLogPartnerSearchForm");
	            searchDateChange();				
// 				var options = {
// 					searchParam : $("#petLogPartnerSearchForm").serializeJson()
// 				};
// 				grid.reload("petLogPartnerList", options);
	        }
	        
			function petLogPartnerExcelDownload(){
				var d = $("#petLogPartnerSearchForm").serializeJson();
				createFormSubmit( "petLogPartnerExcelDownload", "/partner/petLogPartnerExcelDownload.do", d );
			}
			
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form name="petLogPartnerSearchForm" id="petLogPartnerSearchForm" method="post">
					<input type="hidden" id="mbrGbCd" name="mbrGbCd" value="${adminConstants.MBR_GB_CD_30 }" />
					<table class="table_type1">
						<caption>펫로그 파트너 목록</caption>
						<tbody>	
							<tr>								
								<!-- 기간 -->
								<th scope="row"><spring:message code="column.common.date" /></th>
								<td colspan="3"> 
									<select id="dateOption" name="dateOption">
										<option value="10"><spring:message code="column.ptn_date" /></option>
										<option value="20"><spring:message code="column.last_access_dtm" /></option>
									</select>
									<frame:datepicker startDate="searchStDate" endDate="searchEnDate" startValue="${frame:toDate('yyyy-MM-dd') }" endValue="${frame:toDate('yyyy-MM-dd') }"  />
									<select name=checkOptDate id="checkOptDate" style="margin-left:10px;" onchange="searchDateChange();">					
										<option value="">기간선택</option>
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_40}" excludeOption="${adminConstants.SELECT_PERIOD_30 },${adminConstants.SELECT_PERIOD_60 }" />
									</select>
								</td>								
							</tr>
							<tr>	
								<!-- 아이디 -->
								<th scope="row"><spring:message code="column.ptn_id" /></th>							
								<td>
									<input type="text" name="loginId" id="loginId" title="<spring:message code="column.ptn_id" />" />
								</td>
								<!-- 파트너명 -->
								<th scope="row"><spring:message code="column.ptn_nm" /></th>								
								<td>									
									<input type="text" name="bizNm" id="bizNm" title="<spring:message code="column.ptn_nm" />" />
								</td>
							</tr>
							<tr>
								<!-- 이메일 -->								
								<th scope="row"><spring:message code="column.email" /></th>
								<td>
									<input type="text" name="email" id="email" title="<spring:message code="column.email" />" />
								</td>
								<!-- 상태 -->
								<th scope="row"><spring:message code="column.ptn_stat_cd" /></th>								
								<td>				
									<select name="mbrStatCd" id="mbrStatCd" title="<spring:message code="column.ptn_stat_cd"/>">					
										<frame:select grpCd="${adminConstants.MBR_STAT_CD }"  />
									</select>
								</td>
							</tr>				
						</tbody>
					</table>
				</form>
				
				<div class="btn_area_center">
					<button type="button" onclick="reloadPetLogPartnerGrid();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

		<div class="mModule">
			<div id="resultArea">
				<button type="button" onclick="petLogPartnerInsertView('');" class="btn btn-add">파트너 등록</button>
				
				<button type="button" onclick="petLogPartnerExcelDownload();" class="btn btn-add btn-excel right">엑셀 다운로드</button>
			</div>
			
			<table id="petLogPartnerList" class="grid"></table>
			<div id="petLogPartnerListPage"></div>
		</div>

	</t:putAttribute>
</t:insertDefinition>