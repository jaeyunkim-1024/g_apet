<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
	$(document).ready(function(){
		$("#apetReplyViewPop_dlg-buttons .btn-cancel").html("취소");
	});
</script>
<form name="contsReplyDetailForm" id="contsReplyDetailForm">
	<input type="hidden" name="loginId" value="${contsReplyInfo.loginId }" />
	<input type="hidden" name="aplySeq" value="${contsReplyInfo.aplySeq }" />
	<input type="hidden" name="contsStatCd" value="${contsReplyInfo.contsStatCd }" />
	<input type="hidden" name="rplGb" value="${contsReplyInfo.rpl }" />
	<input type="hidden" name="rplRegDtm" value="${frame:getFormatTimestamp(contsReplyInfo.rplRegDtm, 'yyyy-MM-dd HH:mm:ss')}" />
	<input type="hidden" name="rplUpdDtm" value="${frame:getFormatTimestamp(contsReplyInfo.rplUpdDtm, 'yyyy-MM-dd HH:mm:ss')}" />
	<!-- 댓글 내용 -->
	<h2 style="font-size:13px; padding:8px 0 5px 0;">댓글 내용</h2>
	<textarea name="aply" class="readonly" style="width:97%; height:72px;" readonly="readonly">${contsReplyInfo.aply }</textarea>
	<!-- 답글 내용 -->
	<h2 style="font-size:13px; padding:20px 0 0 0;">답글 ${empty contsReplyInfo.rpl ? "등록" : "수정" }</h2>
	<h2 style="font-size:13px; padding:5px 0 5px 0;">@ ${contsReplyInfo.loginId }</h2>
	<textarea name="rpl" class="validate[required]" style="width:97%; height:72px;" placeholder="댓글을 입력하세요">${contsReplyInfo.rpl }</textarea>
</form>
