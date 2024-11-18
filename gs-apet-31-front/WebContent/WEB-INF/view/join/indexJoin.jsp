<tiles:insertDefinition name="common">
<%--<tiles:putAttribute name="script.include" value="script.common.mo"/> <!-- MO scalable 스크립트 적용 -->--%>
<jsp:include page="/WEB-INF/tiles/include/js/common_mo.jsp"/>
<tiles:putAttribute name="script.include" value="script.member"/>
<tiles:putAttribute name="script.inline">
<style>
.inputInfoTxt{
	cursor : pointer;
}
.menubar{ display: none;}
</style>
<script type="text/javascript" 	src="/_script/file.js"></script>
<script type="text/javascript">
	var imageResult = null;
	
	$(document).ready(function(){
		$("input:text[onlyEng]").on("keyup", function() {
		    $(this).val($(this).val().replace(/[ㄱ-힣]/gi,""));
		}); 
		
		if("${view.deviceGb}" != "PC"){
			$(".mode0").remove();
			$("#footer").remove();
		}else{
			$(".mode7").remove();
		}
		
		//window.history.forward();

		/*추천인 코드 설정*/
		var rcomCode = "${rcomCode}";
		rcomCode = rcomCode.replace("&quot;","");
		rcomCode = rcomCode.replace("&quot;","");
		if(rcomCode != "" ){
			$("#join_rcomId").val(rcomCode);
		}

		//푸쉬토큰 app interface 호출
		if('${view.deviceGb}' == 'APP'){
			//alert("푸쉬토큰요청");
			toNativeData.func = 'onPushToken';
			toNativeData.callback= 'appPushToken';
			// 호출
			toNative(toNativeData);
		}

		//엔터 작동 막기
		$("#join_form").keypress(function(e) {
			if ( window.event.keyCode == 13 ) {
				e.preventDefault();
			}
		});
		
		//2021.05.06  김재윤 추가
		//2021.06.23 김준형 추가 (safari blur처리)
		$("#join_login_id").on("${view.os}" == "20" ? 'mouseout focusout' : 'blur', () => {
			setTimeout(function(){
				//var inputVal = $(this).val().replace(/[ㄱ-힣]/g,'');
				//$("#join_login_id").val(inputVal);

				var msg = "";
				var v = true;
				var loginId = $("#join_login_id").val();

				if($("#join_login_id").val().length < 6 || $("#join_login_id").val().length > 40){
					msg = "<spring:message code='front.web.view.join.id.input.validate.check1' />";
					v = false;
				}
				//아이디 공백있는 경우
				else if(!valid.login_id.test($("#join_login_id").val())){
					msg = "<spring:message code='front.web.view.join.id.input.validate.check2' />";
					v = false;
				}else{
					validWhenBlur.banWord({loginId : loginId}, function(returnCode){
						if(returnCode == "banWord"){
							if($("#join_login_id").val() != "" ){
								$("#join_login_id_error").html("<spring:message code='front.web.view.join.banword.input.check' />");
								//$("#join_login_id").focus();
							}
						}else{
							validWhenBlur.loginId(loginId,function(){
								if($("#join_login_id").val() != "" ){
									$("#join_login_id_error").html("<spring:message code='front.web.view.join.id.input.validate.check3' />");
									//$("#join_login_id").focus();
								}
							});
						}
					});
				}
			
				if( $("#join_pswd").val() != "" ){
					if(!pswdValid.checkIncludeIdValue($("#join_pswd").val(), $("#join_login_id").val().replace(/-/g, ''))){
						$("#join_pswd_error").html("<spring:message code='front.web.view.join.pwd.input.validate.check4' />");
					}
				}

				/* if(!v && $("#join_login_id_error").html() == ""){
					$("#join_login_id").focus();
				} */
				$("#join_login_id_error").html(msg);
			
				$('.btnDel').click(function(){
					$('#join_login_id_error').html("");
				});
				
			},250);
		});
		
		$("#join_pswd").on("${view.os}" == "20" ? 'mouseout focusout' : 'blur', () => {
			setTimeout(function(){
				if("${snsYn}" != 'Y' || (!($("#join_pswd").val() == "" || $("#join_pswd").val() == 'undefined') && "${data.snsLnkCd}" < 40) ) {
					var v = true;
					var msg = "";
	
					var pswdCheck = pswdValid.checkPswd($("#join_pswd").val());
	
					if(pswdCheck == "falseLength"){
						msg = "<spring:message code='front.web.view.join.pwd.input.validate.check1' />";
						v = false;
					}
					//공백, 특수문자 포함일때
					else if($("#join_pswd").val().search(/[|]/gi) > 0 || $("#join_pswd").val().search(/\s/g) > 0){
						msg = "<spring:message code='front.web.view.join.pwd.input.validate.check7' />";
						v = false;
					}
					else if(pswdCheck == "falseCheck"){
						msg = "<spring:message code='front.web.view.join.pwd.input.validate.check2' />";
						v = false;
					}
					else if(!pswdValid.checkPswdMatch($("#join_pswd").val())){
						msg = "<spring:message code='front.web.view.join.pwd.input.validate.check3' />";
						v = false;
					}
					else if(!pswdValid.checkIncludeIdValue($("#join_pswd").val(), $("#join_login_id").val().replace(/-/g, '')) ){
						msg = "<spring:message code='front.web.view.join.pwd.input.validate.check4' />";
						v = false;
					}
	
					if(!v && $("#join_pswd_error").html() == ""){
						//$("#join_pswd").focus();
					}
					$("#join_pswd_error").html(msg);
					
					$('.btnDel').click(function(){
						$('#join_pswd_error').html("");
					});
				}
			},250);
		});
		
		$("#join_pswd_check").on("${view.os}" == "20" ? 'mouseout focusout' : 'blur', () => {
			setTimeout(function(){
				if("${snsYn}" != 'Y' || (!($("#join_pswd").val() == "" || $("#join_pswd").val() == 'undefined') && "${data.snsLnkCd}" < 40) ) {
					if(pswdValid.checkPswd($("#join_pswd").val()) == "true" && $("#join_pswd_check").val() != $("#join_pswd").val()){
						$("#join_pswd_check_error").html("<spring:message code='front.web.view.join.pwd.input.same_pwd.check' />");
					}else{
						$("#join_pswd_check_error").html("");
					}
					
					$('.btnDel').click(function(){
						$('#join_pswd_check_error').html("");
					});
				}
			},250);
		});

		 $("#join_nickname").on("${view.os}" == "20" ? 'mouseout focusout' : 'blur', () => {
			 setTimeout(function(){
				var v = true ;
				var msg = "";
				var nickNm = $("#join_nickname").val();
				var chkNickNm = nickNm.replace(/ /gi, "");
				nickNm = chkNickNm;
				if($("#join_nickname").val() == ""){
					msg = "<spring:message code='front.web.view.join.nickname.input.validate.check1' />";
					v = false;
				}else{
					//2021-08-19 추가 김명섭
					if(nickNm.indexOf("#") > -1 
							|| nickNm.indexOf("@") > -1
							|| nickNm.indexOf(">") > -1
							|| nickNm.indexOf("<") > -1){
						msg = ("닉네임에 @, #, <, > 는 입력할 수 없어요.");
					}else{
						validWhenBlur.banWord({nickNm : nickNm}, function(returnCode){
							if(returnCode == "banWord"){
								if($("#join_nickname").val() != "" ){
									$("#join_nickNm_error").html("<spring:message code='front.web.view.join.banword.input.check' />");
									//$("#join_login_id").focus();
								}
							}else{
								validWhenBlur.nickNm(nickNm,function(result){
									if($("#join_nickname").val() != ""){
										if(result!=0){
									$("#join_nickNm_error").html("<spring:message code='front.web.view.join.nickname.input.validate.check2' />");
										}
									}
								});
							}
						});
					}
				}
	
				if(!v && $("#join_nickNm_error").html() == ""){
					//$("#join_nickname").focus();
				}
				
				$("#join_nickNm_error").html(msg);
				
				$('.btnDel').click(function(){
					$('#join_nickNm_error').html("");
				});		 
			 },250);
		}); 
		 
		$("#join_email_id").on("${view.os}" == "20" ? 'mouseout focusout' : 'blur', () => {
			setTimeout(function(){
				var e = $("#join_email_id").val();
				var v = true;
				var msg = "";
				if(e == ""){
					v = false;
					msg = "<spring:message code='front.web.view.join.email.input.validate.check1' />";
				}
				/* else if(!valid.email.test(e)){
					v = false;
					msg = "<spring:message code='front.web.view.join.email.input.validate.check2' />";
				} */
				  else if(!valid.ko.test(e)){
					v = false;
					msg = "<spring:message code='front.web.view.join.email.input.validate.check2' />";
				}  
				
				$("#join_email_error").html(msg);
				
				/* $('.btnDel').click(function(){
					$('#join_email_error').html("");
				}); */
			},250);
		}).on("input paste change","#join_email_id",function(){
			var inputVal = $(this).val().replace(/[ㄱ-힣]/gi,'');
			//$("#join_email_id").val(inputVal);
			validateTxtLength(this,40);
		});
		
		$("#join_rcomId").on("${view.os}" == "20" ? 'mouseout focusout' : 'blur', () => {
			setTimeout(function(){
				$("#join_rcomId_error").html("");
				if($("#join_rcomId").val() != ""){
					validWhenBlur.rcomCd($("#join_rcomId").val(),function(){
						if($("#join_rcomId").val() != ''){
							$("#join_rcomId_error").html("<spring:message code='front.web.view.join.recommendation_id.input.check' />");
						}
					});
				}
			},250)
		});
	});// End Ready
	
	//2021.06.21 인풋태그에 값 입력 시, 오류 메세지 제거
	$(document).on("keydown input paste",".cleanValMsg", function(){
		$(this).parent().next().html("")
	});
	
	$(document).on("input paste keydown change","[name='nickNm']",function(){
		validateTxtLength(this, 20);
		var nickNmNoSpace=$(this).val().replace(/ /gi, "");
		$(this).val(nickNmNoSpace); 
	});
	
	/* 필수입력칸 입력여부 체크 - 버튼 활성화 */
	$(document).on("input paste change",".required_join_input",function() {
		var required_value_fill = true;

		$(".required_join_input").each(function(){
			if($(this).val() == '') required_value_fill = false;
		});

		//if($("input:radio[name='gdGbCd']:radio").val() == '')  required_value_fill = false;
		if("${snsYn}" == 'Y' && "${data.snsLnkCd}" > 30 ){
			if($("#join_login_id").val() == '' || $("#join_nickname").val() == '') required_value_fill = false;
			else required_value_fill =true;
		}

		if(required_value_fill){
			$("#activeBtn").show();
			$("#inactiveBtn").hide();
		}else{
			$("#inactiveBtn").show();
			$("#activeBtn").hide();
		}
	});
	
	//App 푸쉬토큰 콜백
	function appPushToken(data){
		var dataJson = JSON.parse(data);
		$("#appPushToken").val(dataJson.token);
	}
	
	/*회원가입 처리*/
	function insertMember(){
		var flag = true;
		 	
		$(".validation-check").each(function(e){
			$(this).remove;
		}); 
 
		if($("#join_login_id").val().length < 6 || $("#join_login_id").val().length > 40){
			$("#join_login_id_error").html("<spring:message code='front.web.view.join.id.input.validate.check1' />");
			//$("#join_login_id").focus();
			flag = false;
		}
		
		//아이디 공백있는 경우
		if(!valid.login_id.test($("#join_login_id").val())){
			$("#join_login_id_error").html("<spring:message code='front.web.view.join.id.input.validate.check2' />");
			//$("#join_login_id").focus();
			flag = false;
		}
			
		//비밀번호 체크 - sns회원가입인 경우는 비밀번호 필수아님.
		if("${snsYn}" != 'Y' || (!($("#join_pswd").val() == "" || $("#join_pswd").val() == 'undefined') && "${data.snsLnkCd}" < 40) ){
			if($("#join_pswd").val() == ""){
				$("#join_pswd_error").html("<spring:message code='front.web.view.join.sns.input.pwd.validate.check' />");
				//$("#join_pswd").focus();
				flag = false;
			}
			 
			var pswdCheck = pswdValid.checkPswd($("#join_pswd").val());
			if(pswdCheck == "falseLength"){
				$("#join_pswd_error").html("<spring:message code='front.web.view.join.pwd.input.validate.check1' />");
				//$("#join_pswd").focus();
				flag = false;
			}
			
			if($("#join_pswd").val().search(/[|]/gi) > 0 || $("#join_pswd").val().search(/\s/g) > 0){
				$("#join_pswd_error").html("<spring:message code='front.web.view.join.pwd.input.validate.check7' />");
				//$("#join_pswd").focus();
				flag = false;
			}
			
			if(pswdCheck == "falseCheck"){
				$("#join_pswd_error").html("<spring:message code='front.web.view.join.pwd.input.validate.check2' />");
				//$("#join_pswd").focus();
				flag = false;
				
			}
			
			if(!pswdValid.checkPswdMatch($("#join_pswd").val())){
				$("#join_pswd_error").html("<spring:message code='front.web.view.join.pwd.input.validate.check3' />");
				//$("#join_pswd").focus();
				flag = false;
			}
			
			if(!pswdValid.checkIncludeIdValue($("#join_pswd").val(), $("#join_login_id").val().replace(/-/g, '')) ){
				$("#join_pswd_error").html("<spring:message code='front.web.view.join.pwd.input.validate.check4' />");
				//$("#join_pswd").focus();
				flag = false;
			}
		}
			
		if("${snsYn}" == 'Y' && "${data.snsLnkCd}" > 30 ){
			if($("#join_nickname").val() == ""){
				$("#join_nickNm_error").html("<spring:message code='front.web.view.join.nickname.input.validate.check1' />");
				//$("#join_nickname").focus();
				flag = false;
			}
		}else{
			if($("#join_pswd_check").val() != $("#join_pswd").val()){
				$("#join_pswd_check_error").html("<spring:message code='front.web.view.join.pwd.input.same_pwd.check' />");
				//$("#join_pswd_check").focus();
				flag = false;
			}

			if($("#join_nickname").val() == ""){
				$("#join_nickNm_error").html("<spring:message code='front.web.view.join.nickname.input.validate.check1' />");
				//$("#join_nickname").focus();
				flag = false;
			}
			
			if(!valid.ko.test($("#join_email_id").val())){
				$("#join_email_error").html("<spring:message code='front.web.view.join.email.input.validate.check2' />");//("메일 주소를 다시 확인해 주세요.");
				//$("#join_email_id").focus();
				flag = false;
			}
			
			if($("#join_nickname").val() != ''){
				var nickNm = $("#join_nickname").val();
				var chkNickNm = nickNm.replace(/ /gi, "");
				nickNm = chkNickNm;
				if(nickNm.indexOf("#") > -1
						|| nickNm.indexOf("@") > -1
						|| nickNm.indexOf(">") > -1
						|| nickNm.indexOf("<") > -1){
					$("#join_nickNm_error").html("닉네임에 @, #, <, > 는 입력할 수 없어요.")
					flag = false;
				}else{
					validWhenBlur.banWord({nickNm : nickNm}, function(returnCode){
						if(returnCode == "banWord"){
							if($("#join_nickname").val() != "" ){
								$("#join_nickNm_error").html("<spring:message code='front.web.view.join.banword.input.check' />");
								//$("#join_login_id").focus();
								flag = false;
							}
						}else{
							validWhenBlur.nickNm(nickNm,function(result){
								if(result!=0){
								$("#join_nickNm_error").html("<spring:message code='front.web.view.join.nickname.input.validate.check2' />");
								//$("#join_nickname").focus();
								flag = false;
								}
							});
						}
					});
				}
			}
		}
		
		//스크롤 처리
		if(($("#join_login_id_error")!="") || ($("#join_pswd_error")!="")){
			window.scroll(0,0);
		}
		
		setTimeout(function(){
			$(".validation-check").each(
				function(){
					if(($(this).html())!=""){
						$t =$(this).siblings("div").find("input")
						$t.focus();
						return false;
					}
				}
			)
	 	},500);
		
		setTimeout(function(){
			if(flag){
				$("input").attr('disabled',false);
				var options = {
					url : "<spring:url value='/join/insertMember' />",
					data : $("#join_form").serialize(),
					done : function(data){
						$("#mbrNo").val(data.mbrNo);
						
						//gsr 휴면 해제 처리 알림
						if(data.separateNotiMsg != null && data.separateNotiMsg != ""){
							messager.alert(data.separateNotiMsg ,"Info","info");
						}
						
						if(data.returnCode == "duplicatedId"){
							$("#join_login_id_error").html("<spring:message code='front.web.view.join.id.input.validate.check3' />");
							//$("#join_login_id").focus();
							return false;
						}else if(data.returnCode == "duplicatedEmail"){
							$("#join_email_error").html("<spring:message code='front.web.view.join.email.input.validate.check3' />");
							//$("#join_email_id").focus();
							return false;
						}else if(data.returnCode == "notMatchRcomId"){
							$("#join_rcomId_error").html("<spring:message code='front.web.view.join.recommendation_id.input.check' />");
							//$("#join_rcomId").focus();
							return false;
						}else if(data.returnCode == "duplicatedNickNm"){
							$("#join_nickNm_error").html("<spring:message code='front.web.view.join.nickname.input.validate.check2' />");
							//$("#join_nickname").focus();
							return false;
						}else if(data.returnCode == "banWord"){
							ui.toast("<spring:message code='front.web.view.join.banword.input.check' />");
							return false;
						}else if(data.returnCode == "existMember"){
							storageHist.replaceHist();
							
							//기존 회원정보와 동일한 경우
							location.href='/join/indexExistMember';
						}else if(data.returnCode == "connectSns"){
							storageHist.replaceHist();
							
							//애플,구글 로그인 시 한번더 체크 하여 기존 회원인 경우 연동
							location.href='/join/connectSns';
						}else{
							//성공인 경우
							if('${view.deviceGb}' == "${frontConstants.DEVICE_GB_30}"){
								toNativeData.func = 'onLogin';
								toNative(toNativeData);
								
								// 애드브릭스 호출
								var chnl = 10;
								var snsCd = "${data.snsLnkCd}";
								if(snsCd == 10) chnl = 2;
								else if(snsCd == 20) chnl = 1;
								else if(snsCd == 30) chnl = 4;
								else if(snsCd == 40) chnl = 13;
								
								var date = new Date();
							    var year = date.getFullYear() + "";
							    var month = ("0" + (1 + date.getMonth())).slice(-2);
							    var day = ("0" + date.getDate()).slice(-2);
	
							    var join_date = year.substr(2,2) + "." + month + "." + day;
								
								onUserRegisterData.func = 'onUserRegister';
								onUserRegisterData.SignUpChnnel = chnl;
								onUserRegisterData.eventAttrs = {
										user_id : $("#join_login_id").val(),
										birth : $("#join_birth").val(),
										join_dtm : join_date
								};
								toNativeAdbrix(onUserRegisterData);
							}else{
								//google analytics 호출
								var pathCd = "ABOUTPET";
								var snsCd = "${data.snsLnkCd}";
								if(snsCd == 10) pathCd = "NAVER";
								else if(snsCd == 20) pathCd = "KAKAO";
								else if(snsCd == 30) pathCd = "GOOGLE";
								else if(snsCd == 40) pathCd = "APPLE";
								
								sign_up_data.method =pathCd;
								sendGtag('sign_up');
							}
							
							fncTagInfoLogApi({ url:"/join/indexJoin", targetUrl:"/join/indexTag",callback:console.log(data) });
							
							storageHist.replaceHist();
							
							location.href='/join/indexTag';
						}
					}
				}; 
				ajax.call(options);
				
				inputDisabled();
			}
			/* else{
				$('#contents').find('.member-input').find('input').trigger('blur');
			} */
		},800)
	}
	
	//뒤에서 오기 방지
	/*function noBack(){
		 window.history.forward();
	}*/
	
	function inputDisabled(){
		if("${data.nickNm}" != null && "${data.nickNm}" != "")  $("#join_nickname").attr('disabled',true);
		if("${data.email}" != null && "${data.email}" != "" && '${snsYn}' != 'Y' )  $("#join_email_id").attr('disabled',true);
		if("${snsYn}" == 'Y' && "${data.snsLnkCd}" > 30) $("#join_login_id").attr('disabled',true);
		//$("#join_road_addr_input").attr('disabled',true);
	} 
</script>
</tiles:putAttribute>
<tiles:putAttribute name="content">	
<!-- <body class="body" onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload=""> -->
<body class="body">
	<div class="wrap" id="wrap">
		<!-- mobile header -->
			<header class="header pc cu mode7 noneAc" data-header="set9">
				<div class="hdr">
					<div class="inr">
						<div class="hdt">
							<!--<button id ="backBtn" class="mo-header-backNtn" onclick = "location.href='/indexLogin';" data-content="" data-url="history.go(-1)"><spring:message code='front.web.view.common.msg.back' /></button>-->
							<button id ="backBtn" class="mo-header-backNtn" onclick = "storageHist.goBack();" data-content="" data-url=""><spring:message code='front.web.view.common.msg.back' /></button>
							<div class="mo-heade-tit"><span class="tit"><spring:message code='front.web.view.common.join.title' /></span></div>
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
					<div class="pc-tit">
						<h2><spring:message code='front.web.view.common.join.title' /></h2>
					</div>
					<div class="fake-pop">
						<div class="pct">
							<div class="poptents">
								<form id="join_form">
		
								<input type="hidden" id="snsYn" name="snsYn" value="${snsYn }" />
								<input type="hidden" id="termsNo" name="termsNo" value="${termsNo }" />
								<input type="hidden" id="pstInfoAgrYn" name="pstInfoAgrYn" value="${pstInfoAgrYn }" />
								<input type="hidden" id="mkngRcvYn" name="mkngRcvYn" value="${mkngRcvYn }" />
								<input type="hidden" id="joinEnvCd" name="joinEnvCd" value="${view.deviceGb}" />
								<input type="hidden" id="deviceTpCd" name="deviceTpCd" value="${view.os}" />
								<input type="hidden" name="deviceToken" id="appPushToken"  /> 
								<input type="hidden" name="mbrNo" id="mbrNo"  /> 
								<input type="hidden" name="gdGbCd" id="gdGbCd"  value="${data.gender}"/> 
		
								<!-- 프로필 사진 -->
								<%-- <c:if test="${snsYn != 'Y' or(data.snsLnkCd != null and data.snsLnkCd < 40)}">
								<div class="my-picture">
									<p class="picture" id="imgArea"></p>
									<img class="picture" id="imgPathView" name="imgPathView" class="thumb" alt="" style="display:none;">
									<input type="hidden" id="prfImgPath" name="prflImg"  />
									<input type="hidden" id="prfImgPathInApp" name="prfImgPathInApp"  />
									<button class="btn edit"  id="profileAdd" data-content="" data-url="" ></button>
								</div>
								</c:if> --%>
								<!-- // 프로필 사진 -->
								
								<!-- 회원 정보 입력 -->
								<div class="member-input">
									<ul class="list">
									<c:choose>
									<c:when test="${data.snsLnkCd != null and data.snsLnkCd > 30 }"><!-- 애플인 경우 -->
										<li>
											<strong class="tit requied"><spring:message code='front.web.view.join.sns.required.input.id.title' /></strong>
											<p class="info"><spring:message code='front.web.view.join.required.info.title' /></p>
											<div class="input del">
												<input type="text" id="join_login_id" class="required_join_input cleanValMsg" name="loginId" placeholder="<spring:message code='front.web.view.join.sns.required.input.id.preview' />" maxlength="40" value="${data.loginId }"  style="ime-mode:disabled;"  ${data.email != null and data.email !='' and data.snsLnkCd != null and data.snsLnkCd > 30   ?'disabled' : '' }>
											</div>
											<p class="validation-check"  id="join_login_id_error"></p>
										</li>
										<li>
											<strong class="tit requied"><spring:message code='front.web.view.join.required.input.nickname.title' /></strong>
											<div class="input del disabled">
												<input type="text" id="join_nickname" name="nickNm" class="required_join_input cleanValMsg" placeholder="<spring:message code='front.web.view.join.nickname.input.validate.check1' />" maxlength="20" value="${data.nickNm }"  ${data.nickNm != null and data.nickNm !='' ?'disabled' : '' }>
											</div>
											<p id="join_nickNm_error" class="validation-check"></p>
										</li>
									</c:when>
									<c:otherwise>
										<li>
											<strong class="tit requied"><spring:message code='front.web.view.common.id.title' /></strong>
											<p class="info"><spring:message code='front.web.view.join.required.info.title' /></p>
											<div class="input del">
												<input type="text" id="join_login_id" class="required_join_input cleanValMsg" name="loginId" placeholder="<spring:message code='front.web.view.join.required.input.id.validate.preview' />" maxlength="40" value="${data.loginId }"  style="ime-mode:disabled;" >
											</div>
											<p class="validation-check"  id="join_login_id_error"></p>
										</li>
										<li>
											<strong class="tit ${snsYn != 'Y'? 'requied':'' }"><spring:message code='front.web.view.common.pwd.title' /></strong>
											<div class="input del">
												<input type="password"  name="pswd" id="join_pswd" placeholder="<spring:message code='front.web.view.find.pwd.result.pwd.rule' />" maxlength="15" autocomplete="new-password" ${snsYn != 'Y'? 'class="required_join_input cleanValMsg "':'' }>
											</div>
											<p class="validation-check" id="join_pswd_error" ></p>
										</li>
										<li>
											<strong class="tit ${snsYn != 'Y'? 'requied':'' }"><spring:message code='front.web.view.join.required.input.pwd.again.title' /></strong>
											<div class="input del">
												<input type="password" id="join_pswd_check" placeholder="<spring:message code='front.web.view.join.required.input.pwd.again.check.preview' />" maxlength="15" autocomplete="new-password"${snsYn != 'Y'? 'class="required_join_input cleanValMsg"':'' }>
											</div>
											<p class="validation-check" id="join_pswd_check_error" ></p>
										</li>
										<li style="display:none;">
											<strong class="tit requied"><spring:message code='front.web.view.common.name.title' /></strong>
											<div class="input del  ${data.mbrNm != null  and data.mbrNm !=''?'disabled' : '' } ">
												<input type="text" class="cleanValMsg" id="join_mbr_nm" name="mbrNm"  value="${data.mbrNm }" maxlength="10" ${data.mbrNm != null  and data.mbrNm !='' ?'disabled' : ''  } placeholder="<spring:message code='front.web.view.join.required.input.name.preview' />" >
											</div>
											<p class="validation-check"  id="join_mbr_nm_error"></p>
										</li>
										<li style="display:none;">
											<strong class="tit requied"><spring:message code='front.web.view.mobile.phoneNumber' /></strong>
											<div class="input del ${data.mobile != null  and data.mobile !=''?'disabled' : '' } ">
												<input type="number" class="cleanValMsg" id="join_mobile" name="mobile" title="<spring:message code='front.web.view.join.required.input.phone.title' />" value="${data.mobile }" maxlength="20" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  placeholder="<spring:message code='front.web.view.join.required.input.phone.validate.preview' />"  ${data.mobile != null  and data.mobile !='' and snsYn != 'Y' ?'disabled' : '' }>
											</div>
											<p class="validation-check" id="join_mobile_error"></p>
										</li>
										<li style="display:none;">
											<strong class="tit"><spring:message code='front.web.view.join.required.input.birth.title' /></strong>
											<div id="join_birth_not_accept"  class="input del  ${data.birth != null  and data.birth !=''?'disabled' : '' }">
												<input type="number" class="cleanValMsg" id="join_birth" name="birth" class="" value="${data.birth }" maxlength="8" placeholder="<spring:message code='front.web.view.join.required.input.birth.validate.preview' />"  ${data.birth != null  and data.birth !='' and snsYn != 'Y' ?'disabled' : '' }/> 
											</div>
											<p class="validation-check" id="join_birth_error"></p>
										</li>
										<li style="display:none;">
											<strong class="tit"><spring:message code='front.web.view.join.required.input.gender.title' /></strong>
											<div class="flex-wrap">
												<label class="radio"><input type="radio" id="join_gd_gb_cd2" name="gdGbCd" value="10" ><span class="txt"><spring:message code='front.web.view.join.gender.male.title' /></span></label>
												<label class="radio"><input type="radio" id="join_gd_gb_cd1" name="gdGbCd" value="20"><span class="txt"><spring:message code='front.web.view.join.gender.female.title' /></span></label>
											</div>
										</li> 
										<li>
											<strong class="tit requied"><spring:message code='front.web.view.join.required.input.nickname.title' /></strong>
											<div class="input del disabled">
												<input type="text" id="join_nickname" name="nickNm" class="required_join_input cleanValMsg" placeholder="<spring:message code='front.web.view.join.nickname.input.validate.check1' />" maxlength="20" value="${data.nickNm }"  ${data.nickNm != null and data.nickNm !='' ?'disabled' : '' }>
											</div>
											<p id="join_nickNm_error" class="validation-check"></p>
										</li>
									<c:choose>
										<c:when test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
											<li>
											<strong class="tit requied"><spring:message code='front.web.view.common.email.title' /></strong>
											<div class="input del disabled">
												<input type="text"  id="join_email_id" onlyEng name="email" class="required_join_input cleanValMsg" placeholder="<spring:message code='front.web.view.join.required.input.email.preview' />" maxlength="40" value="${data.email }"  ${data.email != null and data.email !='' and (snsYn !='Y' or (data.snsLnkCd != null and data.snsLnkCd > 30 ))  ?'disabled' : '' }>
											</div>
											<p class="validation-check" id="join_email_error"></p> 
										</li>
										</c:when>
										<c:otherwise>
											<li>
											<strong class="tit requied"><spring:message code='front.web.view.common.email.title' /></strong>
											<div class="input del disabled">
												<input type="text"  id="join_email_id" name="email" class="required_join_input cleanValMsg" placeholder="<spring:message code='front.web.view.join.required.input.email.preview' />" maxlength="40" value="${data.email }"  ${data.email != null and data.email !='' and (snsYn !='Y' or (data.snsLnkCd != null and data.snsLnkCd > 30 ))  ?'disabled' : '' }>
											</div>
											<p class="validation-check" id="join_email_error"></p> 
										</li>
										</c:otherwise>		
									</c:choose>														
										<!-- <li style="display:none;">
											<strong class="tit ">주소</strong>
											<div class="adrbox basic" id="addrDiv" >
												<div class="adr on"  id="join_road_addr_input" >&nbsp;</div>
												<a href="javascript:;" class="btAdr">주소검색</a>
												<input type="hidden" id="join_prcl_addr" name="prclAddr" title="지번주소" value="" />
												<input type="hidden" id="join_prcl_dtl_addr" name="prclDtlAddr" title="지번주소 상세" value="" />
												<input type="hidden" id="join_post_no_new" name="postNoNew"  title="우편번호"  />
												<input type="hidden" id="join_road_addr" name="roadAddr"  title="도로명주소"  />
											</div>
											// 04.14 : 수정
											<div class="input disabled" id="roadDtlAddrDiv" style="display:none;">
												<input type="text" class="text-input" id="join_road_dtl_addr" name="roadDtlAddr" maxlength="30"  placeholder="주소를 검색해주세요." >
											</div>
											<p class="validation-check">error message</p>
										</li> -->
										
										<li>
											<strong class="tit"><spring:message code='front.web.view.join.recommendation_id.title' /></strong>
											<div class="input disabled">
												<input type="text" class="cleanValMsg" id="join_rcomId" name="${rcomCode != null  and rcomCode !=''? 'rcomCode': 'rcomLoginId' }" placeholder="<spring:message code='front.web.view.join.required.input.recommendation_id.preview' />" >
											</div>
											<p class="validation-check" id="join_rcomId_error"></p>
										</li>
										</c:otherwise>
									</c:choose>
									</ul>
								</div>
								<!-- // 회원 정보 입력 -->
								</form>
							</div>
						</div>
						<div class="pbt pull">
							<div class="bts" id="inactiveBtn" >
								<a href="javascript:;" id="nextBtn" class="btn lg gray" data-content="" data-url="" ><spring:message code='front.web.view.common.next.button.title' /></a><!--pointer-events: none;  -->
							</div>
							<div class="bts" id="activeBtn" style="display:none;">
								<a href="javascript:insertMember();" id="nextBtn" class="btn lg a" data-content="" data-url="" ><spring:message code='front.web.view.common.next.button.title' /></a><!--pointer-events: none;  -->
							</div>
						</div>
						<form id="imgAppForm" style="display:none;">
						</form>
					</div>
				</div>

			</div>
		</main>

		<div class="layers">
			<!-- 레이어팝업 넣을 자리 -->
		</div>
		<!-- 바디 - 여기 밑으로 템플릿 -->

		<!-- 하단메뉴 -->
		<!-- <include class="menubar" data-include-html="../inc/menubar.html"></include> -->
		<!-- 푸터 -->
		<!-- <include class="footer" data-include-html="../inc/footer.html"></include> -->
		</div>
	</body>
	</tiles:putAttribute>
</tiles:insertDefinition>