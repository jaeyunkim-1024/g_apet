<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="pbd">
	<input type="password" style="display:none;"/><!-- 크롬 패스워드 자동완성 방지 -->
	<div class="phd">
		<div class="in">
			<h1 class="tit">결제 비밀번호 입력<!--결제 비밀번호 입력 --></h1>
			<button type="button" class="btnPopClose">닫기</button>
		</div>
	</div>
	<form>
		<input type="hidden" id="cpw0" name="cpw0" value="">
		<input type="hidden" id="cpw1" name="cpw1" value="">
		<input type="hidden" id="cpw2" name="cpw2" value="">
		<input type="hidden" id="cpw3" name="cpw3" value="">
		<input type="hidden" id="cpw4" name="cpw4" value="">
		<input type="hidden" id="cpw5" name="cpw5" value="">
		<input type="hidden" id="confirmFinalPassword" name="finalPassword" value="">
		<input type="hidden" id="confirmResetCertifyPassword" name="resetCertifyPassword" value="">
	</form>
	<div class="pct">
		<main class="poptents">
			<div class="uibilpwdmod payMentBox" id="confirmFirstPassword">
				<div class="hdts">
					<div class="boxs">
						<div class="txt">
							<p class="t" id="confirmFirstInputPasswordTxt">결제 비밀번호를 입력해주세요.</p>
							<p class="t" id="confirmFailInputPasswordTxt" style="display: none"></p>
						</div>
						<div class="dots">
							<em class="dot" id="cp0">.</em>
							<em class="dot" id="cp1">.</em>
							<em class="dot" id="cp2">.</em>
							<em class="dot" id="cp3">.</em>
							<em class="dot" id="cp4">.</em>
							<em class="dot" id="cp5">.</em>
						</div>
						<div class="ttt"><a class="lk" href="javascript:;" onclick="confirmResetBillPassword();">비밀번호 재설정</a></div>
					</div>
				</div>
				<div class="cdts">
					<div class="keynumsbox">
						<ul class="nums">
							<li><button type="button" class="nm" disabled>.</button></li>
							<li><button type="button" class="nm" onclick="">1</button></li>
							<li><button type="button" class="nm">2</button></li>
							<li><button type="button" class="nm">5</button></li>
							<li><button type="button" class="nm">4</button></li>
							<li><button type="button" class="nm">7</button></li>
							<li><button type="button" class="nm" disabled>.</button></li>
							<li><button type="button" class="nm">3</button></li>
							<li><button type="button" class="nm">8</button></li>
							<li><button type="button" class="nm">9</button></li>
							<li><button type="button" class="nm">6</button></li>
							<li><button type="button" class="nm">0</button></li>
						</ul>
						<div class="bts">
							<button type="button" class="bt res" onclick="confirmRandomKeyPad();">재배열</button>
							<button type="button" class="bt del" onclick="confirmFirstDeletePassword();">삭제</button>
						</div>
					</div>
				</div>
			</div>
		</main>
	</div>
</div>
<article class="popLayer a popBilPwdMod noClickClose" id="popBilPwdReset">
</article>

<script type="text/javascript">
	// count 변수
	var confirmInputCnt = 0;
	var confirmMaxCnt = 6;
	var confirmFailCnt = '<c:out value="${billInputFailCnt}"/>';
	var confirmFailMaxCnt = "4";	//5번 실패해야만 하지만 0부터 시작이므로 4로 설정


	$(document).ready(function(){


		if(confirmFailCnt === confirmFailMaxCnt){
			confirmFailCertConfirm();
		}
		// 키패드 랜덤 배치
		confirmRandomKeyPad();
	}); // End Ready

	$(function() {

		// 키패드 컨트롤
		let sBtn = $("#confirmFirstPassword ul.nums > li");

		sBtn.find("button").click(function(){

			$("#confirmFirstInputPasswordTxt").show();
			$("#confirmFailInputPasswordTxt").hide();


			$("#cp"+confirmInputCnt).addClass("on");
			$("#cpw"+confirmInputCnt).val($(this).text());

			// 카운트 증가.
			confirmFirstAddCnt();

			let confirmFirstPassword = $("#cpw0").val() + $("#cpw1").val() + $("#cpw2").val() + $("#cpw3").val() + $("#cpw4").val() + $("#cpw5").val();
			$("#confirmFinalPassword").val(confirmFirstPassword);

			if(confirmFirstAddMax()){
				confirmCheckPassword();
			}

		})

	});

	function confirmFailCertConfirm(){
		ui.confirm('비밀번호 입력을 5회 실패하여 본인인증이 필요합니다.<br/>본인인증을 진행할까요?',{
			ycb:function(){
				selectCertType("confirmPassword");
			},
			ncb:function(){
				return false;
			},
			ybt:'본인인증하기 ',
			nbt:'취소'
		});
	}

	// 랜덤 키패드 배치
	function confirmRandomKeyPad() {

		let len = $('ul.nums>li').length;

		$('ul.nums').each(function() {

			let ul = $(this);
			let liArr = ul.children('li');

			liArr.sort(function() {
				let temp = parseInt(Math.random() * len);
				let temp1 = parseInt(Math.random() * len);
				return temp1-temp;
			}).appendTo(ul);
		});
	}

	// 처음 입력받은 비밀번호 입력 횟수 증가
	function confirmFirstAddCnt(){

		if(confirmInputCnt >= confirmMaxCnt){
			return false;
		}

		confirmInputCnt++;
	}


	// 처음 입력받은 비밀번호 max check
	function confirmFirstAddMax(){
		return confirmInputCnt === confirmMaxCnt;
	}

	// 처음 입력받은 비밀번호 횟수 순차 삭제
	function confirmFirstRemoveAddCnt(){

		if(confirmInputCnt > 0){
			confirmInputCnt--;
		}else{
			return;
		}

	}

	// 처음 입력받은 비밀번호 순차 삭제
	function confirmFirstDeletePassword(){

		let cnt = confirmInputCnt-1;

		$("#cpw"+cnt).val("");
		$("#cp"+cnt).removeClass("on");

		confirmFirstRemoveAddCnt();

	}

	// 처음 입력받은 비밀번호 reset
	function confirmResetFirstPassword(){
		$("#cpw0").val("");
		$("#cpw1").val("");
		$("#cpw2").val("");
		$("#cpw3").val("");
		$("#cpw4").val("");
		$("#cpw5").val("");
		$("#confirmFirstPassword div.dots > em.dot").removeClass("on");

		confirmInputCnt = 0;

	}

	function confirmCheckPassword(){

		let confirmFinalPassword = $("#confirmFinalPassword").val();
		let url = "<spring:url value='/order/checkBillPassword' />";

		let sendData = {
			simpScrNo : confirmFinalPassword
		}

		let options = {
			url : url
			, data : sendData
			, done : function(data){

				var resultCode = data.resultCode;
				var resultMsg = data.resultMsg;

				confirmCheckResult(resultCode, resultMsg);

			}
		}
		ajax.call(options);
	}

	function confirmCheckResult(resultCode, resultMsg){

		if(resultCode === "${frontConstants.CONTROLLER_RESULT_CODE_SUCCESS}"){
			// 주문번호 채번
			orderPay.insertOrder();
		}else{
			if(resultCode === '${exceptionConstants.ERROR_CODE_LOGIN_PW_FAIL}'){
				confirmResetFirstPassword();
				confirmFailCnt++;
				$("#confirmFirstInputPasswordTxt").hide();
				$("#confirmFailInputPasswordTxt").show();
				$("#confirmFailInputPasswordTxt").html("비밀번호가 일치하지 않습니다. <br> 다시입력해주세요. (" + confirmFailCnt +"/5)");
			}else if(resultCode === '${exceptionConstants.ERROR_CODE_FO_PW_FAIL_CNT}'){
				confirmResetFirstPassword();
				ui.confirm('비밀번호 입력을 5회 실패하여 본인인증이 필요합니다.<br/>본인인증을 진행할까요?',{
					ycb:function(){
						selectCertType("confirmPassword");
					},
					ncb:function(){
						return false;
					},
					ybt:'본인인증하기 ',
					nbt:'취소'
					
				});
				return;
			}

		}

	}

	// 비밀번호 재설정
	function confirmResetBillPassword(){

		selectCertType("confirmPassword");

	}

	function confirmOpenResetPasswordPop(){

		let url = "<spring:url value='/order/openResetPasswordPop' />";
		let options = {
			url : url
			, data : {
				birth : "<c:out value="${birth}"/>"
			}
			, dataType : "html"
			, done : function(html){
				$("#popBilPwdReset").html(html);
				ui.popLayer.open("popBilPwdReset");
			}
		}
		ajax.call(options);
	}

	function confirmUpdateBillPassword(){

		$("#confirmResetCertifyPassword").val($("#resetFinalPassword").val());

		let url = "<spring:url value='/order/updateBillPassword' />";

		let options = {
			url : url
			, data : {
				simpScrNo : $("#confirmResetCertifyPassword").val()
			}
			, done : function(result){

				ui.alert('결제 비밀번호가 변경되었습니다.',{
					ycb:function(){
						closeLayer('popBilPwdReset');
						$("#confirmResetCertifyPassword").val("");
						confirmFailCnt = 0;
					},
					ybt:'확인'
				});
			}
		}
		ajax.call(options);
	}

</script>