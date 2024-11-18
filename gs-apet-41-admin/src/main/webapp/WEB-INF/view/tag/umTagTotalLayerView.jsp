<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
let rIndex = 0;
var isGridExistsTotal = false;
if(isGridExistsTotal){
	var options = {
		searchParam : $("#umTagListForm").serializeJson()
	};
	grid.reload("tagBaseList", options);
}else{
	viewNewTagRltListPopGrid();	
}
function viewNewTagRltListPopGrid(){			
	setLayerPopParam("Total");
	
	var gridOptions = {
			url : "<spring:url value='/tag/pageUmTagTotalLayer.do' />"
			, height : 300
			, searchParam : $("#umTagListForm").serializeJson()
			, sortname : 'sysRegDtm'
			, sortorder : 'DESC'
			, colModels : [
				 {name:"rowIndex", label:'No.', width:"55", align:"center", classes:'cursor_default', sortable:false, formatter: function(cellvalue, options, rowObject){
						let nTotalCnt = $("#umTagList").getGridParam("records");
						let nPage = $('#umTagList').jqGrid('getGridParam', 'page');
						let nRows = $('#umTagList').jqGrid('getGridParam', 'rowNum');
						let No = nTotalCnt - ( nPage-1 )*nRows - (rIndex);
						rIndex++;
						return No;
				  	}
				  }
				, {name:"rltGb", 		label:_TAG_RLT_LIST_GRID_LABEL.rltGb ,  width:"130", 	align:"center", sortable:false} 	
				, {name:"rltTp", 		label:_TAG_RLT_LIST_GRID_LABEL.rltTp ,  width:"120",  	align:"center", sortable:false}
				, {name:"rltId", 		label:"컨텐츠 ID / 상품 번호" , 				width:"280", 	align:"left", sortable:false, classes:'pointer fontbold'} 		
				, {name:"rltGbCd", 		label:"" ,	width:"265", 	align:"center", sortable:false, hidden:true}
				//, _GRID_COLUMNS.sysRegrNm
				//, _GRID_COLUMNS.sysRegDtm
				, {name:"sysRegrNm", 	label : "<spring:message code='column.sys_regr_nm' />", width : "100",  sortable:false, align : "center", hidden:true}
				, {name:"sysRegDtm",	label:'<spring:message code="column.regdate" />',		width:"180", 	align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy.MM.dd HH:mm:ss"} 	
				, {name:"rltId", key: true, hidden:true}
			]
			//,rownumbers: true
			, onCellSelect : function (id, cellidx, cellvalue) {
				if(cellidx == 3) {
					var rowData = $("#umTagList").getRowData(id);
					var rltId = rowData.rltId;	
					var rltTp = rowData.rltTp;
					var rltGbCd = rowData.rltGbCd;
					var url = "";
					if(rltGbCd == "S"){//펫샵
						if(rltTp == "상품"){
							url ='https://<spring:eval expression="@webConfig['site.fo.domain']" />/goods/indexGoodsDetail?goodsId='+rltId; 
						}else{
							url ='https://<spring:eval expression="@webConfig['site.fo.domain']" />/log/indexPetLogDetailView?petLogNo='+rltId; 
						}
					}else if(rltGbCd == "L"){//LOG
						url ='https://<spring:eval expression="@webConfig['site.fo.domain']" />/log/indexPetLogDetailView?petLogNo='+rltId; 
					}else if(rltGbCd == "T"){//영상
						url ='https://<spring:eval expression="@webConfig['site.fo.domain']" />/tv/series/indexTvDetail?vdId='+rltId+'&sortCd=&listGb=HOME'; 
					}	
					
					var options = 'top=10, left=10, width=1200, height=800, status=no, menubar=no, toolbar=no, resizable=no';
					window.open(url, "", options);		
				}
			}
			, gridComplete : function() {
				$("#noData").remove();
				var grid = $("#umTagList").jqGrid('getRowData');
				if(grid.length <= 0) {
					var str = "";
					str += "<tr id='noData' role='row' class='jqgrow ui-row-ltr ui-widget-content'>";
					str += "	<td role='gridcell' colspan='6' style='text-align:center;'>조회결과가 없습니다.</td>";
					str += "</tr>"
						
					$("#umTagList.ui-jqgrid-btable").append(str);
				}
			}
		}
	grid.create("umTagList", gridOptions);
		
		
}

</script>
<h2 style="padding-left:10px">▶ Tag</h2>
<div title="Tag" style="padding:10px">
<form id="umTagListForm" name="umTagListForm" method="post" >
	<table class="table_type1">
		<caption>Tag</caption>
		<colgroup>
			<col style="width:15%;">							
			<col style="width:35%;">
			<col style="width:15%;">
			<col style="width:35%;">
		</colgroup>
		<tbody>
			<tr>
				<th><spring:message code="column.tag_no"/></th>
				<td title="<spring:message code="column.tag_no"/>">
					<input type="hidden" class="readonly" name="tagNo" id="tagNo"  value="${tagBase.tagNo}" />
					<c:out value="${tagBase.tagNo}" />
				</td>
				<th><spring:message code="column.tag_nm" /></th>	<!-- Tag 명-->
				<!-- 상품 상태 -->
				<td>
					<input type="text" class="readonly" readonly="readonly" name="tagNm" id="tagNm" style= "width:230px;border-radius: 7px;" title="<spring:message code="column.tag_nm" />" value="#${tagBase.tagNm}" />
				</td>
			</tr>
		</tbody>
	</table>
</form>
</div>
<br/>
<br/>
<h2 style="padding-left:10px">▶ 등장 리스트</h2>
<div title="관련 상품" style="padding:10px">
	<table id="umTagList" ></table>
	<div id="umTagListPage"></div>				
</div>
				