<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function(){
			//엔터키 	
			$(document).on("keydown","#authSearchForm input",function(){
    			if ( window.event.keyCode == 13 ) {
    				reloadAuthGrid();
  		  		}
            });
  
        });
			function createMenuTree() {
				$("#menuTree").jstree({//tree 생성
					core : {
						multiple : true
						, data : {
							type : "POST"
							, url : function (node) {
								return "/system/menuTree.do";
							}
						}
					}
					, plugins : [ "themes" , "checkbox" ]
				})
				.bind("ready.jstree", function (event, data) {
					$("#menuTree").jstree("open_all");
				});
			}

			// 권한 그리드
			function createAuthGrid(){
				var options = {
					url : "<spring:url value='/system/authListGrid.do' />"
					, height : 550
					, searchParam : $("#authSearchForm").serializeJson()
					, colModels : [
						{name:"authNo", label:'<spring:message code="column.auth_no" />', width:"70", align:"center", sortable:false}
						, {name:"authNm", label:'<b><u><tt><spring:message code="column.auth_nm" /></tt></u></b>', width:"120", align:"center", sortable:false, classes:'pointer fontbold'}
						, _GRID_COLUMNS.useYn
						, _GRID_COLUMNS.sysRegrNm
						, _GRID_COLUMNS.sysRegDtm
						, _GRID_COLUMNS.sysUpdrNm
						, _GRID_COLUMNS.sysUpdDtm
					]
					, onSelectRow : function(ids) {
						var rowdata = $("#authList").getRowData(ids);
						authView(rowdata.authNo);
					}
				};

				grid.create("authList", options);
			}
			function reloadAuthGrid(){
				var options = {
					searchParam : $("#authSearchForm").serializeJson()
				};

				grid.reload("authList", options);
			}

			//권한 table 생성
			function authView(authNo){
				var options = {
					url : "<spring:url value='/system/authView.do' />"
					, data : {
						authNo : authNo
					}
					, dataType : "html"
					, callBack : function(data){
						$("#authView").html(data);
						$("#menuTree").jstree("set_text","0","Back Office");
						authMenuList(authNo);
					}
				};
				ajax.call(options);
			}

			//메뉴 트리에 해당 권한 표시
			function authMenuList(authNo) {
				var options = {
					url : "<spring:url value='/system/authMenuList.do' />"
					, data : {
						authNo : authNo
					}
					, callBack : function(data){
						$("#menuTree").jstree().deselect_all();
						$(data.authMenu).each(function(e){
							$("#menuTree").jstree().select_node(this.menuNo);
						});
					}
				};
				ajax.call(options);
			}

			function authSave() {
				if(validate.check("authForm")) {
					var message = '<spring:message code="column.common.confirm.insert" />';

					if(!validation.isNull($("#authForm #authNo").val())) {
						message = '<spring:message code="column.common.confirm.update" />';
					}

					var data = $("#authForm").serializeJson();

					var treeData = $("#menuTree").jstree().get_selected(true);
					var arrAllMenuNo = new Array();
					for(var i in treeData) {
						if(treeData[i].children == null || treeData[i].children.length == 0){
							arrAllMenuNo.push(treeData[i].id);
							for(var j in treeData[i].parents) {
								if(treeData[i].parents[j] != '0' && treeData[i].parents[j] != '#') {
									arrAllMenuNo.push(treeData[i].parents[j]);
								}
							}
						}
					}
					var arrMenuNo = new Array();
					$.each(arrAllMenuNo, function(index, element) {
						if ($.inArray(element, arrMenuNo) == -1) {
							arrMenuNo.push(element);
						}
					});

					$.extend(data, {
						arrMenuNo : arrMenuNo
					});

					messager.confirm(message, function(r){
						if(r){
							var options = {
								url : "<spring:url value='/system/authSave.do' />"
								, data : data
								, callBack : function(data){
									reloadAuthGrid();
									authView(data.auth.authNo);
								}
							};

							ajax.call(options);							
						}
					})
				}
			}

			function authDelete(authNo) {
				messager.confirm('<spring:message code="column.common.confirm.delete" />', function(r){
					if(r){
						var options = {
							url : "<spring:url value='/system/authDelete.do' />"
							, data : { authNo : authNo }
							, callBack : function(data){
								reloadAuthGrid();
								authView('');
							}
						};

						ajax.call(options);
					}
				})
			}

			function fnInitBtnOnClick(){
				resetForm('authSearchForm');
				reloadAuthGrid();
				authMenuList();
			}
			$(function(){
				createAuthGrid();
				createMenuTree();
			})
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="row">
			<div class="col-md-7">
				<form name="authSearchForm" id="authSearchForm" method="post">
				<table class="table_type1">
					<caption>정보 검색</caption>
					<colgroup>
						<col style="width:15%;">
						<col style="width:auto;">
						<col style="width:15%;">
						<col style="width:auto;">
					</colgroup>
					<tbody>
						<tr>
							<th><spring:message code="column.auth_nm"/></th>
							<td>
								<!-- 권한 명-->
								<input type="text" class="" name="authNm" id="authNm" title="<spring:message code="column.auth_nm"/>" />
							</td>
							<th><spring:message code="column.use_yn" /></th>
							<td>
								<!-- 사용 여부-->
								<select name="useYn" id="useYn" title="<spring:message code="column.use_yn"/>" >
									<frame:select grpCd="${adminConstants.USE_YN}" defaultName="전체"/>
								</select>
							</td>
						</tr>
					</tbody>
				</table>
				</form>

				<div class="btn_area_center">
					<button type="button" onclick="reloadAuthGrid();" class="btn btn-ok">검색</button>
					<button type="button" onclick="fnInitBtnOnClick();" class="btn btn-cancel">초기화</button>
				</div>

				<div class="mModule">
					<table id="authList" ></table>
					<div id="authListPage"></div>
				</div>
			</div>
			
			<div class="col-md-5 bar-left">
				<div class="mTitle">
					<h2>메뉴 권한</h2>
				</div>
				<div class="box">
					<div id="authView">
						<jsp:include page="/WEB-INF/view/system/authView.jsp" />
					</div>
				</div>
				<div class="tree-menu" style="border-top:none;">
					<div class="gridTree" id="menuTree" style="height:700px;"></div>
				</div>
			</div>
		</div>		
		
	</t:putAttribute>
</t:insertDefinition>