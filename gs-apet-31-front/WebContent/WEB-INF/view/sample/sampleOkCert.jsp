<%--	
 - Class Name	: /sample/sampleOkCert.jsp
 - Description	: KCB OkCert3 휴대폰 본인 인증 샘플 화면
 - Since		: 2020.12.27
 - Author		: KKB
--%>


<tiles:insertDefinition name="default">
	<tiles:putAttribute name="content">
		<script>
		function okCertCallback(result){
				alert(result);
			}
		</script>
		<br/>
		<br/>
		<button type="button" onclick="okCertPopup(99);" class="btn" style="display: inline;">본인 인증 팝</button>
		<br/>
		<br/>
		<p><span style="font-family: D2Coding; font-size: 12pt;">휴대폰 본인확인 서비스 팝업 인증 거래 결과 수신</span></p><div style="line-height: 1.6; padding: 0px 0px 7px; margin: 0px;"><table class="__se_tbl_ext" border="1" cellpadding="5" cellspacing="-1" style="border-color: #000000; border-style: solid; border-collapse: collapse; table-layout:fixed; word-wrap:break-word; word-break:break-all;">
<tbody><tr valign="top">
<td colspan="3" width="536" height="24" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">svcName =&nbsp;</span><span style="font-size: 10pt; font-family: 'Gulim Western';">“</span><span style="font-size: 10pt; font-family: 굴림;">IDS_HS_POPUP_RESULT</span><span style="font-size: 10pt; font-family: 'Gulim Western';">”</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="50" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">Request</span></p>
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">Json</span></p>
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">(=params)</span></p>
</td>
<td width="134" height="50" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">MDL_TKN</span></p>
</td>
<td width="314" height="50" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">거래 요청 시 수신한 토큰</span></p>
</td>
</tr>
<tr valign="top">
<td rowspan="12" width="66" height="405" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">Response</span></p>
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">Json</span></p>
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">(=mOut)</span></p>
</td>
<td width="134" height="24" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">TX_SEQ_NO</span></p>
</td>
<td width="314" height="24" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">거래 일련 번호</span></p>
</td>
</tr>
<tr valign="top">
<td width="134" height="24" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">RSLT_CD</span></p>
</td>
<td width="314" height="24" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">처리 결과 응답코드 (하단 응답코드표 참고)</span></p>
</td>
</tr>
<tr valign="top">
<td width="134" height="24" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">RSLT_MSG</span></p>
</td>
<td width="314" height="24" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">처리 결과 메시지</span></p>
</td>
</tr>
<tr valign="top">
<td width="134" height="24" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">RSLT_NAME</span></p>
</td>
<td width="314" height="24" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">성명</span></p>
</td>
</tr>
<tr valign="top">
<td width="134" height="24" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">RSLT_BIRTHDAY</span></p>
</td>
<td width="314" height="24" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">생년월일 (ex. 19990101)</span></p>
</td>
</tr>
<tr valign="top">
<td width="134" height="24" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">RSLT_SEX_CD</span></p>
</td>
<td width="314" height="24" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">성별 (남자:M, 여자:F)</span></p>
</td>
</tr>
<tr valign="top">
<td width="134" height="24" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">RSLT_NTV_FRNR_CD</span></p>
</td>
<td width="314" height="24" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">내외국인 구분 (내국인:L, 외국인:F)</span></p>
</td>
</tr>
<tr valign="top">
<td width="134" height="24" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">DI</span></p>
</td>
<td width="314" height="24" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">DI 값. 중복가입 확인정보 (64byte)</span></p>
</td>
</tr>
<tr valign="top">
<td width="134" height="37" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">CI</span></p>
</td>
<td width="314" height="37" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">CI 값. 연계정보 확인정보 (88byte)</span></p>
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">(CI_UPDATE가 홀수일 경우 사용)</span></p>
</td>
</tr>
<tr valign="top">
<td width="134" height="50" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">CI2</span></p>
</td>
<td width="314" height="50" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">COINFO2 값&nbsp;</span></p>
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">(현재는 빈값으로 사용된다. 추후 CI_UPDATE가 변경될 경우 전 버전의 CI가 입력된다.)</span></p>
</td>
</tr>
<tr valign="top">
<td width="134" height="24" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">CI_UPDATE</span></p>
</td>
<td width="314" height="24" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">CI 업데이트 횟수 (현재&nbsp;</span><span style="font-size: 10pt; font-family: 'Gulim Western';">‘</span><span style="font-size: 10pt; font-family: 굴림;">1</span><span style="font-size: 10pt; font-family: 'Gulim Western';">’</span><span style="font-size: 10pt; font-family: 굴림;">&nbsp;로 고정임)</span></p>
</td>
</tr>
<tr valign="top">
<td width="134" height="102" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">TEL_COM_CD</span></p>
</td>
<td width="314" height="102" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">통신사 구분</span></p>
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">01:SKT</span></p>
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">02:KT</span></p>
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">03:LGU+</span></p>
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">04:알뜰폰SKT</span></p>
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">05:알뜰폰KT</span></p>
<p style="text-align: justify; line-height: 1;"><span style="font-size: 10pt; font-family: 굴림;">06:알뜰폰LGU+</span></p>
</td>
</tr>
</tbody></table>
</div><p style="line-height: 1.6;"><span style="font-size: 12pt; font-family: D2Coding;"><br></span></p><p style="line-height: 1.6;"><span style="font-size: 12pt; font-family: D2Coding;">주요 응답코드표</span></p><div style="line-height: 1.6; padding: 0px 0px 7px; margin: 0px;"><table class="__se_tbl_ext" border="1" cellpadding="5" cellspacing="-1" style="border-color: #000000; border-style: solid; border-collapse: collapse; border-bottom: none; table-layout:fixed; word-wrap:break-word; word-break:break-all;">
<tbody><tr valign="top">
<td width="66" height="27" valign="middle" style="border-color: #000000; border-style: solid; background-color: #ddd9c3;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림; font-weight: bold;">NO</span></p>
</td>
<td width="66" height="27" valign="middle" style="border-color: #000000; border-style: solid; background-color: #ddd9c3;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림; font-weight: bold;">응답코드</span></p>
</td>
<td width="421" height="27" valign="middle" style="border-color: #000000; border-style: solid; background-color: #ddd9c3;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림; font-weight: bold;">내용</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">1</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B</span><span style="font-size: 10pt; font-family: 'Times New Roman', Times, serif;">000</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">정상 처리</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">2</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B006</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">잔여건수 사용 초과, 충전제 사용시 잔액부족</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">3</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B</span><span style="font-size: 10pt; font-family: 'Times New Roman', Times, serif;">00</span><span style="font-size: 10pt; font-family: 굴림;">8</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">제휴가맹점 코드 오류&nbsp;</span><span style="font-size: 10pt; font-family: 'Gulim Western';">–</span><span style="font-size: 10pt; font-family: 굴림;">&nbsp;회원사코드가 등록 안 된 경우</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">4</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B010</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">계약되지 않은 서비스 타입</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">5</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B</span><span style="font-size: 10pt; font-family: 'Times New Roman', Times, serif;">0</span><span style="font-size: 10pt; font-family: 굴림;">17</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">입력값 오류</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">6</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B</span><span style="font-size: 10pt; font-family: 'Times New Roman', Times, serif;">0</span><span style="font-size: 10pt; font-family: 굴림;">30</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">네트워크 오류 (타임아웃, 웹서비스 연결 지연 등)</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">7</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B</span><span style="font-size: 10pt; font-family: 'Times New Roman', Times, serif;">0</span><span style="font-size: 10pt; font-family: 굴림;">43</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">잘못된 형식의 전문</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">8</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B081</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">이통사 DB 오류</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">9</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B082</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">이통사 SCI 통신 오류</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">10</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B083</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">이통사 DB 암호화 서버 연결 실패</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">11</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B084</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">이통사 CI/DI 연동 오류</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">12</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B085</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">이통사 CP(회원사) 코드 없음</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">13</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B086</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">이통사 기타 오류</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">14</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B091</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">인증 시도 횟수 추가</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">15</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B092</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">이통사 연동 오류</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">16</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B097</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">서비스거래번호 없음</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">17</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B098</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">서비스거래번호 오류(길이/형식)</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">18</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B099</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">기타오류&nbsp;</span><span style="font-size: 10pt; font-family: 'Gulim Western';">–</span><span style="font-size: 10pt; font-family: 굴림;">&nbsp;서버에러</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">19</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B100</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">본인인증 처리 실패</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">20</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B101</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">기요청 서비스 거래번호</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">21</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B102</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">선행 요청정보 없음</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">22</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B103</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">서비스 사용 가능일이 아닙니다</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">23</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B104</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">서비스 사용 중지 상태입니다</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">24</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B105</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">서비스 기간이 만료 되었습니다</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">25</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B106</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">요청 사이트 도메인 없음</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">26</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B107</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">본인인증수단 없음</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">27</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B108</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">본인인증 요청사유 없음</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">28</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B109</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">타겟ID 없음</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">29</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B110</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">리턴 URL 없음</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">30</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B111</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">파라미터체크(본인인증수단)</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">31</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B112</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">파라미터체크(주민번호형식)</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">32</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B113</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">파라미터체크(휴대폰 통신사 정보)</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">33</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B114</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">파라미터체크(휴대폰 번호 앞자리)</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">34</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B115</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">파라미터체크(휴대폰 번호)</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">35</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B120</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">인증번호 재전송 건수 초과</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">36</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B121</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">서비스 오류</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">37</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B122</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">DB 오류</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">38</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B123</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">본인인증 취소</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">39</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B124</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">회원사 허용대역 오류</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">40</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B125</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">인증번호 문자길이 오류 (80Byte 초과 시)&nbsp;</span><span style="font-size: 10pt; font-family: 'Gulim Western';">–</span><span style="font-size: 10pt; font-family: 굴림;">&nbsp;회원사명 조정 필요</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">41</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B128</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">이미 정상인증 확인되었습니다&nbsp;</span><span style="font-size: 10pt; font-family: 'Gulim Western';">–</span><span style="font-size: 10pt; font-family: 굴림;">&nbsp;인증 완료 건에 인증번호 요청한 경우</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">42</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B129</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">인증번호 입력시간 초과</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">43</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B130</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">인증번호 오류입력건수 초과</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">44</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B131</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">인증번호 불일치</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">45</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B132</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">해당건 미존재</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">47</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B133</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">잘못된 접근 (페이지 리로딩 포함)</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">48</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B135</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">등록되지 않은 서비스 구분</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">49</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B136</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">인증번호 재전송 요청시간이 초과되었습니다</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">50</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B137</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">SMS 발송에 실패했습니다</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">51</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B138</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">잘못된 DI 정보가 수신되었습니다</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">52</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B139</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">잘못된 CI 정보가 수신되었습니다</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">53</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B140</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">CI 검증 실패</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">54</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B141</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">파라미터체크(성명)</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">55</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B142</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">파라미터체크(생년월일)</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">56</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B143</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">파라미터체크(성별)</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">57</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B144</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">파라미터체크(내외국인구분)</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">58</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B145</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">파라미터체크(개인정보동의여부)</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">59</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B146</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">파라미터체크(식별정보동의여부)</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">60</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B147</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">파라미터체크(통신약관동의여부)</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">61</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B148</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">파라미터체크(SMS/LMS구분)</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">62</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B149</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">파라미터체크(SMS 인증번호)</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">63</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B150</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">파라미터체크(원거래 주민번호 상이)</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">64</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B151</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">파라미터체크(원거래 휴대폰번호 상이)</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">65</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B154</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">휴대폰인증보호서비스앱 미설치</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">66</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B155</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">차단된 회원사</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">67</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B156</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">SMS발송 차단 회원사</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">68</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B157</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">사용자 입력 항목 체크 오류&nbsp;</span><span style="font-size: 10pt; font-family: 'Gulim Western';">–</span><span style="font-size: 10pt; font-family: 굴림;">&nbsp;개인정보수집/이용/취급위탁 동의 여부</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">69</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B158</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">SMS메시지를 확인해주세요</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">70</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B159</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">콜백번호를 확인해주세요</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">71</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B161</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">비정상적인 요청으로 서비스 제공이 중지되었습니다</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">72</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">B162</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">법인폰 차단회원사</span></p>
</td>
</tr>
<tr valign="top">
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">73</span></p>
</td>
<td width="66" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="text-align: center; line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">T990</span></p>
</td>
<td width="421" height="28" valign="middle" style="border-color: #000000; border-style: solid;">
<p style="line-height: 1.4;"><span style="font-size: 10pt; font-family: 굴림;">모듈토큰 미존재</span></p>
</td>
</tr>
</tbody></table>
</div><p>



<br></p>
	</tiles:putAttribute>
</tiles:insertDefinition>