<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			function createCodeGroupGrid(){
				var options = {
					url : "<spring:url value='/system/codeGroupListGrid.do' />"
					, height : 370
					, searchParam : $("#codeGroupListForm").serializeJson()
					, colModels : [
						  {name:"grpCd", label:'<spring:message code="column.grp_cd" />', width:"130", align:"center", classes:'pointer'}
						, {name:"grpNm", label:'<spring:message code="column.grp_nm" />', width:"200", align:"center"}
						, _GRID_COLUMNS.sysRegrNm
						, _GRID_COLUMNS.sysRegDtm
						, _GRID_COLUMNS.sysUpdrNm
						, _GRID_COLUMNS.sysUpdDtm
					]
					, onSelectRow : function(ids) {
						var rowdata = $("#codeGroupList").getRowData(ids);
						//코드관리_그룹 상세 조회
						codeGroupView(rowdata.grpCd);
					}
				};

				grid.create("codeGroupList", options);
			}

			// 그룹 코드 리스트 조회
			function reloadCodeGroupGrid(){
				var options = {
					searchParam : $("#codeGroupListForm").serializeJson()
				};
				grid.reload("codeGroupList", options);
			}

			// 그룹 코드 상세
			function codeGroupView(grpCd){
				var options = {
					url : "<spring:url value='/system/codeGroupView.do' />"
					, data : { grpCd : grpCd }
					, dataType : "html"
					, callBack : function(data){
						$("#codeGroupView").html(data);
						validate.set("codeGroupForm");
						reloadCodeDetailGrid(grpCd);
						codeDetailView(grpCd, '');
					}
				};

				ajax.call(options);
			}

			// 그룹 코드 등록
			function codeGroupInsert(){
				var grpCd = $("#codeGroupForm").find("input[name='grpCd']").val();
				var grpNm = $("#codeGroupForm").find("input[name='grpNm']").val();

				var invalidResult = validation.isValidCodeName(grpNm);
				if(!invalidResult){
					messager.alert('<spring:message code="admin.web.view.msg.code.isValidCodeName.grpNm" />', "Info", "info");
					return false;
				}else{
					if(validate.check("codeGroupForm")) {
						messager.confirm('<spring:message code="column.common.confirm.insert" />', function(r){
							if(r){
								var options = {
									url : "<spring:url value='/system/codeGroupInsert.do' />"
									, data : $("#codeGroupForm").serializeJson()
									, callBack : function(data){
										codeGroupView(grpCd);
										$("#grpNm").combobox("setText",grpNm);
										$("#grpCd").combobox("setText",grpCd);
										reloadCodeGroupGrid();
										fnAddSearchKeyWord("grpCd");
										fnAddSearchKeyWord("grpNm");
									}
								};

								ajax.call(options);
							}
						})
					}
				}
			}
			function fnAddSearchKeyWord(id){
				var data = $("#"+id).combobox('getData');
				var addData = {
					value : $("#codeGroupForm [name="+id+"]").val()
					,	text : $("#codeGroupForm [name="+id+"]").val()
					,	iconCls : undefined
					, 	selected: true
					, 	disabled: false
				};
				data.push(addData);
				$("#"+id).combobox('loadData', data);
			}

			// 그룹 코드 수정
			function codeGroupUpdate(){
				if(validate.check("codeGroupForm")) {
					messager.confirm('<spring:message code="column.common.confirm.update" />', function(r){
						if(r){
							var options = {
								url : "<spring:url value='/system/codeGroupUpdate.do' />"
								, data : $("#codeGroupForm").serializeJson()
								, callBack : function(data){
									var grpCd = $("#codeGroupForm").find("input[name='grpCd']").val();
									var grpNm = $("#codeGroupForm").find("input[name='grpNm']").val();

									codeGroupView(grpCd);
									fnUpdateSearchKeyword($("#originGrpNm").val(),grpNm);
									$("#grpNm").combobox("setText",grpNm);
									reloadCodeGroupGrid();
								}
							};

							ajax.call(options);
						}
					})
				}
			}
			function fnUpdateSearchKeyword(oldkeyword,newkeyword){
				var data = $("#grpNm").combobox('getData');
				var result = [];
				data.forEach(function(item){
					if(item.value === oldkeyword){
						item.value = newkeyword;
						item.text = newkeyword;
					}
					result.push(item);
				});
				$("#grpNm").combobox('loadData', result);
			}

			// 그룹 코드 삭제
			function codeGroupDelete(){
				messager.confirm('<spring:message code="column.common.confirm.delete" />', function(r){
					if(r){
						var options = {
							url : "<spring:url value='/system/codeGroupDelete.do' />"
							, data : $("#codeGroupForm").serializeJson()
							, callBack : function(data){
								fnDeleteSearchKeyword("grpCd");
								fnDeleteSearchKeyword("grpNm");
								codeGroupView('');
								reloadCodeGroupGrid();
							}
						};

						ajax.call(options);
					}
				})
			}
			function fnDeleteSearchKeyword(id){
				var data = $("#"+id).combobox('getData');
				var result = [];
				data.forEach(function(item){
					if(item.value != $("#codeGroupForm [name="+id+"]").val()){
						result.push(item);
					}
				});
				$("#"+id).combobox('loadData', result);
			}

			// 상세 코드 그리드 생성
			function createCodeDetailGrid(){
				var options = {
					url : "<spring:url value='/system/codeDetailListGrid.do' />"
					, height : 650
					, searchParam : { grpCd : '' }
					, colModels : [
						{name:"grpCd", label:'<spring:message code="column.grp_cd" />', width:"130", align:"center", sortable:false}
						, {name:"dtlCd", label:'<spring:message code="column.dtl_cd" />', width:"50", align:"center", classes:'pointer'}
						, {name:"dtlNm", label:'<spring:message code="column.dtl_nm" />', width:"130", align:"center", sortable:false}
						, {name:"dtlShtNm", label:'<spring:message code="column.dtl_sht_nm" />', width:"100", align:"center", sortable:false}
						, {name:"sortSeq", label:'<spring:message code="column.sort_seq" />', width:"80", align:"center", formatter:'integer'}
						, _GRID_COLUMNS.useYn
						, _GRID_COLUMNS.sysRegrNm
						, _GRID_COLUMNS.sysRegDtm
						, _GRID_COLUMNS.sysUpdrNm
						, _GRID_COLUMNS.sysUpdDtm
					]
					, onSelectRow : function(ids) {
						var rowdata = $("#codeDetailList").getRowData(ids);

						codeDetailView(rowdata.grpCd, rowdata.dtlCd);
					}
					, paging : true
				};

				grid.create("codeDetailList", options);
			}

			// 상세 코드 리스트 리로드
			function reloadCodeDetailGrid(grpCd){
				var options = {
					searchParam : { grpCd : grpCd }
				};
				grid.reload("codeDetailList", options);
			}

			// 상세 코드 화면
			function codeDetailView(grpCd, dtlCd){
				var options = {
					url : "<spring:url value='/system/codeDetailView.do' />"
					, data : {
						grpCd : grpCd
						, dtlCd : dtlCd
					}
					, dataType : "html"
					, callBack : function(data){
						$("#codeDetailView").html(data);
						validate.set("codeDetailForm");
					}
				};

				ajax.call(options);
			}

			// 상세 코드 등록
			function codeDetailInsert(){
				var cdNm = $("input[name='dtlNm']").val();
				var invalidResult = validation.isValidCodeName(cdNm);
				if(!invalidResult){
					messager.alert('<spring:message code="admin.web.view.msg.code.isValidCodeName.dtlNm" />', "Info", "info");
					return false;
				}else{
					if(validate.check("codeDetailForm")) {
						messager.confirm('<spring:message code="column.common.confirm.insert" />', function(r){
							if(r){
								var options = {
									url : "<spring:url value='/system/codeDetailInsert.do' />"
									, data : $("#codeDetailForm").serializeJson()
									, callBack : function(data){
										codeDetailView($("#codeDetailForm").find("input[name=grpCd]").val(), $("#codeDetailForm").find("input[name=dtlCd]").val());
										reloadCodeDetailGrid($("#codeDetailForm").find("input[name=grpCd]").val());
									}
								};

								ajax.call(options);
							}
						});
					}
				}
			}

			// 상세 코드 수정
			function codeDetailUpdate(){
				if(validate.check("codeDetailForm")) {
					messager.confirm('<spring:message code="column.common.confirm.update" />', function(r){
						if(r){
							var options = {
								url : "<spring:url value='/system/codeDetailUpdate.do' />"
								, data : $("#codeDetailForm").serializeJson()
								, callBack : function(data){
									codeDetailView($("#codeDetailForm").find("input[name=grpCd]").val(), $("#codeDetailForm").find("input[name=dtlCd]").val());
									reloadCodeDetailGrid($("#codeDetailForm").find("input[name=grpCd]").val());
								}
							};

							ajax.call(options);
						}
					})
				}
			}

			// 상세 코드 삭제
			function codeDetailDelete(){
				messager.confirm('<spring:message code="column.common.confirm.delete" />', function(r){
					if(r){
						var options = {
							url : "<spring:url value='/system/codeDetailDelete.do' />"
							, data : $("#codeDetailForm").serializeJson()
							, callBack : function(data){
								codeDetailView($("#codeDetailForm").find("input[name=grpCd]").val(), '');
								reloadCodeDetailGrid($("#codeDetailForm").find("input[name=grpCd]").val());
							}
						};

						ajax.call(options);
					}
				})
			}

			//화면 최초 로딩 시
			function fnOnLoadDocument(){
				$('#grpCd').combobox({
					hasDownArrow : false
				});
				$('#grpNm').combobox({
					hasDownArrow : false
				});

				// 그룹 코드 그리드
				createCodeGroupGrid();
				// 상세 코드 그리드
				createCodeDetailGrid();
			}

			//초기화 버튼 클릭 시
			function fnInitBtnOnClick(){
				resetForm('codeGroupListForm');
				$("#grpNm").combobox("setText","");
				$("#grpCd").combobox("setText","");
				fnSearchBtnOnClick();
			}

			//검색 버튼 클릭 시
			function fnSearchBtnOnClick(){
				codeGroupView('');
				reloadCodeGroupGrid();
			}

			$(function(){
				fnOnLoadDocument();

				$(document).on("keydown","#_easyui_textbox_input3 , #_easyui_textbox_input4",function(e){
					var idx = this.id == "_easyui_textbox_input3" ? 0 : 1;
					if(e.keyCode == 13){
						reloadCodeGroupGrid();
						$(".panel-htop").eq(idx).hide();
					}else{
						$(".panel-htop").eq(idx).show();
					}
				})
			})
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="mTitle">
			<h2>그룹 코드</h2>
		</div>
		<div class="box">
			<div class="row">
				<div class="col-md-8 bar-right">
					<form name="codeGroupListForm" id="codeGroupListForm" method="post">
						<table class="table_type1">
							<caption>공통코드 등록</caption>
							<colgroup>
								<col style="width:120px;" />
								<col />
								<col style="width:120px;" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code="column.grp_cd" /></th>
									<td>
										<select class="easyui-combobox" name="grpCd" id="grpCd" title="<spring:message code="column.grp_cd" />" value="">
											<option></option>
											<c:forEach var="grpCd" items="${grpCds}">
												<option value="${grpCd}">${grpCd}</option>
											</c:forEach>
										</select>
									</td>
									<th><spring:message code="column.grp_nm" /></th>
									<td>
										<select class="easyui-combobox" name="grpNm" id="grpNm" title="<spring:message code="column.grp_nm" />" value="">
											<option></option>
											<c:forEach var="grpNm" items="${grpNms}">
												<option value="${grpNm}">${grpNm}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					<div class="btn_area_center">
						<button type="button" onclick="fnSearchBtnOnClick();" class="btn btn-ok">조회</button>
						<button type="button" onclick="fnInitBtnOnClick();" class="btn btn-cancel">초기화</button>
					</div>

					<div class="mModule mt20">
						<table id="codeGroupList" class="grid"></table>
						<div id="codeGroupListPage"></div>
					</div>
				</div>

				<div class="col-md-4">
					<div id="codeGroupView">
						<jsp:include page="/WEB-INF/view/system/codeGroupView.jsp" />
					</div>
				</div>
			</div>

		</div>

		<div class="mTitle mt30">
			<h2>코드 상세</h2>
		</div>
		<div class="box">
			<div class="row">
				<div class="col-md-8 bar-right">
					<div class="mModule" style="margin-top:0">
						<table id="codeDetailList" class="grid"></table>
						<div id="codeDetailListPage"></div>
					</div>
				</div>

				<div class="col-md-4">
					<div id="codeDetailView">
						<jsp:include page="/WEB-INF/view/system/codeDetailView.jsp" />
					</div>
				</div>
			</div>
		</div>
	</t:putAttribute>
</t:insertDefinition>