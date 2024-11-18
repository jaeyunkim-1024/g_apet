<tiles:insertDefinition name="noheader_mo">
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">
			$(function(){
				if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10}"){
					$(".mo-heade-tit .tit").html("<spring:message code='front.web.view.index.myinfo.msg.manage.my.info'/>");
				}
			})
			
			function goBack() {
				location.href = "${returnUrl}";
			}
		</script>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<main class="container page sett" id="container">

<%-- 			<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }"> --%>
<!-- 				<header class="header pc cu mode7" data-header="set9" style="height:0px;"> -->
<!-- 					<div class="hdr"> -->
<!-- 						<div class="inr"> -->
<!-- 							<div class="hdt"> -->
<%-- 								<button class="mo-header-backNtn" onclick="goBack();" data-content="" data-url="${returnUrl }"><spring:message code='front.web.view.common.msg.back'/></button> --%>
<%-- 								<div class="mo-heade-tit"><span class="tit"><spring:message code='front.web.view.index.myinfo.msg.manage.my.info'/></span></div> --%>
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</header> -->
<%-- 			</c:if> --%>
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">

					<!-- PC 타이틀 모바일에서 제거  -->
					<div class="pc-tit">
						<h2><spring:message code='front.web.view.index.myinfo.msg.manage.my.info'/></h2>
					</div>
					<!-- // PC 타이틀 모바일에서 제거  -->
					
					<!-- 설정 컨텐츠 영역 -->
					<div class="setlist nline">
						<dl>
							<dd>
								<ul>
									<li>
										<a href="/mypage/info/indexPswdUpdate" data-content="" data-url="/mypage/info/indexPswdUpdate">
<%-- 										<a href="/mypage/info/indexPswdUpdate?returnUrl=/indexMyInfo?returnUrl=${returnUrl }" data-content="" data-url="/mypage/info/indexPswdUpdate"> --%>
											<span class="ti"><spring:message code='front.web.view.find.pwd.result.set.pwd'/></span>
											<span class="next"></span>
										</a>
									</li>
									<li>
										<a href="/mypage/info/indexManageCheck" data-content="${session.mbrNo }" data-url="/mypage/info/indexManageCheck">
<%-- 										<a href="/mypage/info/indexManageCheck?returnUrl=/indexMyInfo?returnUrl=${returnUrl }" data-content="${session.mbrNo }" data-url="/mypage/info/indexManageCheck"> --%>
											<span class="ti"><spring:message code='front.web.view.index.myinfo.edit.info'/></span>
											<span class="next"></span>
										</a>
									</li>
								</ul>
							</dd>
						</dl>
						<div class="btnSet">
							<a href="/logout?returnUrl=/" class="btn c" data-content="" data-url="/logout?returnUrl=/"><spring:message code='front.web.view.common.msg.logout'/></a>
						</div>
					</div>
					<!-- // 설정 컨텐츠 영역 -->
				</div>
			</div>
		</main>
	</tiles:putAttribute>
</tiles:insertDefinition>