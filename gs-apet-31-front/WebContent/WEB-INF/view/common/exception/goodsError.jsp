<%--
 - Class Name	: /common/exception/goodsError.jsp
 - Description	: error404
 - Since		: 2021.3.15
 - Author		: KSH
--%>

<%--
사용 Tiles 지정
--%>
<tiles:insertDefinition name="noheader_mo">
	<%--
	Tiles script.include put
	불 필요시, 해당 영역 삭제
	--%>
	<tiles:putAttribute name="script.include" value="script.member"/> <%-- 지정된 스크립트 적용  --%>

	<%--
	Tiles script.inline put
	불 필요시, 해당 영역 삭제
	--%>
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">
		$(document).ready(function(){
			$("#header_pc").removeClass("mode0");
			$("#header_pc").addClass("mode7-1");
			$("#header_pc").attr("data-header", "set18");
			$(".mo-heade-tit .tit").remove();
			$(".mo-header-backNtn").remove();
		});

		function goMainService() {
			if ('${view.deviceGb eq frontConstants.DEVICE_GB_30 }' == 'true') {
				<%--앱 설정정보 조회 --%>
				<%-- 데이터 세팅 --%>
				toNativeData.func = "onSettingInfos";
				toNativeData.callback = "appSettingInfo";
				<%-- APP 호출 --%>
				toNative(toNativeData);
			} else {
				window.location.href ='/';
			}
		}

		<%-- 앱 설정정보 값 셋팅(메인 설정) --%>
		function appSettingInfo(jsonString){
			let parseData = JSON.parse(jsonString);
			<%-- 메인 설정값  --%>
			let mainPage = parseData.mainPage;
			let mainUrl = '/shop/home/';
			if (mainPage == 'LOG') {
				mainUrl = '/log/home/';
			}
			if (mainPage == 'TV') {
				mainUrl = '/tv/home/';
			}
			window.location.href = mainUrl;
		}
		</script>
	</tiles:putAttribute>

	<%--
	Tiles content put
	--%>
	<tiles:putAttribute name="content">
		<%-- content 내용 부분입니다.	 --%>
		<%-- 바디 - 여기위로 템플릿  --%>
		<main class="container page login srch agree" id="container">
			<div class="inr">
				<%-- 본문  --%>
				<div class="contents error-wrap-area" id="contents">

					<%-- 상품 접근 에러 --%>
					<div class="error-area">
						<div class="error">
							<p class="txt"><spring:message code='front.web.view.goods.msg.error.500'/></p>
							<p class="txt-s">
								<spring:message code='front.web.view.goods.msg.error.500.notice'/>
							</p>
							<div class="btnSet">
								<a href="javascript:history.go(-1);" class="btn c"><spring:message code='front.web.view.common.msg.goBack'/></a>
								<a href="javascript:goMainService();" class="btn b"><spring:message code='front.web.view.common.msg.goHome'/></a>
							</div>
						</div>
					</div>
					<%-- // 상품 접근 에러 --%>

				</div>
			</div>
		</main>
	</tiles:putAttribute>
</tiles:insertDefinition>