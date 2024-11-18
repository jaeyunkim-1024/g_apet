<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="framework.common.constants.CommonConstants" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			var verCheck = true;
		
			$(document).ready(function(){
				changeLinkType();
			});
			
			$(function() {
				$("input[name=linkType]").change(function() {
					changeLinkType();
				});
			});
			
			function changeLinkType() {
				var linkType = $("input[name=linkType]:checked").val();
				
				<c:if test="${not empty splash}">
				<c:if test="${splash.linkType eq 'I'}">
				$('#link').val('');
				</c:if>
				<c:if test="${splash.linkType eq 'L'}">
				$('#imageUrl').val('');
				</c:if>
				</c:if>
				
				if (linkType == 'I') {
					$('#typeImage').show();
					$('#typeLink').hide();
				}
				else { 
					$('#typeImage').hide();
					$('#typeLink').show();
				}
			}
			
			function resultSplashImage(result) {
				$("#filePath").val(result.filePath);
				$("#splashImgPathView").attr('src', '/common/imageView.do?filePath=' + result.filePath);
			}
			
			function deleteSplashImage() {
				$("#filePath").val("");
				$("#imageUrl").val("");
				$("#splashImgPathView").attr('src', '/images/noimage.png' );	
			}
			
			
			// Splash 등록
			function insertSplash() {
				if (checkValidate()) {
					messager.confirm('<spring:message code="column.common.confirm.insert" />', function(r){
						if(r){
							var options = {
								url : "<spring:url value='/mobileapp/splash/insert.do' />"
								, data : $("#splashForm").serializeJson()
								, callBack : function(result) {
									updateTab('/mobileapp/splash/view.do?splashNo=' + result.splash.splashNo, '앱 Splash 상세');
								}
							};

							ajax.call(options);
						}
					})
				}
			}
			
			// Splash 수정
			function updateSplash() {
				if (checkValidate()) {
					messager.confirm('<spring:message code="column.common.confirm.update" />', function(r){
						if(r){
							var options = {
								url : "<spring:url value='/mobileapp/splash/update.do' />"
								, data : $("#splashForm").serializeJson()
								, callBack : function(result) {
									updateTab();
								}
							};

							ajax.call(options);
						}
					})
				}
			}
			
			// Splash 삭제
			function deleteSplash() {
				messager.confirm('<spring:message code="column.common.confirm.delete" />', function(r){
					if(r){
						var options = {
							url : "<spring:url value='/mobileapp/splash/delete.do' />"
							, data : {splashNos : '${splash.splashNo}'}
							, callBack : function(result) {
								closeGoTab('앱 Splash 목록', '/mobileapp/splash/list.do');
							}
						};

						ajax.call(options);
					}
				})
			}
			
			function checkValidate() {
				if (validate.check("splashForm")) {
					var linkType = $("input[name=linkType]:checked").val();
					
					if (linkType == "I" && $('#imageUrl').val() == "" && $("#filePath").val() == "") {
						messager.alert('<spring:message code="admin.web.view.msg.splash.validate.image" />', "Info", "info");
						return false;
					}
					if (linkType == "L" && $("#link").val() == "") {
						messager.alert('<spring:message code="admin.web.view.msg.splash.validate.link" />', "Info", "info");
						return false;
					}
					
					return true;
				}
				else 
					return false;
			}
			
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">

		<form name="splashForm" id="splashForm" method="post">
		<table class="table_type1">
			<caption>Splash 등록</caption>
			<tbody>
				<tr>
					<th><spring:message code="column.splashNo" /><strong class="red">*</strong></th>
					<td>
						<input type="text" class="readonly" name="splashNo" id="splashNo" title="<spring:message code="column.splashNo" />" value="${splash.splashNo}" readonly="readonly"/>
					</td>
					<th><spring:message code="column.mobileOs" /><strong class="red">*</strong></th>
					<td>
						<frame:radio name="mobileOs" grpCd="${CommonConstants.MOBILE_OS_GB}" selectKey="${splash.mobileOs eq null ? CommonConstants.MOBILE_OS_GB_I : splash.mobileOs}" />
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.ttl" /><strong class="red">*</strong></th>
					<td colspan="3">
						<input type="text" class="w400 validate[required, maxSize[1000]]" name="title" id="title" title="<spring:message code="column.ttl" />" value="${splash.title}"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.splashType" /><strong class="red">*</strong></th>
					<td colspan="3">
						<frame:radio name="linkType" grpCd="${CommonConstants.APP_SPLASH_TP}" selectKey="${splash.linkType eq null ? CommonConstants.APP_SPLASH_TP_I : splash.linkType}" />
						
						<div id="typeImage" class="mt20">
							<div class="inner">
								<input type="hidden" id="imageUrl" name="imageUrl" value="${splash.link}" />
								<input type="hidden" id="filePath" name="filePath" />
								<c:if test="${not empty splash.link}">
								<img id="splashImgPathView" name="splashImgPathView" src="${splash.link}" class="thumb" alt="" />
								</c:if>
								<c:if test="${empty splash.link}">
								<img id="splashImgPathView" name="splashImgPathView" src="/images/noimage.png" class="thumb" alt="" />
								</c:if>
							</div>
							<div id="pushImg" class="inner ml10" style="vertical-align:bottom">
								<button type="button" class="btn" onclick="fileUpload.image(resultSplashImage);" ><spring:message code="column.common.addition" /></button> <!-- 추가 -->
								<button type="button" class="btn" onclick="deleteSplashImage();" ><spring:message code="column.common.delete" /></button> <!-- 삭제 -->
							</div>
						</div>
						<div id="typeLink" class="mt20">
							<input type="text" class="w400 validate[required, custom[url]]" id="link" name="link" value="${splash.link}" />
						</div>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.splashStatus" /><strong class="red">*</strong></th>
					<td colspan="3">
						<frame:radio name="status" grpCd="${CommonConstants.APP_SPLASH_STATUS}" selectKey="${splash.status eq null ? CommonConstants.APP_SPLASH_STATUS_0 : splash.status}" />
					</td>	
				</tr>	
			<c:if test="${not empty splash}">
				<tr>
					<th><spring:message code="column.sys_regr_nm" /></th>
					<td>
						${splash.sysRegrNm}
					</td>
					<th><spring:message code="column.sys_reg_dtm" /></th>
					<td>
						<fmt:formatDate value="${splash.sysRegDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.sys_updr_nm" /></th>
					<td>
						${splash.sysUpdrNm}
					</td>
					<th><spring:message code="column.sys_upd_dtm" /></th>
					<td>
						<fmt:formatDate value="${splash.sysUpdDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>
				</tr>
			</c:if>
			</tbody>
		</table>
		</form>

		<div class="btn_area_center">
		<c:if test="${empty splash}">
			<button type="button" onclick="insertSplash();" class="btn btn-ok">등록</button>
			<button type="button" onclick="closeTab();" class="btn btn-cancel">취소</button>
		</c:if>
		<c:if test="${not empty splash}">
			<button type="button" onclick="updateSplash();" class="btn btn-ok">수정</button>
			<button type="button" onclick="deleteSplash();" class="btn btn-add">삭제</button>
			<button type="button" onclick="closeTab();" class="btn btn-cancel">닫기</button>
		</c:if>
			
		</div>
	</t:putAttribute>
</t:insertDefinition>
