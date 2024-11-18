<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<link rel="stylesheet" type="text/css" media="screen" href="/tools/fullcalendar/fullcalendar.css" />
		<script src="/tools/fullcalendar/lib/moment.min.js"></script>
		<script src="/tools/fullcalendar/fullcalendar.js"></script>
		<script src="/tools/fullcalendar/lang/ko.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				// 달력 생성
				createCalendar();
			});

			// 달력 생성
			function createCalendar() {
				$('#calendar').fullCalendar({
					header: {
						left: 'prevYear,prev,next,nextYear today'
						, right: ''
						, center: 'title'
					},
					editable: false,
					eventLimit: true,
					events: function(start, end, timezone, callback) {
						var options = {
							url : "<spring:url value='/system/capaCalendar.do' />"
							, data : {
								strtDate : new Date(start).format("yyyy-MM-dd")
								, endDate : new Date(end).format("yyyy-MM-dd")
								, areaCd : '${adminConstants.AREA_10}'
							}
							, callBack : function(result){
								var events = new Array();
								if(result != null) {
									if(result.deliverDateSetList != null && result.deliverDateSetList.length > 0) {
										$.each(result.deliverDateSetList, function(key, val) {
											// 일일케파용량

											var title = new Array();
											title.push('<span class="fontbold">');
											title.push(val.areaName.trim().substring(0,1));
											title.push('</span> - ');
											title.push('<span class="">');
											title.push(addComma(val.daysDeliveryLimit));
											title.push('</span> | ');

											if(val.daysDeliveryLimit > val.daysDeliveryStatus) {
												title.push('<span class="">');
												title.push(addComma(val.daysDeliveryStatus));
												title.push('</span> | ');
											} else {
												title.push('<span class="red">');
												title.push(addComma(val.daysDeliveryStatus));
												title.push('</span> | ');
											}
											title.push('<span class="">');
											title.push(addComma(val.daysDeliveryCntLimit));
											title.push('</span> | ');

											if(val.daysDeliveryCntLimit > val.daysDeliveryCntStatus) {
												title.push('<span class="">');
												title.push(addComma(val.daysDeliveryCntStatus));
												title.push('</span>');
											} else {
												title.push('<span class="red">');
												title.push(addComma(val.daysDeliveryCntStatus));
												title.push('</span>');
											}

											events.push({
												title: title.join("")
												, start: val.deliverDate
												, htmlEscapeCheck : true
											});
										});
									}

									if(result.holidayList != null && result.holidayList.length > 0) {
										$.each(result.holidayList, function(key, val) {
											events.push({
												id : val.holidayNo
												, title: val.title
												, start: new Date(val.holidayDate).format("yyyy-MM-dd")
												, rendering : "background"
												, color : "#fecfcb"
											});
										});
									}
								}
								callback(events);
							}
						};

						ajax.call(options);
					}
					// 휴일 추가
					, dayClick: function(date, jsEvent, view) {
						capaLayerView(new Date(date).format("yyyy-MM-dd"));
					}
					// 케파 수정 / 휴일 수정
					, eventClick: function(calEvent, jsEvent, view) {
					}
					// 사용자 렌더링
					, eventAfterAllRender : function(view) {
						$("#yyyy").val(new Date(view.intervalStart._d).format("yyyy"));
						$("#mm").val(new Date(view.intervalStart._d).format("MM"));
					}
				});
			}

			// 달력 검색
			function reloadCalendar() {
				$('#calendar').fullCalendar('refetchEvents');
			}

			function capaSettingLayerView() {
				var options = {
					url : "<spring:url value='/system/capaSettingLayerView.do' />"
					, data : {
						areaCd : '${adminConstants.AREA_10}'
					}
					, dataType : "html"
					, callBack : function (data ) {
						var config = {
							id : "capaSettingLayer"
							, width : 600
							, height : 600
							, top : 100
							, title : "직배송 배차 캘린더 환경설정"
							, body : data
							, button : "<button type=\"button\" onclick=\"deliverDateSetSettingSave();\" class=\"btn btn-ok\">확인</button>"
						}
						layer.create(config);
					}
				}
				ajax.call(options );
			}

			function capaLayerView(date) {
				var options = {
					url : "<spring:url value='/system/capaLayerView.do' />"
					, data : {
						holidayDate : date
						, deliverDate : date
						, areaCd : '${adminConstants.AREA_10}'
					}
					, dataType : "html"
					, callBack : function(data) {
						var config = {
							id : "capaLayer"
							, width : 600
							, height : 600
							, top : 100
							, title : "직배송 배차 캘린더 일일 환경설정"
							, body : data
							, button : "<button type=\"button\" onclick=\"deliverDateSetHolidaySave();\" class=\"btn btn-ok\">확인</button>"
						}
						layer.create(config);
					}
				}
				ajax.call(options );
			}

			$(document).on("change" , "#capaLayerForm #areaId", function(e){
				var options = {
					url : "<spring:url value='/system/deliverDateSetResult.do' />"
					, data : $("#capaLayerForm").serializeJson()
					, callBack : function(result) {
						if(result.deliverDateSet != null) {
							$("#detailDaysDeliveryLimit").val(addComma(result.deliverDateSet.daysDeliveryLimit));
							$("#detailDeliveryIncrease").val(addComma(result.deliverDateSet.deliveryIncrease));
							$("#detailDaysDeliveryCntLimit").val(addComma(result.deliverDateSet.daysDeliveryCntLimit));
						} else {
							$("#detailDaysDeliveryLimit").val(0);
							$("#detailDeliveryIncrease").val(0);
							$("#detailDaysDeliveryCntLimit").val(0);
						}
					}
				};
				ajax.call(options);
			});

			function deliverDateSetSettingSave(){
				if(validate.check("capaSettingLayerForm")) {
					messager.confirm('<spring:message code="column.common.confirm.insert" />', function(r){
						if(r){
							var options = {
								url : "<spring:url value='/system/deliverDateSetSettingSave.do' />"
								, data : $("#capaSettingLayerForm").serializeJson()
								, callBack : function(result) {
									layer.close ("capaSettingLayer" );
									reloadCalendar();
								}
							};

							ajax.call(options);
						}
					})
				}
			}

			function deliverDateSetHolidaySave(){

				if(validation.isNull($("#capaLayerForm #daysDeliveryLimit").val())
					&& validation.isNull($("#capaLayerForm #deliveryIncrease").val())
					&& validation.isNull($("#capaLayerForm #daysDeliveryCntLimit").val())) {
					objClass.remove($("#capaLayerForm #daysDeliveryLimit"), "validate[required,custom[number]]");
					objClass.remove($("#capaLayerForm #deliveryIncrease"), "validate[required,custom[number],min[0],max[100]]");
					objClass.remove($("#capaLayerForm #daysDeliveryCntLimit"), "validate[required,custom[number]]");
					objClass.remove($("#capaLayerForm #areaId"), "validate[required]");
				} else {
					objClass.add($("#capaLayerForm #daysDeliveryLimit"), "validate[required,custom[number]]");
					objClass.add($("#capaLayerForm #deliveryIncrease"), "validate[required,custom[number],min[0],max[100]]");
					objClass.add($("#capaLayerForm #daysDeliveryCntLimit"), "validate[required,custom[number]]");
					objClass.add($("#capaLayerForm #areaId"), "validate[required]");
				}

				if(validate.check("capaLayerForm")) {
					if(confirm('<spring:message code="column.common.confirm.insert" />')) {
						var options = {
							url : "<spring:url value='/system/deliverDateSetHolidaySave.do' />"
							, data : $("#capaLayerForm").serializeJson()
							, callBack : function(result) {
								layer.close ("capaLayer" );
								reloadCalendar();
							}
						};

						ajax.call(options);
					}
				}
			}

			function dateSearch(){
				$('#calendar').fullCalendar("gotoDate", $("#yyyy").val() + "-" + $("#mm").val() );
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">

		<div class="mTitle">
			<h2>케파 목록</h2>
		</div>

		<table class="table_type1">
			<caption>정보 검색</caption>
			<tbody>
				<tr>
					<th scope="row"><spring:message code="column.common.date" /></th>
					<td>
						<select name="yyyy" id="yyyy" title="<spring:message code="column.common.date" />">
							<frame:select grpCd="${adminConstants.YYYY}" selectKey="${frame:toDate('yyyy')}"/>
						</select>
						<select name="mm" id="mm" title="<spring:message code="column.common.date" />">
							<frame:select grpCd="${adminConstants.MM}" selectKey="${frame:toDate('MM')}"/>
						</select>
					</td>
				</tr>
			</tbody>
		</table>
		
		<div class="btn_area_center">
			<button type="button" onclick="dateSearch();" class="btn btn-ok">검색</button>
			<button type="button" onclick="resetForm('userSearchForm');" class="btn btn-cancel">초기화</button>
		</div>

		<div class="mButton">
			<div class="leftInner">
				<button type="button" onclick="capaSettingLayerView();" class="btn btn-add">설정</button>
			</div>
		</div>

		<p class="red-desc">※ 배송 지역 - 일일배송한계량 | 현재배송한계량 | 일일배송한계수량 | 현재배송한계수량</p>

		<!-- 케파관리 달력 -->
		<div id="calendar" class="mt20" style="width: 100%"></div>

	</t:putAttribute>
</t:insertDefinition>