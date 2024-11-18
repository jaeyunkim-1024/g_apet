<%@ page pageEncoding="UTF-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				addReciver();
				$(".datepicker").datepicker("option", "minDate", new Date());
				$("input[name='reservYn']").change(function(){
					$("input[name='reservationDateTime']").val("");
					if($("input[name='reservYn']:checked").val() == "Y"){
						$("input[name='reservationDateTime']").hide();
					}else{
						$("input[name='reservationDateTime']").show();
					}
				});
				
				$("input[name='tmplYn']").change(function(){
					$(".tmplNo").val("");
					if($("input[name='tmplYn']:checked").val() == "Y"){
						$(".tmplY").show();					
						$(".tmplN").attr("disabled", true);
					}else{
						$(".tmplY").hide();
						$(".tmplN").attr("disabled", false);
					}
				});	
				$("input[name='sndTypeCd']").change(function(){
					if ($(this).val() == '${adminConstants.SND_TYPE_30}') {
						$("input:radio[name='tmplYn']:radio[value='Y']").prop('checked', true);
						$('input[name=tmplYn]:not(:checked)').attr('disabled', true);
						$(".tmplY").show();					
						$(".tmplN").attr("disabled", true);
						/* $(".tmplNo").val("");
						$(".tmplY").hide();
						$(".tmplUse").hide(); */
						$("#pathTr").hide();
					} else {
						$(".tmplY").show();
						$(".tmplUse").show();
						$("#pathTr").show();
						$(".tmplN").attr("disabled", true);
						$('input[name=tmplYn]:not(:checked)').removeAttr('disabled');
					}
				});
				$(".datepicker").change(function(){
				});
			});
			
			
			$(document).on("input", ".phoneNumber", function(event) {
				$(this).val($(this).val().replace(/[^0-9]/g, ''));
				$(this).val($(this).val().replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3"));
			});
			
			var params="";
			function addRiciverHtml(){
				var addhtml = '<div class="reciveDiv lastAddedDiv" style="display: block;" ><input type="text" class="phoneNumber w200" name="receivePhone" value="" maxlength="14" style="margin-right:5px; autocomplete="off">';
				addhtml += '<button type="button" onclick="delReciver(this);" class="btn">-</button>';
				addhtml += '<button type="button" onclick="addReciver(this);" class="btn">+</button>';
				addhtml += '<div class="tmplY paramArea" style="margin-bottom:5px;" ></div>';
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
							$("input[name='fsubject']").val(result.subject);
							$("#fmessage").val(contents);
							$("#tmplCd").val(result.tmplCd);
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
			
			function sendMessage() {
				$("#fsenddate").val(new Date($("#sendReqDtm").val() + " " + $("#sendReqDtmHr").val() + ":" + $("#sendReqDtmMn").val() + ":" + $("#sendReqDtmSec").val()).getTime());
				let sendData = $("#sendMessageForm").serializeJson();
				let recipients = new Array();
				var reciverDivs = $(".reciveDiv");
				reciverDivs.each(function(i, v){
					var thisReceivePhone = $(this).find("input[name='receivePhone']").val();
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
						receivePhone : thisReceivePhone,
						parameters : thisParamJson
					}					
					recipients[i] = thisRecipient;
				})
				var recipientsJson = JSON.stringify(recipients);
				var sendDataJson = JSON.stringify(sendData);
				let options = {
					url : "<spring:url value='/sample/testMessage.do' />"
					, data : { 
						messageJson : sendDataJson,
						recipientsJon : recipientsJson
					}
					, callBack : function(result){
						if (result == '1') {
							messager.alert("<spring:message code='column.common.process.final_msg' />", "Info", "info", function(){
								updateTab();
							});
						} else {
							messager.alert("<spring:message code='column.common.try.again_msg' />", "Info", "info", function(){
							});
						}
					}
				};
				ajax.call(options);
			}
			
			// 템플릿 선택 팝업
			function pushTemplateSelectViewPop() {
				var options = {
					url : "<spring:url value='/sample/samplePushTemplateSelectView.do' />"
					, dataType : "html"
					, data : {
						sndTypeCd : $("input:radio[name=sndTypeCd]:checked").val()
					}
					, callBack : function(data) {
						var config = {
							id : "pushTemplateSelectView"
							, title : "알림 메시지 템플릿 선택"
							, height : 620
							, body : data
						}
						layer.create(config);
					}
				}
				ajax.call(options);
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
	
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="메시지 유형(SMS/LMS/MMS/KKO)에 따라 SsgMessageSendPO 필수 값입니다. 검은색 동그라미는 설명의 해당경우에만 필수입니다." style="padding:10px">
				<table class="__se_tbl_ext" border="0" cellpadding="0" cellspacing="0" width="1000" style="border-collapse:
				   collapse;width:1000pt">
				   <colgroup>
				      <col width="127" style="mso-width-source:userset;mso-width-alt:4064;width:95pt">
				      <col width="44" span="2" style="mso-width-source:userset;mso-width-alt:1408;
				         width:33pt">
				      <col width="50" style="mso-width-source:userset;mso-width-alt:1600;width:38pt">
				      <col width="46" style="mso-width-source:userset;mso-width-alt:1472;width:35pt">
				      <col width="204" style="mso-width-source:userset;mso-width-alt:6528;width:153pt">
				      <col width="72" span="6" style="width:54pt">
				      <col width="107" style="mso-width-source:userset;mso-width-alt:3424;width:80pt">
				      <col width="72" span="6" style="width:54pt">
				      <col width="180" style="mso-width-source:userset;mso-width-alt:6656;width:120pt">
				   </colgroup>
				   <tbody>
				      <tr height="22" style="height:16.5pt">
				         <td height="22" class="xl66" width="118" style="text-align:center;
				            border:1px solid windowtext; height:16.5pt;width:89pt">　</td>
				         <td class="xl70" width="44" style="height:16.5pt; font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-left:none;width:33pt">SMS</td>
				         <td class="xl70" width="44" style="height:16.5pt; font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-left:none;width:33pt">LMS</td>
				         <td class="xl70" width="50" style="height:16.5pt; font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-left:none;width:38pt">MMS</td>
				         <td class="xl70" width="46" style="height:16.5pt; font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-left:none;width:35pt">KKO</td>
				         <td class="xl70" width="192" style="height:16.5pt; font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-left:none;width:144pt">컬럼명</td>
				         <td colspan="7" class="xl70" width="532" style="height:16.5pt; font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-left:none;width:399pt">설명</td>
				         <td colspan="7" class="xl70" width="640" style="height:16.5pt; font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-left:none;width:480pt">비고</td>
				      </tr>
				      <tr height="22" style="height:16.5pt">
				         <td height="22" class="xl71" style="width:89pt; font-weight:700;
				            border:1px solid windowtext; height:16.5pt;border-top:none">fuserid</td>
				         <td class="xl72" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl72" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl72" style="height:16.5pt; width:38pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl72" style="height:16.5pt; width:35pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl67" style="height:16.5pt; width:144pt; border:1px solid windowtext; border-top:none;border-left:none">USER계정</td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">mbrNo 또는 usrNo. 수동으로 발송할 경우
				            'system'
				         </td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">CommonConstants.FUSER_DEFAULT</td>
				      </tr>
				      <tr height="22" style="height:16.5pt">
				         <td height="22" class="xl67" style="width:89pt; border:1px solid windowtext; height:16.5pt;border-top:none">fmsgtype</td>
				         <td class="xl72" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl72" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl72" style="height:16.5pt; width:38pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl72" style="height:16.5pt; width:35pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl67" style="height:16.5pt; width:144pt; border:1px solid windowtext; border-top:none;border-left:none">메시지타입</td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">0 : SMS / 2 : LMS / 3: MMS
				            / 4 : KKO
				         </td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">CommonConstants.MSG_TP.
				            noticeTypeCd로 set
				         </td>
				      </tr>
				      <tr height="22" style="height:16.5pt">
				         <td height="22" class="xl67" style="width:89pt; border:1px solid windowtext; height:16.5pt;border-top:none">fsubject</td>
				         <td class="xl72" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl72" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl72" style="height:16.5pt; width:38pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl72" style="height:16.5pt; width:35pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl67" style="height:16.5pt; width:144pt; border:1px solid windowtext; border-top:none;border-left:none">메시지제목</td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">LMS/MMS</td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">　</td>
				      </tr>
				      <tr height="111" style="mso-height-source:userset;height:83.25pt">
				         <td height="111" class="xl71" style="width:89pt; font-weight:700;
				            border:1px solid windowtext; height:83.25pt;border-top:none">fmessage</td>
				         <td class="xl72" style="height:83.25pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl72" style="height:83.25pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl72" style="height:83.25pt; width:38pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl72" style="height:83.25pt; width:35pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl67" style="height:83.25pt; width:144pt; border:1px solid windowtext; border-top:none;border-left:none">메시지본문</td>
				         <td colspan="7" class="xl69" width="532" style="height:83.25pt; text-align:left;
				            border:1px solid windowtext;
				            white-space:normal; border-left:none;width:399pt">수동
				            발송외 시스템 발송은 비고란에 있는 템플릿 조회를 사용합니다.<br>
				            조회 후 템플릿 내용의 변수를 모두 데이터로 replace 한 후에 set
				         </td>
				         <td colspan="7" class="xl69" width="640" style="height:83.25pt; text-align:left;
				            border:1px solid windowtext;
				            white-space:normal; border-left:none;width:480pt">PushSO
				            pso = new PushSO();<br>
				            pso.setTmplNo(1L);<br>
				            PushVO pvo = pushService.getNoticeTemplate(pso); // 템플릿 조회<br>
				            pvo.getContents() //템플릿 내용
				         </td>
				      </tr>
				      <tr height="22" style="height:16.5pt">
				         <td height="22" class="xl71" style="width:89pt; font-weight:700;
				            border:1px solid windowtext; height:16.5pt;border-top:none">fsenddate</td>
				         <td class="xl73" style="height:16.5pt; width:33pt; color:windowtext;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl73" style="height:16.5pt; width:33pt; color:windowtext;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl73" style="height:16.5pt; width:38pt; color:windowtext;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl73" style="height:16.5pt; width:35pt; color:windowtext;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl67" style="height:16.5pt; width:144pt; border:1px solid windowtext; border-top:none;border-left:none">발송시간</td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">예약메시지인경우에만 해당 예약일시. null일
				            경우 즉시발송
				         </td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">　</td>
				      </tr>
				      <tr height="22" style="height:16.5pt">
				         <td height="22" class="xl71" style="width:89pt; font-weight:700;
				            border:1px solid windowtext; height:16.5pt;border-top:none">fdestine</td>
				         <td class="xl72" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl72" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl72" style="height:16.5pt; width:38pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl72" style="height:16.5pt; width:35pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl67" style="height:16.5pt; width:144pt; border:1px solid windowtext; border-top:none;border-left:none">수신자 전화번호</td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">　</td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">　</td>
				      </tr>
				      <tr height="22" style="height:16.5pt">
				         <td height="22" class="xl71" style="width:89pt; font-weight:700;
				            border:1px solid windowtext; height:16.5pt;border-top:none">fcallback</td>
				         <td class="xl73" style="height:16.5pt; width:33pt; color:windowtext;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl73" style="height:16.5pt; width:33pt; color:windowtext;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl73" style="height:16.5pt; width:38pt; color:windowtext;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl73" style="height:16.5pt; width:35pt; color:windowtext;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl67" style="height:16.5pt; width:144pt; border:1px solid windowtext; border-top:none;border-left:none">발신자 전화번호(회신번호)</td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">null일 경우 사이즈 기준정보의 고객센터 번호로
				            set
				         </td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">어바웃 펫 대표번호 1644-9601</td>
				      </tr>
				      <tr height="44" style="mso-height-source:userset;height:33.0pt">
				         <td height="44" class="xl67" style="width:89pt; border:1px solid windowtext; height:33.0pt;border-top:none">fsendstat</td>
				         <td class="xl72" style="height:33.0pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl72" style="height:33.0pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl72" style="height:33.0pt; width:38pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl72" style="height:33.0pt; width:35pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl67" style="height:33.0pt; width:144pt; border:1px solid windowtext; border-top:none;border-left:none">전송상태</td>
				         <td colspan="7" class="xl69" width="532" style="height:33.0pt; text-align:left;
				            border:1px solid windowtext;
				            white-space:normal; border-left:none;width:399pt">0:
				            전송대기 / 2: 결과대기(GW전송완료) / 3: 결과수신완료 / 4: 로그 이동 실패&nbsp;
				         </td>
				         <td colspan="7" class="xl69" width="640" style="height:33.0pt; text-align:left;
				            border:1px solid windowtext;
				            white-space:normal; border-left:none;width:480pt">운영환경을
				            제외하고 allowlist 를 운영하고 있습니다. 공통코드 &gt; 그룹코드 : MSG_ALLOW_LIST<br>
				            사용자 정의 1 값에 휴대전화 번호를 넣으면 해당번호로 수신할 수 있습니다. (구분자: comma)
				         </td>
				      </tr>
				      <tr height="22" style="height:16.5pt">
				         <td height="22" class="xl67" style="width:89pt; border:1px solid windowtext; height:16.5pt;border-top:none">ffilecnt</td>
				         <td class="xl72" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl72" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl72" style="height:16.5pt; width:38pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl72" style="height:16.5pt; width:35pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl67" style="height:16.5pt; width:144pt; border:1px solid windowtext; border-top:none;border-left:none">파일개수</td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">　</td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">ffilepath 값으로 set</td>
				      </tr>
				      <tr height="22" style="height:16.5pt">
				         <td height="22" class="xl71" style="width:89pt; font-weight:700;
				            border:1px solid windowtext; height:16.5pt;border-top:none">ffilepath</td>
				         <td class="xl72" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl72" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl72" style="height:16.5pt; width:38pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl72" style="height:16.5pt; width:35pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl67" style="height:16.5pt; width:144pt; border:1px solid windowtext; border-top:none;border-left:none">파일경로</td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">다중파일은 세미콜론으로 구분</td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">　</td>
				      </tr>
				      <tr height="22" style="height:16.5pt">
				         <td height="22" class="xl67" style="width:89pt; border:1px solid windowtext; height:16.5pt;border-top:none">fyellowid</td>
				         <td class="xl72" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl72" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl72" style="height:16.5pt; width:38pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl72" style="height:16.5pt; width:35pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl67" style="height:16.5pt; width:144pt; border:1px solid windowtext; border-top:none;border-left:none">KKO발신프로필키</td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">카카오 전송을 위해 승인받은 프로필키</td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">자동 세팅</td>
				      </tr>
				      <tr height="22" style="height:16.5pt">
				         <td height="22" class="xl71" style="width:89pt; font-weight:700;
				            border:1px solid windowtext; height:16.5pt;border-top:none">ftemplatekey</td>
				         <td class="xl72" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl72" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl72" style="height:16.5pt; width:38pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl72" style="height:16.5pt; width:35pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td style="height:16.5pt; width:144pt;">KKO 템플릿키</td>
				         <td colspan="7" class="xl74" style="height:16.5pt; width:378pt; text-align:left;
				            border-top:1px solid windowtext;
				            border-right:none;
				            border-bottom:1px solid windowtext;
				            border-left:1px solid windowtext; border-right:1px solid black">　</td>
				         <td colspan="7" class="xl74" style="height:16.5pt; width:378pt; text-align:left;
				            border-top:1px solid windowtext;
				            border-right:none;
				            border-bottom:1px solid windowtext;
				            border-left:1px solid windowtext; border-right:1px solid black;border-left:
				            none">　</td>
				      </tr>
				      <tr height="22" style="height:16.5pt">
				         <td height="22" class="xl67" style="width:89pt; border:1px solid windowtext; height:16.5pt;border-top:none">fkkoresendtype</td>
				         <td class="xl72" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl72" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl72" style="height:16.5pt; width:38pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl72" style="height:16.5pt; width:35pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl67" style="height:16.5pt; width:144pt; border:1px solid windowtext; border-left:none">KKO 재발송 메시지 타입</td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">SMS/LMS</td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">CommonConstants.RESEND_MSG_TP.
				            fmessage 바이트체크로 set
				         </td>
				      </tr>
				      <tr height="22" style="height:16.5pt">
				         <td height="22" class="xl67" style="width:89pt; border:1px solid windowtext; height:16.5pt;border-top:none">fkkoresendmsg</td>
				         <td class="xl72" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl72" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl72" style="height:16.5pt; width:38pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl72" style="height:16.5pt; width:35pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl67" style="height:16.5pt; width:144pt; border:1px solid windowtext; border-top:none;border-left:none">KKO 재발송 메시지 내용</td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">　</td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">fmessage 으로 set</td>
				      </tr>
				      <tr height="22" style="height:16.5pt">
				         <td height="22" class="xl71" style="width:89pt; font-weight:700;
				            border:1px solid windowtext; height:16.5pt;border-top:none">sndTypeCd</td>
				         <td class="xl72" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl72" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl72" style="height:16.5pt; width:38pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl72" style="height:16.5pt; width:35pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl68" style="height:16.5pt; width:144pt; text-align:left;
				            border:1px solid windowtext; border-top:none;border-left:none">메시지 구분 코드</td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">20: MMS/LMS/SMS&nbsp;&nbsp;&nbsp;&nbsp; 30: 알림톡</td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">CommonConstants.SND_TYPE</td>
				      </tr>
				      <tr height="22" style="height:16.5pt">
				         <td height="22" class="xl71" style="width:89pt; font-weight:700;
				            border:1px solid windowtext; height:16.5pt;border-top:none">mbrNo</td>
				         <td class="xl72" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl72" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl72" style="height:16.5pt; width:38pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl72" style="height:16.5pt; width:35pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl67" style="height:16.5pt; width:144pt; border:1px solid windowtext; border-top:none;border-left:none">회원번호</td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">회원 번호 또는 사용자 번호</td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">　</td>
				      </tr>
				      <tr height="22" style="height:16.5pt">
				         <td height="22" class="xl71" style="width:89pt; font-weight:700;
				            border:1px solid windowtext; height:16.5pt;border-top:none">noticeTypeCd</td>
				         <td class="xl72" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl72" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl72" style="height:16.5pt; width:38pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl72" style="height:16.5pt; width:35pt; color:red;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl68" style="height:16.5pt; width:144pt; text-align:left;
				            border:1px solid windowtext; border-top:none;border-left:none">발송 방식 코드</td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">10: 즉시&nbsp;&nbsp;&nbsp;&nbsp; 20: 예약</td>
				         <td colspan="7" class="xl68" style="height:16.5pt; width:378pt; text-align:left;
				            border:1px solid windowtext; border-left:none">CommonConstants.NOTICE_TYPE</td>
				      </tr>
				      <tr height="22" style="height:16.5pt">
				         <td height="22" class="xl67" style="width:89pt; border:1px solid windowtext; height:16.5pt;border-top:none">fkkobutton</td>
				         <td class="xl78" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl78" style="height:16.5pt; width:33pt; color:red;
				            font-weight:700;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl78" style="height:16.5pt; width:38pt; color:red;
				            font-weight:700;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl73" style="height:16.5pt; width:35pt; color:windowtext;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl67" style="height:16.5pt; width:144pt; border:1px solid windowtext; border-top:none;border-left:none">KKO 버튼</td>
				         <td colspan="7" class="xl74" style="height:16.5pt; width:378pt; text-align:left;
				            border-top:1px solid windowtext;
				            border-right:none;
				            border-bottom:1px solid windowtext;
				            border-left:1px solid windowtext; border-right:1px solid black;border-left:
				            none">링크기능, JSON 이용</td>
				         <td colspan="7" class="xl77" width="640" style="height:16.5pt; text-align:left;
				            border-top:1px solid windowtext;
				            border-right:none;
				            border-bottom:1px solid windowtext;
				            border-left:1px solid windowtext;
				            white-space:normal; border-right:1px solid black;
				            border-left:none;width:480pt">buttonList 로 set</td>
				      </tr>
				      <tr height="181" style="mso-height-source:userset;height:135.75pt">
				         <td height="181" class="xl71" style="width:89pt; font-weight:700;
				            border:1px solid windowtext; height:135.75pt;border-top:none">buttionList</td>
				         <td class="xl78" style="height:135.75pt; width:33pt; color:red;
				            font-weight:700;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl78" style="height:135.75pt; width:33pt; color:red;
				            font-weight:700;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl78" style="height:135.75pt; width:38pt; color:red;
				            font-weight:700;
				            border:1px solid windowtext; border-top:none;border-left:none">　</td>
				         <td class="xl73" style="height:135.75pt; width:35pt; color:windowtext;
				            font-weight:700;
				            text-align:center;
				            border:1px solid windowtext; border-top:none;border-left:none">O</td>
				         <td class="xl67" style="height:135.75pt; width:144pt; border:1px solid windowtext; border-top:none;border-left:none">카카오 버튼 List</td>
				         <td colspan="7" class="xl74" style="height:135.75pt; width:378pt; text-align:left;
				            border-top:1px solid windowtext;
				            border-right:none;
				            border-bottom:1px solid windowtext;
				            border-left:1px solid windowtext; border-right:1px solid black;border-left:
				            none">알림톡 템플릿에 버튼이 있는 경우 set</td>
				         <td colspan="7" class="xl77" width="640" style="height:135.75pt; text-align:left;
				            border-top:1px solid windowtext;
				            border-right:none;
				            border-bottom:1px solid windowtext;
				            border-left:1px solid windowtext;
				            white-space:normal; border-right:1px solid black;
				            border-left:none;width:480pt">&nbsp;&nbsp;&nbsp; <font class="font0" style="color:black;
				            font-size:11.0pt;
				            font-weight:400;
				            font-style:normal;
				            text-decoration:none;
				            font-family:'맑은 고딕', monospace;
				            mso-font-charset:129;">SsgKkoBtnPO</font><font class="font7" style="color:black;
				            font-size:11.0pt;
				            font-weight:400;
				            font-style:normal;
				            text-decoration:none;
				            font-family:'맑은 고딕', monospace;
				            mso-font-charset:129;"> buttonPo = new
				            SsgKkoBtnPO();<br>
				            &nbsp;&nbsp;&nbsp; buttonPo.setBtnName("버튼
				            명");<br>
				            &nbsp;&nbsp;&nbsp; buttonPo.setBtnType("버튼
				            타입"); // CommonConstants.KKO_BTN_TP_<br>
				            &nbsp;&nbsp;&nbsp; buttonPo.setPcLinkUrl("Pc
				            Link Url"); // 필수<br>
				            &nbsp;&nbsp;&nbsp;
				            buttonPo.setMobileLinkUrl("Mobile Link Url"); // 비필수<br>
				            &nbsp;&nbsp;&nbsp; List&lt;SsgKkoBtnPO&gt; list =
				            new ArrayList&lt;&gt;();<br>
				            &nbsp;&nbsp;&nbsp; list.add(buttonPo);<br>
				            &nbsp;&nbsp;&nbsp; </font><font class="font0" style="color:black;
				               font-size:11.0pt;
				               font-weight:400;
				               font-style:normal;
				               text-decoration:none;
				               font-family:'맑은 고딕', monospace;
				               mso-font-charset:129;">SsgMessageSendPO.set</font><font class="font6" style="color:red;
				               font-size:11.0pt;
				               font-weight:700;
				               font-style:normal;
				               text-decoration:none;
				               font-family:'맑은 고딕', monospace;
				               mso-font-charset:129;">ButtionList(list);</font>
				         </td>
				      </tr>
				   </tbody>
				</table>
			</div>
		</div>
		<br/>
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="SMS/MMS/KKO" style="padding:10px">
				<p>- 메소드 : BizService.sendMessage(SsgMessageSendPO po)</p>
				<p>- PO : SsgMessageSendPO (위 표 참고)</p>
				<p>- 템플릿의 바인딩 변수는 $ { 변수명 } 입니다.</p>
				<p>- 메시지 오발송 방지 및 과금 부족 방지를 위해 allowList 를 운영합니다. 부득이한 경우 외 테이블 데이터 적재확인으로 대체합니다.</p>
				<p>- 확인 테이블<br/>
					&emsp;SMS<br/>
				&emsp;&emsp;SSG_SEND_TRAN_SMS_REAL<br/>
				&emsp;&emsp;또는<br/>
				&emsp;&emsp;SSG_SEND_LOG_SMS_2021XX(당월)<br/>
				<br/>
				&emsp;MMS & LMS<br/>
				&emsp;&emsp;SSG_SEND_TRAN_MMS_REAL<br/>
				&emsp;&emsp;또는<br/>
				&emsp;&emsp;SSG_SEND_LOG_MMS_2021XX(당월)<br/>
				<br/>
				&emsp;알림톡<br/>
				&emsp;&emsp;SSG_SEND_TRAN_KKO<br/>
				&emsp;&emsp;또는<br/>
				&emsp;&emsp;SSG_SEND_LOG_MMS_2021XX(당월)<br/>
				</p>
				<p>- result message 확인 : /gs-apet-11-business/resources/config/messages/business_ko.properties > business.ssg.result.msg 이하</p>
				<br/><br/>
				<p>* 예시</p>
				<p>		// SMS/LMS/MMS/KKO object<br/>
		SsgMessageSendPO msg = new SsgMessageSendPO();<br/>
		// 1. SMS / LMS<br/>
		msg.setFuserid(String.valueOf(mbrNo));<br/>
		<br/>
		PushSO pso = new PushSO();<br/>
		pso.setTmplNo(1L);<br/>
		PushVO pvo = pushService.getNoticeTemplate(pso); // 템플릿 조회<br/>
		String message2 = pvo.getContents(); //템플릿 내용<br/>
		msg.setFmessage(message2);// 템플릿 내용 replace(데이터 바인딩)<br/>
		// msg.setFsenddate(sendDate); //예약 발송일 경우만 set<br/>
		msg.setFdestine("수신자번호");<br/>
		//msg.setFcallback("발신자번호");//어바웃 펫 대표번호 1644-9601 일 때만 발송 됨. service 에서 자동처리 하고 있음.<br/>
		msg.setSndTypeCd(CommonConstants.SND_TYPE_20); // MMS/LMS/SMS<br/>
		msg.setMbrNo(mbrNo);<br/>
		msg.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_10);// 즉시<br/>
		<br/>
		// 2. MMS<br/>
		msg.setFuserid(String.valueOf(mbrNo));<br/>
		<br/>
		PushSO pso = new PushSO();<br/>
		pso.setTmplNo(1L);<br/>
		PushVO pvo = pushService.getNoticeTemplate(pso); // 템플릿 조회<br/>
		String message2 = pvo.getContents(); //템플릿 내용<br/>
		msg.setFmessage(message2);// 템플릿 내용 replace(데이터 바인딩)<br/>
		// msg.setFsenddate(sendDate); //예약 발송일 경우만 set<br/>
		msg.setFdestine("수신자번호");<br/>
		//msg.setFcallback("발신자번호");//어바웃 펫 대표번호 1644-9601 일 때만 발송 됨. service 에서 자동처리 하고 있음.<br/>
		msg.setSndTypeCd(CommonConstants.SND_TYPE_20); // MMS/LMS/SMS<br/>
		msg.setMbrNo(mbrNo);<br/>
		msg.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_10);// 즉시<br/>
		msg.setFfilepath(ffilepath);<br/>
		<br/>
		// 3. Kakao<br/>
		msg.setFuserid(String.valueOf(mbrNo));<br/>
		<br/>
		PushSO pso = new PushSO();<br/>
		pso.setTmplNo(1L);<br/>
		PushVO pvo = pushService.getNoticeTemplate(pso); // 템플릿 조회<br/>
		String message = pvo.getContents(); //템플릿 내용<br/>
		msg.setFmessage(message);// 템플릿 내용 replace(데이터 바인딩)<br/>
		msg.setFtemplatekey(pvo.getTmplCd());//템플릿 키<br/>
		// msg.setFsenddate(sendDate); //예약 발송일 경우만 set<br/>
		msg.setFdestine("수신자번호");<br/>
		//msg.setFcallback("발신자번호");//어바웃 펫 대표번호 1644-9601 일 때만 발송 됨. service 에서 자동처리 하고 있음.<br/>
		msg.setSndTypeCd(CommonConstants.SND_TYPE_30); // 알림톡<br/>
		msg.setMbrNo(mbrNo);<br/>
		msg.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_10);// 즉시<br/>
		<br/>
		// 템플릿에 버튼이 있는 경우만<br/>
		SsgKkoBtnPO buttonPo = new SsgKkoBtnPO();<br/>
	    buttonPo.setBtnName("버튼 명");<br/>
	    buttonPo.setBtnType("버튼 타입"); // CommonConstants.KKO_BTN_TP_<br/>
	    buttonPo.setPcLinkUrl("Pc Link Url"); // 필수<br/>
	    buttonPo.setMobileLinkUrl("Mobile Link Url"); // 비필수<br/>
	    List<SsgKkoBtnPO> list = new ArrayList<>();<br/>
	    list.add(buttonPo);<br/>
	    msg.setButtionList(list);<br/>
		<br/>
	    <br/>
	    // 발송<br/>
	    int result = bizService.sendMessage(msg);<br/></p>
			</div>
		</div>
		<br/>

		<form name="sendMessageForm" id="sendMessageForm" method="post">			
			<div class="mTitle">
				<h2>메세지 발송 테스트</h2>
			</div>
			<table class="table_type1">
				<colgroup>
					<col width="20%"/>
					<col width="80%"/>
				</colgroup>
				<tbody>
					<tr>
						<th>발신 번호 (사이트 고객센터 번호)</th>
						<td>
							<input type="text" name="fcallback" class="phoneNumber" value="${csTelNo }" readonly="readonly" disabled="disabled">
						</td>
					</tr>
					<tr>
						<th>전송방식</th>
						<td>
							<frame:radio name="sndTypeCd" grpCd="${adminConstants.SND_TYPE }" excludeOption="${adminConstants.SND_TYPE_10},${adminConstants.SND_TYPE_40}" />
						</td>
					</tr>
					<tr>
						<th>발송구분</th>
						<td>
					<!-- 발송 구분 -->
					<frame:radio name="noticeTypeCd" grpCd="${adminConstants.NOTICE_TYPE }" 
					selectKey="${not empty noticeSendInfoList ? noticeSendInfoList[0].noticeTypeCd : adminConstants.NOTICE_TYPE_20 }" />
					<div id="pushDateArea" style="display:inline;">
						<frame:datepicker startDate="sendReqDtm" startHour="sendReqDtmHr" startMin="sendReqDtmMn" startSec="sendReqDtmSec"
							  startValue="${empty noticeSendInfoList ? frame:addDay('yyyy-MM-dd 00:00:00', 1) : frame:getFormatTimestamp(noticeSendInfoList[0].sendReqDtm, 'yyyy-MM-dd HH:mm:ss') }"
							  required="Y" />
						<input type="hidden" name="fsenddate" value="" id="fsenddate" >
					</div>
				</td>
					</tr>			
					<tr class="tmplUse">
						<th>템플릿 사용 여부</th>
						<td>
							<label class="fRadio"><input type="radio" name="tmplYn" value="Y" checked="checked"><span>사용</span></label>
							<label class="fRadio"><input type="radio" name="tmplYn" value="N"><span>미사용</span></label>
						</td>
					</tr>
					<tr class="tmplY">
						<th>템플릿 번호 입력</th>
						<td>
							<input type="text" name="tmplNo" id="tmplNo" style="margin-right: 5px;"><button type="button" onclick="pushTemplateSelectViewPop();" class="btn">템플릿 선택</button>
							<input type="hidden" name="ftemplatekey" id="tmplCd" value="">
							<button type="button" onclick="getTmple();" class="btn">호출</button>
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>
							<input type="text" class="tmplN" id="fsubject" name="fsubject" disabled="disabled" >							
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<textarea name="fmessage" id="fmessage" class="tmplN" disabled="disabled"></textarea>
						</td>
					</tr>
					<tr id="pathTr">
						<th>첨부파일</th>
						<td>
							<input type="text" class="w800 validate[custom[url]]"  name="ffilepath" ><span>&emsp;※ 다중파일은 세미콜론으로 구분</span>							
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
        	<button type="button" onclick="sendMessage();" class="btn btn-ok">발송</button>
       	</div>
	</t:putAttribute>
</t:insertDefinition>