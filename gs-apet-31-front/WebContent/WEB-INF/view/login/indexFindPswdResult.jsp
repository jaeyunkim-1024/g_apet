<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.include" value="script.member"/>
	<tiles:putAttribute name="script.inline">  
	<!-- RSA 자바스크립트 라이브러리 -->
	<script type="text/javascript" src="/_script/jsbn.js"></script>
	<script type="text/javascript" src="/_script/rsa.js"></script>
	<script type="text/javascript" src="/_script/prng4.js"></script>
	<script type="text/javascript" src="/_script/rng.js"></script>	
	
		<script type="text/javascript">
			$(document).ready(function(){
				if("${view.deviceGb}" != "PC"){
					$(".mode0").remove();
					$("#footer").remove();
					$(".menubar").remove();
				}else{
					$(".mode7").remove();
				}			
			});
			
			/* $(document).on("input change paste",".inputPswd",function(){
				validateTxtLength(this,15);
			}); */
			
			$(function(){
				//새 비밀번호 확인 메세지 
				$(document).on('blur', "#newPswdCheck", function(){
					if($("#newPswdCheck").val() != $("#newPswd").val()){
						
						$("#newPswdCheck_error").html("<spring:message code='front.web.view.join.pwd.input.same_pwd.check'/>");
						return false;
					}else{
						$("#newPswdCheck_error").html("");
					}
				});
				
				//글자수 제한 15자 초과
				$(document).on('keyup', "#newPswd",function(){
					$("#newPswd").val($("#newPswd").val().substring(0,15));
					 
				});
				
				//글자수 제한 15자 초과
				$(document).on('keyup', "#newPswdCheck",function(){
					$("#newPswdCheck").val($("#newPswdCheck").val().substring(0,15));
					 
				});
			});
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
								<!--<button id ="backBtn" class="mo-header-backNtn" onclick = "history.go(-1);" data-content="" data-url="history.go(-1)"><spring:message code='front.web.view.common.msg.back'/></button>-->
								<button id ="backBtn" class="mo-header-backNtn" onclick="storageHist.goBack();" data-content="" data-url=""><spring:message code='front.web.view.common.msg.back'/></button>
								<div class="mo-heade-tit"><span class="tit"><spring:message code='front.web.view.find.pwd.result.set.pwd'/></span></div>
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
								<h2>비밀번호 설정</h2>
							</div>
		
							<div class="fake-pop">
								<input type="hidden" id="RSAModulus" value="${RSAModulus}" />
								<input type="hidden" id="RSAExponent" value="${RSAExponent}" />
								<div class="result">
									<p class="sub"><spring:message code='front.web.view.find.pwd.result.msg.register.new.pwd'/></p>
								</div>
								
								<form id="pswdForm">
								<div class="member-input email mt60">
									<ul class="list">
										<li>
											<strong class="tit"><spring:message code='front.web.view.find.pwd.result.new.pwd'/></strong>
											<div class="input">
												<input type="password" class="inputPswd" id="newPswd" name="newPswd" onblur="fncPswdCheck()" placeholder="<spring:message code='front.web.view.find.pwd.result.pwd.rule'/>" autocomplete="new-password">
											</div>
											<p class="validation-check" id="newPswd_error"></p>
										</li>
										<li>
											<strong class="tit"><spring:message code='front.web.view.find.pwd.result.new.pwd.check'/></strong>
											<div class="input">
												<input type="password" class="inputPswd" id="newPswdCheck" placeholder="<spring:message code='front.web.view.find.pwd.result.new.pwd.retype'/>" autocomplete="new-password">
											</div>
											<p class="validation-check" id="newPswdCheck_error" ></p>
										</li>
									</ul>
								</div>
								</form>
								<div class="pbt mt30">
									<!-- <div class="btnSet">
										<a href="javascript:alert_sample();" id="updateBtn" class="btn lg a">변경하기</a>
									</div> -->
									<div class="btnSet">
										<a href="javascript:fncUpdatePswd();" id="updateBtn" class="btn lg a gray"  data-content="" data-url="" disabled><spring:message code='front.web.view.common.msg.completed'/></a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</main>
		
				<div class="layers">
					<!-- 레이어팝업 넣을 자리 -->
				</div>
				<script>
				$(document).ready(function(){
					
					//다 입력된 경우 변경 버튼 활성화
					$(".inputPswd").on('keyup', function(e) {
						if($("#newPswd").val() != "" && $("#newPswdCheck").val()  != ""){
							//버튼 활성화
							$("#updateBtn").attr("disabled",false);
							$("#updateBtn").attr("class","btn lg a") ;
						
						}else{
							//버튼 비활성화
							$("#updateBtn").attr("disabled",true);
							$("#updateBtn").attr("class","btn lg a gray") ;
						}
					});
					
				});
				
				// 알럿창 띄우기
				var popAlert = function(msg, callback){
					ui.alert('<p>'+msg+'</p>',{
						//보안성검사결과처리. 불필요한 코드 (비어있는 함수) 제거		
						ybt:"<spring:message code='front.web.view.common.msg.confirmation'/>"
					});
				}
				
				//비밀번호 변경
				function fncUpdatePswd(){
					if(fncPswdCheck()){
						
						var newPswd = $("#newPswd").val();
						
						var rsa = new RSAKey();
						rsa.setPublic($("#RSAModulus").val(), $("#RSAExponent").val());
						var newPswd_enc = rsa.encrypt(newPswd);
						$("#newPswd").val(newPswd_enc);
						
						var options = {
								url: "<spring:url value='/login/updateMemberPassword' />",
								data : $("#pswdForm").serialize(),
								done : function(data){
									if(data.resultCode == 'duplicated'){
										ui.toast("<spring:message code='front.web.view.find.pwd.result.cannot.use.same.pwd'/>"); // 체크하는게 맞는지 노확실
									}else{
										//popAlert('비밀번호가 변경되었습니다.<br/>로그인 후 이용해주세요', 'callback');
										messager.toast({txt:"<spring:message code='front.web.view.find.pwd.result.pwd.change.completed'/>"});
										setTimeout(function(){
											location.href = "/indexLogin";
										},2000);
									}
								}
						}
						ajax.call(options);
						$("#newPswd").val(newPswd);
					}
				}
				
				//유효성 체크
				function fncPswdCheck(){
					$("#newPswd_error").html("");
					$("#newPswdCheck_error").html("");
					
					if($("#newPswd").val() == ""){
						$("#newPswd_error").html("<spring:message code='front.web.view.join.pwd.input.validate.check1'/>");
						//$("#newPswd").focus();
						return false;
					}
					 
					if($("#newPswd").val().search(/\s/) !== -1 || $("#newPswd").val().search(/[|]/gi) !== -1){
						$("#newPswd_error").html("<spring:message code='front.web.view.find.pwd.result.pwd.restriction'/>");
						//$("#newPswd").focus();
						return false;
					}
					
					var pswdCheck = pswdValid.checkPswd($("#newPswd").val());
					//$("#newPswd").val($("#newPswd").val().substring(0,15));
					if(pswdCheck == "falseLength"){
						$("#newPswd_error").html("<spring:message code='front.web.view.join.pwd.input.validate.check1'/>");
						//$("#newPswd").focus();
						return false;
					}
					
					if(pswdCheck == "falseCheck" || $("#newPswd").val().search(/\s/) !== -1){
						$("#newPswd_error").html("<spring:message code='front.web.view.join.pwd.input.validate.check2'/>");
						//$("#newPswd").focus();
						return false;
						
					}
					
					if(!pswdValid.checkPswdMatch($("#newPswd").val())){
						$("#newPswd_error").html("<spring:message code='front.web.view.join.pwd.input.validate.check3'/>");
						//$("#newPswd").focus();
						return false;
					}
					
					if(!pswdValid.checkIncludeIdValue($("#newPswd").val(),"${member.loginId}")
							|| !pswdValid.checkIncludeIdValue($("#newPswd").val(), "${member.mobile}") ) {
						$("#newPswd_error").html("<spring:message code='front.web.view.join.pwd.input.validate.add.msg.check5'/>");
						//$("#newPswd").focus();
						return false;
					}
			
					if(!pswdValid.checkIncludeIdValue($("#newPswd").val(), "${member.birth}")){
						$("#newPswd_error").html("<spring:message code='front.web.view.join.pwd.input.validate.check6'/>");
						//$("#newPswd").focus();
						return false;
					}
					
					if($("#newPswdCheck").val() != $("#newPswd").val()){
						$("#newPswdCheck_error").html("<spring:message code='front.web.view.join.pwd.input.same_pwd.check'/>");
						//$("#newPswdCheck").focus();
						return false;
					}
					
					if($("#newPswdCheck").val() == ""){
						$("#newPswdCheck_error").html("<spring:message code='front.web.view.join.pwd.input.same_pwd.check'/>");
						//$("#newPswdCheck").focus();
						return false;
					}
			
					return true;
				}
				</script>
			</div>
		</body>
	</tiles:putAttribute>
</tiles:insertDefinition>