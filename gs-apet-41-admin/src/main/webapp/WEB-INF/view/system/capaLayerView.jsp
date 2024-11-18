<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<form id="capaLayerForm" name="capaLayerForm" method="post" >
				<table class="table_type1">
					<caption>직배송 배차 캘린더</caption>
					<colgroup>
						<col style="width:30%;">
						<col />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><spring:message code="column.common.date" /><strong class="red">*</strong></th>
							<td>
								<input type="text" name="deliverDate" id="deliverDate" readonly="readonly" class="readonly validate[required,custom[date]]" title="날짜선택" value="${empty deliverDateSet.deliverDate? deliverDateSetSO.deliverDate : deliverDateSet.deliverDate}" />
							</td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.area_id" /><strong class="red">*</strong></th>
							<td>
								<select name="areaId" id="areaId" title="<spring:message code="column.area_id"/>">
								<c:if test="${empty listDirectDeliverArea}">
									<option value="">해당없음</option>
								</c:if>
								<c:forEach items="${listDirectDeliverArea}" var="item">
									<option value="${item.areaId}">${item.areaName}</option>
								</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row">등록 일일배송 한계량</th>
							<td>
								<input type="text" readonly="readonly" class="comma readonly" id="detailDaysDeliveryLimit" title="<spring:message code="column.days_delivery_limit"/>" value="${empty deliverDateSet.daysDeliveryLimit ? '0' : deliverDateSet.daysDeliveryLimit}" />
							</td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.days_delivery_limit" /><strong class="red">*</strong></th>
							<td>
								<input type="text" class="comma" name="daysDeliveryLimit" id="daysDeliveryLimit" title="<spring:message code="column.days_delivery_limit"/>" value="" />
							</td>
						</tr>
						<tr>
							<th scope="row">등록 배송량 가중치</th>
							<td>
								<input type="text" readonly="readonly" class="readonly" maxlength="3" id="detailDeliveryIncrease" title="<spring:message code="column.delivery_increase"/>" value="${empty deliverDateSet.deliveryIncrease ? '0' : deliverDateSet.deliveryIncrease}" /> %
							</td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.delivery_increase" /><strong class="red">*</strong></th>
							<td>
								<input type="text" class="numeric" maxlength="3" name="deliveryIncrease" id="deliveryIncrease" title="<spring:message code="column.delivery_increase"/>" value="" /> %
							</td>
						</tr>
						<tr>
							<th scope="row">등록 일일배송 수량 한계</th>
							<td>
								<input type="text" readonly="readonly" class="comma readonly" id="detailDaysDeliveryCntLimit" title="<spring:message code="column.days_delivery_cnt_limit"/>" value="${empty deliverDateSet.daysDeliveryCntLimit ? '0' : deliverDateSet.daysDeliveryCntLimit}" /> 수량
							</td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.days_delivery_cnt_limit" /><strong class="red">*</strong></th>
							<td>
								<input type="text" class="comma" name="daysDeliveryCntLimit" id="daysDeliveryCntLimit" title="<spring:message code="column.days_delivery_cnt_limit"/>" value="" /> 수량
							</td>
						</tr>
					</tbody>
				</table>
				
				<div class="mTitle mt30">
					<h2>휴일 관리</h2>
				</div>
				<table class="table_type1">
					<caption>휴일 정보</caption>
					<colgroup>
						<col style="width:150px;" />
						<col />
					</colgroup>
					<tbody>
						<tr>
							<th><spring:message code="column.holiday_date"/><strong class="red">*</strong></th>
							<td>
								<div class="mg5">
									<label><input type="checkbox" name="holidayDateYn" value="${adminConstants.COMM_YN_Y}" ${empty holiday ? '' : 'checked="checked"'}> <span>해당 일자를 공휴일로 설정합니다.</span></label>
								</div>
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.holiday_date"/><strong class="red">*</strong></th>
							<td>
								<input type="text" name="holidayDate" id="holidayDate" readonly="readonly" class="readonly validate[required,custom[date]]" title="날짜선택" value="${empty holiday.holidayDate ? holidaySO.holidayDate : holiday.holidayDate}" />
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.ttl"/></th>
							<td>
								<!-- 제목-->
								<input type="text" class="w300" name="title" id="title" title="<spring:message code="column.ttl"/>" value="${holiday.title}" />
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.content"/></th>
							<td>
								<!-- 내용-->
								<textarea class="w300" name="contents" >${holiday.contents}</textarea>
							</td>
						</tr>
					</tbody>
				</table>
</form>