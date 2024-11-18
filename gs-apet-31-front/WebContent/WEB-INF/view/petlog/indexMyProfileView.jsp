<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<tiles:insertDefinition name="noheader_mo">

	<tiles:putAttribute name="script.include" value="script.petlog"/> <!-- 지정된 스크립트 적용 -->
	
	<tiles:putAttribute name="script.inline">
<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">	
	<script>
	var toastH = 74;
	
	$(document).ready(function(){
		$("#header_pc").removeClass("mode0");	
		$("#header_pc").addClass("mode7-1");
		$(".mo-heade-tit .tit").html("<spring:message code='front.web.view.petlog.myprofile.edit.title' />");	
		$(".mo-header-backNtn").attr("onClick", "cancelEdit();");
		
		if( isIOS() ) toastH = 300;

		
// 		$("#petLogItrdc").keyup(function(){
// 			isChange  = true;
// 			//$(".btnSet a").removeClass("disabled");
// 			saveBtnEnabled();
			
// 			var content = $("#petLogItrdc").val();
// 			if($("#petLogItrdc").val().length > 20) {
// 				ui.toast("20자까지 입력 가능합니다.",{   // 토스트 창띄우기
// 					bot:toastH
// 				});
// 				$("#petLogItrdc").val(content.substring(0,20));
// 				return;
// 			}
// 		});
// 		if("${fn:replace(cmemberBase.petLogItrdc, newLineChar, '<br/>')}" == "") {
// 			$(".btnDel").hide();
// 		}
		
	});
	
	function isIOS(){	
		var mobileKeyWords = new Array('iPhone', 'iPod');
		for (var word in mobileKeyWords) {
			if (navigator.userAgent.match(mobileKeyWords[word]) != null) {
				return true;
			}
		}
		return false;
	}
	
	
// 	function cancelEdit(){
// 		ui.confirm('변경사항을 저장하지 않고</br>나가시겠습니까?',{ // 컨펌 창 띄우기
// 			ycb:function(){
// 				history.back();
// 			},
// 			ncb:function(){
// 				return false;
// 			},
// 			ybt:'나가기',
// 			nbt:'취소'	
// 		});
// 	}
	
// 	// 한줄 소개 x 버튼 이벤트
// 	function btnDel() {
// 		$(".lg ").removeClass('disabled');
// 	}

	</script>
</c:if>

<c:choose>
<c:when test="${view.deviceGb ne frontConstants.DEVICE_GB_30 }">
	<script type="text/javascript" 	src="/_script/file.js"></script>
	<script>	

		// 이미지 업로드
		function imageUpload() {
			// 파일 추가
			fileUpload.jpg(imageUploadCallBack);
		}		
		// 이미지 업로드 결과
		function imageUploadCallBack (result) {
			//alert("imageUploadCallBack");
			var addHtml = '<img class="img" name="petLogImgPathView" src="/common/imageView?filePath=' + result.filePath +'" />';
			$("#profile_image").html(addHtml);	
					
			$("#memberBaseForm").append("<input type='hidden' name='prflImg' value='"+result.filePath+"' />");	
			
			//saveBtnEnabled();
			isImgChanged();
		}
		
		function memberProfileSave(){
			insertMemberProfile();
		}
		
// 		function cancelEdit(){
// 		alert("1111");
// 			ui.confirm('변경사항을 저장하지 않고</br>나가시겠습니까?',{ // 컨펌 창 띄우기
// 				ycb:function(){
// 					history.back();
// 				},
// 				ncb:function(){
// 					return false;
// 				},
// 				ybt:'나가기',
// 				nbt:'취소'	
// 			});
// 		}
		
// 		// 한줄 소개 x 버튼 이벤트
// 		function btnDel() {
// 			$(".lg ").removeClass('disabled');
// 		}
	</script>	
</c:when>
<c:otherwise>
	<script>
		function imageUpload() {
			callAppFunc('onOpenGalleryProfile');
		}	
		
		function memberProfileSave(){
			// 이미지가 변경되었을 때는 app upload 처리
			if( isImgChange ){
				callAppFunc('onFileUploadProfile', '${session.getMbrNo()}');
			}else{
				insertMemberProfile();
			}
		}
	</script>
</c:otherwise>
</c:choose>
	<script>
		var isChange = false;
		var isImgChange = false;
		var bSerialize = null;

		$(function(){
			backupFormValue();
			ui.lock.using(true); //2021.04.19 추가 - IOS 스크롤 막기
			
		   function isIOS(){	
				var mobileKeyWords = new Array('iPhone', 'iPod');
				for (var word in mobileKeyWords) {
					if (navigator.userAgent.match(mobileKeyWords[word]) != null) {
						return true;
					}
				}
				return false;
			}
			
			$("#petLogItrdc").keyup(function(){
				//isChange  = true;
				//$(".btnSet a").removeClass("disabled");
				
				saveBtnEnabled();
			   
				var content = $("#petLogItrdc").val();
				var height;
				if(isIOS()){
					height = 140;
				}else{
					height = 70;
				}
				if($("#petLogItrdc").val().length > 50) {
					ui.toast("<spring:message code='front.web.view.petlog.intro.contents.msg.toast' />",{   // 토스트 창띄우기
						bot:height
					});
					$("#petLogItrdc").val(content.substring(0,50));
					return;
				}
			});
			
			<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
			if("${fn:replace(cmemberBase.petLogItrdc, newLineChar, '<br/>')}" == "") {
				$(".btnDel").hide();
			}
			
			// APET-1104 210611 lju02
			$('.introduction').on('keyup', function() {
				if($(this).val().length > 0) {
					$(".btn_del").css({'display':'block'});
				}else{
					$(".btn_del").css({'display':'none'});
				}
			});

			$(".btn_del").click(function(event){
				$( ".introduction" ).val('');
				$(this).css({'display':'none'});
			});
			//APET-1104 210611 lju02
			</c:if>
		});
	
		function isIOS(){	
			var mobileKeyWords = new Array('iPhone', 'iPod');
			for (var word in mobileKeyWords) {
				if (navigator.userAgent.match(mobileKeyWords[word]) != null) {
					return true;
				}
			}
			return false;
		}
		
		function isImgChanged(){
			isImgChange = true;
			saveBtnEnabled();
		}
		
		function saveBtnEnabled(){
			isChangedFormValue();
			
			if( isChange || isImgChange ){
				$(".btnSet .a").removeClass("disabled");
			}else{
				$(".btnSet .a").addClass("disabled");
			}
		}
		
		function closePictureCon(){
			//APETQA-4860 갤러리 열고 닫을 때 헤더 위치 조정
			//ui.headerSearech_input.set();
			$('.mo-header-backNtn').show();
			$('.mo-heade-tit').css('text-align','left');
			var $input = $(".header").find(".mo-heade-tit");
			var check = $input.css("justify-content");
			var diff1 = ($(".header").find(".hdr .cdt").css("display").toLowerCase() != "none")?$(window).width() - $(".header").find(".hdr .cdt").offset().left:($(".header").find(".mo-header-rightBtn").css("display").toLowerCase() != "none")?$(window).width() - $(".header").find(".mo-header-rightBtn").offset().left:20;
			var sum = (diff1 + $input.offset().left);
			if(check == "center") return;
			var style_width = "calc(100vw - " + sum + "px)";
			$input.css("width",style_width);
			//
			
		}

		// 한줄 소개 x 버튼 이벤트
		function btnDel() {
			$(".lg ").removeClass('disabled');
		}
		
		function cancelEdit(){
			isChangedFormValue();

			if( isChange || isImgChange ){
				
				ui.confirm('<spring:message code='front.web.view.petlog.myprofile.edit.cancel.msg.confirm' />',{ // 컨펌 창 띄우기
					ycb:function(){
						storageHist.goBack();
						//location.href="/log/home";			 
						return 
					},
					ncb:function(){
						return false;
					},
					ybt:'<spring:message code='front.web.view.common.yes' />',
					nbt:'<spring:message code='front.web.view.common.no' />'	
				});
			}else{
				storageHist.goBack();
			}
		}
		
		// 프로필 등록
		function insertMemberProfile(){
			// 컨펌 없이 저장.
			//if(confirm("<spring:message code='front.web.view.common.msg.confirm.insert' />")){
				var options = {
					url : "<spring:url value='/log/memberInfoSave' />"
					, data : $("#memberBaseForm").serialize()
					, done : function(data){
						storageHist.replaceHist();
						goMyPetLog("${memberBase.petLogUrl}", "${memberBase.mbrNo}" , undefined , 'Y');
					}
				};
				ajax.call(options);
			//}
		}	
		
		
		function backupFormValue() {
			  bSerialize = $('#memberBaseForm').serialize();
			  //alert(bSerialize);
			}

		function isChangedFormValue() {
		  var cSerialize = $('#memberBaseForm').serialize();
			//alert(cSerialize);

		  if(bSerialize != cSerialize) {
			  isChange = true;
		  }else {
			  isChange = false;
		  }
		}
	</script>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content">
		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container page logmain" id="container">
			<div class="inr">
			<form id="memberBaseForm" name="memberBaseForm" method="post" style="width:100%;">
				<input type="hidden" name="mbrNo"  value="${memberBase.mbrNo}"/>
				<!-- 본문 -->
				<div class="contents log my" id="contents">
					<!-- 페이지 헤더 -->
					<!-- mobile 
					<div class="pageHead">
						<div class="inr">
							<div class="hdt">
								<button class="back" type="button">뒤로가기</button>
								<h2 class="subtit">프로필 편집</h2>
							</div>
							<div class="mdt">
								<a href="javascript:;" class="golist gray">저장</a><!--- golist gray : 회색 // golist : 파란색  
							</div>
						</div>
					</div>-->
					<!-- // mobile -->
					<!-- // 페이지 헤더 -->
					<!-- align wrap-->
					<div class="logProfileAalignWrap">
						<!-- 프로필 사진 -->
						<div class="my-picture big">
							<p class="picture" id="profile_image">
									<img src="${memberBase.prflImg eq null or memberBase.prflImg eq ''?'../../_images/common/icon-img-profile-default-m@2x.png': frame:optImagePath(memberBase.prflImg, frontConstants.IMG_OPT_QRY_764)  }" alt="img" id="prflImg_pv">
							</p>
									<button class="btn edit" id="btnImgEdit" onclick="imageUpload();return false;" data-content="" data-url="/common/fileUploadResult">
						</div>
						<!-- // 프로필 사진 -->
						<!-- 정보 입력 -->
						<div class="member-input">
							<ul class="list">
								<li style="margin-bottom:0;">
									<strong class="tit"><spring:message code='front.web.view.petlog.myprofile.intro.title' /></strong>
									<div class="input">
										<!-- <div class="input del coms"><input type="text" name="petLogItrdc" id="petLogItrdc" placeholder="<spring:message code='front.web.view.petlog.mypet.intro.preview' />" value="${memberBase.petLogItrdc}"><button type="button" class="btnDel" onclick="btnDel();" tabindex="-1"><spring:message code='front.web.view.goods.delete.btn' /></button></div> -->
										<!-- APET-1104 210611 lju02 -->
										<div class="textarea">
											<textarea class="introduction" name="petLogItrdc" id="petLogItrdc"  placeholder="<spring:message code='front.web.view.petlog.mypet.intro.preview' />">${memberBase.petLogItrdc}</textarea>
											<button type="button" class="btn_del" onclick="btnDel();" tabindex="-1"><spring:message code='front.web.view.goods.delete.btn' /></button>
										</div>
										<!-- //APET-1104 210611 lju02 -->
									</div>
									<p class="validation-check t2 po"></p>
								</li>
							</ul>
						</div>
						<c:choose>
						<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
						<!-- // 정보 입력 -->
						<div class="btnSet logPosition">
							<a href="javascript:cancelEdit();" class="btn lg b"><spring:message code='front.web.view.common.msg.cancel' /></a>
							<a href="javascript:memberProfileSave();" class="btn lg a disabled"><spring:message code='front.web.view.common.save.button.title' /></a>
						</div>
						</c:when>
						<c:otherwise>
						<!-- <div class="pbt pull log_basicPw mt60">
							<div class="btnSet">
								<a href="javascript:memberProfileSave();" class="btn lg a disabled">저장</a>
							</div>
						</div> -->
						<div class="btnSet moBtn">
							<a href="javascript:memberProfileSave();" class="btn lg a disabled"><spring:message code='front.web.view.common.save.button.title' /></a>
						</div>
						</c:otherwise>
						</c:choose>
						<!-- // btn -->
						<!-- // 버튼 -->
					</div>
				</div>
			</div>
		</form>			
		</main>
	
	</tiles:putAttribute>
			
</tiles:insertDefinition>