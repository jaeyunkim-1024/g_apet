<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="popupLayout">
	<t:putAttribute name="title">휴일 관리</t:putAttribute>
	<t:putAttribute name="script">
		<script type="text/javascript">
			// 등록 / 수정
			function saveHoliday() {
				if(validate.check("holidayPopForm")) {
					
					messager.confirm('<spring:message code="column.display_view.message.confirm_save" />',function(r){
						if(r){
							var options = {
								url : "<spring:url value='/main/holidaySave.do' />"
								, data : $("#holidayPopForm").serializeJson()
								, callBack : function(result){
									opener['reloadCalendar']();
									popupClose();
								}
							};

							ajax.call(options);
						}
					});
				}
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="popTitle">휴일 관리 팝업</div>
		<div class="popContent">
			<form name="holidayPopForm" id="holidayPopForm">
				<input type="hidden" name="holidayNo" id="holidayNo" value="${holidayResult.holidayNo}">

				<table class="table_type1 popup">
					<caption>휴일 정보</caption>
					<tbody>
						<tr>
							<th><spring:message code="column.ttl"/><strong class="red">*</strong></th>
							<td>
								<!-- 제목-->
								<input type="text" class="w300 validate[required]" name="title" id="title" title="<spring:message code="column.ttl"/>" value="${holiday[0].title}" />
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.display_view.start_date"/><strong class="red">*</strong></th>
							<td>
								<!-- 시작기간-->
								<div class="mCalendar typeLayer">
									<span class="date_picker_box">
										<input type="text" name="startDate" id="startDate" class="datepicker validate[required,custom[date]]" title="날짜선택" value="${empty holiday[0].startDate ? holidayResult.startDate : holiday[0].startDate}" /><img src="/images/calendar_icon.png" class="datepickerBtn" alt="날짜선택" />
									</span>
								</div>
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.display_view.end_date"/><strong class="red">*</strong></th>
							<td>
								<!-- 종료기간-->
								<div class="mCalendar typeLayer">
									<span class="date_picker_box">
										<input type="text" name="endDate" id="endDate" class="datepicker validate[required,custom[date],future[#startDate]]" title="날짜선택" value="${empty holiday[0].endDate ? holidayResult.endDate : holiday[0].endDate}" /><img src="/images/calendar_icon.png" class="datepickerBtn" alt="날짜선택" />
									</span>
								</div>
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.content"/><strong class="red">*</strong></th>
							<td>
								<!-- 내용-->
								<textarea rows="3" cols="80" class="validate[required]" name="contents" >${holiday[0].contents}</textarea>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
			<div class="btn_area_center">
				<button type="button" class="btn btn-ok" onclick="saveHoliday();">저장</button>
				<button type="button" class="btn btn-cancel" onclick="popupClose();">닫기</button>
			</div>

			<div class="closeBtn">
				<button type="button" class="btn btn-cancel" onclick="popupClose();">팝업 닫기</button>
			</div>
		</div>
	</t:putAttribute>
</t:insertDefinition>
