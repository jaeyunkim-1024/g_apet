<%--
  Class Name  : pswdChangeView.jsp 
  Description : 비밀번호 변경.
  Modification Information 
     수정일         			수정자    			 수정내용
    ---------------   ----------    -------------------------------------------
    2020.12.15       	이지희   			  최초 작성
     author   : 이지희
    since    : 2020.12.15  
--%>

<%@ page pageEncoding="UTF-8" session="true" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!doctype html>
<html lang="ko">
<head>
	<title>Back Office Login</title>
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
	
		var userInfo;
		$(document).ready(function(){
			
			 //엔터시 로그인     
	        $("#loginId").textbox('textbox').bind('keydown', function(e) {
	            if(event.keyCode == 13) {
	                fncNextAction();
	                return false;
	            }
	        });
			
			$('#loginId').focus();
			
			$("#progress1").css("color","#4e88b9");
			
			//엔터 시 비번 설정active
			$("#newPasswordChk").bind('keydown', function(e) {
	            if(event.keyCode == 13) {
	                fncNextAction();
	                return false;
	            }
	        });
			
			//비번확인 칸이 입력한 비번과 맞는지 입력 시 마다 체크
			$("#newPasswordChk").bind('keyup', function(e) {
            	if($("#newPassword").val() == $("#newPasswordChk").val()){
            		$("#newPwdChkErrMsg").hide();
            	}else{
            		$("#newPwdChkErrMsg").show();
            	}
	        });
			
			//비번 유효성 체크
			$("#newPassword").bind('keyup', function(e) {
				var returnVal = fncValidator();
				if(returnVal != "S") $('#newPwdErrMsg').show();
				
				if($("#newPassword").val() == $("#newPasswordChk").val()){
            		$("#newPwdChkErrMsg").hide();
            	}else{
            		$("#newPwdChkErrMsg").show();
            	}
	        });
		});
		
		
		// step1 . id로 user 정보체크하고 otp 창 open + step2.변경 비밀번호 저장insert/update 
		function fncNextAction(){
			var stepFlag = $("#stepFlag").val();
			
			//step 1
			if(stepFlag == "1")
			{
				if ($("#loginId").val().trim() == '') {
					messager.alert("아이디를 입력해 주세요.", "알림", "info"); 
					return false;
				}
				
				var options = {
					url : "<spring:url value='/login/getUser.do' />"
					, data : $("#idForm").serialize()
					, callBack : function(data) {
						var loginCd = data.split('|')[0];
		                var loginMsg = data.split('|')[1]; 
		                
	                   	if(loginCd == "S"){
	                        fncOpenOtpModal(); //otp 창 오픈
	                    }else{
	                    	 messager.alert(loginMsg, "알림", "info"); 
	                    }
					}
				};
				ajax.call(options);
			}
			else if(stepFlag == "2")
			{//step2
				if ($("#newPassword").val().trim() == '') {
					messager.alert("변경할 비밀번호를 입력해 주세요.", "알림", "info"); 
					return false;
				}

				if ($("#newPasswordChk").val().trim() == '') {
					messager.alert("새 비밀번호 확인을 입력해 주세요.", "알림", "info"); 
					return false;
				}
				
				if( $('#newPwdChkErrMsg').css("display") == "block" 
						||  $('#newPwdErrMsg').css("display") == "block"){
					messager.alert("비밀번호를 다시 확인해 주세요.", "알림", "info"); 
					return false;
				}
				
				//pwd 업데이트 하고 이력 저장
				var options = {
					url : "<spring:url value='/login/updateUserPw.do' />"
					, data : $("#pwdForm").serialize()
					, callBack : function(data) {
						
						if(data.resultCode == '${adminConstants.CONTROLLER_RESULT_CODE_SUCCESS}'){
							$("#progress3").css("color","#4e88b9");
			            	$("#step2Div").hide();
			            	$("#step3Div").show();
			            	$("#stepFlag").val("3");
			            	$(".loginMainWrap").css("height" , "206px");
			            	$("#buttonDiv").hide();
			            	$("#cautionDiv").show();
			            	$("#loginBtn").show();
						}
						else if(data.resultCode == '${adminConstants.USER_PSWD_EQUAL}'){
							$("#newPwdErrMsg").text("이전에 사용된 비밀번호는 사용하실 수 없습니다.");
							$("#newPwdErrMsg").show();
						}
						else{
							 messager.alert("<spring:message code='column.common.try.again_msg' />", "알림", "info");
						}
					}
				};
				ajax.call(options);
				
			}
		};
		
		
		//otp 번호 체크와 user 정보 조회
		function fncOtpCheck(){
			
			var ctfCd = $("#otpNumber").val().trim();
			
		    if(ctfCd == ''){
		        messager.alert("인증 번호를 입력해 주세요.", "알림", "info"); 
		        return false;
		    }
		    
			$("#sendCtfCd").val(ctfCd);
		
		    var options = {
		        url : "<spring:url value='/login/checkOtp.do' />"  //otp번호 체크하고 user정보 select
		        , data : $("#idForm").serialize()
		        , callBack : function(data) {
		        	
		            if(data.resultCode == '${adminConstants.CONTROLLER_RESULT_CODE_SUCCESS}') {
		            	$('.crtfCountDownArea').countdown("stop");
		            	layer.close("otpCertifyLayer");
		            	
		            	$("#progress2").css("color","#4e88b9");
		            	$("#step1Div").hide();
		            	$("#step2Div").show();
		            	$("#newPassword").val("");
		            	$("#stepFlag").val("2");
		            	
		            	userInfo = data.user; // user 객체 저장
		            	$("#usrNo").val(userInfo.usrNo);
		            }else if(data.resultCode === '${adminConstants.USER_WRONG_CFT}'){
		            	$("#notMatchCtfMsg").show();
		            }
		        }
		    }
		    ajax.call(options);
		};
		
		
		//otp 팝업창 열기
	 	function fncOpenOtpModal(){
	    	
	    	var options = {
					url : "<spring:url value='/login/loginOtpCertifyPop.do' />"
					, 	dataType : "HTML"
					, 	callBack : function(result){
						var config = {
							id : "otpCertifyLayer"
							, title : "OTP 인증"
							, width : 410
							, height: 250
							, body : result
							, button : "<button type='button' onclick=\"fncOtpCheck()\" class='btn btn-ok'>확인</button>"
						}
						layer.create(config);
					}
				};
				ajax.call(options);
	    }
		
		
		//otp번호 재발급
	    function fncOtpNumIssue(){
	    	fncNextAction();
	    }
	    
		
		//비밀번호 유효성 체크
	    function fncValidator(){
	        var strPw = $("#newPassword").val();
	        var num = strPw.search(/[0-9]/g);
	        var eng = strPw.search(/[a-z]/ig);
	        var spe = strPw.search(/[`~!@@#$%^&*|\\₩'₩";:₩/?]/gi);
	       

	       /*  var isSameChar = 0;
	        var char_1 , char_2;
	        for(var i = 0 ; i < strPw.length ; i++){
	            char_1 = strPw.charAt(i);
	            char_2 = strPw.charAt(i+1);
	            if(char_1 == char_2) isSameChar++;
	            
	            if(isSameChar > 1) {
	                $("#newPwdErrMsg").text("동일 숫자/문자가 연속으로 3자 이상 포함된 번호는 비밀번호로 사용하실수 없습니다.");
	                return "inARow"; 
	            }            
	        }
	         */
	        if(!pswdValid.checkPswdMatch(strPw)){
				$("#newPwdErrMsg").text("3자리 연속 반복된 문자나 숫자는 입력할 수 없습니다.");
				return "inARow"; 
			}else{
			}

	        if(strPw.length < 8 || strPw.length > 15 || num < 0 || eng < 0 || spe < 0 )
	        {
	            $("#newPwdErrMsg").text("8자 이상 15자 이하로 하되, 숫자와 영문자, 특수기호를 각각 1자 이상 입력해 주세요.");
	            return "char";
	        }
	        
	       
	        if(!fncIncludeIdValue(strPw, userInfo.tel) ||
	        !fncIncludeIdValue(strPw, userInfo.mobile)||
	        !fncIncludeIdValue(strPw, userInfo.email) ||
	        !fncIncludeIdValue(strPw, userInfo.loginId) ){
	        	 $("#newPwdErrMsg").text("개인정보와 관련된 번호는 비밀번호로 사용하실수 없습니다.");
		            return "memberInfo";
	        }
	        
	        
	       /*  var pswdHistList = userInfo.pswdHist; 
	        if(pswdHistList.length > 0 && pswdHistList[0] == strPw
	        		|| pswdHistList.length > 1 && pswdHistList[1] == strPw)
	        {
	            $("#newPwdErrMsg").text("이전에 사용된 비밀번호는 사용하실수 없습니다.");
	            return "before";
	        } 
	         */
	        
            $('#newPwdErrMsg').css("display", "none"); 
            validated = true;
            return "S"
	    }
		
		function fncIncludeIdValue(pswd, str){
			//개인정보 4자이상 포함 체크
			if(str == "") return true;
			var cnt = 0;
			for(i=0; i<str.length-3; i++){
				tmp = str.charAt(i) + str.charAt(i+1) + str.charAt(i+2) + str.charAt(i+3);
				//console.log(tmp);
				if(pswd.indexOf(tmp) > -1){
					cnt ++;
				}
			}
			if(cnt > 0){
			  return false;
			}

			return true;
		}

		
	</script>
	<style type="text/css">
		#progressTitle{
			text-align: left;
		    font-weight: bold;
		    margin-bottom: 40px;
		    margin-top : 10px;
		    font-size: 13pt;
		}
		#progressDiv{
		    display: flex;
		    text-align: center;
		    position: relative;
		    left: 62%;
		    width: fit-content;
		}
		.pwdInputDiv{
			display : flex;
		}
		.pwdDiv{
			margin-bottom : 10px;
			text-align : left;
		}
		.errMsgPwd{
			font-size: 8pt;
		    color: red;
		    left: 30%;
		    position: relative;	
		}
		#step3Div{
			align-items: center;
		    top: 93px;
		    font-size: 17pt;
		    align-self: center;
		    position: relative;
		}
		#cautionDiv{
			border: 1px solid #cacab4;
		    margin-top: 7px;
		    display: flex;
		    height: 100px;
		}
		#cautionTitleDiv{
			width: 25%;
		    border-right: 1px solid #8c8c7e;
		    height: 70%;
		    top: 15%;
		    text-align: center;
		    position: relative;
		}
		#cautionTitleP{
			top: 30%;
		    font-size: 10pt;
		    position: relative;
		    font-weight: bold;
		}
		#cautionInfoDiv{
			height: 50%;
		    position: relative;
		    text-align: left;
		    top: 23%;
		    margin-left: 30px;
		}
		#cautionInfoDiv ul{
			list-style: disc;
		}
		#cautionInfoDiv li{
			margin-bottom : 3px;
		}
	</style>
</head>
<body>
	<div class="login_cont" style="width:640px;left:42%;top:40%;">
		<div id="progressDiv" >
			<p id="progress1">사용자 ID 입력&nbsp;</p><p>></p> <p id="progress2"> &nbsp;비밀번호 설정  &nbsp;</p><p>></p><p id="progress3"> &nbsp;설정 완료</p>
		</div>		
		<div class="loginMainWrap" style="height:310px;">
		<div class="login_title" style="margin-bottom : 5px; ">비밀번호 변경</div>
			
			<!-- step1:사용자 ID 입력 단계  -->
			<form name="idForm" id="idForm" method="post" role="form" style="display:flex;">
				<div id="step1Div" style="width:72%;">
					<div id="progressTitle">▶ 사용자 ID 입력</div>
					<div class="login_input">
						<p class="login_label" style="width:30%;">사용자 ID</p>
						<input class="easyui-textbox" style="width:90%;height:30px;" type="text" data-options="prompt:'아이디',iconCls:'icon-man',iconWidth:38" name="loginId" id="loginId" title="아이디">	
					</div> 
				</div>
				<input type="text" name="ctfCd" id="sendCtfCd" style="display:none;" /> 
			</form>
			
			<!-- step2:비밀번호 설정 -->	
			<form name="pwdForm" id="pwdForm" method="post" role="form" style="display:flex;">
				<div id="step2Div" style="display:none;">
					<div id="progressTitle">
						▶ 비밀번호 설정
						<p style="font-size:8pt;font-weight:normal;">※비밀번호는 반드시 영문, 숫자, 특수문자가 각 1자리 이상 포함되어야 하며 최소 8자 ~ 최소 20자 이내로 입력해야 합니다.</p>
					</div>
					<div class="pwdDiv">
						<div class="pwdInputDiv">
							<p style="width:30%;">새 비밀번호</p>
							<input type="password"  name="pswd" id="newPassword" title="비밀번호" style="width:70%;"/>
						</div>
						<p class="errMsgPwd" id="newPwdErrMsg" >※ 8자 이상 15자 이하로 하되, 숫자와 영문자, 특수기호를 각각 1자 이상 입력해 주세요.</p>	
					</div> 
					<div class="pwdDiv">
						<div  class="pwdInputDiv">
							<p style="width:30%;">새 비밀번호 확인</p>
							<input type="password" name="pswdChk" id="newPasswordChk" title="비밀번호" style="width:70%;"/>
						</div>
						<p class="errMsgPwd" id="newPwdChkErrMsg" style="display:block;" >※ 입력하신 비밀번호가 일치하지 않습니다.</p>	
					</div> 
				</div>
				<input type="text" name="usrNo" id="usrNo" style="display:none;" /> 
			</form>
			
			<!-- step3:설정 완료-->	
			<div id="step3Div" style="display:none;">
				<p style="font-weight: bold;">비밀번호 설정이 완료되었습니다.</p>
			</div>
				
			<input type="text" style="display:none;" id="stepFlag" value="1"/>
			<div id="buttonDiv" style="margin-top:36px;">
			 	<button type="button" class="btn btn-d btn-type2"  onclick="fncNextAction()">확인</button>
			    <button type="button" class="btn btn-d btn-type2"  onclick="history.back()">취소</button>
			</div>
		
		</div>
		<div id="cautionDiv" style="display:none;">
			<div id="cautionTitleDiv" ><p id="cautionTitleP">유의사항</p></div>	
			<div id="cautionInfoDiv">
				<ul type="disc"  >
					<li>PW 오류 횟수 5회 시 PW 초기화됩니다.</li>
					<li>로그인 후 30분 간 사용이 없을 경우 자동으로 로그오프됩니다.</li>
					<li>30일 간 로그인되지 않으면 계정 잠금처리 됩니다.</li>
				</ul>
			</div>
		</div>
		<button type="button" class="btn btn-d btn-type2" id="loginBtn" onclick="location.href='/login/loginView.do'" style="display:none;float:right;margin-top:10px;">로그인</button>
	</div>
</body>
</html>




