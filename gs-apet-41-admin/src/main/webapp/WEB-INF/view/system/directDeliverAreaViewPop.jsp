<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">
			$(document).ready(function(){
				var areaGubunText = $("#areaCd option:selected").text();
				$("#areaName").val(areaGubunText);
			});

			$(document).on("change", "#areaCd", function(e) {
				var areaGubunText = $("#areaCd option:selected").text();
				$("#areaName").val(areaGubunText);
			});

			// 창고 검색
			function wareHouseViewPop(popType) {
				var options = {
					url : "<spring:url value='/system/wareHouseViewPop.do' />"
					, data : {popType : popType }
					, dataType : "html"
					, callBack : function (data ) {
						var config = {
							id : "wareHouseView"
							, width : 1200
							, height : 800
							, top : 200
							, title : "창고 검색"
							, body : data
						}
						layer.create(config);
					}
				}
				ajax.call(options );
			}

			// 창고 검색 콜백(창고번호, 창고명, 창고코드, 창고유형, 지역구분, 창고 검색 구분)
			function callBackWareHouse(whsNo, whsNm, whsCd, rltnWhs, areaGbCd, popType) {
				if(popType != "") {
					if(popType == "A") {
						// 출고창고
						$("#outgoStorageNm").val(whsNm);
						$("#outgoStorageId").val(whsNo);
					} else if(popType == "B") {
						// AS창고1
						$("#asStorageNm1").val(whsNm);
						$("#asStorageId1").val(whsNo);
					} else if(popType == "C") {
						// AS창고2
						$("#asStorageNm2").val(whsNm);
						$("#asStorageId2").val(whsNo);
					}
				}
			}

			// 등록 / 수정
			function directDeliverAreaSave() {
				if(validate.check("directDeliverAreaPopForm")) {
					messager.confirm('<spring:message code="column.display_view.message.confirm_save" />', function(r){
						if(r){
							var options = {
								url : "<spring:url value='/system/directDeliverAreaSave.do' />"
								, data : $("#directDeliverAreaPopForm").serializeJson()
								, callBack : function(result){
									opener['reloadDirectDeliverAreaGrid']();
									popupClose();
								}
							};

							ajax.call(options);
						}
					})
				}
			}
		</script>
			<form name="directDeliverAreaPopForm" id="directDeliverAreaPopForm">
				<input type="hidden" name="areaId" id="areaId" value="${directDeliverAreaResult.areaId}">

				<table class="table_type1">
					<caption>직배송지역 정보</caption>
					<tbody>
						<tr>
							<th><spring:message code="column.display_view.area_gubun"/><strong class="red">*</strong></th>
							<td>
								<!-- 지역구분-->
								<select name="areaCd" id="areaCd" class="validate[required]" title="<spring:message code="column.display_view.area_gubun"/>">
									<frame:select grpCd="${adminConstants.AREA}" selectKey="${directDeliverArea[0].areaCd}"/>
								</select>
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.area_name"/><strong class="red">*</strong></th>
							<td>
								<!-- 지역명-->
								<input type="text" class="w300 validate[required]" name="areaName" id="areaName" title="<spring:message code="column.area_name"/>" value="${directDeliverArea[0].areaName}" />
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.display_view.outgo_storage"/></th>
							<td>
								<!-- 출고창고-->
								<input type="hidden" class="w300" name="outgoStorageId" id="outgoStorageId" value="${directDeliverArea[0].outgoStorageId}" />
								<input type="text" class="w300" name="outgoStorageNm" id="outgoStorageNm" title="<spring:message code="column.display_view.outgo_storage"/>" value="${directDeliverArea[0].outgoStorageNm}" />
								<button type="button" onclick="wareHouseViewPop('A');" class="btn">검색</button>
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.as_storage_id1"/>
							<td>
								<!-- AS창고1-->
								<input type="hidden" class="w300" name="asStorageId1" id="asStorageId1" value="${directDeliverArea[0].asStorageId1}" />
								<input type="text" class="w300" name="asStorageNm1" id="asStorageNm1" title="<spring:message code="column.as_storage_id1"/>" value="${directDeliverArea[0].asStorageNm1}" />
								<button type="button" onclick="wareHouseViewPop('B');" class="btn">검색</button>
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.as_storage_id2"/></th>
							<td>
								<!-- AS창고2-->
								<input type="hidden" class="w300" name="asStorageId2" id="asStorageId2" value="${directDeliverArea[0].asStorageId2}" />
								<input type="text" class="w300" name="asStorageNm2" id="asStorageNm2" title="<spring:message code="column.as_storage_id2"/>" value="${directDeliverArea[0].asStorageNm2}" />
								<button type="button" onclick="wareHouseViewPop('C');" class="btn">검색</button>
							</td>
						</tr>
					</tbody>
				</table>
			</form>

