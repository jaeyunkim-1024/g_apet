<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<form id="capaSettingLayerForm" name="capaSettingLayerForm" method="post" >
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
								<div class="mg5">
									<label class="fRadio"><input type="radio" checked="checked" name="deliverGubunCd" id="deliverGubunCd${adminConstants.DELIVER_GUBUN_10}" value="${adminConstants.DELIVER_GUBUN_10}"></label>
									<frame:datepicker startDate="strtDeliverDate" endDate="endDeliverDate" />
								</div>
								<div class="mg5">
									<label class="fRadio"><input type="radio" name="deliverGubunCd" id="deliverGubunCd${adminConstants.DELIVER_GUBUN_20}" value="${adminConstants.DELIVER_GUBUN_20}"></label>
									<div class="mCalendar typeLayer">
										<span class="date_picker_box">
											<input type="text" name="deliverDate" id="deliverDate" class="datepicker validate[required, custom[date]]" title="날짜선택" value="${frame:toDate('yyyy-MM-dd')}" />
											<img src="/images/calendar_icon.png" class="datepickerBtn" alt="날짜선택" />
										</span> 이후 계속
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.area_id" /><strong class="red">*</strong></th>
							<td>
								<select name="areaId" id="areaId" class="validate[required]" title="<spring:message code="column.area_id"/>">
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
							<th scope="row"><spring:message code="column.days_delivery_limit" /><strong class="red">*</strong></th>
							<td>
								<input type="text" class="comma validate[required,custom[number]]" name="daysDeliveryLimit" id="daysDeliveryLimit" title="<spring:message code="column.days_delivery_limit"/>" value="" />
							</td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.delivery_increase" /><strong class="red">*</strong></th>
							<td>
								<input type="text" class="numeric validate[required,custom[number],min[0],max[100]]" maxlength="3" name="deliveryIncrease" id="deliveryIncrease" title="<spring:message code="column.delivery_increase"/>" value="" /> %
							</td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.days_delivery_cnt_limit" /><strong class="red">*</strong></th>
							<td>
								<input type="text" class="comma validate[required,custom[number]]" name="daysDeliveryCntLimit" id="daysDeliveryCntLimit" title="<spring:message code="column.days_delivery_cnt_limit"/>" value="" /> 수량
							</td>
						</tr>
					</tbody>
				</table>
</form>