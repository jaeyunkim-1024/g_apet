<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<tiles:insertDefinition name="default">
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">

			$(document).ready(function(){
	
			}); // End Ready
			
			// 핀번호 체크
			function sktmpPinNoCheck(){
	
				let url = "<spring:url value='/order/sktmpPinNoCheck' />";
				let mpcPinNo = $("#mpCardPinNo").val();
				
				if(mpcPinNo === ""){
					ui.alert('비밀번호를 입력해주세요',{
						ycb:function(){
							$("#mpCardPinNo").focus();
						},
						ybt:'확인'
					});
					return;
				}
				
				let sendData = {
					pinNo : mpcPinNo
				};
	
				let options = {
					url : url
					, data : sendData
					, done : function(data){
						//사용 정지 카드
						if (data.resvo && data.resvo.result_CODE == "PCK_PCV_E4015") {
							ui.alert('사용정지된 카드에요.');
							return;
						}
						
						// api 호출 성공 시
						if (data.resvo.result == "S" && data.resvo.result_CODE == "00") {
							if (data.resvo.is_SAME == "true") {
								opener.mpPnt.insertCallBack(data.cardInfo);
								window.self.close();
							} else {
								if (data.resvo.total_FAIL_COUNT >= 10) {
									ui.alert('비밀번호 10회 누적 입력 실패로<br>비밀번호 변경이 필요합니다.<br>우주앱에서 비밀번호를 재설정해주세요.');
									return;
								}
								if (data.resvo.daily_FAIL_COUNT >= 5) {
									$("#mpCardValidMsg").html("비밀번호가 일치하지 않습니다. (" + data.resvo.daily_FAIL_COUNT + "/5)");
									$("#mpCardValidMsg").show();
									ui.alert('비밀번호 5회 입력 실패로<br>비밀번호 변경이 필요합니다.<br>우주앱에서 비밀번호를 재설정해주세요.');
									return;
								}
								
								$("#mpCardValidMsg").html("비밀번호가 일치하지 않습니다. (" + data.resvo.daily_FAIL_COUNT + "/5)");
								$("#mpCardValidMsg").show();
								$("#mpCardPinNo").focus();
								return;
							}
							
						} else {
							ui.alert("비밀번호 체크 API 오류입니다.");
							return;
						}
	
					}
				}
				ajax.call(options);
			}
			
			function closeSktmpPwdPop(){
				$("#mpCardPinNo").val("");
				window.self.close();
			}
			
			// 비밀번호 재설정 클릭
			function sktmpPwdReset(){
				ui.alert("비밀번호 설정은 우주앱에서 가능합니다.<br>‘설정 > 우주코인 비밀번호 등록/변경’<br>메뉴에서 비밀번호를 재설정해주세요.");
			}
			
		</script>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<article class="popLayer win a popWoozooPass">
			<div class="pbd">
				<div class="phd">
					<div class="in">
						<h1 class="tit">비밀번호 확인</h1>
						<button type="button" class="btnPopClose none" onclick="closeSktmpPwdPop();">닫기</button>
					</div>
				</div>
				<div class="pct">
					<main class="poptents">
						<div class="result mt15">
							<p class="sub">우주코인 조회를 위해</p>
							<p class="sub">우주멤버십 비밀번호를 입력해주세요.</p>
						</div>
						
						<div class="woozooPass">
							<ul class="list">
								<li>
									<input type="text" style="display: none; width:0px; height:0px; border: 0;" autocomplete="off" autocomplete="new-password">
									<input type="password" style="display: none; width:0px; height:0px; border: 0;" @focus="$refs.pwdInput.focus()" autocomplete="new-password">
									<div class="input del">
										<input type="password" id="mpCardPinNo" inputmode="numeric" autocorrect="off" minlength="6" maxlength="6" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" title="핀번호" placeholder="비밀번호를 입력하세요">
									</div>
									<p class="validation-check" id="mpCardValidMsg" style="display:none;"></p>
								</li>
							</ul> 
						</div>
						
						<div class="btnSet mt30">
								<button type="button" class="btn lg d cancel" onclick="closeSktmpPwdPop();">취소</button>
								<button type="button" class="btn lg a save" onclick="sktmpPinNoCheck();return false;">확인</button>
						</div>
						<a class="lnk-pw center" href="javascript:;" onclick="sktmpPwdReset();">비밀번호 재설정</a>
					</main>
				</div>
				
			</div>
		</article>
	</tiles:putAttribute>
</tiles:insertDefinition>
