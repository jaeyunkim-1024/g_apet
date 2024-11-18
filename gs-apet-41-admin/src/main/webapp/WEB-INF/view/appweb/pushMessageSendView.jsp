<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<jsp:include page="./include/pushMessageSendViewScript.jsp" />
	</t:putAttribute>
	<t:putAttribute name="content">
		<jsp:include page="./include/pushMessageSendViewContent.jsp" />
		<div class="btn_area_center">
			<button type="button" onclick="sendPushMessage('10');" class="btn btn-add">발송</button>
			<button type="button" onclick="noticeSendViewReset('pushMessageSendForm');" class="btn btn-ok">초기화</button>
			<button type="button" onclick="closeTab();" class="btn btn-cancel">취소</button>
		</div>
	</t:putAttribute>
</t:insertDefinition>