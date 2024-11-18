<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
			});

			function insertChnlStdInfo() {
				if(validate.check("chnlStdInfoForm")) {
					messager.confirm('<spring:message code="column.common.confirm.insert" />', function(r){
						if(r){
							var data = $("#chnlStdInfoForm").serializeJson();

							var options = {
								url : "<spring:url value='/system/chnlStdInfoInsert.do' />"
								, data :  data
								, callBack : function(result){
									updateTab('/system/chnlStdInfoView.do?chnlId=' + result.chnlStdInfo.chnlId, '채널 상세');
								}
							};

							ajax.call(options);
						}
					})
				}
			}

			function updateChnlStdInfo() {
				if(validate.check("chnlStdInfoForm")) {
					messager.confirm('<spring:message code="column.common.confirm.update" />', function(r){
						if(r){
							var data = $("#chnlStdInfoForm").serializeJson();

							var options = {
								url : "<spring:url value='/system/chnlStdInfoUpdate.do' />"
								, data : data
								, callBack : function(result){
									updateTab();
								}
							};

							ajax.call(options);
						}
					})
				}
			}

			function deleteChnlStdInfo() {
				messager.confirm('<spring:message code="column.common.confirm.delete" />', function(r){
					if(r){
						var options = {
							url : "<spring:url value='/system/chnlStdInfoDelete.do' />"
							, data :  {
								chnlId : '${chnlStdInfo.chnlId}'
							}
							, callBack : function(result){
								closeGoTab('채널 목록', '/system/chnlStdInfoListView.do');
							}
						};

						ajax.call(options);
					}
				})
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
	
		<form id="chnlStdInfoForm" name="chnlStdInfoForm" method="post" >
				
			<table class="table_type1 mg5">
				<c:if test="${empty chnlStdInfo}">
					<caption>채널 기준 정보 등록</caption>
				</c:if>
				<c:if test="${not empty chnlStdInfo}">
					<caption>채널 기준 정보 상세</caption>
				</c:if>
				<tbody>
					<tr>
						<th><spring:message code="column.chnl_id" /><strong class="red">*</strong></th>	<!-- 채널 ID -->
						<td>
							<input type="hidden" id="chnlId" name="chnlId" value="${chnlStdInfo.chnlId }" />
							<c:if test="${empty chnlStdInfo}">
								<b>자동입력</b>
							</c:if>
							<c:if test="${not empty chnlStdInfo}">
								<b>${chnlStdInfo.chnlId }</b>
							</c:if>
						</td>
						<th><spring:message code="column.chnl_nm" /><strong class="red">*</strong></th>	<!-- 채널명 -->
						<td>
							<input type="text" class="validate[required, maxSize[200]]" name="chnlNm" id="chnlNm" title="<spring:message code="column.chnl_nm" />" value="${chnlStdInfo.chnlNm}" />
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="column.chnl_sht" /><strong class="red">*</strong></th>	<!-- 사이트 약어 -->
						<td>
							<input type="text" class="w300 validate[required, maxSize[100]]" id="chnlSht" name="chnlSht" title="<spring:message code="column.chnl_sht" />" value="${chnlStdInfo.chnlSht}" />
						</td>
						
						<th><spring:message code="column.chnl_gb_cd" /><strong class="red">*</strong></th>	<!-- 채널 구분 코드-->
						<td>
							<select class="input_select validate[required]" name="chnlGbCd" id="chnlGbCd" title="<spring:message code="column.chnl_gb_cd" />">
								<frame:select grpCd="${adminConstants.CHNL_GB }" selectKey="${chnlStdInfo.chnlGbCd eq null ? adminConstants.CHNL_GB_10 : chnlStdInfo.chnlGbCd }" />
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="column.ccl_tg_yn" /></th>	<!-- 정산 대상 여부 -->
						<td>
							<frame:radio name="cclTgYn" grpCd="${adminConstants.COMM_YN }" selectKey="${chnlStdInfo.cclTgYn }" />
						</td>
						<th scope="row"><spring:message code="column.tax_ivc_issue_yn" /></th>	<!-- 세금 계산서 발행 여부 -->
						<td>
							<frame:radio name="taxIvcIssueYn" grpCd="${adminConstants.COMM_YN }" selectKey="${chnlStdInfo.taxIvcIssueYn }" />
						</td>
					</tr>
				</tbody>
			</table>
				
		</form>

		<div class="btn_area_center">
		<c:if test="${empty chnlStdInfo}">
			<button type="button" onclick="insertChnlStdInfo();" class="btn btn-ok">등록</button>
		</c:if>
		<c:if test="${not empty chnlStdInfo}">
			<button type="button" onclick="updateChnlStdInfo();" class="btn btn-ok">수정</button>
			<button type="button" onclick="deleteChnlStdInfo();" class="btn btn-add">삭제</button>
		</c:if>
			<button type="button" onclick="closeTab();" class="btn btn-cancel">닫기</button>
		</div>
	</t:putAttribute>
</t:insertDefinition>
