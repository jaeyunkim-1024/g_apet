<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">
			$(document).ready(function(){
				// 창고 리스트
				createWareHouseGrid();
			});

			// 창고 리스트
			function createWareHouseGrid() {
				var gridOptions = {
					url : "<spring:url value='/system/wareHouseListGrid.do'/>"
					, height : 400
					, searchParam : $("#wareHousePopForm").serializeJson()
					, colModels : [
						// 창고번호
						  {name:"whsNo", label:"<spring:message code='column.whs_no' />", width:"50", key: true, align:"center"}
						// 창고유형명
						, {name:"whsTpNm", label:"<spring:message code='column.display_view.whs_cd' />", width:"150", align:"center"}
						// 창고명
						, {name:"whsNm", label:"<spring:message code='column.display_view.whs_nm' />", width:"150", align:"center"}
						// 주소
						, {name:"addr", label:"<spring:message code='column.addr' />", width:"500", align:"center"}
						// 책임자
						, {name:"managerNm", label:"<spring:message code='column.manager_nm' />", width:"150", align:"center"}
						// 책임자연락처
						, {name:"managerTel", label:"<spring:message code='column.manager_tel' />", width:"150", align:"center"}
						// 창고코드
						, {name:"whsCd", label:"<spring:message code='column.manager_tel' />", width:"150", align:"center", hidden:true}
						// 창고유형
						, {name:"rltnWhs", label:"<spring:message code='column.manager_tel' />", width:"150", align:"center", hidden:true}
						// 지역구분
						, {name:"areaGbCd", label:"<spring:message code='column.manager_tel' />", width:"150", align:"center", hidden:true}
					]
					, onSelectRow : function(ids) {
						var rowdata = $("#wareHouseList").getRowData(ids);

						// 창고 검색 콜백(창고번호, 창고명, 창고코드, 창고유형, 지역구분, 창고 검색 구분)
						callBackWareHouse(rowdata.whsNo, rowdata.whsNm, rowdata.whsCd, rowdata.rltnWhs, rowdata.areaGbCd, $("#popType").val());
						layer.close('wareHouseView');
					}
				}

				grid.create("wareHouseList", gridOptions);
			}
		</script>
			<form name="wareHousePopForm" id="wareHousePopForm">
				<input type="hidden" name="popType" id="popType" value="${directDeliverAreaResult.popType}">
				<table class="table_type1">
					<caption>정보 검색</caption>
					<tbody>
						<tr>
							<!-- 창고구분 -->
							<th scope="row"><spring:message code="column.display_view.whs_cd" /></th>
							<td>
								<select id="whsTp" name="whsTp" >
									<frame:select grpCd="${adminConstants.WMS_WAREHOUSE_TYPE}" defaultName="선택" />
								</select>
							</td>
						</tr>
						<tr>
							<!-- 창고명 -->
							<th scope="row"><spring:message code="column.display_view.whs_nm"/></th>
							<td>
								<input type="text" name="whsNm" id="whsNm" title="<spring:message code="column.display_view.whs_nm"/>" value="" />
							</td>
						</tr>
					</tbody>
				</table>
			</form>
			<div class="btn_area_center">
				<button type="button" onclick="searchWareHouseList();" class="btn btn-ok">검색</button>
				<button type="button" onclick="resetForm('wareHousePopForm');" class="btn btn-cancel">초기화</button>
			</div>

			<div class="mModule">
				<table id="wareHouseList" ></table>
				<div id="wareHouseListPage"></div>
			</div>
