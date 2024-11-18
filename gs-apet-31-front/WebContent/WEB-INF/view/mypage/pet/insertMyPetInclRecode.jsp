<tiles:insertDefinition name="mypage">
	<jsp:include page="/WEB-INF/tiles/include/js/common_mo.jsp"/>
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript" 	src="/_script/file.js"></script>
		<script type="text/javascript">
		var deviceGb = "${view.deviceGb}";
		var checkedValue;
		var petGbCd = '${petBase.petGbCd}';
		var age = '${petBase.age}';
		
		$(function(){
			if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
				//Device 뒤로가기 버튼 기능을 웹에서 처리시 사용(Y:웹에서 백기능 처리, N:앱에서 처리)-호출 함수
				fncDeviceBackWebUse("fncGoBack");
			}
			
			//바텀시트 오픈 시 스크롤 lock
			if(ui.check_brw.mo()){
				setTimeout(function(){
					$("[data-sid = 'ui-datepickers'], .ui-datepicker-trigger, .select-pop").click(function(){
						ui.lock.using(true);
						setTimeout(function(){
							$(".ui-datepicker-close, .ui-state-default").click(function(){
								//console.log("unlock!!");
								ui.lock.using(false);
							});
							$(".ui-datepicker").click(function(){
								$(".ui-state-default").click(function(){
									//console.log("unlock!!");
									ui.lock.using(false);
								});
							});
						},500);
					});
				},500);
			}
			
			if(deviceGb != "PC"){
				$("#footer").remove();
				$(".mode0").remove();
				$(".menubar").remove();
			}else{
				$(".mode7").remove();
			}
			
			$(".btSel").html("접종명을 선택해주세요.");
			$("[name=insertBtn]").addClass("disabled");
			$('[name=inclDt]').datepicker('option','dateFormat','yy.mm.dd');
			$('[name=addInclDt]').datepicker('option','dateFormat','yy.mm.dd');
			$('[name=inclDt]').datepicker("option" , "maxDate" , "0");
			$('[name=addInclDt]').datepicker("option" ,"minDate" , "0");
			$("#inclAdd").hide();
			
			// 접종 유형
			$(document).on("click" , "input[name=inclGbCd]" , function(){
				$(".btnPopSelClose").trigger("click")
				$(".btSel").html("접종명을 선택해주세요.");
				$("#alertli").show();
				$("[name=inclDt]").val("")
				$("[name=addInclDt]").val("")
				$("[name=fixAddInclDt]").val("")
				$("[name=inclKindCd]").val("");
				$("[name=addInclCd]").prop("chekced" , false);
				
				if($(this).val() == 10){
					$("#basicIncl").show();
					$("#regularIncl").hide();
					$("#antibodyIncl").hide();
					$("#almSetYn").prop("checked" , false);
					$("#almSetYn").trigger("click");
					$("#addInclDt").hide();
					
					if(petGbCd == "10"){
						$("#alertMsg").html("다음 접종일에 알림 받기(접종일 기준 2주 뒤)")
						$("#inclAdd").show();
					}else{
						$("#alertMsg").html("다음 접종일에 알림 받기(접종일 기준 3주 뒤)")
					}
				}
				
				if($(this).val() == 20){
					$("#basicIncl").hide();
					$("#regularIncl").show();
					$("#antibodyIncl").hide();
					$("#inclAdd").hide();
					$("#addInclDt").hide();
					
					$("#almSetYn").prop("checked" , false);
					$("#almSetYn").trigger("click");
					
					$("#alertMsg").html("다음 접종일에 알림 받기(접종일 기준 1년 뒤)");
				}
				
				if($(this).val() == 30){
					$("#antibodyIncl").show();
					$("#basicIncl").hide();
					$("#regularIncl").hide();
					$("#inclAdd").hide();
					// APETQA-6911
					var checkAlmSetYn = "${recode.almSetYn}"; // 알람설정 체크 여부 검증용(true ="Y" , false = "N")			
					var addInclDt = "${recode.addInclDt}"; // 접종날짜 설정 값(yyyymmdd)
					var year =addInclDt.substring(0,4);
					var month =addInclDt.substring(4,6);
					var day =addInclDt.substring(6,8);
					var ResultaddInclDt = year + '.' + month + '.' + day; // 접종날짜 설정 값 양식에 맞게 변환(yyyy.mm.dd)
					if(checkAlmSetYn == "Y"){  //알람설정 여부가 체크되어있으면
						$("#almSetYn").prop("checked" , true); //알람설정을 체크박스를 체크하고,
						$("#addInclDt").show(); // 데이트 피커를 보여주고,
						$("#addInclDt").find("input").val(ResultaddInclDt); // 데이트피커에 설정한 값을 넣어준다.
					} else{
						$("#almSetYn").prop("checked" , false); //알람설정을 체크박스를 해제한다.
					}
					
					$("#almSetYn").val(null);
					
					//$("#almSetYn").trigger("click");
					
					$("#alertMsg").text("다음 접종일에 알림 받기");
				}
			});
			
			// 페이지 진입 시 1살 이상이면 정기접종 / 이하일 시 기초 접종
			if(age < 1){
				$("#contents").find("input[name=inclGbCd]").eq(0).trigger("click");
			}else{
				$("#contents").find("input[name=inclGbCd]").eq(1).trigger("click");
			}
			
			// 접종 종류 수정 시
			$(document).on("change" , "#basicInclKindCd" , function(){
				var display = $("#basicIncl").css("display");
				var addyn = $(this).find("option:selected").data("addyn");
				var val = $(this).find("option:selected").val();
				
				if(display != "none"){
					if(addyn == 'N'){
						$("#inclAdd").hide();
						$("#alertli").hide();
						$("[name=addInclCd]").prop("chekced" , false);
						$("#almSetYn").prop("checked" , false);
						$("#almSetYn").val("");
						$("[name=addInclDt]").val("")
						$("[name=fixAddInclDt]").val("")
					}else{
						if(petGbCd != "${frontConstants.PET_GB_20}"){
							$("#inclAdd").show();
						}
						$("#almSetYn").prop("checked" , true);
						$("#almSetYn").val("Y");
						$("#alertli").show();
					}
					
					if(val == '${frontConstants.INCL_KIND_1005}' || val == '${frontConstants.INCL_KIND_2003}'){
						$("#alertMsg").html("다음 접종일에 알림 받기(접종일 기준 1년 뒤)");
					}else{
						if(petGbCd == "${frontConstants.PET_GB_10}"){
							$("#alertMsg").html("다음 접종일에 알림 받기(접종일 기준 2주 뒤)");
						}
						if(petGbCd == "${frontConstants.PET_GB_20}"){
							$("#alertMsg").html("다음 접종일에 알림 받기(접종일 기준 3주 뒤)");
						}
					}
				}
				
				if(display == "none"){
					$("#inclAdd").hide();
					$("#alertli").show();
				}
				
				setAddInclDt();
			});
			
			// 접종일 수정 시
			$(document).on('change' , "[name=inclDt]" , function(){
				setAddInclDt();
			});
			
			// datepicker 아이콘 클릭 시
			$(document).on("click" , "#datepicerIcon" , function(){
				$("[name=inclDt]").trigger("click");
			});
			
			$(document).on("click" , "#datepicerIconAlert" , function(){
				$("[name=addInclDt]").trigger("click");
			});
			
			// 추가 접종
			$(document).on("click", "[name=addInclSpan]" , function(){
				var input = $(this).find('input');
				var value = input.val();
				
				if(checkedValue != value){
					checkedValue = value;
				}else{
					checkedValue = null;
					input.prop("checked" , false);
				}
			});
			
			// 알림 설정 
			$(document).on("click" , "#almSetYn" , function(){
				var inclGbCd = $("[name=inclGbCd]:checked").val();
				if($(this).prop("checked") == true){
					$(this).val("Y");
					if(inclGbCd != "${frontConstants.INCL_GB_30}"){
						$("#fixAddInclDt").show();
					}else{
						$("#addInclDt").show();
					}
					setAddInclDt();
				}else{
					$("#addInclDt").hide();
					$("#fixAddInclDt").hide();
					$("[name=addInclDt]").val("");
					$("[name=fixAddInclDt]").val("");
					$(this).val(null);
				}
			});
			
			// 진료병원 유효성
			$(document).on("change input paste" , "#trmtHsptNm" , function(){
				if($(this).val().length > 10){
					ui.toast("진료 병원명은 10자까지 입력할 수 있어요.");
					$(this).val($(this).val().substr(0 , 10));
				}
			});
			
			// 특이사항 유효성
			$(document).on("change input paste" , "#memo" , function(){
				if($(this).val().length > 500){
					ui.toast("특이사항은 500자까지 입력할 수 있어요.");
					$(this).val($(this).val().substr(0 , 500));
				}
			});
			
			//등록 버튼 활성화
			$(document).on("change" , "input , select" , function(){
				if(!$("[name=inclKindCd]").find("option:selected").val() || !$("[name=inclDt]").val()){
					$("[name=insertBtn]").addClass("disabled");
				}else{
					$("[name=insertBtn]").removeClass("disabled");
				}
			});
			
			// 취소 버튼 클릭 시
			/*$(document).on("click" , "#cancleBtn , #backBtn" , function(e){
				e.preventDefault();
				var msg;
				if('${recode.inclNo}'){
					msg = "예방접종 정보 수정을 취소할까요?"
				}else{
					msg = "예방접종 등록을 취소할까요?"	
				}
				ui.confirm(msg , {
					ycb : function(){
						//location.href = "/my/pet/indexMypetInclRecode?petNo=" + $("#petNo").val();
						storageHist.goBack("/my/pet/indexMypetInclRecode?petNo=" + $("#petNo").val());
						//storageHist.goHistoryBack(storageReferrer.get());
					}
					, ybt : "예"
					, nbt : "아니오"
				});
			});*/
			
			$(document).on("click" , "button" , function(e){
				e.preventDefault();
			});
			
			if('${recode.inclNo}'){
				inputSet();
			}
		});
		
		function validate(){
			var msg;
			var result;
			
			//필수 입력값(접종명 , 접종일)이 없을 시 
			if(!$("[name=inclKindCd]").find("option:selected").val() || !$("[name=inclDt]").val()){
				msg = "필수 입력 정보를 모두 입력해주세요.";
				result = false;
			// 알림 설정이 되었지만 다음 예정 접종일을 선택하지 않았을 시
			}else if($("[name=almSetYn]").val() && (!$("[name=addInclDt]").val() && !$("[name=fixAddInclDt]").val())){
				msg = "<spring:message code ='front.web.view.mypet.valid.add_incl_dt'/>";
				result = false;
			}else{
				result = true;
			}
			
			if(msg){
				ui.toast(msg);
			}
			
			return result;
		}
		
		// update시 inputSet
		function inputSet(){
			var inclDt = "${recode.inclDt}";
			var y = inclDt.substr(0, 4);
			var m = inclDt.substr(4, 2);
			var d = inclDt.substr(6, 2);
			var date = new Date(y , m-1 , d);
			
			// 접종 유형
			$("[name=inclGbCd][value='${recode.inclGbCd}']").trigger("click");
			
			//접종 종류
			var index = "${recode.inclGbCd}".substr(0,1) -1;
			$(".btSel").eq(index).trigger("click");
			$(".pop-select").eq(index).find("button[value='${recode.inclKindCd}']").trigger("click");
			
			// 접종일
			$("[name=inclDt]").datepicker("setDate" , date).change();
			
			//추가 백신
			$("[name=addInclCd][value='${recode.addInclCd}']").trigger("click");
			
			// 이미지
			if('${recode.imgPath}'){
				$("#imgArea").show();
			}
			
			$("#insertBtn").html("저장");
		}
		
		function setAddInclDt(){
			var today = new Date();
			var date = $("[name=inclDt]").datepicker("getDate");
			var inclGbCd = $("[name=inclGbCd]:checked").val();
			var basicInclKind = $("#basicInclKindCd").find("option:selected").val();
			
			if(date){
				if(inclGbCd == "20" || basicInclKind == "${frontConstants.INCL_KIND_1005}" || basicInclKind == "${frontConstants.INCL_KIND_2003}"){
					date.setDate(date.getDate()+365);
				}else{
					if(petGbCd == "10"){
						date.setDate(date.getDate()+14);
					}
					if(petGbCd == "20"){
						date.setDate(date.getDate()+21);
					}
				}
				
				// 접종 예정일이 오늘보다 이전이고 접종구분이 항체가 검사가 아닐 경우 알림설정 checkbox disabled
				if(date.getTime() < today.getTime() 
						&& $("[name=inclGbCd]:checked").val() != "${frontConstants.INCL_GB_30}"){
					$("#almSetYn").prop("disabled" , true);
					$("#almSetYn").prop("checked" , false);
					$("#almSetYn").val(null);
					$("#addInclDt").hide();
					return false;
				}else{
					$("#almSetYn").prop("disabled" , false);
				}
				
				if($("#almSetYn").prop("checked") && inclGbCd != "${frontConstants.INCL_GB_30}"){
					//$("[name=addInclDt]").datepicker("setDate" , date);
					$("[name=fixAddInclDt]").val(format.DateType(date , "."));
				}
			}
		}
		
		// 이미지 업로드
		function imageUpload(){
			if(deviceGb != "APP"){
				fileUpload.image(imageUploadCallBack);
			}else{
				callAppFunc("onOpenGallery");
			}
		}
		
		// 이미지 업로드 콜백
		function imageUploadCallBack(result){
			$("#imgUploadBtn").hide();
			
			if(deviceGb != "APP"){
				$("#imgPathView").attr("src" , "/common/imageView?filePath="+result.filePath);
				$("#imgPath").val(result.filePath);
			}else{
				imageResult = JSON.parse(result);
				$("#imgPathView").attr("src" , imageResult.imageToBase64);
			}
			
			$("#imgArea").show();
		}
		
		//이미지 삭제
		function deleteImage(){
			/*var msg = "<spring:message code='front.web.view.mypet.confirm.delete.incl_image' />";
			ui.confirm(msg ,{ 
				ycb:function(){
					ui.alert("<spring:message code='front.web.view.mypet.confirm.delete.incl_image.done' />");
				},
				ybt:'확인',
				nbt:'취소'
			});*/
			
			$("#imgArea").hide();
			$("#imgUploadBtn").show();
			$("#imgPath").val("");
		}
		
		// 예방 접종 기록 INSERT / UPDATE
		function insertInclRecode(){
			var obj = null;
			var result; 
			var formData = $("#inclInsertForm").serializeArray();
			if(formData){
				obj = {};
				$.each(formData , function(){
					if(this.value){
						obj[this.name] = this.value;
					}else{
						obj[this.name] = null;
					}
				});
			}
			
			if($("[name=inclDt]").val() != ""){
				var inclyear = obj.inclDt.substr(0,4);
				var inclmonth = obj.inclDt.substr(5,2);
				var inclday = obj.inclDt.substr(8,2);
				obj.inclDt = inclyear + "-" + inclmonth + "-" + inclday;
			}
			
			//console.log(obj);
			// 기초접종 , 정기접종일 경우 고정된 값 노출 , 항체가 검사일 경우 사용자 선택 값
			if($("[name=addInclDt]").val() != "" || $("[name=fixAddInclDt]").val()){
				var addyear;
				var addmonth;
				var addday;
				
				if(obj.inclGbCd != "${frontConstants.INCL_GB_30}"){
					addyear = obj.fixAddInclDt.substr(0,4);
					addmonth = obj.fixAddInclDt.substr(5,2);
					addday = obj.fixAddInclDt.substr(8,2);
				}else{
					addyear = obj.addInclDt.substr(0,4);
					addmonth = obj.addInclDt.substr(5,2);
					addday = obj.addInclDt.substr(8,2);
				}
				obj.addInclDt = addyear + "-" + addmonth + "-" + addday + " 09:00:00";
			}
			
			var options = {
				url : "<spring:url value ='/my/pet/insertMyPetInclRecode'/>"
				, data : obj
				, done : function(petInclNo){
					if(petInclNo){
						var msg;
						var updateYn;
						if('${recode.inclNo}'){
							updateYn = "Y";
						}else{
							updateYn = "N";
						}
						$("#inclNo").val(petInclNo);
						
						if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}" && $("#imgArea").css("display") != "none"){
							callAppFunc("onFileUpload");
						}else{
							//location.href = "/my/pet/indexMypetInclRecode?petNo=" + $("#petNo").val() + "&updateYn="+updateYn;
							storageHist.goBack("/my/pet/indexMypetInclRecode?petNo=" + $("#petNo").val() + "&updateYn="+updateYn);
						}
					}
				}
			}
			if(validate()){
				ajax.call(options);
			}
		}
		
		// app 이미지 처리 
		function callAppFunc(funcNm){
			toNativeData.func = funcNm;
			if(funcNm == "onOpenGallery"){
				toNativeData.useCamera = "P";
				toNativeData.usePhotoEdit = "N";
				toNativeData.galleryType = "P";
				toNativeData.maxCount = "1";
				toNativeData.previewWidth = "300";
				toNativeData.callback = "imageUploadCallBack"
			}else if(funcNm == "onDeleteImage"){
				toNativeData.fileId = "imgPathView";
				toNativeData.callback = "deleteImage";
			}else if(funcNm == "onFileUpload"){
				toNativeData.prefixPath = "${frontConstants.PET_INCL_IMG_PATH}/"+ "${petBase.petNo}"
				toNativeData.callback = "onFileUploadCallBack";
			}
			toNative(toNativeData);
		}
		
		function onFileUploadCallBack(result){
			var file = JSON.parse(result);
			
			var options = {
				url : "<spring:url value='/my/pet/appInclPetImageUpdate' />"
				, data : {
					petNo : "${petBase.petNo}"
					, inclNo : $("#inclNo").val()
					, imgPath : file.images[0].filePath
				}
				, done : function(){
					var msg;
					
					if('${recode.inclNo}'){
						msg = "<spring:message code ='front.web.view.mypet.update.incl_recode'/>";
					}else{
						msg = "<spring:message code ='front.web.view.mypet.insert.incl_recode'/>";
					}
					
					ui.toast(msg , {
						ccb : function(){
							//location.href = "/my/pet/indexMypetInclRecode?petNo=" + $("#petNo").val();
							storageHist.goBack("/my/pet/indexMypetInclRecode?petNo=" + $("#petNo").val());
						}
					});
				}
			}
			ajax.call(options);
		}	
		
		//PC에서 투약명을 선택해주세요  누르면 options 닫히게  APETQA-6295
		$(function(){
			if('${view.deviceGb}' == "${frontConstants.DEVICE_GB_10}"){
			    $('.btSel').click(function(){
					var id = $(".pop-select:visible").data("select-pop");
					$(".pop-select").removeClass("on").fadeOut(100,function(){
						$(this).remove();
						ui.lock.using(false);
						$(".cusDim").removeClass('dimOn');
					});
					$("select[name="+id+"]").closest(".select-pop").find(".btSel").attr("tabindex","0").focus().removeClass("open");
					$("body").removeClass("isPopSelect");
			    });
			}
		});
		
		function fncGoBack(){
			var msg = "";
			if('${recode.inclNo}'){
				msg = "예방접종 정보 수정을 취소할까요?";
			}else{
				msg = "예방접종 등록을 취소할까요?";
			}
			
			ui.confirm(msg , {
				ycb : function(){
					//location.href = "/my/pet/indexMypetInclRecode?petNo=" + $("#petNo").val();
					storageHist.goBack("/my/pet/indexMypetInclRecode?petNo=" + $("#petNo").val());
					//storageHist.goHistoryBack(storageReferrer.get());
				}
				, ybt : "예"
				, nbt : "아니오"
			});
		}
		
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<div class="wrap" id="wrap">
			<!-- mobile header -->
			<header class="header pc cu mode7 noneAc" data-header="set9">
				<c:set var="title" value ='${recode.inclNo eq null ? "예방접종 등록" : "예방접종 수정"}'/>
				<div class="hdr">
					<div class="inr">
						<div class="hdt">
							<button id="backBtn" class="mo-header-backNtn" data-content="" data-url="fncGoBack()" onclick="fncGoBack();">뒤로</button>
							<div class="mo-heade-tit"><span class="tit">${title }</span></div>
						</div>
					</div>
				</div>
			</header>
			<!-- // mobile header -->
			<main class="container page login lnb" id="container">
				<div class="inr">
					<!-- 본문 -->
					<div class="contents" id="contents">
						<div class="pc-tit">
							<h2>예방접종 등록</h2>
						</div>
						<!-- dogContent -->
						<form id="inclInsertForm">
						<input type ="hidden" name="inclNo" id="inclNo" value ="${recode.inclNo }">
						<input type ="hidden" name="petNo" id="petNo" value ="${petBase.petNo }">
						<input type ="hidden" name="petNm" id="petNm" value ="${petBase.petNm }">
						<input type="hidden" id="imgPath" name="imgPath">
						<input type="hidden" id="orgImgPath" name="orgImgPath" value="${recode.imgPath }">
						<div id ="content" class="fake-pop">
							<div class="pct">
								<div class="poptents">
									<!-- 회원 정보 입력 -->
									<div class="member-input po-reSet-layer">
										<div class="check_mark_legend"><span>*</span>필수 입력 정보</div>
										<ul class="list">
											<li>
												<strong class="tit requied">접종 유형</strong>
												<div class="radiobox nowrap t2 pc-flex-reset01">
													<c:if test ="${petBase.petGbCd eq frontConstants.PET_GB_10 }">
														<span class="radio"><input type="radio" name="inclGbCd" value =${frontConstants.INCL_GB_10 }><label for="radt_1" class="txt">기초접종<span>(1년 미만 강아지)</span></label></span>
														<span class="radio"><input type="radio" name="inclGbCd" value =${frontConstants.INCL_GB_20 }><label for="radt_2" class="txt">정기접종<span>(1년 이상 성견)</span></label></span>
														<span class="radio"><input type="radio" name="inclGbCd" value =${frontConstants.INCL_GB_30 }><label for="radt_3" class="txt">항체가검사</label></span>
													</c:if>
													<c:if test ="${petBase.petGbCd eq frontConstants.PET_GB_20 }">
														<span class="radio"><input type="radio" name="inclGbCd" value =${frontConstants.INCL_GB_10 }><label for="radt_11" class="txt">기초접종<span>(1년 미만 자묘)</span></label></span>
														<span class="radio"><input type="radio" name="inclGbCd" value =${frontConstants.INCL_GB_20 }><label for="radt_22" class="txt">정기접종<span>(1년 이상 성묘)</span></label></span>
														<span class="radio"><input type="radio" name="inclGbCd" value =${frontConstants.INCL_GB_30 }><label for="radt_33" class="txt">항체가검사</label></span>
													</c:if>
												</div>
											</li>
											<li>
												<strong class="tit requied">종류</strong>
												<div class ="cusDim" style="position: relative;">
													<span class="select-pop w100" id="basicIncl">
														<select id="basicInclKindCd" class="sList" name="inclKindCd" data-select-title="기초접종 종류 선택">
															<c:forEach items = "${basicInclList }" var="basic">
																<option data-addyn = "${basic.usrDfn3Val }" value="${basic.dtlCd }">${basic.dtlNm }</option>
															</c:forEach>
														</select>
													</span>
													<span class="select-pop w100" id="regularIncl">
														<select id ="regularInclKind" class="sList" name="inclKindCd" data-select-title="정기접종 종류 선택">
															<c:forEach items="${regularInclList }" var="regular">
																<option data-addyn ="N" value="${regular.dtlCd }">${regular.dtlNm }</option>
															</c:forEach>
														</select>
													</span>
													<span class="select-pop w100" id="antibodyIncl">
														<select id ="andtibodyInclKind" class="sList" name="inclKindCd" data-select-title="항체가검사 종류 선택">
															<c:forEach items="${antibodyInclList }" var="antibody">
																<option data-addyn ="N" value="${antibody.dtlCd }">${antibody.dtlNm }</option>
															</c:forEach>
														</select>
													</span>
													
												</div>
											</li>
											<li>
												<strong class="tit requied">접종일</strong>
												<section class="sect" data-sid="ui-datepickers" class="ui-datepicker">
													<span class="datepicker_wrap uiDate">
														<input type="text" readonly="readonly" class="datepicker" name="inclDt" title="접종일" placeholder ="날짜를 선택해주세요."/>
														<button type="button" id ="datepicerIcon" class="ui-datepicker-trigger">달력</button>
													</span>
												</section>
											</li>
											<li id="inclAdd">
												<!--<strong class="tit newDn">추가백신<span>(1종선택)</span></strong>-->
												<strong class="tit newDn">추가백신<span class="k0420">(1종선택)</span></strong><!-- 04.20 : 수정 -->
												<div class="radiobox t2 pc-flex-reset02">
													<c:forEach items ='${addInclList }' var="addIncl" varStatus ="idx">
														<span name = "addInclSpan" class="radio"><input type="radio" id ="${idx.count}" name="addInclCd" value="${addIncl.dtlCd }" data-selected = "false"><label for="radt_2-1" class="txt">${addIncl.dtlNm }</label></span>
													</c:forEach>
												</div>
											</li>
											<li>
												<strong class="tit">진료병원</strong>
												<div class="input">
													<input type="text" id="trmtHsptNm" name="trmtHsptNm" placeholder="병원명을 입력해주세요" value ="${recode.trmtHsptNm }">
												</div>
											</li>
											<li>
												<strong class="tit pc-pSet-t1">사진첨부</strong>
												<div class="log_makePicWrap t3">
													<div class="con">
														<ul>
															<li>
																<button class="lmp_addpicBt first w164" id="imgUploadBtn" onclick="imageUpload();return false;" data-content="" data-url="/common/fileUploadResult">
																	<div>
																		<span class="lmp_addPicIcon"></span>
																		<div class="txt t2">
																			오프라인 건강수첩<br />
																			사진을 업로드해 주세요
																		</div>
																	</div>
																</button>
															</li>
															<li id="imgArea" style="display:none">
																<c:if test ="${view.deviceGb ne frontConstant.DEVICE_GB_30}">
																	<button onclick="deleteImage()" class="lmp_colseBt" data-content="" data-url="deleteImage()"></button>
																</c:if>
																<c:if test ="${view.deviceGb eq frontConstant.DEVICE_GB_30 }">
																	<button onclick="callAppFunc('onDeleteImage')" class="lmp_colseBt" data-content="" data-url="callAppFunc('onDeleteImage')"></button>
																</c:if>
																<div class="pic">
																	<img id = "imgPathView" src="${frame:optImagePath(recode.imgPath , frontConstants.IMG_OPT_QRY_170) }" alt="">
																	<!--<a href="javascript:;" class="pic_icon"></a>-->
																</div>
															</li>
														</ul>
													</div>
												</div>
											</li>
											<li id="alertli">
												<strong class="tit pc-pSet-t1">알람설정</strong>
												<div class="mt05 mb10">
													<label class="checkbox">
														<input type="checkbox" id="almSetYn" name="almSetYn">
														<span id="alertMsg" class="txt">다음 접종일에 알림 받기 (접종일 기준 2주 뒤)</span>
													<input type="hidden" name="fixAddInclDt" class="datepicker hasDatepicker" title="캘린더타이틀" id="datepick_1" readonly="" value="${recode.addInclDt }">
													</label>
												</div>
												<section id ="addInclDt" class="sect" data-sid="ui-datepickers" class="ui-datepicker" <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">style="margin-left:15px;"</c:if>>
														<span class="datepicker_wrap uiDate" >
															<input type="text" readonly="readonly" class="datepicker" name="addInclDt" title="다음 접종일" placeholder ="다음 접종 날짜를 선택해주세요."/>
															<button type="button" id ="datepicerIconAlert" class="ui-datepicker-trigger" data-content="" data-url="">달력</button>
														</span>
												</section>
											</li>
											<li>
												<strong class="tit pc-pSet-t1">특이사항 메모 </strong>
												<div class="textarea"><textarea name="memo" id="memo" placeholder="접종 시 마이펫의 증상이나 부작용 등 접종에 대한 기록을 남겨주세요" style="height:180px;">${recode.memo }</textarea></div>
											</li>
										</ul>
									</div>
									<div class="exchange-area onWeb_b">
										<div class="btnSet space pc-reposition pc-no-border">
											<button id="cancleBtn" class="btn lg d" data-content="" data-url="fncGoBack()" onclick="fncGoBack();">취소</a>
											<button id="insertBtn" name="insertBtn" class="btn lg a" onclick="insertInclRecode();return false;" data-content="" data-url="/my/pet/insertMyPetInclRecode">등록</a>
										</div>
									</div>
									<c:if test ="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
										<div class="exchange-area">
											<div class="btnSet space pc-reposition pc-no-border" style="padding:0px;">
												<button id="insertBtnMo" name="insertBtn" class="btn lg a" onclick="insertInclRecode();return false;" data-content="" data-url="/my/pet/insertMyPetInclRecode">등록</a></button>
											</div>
									</c:if>
								</div>
							</div>
						</div>
						</form>
					</div>
				</div>
			</main>
			
			<%-- <jsp:include page="/WEB-INF/tiles/include/floating.jsp">
				<jsp:param name="floating" value="talk" />
			</jsp:include> --%>
			<!-- 하단메뉴 -->
			<!-- <include class="menubar" data-include-html="../inc/menubar.html"></include> -->
			<!-- 푸터 -->
			<!-- <include class="footer" data-include-html="../inc/footer.html"></include> -->
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>