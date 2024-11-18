<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
	$(document).ready(function() {
		createApetReplyRptpListGrid();
		$("#apetReplyRptpDetailViewPop_dlg-buttons .btn-cancel").html("취소");
		$("#apetReplyRptpDetailForm #contsStatCd" + "${adminConstants.CONTS_STAT_30}").prop("disabled", true);
	});
	
	// 신고 접수 내역 그리드
	function createApetReplyRptpListGrid(){
		var options = {
			url : "<spring:url value='/contents/listApetReplyRptpGrid.do' />"
			, height : 115
			, searchParam : $("#apetReplyRptpDetailForm").serializeJson()
			, colModels : [
					// 신고 번호
					{name:"rptpNo", label:'No', width:"80", align:"center", sortable:false}
					// 신고일자
					, {name:'sysRegDtm', label:'<spring:message code="column.reply.rptp_date" />', width:'130', align:'center', sortable:false, formatter: function(cellvalue, options, rowObject) {
	                	return new Date(rowObject.sysRegDtm).format("yyyy-MM-dd") + "<br><p style='font-size:11px;'>(" + new Date(rowObject.sysRegDtm).format("HH:mm:ss") + ")</p>";
					}}
					// 신고자
					, {name:"loginId", label:'<spring:message code="column.reply.rptp_mbr" />', width:"130", align:"center", sortable:false}
					// 신고 사유
					, {name:"rptpRsnCd", label:'<spring:message code="column.reply.rptp_type" />', width:"120", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.RPTP_RSN}" />"}}
					// 신고 내용
					, {name:"rptpContent", label:'<spring:message code="column.reply.rptp_contents" />', width:"280", align:"center", sortable:false}
				]
		};
		grid.create("apetReplyRptpList", options);
	}
	
	// 신고된 댓글 노출 여부 수정
	function updateRptpReplyContsStat() {
		var arrReplySeq = new Array();
		arrReplySeq.push($("#apetReplyRptpDetailForm input[name=aplySeq]").val());
		
		if ("${contsReplyInfo.contsStatCd }" == $("#apetReplyRptpDetailForm input[name=contsStatCd]:checked").val()) {
			var options = {
					searchParam : $("#contsReplyListForm").serializeJson()
			};
			messager.alert("<spring:message code='column.display_view.message.save' />", "Info", "info", function() {
				grid.reload("contsReplyList", options);
				layer.close('apetReplyRptpDetailViewPop');
			});
		} else {
			var sendData = {
				arrReplySeq : arrReplySeq
				, contsStatCd : $("#apetReplyRptpDetailForm input[name=contsStatCd]:checked").val()
			}
			var options = {
				  url : "<spring:url value='/contents/updateApetReplyContsStat.do' />"
				, data : sendData
				, callBack : function(data) {
					messager.alert("<spring:message code='column.display_view.message.save' />", "Info", "info", function() {
						grid.reload("contsReplyList", options);
						layer.close('apetReplyRptpDetailViewPop');
					});
				}
			};
			ajax.call(options);
			
		}
	}
</script>
<form name="apetReplyRptpDetailForm" id="apetReplyRptpDetailForm">
	<input type="hidden" name="loginId" value="${contsReplyInfo.loginId }" />
	<input type="hidden" name="aplySeq" value="${contsReplyInfo.aplySeq }" />
	<input type="hidden" name="contsStatCd" value="${contsReplyInfo.contsStatCd }" />
	<input type="hidden" name="rplGb" value="${contsReplyInfo.rpl }" />
	<input type="hidden" name="rplRegDtm" value="${frame:getFormatTimestamp(contsReplyInfo.rplRegDtm, 'yyyy-MM-dd HH:mm:ss')}" />
	<input type="hidden" name="rplUpdDtm" value="${frame:getFormatTimestamp(contsReplyInfo.rplUpdDtm, 'yyyy-MM-dd HH:mm:ss')}" />
	
	<!-- 댓글 내용 -->
	<h2 style="font-size:13px; padding:8px 0 5px 0;">댓글 내용</h2>
	<textarea name="aply" class="readonly" style="width:97%; height:55px;" readonly="readonly">${contsReplyInfo.aply }</textarea>
	
	<!-- 답글 내용 -->
	<h2 style="font-size:13px; padding:20px 0 5px 0;">답글 내용</h2>
<c:if test="${not empty contsReplyInfo.rpl }">
	<h2 style="font-size:13px; padding:0 0 5px 0;">@ ${contsReplyInfo.loginId }</h2>
</c:if>
	<textarea name="rpl" class="readonly" style="width:97%; height:55px;" readonly="readonly">${contsReplyInfo.rpl }</textarea>

	<!-- 신고 접수 내역 -->
	<h2 style="font-size:13px; padding:20px 0 5px 0;">신고 접수 내역</h2>
	<table id="apetReplyRptpList"></table>
	<div id="apetReplyRptpListPage"></div>
	
	<!-- 댓글 노출 여부 -->
	<h2 style="font-size:13px; padding:20px 0 5px 0;">댓글 노출 여부</h2>
	<frame:radio name="contsStatCd" grpCd="${adminConstants.CONTS_STAT }" selectKey="${contsReplyInfo.contsStatCd }" />
</form>
