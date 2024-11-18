<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
	$(document).ready(function() {
		createPushTemplateListGrid();
		
		// 엔터키 이벤트
		$(document).on("keydown","#pushTemplateListForm input[name=searchTxt]",function(e){
			if (e.keyCode == 13) {
				searchPushTemplateList();
			}
		});
	});
	
	// 알림 메시지 템플릿 목록 그리드
	function createPushTemplateListGrid() {
		var options = {
			url : "<spring:url value='/appweb/listPushTemplateGrid.do' />"
			, height : 165
			, searchParam : $("#pushTemplateListForm").serializeJson()
			, cellEdit : true
			, colModels : [
					// 알림 메시지 템플릿 번호
					{name:"tmplNo", label:'No', width:"100", align:"center", sortable:false, formatter:'integer', key:true}
					// 전송방식
					, {name:"sndTypeCd", label:'<spring:message code="column.push.send_type" />', width:"150", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.SND_TYPE }' />"}}
					// 카테고리
					, {name:"ctgCd", label:'<spring:message code="column.push.category" />', width:"150", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.CTG }' />"}}
					// 템플릿 일련번호
					, {name:"tmplCd", label:'일련번호', width:"150", align:"center", sortable:false}
					// 템플릿 제목
					, {name:"subject", label:'<spring:message code="column.push.tmpl_sub" />', width:"450", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
						var cellLength = cellvalue.length;
						var cellStr = rowObject.subject;
						if (cellLength > 25) {
							cellStr = rowObject.subject.substring(0,25) + "...";
						}
						return cellStr;
					}}
					// 템플릿 내용
					, {name:"contents", label:'<spring:message code="column.push.tmpl" />', width:"450", align:"center", hidden:true, sortable:false}
					// 이미지 경로
					, {name:"imgPath", label:'<spring:message code="column.push.tmpl_sub" />', width:"450", align:"center", hidden:true, sortable:false}
					// 이동 경로
					, {name:"movPath", label:'<spring:message code="column.push.tmpl" />', width:"450", align:"center", hidden:true, sortable:false}
					// 등록일
					, {name:'sysRegDtm', label:'<spring:message code="column.push.tmpl_reg_dtm" />', width:'150', align:'center', sortable:false, formatter:gridFormat.date, dateformat:"yyyy.MM.dd"}
				]
			, onCellSelect : function (id, cellidx, cellvalue) {
				var rowData = $("#pushTemplateList").getRowData(id);
				var sendInfo = $("input[name=receiverSendInfo]:checked").val();
				var sendSndType = $("#sndTypeCd option[value=" + rowData.sndTypeCd + "]").val();
				$("#tmplCd").val(rowData.tmplCd);
				if(sendInfo == '10') {
					$("#subject").val(rowData.subject);
				}else {
					if(sendSndType == '${adminConstants.SND_TYPE_10}'){
						$("#subject").val("(광고) "+rowData.subject);
					}
					if(sendSndType == '${adminConstants.SND_TYPE_20}' || sendSndType == '${adminConstants.SND_TYPE_40}') {
						$("#subject").val("(광고) 어바웃펫 "+rowData.subject);
					}
				}
				
				$("#appImgUrl").val(rowData.imgPath);
				$("#tmplNo").val(rowData.tmplNo);
				
				if (rowData.imgPath == "" || rowData.imgPath == null) {
					$("#appIconSelect option").eq(2).prop("selected", "selected");
				} else if (rowData.imgPath != "" && rowData.imgPath != null) {
					$("#appIconSelect option").eq(1).prop("selected", "selected");
				}
				
				if ($("#templateHtml").siblings("iframe").length != 0) {
					oEditors.getById["templateHtml"].exec("SET_IR", [""]);
					oEditors.getById["templateHtml"].exec("PASTE_HTML", [rowData.contents]);
				}
				
				if(sendInfo == '10'){
					$("#templateHtml").val(rowData.contents);
				}else {
					var appHtml = "\n\n수신거부: MY>설정>앱푸시 설정 OFF";
					var smsHtml = "\n\n고객센터: 1644-9610\n무료수신거부: 0808700224";
					var emailHtml = "<br>고객센터: 1644-9610 <br>수신거부: 어바웃펫<br>로그인>서비스이용약관>마케팅정보<br>수신동의 >동의철회";
					if(sendSndType == '${adminConstants.SND_TYPE_10}'){
						$("#templateHtml").val(rowData.contents + appHtml);
					}
					else if(sendSndType == '${adminConstants.SND_TYPE_20}'){
						$("#templateHtml").val(rowData.contents + smsHtml);
					}else {
						$("#templateHtml").val(rowData.contents + emailHtml);
					}
				}
				
				
				$("#movPath").val(rowData.movPath);
				$("#sndTypeCd option[value=" + rowData.sndTypeCd + "]").prop("selected", "selected");
				$("#templateArea").show();
				sndTypeCdChange("N", "Y", "tmpl");
				
				layer.close('pushTemplateSelectView');
			}
		};
		grid.create("pushTemplateList", options);
	}
	
	// 알림 메시지 템플릿 검색
	function searchPushTemplateList(){
		var options = {
				searchParam : $("#pushTemplateListForm").serializeJson()
		};
		options.searchParam.tmplPopGb = "Y";
		grid.reload("pushTemplateList", options);
	}
	
	// 목록 초기화
	function searchReset(form){
		resetForm(form);
		searchPushTemplateList();
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
	<input type="hidden" name="tmplPopGb" id="tmplPopGb" value="Y" />
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
								<frame:select grpCd="${adminConstants.SND_TYPE }" defaultName="선택" excludeOption="${adminConstants.SND_TYPE_30}"/>
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
				<button type="button" onclick="searchPushTemplateList();" class="btn btn-ok">조회</button>
				<button type="button" onclick="searchReset('pushTemplateListForm');" class="btn btn-cancel">초기화</button>
			</div>
		</div>
	</div>
	<div class="mModule">
		<div align="right">
			<button type="button" onclick="pushTemplateListExcelDownload();" class="btn btn-add btn-excel" style="margin-right:0px;">엑셀 다운로드</button>
		</div>
		
		<table id="pushTemplateList"></table>
		<div id="pushTemplateListPage"></div>
	</div>
</form>
