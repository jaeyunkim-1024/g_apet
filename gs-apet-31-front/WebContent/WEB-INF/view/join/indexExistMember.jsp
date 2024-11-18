<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.include" value="script.member"/>
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
			
			function fncGoReplaceUrl(url){
				storageHist.replaceHist();
				
				location.href = url;	
			}
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
								<!--<button id ="backBtn" class="mo-header-backNtn" onclick = "location.href='/indexLogin'" data-content="" data-url="history.go(-1)"><spring:message code='front.web.view.common.msg.back' /></button>-->
								<button id ="backBtn" class="mo-header-backNtn" onclick="storageHist.goBack();" data-content="" data-url=""><spring:message code='front.web.view.common.msg.back' /></button>
								<div class="mo-heade-tit"><span class="tit"><spring:message code='front.web.view.join.basic.member.info.title' /></span></div>
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
								<h2><spring:message code='front.web.view.join.basic.member.info.title' /></h2>
							</div>
							<!-- // PC 타이틀 모바일에서 제거  -->
							<div class="fake-pop">
								<c:choose>
									<c:when test="${ (existMember.ciCtfVal eq null || existMember.ciCtfVal eq '') && existMember.joinPath ne null }">
										<div class="result"><spring:message code='front.web.view.common.already.title' />
											<span class="blue">
											<c:if test="${existMember.joinPath eq '10' }"><spring:message code='front.web.view.join.app.sns.login.link.naver' /></c:if>
											<c:if test="${existMember.joinPath eq '20' }"><spring:message code='front.web.view.join.app.sns.login.link.kakao' /></c:if>
											<c:if test="${existMember.joinPath eq '30' }"><spring:message code='front.web.view.join.app.sns.login.link.google' /></c:if>
											<c:if test="${existMember.joinPath eq '40' }"><spring:message code='front.web.view.join.app.sns.login.link.apple' /></c:if>
											</span><spring:message code='front.web.view.join.sns.account.title' /> <span class="block"><spring:message code='front.web.view.join.sns.account.record.title' /></span></div>
										<div class="pbt pull mt90">
											<div class="btnSet">
												<c:if test="${existMember.joinPath eq '10' }">
													<a href="javascript:snsLogin(${frontConstants.SNS_LNK_CD_10});" class="btn lg a"  data-content="" data-url="/indexLogin"><spring:message code='front.web.view.join.sns.login.naver.button.title' /></a>
												</c:if>
												<c:if test="${existMember.joinPath eq '20' }">
													<a href="javascript:snsLogin(${frontConstants.SNS_LNK_CD_20});" class="btn lg a"  data-content="" data-url="/indexLogin"><spring:message code='front.web.view.join.sns.login.kakao.button.title' /></a>
												</c:if>
												<c:if test="${existMember.joinPath eq '30' }">
													<a href="javascript:snsLogin(${frontConstants.SNS_LNK_CD_30});" class="btn lg a"  data-content="" data-url="/indexLogin"><spring:message code='front.web.view.join.sns.login.google.button.title' /></a>
												</c:if>
												<c:if test="${existMember.joinPath eq '40' }">
													<a href="javascript:snsLogin(${frontConstants.SNS_LNK_CD_40});" class="btn lg a"  data-content="" data-url="/indexLogin"><spring:message code='front.web.view.join.sns.login.apple.button.title' /></a>
												</c:if>
											</div>
										</div>
									</c:when>
									<c:otherwise>
										<div class="result"><spring:message code='front.web.view.join.exist.member.title' /> <span class="blue">${existMember.loginId }</span><spring:message code='front.web.view.join.exist.member.id.title' /> <span class="block"><spring:message code='front.web.view.join.exist.member.account.title' /></span></div>
										<div class="pbt pull mt90">
											<div class="btnSet">
												<!--<a href="/indexLogin" class="btn lg a"  data-content="" data-url="/indexLogin"><spring:message code='front.web.view.find.id.result.do.login' /></a>-->
												<a href="#" onclick="fncGoReplaceUrl('/indexLogin'); return false;" class="btn lg a"  data-content="" data-url="/indexLogin"><spring:message code='front.web.view.find.id.result.do.login' /></a>
											</div>
										</div>
									</c:otherwise>
								</c:choose>
								<c:if test="${ existMember.joinPath eq null || existMember.joinPath eq '' }">
									<!--<a class="lnk-pw" href="/login/indexFindPswd" data-content="" data-url="/login/indexFindPswd" ><spring:message code='front.web.view.find.id.result.msg.forgot.pwd' /></a>-->
									<a class="lnk-pw" href="#" onclick="fncGoReplaceUrl('/login/indexFindPswd'); return false;" data-content="" data-url="/login/indexFindPswd" ><spring:message code='front.web.view.find.id.result.msg.forgot.pwd' /></a>
								</c:if>
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

