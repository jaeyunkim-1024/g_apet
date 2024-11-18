<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function() {
				// 템플릿 리스트
				createTemplateGrid();
			});
			var stIndex = 0;
			// 사이트 검색
			function searchSt (index) {
				stIndex = index;
				var options = {
					multiselect : false
					, callBack : searchStCallback
				}
				layerStList.create (options );
			}
			function searchStCallback (stList ) {
				if(stList.length > 0 ) {
// 					$("#stId").val (stList[0].stId );
// 					$("#stNm").val (stList[0].stNm );
					document.getElementsByName("stId")[stIndex].value = stList[0].stId;
					document.getElementsByName("stNm")[stIndex].value = stList[0].stNm;
				}
			}

			// 템플릿 리스트
			function createTemplateGrid() {
				var options = {
					url : "<spring:url value='/display/displayTemplateListGrid.do' />"
					, height : 400
					, searchParam : $("#templateListForm").serializeJson()
					, colModels : [
						// 템플릿 번호
						{name:"tmplNo", label:'<b><u><tt><spring:message code="column.tmpl_no" /></tt></u></b>', width:"100", align:"center", formatter:'integer', classes:'pointer fontbold'}
						// 사이트 아이디
						, {name:"stId", label:'<spring:message code="column.st_id" />', width:"100", align:"center", hidden:true}
						, _GRID_COLUMNS.stNm
						// PC웹 URL
						, {name:"pcwebUrl", label:'<spring:message code="column.pcweb_url" />', width:"200", align:"center"}
						// 모바일 URL
						, {name:"mobileUrl", label:'<spring:message code="column.mobile_url" />', width:"180", align:"center"}
                        // 템플릿 명
                        , {name:"tmplNm", label:'<spring:message code="column.tmpl_nm" />', width:"200", align:"center"}						
						// 템플릿 설명
						, {name:"tmplDscrt", label:'<spring:message code="column.tmpl_dscrt" />', width:"200", align:"center"}
						, _GRID_COLUMNS.sysRegrNm
						, _GRID_COLUMNS.sysRegDtm
						, _GRID_COLUMNS.sysUpdrNm
						, _GRID_COLUMNS.sysUpdDtm
					]
					, onSelectRow : function(ids) {
						var rowdata = $("#templateList").getRowData(ids);
						templateView(rowdata.tmplNo);
					}
				};
				grid.create("templateList", options);
			}

			// 검색
			function reloadTemplateGrid() {
				var options = {
					searchParam : $("#templateListForm").serializeJson()
				};

				grid.reload("templateList", options);
			}

			// 템플릿 상세
			function templateView(tmplNo) {
				var options = {
					url : "<spring:url value='/display/displayTemplateDetailView.do' />"
					, data : {tmplNo : tmplNo}
					, dataType : "html"
					, callBack : function(data) {
						$("#templateView").html(data);
						validate.set("templateViewForm");
					}
				};

				ajax.call(options);
			}

			// 템플릿 등록
			function templateInsert() {
				if(validate.check("templateViewForm")) {
					messager.confirm("<spring:message code='column.common.confirm.insert' />",function(r){
						if(r){
							var options = {
									url : "<spring:url value='/display/displayTemplateInsert.do' />"
									, data : $("#templateViewForm").serializeJson()
									, callBack : function(data) {
										templateView($("#templateViewForm").find("input[name=tmplNo]").val());
										reloadTemplateGrid();
									}
								};

								ajax.call(options);				
						}
					});
				}
			}

			// 템플릿 수정
			function templateUpdate() {
				if(validate.check("templateViewForm")) {
					messager.confirm("<spring:message code='column.common.confirm.update' />",function(r){
						if(r){
							var options = {
									url : "<spring:url value='/display/displayTemplateUpdate.do' />"
									, data : $("#templateViewForm").serializeJson()
									, callBack : function(data) {
										templateView($("#templateViewForm").find("input[name=tmplNo]").val());
										reloadTemplateGrid();
									}
								};

								ajax.call(options);				
						}
					});
				}
			}

			// 템플릿 삭제
			function templateDelete() {
				if(validate.check("templateViewForm")) {
					messager.confirm("<spring:message code='column.common.confirm.delete' />",function(r){
						if(r){
							var options = {
									url : "<spring:url value='/display/displayTemplateDelete.do' />"
									, data : $("#templateViewForm").serializeJson()
									, callBack : function(data) {
										templateView($("#templateViewForm").find("input[name=tmplNo]").val());
										reloadTemplateGrid();
									}
								};

								ajax.call(options);				
						}
					});
				}
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="row">
			<div class="col-md-8 bar-right">
				<div class="mTitle">
					<h2>템플릿 목록</h2>
				</div>

				<form name="templateListForm" id="templateListForm" method="post">
				<table class="table_type1">
					<caption>템플릿 목록</caption>
					<colgroup>
						<col class="th-s" />
						<col style="width:300px" />
						<col class="th-s" />
						<col />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><spring:message code="column.display_view.date" /></th>
							<td>
								<frame:datepicker startDate="strtDtm"
												  startValue="${frame:toDate('yyyy-MM-dd')}"
												  endDate="endDtm"
												  endValue="${frame:addMonth('yyyy-MM-dd', 1)}"
												  />
							</td>
							<th scope="row"><spring:message code="column.tmpl_nm" /></th>
							<td>
								<input type="text" class="" name="tmplNm" id="tmplNm" title="<spring:message code="column.tmpl_nm"/>" value="" />
							</td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.st_id" /></th> <!-- 사이트 ID -->
							<td colspan="3">
								<frame:stId funcNm="searchSt(0)" />
							</td>
						</tr>
					</tbody>
				</table>
				</form>
				<div class="btn_area_center">
					<button type="button" onclick="reloadTemplateGrid();" class="btn btn-ok">검색</button>
					<button type="button" onclick="resetForm('templateListForm');" class="btn btn-cancel">초기화</button>
				</div>

				<div class="mModule">
					<table id="templateList" ></table>
					<div id="templateListPage"></div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="mTitle">
					<h2>템플릿 상세</h2>
				</div>

				<div id="templateView">
					<jsp:include page="/WEB-INF/view/display/displayTemplateDetailView.jsp" />
				</div>
			</div>
		</div>
	</t:putAttribute>
</t:insertDefinition>