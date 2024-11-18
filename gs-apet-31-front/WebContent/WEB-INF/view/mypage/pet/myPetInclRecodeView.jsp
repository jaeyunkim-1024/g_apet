<tiles:insertDefinition name="mypage">
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">
			$(function(){
				if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
					//Device 뒤로가기 버튼 기능을 웹에서 처리시 사용(Y:웹에서 백기능 처리, N:앱에서 처리)-호출 함수
					fncDeviceBackWebUse("fncGoBack");
				}
				
				if("${view.deviceGb}" != "PC"){
					$(".mode0").remove();
					$("#footer").remove();
					$(".menubar").remove();
					$(".header").addClass('logHeaderAc');
				}else{
					$(".mode7").remove();
				}
				
				/*$(document).on("click" , "#backBtn" , function(){
					//history.go(-1)
					storageHist.goBack("/my/pet/indexMypetInclRecode?petNo=${recode.petNo}");
				});*/
			});
			
			function fncGoBack(){
				storageHist.goBack("/my/pet/indexMypetInclRecode?petNo=${recode.petNo}");
			}
			
			function updateMyPetInclRecode(){
				if('${recode.inclGbCd}' == "40"){
					//location.href = "/my/pet/insertMyPetInclRecodePage?petNo="+'${recode.petNo}'+"&subYn=Y&inclNo="+'${recode.inclNo}';
					storageHist.goBack("/my/pet/insertMyPetInclRecodePage?petNo="+'${recode.petNo}'+"&subYn=Y&inclNo="+'${recode.inclNo}');
				}else{
					//location.href = "insertMyPetInclRecodePage?petNo="+'${recode.petNo}'+"&subYn=N&inclNo="+'${recode.inclNo}';
					storageHist.goBack("/my/pet/insertMyPetInclRecodePage?petNo="+'${recode.petNo}'+"&subYn=N&inclNo="+'${recode.inclNo}');
				}
			}
			
			function deleteMypetInclRecode(){
				var msg;
				var deleteMsg;
				var subYn;
				if('${recode.inclGbCd}' == "40"){
					msg = "<spring:message code='front.web.view.mypet.confirm.delete.incl_recode_sub'/>";
					subYn = "Y"
				}else{
					msg = "<spring:message code='front.web.view.mypet.confirm.delete.incl_recode'/>";
					subYn = "N"
				}
				
				ui.confirm(msg , {
					ycb : function(){
						var options = {
							url : "<spring:url value='/my/pet/deleteMyPetInclRecode'/>"
							, data : {
								inclNo : '${recode.inclNo}'
							}
							, done : function(result){
								if(result > 0){
									//location.href = "/my/pet/indexMypetInclRecode?petNo=" + "${recode.petNo}" +"&deleteYn=Y&subYn=" + subYn;
									storageHist.goBack("/my/pet/indexMypetInclRecode?petNo=" + "${recode.petNo}" +"&deleteYn=Y&subYn=" + subYn);
								}
							}
						}
						ajax.call(options);
					}
					, ybt : "예"
					, nbt : "아니요"
				})
			}
			
			function addPopPic(obj) {
				$(".floatNav").hide();
				ui.addPopPic(obj);
				$(".pop-pic-wrap").css("z-index", 1000);
			}
			
			$(document).on("click", ".pop-pic-wrap .inr .had .close", function(){
				$(".floatNav").show();
			})
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<div class="wrap" id="wrap">
			<!-- mobile header -->
			<header class="header pc cu mode7" data-header="set9">
				<div class="hdr">
					<div class="inr">
						<div class="hdt">
							<button id ="backBtn" class="mo-header-backNtn" onclick="fncGoBack();">뒤로</button>
							<div class="mo-heade-tit">
								<span class="tit">
										<c:if test ="${recode.inclGbCd ne frontConstants.INCL_GB_40 }">
											예방접종 정보
										</c:if>
										<c:if test ="${recode.inclGbCd eq frontConstants.INCL_GB_40 }">
											투약 정보
										</c:if>	
								</span>
							</div>
							<div class="mo-header-rightBtn">
								<nav class="uidropmu dmenu">
									<button type="button" class="bt st">메뉴열기</button>
									<div class="list">
										<ul class="menu">
											<li><button id="updateInclMo" type="button" class="bt" onclick="updateMyPetInclRecode()" data-content="" data-url="/my/pet/insertMyPetInclRecodePage">수정</button></li>
											<li><button id="updateInclMo" type="button" class="bt" onclick="deleteMypetInclRecode();" data-content="" data-url="/my/pet/deleteMyPetInclRecode">삭제</button></li>
										</ul>
									</div>
								</nav>
							</div>
						</div>
					</div>
				</div>
			</header>
			<!-- // mobile header -->
		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container page lnb 1dep 2dep" id="container">
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
				<!-- 모바일 헤더 -->
				<!-- //모바일 헤더 -->
					<!-- PC 타이틀 모바일에서 제거  -->
					<c:if test ="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
					<div class="pc-tit">
						<h2>
						<c:if test ="${recode.inclGbCd ne frontConstants.INCL_GB_40 }">
							예방접종 정보
						</c:if>
						<c:if test ="${recode.inclGbCd eq frontConstants.INCL_GB_40 }">
							투약 정보
						</c:if>	
						</h2>
						<div class="right-item">
							<nav class="uidropmu">
								<button type="button" class="bt st" data-content="" data-url="">메뉴열기</button>
								<div class="list">
									<ul class="menu">
										<li><button id="updateIncl" type="button" class="bt" onclick="updateMyPetInclRecode()" data-content="" data-url="/my/pet/insertMyPetInclRecodePage">수정</button></li>
										<li><button id="deleteIncl" type="button" class="bt" onclick="deleteMypetInclRecode();" data-content="" data-url="/my/pet/deleteMyPetInclRecode">삭제</button></li>
									</ul>
								</div>
							</nav>
						</div>
					</div>
					</c:if>
					<!-- // PC 타이틀 모바일에서 제거  -->
					<!-- 접종 상세 기록 -->
					<c:if test ="${recode.inclGbCd ne frontConstants.INCL_GB_40 }">
					<div class="record-area">
						<c:if test="${not empty recode.imgPath }">
							<div class="pic"><img id ="petInclImg" class="img" src="${frame:optImagePath(recode.imgPath , frontConstants.IMG_OPT_QRY_370) }" onClick="addPopPic(this)"></div>
						</c:if>
						<c:if test="${empty recode.imgPath }">
							<div class="pic"><img id ="petInclImg" class="img" src="../../_images/common/img_default_thumbnail@2x.png" style="background-size:auto 100%;"></div>
						</c:if>
						<div class="record-list">
							<ul>
								<li>
									<strong class="tit">구분</strong>
									<p class="txt"><frame:codeValue items="${inclGbList }"  dtlCd="${recode.inclGbCd }"/></p>
								</li>
								<li>
									<strong class="tit">종류</strong>
									<p class="txt">${recode.inclNm }</p>
								</li>
								<c:if test = "${recode.itemNm ne null }">
									<li>
										<strong class="tit">추가접종</strong>
										<p class="txt">${recode.itemNm }</p>
									</li>
								</c:if>
								<li>
									<strong class="tit">접종일</strong>
									<p class="txt"><frame:date date="${recode.inclDt }" type="C"/></p>
								</li>
								<li>
									<strong class="tit">진료병원</strong>
									<p class="txt">${recode.trmtHsptNm }</p>
								</li>
								<li>
									<strong class="tit">다음 접종 알람</strong>
									<c:if test ="${recode.addInclDt ne null }">
										<p class="txt"><frame:date date="${recode.addInclDt }" type="C" /> 알람 예정</p>
									</c:if>
									<c:if test ="${recode.addInclDt eq null }">
										<p class="txt">미설정</p>
									</c:if>
								</li>
								<li>
									<strong class="tit">특이사항</strong>
									<p class="txt">${recode.memo }</p>
								</li>
							</ul>
						</div>
					</div>
					</c:if>
					<!--// 접종 상세 기록 -->
					<!-- 투약 기록 -->
					<c:if test ="${recode.inclGbCd eq frontConstants.INCL_GB_40 }">
					<div class="record-area t2">
						<div class="record-list">
							<ul>
								<li>
									<strong class="tit">구분</strong>
									<p class="txt">${recode.inclNm }</p>
								</li>
								<li>
									<strong class="tit">종류</strong>
									<p class="txt">${recode.itemNm }</p>
								</li>
								<li>
									<strong class="tit">접종일</strong>
									<p class="txt"><frame:date date="${recode.inclDt }" type="C"/></p>
								</li>
								<li>
									<strong class="tit">진료병원</strong>
									<p class="txt">${recode.trmtHsptNm }</p>
								</li>
								<li>
									<strong class="tit">특이사항</strong>
									<p class="txt">${recode.memo }</p>
								</li>
							</ul>
						</div>
					</div>
					</c:if>
					<!-- // 투약 기록 -->
				</div>
			</div>
		</main>
		
		<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
			<jsp:param name="floating" value="talk" />
		</jsp:include>
	</div>
	</tiles:putAttribute>
</tiles:insertDefinition>


