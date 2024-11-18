<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
	$(document).ready(function() {
		createPushVariableListGrid();
	});
	
	// 변수 리스트 팝업 그리드
	function createPushVariableListGrid() {
		var options = {
			url : "<spring:url value='/appweb/listPushVariableGrid.do' />"
			, height : 330
			, colModels : [
				// No
				{name:"sortSeq", label:'No', width:"100", align:"center", sortable:false}
				// 변수
				, {name:"usrDfn1Val", label:'변수', width:"275", align:"center", sortable:false}
				// 설명
				, {name:"dtlNm", label:'설명', width:"275", align:"center", sortable:false}
			]
		};
		grid.create("pushVariableList", options);
	}
	
	// 알림 메시지 템플릿 리스트 엑셀 다운로드
	function pushVariableListExcelDownload() {
		var excelData = $("#pushVariableListForm").serializeJson();
		var headerName = new Array();
		var fieldName = new Array();
		headerName.push("No");
		headerName.push("변수");
		headerName.push("설명");
		
		fieldName.push("sortSeq");
		fieldName.push("usrDfn1Val");
		fieldName.push("dtlNm");
		
		$.extend(excelData, {
			headerName : headerName
			, fieldName : fieldName
			, sheetName : "pushVariableListExcelDownload"
			, fileName : "pushVariableExcelDownload"
			, pushTpGb : "variableList"
		});
		createFormSubmit("pushVariableListExcelDownload", "/appweb/pushCommonExcelDownload.do", excelData);
	}
</script>
<form name="pushVariableListForm" id="pushVariableListForm" method="post">
	<div class="mModule" align="right">
		<button type="button" onclick="pushVariableListExcelDownload();" class="btn btn-add btn-excel" style="margin-right:0px;">엑셀 다운로드</button>
		<table id="pushVariableList"></table>
		<div id="pushVariableListPage"></div>
	</div>
</form>

