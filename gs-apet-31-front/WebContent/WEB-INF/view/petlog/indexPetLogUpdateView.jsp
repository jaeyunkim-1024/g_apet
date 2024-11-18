<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<tiles:insertDefinition name="common_my_mo">

    <tiles:putAttribute name="script.include" value="script.petlog"/> <!-- 지정된 스크립트 적용 -->
    
	<tiles:putAttribute name="script.inline">	

 	<script>
 		var toastH = 74;
		$(function(){
			/* 사진선택 높이 */
			var h = ($(window).height() + 18 - ($(".lmp_addpicBt:eq(0)").offset().top + $(".lmp_addpicBt:eq(0)").height() - $(window).scrollTop() - 14)) / ($(window).height() * 0.01) - 5;/* 2021.02.24 : 수정 */
			$(".logCommentBox").data("priceh",h+"%");
			$(".logCommentBox .btn_right,.logCommentBox .btn_left").click(function(){
				$("body").removeClass("open_mode_both");
			});
			/* 2021.02.24 : 스크립트 추가 */
			$(".log_tagTextBox textarea").focus(function(){
				var placeholderMsg = "오늘은 어떤 추억이 있었나요?";
				if("${petLogBase.petLogChnlCd}" == "${frontConstants.PETLOG_CHNL_20}"){
					placeholderMsg = "구매 상품에 대한 후기를 남겨주세요";
				}
				
				//$(this).css("max-height","150px"); /* 2021.06.30 수정함 */ 2021.07.16 수정함
				ui.lock.using(true); //2021.04.19 추가 
				$(".log_makePicWrap").slideUp(250);
				$("html,body").stop().animate({"scroll-top":0},300,function(){
					$(".dim_box_w").css("top",($(".log_tagTextBox").offset().top + $(".log_tagTextBox").innerHeight() + 20)).removeClass("hide");
				});
				$(this).closest(".log_basicPw").css("margin-top",0).next().addClass("border_on");
				$(".mo-header-close, .btnSet").hide();
				//$(".mo-header-backNtn").hide();
				if($(".dim_box_w").length == 0) $("body").append("<div class='dim_box_w hide'></div>");
				$(".lttbTagArea").show();
				$("#area_pop_loc").attr("onClick" , "");
				$(".mo-header-rightBtn").show().find(".mo-header-btnType01").text("완료").show().click(function(){
					ui.lock.using(false);
					$(".log_makePicWrap").slideDown(250);
					$(".log_basicPw").css("margin-top","").next().removeClass("border_on");
					$(".mo-header-rightBtn").hide().find(".mo-header-btnType01").hide()
					$(".dim_box_w").remove();
					$(".lttbTagArea").hide();
					$(".log_tagTextBox textarea").css("max-height","none").attr("placeholder",placeholderMsg); /* 2021.06.30 수정함 */
					
					if("${petLogBase.petLogChnlCd}" == "${frontConstants.PETLOG_CHNL_20}"){
						$(".mo-header-backNtn, .btnSet").show();
					}else{
						$(".mo-header-close, .btnSet").show();
					}
					$("#area_pop_loc").attr("onClick" , "popupPetLogInsertLoc('U');");
				});
				/* 04.21 */
				$(".dim_box_w").click(function(){
					ui.lock.using(false);
					$(".log_makePicWrap").slideDown(250);
					$(".log_basicPw").css("margin-top","").next().removeClass("border_on");
					$(".mo-header-rightBtn").hide().find(".mo-header-btnType01").hide()
					$(".dim_box_w").remove();
					$(".lttbTagArea").hide();
					$(".log_tagTextBox textarea").css("max-height","none").attr("placeholder",placeholderMsg); /* 2021.06.30 수정함 */
					
					if("${petLogBase.petLogChnlCd}" == "${frontConstants.PETLOG_CHNL_20}"){
						$(".mo-header-backNtn, .btnSet").show();
					}else{
						$(".mo-header-close, .btnSet").show();
					}
					$("#area_pop_loc").attr("onClick" , "popupPetLogInsertLoc('U');");
				})
				
				// 2021.07.16추가함 starto
				$(".log_tagTextBox").on("keypress", "textarea", function(e) {
					if( $(".log_tagTextBox textarea").outerHeight() < 149 ) {
						$(this).css("max-height","none");
						document.ontouchmove = function(event){
						    //event.preventDefault();
							return false;
						}
						//alert("150보다 작음");
					}else if( $(".log_tagTextBox textarea").outerHeight() > 149 ) {
						document.ontouchmove = function(event){
							return;
						}
					}
		         });
				// 2021.07.16 추가함 end
				
			});
			/* 바톰시트 끌어서 내릴때 일어나는 이벤트 */
			$(".logCommentBox").bind("popCloseEvent",function(){
				closePictureCon();
			});
			/* 스와이퍼 */

		/* 	var madePetlog = new Swiper(".log_makePicWrap .swiper-container", {
      			slidesPerView: 'auto',
				slidesPerGroup:1,
				spaceBetween: 22,
				freeMode: true,
      			centeredSlides: true,
			});
		 */
			$(".lttbTagArea ul li").click(function(){
				let  txt = $(this).text();
				$(".log_tagTextBox textarea").val(txt);
			});

		// APETQA-5398 2021.07.20 추가함 start
			$(".lttbTagArea").bind("touchstart",function(e){
				document.ontouchmove = function(event){
					return;
				}
			}).bind("touchmove",function(e){
				document.ontouchmove = function(event){
					return;
				}
			}).bind("touchend",function(e){
				document.ontouchmove = function(event){
					return;
				}
			}).bind("mousedown",function(e){
				document.ontouchmove = function(event){
					return;
				}
			}).bind("click",function(e){
				document.ontouchmove = function(event){
					return;
				}
			});
			
			$(".log_tagTextBox > textarea").bind("touchstart",function(e){
				document.ontouchmove = function(event){
					return;
				}
			}).bind("touchmove",function(e){
				document.ontouchmove = function(event){
					return;
				}
			}).bind("touchend",function(e){
				document.ontouchmove = function(event){
					return;
				}
			}).bind("mousedown",function(e){
				document.ontouchmove = function(event){
					return;
				}
			}).bind("click",function(e){
				document.ontouchmove = function(event){
					return;
				}
			});
			// APETQA-5398 2021.07.20 추가함 end
			
		});
		/* 바톰시트 오픈 시 */
		function openPictureCon(){
			// 편집/삭제 버튼 hide
			$(".swiper-wrapper .swiper-slide").each(function(i, v) {
				 $(this).children("a").not("a.first").addClass("onWeb_b");  // 추가/편집 버튼도 포함
				 $(this).children("div").find(".pic_icon").addClass("onWeb_b");
			});
			$("body").addClass("open_mode_both");
			callAppFunc('onOpenGallery');
		};
		/* 바톰시트 닫을 시 */
		function closePictureCon(){
			$("body").removeClass("open_mode_both");
			// 편집/삭제 버튼 show
			$(".swiper-wrapper .swiper-slide").each(function(i, v) {
				 $(this).children("a").removeClass("onWeb_b");
				 $(this).children("div").find(".pic_icon").removeClass("onWeb_b");
			});
			reloadImageView("U"); // 2021.04.22 추가
		};
	</script>
	<script>
		var beforeImg = {
			cnt : function(){
				var newImgCnt = 0;
				var petLogNo = '${petLogBase.petLogNo}';
				
				$("li .pic img").each(function(i, v) {
					if( $(this).attr("id").indexOf(petLogNo) > -1 ){
						newImgCnt++;
					}
				});
				return newImgCnt;
			}
		};	

		$(function(){
			$("#dscrt").change();
			var title;
			var logComment;
			var cancleUrl;
			var goodsYn = "${goodsYn}";
			if(document.referrer.indexOf("/mypage/comment") > -1 && !goodsYn){
				cancleUrl = "/mypage/goodsCommentList?selectTab=aftTab" 
			}else{
				cancleUrl = null
			}
			
		   var textAcont = $(".log_tagTextBox textarea");
		    textAcont.css({"max-height":"none"});
		    
		    $(".log_tagTextBox").on("keypress", "textarea", function(e) {
		        $(this).height(this.scrollHeight - 40);
		    });
		    $(".log_tagTextBox").find("textarea").keypress();
			
		    
      		// 2021.07.16 추가함 start
	         if( $(".log_tagTextBox textarea").outerHeight() > 149 ) {
				document.ontouchmove = function(event){
					return;
				}
			 }

	         $(".log_tagTextBox textarea").click(function(){
		         textAcont.css({"max-height":"150px"});
			 });
			 // 2021.07.16 추가함 end
		    
			$("#header_pc").removeClass("mode0");
			$(".mo-header-backNtn").removeAttr("onclick");
			
			if("${petLogBase.petLogChnlCd}" == "${frontConstants.PETLOG_CHNL_20}"){
				title = "<spring:message code='front.web.view.new.menu.log'/>  후기 수정";
				$("#header_pc").addClass("mode7-1");
				logComment = "Y";
			}else{ 
				//APET-1250 210728 kjh02 
				title = "<spring:message code='front.web.view.new.menu.log'/>  수정";   
				$("#header_pc").addClass("mode8");
			}
			
			if("${view.deviceGb}" != "${frontConstatns.DEVICE_GB_10}"){
				$(".menubar").remove();
				$("#header_pc").addClass("noneAc")
			}
			
			//temp 퍼블리싱 수정 시 삭제
			$(".mo-heade-tit .tit").css("text-align" , "center")
			
			$(".mo-heade-tit .tit").html(title);	
			$(".mo-header-backNtn , .mo-header-close").click(function(){
				// APET-1250 210728 kjh02 
				ui.confirm("<spring:message code='front.web.view.new.menu.log'/> 수정을 취소할까요?"    ,{
					ycb : function(){
						/* var back = "${goodsYn}" != "" ? -2 : -1; */
						if(cancleUrl){
							location.href = cancleUrl; 	
						}else{
							"${goodsYn}" != "" ? history.go(-2) : location.href="/log/home";
						}
					},
					ncb : function(){	
					},
					ybt:'예',
					nbt:'아니오'	
				})
			})

			//위치 정보 변경 시에도 유효성 체크
			$(document).on('propertychange change keyup paste input', '#pstNm', function(){
				if( isChangedFormValue()){
					isChange  = true;
					$("#commitBtn").removeClass("disabled");
				}else{
					isChange  = false;
					$("#commitBtn").addClass("disabled");
				}
			});
			
			<c:if test="${petLogBase.petLogChnlCd == frontConstants.PETLOG_CHNL_20}">
				$('textarea[name=dscrt]').on('propertychange keyup input change paste ', function(){
					var imgCnt = $(".pic img").length;
					var dscrtCnt = $('#dscrt').val().replaceAll(' ', '').length;
					
					if(imgCnt != 0 && dscrtCnt >= 10 ){
						$(".btnSet > .a").removeClass("disabled");
					}else{
						$(".btnSet > .a").addClass("disabled");
					}
				});
			</c:if>
		});

		function requestPV(){
			var imgCnt = $(".pic img").length;
			var cont = $('#dscrt').val();
			const regExp = /([ㄱ-ㅎ|ㅏ-ㅣ|!?@#$%^&*():;+-=~{}<>\_\[\]\|\\\"\'\,\.\/\`\₩])\1\1\1/g;
			
			if(imgCnt==0){
				ui.toast('사진 또는 영상을 등록해주세요',{
				    bot:70
				});
			}else{ 
				<c:if test="${petLogBase.petLogChnlCd == frontConstants.PETLOG_CHNL_20}">
				if(cont.length == 0 || (cont.length != 0 && cont.replaceAll(' ', '').replaceAll('\n','').length < 10)){
					//공백 제외 문자열 10자 미만
					//문구 : 최소 10자 이상 입력해주세요
					ui.toast('최소 10자 이상 입력해주세요',{
						bot:70
					});
					return false;
				}else if(regExp.test(cont)){
					//문구 : 자음/모음/특수문자는 4회 이상 연속 입력할 수 없습니다
					ui.toast('자음/모음/특수문자는 4회 이상 연속 입력할 수 없습니다',{
						bot:70
					});
					return false;
				}
				</c:if>
				
				checkUpdate();
			}
		}
		
	</script>
	
	
	
	
	<script type="text/javascript">

		
/* 		function changeImageVod(){
			var beforeImgCnt = parseInt('${petLogBase.imgCnt}');	
			var oldImgCnt = 0
			var newImgCnt = 0;
			var petLogNo = '${petLogBase.petLogNo}';
			
			$("li .pic img").each(function(i, v) {
				if( $(this).attr("id").indexOf(petLogNo) > -1 ){
					oldImgCnt++; // 기존 등록 이미지 
				}else{					
					newImgCnt++; // 새로 선택한 이미지
				}
			});			
			alert(oldImgCnt+","+newImgCnt);			
			if(oldImgCnt !=  newImgCnt || newImgCnt >0 ) return true;
			else return false;
		} */
		
		function changeImageVod(){
			var imgCnt = $(".pic img").length;
			var oldImgCnt = 0;			
			$("li .pic img").each(function(i, v) {
				var updateImgId = $(this).attr("data-update-id");
				if( updateImgId !== undefined && updateImgId != null && updateImgId != '' ){
					oldImgCnt++;
				}
			});	
		
			// 등록된 이미지를 모두 삭제했거나, 이미지가 달라졌거나
			if( imgCnt == 0 || oldImgCnt != imgCnt ){
				return true;
			}
	  		else{
	  			return false;
	  		}
		}
		
		
		
		
		
		function checkUpdate(){			
			var newImgCnt = 0;
			var petLogNo = '${petLogBase.petLogNo}';
			$("li .pic img").each(function(i, v) {
				if( $(this).attr("id").indexOf(petLogNo) < 0 ){
					newImgCnt++; // 새로 선택한 이미지
				}
			});
			if(isChange){
				savePetLogBase($('#petLogBaseForm [name="saveGb"]').val());
			}else{
				return false;
			}
			//alert("newImgCnt:"+newImgCnt);
// 			if( newImgCnt > 0){ 
// 				if( isFileUploadCallBack ){  // 이미 file upload 되었고, 수정 - 취소 했다가 다시 등록하는 경우는 바로 save.
// 					//alert("newImgCnt222:"+newImgCnt);
// 					savePetLogBase($('#petLogBaseForm [name="saveGb"]').val());
// 				}else{
// 					//alert("newImgCnt111:"+newImgCnt);
// 					callAppFunc('onFileUpload', '${session.getMbrNo()}');
					
// 				}
// 			}else{
				//alert("newImgCnt333:"+newImgCnt);
				
// 			}
		}
		
		function onEnableKeyboardEventCallBack(data){
			toastH = Number(data) + 74;	
		}
		
		function backupFormValue() {
			  bSerialize = $('#petLogBaseForm').serialize();
			  //alert(bSerialize);
			}

		function isChangedFormValue() {
		  var cSerialize = $('#petLogBaseForm').serialize();
			//alert(cSerialize);

		  if(bSerialize != cSerialize) {
			  //alert("11");
		    return true;
		  }else {
			  //alert("22");
		    return false;
		  }
		}
	
	
	var isChange = false;
	$(function(){
		if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
			toNativeData.func = "onEnableKeyboardEvent";
			toNativeData.callback = "onEnableKeyboardEventCallBack";
			toNative(toNativeData);
		}
		
		var bSerialize = null;
		backupFormValue();
		
		resizeImg();
		
		reloadImageView("U");
		
		
		$("input, textarea").change(function(){
			//isChange  = true;
			//alert("111");
// 			var imgCnt = $(".pic img").length;
// 			if(imgCnt <= 0){
// 				$(".btnSet a").addClass("disabled");
// 			}else{
// 				$(".btnSet a").removeClass("disabled");
// 			}
			if($("#chkGoodsRcomYn").is(":checked")) {
				$("#goodsRcomYn").val("Y");
			}else{
				$("#goodsRcomYn").val("N");
			}
			
			var dscrtCnt = 10;
			
			if("${petLogBase.petLogChnlCd}" == "${frontConstants.PETLOG_CHNL_20}"){
				dscrtCnt = $('#dscrt').val().replaceAll(' ', '').length;
			}
			if( isChangedFormValue() && dscrtCnt >= 10){
				isChange  = true;
				$("#commitBtn").removeClass("disabled");
			}
			else{
				isChange  = false;
				$("#commitBtn").addClass("disabled");
			}
			reloadImageView("U");
		});
		
		// X 버튼 클릭
// 		$(".mo-header-close").click(function(){
// 			if(isChangedFormValue() || changeImageVod() ){		
				
// 				ui.confirm('펫로그 수정을 취소할까요?',{ // 컨펌 창 옵션들
// 					ycb:function(){
// 						history.back();
// 					},
// 					ncb:function(){
// 						return false;
// 					},
// 					ybt:"예", // 기본값 "예"
// 					nbt:"아니오"  // 기본값 "아니오"
// 				});		
				
// 			}else{
// 				//alert("변경없음");
// 				history.back();
// 			}				
// 		});
		

		// event type은 변경하셔도 됩니다. 
		$(document).on("input keyup click", "textarea[name=dscrt]", function(e) {
			//$("#realTimeTag").val("");// <- 예시를 위한 input 태그입니다. 실사용시에는 삭제
			let element = document.getElementById('dscrt');
			let strOriginal = element.value;
			strOriginal = strOriginal.substr(0, element.selectionStart);
			var inTag = strOriginal.indexOf('#');
			if(inTag > -1) {
				$(".lttbTagArea").css("display", "block");
    		}else {
    			$(".lttbTagArea").css("display", "none");
    		}
			if (strOriginal.indexOf('\#') > -1) {
				let iStartPos = element.selectionStart;
				let iEndPos = element.selectionEnd;
				let strFront = "";
				let strEnd = "";
				firstChar = "\#"
				if(iStartPos == iEndPos) {
					String.prototype.startsWith = function(str) {
						if (this.length < str.length) { return false; }
						return this.indexOf(str) == 0;
					}
					
					strFront = strOriginal.substring(0,iStartPos)
					var hashTagChar =0;
					
					for(var i =0; i<strFront.length; i++){
						if(strFront[i] == firstChar){
							//#은 추천리스트에 노출되지 않게 하기 위해
							hashTagChar = i+1
						}
					}
					var fromHashTag =  strOriginal.substring(hashTagChar, strOriginal.length)
					var hashTagFind = new RegExp(/[^#\s\<\>\@\&\\']*/, 'g')
					var hashTagReplLength = fromHashTag.match(hashTagFind)[0].length
					searchTagTxt =  strOriginal.substring(hashTagChar, hashTagChar+hashTagReplLength)
					
					//태그가 끝나는 지점에서 공백이나 개행문자가 있을 시 추천리스트 노출하지 않음.
					if(strFront.lastIndexOf('#') < strFront.lastIndexOf(' ')
							|| strFront.lastIndexOf('#') < strFront.lastIndexOf('\n')){
						searchTagTxt = "";
					}
					
					// searchTagTxt 로 태그검색하시면 됩니다.
					if( searchTagTxt != '' ){
						//console.log('searchTagTxt', searchTagTxt);
						fnGetAutocomplete(searchTagTxt);
					}
					else{
						$("#add_tag_list").html("");
					}
				} else return;
			}
		});
		
		$(document).on("input change paste" , "#dscrt" , function(){
			var value = $(this).val();
			//console.log(value.length);
			if(value.length > 500){ 
				ui.toast('내용은 500자까지 입력할 수 있어요.',{
				    bot:toastH  // 바닥에서 띄울 간격
				    //,sec:1000 // 사라질 시간 number
				});
				$(this).val(value.substr(0 , 500));
			}
		});


	});
	
	</script>	
	
	</tiles:putAttribute>

	<tiles:putAttribute name="content">
		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container page" id="container">
			<div class="inr">
			<form id="petLogBaseForm" name="petLogBaseForm" method="post" style="width:100%;">
			<input type="hidden" id="petLogNo" name="petLogNo" value="${petLogBase.petLogNo}" /><!-- 펫로그 번호 -->
			<input type="hidden" id="goodsRcomYn" name="goodsRcomYn" value="${petLogBase.goodsRcomYn}" /><!-- 연관상품추천 여부 -->
			<input type="hidden" id="petLogChnlCd" name="petLogChnlCd" value="${petLogBase.petLogChnlCd}"/><!-- 펫로그 채널 코드 : 펫로그-10 -->
			<input type="hidden" id="logLitd" name="logLitd" /><!-- 경도 -->	
			<input type="hidden" id="logLttd" name="logLttd" /><!-- 위도-->	
			<input type="hidden" id="prclAddr" name="prclAddr" /><!-- 지번주소 -->	
			<input type="hidden" id="roadAddr" name="roadAddr" value="${petLogBase.roadAddr}"/><!-- 도로주소 -->	
			<input type="hidden" id="pstNm" name="pstNm" value="${petLogBase.pstNm}"/><!-- 위치 명 -->	
			<input type="hidden" id="saveGb" name="saveGb" value="U"/><!-- 등록/수정(I/U) -->
			<textarea id="orginDscrt" name="orginDscrt" style="display:none;">${petLogBase.dscrt }</textarea>
				<!-- 본문 -->
				<div class="contents log made" id="contents">
					<!-- log head-->
<!-- 					<div class="log_hanBoxTop">
						<a href="javascript:history.back();" class="lhbt_btn l">취소</a>
						<div class="tit">펫로그 만들기</div>
						<a href="#" onclick="updatePetLogBase();" class="lhbt_btn r active_color">수정</a>파란색 color 'active_color' class 추가
					</div> -->
					<!-- //log head-->
                    <!-- picture -->
					<div class="log_makePicWrap">
						<div class="con swiper-container">
							<ul class="swiper-wrapper" id="add_image_list">
								<li class="swiper-slide" id="addPicFirstLi">
									<a href="javascript:;" class="lmp_addpicBt first" onClick="openPictureCon();"><!-- ui.commentBox.open('.logCommentBox');openPictureCon() -->
										<div>
											<span class="lmp_addPicIcon"></span>
											<div class="txt">사진 또는 영상을 등록해주세요.</div>
										</div>
									</a>
								</li>
		<c:choose>							
			<c:when test="${petLogBase.vdPath ne null and petLogBase.vdPath ne ''}">
								<li class="swiper-slide">
									<%-- <a href="javascript:callAppFunc('onDeleteUpdateImage','${petLogBase.petLogNo}_0');" class="lmp_colseBt"></a> --%>
									<div class="pic">
										<img  class="img" id="${petLogBase.petLogNo}_0" src="${petLogBase.vdThumPath}" alt="V" data-update-id="${petLogBase.petLogNo}_0" style="width:100%;">
									</div>
									<input type='hidden' name='vdPath' value='${petLogBase.vdPath}' />
									<input type='hidden' name='vdThumPath' value='${petLogBase.vdThumPath}' />
								</li>
			</c:when>
			<c:otherwise>						
						<c:set var="imgPathList" value="${fn:split(petLogBase.imgPathAll,'[|]')}" />
							<c:forEach items="${imgPathList}" var="imgPath" varStatus="idx">
								<li class="swiper-slide">
									<%-- <a href="javascript:callAppFunc('onDeleteUpdateImage','${petLogBase.petLogNo}_${idx.index}');" class="lmp_colseBt"></a> --%>
									<div class="pic">
										<img  class="img" id="${petLogBase.petLogNo}_${idx.index}" src="${frame:optImagePath(imgPath,frontConstants.IMG_OPT_QRY_773)}" alt="I" data-update-id="${petLogBase.petLogNo}_${idx.index}">
									</div>
									<input type='hidden' name='imgPath' value='${imgPath}' />
								</li>
							
							</c:forEach>		
						
<%-- 						<c:forEach items="${petLogBase.imgPathList}" var="imgPaths" varStatus="idx">
								<li class="swiper-slide">
									<a href="javascript:callAppFunc('onDeleteUpdateImage','${petLogBase.petLogNo}_${idx.index}');" class="lmp_colseBt"></a>
									<div class="pic">
										<img  class="img" id="${petLogBase.petLogNo}_${idx.index}" src="${frame:optImagePath(imgPaths, frontConstants.IMG_OPT_QRY_460)}" alt="I" data-update-id="${petLogBase.petLogNo}_${idx.index}">
									</div>
									<input type='hidden' name='imgPath' value='${imgPaths}' />
								</li>
							</c:forEach> --%>	
		</c:otherwise>
	</c:choose>														
<!-- 								<li>
									<a href="javascript:;" class="lmp_addpicBt">
										<div>
											<span class="lmp_addPicIcon"><input type="file" class="input_file" title="파일첨부" onclick="javascript:imageUpload(); return false;"/> 파일찾기</span>
											<div class="txt">추가/편집</div>
										</div>
									</a>
								</li> -->
							</ul>
						</div>
					</div>
                    <!-- // picture -->
					<!-- bagic wrap-->
					<div class="log_basicPw">
						<!-- tag -->
						<div class="log_tagTextBox">
							<!-- 2021-01-18 : 수정 -->
							<!-- 등록화면 -->
							<div class="byte" id="dscrt_byte" style="display:none;"></div>
							<!-- 입력창 -->							
							<c:if test ="${petLogBase.petLogChnlCd ne frontConstants.PETLOG_CHNL_20 }">
								<textarea name="dscrt" id="dscrt" placeholder="오늘은 어떤 추억이 있었나요?">${petLogBase.dscrt}</textarea>
							</c:if>
							<c:if test ="${petLogBase.petLogChnlCd eq frontConstants.PETLOG_CHNL_20 }">
								<textarea name="dscrt" id="dscrt" placeholder="구매 상품에 대한 후기를 남겨주세요">${petLogBase.dscrt}</textarea>
							</c:if>
							<!-- tag 셀렉터 부분 -->
							<div class="lttbTagArea" style="display:none;"><!--  border-bottom 있음 -->
								<ul id="add_tag_list">
								</ul>
							</div>
							<!-- // tag 셀렉터 부분 -->
							<!-- // 2021-01-18 : 수정 -->
						</div>
						<!-- // tag -->
					</div>
					<!-- // bagic wrap-->
					<!-- top borader box-->
	<c:choose>
		<c:when test="${petLogBase.pstNm == null or petLogBase.pstNm == ''}">
					<div class="log_topBbox locaRegi" id="area_pop_loc" onclick="javascript:popupPetLogInsertLoc('U');"> <!-- log_topBbox border-top 있음 -->
						<div class="top_tit">
						<div class="tit">위치 등록</div>
						<a href="javascript:;" class="log_arrIcon"></a></div>
					</div>
					<div class="log_pointEnterList  onWeb_b"> <!-- log_pointEnterList border-top 삭제 -->
						<ul>
						</ul>
					</div>
		</c:when>
		<c:otherwise>
					<div class="log_topBbox locaRegi onWeb_b" id="area_pop_loc" onclick="javascript:popupPetLogInsertLoc('U');" > <!-- log_topBbox border-top 있음 -->
						<div class="top_tit">
						<div class="tit">위치 등록</div>
						<a href="javascript:;" class="log_arrIcon"></a></div>
					</div>
					<div class="log_pointEnterList ">
						<ul>
							<li>
								<div class="tit">${petLogBase.pstNm}</div>
								<div class="con">${petLogBase.roadAddr}</div>
								<a href="javascript:deleteLoc('U');" class="log_pelClose"></a>
							</li>
						</ul>
					</div>
		
		</c:otherwise>
	</c:choose>					
<%-- 					<div class="log_topBbox <c:if test="${petLogBase.pstNm != null and petLogBase.pstNm != ''}">onWeb_b</c:if>" id="area_pop_loc" >
						<div class="top_tit" style="padding-bottom:5px;">
						<div class="tit">위치 등록</div>
						<a href="javascript:popupPetLogInsertLoc();" class="log_arrIcon"></a></div>
					</div>
					<!-- // tag -->
					<!-- 위치등록 리스트?? -->
					<div class="log_pointEnterList mt16">
						<ul>
							<li>
								<div class="tit">|${petLogBase.pstNm.length()}|</div>
								<div class="con">${petLogBase.roadAddr}</div>
								<a href="javascript:deleteLoc();" class="log_pelClose"></a>
							</li>
						</ul>
					</div> --%>
					<!-- // 위치등록 리스트?? -->
					<!-- top borader box-->
					<c:if test ="${petLogBase.petLogChnlCd ne frontConstants.PETLOG_CHNL_20 }">
						<div class="log_topBbox">
							<div class="top_tit"><div class="tit">연관상품 추천받기</div></div>
							<div class="con_input">
								<label class="checkbox">
								<input type="checkbox" id="chkGoodsRcomYn" <c:if test="${petLogBase.goodsRcomYn eq 'Y'}">checked="checked"</c:if>><span class="txt">등록한 정보와 관련있는 상품을 추천합니다.</span></label>
							</div>
						</div>	
					</c:if>
					<!-- // top borader box-->
					<!-- 2021.03.04 : 추가 -->
					<!-- btn -->
					<div class="btnSet set_01">
						<c:if test ="${petLogBase.petLogChnlCd eq frontConstants.PETLOG_CHNL_20 }">
							<a href="#" onclick ="history.go(-1);return false;" class="btn lg d">이전</a>
						</c:if>
						<a id="commitBtn" href="javascript:requestPV();" class="btn lg a disabled" style="pointer-events:all;">완료</a>
					</div>
					<c:if test ="${petLogBase.petLogChnlCd eq frontConstants.PETLOG_CHNL_20 }">
					<div class="set gud n2">
						<div class="hdt">
							<span class="tit">유의사항</span>
						</div>
						<div class="info-txt">
							<ul> <!-- APET-1250 210728 kjh02  -->
								<li><spring:message code='front.web.view.new.menu.log'/> 후기 등록 시 MY 로그에도 작성한 게시글이 노출 됩니다.</li>
								<li><spring:message code='front.web.view.new.menu.log'/> 후기 등록 시 등록된 게시글에 '연관상품'에는 구매한 상품정보가 노출됩니다.</li>
								<c:if test="${gsReViewUseYn eq frontConstants.COMM_YN_Y}">
									<li><spring:message code='front.web.view.new.menu.log'/> 후기 작성 후 발급되는 GS&POINT는 로그 후기 삭제 시 회수될 수 있습니다.</li>
								</c:if>
							</ul>
						</div>
					</div>
					</c:if>
					<!-- // btn -->
					<!-- // 2021.03.04 : 추가 -->					
				</div>
			</div>
			</form>
		</main>
		
		<script>
			var madePetlog = new Swiper(".log_makePicWrap .swiper-container", {
				slidesPerView: 2,
				//slidesPerGroup:1,
				spaceBetween: 22,
				//freeMode: true,
				centeredSlides: true,
			});
		</script>
	</tiles:putAttribute>	
</tiles:insertDefinition>		
