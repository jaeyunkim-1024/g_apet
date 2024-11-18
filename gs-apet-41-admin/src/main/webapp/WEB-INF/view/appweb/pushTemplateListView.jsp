<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
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
			
			// 알림 메시지 템플릿 리스트 그리드
			function createPushTemplateListGrid() {
				var options = {
					url : "<spring:url value='/appweb/listPushTemplateGrid.do' />"
					, height : 400
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
	                        , {name:"tmplCd", label:'일련번호', width:"150", align:"center", sortable:false}
	                     	// 템플릿 제목
							, {name:"subject", label:'<spring:message code="column.push.tmpl_sub" />', width:"450", align:"center", sortable:false, classes:'pointer', formatter: function(cellvalue, options, rowObject) {
								var cellLength = cellvalue.length;
								var cellStr = rowObject.subject;
								if (cellLength > 25) {
									cellStr = rowObject.subject.substring(0,25) + "...";
								}
								return cellStr;
							}}
							// 등록자
							, {name:"sysRegrNm", label:'<spring:message code="column.sys_regr_nm" />', width:"150", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
								/* return rowObject.sysRegrNm + "<br><p style='font-size:11px;'>(" + rowObject.sysUpdrNm + ")</p>"; */
								return rowObject.sysRegrNm;
							}}
	                     	// 생성일
	                        , {name:'sysRegDtm', label:'생성일', width:'150', align:'center', sortable:false, formatter: function(cellvalue, options, rowObject) {
								/* return new Date(rowObject.sysRegDtm).format("yyyy.MM.dd") + "<br><p style='font-size:11px;'>(" + new Date(rowObject.sysUpdDtm).format("yyyy-MM-dd") + ")</p>"; */
	                        	return new Date(rowObject.sysRegDtm).format("yyyy.MM.dd");
							}}
	                     	// 수정자
							, {name:"sysUpdrNm", label:'<spring:message code="column.sys_regr_nm" />', width:"150", align:"center", hidden:true, sortable:false}
	                     	// 수정일
	                        , {name:'sysUpdDtm', label:'<spring:message code="column.push.tmpl_reg_dtm" />', width:'150', align:'center', hidden:true, sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd"}
	                     	// 메시지 발송
							, {name:"pushMessageBtn", label:'<spring:message code="column.push.message_send" />', width:"180", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
								var str = '<button type="button" onclick="pushTemplateSendView('+ rowObject.tmplNo +');" class="btn btn-add">발송</button>';
								return str;
							}}
						]
					, onCellSelect : function (id, cellidx, cellvalue) {
						var rowData = $("#pushTemplateList").getRowData(id);
						if (cellidx == 5) {
							pushTemplateDetailViewPop(rowData.tmplNo);
						}
					}
					, loadComplete : function(data) {
						var td = $("#pushTemplateList").find("tr").find("td[aria-describedby=pushTemplateList_subject]");
						$(td).css('color', '#0066CC');
						$(td).css('text-decoration', 'underline');
					}
				};
				grid.create("pushTemplateList", options);
			}
			
			// 알림 메시지 발송 화면 이동
			function pushTemplateSendView(seq) {
				addTab("알림 메시지 발송", "/appweb/pushMessageSendView.do?tmplNo=" + seq);
			}
			
			// 알림 메시지 템플릿 상세 팝업
			function pushTemplateDetailViewPop(seq) {
				var options = {
					url : "<spring:url value='/appweb/pushTemplateDetailViewPop.do' />"
					, data : {tmplNo : seq}
					, dataType : "html"
					, callBack : function(data) {
						var config = {
							id : "pushTemplateDetailViewPop"
							, title : "알림 메시지 템플릿 상세"
							, body : data
							, button : "<button type=\"button\" onclick=\"updateNoticeTemplate();\" class=\"btn btn-add\">저장</button>"
										+ "<button type=\"button\" onclick=\"deleteNoticeTemplate();\" class=\"btn btn-ok ml10\">삭제</button>"
										+ "<button type=\"button\" onclick=\"layer.close('pushTemplateDetailViewPop');\" class=\"btn btn-cancel ml10\">목록</button>"
						}
						layer.create(config);
					}
				}
				ajax.call(options);
			}
			
			// 알림 메시지 템플릿 목록 검색
			function searchPushTemplateList(){
				var options = {
						searchParam : $("#pushTemplateListForm").serializeJson()
				};
				grid.reload("pushTemplateList", options);
			}
			
			// 목록 초기화
			function searchReset(form){
				resetForm(form);
				searchPushTemplateList();
			}
			
			// 알림 메시지 템플릿 생성
			function pushTemplateInsertView() {
				addTab("알림 메시지 템플릿 생성", "/appweb/pushTemplateInsertView.do");
			}
			
			// 알림 메시지 발송
			function pushMessageSendView() {
				addTab("알림 메시지 발송", "/appweb/pushMessageSendView.do");
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
				headerName.push("등록자");
				headerName.push("등록일");
				
				fieldName.push("tmplNo");
				fieldName.push("ctgCd");
				fieldName.push("sndTypeCd");
				fieldName.push("sysCode");
				fieldName.push("tmplCode");
				fieldName.push("subject");
				fieldName.push("sysRegrNm");
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
	</t:putAttribute>
	<t:putAttribute name="content">
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
										<frame:select grpCd="${adminConstants.SND_TYPE }" defaultName="전체" />
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
									<input type="text" name="searchTxt" id="searchTxt" class="w800" placeholder="시스템 코드, 일련번호, 제목을 입력" />
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
					<button type="button" onclick="pushTemplateInsertView();" class="btn btn-add">템플릿 생성</button>
					<button type="button" onclick="pushMessageSendView();" class="btn btn-add" style="background-color: #0066CC; border-color: #0066CC;">알림 메시지 발송</button>
					<button type="button" onclick="pushTemplateListExcelDownload();" class="btn btn-add btn-excel" style="margin-right:0px;">엑셀 다운로드</button>
				</div>
				
				<table id="pushTemplateList"></table>
				<div id="pushTemplateListPage"></div>
			</div>
		</form>
	</t:putAttribute>
</t:insertDefinition>