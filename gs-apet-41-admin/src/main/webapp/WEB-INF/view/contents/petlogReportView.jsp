<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">		
		<script type="text/javascript">		
		var isGridExists = false;		
		$(document).ready(function() {
			searchDateChange();
			createPetLogReportGrid();         
		});
		
		$(function(){
			//신고 구분 클릭 이벤트
			$("input:checkbox[name=arrRptpRsnCd]").click(function(){
				var all = false;
				if ( validation.isNull( $(this).val() ) ){
					all = true;
				}
				if ( $('input:checkbox[name="arrRptpRsnCd"]:checked').length == 0 ) {
					$('input:checkbox[name="arrRptpRsnCd"]').eq(0).prop( "checked", true );
				} else {
					$('input:checkbox[name="arrRptpRsnCd"]').each( function() {
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
		
		// 신고내역 Grid
		function createPetLogReportGrid () {
			var gridOptions = {
				  url : "<spring:url value='/petLogMgmt/listPetLogReport.do' />"	
 				, height : 400 				
				, searchParam : fncSerializeFormData()
				, colModels : [
					  {name:"petLogRptpNo", 	label:'<spring:message code="column.no" />', 			width:"80", 	align:"center", sortable:false} /* 번호 */					  
					, {name:"rptpContent", 		label:'<spring:message code="column.content" />', 		width:"600", 	align:"center", sortable:false} /* 내용 */
					, {name:"loginId", 			label:"<spring:message code='column.mbrNo' />", 		width:"120", 	align:"center", sortable:false} /* 등록자 */					
					, {name:"rptpLoginId", 		label:"<spring:message code='column.claim_mbr' />", 	width:"120", 	align:"center", sortable:false} /* 신고자 */
					, {name:"rptpRsnCd", 		label:"<spring:message code='column.rptp_rsn' />",  	align:"center", sortable:false
						, editable:true, edittype:'select', formatter:'select', editoptions : {value:"<frame:gridSelect grpCd='${adminConstants.RPTP_RSN}' showValue='false' />"}} /* 신고구분 */
					, {name:"sysRegDtm",		label:"<spring:message code='column.rptp_dt' />", 		align:"center", sortable:true, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"} /* 신고일 */
					, {name:"petLogNo", 		label:"<spring:message code='column.petlog_no' />", 	hidden:true, 	align:"center", sortable:false} /* 펫로그번호 */
	                ]

				, multiselect : true				
			}
			grid.create("petlogListReport", gridOptions);
			isGridExists = true;
		}
		
		// form data set
		function fncSerializeFormData() {
            var data = $("#petlogListReportForm").serializeJson();            
            if ( undefined != data.arrRptpRsnCd && data.arrRptpRsnCd != null && Array.isArray(data.arrRptpRsnCd) ) {            	
                $.extend(data, {arrRptpRsnCd : data.arrRptpRsnCd.join(",")});
            } else {
                // 전체를 선택했을 때 Array.isArray 가 false 여서 이 부분을 실행하게 됨.
                // 전체를 선택하면 검색조건의 모든 POC구분을 배열로 만들어서 파라미터 전달함.                
                var arrRptpRsnCd = new Array();
                if ($("#arrRptpRsnCd_default").is(':checked')) {
                    $('input:checkbox[name="arrRptpRsnCd"]').each( function() {
                        if (! $(this).is(':checked')) {
                        	arrRptpRsnCd.push($(this).val());
                        }
                    });                    
                    $.extend(data, {arrRptpRsnCd : arrRptpRsnCd.join(",")});
                }
            }
            return data;
		}

		// 검색 조회
		function searchPetlogListReport () {
			if (! isGridExists) {
				createPetLogReportGrid();
			}						
			if($("#sysRegDtmStart").val() > $("#sysRegDtmEnd").val()){
				messager.alert("<spring:message code='column.common.petlog.priod.msg' />", "Info", "info");			
				return;
			}
			if(validate.check("petlogListReportForm")) {
				var options = {					
					searchParam : fncSerializeFormData()
				};
				grid.reload("petlogListReport", options);
			}

			
		}

		// 초기화 버튼클릭
		function searchReset () {
			resetForm ("petlogListReportForm");
			<c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
			$("#petlogListReportForm #compNo").val('${adminSession.compNo}');
			$("#petlogListReportForm #showAllLowCompany").val("N");
			</c:if>
			searchDateChange();
		}		

		// 등록일 변경
		function searchDateChange() {			
			$("#sysRegDtmStart").addClass("validate[required]");
			$("#sysRegDtmEnd").addClass("validate[required]");
			var term = $("#checkOptDate").children("option:selected").val();
			if(term == "") {
				$("#sysRegDtmStart").val("");
				$("#sysRegDtmEnd").val("");
			} else {
				setSearchDate(term, "sysRegDtmStart", "sysRegDtmEnd");
			}
		}
		
		// 엑셀 다운로드
     	function petLogReportExcelDownload(){
     		var d = fncSerializeFormData();
			createFormSubmit( "petLogReportExcelDownload", "/petLogMgmt/petLogReportExcelDownload.do", d );
     	}
		</script>
	</t:putAttribute>

	<t:putAttribute name="content">

		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<input type = "hidden" id = "selectedPetLogNo" />
				<form id="petlogListReportForm" name="petlogListReportForm" method="post">
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
								<th scope="row"><spring:message code="column.reg_dt" /><strong class="red">*</strong></th>								
								<!-- 기간 -->
								<td colspan = "3">
									<frame:datepicker startDate="sysRegDtmStart" endDate="sysRegDtmEnd" startValue="${adminConstants.COMMON_START_DATE }" readonly = "true"/>&nbsp;&nbsp; 
									<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_20 }" defaultName="기간선택" />
									</select>
								</td>								
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.sys_regr_nm" /></th>	
								<!-- 등록자 -->							
								<td><input type="text" name="loginId" id="loginId" title="등록자" value="" /></td>
								
								<th scope="row"><spring:message code="column.claim_mbr" /></th>	
								<!-- 신고자 -->							
								<td><input type="text" name="rptpLoginId" id="rptpLoginId" title="등록자" value="" /></td>
								
								
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.rptp_rsn" /></th>
								<!-- 신고구분 -->								
								<td colspan = "3">								
									<frame:checkbox name="arrRptpRsnCd" grpCd="${adminConstants.RPTP_RSN }" defaultName="전체" defaultId="arrRptpRsnCd_default" />									
								</td>
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.content" /></th>
								<!-- 내용 -->
								<td colspan = "3">
									<input type="text" class = "w800" name="rptpContent" id="rptpContent" title="내용" value="" />
								</td>								
							</tr>						
						</tbody>
					</table>
					
				</form>
				
				<div class="btn_area_center">
					<button type="button" onclick="searchPetlogListReport();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

		
		<div class="mModule">			
			<div class="mButton">
				<div class="rightInner">
					<button type="button" onclick="petLogReportExcelDownload();" class="btn btn-add btn-excel right">엑셀 다운로드</button>			
				</div>
			</div>
			<table id="petlogListReport"></table>
			<div id="petlogListReportPage"></div>
		</div>
	</t:putAttribute>

</t:insertDefinition>