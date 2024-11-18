<tiles:insertDefinition name="common">
<tiles:putAttribute name="script.include" value="script.member"/>
<tiles:putAttribute name="script.inline">
<style>
.inputInfoTxt{
	cursor : pointer;
}
.menubar{ display: none;}
</style>
<script type="text/javascript" src="/_script/file.js"></script>
<script type="text/javascript">
	var imageResult = null;

	$(document).ready(function(){
		//$(".validation-check").hide();
		
		if("${view.deviceGb}" != "PC"){
			$(".mode0").remove();
			$("#footer").remove();
		}else{
			$(".mode7").remove();
		}
		
		//window.history.forward();
		
		//엔터 작동 막기
		$("#join_form").keypress(function(e) {
			if ( window.event.keyCode == 13 ) {
				e.preventDefault();
			}
		});
		
		$("[name=gdGbCd]:checked").change();
		
		$("#profileAdd").click(function(e){
			e.preventDefault();
			if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
				onOpenGallery();
			}else{
				//alert("11 : ${view.deviceGb}");
				fileUpload.image(resultImage);
			}
		});
		
		//푸쉬토큰 app interface 호출 
		if('${view.deviceGb}' == 'APP'){
			//alert("푸쉬토큰요청");
			toNativeData.func = 'onPushToken';
			toNativeData.callback= 'appPushToken';
			// 호출
			toNative(toNativeData); 
		}
		
		inputChk();
	}); // End Ready
	
	//App 푸쉬토큰 콜백
	function appPushToken(data){
		var dataJson = JSON.parse(data);
		$("#appPushToken").val(dataJson.token);
	}
	
	/* 필수입력칸 입력여부 체크 - 버튼 활성화 */
	$(document).on("input paste change",".required_join_input",function()  {
		inputChk();
	});
	
	$(document).on("input change paste","[name='birth']",function(){
		validateTxtLength(this,8);
	});
	
	$(document).on("input change paste","[name='email']",function(){
		validateTxtLength(this,40);
	});
	
	/*$(document).on("keyup", "#join_name", function() {
		$(this).val( $(this).val().replace(/[^ㄱ-힣a-zA-Z]/gi,"") );
	});*/
	
	/* 회원가입 Validation*/
	var mbrNm = "${member.mbrNm}";
	var birth = "${member.birth}";
	var nickNm = "${member.nickNm}";
	var email = "${member.email}";
	var joinValidate = {
		all : function(){
			$(".validation-check").each(function(e){
				$(this).html("");
			});
			
			/* if(!mbrNm && $("#join_name").val() == ""){
				$("#join_name_error").html("이름을 입력해주세요.");
				$("#join_name").focus();
				return false;
			} */
			
			/*if(!birth &&($("#join_birth").val().length != 8 )){
				$("#join_birth_error").html("숫자 8자리를 입력해주세요.");
				$("#join_birth").focus();
				return false;
			}*/
	
			if(!nickNm && $("#join_nickname").val() == ""){
				$("#join_nickNm_error").html("<spring:message code='front.web.view.join.nickname.input.validate.check1'/>");
				$("#join_nickname").focus();
				return false;
			}
			
			if(!email){
				if(!valid.email.test($("#join_email_id").val())){
					$("#join_email_error").html("<spring:message code='front.web.view.join.email.input.validate.check2'/>");
					$("#join_email_id").focus();
					return false;
				}
			}
	
			return true;
		}
	};
	
	function inputChk(){
		var required_value_fill = true;
		
		$(".required_join_input").each(function(){
			if($(this).val() == '') required_value_fill = false;
		});
		
		if($("input:radio[name='gdGbCd']:radio").val() == '')  required_value_fill = false;
		
		if(required_value_fill){
			$("#activeBtn").show();
			$("#inactiveBtn").hide();
		}else{
			$("#inactiveBtn").show();
			$("#activeBtn").hide();
		}
	}
	
	/* 회원가입 처리*/
	function insertMember(){
		if(joinValidate.all()){
			var options = {
				url : "<spring:url value='/login/insertPBHRInfo' />",
				data : $("#join_form").serialize(),
				done : function(data){
					if(data.returnCode == "duplicatedEmail"){
						$("#join_email_error").html("<spring:message code='front.web.view.join.email.input.validate.check3'/>");
						$("#join_email_id").focus();
						return false;
					}else if(data.returnCode == "duplicatedNickNm"){
						$("#join_nickNm_error").html("<spring:message code='front.web.view.join.nickname.input.validate.check2'/>");
						$("#join_nickname").focus();
						return false;
					}else if(data.returnCode == "banWord"){
						messager.toast({txt : "<spring:message code='front.web.view.join.banword.input.check'/>"});
						return false;
					}else{
						if('${view.deviceGb}' == 'APP'){
							toNativeData.func = 'onLogin';
							toNative(toNativeData);
							
							toNativeData.func = "onMainPage";
							toNativeData.type = "SHOP"  //펫츠비회원만 쓰는 화면으로 변경되었으므로 SHOP으로 자동 설정
							toNative(toNativeData);
						}else{
							//google analytics 호출
							login_data.method = data.loginPathCd;
							sendGtag('login');
						}
						
						storageHist.replaceHist();
						
						location.href='/join/indexTag?isPBHR=Y';
					}
				}
			}; 
	
			ajax.call(options);
		}
	}
	
	//어플인 경우 갤러리 오픈
	function onOpenGallery(){
		// 데이터 세팅
		toNativeData.func = "onOpenGallery";
		toNativeData.useCamera = "P";
		toNativeData.galleryType = "P";
		toNativeData.usePhotoEdit = "Y";
		toNativeData.editType = "S";
		let fileIds = new Array();
		if(imageResult != null) {
			fileIds[0] = imageResult.fileId;
			toNativeData.fileIds = fileIds;
		}
		toNativeData.maxCount = 1;
		//toNativeData.previewWidth = $("input[name=previewWidth]").val();
		//toNativeData.previewHeight = $("input[name=previewHeight]").val();
		toNativeData.callbackDelete = "galleryCallbackDelete";
		toNativeData.callback = "galleryCallback";
		// 호출
		toNative(toNativeData);
	}
	
	//app갤러리 콜백
	function galleryCallback(result) {
        imageResult = JSON.parse(result);
        //alert(result);
        $("#imgPathView").show();
        $("#imgPathView").attr("src", imageResult.imageToBase64);
        $("#imgArea").hide();
		$("#prfImgPathInApp").val("Y").change(); 
		//$("#prfImgPath").val("");
    }
	
	// 사진 선택 해제시
    function galleryCallbackDelete(result) {
		$("#imagPathView").attr("src", "../../_images/my/icon-img-profile-default-b@2x.png");
		$("#prfImgPathInApp").val("").change();
		//alert();
    }
	
    /*이미지 등록 인앱 */
	function saveImgInApp(mbrNo){
		//$("#prfImgPath").val($("#prfImgPathInApp").val());
		toNativeData.func = 'onFileUpload';
		toNativeData.prefixPath = "/member/"+mbrNo;
		toNativeData.callback = "onFileUploadProfileCallBack";
		
		toNative(toNativeData);
	}
	
	/*이미지 등록 인앱 - 콜백함수*/
	function onFileUploadProfileCallBack(result) {
		//alert(result);
		var file = JSON.parse(result);
		var mbrNo = $("#mbrNo").val();
		
		var options = {
				url : "<spring:url value='/join/insertMemberPrflInApp' />"
				, data : { mbrNo : $("#mbrNo").val(), prflImg : file.images[0].filePath }
				, done : function(data) {
					location.href='/join/indexTag';
				}
		}
 		ajax.call(options);
	}
	
	// web 이미지 업로드 결과
	function resultImage(result) {
		if(result.fileExe == "gif"){
			messager.toast({txt : "<spring:message code='front.web.view.join.image.input.result.check'/>"});
			return;
		}
		$("#imgPathView").show();
		$("#imgPathView").attr('src', '/common/imageView.do?filePath=' + result.filePath);
		//$("#imgArea").attr('background', '/common/imageView.do?filePath=' + result.filePath);
		$("#imgArea").hide();
		$("#prfImgPath").val(result.filePath);
	}
	
	//뒤에서 오기 방지
	/*function noBack(){
		window.history.forward();
	}*/
</script>
</tiles:putAttribute>
<%-- <body class="body">
	<div class="wrap" id="wrap">

		<!-- 헤더 MO-->
		<c:if test="${ view.deviceGb eq 'MO'}">
		<include class="header mo" data-include-html="/_html/inc/header_mo_type02.html"></include>
		</c:if>
		<!-- 헤더 PC-->
		<c:if test="${ view.deviceGb eq 'PC'}">
		<include class="header pc" data-include-html="/_html/inc/header_pc.html"></include>
		</c:if>

		<!-- GNB -->
		<include class="gnb" data-include-html="/_html/inc/gnb.html"></include> --%>
<tiles:putAttribute name="content">	
	<body class="body">
		<div class="wrap" id="wrap">
			<!-- mobile header -->
			<header class="header pc cu mode7 noneAc" data-header="set9">
				<div class="hdr">
					<div class="inr">
						<div class="hdt">
							<!--<button id ="backBtn" class="mo-header-backNtn" onclick = "location.href='/indexLogin'" data-content="" data-url="history.go(-1)"><spring:message code='front.web.view.common.msg.back'/></button>-->
							<button id ="backBtn" class="mo-header-backNtn" onclick="storageHist.goBack();" data-content="" data-url=""><spring:message code='front.web.view.common.msg.back'/></button>
							<div class="mo-heade-tit"><span class="tit"><spring:message code='front.web.view.index.pbhrinfo.additional.info.add'/></span></div>
						</div>
					</div>
				</div>
			</header>
			<!-- // mobile header -->		
			<!-- 바디 - 여기위로 템플릿 -->
			<main class="container page login srch" id="container">
				<div class="inr">
					<!-- 본문 -->
					<div class="contents" id="contents">
						<div class="pc-tit">
							<h2>회원정보 추가 입력</h2>
						</div>
	
						<div class="fake-pop">
							<div class="result">
								<c:if test="${member.joinPathCd == frontConstants.JOIN_PATH_10 }">하루가 </c:if>
								<c:if test="${member.joinPathCd == frontConstants.JOIN_PATH_20 }">펫츠비가 </c:if>
								 <span class="blue"><spring:message code='front.web.view.common.aboutPet.title'/></span><spring:message code='front.web.view.index.pbhrinfo.rst.msg'/>
								<p class="sub"><spring:message code='front.web.view.index.pbhrinfo.rst.msg.suggest'/></p>
							</div>
	
							<div class="pct">
								<div class="poptents">
									<form id="join_form">
									<input type="hidden" name="mbrNo" id="mbrNo" value="${member.mbrNo }" />
									<input type="hidden" name="orgNickNm" value="${member.nickNm }" />
									<input type="hidden" id="joinEnvCd" name="joinEnvCd" value="${view.deviceGb}" />
									<input type="hidden" id="deviceTpCd" name="deviceTpCd" value="${view.os}" />
									<input type="hidden" name="deviceToken" id="appPushToken"  /> 
									
									<!-- 프로필 사진 -->
									<!-- <div class="my-picture">
										<p class="picture" id="imgArea"></p>
										<img class="picture" id="imgPathView" name="imgPathView" class="thumb" alt="" style="display:none;">
										<input type="hidden" id="prfImgPath" name="prflImg"  />
										<input type="hidden" id="prfImgPathInApp" name="prfImgPathInApp"  />
										<button class="btn edit"  id="profileAdd" data-content="" data-url=""></button>
									</div> -->
									<!-- // 프로필 사진 -->
									<!-- 회원 정보 입력 -->
									<div class="member-input" style="padding-top: 30px;">
										<ul class="list">
										<%-- 	<c:if test="${member.joinPathCd == frontConstants.JOIN_PATH_10 }"> 
												<li>
													<strong class="tit requied">이름</strong>
													<p class="info">필수 입력 정보</p>
													<div class="input">
														<input type="text" id="join_name" class="" name="mbrNm" value="${member.mbrNm}" placeholder="이름을 입력해주세요." maxlength="10">
													</div>
													<p class="validation-check" id="join_name_error"></p>
												</li>
										 	</c:if> --%>
												<%-- <li>
													<strong class="tit requied">생년월일</strong>
													<c:if test="${member.joinPathCd ne frontConstants.JOIN_PATH_10 }">
													<p class="info">필수 입력 정보</p>
													</c:if>
													<div class="input">
														<input type="number" id="join_birth" class="required_join_input" name="birth" placeholder="숫자  8자리 입력(YYYYMMDD)" maxlength="8">
													</div>
													<p class="validation-check" id="join_birth_error"></p>
												</li> --%>
												<!-- <li>
													<strong class="tit requied">성별</strong>
													<div class="flex-wrap">
														<label class="radio"><input class ="required_join_input" type="radio" id="join_gd_gb_cd2" name="gdGbCd" value="10" checked="checked" ><span class="txt">남자</span></label>
														<label class="radio"><input class ="required_join_input" type="radio" id="join_gd_gb_cd1" name="gdGbCd" value="20" ><span class="txt">여자</span></label>
													</div>
												</li> -->
											<%-- <c:if test ="${member.nickNm eq null || member.nickNm eq ''}"> --%>
												<li>
													<strong class="tit requied"><spring:message code='front.web.view.join.required.input.nickname.title'/></strong>
													<div class="input disabled">
														<input type="text" id="join_nickname" name="nickNm" value="${member.nickNm}" class="required_join_input"  maxlength="20" placeholder="<spring:message code='front.web.view.join.nickname.input.validate.check1'/>" >
													</div>
													<p id="join_nickNm_error"  class="validation-check"></p>
												</li>
											<%-- </c:if> --%>
												<li>
													<strong class="tit requied"><spring:message code='front.web.view.common.email.title'/></strong>
													<div class="input disabled">
														<input type="text" id="join_email_id" name="email" value="${member.email}" class="required_join_input" placeholder="<spring:message code='front.web.view.certificate.email.msg.request.email'/>" maxlength="40" >
													</div>
													<p class="validation-check" id="join_email_error"></p>
												</li>
										</ul>
									</div>
									</form>
									<!-- // 회원 정보 입력 -->
								</div>
							</div>
							<div class="pbt pull">
								<div class="bts" id="inactiveBtn" >
									<a href="javascript:;" id="nextBtn" class="btn lg gray" data-content="" data-url=""><spring:message code='front.web.view.common.next.button.title'/></a><!--pointer-events: none;  -->
								</div>
								<div class="bts" id="activeBtn" style="display:none;">
									<a href="javascript:insertMember();" id="nextBtn" class="btn lg a" data-content="" data-url=""><spring:message code='front.web.view.common.next.button.title'/></a><!--pointer-events: none;  -->
								</div>
							</div>
						</div>
					</div>
	
				</div>
			</main>
	
			<div class="layers">
				<!-- 레이어팝업 넣을 자리 -->
			</div>
			<!-- 바디 - 여기 밑으로 템플릿 -->
	
			<!-- 하단메뉴 -->
			<!-- <include class="menubar" data-include-html="../inc/menubar.html"></include> -->
			<!-- 푸터 -->
			<!-- <include class="footer" data-include-html="../inc/footer.html"></include> -->
	
		</div>
	</body>
	</tiles:putAttribute>
</tiles:insertDefinition>