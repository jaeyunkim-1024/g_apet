<tiles:insertDefinition name="mypage">
	
	<tiles:putAttribute name="script.include" value="script.member"/>
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">
		
		$(function(){
			
			if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10}"){
				$(".menubar").remove();
				$("footer").remove();
			}
		});
		
		//복사 아이콘 클릭
		function copyBtnClick(msg, type){
			if(msg == '' || msg == undefined ) msg ="${rcomCode}";
			copyToClipboard(msg, type);
		};
		
		//공유하기 버튼 클릭
		function shareBtnClick(type){
			//app인 경우
			if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30 }"){
				// 데이터 세팅
				toNativeData.func = "onShare";
				toNativeData.image = $("#appImage").val();
				toNativeData.subject = "어바웃펫 공유하기";
				toNativeData.link = $("#linkUrl").val(); 
				// 호출
				toNative(toNativeData);
			}else{
				//web인 경우
				copyBtnClick($("#linkUrl").val(), type);
			}
		}
		
		//초대코드 복사
		function copyToClipboard(val, type){
			var textarea = document.createElement("textarea");
			document.body.appendChild(textarea);
			textarea.value = val;
			textarea.select();
			document.execCommand('copy');
			document.body.removeChild(textarea);
			
			if(type == 'R') {
				messager.toast({txt: "추천코드가 복사되었어요."});	
			} else {
				messager.toast({txt: "링크가 복사되었어요"});
			}
		}
		
		function goBack() {
			history.replaceState("","",'/mypage/indexMyPage/');
			location.href='/mypage/indexMyPage/';
		}
		</script>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<body class="body">
		<div class="wrap" id="wrap">
	
			
			<div class="header pageHead heightNone">
				<div class="inr">
					<div class="hdt">
						<button class="back" id="goBackBtn" type="button" onclick="goBack();" data-content=""  data-url="/mypage/indexMyPage/">뒤로가기</button>
					</div>
					<div class="cent t2"><h2 class="subtit">친구 초대하기</h2></div>
				</div>
			</div>
			
			<input type="hidden" id="linkUrl" value="${linkUrl}"/>
			<input type="hidden" id="appImage" value=""/>
			
			<main class="container lnb page my invite" id="container">
	
				<div class="inr">			
	
					<!-- 본문 -->
					<div class="contents" id="contents">
	
						<!-- PC 타이틀 모바일에서 제거  -->
						<div class="pc-tit">
							<h2>친구 초대하기</h2>
						</div>
						<section class="sect">
							<div class="thum">
								<div class="pic">
									<img src="../../_images/common/mn_vis_1_mo.png" alt="친구초대하기 이미지" class="img mo"><!-- 04.06 : 수정 -->
									<img src="../../_images/common/mn_vis_1_pc.png" alt="친구초대하기 이미지" class="img pc"><!-- 04.06 : 수정 -->
								</div>
							</div>
							<dl class="code">
								<dt>친구 초대 코드</dt>
								<dd>
									<span>${rcomCode}</span>
									<a class="copy" id="copyBtn" href="javascript:copyBtnClick('', 'R');" data-content="" data-url=""  ></a>
								</dd>
							</dl>
						</section>
						
						<div class="btnSet">
							<a href="javascript:shareBtnClick('S');" class="btn lg a" data-content="" data-url="">어바웃펫 공유하기</a>
						</div>
					</div>
	
				</div>
			</main>
		</div>
	</body>
	</tiles:putAttribute>
</tiles:insertDefinition>