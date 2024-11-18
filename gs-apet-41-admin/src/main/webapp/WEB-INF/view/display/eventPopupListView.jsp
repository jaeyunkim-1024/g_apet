<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function(){
			searchDateChange();
			newSetCommonDatePickerEvent('#displayStrtDtm','#displayEndDtm');	
			
			// 팝업 목록그리드
			popupListGrid();
			//엔터키 
            $(document).on("keydown","#popupListForm input",function(){
    			if ( window.event.keyCode == 13 ) {
    				searchPopupList('');
  		  		}
            });
            
		});
		
		
		// 팝업 목록 그리드
		function popupListGrid(){
			var options = {
				url : "<spring:url value='/display/eventPopupListGrid.do' />"
				, height : 400
				, searchParam : $("#popupListForm").serializeJson()
				, sortname : 'evtpopSortSeq'
				, sortorder : 'DESC'
				, colModels : [	
						 {name:"rowIndex", 		label:'<spring:message code="column.no" />', 			width:"60", 	align:"center", sortable:false} /* 번호 */	    
						// 게시구분  
						,  {name:"evtpopGbCd", label:'게시구분', width:"80", align:"center", formatter:'select', editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.EVTPOP_GB}" />"}}
						// 제목
						, {name:"evtpopTtl", label:'<spring:message code="column.ttl" />', width:"250", align:"center"}						
                        // 위치
                        , {name:"evtpopLocCd", label:'<spring:message code="column.location" />', hidden:true, width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.EVTPOP_LOC}" />"}}
						// 내용
						, {name:"evtpopImgPath", label:'<spring:message code="column.content" />', width:"150", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
								if(rowObject.evtpopImgPath != "" && rowObject.evtpopImgPath != null) {									
									var imgPath = rowObject.evtpopImgPath.indexOf('cdn.ntruss.com') > -1 ? rowObject.evtpopImgPath : '${frame:optImagePath("' + rowObject.evtpopImgPath + '", adminConstants.IMG_OPT_QRY_400)}';
									return '<img src='+imgPath+' style="width:100px; height:100px;" onError="this.src=\'/images/noimage.png\'"  />';
								} else {
									return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
								}
							}
						}
						// 게시기간
						, {name:"displayStrtDtm", label:'게시기간', width:"200", align:"center", sortable:false, formatter: function(rowId, val, rawObject, cm) {
								return new Date(rawObject.displayStrtDtm).format("yyyy-MM-dd") + ' ~\r\n' + new Date(rawObject.displayEndDtm).format("yyyy-MM-dd");
							}
						}
						// 노출순서
						, {name:"evtpopSortSeq", label:'노출순서', width:"100", align:"center", sortable:false}
						, {name:"sysRegrNm",	 label:'작성자',	 width:"100", align:"center", sortable:false}
						, {name:"sysRegDtm",	 label:"<spring:message code='column.sys_reg_dt' />", 		width:"150", 	align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd"} /* 등록일 */ 						
						// 진행여부
						, {name:"progressStatCd", label:'진행여부', width:"100", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
								var progerssStat = "진행중";
								if(rowObject.progressStatCd == "STANDBY") {									
									progerssStat = "대기";
								} else if(rowObject.progressStatCd == "CLOSE"){
									progerssStat = "마감";
								}
								return progerssStat;
							}
 						}
 						// 게시여부
 						, {name:"evtpopStatCd", label:'게시여부', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.EVTPOP_STAT}" />"}}
 						, {name:"evtpopNo", label:'이벤트팝업번호', hidden:true, width:"150", align:"center", sortable:false}
					]
				, onCellSelect : function (id, cellidx, cellvalue) {
					// 팝업 상세
					var rowData = $("#popupGroupList").getRowData(id);
					var evtpopNo = rowData.evtpopNo;						
					goEvtpopDetail(evtpopNo);
				}
				, gridComplete : function() {
					$("#noData").remove();
					var grid = $("#popupGroupList").jqGrid('getRowData');
					if(grid.length <= 0) {
						var str = "";
						str += "<tr id='noData' role='row' class='jqgrow ui-row-ltr ui-widget-content'>";
						str += "	<td role='gridcell' colspan='11' style='text-align:center;'>조회결과가 없습니다.</td>";
						str += "</tr>"
							
						$("#popupGroupList.ui-jqgrid-btable").append(str);
					}
					jQuery("#popupGroupList").jqGrid( 'setGridWidth', $(".mModule").width() );
				}
			};
			grid.create("popupGroupList", options);
		}

		// 팝업 상세
		function goEvtpopDetail(evtpopNo){
			addTab('팝업 배너 상세', '/display/eventPopupDetailView.do?evtpopNo=' + evtpopNo);
		}

		// 팝업 등록
		function popupInsertView(){
			addTab('팝업 배너 등록', '/display/eventPopupInsertView.do');
		}

		// 팝업 검색
		 function searchPopupList(){
			compareDateAlert('displayStrtDtm','displayEndDtm','term');			
			var displayStrtDtmVal = $("#displayStrtDtm").val();
			var displayEndDtmVal = $("#displayEndDtm").val();
			
    		var dispStrtDtm = $("#displayStrtDtm").val().replace(/-/gi, "");
			var dispEndDtm = $("#displayEndDtm").val().replace(/-/gi, "");
			var diffMonths = getDiffMonths(dispStrtDtm, dispEndDtm);
			var term = $("#checkOptDate").children("option:selected").val();	
			
			var options = {
					searchParam : $("#popupListForm").serializeJson()
			};
			if((displayStrtDtmVal != "" && displayEndDtmVal != "") || (displayStrtDtmVal == "" && displayEndDtmVal == "")){ // 시작날짜 종료날짜 둘다 있을 때 시작날짜 종료날짜 둘다 없을 때만 조회
				if(term == "50" || diffMonths <= 3){ 				//날짜 3개월 이상 차이 날때 조회 X term이 3개월일 때는 예외적 허용 예를들어 2월 28일과 5월 31일은 90일이 넘기			
				grid.reload("popupGroupList", options);
				}
			}
		}

		// 팝업 초기화
		function searchReset(from){
			resetForm(from);
		}

		// 기간 검색
		function searchDateChange(){
			var term = $("#checkOptDate").children("option:selected").val();
			if(term == "" ) {
				$("#displayStrtDtm").val("");
				$("#displayEndDtm").val("");
			} else if(term == "50") {
				setSearchDateThreeMonth("displayStrtDtm","displayEndDtm");
			} else {
				setSearchDate(term, "displayStrtDtm", "displayEndDtm" );
			}
		}
		
		// 엑셀 다운로드
		function eventPopupExcelDownload(){
			var d = $("#popupListForm").serializeJson();
			createFormSubmit( "eventPopupExcelDownload", "/display/eventPopupExcelDownload.do", d );
		}
		
		</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		
			<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
				<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
					<form name="popupListForm" id="popupListForm" method="post">
					<table class="table_type1">
						<caption>팝업 검색 목록</caption>
						<tbody>
							<tr>
								<th scope="row">게시 기간</th>
								<td colspan="4">
									<!-- 기간 -->
									<frame:datepicker startDate="displayStrtDtm" endDate="displayEndDtm" startValue="${frame:toDate('yyyy-MM-dd')}" endValue="${frame:toDate('yyyy-MM-dd') }" />&nbsp;&nbsp;
									<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD}" selectKey="${adminConstants.SELECT_PERIOD_10 }" defaultName="기간선택" />
									</select>
								</td>							
							</tr>
							<tr>
								<th>조회 조건</th>
								<td colspan="4">
									<!-- 팝업 명-->
									<select name="evtpopStatCd" id="evtpopStatCd" title="게시여부" >
		                                <option value="" disabled selected hidden>게시여부</option>
		                                <frame:select grpCd="${adminConstants.EVTPOP_STAT}" defaultName="전체" showValue="false" />
		                            </select>
		                            <select name="progressStatCd" id="progressStatCd" title="진행여부" >
		                            	<option value="" disabled selected hidden>진행여부</option>
		                            	<option value="" >전체</option>
		                            	<option value="OPEN" >진행중</option>
		                            	<option value="STANDBY" >대기</option>
		                            	<option value="CLOSE" >마감</option>		                                
		                            </select>
		                            <select name="evtpopGbCd" id="evtpopGbCd" title="게시구분" >
		                                <option value="" disabled selected hidden>게시구분</option>
		                                <option value="" >전체</option>
		                                <frame:select grpCd="${adminConstants.EVTPOP_GB}" showValue="false" excludeOption="${adminConstants.EVTPOP_GB_ALL}"/>
		                            </select>
		                            <select name="evtpopLocCd" id="evtpopLocCd" title="게시위치" style="display:none;">
		                            	<option value="" disabled selected hidden>게시위치</option>
		                                <frame:select grpCd="${adminConstants.EVTPOP_LOC}" defaultName="전체" showValue="false" />
		                            </select>
								</td>								
							</tr>
							<tr>												
								<th><spring:message code="column.ttl"/></th>
								<td colspan="4">
									<input type="text"  class = "w800" name="evtpopTtl" id="evtpopTtl" title="<spring:message code="column.ttl"/>" >
								</td>					
							</tr>
						</tbody>
					</table>
					</form>
					<div class="btn_area_center">
						<button type="button" onclick="searchPopupList();" class="btn btn-ok">조회</button>
						<button type="button" onclick="searchReset('popupListForm');" class="btn btn-cancel">초기화</button>
					</div>
				</div>
			</div>
			<div class="mModule">
				<div id="resultArea" align="right">
					<button type="button" onclick="popupInsertView();" class="btn btn-add" style="background-color: #0066CC;">+ 등록</button>
					<button type="button" onclick="eventPopupExcelDownload();" class="btn btn-add btn-excel">엑셀 다운로드</button>
				</div>
				<table id="popupGroupList" ></table>
				<div id="popupGroupListPage"></div>
			</div>
		
	</t:putAttribute>

</t:insertDefinition>