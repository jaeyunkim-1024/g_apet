<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			var tarGroupNo = null;
			var upGroupNo = null;
			$(document).ready(function(){
				createMenuTree();
				createMenuActionGrid();
			});

			function menuBaseAddView(){
				var data = $("#menuTree").jstree();
				var length = data._data.core.selected.length;
				var upGrpNo = null;
				for (var i = 0; i < length; i++) {
					upGrpNo = $("#menuTree").jstree().get_node(data._data.core.selected[i]).id;
				}

				menuBaseView(null, upGrpNo);
			}

			function menuBaseView(tagGrpNo, upGrpNo, depth){
				var options = {
					url : "<spring:url value='/tag/tagGroupView.do' />"
					, data : {
						tagGrpNo : tagGrpNo
						, upGrpNo : upGrpNo
					}
					, dataType : "html"
					, callBack : function(result){
						$("#menuBaseView").html(result);
						reloadMenuActionGrid(tagGrpNo);
						
						if(depth >= 4){
							$(".menuBaseAddBtn").hide();
						}else{
							$(".menuBaseAddBtn").show();
						}
						
						
					}
				};
				ajax.call(options);
			}
			
			//유효성체크
			function customValidation() {
				var cnt = 0;
				$(".required_item").each(function(index, item){
					var val = this.value;
					
					if(val == null || val == "") {
						var name = $(this).parents("td").prev().text().replace("*", "");
						console.log("text", text)
						
						var text = "";
						if(name == "Group 명"){
							text = "Tag Group명을 입력해 주세요";
						}else if(name == "정렬 순서"){
							text = "정렬 순서를 입력해 주세요"
						}
						
						$(this).validationEngine('showPrompt', text, 'error', true);
						cnt++;
					} else {
						$(this).validationEngine('hide');
					}
				})
				return (cnt > 0) ? false : true;
			}
			
			function menuSave() {
				if(customValidation()) {
					if(validate.check("menuBaseForm")) {
						if ($("#sortSeq").val() != '' && $("#sortSeq").val() * 1 > 0 && $("#hiddenSortSeq").val() != $("#sortSeq").val()) {
							let options = {
								url : "<spring:url value='/tag/tagGrpSortSeqChk.do' />"
								, data : {
									upGrpNo : $("#upGrpNo").val()
									, sortSeq : $("#sortSeq").val()
								}
								, callBack : function(result) {
									if (result) {
										messager.alert("<spring:message code='column.dupl.tag_grp_sort' />", "Info", "info", function(){
											$("#sortSeq").val($("#hiddenSortSeq").val());
											$("#sortSeq").focus();
											return;
										});
									} else {
										var check = true;
										var message = '<spring:message code="column.common.confirm.insert" />';
					
										if(!validation.isNull($("#menuBaseForm #tagGrpNo").val())){
											check = false;
											message = '<spring:message code="column.common.confirm.update" />';
										}
					
										messager.confirm(message, function(r){
											if(r){
												var options = {
													url : "<spring:url value='/tag/tagGroupSave.do' />"
													, data : $("#menuBaseForm").serializeJson()
													, callBack : function(result){
														tarGroupNo = result.tagGroupPO.tagGrpNo;
														upGroupNo = result.tagGroupPO.upGrpNo;
														$("#menuTree").jstree().refresh();
													}
												};
					
												ajax.call(options);
											}
										})
									}
								}
							}
							ajax.call(options);
						} else {
							var check = true;
							var message = '<spring:message code="column.common.confirm.insert" />';
		
							if(!validation.isNull($("#menuBaseForm #tagGrpNo").val())){
								check = false;
								message = '<spring:message code="column.common.confirm.update" />';
							}
		
							messager.confirm(message, function(r){
								if(r){
									var options = {
										url : "<spring:url value='/tag/tagGroupSave.do' />"
										, data : $("#menuBaseForm").serializeJson()
										, callBack : function(result){
											tarGroupNo = result.tagGroupPO.tagGrpNo;
											upGroupNo = result.tagGroupPO.upGrpNo;
											$("#menuTree").jstree().refresh();
										}
									};
		
									ajax.call(options);
								}
							})
						}
					}
				}
			}

			function menuDelete(tagGrpNo) {
				messager.confirm('<spring:message code="column.common.confirm.delete" />', function(r){
					if(r){
						var options = {
							url : "<spring:url value='/tag/tagGroupDelete.do' />"
							, data : {
								tagGrpNo : tagGrpNo
							}
							, callBack : function(result){
								tarGroupNo = null;
								upGroupNo = null;
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
								return "/tag/tagGroupTree.do";
							}
						}
					}
					, plugins : [ "themes" ]
				})
				// event 핸들러 :: 매장 클릭시 이벤트
				.on('changed.jstree', function(e, data) {
					var tagGrpNo = null;
					for (var i = 0; i < data.selected.length; i++) {
						tagGrpNo = data.instance.get_node(data.selected[i]).id;
					}
	
					//4depth일때 신규버튼 hide
					var depth = 0;
					if (data.node == undefined){
						if (data.instance._model.data[tarGroupNo] == undefined) {
							depth = null;
						} else {
							depth = data.instance._model.data[tarGroupNo].parents.length;
						}
					} else {
						depth = data.node.parents.length;
					}
					if(depth >= 4){
						$(".menuBaseAddBtn").hide();
					}else{
						$(".menuBaseAddBtn").show();
					}
					
					if(tagGrpNo != null) {
						menuBaseView(tagGrpNo, null, depth);
					}
					
				})
				.bind("ready.jstree", function (event, data) {
					$("#menuTree").jstree("open_all");
				});
			}
			

			// 상세 코드 그리드 생성
			function createMenuActionGrid(){
				var options = {
					url : "<spring:url value='/tag/tagGroupListGrid.do' />"
					, height : 300
					, searchParam : { tagGrpNo : '' }
					, sortname : 'tagGrpNo'
					, sortorder : 'DESC'
					, colModels : [
						{name:"tagGrpNo", label:'<b><u><tt><spring:message code="column.grp_no" /></tt></u></b>', width:"150", align:"center",  classes:'pointer fontbold', sortable:false}
						, {name:"grpNm", label:'<spring:message code="column.tag_grp_nm" />', width:"250", align:"center", sortable:false}
						, {name:"sortSeq", label:'<spring:message code="column.sort_seq" />', width:"100", align:"center", sortable:false}
						, {name:"stat", label:'<spring:message code="column.use_yn" />', width:"100", align:"center", sortable:false}
						, {name:"upGrpNo", label:'<spring:message code="column.up_grp_no" />', width:"100", align:"center", sortable:false, hidden:true}
						, _GRID_COLUMNS.sysRegrNm
						, _GRID_COLUMNS.sysRegDtm
						, _GRID_COLUMNS.sysUpdrNm
						, _GRID_COLUMNS.sysUpdDtm
					]
					, onSelectRow : function(ids) {
						var rowdata = $("#menuActionList").getRowData(ids);

						//menuBaseView(rowdata.tagGrpNo, rowdata.upGrpNo);
						$("#menuTree").jstree("deselect_all");
						$("#menuTree").jstree(true).select_node(rowdata.tagGrpNo);
					}
					, paging : false
				};

				grid.create("menuActionList", options);
			}

			// 상세 코드 리스트 리로드
			function reloadMenuActionGrid(tagGrpNo){
				var options = {
					searchParam : { tagGrpNo : tagGrpNo }
				};
				grid.reload("menuActionList", options);
			}

		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="row">
			<div class="col-md-3">
				<div class="mTitle">
					<h2>Tag Group 목록</h2>
					<div class="buttonArea">
						<button type="button" onclick="menuBaseAddView();" class="btn btn-add menuBaseAddBtn">신규</button>
					</div> 
				</div>
				<div class="tree-menu">
					<div class="gridTree" id="menuTree"></div>
				</div>
			</div>
			<div class="col-md-9">
				<div id="menuBaseView">
					<jsp:include page="/WEB-INF/view/tag/tagGroupView.jsp" />
				</div>
				
				<div class="mTitle mt30">
					<h2>태그 그룹 목록</h2>
				</div>
				<div class="box">
					<table id="menuActionList"></table>
				</div>
				
<!-- 				<div id="menuActionView"> -->
<%-- 					<jsp:include page="/WEB-INF/view/tag/tagChildGroupListView.jsp" /> --%>
<!-- 				</div> -->
				<hr />
			</div>
		</div>
	</t:putAttribute>
</t:insertDefinition>
