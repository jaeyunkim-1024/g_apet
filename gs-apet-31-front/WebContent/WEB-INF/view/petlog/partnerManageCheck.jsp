<tiles:insertDefinition name="mypage">
	<tiles:putAttribute name="script.inline">
		<!-- RSA 자바스크립트 라이브러리 -->
		<script type="text/javascript" src="/_script/jsbn.js"></script>
		<script type="text/javascript" src="/_script/rsa.js"></script>
		<script type="text/javascript" src="/_script/prng4.js"></script>
		<script type="text/javascript" src="/_script/rng.js"></script>	
	
		<script type="text/javascript">
			/*
			 * 비밀번호 체크
			 */
			function checkMemberPassword(){
				if(!$("#manage_chk_pswd").val()){
					return;
				}
				$("#errorMsg").hide();
				
				var pwdVal = $("#manage_chk_pswd").val();
				
				var rsa = new RSAKey();
				rsa.setPublic($("#RSAModulus").val(), $("#RSAExponent").val());
				var pswd_enc = rsa.encrypt(pwdVal);

				var options = {
					url : "<spring:url value='/log/checkPartnerPassword' />",
					data : {
						pswd : pswd_enc,
					},
					done : function(data){
						var checkCode = data.checkCode;
						var resultCode = data.resultCode;
						var type = data.type;
						if(resultCode == "${frontConstants.CONTROLLER_RESULT_CODE_SUCCESS}"){
							waiting.start();
							$("#checkForm #type").val(type);
							$("#checkForm #checkCode").val(checkCode);
							document.getElementById("checkForm").submit();
						}else if(resultCode == "keyError"){
							ui.alert('<p>오류가 발생되었습니다. 다시 시도하여 주십시오.</p>',{
								ycb:function(){location.reload();},
								ybt:"<spring:message code='front.web.view.common.msg.confirmation'/>"	
							});
							return;	
						}else{
							$("#errorMsg").text("<spring:message code='front.web.view.mypage.info.msg.password.fail'/>").show();
						}
					}
				};
				ajax.call(options);
			}

			function goBack(){
				var url = $("#goBackBtn").data("url");
				window.location.href=url;
			}

			$(function(){
				
				if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10}"){
					$(".menubar").remove();
					$("#footer").remove();
				}
				
				if($("#checkCode").val() != ""){
					waiting.start();
					$("html").hide();
					document.getElementById("checkForm").submit();
				}

				$(document).on("input paste change","#manage_chk_pswd",function(){
					var length = $("#manage_chk_pswd").val().length;
					if(length > 0){
						$("#confirmBtn a").removeClass("gray");
						$("#confirmBtn a").attr("href","javascript:checkMemberPassword();");
						$("#confirmBtn a").removeAttr("disabled");
					}else{
						$("#confirmBtn a").addClass("gray");
						$("#confirmBtn a").attr("href","#");
						$("#confirmBtn a").attr("disabled","");
					}
					
					if($("#errorMsg").css("display") != "none" ){
						$("#errorMsg").hide();
					}
				}).on("keyup","#manage_chk_pswd",function(e){
					if ( e.keyCode == 13 ) {
						checkMemberPassword();
					}
				}).on("blur","#manage_chk_pswd",function(){
					if($("#manage_chk_pswd").val() == ""){
						$("#errorMsg").text("비밀번호를 다시 확인해주세요.").show();
					}
				});
				
				//인풋 엑스 시 이벤트 안먹혀서 설정
				$(document).on("click",".btnDel",function(){
					$("#confirmBtn a").addClass("gray");
					$("#confirmBtn a").attr("href","#");
					$("#confirmBtn a").attr("disabled","");
					$("#errorMsg").hide();
				});
				
			})
		</script>
	</tiles:putAttribute>

	<tiles:putAttribute name="content">
		<main class="container page login srch" id="container">
			<div class="header pageHead heightNone">
				<div class="inr">
					<div class="hdt">
						<button class="back" id="goBackBtn" type="button" onclick="goBack();" data-content="" data-url="/log/home">뒤로가기</button>
					</div>
					<div class="cent t2"><h2 class="subtit">비밀번호 확인</h2></div>
				</div>
			</div>

			<div style="display:none;">
				<input type="hidden" id="RSAModulus" value="${RSAModulus}" />
				<input type="hidden" id="RSAExponent" value="${RSAExponent}" />
				<form action="/log/partnerPswdSet?returnUrl=/log/home" method="POST" id="checkForm">
					<input type="text" name="checkCode" id="checkCode" value="${checkCode}"/>
					<c:choose>
						<c:when test="${not empty checkCode}">
							<input type="text" name="type" id="type" value="${frontConstants.PSWD_CHECK_TYPE_INFO}" />
						</c:when>
						<c:otherwise>
							<input type="text" name="type" id="type" value="" />
						</c:otherwise>
					</c:choose>
				</form>
			</div>

			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">

					<!-- PC 타이틀 모바일에서 제거  -->
					<div class="pc-tit">
						<h2>비밀번호 확인</h2>
					</div>
					<!-- // PC 타이틀 모바일에서 제거  -->

					<div class="fake-pop">
						<div class="result">
							<p class="sub">회원님의 소중한 개인정보 보호를 위해<br> 비밀번호 확인 후 변경이 가능합니다.</p>
						</div>

						<div class="member-input email mt60">
							<ul class="list">
								<li>
									<div class="input del">
										<input type="password" id="manage_chk_pswd" placeholder="비밀번호를 입력해주세요" autocomplete="new-password"  maxlength="20">
									</div>
									<p class="validation-check" id="errorMsg" style="display:none;">error message</p>
								</li>
							</ul>
						</div>
						<div class="pbt mt30">
							<div class="btnSet" id="confirmBtn">
								<a href="javascript:;" class="btn lg a gray" data-url="/log/checkPartnerPassword" data-content="${session.mbrNo}" disabled>확인</a>
							</div>
						</div>
						<!-- 협력사 로그아웃 CSR-1285 210621 lju02 -->
						<div class="partner_members"><a href="/logout" data-content="${session.mbrNo}" data-url="/logout" class="btn_text">로그아웃</a></div>
						<!-- //협력사 로그아웃 CSR-1285 210621 lju02 -->						
					</div>
				</div>
			</div>
		</main>
		
		 <!-- 플로팅 영역 -->
<%--         <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}" > --%>
<%-- 			<jsp:include page="/WEB-INF/tiles/include/floating.jsp"> --%>
<%-- 	        	<jsp:param name="floating" value="" /> --%>
<%-- 	        </jsp:include> --%>
<%--         </c:if> --%>
		        
	</tiles:putAttribute>

</tiles:insertDefinition>
