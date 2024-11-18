<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function() {
			initEditor();
		});

		function initEditor () {
			EditorCommon.setSEditor('content', '${adminConstants.PRIVACY_IMAGE_PTH}');
		}
		
		// 사이트 검색
		function searchSt () {
			var options = {
				multiselect : false
				, callBack : searchStCallback
			}
			layerStList.create (options );
		}
		function searchStCallback (stList ) {
			if(stList.length > 0 ) {
				$("#stId").val (stList[0].stId );
				$("#stNm").val (stList[0].stNm );
			}
		}

		// 개인정보처리방침 등록
		function insertPrivacy () {
			if(validate.check("privacyInsertForm")) {
				oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
				// 내용 체크
				if( !editorRequired( 'content' ) ){ return false };
				
				var formData = $("#privacyInsertForm").serializeJson();
				
				// Form 데이터
				var sendData = {
					privacyPolicyPO : JSON.stringify(formData )
				}
				console.debug (sendData );
				messager.confirm("<spring:message code='column.common.confirm.insert' />", function(r){
					if(r){
						var options = {
							url : "<spring:url value='/privacy/privacyInsert.do' />"
							, data : sendData
							, callBack : function (data ) {
								messager.alert("<spring:message code='column.common.regist.final_msg' />", "Info", "info", function(){
									updateTab('/privacy/privacyDetailView.do?policyNo=' + data.policyNo, '개인정보방침 상세');
								});
							}
						};
						ajax.call(options);
					}
				})
			}
		}

		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
<form id="privacyInsertForm" name="privacyInsertForm" method="post" >
				
					<table class="table_type1">
						<caption>개인정보처리방침 등록</caption>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.policy_no" /><strong class="red">*</strong></th>	<!-- 처리 방침 번호 -->
								<td>
									<input type="hidden" id="privacyNo" name="policyNo" title="<spring:message code="column.policy_no" />" value="" />
									<b>자동입력</b>
								</td>
								<th scope="row"><spring:message code="column.version_info" /><strong class="red">*</strong></th>	<!-- 버전 정보 -->
								<td>
									<input type="text" class="w300 validate[required, maxSize[50]]" id="versionInfo" name="verInfo" title="<spring:message code="column.version_info" />" value="" />
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.st_id" /><strong class="red">*</strong></th>	<!-- 사이트 -->
								<td>
									<!-- 사이트 ID-->
									<frame:stId funcNm="searchSt()" requireYn="Y"  />
								</td>
								<th scope="row"><spring:message code="column.use_yn" /></th>	<!-- 사용 여부 -->
								<td>
									<frame:radio name="useYn" grpCd="${adminConstants.USE_YN }" />
								</td>
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.content" /><strong class="red">*</strong></th>	<!-- 내용 -->
								<td colspan="3">
									<textarea name="content" id="content" class="validate[required]" cols="30" rows="10" style="width:100%;height:500px;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>
				
</form>

				<div class="btn_area_center">
					<button type="button" class="btn btn-ok" onclick="insertPrivacy();" >등록</button>
					<button type="button" class="btn btn-cancel" onclick="closeTab();">취소</button>
				</div>

	</t:putAttribute>

</t:insertDefinition>