<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="pbd">
	<input type="password" style="display:none;"/><!-- 크롬 패스워드 자동완성 방지 -->
	<div class="phd">
		<div class="in">
			<h1 class="tit">결제 비밀번호 등록<!--결제 비밀번호 입력 --></h1>
			<button type="button" class="btnPopClose none" onclick="closeRegistPasswordPop();">닫기</button>
		</div>
	</div>
	<form>
		<input type="hidden" id="pw0" name="pw0" value="">
		<input type="hidden" id="pw1" name="pw1" value="">
		<input type="hidden" id="pw2" name="pw2" value="">
		<input type="hidden" id="pw3" name="pw3" value="">
		<input type="hidden" id="pw4" name="pw4" value="">
		<input type="hidden" id="pw5" name="pw5" value="">
		<input type="hidden" id="pwr0" name="pwr0" value="">
		<input type="hidden" id="pwr1" name="pwr1" value="">
		<input type="hidden" id="pwr2" name="pwr2" value="">
		<input type="hidden" id="pwr3" name="pwr3" value="">
		<input type="hidden" id="pwr4" name="pwr4" value="">
		<input type="hidden" id="pwr5" name="pwr5" value="">
		<input type="hidden" id="finalPassword" name="finalPassword" value="">
	</form>
	<div class="pct">
		<main class="poptents">
			<div class="uibilpwdmod payMentBox" id="firstPassword">
				<div class="hdts">
					<div class="boxs">
						<div class="txt">
							<p class="t" id="firstInputPasswordTxt">결제 비밀번호를 입력해주세요.</p>
							<p class="t" id="notAvailablePasswordTxt" style="display: none">비밀번호로 사용할 수 없는 숫자입니다. <br> 다시 입력해주세요. </p>
							<p class="t" id="retryPasswordTxt" style="display: none">비밀번호가 일치하지 않습니다. <br> 다시 입력해주세요. </p>
						</div>
						<div class="dots">
							<em class="dot" id="p0">.</em>
							<em class="dot" id="p1">.</em>
							<em class="dot" id="p2">.</em>
							<em class="dot" id="p3">.</em>
							<em class="dot" id="p4">.</em>
							<em class="dot" id="p5">.</em>
						</div>
						<%--<div class="ttt"><a class="lk" href="javascript:;">비밀번호 재설정</a></div>--%>
					</div>
				</div>
				<div class="cdts">
					<div class="gdmsg">연속된 숫자, 동일한 숫자 반복, 생년월일 사용 불가</div>
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
							<button type="button" class="bt res" onclick="randomKeyPad();">재배열</button>
							<button type="button" class="bt del" onclick="firstDeletePassword();">삭제</button>
						</div>
					</div>
				</div>
			</div>
			<div class="uibilpwdmod payMentBox" id="confirmPassword" style="display: none">
				<div class="hdts">
					<div class="boxs">
						<div class="txt">
							<p class="t" id="validPasswordTxt">확인을 위해 한번 더 입력해주세요.</p>
						</div>
						<div class="dots">
							<em class="dot" id="pr0">.</em>
							<em class="dot" id="pr1">.</em>
							<em class="dot" id="pr2">.</em>
							<em class="dot" id="pr3">.</em>
							<em class="dot" id="pr4">.</em>
							<em class="dot" id="pr5">.</em>
						</div>
						<%--<div class="ttt"><a class="lk" href="javascript:;">비밀번호 재설정</a></div>--%>
					</div>
				</div>
				<div class="cdts">
					<div class="gdmsg">연속된 숫자, 동일한 숫자 반복, 생년월일 사용 불가</div>
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
							<button type="button" class="bt res" onclick="randomKeyPad();">재배열</button>
							<button type="button" class="bt del" onclick="confirmDeletePassword();">삭제</button>
						</div>
					</div>
				</div>
			</div>
		</main>
	</div>
</div>

<script type="text/javascript">
	// count 변수
	var firstInputCnt = 0;
	var firstMaxCnt = 6;
	var confirmInputCnt = 0;
	var confirmMaxCnt = 6;

	$(document).ready(function(){

		// 키패드 랜덤 배치
		randomKeyPad();
	}); // End Ready

	$(function() {

		// 키패드 컨트롤
		let sBtn = $("#firstPassword ul.nums > li");
		let eBtn = $("#confirmPassword ul.nums > li");

		sBtn.find("button").click(function(){

			$("#firstInputPasswordTxt").show();
			$("#notAvailablePasswordTxt").hide();
			$("#retryPasswordTxt").hide();

			$("#p"+firstInputCnt).addClass("on");
			$("#pw"+firstInputCnt).val($(this).text());

			// 카운트 증가.
			firstAddCnt();

			if(firstAddMax()){
				checkPassword();
			}

		})

		eBtn.find("button").click(function(){   // sBtn에 속해 있는  a 찾아 클릭 하면.

			$("#validPasswordTxt").show();

			$("#pr"+confirmInputCnt).addClass("on");
			$("#pwr"+confirmInputCnt).val($(this).text());

			// 카운트 증가.
			confirmAddCnt();

			// 증가 완료(비밀번호 검증)
			if(confirmAddMax()){
				confirmValidPassword();
			}

		})

	});

	// 랜덤 키패드 배치
	function randomKeyPad() {

		let len = $('ul.nums>li').length;

		$('ul.nums').each(function() {

			let ul = $(this);
			let liArr = ul.children('li');

			liArr.sort(function() {
				let temp = parseInt(Math.random()*len);
				let temp1 = parseInt(Math.random()*len);
				return temp1-temp;
			}).appendTo(ul);
		});
	}

	// 처음 입력받은 비밀번호 입력 횟수 증가
	function firstAddCnt(){

		if(firstInputCnt >= firstMaxCnt){
			return false;
		}

		firstInputCnt++;
	}

	// 비밀번호 확인 입력 횟수 증가
	function confirmAddCnt(){

		if(confirmInputCnt >= confirmMaxCnt){
			return false;
		}

		confirmInputCnt++;
	}

	// 처음 입력받은 비밀번호 max check
	function firstAddMax(){
		return firstInputCnt === firstMaxCnt;
	}

	// 비밀번호 확인 max check
	function confirmAddMax(){
		return confirmInputCnt === confirmMaxCnt;
	}

	// 처음 입력받은 비밀번호 횟수 순차 삭제
	function firstRemoveAddCnt(){

		if(firstInputCnt > 0){
			firstInputCnt--;
		}else{
			return;
		}

	}

	// 비밀번호 확인 횟수 순차 삭제
	function confirmRemoveAddCnt(){

		if(confirmInputCnt > 0){
			confirmInputCnt--;
		}else{
			return;
		}
	}

	// 처음 입력받은 비밀번호 순차 삭제
	function firstDeletePassword(){

		let cnt = firstInputCnt-1;

		$("#pw"+cnt).val("");
		$("#p"+cnt).removeClass("on");

		firstRemoveAddCnt();

	}

	// 비밀번호 확인 순차 삭제
	function confirmDeletePassword(){

		let cnt = confirmInputCnt-1;

		$("#pwr"+cnt).val("");
		$("#pr"+cnt).removeClass("on");

		confirmRemoveAddCnt();

	}

	// 비밀번호 확인 으로 change
	function checkPassword(){

		let firstPassword = $("#pw0").val() + $("#pw1").val() + $("#pw2").val() + $("#pw3").val() + $("#pw4").val() + $("#pw5").val();

		if(!numberCheck(firstPassword)) {

			$("#firstInputPasswordTxt").hide();
			$("#notAvailablePasswordTxt").show();

			let cnt = firstInputCnt = 0;

			$("[id^='p']").removeClass("on");
			$("[id^='pw']").val("");

			//firstRemoveAddCnt();
			return;
		}

		if(!straightCheck(firstPassword)){

			$("#firstInputPasswordTxt").hide();
			$("#notAvailablePasswordTxt").show();

			firstInputCnt = 0;

			$("[id^='p']").removeClass("on");
			$("[id^='pw']").val("");

			//firstRemoveAddCnt();
			return;
		}

		if(!checkIncludeBirth(firstPassword)){

			$("#firstInputPasswordTxt").hide();
			$("#notAvailablePasswordTxt").show();

			firstInputCnt = 0;

			$("[id^='p']").removeClass("on");
			$("[id^='pw']").val("");

			//firstRemoveAddCnt();
			return;

		}

		$("#firstPassword").hide();
		randomKeyPad();
		$("#confirmPassword").show();
		$("#validPasswordTxt").show();
	}

	// 처음으로 으로 change
	function resurrectPassword(){

		$("#firstPassword").show();
		$("#firstInputPasswordTxt").hide();
		randomKeyPad();
		$("#confirmPassword").hide();
	}

	// 처음 입력받은 비밀번호 reset
	function resetFirstPassword(){

		$("#pw0").val("");
		$("#pw1").val("");
		$("#pw2").val("");
		$("#pw3").val("");
		$("#pw4").val("");
		$("#pw5").val("");
		$("#firstPassword div.dots > em.dot").removeClass("on");

		firstInputCnt = 0;

	}

	// 비밀번호 확인 reset
	function resetConfirmPassword(){

		$("#pwr0").val("");
		$("#pwr1").val("");
		$("#pwr2").val("");
		$("#pwr3").val("");
		$("#pwr4").val("");
		$("#pwr5").val("");
		$("#confirmPassword div.dots > em.dot").removeClass("on");

		confirmInputCnt = 0;
	}

	// 비밀번호 확인 valid check
	function confirmValidPassword(){

		let firstPassword = $("#pw0").val() + $("#pw1").val() + $("#pw2").val() + $("#pw3").val() + $("#pw4").val() + $("#pw5").val();
		let confirmPassword = $("#pwr0").val() + $("#pwr1").val() + $("#pwr2").val() + $("#pwr3").val() + $("#pwr4").val() + $("#pwr5").val();

		if(firstPassword !== confirmPassword){
			$("#validPasswordTxt").hide();
			$("#retryPasswordTxt").show();

			resetConfirmPassword();

			resetFirstPassword();

			resurrectPassword();

		}else{
			$("#finalPassword").val(confirmPassword);

			// 모든 절차가 끝나면 빌링 등록 process 시작
			billingRegsistTemp("Y");
		}

	}

	// 동일 숫자 check
	function numberCheck(password){

		//반복 문자 체크
		let sameTextCnt = 0;
		for(let k=0; k<password.length-1; k++){
			if(password.charCodeAt(k) === password.charCodeAt(k+1)){
				sameTextCnt++;
			}else{
				sameTextCnt = 0;
			}
			if(sameTextCnt >= 2){
				return false;
			}
		}


		return true;
	}

	// 생일 번호와 겹치는지 check
	function checkIncludeBirth(password){

		let birth = "<c:out value="${birth}"/>";

		if(birth === password){
			return false;
		}

		return true;
		/*let cnt = 0;

		for(let l=0; l<birth.length-3; l++){
			let tmp = birth.charAt(l) + birth.charAt(l+1) + birth.charAt(l+2) + birth.charAt(l+3);
			if(password.indexOf(tmp) > -1){
				cnt ++;
			}
		}

		return cnt <= 0;*/

	}

	// 비밀번호 연속 check
	function straightCheck(password) {

		let pattern = /(012)|(123)|(234)|(345)|(456)|(567)|(678)|(789)|(890)|(098)|(987)|(876)|(765)|(654)|(543)|(432)|(321)|(210)/;

		if(pattern.test(password)){
			return false;
		}
		return true;
	}

	function closeRegistPasswordPop(){

		ui.confirm('비밀번호 등록 후 간편결제를 이용할 수 있어요<br/>나중에 등록할까요?',{ // 컨펌 창 옵션들
			ycb:function(){
				closeLayer('popBilPwdMod');
			},
			ncb:function(){
				return false;
			},
			ybt:"예", // 기본값 "확인"
			nbt:"아니오"  // 기본값 "취소"
		});
	}

</script>