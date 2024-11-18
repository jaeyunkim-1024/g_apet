<%@ page pageEncoding="UTF-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
      	<script type="text/javascript">
	      	$(document).ready(function(){
	      		
	      	});
	      	// 클라우드게이트 가입 API
	      	function sendCounselorInfo() {
	  			let options = {
						url : "<spring:url value='/sample/sampleSendCounselorInfo.do' />"
						, data : $("#counselorForm").serializeJson()
						, callBack : function(result){
							messager.alert(result, "Info", "info");
						}
					};
					ajax.call(options);
	  		}
	      	// 티켓 사건 추가 API
	      	function sendTicketEvent() {
	  			let options = {
						url : "<spring:url value='/sample/sampleSendTicketEvent.do' />"
						, data : $("#ticketForm").serializeJson()
						, callBack : function(result){
							messager.alert(result, "Info", "info");
						}
					};
					ajax.call(options);
	  		}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="클라우드게이트 가입 API(상담원 가입 정보 발송)" style="padding:10px">
				<p>호출 서비스 : TwcService.sendCounselorInfo(CounslorPO po)</p>
				<p>CounslorPO의 모든 필드는 필수값입니다.</p>
			</div>
		</div>
		<form name="counselorForm" id="counselorForm" method="post">			
			<div class="mTitle">
				<h2>카운슬 정보 발송 테스트</h2>
			</div>
			<table class="table_type1">
				<colgroup>
					<col width="10%"/>
					<col width="20%"/>
					<col width="30%"/>
					<col width="10%"/>
					<col width="20%"/>
					<col width="30%"/>
				</colgroup>
				<tbody>
					<tr>
						<th>구 분</th>
						<th>설 명</th>
						<th>입 력</th>
						<th>구 분</th>
						<th>설 명</th>
						<th>입 력</th>
					</tr>
					<tr>
						<th>apiKey</th>
						<td>
							<p>API 사용자 Key<strong class="red">*</strong></p>
						</td>
						<td>
							<input name="apiKey" type="text" placeholder="*API 사용자 Key" value="RUiv0sETpzY7OQVK-55VlQ" disabled="disabled">
						</td>
						<th>brandId</th>
						<td>
							<p>브랜드 아이디<strong class="red">*</strong></p>
						</td>
						<td>
							<input name="brandId" type="text" placeholder="brandId">
						</td>
					</tr>
					<tr>
						<th>loginId</th>
						<td>
							<p>고객 아이디<strong class="red">*</strong></p>
						</td>
						<td>
							<input name="loginId" type="text" placeholder="loginId">
						</td>
						<th>name</th>
						<td>
							<p>이름<strong class="red">*</strong></p>
						</td>
						<td>
							<input name="name" type="text" placeholder="name">
						</td>
					</tr>
					<tr>
						<th>password</th>
						<td>
							<p>비밀번호<strong class="red">*</strong></p>
						</td>
						<td>
							<input name="password" type="text" placeholder="password">
						</td>
						<th>retryPassword</th>
						<td>
							<p>비밀번호 확인<strong class="red">*</strong></p>
						</td>
						<td>
							<input name="retryPassword" type="text" placeholder="retryPassword">
						</td>
					</tr>
					<tr>
						<th>email</th>
						<td>
							<p>이메일<strong class="red">*</strong></p>
						</td>
						<td>
							<input name="email" type="text" placeholder="email">
						</td>
						<th>phoneNumber</th>
						<td>
							<p>전화번호<strong class="red">*</strong></p>
						</td>
						<td>
							<input name="phoneNumber" type="text" placeholder="phoneNumber">
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<div class="btn_area_center">
        	<button type="button" onclick="sendCounselorInfo();" class="btn btn-ok">발송</button>
       	</div>
       	<br/>
       	<br/>
       	<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="티켓 사건 추가 API" style="padding:10px">
				<p>호출 서비스 : TwcService.sendTicketEvent(TicketPO po)</p>
				<p>TicketPO의 모든 필드는 필수값입니다.</p>
			</div>
		</div>
		<form name="ticketForm" id="ticketForm" method="post">			
			<div class="mTitle">
				<h2>티켓 사건 발송 테스트</h2>
			</div>
			<table class="table_type1">
				<colgroup>
					<col width="10%"/>
					<col width="20%"/>
					<col width="30%"/>
					<col width="10%"/>
					<col width="20%"/>
					<col width="30%"/>
				</colgroup>
				<tbody>
					<tr>
						<th>구 분</th>
						<th>설 명</th>
						<th>입 력</th>
						<th>구 분</th>
						<th>설 명</th>
						<th>입 력</th>
					</tr>
					<tr>
						<th>apiKey</th>
						<td>
							<p>API 사용자 Key<strong class="red">*</strong></p>
						</td>
						<td>
							<input name="apiKey" type="text" placeholder="*API 사용자 Key" value="RUiv0sETpzY7OQVK-55VlQ">
						</td>
						<th>ticketDispId</th>
						<td>
							<p>티켓 디스플레이 아이디 <strong class="red">*</strong></p>
						</td>
						<td>
							<input name="ticketDispId" type="text" placeholder="ticketDispId">
						</td>
					</tr>
					<tr>
						<th>eventCode</th>
						<td>
							<p>이벤트 코드<strong class="red">*</strong></p>
						</td>
						<td>
							<input name="eventCode" type="text" placeholder="eventCode">
						</td>
						<th>content</th>
						<td>
							<p>티켓 사건 추가 입력사항<strong class="red">*</strong></p>
						</td>
						<td>
							<input name="content" type="text" placeholder="content">
						</td>
					</tr>
					<tr>
						<th>agentLoginId</th>
						<td>
							<p>상담사 로그인 아이디 <strong class="red">*</strong></p>
						</td>
						<td>
							<input name="agentLoginId" type="text" placeholder="agentLoginId">
						</td>
						<th></th>
						<td>
							<p></p>
						</td>
						<td>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<div class="btn_area_center">
        	<button type="button" onclick="sendTicketEvent();" class="btn btn-ok">발송</button>
       	</div>
</t:putAttribute>
</t:insertDefinition>