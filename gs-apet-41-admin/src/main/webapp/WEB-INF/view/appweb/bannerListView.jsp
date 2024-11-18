<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		
		$(document).ready(function(){
			createBannerGrid();
			//날짜선택시 selectbox 기간선택문구로 변경 
			newSetCommonDatePickerEvent("#regStrtDtm", "#regEndDtm"); 
			searchDateChange();
			//엔터키
			$(document).on("keydown","#bannerSearchForm input",function(){
    			if ( window.event.keyCode == 13 ) {
    				reloadBannerGrid();
  		  		}
            });
			
		});
		
		//배너 등록 페이지
		function bannerInsertView() {
			addTab('배너 등록', '/appweb/bannerView.do');
		}
		
		//배너 상세 페이지
		function bannerDetailView(bnrNo) {
			addTab('배너 상세', '/appweb/bannerView.do?bnrNo=' + bnrNo);
		}
		
		//배너 검색 초기화
		function searchReset() {
			resetForm("bannerSearchForm");
			searchDateChange();
			reloadBannerGrid();
		}
		
		// 등록기간 
		function searchDateChange() {
			var term = $("#checkOptDate").children("option:selected").val();
			if(term == "") {
				$("#regStrtDtm").val("");
				$("#regEndDtm").val("");
			}else if(term == "50"){
				//3개월 기간조회시에만 호출하는 메소드
				setSearchDateThreeMonth("regStrtDtm", "regEndDtm");
			}else {
				setSearchDate(term, "regStrtDtm", "regEndDtm");
			}
		}
		
		// 엑셀 다운로드
		function bannerListExcelDownload() {
			var data = $("#bannerSearchForm").serializeJson();
			createFormSubmit("bannerListExcelDownload", "/appweb/bannerListExcelDownload.do", data);
		}
		
		// barrnerList 그리드
 		function createBannerGrid() {
			var options = {
				url : "<spring:url value='/appweb/bannerListGrid.do' />",
				height : 400,
				searchParam : $("#bannerSearchForm").serializeJson(),
				colModels : [
					{name : "bnrNo",label : "<spring:message code='column.bnr_no' />" ,width : "80", key : true, align : "center"}
					//, {name : "bnrId",label : "<spring:message code='column.bnr_id' />" ,width : "100", align : "center"}
					, {name : "bnrTpCd",label : "<spring:message code='column.bnr_tp_cd_nm' />" ,width : "100", align : "center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.BNR_TP_CD}" />"}}
					, {name : "bnrMobileImgPath",label : "<spring:message code='column.bnr_mo_img_path' />", width : "250", align : "center", formatter : function(cellvalue, options, rowObject) {
							if(rowObject.bnrMobileImgPath != "") {
								return '<img src="${frame:imagePath( "'+rowObject.bnrMobileImgPath+'" )}" style="width:100px; height:100px;" alt="' + rowObject.bnrMobileImgPath + '" />';
							} else {
								return '<img src="/images/noimage.png" style="width:70px; height:60px;" alt="NoImage" />';
							}
						}
					}
					, {name : "bnrTtl",label : "<spring:message code='column.bnr_ttl' />",width : "400", align : "center", classes:'pointer fontbold', formatter : function(cellvalue, options, rowObject) {
						var length = 31;	//표시할 글자 수
						var temp;
						if(cellvalue.length > length) {
							temp = cellvalue.substring(0, length) + '...';
						} else {
							temp = cellvalue;
						}
							return temp;
						}
					}
					, {name : "useYn",label : "<spring:message code='column.bnr_use_yn' />",width : "100", align : "center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.USE_YN}" />"}}
					, _GRID_COLUMNS.sysRegDtm
					, _GRID_COLUMNS.sysRegrNm
				]
				, onCellSelect : function(id, cellidx, cellvalue) {
					if(cellidx == 3) {
						var rowData = $("#bannerList").getRowData(id);
						bannerDetailView(rowData.bnrNo);
					}
				}
				, gridComplete : function() {

					$("#noData").remove();
					var grid = $("#bannerList").jqGrid('getRowData');
					if(grid.length <= 0) {
						var str = "";
						str += "<tr id='noData' role='row' class='jqgrow ui-row-ltr ui-widget-content'>";
						str += "	<td role='gridcell' colspan='9' style='text-align:center;'>조회결과가 없습니다.</td>";
						str += "</tr>"
							
						$("#bannerList.ui-jqgrid-btable").append(str);
					}
				}
			};
			grid.create("bannerList", options);
		}
		
 		// 그리드  검색
		function reloadBannerGrid() {
			//검색버튼 click이후에 alert창 띄우기 
			compareDateAlert("regStrtDtm", "regEndDtm", "term");
 			
			var options = {
				searchParam : $("#bannerSearchForm").serializeJson()
			};

			gridReload('regStrtDtm','regEndDtm','bannerList','term', options);
		}
		
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion"
			data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect"
			style="width: 100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding: 10px">
				<form name="bannerSearchForm" id="bannerSearchForm">
					<input type="hidden" id="dispClsfCd" name="dispClsfCd" value="" />
					<table class="table_type1">
						<caption>배너 검색</caption>
						<tbody>
							<tr>
								<th><spring:message code='column.use_yn' /></th>
								<td>
									<select name="useYn" id="useYn" title="<spring:message code='column.use_yn' />">
										<frame:select grpCd="${adminConstants.USE_YN}" />
									</select>
								</td>
								<th><spring:message code='column.insert_date' /></th>
								<td>
									<frame:datepicker startDate="regStrtDtm"
													  startValue="${frame:toDate('yyyy-MM-dd') }"
													  endDate="regEndDtm" 
													  endValue="${frame:toDate('yyyy-MM-dd') }"/>
									&nbsp;&nbsp; 
									<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_40 }" defaultName="기간선택" />
									</select>
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.bnr_tp_cd_nm" /></th>
								<td>
									<!-- 배너 타입명-->
									<select class="wth100" name="bnrTpCd" id="bnrTpCd" title="<spring:message code="column.bnr_tp_cd_nm"/>">
										<frame:select grpCd="${adminConstants.BNR_TP_CD}" defaultName="전체" />
									</select>
								</td>
								<th><spring:message code="column.bnr_search" /></th>
								<td>
									<input type="text" name="searchVal" id="searchVal" placeholder="배너ID, 제목 입력"/>
								</td>
							</tr>
						</tbody>
					</table>
				</form>

				<div class="btn_area_center">
					<button type="button" onclick="reloadBannerGrid();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>
		
		<div class="mModule">
			<div class="mButton">
				<div class="rightInner">
					<button type="button" onclick="bannerInsertView();" class="btn btn-add"><spring:message code='column.bnr_insert' /></button>
				</div>
			</div>

			<table id="bannerList"></table>
			<div id="bannerListPage"></div>
			
			<div class="mButton">
				<div class="rightInner">
					<button type="button" onclick="bannerListExcelDownload();" class="btn btn-add btn-excel"><spring:message code='column.common.btn.excel_download' /></button>
				</div>
			</div>
		</div>
		
	</t:putAttribute>
</t:insertDefinition>