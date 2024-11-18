<tiles:insertDefinition name="mypage">
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">
			//$(window).bind("pageshow", function(event){
			$(document).ready(function(){
				if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
					//Device 뒤로가기 버튼 기능을 웹에서 처리시 사용(Y:웹에서 백기능 처리, N:앱에서 처리)-호출 함수
					fncDeviceBackWebUse("fncGoBack");
				}
				
				if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10}") {
					$("footer").remove();
					$(".menubar").remove();
					
					$('header').removeClass('mode0').addClass('mode7 show');
					$('header').attr('data-header', 'set8');
					$('header .tit').text('마이펫 관리');
					var html = '';
					html += '<button class="mo-header-btnType01" onclick="petInsert();" data-content="${session.mbrNo}" data-url="/my/pet/petInsertView">';
					html += '<span class="mo-header-icon"></span>';
					html += '<span class="txt">등록하기</span>';
					html += '</button>';
					$('.mo-header-rightBtn').html(html);
					$('.mo-header-backNtn').attr('onclick', 'fncGoBack();');
				}
				
				var deleteYn = "${deleteYn}";
				if(deleteYn){
					ui.toast("마이펫 정보가 삭제되었어요.");
				    history.replaceState("", "", "/my/pet/myPetListView");
					storageHist.replaceHist("/my/pet/myPetListView")
				}
			});
		
			// 반려동물 등록 페이지
			function petInsert() {
				if("${fn:length(voList)}" >= 5) {
					ui.toast("마이펫은 5마리까지 등록할 수 있어요.");
					return;
				}

 				//location.href = "/my/pet/petInsertView";
				storageHist.goBack("/my/pet/petInsertView");
			}
			
			// 반려동물 상세 페이지
			function myPetView(petNo) {
				var form = $("<form></form>");
				form.attr("name" , "petDeatilForm");
				form.attr("method" , "post");
				form.attr("action" , "/my/pet/myPetView");
				form.append($("<input/>", {type: 'hidden', name:'petNo', value:petNo }));
				
				form.appendTo("body");
				form.submit();
			}
			
			function fncGoBack() {
				if(${empty session.bizNo}){
					//history.replaceState("","","/mypage/indexMyPage");
					location.href = "/mypage/indexMyPage";
				}else{
					//history.replaceState("","","/log/home");
					location.href = "/log/home";
				}
			}
		
			function myPetIncl(petNo , petNm){
				//location.href = "/my/pet/indexMypetInclRecode?petNo=" + petNo;
				storageHist.goBack("/my/pet/indexMypetInclRecode?petNo=" + petNo);
			}
			
		</script>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<main class="container lnb page my" id="container">
			<!-- 페이지 헤더 -->
			<!-- mobile -->
			<%-- <div class="header pageHead heightNone">
				<div class="inr">
					<div class="hdt">
						<!-- TODO 조은지 : 뒤로가기 URL변경해얗마. -->
						<button class="back" type="button" onclick="goBack();" data-content="" data-url="/mypage/indexMyPage">뒤로가기</button>
					</div>
					<div class="cent t2"><h2 class="subtit">마이펫 관리</h2></div>
					<div class="mdt">
						<button type="button" class="bt txt a make font" onclick="petInsert();" data-content="${session.mbrNo}" data-url="/my/pet/petInsertView"><i class="ico"></i> 등록하기</button>
					</div>
				</div>
			</div> --%>
			<!-- // mobile -->
			<!-- // 페이지 헤더 -->
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<div class="mypet-admin t2">
						<!-- PC 타이틀 모바일에서 제거 -->
						<div class="pc-tit">
								<h2>마이펫 관리</h2>
							<div class="right-item">
								<button class="btn sm new a" onclick="petInsert();" data-content="${session.mbrNo}" data-url="/my/pet/petInsertView">마이펫 등록하기</button>
							</div>
						</div>
						<!-- // PC 타이틀 모바일에서 제거 -->
						<!-- 마이펫 리스트 -->
						<div class="mypet-list">
							<ul class="list">
								<c:forEach items="${voList }" var="item">
									<li>
										<p class="img">
											<img src="${frame:imagePath(item.imgPath) }" onclick="myPetView(${item.petNo});" style="cursor: pointer;height: 100%;width: 100%;">
										</p>
										<div class="box">
											<p class="t1" onclick="myPetView(${item.petNo});" style="cursor: pointer;">${item.petNm }</p>
											<p class="t2">
												<c:if test="${not empty item.petKindNm }">
													<span>${item.petKindNm }</span>
												</c:if>
												<c:if test="${not empty item.petGdGbCd }"><span><frame:codeValue items="${petGdGbCdList }" dtlCd="${item.petGdGbCd }"></frame:codeValue></span></c:if>
												<span><c:if test="${not empty item.age }">${item.age }세 </c:if> <c:if test="${not empty item.month }">${item.month }개월</c:if></span>
											</p>
											<a href="#" onclick="myPetIncl(${item.petNo})" class="btn sm" data-content="" data-url ="myPetIncl(${item.petNo} , ${item.petNm})">건강수첩</a>
										</div>
										<a href="#" onclick="myPetView(${item.petNo});return false;" class="link" data-content="" data-url="/my/pet/myPetView?petNo=${item.petNo }">상세정보 이동</a>
									</li>
								</c:forEach>
							</ul>
						</div>
						<!-- // 마이펫 리스트 -->
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


