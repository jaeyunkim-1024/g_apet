<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// 가입탈퇴현황 리스트 생성
			searchDateChange();
			createMembetStatsGrid();
			//날짜선택시 selectbox 기간선택문구로 변경 
			newSetCommonDatePickerEventOptions("#startDtm", "#endDtm", "#checkRegDate"); 
		});

		// 가입탈퇴현황 리스트
		function createMembetStatsGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/memberStatsListGrid.do'/>"
				, height : 500
				, searchParam : $("#memberStatsForm").serializeJson()
				, colModels : [
					//구분
					{name:"mbrFlowGbCd", label:"<spring:message code='column.statistics.gubun' />", width:"120", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.MBR_FLOW_GB}" />"}}
					// 총합계
					, {name:"totMbrCnt", label:"<spring:message code='column.statistics.memer.totcnt' />", width:"100", align:"center", sortable:false, summaryType:"sum",formatter:'integer'}
					// 여성 20대
					,{name:"fm20", label:"<spring:message code='column.statistics.fm20' />", width:"100", align:"center", sortable:false, formatter:'integer' }
					// 여성 30대
					, {name:"fm30", label:"<spring:message code='column.statistics.fm30' />", width:"100", align:"center", sortable:false,formatter:'integer'}
					// 여성 40대
					, {name:"fm40", label:"<spring:message code='column.statistics.fm40' />", width:"100", align:"center", sortable:false ,formatter:'integer'}
					// 여성 50대
					, {name:"fm50", label:"<spring:message code='column.statistics.fm50' />", width:"100", align:"center", sortable:false ,formatter:'integer'}
					// 여성 60대
					, {name:"fm60", label:"<spring:message code='column.statistics.fm60' />", width:"100", align:"center", sortable:false ,formatter:'integer'}
					// 여성 합계
					, {name:"femaleSum", label:"<spring:message code='column.statistics.femaleSum' />", width:"100", align:"center", sortable:false ,formatter:'integer'}
					// 남성 20대
					, {name:"ml20", label:"<spring:message code='column.statistics.ml20' />", width:"100", align:"center", sortable:false ,formatter:'integer'}
					// 남성 30대
					, {name:"ml30", label:"<spring:message code='column.statistics.ml30' />", width:"100", align:"center", sortable:false,formatter:'integer'}
					// 남성 40대
					, {name:"ml40", label:"<spring:message code='column.statistics.ml40' />", width:"100", align:"center", sortable:false ,formatter:'integer'}
					// 남성 50대
					, {name:"ml50", label:"<spring:message code='column.statistics.ml50' />", width:"100", align:"center", sortable:false,formatter:'integer'}
					// 남성 60대
					, {name:"ml60", label:"<spring:message code='column.statistics.ml60' />", width:"100", align:"center", sortable:false,formatter:'integer'}
					// 남성 합계
					, {name:"maleSum", label:"<spring:message code='column.statistics.maleSum' />", width:"100", align:"center", sortable:false ,formatter:'integer'}
				]
				, gridComplete : function () {

				}
			}

			grid.create("memberStatsList", gridOptions);

			// Header Group
			$("#memberStatsList").jqGrid('setGroupHeaders', {
			  useColSpanStyle: true,
			  groupHeaders:[
				{startColumnName: 'fm20', numberOfColumns: 6, titleText: '여성'},
				{startColumnName: 'ml20', numberOfColumns: 6, titleText: '남성'}
			  ]
			});
		}

		// 검색
		function searchMemberStatsList() {
			//검색버튼 click이후에 alert창 띄우기 
			compareDateAlertOptions("startDtm", "endDtm", "checkRegDate");
// 			$("#startDtm").val($("#startDtm").val().replace(/\-/g,'') );
//  			$("#endDtm").val($("#endDtm").val().replace(/\-/g,'') );
			var options = {
				searchParam : $("#memberStatsForm").serializeJson()
			};
			
			gridReload('startDtm','endDtm','memberStatsList','term', options);
			
		}
		
		//조회기간
		function searchDateChange(){
			var term = $("[name=checkRegDate] option:selected").val();
			if(term == "") {
				$("#startDtm").val("");
				$("#endDtm").val("");
			}else if(term == "50"){
				//3개월 기간조회시에만 호출하는 메소드
				setSearchDateThreeMonth("startDtm", "endDtm");
			}else {
				setSearchDate(term, "startDtm", "endDtm");
			}
		}
		
		//초기화
		function searchReset(){
			resetForm ("memberStatsForm");
			searchDateChange();
		}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form id="memberStatsForm" name="memberStatsForm" method="post" >
					<table class="table_type1">
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<!-- 조회 기간 -->
								<th scope="row"><spring:message code="column.statistics.period" /></th>
								<td colspan="3">
									<frame:datepicker startDate="startDtm" endDate="endDtm"  startValue="${frame:toDate('yyyy-MM-dd') }" endValue="${frame:toDate('yyyy-MM-dd') }" />&nbsp;&nbsp;
									<select id="checkRegDate" name="checkRegDate" onchange="searchDateChange();">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_40}"  defaultName="기간선택" />
									</select>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
		
				<div class="btn_area_center">
					<button type="button" onclick="searchMemberStatsList();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>
		<div class="mModule">
			<table id="memberStatsList" class="grid"></table>
		</div>
	</t:putAttribute>
</t:insertDefinition>