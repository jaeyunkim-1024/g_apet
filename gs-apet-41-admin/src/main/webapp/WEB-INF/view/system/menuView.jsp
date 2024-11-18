<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				createMenuTree();
				createMenuActionGrid();
			});

			function menuBaseAddView(){
				var data = $("#menuTree").jstree();
				var length = data._data.core.selected.length;
				var upMenuNo = null;
				for (var i = 0; i < length; i++) {
					upMenuNo = $("#menuTree").jstree().get_node(data._data.core.selected[i]).id;
				}

				menuBaseView(null, upMenuNo);
			}

			function menuBaseView(menuNo, upMenuNo){
				var options = {
					url : "<spring:url value='/system/menuBaseView.do' />"
					, data : {
						menuNo : menuNo
						, upMenuNo : upMenuNo
					}
					, dataType : "html"
					, callBack : function(result){
						$("#menuBaseView").html(result);
						reloadMenuActionGrid(menuNo, null);
					}
				};
				ajax.call(options);
			}

			function menuSave() {
				if(validate.check("menuBaseForm")) {
					var check = true;
					var message = '<spring:message code="column.common.confirm.insert" />';

					if(!validation.isNull($("#menuBaseForm #menuNo").val())){
						check = false;
						message = '<spring:message code="column.common.confirm.update" />';
					}

					messager.confirm(message, function(r){
						if(r){
							var options = {
								url : "<spring:url value='/system/menuBaseSave.do' />"
								, data : $("#menuBaseForm").serializeJson()
								, callBack : function(result){
									$("#menuTree").jstree().refresh();
								}
							};

							ajax.call(options);
						}
					})
				}
			}

			function menuDelete(menuNo) {
				messager.confirm('<spring:message code="column.common.confirm.delete" />', function(r){
					if(r){
						var options = {
							url : "<spring:url value='/system/menuBaseDelete.do' />"
							, data : {
								menuNo : menuNo
							}
							, callBack : function(result){
								$("#menuTree").jstree().refresh();
								menuBaseView();
							}
						};
						ajax.call(options);
					}
				})
			}

			function createMenuTree() {
				$("#menuTree").jstree({//tree 생성
					core : {
						multiple : false
						, data : {
							type : "POST"
							, url : function (node) {
								return "/system/menuTree.do";
							}
						}
					}
					, plugins : [ "themes" ]
				})
						// event 핸들러 :: 매장 클릭시 이벤트
						.on('changed.jstree', function(e, data) {
							var menuNo = null;
							for (var i = 0; i < data.selected.length; i++) {
								menuNo = data.instance.get_node(data.selected[i]).id;
							}

							if(menuNo != null) {
								menuBaseView(menuNo, null);
							}
						})
						.bind("ready.jstree", function (event, data) {
							$("#menuTree").jstree("open_all");
						});
			}

			// 상세 코드 그리드 생성
			function createMenuActionGrid(){
				var options = {
					url : "<spring:url value='/system/menuActionListGrid.do' />"
					, height : 300
					, searchParam : { menuNo : '' }
					, colModels : [
						{name:"menuNo", label:'<b><u><tt><spring:message code="column.menu_no" /></tt></u></b>', width:"100", align:"center", sortable:false, classes:'pointer fontbold'}
						, {name:"actNo", label:'<spring:message code="column.act_no" />', width:"100", align:"center"}
						, {name:"actNm", label:'<spring:message code="column.act_nm" />', width:"200", align:"center", sortable:false}
						, {name:"url", label:'<spring:message code="column.url" />', width:"300", align:"center", sortable:false}
						, {name:"actGbCd", label:'<spring:message code="column.act_gb_cd" />', width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.ACT_GB}" />"}}
						, _GRID_COLUMNS.useYn
						, _GRID_COLUMNS.sysRegrNm
						, _GRID_COLUMNS.sysRegDtm
						, _GRID_COLUMNS.sysUpdrNm
						, _GRID_COLUMNS.sysUpdDtm
					]
					, onSelectRow : function(ids) {
						var rowdata = $("#menuActionList").getRowData(ids);
						menuActionView(rowdata.menuNo, rowdata.actNo);
					}
					, paging : false
				};

				grid.create("menuActionList", options);
			}

			// 상세 코드 리스트 리로드
			function reloadMenuActionGrid(menuNo, actNo){
				var options = {
					searchParam : { menuNo : menuNo }
				};
				grid.reload("menuActionList", options);
				menuActionView(menuNo, actNo);
			}

			function menuActionView(menuNo, actNo) {
				if(menuNo === ""){
					menuNo = $("[name='menuNo']").val();
				}
				var options = {
					url : "<spring:url value='/system/menuActionView.do' />"
					, data : {
						menuNo : menuNo
						, actNo : actNo
					}
					, dataType : "html"
					, callBack : function(result){
						$("#menuActionView").html(result);
					}
				};
				ajax.call(options);
			}

			function menuActionSave() {
				if(validate.check("menuActionForm")) {
					var check = true;
					var message = '<spring:message code="column.common.confirm.insert" />';

					if(!validation.isNull($("#menuActionForm #actNo").val())){
						check = false;
						message = '<spring:message code="column.common.confirm.update" />';
					}

					messager.confirm( message, function(r){
						if(r){
							var options = {
								url : "<spring:url value='/system/menuActionSave.do' />"
								, data : $("#menuActionForm").serializeJson()
								, callBack : function(result){
									reloadMenuActionGrid(result.menuAction.menuNo, result.menuAction.actNo);
								}
							};

							ajax.call(options);
						}
					})
				}
			}

			function menuActionDelete() {
				if(validate.check("menuActionForm")) {
					var check = true;
					var message = '<spring:message code="column.common.confirm.delete" />';

					messager.confirm( message, function(r){
						if(r){
							var options = {
								url : "<spring:url value='/system/menuActionDelete.do' />"
								, data : $("#menuActionForm").serializeJson()
								, callBack : function(result){
									reloadMenuActionGrid(result.menuAction.menuNo, null);
								}
							};

							ajax.call(options);
						}
					})
				}
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="row">
			<div class="col-md-3">
				<div class="mTitle">
					<h2>메뉴 목록</h2>
					<div class="buttonArea">
						<button type="button" onclick="menuBaseAddView();" class="btn btn-add">추가</button>
					</div>
				</div>
				<div class="tree-menu">
					<div class="gridTree" id="menuTree"></div>
				</div>
			</div>
			<div class="col-md-9">
				<div id="menuBaseView">
					<jsp:include page="/WEB-INF/view/system/menuBaseView.jsp" />
				</div>

				<div class="mTitle mt30">
					<h2>하위 메뉴 기능 목록</h2>
				</div>
				<div class="box">
					<table id="menuActionList"></table>
				</div>

				<div id="menuActionView">
					<jsp:include page="/WEB-INF/view/system/menuActionView.jsp" />
				</div>
				<hr />
			</div>
		</div>
	</t:putAttribute>
</t:insertDefinition>
