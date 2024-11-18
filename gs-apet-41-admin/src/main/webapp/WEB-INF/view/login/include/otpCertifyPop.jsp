<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
$(document).ready(function(){	
		// 인증 번호 입력 시간 카운트다운
	    $(".crtfCountDownArea").show();
	    var endTime = new Date();
	    endTime.setMinutes(endTime.getMinutes() + 3);
	    $(".crtfCountDownArea").countdown(endTime, function (event) {
	        var mm = event.strftime('%M');
	        var ss = event.strftime('%S');
	        $(".crtfCountDownArea").html(mm + ":" + ss);
	    }).on('finish.countdown', function () {
	        /* $("#otpNumber").attr('disabled', true);
	        $(".ctfArea").hide();
	        $("#otpNumber").val(""); */

        	var options = {
					url : "<spring:url value='/login/removeOtpSession.do' />"
					, callBack : function(data) {
				        messager.alert("시간이 초과하였습니다. 다시 시도해주세요.","알림","error", function(){
							//layer.close("otpCertifyLayer");
				        });
					}
        	}
        	ajax.call(options);
        	
	    });
	});
	
	function searchEnterKey(){
		if ( window.event.keyCode == 13 ) {
			fncLoginActive();
		}
	}
</script>

<div class="modal fade" id="popupOtpLayer"    title="OTP 인증" onkeydown="javascript:searchEnterKey();">
    <!-- <div class="layer-header blind"><h2>OTP 인증</h2></div> -->
    <div>
    <div class="layer-content" style="margin-top: 15px;">
        <p style="color:gray;font-size:8pt;">휴대폰에서 받은 OTP인증번호 6자리 수를 확인 후 입력해 주세요.</p>
        <div class="ctfArea" style="margin: 20px 0px 0px;display:flex;">
	        <p  style="width:20%;padding-top:5px;">인증번호</p>
	        <div style="display:flex; width:85%;float:right;border: #cacab4 1px solid;padding:5px;">
	            <input type="text" id="otpNumber" name="ctfCd"  placeholder="인증번호 6자리 숫자" title="인증번호" style="width:45%;height:30px;border:none;border-right:0px; border-top:0px;"  maxlength="6" > <!-- onKeyDown="checkKeysInt(event);" onKeyUp="checkKeysInt(event);" -->
			    <p class="crtfCountDownArea" style="float: right;color:red;width:15%;" ></p>
	            <button onClick="fncOtpNumIssue()" class="btn btn-d btn-type1" style="width:32%;" id="checkCtfBtn">재발급</button>
	        </div>
       </div>
    </div>
    <p  id="notMatchCtfMsg" style="padding-left:19%;font-size:8pt;color:red;display:none;">인증번호를 정확하게 입력해 주세요.</p>
    <!-- <div style="text-align:center;margin:20px;">
	    <button type="button" class="btn btn-d btn-type2"  onclick="fncCloseModal()">취소</button>
	    <button type="button" class="btn btn-d btn-type2"  id="loginActiveBtn">확인</button>
    </div> -->
    </div>
</div>
