<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.inline">  
		<style>.footer{display:none;}</style>
		<!-- RSA 자바스크립트 라이브러리 -->
		<script type="text/javascript" src="/_script/jsbn.js"></script>
		<script type="text/javascript" src="/_script/rsa.js"></script>
		<script type="text/javascript" src="/_script/prng4.js"></script>
		<script type="text/javascript" src="/_script/rng.js"></script>	
		<script type="text/javascript">
			$(document).ready(function(){
				if("${view.deviceGb}" != "PC"){
					$(".mode0").remove();
					$(".footer").remove();
					$(".menubar").remove();
				}else{
					$(".mode7").remove();
				}			
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
								<button id ="backBtn" class="mo-header-backNtn" onclick = "location.href='/log/partnerPswdUpdate?returnUrl=/log/home'" data-content="" data-url="/log/partnerPswdUpdate">뒤로</button>
								<div class="mo-heade-tit"><span class="tit">비밀번호 설정</span></div>
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
									<p class="sub">회원님의 소중한 개인정보 보호를 위해<br> 새로운 비밀번호를 등록해주세요.</p>
								</div>
								
								<form id="pswdForm">
								<div class="member-input email mt60">
									<ul class="list">
										<li>
											<strong class="tit">새 비밀번호</strong>
											<div class="input del">
												<input type="password" class="inputPswd" id="newPswd" name="newPswd" placeholder="영문, 숫자, 특수문자 포함 8자 이상 " autocomplete="new-password" maxlength="15">
											</div>
											<p class="validation-check" id="newPswd_error"></p>
										</li>
										<li>
											<strong class="tit">새 비밀번호 확인</strong>
											<div class="input del">
												<input type="password" class="inputPswd" id="newPswdCheck" placeholder="비밀번호를 다시 한번 입력해주세요" autocomplete="new-password" maxlength="15">
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
										<a href="javascript:fncUpdatePswd();" id="updateBtn" class="btn lg a gray"  data-content="" data-url="" disabled>완료</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</main>
				
				 <!-- 플로팅 영역 -->
		        <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}" >
					<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
			        	<jsp:param name="floating" value="" />
			        </jsp:include>
		        </c:if>
		
				<div class="layers">
					<!-- 레이어팝업 넣을 자리 -->
				</div>
				<script>
				$(document).ready(function(){
					
					//다 입력된 경우 변경 버튼 활성화
					$(".inputPswd").on('keyup', function(e) {
						if($("#newPswd_error").html() != "" ||  $("#newPswdCheck_error").html() != ""){
							$("#newPswd_error").html("")
							$("#newPswdCheck_error").html("");
						}
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

					$(document).on("blur","#newPswd",function(){
						fncPswdCheck();
					});
					$(document).on("blur","#newPswdCheck",function(){
						if($("#newPswdCheck").val() != $("#newPswd").val()){
							$("#newPswdCheck_error").html("동일한 비밀번호를 입력해주세요.");
							//$("#newPswdCheck").focus();
						}
					});
				});
				
				// 알럿창 띄우기
				var popAlert = function(msg, callback){
					ui.toast('<p>'+msg+'</p>',{
						ccb:function(){
							if(callback.length > 0){
								location.href="/log/home";
							}
						},
						ybt:'확인'	
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
								url: "<spring:url value='/mypage/info/updateMemberPassword' />",
								data : $("#pswdForm").serialize(),
								done : function(data){
									if(data.resultCode == '${frontConstants.CONTROLLER_RESULT_CODE_FAIL}'){
										popAlert('오류가 발생되었습니다. 관리자에게 문의하십시요.');
										return;
									}
									else if(data.resultCode == 'duplicated'){
										$("#newPswd_error").html('이전에 사용된 비밀번호는 사용하실 수 없어요.'); // 체크하는게 맞는지 노확실
									}else{
										popAlert('비밀번호가 변경되었어요.', 'callback');
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
						$("#newPswd_error").html("비밀번호를 입력해주세요.");
						$("#newPswd").focus();
						return false;
					}
					 
					if($("#newPswd").val().search(/\s/) !== -1 || $("#newPswd").val().search(/[|]/gi) !== -1){
						$("#newPswd_error").html("공백이나 제한된 특수문자는 사용하실 수 없어요");
						$("#newPswd").focus();
						return false;
					}
					
					var pswdCheck = pswdValid.checkPswd($("#newPswd").val());
					if(pswdCheck == "falseLength"){
						$("#newPswd_error").html("8~15자 이내로 입력해주세요.");
						$("#newPswd").focus();
						return false;
					}
					
					if(pswdCheck == "falseCheck" || $("#newPswd").val().search(/\s/) !== -1){
						$("#newPswd_error").html("영문, 숫자, 특수문자를 각각 1자리 이상 포함해주세요");
						$("#newPswd").focus();
						return false;
						
					}
					
					if(!pswdValid.checkPswdMatch($("#newPswd").val())){
						$("#newPswd_error").html("3자리 연속 반복된 문자가 숫자는 입력할 수 없어요");
						$("#newPswd").focus();
						return false;
					}
					
					if(!pswdValid.checkIncludeIdValue($("#newPswd").val(),"${memberId}") ) {
						$("#newPswd_error").html("아이디와 4자 이상 동일할 수 없어요.");
						$("#newPswd").focus();
						return false;
					}
			
					/* if(!pswdValid.checkIncludeIdValue($("#newPswd").val(), "${member.birth}")){
						$("#newPswd_error").html("생년월일과 4자 이상 동일할 수 없습니다.");
						$("#newPswd").focus();
						return false;
					} */
			
					if($("#newPswdCheck").val() != $("#newPswd").val()){
						$("#newPswdCheck_error").html("동일한 비밀번호를 입력해주세요.");
						$("#newPswdCheck").focus();
						return false;
					}
					
					return true;
					
				}
				</script>
			</div>
		</body>
	</tiles:putAttribute>
</tiles:insertDefinition>

