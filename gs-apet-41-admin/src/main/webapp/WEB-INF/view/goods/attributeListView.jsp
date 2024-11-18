<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function() {
			createAttributeGrid();

			/**
			 * 키 엔터
			 */
			$('#attrNo, #attrNm').on('keydown', function(event) {
				if (event.keyCode == 13) {
					event.preventDefault();
					//console.log('enter key')
					searchAttributeList();
				}
			});
		});

		function createAttributeGrid () {
			// attributeList
			var gridOptions = {
				url : "<spring:url value='/goods/attributeGrid.do' />"
				, height : 400
				, searchParam : $("#attributeListForm").serializeJson()
				, cellEdit : true
// 				, multiselect : true
				, colModels : [
					{name:"attrNo", label:'<b><u><tt><spring:message code="column.attr_no" /></tt></u></b>', width:"70", align:"center", key:true, sortable:false, classes:"pointer fontbold"}
					, {name:"attrNm", label:"<spring:message code='column.attr_nm' />", width:"200", align:"center", sortable:false}
					, _GRID_COLUMNS.useYn
					,{name:'sysRegrNm', label:'<spring:message code="column.sys_regr_nm" />', width:'90', align:'center', sortable:false}	
					,{name:'sysRegDtm', label:'<spring:message code="column.sys_reg_dtm" />', width:'150', align:'center', formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", sortable:false}
					,{name:'sysUpdrNm', label:'<spring:message code="column.sys_updr_nm" />', width:'90', align:'center', sortable:false}
					,{name:'sysUpdDtm', label:'<spring:message code="column.sys_upd_dtm" />', width:'150', align:'center', formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", sortable:false}
				]
				, onCellSelect : function (ids, cellidx, cellvalue) {
// 					if (cellidx > 0) {
						attributeView(ids);
// 					}
				}
			}
			grid.create("attributeList", gridOptions);
		}
		
		function attributeView (attrNo) {
			var url = '/goods/attributeView.do?attrNo=' + attrNo;
			addTab('옵션(속성) 상세', url);
		}

		function searchAttributeList () {
			var options = {
				searchParam : $("#attributeListForm").serializeJson()
			};
			grid.reload("attributeList", options);
		}

		function searchReset () {
			resetForm ("attributeListForm" );
		}
		
		function deleteAttribute() {
			var grid = $("#attributeList");
			var rowids = grid.jqGrid('getGridParam', 'selarrrow');
			if(rowids.length <= 0 ) {
				messager.alert("<spring:message code='column.common.delete.no_select' />", "Info", "info");
				return;
			}
			
			var url = "<spring:url value='/goods/deleteAttribute.do' />";

			messager.confirm("<spring:message code='column.common.confirm.delete' />",function(r){
				if(r){
					var attributeItems = new Array();
					var grid = $("#attributeList");
					var rowids = grid.jqGrid('getGridParam', 'selarrrow');
					
					for (var i = 0; i < rowids.length; i++) {
						var rowdata = $("#attributeList").getRowData(rowids[i]);
						var data = {
							attrNo : rowdata.attrNo
						};
						
						attributeItems.push (data);
					}
					
					var sendData = {
						attributeItemPO : JSON.stringify(attributeItems)
	 				};
	
					var options = {
						url : url
						, data : sendData
						, callBack : function(result){
							messager.alert("<spring:message code='column.common.delete.final_msg' arguments='" + result.delCnt + "' />", "Info", "info", function(){
								searchAttributeList ();
							});
							
						}
					};
	
					ajax.call(options);
				}
			});
		}

		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form id="attributeListForm" name="attributeListForm" method="post" >
					<table class="table_type1">
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.attr_no" /></th>
								<td>
									<input type="text" class="numeric" name="attrNo" id="attrNo" title="<spring:message code="column.attr_no" />" >
								</td>
								<th scope="row"><spring:message code="column.attr_nm" /></th>
								<td>
									<input type="text" name="attrNm" id="attrNm" title="<spring:message code="column.attr_nm" />" >
								</td>
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.use_yn" /></th>
								<td colspan="3">
		                            <frame:radio name="useYn" grpCd="${adminConstants.USE_YN }" defaultName="전체" selectKey="${adminConstants.USE_YN_Y}"/>
		                        </td>
							</tr>
						</tbody>
					</table>
				</form>
	
				<div class="btn_area_center">
					<button type="button" onclick="searchAttributeList();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>
		<div class="mModule">
			<button type="button" onclick="attributeView('');" class="btn btn-add">옵션(속성) 등록</button>
			<!--<button type="button" onclick="deleteAttribute();" class="btn btn-add">삭제</button> -->
			
			<table id="attributeList" ></table>
			<div id="attributeListPage"></div>
		</div>

	</t:putAttribute>

</t:insertDefinition>