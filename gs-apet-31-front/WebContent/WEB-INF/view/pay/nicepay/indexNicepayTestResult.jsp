
<!DOCTYPE html>
<html>
	<head>
		<title>NICEPAY PAY RESULT</title>
		<meta charset="utf-8">
	</head>
	<body>
		<table>
			<tr>
				<th>승인 통신 실패로 인한 망취소 처리 진행 결과</th>
			</tr>
			<tr>
				<th>결과 내용</th>
				<td>${authResultCode}${authResultMsg}</td>
			</tr>
			<tr>
				<th>결제수단</th>
				<td>${payMethod}</td>
			</tr>
			<tr>
				<th>상품명</th>
				<td>${GoodsName}</td>
			</tr>
			<tr>
				<th>결제 금액</th>
				<td>${amt}</td>
			</tr>
			<tr>
				<th>거래 번호</th>
				<td>${txTid}</td>
			</tr>
		</table>
		<p>*테스트 아이디인경우 당일 오후 11시 30분에 취소됩니다.</p>
	</body>
</html>
