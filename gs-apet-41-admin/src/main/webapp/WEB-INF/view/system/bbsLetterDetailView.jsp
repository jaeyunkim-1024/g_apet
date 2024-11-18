<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				//EditorCommon.setSEditor('content', '${adminConstants.BOARD_IMAGE_PATH}');
				// 상품 그리드
				createBbsLetterGoodsGrid();
			});
			// 게시글 등록 & 수정
			function bbsLetterView(lettNo) {
				updateTab('/${board.bbsId}/bbsLetterView.do?lettNo=' + lettNo);
			}

			// 게시글 삭제
			function bbsLetterDelete(){
				messager.confirm("<spring:message code='column.common.confirm.delete' />", function(r){
					if(r){
						var sendData = {
								  bbsId : "${board.bbsId}"
								, lettNo : $("#lettNo").val()
							}
							var options = {
								  url : "<spring:url value='/${board.bbsId}/bbsLetterDelete.do' />"
								, data : sendData
								, callBack : function(result) {
									messager.alert('<spring:message code="column.display_view.message.delete" />', "Info", "info", function(){
										var title = getSeletedTabTitle().replace(' 상세', '');
										closeGoTab(title, '/${board.bbsId}/bbsLetterListView.do');
									});
								}
							};
						
						ajax.call(options);
					}
				})
			}

			// 답글 등록
			function bbsReplyInsert(){
				
				if(validate.check("boardForm")) {
					
					var cont = $("#replyContent").val();
	
					var sendData = {
						  lettNo : '${bbsLetter.lettNo}'
						, content : cont
					}
					if(cont.length <= 0 ) {
						messager.alert('<spring:message code="admin.web.view.msg.bbsLetter.insert.reply" />', "Info", "info");
						return;
					}
	
					 var options = {
						url : "<spring:url value='/${board.bbsId}/bbsReplyInsert.do'/>"
						, data : sendData
						, callBack : function(result){
							updateTab();
						}
					};
					ajax.call(options);
				
				}
			}

			// 파일 업로드
			function bbsFileDownload(filePath, fileName){
				var data = {
					  filePath : filePath
					, fileName : fileName
				}
				createFormSubmit("fileDownload", "/common/fileDownloadResult.do", data);
			}

			// 작성자 답글 삭제
			function bbsReplyDelete(rplNo,sysRegrNo){

				if("${adminSession.usrNo}" == sysRegrNo){  //등록자인 경우
					messager.confirm("<spring:message code='column.common.confirm.delete' />", function(r){
						if(r){
							var sendData = {
									 lettNo : $("#lettNo").val()
									, rplNo : rplNo
								}
								var options = {
									url : "<spring:url value='/${board.bbsId}/bbsReplyDelete.do'/>"
									, data : sendData
									, callBack : function(result){
										messager.alert("<spring:message code='column.display_view.message.delete'/>", "Info", "info", function(){
											updateTab();	
										});
									}
								};
								ajax.call(options);
						}
					})
				}else{
					messager.alert('<spring:message code="admin.web.view.msg.bbsLetter.delete.sysRegrNo" />', "Info", "info");
				}
			}
			
			// 상품 리스트
			function createBbsLetterGoodsGrid(){
				var options = {
						url : "<spring:url value='/system/bbsLetterGoodsListGrid.do' />"
					, height : 200
					, multiselect : true
					, searchParam : {
						lettNo : '${bbsLetter.lettNo}'
					}
					, colModels : [
						{name:"lettNo", hidden:true }
						, {name:"dispPriorRank", hidden:true }
						, {name:"goodsId", label:_GOODS_SEARCH_GRID_LABEL.goodsId, key:true, width:"100", align:"center", sortable:false} /* 상품 번호 */
						, {name:"goodsNm", label:_GOODS_SEARCH_GRID_LABEL.goodsNm, width:"300", align:"center", sortable:false } /* 상품명 */
						/*, {name:"stNms", label:'<spring:message code="column.st_nm" />', width:"120", align:"center"}   사이트 명 */
						, {name:"goodsStatCd", label:_GOODS_SEARCH_GRID_LABEL.goodsStatCd, width:"150", align:"center", sortable:false, formatter:"select", editoptions:{value:_GOODS_STAT_CD } } /* 상품 상태 */
						, {name:"bigo", label:_GOODS_SEARCH_GRID_LABEL.bigo, width:"200", align:"center", sortable:false } /* 비고 */
						, {name:"goodsTpCd", label:_GOODS_SEARCH_GRID_LABEL.goodsTpCd, width:"150", align:"center", sortable:false, formatter:"select", editoptions:{value:_GOODS_TP_CD } } /* 상품 유형 */
						, {name:"mdlNm", label:_GOODS_SEARCH_GRID_LABEL.mdlNm, width:"200", align:"center", sortable:false } /* 모델명 */
						, {name:"saleAmt", label:_GOODS_SEARCH_GRID_LABEL.saleAmt, width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
						, {name:"compNm", label:_GOODS_SEARCH_GRID_LABEL.compNm, width:"120", align:"center", sortable:false } /* 업체명 */
						, {name:"bndNmKo", label:_GOODS_SEARCH_GRID_LABEL.bndNmKo, width:"150", align:"center", sortable:false } /* 브랜드명 */
						, {name:"mmft", label:_GOODS_SEARCH_GRID_LABEL.mmft, width:"150", align:"center", sortable:false } /* 제조사 */
						, {name:"saleStrtDtm", label:_GOODS_SEARCH_GRID_LABEL.saleStrtDtm, width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
						, {name:"saleEndDtm", label:_GOODS_SEARCH_GRID_LABEL.saleEndDtm, width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:_COMMON_DATE_FORMAT }
						, {name:"showYn", label:_GOODS_SEARCH_GRID_LABEL.showYn, width:"100", align:"center", sortable:false, formatter:"select", editoptions:{value:_SHOW_YN } } /* 노출여부 */
					]
					, paging : false
				};
				grid.create("bbsLetterGoodsList", options);
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
			<!-- 코드 넣는곳 -->
			<div class="mTitle">
				<h2> 게시글 상세</h2>
			</div>

			<form name="boardForm" id="boardForm" method="post">
			<input type="hidden" id="lettNo" name="lettNo" value="${bbsLetter.lettNo}"/>
			<table class="table_type1">
				<caption>게시글 상세</caption>
				<tbody>
					<tr>
						<th>작성자</th>
						<td>
							<!-- 작성자-->
							${bbsLetter.sysRegrNm}
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.ttl"/></th>
						<td>
							<!-- 제목-->
							${bbsLetter.ttl}
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.top_fix_yn"/><strong class="red">*</strong></th>
						<td>
							<frame:radio name="topFixYn" grpCd="${adminConstants.TOP_FIX_YN}" selectKey="${bbsLetter.topFixYn == null ? 'N' : bbsLetter.topFixYn}"/>
						</td>
					</tr>
					<%-- <tr>
						<th><spring:message code="column.show_gb_cd"/></th>
						<td>
							<!-- 사이트 구분 코드-->
							<frame:codeName grpCd="${adminConstants.SHOW_GB}" dtlCd="${bbsLetter.showGbCd}"/>
						</td>
					</tr> --%>
					<c:if test="${board.bbsTpCd eq adminConstants.BBS_TP_20}">
					<tr>
						<th><spring:message code="column.rcom_yn"/></th>
						<td>
							<frame:radio name="rcomYn" grpCd="${adminConstants.COMM_YN}" selectKey="${bbsLetter.rcomYn == null ? 'N' : bbsLetter.rcomYn}" disabled="true"/>
						</td>
					</tr>
					</c:if>
					<c:if test="${board.gbUseYn eq adminConstants.USE_YN_Y}">
						<tr>
							<th><spring:message code="column.bbs_gb_no"/></th>
							<td>
								<!-- 게시판 구분 코드 -->
								<c:forEach items="${listBoardGb}" var="listGb">
								<label class="fRadio"><input type="radio" ${bbsLetter.bbsGbNo eq listGb.bbsGbNo ? 'checked="checked"' : ''} disabled="disabled" > <span>${listGb.bbsGbNm}</span></label>
								</c:forEach>
							</td>
						</tr>
					</c:if>
					<!-- 이미지 경로 -->
					<c:if test="${(adminConstants.BBS_TP_30 eq board.bbsTpCd) or (adminConstants.BBS_TP_40 eq board.bbsTpCd) or (adminConstants.BBS_TP_41 eq board.bbsTpCd)}">
						<tr>
							<th><spring:message code="column.img_path"/></th>
							<td>
								<img src="<frame:imgUrl/>${bbsLetter.imgPath}" class="thumb" alt="">
							</td>
						</tr>
					</c:if>
					<c:if test="${board.flUseYn eq adminConstants.USE_YN_Y}">
						<tr>
							<th><spring:message code="column.fl_no"/></th>
							<td>
								<!-- 파일 번호-->
								<c:forEach var="item" items="${listFile}">
									<div class="mg5">
										<input type="text" class="readonly w400" readonly="readonly" name="orgFlNm" title="<spring:message code="column.org_fl_nm"/>" value="${item.orgFlNm}" />
										<button type="button" onclick="bbsFileDownload('${item.phyPath}', '${item.orgFlNm}');" class="btn">파일다운로드</button>
									</div>
								</c:forEach>
							</td>
						</tr>
					</c:if>
					<tr>
						<th><spring:message code="column.content"/></th>
						<td>
							<!-- 내용-->
							<%-- <textarea style="width: 100%; height: 300px;" name="content" id="content" title="<spring:message code="column.content"/>" disabled>${bbsLetter.content}</textarea> --%>
							<div class="editor_view"><pre>${bbsLetter.content}</pre></div>
						</td>
					</tr>
					
					
					<tr>
						<th><spring:message code="column.usr_dfn_1"/></th>
						<td>
							${bbsLetter.usrDfn1Val }
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.usr_dfn_2"/></th>
						<td>
							${bbsLetter.usrDfn2Val }
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.usr_dfn_3"/></th>
						<td>
							${bbsLetter.usrDfn3Val }
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.usr_dfn_4"/></th>
						<td>
							${bbsLetter.usrDfn4Val }
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.usr_dfn_5"/></th>
						<td>
							${bbsLetter.usrDfn5Val }
						</td>
					</tr>
					
				</tbody>
			</table>				
			<c:if test="${board.gbUseYn eq adminConstants.USE_YN_Y}">
			<div id="goodsView" ${adminConstants.USE_YN_Y eq board.goodsUseYn ? '' : 'style="display: none;"'} class="mt30">
				<div class="mTitle">
					<h2>적용 상품</h2>
				</div>
	
				<div class="mModule" style="margin-top:0">
					<table id="bbsLetterGoodsList"></table>
				</div>
			</div>
			</c:if>
			<br />
			
			<div class="mTitle">
				<h2>답글</h2>
			</div>
			<table class="table_type1">
				<tbody>
					<tr>
						<th>답글</th>
						<td>
							<table class="table_sub">
								<caption>게시판 목록</caption>
								<colgroup>
									<col style="width:100px;">
									<col />
									<col style="width:200px;">
									<col style="width:100px;">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">등록자</th>
										<th scope="col">내용</th>
										<th scope="col">등록일</th>
										<th scope="col">삭제</th>
									</tr>
								</thead>
								<tbody>
								<!-- 답글 리스트 -->
									<c:forEach items="${listBoardReply}" var="listReply">
										<input type="hidden" id="rplNo" name="rplNo" value="${listReply.rplNo}"/>
										<tr>
											<td>${listReply.sysRegrNm}</td>
											<td class="alignLeft">${listReply.content}</td>
											<td style="text-align:center">${listReply.sysRegDtm}</td>
											<td style="text-align:center">
												<c:if test="${listReply.sysRegrNo eq adminSession.usrNo}">
													<button type="button" onclick="bbsReplyDelete('${listReply.rplNo}','${listReply.sysRegrNo}');" class="btn">삭제</button>
												</c:if>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							
							<table class="no_border mt30">
								<colgroup>
									<col />
									<col width="120px">
								</colgroup>
								<tbody>
									<tr>
										<td><textarea class="validate[required, maxSize[2000]]" style="height:50px;width:100%" id="replyContent" name="replyContent"></textarea></td>
										<td style="text-align:right"><button type="button" style="height:50px;" onclick="bbsReplyInsert();" class="btn btn-ok">답글</button></td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
				</tbody>
			</table>
			</form>

			<div class="btn_area_center">
				<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}">
				<button type="button" onclick="bbsLetterView('${bbsLetter.lettNo}');" class="btn btn-ok">수정</button>
				<button type="button" onclick="bbsLetterDelete();" class="btn btn-add">삭제</button>
				</c:if>
				<button type="button" onclick="closeTab();" class="btn btn-cancel">닫기</button>
			</div>
	</t:putAttribute>
</t:insertDefinition>
