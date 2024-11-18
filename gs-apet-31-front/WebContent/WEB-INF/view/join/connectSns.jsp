<tiles:insertDefinition name="common_my_mo">
<tiles:putAttribute name="script.include" value="script.member"/>
	<tiles:putAttribute name="script.inline">
	<style>
		#footer{
			display:none;
		}
		.inr{display:none;}
	</style>
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
	
		$(function(){
			if("${view.deviceGb}" != "PC"){
				$(".mode0").remove();
				$("#footer").remove();
				$(".menubar").remove();
			}else{
				$(".mode7").remove();
			}			
			
			$("#snsError").hide();
			$("#login_login_id").focus();
			
			$(".ipt").keypress(function() {
				if ( window.event.keyCode == 13 && $("#activeBtn").is(':visible')) {
					snsConnect();
				}
			});
			
			//푸쉬토큰 app interface 호출 
			if('${view.deviceGb}' == 'APP'){
				//alert("푸쉬토큰요청");
				toNativeData.func = 'onPushToken';
				toNativeData.callback= 'appPushToken';
				// 호출
				toNative(toNativeData); 
			}
		});
		
		//App 푸쉬토큰 콜백
		function appPushToken(data){
			var dataJson = JSON.parse(data);
			$("#appPushToken").val(dataJson.token);
		}
		
		//아이디 비번 입력 됐을 시 로그인 버튼 활성화
		$(document).on("input change paste keyup",".ipt",function()  {
			if($("#login_login_id").val().length > 0
					&& $("#login_password").val().length > 0){
				//버튼 활성화
				$("#activeBtn").show();
				$("#inactiveBtn").hide();
			}else{
				//버튼 비활성화
				$("#inactiveBtn").show();
				$("#activeBtn").hide();
			}
			
			if($("#snsError").css("display") != "none" ){
				$("#snsError").hide();
			}
		});
		
		//인풋 엑스 시 이벤트 안먹혀서 설정
		$(document).on("click",".btnDel",function(){
			$("#inactiveBtn").show();
			$("#activeBtn").hide();
			$("#newErrMsg").hide();
		});

		//로그인 아이디 입력 제한 ( 40 )
		$(document).on("input change paste","[name='loginId']",function(){
			validateTxtLength(this,40);
		});
		
		// 알럿창 띄우기
		var popAlert = function(msg, callback){
			ui.alert('<p>'+msg+'</p>',{
				ycb:callback,
				ybt:'확인'	
			});
		}
		
		//sns 연동 
		function snsConnect(){
			$("#snsError").hide();
			
			var login_id = $("#login_login_id").val();
			var login_pswd = $("#login_password").val();
			
			if(login_id == ""){
				popAlert("아이디를 입력해 주세요.");
				$("#login_login_id").focus();
				return;
			}

			if(login_pswd == ""){
				popAlert("비밀번호를 입력해 주세요.");
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
				url : "<spring:url value='/join/connectSnsMember' />",
				data : $("#sns_form").serialize(),
				done : function(data){
					var loginCd = data.resultCode;
					var loginMsg = data.resultMsg;
					mbrNo = data.mbrNo;
					bizNo = data.petLog;
					isTag = data.tags;
					
					//하루 펫츠비 최초로그인
					if(loginCd == "PBHR"){
						//location.href = "/login/indexPBHRMember";
						fncGoReplaceUrl("/login/indexPBHRMember");
						return;
					}
					
					if(data.resultCode == "${frontConstants.CONTROLLER_RESULT_CODE_SUCCESS}"){
						appLoginPost();
						return;
					}else{
						if(loginCd == '${exceptionConstants.ERROR_CODE_LOGIN_PW_FAIL}' || loginCd == '${exceptionConstants.ERROR_CODE_LOGIN_ID_FAIL}'){
							//아디, 비번 올바르지 않은 경우
							$("#snsError").show();
							return;
						}else if(data.resultCode == "notMatch"){
							//popAlert("아이디가 틀립니다. 아이디가 생각나지 않으시면 아이디 찾기를 해주세요.");
							$("#snsError").show();
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
								ybt:'확인',
								nbt:'취소'	
							}); 
						}else if(loginCd == '${exceptionConstants.ERROR_CODE_LOGIN_DUPLICATE_PHONE}'){
							//번호 중복인 경우 
							mbrState =  '${frontConstants.MBR_STAT_40}';
							fncDuplicatedMember(loginMsg, data.mbrNo);
						}else if( loginCd == '${exceptionConstants.ERROR_CODE_LOGIN_STOP}'){
							//정지 상태인 경우 - 지금은 없는 상태
							mbrState =  '${frontConstants.MBR_STAT_70}';
							ui.alert('<p>'+loginMsg+'</p>',{
								ycb:function(){
									//okCertPopup("01", data.mbrNo);//본인인증 팝업창 open
								},
								ybt:'확인'	
							}); 
							return;
						}else if(loginCd == '${exceptionConstants.ERROR_CODE_FO_PW_FAIL_CNT}'){
							//비번 오류횟수 초과인 경우
							ui.alert('<p>'+loginMsg+'</p>',{
								ycb:function(){
									//location.href="/login/indexFindPswd";
									fncGoReplaceUrl("/login/indexFindPswd");
								},
								ybt:'확인'	
							}); 
						}else{
							//부당거래정지 또는 다른 상태
							popAlert(loginMsg);
							return;
						}
					}
				}
			};
	
			ajax.call(options);
			$("#login_login_id").val(login_id);
			$("#login_password").val(login_pswd);
		}
		
		//중복인 경우 처리
		function fncDuplicatedMember(msg, mbrNo){
			popAlert(msg, function(){
				var input1 = "<input type='hidden' name='deviceToken' value='"+$("#appPushToken").val()+"' />";
				var input2 = "<input type='hidden' name='deviceTpCd' value='"+$("#deviceTpCd").val()+"' />";
				jQuery("<form action=\"/mypage/info/updateDulicatedMember\" method=\"post\">"+input1+input2+"<input type=\"hidden\" name=\"mbrNo\" value='"+mbrNo+"' /><input type=\"hidden\" name=\"loginPathCd\" value=${snsLnkCd} /></form>").appendTo('body').submit();
				//jQuery("<form action=\"/mypage/info/updateDulicatedMember\" method=\"post\">"+input1+input2+""</form>").appendTo('body').submit();
			});
		}
		
		/*휴면 해제 - 원래는 정지해제도 같이하는 함수였지만 정지상태는 지금은 없는 상태*/
		function fncUpdateStat(msg){
			$("#mbrNo").val(mbrNo);
			$("#mbrStatCd").val(mbrState);
			var options = {
				url : "<spring:url value='/login/memberUpdateState' />",
				data : $("#sns_form").serialize(),
				done : function(data){
					var resultCd = data.resultCode;
					if(resultCd == "${frontConstants.CONTROLLER_RESULT_CODE_SUCCESS}"){
						if(msg != "" )popAlert(msg, function(){location.href="/indexLogin";});
						else  ui.toast("<spring:message code='front.web.view.index.login.dormant.release'/>" , {ccb:function(){appLoginPost()}}); //휴면인 경우
						return;
					}else if(resultCd == "existMemberInfo"){
						popAlert("고객님이 이전에 본인인증 했던<br/>아이디를 찾았습니다.<br/><U>"+data.existLoginId+"</U>로 로그인해서 이용해주세요."); 							
					}else if(resultCd == "${frontConstants.CONTROLLER_RESULT_CODE_NOT_USE}"){
						popAlert("인증정보가 회원정보와 일치하지 않습니다.");
					}else if(resultCd == "${frontConstants.CONTROLLER_RESULT_CODE_FAIL}"){
						popAlert("회원정보가 존재하지 않습니다. 고객센터로 문의해 주세요");
					}
				}
			};

			ajax.call(options);
		}
		
		//본인인증 콜백함수
	    /*function okCertCallback(result){
	    	var data = JSON.parse(result);
			
			//본인 인증 성공 시
			if(data.RSLT_CD == "B000"){
				$("#authJson").val(JSON.stringify(data));
				fncUpdateStat("인증되었습니다. 다시 시도 해주세요.");
			}				
		}*/
		
		//app인 경우 로그인 처리
		function appLoginPost(){
			
			var loginID = $("#login_login_id").val();
			var snsNm = "";
			var method = "";
			if("${snsLnkCd}"== "${frontConstants.SNS_LNK_CD_10}") {snsNm = "네이버"; method="NAVER";} 
			else if("${snsLnkCd}"== "${frontConstants.SNS_LNK_CD_20}") {snsNm = "카카오";  method="KAKAO";} 
			else if("${snsLnkCd}"== "${frontConstants.SNS_LNK_CD_30}") {snsNm = "구글";  method="GOOGLE";} 
			else if("${snsLnkCd}"== "${frontConstants.SNS_LNK_CD_40}") {snsNm = "애플";  method="APPLE";} 
			
			
			if('${view.deviceGb}' == 'APP'){
				toNativeData.func = 'onLogin';
				toNative(toNativeData);
			}else{
				//google analytics 호출
				login_data.method = method;
				sendGtag('login');
			}
			
			var returnUrl = '${returnUrl}';
			returnUrl = returnUrl.replace(/&amp;/gi, "&");
			
			if(returnUrl == '' && bizNo != '' && bizNo > 0){
				returnUrl = '/log/home';
			}else if(returnUrl == ''){
				returnUrl = '/shop/home/';
			}
			
			if(isTag != null && isTag == "no_tag"){
				returnUrl='/join/indexTag?returnUrl=/shop/home/';   
			}
			
			messager.toast({txt : "회원님의 아이디("+loginID+")와 "+snsNm+" 계정이 연결되었습니다."});
			
			setTimeout(function(){
				//location.href = returnUrl;
				fncGoReplaceUrl(returnUrl);
			},2000);
			
			return;
		}
		
		function fncGoReplaceUrl(url){
			storageHist.replaceHist();
			
			location.href = url;
		}
	</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">	
		<body class="body">
		<div class="wrap" id="wrap">
	
			<!-- mobile header -->
			<header class="header pc cu mode7" data-header="set9">
				<div class="hdr">
					<div class="inr">
						<div class="hdt">
							<!--<button id ="backBtn" class="mo-header-backNtn" onclick = "history.go(-1)" data-content="" data-url="history.go(-1)">뒤로</button>-->
							<button id ="backBtn" class="mo-header-backNtn" onclick="storageHist.goBack();" data-content="" data-url="">뒤로</button>
							<div class="mo-heade-tit"><span class="tit">계정 연동 로그인</span></div>
						</div>
					</div>
				</div>
			</header>
			
			<!-- 바디 - 여기위로 템플릿 -->
			<main class="container page login srch" id="container">
	
				<div class="inr">
					<!-- 본문 -->
					<div class="contents" id="contents">
						<!-- PC 타이틀 모바일에서 제거  -->
						<div class="pc-tit">
							<h2>계정 연동 로그인</h2>
						</div>
						<!-- // PC 타이틀 모바일에서 제거  -->
						
						<div class="fake-pop top">
							<div class="result">
								이미 <span class="blue">어바웃펫</span> 회원입니다.
								<p class="sub">${maskingId} 계정으로 로그인 하시면<br>
								<c:if test="${snsLnkCd == frontConstants.SNS_LNK_CD_10 }">네이버</c:if>
								<c:if test="${snsLnkCd == frontConstants.SNS_LNK_CD_20 }">카카오</c:if>
								<c:if test="${snsLnkCd == frontConstants.SNS_LNK_CD_30 }">구글</c:if>
								<c:if test="${snsLnkCd == frontConstants.SNS_LNK_CD_40 }">애플</c:if>
								 아이디 계정과 자동으로 연결됩니다.</p>
							</div>
	
							<div class="pct">
								<div class="poptents">
								
									<!-- 회원 정보 입력 -->
									<div class="member-input idpw mt60">
									<form id="sns_form">
										<input type="hidden" name="mbrNo" id="mbrNo" /> 
										<input type="hidden" name="mbrStatCd" id="mbrStatCd"/> 
										<input type="hidden" name="authJson" id="authJson"  />
										<input type="hidden" id="deviceTpCd" name="deviceTpCd" value="${view.os}" />
										<input type="hidden" name="deviceToken" id="appPushToken"  /> 
										
										<input type="hidden" id="RSAModulus" value="${RSAModulus}" />
										<input type="hidden" id="RSAExponent" value="${RSAExponent}" />
										
										<ul class="list">
											<li>
												<div class="input">
													<input type="text"  class="ipt" id="login_login_id" name="loginId"  placeholder="아이디">
												</div>
											</li>
											<li>
												<div class="input">
													<input type="password" class="ipt" id="login_password" name="pswd" placeholder="비밀번호" maxlength="15" autocomplete="new-password">
												</div>
												<p class="validation-check" id="snsError"><spring:message code='front.web.view.join.sns.login.pwd.msg'/></p>
											</li>
										</ul>
										</form>
									</div>
									<!-- // 회원 정보 입력 -->
								</div>
							</div>
							<div class="pbt pull mt30">
								<div class="btnSet" id="inactiveBtn" >
									<a href="javascript:;" class="btn lg gray" data-content="" data-url="">로그인</a>
								</div>
								<div class="btnSet" id="activeBtn" style="display:none;">
									<a href="javascript:snsConnect();" class="btn lg a" data-content="" data-url="">로그인</a>
								</div>
							</div>
							
							
							<div class="lnk-set">
								<a href="#" onclick="fncGoReplaceUrl('/login/indexFindId'); return false;" data-content="" data-url="/login/indexFindId">아이디 찾기</a>
								<a href="#" onclick="fncGoReplaceUrl('/login/indexFindPswd'); return false;" data-content="" data-url="/login/indexFindPswd">비밀번호 찾기</a>
								<a href="#" onclick="fncGoReplaceUrl('/join/indexTerms?header=Y'); return false;" data-content="" data-url="/join/indexTerms?header=Y">회원가입</a>
							</div>
						</div>
					</div>
	
				</div>
			</main>
			</div>
			</body>
	</tiles:putAttribute>
</tiles:insertDefinition>