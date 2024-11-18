<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				// 게시판 글 그리드
				bbsLetterGrid();
				<c:if test="${board.bbsTpCd eq  adminConstants.BBS_TP_40 or  board.bbsTpCd eq adminConstants.BBS_TP_41  }">
					bbsLetterDispGrid();
				</c:if>
			});

			// 게시판 글 리스트
			function bbsLetterGrid(){
				var options = {
					url : "<spring:url value='/${board.bbsId}/bbsLetterListGrid.do' />"
					, height : 400
					, colModels : [
						// 글 번호
						{name:"lettNo", label:'<spring:message code="column.lett_no" /></tt></u></b>', width:"70", align:"center", sortable:false, formatter:'integer'}
						// 제목
						, {name:"ttl", label:'<b><u><tt><spring:message code="column.ttl" /></tt></u></b>', width:"500", align:"center", classes:'pointer fontbold'}
						/* // 사이트 구분 코드
						, {name:"showGbCd", label:'<spring:message code="column.show_gb_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.SHOW_GB}" />"}} */
						// 조회수
						, {name:"hits", label:'<spring:message code="column.hits" />', width:"80", align:"center", sortable:false, formatter:'integer'}
						<c:if test="${board.bbsTpCd eq  adminConstants.BBS_TP_40 or  board.bbsTpCd eq adminConstants.BBS_TP_41  }">
						, {name:"dispPriorRank", label:'<spring:message code="column.disp_prior_rank" />', width:"80", align:"center", formatter:'integer' , editable:true }
						</c:if>
						<c:if test="${board.bbsTpCd eq  adminConstants.BBS_TP_20 }">
						, {name:"rcomYn", label:'<spring:message code="column.rcom_yn" />', width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.COMM_YN}" />"} , editable:true }
						</c:if>
						// 댓글수
						, {name:"bbsReplyCnt", label:'댓글수', width:"80", align:"center", sortable:false, formatter:'integer'}
						// 시스템 등록자
						, {name:"sysRegrNm", label:'<spring:message code="column.sys_regr_nm" />', width:"100", align:"center"}
						// 시스템 등록 일시
						, {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						// 시스템 수정자
						, {name:"sysUpdrNm", label:'<spring:message code="column.sys_updr_nm" />', width:"100", align:"center"}
						// 시스템 수정 일시
						, {name:"sysUpdDtm", label:'<spring:message code="column.sys_upd_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"bbsId", hidden:true }  
					]
					, multiselect : true
					, cellEdit : true
					, onCellSelect : function (ids, cellidx, cellvalue) {
						if(cellidx == 1 || cellidx == 2) { // CODE 선택
							var rowdata = $("#bbsLetter").getRowData(ids);
							bbsLetterDetailView(rowdata.lettNo);
						}
					}
				};
				grid.create("bbsLetter", options);
			}

			// 게시판 글 리스트
			function bbsLetterDispGrid(){
				var options = {
					url : "<spring:url value='/${board.bbsId}/bbsLetterDispListGrid.do' />"
					, height : 200
					, colModels : [
                        {name:"dispPriorRank", label:'<spring:message code="column.disp_prior_rank" />', width:"100", align:"center", formatter:'integer', editable:true }           
						// 글 번호
						, {name:"lettNo", label:'<spring:message code="column.lett_no" />', width:"70", align:"center", formatter:'integer'}
						// 제목
						, {name:"ttl", label:'<spring:message code="column.ttl" />', width:"250", align:"center", sortable:false}
						// 조회수
						, {name:"hits", label:'<spring:message code="column.hits" />', width:"80", align:"center", sortable:false, formatter:'integer'}
						// 댓글수
						, {name:"bbsReplyCnt", label:'댓글수', width:"80", align:"center", sortable:false, formatter:'integer'}
						// 시스템 등록자
						, {name:"sysRegrNm", label:'<spring:message code="column.sys_regr_nm" />', width:"100", align:"center"}
						// 시스템 등록 일시
						, {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						// 시스템 수정자
						, {name:"sysUpdrNm", label:'<spring:message code="column.sys_updr_nm" />', width:"100", align:"center"}
						// 시스템 수정 일시
						, {name:"sysUpdDtm", label:'<spring:message code="column.sys_upd_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"bbsId", hidden:true }  
					]
					, multiselect : true
					, cellEdit : true
					, onCellSelect : function (ids, cellidx, cellvalue) {
						 
					}
				};
				grid.create("bbsLetterDisp", options);
			}
			
			
			// 그룹 코드 리스트 조회
			function reloadBbsLetterGrid(){
				grid.reload("bbsLetter", {});
			}
			function reloadBbsLetterDispGrid(){
                grid.reload("bbsLetterDisp", {});
			}

			// 게시판 등록
			function bbsLetterView(bbsId) {
				var title = getSeletedTabTitle();
				addTab(title + ' 등록', '/${board.bbsId}/bbsLetterView.do?bbsId=' + bbsId);
			}

			// 게시판 상세보기
			function bbsLetterDetailView(lettNo) {
				var title = getSeletedTabTitle();
				addTab(title + ' 상세', '/${board.bbsId}/bbsLetterDetailView.do?lettNo=' + lettNo);
			}

			// 게시판 삭제
			function boardDelete(){

				var grid = $("#bbsLetter");
				var lettNos = new Array();
				var rowids = grid.jqGrid('getGridParam', 'selarrrow');

				if(rowids != null && rowids.length <= 0 ) {
					messager.alert("<spring:message code='column.common.delete.no_select' />", "Info", "info" );
					return;
				}
				
				messager.confirm("<spring:message code='column.common.confirm.delete' />", function(r){
					if(r){
						for(var i in rowids) {
							var data = grid.getRowData(rowids[i]);
							lettNos.push({lettNo : data.lettNo});
						}
	
						var options = {
								url : "<spring:url value='/${board.bbsId}/bbsLetterArrDelete.do' />"
								, data : {
									deleteLettNoStr : JSON.stringify(lettNos)
								}
								, callBack : function(result) {
									messager.alert("<spring:message code='column.common.delete.final_msg' arguments='" + rowids.length + "' />", "Info", "info", function(){
										reloadBbsLetterGrid();	
									});
								}
						};
						ajax.call(options);
					}
				})
			}
			
			
			// 전시 코너 아이템 저장
			function bbsDispPriorRankSave(gridsName) {
				var url = "";
				var grid = $("#"+gridsName);  
				var cornerItems = new Array();

				var rowids = grid.jqGrid('getGridParam', 'selarrrow');
				if(rowids.length <= 0 ) {
					messager.alert("<spring:message code='column.display_view.message.no_select' />", "Info", "info");
					return;
				} else {
					
					for(var i = 0; i < rowids.length; i++) {
						var data = $("#"+gridsName).getRowData(rowids[i]);
						cornerItems.push({  bbsId : data.bbsId 
						                  , lettNo : data.lettNo 
						                  , dispPriorRank : data.dispPriorRank
						                 });
					}
					//console.log("=========cornerItems=========");
					//console.log(cornerItems);
				}
				var sendData = new Array();
				sendData = {
						bbsLetterDispPOList : JSON.stringify(cornerItems)
	 				};
				
				console.log(sendData);
									
				messager.confirm("<spring:message code='column.display_view.message.confirm_save' />", function(r){
					if(r){
						var options = {
								url : "<spring:url value='/${board.bbsId}/insertBbsLetterDisp.do' />"
								, data : sendData
								, callBack : function(data) {
									messager.alert("<spring:message code='column.display_view.message.save'/>", "Info", "info", function(){
										reloadBbsLetterGrid();	
										reloadBbsLetterDispGrid();
									});
								}
							};

						ajax.call(options);	
					}
				})
			}
			
			function bbsDispPriorRankDelete() {
				var url = "";
				var grid = $("#bbsLetterDisp");  
				var cornerItems = new Array();

				var rowids = grid.jqGrid('getGridParam', 'selarrrow');
				if(rowids.length <= 0 ) {
					messager.alert("<spring:message code='column.display_view.message.no_select' />", "Info", "info");
					return;
				} else {
					
					for(var i = 0; i < rowids.length; i++) {
						var data = $("#bbsLetterDisp").getRowData(rowids[i]);
						cornerItems.push({  bbsId : data.bbsId 
						                  , lettNo : data.lettNo 
						                  , dispPriorRank : data.dispPriorRank
						                 });
					}
					//console.log("=========cornerItems=========");
					//console.log(cornerItems);
				}
				var sendData = new Array();
				sendData = {
						bbsLetterDispPOList : JSON.stringify(cornerItems)
	 				};
				messager.confirm("<spring:message code='column.display_view.message.confirm_save' />", function(r){
					if(r){
						var options = {
								url : "<spring:url value='/${board.bbsId}/deleteBbsLetterDisp.do' />"
								, data : sendData
								, callBack : function(data) {
									messager.alert("<spring:message code='column.display_view.message.save'/>", "Info", "info", function(){
										reloadBbsLetterGrid();	
										reloadBbsLetterDispGrid();	
									});
								}
							};

						ajax.call(options);
					}
				})
			}
			
	        // 업체 검색
	        function searchCompany () {
	            var options = {
	                multiselect : false
	                , callBack : searchCompanyCallback
	<c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
	                , showLowerCompany : 'Y'
	</c:if>             
	            }
	            layerCompanyList.create (options );
	        }
	        function searchCompanyCallback (compList ) {
	            if(compList.length > 0 ) {
	                $("#bbsLetterListForm #compNo").val (compList[0].compNo );
	                $("#bbsLetterListForm #compNm").val (compList[0].compNm );
	            }
	        }			
			
		     // 게시글 검색 조회
	        function searchBBSLetterList () {
	            var options = {
	                searchParam : $("#bbsLetterListForm").serializeJson()
	            };
	            grid.reload("bbsLetter", options);
	        }

	        // 초기화 버튼클릭
	        function searchReset () {
	            resetForm ("bbsLetterListForm");
	            <c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
	            $("#bbsLetterListForm #compNo").val('${adminSession.compNo}');
	            $("#bbsLetterListForm #showAllLowCompany").val("N");
	            </c:if>
	        }
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">

		<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd and board.bbsId eq 'cpnotice'}">
			<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
				<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
		</c:if>		
					<form id="bbsLetterListForm" name="bbsLetterListForm" method="post" >
						<table class="table_type1">
							<caption>게시판 글 목록</caption>
							<tbody>
								<tr>
									<th><spring:message code="column.bbs_id" /></th>
									<td>
										${board.bbsId}
									</td>
									<th><spring:message code="column.bbs_nm" /></th>
									<td>
										${board.bbsNm}
									</td>
								</tr>
								<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd and board.bbsId eq 'cpnotice'}">
			                    <tr>
			                        <th scope="row"><spring:message code="column.goods.comp_no" /></th> <!-- 업체번호 -->
			                        <td colspan="3">
			                            <frame:compNo funcNm="searchCompany" disableSearchYn="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? 'N' : 'Y'}" placeholder="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? '입점업체를 검색하세요' : ''}"/>
			                        </td>
			                    </tr>
			                    </c:if>
							</tbody>
						</table>
					</form>
		<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd and board.bbsId eq 'cpnotice'}">
				    <div class="btn_area_center">
			           <button type="button" onclick="searchBBSLetterList();" class="btn btn-ok">검색</button>
			           <button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
			        </div>
				</div>
			</div>
		</c:if>

			<div class="mModule">
				<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}">
					<button type="button" onclick="bbsLetterView('');" class="btn btn-add">글 등록</button>
					<button type="button" onclick="boardDelete();" class="btn btn-add">글 삭제</button>
					<c:if test="${board.bbsTpCd eq  adminConstants.BBS_TP_40 or  board.bbsTpCd eq adminConstants.BBS_TP_41  }">
					<button type="button" onclick="bbsDispPriorRankSave('bbsLetter');" class="btn btn-add">전시우선순위 수정</button>
					</c:if>
				</c:if>
				
				<table id="bbsLetter" class="grid"></table>
				<div id="bbsLetterPage"></div>
			</div>


		<c:if test="${board.bbsTpCd eq  adminConstants.BBS_TP_40 or  board.bbsTpCd eq adminConstants.BBS_TP_41  }">
			<div class="mTitle mt30">
				<h2>전시 우선 순위</h2>
				<div class="buttonArea">
				    <button type="button" onclick="bbsDispPriorRankSave('bbsLetterDisp');" class="btn btn-ok">전시우선순위 수정</button>
					<button type="button" onclick="bbsDispPriorRankDelete();" class="btn btn-add">삭제</button>
				</div>
			</div>
			<div class="mModule" style="margin-top:0">
				<table id="bbsLetterDisp" class="grid"></table>
				<div id="bbsLetterDispPage"></div>
			</div>
		</c:if>			
	</t:putAttribute>
</t:insertDefinition>
