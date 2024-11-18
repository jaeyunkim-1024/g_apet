<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
	$(document).ready(function() {
		//initEditor();
		createPushTemplateListGrid();
		
		$(document).on("click", "#pushTemplateSelectView_dlg-buttons button", function() {
			if (!$("#tmplNo").val()) {
				$("#templateArea").hide();
			}
		});
	});
	
	// 알림 메시지 발송 내역 그리드
	function createPushTemplateListGrid() {
		var options = {
			url : "<spring:url value='/sample/sampleListPushTemplateGrid.do' />"
			, searchParam : $("#pushTemplateListForm").serializeJson()
			, cellEdit : true
			, colModels : [
					// 알림 메시지 템플릿 번호
					{name:"tmplNo", label:'No', width:"100", align:"center", sortable:false, formatter:'integer', key:true}
					// 카테고리
					, {name:"ctgCd", label:'<spring:message code="column.push.category" />', width:"150", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.CTG }' />"}}
					// 전송방식
					, {name:"sndTypeCd", label:'<spring:message code="column.push.send_type" />', width:"150", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.SND_TYPE }' />"}}
					// 시스템 코드
					, {name:"sysCd", label:'<spring:message code="column.push.system_cd" />', width:"150", align:"center", sortable:false}
					// 템플릿 일련번호
					, {name:"tmplCd", label:'<spring:message code="column.push.tmpl_no" />', width:"150", align:"center", sortable:false}
					// 템플릿 제목
					, {name:"subject", label:'<spring:message code="column.push.tmpl_sub" />', width:"450", align:"center", sortable:false}
					// 템플릿 내용
					, {name:"contents", label:'<spring:message code="column.push.tmpl" />', width:"450", align:"center", hidden:true, sortable:false}
					// 등록일
					, {name:'sysRegDtm', label:'<spring:message code="column.push.tmpl_reg_dtm" />', width:'150', align:'center', sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
				]
			, onCellSelect : function (id, cellidx, cellvalue) {
				var rowData = $("#pushTemplateList").getRowData(id);
				$("#tmplNo").val(rowData.tmplNo);
				$("#tmplCd").val(rowData.tmplCd);
				$("#fsubject").val(rowData.subject);
				$("#fmessage").val(rowData.contents);
				$("#sndTypeCd").children().eq(0).prop("disabled", false);
				$("#sndTypeCd option[value=" + rowData.sndTypeCd + "]").prop("disabled", false);
				$("#sndTypeCd option[value=" + rowData.sndTypeCd + "]").prop("selected", "selected");
				$(".paramArea").html("");	
				var namePattern = /\{.+?\}/g; 
				var contents = rowData.contents;
				var paramVar = contents.match(namePattern);	
				if(paramVar != null && paramVar != "" ){
					for(let i=0; i< paramVar.length ; i++){
						paramVar[i] = paramVar[i].replace("{","").replace("}","");
						$(".paramArea").append('<input type="text" data-param="'+ paramVar[i] +'" placeholder="'+ paramVar[i] +'">');							
					}
					$(".paramArea").prepend('<input type="text" disabled="disabled" style="width:80px;border:none;" value="ㄴ 바인딩 변수 : ">');
					params = paramVar;
					$("#pramTr").show();
				}
				layer.close('pushTemplateSelectView');
			}
		};
		grid.create("pushTemplateList", options);
	}
	
	// 알림 메시지 발송 내역 검색
	function searchPushTemplateList(){
		var options = {
				searchParam : $("#pushTemplateListForm").serializeJson()
		};
		grid.reload("pushTemplateList", options);
	}
	
	// 목록 초기화
	function searchReset(form){
		resetForm(form);
	}
	
	// 알림 메시지 템플릿 리스트 엑셀 다운로드
	function pushTemplateListExcelDownload() {
		var excelData = $("#pushTemplateListForm").serializeJson();
		var headerName = new Array();
		var fieldName = new Array();
		headerName.push("No");
		headerName.push("카테고리");
		headerName.push("전송방식");
		headerName.push("시스템 코드");
		headerName.push("템플릿 일련번호");
		headerName.push("템플릿 제목");
		headerName.push("등록일");
		
		fieldName.push("tmplNo");
		fieldName.push("ctgCd");
		fieldName.push("sndTypeCd");
		fieldName.push("sysCode");
		fieldName.push("tmplCode");
		fieldName.push("subject");
		fieldName.push("sysRegDtm");
		
		$.extend(excelData, {
			headerName : headerName
			, fieldName : fieldName
			, sheetName : "pushTmplListExcelDownload"
			, fileName : "pushTmplExcelDownload"
			, pushTpGb : "tmplList"
		});
		createFormSubmit("pushTemplateListExcelDownload", "/appweb/pushCommonExcelDownload.do", excelData);
	}
</script>
<form name="pushTemplateListForm" id="pushTemplateListForm" method="post">
	<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
		<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
			<table class="table_type1">
				<colgroup>
					<col width="20%"/>
					<col width="80%"/>
					<col width="20%"/>
					<col width="80%"/>
				</colgroup>
				<caption>공통 댓글 검색 목록</caption>
				<tbody>
					<tr>
						<th><spring:message code="column.push.send_type" /></th>
						<td>
							<!-- 전송방식 -->
							<select id="sndTypeCd" name="sndTypeCd">
								<frame:select grpCd="${adminConstants.SND_TYPE }" selectKey="${sndTypeCd}" selectKeyOnly="true" />
							</select>
						</td>
                        <th><spring:message code="column.push.category" /></th>
                        <td>
                            <!-- 카테고리 -->
                            <select name="ctgCd" id="ctgCd">
								<frame:select grpCd="${adminConstants.CTG }" defaultName="전체" />
							</select>
                        </td>
					</tr>
					<tr>
						<th><spring:message code="column.push.search" /></th>
						<td colspan="3">
							<!-- 검색어 -->
							<input type="text" name="searchTxt" id="searchTxt" class="w500" placeholder="시스템 코드, 일련번호, 제목을 입력" />
						</td>
					</tr>
				</tbody>
			</table>

			<div class="btn_area_center">
				<button type="button" onclick="searchPushTemplateList();" class="btn btn-ok">검색</button>
				<button type="button" onclick="searchReset('pushTemplateListForm');" class="btn btn-cancel">초기화</button>
			</div>
		</div>
	</div>
	<div class="mModule">
		<table id="pushTemplateList"></table>
		<div id="pushTemplateListPage"></div>
	</div>
</form>
