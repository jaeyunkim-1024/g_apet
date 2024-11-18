<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				EditorCommon.setSEditor('content', '${adminConstants.NOTICE_IMAGE_PATH}');
			});

			function noticeInsert(){
				if(validate.check("noticeForm")) {
					oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
					if( !editorRequired( 'content' ) ){ return false };
					
					messager.confirm('<spring:message code="column.common.confirm.insert" />', function(r){
		                if (r){
		                	var options = {
								url : "<spring:url value='/company/noticeInsert.do' />"
								, data : $("#noticeForm").serializeJson()
								, callBack : function(result){
									messager.alert("<spring:message code='admin.web.view.common.normal_process.final_msg' />", "Info", "info", function(){
										updateTab('/company/noticeView.do?compNtcNo=' + result.notice.compNtcNo, '업체 공지사항 상세');
									});
									
								}
							};
							ajax.call(options);
		                }
					});
				}
			}

			function noticeUpdate(){
				if(validate.check("noticeForm")) {
					oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
					if( !editorRequired( 'content' ) ){ return false };
					messager.confirm('<spring:message code="column.common.confirm.update" />', function(r){
		                if (r){
		                	var options = {
								url : "<spring:url value='/company/noticeUpdate.do' />"
								, data : $("#noticeForm").serializeJson()
								, callBack : function(result){
									messager.alert("<spring:message code='admin.web.view.common.normal_process.final_msg' />", "Info", "info", function(){
										updateTab();
									});
								}
							};
							ajax.call(options);
		                }
					});
				}
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
			
            function searchReset () {
		        //resetForm ("noticeForm" );
		        //$("#compNtcNo").val('${notice.compNtcNo}');
		        <c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}" >
		        	$("#compNo").val(${empty notice ? 0 : notice.compNo });
		        	$("#compNm").val("${empty notice ? '전체 업체' : notice.compNo eq 0 ? '전체 업체' : notice.compNm}");
		        </c:if>
                <c:if test="${adminConstants.USR_GRP_20 eq adminSession.usrGrpCd}" >                
                $("#compNo").val(${empty notice ? '' : notice.compNo });
                </c:if>		        
		    }
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
			<form name="noticeForm" id="noticeForm" method="post">
			<table class="table_type1">
				<caption>게시판 글</caption>
				<tbody>
					<tr>
						<th><spring:message code="column.comp_ntc_no"/><strong class="red">*</strong></th>
						<td>
							<input type="hidden" name="compNtcNo" value="${notice.compNtcNo}">
							<c:if test="${not empty notice}">
							${notice.compNtcNo }
							</c:if>
							<c:if test="${empty notice}">
							<b>자동입력</b>
							</c:if>
						</td>
					</tr>
					<c:if test="${not empty notice}">
					<tr>
                        <th>발신 <spring:message code="column.comp_nm"/><strong class="red">*</strong></th>
                        <td>
                            ${notice.wrCompNm }
                        </td>
                    </tr>
                    </c:if>
					<tr>
						<th>수신 <spring:message code="column.comp_nm"/><strong class="red">*</strong></th>
						<td>
<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}" >						
							<frame:compNo funcNm="searchCompany" requireYn="Y" defaultCompNo="${empty notice ? 0 : notice.compNo }" defaultCompNm="${empty notice ? '전체 업체' : notice.compNo eq 0 ? '전체 업체' : notice.compNm }" disableSearchYn="${empty notice ? 'N' : 'Y' }"/>
							&nbsp;
							<c:if test="${empty notice}">
								<button type="button" class="btn" onclick="searchReset();">초기화</button>
							</c:if>
							<span class="blue-desc">* 수신 업체명이 "전체 업체"일 때 모든 계약/하위 업체에게 공지사항이 전달됩니다.</span>
</c:if>
<c:if test="${adminConstants.USR_GRP_20 eq adminSession.usrGrpCd}" >                        
                            <frame:compNo funcNm="searchCompany" requireYn="Y" defaultCompNo="${empty notice ? '' : notice.compNo }" defaultCompNm="${empty notice ? '' : notice.compNm }" placeholder="${empty notice ? '업체를 선택하세요' : ''}" forceDefaultValue="true" disableSearchYn="${empty notice ? 'N' : 'Y' }"/>
</c:if>
						</td>
					</tr>
					<tr>
						<th>공지 기간 <strong class="red">*</strong></th>
						<td>
							<frame:datepicker startDate="ntcStrtDtm"
												  startValue="${empty notice.ntcStrtDtm ? frame:toDate('yyyy-MM-dd') : notice.ntcStrtDtm}"
												  endDate="ntcEndDtm"
												  endValue="${empty notice.ntcEndDtm ? frame:addMonth('yyyy-MM-dd', 1) : notice.ntcEndDtm}"
												  />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.disp_yn"/><strong class="red">*</strong></th>
						<td>
							<frame:radio name="dispYn" grpCd="${adminConstants.DISP_YN }" selectKey="${notice.dispYn}" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.content"/><strong class="red">*</strong></th>
						<td>
							<textarea style="width: 100%; height: 300px;" name="content" id="content" title="<spring:message code="column.content"/>">${notice.content}</textarea>
						</td>
					</tr>
				</tbody>
			</table>
			</form>

			<div class="btn_area_center">
			<c:if test="${empty notice}">
				<button type="button" onclick="noticeInsert();" class="btn btn-ok">등록</button>
				<button type="button" onclick="closeTab();" class="btn btn-cancel">취소</button>
			</c:if>
			<c:if test="${not empty notice and adminConstants.USR_GB_2020 ne adminSession.usrGbCd and notice.wrCompNo eq adminSession.compNo}">
				<button type="button" onclick="noticeUpdate();" class="btn btn-ok">수정</button>
				<button type="button" onclick="closeTab();" class="btn btn-cancel">닫기</button>
			</c:if>
				
			</div>
	</t:putAttribute>
</t:insertDefinition>
