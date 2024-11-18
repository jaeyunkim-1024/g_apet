<tiles:insertDefinition name="mypage">
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">
			$(document).ready(function(){
				if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
					//Device 뒤로가기 버튼 기능을 웹에서 처리시 사용(Y:웹에서 백기능 처리, N:앱에서 처리)-호출 함수
					fncDeviceBackWebUse("fncGoBack");
				}
				
				if("${view.deviceGb}" != "${frontContants.DEVICE_GB_10}"){
					$("footer").remove();
					$(".menubar").remove();
				}
			});
			
			function petInsert() {
				//location.href = "/my/pet/petInsertView";
				storageHist.goBack("/my/pet/petInsertView");
			}
			
			function fncGoBack() {
				location.href = "/mypage/indexMyPage";
			}
			
			
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<main class="container lnb page my" id="container">
			<!-- 페이지 헤더 -->
			<!-- mobile -->
			<div class="pageHead heightNone">
				<div class="inr">
					<div class="hdt">
						<!-- TODO 조은지 : 뒤로가기시 마이페이지로 이동 -->
						<button class="back" type="button" onclick="fncGoBack();" data-content="" data-url="fncGoBack()">뒤로가기</button>
					</div>
					<div class="cent t2"><h2 class="subtit">마이펫 관리</h2></div>
					<div class="mdt">
						<button type="button" class="bt txt a make font" onclick="petInsert();" data-content="${session.mbrNo }" data-url="/my/pet/petInsertView"><i class="ico"></i> 등록하기</button>
					</div>
				</div>
			</div>
			<!-- // mobile -->
			<!-- // 페이지 헤더 -->
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents" style="height: 80vh;">
					<div class="mypet-admin">
						<!-- PC 타이틀 모바일에서 제거 -->
						<div class="pc-tit">
							<h2>마이펫 관리</h2>
<%-- 							<button class="btn sm add" onclick="petInsert();" data-content="${session.mbrNo }" data-url="/my/pet/petInsertView">마이펫 등록하기</button> --%>
							<div class="right-item">
								<button class="btn sm new a" onclick="petInsert();" data-content="${session.mbrNo }" data-url="/my/pet/petInsertView">마이펫 등록하기</button>
							</div>
						</div>
						<!-- // PC 타이틀 모바일에서 제거 -->
						<div class="mylog_area">
							<!-- 위치추천을 위해 서비스를 활성화해주세요. -->
							<section class="no_data i6 ">
								<div class="inr">
									<div class="msg">
										마이펫 등록하고<br /> <span>예방접종 내역</span>을 관리하세요.
									</div>
									<div class="uimoreview">
										<a href="#" onclick="petInsert(); return false;" class="bt more" data-content="${session.mbrNo }" data-url="/my/pet/petInsertView">마이펫 등록하기<span class="arrow"></span></a>
									</div>
								</div>								                               
							</section>
							<!-- // 위치추천을 위해 서비스를 활성화해주세요 -->
						</div>
					</div>
				</div>
			</div>
		</main>
		
		
		<!-- 플로팅 영역 -->
		<c:choose>
			<c:when test="${view.deviceGb  eq 'PC'}">
			<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
			       <jsp:param name="floating" value="" />
			</jsp:include>
			</c:when>
			<c:otherwise>
			<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
			       <jsp:param name="floating" value="talk" />
			</jsp:include>
			</c:otherwise>
		</c:choose>
		
		<%-- <c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_30 }">
			<jsp:include  page="/WEB-INF/tiles/include/footer.jsp" />
		</c:if> --%>
	</tiles:putAttribute>
</tiles:insertDefinition>	