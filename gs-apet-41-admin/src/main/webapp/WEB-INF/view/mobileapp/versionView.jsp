<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			var verCheck = true;
			var beforeChecked = -1;
			
			$(document).ready(function(){
				//노출 POC 라디오버튼 선택 해제 이벤트
				$("input:radio[name='mobileOs']").click(function(){
					var index = $(this).parent().index("label");
					 
					if(beforeChecked == index) {
					
						beforeChecked = -1;
			 
						$(this).prop("checked", false);
			 
					}else{
						beforeChecked = index;
					}
				});
			});
			
			// 앱 버전 등록
			function insertVersion() {
			 if(validate.check("versionRegForm")) {
				if(fncValidation()){
					// 업데이트 일시
		            $("#marketRegDtm").val(getDateStr("verStrt"));
					
					messager.confirm('<spring:message code="column.common.confirm.insert" />', function(r){
						if(r){
							var options = {
								url : "<spring:url value='/mobileapp/version/insert.do' />"
								, data : $("#versionRegForm").serializeJson()
								, callBack : function(result) {
									var url = '/mobileapp/version/list.do?returnDt=' + result.version.verStrtDt;
									closeGoTab('APP 버전 목록', url);
								}
							};

							ajax.call(options);
						}
					});
				}
			}
		}
			
			//유효성 체크
			function fncValidation(){
				if ( !$('input:radio[name="mobileOs"]:checked').is(":checked") ) {
					messager.alert('<spring:message code="admin.web.view.msg.terms.rqid.poc" />', "Info", "info"); <!-- 노출 POC 구분을 선택해 주세요. -->
					
					return false;
				}
				
				<%--if ( !$('input:radio[name="requiredYn"]:checked').is(":checked") ) {
					messager.alert('강제업데이트 여부를 선택해 주세요.', "Info", "info"); <!-- 강제업데이트 여부를 선택해 주세요. -->
					
					return false;
				}--%>
				
				if($("#appVer").val() == ""){
					messager.alert('앱 버전을 입력해 주세요.', "Info", "info", function(){ <!-- 앱 버전을 입력해 주세요. -->
						$("#appVer").focus();
					});
					
					return false;
				}else{
					/* IOS, AOS 둘다 1.0.0 형식으로 변경되어 주석처리
					if($('input:radio[name="mobileOs"]:checked').val() == "I"){
						var re = /^(?:(?:[0-9]?[0-9][0-9]?)\.){2}(?:[0-9]?[0-9][0-9]?)$/;
						if(!re.test($("#appVer").val())){
							messager.alert('IOS 앱 버전 형식은 1.0.0 입니다.', "Info", "info", function(){ <!-- IOS 앱 버전 형식은 1.0.0 입니다. -->
								$("#appVer").focus();
							});
							
							return false;
						}
					}else{
						var re = /^[0-9]*$/;
						if(!re.test($("#appVer").val())){
							messager.alert('Android 앱 버전 형식은 100 입니다.', "Info", "info", function(){ <!-- Android 앱 버전 형식은 100 입니다. -->
								$("#appVer").focus();
							});
						
							return false;
						}
					}
					*/
					
					var re = /^(?:(?:[0-9]?[0-9][0-9]?)\.){2}(?:[0-9]?[0-9][0-9]?)$/;
					if(!re.test($("#appVer").val())){
						messager.alert('앱 버전 형식은 1.0.0 입니다.', "Info", "info", function(){ <!-- 앱 버전 형식은 1.0.0 입니다. -->
							$("#appVer").focus();
						});
						
						return false;
					}
					
					var options = {
						url : "<spring:url value='/mobileapp/version/verCheck.do' />"
						, data : $("#versionRegForm").serializeJson()
						, async : false
						, callBack : function(result) {
							if (result.checkCount > 0) {
								verCheck = false;
							}else{
								verCheck = true;
							}
						}
					};
					
					ajax.call(options);
				}
				
				if(!verCheck){
					messager.alert('새로운 APP 버전 정보를 입력해 주세요.', "Info", "info", function(){ <!-- 새로운 APP 버전 정보를 입력해 주세요. -->
						$("#appVer").focus();
					});
					
					return false;
				}
				
				if( validation.isNull( $("#verStrtDt").val() ) ){
					messager.alert("업데이트 일시 정보를 선택해 주세요.", "Info", "info"); <!-- 업데이트 일시 정보를 선택해 주세요. -->
					return;
				}else{
					//업데이트 일시는 현재시간 이후로 설정하도록 얼럿
					var nowDtm = new Date().setSeconds(0,0);
					var regDtm = new Date(getDateStr("verStrt"));
					
					if(nowDtm > regDtm.getTime()){
						messager.alert("업데이트 일시를 미래의 날짜와 시간으로 선택해 주세요.", "Info", "info"); <!-- 업데이트 일시를 미래의 날짜와 시간으로 선택해 주세요. -->
						return;
					}
				}
				
				if($("#updateUrl").val() == ""){
					messager.alert('업데이트 URL를 입력해 주세요.', "Info", "info", function(){ <!-- 업데이트 URL를 입력해 주세요. -->
						$("#updateUrl").focus();
					});
					
					return false;
				}else{
					<%--var re = /(http(s)?:\/\/|www.)([a-z0-9\w]+\.*)+[a-z0-9]{2,4}([\/a-z0-9-%#?&=\w])+(\.[a-z0-9]{2,4}(\?[\/a-z0-9-%#?&=\w]+)*)*/gi;
					if(!re.test($("#updateUrl").val())){
						messager.alert('URL 형식을 입력해 주세요.', "Info", "info", function(){ <!-- URL 형식을 입력해 주세요. -->
							$("#updateUrl").focus();
						});
						
						return false;
					}else{--%>
						if($("#updateUrl").val().length > 255){
							messager.alert('최대 255('+ $("#updateUrl").val().length +') 이하로 작성하십시오.', "Info", "info", function(){ <!-- 최대 255 이하로 작성하십시오. -->
								$("#updateUrl").focus();
							});
							
							return false;
						}
					<%--}--%>
				}
				
				if($("#message").val() == ""){
					messager.alert('업데이트 내용을 입력해 주세요.', "Info", "info", function(){ <!-- 업데이트 내용을 입력해 주세요. -->
						$("#message").focus();
					});
					
					return false;
				}else{
					if($("#message").val().length > 1000){
						messager.alert('최대 1000('+ $("#message").val().length +') 이하로 작성하십시오.', "Info", "info", function(){ <!-- 최대 1000 이하로 작성하십시오. -->
							$("#updateUrl").focus();
						});
						
						return false;
					}
				}
				
				return true;
			}
			
			// 초기화
			function fncReset(){
				resetForm ("versionRegForm");
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<form name="versionRegForm" id="versionRegForm" method="post">
			<input type="hidden" id="marketRegDtm" name="marketRegDtm" value=""/>
			
			<table class="table_type1">
				<caption>APP 버전관리 신규 등록</caption>
				<tbody>
					<tr>
						<th><spring:message code="column.version.out_poc" /><strong class="red">*</strong></th> <!-- 노출 POC -->
						<td>
							<frame:radio name="mobileOs" grpCd="${adminConstants.MOBILE_OS_GB}" selectKey="${adminConstants.MOBILE_OS_GB_I}"/>
						</td>
						<th><spring:message code="column.version.force_update_yn" /></th> <!-- 강제업데이트 여부 -->
						<td>
							<frame:radio name="requiredYn" grpCd="${adminConstants.APP_UPDATE_YN}" selectKey="${adminConstants.APP_UPDATE_YN_Y}"/>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.version.app_ver" /><strong class="red">*</strong></th> <!-- 앱 버전 -->
						<td>
							<%-- <input type="text" class="validate[required, custom[version]]" name="appVer" id="appVer" title="<spring:message code="column.version.app_ver" />"/> --%>
							<input type="text" class="validate[required, maxSize[20]]" name="appVer" id="appVer" title="<spring:message code="column.version.app_ver" />"/>
						</td>
						<th><spring:message code="column.version.update_dtm" /><strong class="red">*</strong></th> <!-- 업데이트 일시 -->
						<td>
							<frame:datepicker startDate="verStrtDt" startHour="verStrtHr" startMin="verStrtMn"/>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.version.update_url" /><strong class="red">*</strong></th> <!-- 업데이트 URL -->
						<td colspan="3">
							<input type="text" class="w400 validate[required, maxSize[255]]" name="updateUrl" id="updateUrl" title="<spring:message code="column.version.update_url" />"/>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.version.update_cnts" /><strong class="red">*</strong></th> <!-- 업데이트 내용 -->
						<td colspan="3">
							<textarea name="message" id="message" class="validate[required, maxSize[1000]]" title="<spring:message code="column.version.update_cnts"/>" rows="3" cols="70"></textarea>
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.version.reg_chng_info"/></th> <!-- 등록/변경 정보 -->
						<td colspan="3">
							<jsp:useBean id="now" class="java.util.Date" />
							<fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm" var="today"/>
							${session.usrNm}(${session.loginId}), ${today }
						</td>
					</tr>
				</tbody>
			</table>
		</form>

		<div class="btn_area_center">
			<button type="button" onclick="insertVersion();" class="btn btn-ok">등록</button>
			<button type="button" onclick="fncReset();" class="btn btn-cancel">초기화</button>
			<button type="button" onclick="closeTab();" class="btn btn-cancel">취소</button>
		</div>
	</t:putAttribute>
</t:insertDefinition>