<%--	
 - Class Name	: /common/exception/wrongAprch.jsp
 - Description	: 잘못된 접근시 노출 페이지
 - Since		: 2021. 07. 01.
 - Author		: KKB
--%>

<tiles:insertDefinition name="default">
	<tiles:putAttribute name="content"> 
		<!-- 헤더 MO-->
		<include class="header cu" data-include-html="../inc/header_cu.html" data-include-opt='{"header":"set16","tit":"잘못된 접근"}'></include>

		
		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container page login srch agree" id="container">
			<div class="inr">
				<!-- 본문 -->
				<div class="contents error-wrap-area" id="contents">
					
					<div class="error-area">
						<div class="error">
							<c:choose>
								<c:when test="${type eq 'test'}">
									<p class="txt">타입이 있는경우</p>
									<p class="txt-s">
										이곳에 적용
									</p>
								</c:when>
								<c:otherwise>
									<p class="txt">잘못된 접근입니다.</p>
									<p class="txt-s">
										요청하신 페이지에 접근할 수 없습니다. <br>
										다른 경로를 이용해주세요.
									</p>
								</c:otherwise>
							</c:choose>
							
							<div class="btnSet">
							<c:choose>
								<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_20 || view.deviceGb eq frontConstants.DEVICE_GB_30 }"> 
										<a href="javascript:storageHist.goBack();" class="btn c">이전 페이지</a>
								</c:when>
								<c:otherwise> 
										<a href="javascript:history.back();" class="btn c">이전 페이지</a>
								</c:otherwise>				
							</c:choose>
								<a href="javascript:location.href='/';" class="btn b">홈 바로가기</a>
							</div>
						</div>
					</div>
					
				</div>
			</div>
		</main>
	</tiles:putAttribute>	
</tiles:insertDefinition>