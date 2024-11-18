<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.inline">  
	<script type="text/javascript">
		$(document).ready(function(){
			if("${view.deviceGb}" != "PC"){
				$(".mode0").remove();
				$("#footer").remove();
				$(".menubar").remove();
			}else{
				$(".mode7").remove();
			}			
		});
	</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<body class="body">
			<div class="wrap" id="wrap">
		
				<!-- mobile header -->
				<header class="header pc cu mode7" data-header="set9">
					<div class="hdr">
						<div class="inr">
							<div class="hdt">
								<!--<button id ="backBtn" class="mo-header-backNtn" onclick = "history.go(-1);" data-content="" data-url="history.go(-1)"><spring:message code='front.web.view.common.msg.back'/></button>-->
								<button id ="backBtn" class="mo-header-backNtn" onclick="storageHist.goBack();" data-content="" data-url=""><spring:message code='front.web.view.common.msg.back'/></button>
								<div class="mo-heade-tit"><span class="tit"><spring:message code='front.web.view.find.id.result.guidance'/></span></div>
							</div>
						</div>
					</div>
				</header>
				<!-- // mobile header -->
		
				<!-- 바디 - 여기위로 템플릿 -->
				<main class="container page login srch" id="container">
		
					<div class="inr">
						<!-- 본문 -->
						<div class="contents" id="contents">
							<!-- PC 타이틀 모바일에서 제거  -->
							<div class="pc-tit">
								<h2><spring:message code='front.web.view.find.id.result.guidance'/></h2>
							</div>
							<!-- // PC 타이틀 모바일에서 제거  -->
							<div class="fake-pop">
								<div class="result">
									<span class="blue"><spring:message code='front.web.view.login.msg.find.id'/></span><spring:message code='front.web.view.find.id.result.complete'/>
								</div>
								<div class="end-box mt30">
									<c:if test="${member.mbrNm != '' }">
									<dl>
										<dt><spring:message code='front.web.view.common.name.title'/></dt>
										<dd>${member.mbrNm }</dd>
									</dl>
									</c:if>
									<dl>
										<dt>아이디</dt>
										<dd>${member.loginId }</dd>
									</dl>
								</div>
								<div class="pbt mt30">
									<div class="btnSet">
										<a href="/indexLogin" class="btn lg a" data-content="" data-url="/indexLogin" ><spring:message code='front.web.view.find.id.result.do.login'/></a>
									</div>
								</div>
								<a class="lnk-pw center" href="/login/indexFindPswd" data-content="" data-url="/login/indexFindPswd" ><spring:message code='front.web.view.find.id.result.msg.forgot.pwd'/></a>
							</div>
						</div>
		
					</div>
				</main>
		
				<div class="layers">
					<!-- 레이어팝업 넣을 자리 -->
				</div>
			</div>
		</body>
	</tiles:putAttribute>
</tiles:insertDefinition>

