<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				searchDateChange();
				createGiftGrid();
				//날짜선택시 selectbox 기간선택문구로 변경 
			 	newSetCommonDatePickerEvent("#strtDtm", "#endDtm");

				//엔터 키 이벤트
				$(document).on("keydown","#giftSearchForm input[type='text']",function(e){
					if (e.keyCode == 13) {
						reloadGiftGrid();
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

			// 그룹 코드 리스트
			function createGiftGrid(){
				var options = {
					url : "<spring:url value='/promotion/giftListGrid.do' />"
					, height : 400
					, searchParam : $("#giftSearchForm").serializeJson()
					, colModels : [
						{name:"prmtNo", label:'<b><u><tt><spring:message code="column.prmt_no" /></tt></u></b>', width:"100", align:"center", classes:'pointer fontbold'}
						, {name:"prmtNm", label:'<spring:message code="column.prmt_nm" />', width:"300", align:"center", cellattr:function(){
							return 'style="text-overflow:ellipsis;white-space:nowrap;word-wrap:normal;width:100px;overflow:hidden";';
						}}
						, {name:"stNms", label:'<spring:message code="column.st_nm" />', width:"120", align:"center"}		// 사이트 명
						, {name:"prmtStatCd", label:'<spring:message code="column.prmt_stat_cd" />', width:"120", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.PRMT_STAT}" />"}}
						, {name:"aplStrtDtm", label:'<spring:message code="column.apl_strt_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"aplEndDtm", label:'<spring:message code="column.apl_end_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, _GRID_COLUMNS.sysRegrNm
						, _GRID_COLUMNS.sysRegDtm
						, _GRID_COLUMNS.sysUpdrNm
						, _GRID_COLUMNS.sysUpdDtm
					]
					, onSelectRow : function(ids) {
						var rowData = $("#giftList").getRowData(ids);
						if(!isNaN(rowData.prmtNo)){
							giftView(rowData.prmtNo);
						}
					}
					, gridComplete : function() {

						var grid = $("#giftList").jqGrid('getRowData');
						if(grid.length <= 0) {
							var str = "";
							str += "<tr id='noData' role='row' class='jqgrow ui-row-ltr ui-widget-content'>";
							str += "	<td role='gridcell' colspan='10' style='text-align:center;'>조회결과가 없습니다.</td>";
							str += "</tr>"
								
							$("#giftList.ui-jqgrid-btable").append(str);
						}
					}
				};
				grid.create("giftList", options);
			}

			function reloadGiftGrid(){
				//검색버튼 click이후에 alert창 띄우기 
				compareDateAlert("strtDtm", "endDtm", "term");
			
				var options = {
					searchParam : $("#giftSearchForm").serializeJson()
				};
				gridReload('strtDtm','endDtm','giftList','term', options);
			}

			function giftView(prmtNo) {
				if (prmtNo == '')
					addTab('사은품 프로모션 등록', '/promotion/giftView.do');
				else
					addTab('사은품 프로모션 상세', '/promotion/giftView.do?prmtNo=' + prmtNo);
			}

			function searchDateChange() {
				var term = $("#checkOptDate").children("option:selected").val();
				if(term == "") {
					$("#strtDtm").val("");
					$("#endDtm").val("");
				}else if(term == "50"){
					//3개월 기간조회시에만 호출하는 메소드
    				setSearchDateThreeMonth("strtDtm", "endDtm");					
				}else{
					setSearchDate(term, "strtDtm", "endDtm");
				}
			}

			function searchReset() {
				resetForm ("giftSearchForm");
				searchDateChange();
				reloadGiftGrid();
			}

		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion"
			data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect"
			style="width: 100%">
			<div title="<spring:message code='admin.web.view.common.search' />"
				style="padding: 10px">
				<form name="giftSearchForm" id="giftSearchForm" method="post">
					<table class="table_type1">
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<!-- 프로모션 번호 -->
								<th scope="row"><spring:message code="column.prmt_no" /></th>
								<td><input type="text" class="numeric" name="prmtNo"
									title="<spring:message code="column.prmt_no" />"></td>
								<!-- 프로모션 상태 -->
								<th scope="row"><spring:message code="column.prmt_stat_cd" /></th>
								<td>
									<select name="prmtStatCd" id="prmtStatCd" title="<spring:message code="column.prmt_stat_cd"/>">
										<frame:select grpCd="${adminConstants.PRMT_STAT}" defaultName="상태"/>
									</select>
								
								<!-- 사이트 ID -->																
								<th scope="row"><spring:message code="column.st_id" /></th>
								<td><select id="stIdCombo" name="stId">
										<frame:stIdStSelect defaultName="사이트선택" />
								</select></td>									
							</tr>
							<tr>
								<!-- 프로모션명 -->
								<th scope="row"><spring:message code="column.prmt_nm" /></th>
								<td><input type="text" name="prmtNm"
									title="<spring:message code="column.prmt_nm" />"></td>
									
								<th scope="row"><spring:message code="column.common.date" /></th>
								<td colspan='3'><frame:datepicker startDate="strtDtm" endDate="endDtm" startValue="${frame:toDate('yyyy-MM-dd') }" endValue="${frame:toDate('yyyy-MM-dd') }" />
									<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();" style="width:120px !important;">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_40}" defaultName="기간선택" />
									</select>

								</td>
								
							</tr>
						</tbody>
					</table>
				</form>

				<div class="btn_area_center">
					<button type="button" onclick="reloadGiftGrid();"
						class="btn btn-ok">조회</button>
					<button type="button" onclick="searchReset();"
						class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

		<div class="mModule">
			<button type="button" onclick="giftView('');" class="btn btn-add">+ 등록</button>

			<table id="giftList"></table>
			<div id="giftListPage"></div>
		</div>

	</t:putAttribute>
</t:insertDefinition>
