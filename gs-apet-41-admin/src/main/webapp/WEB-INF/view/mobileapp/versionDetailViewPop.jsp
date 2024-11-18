<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

	<script type="text/javascript">
		var verCheck = true;
		var beforeChecked = -1;
		
		$(document).ready(function(){
			<%--var nowDtm = new Date().setSeconds(0,0);
			var saveRegDtm = new Date("${version.marketRegDtm}");
			
			//업데이트 일시가 현재날짜보다 과거이면 수정 못하도록 처리
			if(nowDtm >= saveRegDtm.getTime()){
				$("input[name=mobileOs]").prop("disabled", true);
				$("input[name=requiredYn]").prop("disabled", true);
				$("input[name=appVer]").prop("disabled", true);
				$("input[name=verStrtDt]").prop("disabled", true);
				$("select[name=verStrtHr]").prop("disabled", true);
				$("select[name=verStrtMn]").prop("disabled", true);
				$("input[name=updateUrl]").prop("disabled", true);
				$("textarea[name=message]").prop("disabled", true);
				$("#save_btn").hide();
			}else{
				$("input[name=mobileOs]").prop("disabled", false);
				$("input[name=requiredYn]").prop("disabled", false);
				$("input[name=appVer]").prop("disabled", false);
				$("input[name=verStrtDt]").prop("disabled", false);
				$("select[name=verStrtHr]").prop("disabled", false);
				$("select[name=verStrtMn]").prop("disabled", false);
				$("input[name=updateUrl]").prop("disabled", false);
				$("textarea[name=message]").prop("disabled", false);
				$("#save_btn").show();
			}--%>
			
			var nowVerYn = "${version.nowVerYn}";
			if(nowVerYn == "Y"){
				$("input[name=mobileOs]").prop("disabled", false);
				$("input[name=appVer]").prop("disabled", false);
				
				//$("#del_btn").hide();
			}else{
				$("input[name=mobileOs]").prop("disabled", true);
				$("input[name=appVer]").prop("disabled", true);
				
				//$("#del_btn").show();
			}
			
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
		
		// 앱 버전 수정
		function updateVersion() {
			if(fncValidation()){
				// 업데이트 일시
	            $("#marketRegDtm").val(getDateStr("verStrt"));
				
				messager.confirm('<spring:message code="column.common.confirm.update" />', function(r){
					if(r){
						var options = {
							url : "<spring:url value='/mobileapp/version/update.do' />"
							, data : $("#versionDetailForm").serializeJson()
							, callBack : function(result) {
								layer.close ("versionDetailViewPop");
								
								fncSrchVerGrid();
							}
						};
	
						ajax.call(options);
					}
				});
			}
		}
		
		// 앱 버전 삭제
		function deleteVersion() {
			messager.confirm('<spring:message code="column.common.confirm.delete" />', function(r){
				if(r){
					var options = {
						url : "<spring:url value='/mobileapp/version/delete.do' />"
						, data : {verNos : '${version.verNo}'}
						, callBack : function(result) {
							layer.close ("versionDetailViewPop");
							
							fncSrchVerGrid();
						}
					};
	
					ajax.call(options);
				}
			})
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
					, data : $("#versionDetailForm").serializeJson()
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
				//업데이트 일시 변경시 현재시간 이후로 설정하도록 얼럿
				var saveRegDtm = new Date("${version.marketRegDtm}");
				var nowRegDtm = new Date(getDateStr("verStrt"));
				if(saveRegDtm.getTime() != nowRegDtm.getTime()){
					var nowDtm = new Date().setSeconds(0,0);
					var regDtm = new Date(getDateStr("verStrt"));
					
					if(nowDtm > regDtm.getTime()){
						messager.alert("업데이트 일시를 미래의 날짜와 시간으로 선택해 주세요.", "Info", "info"); <!-- 업데이트 일시를 미래의 날짜와 시간으로 선택해 주세요. -->
						return false;
					}
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
	</script>
	<form name="versionDetailForm" id="versionDetailForm" method="post">
		<input type="hidden" id="marketRegDtm" name="marketRegDtm" value=""/>
		<input type="hidden" id="verNo" name="verNo" value="${version.verNo}"/>
		
		<table class="table_type1 popup">
			<caption>APP 버전관리 신규 등록</caption>
			<tbody>
				<tr>
					<th><spring:message code="column.version.out_poc" /><strong class="red">*</strong></th> <!-- 노출 POC -->
					<td>
						<frame:radio name="mobileOs" grpCd="${adminConstants.MOBILE_OS_GB}" selectKey="${version.mobileOs eq null ? CommonConstants.MOBILE_OS_GB_I : version.mobileOs}"/>
					</td>
					<th><spring:message code="column.version.force_update_yn" /></th> <!-- 강제업데이트 여부 -->
					<td>
						<frame:radio name="requiredYn" grpCd="${adminConstants.APP_UPDATE_YN}" selectKey="${version.requiredYn eq null ? CommonConstants.APP_UPDATE_YN_Y : version.requiredYn}"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.version.app_ver" /><strong class="red">*</strong></th> <!-- 앱 버전 -->
					<td>
						<%-- <input type="text" class="validate[required, custom[version]]" name="appVer" id="appVer" title="<spring:message code="column.version.app_ver" />" value="${version.appVer}"/> --%>
						<input type="text" name="appVer" id="appVer" title="<spring:message code="column.version.app_ver" />" value="${version.appVer}"/>
					</td>
					<th><spring:message code="column.version.update_dtm" /><strong class="red">*</strong></th> <!-- 업데이트 일시 -->
					<td>
						<frame:datepicker startDate="verStrtDt" startHour="verStrtHr" startMin="verStrtMn" startValue="${version.marketRegDtm}"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.version.update_url" /><strong class="red">*</strong></th> <!-- 업데이트 URL -->
					<td colspan="3">
						<input type="text" class="w400" name="updateUrl" id="updateUrl" title="<spring:message code="column.version.update_url"/>" value="${version.updateUrl}"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.version.update_cnts" /><strong class="red">*</strong></th> <!-- 업데이트 내용 -->
					<td colspan="3">
						<textarea name="message" id="message" title="<spring:message code="column.version.update_cnts"/>" rows="3" cols="70">${version.message}</textarea>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.version.reg_chng_info"/></th> <!-- 등록/변경 정보 -->
					<td colspan="3">
						${version.sysRegrNm }(${version.sysRegrId}),&nbsp;<fmt:formatDate value="${version.sysRegDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>,&nbsp;등록<br> 
						${version.sysUpdrNm }(${version.sysUpdrId}),&nbsp;<fmt:formatDate value="${version.sysUpdDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>,&nbsp;최종수정
					</td>
				</tr>
			</tbody>
		</table>
	</form>