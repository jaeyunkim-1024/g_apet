<tiles:insertDefinition name="mypage">
	<tiles:putAttribute name="script.include" value="script.member"/>
	<tiles:putAttribute name="script.inline">
		<jsp:include page="/WEB-INF/tiles/include/js/pet.jsp" />
		<script type="text/javascript" 	src="/_script/file.js"></script>
		<script type="text/javascript">
			var imageResult = null;
			
			$(document).ready(function(){
				if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
					//Device 뒤로가기 버튼 기능을 웹에서 처리시 사용(Y:웹에서 백기능 처리, N:앱에서 처리)-호출 함수
					fncDeviceBackWebUse("fncGoBack");
				}
				
				init.update();
				
				btnControl();
				ageControl();
				allergyAreaControl();
				
				storageHist.replaceHist();
			})

			function btnControl() {
				var imgPathTempObj = ("${view.deviceGb}" != "${frontConstants.DEVICE_GB_30}") ? $("#imgPathTemp") : $("#imgPathAppTemp");
				
				if(!valid.isEmpty($("#petNm")) && (!valid.isEmpty($("#imgPath")) || !valid.isEmpty(imgPathTempObj)) && (!valid.isEmpty($("#age")) || !valid.isEmpty($("#month")) || valid.length($("#birth")) == 8)) {
					$("#saveButton").addClass("a").removeClass("gray");
				} else { 
					$("#saveButton").removeClass("a").addClass("gray").css("width", "100%");
				}
			}
			
			// 반려동물 프로필 사진
			function rsltImage(result) {
				if(valid.gifToast(result.fileExe) == false) return;
				
				$("#imagPathView").attr('src', '/common/imageView?filePath=' + result.filePath);
				$("#imgPathTemp").val(result.filePath).change();
			}
			
			function fncGoBack() {
				var options = {
					txt : "펫 정보 수정을 취소할까요?"
					, ycb : function() {
						var form = $("<form></form>");
						form.attr("name" , "petDeatilForm");
						form.attr("method" , "post");
						form.attr("action" , "/my/pet/myPetView");
						form.append($("<input/>", {type: 'hidden', name:'petNo', value:'${vo.petNo}' }));
						
						form.appendTo("body");
						form.submit();
					}
					, ybt : "예"
					, nbt : "아니요"
				}
				messager.confirm(options);
			}

			function petUpdate() {
				if(valid.imgToast() == false) return;
				if(valid.reqiredToast() == false) return;
				
				setAllergyCds();
				setWryDaCds();
					
				if(!valid.isEmpty($("#imgPathAppTemp")) && "${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}") {					
					onFileUpload();
				} else {
					petUpdateAction();
				}
				
			}
			
			function petUpdateAction() {
				var options = {
					url : "<spring:url value='/my/pet/petUpdate' />"
					, data : $("#petUpdateForm").serialize()
					, done : function(result) {
						if(result == "${frontConstants.CONTROLLER_RESULT_CODE_SUCCESS }") {
							fncTagInfoLogApi({ url:"/my/pet/petUpdateView", targetUrl:"/my/pet/myPetView",callback:console.log(result) });
							
							var form = $("<form></form>");
							form.attr("name" , "petDeatilForm");
							form.attr("method" , "post");
							form.attr("action" , "/my/pet/myPetView");
							form.append($("<input/>", {type: 'hidden', name:'petNo', value:'${vo.petNo}' }));
							
							form.appendTo("body");
							form.submit();
					
						}
					}
				}
				ajax.call(options);	
			}
			
			/*********************************************************************************/
			/******* APP 인터페이스 *************************************************************/
			/*********************************************************************************/
			// 사진 선택시
		    function onOpenGalleryCallback(result) {
				imageResult = JSON.parse(result);
				
				$("#imagPathView").attr("src", imageResult.imageToBase64);
				$("#imgPathAppTemp").val(imageResult.mediaType).change();	
		    }
			
			function onFileUploadCallBack(result) {
				var file = JSON.parse(result);
				$("#imgPathTemp").val(file.images[0].filePath);
				
				petUpdateAction();
			}
		</script>
	</tiles:putAttribute>		
	
	<tiles:putAttribute name="content">
		<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
			<div class="header pc cu mode7-1 noneAc" data-header="set16" style="height: 0px;">
				<div class="hdr">
					<div class="inr">
						<div class="hdt">
							<!-- mobile -->
							<button class="mo-header-btnType02">취소</button><!-- on 클래스 추가 시 활성화 -->
							<!-- // mobile -->
							<!-- mobile -->
							<button class="mo-header-backNtn" onclick="fncGoBack();" data-content="" data-url="fncGoBack()">뒤로</button>
							<div class="mo-heade-tit">마이펫 정보 수정</div>
							<button class="mo-header-close"></button>
							<!-- // mobile -->
						</div>
					</div>
				</div>
			</div>
		</c:if>
		
		<main class="container lnb page my" id="container">
			<!-- 페이지 헤더 -->
			
			<!-- // 페이지 헤더 -->
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<form id="petUpdateForm" name="petUpdateForm">
					
						<input type="hidden" id="mbrNo" name="mbrNo" value="${vo.mbrNo }" />
						<input type="hidden" id="petNo" name="petNo" value="${vo.petNo }" />
						<input type="hidden" id="allergyCds" name="allergyCds" />
						<input type="hidden" id="wryDaCds" name="wryDaCds" />
						
						<div class="mypet-admin">
							<!-- PC 타이틀 모바일에서 제거 -->
							<div class="pc-tit">
								<h2>마이펫 정보 수정</h2>
							</div>
							<!-- // PC 타이틀 모바일에서 제거 -->
							<div class="mypet-profile">
								<div>
									<div class="img-box">
										<div>
											<div class="my-picture medium2 animal">
												<p class="picture"><img id="imagPathView" src="${frame:imagePath(vo.imgPath) }" alt="" style="height: 100%;width: 100%;"></p>
												<input type="hidden" id="imgPath" name="imgPath" class="required_item" value="${vo.imgPath }"  />
												<input type="hidden" id="imgPathTemp" name="imgPathTemp" />
												<input type="hidden" id="imgPathAppTemp" name="imgPathAppTemp" />
												<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_30 }">
													<button type="button" class="btn edit" onclick="fileUpload.image(rsltImage);" data-content="" data-url=""></button>
												</c:if>
												<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_30 }">
													<button type="button" class="btn edit" onClick="onOpenGallery();" data-content="" data-url=""></button>
												</c:if>
											</div>
										</div>
									</div>
									<div class="t-box">
										<div class="item">
											<!-- 정보 입력 -->
											<div class="member-input">
												<ul class="list">
													<li>
														<strong class="tit">
															<c:if test="${vo.petGbCd eq frontConstants.PET_GB_10 }">견종</c:if>
															<c:if test="${vo.petGbCd eq frontConstants.PET_GB_20 }">묘종</c:if>
														</strong>
														<p class="info">필수 입력 정보</p>
														<div class="input del">
															<input type="text" id="petKindNm" name="petKindNm" value="${vo.petKindNm }" placeholder="${vo.petGbCd eq frontConstants.PET_GB_10 ? '견종을 입력해주세요.' : '묘종을 입력해주세요.' }" autocomplete="off">														
														</div>
													</li>
													<li>
														<strong class="tit requied">이름</strong>
														<div class="input del">
															<input type="text" id="petNm" name="petNm" class="required_item" value="${vo.petNm }" placeholder="이름을 입력해주세요.">
														</div>
													</li>
													<li>
														<strong class="tit">성별</strong>
														<div class="flex-wrap">
															<c:forEach items="${petGdGbCdList }" var="item">
																<label class="radio"><input type="radio" id="petGdGbCd${item.dtlCd }" name="petGdGbCd" value="${item.dtlCd }" <c:if test="${vo.petGdGbCd eq item.dtlCd }">checked="checked"</c:if>><span class="txt">${item.dtlNm }</span></label>
															</c:forEach>
														</div>
													</li>
													<li>
														<strong class="tit requied">나이</strong>
														<div class="flex-wrap">
															<label class="radio"><input type="radio" name="ageChoose" class="required_item" value="1" <c:if test="${vo.ageChoose eq '1' }">checked="checked"</c:if>><span class="txt">개월 수 입력</span></label>
															<label class="radio"><input type="radio" name="ageChoose" class="required_item" value="2" <c:if test="${vo.ageChoose eq '2' }">checked="checked"</c:if>><span class="txt">생년월일 입력</span></label>
														</div>
														<!-- PC 셀렉트 -->
														<%-- <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
															<div id="divAgePcArea">
																<div class="pc-wrap">
																	<div class="select">
																		<select id="age" name="age" class="required_item"> 
																			<option value="" selected>0세</option>
																			<c:forEach var="i" begin="1" end="99" step="1" >
																				<option value="${i}" <c:if test="${i == vo.age}">selected</c:if> >${i}세</option>
																			</c:forEach>
																		</select>
																	</div>
																	<div class="select">
																		<select id="month" name="month" class="required_item"> 
																			<option value="" selected>0개월</option>
																			<c:forEach var="i" begin="1" end="12" step="1" >
																				<option value="${i}" <c:if test="${i == vo.month}">selected</c:if> >${i}개월</option>
																			</c:forEach>
																		</select>
																	</div>
																</div>
															</div>
															<div id="divBirthPcArea">
																<div class="input del">
																	<input type="text" id="birth" name="birth" class="required_item" value="${vo.birth }" style="margin-top:10px;" maxlength="8" placeholder="숫자 8자리 입력 (YYYYMMDD)">
																</div>
															</div>
														</c:if> --%>
														<!-- // PC 셀렉트 -->
														<!-- 모바일 인풋 -->
														<%-- <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_20 }">
															<div id="divAgeMtArea">
																<div class="mo-wrap">
																	<div class="input del">
																		<input type="number" id="age" name="age" class="required_item" value="${vo.age }" placeholder="0 세">
																	</div>
																	<div class="input del">
																		<input type="number" id="month" name="month" class="required_item" value="${vo.month }" placeholder="0 개월">
																	</div>
																</div>
															</div>
															<div id="divBirthMtArea">
																<div class="input del">
																	<input type="number" id="birth" name="birth" class="required_item" value="${vo.birth }" style="margin-top:10px;" maxlength="8" placeholder="숫자 8자리 입력 (YYYYMMDD)">
																</div>
															</div>
														</c:if> --%>
														<!-- 모바일 인풋 -->
														<div id="divAgeArea">
															<div class="flex-wrap wrap">
																<div class="input del t2" data-txt="세">
																	<input type="number" id="age" name="age" placeholder="0" class="required_item" value="${vo.age }" maxlength="2">
																</div>
																<div class="input del t2" data-txt="개월">
																	<input type="number" id="month" name="month" placeholder="0" class="required_item" value="${vo.month }" maxlength="2">
																</div>
															</div>
														</div>
														<div id="divBirthArea">
															<div class="input del">
																<input type="number" id="birth" name="birth" class="required_item" value="${vo.birth }" style="margin-top:10px;" maxlength="8" placeholder="숫자 8자리 입력 (예: 20210101)">
															</div>
														</div>
														<div id="errorTextArea" style="color: red;display: none;">
														</div>
													</li>
													<li>
														<strong class="tit">몸무게</strong>
														<div class="input del t2" data-txt="kg">
															<input type="number" id="weight" name="weight" value="${vo.weight }" class="moveStop" placeholder="소수점 한자리까지 입력 가능">
														</div>
													</li>
												</ul>
											</div>
											<!-- // 정보 입력 -->
										</div>
										<div class="item t2">
											<p class="tit">건강 정보</p>
											<!-- 정보 입력 -->
											<div class="member-input t2">
												<ul class="list">
													<li>
														<strong class="tit">중성화 여부</strong>
														<div class="radiobox">
															<span class="radio"><input type="radio" name="fixingYn" id="fixingYnN" value="N" <c:if test="${vo.fixingYn eq frontConstants.USE_YN_N }">checked="checked"</c:if>><label for="radt_1" class="txt">중성화 전</label></span>
															<span class="radio"><input type="radio" name="fixingYn" id="fixingYnY" value="Y" <c:if test="${vo.fixingYn eq frontConstants.USE_YN_Y }">checked="checked"</c:if>><label for="radt_2" class="txt">중성화 완료</label></span>
														</div>
													</li>
													<li>
														<strong class="tit newDn">염려질환
															<span>중복 선택 가능</span>
														</strong>
														<div class="filter-item">
															<div class="tag">
																<c:forEach items="${diseaseList }" var="wryDa" varStatus="status">
																	<button id="wryDaCd${wryDa.dtlCd }" name="wryDaCd" value="${wryDa.dtlCd }"
																		<c:forEach items="${daVo }" var="wryDaCd"> 
																			<c:if test="${wryDaCd.daGbCd eq frontConstants.DA_GB_10 and wryDaCd.daCd eq wryDa.dtlCd }">
																				class="active"
																			</c:if>
																		 </c:forEach>>
																		${wryDa.dtlNm } 
																	</button>
																</c:forEach>
															</div>
														</div>
													</li>
													<li>
														<strong class="tit">알러지여부</strong>
														<div class="radiobox">
															<span class="radio"><input type="radio" name="allergyYn" id="allergyYnY" value="Y" <c:if test="${vo.allergyYn eq frontConstants.USE_YN_Y }">checked="checked"</c:if>><label for="radt_1" class="txt">있어요</label></span>
															<span class="radio"><input type="radio" name="allergyYn" id="allergyYnN" value="N" <c:if test="${vo.allergyYn eq frontConstants.USE_YN_N }">checked="checked"</c:if>><label for="radt_2" class="txt">없어요</label></span>
														</div>
														<div id="allergyChkArea">
															<div class="filter-item">
																<div id="allergyArea" class="tag">
																	<c:forEach items="${allergyList }" var="allergy" varStatus="status">
																		<button id="allergyCd${allergy.dtlCd }" name="allergyCd" value="${allergy.dtlCd }"
																			<c:forEach items="${daVo }" var="allergyCd"> 
																				<c:if test="${allergyCd.daGbCd eq frontConstants.DA_GB_20 and allergyCd.daCd eq allergy.dtlCd }">
																					class="active"
																				</c:if>
																			 </c:forEach>>
																			${allergy.dtlNm } 
																		</button>
																	</c:forEach>
																</div>
															</div>
														</div>
													</li>
												</ul>
											</div>
											<!-- // 정보 입력 -->
										</div>
									</div>
								</div>
								<div class="btnSet set2 pull">
									<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
										<a id="cancleButton" href="#" onclick="fncGoBack(); return false;" class="btn lg " data-content="" data-url="fncGoBack()">취소</a>
									</c:if>
									<a id="saveButton" href="#" onclick="petUpdate(); return false;" class="btn lg a" data-content="" data-url="petUpdate()">저장</a>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
			
			<article class="popLayer a popSample1" id="popSample1">
				<div class="pbd pop-search">
					<div class="log_hanBoxTop">
						<a href="#" onclick="ui.popLayer.close('popSample1');return false;" class="lhbt_btn l icon_al b" data-content="" data-url=""></a>
						<div class="tit">
							<c:if test="${vo.petGbCd eq frontConstants.PET_GB_10 }">견종 검색</c:if>
							<c:if test="${vo.petGbCd eq frontConstants.PET_GB_20 }">묘종 검색</c:if>	
						</div>
						<button onclick="ui.popLayer.close('popSample1');return false;" type="button" class="btnPopClose">닫기</button>
					</div>
					<div class="pct">
						<main class="poptents">
							<!-- input -->
							<div class="log_topBbox newDn "><!-- 04.08 newDn 클래스 추가  -->
								<div class="input del t2"><!-- 04.08 data-txt="검색" 제거  -->
									<input type="text" id="petKindNmSearch" name="petKindNmSearch" class="moveStop" autocomplete="off" 
										<c:if test="${vo.petGbCd eq frontConstants.PET_GB_10 }">placeholder="견종을 입력해주세요."</c:if>
										<c:if test="${vo.petGbCd eq frontConstants.PET_GB_20 }">placeholder="묘종을 입력해주세요."</c:if>>
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
							<div id="petKindSearchListArea" class="log_pointEnterList newDn" style="display:none;">
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
		</main>		
	</tiles:putAttribute>
</tiles:insertDefinition>
