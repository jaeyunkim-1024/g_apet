<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.include" value="script.member"/>
	<tiles:putAttribute name="script.inline">  
		<style>
			.footer{ display : none;}
		</style>
		<script type="text/javascript">
			$(document).ready(function(){
				if("${view.deviceGb}" != "PC"){
					$(".mode0").remove();
					$("#footer").remove();
					$(".menubar").remove();
				}else{
					$(".mode7").remove();
				}			
				
				$(document).on("change input paste" , "#ctfLoginId" , function(){
					mobileCtfBtnControll();
				})
				
				$("#ctfLoginId").change();
				
				$('#ctfLoginId').on('focus', function(){
					$("#ctf_id_error").hide();
				});
			});
			
			function mobileCtfBtnControll(){
				if(!$("#ctfLoginId").val()){
					$("#mobileCtfBtn").addClass("disabled");
				}else{
					$("#mobileCtfBtn").removeClass("disabled");
				}
			}
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<body class="body">
			<div class="wrap" id="wrap">
				<!-- mobile header -->
				<header class="header pc cu mode7 noneAc" data-header="set9">
					<div class="hdr">
						<div class="inr">
							<div class="hdt">
								<button id ="backBtn" class="mo-header-backNtn" onclick="storageHist.goBack();" data-content="" data-url=""><spring:message code='front.web.view.common.msg.back'/></button>
								<div class="mo-heade-tit"><span class="tit"><spring:message code='front.web.view.common.login.find.pwd.title'/></span></div>
							</div>
						</div>
					</div>
				</header>
				<!-- // mobile header -->
		
			<!-- 바디 - 여기위로 템플릿 -->
			<main class="container page login srch" id="container">

			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<!-- PC 타이틀 모바일에서 제거  -->
					<div class="pc-tit">
						<h2><spring:message code='front.web.view.common.login.find.pwd.title'/></h2>
					</div>
					<!-- // PC 타이틀 모바일에서 제거  -->

					<!-- 탭있을때만 (클래스 추가 top) -->
					<div class="fake-pop top">
						<div class="result">
							<span class="blue"><spring:message code='front.web.view.common.pwd.title'/></span><spring:message code='front.web.view.find.id.msg.cannot.think'/>
							<p class="sub"><spring:message code='front.web.view.find.pwd.msg.new.pwd.set'/></p>
						</div>
					</div>
					
					<section class="sect petTabContent">
						<!-- 탭영역 -->
						<ul class="uiTab a mt50">
							<li class="active">
								<a class="bt" href="javascript:;" data-content="" data-url=""><span><spring:message code='front.web.view.find.id.msg.by.phone'/></span></a>
							</li>
							<li>
								<a class="bt" href="javascript:;" data-content="" data-url=""><span><spring:message code='front.web.view.find.id.msg.by.email'/></span></a>
							</li>
						</ul>

						<!-- 탭내용 -->
						<div class="uiTab_content">
							<ul>
								<li class="active">

									<!-- 아이디인증 -->
									<div class="result">
										<p class="sub left"><spring:message code='front.web.view.find.pwd.msg.certification.request.input.id'/></p>
									</div>
									<div class="member-input">
										<ul class="list">
											<li>
												<strong class="tit">아이디</strong>
												<div class="input del">
													<input type="text" id="ctfLoginId" placeholder="<spring:message code='front.web.view.join.sns.login.id.msg.no.dot'/>">
												</div>
												<p class="validation-check" id="ctf_id_error"><spring:message code='front.web.view.find.pwd.id.inconsistency'/></p>
											</li>
										</ul>
									</div>
									<div class="pbt mt30">
										<div class="btnSet">
											<a href="javascript:fncMobileCtf();" class="btn lg a" id="mobileCtfBtn" data-content="" data-url=""><spring:message code='front.web.view.certificate.mobile.msg.do.certificate'/></a>
										</div>
										<form id="find_form">
											<input type="hidden" name="authJson" id="authJson"/>
											<!-- <input type="hidden" name="mbrNm" id="sndMbrNm"/> -->
											<input type="hidden" name="email" id="sndEmail"/>
											<input type="hidden" name="loginId" id="sndLoginId"/>
										</form>
									</div>
								</li>
								<li>

									<!-- 이메일인증 -->
									<div class="member-input email mt30">
									<form id="pswd_find_email_form" method="post"> 
										<input type="hidden" name="pswdFindUseYn" id="pswdFindUseYn" value="Y"/>
										<ul class="list">
											<li>
												<strong class="tit"><spring:message code='front.web.view.common.id.title'/></strong>
												<div class="input">
													<input type="text" id="loginId" name="loginId"  placeholder="<spring:message code='front.web.view.join.sns.login.id.msg.no.dot'/>" maxlength="40"> 
												</div>
												<p class="validation-check" id="loginId-error"><spring:message code='front.web.view.join.sns.login.id.msg.no.dot'/></p>
											</li>
											<!-- <li>
												<strong class="tit">이름</strong>
												<div class="input">
													<input type="text" id="mbrNm" name="mbrNm"  placeholder="이름을 입력해주세요">
												</div>
												<p class="validation-check" id="mbrNm-error">이름을 입력해주세요</p>
											</li> -->
											<li>
												<strong class="tit"><spring:message code='front.web.view.common.email.title'/></strong>
												<div class="input flex">
													<input type="text"  id="email" name="email" placeholder="<spring:message code='front.web.view.certificate.email.msg.request.email'/>">
													<a href="javascript:fncSendEmail();" class="btn md" id="sendBtn" data-content="" data-url="" ><spring:message code='front.web.view.certificate.email.msg.send.email'/></a>
												</div>
												<p class="validation-check" id="email-error"><spring:message code='front.web.view.certificate.email.msg.request.email'/></p>
											</li>
											<li id="ctfArea">
												<strong class="tit"><spring:message code='front.web.view.common.email.certificate.number'/></strong>
												<div class="input flex" data-txt="<spring:message code='front.web.view.common.zipcode.search'/>">
													<input type="text" id="ctfNoInp" placeholder="<spring:message code='front.web.view.certificate.email.msg.request.certificate.number'/>">
													<div class="inputInfoTxt time" id="crtfCountDownArea">00:00</div>
													<a href="javascript:fncCheckOtp();" class="btn md" data-content="" data-url=""><spring:message code='front.web.view.certificate.email.msg.confirm.certificate'/></a>
												</div>
												<p class="validation-check" id="otp-error"><spring:message code='front.web.view.certificate.email.msg.request.certificate.number.wrong'/></p>
											</li>
										</ul>
									</div>

								</li>
							</ul>
						</div>
					</section>
					<style>
						#ctfArea input{padding-right: 45px !important;}
					</style>
				</div>

			</div>
		</main>
		
				<div class="layers">
					<!-- 레이어팝업 넣을 자리 -->
				</div>
				<script>
					var ctfNo = "";
					//var chkCnt = 0;
					
					$(document).ready(function(){
						$(".validation-check").hide();	
						$("#ctfArea").hide();
					});
					
					// 알럿창 띄우기
					var popAlert = function(msg,callback){
						ui.alert('<p>'+msg+'</p>',{
							ycb:callback,
							ybt:"<spring:message code='front.web.view.common.msg.confirmation'/>"
						});
					}
					
					//모바일 인증 창 open
					function fncMobileCtf(){
						var loginId = $("#ctfLoginId").val();
						if(loginId == "" ){
							$("#ctf_id_error").show();
							return;
						}
						
						//아이디 유무 체크
						var idCheck = true;
						validWhenBlur.loginId(loginId, function(){
								okCertPopup('01');
							}, function(){
								$("#ctf_id_error").show();
							}
						);
					}
					
					//본인인증 callback함수
					function okCertCallback(result){
	    				var data = JSON.parse(result);
						if(data.RSLT_CD != "B000") {
							//popAlert('잘못된 정보입니다. 다시 시도해 주세요.');
							return;
						}
						$("#authJson").val(JSON.stringify(data));
						$("#sndLoginId").val($("#ctfLoginId").val());
						
						var options = {
							url : "<spring:url value='/login/indexFindPswdCtfResult' />",
							data : $("#find_form").serialize(),
							done : function(data){
								if(data.resultCode == '${frontConstants.CONTROLLER_RESULT_CODE_NOT_USE}'){
									messager.toast({txt:"<spring:message code='front.web.view.find.id.nomatch'/>"});
									return;
								}else{
									storageHist.replaceHist();
									
									location.href = "/login/indexFindPswdResult";
								}
							}
						}
						ajax.call(options);
					}
					
					//이메일 전송
					function fncSendEmail(){
						$("#email-error").hide();
						$("#loginId-error").hide();
						
						var email = $("#email").val();
						var loginId = $("#loginId").val();
						
						if(loginId == ""){
							$("#loginId-error").show();
							return;
						}
						if(email == ""){
							$("#email-error").show();
							return;
						}
						
						var options = {
							url : "<spring:url value='/login/findMemberIdPswdEmail' />",
							data : $("#pswd_find_email_form").serialize(),
							done : function(data){
								if(data.resultCode == '${frontConstants.CONTROLLER_RESULT_CODE_NOT_USE}'){
									messager.toast({txt:"<spring:message code='front.web.view.find.id.nomatch'/>"});
									//$("#email-error").show();
									return;
								}
								messager.toast({txt:"<spring:message code='front.web.view.find.id.alert.sent.certificate.number.to.email'/>"});
								ctfNo = data.ctfNo;
								$("#ctfArea").show();
								
								$("#sendBtn").html("<spring:message code='front.web.view.common.resend.title'/>");
								
								
								// 인증 번호 입력 시간 카운트다운
							    var endTime = new Date();
							    endTime.setMinutes(endTime.getMinutes() + 3);
							    $("#crtfCountDownArea").countdown(endTime, function (event) {
							        var mm = event.strftime('%M');
							        var ss = event.strftime('%S');
							        $("#crtfCountDownArea").html(mm + ":" + ss);
							    }).on('finish.countdown', function () {
							    	popAlert("<spring:message code='front.web.view.find.id.alert.invalid.certificate.input.time'/>");
							    	$("#ctfArea").hide();
							    	$("#ctfNoInp").val("");
							    	$("#otp-error").hide(); 
							        //$("#ctfNoInp").attr('disabled', true);
							         ctfNo = "";
								});
							}
						}
						ajax.call(options);
							
					}
					
					//인증번호 체크
					function fncCheckOtp(){
						$("#otp-error").hide();
						var email = $("#email").val();
						
						var inputotp = $("#ctfNoInp").val();
						if(inputotp == ctfNo){
							$("#sndEmail").val(email);
							$("#find_form").attr("action", "/login/indexFindPswdEmailResult");
							$("#find_form").attr("method","post");  
							$("#find_form").submit(); 
						}else{
							/* chkCnt++ ;
							if(chkCnt > 2) {
								popAlert("<spring:message code='front.web.view.certificate.msg.recheck.certificatenumber'/>",function(){ location.href="/indexLogin"; });
			        			chkCnt = 0;
							}else{ */
								$("#otp-error").show();
							/* } */
						}
					}
				</script>
			</div>
		</body>
	</tiles:putAttribute>
</tiles:insertDefinition>

