<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function() {
				fncSrchDateChange();
				fncCreateVersionGrid();
				//날짜선택시 selectbox 기간선택문구로 변경 
				newSetCommonDatePickerEvent("#verUpStrtDtm", "#verUpEndDtm"); 
			});
			
			$(function(){
				//POC 구분 클릭 이벤트
				$("input:checkbox[name=arrMobileOs]").click(function(){
					var all = false;
					if ( validation.isNull( $(this).val() ) ){
						all = true;
					}
					if ( $('input:checkbox[name="arrMobileOs"]:checked').length == 0 ) {
						//$('input:checkbox[name="arrMobileOs"]').eq(0).prop( "checked", true );
					} else {
						$('input:checkbox[name="arrMobileOs"]').each( function() {
							if ( all ) {
								if ( validation.isNull( $(this).val() ) ) {
									$(this).prop("checked", true);
								} else {
									$(this).prop("checked", false);
								}
							} else {
								if ( validation.isNull($(this).val() ) ) {
									$(this).prop("checked", false);
								}
							}
						});
					}
				});
				
				
			});

			// APP 버전관리 그리드
			function fncCreateVersionGrid() {
				var options = {
					url : "<spring:url value='/mobileapp/version/listGrid.do' />"
					, height : 400
					, searchParam : fncSerializeFormData()
					, sortname : 'sysRegDtm'
					, sortorder : 'DESC'
					, colModels : [
						{name:"verNo", label:'No', width:"100", key: true, align:"center"}
						, {name:"mobileOs", label:'<spring:message code="column.version.os_gb" />', width:"150", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.MOBILE_OS_GB}" />"}, sortable:false}
						, {name:"appVer", label:'<b><u><tt><spring:message code="column.version.version" /></tt></u></b>', width:"100", align:"center", classes:'pointer fontbold', sortable:false}
						, {name:"message", label:'<spring:message code="column.version.update_cnts" />', width:"450", sortable:false, formatter : function(cellvalue, options, rowObject) {
								var array = cellvalue.split(/\r\n|\r|\n/);
								if(array.length > 1){
									return array[0]+"...";
								}else{
									return cellvalue;
								}
							}
						}
						, {name:"marketRegDtm", label:'<spring:message code="column.version.update_dtm" />', width:"200", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", sortable:false}
						, {name:"sysRegrNm", label:'<spring:message code="column.sys_regr_nm" />', width:'90', align:'center', sortable:false} 
						, {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_dt" />', width:'150', align:'center', formatter:gridFormat.date, dateformat:"yyyy-MM-dd", sortable:false}
					]
					, multiselect : false
					, onCellSelect : function(id, cellidx, cellvalue) {
						if (cellidx == 2) {
							viewVersion(id);
						}
					}
					, gridComplete : function() {
						$("#noData").remove();
						var grid = $("#versionList").jqGrid('getRowData');
						if(grid.length <= 0) {
							var str = "";
							str += "<tr id='noData' role='row' class='jqgrow ui-row-ltr ui-widget-content'>";
							str += "	<td role='gridcell' colspan='7' style='text-align:center;'>조회결과가 없습니다.</td>";
							str += "</tr>"
								
							$("#versionList.ui-jqgrid-btable").append(str);
						}
						
						//업데이트 내용 줄임말
						$("#versionList td[aria-describedby=versionList_message]").css("text-overflow", "ellipsis"); // 줄임말
						$("#versionList td[aria-describedby=versionList_message]").css("white-space", "nowrap"); // 한줄로 표기
						$("#versionList td[aria-describedby=versionList_message]").css("overflow", "hidden"); // 스크롤 숨김
					}
				};
				
				grid.create("versionList", options);
			}

			// APP 버전관리 검색
			function fncSrchVerGrid() {
				//검색버튼 click이후에 alert창 띄우기 
				compareDateAlert("verUpStrtDtm", "verUpEndDtm", "term");
				
				// POC 구분 필수 선택
				if ( $('input:checkbox[name="arrMobileOs"]:checked').length == 0 ) {
					messager.alert("POC 구분을 선택해 주세요.", "Info", "info");
					return;
				}

				var options = {
					searchParam : fncSerializeFormData()
				};
				
				gridReload('verUpStrtDtm','verUpEndDtm','versionList','term', options);
			
			}
			
			// form data set
			function fncSerializeFormData() {
	            var data = $("#mobileSearchForm").serializeJson();
	            if ( undefined != data.arrMobileOs && data.arrMobileOs != null && Array.isArray(data.arrMobileOs) ) {
	                $.extend(data, {arrMobileOs : data.arrMobileOs.join(",")});
	            } else {
	                // 전체를 선택했을 때 Array.isArray 가 false 여서 이 부분을 실행하게 됨.
	                // 전체를 선택하면 검색조건의 모든 POC구분을 배열로 만들어서 파라미터 전달함.
	                var arrMobileOs = new Array();
	                if ($("#arrMobileOs_default").is(':checked')) {
	                    $('input:checkbox[name="arrMobileOs"]').each( function() {
	                        if (! $(this).is(':checked')) {
	                        	arrMobileOs.push($(this).val());
	                        }
	                    });

	                    $.extend(data, {arrMobileOs : arrMobileOs.join(",")});
	                }
	            }

	            return data;
			}

			// APP 버전관리 등록 이동
			function regVersion() {
				addTab('APP 버전 신규 등록', '/mobileapp/version/reg.do');
			}
			
			// APP 버전관리 상세 팝업
			function viewVersion(verNo) {
				<%--addTab('APP 버전 상세', '/mobileapp/version/view.do?verNo=' + verNo);--%>
				
				var options = {
					url : "<spring:url value='/mobileapp/version/versionDetailViewPop.do' />"
					, data : {verNo : verNo}
					, dataType : "html"
					, callBack : function (data ) {
						var config = {
							id : "versionDetailViewPop"
							, width : 1000
							, height : 420
							, title : "APP 버전 상세 팝업"
							, body : data
							, button : "<button type=\"button\" id=\"save_btn\" onclick=\"updateVersion();\" class=\"btn btn-ok\">저장</button>"+
										"<button type=\"button\" id=\"del_btn\" onclick=\"deleteVersion();\" class=\"ml10 btn btn-add\">삭제</button>"
						}
						
						layer.create(config);
					}
				}
			
				ajax.call(options );
			}
			
			<%--
			// 버전 정보 삭제
			function deleteVersion() {
				var grid = $("#versionList");
				var verNos = new Array();

				var rowids = grid.jqGrid('getGridParam', 'selarrrow');
				if (rowids.length <= 0) {
					messager.alert("<spring:message code='column.common.delete.no_select' />", "Info", "info");
					return;
				}

				messager.confirm('<spring:message code="column.common.confirm.delete" />', function(r){
					if(r){
						for (var i = rowids.length - 1; i >= 0; i--) {
							verNos.push(rowids[i]);
						}

						var options = {
							url : "<spring:url value='/mobileapp/version/delete.do' />"
							, data : {verNos : verNos}
							, callBack : function(data) {
								messager.alert("<spring:message code='column.common.delete.final_msg' arguments='" + data.delCnt + "' />", "Info", "info", function(){
									searchVersionGrid();	
								});
							}
						};
						ajax.call(options);
					}
				})
			}
			--%>
			
	        // 초기화 버튼클릭
	        function fncSrchReset() {
	        	resetForm ("mobileSearchForm");
	        	
	        	fncSrchVerGrid(); // APP 버전관리 조회
	        }
	        
	     	// 업데이트일 변경
			function fncSrchDateChange() {
				var term = $("#checkOptDate").children("option:selected").val();
				if(term == "") {
					$("#verUpStrtDtm").val("");
					$("#verUpEndDtm").val("");
				}else if(term == "50"){
					//3개월 기간조회시에만 호출하는 메소드
					setSearchDateThreeMonth("verUpStrtDtm", "verUpEndDtm");
				}else {
					setSearchDate(term, "verUpStrtDtm", "verUpEndDtm");
				}
			}
	     	
	     	// 엑셀 다운로드
	     	function versionExcelDownload(){
	     		var d = fncSerializeFormData();

				createFormSubmit( "versionExcelDownload", "/mobileapp/version/versionExcelDownload.do", d );
	     	}
	     	
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form name="mobileSearchForm" id="mobileSearchForm" method="post">
					<table class="table_type1">
						<caption>APP 버전관리 목록</caption>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.version.poc_gb" /></th> <!-- POC 구분 -->
								<td>
									<frame:checkbox name="arrMobileOs" grpCd="${adminConstants.MOBILE_OS_GB}" defaultName="전체" defaultId="arrMobileOs_default"/>
								</td>
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.version.update_dt" /></th> <!-- 업데이트 일 -->
								<td>
									<frame:datepicker startDate="verUpStrtDtm" startValue="${frame:toDate('yyyy-MM-dd')}" endDate="verUpEndDtm" endValue="${versionSo.returnDt eq '' ? frame:toDate('yyyy-MM-dd') : versionSo.returnDt}" />
									&nbsp;
									<select id="checkOptDate" name="checkOptDate" onchange="fncSrchDateChange();">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_40 }" defaultName="기간선택" />
									</select>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				
				<div class="btn_area_center">
					<button type="button" onclick="fncSrchVerGrid();" class="btn btn-ok"><spring:message code="admin.web.view.common.button.search" /></button> <!-- 조회 -->
					<button type="button" onclick="fncSrchReset();" class="btn btn-cancel"><spring:message code="admin.web.view.common.button.clear" /></button> <!-- 초기화 -->
				</div>
			</div>
		</div>

		<div class="mModule">
			<div class="mButton">
				<div class="rightInner">
					<button type="button" onclick="regVersion();" class="btn btn-add"><spring:message code="column.version.insert_version" /></button> <!-- 버전 등록 -->
					<button type="button" onclick="versionExcelDownload();" class="btn btn-add btn-excel">엑셀 다운로드</button>
					<%--<button type="button" onclick="deleteVersion();" class="btn btn-add">삭제</button>--%>
				</div>
			</div>
				
			<table id="versionList" class="grid"></table>
			<div id="versionListPage"></div>
		</div>
		
	</t:putAttribute>
</t:insertDefinition>