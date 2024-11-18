<%--	
 - Description	: 공통 시리즈 조회 팝업 View
 - Since		: 2020.12.22
 - Author		: CJA
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">
	$(document).ready(function() {
		searchDateChange();
	});
	
	function searchDateChange() {
		$("#seriesSearchForm #sysRegDtmStart").addClass("validate[required]");
		$("#seriesSearchForm #sysRegDtmEnd").addClass("validate[required]");
		var term = $("#seriesSearchForm #checkOptDate").children("option:selected").val();
		if(term == "") {
			$("#seriesSearchForm #sysRegDtmStart").val("");
			$("#seriesSearchForm #sysRegDtmEnd").val("");
		} else {
			setSearchDate(term, "seriesSearchForm #sysRegDtmStart", "seriesSearchForm #sysRegDtmEnd");
		}
	}
	
	// 시리즈 전시상태 일괄 변경 step1
	function batchUpdateSeriesStat () {
		if($("#seriesStatUpdateGb option:selected").val() == "" || $("#seriesStatUpdateGb option:selected").val() == null){
			messager.alert("<spring:message code='column.common.petlog.update.gb' />", "Info", "info");
			$("#seriesStatUpdateGb").focus();
			return;
		}
		var grid = $("#layerSeriesList");
		var rowids = grid.jqGrid('getGridParam', 'selarrrow');
		if(rowids.length <= 0 ) {
			messager.alert("<spring:message code='column.common.petlog.update.no_select' />", "Info", "info");
			return;
		}
		
		var seriesStatUpdateGb = $("#seriesStatUpdateGb").children("option:selected").val();
		seriesUpdateProc ();
		
	}
	// 시리즈 전시상태 일괄 변경 step2
	function seriesUpdateProc () {
		messager.confirm("<spring:message code='column.sris.confirm.batch_update' />",function(r){
			if(r){
				var seriesStatUpdateGb = $("#seriesStatUpdateGb").children("option:selected").val();
				var srisNos = new Array();
				var flNos = new Array();	
				var grid = $("#layerSeriesList");
				var selectedIDs = grid.getGridParam ("selarrrow");
				
				for (var i = 0; i < selectedIDs.length; i++) {
					var srisNo = grid.getCell(selectedIDs[i], 'srisNo');
					var flNo =  grid.getCell(selectedIDs[i], 'flNo');
					srisNos.push (srisNo );		
					flNos.push (flNo );	
				}
				
				var sendData = {
					srisNos : srisNos
					, seriesStatUpdateGb:seriesStatUpdateGb
					, flNos : flNos
				};
						
				var options = {
					url : "<spring:url value='/series/updateSeriesStat.do' />"
					, data : sendData
					, callBack : function(data ) {
						messager.alert("<spring:message code='column.common.edit.final_msg' />", "Info", "info", function(){
							layerSeriesList.searchSeriesList();
							$("#seriesStatUpdateGb").val("");
							
						});
					}
				};
				ajax.call(options);
			}
		});
	}
	
	// 시리즈 등록
	function registSeries() {
		addTab('시리즈 등록', '/series/seriesInsertView.do?');
	}
</script>


<form name="seriesSearchForm" id="seriesSearchForm" method="post">
		<table class="table_type1">
			<caption>시리즈 조회</caption>
			<tbody>
				<tr>
					<th scope="row"><spring:message code="column.regdate" /><strong class="red">*</strong></th>
					<td colspan = "3">
						<!-- 등록일--> 
						<frame:datepicker startDate="sysRegDtmStart"
										  startValue="${frame:toDate('yyyy-MM-dd') }"
										  endDate="sysRegDtmEnd" 
										  endValue="${frame:toDate('yyyy-MM-dd') }"/>&nbsp;&nbsp;
						<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();" style="width: 120px !important;">
							<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_50 }" defaultName="기간선택" />
						</select>
					</td>					
				</tr>
				<tr>
					<th scope="row"><spring:message code="column.sris_id" /></th>
					<td>
						<input type="text" name="srisId" id="srisId" />
					</td>
					<th scope="row"><spring:message code="column.use_yn" /></th>
					<td>
						<!-- 검색어 -->
						<frame:radio name="dispYn" grpCd="${adminConstants.DISP_STAT }" defaultName="전체" />
					</td>
				</tr>
				<tr>
					<th scope="row"><spring:message code="column.type" /></th>
					<td>
						<select class="wth100" name="tpCd" id="tpCd" title="<spring:message code="column.type"/>">
								<frame:select grpCd="${adminConstants.APET_TP}" defaultName="전체" />
							</select>
					</td>
					<th scope="row"><spring:message code="column.sris_ad_yn" /></th>
					<td>
						<!-- 검색어 -->
						<frame:radio name="adYn" grpCd="${adminConstants.AD_YN }" defaultName="전체" />
					</td>
				</tr>
				<tr>
					<th scope="row"><spring:message code="column.sris_nm" /></th>
					<td colspan = "3">
						<input type="text" name="srisNm" id="srisNm" class="w400" />
					</td>
				</tr>
			</tbody>
		</table>
</form>
				<div class="btn_area_center">
					<button type="button" onclick="layerSeriesList.searchSeriesList();" class="btn btn-ok">검색</button>
					<button type="button" onclick="layerSeriesList.searchReset();" class="btn btn-cancel">초기화</button>
				</div>
				<hr />

				<div class="mModule">
			<div class = "mButton">
				<div class = "leftInner">
					<div id = "pageArea" style = "margin-top:15px;"></div>
				</div>
				<div id="resultArea" class = "rightInner">
					<select id="seriesStatUpdateGb" name="seriesStatUpdateGb" >							
						<frame:select grpCd="${adminConstants.DISP_STAT }" defaultName="선택" />
					</select>
					<button type="button" onclick="batchUpdateSeriesStat();" class="btn btn-add">일괄 변경</button>
					<button type="button" onclick="registSeries();" class="btn btn-add" style = "background-color: #0066CC;">+ 시리즈 등록</button>											
				</div>
			</div>
			
			<table id="layerSeriesList" ></table>
			<div id="layerSeriesListPage"></div>
		</div>
