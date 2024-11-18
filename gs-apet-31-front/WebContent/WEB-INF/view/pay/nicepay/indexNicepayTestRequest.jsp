<html>
	<head>
		<title>NICEPAY PAY REQUEST</title>
		<meta charset="utf-8">
		<style>
			html,body {height: 100%;}
			form {overflow: text;}
		</style>
		<!-- 아래 js는 PC 결제창 전용 js입니다.(모바일 결제창 사용시 필요 없음) -->
		<script src="https://web.nicepay.co.kr/v3/webstd/js/nicepay-3.0.js" type="text/javascript"></script>
		<script type="text/javascript">
			//결제창 최초 요청시 실행됩니다.
			function nicepayStart(){
				if(checkPlatform(window.navigator.userAgent) == "mobile"){//모바일 결제창 진입
					document.payForm.action = "https://web.nicepay.co.kr/v3/v3Payment.jsp";
					document.payForm.acceptCharset="euc-kr";
					document.payForm.submit();
				}else{//PC 결제창 진입
					goPay(document.payForm);
				}
			}

			//[PC 결제창 전용]결제 최종 요청시 실행됩니다. <<'nicepaySubmit()' 이름 수정 불가능>>
			function nicepaySubmit(){
				document.payForm.submit();
			}

			//[PC 결제창 전용]결제창 종료 함수 <<'nicepayClose()' 이름 수정 불가능>>
			function nicepayClose(){
				alert("결제가 취소 되었습니다");
			}

			//pc, mobile 구분(가이드를 위한 샘플 함수입니다.)
			function checkPlatform(ua) {
				if(ua === undefined) {
					ua = window.navigator.userAgent;
				}

				ua = ua.toLowerCase();
				var platform = {};
				var matched = {};
				var userPlatform = "pc";
				var platform_match = /(ipad)/.exec(ua) || /(ipod)/.exec(ua)
						|| /(windows phone)/.exec(ua) || /(iphone)/.exec(ua)
						|| /(kindle)/.exec(ua) || /(silk)/.exec(ua) || /(android)/.exec(ua)
						|| /(win)/.exec(ua) || /(mac)/.exec(ua) || /(linux)/.exec(ua)
						|| /(cros)/.exec(ua) || /(playbook)/.exec(ua)
						|| /(bb)/.exec(ua) || /(blackberry)/.exec(ua)
						|| [];

				matched.platform = platform_match[0] || "";

				if(matched.platform) {
					platform[matched.platform] = true;
				}

				if(platform.android || platform.bb || platform.blackberry
						|| platform.ipad || platform.iphone
						|| platform.ipod || platform.kindle
						|| platform.playbook || platform.silk
						|| platform["windows phone"]) {
					userPlatform = "mobile";
				}

				if(platform.cros || platform.mac || platform.linux || platform.win) {
					userPlatform = "pc";
				}

				return userPlatform;
			}
		</script>
	</head>
	<body>
		<form name="payForm" method="post" action="indexNicepayTestResult" accept-charset="euc-kr">
			<table>
				<tr>
					<th><span>결제 수단</span></th>
					<td><input type="text" name="PayMethod" value="CARD"></td>
				</tr>
				<tr>
					<th><span>결제 수단</span></th>
					<td><input type="text" name="SelectCardCode" value="06"></td>
				</tr>
				<tr>
					<th><span>결제 상품명</span></th>
					<td><input type="text" name="GoodsName" value="테스트"></td>
				</tr>
				<tr>
					<th><span>결제 상품금액</span></th>
					<td><input type="text" name="Amt" value="1000"></td>
				</tr>
				<tr>
					<th><span>상점 아이디</span></th>
					<td><input type="text" name="MID" value="aboutp001m"></td>
				</tr>
				<tr>
					<th><span>상품 주문번호</span></th>
					<td><input type="text" name="Moid" value="C2021011800001"></td>
				</tr>
				<tr>
					<th><span>구매자명</span></th>
					<td><input type="text" name="BuyerName" value="김사무엘"></td>
				</tr>
				<tr>
					<th>구매자명 이메일</th>
					<td><input type="text" name="BuyerEmail" value="muel@valfac.com"></td>
				</tr>
				<tr>
					<th><span>구매자 연락처</span></th>
					<td><input type="text" name="BuyerTel" value="0102580460"></td>
				</tr>
				<tr>
					<th><span>인증완료 결과처리 URL<!-- (모바일 결제창 전용)PC 결제창 사용시 필요 없음 --></span></th>
					<td><input type="text" name="ReturnURL" value="http://localhost:8090/pay/nicepay/indexNicepayTestResult"></td>
				</tr>
				<tr>
					<th>가상계좌입금만료일(YYYYMMDD)</th>
					<td><input type="text" name="VbankExpDate" value=""></td>
				</tr>

				<!-- 옵션 -->
				<input type="text" name="GoodsCl" value="1"/>						<!-- 상품구분(실물(1),컨텐츠(0)) -->
				<input type="text" name="TransType" value="0"/>					<!-- 일반(0)/에스크로(1) -->
				<input type="text" name="CharSet" value="euc-kr"/>				<!-- 응답 파라미터 인코딩 방식 -->
				<input type="text" name="ReqReserved" value=""/>					<!-- 상점 예약필드 -->
				<input type="text" name="DirectShowOpt" value="CARD"/>				<!-- 직접 호출 옵션 -->
				<input type="text" name="NicepayReserved" value=""/>				<!-- 나이스페이 복합 옵션 -->

				<!-- 카드 옵션 -->
				<input type="text" name="SelectQuota" value="00"/>					<!-- 할부개월 제한 -->
				<input type="text" name="DirectCardPointFlag" value=""/>			<!-- 카드포인트 사용 옵션 -->
				<input type="text" name="DirectEasyPay" value=""/>				<!-- 간편결제 제휴사 인증창 바로 호출 옵션 -->

					<!-- 카카오페이 옵션 -->
				<input type="text" name="EasyPayCardCode" value=""/>				<!-- 간편결제 카드코드 -->
				<input type="text" name="EasyPayQuota" value=""/>				<!-- 간편결제 할부개월 -->

				<!-- 페이코 옵션 -->
				<input type="text" name="EasyPayShopInterest" value=""/>			<!-- 간편결제 상점 무이자 미사용(0)/사용(1) -->
				<input type="text" name="EasyPayQuotaInterest" value=""/>			<!-- 간편결제 상점무이자 설정 -->
				<input type="text" name="PaycoClientId" value=""/>				<!-- 페이코 자동로그인 ID -->
				<input type="text" name="PaycoAccessToken" value=""/>				<!-- 페이코 자동로그인 토큰 -->

				<!-- 네이버페이 옵션 -->
				<input type="text" name="EasyPayMethod" value=""/>				<!-- 간편결제 지불수단 지정 -->

				<!-- 계좌간편결제 옵션 -->
				<input type="text" name="MallUserID" value=""/>					<!-- 상점 사용자 아이디 -->
				<input type="text" name="BankPayMemID" value=""/>					<!-- 계좌간편결제 회원 계정 -->
				<input type="text" name="BankPayDesc" value=""/>					<!-- 계좌간편결제 출금통장 인자 -->
				<input type="text" name="BankPayMemNotiURL" value=""/>			<!-- 계좌간편결제 가입정보 통보 -->

				<!-- 변경 불가능 -->
				<input type="text" name="EdiDate" value="${ediDate}"/>			<!-- 전문 생성일시 -->
				<input type="text" name="SignData" value="${signData}"/>	<!-- 해쉬값 -->
			</table>
			<a href="#" class="btn_blue" onClick="nicepayStart();">요 청</a>
		</form>
</body>
</html>

<%--<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>NICEPAY BILLING REGIST REQUEST(UTF-8) :: API1.0</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=yes, target-densitydpi=medium-dpi" />
	<link rel="stylesheet" type="text/css" href="../css/import.css"/>
	<script>
		function reqBillRegist(){
			document.billingForm.submit();
		}
	</script>
</head>
<body>
<div class="payfin_area">
	&lt;%&ndash; 빌키 발급 요청 form &ndash;%&gt;
	<form name="billingForm" method="post" target="_self" action="billRegistResult_utf.jsp">
		<div class="top">빌키 발급 요청</div>
		<div class="conwrap">
			<div class="con">
				<div class="tabletypea">
					<table>
						<colgroup><col width="380px"/><col width="*"/></colgroup>
						<!-- 필수 파라미터 -->
						<tr>
							<th colspan="2" style="background:#dfe4ec;">[필수 파라미터]</th>
						</tr>
						<tr>
							<th><span>상점ID(MID)</span></th>
							<td><input type="text" name="MID" value="nictest04m"/></td>
						</tr>
						<tr>
							<th><span>주문번호(Moid)</span></th>
							<td><input type="text" name="Moid" value="testmoid" /></td>
						</tr>
						<tr>
							<th><span>카드번호(CardNo)</span></th>
							<td><input type="text" name="CardNo" value="" /></td>
						</tr>
						<tr>
							<th><span>유효기간(년/월)(ExpYear/ExpMonth)</span></th>
							<td><input type="text" name="ExpYear" value="" />/<input type="text" name="ExpMonth" value="" /></td>
						</tr>
						<!-- 옵션 파라미터 -->
						<tr>
							<th colspan="2" style="background:#dfe4ec;">[옵션 파라미터]</th>
						</tr>
						<tr>
							<th><span>생년월일/사업자번호(IDNo)</span></th>
							<td><input type="password" name="IDNo" value="" /></td>
						</tr>
						<tr>
							<th><span>카드비밀번호(CardPw) - 앞2자리</span></th>
							<td><input type="password" name="CardPw" value="" /></td>
						</tr>
						<tr>
							<th><span>구매자(BuyerName)</span></th>
							<td><input type="text" name="BuyerName" value="" /></td>
						</tr>
						<tr>
							<th><span>구매자 이메일(BuyerEmail)</span></th>
							<td><input type="text" name="BuyerEmail" value="" /></td>
						</tr>
						<tr>
							<th><span>구매자 전화번호(BuyerTel)</span></th>
							<td><input type="text" name="BuyerTel" value="" /></td>
						</tr>
						<tr>
							<th><span>응답전문 유형(EdiType)</span></th>
							<td>
								<select name="EdiType">
									<option value="" selected>Json(default)</option>
									<option value="KV" >Key&Value</option>
								</select>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<p>*테스트 아이디인경우 당일 오후 11시 30분에 취소됩니다.</p>
			<div class="btngroup">
				<a href="#" class="btn_blue" onClick="javascript:reqBillRegist();">요 청</a>
			</div>
		</div>
	</form>
</div>
</body>
</html>--%>

