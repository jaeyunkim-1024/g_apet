<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function(){
		// 	eventGrid(); 
			//검색조건 
		 	newSetCommonDatePickerEvent("#strtDate", "#endDate");
			
            $(document).on("keydown","#eventListForm input",function(){
      			if ( window.event.keyCode == 13 ) {
      				searchEventList();
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

		// 이벤트 리스트
		function eventGrid(){
			var options = {
				url : "<spring:url value='/event/eventBaseGrid.do' />"
				, height : 400
				, searchParam : $("#eventListForm").serializeJson()
				, colModels : [
						//이벤트 번호
						{name:"eventNo", label:'이벤트 No.', width:"80", align:"center", sortable:false, formatter:'integer', key: true, classes:'pointer fontbold'}

						// 이벤트 유형 코드
						, {name:"eventTpCd", label:'이벤트 유형', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.EVENT_TP}" />"}}

						// 이벤트 구분 코드
						, {name:"eventGbCd", label:'이벤트 구분', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.EVENT_GB}" />"}}

						// 이벤트 타입
						, {name:"eventGb2Cd", label:'이벤트 타입', width:"140", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.EVENT_GB2_CD}" />"}}

						// 이벤트 명
						, {name:"ttl", label:'이벤트 명', width:"220", align:"center"}

						// 이벤트 기간
						, {name:"aplPeriod", label:'이벤트 기간', width:"200", align:"center" , formatter : function(cellvalue, options, rowObject){
							var result = rowObject.aplStrtDtmStr + "~" + rowObject.aplEndDtmStr;
							return result;
						}}

						// 진행상황
						, {name:"eventStatCd", label:'진행상황', width:"140", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.EVENT_STAT}" />"}}

						// 참여자 수
						, {name:"entryCnt", label:'참여자 수', width:"80", align:"center" , classes:'pointer fontbold',formatter : function(cellvalue, options, rowObject){
							var result = rowObject.entryCnt == undefined || rowObject.entryCnt === "" ? 0 : rowObject.entryCnt;
							return result;
						}}

						//당첨자 결과
						, {name:"winRst", label:'당첨자 결과', width:"80", align:"center" ,classes:'pointer fontbold', formatter : function(cellvalue, options, rowObject){
							var winRstYn = rowObject.winRstYn == undefined || rowObject.winRstYn === "" ? "${adminConstants.COMM_YN_N}" : rowObject.winRstYn;
							var result = winRstYn === "${adminConstants.COMM_YN_N}" ? "미발표" : "발표" ;
							return result;
						}}
						,	_GRID_COLUMNS.sysRegrNm
						,	_GRID_COLUMNS.sysRegDtm

					]
				, onCellSelect : function (id, cellidx, cellvalue) {
					if(cellidx == 7 || cellidx == 8){
						var obj = $("#eventGridList").jqGrid("getRowData",id);
						addTab("이벤트 참여자 목록","/event/eventParticipantManageView.do?eventNo="+obj.eventNo);
					}
					else if(cellidx != 0) {
						eventDetailVIew(id);
					}
				}
			};
			grid.create("eventGridList", options);
		}

		// 이벤트 수정
		function eventDetailVIew (eventNo){
			addTab('이벤트 상세', '/event/eventDetailView.do?eventNo=' + eventNo);
		}

		// 이벤트 등록
		function eventInsertView (){
			addTab('이벤트 등록', '/event/eventInsertView.do');
		}

		// 이벤트 검색 조회
		function searchEventList(){
			//검색버튼 click이후에 alert창 띄우기 
			compareDateAlert("strtDate", "endDate", "term");
			
			var options = {
				searchParam : $("#eventListForm").serializeJson()
			};
			
			gridReload('strtDate','endDate','eventGridList','term', options);
			
		}

		// 초기화 버튼 클릭
		function searchReset(){
			resetForm ("eventListForm");
			searchDateChange();
		}

		function searchDateChange() {
			var term = $("[name=checkOptDate] option:selected").val();
			if(term == "") {
				$("#strtDate").val("");
				$("#endDate").val("");
			}else if(term == "50"){
				//3개월 기간조회시에만 호출하는 메소드
				setSearchDateThreeMonth("strtDate", "endDate");
			}else {
				setSearchDate(term, "strtDate", "endDate");
			}
		}

		$(function(){
			searchDateChange();
//			setCommonDatePickerEvent("#strtDate","#endDate");
			eventGrid();
		})
		</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<form name="eventListForm" id="eventListForm" method="post">
			<select style="display:none;" name="stId" style="display:none;"><frame:stIdStSelect stId="1"/></select>
			<div class="easyui-accordion search-accordion"
				data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect"
				style="width: 100%">
				<div title="<spring:message code='admin.web.view.common.search' />"
					style="padding: 10px">
					<table class="table_type1">
						<caption>이벤트 검색 목록</caption>
						<colgroup>
							<col width="13%" />
							<col width="25%" />
							<col width="13%" />
						</colgroup>
						<tbody>
							<tr>
								<th>이벤트 타입</th>
								<td>
									<!-- 이벤트 구분 코드-->
									<select name="eventGb2Cd" id="eventGb2Cd" title="<spring:message code="column.event_gb_cd"/>">
										<frame:select grpCd="${adminConstants.EVENT_GB2_CD}" defaultName="전체" showValue="false" excludeOption="${adminConstants.EVENT_GB2_CD_10}" />
<%-- 										<frame:select grpCd="${adminConstants.EVENT_GB2_CD}" showValue="false" /> --%>
									</select>
								</td>

								<th>진행 상태</th>
								<td>
									<frame:radio name="eventStatCd" grpCd="${adminConstants.EVENT_STAT}" defaultName="전체" />
								</td>
							</tr>
							<tr>
								<th>이벤트 명</th>
								<td>
									<!-- 제목-->
									<input type="text" class="input_text w175" name="ttl" id="ttl" title="<spring:message code="column.ttl"/>" value="" />
								</td>

								<th scope="row">등록일</th>
								<td>
									<!-- 기간 -->
									<frame:datepicker startDate="strtDate" endDate="endDate" startValue="${frame:toDate('yyyy-MM-dd') }" endValue="${frame:toDate('yyyy-MM-dd') }" />&nbsp;&nbsp;
									&nbsp;&nbsp;
									<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD}" selectKey="${adminConstants.SELECT_PERIOD_40}" defaultName="기간선택" />
									</select>
								</td>
							</tr>
						</tbody>
					</table>

					<div class="btn_area_center">
						<button type="button" onclick="searchEventList();" class="btn btn-ok">검색</button>
						<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
					</div>
				</div>
			</div>

			<div class="buttonArea mt30" style="text-align:right;">
				<button type="button" onclick="eventInsertView();" class="btn btn-add">이벤트 등록</button>
			</div>
			<div class="mModule" style="margin-top:10px;">
				<table id="eventGridList"></table>
				<div id="eventGridListPage"></div>
			</div>
		</form>
	</t:putAttribute>

</t:insertDefinition>