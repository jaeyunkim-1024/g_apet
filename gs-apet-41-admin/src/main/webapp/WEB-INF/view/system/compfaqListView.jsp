<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				// 게시판 글 그리드
				bbsLetterGrid();
			});

			// 게시판 글 리스트
			function bbsLetterGrid(){
				var options = {
					url : "<spring:url value='/${board.bbsId}/bbsLetterListGrid.do' />"
					, height : 400
					, colModels : [
						// 글 번호
						{name:"lettNo", label:'<spring:message code="column.lett_no" /></tt></u></b>', width:"100", align:"center", sortable:false, formatter:'integer'}
						// 제목
						, {name:"ttl", label:'<b><u><tt><spring:message code="column.ttl" /></tt></u></b>', width:"500", align:"left", classes:'pointer fontbold'}
						// 댓글수
						, {name:"bbsReplyCnt", label:'답글 수', width:"80", align:"center", sortable:false, formatter:'integer'}
						// 시스템 등록자
						, {name:"sysRegrNo", label:'<spring:message code="column.sys_regr_no" />', width:"100", align:"center"}
						// 시스템 등록자
						, {name:"sysRegrNm", label:'<spring:message code="column.sys_regr_nm" />', width:"100", align:"center"}
						// 시스템 등록 일시
						, {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						// 시스템 수정자
						, {name:"sysUpdrNm", label:'<spring:message code="column.sys_regr_nm" />', width:"100", align:"center"}
						// 시스템 수정 일시
						, {name:"sysUpdDtm", label:'<spring:message code="column.sys_reg_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						, {name:"bbsId", hidden:true }  
					]
					, multiselect : true
					, cellEdit : true
					, onCellSelect : function (ids, cellidx, cellvalue) {
						if(cellidx != 0) { // CODE 선택
							var rowdata = $("#bbsLetter").getRowData(ids);
							bbsLetterDetailView(rowdata.lettNo);
						}
					}, gridComplete : function() {

						$("#noData").remove();
						var grid = $("#bbsLetter").jqGrid('getRowData');
						if(grid.length <= 0) {
							var str = "";
							str += "<tr id='noData' role='row' class='jqgrow ui-row-ltr ui-widget-content'>";
							str += "	<td role='gridcell' colspan='9' style='text-align:center;'>조회결과가 없습니다.</td>";
							str += "</tr>"
								
							$("#bbsLetter.ui-jqgrid-btable").append(str);
						}
					}
				};
				grid.create("bbsLetter", options);
			}

			// 게시판 등록
			function bbsLetterView(bbsId) {
				var title = getSeletedTabTitle();
				addTab(title + ' 등록', '/COMPFAQ/compfaqView.do');
			}

			// 게시판 상세보기
			function bbsLetterDetailView(lettNo) {
				var title = getSeletedTabTitle();
				addTab(title + ' 상세', '/COMPFAQ/bbsLetterDetailView.do?lettNo=' + lettNo);
			}
			
		     // 게시글 검색 조회
	        function searchBBSLetterList() {
		    	 
		    	var starr = $("#searchDtmStart").val().split("-");
		    	var endarr = $("#searchDtmEnd").val().split("-");
		    	var stdate = new Date(starr[0], starr[1], starr[2] );
		    	var enddate = new Date(endarr[0], endarr[1], endarr[2] );
		    	var diff = enddate - stdate;
		    	var diffDays = parseInt(diff/(24*60*60*1000));
		    	if(diffDays > 90){
		    		messager.alert("기간 선택범위를 3개월로 선택해 주세요", "Info", "info" );
		    		return;
		    	}else if(diffDays<0){
		    		messager.alert("종료일이 시작일보다 크게 선택해 주세요", "Info", "info" );
		    		return;
		    	}
		    	
	            var options = {
	                searchParam : $("#bbsLetterListForm").serializeJson()
	            }
	            
	            console.log(options);
	            grid.reload("bbsLetter", options);
	        }

	        // 초기화 버튼클릭
	        function searchReset () {
	            resetForm ("bbsLetterListForm");
	            
	            var data = fncSerializeFormData();
	            data.searchDtmStart = "";
	            data.searchDtmEnd = "";
	            data.bbsStatCd = null;
	            grid.reload("bbsLetter", {searchParam : data});
	        }
	        
	    	// 업데이트일 변경
			function fncSrchDateChange() {
				var term = $("#checkOptDate").children("option:selected").val();
				if(term == "") {
					$("#searchDtmStart").val("");
					$("#searchDtmEnd").val("");
				} else {
					setSearchDate(term, "searchDtmStart", "searchDtmEnd");
				}
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
	    	
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">

			<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
				<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
					<form id="bbsLetterListForm" name="bbsLetterListForm" method="post" >
						<table class="table_type1">
							<caption>게시판 글 목록</caption>
							<tbody>
								<tr>
									<th scope="row"><spring:message code="column.ttl" /></th>
									<td>
										<input class="w300" type="text" name="ttl" id ="ttl">
									</td>
									<th scope="row"><spring:message code="column.sys_regr_nm" /></th>
									<td>
										<input class="w200" type="text" name="sysRegrNm" id="sysRegrNm">									
									</td>
								</tr>
								<tr>
									<th scope="row"><spring:message code="column.faq.regist_date" /></th> <!-- 업데이트 일 -->
									<td colspan="3">
										<frame:datepicker startDate="searchDtmStart" startValue="${frame:toDate('yyyy-MM-dd')}" endDate="searchDtmEnd" endValue="${frame:toDate('yyyy-MM-dd')}" />
										&nbsp;
										<select id="checkOptDate" name="checkOptDate" onchange="fncSrchDateChange();">
											<frame:select grpCd="${adminConstants.SELECT_PERIOD }"  defaultName="기간선택" excludeOption="${adminConstants.SELECT_PERIOD_30 }"/>
										</select>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
				    <div class="btn_area_center">
			           <button type="button" onclick="searchBBSLetterList();" class="btn btn-ok">검색</button>
			           <button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
			        </div>
				</div>
			</div>

			<div class="mModule">
				<c:if test ="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd }">
					<button type="button" onclick="bbsLetterView('');" class="btn btn-add">글 등록</button>
					<button type="button" onclick="boardDelete();" class="btn btn-add">글 삭제</button>
				</c:if>
				<table id="bbsLetter" class="grid"></table>
				<div id="bbsLetterPage"></div>
			</div>
</t:putAttribute>
</t:insertDefinition>
<style>
.ui-jqgrid tr.jqgrow td { text-overflow: ellipsis; -o-text-overflow: ellipsis; white-space: nowrap; }
</style>
