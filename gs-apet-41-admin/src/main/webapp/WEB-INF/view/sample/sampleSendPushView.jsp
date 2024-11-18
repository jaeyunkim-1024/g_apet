<%@ page pageEncoding="UTF-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function(){
			
			$("input[name='reservYn']").change(function(){
				$("input[name='reservationDateTime']").val("");
				if($("input[name='reservYn']:checked").val() == "Y"){
					$("input[name='reservationDateTime']").hide();
				}else{
					$("input[name='reservationDateTime']").show();
				}
			});
			addReciver();
			$("input[name='tmplYn']").change(function(){
				params="";
				$("input[name=tmplNo]").val("");
				$("#reciveArea").html("");
				$("#reciveArea").append(addRiciverHtml());
				$("input[name=title]").val("");
				$("textarea[name=body]").val("");
				if($("input[name='tmplYn']:checked").val() == "Y"){
					$(".tmplY").show();
					$("input[name=title]").attr("disabled", true);
					$("textarea[name=body]").attr("disabled", true);
				}else{
					$(".tmplY").hide();
					$("input[name=title]").attr("disabled", false);
					$("textarea[name=body]").attr("disabled", false);
				}
			});	
		});
		
		
		
		function insertDeviceToken() {
			let sendData = $("#insertDeviceTokenForm").serializeJson();
			let options = {
				url : "<spring:url value='/sample/sampleInsertDeviceToken.do' />"
				, data : sendData
				, callBack : function(result){
					messager.alert(result, "Info", "info");					
				}
			};
			ajax.call(options);
		}
		
		function getDeviceToken() {
			let sendData = $("#getDeviceTokenForm").serializeJson();
			let options = {
				url : "<spring:url value='/sample/sampleGetDeviceToken.do' />"
				, data : sendData
				, callBack : function(result){
					messager.alert(result, "Info", "info");
					console.log("DeviceToken",result);
				}
			};
			ajax.call(options);
		}
		
		function deleteDeviceToken() {
			let sendData = $("#deleteDeviceTokenForm").serializeJson();
			let options = {
				url : "<spring:url value='/sample/sampleDeleteDeviceToken.do' />"
				, data : sendData
				, callBack : function(result){
					messager.alert(result, "Info", "info");
				}
			};
			ajax.call(options);
		}
		
		function sendPush() {
			let baseData = $("#sendPushForm").serializeJson();
			let targetList = new Array();
			let reciverDivs = $(".reciveDiv");
			reciverDivs.each(function(i, v){				
				var thisTo = $(this).find("input[name='to']").val();				
				var thisParamObj = $(this).find(".paramArea input");				
				var thisParamMap = new Map();
				thisParamObj.each(function(i, v) {
					let thisKey = thisParamObj[i].dataset.param;
					let thisValue = thisParamObj[i].value;
					if(thisKey != null){
						thisParamMap.set(thisKey, thisValue);
					}						
				})			
				var thisParamJson = Object.fromEntries(thisParamMap);
				var thisImage = $(this).find("input[name='image']").val();	
				var thisLandingUrl = $(this).find("input[name='landingUrl']").val();	
				let thisTarget = {
					to : thisTo,
					parameters : thisParamJson,
					image : thisImage,
					landingUrl : thisLandingUrl
				}					
				targetList[i] = thisTarget;
			})
			
			$.extend(baseData, {
				targetList :  JSON.stringify(targetList)
			});
			let options = {
				url : "<spring:url value='/sample/sampleSendPush.do' />"
				, data : baseData
				, callBack : function(result){
					messager.alert(result, "Info", "info");
				}
			};
			console.log("data",options.data);
			ajax.call(options);
		}
		
		var params="";
		function addRiciverHtml(){
			var addhtml = '<div class="reciveDiv lastAddedDiv" style="display: block; border:1px solid #d3d3d3" >';
			addhtml += '<input type="text" disabled="disabled" style="width:80px;border:none;" value="수신자 : "><input type="text" name ="to" placeholder="mbrNo or userNo">';
			addhtml += '<button type="button" onclick="delReciver(this);" class="btn">-</button>';
			addhtml += '<button type="button" onclick="addReciver(this);" class="btn">+</button><br/>';
			addhtml += '<input class="oneUrl" type="text" disabled="disabled" style="width:80px;border:none;" value="image : "><input class="oneUrl" type="text" name ="image" placeholder="image" style="width:32.5%;"><br/>';
			addhtml += '<input class="oneUrl" type="text" disabled="disabled" style="width:80px;border:none;" value="landingUrl : "><input class="oneUrl" type="text" name ="landingUrl" placeholder="landingUrl" style="width:32.5%">';			
			addhtml += '<div class="tmplY paramArea" style="margin-bottom:5px;" ></div>';
			addhtml += '</div>';
			return addhtml;
		}
		function delReciver(obj) {
			if($(".reciveDiv").length > 1){
				$(obj).parent("div").remove();
			}
			if($(':radio[name="tmplYn"]:checked').val() == "N"){
				$(".reciveDiv .oneUrl").hide();
				$(".reciveDiv:first .oneUrl").show();
			}else{
				$(".reciveDiv .oneUrl").show();
			}
		};
		function addReciver(obj) {
			$('.reciveDiv').removeClass('lastAddedDiv');
			if(obj == null){
				$("#reciveArea").append(addRiciverHtml());
			}else{
				$(obj).parents(".reciveDiv").after(addRiciverHtml());				
			}
			if(params != "" ){
				for(let i=0; i< params.length ; i++){
					if(i == 0){
						$(".lastAddedDiv .paramArea").append('<input type="text" disabled="disabled" style="width:80px;border:none;" value="바인딩 변수 : ">');
					}
					$(".lastAddedDiv .paramArea").append('<input type="text" data-param="'+ params[i] +'" placeholder="'+ params[i] +'">');							
				}
			}
			if($(':radio[name="tmplYn"]:checked').val() == "N"){
				$(".reciveDiv .oneUrl").hide();
				$(".reciveDiv:first .oneUrl").show();
			}else{
				let imagePlaceHolder = $("#reciveArea .reciveDiv:first input[name=image]").attr("placeholder");
				let landingUrlPlaceHolder = $("#reciveArea .reciveDiv:first input[name=landingUrl]").attr("placeholder");
				console.log("imagePlaceHolder",imagePlaceHolder);
				console.log("landingUrlPlaceHolder",landingUrlPlaceHolder);
				$("input[name=image]").attr("placeholder",imagePlaceHolder);
				$("input[name=landingUrl]").attr("placeholder",landingUrlPlaceHolder);	
				$(".reciveDiv .oneUrl").show();
			}
		};
		
		function getTmple() {
			let options = {
					url : "<spring:url value='/sample/sampleNoticeTemplate.do' />"
					, data : {
						tmplNo : $("#tmplNo").val()
					}
					, callBack : function(result){
						var subject = result.subject;
						var contents = result.contents;
						var image = result.imgPath;
						var landingUrl = result.movPath;
						$("input[name=title]").val(subject);
						$("textarea[name=body]").val(contents);
						if(image != null && image != "")
						$("input[name=image]").attr("placeholder",image);
						if(landingUrl != null && landingUrl != "")
						$("input[name=landingUrl]").attr("placeholder",landingUrl);	
						var namePattern = /\{.+?\}/g; 
						var paramVar = contents.match(namePattern);	
						if(paramVar != null && paramVar != "" ){
							for(let i=0; i< paramVar.length ; i++){
								paramVar[i] = paramVar[i].replace("{","").replace("}","");
								$(".paramArea").append('<input type="text" data-param="'+ paramVar[i] +'" placeholder="'+ paramVar[i] +'">');							
							}
							$(".paramArea").prepend('<input type="text" disabled="disabled" style="width:80px;border:none;" value="ㄴ 바인딩 변수 : ">');
							params = paramVar;
							$("#pramTr").show();
						}
					}
				};
				ajax.call(options);
		}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="토큰 등록 안내 (항목은 PO / SO 기준으로 설명)" style="padding:10px">
				<p>- 디바이스 토큰 등록 서비스 : BizService.insertDeviceToken(PushTokenPO po)</p>
				<p>	&emsp;&emsp;userId : mbrNo</p>
				<p> &emsp;&emsp;deviceType : GCM(Android) 또는 APNS(iOS)</p>
				<p> &emsp;&emsp;deviceToken : 디바이스 토큰</p>
				<p> &emsp;&emsp;isNotificationAgreement : 푸시 알림 메시지 수신여부 (무조건 true입력후 메시지 발송전 자체적으로 확인해서 API 호출)</p>
				<p> &emsp;&emsp;isAdAgreement : 광고성 메시지 수신 여부 (무조건 true입력후 메시지 발송전 자체적으로 확인해서 API 호출)</p>
				<p> &emsp;&emsp;isNightAdAgreement : 야간 광고성 메시지 수신 여부 (무조건 true입력후 메시지 발송전 자체적으로 확인해서 API 호출)</p>
				<p>- 디바이스 토큰 조회 서비스 : BizService.getDeviceToken(PushTokenSO so)</p>
				<p> &emsp;&emsp;userId : mbrNo </p>
				<p>- 디바이스 토큰 삭제 서비스 : BizService.deleteDeviceToken(PushTokenPO po)</p>
				<p> &emsp;&emsp;userId : mbrNo</p>
			</div>
		</div>
		<br/>
		<form name="insertDeviceTokenForm" id="insertDeviceTokenForm" method="post">			
			<div class="mTitle">
				<h2>토큰 등록 테스트</h2>
				<div class="buttonArea">
					<button type="button" onclick="insertDeviceToken();" class="btn btn-ok">등록</button>
				</div>
			</div>
			<table class="table_type1">
				<colgroup>
					<col width="10%"/>
					<col width="40%"/>
					<col width="10%"/>
					<col width="40%"/>
				</colgroup>
				<tbody>
					<tr>
						<th>회원 번호</th>
						<td>
							<input type="text" name = "userId" placeholder="mbrNo or userNo">
						</td>
						<th>디바이스 타입</th>
						<td>
							<label class="fRadio"><input type="radio" name="deviceType" value="GCM" checked="checked"><span>GCM(Android)</span></label>
							<label class="fRadio"><input type="radio" name="deviceType" value="APNS"><span>APNS(iOS)</span></label>
						</td>
					</tr>
					<tr>
						<th>디바이스 토큰</th>
						<td>
							<input type="text" name="deviceToken"  placeholder="deviceToken">
						</td>
						<th>푸시 알림 메시지 수신여부</th>
						<td>
							<input type="text" name="isNotificationAgreement"  placeholder="isNotificationAgreement" value="true">
						</td>
					</tr>
					<tr>
						<th>광고성 메시지 수신여부</th>
						<td>
							<input type="text" name="isAdAgreement"  placeholder="isAdAgreement" value="true">
						</td>
						<th>야간 광고성 메시지 수신여부</th>
						<td>
							<input type="text" name="isNightAdAgreement"  placeholder="isNightAdAgreement" value="true">
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<br/>

		
       	
      	<form name="getDeviceTokenForm" id="getDeviceTokenForm" method="get">			
			<div class="mTitle">
				<h2>토큰 조회 테스트</h2>
				<div class="buttonArea">
		       		<button type="button" onclick="getDeviceToken();" class="btn btn-ok">조회</button>
		      	</div>
			</div>
			<table class="table_type1">
				<colgroup>
					<col width="10%"/>
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th>회원 번호</th>
						<td>
							<input type="text" name = "userId" placeholder="mbrNo or userNo">
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<br/>

      	
      	<form name="deleteDeviceTokenForm" id="deleteDeviceTokenForm" method="delete">			
			<div class="mTitle">
				<h2>토큰 삭제 테스트</h2>
				<div class="buttonArea">
		        	<button type="button" onclick="deleteDeviceToken();" class="btn btn-ok">삭제</button>
		       	</div>
			</div>
			<table class="table_type1">
				<colgroup>
					<col width="10%"/>
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th>회원 번호</th>
						<td>
							<input type="text" name = "userId" placeholder="mbrNo or userNo">
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<br/>
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="PUSH 발송 안내 (항목은 PO / SO 기준으로 설명)" style="padding:10px">
				<p>- PUSH 발송 서비스 : BizService.sendPush(SendPushPO po)</p>
				<p>	&emsp;&emsp;tmplNo : 탬플릿 사용시에만 입력</p>
				<p>	&emsp;&emsp;title : 탬플릿 미사용시에만 입력</p>
				<p>	&emsp;&emsp;body : 탬플릿 미사용시에만 입력</p>
				<p> &emsp;&emsp;type : ALL - 서비스에 등록된 모든 디바이스, USER - 사용자에 바인딩된 모든 디바이스</p>
				<p>	&emsp;&emsp;messageType : NOTIF - 알림 메시지, AD - 광고성 메시지</p>
				<p> &emsp;&emsp;target.to : 수신대상 식별자 : ALL - 입력 필요 없음, USER - 사용자아이디</p>
				<p> &emsp;&emsp;target.parameters : 탬플릿 사용시에만 사용</p>
				<p> &emsp;&emsp;target.image : Push에 표현될 이미지 URL 링크 주소 ([직접 입력시] 첫번째 입력값만 공통으로 사용,[탬플릿 사용시]개별 입력값을 사용하며 없으면 탬플릿에 있는 값을 사용)</p>
				<p> &emsp;&emsp;target.landingUrl : Push를 선택해서 앱 진입시 이동될 URL 주소 ([직접 입력시] 첫번째 입력값만 공통으로 사용,[탬플릿 사용시]개별 입력값을 사용하며 없으면 탬플릿에 있는 값을 사용)</p>
				<p> &emsp;&emsp;deviceType : GCM - Android, APNS - iOS, (null 일 경우 모든 디바이스)</p>
				<p> &emsp;&emsp;sendReqDtm : 미입력시 즉시발송, 입력시 예약발송(reservationDateTime 으로 대체가능) * 예약발송은 BATCH로 처리됩니다.</p>
				<p>* 직접 입력의 경우 공통메시지로 API 한번 호출이며, 탬플릿 방식의 경우 다른 메시지 발송으로 API 수신인 만큼 호출</p>
				<p>* 탬플릿 방식의 경우 API 여러번 호출되기 때문에 sendReqDtm이나 reservationDateTime 입력 필요(BATCH로 처리하게됨) </p>
			</div>
		</div>
		<br/>
		<form name="sendPushForm" id="sendPushForm" method="post">
			<div class="mTitle">
				<h2>푸시 발송 테스트</h2>
				<div class="buttonArea">
					<button type="button" onclick="sendPush();" class="btn btn-ok">발송</button>
				</div>
			</div>
			<table class="table_type1">
				<colgroup style="border-right: 1px;">
					<col width="5%"/>
					<col width="5%"/>
					<col width="5%"/>
					<col width="35%"/>
					<col width="10%"/>
					<col width="40%"/>
				</colgroup>
				<tbody>
					<tr>
						<th colspan="2">메시지 타입 타입</th>
						<td colspan="2">
							<label class="fRadio"><input type="radio" name="messageType" value="NOTIF" checked="checked"/><span>NOTIF - 알림 메시지</span></label>
							<label class="fRadio"><input type="radio" name="messageType" value="AD"/><span>AD - 광고성 메시지</span></label>
						</td>
						<th>발송구분</th>
						<td>
							<label class="fRadio"><input type="radio" name="reservYn" value="Y" checked="checked"/><span>즉시</span></label>
							<label class="fRadio"><input type="radio" name="reservYn" value="N"/><span>예약</span></label>
							<input type="text" name="reservationDateTime" style="display: none;" placeholder="yyyy-MM-dd HH:mm:ss">
						</td>					
					</tr>
					<tr>
						<th colspan="2">템플릿 사용 여부</th>
						<td colspan="4">
							<label class="fRadio"><input type="radio" name="tmplYn" value="Y"><span>사용</span></label>
							<label class="fRadio"><input type="radio" name="tmplYn" value="N" checked="checked"><span>미사용</span></label>
						</td>
					</tr>
					<tr class="tmplY" style="display: none;">
						<th colspan="2">템플릿 번호 입력</th>
						<td colspan="4">
							<input type="text" name="tmplNo" id="tmplNo"><button type="button" onclick="getTmple();" class="btn">호출</button>
						</td>
					</tr>
					<tr class="target">
						<th rowspan="2">대상</th>
						<th>타입</th>
						<td colspan="2">
							<label class="fRadio"><input type="radio" name="type" value="ALL" /><span>ALL</span></label>
							<label class="fRadio"><input type="radio" name="type" value="USER"  checked="checked"/><span>USER</span></label>
						</td>
						<th>디바이스 종류</th>
						<td>
							<label class="fRadio"><input type="radio" name="deviceType" value="" checked="checked"><span>전체</span></label>
							<label class="fRadio"><input type="radio" name="deviceType" value="GCM" /><span>GCM - 안드로이드</span></label>
							<label class="fRadio"><input type="radio" name="deviceType" value="APNS" /><span>APNS - IOS</span></label>
						</td>
					</tr>
					<tr class="target">
						<th>수신자 정보</th>
						<td colspan="4" id="reciveArea">
							
						</td>
					</tr>
					<tr>
						<th colspan="2">제목</th>
						<td colspan="2">
							<input type="text" name = "title" placeholder="title" style="width: 90%"  value="제목입니다.">
						</td>
						<th>내용</th>
						<td>
							<textarea name="body" placeholder="body" style="width: 90%" >내용입니다.</textarea>
						</td>					
					</tr>		
				</tbody>
			</table>
		</form>
		<br/>
	</t:putAttribute>
</t:insertDefinition>