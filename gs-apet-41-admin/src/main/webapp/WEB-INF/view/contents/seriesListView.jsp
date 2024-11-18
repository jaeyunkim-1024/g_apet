<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<style>
			th.ui-th-column div { white-space:normal !important; height:auto !important; }
		</style>
		<script type="text/javascript">		
		var isGridExists = false;		
		$(document).ready(function() {
			newSetCommonDatePickerEvent('#sysRegDtmStart','#sysRegDtmEnd');			
			searchDateChange();
			createSeriesGrid();
			
			//엔터키 
			$(document).on("keydown","#seriesListForm input",function(){
    			if ( window.event.keyCode == 13 ) {
    				searchSeriesList();
  		  		}
            });
		});
		
		// 시리즈관리 Grid
		function createSeriesGrid () {
			var _lebel = "<spring:message code='column.sys_reg_dt' /><br/>(<spring:message code='column.sys_upd_dt' />)";
			var gridOptions = {
				  url : "<spring:url value='/series/listSeries.do' />"	
 				, height : 400 				
				, searchParam : $("#seriesListForm").serializeJson()
				, colModels : [
					  {name:"rowIndex", 		label:'<spring:message code="column.no" />', 			width:"60", 	align:"center", sortable:false} /* 번호 */	    
					, {name:"srisId", 			label:'<spring:message code="column.sris_id" />', 		width:"200", 	align:"center", sortable:false, classes:'pointer fontbold'}/* 시리즈ID */					
					, {name:"srisPrflImgPath", 	label:'<spring:message code="column.sris_profile" />',	width:"150", align:"center", classes:'pointer fontbold', sortable:false, formatter: function(cellvalue, options, rowObject) {
						if(rowObject.srisPrflImgPath != "" && rowObject.srisPrflImgPath != null) {							
							var imgPath = rowObject.srisPrflImgPath.indexOf('cdn.ntruss.com') > -1 ? rowObject.srisPrflImgPath :  '${frame:optImagePath("' + rowObject.srisPrflImgPath + '",adminConstants.IMG_OPT_QRY_400)}';							
							return '<img src='+imgPath+' style="width:100px; height:100px;" onError="this.src=\'/images/noimage.png\'" />';[]							
						} else {
							return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
						}
						} /* 시리즈프로필 */
					}
					, {name:"srisNm", 			label:"<spring:message code='column.sris_nm' />", 		width:"500", 	align:"left", sortable:false, classes:'pointer fontbold'} /* 시리즈명 */
					, {name:"sesnCnt",			label:"<spring:message code='column.sesn_cnt' />", 		width:"100", 	align:"center", sortable:false} /* 시즌수 */
					, {name:"tpCd", 			label:"<spring:message code='column.type' />",  		align:"left", 	sortable:false, width:"150"
						, editable:true, edittype:'select', formatter:'select', editoptions : {value:"<frame:gridSelect grpCd='${adminConstants.APET_TP}' showValue='false' />"}} /* 타입 */
					, {name:"vdCnt",			label:"<spring:message code='column.vod_cnt' />", 		width:"100", 	align:"center", sortable:false} /* 영상건수 */
					, {name:"adYn",				label:"<spring:message code='column.sris_ad' />", 		width:"100", 	align:"center", sortable:false} /* 광고노출 */	
					, {name:"dispYn", 			label:"<spring:message code='column.vod.disp' />",  		align:"center", sortable:false, width:"100"
						, editable:true, edittype:'select', formatter:'select', editoptions : {value:"<frame:gridSelect grpCd='${adminConstants.DISP_STAT}' showValue='false' />"}} /* 전시 */
					, {name:"regModDtm",		label:_lebel,  align:"center", width:"150", sortable:false} /* 등록수정일 */
					, {name:"srisNo", 			label:'<spring:message code="column.no" />', 			hidden:true,	width:"60", 	align:"center", sortable:false}/* 번호 */
					, {name:"flNo", 			label:'', 												hidden:true,	width:"60", 	align:"center", sortable:false}/* file번호 */		
	                ]

				, multiselect : true
				, onCellSelect : function (id, cellidx, cellvalue) {
					if(cellidx == 3 || cellidx == 4) {						
						var rowData = $("#seriesList").getRowData(id);
						var srisNo = rowData.srisNo;						
						seriesDetail(srisNo );
					}
					
				}
				, gridComplete : function (){
					jQuery("#seriesList").jqGrid( 'setGridWidth', $(".mModule").width() );
				}
			}
			grid.create("seriesList", gridOptions);
			isGridExists = true;
		}

		// 검색 조회
		function searchSeriesList () {
			compareDateAlert('sysRegDtmStart','sysRegDtmEnd','term');			
			var sysRegDtmStartVal = $("#sysRegDtmStart").val();
			var sysRegDtmEndVal = $("#sysRegDtmEnd").val();
			
    		var dispStrtDtm = $("#sysRegDtmStart").val().replace(/-/gi, "");
			var dispEndDtm = $("#sysRegDtmEnd").val().replace(/-/gi, "");
			var diffMonths = getDiffMonths(dispStrtDtm, dispEndDtm);
			var term = $("#checkOptDate").children("option:selected").val();
			
			if (! isGridExists) {
				createSeriesGrid();
			}						
			
			if(validate.check("seriesListForm")) {
				var options = {
					searchParam : $("#seriesListForm").serializeJson()
				};
				if((sysRegDtmStartVal != "" && sysRegDtmEndVal != "") || (sysRegDtmStartVal == "" && sysRegDtmEndVal == "")){ // 시작날짜 종료날짜 둘다 있을 때 시작날짜 종료날짜 둘다 없을 때만 조회
					if(term == "50" || diffMonths <= 3){ 				//날짜 3개월 이상 차이 날때 조회 X term이 3개월일 때는 예외적 허용 예를들어 2월 28일과 5월 31일은 90일이 넘기때문
						grid.reload("seriesList", options);
					}
				}
			}			
		}

		// 초기화 버튼클릭
		function searchReset () {
			resetForm ("seriesListForm");			
			searchDateChange();
		}


		// 시리즈 전시상태 일괄 변경 step1
		function batchUpdateSeriesStat () {
			if($("#seriesStatUpdateGb option:selected").val() == "" || $("#seriesStatUpdateGb option:selected").val() == null){
				messager.alert("<spring:message code='column.common.petlog.update.gb' />", "Info", "info");
				$("#seriesStatUpdateGb").focus();
				return;
			}
			var grid = $("#seriesList");
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
					var grid = $("#seriesList");
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
								searchSeriesList();
								$("#seriesStatUpdateGb").val("");
								
							});
						}
					};
					ajax.call(options);
				}
			});
		}

		// 등록일 변경
		function searchDateChange() {			
			var term = $("#checkOptDate").children("option:selected").val();
			if(term == "") {
				$("#sysRegDtmStart").val("");
				$("#sysRegDtmEnd").val("");
			} else if(term == "50") {
				setSearchDateThreeMonth("sysRegDtmStart","sysRegDtmEnd");
			} else {
				setSearchDate(term, "sysRegDtmStart", "sysRegDtmEnd");
			}
		}
		// 시리즈 등록
		function registSeries() {
			addTab('시리즈 등록', '/series/seriesInsertView.do?');
		}
		// 시리즈 상세
		function seriesDetail(srisNo) {
			addTab('시리즈 상세', '/series/seriesDetailView.do?srisNo='+srisNo);
		}
		//시리즈 삭제
		function deleteSeries(){
			var grid = $("#seriesList");
			var rowids = grid.jqGrid('getGridParam', 'selarrrow');
			if(rowids.length <= 0 ) {
				messager.alert("<spring:message code='column.sris.no_select' />", "Info", "info");
				return;
			}
			
			messager.confirm("<spring:message code='column.sris.confirm.delete' />",function(r){
				if(r){					
					var srisNos = new Array();						
					var grid = $("#seriesList");
					var selectedIDs = grid.getGridParam ("selarrrow");
					
					for (var i = 0; i < selectedIDs.length; i++) {
						var srisNo = grid.getCell(selectedIDs[i], 'srisNo');
						var sesnCnt =  grid.getCell(selectedIDs[i], 'sesnCnt');
						var vdCnt =  grid.getCell(selectedIDs[i], 'vdCnt');
						if(Number(sesnCnt) > 0){
							messager.alert("<spring:message code='column.sris.check_sesn' />", "Info", "info");
							return;
						}
						if(Number(vdCnt) > 0){
							messager.alert("<spring:message code='column.sris.check_vd' />", "Info", "info");
							return;
						}
						srisNos.push (srisNo );		
					}
					
					var sendData = {
						srisNos : srisNos						
					};
							
					var options = {
						url : "<spring:url value='/series/deleteSeries.do' />"
						, data : sendData
						, callBack : function(data ) {
							var result = data.deleteCnt;
							if(Number(result) > 0){
								messager.alert("삭제 되었습니다.", "Info", "info", function(){
									searchSeriesList();
								});
							}else{
								messager.alert("삭제 실패하였습니다.", "Info", "info");
							}
							
						}
					};
					ajax.call(options); 
				}
			});
			
		}
		

		</script>
	</t:putAttribute>

	<t:putAttribute name="content">

		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<input type = "hidden" id = "selectedPetLogNo" />
				<form id="seriesListForm" name="seriesListForm" method="post">
					<table class="table_type1">
						<caption>정보 검색</caption>
						<colgroup>
							<col style="width:20%;">							
							<col style="width:30%;">
							<col style="width:20$;">
							<col style="width:30%;">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.sys_reg_dt" /><strong class="red">*</strong></th>								
								<!-- 기간 -->
								<td colspan = "3">
									<frame:datepicker startDate="sysRegDtmStart"  startValue="${frame:toDate('yyyy-MM-dd') }" endDate="sysRegDtmEnd" endValue="${frame:toDate('yyyy-MM-dd') }"  readonly = "true"/>&nbsp;&nbsp; 
									<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_40 }" defaultName="기간선택" />
									</select>
								</td>								
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.sris_id" /></th>	
								<!-- 시리즈ID -->							
								<td><input type="text" name="srisId" id="srisId" title="시리즈ID" value="" /></td>
								
								<th scope="row"><spring:message code="column.use_yn" /></th>
								<!-- 사용여부 -->								
								<td>									
									<frame:radio name="dispYn" grpCd="${adminConstants.DISP_STAT }" defaultName="전체" />
								</td>
							</tr>	
							<tr>
								<th scope="row"><spring:message code="column.type" /></th>	
								<!-- 타입 -->
								<td>
									<select title="<spring:message code="column.type" />" name="tpCd">
										<frame:select grpCd="${adminConstants.APET_TP }"  defaultName="전체" />
									</select>
								</td>
								
								<th scope="row"><spring:message code="column.sris_ad_yn" /></th>
								<!-- 광고노출여부 -->								
								<td>									
									<frame:radio name="adYn" grpCd="${adminConstants.AD_YN }" defaultName="전체" />
								</td>
							</tr>						
							<tr>
								<th scope="row"><spring:message code="column.sris_nm" /></th>
								<!-- 시리즈명 -->
								<td colspan = "3">
									<input type="text" class = "w800" name="srisNm" id="srisNm" title="내용" value="" />
								</td>								
							</tr>						
						</tbody>
					</table>					
				</form>
				
				<div class="btn_area_center">
					<button type="button" onclick="searchSeriesList();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

		
		<div class="mModule">
			<div class = "mButton">
				<div class = "leftInner">
					<div id = "pageArea" style = "margin-top:15px;"></div>
				</div>
				<div id="resultArea" class = "rightInner">
					<button type="button" onclick="deleteSeries();" class="btn btn-ok">시리즈 삭제</button>
					<select id="seriesStatUpdateGb" name="seriesStatUpdateGb" >							
						<frame:select grpCd="${adminConstants.DISP_STAT }" defaultName="선택" />
					</select>
					<button type="button" onclick="batchUpdateSeriesStat();" class="btn btn-add">일괄 변경</button>
					<button type="button" onclick="registSeries();" class="btn btn-add" style = "background-color: #0066CC;">+ 시리즈 등록</button>											
				</div>
			</div>
			
			<table id="seriesList"></table>
			<div id="seriesListPage"></div>
		</div>
	</t:putAttribute>

</t:insertDefinition>