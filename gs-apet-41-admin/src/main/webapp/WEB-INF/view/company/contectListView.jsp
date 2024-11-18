<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				createContectGrid();
			});

			// 그룹 코드 리스트
			function createContectGrid(){
				var options = {
					url : "<spring:url value='/company/contectListGrid.do' />"
					, height : 400
					, searchParam : $("#contectSearchForm").serializeJson()
					, colModels : [
						{name:"seNo", label:'<b><u><tt><spring:message code="column.se_no" /></tt></u></b>', width:"60", align:"center", sortable:false, formatter:'integer', classes:'pointer fontbold'}
						, _GRID_COLUMNS.compNm
						, {name:"bndNm", label:'<spring:message code="column.bnd_nm" />', width:"150", align:"center"}
						, {name:"seGoodsTpCd", label:'<spring:message code="column.se_goods_tp_cd" />', width:"120", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.SE_GOODS_TP}" />"}}
						, {name:"seSaleTpCd", label:'<spring:message code="column.se_sale_tp_cd" />', width:"120", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.SE_SALE_TP}" />"}}
						, {name:"seDstbTpCd", label:'<spring:message code="column.se_dstb_tp_cd" />', width:"150", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.SE_DSTB_TP}" />"}}
						, {name:"ctgNm", label:'<spring:message code="column.se_hope_ctg_nm" />', width:"200", align:"center"}
					]
					, onSelectRow : function(ids) {
						var rowdata = $("#contectList").getRowData(ids);
						contectView(rowdata.seNo);
					}
				};
				grid.create("contectList", options);
			}

			function reloadContectGrid(){
				var options = {
					searchParam : $("#contectSearchForm").serializeJson()
				};

				grid.reload("contectList", options);
			}

			function contectView(seNo) {
				var options = {
					url : "<spring:url value='/company/contectDetailViewPop.do' />"
					, data : {seNo : seNo}
					, dataType : "html"
					, callBack : function (data ) {
						var config = {
							id : "contectDetailView"
							, width : 1000
							, height : 800
							, top : 200
							, title : "입점 문의 상세"
							, body : data
						}
						layer.create(config);
					}
				}
				ajax.call(options );
			}
			
			function searchCompany() {
				var options = {
					multiselect : false
					, callBack : function(result) {
						if(result.length > 0) {
							$("#compNo").val(result[0].compNo);
							$("#compNm").val(result[0].compNm);
						}
					}
				}

				layerCompanyList.create(options);
			}

		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form name="contectSearchForm" id="contectSearchForm" method="post">
					<table class="table_type1">
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<th scope="row">입점 문의 기간</th>
									<td>
										<frame:datepicker startDate="strtDtm" endDate="endDtm"
											startValue="${frame:toDate('yyyy-MM-dd')}" 
											period="31" />
								</td>
		                        <th scope="row"><spring:message code="column.se_goods_tp_cd" /></th>
		                        <td>
		                            <select name="seGoodsTpCd" id="seGoodsTpCd" title="<spring:message code="column.se_goods_tp_cd" />">
		                                <frame:select grpCd="${adminConstants.SE_GOODS_TP}" defaultName="전체"/>
		                            </select>
		                        </td>
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.se_sale_tp_cd" /></th>
								<td>
									<select name="seSaleTpCd" id="seSaleTpCd" title="<spring:message code="column.se_sale_tp_cd" />">
										<frame:select grpCd="${adminConstants.SE_SALE_TP}" defaultName="전체"/>
									</select>
								</td>
		                        <th scope="row"><spring:message code="column.se_dstb_tp_cd" /></th>
		                        <td>
		                            <select name="seDstbTpCd" id="seDstbTpCd" title="<spring:message code="column.se_dstb_tp_cd" />">
		                                <frame:select grpCd="${adminConstants.SE_DSTB_TP}" defaultName="전체"/>
		                            </select>
		                        </td>						
							</tr>
						</tbody>
					</table>
				</form>
		
				<div class="btn_area_center">
					<button type="button" onclick="reloadContectGrid();" class="btn btn-ok">검색</button>
					<button type="button" onclick="resetForm('contectSearchForm');" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>
		
		<div class="mModule">
			<table id="contectList" class="grid"></table>
			<div id="contectListPage"></div>
		</div>

	</t:putAttribute>
</t:insertDefinition>