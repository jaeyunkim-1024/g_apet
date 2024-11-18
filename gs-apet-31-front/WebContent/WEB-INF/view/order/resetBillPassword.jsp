<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="pbd">
	<input type="password" style="display:none;"/><!-- 크롬 패스워드 자동완성 방지 -->
	<div class="phd">
		<div class="in">
			<h1 class="tit">결제 비밀번호 재등록<!--결제 비밀번호 입력 --></h1>
			<button type="button" class="btnPopClose">닫기</button>
		</div>
	</div>
	<form>
		<input type="hidden" id="rpw0" name="rpw0" value="">
		<input type="hidden" id="rpw1" name="rpw1" value="">
		<input type="hidden" id="rpw2" name="rpw2" value="">
		<input type="hidden" id="rpw3" name="rpw3" value="">
		<input type="hidden" id="rpw4" name="rpw4" value="">
		<input type="hidden" id="rpw5" name="rpw5" value="">
		<input type="hidden" id="rpwr0" name="rpwr0" value="">
		<input type="hidden" id="rpwr1" name="rpwr1" value="">
		<input type="hidden" id="rpwr2" name="rpwr2" value="">
		<input type="hidden" id="rpwr3" name="rpwr3" value="">
		<input type="hidden" id="rpwr4" name="rpwr4" value="">
		<input type="hidden" id="rpwr5" name="rpwr5" value="">
		<input type="hidden" id="resetFinalPassword" name="resetFinalPassword" value="">
	</form>
	<div class="pct">
		<main class="poptents">
			<div class="uibilpwdmod payMentBox" id="resetFirstPassword">
				<div class="hdts">
					<div class="boxs">
						<div class="txt">
							<p class="t" id="resetFirstInputPasswordTxt">결제 비밀번호를 입력해주세요.</p>
							<p class="t" id="resetNotAvailablePasswordTxt" style="display: none">비밀번호로 사용할 수 없는 숫자입니다. <br> 다시 입력해주세요. </p>
							<p class="t" id="resetRetryPasswordTxt" style="display: none">비밀번호가 일치하지 않습니다. <br> 다시 입력해주세요. </p>
						</div>
						<div class="dots">
							<em class="dot" id="rp0">.</em>
							<em class="dot" id="rp1">.</em>
							<em class="dot" id="rp2">.</em>
							<em class="dot" id="rp3">.</em>
							<em class="dot" id="rp4">.</em>
							<em class="dot" id="rp5">.</em>
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
							<button type="button" class="bt res" onclick="resetRandomKeyPad();">재배열</button>
							<button type="button" class="bt del" onclick="resetFirstDeletePassword();">삭제</button>
						</div>
					</div>
				</div>
			</div>
			<div class="uibilpwdmod payMentBox" id="resetConfirmPassword" style="display: none">
				<div class="hdts">
					<div class="boxs">
						<div class="txt">
							<p class="t" id="resetValidPasswordTxt">확인을 위해 한번 더 입력해주세요.</p>
						</div>
						<div class="dots">
							<em class="dot" id="rpr0">.</em>
							<em class="dot" id="rpr1">.</em>
							<em class="dot" id="rpr2">.</em>
							<em class="dot" id="rpr3">.</em>
							<em class="dot" id="rpr4">.</em>
							<em class="dot" id="rpr5">.</em>
						</div>
						<%--<div class="ttt"><a class="lk" href="javascript:;">비밀번호 재설정</a></div>--%>
					</div>
				</div>
				<div class="cdts">
					<div class="gdmsg">연속된 숫자, 동일한 숫자 반복, 생년월일</div>
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
							<button type="button" class="bt res" onclick="resetRandomKeyPad();">재배열</button>
							<button type="button" class="bt del" onclick="resetConfirmDeletePassword();">삭제</button>
						</div>
					</div>
				</div>
			</div>
		</main>
	</div>
</div>

<script type="text/javascript">
	// count 변수
	var resetFirstInputCnt = 0;
	var resetFirstMaxCnt = 6;
	var resetConfirmInputCnt = 0;
	var resetConfirmMaxCnt = 6;

	$(document).ready(function(){

		// 키패드 랜덤 배치
		resetRandomKeyPad();
	}); // End Ready

	$(function() {

		// 키패드 컨트롤
		let sBtn = $("#resetFirstPassword ul.nums > li");
		let eBtn = $("#resetConfirmPassword ul.nums > li");

		sBtn.find("button").click(function(){

			$("#resetFirstInputPasswordTxt").show();
			$("#resetNotAvailablePasswordTxt").hide();
			$("#resetRetryPasswordTxt").hide();

			$("#rp"+resetFirstInputCnt).addClass("on");
			$("#rpw"+resetFirstInputCnt).val($(this).text());

			// 카운트 증가.
			resetFirstAddCnt();

			if(resetFirstAddMax()){
				resetCheckPassword();
			}

			/*let resetFirstPassword = $("#rpw0").val() + $("#rpw1").val() + $("#rpw2").val() + $("#rpw3").val() + $("#rpw4").val() + $("#rpw5").val();

			if(!resetNumberCheck(resetFirstPassword)) {

				$("#resetFirstInputPasswordTxt").hide();
				$("#notAvailablePasswordTxt").show();

				let resetCnt = resetFirstInputCnt-1;

				$("#rp"+resetCnt).removeClass("on");
				$("#rpw"+resetCnt).val("");

				resetFirstRemoveAddCnt();
				return;
			}

			if(!resetStraightCheck(resetFirstPassword)){

				$("#resetFirstInputPasswordTxt").hide();
				$("#notAvailablePasswordTxt").show();

				let resetCnt = resetFirstInputCnt-1;

				$("#rp"+resetCnt).removeClass("on");
				$("#rpw"+resetCnt).val("");

				resetFirstRemoveAddCnt();
				return;
			}

			if(!resetCheckIncludeBirth(resetFirstPassword)){

				$("#resetFirstInputPasswordTxt").hide();
				$("#notAvailablePasswordTxt").show();

				let resetCnt = resetFirstInputCnt-1;

				$("#rp"+resetCnt).removeClass("on");
				$("#rpw"+resetCnt).val("");

				resetFirstRemoveAddCnt();
				return;

			}*/

		})

		eBtn.find("button").click(function(){   // sBtn에 속해 있는  a 찾아 클릭 하면.

			$("#resetValidPasswordTxt").show();

			$("#rpr"+resetConfirmInputCnt).addClass("on");
			$("#rpwr"+resetConfirmInputCnt).val($(this).text());

			// 카운트 증가.
			resetConfirmAddCnt();

			// 증가 완료(비밀번호 검증)
			if(resetConfirmAddMax()){
				resetConfirmValidPassword();
			}

		})

	});

	// 랜덤 키패드 배치
	function resetRandomKeyPad() {

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
	function resetFirstAddCnt(){

		if(resetFirstInputCnt >= resetFirstMaxCnt){
			return false;
		}

		resetFirstInputCnt++;
	}

	// 비밀번호 확인 입력 횟수 증가
	function resetConfirmAddCnt(){

		if(resetConfirmInputCnt >= resetConfirmMaxCnt){
			return false;
		}

		resetConfirmInputCnt++;
	}

	// 처음 입력받은 비밀번호 max check
	function resetFirstAddMax(){
		return resetFirstInputCnt === resetFirstMaxCnt;
	}

	// 비밀번호 확인 max check
	function resetConfirmAddMax(){
		return resetConfirmInputCnt === resetConfirmMaxCnt;
	}

	// 처음 입력받은 비밀번호 횟수 순차 삭제
	function resetFirstRemoveAddCnt(){

		if(resetFirstInputCnt > 0){
			resetFirstInputCnt--;
		}else{
			return;
		}

	}

	// 비밀번호 확인 횟수 순차 삭제
	function resetConfirmRemoveAddCnt(){

		if(resetConfirmInputCnt > 0){
			resetConfirmInputCnt--;
		}else{
			return;
		}
	}

	// 처음 입력받은 비밀번호 순차 삭제
	function resetFirstDeletePassword(){

		let resetCnt = resetFirstInputCnt-1;

		$("#rpw"+resetCnt).val("");
		$("#rp"+resetCnt).removeClass("on");

		resetFirstRemoveAddCnt();

	}

	// 비밀번호 확인 순차 삭제
	function resetConfirmDeletePassword(){

		let cnt = resetConfirmInputCnt-1;

		$("#rpwr"+cnt).val("");
		$("#rpr"+cnt).removeClass("on");

		resetConfirmRemoveAddCnt();

	}

	// 비밀번호 확인 으로 change
	function resetCheckPassword(){

		let resetFirstPassword = $("#rpw0").val() + $("#rpw1").val() + $("#rpw2").val() + $("#rpw3").val() + $("#rpw4").val() + $("#rpw5").val();

		if(!resetNumberCheck(resetFirstPassword)) {

			$("#resetFirstInputPasswordTxt").hide();
			$("#resetNotAvailablePasswordTxt").show();

			resetFirstInputCnt = 0;

			$("[id^='rp']").removeClass("on");
			$("[id^='rpw']").val("");

			//resetFirstRemoveAddCnt();
			return;
		}

		if(!resetStraightCheck(resetFirstPassword)){

			$("#resetFirstInputPasswordTxt").hide();
			$("#resetNotAvailablePasswordTxt").show();

			resetFirstInputCnt = 0;

			$("[id^='rp']").removeClass("on");
			$("[id^='rpw']").val("");

			//resetFirstRemoveAddCnt();
			return;
		}

		if(!resetCheckIncludeBirth(resetFirstPassword)){

			$("#resetFirstInputPasswordTxt").hide();
			$("#resetNotAvailablePasswordTxt").show();

			resetFirstInputCnt = 0;

			$("[id^='rp']").removeClass("on");
			$("[id^='rpw']").val("");

			//resetFirstRemoveAddCnt();
			return;

		}

		$("#resetFirstPassword").hide();
		resetRandomKeyPad();
		$("#resetConfirmPassword").show();
		$("#resetValidPasswordTxt").show();
	}

	// 처음으로 으로 change
	function resetResurrectPassword(){

		$("#resetFirstPassword").show();
		$("#resetFirstInputPasswordTxt").hide();
		resetRandomKeyPad();
		$("#resetConfirmPassword").hide();
	}

	// 처음 입력받은 비밀번호 reset
	function resetResetFirstPassword(){

		$("#rpw0").val("");
		$("#rpw1").val("");
		$("#rpw2").val("");
		$("#rpw3").val("");
		$("#rpw4").val("");
		$("#rpw5").val("");
		$("#resetFirstPassword div.dots > em.dot").removeClass("on");

		resetFirstInputCnt = 0;

	}

	// 비밀번호 확인 reset
	function resetResetConfirmPassword(){
		$("#rpwr0").val("");
		$("#rpwr1").val("");
		$("#rpwr2").val("");
		$("#rpwr3").val("");
		$("#rpwr4").val("");
		$("#rpwr5").val("");
		$("#resetConfirmPassword div.dots > em.dot").removeClass("on");

		resetConfirmInputCnt = 0;
	}

	// 비밀번호 확인 valid check
	function resetConfirmValidPassword(){

		let resetFirstPassword = $("#rpw0").val() + $("#rpw1").val() + $("#rpw2").val() + $("#rpw3").val() + $("#rpw4").val() + $("#rpw5").val();
		let resetConfirmPassword = $("#rpwr0").val() + $("#rpwr1").val() + $("#rpwr2").val() + $("#rpwr3").val() + $("#rpwr4").val() + $("#rpwr5").val();

		if(resetFirstPassword !== resetConfirmPassword){
			$("#resetValidPasswordTxt").hide();
			$("#resetRetryPasswordTxt").show();

			resetResetConfirmPassword();

			resetResetFirstPassword();

			resetResurrectPassword();

		}else{
			$("#resetFinalPassword").val(resetConfirmPassword);

			// 모든 절차가 끝나면 빌링 비밀번호 update 시작
			confirmUpdateBillPassword();
		}

	}

	// 동일 숫자 check
	function resetNumberCheck(password){

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
	function resetCheckIncludeBirth(password){

		let birth = "<c:out value="${birth}"/>";
		let cnt = 0;

		for(let l=0; l<birth.length-3; l++){
			let tmp = birth.charAt(l) + birth.charAt(l+1) + birth.charAt(l+2) + birth.charAt(l+3);
			if(password.indexOf(tmp) > -1){
				cnt ++;
			}
		}

		return cnt <= 0;

	}

	// 비밀번호 연속 check
	function resetStraightCheck(password) {

		let pattern = /(012)|(123)|(234)|(345)|(456)|(567)|(678)|(789)|(890)|(098)|(987)|(876)|(765)|(654)|(543)|(432)|(321)|(210)/;

		if(pattern.test(password)){
			return false;
		}
		return true;
	}

</script>