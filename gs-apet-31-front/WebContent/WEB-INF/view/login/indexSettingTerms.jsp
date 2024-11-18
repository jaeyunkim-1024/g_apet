<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">
			$(document).ready(function(){
				$(".menubar").remove();
				
	        	if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10}"){
	        		$(".mo-heade-tit .tit").text("서비스 이용약관");
	        		$(".footer").remove();
	        	}
			})
		
			function openTermsSetting(termsCd, settingYn){
				var options = {
					url : "/introduce/terms/indexTerms"
					, data : {
						termsCd : termsCd
						, settingYn : settingYn
					}
					, dataType : "html"
					, done : function(html){
						$("#termsLayer").html(html);
// 						ui.popLayer.open("termsContentPop");
						ui.popLayer.open('termsContentPop',{ // 콜백사용법
							ocb:function(){
							},
							ccb:function(){
								$("#termsLayer .popLayer").remove();
							}
						});
					}
				}
				ajax.call(options)
			}
		</script>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<main class="container page term" id="container">
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
				
					<!-- PC 타이틀 모바일에서 제거  -->
					<div class="pc-tit">
						<h2><spring:message code='front.web.view.common.terms.and.conditions.for.service'/></h2>
					</div>
					<!-- // PC 타이틀 모바일에서 제거  -->
					
					<!-- 설정 컨텐츠 영역 -->
					<section class="sect svcTerm">
						<ul>
							<c:forEach items="${terms}" var="item" varStatus ="stat">
								<c:if test="${item.rqidYn eq 'Y'}" >
									<li>
										<div class="hBox" onclick="openTermsSetting('${item.termsCd}', '${item.rqidYn}', '${item.termsNo}');return false;">
											[<spring:message code='front.web.view.common.required.title'/>] ${item.termsNm}
										</div>
										<button type="button" onclick="openTermsSetting('${item.termsCd}', '${item.rqidYn }');return false;">버튼</button>
									</li>
								</c:if>
							</c:forEach>
							
							<c:if test="${not empty session.loginId}">
								<c:forEach items="${noReqTermsList}" var="item" varStatus ="stat">
									<li>
										<div class="hBox" onclick="openTermsSetting('${item.termsCd}', '${item.rqidYn }');return false;">
											[<spring:message code='front.web.view.common.choice.title'/>] ${item.termsNm}
										</div>
										<button type="button" onclick="openTermsSetting('${item.termsCd}', '${item.rqidYn }');return false;">버튼</button>
									</li>								
								</c:forEach>
							</c:if>
						</ul>	
						
					</section>
					<!-- // 설정 컨텐츠 영역 -->
				</div>
			</div>
		</main>
		
		<div id="termsLayer"></div>
	</tiles:putAttribute>
</tiles:insertDefinition>