<tiles:insertDefinition name="mypage_mo_nomenubar">
	<tiles:putAttribute name="content">
		<main class="container lnb page shop cardmag pc-onlyNone-delsel my" id="container">
			<input type="hidden" id="birth" value="<c:if test="${memberBase.birth ne null and memberBase.birth ne ''}"> ${memberBase.birth} </c:if>">
			<input type="hidden" id="ciCtfVal" value="<c:if test="${memberBase.ciCtfVal ne null and memberBase.ciCtfVal ne ''}"> ${memberBase.ciCtfVal} </c:if>" />
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<div class="uicardimag">
						<!-- PC 타이틀 모바일에서 제거  -->
						<div class="pc-tit">
							<h2>결제 카드 관리</h2>
							<div class="right-item">
								<button class="btn card" onclick="fnCardAddBtnOnClick();">카드추가</button>
							</div>
						</div>
						<ul class="list list-typePc" id="billingCardUl">
							<c:choose>
								<c:when test="${not empty cardBillInfo}">
									<c:forEach var="cardBill" items="${cardBillInfo}" varStatus="status" >
										<li id="billingCard${cardBill.prsnCardBillNo}">
											<div class="box">
												<div class="cname">${cardBill.cardcNm}</div>
												<div class="cnums">${cardBill.cardNo}</div>
												<nav class="uidropmu dmenu">
													<button type="button" class="bt st">메뉴열기</button>
													<div class="list">
														<ul class="menu">
															<li><button type="button" class="bt" onclick="confirmDelete('${cardBill.prsnCardBillNo}');">삭제</button></li>
														</ul>
													</div>
												</nav>
											</div>
										</li>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<li class="nodata">
										<div class="msg">
											<p class="tit">등록된 카드 정보가 없습니다.</p>
											<p class="txt">자주 사용하는 카드를 등록하세요 <br> <b class="t">최초 1회</b> 등록 후, 바로 사용 가능합니다.</p>
										</div>
									</li>
								</c:otherwise>
							</c:choose>
						</ul>
					</div>
				</div>
			</div>
		</main>
		 <!-- 플로팅 영역 -->
        <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}" >
			<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
	        	<jsp:param name="floating" value="" />
	        </jsp:include>
        </c:if>
	</tiles:putAttribute>
	<tiles:putAttribute name="layerPop">
		<article class="popLayer a popCardinput noClickClose" id="popCardinput"></article>
		<article class="popLayer a popBilPwdMod noClickClose" id="popBilPwdConfirm"></article>
		<div id="layers"></div>
	</tiles:putAttribute>
    <tiles:putAttribute name="script.include" value="script.gsr"/>
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">

			$(document).ready(function(){
				if ("${view.deviceGb ne frontConstants.DEVICE_GB_10}" == "true") {
					ui.lock.using("${isEmptyCarBilingInfo}" == "${frontConstants.COMM_YN_Y}");
					$($("#header_pc").find('.tit')).text('결제 카드 관리');
				} else {
					$("#header_pc").removeClass('mode0');
					$("#header_pc").addClass('mode7');
				}

				$(".mo-header-backNtn").removeAttr("onclick");
 				$(".mo-header-backNtn").bind("click", function(){
 					storageHist.goBack();
				});

				//모바일 일 때,
				$(".mo-header-btnType01").remove();
				$("#header_pc .mo-header-rightBtn")
						.prepend("<button class=\"mo-header-btnType01\" onclick=\"fnCardAddBtnOnClick();\"><span class=\"mo-header-icon\"></span><span class=\"txt\">카드추가</span></button>");
				ui.shop.lnb.pos();
			});

			//레이어 팝업 닫기
			function closeLayer(id){
				ui.popLayer.close(id);
			}

			//confrim 레이어 팝업
			function confirmDelete(prsnCardBillNo){
				ui.confirm('등록한 카드정보를<br/>삭제할까요?',{ // 컨펌 창 옵션들
					ycb:function(){
						deleteBillingCard(prsnCardBillNo);
					},
					ncb:function(){
						return false;
					},
					ybt:"예", // 기본값 "확인"
					nbt:"아니요"  // 기본값 "취소"
				});
			}

			//카드 삭제
			function deleteBillingCard(prsnCardBillNo){
				let url = "<spring:url value='/pay/nicepay/removeBillingCard' />";

				let options = {
					url : url
					, data : {
						prsnCardBillNo : prsnCardBillNo
					}
					, done : function(result){

						if(result.resultCode === "<c:out value='${frontConstants.NICEPAY_BILLING_DELETE_SUCCESS}' />"){
							closeLayer('popCardinput');
							
							$("#billingCard" + prsnCardBillNo).remove();
							if ($("#billingCardUl li").not("#billingCardUl .nodata").length == 0) {
								var nodataHtml = '<li class="nodata">';
								nodataHtml += '<div class="msg"><p class="tit">등록된 카드 정보가 없습니다.</p>';
								nodataHtml += '<p class="txt">자주 사용하는 카드를 등록하세요 <br> <b class="t">최초 1회</b> 등록 후, 바로 사용 가능합니다.</p></div></li>';
								
								$("#billingCardUl").append(nodataHtml);
							}
							ui.toast("카드정보가 삭제되었어요.",{
								bot:74
							});
						}else{

							let errMsg = '"' + result.resultMsg + '"' + "<br> 다시 삭제 해주세요.";

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

			//카드 등록
			function registBillingCard(firstYn){
				let url = "<spring:url value='/pay/nicepay/registBillingCard' />";
				let sendBillData = {
					  birth : $("#birth").val()
					, firstYn : firstYn
				};

				let options = {
					url : url
					, data : sendBillData
					, dataType : "html"
					, done : function(html){
						$("#popCardinput").html(html);
						ui.popLayer.open("popCardinput");
					}
				}
				ajax.call(options);

			}

			//최초 카드 추가
			function fnCardAddBtnOnClick(){
				var config = {
					//ci 값 있을 때
					 callBack : function(){
					 		//최초 등록 이면 'Y' , 아니면 'N'
						 	var firstYn = $(".nodata").length == 0 ? "N" : "Y";
						 	registBillingCard(firstYn);
					}
					//ci값 없을 때
					, okCertCallBack : function(data){
						$("#ciCtfVal").val(data.CI);
						$("#birth").val(data.birth);
						registBillingCard('Y');
					}
				};
				gk.open(config);
			}
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>
