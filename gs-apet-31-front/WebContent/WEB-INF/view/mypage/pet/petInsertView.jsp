<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.include" value="script.member"/>
	<tiles:putAttribute name="script.inline">
		<jsp:include page="/WEB-INF/tiles/include/js/pet.jsp" />
		<script type="text/javascript" 	src="/_script/file.js"></script>
		<script type="text/javascript">
			var currStep = 1;
			var imageResult = null;
			
			/*$(window).on("popstate", function(event) {
				cancelInsert("popstate");
			});*/
			
			$(document).ready(function(){
				if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
					//Device 뒤로가기 버튼 기능을 웹에서 처리시 사용(Y:웹에서 백기능 처리, N:앱에서 처리)-호출 함수
					fncDeviceBackWebUse("fncGoBack");
				}
				
				init.insert();
				
				/*var flag = sessionStorage.getItem("petInsertSuccess");
				if(flag) {
					window.history.forward();
				}
				
				if(history.state != "petInsertView") {
					history.pushState("petInsertView", null, null);	
				}*/

				if("${returnUrl}" != "") {
					$("#returnUrl").val("${returnUrl}");
				}
				else {
					$("#returnUrl").val("/my/pet/myPetListView");
				}

				areaControl();
				btnControl();
				stepControl(currStep);
				allergyAreaControl();
				
				// adbrix 호출 추가 (앱)
				if ("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true") {
					onAdbrixCustomEventData.eventName = 'petInsert_click';
					toNativeAdbrix(onAdbrixCustomEventData);
				}
			});
			
			function areaControl() {
				$(".stepArea").each(function(){
					id = this.id;
					
					if(id.indexOf(currStep) > -1) {
						$(this).show();
					}
					else {
						$(this).hide();
					}
				})
			}
			
			function btnControl() {
				var flag = true;
				
				if(currStep == 1) {
					if(valid.isEmpty($("input:radio[name=petGbCd]:checked"))) {
						flag = false;
					}
					else {
						flag = true;
					}
				} else if(currStep == 2) {
					var imgPathObj = ("${view.deviceGb}" != "${frontConstants.DEVICE_GB_30}") ? $("#imgPath") : $("#imgPathApp");
					
					if(!valid.isEmpty(imgPathObj) && !valid.isEmpty($("#petNm")) && (!valid.isEmpty($("#age")) || !valid.isEmpty($("#month")) || valid.length($("#birth")) == 8)) {
						flag = true;
					} else { 
						flag = false;
					}
				} 

				// flag == true : 버튼 활성화
				// flag == false : 버튼 비활성화 
				if(flag) {
					$("#nextBtn" + currStep).addClass("a").removeClass("gray");
				}
				else {
					$("#nextBtn" + currStep).removeClass("a").addClass("gray").css("width", "100%");
				}
			}
			
			function stepControl(step) {
				$('html, body').scrollTop(0);
				
				if(step == 1) {
					
				} else if (step == 2) {
					if(valid.isEmpty($("input:radio[name=petGbCd]:checked"))) return;
					
					ageControl();
					
					var data = {};
					
					if($("input:radio[name=petGbCd]:checked").val() == '${frontConstants.PET_GB_10}') {
						data["petKindNm"] = "견종";
						data["petGbNm"] = "강아지";
					} else {			
						data["petKindNm"] = "묘종";
						data["petGbNm"] = "고양이";
					}					
					
					$("#petGbNmArea").html(data.petKindNm);
					$("#petGbNmSearchArea").html(data.petKindNm + " 검색");
					$("#petKindNm, #petKindNmSearch").attr("placeholder", data.petKindNm + "을 입력해주세요.");
					$("#spanPetGb").html(data.petGbNm);
				} else {
					if(valid.imgToast() == false) return;
					if(valid.reqiredToast() == false) return;
					
					$("#petNmArea").html($("#petNm").val());
				}
				
				currStep = step;

				areaControl();
				btnControl();
			}

			// 반려동물 프로필 사진
			function rsltImage(result) {
				if(valid.gifToast(result.fileExe) == false) return;
				
				$("#imagPathView").attr('src', '/common/imageView?filePath=' + result.filePath).css("height", "100%").css("width", "100%");
				$("#imgPath").val(result.filePath).change();
				$("#imagPathView").show();
			}
			
			function selectPetDaList() {
				var petGbCd = $("input:radio[name=petGbCd]:checked").val();
				
				var options = {
					url : "<spring:url value='/my/pet/selectPetDaList' />"
					, data : { petGbCd : petGbCd }
					, done : function(result) {
						var diseaseHtml = [];
						var allergyHtml = [];
						
						$.each(result.diseaseList, function(index, item) {
							diseaseHtml.push(
								"<button type='button' id='wryDaCd" + item.dtlCd +"' name='wryDaCd' value='" + item.dtlCd + "' data-content='' data-url=''>",
									item.dtlNm,
								"</button>"
							)
						})
						
						$.each(result.allergyList, function(index, item) {
							allergyHtml.push(
								"<button type='button' id='allergyCd" + item.dtlCd +"' name='allergyCd' value='" + item.dtlCd + "' data-content='' data-url=''>",
									item.dtlNm,
								"</button>"
							)
						})
						
						$("#diseaseArea").html(diseaseHtml.join(""));
						$("#allergyArea").html(allergyHtml.join(""));
						
						ui.toggleClassOn.init();
					}
				}
				ajax.call(options);
			}
			
			function petInsert() {
				setWryDaCds();
				setAllergyCds();
				
				petInsertAction();
			}
			
			function petInsertAction() {
				var options = {
					url : "<spring:url value='/my/pet/petInsert' />"
					, data : $("#petInsertForm").serialize()
					, done : function(result) {
						if(result.resultCode == '${frontConstants.CONTROLLER_RESULT_CODE_SUCCESS}') {
							if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
								toNativeData.func = 'onLogin';
								toNative(toNativeData);
								onAdbrixCustomEventData.eventName = 'character_created';
								toNativeAdbrix(onAdbrixCustomEventData);
							}
							fncTagInfoLogApi({ url:"/my/pet/petInsertView", targetUrl:"/my/pet/petInsertSuccess",callback:console.log(result) });
							$("#petNo").val(result.petNo);
							if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_30}") {
								//location.href = "/my/pet/petInsertSuccess?petNo=" + $("#petNo").val() + "&returnUrl=" + $("#returnUrl").val();
								//location.replace("/my/pet/petInsertSuccess?petNo=" + $("#petNo").val() + "&returnUrl=" + $("#returnUrl").val());
								storageHist.goBack("/my/pet/petInsertSuccess?petNo=" + $("#petNo").val() + "&returnUrl=" + $("#returnUrl").val());
							} else {
								onFileUpload();
							}	
						}
					}
				}
				ajax.call(options);
			}
			
			//function cancelInsert(type) {
			function fncGoBack() {
				var options = {
					txt : "마이펫 등록을 취소할까요?"
					, ycb : function() {
						/*if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_30}") {
							if(type == "popstate")	historygo = -1;	
							else					historygo = -2;

							history.go(historygo);
							window.setTimeout(function(){location.replace($("#returnUrl").val());}, 300);
						} else {
							location.href = $("#returnUrl").val();
						}	
						
						var lastUrl = $("#returnUrl").val();
						if(lastUrl){
							storageHist.goBack(lastUrl);
						}else{
							storageHist.goBack();
						}*/
						
						//storageHist.goBack("/my/pet/myPetListView");
						storageHist.getOut("${requestScope['javax.servlet.forward.servlet_path']}");
					}
					, ncb : function() {
						//if(type == "popstate") history.pushState("petInsertView", null, null);
					} 
					, ybt : "예"
					, nbt : "아니요"
				}
				messager.confirm(options);
			}
			
			
			/*********************************************************************************/
			/******* APP 인터페이스 *************************************************************/
			/*********************************************************************************/
			// 사진 선택시
		    function onOpenGalleryCallback(result) {
				imageResult = JSON.parse(result);
				
				$("#imagPathView").attr("src", imageResult.imageToBase64);
				$("#imgPathApp").val(imageResult.mediaType).change();
				$("#imagPathView").show();
		    }
			
			function onFileUploadCallBack(result) {
				var file = JSON.parse(result);
				
				var options = {
					url : "<spring:url value='/my/pet/appPetImageUpdate' />"
					, data : { petNo : $("#petNo").val(), imgPath : file.images[0].filePath }
					, done : function(result) {
						//location.href = "/my/pet/petInsertSuccess?petNo=" + $("#petNo").val() + "&returnUrl=" + $("#returnUrl").val();
						//location.replace("/my/pet/petInsertSuccess?petNo=" + $("#petNo").val() + "&returnUrl=" + $("#returnUrl").val());
						storageHist.goBack("/my/pet/petInsertSuccess?petNo=" + $("#petNo").val() + "&returnUrl=" + $("#returnUrl").val());
					}
				}
				ajax.call(options);
			}
			
			$(document).on("click", ".header>.hdr .mo-header-backNtn", function(e){
				e.preventDefault();
			});
		</script>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<body>
		
			<form id="petInsertForm" name="petInsertForm">
				<input type="hidden" id="petNo" name="petNo" />
				<input type="hidden" id="mbrNo" name="mbrNo" value="${session.mbrNo }" />
				<input type="hidden" id="returnUrl" name="returnUrl" />
				<input type="hidden" id="wryDaCds" name="wryDaCds" />
				<input type="hidden" id="allergyCds" name="allergyCds" />
				
				
				<main class="container page my" id="container">
					<!-- mobile -->
					<%-- <div class="pageHead heightNone">
						<div class="inr">
							<div class="hdt">
								<button class="back" type="button" onclick="cancelInsert();" data-content="${session.mbrNo }" data-url="cancelInsert();">뒤로가기</button>
							</div>
							<div class="cent t2"><h2 class="subtit">마이펫 등록</h2></div>
						</div>
					</div> --%>
					<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
						<div class="header pc cu mode7-1 noneAc" data-header="set16" style="height: 0px;">
							<div class="hdr">
								<div class="inr">
									<div class="hdt">
										<button class="mo-header-backNtn" onclick="fncGoBack(); return false;" data-content="${session.mbrNo }" data-url="fncGoBack()">뒤로</button>
										<div class="mo-heade-tit"><span class="tit">마이펫 등록</span></div>
										<button class="mo-header-close"></button>
									</div>
								</div>
							</div>
						</div>
					</c:if>
					<div id="step1" class="stepArea">
						<!-- // mobile -->
						<div class="inr">
							<!-- 본문 -->
							<div class="contents" id="contents" <c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">style="height: 90vh;"</c:if>>
							<%--<jsp:include page="/WEB-INF/view/mypage/pet/petInsertHiddenData.jsp" />--%>
		
								<!-- 마이펫 등록  -->
								<div class="pet-wrap">
									<!-- PC 타이틀 모바일에서 제거  -->
									<div class="pc-tit">
										<h2>마이펫 등록</h2>
									</div>
									<!-- // PC 타이틀 모바일에서 제거  -->
									<!-- 진행율  -->
									<div class="step-bar">
										<span style="width: 33%">진행율</span>
									</div>
									<!-- // 진행율  -->
									<div class="step-area">
										<p class="tit">어떤 <span>반려동물</span>과 함께하시나요?</p>
										<div class="step">
											<div class="choice">
												<ul>
													<li><label class="radio"><input type="radio" class="required_item" name="petGbCd" value="${frontConstants.PET_GB_10}"><span class="txt">강아지</span></label></li>
													<li><label class="radio"><input type="radio" class="required_item" name="petGbCd" value="${frontConstants.PET_GB_20}"><span class="txt">고양이</span></label></li>
												</ul>
											</div>
										</div>
										<div class="btnSet pull">
											<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
												<a href="#" onclick="fncGoBack(); return false;" class="btn lg d" data-content="${session.mbrNo }" data-url="fncGoBack()">취소</a>
											</c:if>
											<a href="#" id="nextBtn1" onclick="stepControl(2);return false;" class="btn lg a" data-content="" data-url="">다음</a>
										</div>
										<!-- // 마이펫 등록  -->
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div id="step2" class="stepArea">
						<!-- mobile -->
						<%-- <div class="pageHead heightNone">
							<div class="inr">
								<div class="hdt">
									<button class="back" type="button" onclick="confirm('반려동물 등록을 취소 하시겠습니까?', 'goMyPetListView');" data-content="${session.mbrNo }" data-url="/my/pet/myPetListView">뒤로가기</button>
								</div>
								<div class="cent t2"><h2 class="subtit">마이펫 등록</h2></div>
							</div>
						</div> --%>
						<!-- // mobile -->
						<div class="inr">
							<!-- 본문 -->
							<div class="contents" id="contents">
							<%--<jsp:include page="/WEB-INF/view/mypage/pet/petInsertHiddenData.jsp" />--%>
							
								<!-- 마이펫 등록  -->
								<div class="pet-wrap">
									<!-- PC 타이틀 모바일에서 제거  -->
									<div class="pc-tit">
										<h2>마이펫 등록</h2>
									</div>
									<!-- // PC 타이틀 모바일에서 제거  -->
									<!-- 진행율  -->
									<div class="step-bar">
										<span style="width: 66%">진행율</span>
									</div>
									<!-- // 진행율  -->
									<div class="step-area mt10"><!-- 2021.04.09 클래스 추가 mt10 -->
										
										<p class="tit"> <span id="spanPetGb"></span> 프로필을 채워주세요</p>
										<!-- 프로필 사진 -->
										
											<div class="my-picture medium2 animal mt40"><!-- 2021.04.09 클래스 추가 mt40 : medium2 클래스 변경 -->
												<p class="picture">
													<img id="imagPathView" src="" onerror="this.style.display='none'">
													<input type="hidden" id="imgPath" name="imgPath" class="required_item" />
													<input type="hidden" id="imgPathApp" name="imgPathApp" class="required_item" />
												</p>
												<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_30 }">
													<button type="button" class="btn edit" onclick="fileUpload.image(rsltImage);" data-content="" data-url=""></button>
												</c:if>
												<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_30 }">
													<button type="button" class="btn edit" onClick="onOpenGallery();" data-content="" data-url=""></button>
												</c:if>
											</div>
										<!-- // 프로필 사진 -->
										<!-- 정보 입력 -->
										<div class="member-input mt40"><!-- 2021.04.09 클래스 추가 mt40 -->
											<ul class="list">
												<li>
													<strong id="petGbNmArea" class="tit"></strong>
													<p class="info">필수 입력 정보</p>
													<div class="input del">
														<input type="text" id="petKindNm" name="petKindNm" autocomplete="off">
													</div>
												</li>
												<li>
													<strong class="tit requied">이름</strong>
													<div class="input del">
														<input type="text" id="petNm" name="petNm" class="required_item" placeholder="이름을 입력해주세요.">
													</div>
												</li>
												<li>
													<strong class="tit mb10">성별</strong>
													<div class="flex-wrap">
														<c:forEach items="${petGdGbCdList }" var="item">
															<label class="radio"><input type="radio" name="petGdGbCd" value="${item.dtlCd }"><span class="txt">${item.dtlNm }</span></label>
														</c:forEach>
													</div>
												</li>
												<li>
													<strong class="tit requied mt11 mb10">나이</strong>
													<div class="flex-wrap">
														<label class="radio"><input type="radio" name="ageChoose" class="required_item" value="1" checked><span class="txt">개월 수 입력</span></label>
														<label class="radio"><input type="radio" name="ageChoose" class="required_item" value="2"><span class="txt">생년월일 입력</span></label>
													</div>
													<!-- PC 셀렉트 -->
													<%-- <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
														<div id="divAgePcArea">
															<div class="pc-wrap">
																<div class="select">
																	<select id="age" name="age" class="required_item" > 
																		<option value="" selected>0세</option>
																		<c:forEach var="i" begin="1" end="99" step="1" >
																			<option value="${i}">${i}세</option>
																		</c:forEach>
																	</select>
																</div>
																<div class="select">
																	<select id="month" name="month" class="required_item" > 
																		<option value="" selected>0개월</option>
																		<c:forEach var="i" begin="1" end="12" step="1" >
																			<option value="${i}">${i}개월</option>
																		</c:forEach>
																	</select>
																</div>
															</div>
														</div>
														<div id="divBirthPcArea">
															<div class="input del">
																<input type="number" id="birth" name="birth" class="required_item" style="margin-top:20px;" maxlength="8" placeholder="숫자 8자리 입력 (YYYYMMDD)">
															</div>
														</div>
													</c:if> --%>
													<!-- // PC 셀렉트 -->
													<!-- 모바일 인풋 -->
													<%-- <c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
														<div id="divAgeMtArea">
															<div class="mo-wrap">
																<div class="input del">
																	<input type="number" id="age" name="age" class="required_item" placeholder="0 세">
																</div>
																<div class="input del">
																	<input type="number" id="month" name="month" class="required_item" placeholder="0 개월">
																</div>
															</div>
														</div>
														<div id="divBirthMtArea">
															<div class="input del">
																<input type="number" id="birth" name="birth" class="required_item" style="margin-top:10px;" maxlength="8" placeholder="숫자 8자리 입력 (YYYYMMDD)">
															</div>
														</div>
													</c:if> --%>
													<!-- 모바일 인풋 -->
													<div id="divAgeArea">
														<div class="flex-wrap">
															<div class="input del t2" data-txt="세">
																<input type="number" id="age" name="age" class="required_item" maxlength="2" placeholder="0">
															</div>
															<div class="input del t2" data-txt="개월">
																<input type="number" id="month" name="month" class="required_item" maxlength="2" placeholder="0">
															</div>
														</div>
													</div>
													<div id="divBirthArea">
														<div class="input del">
															<input type="number" id="birth" name="birth" class="required_item" style="margin-top:10px;" maxlength="8" placeholder="숫자 8자리 입력 (예: 20210101)">
														</div>
													</div>
													<div id="errorTextArea" style="color: red;display: none;">
													</div>
												</li>
			
												<li>
													<strong class="tit">몸무게</strong>
													<div class="input del t2" data-txt="kg">
														<input type="number" id="weight" name="weight" class="moveStop" placeholder="소수점 한자리 까지 입력 가능">
													</div>
												</li>
											</ul>
										</div>
										<!-- // 정보 입력 -->
										<div class="btnSet pull">
											<a href="#" onclick="stepControl(1);return false;" class="btn lg d" data-content="" data-url="">이전</a>
											<a href="#" id="nextBtn2" onclick="stepControl(3);return false;" class="btn lg a" data-content="" data-url="">다음</a>
										</div>
									</div>
								</div>
							</div>
						</div>
						
						<article class="popLayer a popSample1" id="popSample1">
							<div class="pbd pop-search">
								<div class="log_hanBoxTop">
									<a href="#" onclick="ui.popLayer.close('popSample1');return false;" class="lhbt_btn l icon_al b" data-content="" data-url=""></a>
									<div id="petGbNmSearchArea" class="tit"></div>
									<button onclick="ui.popLayer.close('popSample1');return false;" type="button" class="btnPopClose" data-content="" data-url="">닫기</button>
								</div>
								<div class="pct">
									<main class="poptents">
										<!-- input -->
										<div class="log_topBbox newDn "><!-- 04.08 newDn 클래스 추가  -->
											<div class="input del t2"><!-- 04.08 data-txt="검색" 제거  -->
												<input type="text" id="petKindNmSearch" name="petKindNmSearch" class="moveStop" autocomplete="off" />
											</div>
										</div>	
										<!-- 검색 결과 없을 시 -->
										<div id="petKindNoSearchArea" class="petKindNoSearchArea_box" style="display:none;">
											<section class="no_data i1 auto_h">
												<div class="inr">
													<div id="petKindNoSearchTextArea" class="msg"></div>
												</div>
											</section>
										</div>
										<div id="petKindSearchListArea" class="log_pointEnterList newDn" style="display:none;"><!-- 04.08 newDn 클래스 추가  -->
											<ul id="petKindSearchList">
											</ul>
										</div>
									</main>
								</div>
								<!-- 하단 고정 버튼 있을때 쓰세요
								<div class="pbt">
									<div class="bts">
										<button type="button" class="btn xl d" onclick="ui.popLayer.close('popSample1');">취소</button>
										<button type="button" class="btn xl a">등록</button>
									</div>
								</div>
								-->
							</div>
						</article>
					</div>
					
					<div id="step3" class="stepArea">
						<!-- mobile -->
						<!-- <div class="pageHead heightNone">
							<div class="inr">
								<div class="hdt">
									<button class="back" type="button" onclick="confirm('반려동물 등록을 취소 하시겠습니까?', 'goMyPetListView');" data-content="" data-url="/my/pet/myPetListView">뒤로가기</button>
								</div>
								<div class="cent t2"><h2 class="subtit">마이펫 등록</h2></div>
							</div>
						</div> -->
						<!-- // mobile -->
						<div class="inr">
							<!-- 본문 -->
							<div class="contents" id="contents">
							<%--<jsp:include page="/WEB-INF/view/mypage/pet/petInsertHiddenData.jsp" />--%>
							
								<!-- 마이펫 등록  -->
								<div class="pet-wrap">
									<!-- PC 타이틀 모바일에서 제거  -->
									<div class="pc-tit">
										<h2>마이펫 등록</h2>
									</div>
									<!-- // PC 타이틀 모바일에서 제거  -->
									<!-- 진행율  -->
									<div class="step-bar">
										<span style="width: 100%">진행율</span>
									</div>
									<!-- // 진행율  -->
									<div class="step-area">
										
										<p class="tit">
											마지막이에요!<br>
											<span id="petNmArea"></span>에 대해 조금 더 알려주시겠어요?
										</p>
										<p class="sut-txt">
											추가정보를 등록하시면 다양한 맞춤 추천을 받을 수 있어요.
										</p>
									
										<!-- 정보 입력 -->
										<div class="member-input t2">
											<ul class="list">
												<li>
													<strong class="tit">중성화 여부</strong>
													<div class="radiobox">
														<span class="radio"><input type="radio" name="fixingYn" id="fixingYnN" value="N" ><label for="radt_1" class="txt">중성화 전</label></span>
														<span class="radio"><input type="radio" name="fixingYn" id="fixingYnY" value="Y" ><label for="radt_2" class="txt">중성화 완료</label></span>
													</div>
												</li>
												<li>
													<strong class="tit newDn">염려질환
														<span>중복선택 가능</span>
													</strong>
													<div class="filter-item">
														<div id="diseaseArea" class="tag">
															<%-- <c:forEach items="${diseaseList }" var="wryDa" varStatus="status">
																<button type="button" id="wryDaCd${wryDa.dtlCd }" name="wayDaCd" value="${wryDa.dtlCd }">
																	${wryDa.dtlNm } 
																</button>
															</c:forEach> --%>
														</div>
													</div>
												</li>
												<li>
													<strong class="tit">알러지여부</strong>
													<div class="radiobox">
														<span class="radio"><input type="radio" name="allergyYn" id="allergyYnY" value="Y" ><label for="radt_1" class="txt">있어요</label></span>
														<span class="radio"><input type="radio" name="allergyYn" id="allergyYnN" value="N" ><label for="radt_2" class="txt">없어요</label></span>
													</div>
													<div id="allergyChkArea">
														<div class="filter-item">
															<div id="allergyArea" class="tag">
																<%-- <c:forEach items="${allergyList }" var="allergy" varStatus="status">
																	<button type="button" id="allergyCd${allergy.dtlCd }" name="allergyCd" value="${allergy.dtlCd }">
																		${allergy.dtlNm } 
																	</button>
																</c:forEach> --%>
															</div>
														</div>
													</div>
												</li>
											</ul>
										</div>
										<!-- // 정보 입력 -->
										<div class="btnSet">
											<a href="#" onclick="stepControl(2);return false;" class="btn lg d" data-content="" data-url="">이전</a>
											<a href="#" onclick="petInsert();return false;" class="btn lg a" data-content="" data-url="petInsert();">완료</a>
										</div>
									</div>
								</div>
								<!-- // 마이펫 등록  -->
							</div>
						</div>
					</div>
				</main>
			</form>
			<%-- <c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_30}">
				<jsp:include  page="/WEB-INF/tiles/include/footer.jsp" />
			</c:if> --%>
		</body>
	</tiles:putAttribute>
</tiles:insertDefinition>