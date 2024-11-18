<%@ page pageEncoding="UTF-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				addReciver();
				
				$("input[name='reservYn']").change(function(){
					$("input[name='reservationDateTime']").val("");
					if($("input[name='reservYn']:checked").val() == "Y"){
						$("input[name='reservationDateTime']").hide();
					}else{
						$("input[name='reservationDateTime']").show();
					}
				});
				
				$("input[name='tmplYn']").change(function(){
					params="";
					$("input[name=tmplNo]").val("");
					$("#reciveArea").html("");
					$("#reciveArea").append(addRiciverHtml());
					if($("input[name='tmplYn']:checked").val() == "Y"){
						$(".tmplY").show();					
						$(".tmplN").attr("disabled", true);
					}else{
						$(".tmplY").hide();
						$(".tmplN").attr("disabled", false);
					}
				});	
			});
			
			var params="";
			function addRiciverHtml(){
				var addhtml = '<div class="reciveDiv lastAddedDiv" style="display: block;" ><input type="text" name="reciverAddress" placeholder="수신 이메일" >';
				addhtml += '<input type="text" name="reciverName" placeholder="이름">';
				addhtml += '<button type="button" onclick="delReciver(this);" class="btn">-</button>';
				addhtml += '<button type="button" onclick="addReciver(this);" class="btn">+</button>';
				addhtml += '<div class="tmplY paramArea" style="margin-bottom:5px;" ></div></div>';
				return addhtml;
			}
			function delReciver(obj) {
				if($(".reciveDiv").length > 1){
					$(obj).parent("div").remove();
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
							$(".lastAddedDiv .paramArea").append('<input type="text" disabled="disabled" style="width:80px;border:none;" value="ㄴ 바인딩 변수 : ">');
						}
						$(".lastAddedDiv .paramArea").append('<input type="text" data-param="'+ params[i] +'" placeholder="'+ params[i] +'">');							
					}
				}
			};
			function getTmple() {
				let options = {
						url : "<spring:url value='/sample/sampleNoticeTemplate.do' />"
						, data : {
							tmplNo : $("#tmplNo").val()
						}
						, callBack : function(result){
							var contents = result.contents;
							$("input[name='title']").val(result.subject);
							$("#cont").val(contents);
							$(".paramArea").html("");	
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
			
			function sendEmail() {
				let sendData = $("#sendEmailForm").serializeJson();
				let recipients = new Array();
				var reciverDivs = $(".reciveDiv");
				reciverDivs.each(function(i, v){
					var thisAddr = $(this).find("input[name='reciverAddress']").val();
					var thisName = $(this).find("input[name='reciverName']").val();
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
					let thisRecipient = {
						address : thisAddr,
						name : thisName,
						parameters : thisParamJson
					}					
					recipients[i] = thisRecipient;
				})
				var recipientsJson = JSON.stringify(recipients);
				var sendDataJson = JSON.stringify(sendData);
				let options = {
					url : "<spring:url value='/sample/testEmail.do' />"
					, data : { 
						emailJson : sendDataJson,
						recipientsJon : recipientsJson
					}
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
			<div title="내용" style="padding:10px">
				<p>- 메소드 : BizService.sendEmail(EmailSendPO email)</p>
				<p>- PO : EmailSendPO (아래부터 해당 필드명 기준으로 설명)</p>
				<p>- 방식에 따른 필수 값</p>
				<p> ㄴ 템플릿 사용시 :  <span class="red">mbrNo, tmplNo(템플릿 번호)</span>, senderAddress(발신자 주소), recipients[ address(수신자 주소), name(수신자 이름), <span class="red">parameters(템플릿 변수의 바인딩 map)</span>]</p>
				<p> ㄴ 직접 입력시 :  senderAddress(발신자 주소), <span class="red">mbrNo, title(제목)</span>, <span class="red">body(내용)</span>, recipients[ address(수신자 주소), name(수신자 이름))]</p>
				<p>- 예약 발송시 reservationDateTime(예약 발송 일시) 입력, 없으면 즉시 발송</p>
				<p>- 발송 결과 : requestId, count</p>
				<p>* 현재 이력을 저장하는 프로세스는 미개발 상태입니다.</p>
				<p>* 아래 발송 테스트는 유효성 검사를 하지 않았습니다.</p>	
				<p>* 네이버 이메일 API는 발신자와 수신자와 같을 경우 발송이 되지 않습니다.</p>
				<p>* 템플릿의 바인딩 변수는 $ { 변수명 } 입니다.</p>
			</div>
		</div>
		<br/>

		<form name="sendEmailForm" id="sendEmailForm" method="post">			
			<div class="mTitle">
				<h2>이메일 발송 테스트</h2>
			</div>
			<table class="table_type1">
				<colgroup>
					<col width="20%"/>
					<col width="80%"/>
				</colgroup>
				<tbody>
					<tr>
						<th>발신 이메일</th>
						<td>
							<input type="text" name = "senderAddress" placeholder="발신 이메일">
						</td>
					</tr>
					<tr>
						<th>발송구분</th>
						<td>
							<label class="fRadio"><input type="radio" name="reservYn" value="Y" checked="checked"><span>즉시</span></label>
							<label class="fRadio"><input type="radio" name="reservYn" value="N"><span>예약</span></label>
							<input type="text" name="reservationDateTime" style="display: none;" placeholder="yyyy-MM-dd HH:mm:ss">
						</td>
					</tr>			
					<tr>
						<th>템플릿 사용 여부</th>
						<td>
							<label class="fRadio"><input type="radio" name="tmplYn" value="Y" checked="checked"><span>사용</span></label>
							<label class="fRadio"><input type="radio" name="tmplYn" value="N"><span>미사용</span></label>
						</td>
					</tr>
					<tr class="tmplY">
						<th>템플릿 번호 입력</th>
						<td>
							<input type="text" name="tmplNo" id="tmplNo"><button type="button" onclick="getTmple();" class="btn">호출</button>
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>
							<input type="text" class="tmplN"  name="title" disabled="disabled" >							
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<textarea name="body" id="cont" class="tmplN" disabled="disabled"></textarea>
						</td>
					</tr>
					<tr>
						<th>수신자 정보</th>
						<td id="reciveArea" >													
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		
		<div class="btn_area_center">
        	<button type="button" onclick="sendEmail();" class="btn btn-ok">발송</button>
       	</div>
	</t:putAttribute>
</t:insertDefinition>