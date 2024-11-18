<tiles:insertDefinition name="common">
	<tiles:putAttribute name="content">
		<body class="body">
			<div class="wrap" id="wrap">
				<header class="header pc cu mode7 noneAc" data-header="set9">
					<div class="hdr">
						<div class="inr">
							<div class="hdt">
								<!--<button id ="backBtn" class="mo-header-backNtn" onclick = "location.href='/indexLogin'" data-content="" data-url="history.go(-1)"><spring:message code='front.web.view.common.msg.back'/></button>-->
								<button id ="backBtn" class="mo-header-backNtn" onclick="storageHist.goBack();" data-content="" data-url=""><spring:message code='front.web.view.common.msg.back'/></button>
								<div class="mo-heade-tit"><span class="tit">회원정보 추가 입력</span></div>
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
								<h2>기존회원 안내</h2>
							</div>
							<!-- // PC 타이틀 모바일에서 제거  -->
		
							<%--<div class="fake-pop">
								<div class="result">
									<span class="blue">${ member.mbrNm }</span><spring:message code='front.web.view.index.pbhrmember.msg.certificate1'/><br><spring:message code='front.web.view.index.pbhrmember.msg.certificate2'/>
									<p class="sub"><br><spring:message code='front.web.view.index.pbhrmember.msg.existing.member1'/><span class="block pc"><spring:message code='front.web.view.index.pbhrmember.msg.existing.member2'/></span></p>
								</div> --%>
								
							<div class="fake-pop top">
								<div class="result">
									<span class="blue">${ member.mbrNm }</span> 님은
									<span class="block pc">기존 펫츠비 회원이시군요.</span>
									<span class="block">비밀번호 설정 후 어바웃펫을 시작하세요.</span>
								</div>
							</div>
							
							<section class="sect petTabContent hmode_auto" style="height:100%;"> 
								<!-- 탭영역 -->
								<ul class="uiTab a mt50">
									<li ${ctfMtd == 'phone' ? 'class="active"':'' }>
										<a class="bt" href="javascript:;"><span>휴대폰 번호로 찾기</span></a>
									</li>
									<li ${ctfMtd == 'email' ? 'class="active"':'' }>
										<a class="bt" href="javascript:;"><span>이메일로 찾기</span></a>
									</li>
								</ul>
		
								<!-- 탭내용 -->
								<div class="uiTab_content ptsLog_tCont" style="height:100%;">
									<ul>
										<li ${ctfMtd == 'phone' ? 'class="active"':'' }>
											<!-- 휴대폰인증 -->
											<div id="phone_input_div" class="member-input" ${ctfMtd != 'phone' ? 'style="display:none;"' :'' }>
												<p class="stxt">펫츠비에 가입하신 휴대폰번호<br><span class="blue">${member.mobile }</span> 로 인증번호를 발송하였습니다.</p>
												<ul class="">
													<li>												
														<div class="input flex">
															<input type="text" placeholder="<spring:message code='front.web.view.certificate.email.msg.request.certificate.number'/>" id="otpInput_phone" autocomplete="new-password" >
															<div class="inputInfoTxt time" id="crtfCountDownArea_phone">00:00</div>
															<a href="javascript:fncSendMsgEmail('phone');" class="btn md">재전송</a>
														</div>
														<p class="validation-check" id="ctfError_phone" style="display:none;"><spring:message code='front.web.view.certificate.email.msg.request.certificate.number.wrong'/></p>
														
														<div class="pbt mt30">
															<div class="btnSet" id="btnSet_phone">
																<a href="javascript:fncCheckCtf('phone');" class="btn lg a"  data-content="" data-url=""><spring:message code='front.web.view.certificate.email.msg.confirm.certificate'/></a>
															</div>
															<div class="btnSet" id="btnSetDisabled_phone" style="display:none;">
																<a href="javascript:;" class="btn lg a"  style="background-color: #dddddd;cursor: default;border: 1px solid #dddddd;"><spring:message code='front.web.view.certificate.email.msg.confirm.certificate'/></a>
															</div>
														</div>
													</li>
												</ul>
											</div>
											<!-- 휴대폰인증 -->							
											<div id="phone_btn_div" ${ctfMtd == 'phone' ? 'style="display:none;"':'' }>
												<div class="result">
													<p class="sub pt10">펫츠비에 가입하신<br> 휴대폰 번호로 인증번호를 발송합니다.</p>
												</div>
												<div class="pbt mt30">
													<div class="btnSet">
														<a href="javascript:fncClickCert('phone');" class="btn lg a w164">휴대폰 인증하기</a>
													</div>
												</div>
											</div>
										</li>
										<li ${ctfMtd == 'email' ? 'class="active"':'' }>
											<!-- 이메일인증 -->
											<div id="email_input_div" class="member-input" ${ctfMtd != 'email' ? 'style="display:none;"':'' }>
												<p class="stxt">펫츠비에 가입하신 이메일<br><span class="blue">${member.email}</span> 로 인증번호를 발송하였습니다.</p>
												<ul class="">
													<li>												
														<div class="input flex">
															<input type="text" placeholder="인증번호 6자리 입력"  id="otpInput_email" autocomplete="new-password" >
															<div class="inputInfoTxt time" id="crtfCountDownArea_email">00:00</div>
															<a href="javascript:fncSendMsgEmail('email');" class="btn md">재전송</a>
														</div>
														<p class="validation-check" id="ctfError_email" style="display:none;"><spring:message code='front.web.view.certificate.email.msg.request.certificate.number.wrong'/></p>
														
														<div class="pbt mt30">
															<div class="btnSet" id="btnSet_email">
																<a href="javascript:fncCheckCtf('email');" class="btn lg a" data-content="" data-url=""><spring:message code='front.web.view.certificate.email.msg.confirm.certificate'/></a>
															</div>
															<div class="btnSet" id="btnSetDisabled_email" style="display:none;">
																<a href="javascript:;" class="btn lg a" style="background-color: #dddddd;cursor: default;border: 1px solid #dddddd;"><spring:message code='front.web.view.certificate.email.msg.confirm.certificate'/></a>
															</div>
														</div>
													</li>
												</ul>
											</div>
											<!-- 이메일인증 -->
											<div id="email_btn_div" ${ctfMtd == 'email' ? 'style="display:none;"':'' }>									
												<div class="result">
													<p class="sub pt10">펫츠비에 가입하신<br> 이메일로 인증번호를 발송합니다.</p>
												</div>
												<div class="pbt mt30">
													<div class="btnSet">
														<a href="javascript:fncClickCert('email');" class="btn lg a w164">이메일로 인증하기</a>
													</div>
												</div>
											</div>
										</li>
									</ul>
								</div>
							</section>
								
							<style>
								#ctfArea input{padding-right: 60px !important;}
							</style>
						</div>
					</div>
				</main>
			</div>
		</body>
		</tiles:putAttribute>
		<tiles:putAttribute name="script.inline">
		<script type="text/javascript">
			var chkCnt_email = 0;					
			var chkCnt_phone = 0;					
			$(document).ready(function(){
				if("${view.deviceGb}" != "PC"){
					$(".mode0").remove();
					$("#footer").remove();
					$(".menubar").remove();
				}else{
					$(".mode7").remove();
				}
			
				fncCountdownCtfNo("${ctfMtd}");
			});
			
			//인증번호 입력 시간 카운트다운
			var fncCountdownCtfNo = function(mtd){
				$("#ctfError_"+mtd).hide();
				
			    $("#crtfCountDownArea_"+mtd).show();
			    var endTime = new Date();
			    endTime.setMinutes(endTime.getMinutes() + 3);
			    $("#crtfCountDownArea_"+mtd).countdown(endTime, function (event) {
			        var mm = event.strftime('%M');
			        var ss = event.strftime('%S');
			        $("#crtfCountDownArea_"+mtd).html(mm + ":" + ss);
			    }).on('finish.countdown', function () {
			        $("#otpInput_"+mtd).attr('disabled', true);
			        $("#otpInput_"+mtd).val('');

		        	var options = {
						url : "<spring:url value='/login/removeOtpSession' />"
						, data: {method : mtd}
						, done : function(data) {
							$("#ctfError_"+mtd).text("인증시간이 초과하였습니다.");
							$("#ctfError_"+mtd).show();
							$("#btnSetDisabled_"+mtd).show();
							$("#btnSet_"+mtd).hide();
						}
		        	}
		        	ajax.call(options);
			    });
			};
			
			//인증번호 체크
			var fncCheckCtf = function(mtd){
				$("#ctfError_"+mtd).hide();
				var otpNum = $("#otpInput_"+mtd).val();
				if(otpNum.length < 6){
					$("#ctfError_"+mtd).show();
					fncCheckCtfCnf(mtd);
					return;
				}
				
				var options = {
					url : "<spring:url value='/login/checkOtp' />"
			        , data :{
						otpNum :  otpNum,
						mbrNo  : '${member.mbrNo}',
						method : mtd
					}
			        , done : function(data) {
			        	if(data == '${frontConstants.CONTROLLER_RESULT_CODE_SUCCESS}'){
			        		storageHist.replaceHist();
			        		
			        		location.href="/login/indexPBHRPswd";  // 비밀번호 입력 화면
			        	}else{
			        		fncCheckCtfCnf(mtd);
			        	}
					}
				};
				ajax.call(options);
			};
			
			//오류횟수 체크
			var fncCheckCtfCnf = function(mtd){
				if(mtd == "phone") {
        			/* chkCnt_phone ++; 
        			if(chkCnt_phone > 2) {
	        			popAlert("<spring:message code='front.web.view.certificate.msg.recheck.certificatenumber'/>",function(){ location.href="/indexLogin"; });
	        			chkCnt_phone = 0;
	        		}else{ */
	        			$("#ctfError_"+mtd).text("<spring:message code='front.web.view.certificate.email.msg.request.certificate.number.wrong'/>");
	        			$("#ctfError_"+mtd).show();
	        		/* } */
        		}
        		else {
        			/* chkCnt_email ++; 
        			if(chkCnt_email > 2) {
	        			popAlert("<spring:message code='front.web.view.certificate.msg.recheck.certificatenumber'/>",function(){ location.href="/indexLogin"; });
	        			chkCnt_email = 0;
	        		}else{ */
	        			$("#ctfError_"+mtd).text("<spring:message code='front.web.view.certificate.email.msg.request.certificate.number.wrong'/>");
	        			$("#ctfError_"+mtd).show();
	        		/* } */
        		}
			};
			
			//재전송 함수
			var fncSendMsgEmail = function(mtd){
				var sendOptions = {
					url : "<spring:url value='/login/resendMsgEmail' />"
					, data :{
	        			method : mtd
	        		}
					, done  :function(data){
						$("#otpInput_"+mtd).val("");
						$("#otpInput_"+mtd).attr('disabled', false);
						
						$("#btnSetDisabled_"+mtd).hide();
						$("#btnSet_"+mtd).show();
						
						fncCountdownCtfNo(mtd);
					}
				}
				ajax.call(sendOptions);
			};
			
			//인증하기 버튼 
			var fncClickCert = function(method){
				if(method == 'email' && "${member.email}" == ""){
					popAlert("이메일정보를 찾을 수 없습니다.<br/>고객센터(1644-9601)로 문의주세요.");
					return;
				}
				if(method == 'phone' && "${member.mobile}" == ""){
					popAlert("휴대폰번호를 찾을 수 없습니다.<br/>고객센터(1644-9601)로 문의주세요.");
					return;
				}
				
				$("#"+method+"_input_div").show();
				$("#"+method+"_btn_div").hide();
				
				fncSendMsgEmail(method);
			};
			
			var popAlert = function(msg, callback){
				// 알럿창 띄우기
				ui.alert('<p>'+msg+'</p>',{
					ycb:callback,
					ybt:"<spring:message code='front.web.view.common.msg.confirmation'/>"	
				});
			};
		</script>
			
	</tiles:putAttribute>
</tiles:insertDefinition>

