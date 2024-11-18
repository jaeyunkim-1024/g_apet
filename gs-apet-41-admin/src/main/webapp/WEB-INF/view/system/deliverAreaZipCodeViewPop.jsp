<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">
			$(document).ready(function(){
				// 신우편번호 리스트
				createZipCodeStreetListGrid();

				// 신우편번호만 버튼 노출
				if("${zipCodeResult.mappingCd}" == "${adminConstants.ZIP_CODE_20}") {
					$("#zipBtn").show();
				} else  {
					$("#zipBtn").hide();
				}
			});

			// 신우편번호 리스트
			function createZipCodeStreetListGrid() {
				var gridOptions = {
					url : "<spring:url value='/system/zipCodeListGrid.do'/>"
					, datatype : 'local'
					, height : 400
					, multiselect : true
					, searchParam : $("#zipCodePopForm").serializeJson()
					, colModels : [
						// 순번
						{name:"seq", label:"<spring:message code='column.seq' />", width:"100", align:"center", hidden:true}
						// 우편번호
						, {name:"zipcode", label:"<spring:message code='column.display_view.post_code' />", width:"100", align:"center"}
						// 주소
						, {name:"addr", label:"<spring:message code='column.addr' />", width:"450", align:"left"}
						// 등록된 지역
						, {name:"areaNm", label:"<spring:message code='column.display_view.zip_area' />", width:"200", align:"center"}
					]
				}

				grid.create("zipCodeList", gridOptions);
			}

			// 검색
			function reloadZipCodeListGrid() {
				if(validate.check("zipCodePopForm")) {
					var options = {
						searchParam : $("#zipCodePopForm").serializeJson()
					};

					grid.reload("zipCodeList", options);
				}
			}

			// 초기화
			function resetZipCodePopForm() {
				$("#deliverNm").val("");
			}

			// 우편번호 탭 변경
			function zipCodeChangeView(mappingCd) {
				var url = "/system/deliverAreaZipCodeViewPop.do";

				createFormSubmit("zipCodePopForm", url, {mappingCd : mappingCd});
			}

			// 직배송 지역 저장
			function deliverAreaSave() {
				var grid = $("#zipCodeList");
				var items = new Array();

				var rowids = grid.jqGrid('getGridParam', 'selarrrow');
				var areaId = $("#areaCd option:selected").val();

				if(rowids.length <= 0 ) {
					messager.alert("<spring:message code='column.display_view.message.no_select' />", "Info", "info");
					return;
				} else {
					for(var i = 0; i < rowids.length; i++) {
						var data = $("#zipCodeList").getRowData(rowids[i]);

						$.extend(data, {
							areaId : areaId
						});

						items.push({
							seq : data.seq
						  , areaId : areaId
						});
					}

					sendData = {
		 				zipCodePOList : JSON.stringify(items)
	 				};
				}

				messager.confirm("<spring:message code='column.display_view.message.confirm_save' />", function(r){
					if(r){
						var options = {
							url : "<spring:url value='/system/deliverAreaZipCodeSave.do' />"
							, data : sendData
							, callBack : function(data) {
								// 검색
								reloadZipCodeListGrid();
							}
						};

						ajax.call(options);	
					}
				})
			}

			// 신우편번호 추가
			function zipcodePost(result){
				sendData = {
					zipcode : result.zonecode
				  , mappingCd : $("#mappingCd").val()
				}

				var options = {
					url : "<spring:url value='/system/deliverAreaZipCodeInsert.do' />"
					, data : sendData
					, callBack : function(data) {
						// 검색
						reloadZipCodeListGrid();
					}
				};

				ajax.call(options);
			}
		</script>
			<form name="zipCodePopForm" id="zipCodePopForm" onSubmit="return false;">
				<c:set var="selActive" value="${zipCodeResult.mappingCd}" />
				<input type="hidden" name="mappingCd" id="mappingCd" value="${zipCodeResult.mappingCd}">
				<table class="table_type1">
					<caption>정보 검색</caption>
					<tbody>
						<tr>
							<!-- 지역명 -->
							<th scope="row"><spring:message code="column.area_name" /></th>
							<td>
								<input type="text" class="validate[required] input_text" name="deliverNm" id="deliverNm" title="<spring:message code="column.area_name"/>"/>
								<p class="red-desc">* 동,면,읍 으로 검색해주세요. 예) 역삼동, 화도읍, 장유면</p>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
			<div class="btn_area_center">
				<button type="button" onclick="reloadZipCodeListGrid();" class="btn btn-ok">검색</button>
				<button type="button" onclick="resetZipCodePopForm();" class="btn btn-cancel">초기화</button>
			</div>
			<div class="mTab typePage">
				<ul class="tabMenu">
					<li ${selActive eq '20' ? 'class="active"' : ''}><a href="javascript:zipCodeChangeView('20')">신우편번호</a></li>
					<li ${selActive eq '10' ? 'class="active"' : ''}><a href="javascript:zipCodeChangeView('10')">구우편번호</a></li>
				</ul>
			</div>
			
			<div class="mModule">
				<table id="zipCodeList" ></table>
				<div id="zipCodeListPage"></div>
			</div>

			<div class="btn_area_center">
				선택된 지역을 직배송
				<select name="areaCd" id="areaCd" class="" title="<spring:message code="column.display_view.area_gubun"/>">
					<c:forEach items="${deliverArea}" var="result" varStatus="idx">
						<option value="${result.areaId}">${result.areaName}</option>
					</c:forEach>
				</select>
				으로 <button type="button" onclick="deliverAreaSave();" class="btn">저장</button>
			</div>
