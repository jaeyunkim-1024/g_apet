<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function(){
            if('${adminSession.usrGrpCd}'!='10'){
            	$("#displayYn").hide();
            	$("#sortNo").hide();
            	$("#sortSeq").val('1');
            }
			EditorCommon.setSEditor('content', '${adminConstants.POLICY_CNTS_PATH}');
		});
			function policyInsert(){
				if(validate.check("policyForm")) {
					oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
					if( !editorRequired( 'content' ) ){ return false };
					messager.confirm('<spring:message code="column.common.confirm.insert" />', function(r){
		                if (r){
		                	var options = {
								url : "<spring:url value='/company/policyInsert.do' />"
								, data : $("#policyForm").serializeJson()
								, callBack : function(result){
									messager.alert("<spring:message code='admin.web.view.common.normal_process.final_msg' />", "Info", "info", function(){
										updateTab('/company/policyView.do?compPlcNo=' + result.policy.compPlcNo, '업체 정책 상세');
									});
								}
							};
							ajax.call(options);
		                }
	            	});
				}
			}

			function policyUpdate(){
				if(validate.check("policyForm")) {
					oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
					if( !editorRequired( 'content' ) ){ return false };
					messager.confirm('<spring:message code="column.common.confirm.update" />', function(r){
		                if (r){
		                	var options = {
								url : "<spring:url value='/company/policyUpdate.do' />"
								, data : $("#policyForm").serializeJson()
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
				}

				layerCompanyList.create(options);
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
			<form name="policyForm" id="policyForm" method="post">
			<table class="table_type1">
				<caption>게시판 글</caption>
				<tbody>
					<tr>
						<th><spring:message code="column.comp_plc_no"/><strong class="red">*</strong></th>
						<td>
							<input type="hidden" name="compPlcNo" value="${policy.compPlcNo}">
							<c:if test="${not empty policy}">
							${policy.compPlcNo }
							</c:if>
							<c:if test="${empty policy}">
							<b>자동입력</b>
							</c:if>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.comp_nm"/><strong class="red">*</strong></th>
						<td>
							<frame:compNo funcNm="searchCompany" requireYn="Y" defaultCompNo="${policy.compNo }" defaultCompNm="${policy.compNm }" disableSearchYn="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd && empty policy ? 'N' : 'Y'}"/>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.comp_plc_gb_cd"/><strong class="red">*</strong></th>
						<td>
							<select id="compPlcGbCd" name="compPlcGbCd" title="<spring:message code="column.disp_yn"/>" >
								<frame:select grpCd="${adminConstants.COMP_PLC_GB}" selectKey="${policy.compPlcGbCd}"/>
							</select>
						</td>
					</tr>

					<tr id="displayYn">
						<th><spring:message code="column.disp_yn"/><strong class="red">*</strong></th>
						<td>
							<frame:radio name="dispYn" grpCd="${adminConstants.DISP_YN }" selectKey="${policy.dispYn}" />
						</td>
					</tr>
					<tr id="sortNo">
						<th scope="row"><spring:message code="column.sort_seq" /><strong class="red">*</strong></th>	<!--  정렬 순서-->
						<td>
							<input type="text" class="numeric validate[required,custom[number],max[100]]" name="sortSeq" id="sortSeq" title="<spring:message code="column.sort_seq" />" maxlength="2" value="${policy.sortSeq }" />
						</td>
					</tr>
					<%--
					<tr>
						<th><spring:message code="column.content"/><strong class="red">*</strong></th>
						<td>
							//- 내용
							<div class="fTextarea gFull">
								<textarea name="content" id="content" title="<spring:message code="column.content"/>" rows="100" cols="200">${policy.content}</textarea>
							</div>
						</td>
					</tr>--%>
					<tr>
						<th><spring:message code="column.content"/><strong class="red">*</strong></th>
						<td><!-- 내용-->
							<textarea style="width: 100%; height: 300px;"  name="content" id="content" title="<spring:message code="column.content"/>">${policy.content}</textarea>
						</td>
					</tr>

				</tbody>
			</table>
			</form>

			<div class="btn_area_center">
			<c:if test="${empty policy}">
				<button type="button" onclick="policyInsert();" class="btn btn-ok">등록</button>
				<button type="button" onclick="closeTab();" class="btn btn-cancel">취소</button>
			</c:if>
			<c:if test="${not empty policy}">
				<button type="button" onclick="policyUpdate();" class="btn btn-ok">수정</button>
				<button type="button" onclick="closeTab();" class="btn btn-cancel">닫기</button>
			</c:if>
				
			</div>
	</t:putAttribute>
</t:insertDefinition>
