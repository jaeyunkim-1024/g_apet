<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.include" value="script.member"/>
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">
			//회원 탈퇴
			function fnLeaveMember(){
				var data = $("#redirectForm").serializeJson();
				data.mbrLevRsnCd = $("[name='mbrLevRsnCd']:checked").val();
				data.mbrLevContent = $("[name='mbrLevContent']").val();

				var check = $("[name='mbrLevRsnCd']:checked").length;
				if(check == 0){
					ui.toast("사유를 선택해주세요.");
				}else{
					var option = {
						url : "/mypage/info/deleteMember"
						,	data : data
						,	type : "POST"
						,	done : function(result){
							var resultCode = result.resultCode;
							var msg = "";
							var alertOption = {};
							if(resultCode === "${frontConstants.CONTROLLER_RESULT_CODE_SUCCESS}"){
								ui.toast("회원탈퇴가 완료되었어요.");
								setTimeout(function(){
									location.href = "/tv/home";
								},2000);
							}else{
								ui.alert("지금은 탈퇴하실 수 없어요.<br>안내 사항을 확인해주세요.");
							}
						}
					};
					ajax.call(option);
				}
			}

			//취소
			function fnCancel(){
				$("#redirectForm").submit();
			}

			$(function() {
				$("[name='mbrLevRsnCd']").prop("checked",false);

				$(document).on("input paste change","[name='mbrLevContent']",function()  {
					//var unit = $("[name='mbrLevContent']").val().replace(/\s+/gi,' ').length;
					var unit = $("[name='mbrLevContent']").val().length;
					unit = unit > 200 ? 200 : unit;
					var maxlen = 200;
					$("#unit").text(unit+"/200");
 					//$("[name='mbrLevContent']").val($(this).val().replace(/\s+/gi,' ').substr(0,maxlen));
					$("[name='mbrLevContent']").val($(this).val().substr(0,maxlen));
				});

				//기타 사유 일 때, 사유 입력 란 활성화
				$(document).on("change","[name='mbrLevRsnCd']",function(){
					var checkedValue = $("[name='mbrLevRsnCd']:checked").val();
					var flag = checkedValue != "${frontConstants.MBR_LEV_RSN_80}";
					$("[name='mbrLevContent']").prop("disabled", flag);
					if(flag) $("[name='mbrLevContent']").val("");
				});

// 				var isApp = "${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}";
// 				if(isApp){
// 					$("#footer").hide();
// 				}
				
				if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10}"){
					$(".menubar").remove();
					$("footer").remove();
				}
				
			});
			
			function goBack() {
				history.replaceState("","",'/mypage/indexMyPage/');
				location.href='/mypage/indexMyPage/';
			}
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<form id="redirectForm" method="POST" action="/mypage/info/indexManageDetail" style="display:none;">
			<input type="text" name="checkCode" value="${checkCode}" />
			<input type="text" name="type" value="${type}" />
		</form>
		<main class="container page sett" id="container">
			<div class="header pageHead heightNone">
				<div class="inr">
					<div class="hdt">
						<button class="back" type="button" onclick="goBack();" data-content="" data-url="/mypage/indexMyPage">뒤로가기</button>
					</div>
					<div class="cent t2"><h2 class="subtit">회원 탈퇴</h2></div>
				</div>
			</div>

			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">

					<!-- PC 타이틀 모바일에서 제거  -->
					<div class="pc-tit">
						<h2>회원탈퇴</h2>
					</div>
					<!-- // PC 타이틀 모바일에서 제거  -->

					<div class="fake-pop">

						<div class="member-input">
							<ul class="list">
								<li>
									<strong class="tit">회원탈퇴 안내</strong>
									<div class="dot-txt">
										<p>회원탈퇴후 24시간 동안 재가입이 안됩니다. 24시간 지난 후 신규 회원가입이 가능합니다.</p>
										<p>회원탈퇴시, 회원님께서 보유하신 비현금성 포인트와 쿠폰 등은 모두 삭제됩니다.</p>
										<p>진행중인 거래 내역이 있거나, 현금성 포인트 등이 있다면 즉시 탈퇴가 불가능합니다.</p>
									</div>
								</li>
							</ul>
							<ul class="list bt-line">
								<li>
									<strong class="tit">회원탈퇴 사유</strong>
									<c:forEach var="item" items="${mbrLevRsnCdList}">
										<div class="flex-wrap">
											<label class="radio"><input type="radio" name="mbrLevRsnCd" value="${item.dtlCd}"><span class="txt">${item.dtlNm}</span></label>
										</div>
									</c:forEach>
								</li>
							</ul>
						</div>
						<div class="textarea">
							<textarea name="mbrLevContent" placeholder="탈퇴사유를 입력해주세요." style="height:260px;"></textarea>
							<p class="num" id="unit">0/200</p>
						</div>
						<div class="pbt mt20">
							<strong class="tit">정말 회원탈퇴 하시겠습니까?</strong>
							<div class="btnSet mt24">
								<a href="javascript:fnCancel();" class="btn lg a base">취소</a>
								<a href="javascript:fnLeaveMember();" class="btn lg a base">탈퇴하기</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</main>

		<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}" >
			<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
				<jsp:param name="floating" value="talk" />
			</jsp:include>
		</c:if>

	</tiles:putAttribute>
</tiles:insertDefinition>
