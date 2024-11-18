<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.include" value="script.member"/>
	<tiles:putAttribute name="script.inline">
`		<jsp:include page="/WEB-INF/tiles/include/js/gsr.jsp" />
		<!-- RSA 자바스크립트 라이브러리 -->
		<script type="text/javascript" src="/_script/jsbn.js"></script>
		<script type="text/javascript" src="/_script/rsa.js"></script>
		<script type="text/javascript" src="/_script/prng4.js"></script>
		<script type="text/javascript" src="/_script/rng.js"></script>
		<script type="text/javascript">
			var mbrState = "";
			var mbrNo = "";
			var bizNo = "";
			var isTag = "";
			var appReturnUrl = ""; //앱인 경우는 뒤로가기 시 해당 회원의 APP메인 페이지로 이동
			var gsptStateCd = "";
			var gsptUseYn = "";
			
			$(function() {
				if("${remember}" != null && "${remember}" != ''){
					$("#login_login_id").val("${remember}");
					$("#keepYn").attr("checked","checked");
				}
				
				if("${view.deviceGb}" != "PC"){
					$(".mo-heade-tit .tit").html("로그인");
					$(".mo-header-backNtn").attr("onclick", "fncGoBack();");
					$("#footer").remove();
					$(".menubar").remove();
					$(".header").addClass("noneAc")
				}
				
				//sns 로그인 시 유효성 체크 실패한 경우 & app자동로그인 시 상태체크 실패한 경우
				if("${snsExCode}" != null && "${snsExCode}" != ''){
					if("${snsExCode}" == "noInfoPBHR"){
						//기존 펫츠비 회원 중 폰번호,이메일 정보 둘다 없는 경우
						popAlert("기존 펫츠비회원은 고객센터(1644-9601)로 문의주세요");
						return;
					}
					if("${snsExCode}" != '${exceptionConstants.ERROR_CODE_LOGIN_PW_FAIL}') fncCheckLoginResult("${snsExCode}","${snsExMsg}")
				}
				
				//sns로그인 시 처음 로그인 페이지에서 갖고온 리턴 url로 보내주기 유효성체크 잘 통과한 경우
				if("${snsReturnUrl}" != null && "${snsReturnUrl}" != '' && "${snsExCode}" == null ){
					storageHist.replaceHist();
					
					var returnUrl = "${snsReturnUrl}";
					returnUrl = returnUrl.replace(/&amp;/gi, "&");
					location.href = returnUrl;
				}
				
				$("#login_login_id").focus();
				
				// Enter Key 이벤트
				$(".ipt").keyup(function() {
					if ( window.event.keyCode == 13 && $("#activeBtn").is(':visible') ) {
						login();
					}
				});
				
				//푸쉬토큰 app interface 호출
				if('${view.deviceGb}' == 'APP'){
					toNativeData.func = 'onPushToken';
					toNativeData.callback= 'appPushToken';
					toNative(toNativeData);
					
					//앱 설정정보 조회
					toNativeData.func = "onSettingInfos";
					toNativeData.callback = "appSettingInfosCallBack";
					toNative(toNativeData);
				}
			});
			
			//App 푸쉬토큰 콜백
			function appPushToken(data){
				var dataJson = JSON.parse(data);
				$("#appPushToken").val(dataJson.token);
			}
			
			//아이디 비번 입력 됐을 시 로그인 버튼 활성화
			$(document).on("keyup input paste",".ipt",function()  {
				if($("#login_login_id").val().length > 0 && $("#login_password").val().length > 0 ){
					//버튼 활성화
					$("#activeBtn").show();
					$("#inactiveBtn").hide();
				}else{
					//버튼 비활성화
					$("#inactiveBtn").show();
					$("#activeBtn").hide();
				}
				
				if($("#newErrMsg").css("display") != "none" ){
					$("#newErrMsg").hide();
				}
			});
			
			//인풋 엑스 시 이벤트 안먹혀서 설정
			$(document).on("click",".btnDel",function(){
				$("#inactiveBtn").show();
				$("#activeBtn").hide();
				$("#newErrMsg").hide();
			});
			
			/*로그인*/
			function login(){
				$("#newErrMsg").hide();
				
				var login_id = $("#login_login_id").val();
				var login_pswd = $("#login_password").val();
				if(login_id == ""){
					popAlert("<spring:message code='front.web.view.join.sns.login.id.msg'/>");
					$("#login_login_id").focus();
					return;
				}
				//아이디 공백입력시 메시지 노출
				else if(login_id.search(/\s/g) !== -1){
					$("#newErrMsg").show();
					$("#newErrMsg").html("<spring:message code='front.web.view.join.sns.login.id.msg'/>");
					return;
				}
				
				if(login_pswd == ""){
					popAlert("<spring:message code='front.web.view.join.sns.login.pwd.msg'/>");
					$("#login_password").focus();
					return;
				}
				
				login_id = login_id.replace(/\s/gi,"");
				login_pswd = login_pswd.replace(/\s/gi,"");
				
				//암호화 처리
				var rsa = new RSAKey();
				rsa.setPublic($("#RSAModulus").val(), $("#RSAExponent").val());
				var login_id_enc = rsa.encrypt(login_id);
				var login_pswd_enc = rsa.encrypt(login_pswd);
				$("#login_login_id").val(login_id_enc);
				$("#login_password").val(login_pswd_enc);
				
				var options = {
					url : "<spring:url value='/login' />",
					data : $("#login_form").serialize(),
					done : function(data){
						var loginCd = data.resultCode;
						var loginMsg = data.resultMsg;
						mbrNo = data.mbrNo;
						bizNo = data.petLog;
						isTag = data.tags;
						
						gsptStateCd = data.gsptStateCd;
						gsptUseYn = data.gsptUseYn;
						
						fncCheckLoginResult(loginCd, loginMsg, data)
					}
				};
				ajax.call(options);
				
				$("#login_login_id").val(login_id);
				$("#login_password").val(login_pswd);
			}
			
			//로그인 결과 처리
			function fncCheckLoginResult(loginCd, loginMsg, data){
				//하루 펫츠비 최초로그인
				if(loginCd == "PBHR"){
					location.href = "/login/indexPBHRMember";
					return;
				}
				
				if(loginCd == "${frontConstants.CONTROLLER_RESULT_CODE_SUCCESS}"){
					//로그인 app interface 호출
					appLoginPost();
					return;
				}else{
					if(loginCd == '${exceptionConstants.ERROR_CODE_LOGIN_PW_FAIL}' || loginCd == '${exceptionConstants.ERROR_CODE_LOGIN_ID_FAIL}'){
						//아디, 비번 올바르지 않은 경우
						$("#newErrMsg").show();
						return;
					}
					else if(loginCd == '${exceptionConstants.ERROR_CODE_LOGIN_SLEEP}'){
						//휴면상태일 경우
						mbrState =  '${frontConstants.MBR_STAT_30}';
						ui.confirm('<p>'+loginMsg+'</p>',{ // 컨펌 창 띄우기
							ycb:function(){
								mbrState =  '${frontConstants.MBR_STAT_30}';
								fncUpdateStat("");
							},
							ybt:"<spring:message code='front.web.view.common.msg.yes'/>",
							nbt:"<spring:message code='front.web.view.common.msg.no'/>"
						});
					}else if(loginCd == '${exceptionConstants.ERROR_CODE_LOGIN_DUPLICATE_PHONE}'){
						//번호 중복인 경우
						mbrState =  '${frontConstants.MBR_STAT_40}';
						fncDuplicatedMember(loginMsg);
					}else if( loginCd == '${exceptionConstants.ERROR_CODE_LOGIN_STOP}'){
						//정지 상태인 경우 - 지금은 없는 상태
						mbrState =  '${frontConstants.MBR_STAT_70}';
						ui.alert('<p>'+loginMsg+'</p>',{
							ycb:function(){
								//okCertPopup("01", mbrNo);//본인인증 팝업창 open
							},
							ybt:"<spring:message code='front.web.view.common.msg.confirmation'/>"
						});
						return;
					}else if(loginCd == '${exceptionConstants.ERROR_CODE_FO_PW_FAIL_CNT}'){
						//비번 오류횟수 초과인 경우
						popAlert(loginMsg, function(){
							location.href="/login/indexFindPswd";
						});
					}else if(loginCd == 'keyError'){
						//script 암호화 키값이 세션에 없는 경우는 로그인이 되지 않으므로 다시 새로고침한다.
						popAlert('오류가 발생되었습니다. 다시 시도하여 주십시오.', function(){
							location.href="/indexLogin";
						});
						return;
					}else{
						//부당거래정지 또는 다른 상태
						popAlert(loginMsg);
						return;
					}
				}
			}
			
			// 알럿창 띄우기
			var popAlert = function(msg, callback){
				ui.alert('<p>'+msg+'</p>',{
					ycb:callback,
					ybt:"<spring:message code='front.web.view.common.msg.confirmation'/>"
				});
			}
			
			/*휴면 해제 - 원래는 정지해제도 같이하는 함수였지만 정지상태는 지금은 없는 상태*/
			function fncUpdateStat(msg){
				$("#mbrNo").val(mbrNo);
				$("#mbrStatCd").val(mbrState);
				var options = {
					url : "<spring:url value='login/memberUpdateState' />",
					data : $("#login_form").serialize(),
					done : function(data){
						var resultCd = data.resultCode;
						if(resultCd == "${frontConstants.CONTROLLER_RESULT_CODE_SUCCESS}")
						{
							if(msg != "" )popAlert(msg, function(){location.href="/indexLogin";});
							else  ui.toast("<spring:message code='front.web.view.index.login.dormant.release'/>" , {ccb:function(){appLoginPost()}}); //휴면인 경우
							return;
						}
						else if(resultCd == "existMemberInfo"){
							popAlert("<spring:message code='front.web.view.index.login.duplicate.certificate1'/>"
									+"<U>"+data.existLoginId+"</U>"
									+"<spring:message code='front.web.view.index.login.duplicate.certificate2'/>");
						}else if(resultCd == "${frontConstants.CONTROLLER_RESULT_CODE_NOT_USE}"){
							popAlert("<spring:message code='front.web.view.index.login.certificate.member.info.nomatch'/>");
						}else if(resultCd == "${frontConstants.CONTROLLER_RESULT_CODE_FAIL}"){
							popAlert("<spring:message code='front.web.view.join.sns.exist.info.fail.msg.result.popup'/>");
						}
					}
				};
				ajax.call(options);
			}
			
			//중복인 경우 처리
			function fncDuplicatedMember(msg){
				popAlert(msg, function(){
					var input1 = "<input type='hidden' name='deviceToken' value='"+$("#appPushToken").val()+"' />";
					var input2 = "<input type='hidden' name='deviceTpCd' value='"+$("#deviceTpCd").val()+"' />";
					jQuery("<form action=\"/mypage/info/updateDulicatedMember\" method=\"post\">"+input1+input2+"<input type=\"hidden\" name=\"mbrNo\" value='"+mbrNo+"' /></form>").appendTo('body').submit();
					//jQuery("<form action=\"/mypage/info/updateDulicatedMember\" method=\"post\">"+input1+input2+""</form>").appendTo('body').submit();
				});
			}
			
			//기존에 해제된 sns 계정 다시 연동하기
			/* function fncReconnectSns(){
				var options = {
					url : "<spring:url value='login/reconnectSns' />",
					data : {
						snsUuid : mbrNo,
						deviceToken : $("#appPushToken").val(),
						deviceTpCd  : $("#deviceTpCd").val()
					},
					done : function(data){
						appLoginPost();
					}
				};
				ajax.call(options);
			} */
			
			
			/*	본인인증 콜백함수 -- 원래는 정지 ,중복상태 해제 시 본인인증이 필요했지만 현재는 제거*/
			/* function okCertCallback(result){
				var data = JSON.parse(result);
				
				var today = new Date();
				var yyyy = today.getFullYear();
				var mm = today.getMonth() < 9 ? "0" + (today.getMonth() + 1) : (today.getMonth() + 1); // getMonth()
				var dd  = today.getDate() < 10 ? "0" + today.getDate() : today.getDate();
				if(parseInt(yyyy+mm+dd) - parseInt(data.RSLT_BIRTHDAY) - 140000 < 0){
					popAlert("<spring:message code='front.web.view.index.login.msg.over.fourteen.only'/>", function(){location.href ="/indexLogin";});
					return;
				}
				
				//본인 인증 성공 시
				if(data.RSLT_CD == "B000"){
					$("#authJson").val(JSON.stringify(data));
					fncUpdateStat("<spring:message code='front.web.view.index.login.msg.certification.completed.relogin'/>");
				}
			}*/
			
			//app인 경우 로그인 처리
			function appLoginPost(){
				if('${view.deviceGb}' == 'APP'){
					toNativeData.func = 'onLogin';
					toNative(toNativeData);
					
					toNativeData.func = 'onFirstLaunch';
					toNativeData.callback= 'firstLaunchCallback';
					toNative(toNativeData);
				}else{
					//google analytics 호출
					login_data.method = "ABOUTPET";
					sendGtag('login');
					
					setReturnUrl();
				}
				
			}
			
			//최초 로그인 여부 체크하여 메인페이지 설정 -> 메인화면이 tv에서 shop으로 바꼈으므로 안해도 될 듯하다.
			function firstLaunchCallback(jsonData){
				var jdata = JSON.parse(jsonData);
				if(jdata.firstLaunch == "Y" && '${view.deviceGb}' == 'APP'){
					//실행
					var options = {
						url : "/setMainPathInApp",
						done : function(data){
							if(data != "F") {
								toNativeData.func = "onMainPage";
								toNativeData.type = data
								toNative(toNativeData);
								
								setReturnUrl();
							}
						}
					};
					ajax.call(options);
				}else{
					setReturnUrl();
				}
			}
			
			function setReturnUrl(){
				storageHist.replaceHist();
				
				var returnUrl = "${returnUrl}";
				
				if(returnUrl == ''){
					returnUrl = "/shop/home";
				}
				
				returnUrl = returnUrl.replace(/&amp;/gi, "&");
				
				//로그인이 안된상태에서 로그인이 필요한 페이지 진입 후 로그인 시 exMessage 붙는거 제거 - 2021.07.02 by dslee
				if(returnUrl.indexOf("&exMessage") > -1){
					returnUrl = returnUrl.substring(0, returnUrl.indexOf("&exMessage")-1);
				}
				
				if(isTag != '' && isTag == "no_tag"){
					returnUrl='/join/indexTag?returnUrl='+returnUrl;
				}
				
				if(bizNo != "" && bizNo > 0){
					returnUrl = "/log/home";
				}
				
				if( ( !gsptUseYn || gsptUseYn == "${frontConstants.USE_YN_N}" ) && gsptStateCd == null ){
					var config = {
						callBack : function(){
							//App이고 영상상세에서 진입시 onNewPage 호출로 수정
							var decodeReUrl = decodeURIComponent(returnUrl);
							if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true" && decodeReUrl.indexOf("/tv/series/indexTvDetail") > -1){
								var reUrl;
								if(decodeReUrl.indexOf("http") == -1){
									reUrl = "${view.stDomain}"+decodeReUrl;
								}else{
									reUrl = decodeReUrl;
								}
								// 데이터 세팅
								toNativeData.func = "onNewPage";
								toNativeData.type = "TV";
								toNativeData.url = reUrl;
								// 호출
								toNative(toNativeData);
								
								//history.go(-1);
								//storageHist.goBack();
								storageHist.getOut("${requestScope['javax.servlet.forward.servlet_path']}");
							}else if(decodeReUrl.indexOf("indexLive") > -1 ){
								storageHist.goHistoryBack(decodeReUrl); // 라이브방송인 경우 히스토리 뒤로가기로 처리함.
							}else{
								//location.href = decodeReUrl;
								storageHist.goBack(decodeReUrl);
							}
						}
						,	okCertCallBack : function(data){
							//App이고 영상상세에서 진입시 onNewPage 호출로 수정
							var decodeReUrl = decodeURIComponent(returnUrl);
							if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true" && decodeReUrl.indexOf("/tv/series/indexTvDetail") > -1){
								var reUrl;
								if(decodeReUrl.indexOf("http") == -1){
									reUrl = "${view.stDomain}"+decodeReUrl;
								}else{
									reUrl = decodeReUrl;
								}
								// 데이터 세팅
								toNativeData.func = "onNewPage";
								toNativeData.type = "TV";
								toNativeData.url = reUrl;
								// 호출
								toNative(toNativeData);
								
								//history.go(-1);
								//storageHist.goBack();
								storageHist.getOut("${requestScope['javax.servlet.forward.servlet_path']}");
							}else if(decodeReUrl.indexOf("indexLive") > -1 ){
								storageHist.goHistoryBack(decodeReUrl); // 라이브방송인 경우 히스토리 뒤로가기로 처리함.
							}else{
								//location.href = decodeReUrl;
								storageHist.goBack(decodeReUrl);
							}
						}
						,	ncb : function (){
							var decodeReUrl = decodeURIComponent(returnUrl);
							//App이고 영상상세에서 진입시 onNewPage 호출로 수정
							if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true" && decodeReUrl.indexOf("/tv/series/indexTvDetail") > -1){
								var reUrl;
								if(decodeReUrl.indexOf("http") == -1){
									reUrl = "${view.stDomain}"+decodeReUrl;
								}else{
									reUrl = decodeReUrl;
								}
								// 데이터 세팅
								toNativeData.func = "onNewPage";
								toNativeData.type = "TV";
								toNativeData.url = reUrl;
								// 호출
								toNative(toNativeData);
								
								//history.go(-1);
								//storageHist.goBack();
								storageHist.getOut("${requestScope['javax.servlet.forward.servlet_path']}");
							}else if(decodeReUrl.indexOf("indexLive") > -1 ){
								storageHist.goHistoryBack(decodeReUrl); // 라이브방송인 경우 히스토리 뒤로가기로 처리함.
							}else{
								//location.href = decodeReUrl;
								storageHist.goBack(decodeReUrl);
							}
						}
					};
					gk.open(config);
				}else{
					//App이고 영상상세에서 진입시 onNewPage 호출로 수정
					var decodeReUrl = decodeURIComponent(returnUrl);
					if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true" && decodeReUrl.indexOf("/tv/series/indexTvDetail") > -1){
						var reUrl;
						if(decodeReUrl.indexOf("http") == -1){
							reUrl = "${view.stDomain}"+decodeReUrl;
						}else{
							reUrl = decodeReUrl;
						}
						// 데이터 세팅
						toNativeData.func = "onNewPage";
						toNativeData.type = "TV";
						toNativeData.url = reUrl;
						// 호출
						toNative(toNativeData);
						
						//history.go(-1);
						//storageHist.goBack();
						storageHist.getOut("${requestScope['javax.servlet.forward.servlet_path']}");
					} else if (decodeReUrl.indexOf("/indexLive") > -1) {
						storageHist.goHistoryBack(decodeReUrl); // 라이브방송인 경우 히스토리 뒤로가기로 처리함.
					} else {
						//location.href = returnUrl;
						storageHist.goBack(decodeReUrl);
					}
				}
			}
			
			function appSettingInfosCallBack(result){
				var appSettingData = JSON.parse(result);
				var mainPage = appSettingData.mainPage;
				
				if(mainPage == "TV")		appReturnUrl = "/tv/home";
				else if(mainPage == "LOG")	appReturnUrl = "/log/home";
				else if(mainPage == "SHOP")	appReturnUrl = "/shop/home";
			}
			
			function fncGoBack(){
				storageHist.replaceHist();
				
				var returnUrl = "${returnUrl}";
				
				//App이고 영상상세에서 진입시 onNewPage 호출로 수정
				var decodeReUrl = decodeURIComponent(returnUrl);
				if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true" && decodeReUrl.indexOf("/tv/series/indexTvDetail") > -1){
					var reUrl;
					if(decodeReUrl.indexOf("http") == -1){
						reUrl = "${view.stDomain}"+decodeReUrl;
					}else{
						reUrl = decodeReUrl;
					}
					// 데이터 세팅
					toNativeData.func = "onNewPage";
					toNativeData.type = "TV";
					toNativeData.url = reUrl;
					// 호출
					toNative(toNativeData);
					
					//storageHist.goBack();
					storageHist.getOut("${requestScope['javax.servlet.forward.servlet_path']}");
				}else if(decodeReUrl.indexOf("indexLive") > -1 ){
					storageHist.goHistoryBack(decodeReUrl); // 라이브방송인 경우 히스토리 뒤로가기로 처리함.
				}else{
					//storageHist.goBack();
					storageHist.getOut("${requestScope['javax.servlet.forward.servlet_path']}");
				}
				
				/*if(appReturnUrl != "") {
					location.href = appReturnUrl;
				}else {
					location.href = "/tv/home";
				}*/
			}
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<!-- mobile header -->
		<!--<header class="header pc cu mode7" data-header="set9">
			<div class="hdr">
				<div class="inr">
					<div class="hdt">
						<button id ="backBtn" class="mo-header-backNtn" onclick = "goBack();" data-content="" data-url=""><spring:message code='front.web.view.common.msg.back'/></button>
						<div class="mo-heade-tit"><span class="tit"><spring:message code='front.web.view.login.popup.title'/></span></div>
					</div>
				</div>
			</div>
		</header> -->
		<!-- // mobile header -->
		
		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container page login srch" id="container">
			
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<!-- PC 타이틀 모바일에서 제거  -->
					<div class="pc-tit">
						<h2>로그인</h2>
					</div>
					<!-- // PC 타이틀 모바일에서 제거  -->
					<div class="fake-pop">
						<form id="login_form">
							<div class="pct">
								<div class="poptents">
									
									<!-- 회원 정보 입력 -->
									<input type="hidden" name="mbrNo" id="mbrNo" />
									<input type="hidden" name="mbrStatCd" id="mbrStatCd" />
									<input type="hidden" name="authJson" id="authJson"  />
									<input type="hidden" name="deviceToken" id="appPushToken"  />
									<input type="hidden" id="deviceTpCd" name="deviceTpCd" value="${view.os}" />
									
									<input type="hidden" id="RSAModulus" value="${RSAModulus}" />
									<input type="hidden" id="RSAExponent" value="${RSAExponent}" />
									
									<div class="member-input">
										<ul class="list">
											<li>
												<div class="input">
													<input type="text" class="ipt" name="loginId"  id="login_login_id" placeholder="<spring:message code='front.web.view.common.id.title'/>" autocomplete="new-password" maxlength="40">
												</div>
											</li>
											<li>
												<div class="input">
													<input type="password" class="ipt" name="pswd" id="login_password" placeholder="<spring:message code='front.web.view.common.pwd.title'/>" autocomplete="new-password" maxlength="15">
												</div>
												<p class="validation-check" id="newErrMsg" style="display: none;"><spring:message code='front.web.view.index.login.msg.recheck.id.or.pwd'/></p>
											</li>
										</ul>
									</div>
									<!-- // 회원 정보 입력 -->
								</div>
							</div>
							<c:if test="${view.deviceGb ne 'APP' }">
								<div class="check-wrap">
									<label class="checkbox">
										<input type="checkbox" name="keepYn" id="keepYn" value="Y" checked="checked"><span class="txt"><spring:message code='front.web.view.index.login.id.save'/></span>
									</label>
								</div>
							</c:if>
						</form>
						<div class="pbt pull">
							<div class="btnSet" id="inactiveBtn" >
								<a href="javascript:;" class="btn lg gray" ><spring:message code='front.web.view.login.popup.title'/></a>
							</div>
							<div class="btnSet" id="activeBtn" style="display:none;">
								<a href="javascript:login();" class="btn lg a" data-content="" data-url="" ><spring:message code='front.web.view.login.popup.title'/></a>
							</div>
						
						</div>
						
						<div class="lnk-set">
							<a href="/login/indexFindId" data-content="" data-url="/login/indexFindId" ><spring:message code='front.web.view.login.msg.find.id'/></a>
							<a href="/login/indexFindPswd" data-content="" data-url="/login/indexFindId" ><spring:message code='front.web.view.common.login.find.pwd.title'/></a>
							<a href="/join/indexTerms" data-content="" data-url="/join/indexTerms" ><spring:message code='front.web.view.common.join.title'/></a>
						</div>
						<dl class="sns-set mt50">
							<dt><spring:message code='front.web.view.index.login.msg.easy.login'/></dt>
							<dd>
								<span><a class="naver" href="javascript:snsLogin(${frontConstants.SNS_LNK_CD_10});" data-content="" data-url="" ><spring:message code='front.web.view.join.app.sns.login.link.naver'/></a></span>
								<span><a class="kakao" href="javascript:snsLogin(${frontConstants.SNS_LNK_CD_20});" data-content="" data-url="" ><spring:message code='front.web.view.join.app.sns.login.link.kakaotalk'/></a></span>
								<span><a class="google" href="javascript:snsLogin(${frontConstants.SNS_LNK_CD_30});" data-content="" data-url="" ><spring:message code='front.web.view.join.app.sns.login.link.google'/></a></span>
								<span><a class="apple" href="javascript:snsLogin(${frontConstants.SNS_LNK_CD_40});" data-content="" data-url="" ><spring:message code='front.web.view.join.app.sns.login.link.apple'/></a></span>
							</dd>
						</dl>
					</div>
				</div>
			
			</div>
		</main>
		<%-- <div class="member_wrap" id="content">
			<!-- 로그인 -->
			<div class="login_section">
				<h2 class="login_title">로그인</h2>
				<div class="input_area">
					<form id="login_form">
						<input type="text" id="login_login_id" class="login_input1 ipt" title="아이디" name="loginId" placeholder="아이디" />
						<input type="password" id="login_password" class="login_input2 ipt" title="비밀번호" name="pswd" placeholder="비밀번호" autocomplete="off"/>
						<p class="errMsgPwd" id="newErrMsg" style="display: none;" >아이디 또는 비밀번호가 일치하지 않습니다. 다시 입력해주세요.</p>
					</form>
					<a href="#" class="btn_login1" id="loginBtn" onclick="login();return false;">로그인</a>
				</div>
				<div class="add_text_box">
					<a href="#" onclick="pop.loginFind({});return false;">아이디/비밀번호 찾기</a>
					<span class="col">|</span>
					<a href="/join/indexTerms">회원가입</a>
				</div>
				<div id="content">
					<!-- 네이버 -->
					<button onclick="snsLogin(10)">네이버</button>
					<!-- 카카오 -->
					<button onclick="snsLogin(20)">카카오</button>
					<!-- 구글 -->
					<button onclick="snsLogin(30)">구글</button>
					<!-- 애플 -->
					<button onclick="snsLogin(40)">
						<img src="https://appleid.cdn-apple.com/appleid/button?color=white&border=true" />
					</button>

				</div>
				<c:if test="${not empty resultJson}">
					<h3> 결과</h3>
					<p>${resultJson}</p>
				</c:if>
			</div>
		</div> --%>
	</tiles:putAttribute>
</tiles:insertDefinition>