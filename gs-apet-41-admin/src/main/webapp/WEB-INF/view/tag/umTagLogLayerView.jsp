<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
let rIndex = 0;
var isGridExistsLog = false;
if(isGridExistsLog){
	var options = {
		searchParam : $("#umTagListLogForm").serializeJson()
	};
	grid.reload("umTagListLog", options);
}else{
	viewNewTagRltListPopGrid3();	
}

function viewNewTagRltListPopGrid3(){			
	setLayerPopParam("Log");
	
	var gridOptions = {
			url : "<spring:url value='/tag/pageUmTagLogLayer.do' />"
			, height : 300
			, searchParam : $("#umTagListLogForm").serializeJson()
			, sortname : 'sysRegDtm'
			, sortorder : 'DESC'
			, colModels : [
				{name:"rowIndex", label:'No.', width:"55", align:"center", classes:'cursor_default', sortable:false, formatter: function(cellvalue, options, rowObject){
					let nTotalCnt = $("#umTagListLog").getGridParam("records");
					let nPage = $('#umTagListLog').jqGrid('getGridParam', 'page');
					let nRows = $('#umTagListLog').jqGrid('getGridParam', 'rowNum');
					let No = nTotalCnt - ( nPage-1 )*nRows - (rIndex);
					rIndex++;
					return No;
				  	}
				 }
				, {name:"rltGb", 		label:_TAG_RLT_LIST_GRID_LABEL.rltGb ,  width:"120", 	align:"center", sortable:false} 	
				, {name:"rltTp", 		label:_TAG_RLT_LIST_GRID_LABEL.rltTp ,  width:"120",  	align:"center", sortable:false}
				, {name:"rltId", 		label:"컨텐츠 ID" , 				width:"225", 	align:"left", sortable:false, classes:'pointer fontbold'} 		
				//, _GRID_COLUMNS.sysRegrNm
				//, _GRID_COLUMNS.sysRegDtm
				, {name:"sysRegrNm", 	label : "<spring:message code='column.sys_regr_nm' />", width : "100",  sortable:false, align : "center"}
				, {name:"sysRegDtm",	label:'<spring:message code="column.sys_reg_dt" />', 	width:"140", 	align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy.MM.dd"} 	
				, {name:"rltId", key: true, hidden:true}
			]
			//,rownumbers: true
			, onCellSelect : function (id, cellidx, cellvalue) {
				if(cellidx == 3) {					
					var rowData = $("#umTagListLog").getRowData(id);
					var rltId = rowData.rltId;					
					var url ='https://<spring:eval expression="@webConfig['site.fo.domain']" />/log/indexPetLogDetailView?petLogNo='+rltId; 
					
					var options = 'top=10, left=10, width=1200, height=800, status=no, menubar=no, toolbar=no, resizable=no';
    				window.open(url, "", options);
				}
			}
			, gridComplete : function() {
				$("#noData").remove();
				var grid = $("#umTagListLog").jqGrid('getRowData');
				if(grid.length <= 0) {
					var str = "";
					str += "<tr id='noData' role='row' class='jqgrow ui-row-ltr ui-widget-content'>";
					str += "	<td role='gridcell' colspan='6' style='text-align:center;'>조회결과가 없습니다.</td>";
					str += "</tr>"
						
					$("#umTagListLog.ui-jqgrid-btable").append(str);
				}
			}
		}
	grid.create("umTagListLog", gridOptions);
}

</script>
<h2 style="padding-left:10px">▶ Tag</h2>
<div title="Tag" style="padding:10px">
<form id="umTagListLogForm" name="umTagListLogForm" method="post" >
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
<h2 style="padding-left:10px">▶ 관련 로그</h2>
<div title="관련 상품" style="padding:10px">
	<table id="umTagListLog" ></table>
	<div id="umTagListLogPage"></div>				
</div>
				