<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
			});
			
			function attributeSave(flag){
				if(validate.check("attributeForm")) {
					var messgae = "<spring:message code='column.common.confirm.insert' />";
					var url = "<spring:url value='/goods/insertAttribute.do' />";
					if (flag == "update") {
						messgae = "<spring:message code='column.common.confirm.update' />";
					}

					if(confirm(messgae)) {
						var options = {
							url : url
							, data : $("#attributeForm").serializeJson()
							, callBack : function(result){
								if (flag == "update") {
									messager.alert("<spring:message code='column.common.edit.final_msg' />", "Info", "info", function(){
										updateTab();
									});
								} else {
									messager.alert("<spring:message code='column.common.regist.final_msg' />", "Info", "info", function(){
										var url = '/goods/attributeView.do?attrNo=' + result.attribute.attrNo;
										closeGoTab("<spring:message code='admin.web.view.app.attribute.detail' />", url);
									});
								}
							}
						};

						ajax.call(options);
					}
				}
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
	
		<form id="attributeForm" name="attributeForm" method="post" >
			<div class="mTitle">
				<h2>옵션(속성)</h2>
			</div>
			
			<table class="table_type1">
				<caption>옵션(속성)</caption>
				<tbody>
					<tr>
						<th><spring:message code="column.attr_no" /><strong class="red">*</strong></th>	
						<td colspan="3">
							<input type="hidden" id="attrNo" name="attrNo" value="${attribute.attrNo }" />
							<c:if test="${empty attribute}">
								<b>자동입력</b>
							</c:if>
							<c:if test="${not empty attribute}">
								<b>${attribute.attrNo }</b>
							</c:if>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.attr_nm"/><strong class="red">*</strong></th>
						<td colspan="3">
							<input type="text" class="w300 validate[required]" name="attrNm" id="attrNm" title="<spring:message code="column.attr_nm"/>" value="${attribute.attrNm}" maxlength="50" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.use_yn"/><strong class="red">*</strong></th>
						<td colspan="3">
							<frame:radio name="useYn" grpCd="${adminConstants.USE_YN }" selectKey="${attribute.useYn }"/>
						</td>
					</tr>
				</tbody>
			</table>
		</form>

		<div class="btn_area_center">
		<c:if test="${empty attribute}">
			<button type="button" onclick="attributeSave('insert');" class="btn btn-ok">등록</button>
			<button type="button" onclick="closeTab();" class="btn btn-cancel">취소</button>
		</c:if>
		<c:if test="${not empty attribute}">
			<button type="button" onclick="attributeSave('update');" class="btn btn-ok">수정</button>
			<button type="button" onclick="closeTab();" class="btn btn-cancel">닫기</button>
		</c:if>
			
		</div>
	</t:putAttribute>
</t:insertDefinition>
