<c:choose>
	<c:when test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
		<c:set var="isnertDefinitionName" value="default"></c:set>
	</c:when>	
	<c:otherwise>
		<c:set var="isnertDefinitionName" value="common"></c:set>
	</c:otherwise>
</c:choose>

<tiles:insertDefinition name="${isnertDefinitionName }">
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">  
			
			/* $(window).on("beforeunload", function(){
				sessionStorage.removeItem('petInsertSuccess');
		    }); */
	
			$(document).ready(function(){
				if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
					//Device 뒤로가기 버튼 기능을 웹에서 처리시 사용(Y:웹에서 백기능 처리, N:앱에서 처리)-호출 함수
					fncDeviceBackWebUse("fncGoBack");
				}
				
				//sessionStorage.setItem("petInsertSuccess", true);
				
				if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10}") {
					$("#footer").remove();
				}
			});
			
			function confirm() {
				//sessionStorage.removeItem('petInsertSuccess');
				//location.href = "${returnUrl }";
				var sessionHistory = storageHist.getHist();
				var returnUrlIdx = sessionHistory.length-3;
				storageHist.goBack(sessionHistory[returnUrlIdx].url);
			}
			
			function showPrfl() {
				var form = $("<form></form>");
				form.attr("name", "petDeatilForm");
				form.attr("method", "post");
				form.attr("action", "/my/pet/myPetView");
				form.append($("<input/>", {type: 'hidden', name:'petNo', value:'${vo.petNo}' }));
				
				form.appendTo("body");
				form.submit();
			}
			
			function fncGoBack() {
				storageHist.goBack("/my/pet/myPetListView");
			}
		</script>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<main class="container page my" id="container">
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					
					<!-- 마이펫 등록  -->
					<div class="pet-wrap">
						<div class="step-area">
							<p class="tit t2 end">
								<span>${vo.petNm }</span>의 소중한 정보가 <br>
								등록되었습니다.
							</p>
							<div class="complete">
								<div class="item">
									<p class="img"><img src="${frame:imagePath(vo.imgPath) }" alt="이미지" class="img"></p>
									<p class="name">${vo.petNm }</p>
									<p class="detail">
										<c:if test="${not empty vo.petKindNm }"><span>${vo.petKindNm }</span></c:if>
										<c:if test="${not empty vo.petKindNm }"><span><frame:codeValue items="${petGdGbCdList }" dtlCd="${vo.petGdGbCd }"></frame:codeValue></span></c:if>
										<span><c:if test="${not empty vo.age }">${vo.age }세 </c:if><c:if test="${not empty vo.month }">${vo.month }개월</c:if></span>
										<c:if test="${not empty vo.weight }"><span>${vo.weight }kg</span></c:if>
									</p>
									<div class="btn-area">
										<a href="#" onclick="showPrfl();" class="btn round" data-content="" data-url="/my/pet/myPetView?petNo=${vo.petNo }">프로필 보기<span class="arrow"></span></a>
									</div>
								</div>
							</div>
							<!-- // 정보 입력 -->
							<div class="btnSet">
								<a href="#" onclick="confirm();" class="btn lg a" data-content="" data-url="${returnUrl }">확인</a>
							</div>
						</div>
					</div>
					<!-- // 마이펫 등록  -->
					
				</div>
			</div>
		</main>
		
		<!-- 플로팅 영역 -->
<%-- 		<c:if test="${view.deviceGb  eq 'PC'}"> --%>
<%-- 			<jsp:include page="/WEB-INF/tiles/include/floating.jsp"> --%>
<%-- 			       <jsp:param name="floating" value="talk" /> --%>
<%-- 			</jsp:include> --%>
<%-- 		</c:if> --%>
	</tiles:putAttribute>
</tiles:insertDefinition>