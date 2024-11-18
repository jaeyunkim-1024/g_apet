<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
	$(document).ready(function() {
		createPushCountDetailGrid();
	});
	
	// 알림 메시지 발송 건수 그리드
	function createPushCountDetailGrid() {
		var options = {
			url : "<spring:url value='/appweb/listPushCountGrid.do' />"
			, searchParam : {
				noticeSendNo : "${pushCountDetail.noticeSendNo}"
			}
			, colModels : [
					// 알림 메시지 번호
					{name:"noticeSendNo", label:'No', width:"80", hidden:true, align:"center", sortable:false}
					// 이력 상세 번호
					, {name:"histDtlNo", label:'No', width:"80", align:"center", sortable:false, key:true}
					// 회원 아이디
					, {name:"loginId", label:'회원 ID', width:"120", align:"center", sortable:false}
					// 회원구분
					, {name:"mbrGbCd", label:'회원구분', width:"120", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.MBR_GB_CD }' />"}}
					// 전송방식
					, {name:"sndTypeCd", label:'전송방식', width:"150", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.SND_TYPE }' />"}}
					// 성공여부
					, {name:"sndRstCd", label:'성공여부', width:"100", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
						var str;
						if (rowObject.sndRstCd == "${adminConstants.SND_RST_F}") {
							str = "<p style='color:#C00000;'>" + "<frame:codeName grpCd='${adminConstants.SND_RST }' dtlCd='${adminConstants.SND_RST_F }' />" + "</p>";
						} else if (rowObject.sndRstCd == "${adminConstants.SND_RST_S}") {
							str = "<frame:codeName grpCd='${adminConstants.SND_RST }' dtlCd='${adminConstants.SND_RST_S }' />";
						}
						if (str == undefined) {
							str = "";
						}
						return str;
					}}
					// 발송일시
					, {name:'sendReqDtm', label:'발송일시', width:'150', align:'center', sortable:false, formatter: function(cellvalue, options, rowObject) {
						let str = new Date(rowObject.sendReqDtm).format("yyyy-MM-dd HH:mm:ss");
						if(rowObject.noticeTypeCd == "${adminConstants.NOTICE_TYPE_10}") {
							str = new Date(rowObject.sysRegDtm).format("yyyy-MM-dd HH:mm:ss");
						}
						return str;
					}}
				]
		};
		grid.create("pushCountList", options);
	}
	
	// 알림 메시지 발송 건수 엑셀 다운로드
	function pushCountListExcelDownload() {
		var excelData = $("#pushCountDetailForm").serializeJson();
		var headerName = new Array();
		var fieldName = new Array();
		headerName.push("No");
		headerName.push("회원 아이디");
		headerName.push("회원구분");
		headerName.push("전송방식");
		headerName.push("성공여부");
		headerName.push("발송일시");
		
		fieldName.push("noticeSendNo");
		fieldName.push("loginId");
		fieldName.push("mbrGbCd");
		fieldName.push("sndTypeCd");
		fieldName.push("sndRstCd");
		fieldName.push("sendReqDtm");
		
		$.extend(excelData, {
			headerName : headerName
			, fieldName : fieldName
			, sheetName : "pushCountListExcelDownload"
			, fileName : "pushCountExcelDownload"
			, pushTpGb : "pushCount"
			, noticeSendNo : "${pushCountDetail.noticeSendNo }"
		});
		createFormSubmit("pushCountListExcelDownload", "/appweb/pushCommonExcelDownload.do", excelData);
	}
</script>
<form name="pushCountDetailForm" id="pushCountDetailForm" method="post">
	<table class="table_type1 popup">
		<caption>알림 메시지 발송 건수 정보</caption>
		<tbody>
			<tr>
				<th><spring:message code="column.push.type" /></th>
				<td>
					<!-- 발송방식 -->
					<frame:codeName grpCd="${adminConstants.NOTICE_TYPE }" dtlCd="${pushCountDetail.noticeTypeCd }"/>
				</td>
				<th><spring:message code="column.push.tmpl_reg_dtm" /></th>
				<td>
					<!-- 등록일 -->
					<fmt:formatDate value="${pushCountDetail.sysRegDtm }" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.push.message_sub" /></th>
				<td colspan="3">
					<!-- 알림 메시지 제목 -->
					${pushCountDetail.subject }
				</td>
			</tr>
			<tr>
				<th><spring:message code="column.push.result" /></th>
				<td colspan="3">
					<!-- 발송결과 -->
					<frame:codeName grpCd="${adminConstants.SND_RST }" dtlCd="${adminConstants.SND_RST_S }"/> : <span style="color:#1DDB16; font-size:17px; font-weight:bold;">${pushCountDetail.successCnt eq 0 ? "0" : pushCountDetail.successCnt }</span>
					&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
					<frame:codeName grpCd="${adminConstants.SND_RST }" dtlCd="${adminConstants.SND_RST_F }"/> : <span style="color:#FF0000; font-size:17px; font-weight:bold;">${pushCountDetail.failCnt eq 0 ? "0" : pushCountDetail.failCnt }</span>
				</td>
			</tr>
		</tbody>
	</table>
</form>
<div class="mModule">
	<div align="right">
		<button type="button" onclick="pushCountListExcelDownload();" class="btn btn-add btn-excel" style="margin-right:0px;">엑셀 다운로드</button>
	</div>
	
	<table id="pushCountList"></table>
	<div id="pushCountListPage"></div>
</div>
