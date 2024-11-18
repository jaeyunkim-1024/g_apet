<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				noticeListGrid();
	            $(document).on("keydown","#noticeSearchForm input",function(){
	      			if ( window.event.keyCode == 13 ) {
	      				reloadNoticeListGrid();
	    		  	}
	            });				
			});

			function noticeListGrid(){
				var options = {
					url : "<spring:url value='/company/noticeListGrid.do' />"
					, height : 400
					, colModels : [
						//업체 번호
						{name:"compNo", label:'<spring:message code="column.comp_no" />', width:"70", align:"center", hidden:true}
						
						//업체 공지 번호
                        , {name:"compNtcNo", label:'<b><u><tt><spring:message code="column.comp_ntc_no" /></tt></u></b>', width:"80", align:"center", classes:'pointer fontbold'}

						//내용
						, {name:"content", label:'<spring:message code="column.content" />', width:"500", align:"center"}
						
	                    //발신 업체 명
                        , {name:"wrCompNm", label:'발신 <spring:message code="column.comp_nm" />', width:"120", align:"center"}

	                    //수신 업체 명
                        , {name:"compNm", label:'수신 <spring:message code="column.comp_nm" />', width:"120", align:"center"}
	                      
						, {name:'dispYn', label:'<spring:message code="column.disp_yn" />', width:'90', align:'center', formatter:'select', editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.DISP_YN}' showValue='false'/>"}}
						
						//공지 시작 일시
						, {name:"ntcStrtDtm", label:'<spring:message code="column.ntc_strt_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}

						//공지 종료 일시
						, {name:"ntcEndDtm", label:'<spring:message code="column.ntc_end_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}

						, _GRID_COLUMNS.sysRegrNm
						, _GRID_COLUMNS.sysRegDtm
						, _GRID_COLUMNS.sysUpdrNm
						, _GRID_COLUMNS.sysUpdDtm
					]
					, searchParam : $("#noticeSearchForm").serializeJson()
					, multiselect : ${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? true : false}
					, onCellSelect : function (ids, cellidx, cellvalue) {
						if(cellidx != 0) {
							var rowdata = $("#noticeList").getRowData(ids);
							noticeView(rowdata.compNtcNo);
						}
					}
				};
				grid.create("noticeList", options);
			}

			function reloadNoticeListGrid() {
				var options = {
					searchParam : $("#noticeSearchForm").serializeJson()
				};
				grid.reload("noticeList", options);
			}


			function noticeView(compNtcNo) {
				if (compNtcNo == '')
					addTab('업체 공지사항 등록', '/company/noticeView.do');
				else
					addTab('업체 공지사항 상세', '/company/noticeView.do?compNtcNo=' + compNtcNo);
			}

			function noticeDelete(){
				var grid = $("#noticeList");
				var arrCompNtcNo = new Array();
				var rowids = grid.jqGrid('getGridParam', 'selarrrow');

				if(rowids != null && rowids.length <= 0 ) {
					messager.alert("<spring:message code='column.common.delete.no_select' />", "Info", "info");
					return;
				}

				messager.confirm('<spring:message code="column.common.confirm.delete" />', function(r){
	                if (r){
	                	for(var i in rowids) {
							var data = grid.getRowData(rowids[i]);
							arrCompNtcNo.push(data.compNtcNo);
						}

						var options = {
							url : "<spring:url value='/company/noticeListDelete.do' />"
							, data : {
								arrCompNtcNo : arrCompNtcNo
							}
							, callBack : function(result) {
								messager.alert("<spring:message code='column.common.delete.final_msg' arguments='" + rowids.length + "' />", "Info", "info", function(){
									reloadNoticeListGrid();
								});
							}
						};
						ajax.call(options);
	                }
            	});
			}

			function searchCompany() {
				var options = {
					multiselect : false
					, callBack : function(result) {
						if(result.length > 0) {
							$("#compNo").val(result[0].compNo);
							$("#compNm").val(result[0].compNm);
						}
					}
<c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
                    , showLowerCompany : 'Y'
</c:if>				
				}

				layerCompanyList.create(options);
			}
			
            // 하위 업체 검색
            function searchLowCompany () {
                var options = {
                    multiselect : false
                    , callBack : searchLowCompanyCallback
<c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
                    , showLowerCompany : 'Y'
</c:if>
                }
                layerCompanyList.create (options );
            }
            // 업체 검색 콜백
            function searchLowCompanyCallback(compList) {
                if(compList.length > 0) {
                    $("#noticeSearchForm #lowCompNo").val (compList[0].compNo);
                    $("#noticeSearchForm #lowCompNm").val (compList[0].compNm);
                }
            }	
            
            $(document).on("click", "input:checkbox[name=showAllLowComp]", function(e){
                if ($(this).is(":checked") == true) {
                    $("#showAllLowCompany").val("Y");   
                } else {
                    $("#showAllLowCompany").val("N");
                }
            });             
            
            // 초기화 버튼클릭
            function searchReset () {
                resetForm ("noticeSearchForm");
                <c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
                $("#noticeSearchForm #compNo").val('${adminSession.compNo}');
                $("#noticeSearchForm #showAllLowCompany").val("N");
                </c:if>
            }            
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form name="noticeSearchForm" id="noticeSearchForm" method="post">
				<table class="table_type1">
					<caption>게시판 글 목록</caption>
					<tbody>
						<tr>
							<th scope="row">수신 <spring:message code="column.comp_nm" /></th>
							<td>
							  <frame:compNo funcNm="searchCompany" disableSearchYn="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? 'N' : 'Y'}" placeholder="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? '입점업체를 검색하세요' : ''}"/>
							  <%--
	<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}">
								<frame:compNo funcNm="searchCompany" disableSearchYn="N" placeholder="입점업체를 검색하세요"/>
	</c:if>
	 --%>
	<c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
	                            &nbsp;<frame:lowCompNo funcNm="searchLowCompany" placeholder="하위업체를 검색하세요"/>
	                            &nbsp;<input type="checkbox" id="showAllLowComp" name="showAllLowComp"><span>하위업체 전체 선택</span>
	                            <input type="hidden" id="showAllLowCompany" name="showAllLowCompany" value="N"/>
	</c:if>
							</td>
							<!-- 전시여부 -->
							<th scope="row"><spring:message code="column.disp_yn" /></th>
							<td>
								<select id="dispYn" name="dispYn" >
									<frame:select grpCd="${adminConstants.DISP_YN}" defaultName="선택" />
								</select>
							</td>
						</tr>
					</tbody>
				</table>
				</form>
	
				<div class="btn_area_center">
					<button type="button" onclick="reloadNoticeListGrid();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>	
		

		<div class="mModule">
			<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}">				
				<button type="button" onclick="noticeView('');" class="btn btn-add">공지사항 등록</button>
				<button type="button" onclick="noticeDelete();" class="btn btn-add">삭제</button>
			</c:if>	

			<table id="noticeList" ></table>
			<div id="noticeListPage"></div>
		</div>

	</t:putAttribute>
</t:insertDefinition>
