<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">		
//btn-cancel

var isGridExists = false;		
$(document).ready(function() {
	
	$("#goodsBatchUpdateForm #detailContsStatCd" + "${adminConstants.CONTS_STAT_30}").prop("disabled", true);
	if("${petLogSO.tagCallYn eq 'N'}" == "true"){
		//태그관리에서 호출이 아닐시 닫기 버튼 텍스트 취소로 변경
		$("#petLogDetail_dlg-buttons .btn-cancel").html("취소");
	}
	createPetLogReportGrid();  
	
	$("#ifPetLogDetail").load(function(){    	
    	$("#ifDiv").css("background-image","");
    	
    });	
});

//신고내역 Grid
function createPetLogReportGrid () {
	// 펫로그 관리 상세
	var url = "<spring:url value='/petLogMgmt/listPetLogReport.do' />";
	var searchParam = {petLogNo : '${petLogSO.petLogNo }' };
	var height = 320;
	// 펫로그 댓글 신고 관리 상세
	if ("${petLogSO.replyRptpGb}" == "Y") {
		url = "<spring:url value='/contents/listPetLogReplyRptpGrid.do' />";
		searchParam = {petLogAplySeq : '${petLogSO.petLogAplySeq }' };
		height = 200;
	}
	var gridOptions = {
		  url : url
		, height : height 				
		, searchParam : searchParam
		, colModels : [
			  {name:"rowIndex", 		label:'<spring:message code="column.rptp_no" />', 		width:"50", 	align:"center", sortable:false} /* 번호 */			
		    , {name:"sysRegDtm", label:'<spring:message code="column.rptp_dt" />', 		width:"90",		align:"center", sortable:false, formatter: function(rowId, val, rawObject, cm) {
				return new Date(rawObject.sysRegDtm).format("yyyy-MM-dd") + '\r\n<p style="font-size:11px;">(' + new Date(rawObject.sysRegDtm).format("HH:mm:ss")+ ')</p>';
				}
			}			
			, {name:"rptpLoginId", 		label:"<spring:message code='column.claim_mbr' />", 	width:"110", 	align:"center", sortable:false} /* 신고자 */
			, {name:"rptpRsnCd", 		label:"<spring:message code='column.rptp_rsn' />",  	align:"center", sortable:false
				, editable:true, edittype:'select', formatter:'select', editoptions : {value:"<frame:gridSelect grpCd='${adminConstants.RPTP_RSN}' showValue='false' />"}} /* 신고구분 */
			, {name:"rptpContent", 		label:'<spring:message code="column.rptp_content" />', 	width:"240", 	align:"center", sortable:false} /* 내용 */
			, {name:"loginId", 			label:"<spring:message code='column.mbrNo' />", 		hidden:true,	width:"120", 	align:"center", sortable:false} /* 등록자 */					
			, {name:"petLogNo", 		label:"<spring:message code='column.petlog_no' />", 	hidden:true, 	align:"center", sortable:false} /* 펫로그번호 */
			, {name:"petLogRptpNo", 	label:'<spring:message code="column.rptp_no" />', 		hidden:true,	width:"35", 	align:"center", sortable:false} /* 번호 */			
            ]

		, multiselect : false			
		
	}
	grid.create("petlogListReport", gridOptions);
	isGridExists = true;
}
</script>
<div id = "ifDiv" style="width:38%; height:99%; float:left; border:1px solid #999;background-image:url(/images/ajax-loader-white.gif);background-repeat:no-repeat;background-position: center;">	
	<iframe id="ifPetLogDetail" name="ifPetLogDetail" frameborder="0" src="https://<spring:eval expression="@webConfig['site.fo.domain']" />/log/includePetLogDetail?petLogNo=${petLogSO.petLogNo }&adminYn=Y" width="100%" height="100%" style="margin-top:10px; min-height:500px;"></iframe>
</div>
<div style="width:60%; height:100%; float:right;">
	<!-- 펫로그 댓글 신고 관리 상세 : 댓글 내용 영역 - s -->
	<c:if test="${petLogSO.replyRptpGb eq 'Y' }">
	<h2 style="font-size:13px; padding:8px 0 5px 0;">댓글 내용</h2>
	<h2 style="font-size:13px; padding:5px 0 5px 0;">@ ${petLogSO.loginId }</h2>
	<textarea name="aply" class="readonly" style="width:96.5%; height:55px;" readonly="readonly">${petLogSO.aply }</textarea>
	</c:if>
	<!-- 펫로그 댓글 신고 관리 상세 : 댓글 내용 영역 - e -->
	<div class="mModule" <c:if test="${petLogSO.replyRptpGb ne 'Y' }">style = "margin-top: 10px;"</c:if>>
		<h2 style="font-size:13px; padding:8px 0 5px 0;">신고 접수 내역</h2>
		<table id="petlogListReport"></table>	
		<div id="petlogListReportPage"></div>
	</div>
	<form id="goodsBatchUpdateForm" name="goodsBatchUpdateForm" method="post">
		<h2 style="font-size:13px; padding:22px 0 5px 0;">노출관리</h2>
		<table class="table_type1">
			<caption>펫로그 상세 </caption>
			<colgroup>
				<col style="width:30%;">							
				<col style="width:70%;">
				<!-- <col style="width:13%;">
				<col style="width:18%;"> -->
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><spring:message code="column.disp_yn" /></th> <!-- 전시여부 -->
					<td>
						<frame:radio  name="detailContsStatCd" grpCd="${adminConstants.CONTS_STAT }" selectKey="${petLogSO.contsStatCd }" />
					</td>
					<%-- <th scope="row"><spring:message code="column.snct_yn" /></th> <!-- 제재여부 -->
					<td>								
						<input type= "checkbox" id="snct_yn" name="snct_yn" value = "Y" <c:if test = "${petLogSO.snctYn eq 'Y' }">checked</c:if> />이동(숨김)								
					</td> --%>
				</tr>
			</tbody>
		</table>
	</form>
	<c:if test="${petLogSO.replyRptpGb ne 'Y' }">
	<h2 style="font-size:13px; padding:22px 0 5px 0;">등록 유형 : <frame:codeName grpCd="${adminConstants.PETLOG_CHNL }" dtlCd="${petLogSO.petLogChnlCd}"  /></h2>
	</c:if>
</div>
