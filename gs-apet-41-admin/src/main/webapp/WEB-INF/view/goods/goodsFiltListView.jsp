<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		
		$(document).ready(function(){
						//엔터키 	
						$(document).on("keydown","#codeGroupListForm input",function(){
			    			if ( window.event.keyCode == 13 ) {
				    			reloadCodeGroupGrid();
			  		  		}
			            });
			  
			        });
		
			function createCodeGroupGrid(){
				var options = {
					url : "<spring:url value='/goods/getFiltGrpList.do' />"
					, height : 370
					, sortname : 'filtGrpNo'
					, sortorder : 'ASC'
					, searchParam : $("#codeGroupListForm").serializeJson()
					, colModels : [
						{name:"filtGrpNo"		, label:'<b><u><tt><spring:message code="column.filtGrpNo" /></tt></u></b>', width:"80", align:"center", classes:'pointer fontbold'}
						, {name:"filtGrpMngNm"	, label:'<spring:message code="column.filtGrpMngNm" />'	, width:"200", align:"center"}
						, {name:"filtGrpShowNm"	, label:'<spring:message code="column.filtGrpShowNm" />', width:"200", align:"center"}
						, {name:"sysRegrNm"		, label:'<spring:message code="column.sys_regr_nm" />'	, width:"120", align:"center"}
						, {name:"sysRegDtm"		, label:'<spring:message code="column.sys_reg_dtm" />'	, width:"100", align:"center"	, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"sysUpdrNm"		, label:'<spring:message code="column.sys_updr_nm" />'	, width:"120", align:"center"}
						, {name:"sysUpdDtm"		, label:'<spring:message code="column.sys_upd_dtm" />'	, width:"100", align:"center"	, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
					]
					, onSelectRow : function(ids) {
						var rowdata = $("#codeGroupList").getRowData(ids);
						//코드관리_그룹 상세 조회
						fnFiltGrpView(rowdata.filtGrpNo);
					}
					, paging : false
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
			function fnFiltGrpView(filtGrpNo){
				var options = {
					url : "<spring:url value='/goods/filtGrpInfoView.do' />"
					, data : { filtGrpNo : filtGrpNo }
					, dataType : "html"
					, callBack : function(data){
						$("#fnFiltGrpView").html(data);
						validate.set("codeGroupForm");
						reloadCodeDetailGrid(filtGrpNo);
						fnFiltAttrView(filtGrpNo, '');
					}
				};

				ajax.call(options);
			}

			// 그룹 코드 등록
			function fnFiltGrpInsert(){
				var cdNm 		= $("input[name='filtGrpMngNm']").val();
				var cdShowNm 	= $("input[name='filtGrpShowNm']").val();
				/*
				if(!validation.isValidCodeName(cdShowNm)){
					messager.alert('<spring:message code="admin.web.view.msg.code.isValidCodeName.filtGrpMngNm" />', "Info", "info");
					return false;
				}
				if(!validation.isValidCodeName(cdNm)){
					messager.alert('<spring:message code="admin.web.view.msg.code.isValidCodeName.filtGrpShowNm" />', "Info", "info");
					return false;
				}
				// */

				if(validate.check("codeGroupForm")) {
					messager.confirm('<spring:message code="column.common.confirm.insert" />', function(r){
						if(r){
							var options = {
								url : "<spring:url value='/goods/filtGrpInsert.do' />"
								, data : $("#codeGroupForm").serializeJson()
								, callBack : function(data){
									fnFiltGrpView($("#codeGroupForm").find("input[name=filtGrpNo]").val());
									reloadCodeGroupGrid();
									fnAddSearchKeyWord("filtGrpMngNm");
									fnAddSearchKeyWord("filtGrpShowNm");
								}
							};

							ajax.call(options);
						}
					})
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
			function fnFiltGrpUpdate(){
				if(validate.check("codeGroupForm")) {
					messager.confirm('<spring:message code="column.common.confirm.update" />', function(r){
						if(r){
							var options = {
								url : "<spring:url value='/goods/filtGrpUpdate.do' />"
								, data : $("#codeGroupForm").serializeJson()
								, callBack : function(data){
									fnFiltGrpView($("#codeGroupForm").find("input[name=filtGrpNo]").val());
									fnUpdateSearchKeyword("filtGrpMngNm", $("#originfiltGrpMngNm").val(),$("#codeGroupForm").find("input[name=filtGrpMngNm]").val());
									fnUpdateSearchKeyword("filtGrpShowNm", $("#originfiltGrpShowNm").val(),$("#codeGroupForm").find("input[name=filtGrpShowNm]").val());
									reloadCodeGroupGrid();
								}
							};

							ajax.call(options);
						}
					})
				}
			}
			function fnUpdateSearchKeyword(id, oldkeyword,newkeyword){
				var data = $("#"+id).combobox('getData');
				var result = [];
				data.forEach(function(item){
					if(item.value === oldkeyword){
						item.value = newkeyword;
						item.text = newkeyword;
					}
					result.push(item);
				});
				$("#"+id).combobox('loadData', result);
			}

			// 그룹 코드 삭제
			function fnFiltGrpDelete(){
				console.log("fnFiltGrpDelete");
				messager.confirm('<spring:message code="column.common.confirm.delete" />', function(r){
					if(r){
						var options = {
							url : "<spring:url value='/goods/filtGrpDelete.do' />"
							, data : $("#codeGroupForm").serializeJson()
							, callBack : function(data){
								console.log("delete data : " + data);
								fnDeleteSearchKeyword("filtGrpMngNm");
								fnDeleteSearchKeyword("filtGrpShowNm");
								fnFiltGrpView('');
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

					$("#"+id).combobox('loadData', item);
				});

			}

			// 상세 코드 그리드 생성
			function createCodeDetailGrid(){
				var options = {
					url : "<spring:url value='/goods/getFiltAttrList.do' />"
					, height : 450
					, searchParam : { filtGrpNo : '' }
					, colModels : [
						{name:"filtGrpNo"		, label:'<spring:message code="column.filtGrpNo" />', width:"100", align:"center", sortable:false}
						, {name:"filtAttrSeq"	, label:'<b><u><tt><spring:message code="column.filtAttrSeq" /></tt></u></b>', width:"80", align:"center", classes:'pointer fontbold'}
						, {name:"filtAttrNm"	, label:'<spring:message code="column.filtAttrNm" />', width:"180", align:"center", sortable:false}
						, {name:"useYn"			, label:'<spring:message code="column.use_yn" />', width:"80", align:"center", sortable:false}
						, {name:"sysRegrNm"		, label:'<spring:message code="column.sys_regr_nm" />'	, width:"120", align:"center"}
						, {name:"sysRegDtm"		, label:'<spring:message code="column.sys_reg_dtm" />'	, width:"100", align:"center"	, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"sysUpdrNm"		, label:'<spring:message code="column.sys_updr_nm" />'	, width:"120", align:"center"}
						, {name:"sysUpdDtm"		, label:'<spring:message code="column.sys_upd_dtm" />'	, width:"100", align:"center"	, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
					]
					, onSelectRow : function(ids) {
						var rowdata = $("#codeDetailList").getRowData(ids);

						fnFiltAttrView(rowdata.filtGrpNo, rowdata.filtAttrSeq);
					}
					, paging : false
				};

				grid.create("codeDetailList", options);
			}

			// 상세 코드 리스트 리로드
			function reloadCodeDetailGrid(filtGrpNo){
				var options = {
					searchParam : { filtGrpNo : filtGrpNo }
				};
				grid.reload("codeDetailList", options);
			}

			// 상세 코드 화면
			function fnFiltAttrView(filtGrpNo, filtAttrSeq){
				var options = {
					url : "<spring:url value='/goods/filtAttrInfoView.do' />"
					, data : {
						filtGrpNo : filtGrpNo
						, filtAttrSeq : filtAttrSeq
					}
					, dataType : "html"
					, callBack : function(data){
						$("#fnFiltAttrView").html(data);
						validate.set("codeDetailForm");
					}
				};

				ajax.call(options);
			}

			// 상세 코드 등록
			function fnFiltAttrInsert(){
				var cdNm = $("input[name='filtAttrNm']").val();
				var filtGrpNo = $("input[name='filtGrpNo']").val();
				var invalidResult = validation.isValidCodeName(cdNm);
				if(filtGrpNo == ""){
					messager.alert('<spring:message code="admin.web.view.msg.code.isValidCodeName.filtGrpNo" />', "Info", "info");
					return false;
				}

				// 입력 범위 특수문제 제외 제거 처리.21.02.19
				if(validate.check("codeDetailForm")) {
					messager.confirm('<spring:message code="column.common.confirm.insert" />', function(r){
						if(r){
							var options = {
								url : "<spring:url value='/goods/filtAttrInsert.do' />"
								, data : $("#codeDetailForm").serializeJson()
								, callBack : function(data){
									fnFiltAttrView($("#codeDetailForm").find("input[name=filtGrpNo]").val(), $("#codeDetailForm").find("input[name=filtAttrSeq]").val());
									reloadCodeDetailGrid($("#codeDetailForm").find("input[name=filtGrpNo]").val());
								}
							};

							ajax.call(options);
						}
					});
				}

				<%--if(!invalidResult){--%>
				<%--	messager.alert('<spring:message code="admin.web.view.msg.code.isValidCodeName.filtAttrNm" />', "Info", "info");--%>
				<%--	return false;--%>
				<%--}else{--%>
				<%--	--%>
				<%--}--%>
			}

			// 상세 코드 수정
			function fnFiltAttrUpdate(){
				if(validate.check("codeDetailForm")) {
					messager.confirm('<spring:message code="column.common.confirm.update" />', function(r){
						if(r){
							var options = {
								url : "<spring:url value='/goods/filtAttrUpdate.do' />"
								, data : $("#codeDetailForm").serializeJson()
								, callBack : function(data){
									fnFiltAttrView($("#codeDetailForm").find("input[name=filtGrpNo]").val(), $("#codeDetailForm").find("input[name=filtAttrSeq]").val());
									reloadCodeDetailGrid($("#codeDetailForm").find("input[name=filtGrpNo]").val());
								}
							};

							ajax.call(options);
						}
					})
				}
			}

			// 상세 코드 삭제
			function fnFiltAttrDelete(){
				messager.confirm('<spring:message code="column.common.confirm.delete" />', function(r){
					if(r){
						var options = {
							url : "<spring:url value='/goods/filtAttrDelete.do' />"
							, data : $("#codeDetailForm").serializeJson()
							, callBack : function(data){
								fnFiltAttrView($("#codeDetailForm").find("input[name=filtGrpNo]").val(), '');
								reloadCodeDetailGrid($("#codeDetailForm").find("input[name=filtGrpNo]").val());
							}
						};

						ajax.call(options);
					}
				})
			}

			//화면 최초 로딩 시
			function fnOnLoadDocument(){
				$('#filtGrpMngNm').combobox({
					hasDownArrow : false
				});
				$('#filtGrpShowNm').combobox({
					hasDownArrow : false
				});

				// 그룹 코드 그리드
				createCodeGroupGrid();
				// 상세 코드 그리드
				createCodeDetailGrid();
			}

			$(function(){
				fnOnLoadDocument();
			})
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="mTitle">
			<h2>필터 그룹 관리</h2>
		</div>
		<div class="box">
			<div class="row">
				<div class="col-md-8 bar-right">
					<form name="codeGroupListForm" id="codeGroupListForm" method="post">
						<table class="table_type1">
							<caption>상품 필터 그룹 등록</caption>
							<colgroup>
								<col style="width:100px;" />
								<col />
								<col style="width:100px;" />
								<col />
							</colgroup>
							<tbody>
							<tr>
								<th><spring:message code="column.filtGrpMngNm" /></th>
								<td>
									<select class="easyui-combobox" name="filtGrpMngNm" id="filtGrpMngNm" title="<spring:message code="column.filtGrpMngNm" />" value="">
										<option></option>
										<c:forEach var="filtGrpMngNm" items="${filtGrpMngNms}">
											<option value="${filtGrpMngNm}">${filtGrpMngNm}</option>
										</c:forEach>
									</select>
								</td>
								<th><spring:message code="column.filtGrpShowNm" /></th>
								<td>
									<select class="easyui-combobox" name="filtGrpShowNm" id="filtGrpShowNm" title="<spring:message code="column.filtGrpShowNm" />" value="">
										<option></option>
										<c:forEach var="filtGrpShowNm" items="${filtGrpShowNms}">
											<option value="${filtGrpShowNm}">${filtGrpShowNm}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							</tbody>
						</table>
					</form>

					<div class="btn_area_center">
						<button type="button" onclick="reloadCodeGroupGrid();" class="btn btn-ok">검색</button>
						<button type="button" onclick="resetForm('codeGroupListForm');" class="btn btn-cancel">초기화</button>
					</div>

					<div class="mModule mt20">
						<table id="codeGroupList" class="grid"></table>
<%--						<div id="codeGroupListPage"></div>--%>
					</div>
				</div>
				<div class="col-md-4">
					<div id="fnFiltGrpView">
						<jsp:include page="/WEB-INF/view/goods/goodsFiltGrpView.jsp" />
					</div>
				</div>
			</div>

		</div>

		<div class="mTitle mt30">
			<h2>필터 속성 관리</h2>
		</div>
		<div class="box">
			<div class="row">
				<div class="col-md-8 bar-right">
					<div class="mModule" style="margin-top:0">
						<table id="codeDetailList" class="grid"></table>
<%--						<div id="codeDetailListPage"></div>--%>
					</div>
				</div>

				<div class="col-md-4">
					<div id="fnFiltAttrView">
						<jsp:include page="/WEB-INF/view/goods/goodsFiltAttrView.jsp" />
					</div>
				</div>
			</div>
		</div>
	</t:putAttribute>
</t:insertDefinition>