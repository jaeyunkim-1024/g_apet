<%--
  Class Name  : loginView.jsp 
  Description : 로그인페이지.
  Modification Information 
     수정일         			수정자    			 수정내용
    ---------------   ----------    -------------------------------------------
    2020.12.15       	이지희   			  최초 작성
     author   : 이지희
    since    : 2020.12.15  
--%>

<%@ page pageEncoding="UTF-8" session="true" contentType="text/html; charset=utf-8" %>
<!doctype html>
<html lang="ko">
<head>
	<title>Partner Office Login</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<link rel="shortcut icon" href="/images/favicon.ico" />
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Expires" CONTENT="0">
	<meta http-equiv="Cache-Control" content="no-cache" />
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<jsp:include page="/WEB-INF/include/common.jsp" />
	<script type="text/javascript">
		var isPassedPw ;
		// TODO 조은지 : 임시
		var imsi = "";
		$(document).ready(function(){
			
			// 다른곳에서 로그인시 안내팝업
			if('${resultMsg}' != null && '${resultMsg}' != "" ){
				messager.alert('${resultMsg}' ,"Info","info");
			}
			
			 //엔터시 로그인     
	        $("#password").textbox('textbox').bind('keydown', function(e) {
	        	
	            if(event.keyCode == 13) {
	                $('#loginBtn').click();
	                return false;
	            }
	        });

			
			$("#loginBtn").click(function(){
				isPassedPw = "";

				if ($("#loginId").val().trim() == '') {
					messager.alert("아이디를 입력해 주세요.", "알림", "info"); 
					return false;
				}
				if($("#password").val() == ''){
					messager.alert("비밀번호를 입력해 주세요.", "알림", "info"); 
					return false;
				}
				
				var options = {
						url : "<spring:url value='/login/getUser.do' />"
						, data : $("#loginForm").serialize()
						, callBack : function(data) {
							var loginCd = data.split('|')[0];
			                var loginMsg = data.split('|')[1]; 
			                
		                   	if(loginCd == "S")
		                    {
		                   		if('${env}' == '${adminConstants.ENVIRONMENT_GB_LOCAL}') {
		                   			fncLoginActive(loginMsg); //임시
					                imsi = loginMsg;
		                   		} else {
		                   			fncOpenOptModal(loginMsg); //원래 이거
		                   		}
		                    }
		                   	else if(loginCd == '${exceptionConstants.ERROR_CODE_BO_PW_FAIL_CNT}' )
	                   		{
		                   		messager.confirm(loginMsg,  function(flag){
		                   			if(flag) location.href = "/login/pswdChangeView.do"; // 비밀번호 화면으로 이동.
		                   		}); 
	                   		}
		                   	else if(loginCd == '${exceptionConstants.ERROR_CODE_BO_PW_RESET_FAIL_CNT}'|| loginCd =='${exceptionConstants.ERROR_CODE_LOGIN_BO_FIRST}')
		                   	{
		                    	 messager.alert(loginMsg, "알림", "info", function(flag){
		                    		 if(flag) location.href = "/login/pswdChangeView.do"; // 비밀번호 화면으로 이동.
		                    	 }); 
	                    	}
		                    else{
		                    	 messager.alert(loginMsg, "알림", "info"); 
		                    }
			             
						}
					};

					ajax.call(options);
				});

				

			if ( "" != document.loginForm.loginId.value ) {
				$('#password').focus();
			}
 
 
		});
		
		function fncLoginActive(loginMsg){ //원래 파라미터 안받음
			if('${env}' == '${adminConstants.ENVIRONMENT_GB_LOCAL}'){
				//임시로 해놓은거 로컬에서만
				ctfCd= loginMsg;
				$("#sendCtfCd").val(ctfCd);
			}else{
				/*  원래 이거*/
				var ctfCd = $("#otpNumber").val().trim();
				$("#sendCtfCd").val(ctfCd); 
			}
			
		    if(ctfCd == ''){
		        messager.alert("인증 번호를 입력해 주세요.", "알림", "info"); 
		        return false;
		    }
		
		    var options = {
		        url : "<spring:url value='/login/login.do' />" //로그등록?  ->session set하기
		        , data : $("#loginForm").serialize()
		        , callBack : function(data) {
		            if(data.resultCode == '${adminConstants.CONTROLLER_RESULT_CODE_SUCCESS}') {
		            	$('.crtfCountDownArea').countdown("stop");
		                location.href = data.returnUrl; //관리자 메인화면으로 이동
		            }else if(data.resultCode === '${adminConstants.USER_WRONG_CFT}'){
		            	$("#notMatchCtfMsg").show();
		            }else if(data.resultCode == '${adminConstants.PO_USER_FIRST_LOGIN}'){
		            	// PO 사용자 최초 로그인시 약관동의
		            	fncOpenTermsModal();
		            }else{
		            	//비밀번호 변경이력 90일이상. or 쿼리에러
		            	if(data.resultMsg != null){
		            		messager.confirm(data.resultMsg, function(flag){
                   				if(flag && data.resultCode == '${adminConstants.CONTROLLER_RESULT_CODE_LEAVE}' ) location.href = "/login/pswdChangeView.do"; // 비밀번호 화면으로 이동.
                   			}); 
		           		}
		            	else messager.alert("<spring:message code='column.common.try.again_msg' />", "알림", "info");
		            }
		        }
		    }
		    ajax.call(options);
		};

		
		
		
	    function fncOtpNumIssue(){
	    	$('#loginBtn').click();
	    }
	    
	    function fncPwdChange(){
			location.href = "/login/pswdChangeView.do";
	    }
	    
	    function fncOpenOptModal(otpNum){
	    	var data = {
					otpNum : otpNum
			};
	    	var options = {
					url : "<spring:url value='/login/loginOtpCertifyPop.do' />"
					,	data : data
					, 	dataType : "HTML"
					, 	callBack : function(result){
						var config = {
							id : "otpCertifyLayer"
							, title : "OTP 인증"
							, width : 410
							, height: 250
							, body : result
							, button : "<button type='button' onclick=\"fncLoginActive()\" class='btn btn-ok'>확인</button>"
						}
						layer.create(config);
					}
				};
				ajax.call(options);
	    }
	    
	    function fncOpenTermsModal() {
	    	var options = {
	    			url : "<spring:url value='/login/loginTermsPop.do' />"
	    			, dataType : "HTML"
	    			, callBack : function(result) {
	    				var config = {
							id : "loginTermsLayer"
							, title : "제 3자 정보제공 동의 약관"
							, width : 410
							, height: 500
							, body : result
							, button : "<button type='button' onclick=\"fnTermsAgree()\" class='btn btn-ok'>확인</button>"
						}
						layer.create(config);
  				}
			}
			ajax.call(options);
	    }
	    
	    function fnTermsAgree() {
	    	var checkFlag = $("#termsYn").is(":checked");
	    	if(!checkFlag) {
	    		messager.alert("약관에 동의해주세요.", "알림", "info");
	    		return;
	    	}
	    	
	    	var options = {
		        url : "<spring:url value='/login/insertUserAgreeInfo.do' />"
		        , data : $("#loginForm").serialize() + "&termsNo=" + $("input[name=termsNo]").val()
		        , callBack : function(data) {
		        	if(data.resultCode == '${adminConstants.CONTROLLER_RESULT_CODE_SUCCESS}') {
		        		if('${env}' == '${adminConstants.ENVIRONMENT_GB_LOCAL}') {
			        		fncLoginActive(imsi);	
		        		} else {
		        			fncLoginActive();
		        		}
		        	}
		        }
	    	}
	    	ajax.call(options);
	    }
	    
		/* function setCookie(name, value, expires) {
			document.cookie = name + "=" + escape (value) + "; path=/; expires=" + expires.toGMTString();
		}
		function getCookie(Name) {
			var search = Name + "=";
			if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면
				offset = document.cookie.indexOf(search);
				if (offset != -1) { // 쿠키가 존재하면
					offset += search.length;
					// set index of beginning of value
					end = document.cookie.indexOf(";", offset);
					// 쿠키 값의 마지막 위치 인덱스 번호 설정
					if (end == -1)
						end = document.cookie.length;

					return unescape(document.cookie.substring(offset, end));
				}
			}
			return "";
		}
		function saveId(form) {
			var expdate = new Date();
			// 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
			if (form.checkId.checked)
				expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
			else
				expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제조건
			setCookie("veciSaveId", form.loginId.value, expdate);
		} */
		
	</script>
</head>
<body>
	<div class="divLogoPanel" style="padding: 15px;">
		<img src="/images/aboutpet_logo@2x.png" style="height: 40px;" />
		<span class="login_title" style="border-bottom: none;display: inline;padding-left: 15px;vertical-align: middle;">파트너 시스템</span>
	</div>
	<div class="login_cont">
		<div class="login_title">파트너 시스템 로그인</div>
		
		<div class="loginMainWrap">
			<form name="loginForm" id="loginForm" method="post" role="form" style="display:flex;">
				<div style="width:72%;">
					
					<div class="login_input">
						<p class="login_label">I D</p>
						<input class="easyui-textbox" style="width:90%;height:30px;" type="text" data-options="prompt:'아이디',iconCls:'icon-man',iconWidth:38" name="loginId" id="loginId" title="아이디">	
					</div>
					<div class="login_input">
						<p class="login_label">PW</p>
						<input class="easyui-textbox" style="width:90%;height:30px;" type="password" data-options="prompt:'비밀번호',iconCls:'icon-lock',iconWidth:38" name="password" id="password" title="비밀번호">	
					</div>
				</div>
				<!-- <label class="fCheck"><input type="checkbox" name="checkId" id="checkId" onclick="javascript:saveId(this.form);"><span>아이디 저장</span></label> -->
				
				<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" style="padding:5px 0px;margin-left:10px;width:25%;" id="loginBtn">로그인</a>
				<input type="text" name="ctfCd" id="sendCtfCd" style="display:none;"/>
			</form>
		</div>
		<div style="display:flex;margin-top:10px;">
			<p style="margin-right:32px;">※<spring:message code="column.first_login_po" /></p>
			<a href="#" class="easyui-linkbutton"  style="padding:5px 0px;width:125px;" onClick="fncPwdChange()" id="updatePwBtn">비밀번호 변경</a>
		</div>
	</div>
	<!-- <p class="crtfCountDownArea" style="float: right;color:red;width:15%;display:none!important;" ></p> -->
	<!-- <button type="button" id="popupOtpLayerBtn" onclick="test()" data-target="#popupOtpLayer" data-toggle="modal">123</button> -->
	<!-- <div class="modal fade" id="popupOtpLayer"   style="display:none;"  title="OTP 인증">
	    <div class="layer-header blind"><h2>OTP 인증</h2></div>
	    <div>
	    <div class="layer-content" style="margin-top: 15px;">
	        <p style="color:gray;font-size:8pt;">휴대폰에서 받은 OTP인증번호 6자리 수를 확인 후 입력해 주세요.</p>
	        <div class="ctfArea" style="margin: 20px 0px 0px;display:flex;">
		        <p  style="width:20%;padding-top:5px;">인증번호</p>
		        <div style="display:flex; width:85%;float:right;border: #cacab4 1px solid;padding:5px;">
		            <input type="text" id="otpNumber" name="ctfCd"  placeholder="인증번호 6자리 숫자" title="인증번호" style="width:45%;height:30px;border:none;border-right:0px; border-top:0px;"  maxlength="6" > onKeyDown="checkKeysInt(event);" onKeyUp="checkKeysInt(event);"
				    <p class="crtfCountDownArea" style="float: right;color:red;width:15%;" ></p>
		            <button onClick="fncOtpNumIssue()" class="btn btn-d btn-type1" style="width:32%;" id="checkCtfBtn">재발급</button>
		        </div>
	       </div>
	    </div>
	    <p  id="notMatchCtfMsg" style="padding-left:19%;font-size:8pt;color:red;display:none;">인증번호를 정확하게 입력해 주세요.</p>
	    <div style="text-align:center;margin:20px;">
		    <button type="button" class="btn btn-d btn-type2"  onclick="fncLoginActive()">확인</button>
		    <button type="button" class="btn btn-d btn-type2"  onclick="fncCloseModal()">취소</button>
	    </div>
	    </div>
	</div> -->
</body>
</html>



