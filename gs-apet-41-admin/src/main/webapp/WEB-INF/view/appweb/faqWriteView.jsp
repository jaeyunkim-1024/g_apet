<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				EditorCommon.setSEditor('content', '${adminConstants.BOARD_IMAGE_PATH}');
				
				if("${bbsLetter.bbsId}" == ''){
					$("input:radio[name=bbsGbNo]").eq(0).attr("checked",true);
				}
				
			});

			//게시판 글 등록
			function bbsLetterInsert(){
				oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
				if(!fncValidCheck() ) return false;
				if(validate.check("boardForm")) {
					
					// 내용 체크
					//if( !editorRequired( 'content' ) ){ return false };
					
					messager.confirm('<spring:message code="column.common.confirm.insert" />', function(r){
						if(r){
							var options = {
								url : "<spring:url value='/${board.bbsId}/bbsLetterInsert.do' />"
								, data : $("#boardForm").serializeJson()
								, callBack : function(result){
									messager.alert('<spring:message code="admin.web.view.common.normal_process.final_msg" />', "Info", "info", function(){
										var title = getSeletedTabTitle().replace(' 등록', '');
										updateTab('/appweb/faqListView.do', title);	
									});
								}
							};
							ajax.call(options);
						}
					})
				}
			}

			function bbsLetterUpdate(){
				oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
				if(!fncValidCheck() ) return false;
				if(validate.check("boardForm")) {
					// 내용 체크
					if( !editorRequired( 'content' ) ){ return false };
					
					messager.confirm('<spring:message code="column.common.confirm.update" />', function(r){
						if(r){
							var options = {
								url : "<spring:url value='/${board.bbsId}/bbsLetterUpdate.do' />"
								, data : $("#boardForm").serializeJson()
								, callBack : function(result){
									messager.alert('<spring:message code="admin.web.view.common.normal_process.final_msg" />', "Info", "info", function(){
										var title = getSeletedTabTitle().replace(' 상세', '');
										updateTab('/appweb/faqListView.do', title);	
									});
								}
							};
							ajax.call(options);
						}
					})
				}
			}
			
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
										updateTab('/appweb/faqListView.do', title);
									});
								}
						};
						ajax.call(options);
					}
				})
			}

			
			function initialization(){
				resetForm ("boardForm");
				oEditors.getById["content"].exec("SET_IR", [""]);
			}
			
			//validate
			function fncValidCheck(){
				
				if($("#ttl").val() == ""){
					messager.alert('제목을 입력해 주세요. ', "Info", "info");
					return false;
				}
				
				if($("#content").val() == "" || $("#content").val() == "<p>&nbsp;</p>"){
					messager.alert('내용을 입력해 주세요. ', "Info", "info");
					return false;
				}
				
				var strContent = $("#content").val().replace(/<img /gi, "img ").replace(/(<([^>]+)>)/gi, "").replace(/&nbsp;/gi, "").replaceAll(" ","").trim();
				if(strContent.length > 2000){
					messager.alert("최대 2000이하로 작성해 주세요.","Info","info");
					return false;
				}
				
				return true;
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
			<form name="boardForm" id="boardForm" method="post">
			<input type="hidden" name="lettNo" value="${bbsLetter.lettNo}">
			<table class="table_type1">
				<caption>게시판 글</caption>
				<tbody>
					<tr>
						<th><spring:message code="column.faq.faq_no"/><strong class="red">*</strong></th>
						<td colspan="3" >
							<!-- 게시판 번호-->
							<p name="lettNo" id="lettNo">${bbsLetter.lettNo}</p>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.faq.gb"/></th>
						<td colspan="3">
							<!-- 게시판 구분 코드-->
							<c:forEach items="${listBoardGb}" var="item">
								<c:if test="${item.bbsGbNm ne '전체' }">
								<label class="fRadio"><input type="radio" class="validate[required]" name="bbsGbNo" value="${item.bbsGbNo}" ${item.bbsGbNo eq bbsLetter.bbsGbNo ? 'checked="checked"' : item.bbsGbNo eq 1 ? 'checked="checked"':'' }> <span>${item.bbsGbNm }</span></label>
								</c:if>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.ttl"/><strong class="red">*</strong></th>
						<td colspan="3" >
							<!-- 제목-->
							<input type="text" class="w400 validate[maxSize[100]]" name="ttl" id="ttl" title="<spring:message code="column.ttl"/>" value="${bbsLetter.ttl}" />
						</td>
					</tr>
					
				<%-- <c:if test="${(adminConstants.BBS_TP_30 eq board.bbsTpCd) or (adminConstants.BBS_TP_40 eq board.bbsTpCd) or (adminConstants.BBS_TP_41 eq board.bbsTpCd)}">
					<tr>
						<!-- 이미지 경로 -->
						<th><spring:message code="column.img_path"/><strong class="red">*</strong></th>
						<td colspan="3">
							<div class="inner">
								<c:if test="${empty bbsLetter.imgPath}">
								<img id="imgPathView" name="imgPathView" src="/images/noimage.png" class="thumb" alt="">
								</c:if>
								<c:if test="${not empty bbsLetter.imgPath}">
									<img id="imgPathView" name="imgPathView" src="<frame:imgUrl/>${bbsLetter.imgPath}" class="thumb" alt="">
								</c:if>
							</div>
							<div class="inner ml10" style="vertical-align:bottom">
								<button type="button" onclick="fileUpload.image(resultBbsImage);" class="btn"><spring:message code="column.common.addition" /></button> <!-- 추가 -->
								<button type="button" onclick="deleteImage();" class="btn"><spring:message code="column.common.delete" /></button> <!-- 삭제 -->
							</div>
							<input class="validate[required]" type="text" name="imgPath" id="imgPath" title="<spring:message code="column.img_path"/>" value="${bbsLetter.imgPath}" style="visibility: hidden" />
						</td>
					</tr>
				</c:if>
				<!-- 게시판 글 이미지-->
				<c:if test="${board.flUseYn eq adminConstants.USE_YN_Y}">
					<tr>
						<th><spring:message code="column.fl_no"/></th>
						<td colspan="3">
							<c:forEach var="item" items="${listFile }" varStatus="idx">
								<div class="mg5 bbsFileView" id="bbsFileView${idx.index}">
									<input type="hidden" name="seq" title="<spring:message code="column.seq"/>" value="${item.seq}">
									<input type="hidden" name="phyPath" title="<spring:message code="column.phy_path"/>" value="${item.phyPath}">
									<input type="hidden" name="flSz" title="<spring:message code="column.fl_sz"/>" value="${item.flSz}">
									<input type="text" class="readonly w400" readonly="readonly" name="orgFlNm" title="<spring:message code="column.org_fl_nm"/>" value="${item.orgFlNm}" />
									<button type="button" name="bbsFileUpladBtn" style="display: none;" onclick="bbsFileUpload('${idx.index}');" class="btn">파일찾기</button>
									<button type="button" name="bbsFileDelBtn" onclick="bbsFileDel('${idx.index}');" class="btn">삭제</button>
								</div>
							</c:forEach>
							<c:forEach var="item" begin="${fn:length(listFile)}" end="${board.atchFlCnt - 1}">
							<div class="mg5 bbsFileView" id="bbsFileView${item}">
								<input type="hidden" name="seq" title="<spring:message code="column.seq"/>" value="">
								<input type="hidden" name="phyPath" title="<spring:message code="column.phy_path"/>" value="">
								<input type="hidden" name="flSz" title="<spring:message code="column.fl_sz"/>" value="">
								<input type="text" class="readonly w400" readonly="readonly" name="orgFlNm" title="<spring:message code="column.org_fl_nm"/>" value="" />
								<button type="button" name="bbsFileUpladBtn" onclick="bbsFileUpload('${item}');" class="btn">파일찾기</button>
								<button type="button" name="bbsFileDelBtn" style="display: none;" onclick="bbsFileDel('${item}');" class="btn">삭제</button>
							</div>
							</c:forEach>
						</td>
					</tr>
				</c:if> --%>
					<tr>
						<th><spring:message code="column.content"/><strong class="red">*</strong></th>
						<td colspan="3" >
						<div disabled >
							<!-- 내용-->
							<textarea style="width: 100%; height: 300px;" name="content" id="content" title="<spring:message code="column.content"/>">${bbsLetter.content}</textarea>
						</div>
						</td>
					</tr>
					<tr>
						<th>비고</th>
						<td colspan="3">
							<!-- 사용자 정의 1-->
							<input type="text" class="w400 validate[maxSize[200]]" name="usrDfn1Val" id="usrDfn1Val" title="비고" value="${bbsLetter.usrDfn1Val }" />
						</td>
					</tr>
					<%-- <tr>
						<th><spring:message code="column.usr_dfn_2"/></th>
						<td colspan="3">
							<!-- 사용자 정의 2-->
							<input type="text" class="w400 validate[maxSize[200]]" name="usrDfn2Val" id="usrDfn2Val" title="<spring:message code="column.usr_dfn_2" />" value="${bbsLetter.usrDfn2Val }" />
						</td>
					</tr> --%>
					<%-- <tr>
						<th><spring:message code="column.usr_dfn_3"/></th>
						<td colspan="3">
							<!-- 사용자 정의 3-->
							<input type="text" class="w400 validate[maxSize[200]]" name="usrDfn3Val" id="usrDfn3Val" title="<spring:message code="column.usr_dfn_3" />" value="${bbsLetter.usrDfn3Val }" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.usr_dfn_4"/></th>
						<td colspan="3">
							<!-- 사용자 정의 4-->
							<input type="text" class="w400 validate[maxSize[200]]" name="usrDfn4Val" id="usrDfn4Val" title="<spring:message code="column.usr_dfn_4" />" value="${bbsLetter.usrDfn4Val }" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.usr_dfn_5"/></th>
						<td colspan="3">
							<!-- 사용자 정의 5-->
							<input type="text" class="w400 validate[maxSize[200]]" name="usrDfn5Val" id="usrDfn5Val" title="<spring:message code="column.usr_dfn_5" />" value="${bbsLetter.usrDfn5Val }" />
						</td>
					</tr> --%>
					<tr>
						<th><spring:message code="column.faq.reg_info"/></th>
						<td colspan="3">
							<!-- 등록정보-->
							<c:if test="${bbsLetter.bbsId == null}">
								<p>${session.usrNm} (${session.usrNo})</p>
							</c:if>
							<c:if test="${bbsLetter.bbsId != null}">
								<c:if test="${hist != null }">
								<p>${hist.sysRegrNm}(${hist.sysRegrNo}) ${hist.sysRegDtm} 등록</p>
								</c:if>
							</c:if>
						</td>
					</tr>
				</tbody>
			</table>
			</form>

			<div class="btn_area_center">
			<c:if test="${bbsLetter.bbsId == null}">
				<button type="button" onclick="bbsLetterInsert();" class="btn btn-ok">등록</button>
				<button type="button" onclick="initialization();" class="btn btn-cancel">초기화</button>
				<button type="button" onclick="closeTab();" class="btn btn-cancel">취소</button>
			</c:if>
			<c:if test="${bbsLetter.bbsId != null}">
				<button type="button" onclick="bbsLetterUpdate();" class="btn btn-ok">저장</button>
				<button type="button" onclick="bbsLetterDelete();" class="btn btn-cancel">삭제</button>
				<button type="button" onclick="closeTab();" class="btn btn-cancel">닫기</button>
			</c:if>
				
			</div>
	</t:putAttribute>
</t:insertDefinition>
