<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			// idCheck 여부
			var idCheck = false;

			$(document).ready(function(){
				$("#loginId").validationEngine();
// 				changeUserGrp();
				//changeUserGb();
				
				<c:if test="${!empty user.authNo}">
					$("#authNo").val("${user.authNo}");
					<c:if test="${adminSession.usrGrpCd eq adminConstants.USR_GRP_20}">
					$("#authNo").attr("disabled", true);
					</c:if>
				</c:if>	

				<c:if test="${empty user.usrNo}">
					$('#loginId').validationEngine('showPrompt', '<spring:message code="column.user_view.id_valid" />', 'error', true);
				</c:if>

				<c:if test="${adminSession.usrGrpCd eq adminConstants.USR_GRP_20}">
					$("#usrGrpCd").val("${adminConstants.USR_GRP_20}").change();
				</c:if>
			});

			// 사용자 그룹 선택시
// 			$(document).on("change", "#usrGrpCd", function(e) {
// 				changeUserGrp();
// 			});
			
			$(document).on("change", "#loginId", function(e) {
				idCheck = false;
			})
			
			// 사용자 구분 선택시
			/* $(document).on("change", "#usrGbCd", function(e) {
				changeUserGb();
			}); */

			$(document).on("input paset change", "#email", function(){
			   var inputVal = $(this).val().replace(/[ㄱ-힣]/g,'');
			   $("#email").val(inputVal);
			})

			
			
			/* <c:if test="${empty user.usrNo}">
			// ID 체크로직
			$(document).on("blur", "#loginId", function(e){
				if(!validate.check("loginId")) {
					var options = {
						url : "<spring:url value='/system/userIdCheck.do' />"
						, data : $("#userForm").serializeJson()
						, callBack : function(result){
							if(result.checkCount > 0){
								idCheck = false;
								$('#loginId').validationEngine('showPrompt', result.message, 'error', true);
							} else {
								idCheck = true;
								$('#loginId').validationEngine('showPrompt', "사용가능한 로그인 아이디 입니다.", 'pass', true);
							}
						}
					};
					ajax.call(options);
				} else {
					idCheck = false;
				}
			});
			</c:if> */
			
			// ID 체크
			function userIdCheck(){
				if($("#loginId").val() != "") {
					if(!validate.check("loginId")) {
						var options = {
							url : "<spring:url value='/system/userIdCheck.do' />"
							, data : $("#userForm").serializeJson()
							, callBack : function(result){
								if(result.checkCount > 0){
									idCheck = false;
									$('#loginId').validationEngine('showPrompt', result.message, 'error', true);
								} else {
									idCheck = true;
									$('#loginId').validationEngine('showPrompt', '<spring:message code="column.user_view.success_id_chk" />', 'pass', true);
								}
							}
						};
						ajax.call(options);
					} else {
						idCheck = false;
					}
				} else {
					$('#loginId').validationEngine('showPrompt', '<spring:message code="column.user_view.id_valid" />', 'error', true);
				}
			}

			// 권한 리스트 세팅
			function setAuth(){
				var authList = Array();
				$("input[name=authNo]:checked").each(function() { 
					var authValue = $(this).val();
					authList.push(authValue);
				});
				$("#authorityPOList").val(authList);
			} 
			
			// 권한번호 valid체크
			// 라디오 버튼이라 div로 감싸서 체크함
			function authValidEg() {
				if($("#authorityPOList").val() == null || $("#authorityPOList").val() == ""){
					$('#authDiv').validationEngine('showPrompt', '<spring:message code="column.access_auth" /> 정보를 입력해주세요.', 'error', true);
					return true;
				} else {
					$('#authDiv').validationEngine('hide');
					return false;
				}				
			}
			
			// 제휴일 valid체크
			// frame이라 div로 감싸서 체크함
			function validDtmValidEg() {
				var validEnDtm = $("#validEnDtm").val();
				var validStDtm = $("#validStDtm").val();
				
				if((validStDtm == null || validStDtm == "") || (validEnDtm == null || validEnDtm == "")){
					$('#validDtmDiv').validationEngine('showPrompt', '<spring:message code="column.vld_prd_cd" /> 정보를 입력해주세요.', 'error', true);
					return true;
				} else {
					$('#validDtmDiv').validationEngine('hide');
					return false;
				}				
			}
			

			// 사용자 등록
			function userInsert(){
				setAuth();
				
				authValidEg();
				validDtmValidEg();

				if(customValidation()) {
					if(validate.check("userForm")) {
						if(!idCheck) {
							$('#loginId').validationEngine('showPrompt', '<spring:message code="column.user_view.plz_id_chk" />', 'error', true);
							return;
						}
						
						if(authValidEg()) return;
						if(validDtmValidEg()) return;
						
						var validStDtm = $("#validStDtm").val();
						var validEnDtm = $("#validEnDtm").val();
						if(validStDtm > validEnDtm) {
							$('#validDtmDiv').validationEngine('showPrompt', '<spring:message code="column.user_view.date.chk" />', 'error', true);
							return;
						}
						
						messager.confirm('<spring:message code="column.common.confirm.insert" />', function(r){
							if(r){
								var options = {
									url : "<spring:url value='/system/userInsert.do' />"
									, data : $("#userForm").serializeJson()
									, callBack : function(result){
										var url = "";
										var tabName = "";
										
										if("${usrGrpCdGb}" == "${adminConstants.USR_GRP_10}") {
											url = "/system/userListView.do";
											tabName = "사용자 목록";
										} else {
											url = "/partner/partnerListView.do";
											tabName = "파트너 사용자 목록";
										}
										updateTab(url, tabName);
									}
								};
	
								ajax.call(options);
							}
						})
					}
				}
			}

			// 사용자 수정
			function userUpdate(){
				setAuth();
				
				authValidEg();
				validDtmValidEg();
				
				if(customValidation()) {
					if(validate.check("userForm")) {
					
						if(authValidEg()) return;
						if(validDtmValidEg()) return;
						
						var validStDtm = $("#validStDtm").val();
						var validEnDtm = $("#validEnDtm").val();
						if(validStDtm > validEnDtm) {
							$('#validDtmDiv').validationEngine('showPrompt', '<spring:message code="column.user_view.date.chk" />', 'error', true);
							return;
						}
						
						messager.confirm('<spring:message code="column.common.confirm.update" />', function(r){
							if(r){
								
								var options = {
									url : "<spring:url value='/system/userUpdate.do' />"
									, data : $("#userForm").serializeJson()
									, callBack : function(result){
										var url = "";
										var tabName = "";
										
										if("${usrGrpCdGb}" == "${adminConstants.USR_GRP_10}") {
											url = "/system/userListView.do";
											tabName = "사용자 목록";
										} else {
											url = "/partner/partnerListView.do";
											tabName = "파트너 사용자 목록";
										}
										updateTab(url, tabName);
									}
								};
	
								ajax.call(options);							
							}
						})
					}
				}
			}

			function userPasswordReset(){
				messager.confirm('<spring:message code="column.user_view.confirm.password" />', function(r){
					if(r){
						var options = {
							url : "<spring:url value='/system/userPasswordUpdate.do' />"
							, data : {
								usrNo : '${user.usrNo}'
								, mobile : $("#mobile").val()
							}
							, callBack : function(result){
								messager.alert('<spring:message code="column.user_view.success.userPasswordReset" />', "Info", "info", function(){ updateTab('/system/userListView.do', '사용자 목록'); });
							}
						};

						ajax.call(options);
					}
				})
			}

			// 공급업체 레이어
			function userCompanyLayer(){
				var data = {
					multiselect : false
					, upCompNo : 0
                    , compStatCd : '${adminConstants.COMP_STAT_20}'
					, compTpCd : '${adminConstants.COMP_TP_20}'
					, readOnlyCompTpCd : "Y"
					, selectKeyOnlyCompTpCd : "Y" 
					, callBack : function(result) {
						$("#compNo").val(result[0].compNo);
						$("#compNm").val(result[0].compNm);
						
						var options = {
							url : "<spring:url value='/system/userCompanyDupChk.do' />"
							, data : {
								compNo : $("#compNo").val()
							}
							, callBack : function(result){
								if(result.cnt > 0) {
									messager.alert("사용자가 이미 등록되어있는 업체입니다. 다시 선택하여 주십시오.", "Info", "info", function(){
										$("#compNo").val("");
										$("#compNm").val("");
									});
									return false;
								}
							}
						};

						ajax.call(options);
					}
				}
				layerCompanyList.create(data);
			}

			function userLoginPop(){
				var options = {
					  url : '/system/userLoginViewPop.do'
					, dataType : "html"
					, data : {usrNo : '${user.usrNo}'}
					, callBack : function(result) {
						var config = {
							 id : 'userLoginViewPop'
							,width : 800
							,height : 600
							,top : 100
							,init : 'userLoginViewInit'
							,title : '로그인 이력'
							,body : result
						}
						layer.create(config);
					}
				}
				ajax.call(options);
			}
			
			// 사용자 권한 확인 팝업
			function userAuthMenuViewPop(){
				var options = {
					  url : '/system/userAuthMenuViewPop.do'
					, dataType : "html"
					, data : {
						usrNo : '${user.usrNo}'
						, loginId : '${user.loginId}'
						, usrNm : '${user.usrNm}'
						, dpNm : '${user.dpNm}'
						, usrGrpCd : "${usrGrpCdGb}"
					}
					, callBack : function(result) {
						var config = {
							 id : 'userAuthMenuViewPop'
							,width : 1000
							,height : 600
							,top : 100
							,init : 'userAuthMenuViewInit'
							,title : '사용자 권한 확인'
							,body : result
						}
						layer.create(config);		
					}			
				}
				ajax.call(options);
			}
			
			/*
			 * 사용자 구분에 따른 화면 컨트롤
			 */
			/* function changeUserGb(){
				var userGbCd = $("#usrGbCd").val();
				
				// CTI관련 화면
				if(userGbCd == "${adminConstants.USR_GB_1030}" || userGbCd == "${adminConstants.USR_GB_1031}"){
					$("#user_view_cti_area").show();
				}else{
					$("#user_view_cti_area").hide();
					$("#ctiId").val("");
					$("#ctiExtNo").val("");
				}
				
			} */
			
			/*
			 * 사용자 그룹에 따른 화면 컨트롤
			 */ 
			function changeUserGrp(){
				var userGrpCd = $("#usrGrpCd").val();
				// 업체정보
				/* if(userGrpCd == '${adminConstants.USR_GRP_10}'){
					$(".compView").hide();
				} else {
					$(".compView").show();
				} */

				<c:if test="${empty user.usrGbCd && (adminSession.usrGrpCd eq adminConstants.USR_GRP_10)}">
				$("#usrGbCd").val("");
				
				var optionList = $("#usrGbCd").find("option");
				for( var i=0; i < optionList.length ; i++){
					$(optionList[i]).attr('disabled', false);

					var optionVal = $(optionList[i]).attr("value");
					if(optionVal.substring(0,2) != userGrpCd){
						$(optionList[i]).attr('disabled', true);
					}
				}
				</c:if>	
			}
			
			function dataReset(){
				resetForm ("userForm");

				<c:if test="${adminSession.usrGrpCd eq adminConstants.USR_GRP_10}">
					$("#usrGrpCd").val("${adminConstants.USR_GRP_10}").change();
				</c:if>
				<c:if test="${adminSession.usrGrpCd eq adminConstants.USR_GRP_20}">
					$("#usrGrpCd").val("${adminConstants.USR_GRP_20}").change();
				</c:if>
			}
			
			function customValidation() {
				var cnt = 0;
				$(".required_item").each(function(index, item){
					var val = this.value;
					if(val == null || val == "") {
						var text = $(this).parents("td").prev().text().replace("*", "");
						text += " 정보를 입력해 주세요.";
						
						$(this).validationEngine('showPrompt', text, 'error', true);
						
						cnt++;
					} else {
						$(this).validationEngine('hide');
					}
				})
				return (cnt > 0) ? false : true;
			}
			
			function imsiInsert() {
				setAuth();
				
				authValidEg();
				validDtmValidEg();
				
				//if(validate.check("userForm")) {
				if(customValidation()) {
					if(!idCheck) {
						$('#loginId').validationEngine('showPrompt', '<spring:message code="column.user_view.plz_id_chk" />', 'error', true);
						return;
					}
					
					if(authValidEg()) return;
					if(validDtmValidEg()) return;
					
					var validStDtm = $("#validStDtm").val();
					var validEnDtm = $("#validEnDtm").val();
					if(validStDtm > validEnDtm) {
						$('#validDtmDiv').validationEngine('showPrompt', '<spring:message code="column.user_view.date.chk" />', 'error', true);
						return;
					}
					
					messager.confirm('사용자 다량등록', function(r){
						if(r){
							var options = {
								url : "<spring:url value='/system/imsiInsert.do' />"
								, data : $("#userForm").serialize() + "&startCnt=476&loofCnt=501&usrStatCd=20"
								, callBack : function(result){
									var url = "";
									var tabName = "";
									
									if("${usrGrpCdGb}" == "${adminConstants.USR_GRP_10}") {
										url = "/system/userListView.do";
										tabName = "사용자 목록";
									} else {
										url = "/partner/partnerListView.do";
										tabName = "파트너 사용자 목록";
									}
									updateTab(url, tabName);
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

		<form name="userForm" id="userForm" method="post">
		
		<input id="lastLoginDtmStr" name="lastLoginDtmStr" type="hidden" value="${user.lastLoginDtm }" />
		<input id="usrGrpCd" name="usrGrpCd" type="hidden" value="${usrGrpCdGb }" />
		<c:if test="${adminSession.usrGrpCd eq adminConstants.USR_GRP_20 }">
			<input id="compNo" name="compNo" type="hidden" value="${user.compNo }" />
		</c:if>
		
		<table class="table_type1 mg5">
			<caption>사용자 등록</caption>
			<tbody>
			<c:if test="${adminSession.usrGrpCd ne adminConstants.USR_GRP_20 }">
				<tr>
					<!-- 파트너사 ID -->
					<th><spring:message code="column.partner_id" /><strong class="red">*</strong></th>
					<td colspan="3">
						<%-- <c:if test="${not empty user.usrNo}"> ${user.compNo } ${user.compNm }</c:if>
						<input type="text" class="${empty user.usrNo ? '' : 'readonly'}" name="compNo" id="compNo" title="<spring:message code="column.login_id" />" value="${user.compNo }" style="${empty user.usrNo ? '' : 'display:none'}" /> --%>
						${user.compNo } &nbsp;&nbsp; ${user.compNm }
					</td>
				</tr>
			</c:if>
				<tr>
					<!-- 사용자 번호 -->
					<th style="display:none"><spring:message code="column.usr_no" /><strong class="red">*</strong></th>
					<td style="display:none">
						<input type="text" class="readonly" name="usrNo" id="usrNo" title="<spring:message code="column.usr_no" />" value="${user.usrNo}" readonly="readonly"/>
					</td>
					<!-- 사용자 ID -->
					<th><spring:message code="column.usr_id" /><strong class="red">*</strong></th>
					<td colspan="3">
						<c:if test="${not empty user.usrNo}"> ${user.loginId }</c:if>
						<input type="text" class="${empty user.usrNo ? '' : 'readonly'} required_item validate[custom[loginid]]" name="loginId" id="loginId" title="<spring:message code="column.login_id" />" value="${user.loginId }" style="${empty user.usrNo ? '' : 'display:none'}" />
						 <button type="button" class="btn" onclick="userIdCheck();" style="${empty user.usrNo ? '' : 'display:none'}">중복확인</button>
					</td>
				</tr>
				<tr <c:if test="${empty user.usrNo}">style="display: none;" </c:if>>
					<!-- 비밀번호 -->
					<th><spring:message code="column.pswd" /><strong class="red">*</strong></th>
					<td colspan="3">
						**********
<%-- 						<c:if test="${(adminSession.usrGbCd eq adminConstants.USR_GB_1010 || adminSession.usrGbCd eq adminConstants.USR_GB_2030) && user.usrGbCd ne adminSession.usrGbCd}"> --%>
							<button type="button" class="btn" onclick="userPasswordReset();">비밀번호 초기화</button>
<%-- 					 	</c:if> --%>
					</td>
				</tr>
				<tr>
					<!-- 사용자 명 -->
					<th><spring:message code="column.usr_nm" /><strong class="red">*</strong></th>
					<td colspan="3">
						<c:if test="${not empty user.usrNo}"> ${user.usrNm }</c:if>
						<input type="text" class="required_item validate[custom[onlyKoAndEn], maxSize[20]]" name="usrNm" id="usrNm" title="<spring:message code="column.usr_nm" />" value="${user.usrNm }" style="${empty user.usrNo ? '' : 'display:none'}" placeholder="한글, 영문으로 입력" />
					</td>
				</tr>
				<tr>
					<!-- 소속명 -->
					<th><spring:message code="column.dp_nm" /><strong class="red">*</strong></th>
					<td colspan="3">
						<c:if test="${not empty user.usrNo}"> ${user.dpNm}</c:if>
						<input type="text" class="required_item validate[custom[onlyKoAndEn], [maxSize[100]]" name="dpNm" id="dpNm" title="<spring:message code="column.dp_nm" />" value="${user.dpNm}" style="${empty user.usrNo ? '' : 'display:none'}" />
					</td>
				</tr>
				<c:if test="${adminSession.usrGrpCd eq adminConstants.USR_GRP_10 }">
				<%-- <tr>
					<!-- 사용자 그룹 -->
					<th><spring:message code="column.usr_grp_cd" /><strong class="red">*</strong></th>
					<td colspan="3">
						<select class="validate[required]" name="usrGrpCd" id="usrGrpCd" title="<spring:message code="column.usr_grp_cd" />" <c:if test="${!empty user.usrGrpCd}">disabled="disabled" </c:if>> 
							<frame:select grpCd="${adminConstants.USR_GRP}" usrDfn1Val="${usrGrpCdGb eq adminConstants.USR_GRP_10 ? adminConstants.USR_GB_BO : adminConstants.USR_GB_PO }" selectKey="${user.usrGrpCd}" />
						</select>
					</td>
				</tr> --%>
				<tr class="compView" <c:if test="${usrGrpCdGb ne adminConstants.USR_GRP_20}">style="display: none;" </c:if>>
					<th><spring:message code="column.comp_nm" /><strong class="red">*</strong></th>
					<td colspan="3">
						<input type="hidden" class="${user.usrGrpCd ne adminConstants.USR_GRP_20 ? '' : 'required_item' }" name="compNo" id="compNo" title="" value="${user.compNo}" />
						<input type="text" class="${user.usrGrpCd ne adminConstants.USR_GRP_20 ? '' : 'required_item' } w175 readonly" id="compNm" title="" value="${user.compNm }" readonly="readonly" /> 업체번호 : ${user.compNo}
						<c:if test="${empty user.compNo}">
						<button type="button" class="btn_h25_type1" onclick="userCompanyLayer();">검색</button>
						</c:if>
					</td>
				</tr>
				</c:if>
				<tr>
					<!-- 접근 권한 -->
					<th>
						<spring:message code="column.access_auth" /><strong class="red" style="padding-right:5px">*</strong>
						<button type="button" class="btn btn-sm" onclick="userAuthMenuViewPop();" style="padding:3px">권한 확인</button>
					</th>
					<td colspan="3">
						<div id="authDiv" name="authDiv">
							<c:forEach items="${auth}" var="item">
								<c:if test="${usrGrpCdGb eq adminConstants.USR_GRP_10 }">
									<c:if test="${item.authNo ne 103 }">
										<label class="fCheck"><input type="checkbox" name="authNo" id="authNo_${item.authNo}" value="${item.authNo}" <c:if test="${item.useYn eq 'Y'}">checked</c:if>> <span>${item.authNm }</span></label>
									</c:if>
								</c:if>
								<c:if test="${usrGrpCdGb eq adminConstants.USR_GRP_20 }">
									<c:if test="${item.authNo eq 103 }">
										<label style="${not empty user.usrNo && adminSession.usrGrpCd eq adminConstants.USR_GRP_20 && adminSession.usrNo eq user.usrNo && empty item.useYn ? 'display:none' : ''}" class="fCheck"><input type="checkbox" name="authNo" id="authNo_${item.authNo}" value="${item.authNo}" <c:if test="${item.useYn eq 'Y'}">checked</c:if>> <span>${item.authNm }</span></label>
									</c:if>
								</c:if>
							</c:forEach>
						</div>	
						<input id="authorityPOList" name="authorityPOList" type="hidden" />
					</td>
				</tr>
				<tr>
					<!-- 사용자 구분 -->
					<th><spring:message code="column.usr_gb_cd" /><strong class="red">*</strong></th>
					<td colspan="3">
						<!-- PO마스터 계정은 자신의 정보 수정하지 못함. -->
						<c:choose>
                            <c:when test="${not empty user.usrNo && adminSession.usrGrpCd eq adminConstants.USR_GRP_20 && adminSession.usrNo eq user.usrNo }">
                                <frame:codeName grpCd="${adminConstants.USR_GB}" dtlCd="${user.usrGbCd }" />
                            </c:when>
                            <c:otherwise>
								<select class="required_item" name="usrGbCd" id="usrGbCd" title="<spring:message code="column.usr_gb_cd" />" >
									
									<frame:select grpCd="${adminConstants.USR_GB}" selectKey="${user.usrGbCd }" usrDfn1Val="${usrGrpCdGb eq adminConstants.USR_GRP_10 ? adminConstants.USR_GRP_10 : adminConstants.USR_GRP_20}" usrDfn2Val="${adminSession.usrGrpCd eq adminConstants.USR_GRP_10 ? adminConstants.USR_GB_BO : adminConstants.USR_GB_PO}"  />
								</select>
                            </c:otherwise>
                        </c:choose>
					</td>
				</tr>
				<tr>
					<!-- 상태 -->
					<th><spring:message code="column.usr_stat_cd" /><strong class="red">*</strong></th>
					<td colspan="3">
						<c:if test="${adminSession.usrGbCd eq adminConstants.USR_GB_2030 && user.usrGbCd eq adminConstants.USR_GB_2030}"> ${user.usrStatNm } </c:if>
						<select name="usrStatCd" id="usrStatCd" title="<spring:message code="column.usr_stat_cd" />" ${empty user.usrStatCd ? 'disabled="disabled"' : ''} style="${adminSession.usrGbCd eq adminConstants.USR_GB_2030 && user.usrGbCd eq adminConstants.USR_GB_2030 ? 'display:none' : ''}">
							<frame:select grpCd="${adminConstants.USR_STAT}" selectKey="${empty user.usrStatCd ? adminConstants.USR_STAT_20 : user.usrStatCd}"/>
						</select>
					</td>
				</tr>
				<tr>
					<!-- 전화번호 -->
					<th><spring:message code="column.tel" /></th>
					<td colspan="3">
						<c:if test="${adminSession.usrGbCd eq adminConstants.USR_GB_2030 && user.usrGbCd eq adminConstants.USR_GB_2030}"> ${user.tel } </c:if>
						<input type="text" class="phoneNumber validate[custom[tel]]" name="tel" id="tel" title="<spring:message code="column.tel" />" value="${user.tel}" style="${adminSession.usrGbCd eq adminConstants.USR_GB_2030 && user.usrGbCd eq adminConstants.USR_GB_2030 ? 'display:none' : ''}" />
					</td>
				</tr>
				<tr>
					<!-- 휴대폰번호 -->
					<th><spring:message code="column.mobile" /><strong class="red">*</strong></th>
					<td colspan="3">
						<c:if test="${adminSession.usrGbCd eq adminConstants.USR_GB_2030 && user.usrGbCd eq adminConstants.USR_GB_2030}"> ${user.mobile } </c:if>
						<input type="text" class="required_item phoneNumber validate[custom[mobile]]" name="mobile" id="mobile" title="<spring:message code="column.mobile" />" value="${user.mobile}" style="${adminSession.usrGbCd eq adminConstants.USR_GB_2030 && user.usrGbCd eq adminConstants.USR_GB_2030 ? 'display:none' : ''}"/>
					</td>
				</tr>
				<tr>
					<!-- 이메일 -->
					<th><spring:message code="column.email" /><strong class="red">*</strong></th>
					<td colspan="3">
						<c:if test="${adminSession.usrGbCd eq adminConstants.USR_GB_2030 && user.usrGbCd eq adminConstants.USR_GB_2030}"> ${user.email } </c:if>
						<input type="text" class="required_item validate[custom[email2]] validate[maxSize[100]] " name="email" id="email" title="<spring:message code="column.email" />" value="${user.email}" style="${adminSession.usrGbCd eq adminConstants.USR_GB_2030 && user.usrGbCd eq adminConstants.USR_GB_2030 ? 'display:none' : ''}" />
					</td>
				</tr>
				<tr>
					<!-- IP -->
					<th><spring:message code="column.usr_ip" />	</th>
					<td colspan="3">
						<c:if test="${adminSession.usrGbCd eq adminConstants.USR_GB_2030 && user.usrGbCd eq adminConstants.USR_GB_2030}"> ${user.usrIp } </c:if>
						<input type="text" class="validate[custom[ipv4]] validate[maxSize[20]]" name="usrIp" id="usrIp" title="<spring:message code="column.usr_ip" />" value="${user.usrIp}" placeholder="Ex) 10.205.236.54" style="${adminSession.usrGbCd eq adminConstants.USR_GB_2030 && user.usrGbCd eq adminConstants.USR_GB_2030 ? 'display:none' : ''}" />
					</td>
				</tr>
				<tr>
					<!-- 유효기간 -->
					<th><spring:message code="column.vld_prd_cd" /><strong class="red">*</strong></th>
					<td colspan="3">
						<c:choose>
							<c:when test="${not empty user.usrNo && adminSession.usrGrpCd eq adminConstants.USR_GRP_20 && adminSession.usrNo eq user.usrNo }">
								${user.validStDtm } ~ ${user.validEnDtm }
							</c:when>
							<c:otherwise>
								<div id="validDtmDiv" name="validDtmDiv">	
									<frame:datepicker required="Y" startDate="validStDtm"	
											  startValue="${empty user.validStDtm ? frame:toDate('yyyy-MM-dd') : user.validStDtm }"
											  endDate="validEnDtm"
											  endValue="${empty user.validEnDtm ? frame:addMonth('yyyy-MM-dd', 12) : user.validEnDtm }"
											  />
								</div>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>	
						
			<c:if test="${not empty user.usrNo}">
				<tr>
					<!-- 최종 로그인 시간-->
					<th><spring:message code="column.last_login_dtm" /></th>
					<td colspan="3">
						${frame:getFormatTimestamp(user.lastLoginDtm, 'yyyy-MM-dd HH:mm:ss')}
					</td>
				</tr>
				<%-- <tr>
					<th><spring:message code="column.sys_regr_nm" /></th>
					<td colspan="3">
						${user.sysRegrNm}
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.sys_reg_dtm" /></th>
					<td colspan="3">
						<fmt:formatDate value="${user.sysRegDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.sys_updr_nm" /></th>
					<td colspan="3">
						${user.sysUpdrNm}
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.sys_upd_dtm" /></th>
					<td colspan="3">
						<fmt:formatDate value="${user.sysUpdDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>
				</tr> --%>
			</c:if>
			</tbody>
		</table>
		</form>

		<div class="btn_area_center">
		<c:if test="${empty user.usrNo}">
			<button type="button" onclick="userInsert();" class="btn btn-ok">등록</button>
			<button type="button" onclick="dataReset();" class="btn btn-cancel">초기화</button>
			<button type="button" onclick="closeTab();" class="btn btn-cancel">취소</button>
			
			<!-- TODO 조은지 : 테스트 사용자 다량등록을 위한 서비스이므로 추후 삭제 -->
<!-- 			<button type="button" onclick="imsiInsert();" class="btn btn-ok">다량등록</button> -->
		</c:if>
		<c:if test="${not empty user.usrNo}">
			<button style="${(adminSession.usrGrpCd eq adminConstants.USR_GRP_20 && adminSession.usrNo eq user.usrNo) ? 'display:none' : ''}" type="button" onclick="userUpdate();" class="btn btn-ok">저장</button>
			<button type="button" onclick="closeTab();" class="btn btn-cancel">목록</button>
		</c:if>
			
		</div>
	</t:putAttribute>
</t:insertDefinition>
