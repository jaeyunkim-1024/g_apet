<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
	$(document).ready(function(){	
	});
	
	var ctfNo = "";
	var failCnt = 0;
	
	$(document).on("input paste", "#email", function(){
		var value = this.value;
		
		if(validation.email(value)) {
			$("#ctfSendEmailBtn").attr("disabled", false);
			$("#emailErrorMsg").css("visibility", "hidden");
			emailDupCheck();
		} else {
			$("#emailErrorMsg").text("메일 주소를 다시 확인해주세요.").css("visibility", "visible");
			btnDisabledControl("ctfSendEmailBtn", true);
		}
	});
	
	function btnDisabledControl(id, flag) {
		$("#" + id).attr("disabled", flag);
	}
	
	function emailDupCheck() {
		var options = {
			url : "<spring:url value='/member/emailDupCheck.do' />"
			, data : {
				email : $("#emailUpdateViewPopLayer #email").val()
			}
			, callBack : function(data) {
				if(data == "${adminConstants.CONTROLLER_RESULT_CODE_SUCCESS}") {
					$("#emailErrorMsg").css("visibility", "hidden");
					btnDisabledControl("ctfSendEmailBtn", false);
				} else {
					$("#emailErrorMsg").text("이미 사용 중인 메일 주소에요.").css("visibility", "visible");
					btnDisabledControl("ctfSendEmailBtn", true);
				}
			}
    	}
    	ajax.call(options);
	}
	
	function ctfSendEmail() {
		var options = {
			url : "<spring:url value='/member/ctfSendEmail.do' />"
			,data : {
				email : $("#emailUpdateViewPopLayer #email").val(),
				nickNm : "${nickNm}"
			}
			,callBack : function(data){
				ctfNo = data;
				
				failCnt = 0;	// 실패건수 초기화
				$("#confirmArea").show();	// 인증번호 입력부분 노출
				$("#emailUpdateViewPopLayer").css("height", "125px");	// 레이어 높이 추가
				$("#ctfCd").val("");	// 인증번호 입력값 초기화
				$("#ctfErrorMsg").css("visibility", "hidden");	// 인증번호 에러 문구부분 미노출
				countDown();
			}
		}
		ajax.call(options);
	}
	
	function countDown() {
		// 인증 번호 입력 시간 카운트다운
	    $(".crtfCountDownArea").show();
	    var endTime = new Date();
	    endTime.setMinutes(endTime.getMinutes() + 3);
	    $(".crtfCountDownArea").countdown(endTime, function (event) {
	        var mm = event.strftime('%M');
	        var ss = event.strftime('%S');
	        $(".crtfCountDownArea").html(mm + ":" + ss);
	    }).on('finish.countdown', function () {
	    	failCnt = 3;	// 강제 세팅
	    	$("#ctfErrorMsg").text("인증번호를 재발송해주세요").css("visibility", "visible");
	    });
	}

	function confirm() {
		var inputCtfNo = $("#emailUpdateViewPopLayer #ctfCd").val();
		if(inputCtfNo == ctfNo) {
			$("#confirmBtn").css("visibility", "hidden");
			$("#emailUpdateViewPopLayer_dlg-buttons .btn-ok").attr("disabled", false);
			$("#ctfErrorMsg").css("visibility", "hidden");
			$(".crtfCountDownArea").countdown('pause'); 
		} else {
			if(failCnt < 2) {
				$("#ctfErrorMsg").text("인증번호를 확인해 주세요").css("visibility", "visible");
				failCnt++;
			} else {
				$("#ctfErrorMsg").text("인증번호를 재발송해주세요").css("visibility", "visible");
			}
		}
	}
	
</script>

<div class="modal fade" id="emailUpdateViewPopLayer"    title="알림">
    <div id="sendArea" class="layer-content">
        <div class="ctfArea" style="margin: 10px 0px 0px;display:flex;">
	        <p style="width:20%;padding-top:5px;">이메일</p>
	        <div style="display:flex;width: 70%;float:right;border: #cacab4 1px solid;margin-right: 20px;">
	            <input type="text" id="email" name="email" style="width:100%;border:none;border-right:0px;border-top:0px;" class="validate[custom[email2]]">
	        </div>
 			<button id="ctfSendEmailBtn" onclick="ctfSendEmail()" class="btn btn-d btn-type1" style="width:30%;" disabled>인증번호 발송</button>
       </div>
       <p  id="emailErrorMsg" style="padding-left:16%;font-size:8pt;color:red;visibility:hidden">이메일 에러 문구</p>
    </div>
    <div id="confirmArea" class="layer-content" style="display:none;">
        <div class="ctfArea" style="margin: 0px 0px 0px;display:flex;">
	        <p style="width:20%;padding-top:5px;">인증번호</p>
	        <div style="display:flex;width: 70%;float:right;border: #cacab4 1px solid;margin-right: 20px;">
	            <input type="text" id="ctfCd" name="ctfCd" style="width:80%;border:none;border-right:0px;border-top:0px;">
	            <p class="crtfCountDownArea" style="float: right;color:red;width:20%;" ></p>
	        </div>
 			<button id="confirmBtn" onclick="confirm()" class="btn btn-d btn-type1" style="width:30%;">인증확인</button>
       </div>
       <p  id="ctfErrorMsg" style="padding-left:16%;font-size:8pt;color:red;visibility:hidden">인증번호 에러 문구</p>
    </div>
</div>