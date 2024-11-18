<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="pbd">
	<div class="phd">
		<div class="in">
			<h1 class="tit">카드 정보 입력</h1>
			<button type="button" class="btnPopClose none" onclick="closeCardPop();">닫기</button>
		</div>
	</div>
	<div class="pct">
		<main class="poptents">
			<div class="uicardinput">
				<form id="billingCardForm">
					<input type="hidden" id="billMid" name="MID" value="">
					<input type="hidden" id="billMoid" name="Moid" value="">
					<input type="hidden" id="billEdiDate" name="EdiDate" value="">
					<input type="hidden" id="billEncData" name="EncData" value="">
					<input type="hidden" id="billSignData" name="SignData" value="">
					<input type="hidden" id="billBuyerName" name="BuyerName" value="<c:out value='${memberBase.mbrNm}' />">
					<input type="hidden" id="billBuyerEmail" name="BuyerEmail" value="<c:out value='${memberBase.email}' />">
					<input type="hidden" id="billBuyerTel" name="BuyerTel" value="<c:out value='${memberBase.mobile}' />">
					<input type="hidden" id="registBirth" name="IDNo" value="<c:out value='${memberBase.birth}' />">
					<input type="hidden" id="billCharSet" name="CharSet" value="euc-kr">
					<input type="hidden" id="billCardNo" name="CardNo" value="">
					<input type="hidden" id="billCertifyPassword" name="certifyPassword" value="">
					<input type="hidden" id="registPrsnCardBillNo" name="prsnCardBillNo" value="">
					<ul class="list">
						<li>
							<div class="hdt">카드 번호</div>
							<div class="cdt">
								<input type="text" style="display: none; width:0px; height:0px; border: 0;" autocomplete="off" autocomplete="new-password">
								<input type="password" style="display: none; width:0px; height:0px; border: 0;" @focus="$refs.pwdInput.focus()" autocomplete="new-password">
								<div class="cardnums">
									<div class="input"><input type="number" autocorrect="off" autocomplete="off" placeholder="1234" id="bcNo1" minlength="4" maxlength="4" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" title="1,2,3,4번째번호"></div>
									<div class="input"><input type="password" inputmode="numeric" autocorrect="off" autocomplete="off" placeholder="****" id="bcNo2" minlength="4" maxlength="4" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" title="5,6,7,8번째번호"></div>
									<div class="input"><input type="password" inputmode="numeric" autocorrect="off" autocomplete="off" placeholder="****" id="bcNo3" minlength="4" maxlength="4" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" title="9,10,11,12번째번호"></div>
									<div class="input"><input type="number" autocorrect="off" autocomplete="off" placeholder="4567" id="bcNo4" minlength="3" maxlength="4" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" title="13,14,15,16번째번호"></div>
								</div>
							</div>
						</li>
						<li>
							<div class="hdt">유효기간</div>
							<div class="cdt">
								<div class="cardrange">
									<div class="input"><input type="number" autocorrect="off" minlength="2" maxlength="2" placeholder="MM" name="ExpMonth" id="expMonth" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" title="유효기간 월"></div>
									<div class="input"><input type="number" autocorrect="off" minlength="2" maxlength="2" placeholder="YY" name="ExpYear" id="expYear" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" title="유효기간 년"></div>
								</div>
							</div>
						</li>
						<li>
							<div class="hdt">비밀번호</div>
							<div class="cdt">
								<div class="input"><input type="password" inputmode="numeric" autocorrect="off" minlength="2" maxlength="2" placeholder="카드 비밀번호 앞 2자리" id="cardPw" name="CardPw" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" title="카드 비밀번호 앞 2자리"></div>
							</div>
						</li>
					</ul>
				</form>
				<c:if test="${firstYn eq 'Y'}">
					<ul class="agreeset">

						<c:forEach items="${terms}" var="item" varStatus ="stat">
							<c:if test="${item.termsCd == '1005' || item.termsCd == '1006' || item.termsCd == '1007' || item.termsCd == '1010'}" >
								<li>
									<span class="checkbox">
										<input type="checkbox" name="cardTerms" id="terms_${item.termsNo }" data-idx = "${stat.index }" data-terms-no="${item.termsNo}" onclick="checkSelectAll()">
										<span class="txt"><a href="javascript:;" name="termPopBtn2" data-index="${stat.index }" class="tt lk">${item.termsNm}</a></span>
									</span>
									<a href="javascript:;" name ="contentPopBtn" title="내용보기" data-content="" data-url="" data-index="${stat.index }"></a>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</c:if>
				<div class="btnSet bot">
					<c:if test="${view.deviceGb eq 'PC' }"> <button type="button" class="btn lg d" onclick="closeCardPop();">취소</button></c:if>
					<button type="button" class="btn lg a disabled" id="registCardBtn" onclick="registEasyPay();return false;">저장</button>
				</div>
			</div>
		</main>
	</div>
</div>
<article class="popLayer a popBilPwdMod noClickClose" id="popBilPwdMod">
</article>
<div class="layers" style="display:none;">
	<c:forEach items = "${terms }" var = "term" varStatus = "stat">
		<!-- 이용 약관 -->
		<main class="container page login agree" id="container${stat.index }">
			<div class="inr">
				<div class="contents" id="contents">
					<!-- 팝업레이어 A 전체 덮는크기 -->
					<article class="popLayer a popSample1" id="termsContentPop_bc${stat.index }">
						<div class="pbd">
							<div class="phd">
								<div class="in">
									<h1 class="tit">${term.termsNm }</h1>
									<button type="button" id = "closeBtn" class="btnPopClose">닫기</button>
								</div>
							</div>
							<div class="pct">
								<main class="poptents">
									<!-- // PC 타이틀 모바일에서 제거  -->
									<div class="agree-box">
										<div class="select">
											<select name ="termContentSelect">
												<c:forEach items="${term.listTermsContent}" var ="content" varStatus ="stat">
													<c:if test ="${stat.index eq 0 }">
														<option value ="${stat.index }">현행 시행일자 : <frame:date date ="${content.termsStrtDt }" type ="K"/></option>
													</c:if>
													<c:if test ="${stat.index ne 0 }">
														<option value ="${stat.index }"><frame:date date ="${content.termsStrtDt }" type ="K"/> ~ <frame:date date ="${content.termsEndDt }" type ="K"/></option>
													</c:if>
												</c:forEach>
											</select>
										</div>
										<c:if test="${term.rqidYn eq frontConstants.COMM_YN_N }">
											<div class="agree-btn" style ="margin-top:20px;">
												<p class="txt">${term.termsNm }에 동의할까요?</p>
												<button name ="agreeTerm" class="btn a" data-terms-no="${term.termsNo }">동의</button>
											</div>
										</c:if>
										<c:forEach items="${term.listTermsContent}" var ="content" varStatus ="stat">
											<c:if test="${stat.index eq 0}">
												<section class="exlist">
													<dl>
															${content.content }
													</dl>
												</section>
											</c:if>
											<c:if test="${stat.index ne 0 }">
												<section class="exlist" style = "display:none;">
													<dl>
															${content.content}
													</dl>
												</section>
											</c:if>
										</c:forEach>
									</div>
								</main>
							</div>
						</div>
					</article>
				</div>
			</div>
		</main>
	</c:forEach>
</div>
<script type="text/javascript">

	$(document).ready(function(){

		// 개인정보 수집및 이용동의팝업
		$(document).on("click" , "[name=termPopBtn2]", function(){
			$(".layers").show();
			popServiceList2($(this).data("index"));
		});
		//닫기
		$(document).on("click" , "#closeBtn" , function(){
			if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10}"){
				//$("html, body").css({"overflow":"auto", "height":"auto"});
			}
			$(".layers").hide();
		})

	}); // End Ready

	$(function() {
		$("#bcNo1, #bcNo2, #bcNo3, #bcNo4, #expMonth, #expYear, #cardPw, input[name=cardTerms]").on('propertychange keyup input change paste', function(){
			var cardTermsCheck = true;
			
			if ($("#bcNo1").val().length > 4) {
				$("#bcNo1").val($("#bcNo1").val().substring(0,4));
			} else if ($("#bcNo4").val().length > 4) {
				$("#bcNo4").val($("#bcNo4").val().substring(0,4));
			}
			
			if ($("#expMonth").val().length > 2) {
				$("#expMonth").val($("#expMonth").val().substring(0,2));
			} else if ($("#expYear").val().length > 2) {
				$("#expYear").val($("#expYear").val().substring(0,2));
			}

			if(${firstYn eq 'Y'}) {
				// 전체 체크박스
				var checkboxes = document.querySelectorAll('input[name=cardTerms]');
				// 선택된 체크박스
				var checked = document.querySelectorAll('input[name=cardTerms]:checked');
				if(checkboxes.length != checked.length) {
					cardTermsCheck = false;
				}
			}
			
			if($("#bcNo1").val().trim() != '' && $("#bcNo2").val().trim() != ''
			&& $("#bcNo3").val().trim() != '' && $("#bcNo4").val().trim() != ''
			&& $("#expMonth").val().trim() != '' && $("#expYear").val().trim() != ''
			&& $("#cardPw").val().trim() != '' && cardTermsCheck){
				$("#registCardBtn").removeClass('disabled');
			}else{
				$("#registCardBtn").addClass('disabled');
			}
		})
	});

	// 간편결제 Valid Check
	function validCheckEasyPay(){

		let $bcNo1 = $("#bcNo1");
		let $bcNo2 = $("#bcNo2");
		let $bcNo3 = $("#bcNo3");
		let $bcNo4 = $("#bcNo4");
		let cardNo = $bcNo1.val() + $bcNo2.val() + $bcNo3.val() + $bcNo4.val();
		let $expMonth = $("#expMonth");
		let $expYear = $("#expYear");
		let $cardPw = $("#cardPw");

		// 카드번호 길이 CHECK
		if($bcNo1.val().length === 4){
			if($bcNo2.val().length === 4){
				if($bcNo3.val().length === 4){
					if($bcNo4.val().length >= 3 && $bcNo4.val().length < 5){	// AMEX 카드는 15자리(?)
						$("#billCardNo").val(cardNo);
					}else {
						ui.alert('카드 정보가 잘못되었습니다. <br>다시 입력해주세요.',{
							ycb:function(){
								$bcNo4.focus();
							},
							ybt:'확인'
						});
						return;
					}
				}else {
					ui.alert('카드 정보가 잘못되었습니다. <br>다시 입력해주세요.',{
						ycb:function(){
							$bcNo3.focus();
						},
						ybt:'확인'
					});
					return;
				}
			}else {
				ui.alert('카드 정보가 잘못되었습니다. <br>다시 입력해주세요.',{
					ycb:function(){
						$bcNo2.focus();
					},
					ybt:'확인'
				});
				return;
			}
		}else {
			ui.alert('카드 정보가 잘못되었습니다. <br>다시 입력해주세요.',{
				ycb:function(){
					$bcNo1.focus();
				},
				ybt:'확인'
			});
			return;
		}

		if($expMonth.val().length !== 2){
			ui.alert('유효기간을 확인 해주세요.',{
				ycb:function(){
					$expMonth.focus();
				},
				ybt:'확인'
			});
			return;
		}

		if($expYear.val().length !== 2){
			ui.alert('유효기간을 확인 해주세요.',{
				ycb:function(){
					$expYear.focus();
				},
				ybt:'확인'
			});
			return;
		}

		if($cardPw.val().length !== 2){

			ui.alert('카드 비밀번호를 확인 해주세요.',{
				ycb:function(){
					$cardPw.focus();
				},
				ybt:'확인'
			});
			return;
		}
		
		if(checkSelectAll()){
			ui.toast('이용약관에 동의해 주세요');
			$cardPw.focus();
			return;
		}

		getBillingRegistSignData();
	}

	function checkSelectAll()  {
		// 전체 체크박스
		let checkboxes = document.querySelectorAll('input[name="cardTerms"]');
		// 선택된 체크박스
		let checked = document.querySelectorAll('input[name="cardTerms"]:checked');

		if(checkboxes.length === checked.length) {
			$("#registCardBtn").removeClass("disabled");
			return false;
		}else {
			$("#registCardBtn").addClass('disabled');
			return true;
		}

	}

	// 간편결제 등록
	function registEasyPay(){

		validCheckEasyPay();

	}

	function closeCardPop(){

		ui.confirm('카드 등록을 취소할까요?',{ // 컨펌 창 옵션들
			ycb:function(){
				// 수정중 삭제..
				$("#billCardNo").val("");
				$("#bcNo1").val("");
				$("#bcNo2").val("");
				$("#bcNo3").val("");
				$("#bcNo4").val("");
				$("#expMonth").val("");
				$("#expYear").val("");
				$("#cardPw").val("");
				$("#billMid").val("");
				$("#billMoid").val("");
				$("#billEdiDate").val("");
				$("#billEncData").val("");
				$("#billSignData").val("");
				$("#billCertifyPassword").val("");
				$("#registPrsnCardBillNo").val("");
				$("input[name='cardTerms']").prop("checked", false);
				$("#registCardBtn").addClass('disabled');

				closeLayer('popCardinput');
			},
			ncb:function(){
				return false;
			},
			ybt:"예", // 기본값 "확인"
			nbt:"아니요"  // 기본값 "취소"
		});

	}

	function resetCardPop(){
		
		/* APETQA-6747 처리
		$("#billCardNo").val("");
		$("#bcNo1").val("");
		$("#bcNo2").val("");
		$("#bcNo3").val("");
		$("#bcNo4").val("");
		$("#expMonth").val("");
		$("#expYear").val("");
		$("#cardPw").val("");
		$("#billMid").val("");
		$("#billMoid").val("");
		$("#billEdiDate").val("");
		$("#billEncData").val("");
		$("#billSignData").val("");
		$("#billCertifyPassword").val("");
		*/
		//$("#prsnCardBillNo").val("");
		$("#bcNo1").focus();

		if(${firstYn eq 'Y'}) {
			$("input[name='cardTerms']").prop("checked", false);
			$("#registCardBtn").addClass('disabled');
		}

	}

	function getBillingRegistSignData(){

		let url = "<spring:url value='/pay/nicepay/getBillingRegistSignData' />";
		let cardNo = $("#billCardNo").val();
		let cardPw = $("#cardPw").val();
		let expMonth = $("#expMonth").val();
		let expYear = $("#expYear").val();
		let birth = $("#registBirth").val();

		let sendData = {
			CardNo : cardNo
			, ExpMonth : expMonth
			, ExpYear : expYear
			, CardPw : cardPw
			, IDNo	: birth
		};

		let options = {
			url : url
			, data : sendData
			, done : function(data){

				$("#billMid").val(data.mid);
				$("#billMoid").val(data.moid);
				$("#billEdiDate").val(data.ediDate);
				$("#billEncData").val(data.encData);
				$("#billSignData").val(data.signData);

				if(${firstYn eq 'Y'}){
                    registBillPassword(birth);
                }else{
					billingRegsistTemp("N");
				}

			}

		}
		ajax.call(options);
	}

	function registBillPassword(birth){

		let url = "<spring:url value='/order/registBillPassword' />";

		let options = {
			url : url
			, data : {
				birth : birth
			}
			, dataType : "html"
			, done : function(html){
				$("#popBilPwdMod").html(html);
				ui.popLayer.open("popBilPwdMod");
			}
		}
		ajax.call(options);

	}

	function billingRegsistTemp(firstYn){

		if(firstYn === 'Y'){
			closeLayer('popBilPwdMod');
		}

		$("#billCertifyPassword").val($("#finalPassword").val());

		let url = "<spring:url value='/order/insertRegistBillCardTemp' />";

		let options = {
			url : url
			, data : {
				cardNo : $("#billCardNo").val()
				, simpScrNo : $("#billCertifyPassword").val()
				, pgMoid : $("#billMoid").val()
			}
			, done : function(data){

				$("#registPrsnCardBillNo").val(data.prsnCardBillNo);

				billingRegistComplete(data.cardNo);
			}
		}
		ajax.call(options);
	}

	function billingRegistComplete(cardNo){

		let firstYn = "<c:out value='${firstYn}' />";
		let url = "<spring:url value='/pay/nicepay/registNicepayBilling' />";

		let options = {
			url : url
			, data : $("#billingCardForm").serialize()
			, done : function(result){

				if(result.resultCode === "<c:out value='${frontConstants.NICEPAY_BILLING_REGIST_SUCCESS}' />"){
					closeLayer('popCardinput');
					let registPrsnCardBillNo = $("#registPrsnCardBillNo").val();
					$("#prsnCardBillNo").val(registPrsnCardBillNo);
					
					if ($("#order_payment_form").length > 0) { // 주문결제 페이지에서 간편 카드 등록
						loadEasyPay();
					} else { // 마이페이지에서 간편 카드 등록
						if ($("#billingCardUl .nodata").length > 0) {
							$("#billingCardUl .nodata").remove();
						}
						var html = '<li id="billingCard'+registPrsnCardBillNo+'">';
						html += '<div class="box">';
						html += '<div class="cname">'+result.cardcNm+'</div>';
						html += '<div class="cnums">'+cardNo+'</div>';
						html += '<nav class="uidropmu dmenu">';
						html += '<button type="button" class="bt st">메뉴열기</button>';
						html += '<div class="list">';
						html += '<ul class="menu">';
						html += '<li><button type="button" class="bt" onclick="confirmDelete(\''+registPrsnCardBillNo+'\');">삭제</button></li>';
						html += '</ul>';
						html += '</div>';
						html += '</nav>';
						html += '</div>';
						html += '</li>';
						
						$("#billingCardUl").append(html);
					}
					
					ui.toast("결제카드가 등록되었어요.",{
						bot:74
					});
				} else {
					let errMsg = "카드정보가 잘못되었습니다. <br>다시 확인 해주세요.";
					
					ui.alert(errMsg,{
						ycb:function(){
							resetCardPop();
						},
						ybt:'확인'
					});
					return;

				}
			}
		}
		ajax.call(options);
	}

	//이용약관 레이어
	var popServiceList2 = function(index){
		// 레이어팝업 열기 콜백
		var checkbox = $('input:checkbox[data-idx='+index+']')
		var agreeBtn = $("button[data-terms-no="+checkbox.data('termsNo')+"]");
		if(checkbox.prop("checked")){
			agreeBtn.text("동의철회");
			agreeBtn.removeClass("a");
		}else{
			agreeBtn.text("동의");
			agreeBtn.addClass("a");
		}
		if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10}"){
			//$("html, body").css({"overflow":"hidden", "height":"100%"});
		}
		ui.popLayer.open('termsContentPop_bc'+index);
	}
</script>