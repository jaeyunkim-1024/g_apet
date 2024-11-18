<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
	$(document).ready(function(){
		$("#pushMessageDetailViewPop_dlg-buttons .btn-cancel").html("확인");
	});
</script>
<table class="table_type1 popup">
	<colgroup>
		<col width="30%" />
		<col width="70%" />
		<col width="30%" />
		<col width="70%" />
	</colgroup>
	<caption>알림 메시지 상세 정보</caption>
	<tbody>
		<tr>
			<th><spring:message code="column.push.message_type" /></th>
			<td>
				<!-- 메시지 유형 -->
				<frame:codeName grpCd="${adminConstants.SND_TYPE }" dtlCd="${pushMessageDetail.sndTypeCd }" />
			</td>
			<th><spring:message code="column.push.type" /></th>
			<td>
				<!-- 발송방식 -->
				<frame:codeName grpCd="${adminConstants.NOTICE_TYPE }" dtlCd="${pushMessageDetail.noticeTypeCd }" />
			</td>
		</tr>
		<tr>
			<th><spring:message code="column.push.reserve_dtm" /></th>
			<td>
				<!-- 예약일자 -->
				<c:if test="${pushMessageDetail.noticeTypeCd eq adminConstants.NOTICE_TYPE_10 }">
					-
				</c:if>
				<c:if test="${pushMessageDetail.noticeTypeCd eq adminConstants.NOTICE_TYPE_20 }">
					<fmt:formatDate value="${pushMessageDetail.sendReqDtm }" pattern="yyyy-MM-dd HH:mm:ss"/>
				</c:if>
			</td>
			<th><spring:message code="column.push.dtm" /></th>
			<td>
				<!-- 발송일자 -->
				<c:if test="${pushMessageDetail.noticeTypeCd eq adminConstants.NOTICE_TYPE_10 }">
					<fmt:formatDate value="${pushMessageDetail.sysRegDtm }" pattern="yyyy-MM-dd HH:mm:ss"/>
				</c:if>
				<c:if test="${pushMessageDetail.noticeTypeCd eq adminConstants.NOTICE_TYPE_20 }">
					<fmt:formatDate value="${pushMessageDetail.sendReqDtm }" pattern="yyyy-MM-dd HH:mm:ss"/>
				</c:if>
			</td>
		</tr>
		<tr>
			<th><spring:message code="column.push.count" /></th>
			<td>
				<!-- 발송 건수 -->
				${pushMessageDetail.noticeMsgCnt }
			</td>
			<th><spring:message code="column.push.fail_cnt" /></th>
			<td class="fontbold" style="color:#0066CC;">
				<!-- 실패 건수 -->
				${pushMessageDetail.failCnt }
			</td>
		</tr>
		<tr>
			<th><spring:message code="column.push.os_gb" /></th>
			<td colspan="3">
				<!-- OS구분 -->
				<c:if test="${empty pushMessageDetail.deviceTypeCd }">
					-
				</c:if>
				<c:if test="${not empty pushMessageDetail.deviceTypeCd }">
					<frame:codeName grpCd="${adminConstants.DEVICE_TYPE }" dtlCd="${pushMessageDetail.deviceTypeCd }" />
				</c:if>
			</td>
		</tr>
		<tr>
			<th><spring:message code="column.push.message_ttl" /></th>
			<td colspan="3">
				<!-- 메시지 타이틀 -->
				${pushMessageDetail.subject }
			</td>
		</tr>
		<tr>
			<td colspan="4">
				<!-- 알림 메시지 템플릿 영역 -->
				<div style="height:230px; overflow:auto; line-height:22px; padding-left:15px; white-space:pre-line;">
					${pushMessageDetail.contents }
				</div>
			</td>
		</tr>
	</tbody>
</table>
