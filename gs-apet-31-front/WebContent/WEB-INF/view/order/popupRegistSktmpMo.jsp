<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<tiles:insertDefinition name="default">
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">
			$(document).ready(function(){
			
				// 개인정보 수집및 이용동의팝업
				$(document).on("click" , "[name=mpTermsLayerBtn]", function(){
					var url = "/order/indexSktmpTerms?termsIndex="+ $(this).data("index").toString();
					window.open(url, "sktmpTermsWinPop");
				});
			
			}); // End Ready
			
			$(function() {
				$("#mpcNo1, #mpcNo2, #mpcNo3, #mpcNo4, #mpPopPinNo, input[name=mpTerms]").on('propertychange keyup input change paste', function(){
					// 카드번호 4자리 입력 시 다음 입력란 포커스
					if ($(this).data("index") == "1") {
						if ($(this).val().length === 4) {
							if ($("#mpcNo2").val() === "") {
								$("#mpcNo2").focus();
							}
						} else if ($(this).val().length > 4) {
							$(this).val($(this).val().substring(0,4));
						}
					} else if ($(this).data("index") == "2") {
						if ($(this).val().length === 4) {
							if ($("#mpcNo3").val() === "") {
								$("#mpcNo3").focus();
							}
						}
					} else if ($(this).data("index") == "3") {
						if ($(this).val().length === 4) {
							if ($("#mpcNo4").val() === "") {
								$("#mpcNo4").focus();
							}
						}
					} else if ($(this).data("index") == "4") {
						if ($(this).val().length > 4) {
							$(this).val($(this).val().substring(0,4));
						}
					}
					
					var cardTermsCheck = true;
					// 전체 체크박스
					var checkboxes = document.querySelectorAll('input[name=mpTerms]');
					// 선택된 체크박스
					var checked = document.querySelectorAll('input[name=mpTerms]:checked');
					if(checkboxes.length != checked.length) {
						cardTermsCheck = false;
					}
					
					if($("#mpcNo1").val().trim() != '' && $("#mpcNo2").val().trim() != ''
					&& $("#mpcNo3").val().trim() != '' && $("#mpcNo4").val().trim() != ''
					&& $("#mpPopPinNo").val().trim() != '' && cardTermsCheck){
						$("#registMpCardBtn").removeClass('disabled');
					}else{
						$("#registMpCardBtn").addClass('disabled');
					}
				})
			});
		
			// 우주멤버십 카드 등록 Valid Check
			function validCheckRegistSktmpCardInfo(){
				let $mpcNo1 = $("#mpcNo1");
				let $mpcNo2 = $("#mpcNo2");
				let $mpcNo3 = $("#mpcNo3");
				let $mpcNo4 = $("#mpcNo4");
				let cardNo = $mpcNo1.val() + $mpcNo2.val() + $mpcNo3.val() + $mpcNo4.val();
				let $mpcPinNo = $("#mpPopPinNo");
		
				// 카드번호 빈 값 CHECK
				if($mpcNo1.val() === ""){
					ui.alert('멤버십 번호를 입력해주세요',{
						ycb:function(){
							$mpcNo1.focus();
						},
						ybt:'확인'
					});
					return;
				}
				if($mpcNo2.val() === ""){
					ui.alert('멤버십 번호를 입력해주세요',{
						ycb:function(){
							$mpcNo2.focus();
						},
						ybt:'확인'
					});
					return;
				}
				if($mpcNo3.val() === ""){
					ui.alert('멤버십 번호를 입력해주세요',{
						ycb:function(){
							$mpcNo3.focus();
						},
						ybt:'확인'
					});
					return;
				}
				if($mpcNo4.val() === ""){
					ui.alert('멤버십 번호를 입력해주세요',{
						ycb:function(){
							$mpcNo4.focus();
						},
						ybt:'확인'
					});
					return;
				}
				
				// 카드번호 4자리 수 체크
				if($mpcNo1.val().length === 4){
					if($mpcNo2.val().length === 4){
						if($mpcNo3.val().length === 4){
							if($mpcNo4.val().length === 4){
								$("#mpPopCardNo").val(cardNo);
							}else {
								$("#regCardNoValidMsg").html("멤버십 번호를 다시 확인해주세요");
								$("#regCardNoValidMsg").show();
								return;
							}
						}else {
							$("#regCardNoValidMsg").html("멤버십 번호를 다시 확인해주세요");
							$("#regCardNoValidMsg").show();
							return;
						}
					}else {
						$("#regCardNoValidMsg").html("멤버십 번호를 다시 확인해주세요");
						$("#regCardNoValidMsg").show();
						return;
					}
				}else {
					$("#regCardNoValidMsg").html("멤버십 번호를 다시 확인해주세요");
					$("#regCardNoValidMsg").show();
					return;
				}
				$("#regCardNoValidMsg").hide();
		
				if($mpcPinNo.val() === ""){
					ui.alert('비밀번호를 입력해주세요',{
						ycb:function(){
							$mpcPinNo.focus();
						},
						ybt:'확인'
					});
					return;
				}
				
				if(checkSelectAll()){
					ui.alert('약관을 모두 확인해주세요',{
						ycb:function(){
							
						},
						ybt:'확인'
					});
					return;
				}
		
				sktmpPinNoCheck();
			}
		
			function checkSelectAll()  {
				// 전체 체크박스
				let checkboxes = document.querySelectorAll('input[name="mpTerms"]');
				// 선택된 체크박스
				let checked = document.querySelectorAll('input[name="mpTerms"]:checked');
		
				if(checkboxes.length === checked.length) {
					$("#registMpCardBtn").removeClass("disabled");
					return false;
				}else {
					$("#registMpCardBtn").addClass('disabled');
					return true;
				}
		
			}
		
			function closeSktmpPop(){
				window.self.close();
			}
		
			function resetCardPop(){
				$("#mpcNo1").val("");
				$("#mpcNo2").val("");
				$("#mpcNo3").val("");
				$("#mpcNo4").val("");
				$("#mpPopCardNo").val("");
				$("#mpPopPinNo").val("");
		
				if("${firstYn}" == 'Y') {
					$("input[name='mpTerms']").prop("checked", false);
					$("#registMpCardBtn").addClass('disabled');
				}
		
			}
		
			function sktmpPinNoCheck(){
				let url = "<spring:url value='/order/sktmpPinNoCheck' />";
				
				let sendData = {
					cardNo : $("#mpPopCardNo").val()
					, pinNo : $("#mpPopPinNo").val()
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
						
						//CI, 카드번호 일치 여부 호출 성공시
						if(data.equalVO && data.equalVO.result_CODE == "00"){
							if(data.equalVO.cnnt_INFO_STATUS != "true"){
								ui.alert('본인카드만 사용할 수 있어요.');
								return;
							}
						}
						
						if (data.resvo.result == "S" && data.resvo.result_CODE == "00") {
							if (data.resvo.is_SAME == "true") {
								saveSktmpCardInfo();
							} else {
								if (data.resvo.total_FAIL_COUNT >= 10) {
									ui.alert('비밀번호 10회 누적 입력 실패로<br>비밀번호 변경이 필요합니다.<br>우주앱에서 비밀번호를 재설정해주세요.');
									return;
								}
								if (data.resvo.daily_FAIL_COUNT >= 5) {
									$("#regPinNoValidMsg").html("비밀번호가 일치하지 않습니다. (" + data.resvo.daily_FAIL_COUNT + "/5)");
									$("#regPinNoValidMsg").show();
									ui.alert('비밀번호 5회 입력 실패로<br>비밀번호 변경이 필요합니다.<br>우주앱에서 비밀번호를 재설정해주세요.');
									return;
								}
								
								$("#regPinNoValidMsg").html("비밀번호가 일치하지 않습니다. (" + data.resvo.daily_FAIL_COUNT + "/5)");
								$("#regPinNoValidMsg").show();
								$("#mpPopPinNo").focus();
								return;
							}
							
						} else {
							ui.alert("카드번호, 비밀번호 체크 API 오류입니다.");
							return;
						}
		
					}
				}
				ajax.call(options);
			}
			
			function saveSktmpCardInfo(){
				let url = "<spring:url value='/order/saveSktmpCardInfo' />";
				
				let mpTermsNo = [];
				var termsCheckboxes = $("input[name=mpTerms]");
				for(var i=0; i<termsCheckboxes.length; i++){
					mpTermsNo.push(termsCheckboxes[i].defaultValue);
				}
				
				let sendData = {
					cardNo : $("#mpPopCardNo").val()
					, pinNo : $("#mpPopPinNo").val()
					, termsNo : mpTermsNo
				};
		
				let options = {
					url : url
					, data : sendData
					, done : function(data){
						opener.mpPnt.insertCallBack(data);
						window.self.close();
					}
				}
				ajax.call(options);
			}
			
		</script>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<article class="popLayer win a popWoozooJoin">
			<div class="pbd">
				<div class="phd">
					<div class="in">
						<h1 class="tit">우주멤버십 등록</h1>
						<button type="button" class="btnPopClose none" onclick="closeSktmpPop();">닫기</button>
					</div>
				</div>
				<div class="pct">
					<main class="poptents">
						<input type="hidden" name="mpPopCardNo" id="mpPopCardNo" />
						<div class="uicardinput">
							<ul class="list">
								<li>
									<div class="hdt">멤버십 번호</div>
									<div class="cdt">
										<input type="text" style="display: none; width:0px; height:0px; border: 0;" autocomplete="off" autocomplete="new-password">
										<input type="password" style="display: none; width:0px; height:0px; border: 0;" @focus="$refs.pwdInput.focus()" autocomplete="new-password">
										<div class="cardnums">
											<div class="input"><input type="number" id="mpcNo1" data-index="1" placeholder="1234" autocorrect="off" autocomplete="off" minlength="4" maxlength="4" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" title="1,2,3,4번째카드번호"></div>  
											<div class="input"><input type="password" id="mpcNo2" data-index="2" placeholder="****" inputmode="numeric" autocorrect="off" minlength="4" maxlength="4" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" title="5,6,7,8번째카드번호"></div> 
											<div class="input"><input type="password" id="mpcNo3" data-index="3" placeholder="****" inputmode="numeric" autocorrect="off" minlength="4" maxlength="4" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" title="9,10,11,12번째카드번호"></div> 
											<div class="input"><input type="number" id="mpcNo4" data-index="4" placeholder="5678" autocorrect="off" autocomplete="off" minlength="4" maxlength="4" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" title="13,14,15,16번째카드번호"></div>
										</div>
									</div>
									<p class="validation-check" id="regCardNoValidMsg" style="display:none;"></p>
								</li>
								<li>
									<div class="hdt">비밀번호</div>
									<div class="cdt">
										<div class="input"><input type="password" id="mpPopPinNo" name="mpPopPinNo" inputmode="numeric" placeholder="숫자 6자리 입력" minlength="6" maxlength="6" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" title="숫자 6자리 입력"></div>
									</div>
									<p class="validation-check" id="regPinNoValidMsg" style="display:none;"></p>
								</li>
							</ul>
							
						<c:if test="${firstYn eq 'Y' }">
							<ul class="agreeset">
							<c:forEach items="${termsList}" var="term" varStatus="stat">
								<li>
									<span class="checkbox">
										<input type="hidden" name="mpTermsNo" value="${term.termsNo }" />
										<input type="checkbox" name="mpTerms" value="${term.termsNo }" id="terms_${term.termsNo }" data-idx = "${stat.index }" data-terms-no="${term.termsNo}" class="${term.rqidYn eq frontConstants.COMM_YN_Y ? 'required' : ''}">
										<span class="txt"><a href="javascript:;" class="tt lk" name="mpTermsLayerBtn" data-index="${stat.index }">${term.termsNm }</a></span>
									</span>
								</li>
							</c:forEach>
							</ul>
						</c:if>
			
							<div class="btnSet bot ">
								<button type="button" class="btn lg d cancel" onclick="closeSktmpPop();">취소</button>
								<button type="button" class="btn lg a save disabled" id="registMpCardBtn" onclick="validCheckRegistSktmpCardInfo();">등록</button>
							</div>
						</div>
						
					</main>
				</div>
				
			</div>
			
		</article>
	</tiles:putAttribute>
</tiles:insertDefinition>