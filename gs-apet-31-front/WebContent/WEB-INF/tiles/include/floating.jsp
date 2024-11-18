<!-- TWC chatbot Scripts -->
<c:if test="${view.envmtGbCd eq 'dev' }">
	<script src="https://storage.googleapis.com/cloud-gate-cdn/sdk/Twc.plugin.qa.js" id="pluginJs" data-mode="develop2"></script>
</c:if>
<c:if test="${view.envmtGbCd ne 'dev' }">
	<script src="https://storage.googleapis.com/cloud-gate-cdn/sdk/Twc.plugin.js"></script>
</c:if>

<script type="text/javascript">
	var data = {
			brandKey: "${view.brandKey}",
			channelType: "chat", 
			UserNo: "${session.mbrNo}",
			buttonOption: {
				showLauncher: false,
				zIndex: 500,
				bottom: $("#cartNavs").length > 0 ? 95 : 25
			}
		};

	(function() {
		if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}") { 
			$.extend(data, {appId : 'apet'})
		}
	 	Twc('init', data)
	})();
	
	function twcChatOpen() {
		if ("${session.mbrNo }" == "${frontConstants.NO_MEMBER_NO }") {
			ui.confirm('로그인 후 서비스를 이용할 수 있어요.<br>로그인 할까요?',{
			    ycb:function(){ // 확인 버튼 클릭
			        // 로그인 페이지로 이동 (로그인 후 returnUrl로 이동);
					/* location.href = "/indexLogin?returnUrl=/tv/home/"; */
					location.href = "/indexLogin?returnUrl=/shop/home/";
			    },
			    ncb:function(){ // 취소 버튼 클릭
			    	
			    },
			    ybt:'로그인',
			    nbt:'취소'
			});
		} else {
			Twc.Chat.open();	
			
			// adbrix 호출 추가 (앱)
			if ("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true") {
				onAdbrixCustomEventData.eventName = 'petcare_click';
				toNativeAdbrix(onAdbrixCustomEventData);
			}
		}
	}
</script>

<nav class="floatNav">
	<div class="inr">
		<div class="bts">
		<c:if test="${param.floating eq 'top' || empty param.floating }">
			<div class="pd tp">
				<button type="button" class="bt tops">페이지위로</button>
			</div>
		</c:if>
		<c:if test="${param.floating eq 'talk' || empty param.floating }">
			<div class="pd tk">
				<button type="button" class="bt talk" onclick="twcChatOpen();">상담톡</button>
				<div class="tpn">
					<div class="txt">
						<div class="tt">24시간 언제나</div>
						<div class="ss">궁금할땐 톡!</div>
					</div>
				</div>
			</div>
		</c:if>
		</div>
	</div>
</nav>