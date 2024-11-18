<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				if("${adminSession.usrGrpCd}" == "${adminConstants.USR_GRP_10}"){
					$("[name=replyContent]").addClass("validate[required, maxSize[2000]]");
				}else{
					$("[name=replyContent]").addClass("readonly");
					$("[name=replyContent]").prop("readonly" , true)
					$("#replyBtn").prop("disabled" , true)
				}
				
				EditorCommon.setSEditor('content', '${adminConstants.BOARD_IMAGE_PATH}');
				
				$(document).on("click" , "#comfaqInsertBtn" , function(){
					if("${board.bbsId}"){
						bbsLetterUpdate();
					}else{
						bbsLetterInsert();
					}
				})
				
				//fncInactiveWill();
			});

			//게시판 글 등록
			function bbsLetterInsert(){
				if(validate.check("boardForm")) {
					oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
					
					// 내용 체크
					if( !editorRequired( 'content' ) ){ return false };
					
					messager.confirm('<spring:message code="column.common.confirm.insert" />', function(r){
						if(r){
							var options = {
								url : "<spring:url value='/COMPFAQ/bbsLetterInsert.do' />"
								, data : $("#boardForm").serializeJson()
								, callBack : function(result){
									messager.alert('<spring:message code="admin.web.view.common.normal_process.final_msg" />', "Info", "info", function(){
										var title = getSeletedTabTitle().replace(' 등록', '');
										updateTab('/COMPFAQ/bbsLetterListView.do', title);	
									});
								}
							};
							ajax.call(options);
						}
					})
				}
			}

			//게시판 글 업데이트
			function bbsLetterUpdate(){
				if( validate.check("boardForm")) {
					oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
					// 내용 체크
					if( !editorRequired( 'content' ) ){ return false };
					
					messager.confirm('<spring:message code="column.common.confirm.update" />', function(r){
						if(r){
							var options = {
								url : "<spring:url value='/COMPFAQ/bbsLetterUpdate.do' />"
								, data : $("#boardForm").serializeJson()
								, callBack : function(result){
									messager.alert('<spring:message code="admin.web.view.common.normal_process.final_msg" />', "Info", "info", function(){
										var title = getSeletedTabTitle().replace(' 상세', '');
										updateTab('/COMPFAQ/bbsLetterListView.do', title);	
									});
								}
							};
							ajax.call(options);
						}
					})
				}
			}
			
			//게시판 글 삭제
			function bbsLetterDelete(){
				var lettNos = new Array();
				
				messager.confirm("<spring:message code='column.common.confirm.delete' />", function(r){
					if(r){
						lettNos.push({lettNo : '${bbsLetter.lettNo}'});
						var options = {
								url : "<spring:url value='/${board.bbsId}/bbsLetterArrDelete.do' />"
								, data : {
									deleteLettNoStr : JSON.stringify(lettNos)
								}
								, callBack : function(result) {
									messager.alert("<spring:message code='column.display_view.message.delete' />", "Info", "info", function(){
										var title = getSeletedTabTitle().replace(' 상세', '');
										updateTab('/appweb/NoticeListView.do', title);
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
			
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
			<form name="boardForm" id="boardForm" method="post">
			<table class="table_type1">
				<caption>게시판 글</caption>
				<tbody>
					<tr>
						<input type="hidden" name="lettNo" id="lettNo" value="${bbsLetter.lettNo}">
						<th>글 <spring:message code ="column.no"/></th>
						<td><c:out value ="${bbsLetter.lettNo }" /></td>
					</tr>
					<tr>
						<th><spring:message code="column.terms_writer" /></th>
						<td>
							<c:out value = "${adminSession.usrNm }" />
						</td>
					</tr>
					<tr> 
						<th><spring:message code="column.ttl"/><strong class="red">*</strong></th>
						<td>
							<!-- 제목-->
							<input type="text" class="w800 validate[required,maxSize[100]] <c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd }">readonly</c:if>" placeholder="100자 이내 입력" name="ttl" id="ttl" title="<spring:message code="column.ttl"/>" value="${bbsLetter.ttl}" <c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd }">readonly</c:if>/>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.content"/><strong class="red">*</strong></th>
						<td>
						<div disabled >
							<!-- 내용-->
							<c:if test ="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd  }">
								<div class="readonly editor_view"><pre>${bbsLetter.content}</pre></div>
							</c:if>
							<c:if test ="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd }">
								<textarea style="width: 100%; height: 300px;" class="w400" name="content" id="content" placeholder="2000자 이내로 입력하세요." title="<spring:message code="column.content"/>">${bbsLetter.content}</textarea>
							</c:if>
						</div>
						</td>
					</tr>
				</tbody>
			</table>
			
			<c:if test = "${bbsLetter.bbsId ne null }">
			<div class="mTitle" style ="margin-top:30px;">
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
										<td><textarea style="height:50px;width:100%" id="replyContent" name="replyContent"></textarea></td>
										<td style="text-align:right"><button type="button" style="height:50px;" id ="replyBtn" onclick="bbsReplyInsert();" class="btn btn-ok">저장</button></td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
				</tbody>
			</table>
			</c:if>
			</form>

			<div class="btn_area_center">
				<c:if test ="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd }">
				<button type="button" id ="comfaqInsertBtn" class="btn btn-ok">등록</button>
				</c:if>
				<button type="button" onclick="closeTab();" class="btn btn-cancel">취소</button>
			</div>
	</t:putAttribute>
</t:insertDefinition>
<style>
#linkInput{
	width : 70%;
	margin-left : 10px
}
</style>
