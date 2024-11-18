<tiles:insertDefinition name="mypage">
	<tiles:putAttribute name="script.include" value="script.member"/>
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">
		
			$(document).ready(function(){
				if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
					//Device 뒤로가기 버튼 기능을 웹에서 처리시 사용(Y:웹에서 백기능 처리, N:앱에서 처리)-호출 함수
					fncDeviceBackWebUse("fncGoBack");
				}
				
				// pc버전에서 질환/알러지 리스트 button 클릭시 header.jsp에서 걸어놨던 sendSearchEngineEvent ajax가 발생함으로
				// button을 클릭할때마다 로딩이 뜨기때문에 클릭이벤트를 off 시킨후 토글이벤트 init
				//$(".uidropmu button").off("click");
				//ui.dropmenu.init();
				
				if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10}") {
					$("footer").remove();
					$(".menubar").remove();
				}
			});
			
			function fncGoBack() {
				//history.replaceState("","","/my/pet/myPetListView");
				//location.href = "/my/pet/myPetListView";
				//location.href = "/mypage/indexMyPage"
				storageHist.goBack("/my/pet/myPetListView");
			}
			
			function petUpdate() {
				//location.replace("/my/pet/petUpdateView?petNo=${vo.petNo}");
				var form = $("<form></form>");
				form.attr("name", "petUpdateForm");
				form.attr("method", "post");
				form.attr("action", "/my/pet/petUpdateView");
				form.append($("<input/>", {type: 'hidden', name:'petNo', value:'${vo.petNo}' }));
				
				form.appendTo("body");
				form.submit();
				//storageHist.goBack("/my/pet/petUpdateView?petNo=${vo.petNo}");
			}
			
			function petDelete() {
				ui.confirm('마이펫 정보를 삭제할까요?',{ 
				    ycb:function(){
						var options = {
							url : "<spring:url value='/my/pet/petDelete' />"
							, data : { petNo : "${vo.petNo}", mbrNo : "${session.mbrNo}", imgPath : "${vo.imgPath}"}
							, done : function(result){
								if(result == "${frontConstants.CONTROLLER_RESULT_CODE_SUCCESS }") {
									fncTagInfoLogApi(
											{ url:"/my/pet/myPetView"
											, targetUrl:"/my/pet/myPetListView"
											,callback:petDeleteCallback()
											});
								}
							}
						};
						ajax.call(options);
				    },
				    ncb:function(){
				    },
				    ybt:'예',
				    nbt:'아니요'
				});
			}
		
			function petDeleteCallback(){
				//location.href = "/my/pet/myPetListView?deleteYn=Y";
				storageHist.goBack("/my/pet/myPetListView?deleteYn=Y");
			}
			
			function myPetIncl(petNo , petNm){
				//location.href = "/my/pet/indexMypetInclRecode?petNo=" + petNo;
				storageHist.goBack("/my/pet/indexMypetInclRecode?petNo=" + petNo);
			}
		</script>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<main class="container lnb page my" id="container">
			<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
				<div class="header pc cu mode7 pageHead heightNone">
					<div class="hdr">
						<div class="inr">
							<div class="hdt">
								<!-- mobile -->
								<button class="mo-header-btnType02" data-content="" data-url="">취소</button><!-- on 클래스 추가 시 활성화 -->
								<!-- // mobile -->
								<!-- mobile -->
								<button class="mo-header-backNtn" onclick="fncGoBack();" data-content="${session.mbrNo }" data-url="fncGoBack()">뒤로</button>
								<div class="mo-heade-tit">마이펫 정보</div>
								<div class="mo-header-rightBtn">
									<nav class="uidropmu dmenu">
										<button type="button" class="bt st" data-content="" data-url="">메뉴열기</button>
										<div class="list">
											<ul class="menu">
												<li><button type="button" class="bt" onclick="petUpdate();" data-content="" data-url="/my/pet/petUpdateView?petNo=${vo.petNo}">수정</button></li>
												<li><button type="button" class="bt" onclick="petDelete();" data-content="${session.mbrNo }" data-url="/my/pet/myPetListView">삭제</button></li>
											</ul>
										</div>
									</nav>
								</div>
								<button class="mo-header-close"></button>
								<!-- // mobile -->
							</div>
						</div>
					</div>
				</div>
			</c:if>
			<!-- // mobile -->
			<!-- // 페이지 헤더 -->
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<div class="mypet-admin">
						<!-- PC 타이틀 모바일에서 제거 -->
						<div class="pc-tit">
							<h2>마이펫 정보</h2>
							<div class="right-item">
								<nav class="uidropmu dmenu">
									<button type="button" class="bt st" data-content="" data-url="">메뉴열기</button>
									<div class="list">
										<ul class="menu">
											<li><button type="button" class="bt" onclick="petUpdate();" data-content="" data-url="/my/pet/petUpdateView?petNo=${vo.petNo}">수정</button></li>
											<li><button type="button" class="bt" onclick="petDelete();" data-content="${session.mbrNo }" data-url="/my/pet/myPetListView">삭제</button></li>
										</ul>
									</div>
								</nav>
							</div>
						</div>
						<!-- // PC 타이틀 모바일에서 제거 -->
						<div class="mypet-profile">
							<div>
								<div class="img-box">
									<div>
										<div class="my-picture medium1">
											<p class="picture"><img src="${frame:imagePath(vo.imgPath) }" alt="" style="height: 100%;width: 100%;"></p>
											<!-- <button class="btn edit"></button> -->
										</div>
										<p class="name">${vo.petNm }</p>
									</div>
								</div>
								<div class="t-box">
									<div class="item">
										<p class="tit">기본 정보</p>
										<div class="g-box">
											<ul>
												<li>
													<p class="t1">
														<c:if test="${vo.petGbCd eq frontConstants.PET_GB_10 }">견종</c:if>
														<c:if test="${vo.petGbCd eq frontConstants.PET_GB_20 }">묘종</c:if>
													</p>
													<p class="t2">
														<c:if test="${empty vo.petKindNm }">-</c:if>
														<c:if test="${not empty vo.petKindNm }">${vo.petKindNm }</c:if>
													</p>
												</li>
												<li>
													<p class="t1">나이</p>
													<p class="t2"><c:if test="${not empty vo.age }">${vo.age }세 </c:if><c:if test="${not empty vo.month }">${vo.month }개월</c:if></p>
												</li>
												<li>
													<p class="t1">성별</p>
													<p class="t2">
														<c:if test="${empty vo.petGdGbCd }">-</c:if>
														<c:if test="${not empty vo.petGdGbCd }"><frame:codeValue items="${petGdGbCdList }" dtlCd="${vo.petGdGbCd }"></frame:codeValue></c:if>
													</p>
												</li>
												<li>
													<p class="t1">몸무게</p>
													<p class="t2">
														<c:if test="${empty vo.weight }">-</c:if>
														<c:if test="${not empty vo.weight }">${vo.weight }kg</c:if>
													</p>
												</li>
											</ul>
										</div>
									</div>
									<div class="item">
										<p class="tit">건강 정보</p>
										<div class="g-box">
											<ul>
												<li>
													<p class="t1">중성화</p>
													<p class="t2">
														<c:if test="${empty vo.fixingYn or vo.fixingYn eq 'N'}">-</c:if>
														<c:if test="${vo.fixingYn eq 'Y' }">중성화 완료</c:if>
													</p>
												</li>
												<li>
													<p class="t1">염려질환</p>
													<p class="t2">
														<c:if test="${empty vo.diseaseNm }">-</c:if>
														<c:if test="${not empty vo.diseaseNm }">${vo.diseaseNm }</c:if>
														
													</p>
												</li>
												<li>
													<p class="t1">알러지</p>
													<p class="t2">
														<c:if test="${empty vo.allergyYn }">-</c:if>
														<c:if test="${vo.allergyYn eq 'Y' }">있음</c:if>
														<c:if test="${vo.allergyYn eq 'N' }">없음</c:if>
														<span class="inr-t1">${vo.allergyNm }</span>
													</p>
												</li>
											
											</ul>
										</div>
									</div>
								</div>  
							</div>
							<div class="btnSet set1">
								<a href="#" onclick="myPetIncl(${vo.petNo});return false;" class="btn lg a" data-content="" data-url="myPetIncl(${vo.petNo });">건강수첩</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</main>
		<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
               <jsp:param name="floating" value="talk" />
        </jsp:include>
		<%-- <c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_30 }">
			<jsp:include  page="/WEB-INF/tiles/include/footer.jsp" />
		</c:if> --%>
	</tiles:putAttribute>
</tiles:insertDefinition>