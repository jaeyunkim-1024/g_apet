<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function(){
			// 팝업 목록그리드
			popupListGrid();
			//날짜선택시 selectbox 기간선택문구로 변경 
			newSetCommonDatePickerEvent("#strtDate", "#endDate");

			searchDateChange(); 
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

		// 팝업 목록 그리드
		function popupListGrid(){
			var options = {
				url : "<spring:url value='/display/popupListGrid.do' />"
				, height : 400
				, searchParam : $("#popupListForm").serializeJson()
				, colModels : [
						{name:"popupNo", label:'<b><u><tt><spring:message code="column.popup_no" /></tt></u></b>', width:"80", align:"center", formatter:'integer', key : true, classes:'pointer fontbold'}

						// 팝업 명
						, {name:"popupNm", label:'<spring:message code="column.popup_nm" />', width:"200", align:"center"}
						
                        // 팝업 유형 코드
                        , {name:"popupTpCd", label:'<spring:message code="column.popup_tp_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.POPUP_TP}" />"}}						

						// 서비스 구분 코드
						, {name:"svcGbCd", label:'<spring:message code="column.svc_gb_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.SVC_GB}" />"}}

						/* // 사이트 구분 코드
						, {name:"stGbCd", label:'<spring:message code="column.st_gb_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.SHOW_GB}" />"}}
 						*/
						, _GRID_COLUMNS.dispYn
						
						// 전시 시작 일시
						, {name:"dispStrtDtm", label:'<spring:message code="column.disp_strt_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}

						// 전시 종료 일시
						, {name:"dispEndDtm", label:'<spring:message code="column.disp_end_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}

						/* //사이트 ID
						, {name:"stId", label:"<spring:message code='column.st_id' />", width:"100", align:"center"}
						
						//  사이트 명
						, {name:"stNm", label:"<spring:message code='column.st_nm' />", width:"200", align:"center", sortable:false }
 						*/
 						, _GRID_COLUMNS.sysRegrNm
						, _GRID_COLUMNS.sysRegDtm
					]
				, onCellSelect : function (id, cellidx, cellvalue) {
					// 팝업 상세
					popupView(id);
				}
			};
			grid.create("popupGroupList", options);
		}

		// 팝업 상세
		function popupView(popupNo){
			addTab('팝업 상세', '/display/popupDetailView.do?popupNo=' + popupNo);
		}

		// 팝업 등록
		function popupInsertView(){
			addTab('팝업 등록', '/display/popupInsertView.do');
		}

		// 팝업 검색
		 function searchPopupList(){
			//검색버튼 click이후에 alert창 띄우기 
				compareDateAlert("strtDate", "endDate", "term");
			
			var options = {
					searchParam : $("#popupListForm").serializeJson()
			};
			gridReload('strtDate','endDate','popupGroupList','term', options);
		}

		// 팝업 초기화
		function searchReset(from){
			resetForm(from);
		}

		// 기간 검색
		function searchDateChange(){
			var dateChange = $("#checkOptDate").children("option:selected").val();
			if(dateChange == "" ) {
				$("#strtDate").val("");
				$("#endDate").val("");
			} else if(dateChange == "50"){
				//3개월 기간조회시에만 호출하는 메소드
				setSearchDateThreeMonth("strtDate", "endDate");
			}else {
				setSearchDate(dateChange, "strtDate", "endDate" );
			}
		}
		</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<form name="popupListForm" id="popupListForm" method="post">
			<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
				<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
					<table class="table_type1">
						<caption>팝업 검색 목록</caption>
						<tbody>
							<tr>
								<th scope="row">
									<spring:message code="column.sys_reg_dtm" />
								</th>
								<td colspan="3">
									<!-- 기간 -->
									<frame:datepicker startDate="strtDate" endDate="endDate" startValue="${frame:toDate('yyyy-MM-dd')}" endValue="${frame:toDate('yyyy-MM-dd')}" />
									&nbsp;&nbsp;
									<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD}" selectKey="${adminConstants.SELECT_PERIOD_40}" defaultName="기간 선택"/>
									</select>
								</td>
								<th><spring:message code="column.disp_yn"/></th>
								<td>
									<!-- 전시 여부-->
									<select name="dispYn" id="dispYn" title="<spring:message code="column.disp_yn"/>" >
										<frame:select grpCd="${adminConstants.DISP_YN}" defaultName="선택" showValue="false" />
									</select>
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.popup_nm"/></th>
								<td>
									<!-- 팝업 명-->
									<input type="text" name="popupNm" id="popupNm" title="<spring:message code="column.popup_nm"/>" value="" />
								</td>
		                        <th><spring:message code="column.popup_tp_cd"/></th>
		                        <td>
		                            <!-- 팝업 유형 코드-->
		                            <select name="popupTpCd" id="popupTpCd" title="<spring:message code="column.popup_tp_cd"/>" >
		                                <frame:select grpCd="${adminConstants.POPUP_TP}" defaultName="선택" showValue="false" />
		                            </select>
		                        </td>
							</tr>
							<tr>
								<%-- <th><spring:message code="column.show_gb_cd"/></th>
								<td>
									<!-- 사이트 구분 코드-->
									<select name="stGbCd" id="stGbCd" title="<spring:message code="column.st_gb_cd"/>">
										<frame:select grpCd="${adminConstants.SHOW_GB}" defaultName="선택" showValue="true" />
									</select>
								</td> --%>
		                        <!-- th scope="row"><spring:message code="column.st_id" /></th>
		                        <td>
		                            <frame:stId funcNm="searchSt()" />
		                        </td -->						
								<th><spring:message code="column.svc_gb_cd"/></th>
								<td colspan="3">
									<!-- 서비스 구분 코드-->
									<select name="svcGbCd" id="svcGbCd" title="<spring:message code="column.svc_gb_cd"/>">
										<frame:select grpCd="${adminConstants.SVC_GB}" defaultName="선택" showValue="false" />
									</select>
								</td>					
							</tr>
						</tbody>
					</table>
		
					<div class="btn_area_center">
						<button type="button" onclick="searchPopupList();" class="btn btn-ok">검색</button>
						<button type="button" onclick="searchReset('popupListForm');" class="btn btn-cancel">초기화</button>
					</div>
				</div>
			</div>
			<div class="mModule">
				<button type="button" onclick="popupInsertView();" class="btn btn-add">팝업 등록</button>
				
				<table id="popupGroupList" ></table>
				<div id="popupGroupListPage"></div>
			</div>
		</form>
	</t:putAttribute>

</t:insertDefinition>