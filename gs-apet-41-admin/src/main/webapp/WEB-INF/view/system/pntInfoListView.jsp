<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		
			$(document).ready(function(){
				createPntInfoGrid();
				
	            $(document).on("keydown","#pntInfoListForm input",function(){
	      			if ( window.event.keyCode == 13 ) {
	      				reloadUserGrid();
	    		  	}
	            });					
			});
			
			//그리드 조회
			function createPntInfoGrid(){
				var options = {
					url : "<spring:url value='/system/pntInfoListGrid.do' />"
					, height : 400
					, searchParam : $("#pntInfoListForm").serializeJson()
					, colModels : [
						  {name:"pntNo", label:'<spring:message code="column.pnt_info.pnt_no" />', width:"100", align:"center", sortable:false, key:true}
						, {name:"pntTpCd", label:'<spring:message code="column.pnt_info.pnt_tp" />', width:"100", align:"center", sortable:false, 	formatter:"select",	editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.PNT_TP}" />"}}
						, {name:"saveRate", label:'<spring:message code="column.pnt_info.save_rate" />'+'(%)', width:"90", align:"center", sortable:false}
						, {name:"addSaveRate", label:'<spring:message code="column.pnt_info.add_save_rate" />'+'(%)', width:"90", align:"center", sortable:false}
						, {name:"useRate", label:'<spring:message code="column.pnt_info.use_rate" />'+'(%)', width:"90", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
								if(cellvalue){
									return cellvalue;
								}else{
									return '';
								}
							}
						}
						, {name:"ifGoodsCd", label:'<spring:message code="column.pnt_info.goods_cd" />', width:"100", align:"center", sortable:false}
						, {name:"altIfGoodsCd", label:'<spring:message code="column.pnt_info.alt_goods_cd" />', width:"110", align:"center", sortable:false}
						, {name:"pntPrmtGbCd", label:'<spring:message code="column.pnt_info.pnt_prmt_gb" />', width:"140", align:"center", sortable:false, 	formatter:"select",	editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.PNT_PRMT_GB}" />"}}
						, {name:"maxSavePnt", label:'<spring:message code="column.pnt_info.max_save_pnt" />', width:"110", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
								if(cellvalue){
									return addComma(cellvalue);
								}else{
									return '';
								}
							}
						}
						, {name:'aplStrtDtm', label:'<spring:message code="column.pnt_info.apl_strt_dtm" />', width:'150', align:'center', formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", sortable:false}
						, {name:'aplEndDtm', label:'<spring:message code="column.pnt_info.apl_end_dtm" />', width:'150', align:'center', formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", sortable:false}
						, _GRID_COLUMNS.sysRegrNm
						, _GRID_COLUMNS.sysRegDtm
						, _GRID_COLUMNS.sysUpdrNm
						, _GRID_COLUMNS.sysUpdDtm
					]
					, onSelectRow : function(ids) {
						var rowdata = $("#pntInfoList").getRowData(ids);
						//상세 조회
						pntInfoView(rowdata.pntNo);
					}
				};

				grid.create("pntInfoList", options);
			}
			
			function reloadPntInfoGrid(){
				var options = {
					searchParam : $("#pntInfoListForm").serializeJson()
				};

				grid.reload("pntInfoList", options);
			}

			// 초기화 버튼클릭
	        function searchReset () {
	            resetForm ("pntInfoListForm");
	        }
			
			//등록 or 상세
			function pntInfoView(pntNo) {
				var tabName = "";
				var url = "";
				
				if(pntNo){
					tabName = "포인트 관리 상세"; 
					url = '/system/pntInfoView.do?pntNo=' + pntNo;
				}else{
					tabName = "포인트 관리 등록"; 
					url = '/system/pntInfoView.do';
				}
				
				addTab(tabName, url);
			}

		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form name="pntInfoListForm" id="pntInfoListForm" method="post">
						<table class="table_type1">
						<caption>포인트 관리 목록</caption>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.pnt_info.pnt_tp" /></th>
								<td colspan="5">
									<!-- 포인트 유형 -->
									<select name="pntTpCd" id="pntTpCd" title="<spring:message code="column.pnt_info.pnt_tp" />">
										<frame:select grpCd="${adminConstants.PNT_TP}" defaultName="전체"/>
									</select>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				
				<div class="btn_area_center">
					<button type="button" onclick="reloadPntInfoGrid();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

		<div class="mModule">
			<div id="resultArea">
				<button type="button" onclick="pntInfoView();" class="btn btn-add">포인트 관리 등록</button>
			</div>
			
			<table id="pntInfoList" class="grid"></table>
			<div id="pntInfoListPage"></div>
		</div>
	</t:putAttribute>
</t:insertDefinition>