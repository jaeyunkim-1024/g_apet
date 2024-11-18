<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
			});
			
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="기본 구성" style="padding:10px">
				<div class="box">
					<div>
						<ul style="font-size: 13px;">
							* 관리 사이트: <a href="https://npg.nicepay.co.kr/logIn.do" target="_blank" style="color:blue;">https://npg.nicepay.co.kr/logIn.do</a>
							<br/>
							* 계정 정보 : 
							<br/>
							&emsp;나이스페이 가맹점관리자페이지 접속 
							npg.nicepay.co.kr 접속하여 테스트를 진행한 mid에 m을 제외한 나머지를 아이디와 비밀번호에 동일하게 입력하여 로그인을 진행합니다.
							<br/>
							&emsp;ex) nicepay00m 계정으로 결제 테스트를 진행했을 경우nicepay00/nicepay00 으로 로그인 진행
							<br/>
							* SERVER URL : <spring:eval expression="@bizConfig['nicepay.web.api.server']" />
							<br/>
							* MID 참고 : <a href="http://wiki.aboutpet.co.kr/pages/viewpage.action?pageId=1149614" target="_blank" style="color:blue;">http://wiki.aboutpet.co.kr/pages/viewpage.action?pageId=1149614</a>
							<br/>
							* Business 소스 : /gs-apet-11-business/src/biz/interfaces/nicepay/
							<br/>
							* 기본 세팅 - ex) 현금 영수증 승인 요청
							<br/>
							1. business.xml 호출 URL 설정 : /cash_receipt.jsp
							<br/>
							2. NicePayApiSpec.java 해당 호출 정보 추가
							<br/>
							3. /gs-apet-11-business/src/biz/interfaces/nicepay/model/request/data 하위에 request VO 생성 <b style="color: red;">[extends RequestCommonVO 필수]</b>
							<br/>
							4. /gs-apet-11-business/src/biz/interfaces/nicepay/model/response/data 하위에 response VO 생성<b style="color: red;">[extends ResponseCommonVO 필수]</b>
							<br/><br/>
							****** 호출 ********
							<br/>
							1. request VO 값 세팅.
							<br/>
							2. NicePayClient&#60;CashReceiptReqVO&#60; client = new NicePayClient&#60;CashReceiptReqVO&#60;(vo, NicePayConstants.MID_GB_CERTIFY, NicePayConstants.PAY_MEANS_04, NicePayConstants.MDA_GB_01);
							<br/>
							* 생성자 호출 시 RequestCommonVO 기본 SET - MID, MerchanKey, EdiDate, payMeans, MediaGb, TID 
							<br/>
							* MID_GB 값은 MID 참고
							<br/>
							<b style="color: red;">TID 생성 규칙 (* 호출 마다 지불수단, 매체구분은 다를수 있다.)</b>
							<table class="table_type1" style="width: 250px;">
								<colgroup>
									<col/>
									<col/>
									<col/>
									<col/>
									<col/>
								</colgroup>
								<tbody>
									<tr>
										<th>MID(10byte)</th>
										<th>지불수단(2byte)</th>
										<th>매체구분(2byte)</th>
										<th>시간정보(yyMMddHHmmss, 12byte) </th>
										<th>랜덤(4byte)</th>
									</tr>
									<tr>
										<td>nictest00m</td>
										<td>04 (현금영수증)</td>
										<td>01 (고정)</td>
										<td>191219140404</td>
										<td>1136</td>
									</tr>
								</tbody>
							</table>
							<br/>
							3. CashReceiptResVO res =  client.getResponse(NicePayApiSpec ID, vo, SignData(위변조 검증 Data), ReturnType Class);
							<b style="color: red;">SignData (* 호출 마다 암호화 구성이 다름.)</b>
							<br/>
							<br/>
							****** 참조 ********
							<br/>
							1. NicePayConstants.java : Nice Pay Code 등록  <b style="color: red;">[해당 호출 SUCCESS CODE 정의 후 사용]</b>
							<br/>
							2. NicePayCodeMapping.java : VECI CODE - NICE CODE MAPPING 정보 등록 후 Method 사용
							<br/>
							3. Service 참조 - NicePayCashReceiptServiceImpl.java
							<br/>
							<br/>
							<br/>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</t:putAttribute>
</t:insertDefinition>