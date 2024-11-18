<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				searchDateChange();
				createPromotionGrid();
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
			function createPromotionGrid(){
				var options = {
					url : "<spring:url value='/promotion/promotionListGrid.do' />"
					, height : 400
					, searchParam : $("#promotionSearchForm").serializeJson()
					, colModels : [
						{name:"prmtNo", label:'<b><u><tt><spring:message code="column.prmt_no" /></tt></u></b>', width:"100", align:"center", sortable:false, formatter:'integer', classes:'pointer fontbold'}
						, {name:"prmtNm", label:'<spring:message code="column.prmt_nm" />', width:"400", align:"center"}
						, {name:"prmtTgCd", label:'<spring:message code="column.prmt_tg_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_TG}" />"}}
						, {name:"prmtStatCd", label:'<spring:message code="column.prmt_stat_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_STAT}" />"}}
						, {name:"prmtAplCd", label:'<spring:message code="column.prmt_apl_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_APL}" />"}}
						, {name:"aplStrtDtm", label:'<spring:message code="column.apl_strt_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"aplEndDtm", label:'<spring:message code="column.apl_end_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
                        , {name:"stNms", label:'<spring:message code="column.st_nm" />', width:"120", align:"center"}
                        , _GRID_COLUMNS.sysRegrNm
                        , _GRID_COLUMNS.sysRegDtm
                        , _GRID_COLUMNS.sysUpdrNm
                        , _GRID_COLUMNS.sysUpdDtm
					]
					, onSelectRow : function(ids) {
						var rowdata = $("#promotionList").getRowData(ids);
						promotionView(rowdata.prmtNo);
					}
				};
				grid.create("promotionList", options);
			}

			function reloadPromotionGrid(){
				var options = {
					searchParam : $("#promotionSearchForm").serializeJson()
				};

				grid.reload("promotionList", options);
			}

			function promotionView(prmtNo) {
				addTab('할인 프로모션 상세', '/promotion/promotionView.do?prmtNo=' + prmtNo);
			}
			
            function promotionInsertView() {
                addTab('할인 프로모션 등록', '/promotion/promotionInsertView.do');
            }
            
            function searchDateChange() {
    			var term = $("#checkOptDate").children("option:selected").val();
    			if(term == "") {
    				$("#aplStrtDtm").val("");
    				$("#aplEndDtm").val("");
    			} else {
    				setSearchDate(term, "aplStrtDtm", "aplEndDtm");
    			}
    		}
            
         	// 초기화 버튼클릭
    		function searchReset () {
    			resetForm ("promotionSearchForm");
    			searchDateChange();
    		}
         	
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion"
			data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect"
			style="width: 100%">
			<div title="<spring:message code='admin.web.view.common.search' />"
				style="padding: 10px">
				<form name="promotionSearchForm" id="promotionSearchForm">
					<table class="table_type1">
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.prmt_nm" /></th>
								<td>
									<input type="text" name="prmtNm" id="prmtNm" title="<spring:message code="column.prmt_nm" />">
								</td>
								<th scope="row"><spring:message code="column.st_id" /></th>
								<!-- 사이트 ID -->
								<td>
									<select id="stIdCombo" class="wth100" name="stId">
										<frame:stIdStSelect defaultName="사이트선택" />
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.common.date" /></th>
								<td>
									<frame:datepicker startDate="aplStrtDtm" endDate="aplEndDtm" startValue="${frame:toDate('yyyy-MM-dd') }" endValue="${frame:toDate('yyyy-MM-dd') }" />
									&nbsp;&nbsp;
									<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }" defaultName="기간선택" />
									</select>
								</td>

								<th scope="row"><spring:message code="column.prmt_stat_cd" /></th>
								<td>
									<select name="prmtStatCd" id="prmtStatCd" title="<spring:message code="column.prmt_stat_cd" />">
										<frame:select grpCd="${adminConstants.PRMT_STAT}" defaultName="선택" />
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.prmt_tg_cd" /></th>
								<td>
									<select name="prmtTgCd" id="prmtTgCd" title="<spring:message code="column.prmt_tg_cd" />">
										<frame:select grpCd="${adminConstants.PRMT_TG}" useYn="Y" defaultName="선택" />
									</select>
								</td>
								<th scope="row"><spring:message code="column.prmt_apl_cd" /></th>
								<td>
									<select name="prmtAplCd" id="prmtAplCd" title="<spring:message code="column.prmt_apl_cd" />">
										<frame:select grpCd="${adminConstants.PRMT_APL}" defaultName="선택" />
									</select>
								</td>
							</tr>
						</tbody>
					</table>
				</form>

				<div class="btn_area_center">
					<button type="button" onclick="reloadPromotionGrid();"
						class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();"
						class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

		<div class="mModule">
			<button type="button" onclick="promotionInsertView();"
				class="btn btn-add">할인 프로모션 등록</button>

			<table id="promotionList"></table>
			<div id="promotionListPage"></div>
		</div>

	</t:putAttribute>
</t:insertDefinition>
