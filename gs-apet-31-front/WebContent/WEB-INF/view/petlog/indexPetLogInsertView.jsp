<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%-- <%@ page import="front.web.config.constants.FrontWebConstants" %> --%>

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
					$(this).attr("placeholder","");
					//$(this).css("max-height","150px"); /* 2021.06.30 수정함 */ 2021.07.16 수정함
					ui.lock.using(true); //2021.04.19 추가
					$(".log_makePicWrap").slideUp(250);
					$("html,body").stop().animate({"scroll-top":0},300,function(){
						$(".dim_box_w").css("top",($(".log_tagTextBox").offset().top + $(".log_tagTextBox").innerHeight() + 20)).removeClass("hide");
					});
					$(this).closest(".log_basicPw").css("margin-top",0).next().addClass("border_on");
					$(".mo-header-close, .btnSet").hide();
					if($(".dim_box_w").length == 0) $("body").append("<div class='dim_box_w hide'></div>");
					$(".lttbTagArea").show();
					$("#area_pop_loc").attr("onClick" , "");
					$(".mo-header-rightBtn").show().find(".mo-header-btnType01").text("완료").show().click(function(){
						ui.lock.using(false);	//2021.04.19 추가
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
						$(".log_tagTextBox textarea").attr("placeholder",placeholderMsg);
						$("#area_pop_loc").attr("onClick" , "popupPetLogInsertLoc();");
					});
					/* 04.21 */
					$(".dim_box_w").click(function(){
						ui.lock.using(false);
						$(".log_makePicWrap").slideDown(250);
						$(".log_basicPw").css("margin-top","").next().removeClass("border_on");
						$(".mo-header-close, .btnSet").show();
						$(".mo-header-rightBtn").hide().find(".mo-header-btnType01").hide()
						$(".dim_box_w").remove();
						$(".log_tagTextBox textarea").attr("placeholder",placeholderMsg);
						$("#add_tag_list").html("")
						$(".log_tagTextBox textarea").css("max-height","none").attr("placeholder",placeholderMsg); /* 2021.06.30 수정함 */
						$("#area_pop_loc").attr("onClick" , "popupPetLogInsertLoc();");
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
				/*
                var madePetlog = new Swiper(".log_makePicWrap .swiper-container", {
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
					$(this).children("a").not("a.first").addClass("onWeb_b"); // 추가/편집 버튼도 포함
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

				reloadImageView("I"); // 2021.04.22 추가

			};

		</script>
		<script>
			var beforeImg = {
				cnt : function(){
					var newImgCnt = 0;
					return newImgCnt;
				}
			};

			$(function(){
				var title;
				var cancleUrl;
				var logComment;
				$("#header_pc").removeClass("mode0");
				$(".mo-header-backNtn").removeAttr("onclick");
				$(".mo-header-close").removeAttr("onclick");

				if("${petLogBase.petLogChnlCd}" == "${frontConstants.PETLOG_CHNL_20}"){
					title = "<spring:message code='front.web.view.new.menu.log'/> 후기 작성";
					// APET-1250 210728 kjh02 
					$("#header_pc").addClass("mode7-1");
					logComment = "Y"
				}else{ // APET-1250 210728 kjh02 
					title = "<spring:message code='front.web.view.new.menu.log'/> 만들기";  
					$("#header_pc").addClass("mode8"); 
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
				 
				if("${view.deviceGb}" != "${frontConstatns.DEVICE_GB_10}"){
					$(".menubar").remove();
					$("#header_pc").addClass("noneAc")
				}

				//temp 퍼블리싱 수정 시 삭제
				$(".mo-heade-tit .tit").css("text-align" , "center")

				$(".mo-heade-tit .tit").html(title);
				$(".mo-header-backNtn").click(function(){   
					/* APET-1250 210728 kjh02 */
					ui.confirm("<spring:message code='front.web.view.new.menu.log'/> 작성을 취소할까요?" ,{
						ycb : function(){
							logComment != null ? history.go(-2) : location.href ="/log/home"/* history.go(-1) */;
						}
					})
				})
			});

		</script>
		<script type="text/javascript">
			//console.log("별도의 스크립트 삽입 영역입니다.");
			$(document).ready(function(){
				reloadImageView("I");
			});
		</script>

		<script type="text/javascript">
			var isChange = false;

			$(function(){
				if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
					toNativeData.func = "onEnableKeyboardEvent";
					toNativeData.callback = "onEnableKeyboardEventCallBack";
					toNative(toNativeData);
				}
				
				var bSerialize = null;
				backupFormValue();

				// X 버튼 클릭
				$(".mo-header-close").click(function(){
					if(isChangedFormValue() || selectImageVod()){
						ui.confirm('로그 작성을 취소할까요?',{ // 컨펌 창 옵션들
							ycb:function(){
								location.href = "/log/home"; /* history.back(); */
							},
							ncb:function(){
								return false;
							},
							ybt:"예", // 기본값 "확인"
							nbt:"아니오"  // 기본값 "취소"
						});
					}else{
						location.href ="/log/home";/* history.back() */;
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
			
				$(document).on("input keyup click", "textarea[name=dscrt]", function(e) {
					let element = document.getElementById('dscrt');
					let strOriginal = element.value;
					strOriginal = strOriginal.substr(0, element.selectionStart);
					//replyTxt = replyTxt.substr(0, element.selectionStart).substr(replyTxt.lastIndexOf(' ') > -1 ? replyTxt.lastIndexOf(' ')+1 : 0);
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
							searchTagTxt = strOriginal.substring(hashTagChar, hashTagChar+hashTagReplLength)
							
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
				$(document).on("styleChange" , "#dscrt" , function(){
				})

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


			function onEnableKeyboardEventCallBack(data){
					toastH = Number(data) + 74;	
			}
			
			function backupFormValue() {
				bSerialize = $('#petLogBaseForm').serialize();
			}

			function isChangedFormValue() {
				var cSerialize = $('#petLogBaseForm').serialize();

				if(bSerialize != cSerialize) {
					return true;
				}else {
					return false;
				}
			}

			function isIOS(){
				var mobileKeyWords = new Array('iPhone', 'iPod');
				for (var word in mobileKeyWords) {
					if (navigator.userAgent.match(mobileKeyWords[word]) != null) {
						return true;
					}
				}
				return false;
				
		}
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
					
					callAppFunc('onFileUpload', '${session.getMbrNo()}');
				}
			}

		</script>

	</tiles:putAttribute>

	<tiles:putAttribute name="content">
		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container page" id="container">
			<div class="inr">
				<form id="petLogBaseForm" name="petLogBaseForm" method="post" style="width:100%;">
					<input type="hidden" id="contsStatCd" name="contsStatCd" value="10" /><!-- 컨텐츠 상태코드(10-노출, 20-미노출, 30-신고차단) -->
					<input type="hidden" id="rvwYn" name="rvwYn" value="N" /><!-- 후기여부 -->
					<input type="hidden" id="goodsRcomYn" name="goodsRcomYn" /><!-- 연관상품추천 여부 -->
					<input type="hidden" id="rltId" name="rltId"  value="${petLogBase.rltId}"/><!-- 연관아이디 -->
					<input type="hidden" id="goodsEstmNo" name="goodsEstmNo"  value="${petLogBase.goodsEstmNo}"/><!-- 상품후기번호 -->
					<input type="hidden" id="petLogChnlCd" name="petLogChnlCd" value="${petLogBase.petLogChnlCd}"/><!-- 펫로그 채널 코드 : 펫로그-10 -->
					<input type="hidden" id="ordNo" name="ordNo" value="${petLogBase.ordNo}"/><!-- 펫로그 채널 코드 : 펫로그-10 -->
					<input type="hidden" id="logLitd" name="logLitd" /><!-- 경도 -->
					<input type="hidden" id="logLttd" name="logLttd" /><!-- 위도-->
					<input type="hidden" id="prclAddr" name="prclAddr" /><!-- 지번주소 -->
					<input type="hidden" id="roadAddr" name="roadAddr" /><!-- 도로주소 -->
					<input type="hidden" id="pstNm" name="pstNm" /><!-- 위치 명 -->
					<input type="hidden" id="saveGb" name="saveGb" value="I"/><!-- 등록/수정(I/U) -->
					<!-- 본문 -->
					<div class="contents log made" id="contents"><!-- 2021.01.18 : class 추가 -->
						<!-- log head-->
						<!-- 					<div class="log_hanBoxTop">
                                                <a href="javascript:history.back();" class="lhbt_btn l">취소</a>
                                                <div class="tit">펫로그 만들기</div>
                                                <a href="javascript:insertPetLogBase();" class="lhbt_btn r active_color">등록</a>파란색 color 'active_color' class 추가
                                            </div> -->
						<!-- //log head-->
						<!-- picture -->
						<div class="log_makePicWrap">
							<div class="con swiper-container" id="insertSwiper">
								<ul class="swiper-wrapper" id="add_image_list">
									<li class="swiper-slide" id="addPicFirstLi">
										<a href="javascript:;" class="lmp_addpicBt first" onClick="openPictureCon();"><!-- ui.commentBox.open('.logCommentBox');openPictureCon() -->
											<!-- 									<a href="javascript:;" class="lmp_addpicBt first" onClick="onOpenGallery();"> -->
											<div>
												<span class="lmp_addPicIcon"></span>
												<div class="txt">사진 또는 영상을 등록해주세요.</div>
											</div>
										</a>
									</li>
									<!-- <li>
                                        <a href="javascript:;" class="lmp_colseBt"></a>
                                        <div class="pic">
                                            <img src="../../_images/_temp/log_logMade01.png" alt="">
                                        </div>
                                    </li> -->
									<!-- <li>
                                        <a href="javascript:onOpenGallery();" class="lmp_addpicBt">
                                            <div>
                                                <span class="lmp_addPicIcon"></span>
                                                <div class="txt">추가/편집</div>
                                            </div>
                                        </a>
                                    </li> -->
								</ul>
							</div>
						</div>
						<!-- // picture -->
						<!-- bagic wrap-->
						<div class="log_basicPw focus_on"><!-- 2021.02.24 : focus_on 클래스 추가 -->
							<!-- tag -->
							<div class="log_tagTextBox">
								<!-- 2021-01-18 : 수정 -->
								<!-- 등록화면 -->
								<!-- <div class="lttbTextArea none" >
                                    공백포함100자입니다👍 #해시태그 는파란색으로표시됩니다. 일이삼사오육칠팔구십 <span class="tagColor">#태그택태그</span> <span class="tagColor">#태그로그로그로그로그로그로</span> <a href="javascript:;" class="tagColor">#산책</a>
                                </div> -->
								<div class="byte" id="dscrt_byte" style="display:none;"></div>
								<!-- 입력창display:none; -->
										<c:if test ="${petLogBase.petLogChnlCd ne frontConstants.PETLOG_CHNL_20 }">
											<textarea name="dscrt" id="dscrt" placeholder="오늘은 어떤 추억이 있었나요?"><c:if test="${petLogBase.tag ne null and petLogBase.tag ne ''}">#</c:if><c:out value='${petLogBase.tag}' /></textarea>
										</c:if>
										<c:if test ="${petLogBase.petLogChnlCd eq frontConstants.PETLOG_CHNL_20 }">
											<textarea name="dscrt" id="dscrt" placeholder="구매 상품에 대한 후기를 남겨주세요"><c:if test="${petLogBase.tag ne null and petLogBase.tag ne ''}">#</c:if><c:out value='${petLogBase.tag}' /></textarea>
										</c:if>
								<!-- 							<div  contenteditable="true" id="petlog_content"></div> -->
								<!-- tag 셀렉터 부분 -->
								<div class="lttbTagArea" style="display:none;">
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
						<div class="log_topBbox locaRegi" id="area_pop_loc" onclick="javascript:popupPetLogInsertLoc();"> <!-- log_topBbox border-top 있음 -->
							<div class="top_tit" >
								<div class="tit">위치 등록</div>
								<a href="javascript:;" class="log_arrIcon"></a></div>
						</div>
						<!-- 					<div class="pointTxtArea">
                                                위치추천을 위해 위치서비스를 활성화 하세요.
                                            </div> -->
						<!-- // tag -->
						<div class="log_pointEnterList onWeb_b"> <!-- log_pointEnterList border-top 삭제 -->
							<ul>
							</ul>
						</div>
						<!-- top borader box-->
						<c:if test ="${petLogBase.petLogChnlCd ne frontConstants.PETLOG_CHNL_20 }">
							<div class="log_topBbox">
								<div class="top_tit"><div class="tit">연관상품 추천받기</div></div><!-- 2021.02.23 : inline style 추가 -->
								<div class="con_input">
									<label class="checkbox"><input type="checkbox" id="chkGoodsRcomYn"><span class="txt">등록한 정보와 관련있는 상품을 추천합니다.</span></label>
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
							<a href="javascript:requestPV()" class="btn lg a" style="pointer-events:all;">등록</a>
						</div>
						<!-- // btn -->
						<!-- // 2021.03.04 : 추가 -->
						<!-- 사진선택 -->
						<div class="commentBoxAp logCommentBox" data-priceh="100%">
							<div class="head">
								<div class="con">
									<div class="tit cen">
										사진선택
									</div>
									<a href="javascript:;" class="btn_left" onClick="ui.commentBox.close(this);openPictureCon();">완료</a><!-- 2021.02.24 : 온클릭이벤트 "openPictureCon" 함수 추가  -->
									<a href="javascript:;" class="btn_right logColorBlue" onClick="ui.commentBox.close(this);openPictureCon();" disabled>취소</a><!-- 'logColorBlue' 클래스 추가 시 파란색 글씨 //  'disabled' 제거 시 검정색 글씨 // 'disabled' attribute 있을 시 회식 글씨  --><!-- 2021.02.24 : 온클릭이벤트 "openPictureCon" 함수 추가  -->
								</div>
							</div>
							<div class="con">
								<div class="box full">
									<!-- content -->

									<!-- // content -->
								</div>
							</div>
						</div>
						<c:if test ="${petLogBase.petLogChnlCd eq frontConstants.PETLOG_CHNL_20 }">
							<div class="set gud n2">
								<div class="hdt">
									<span class="tit">유의사항</span>
								</div>
								<div class="info-txt">
									<ul>
										<li><spring:message code='front.web.view.new.menu.log'/>후기 등록 시 마이 펫로그에도 작성한 게시글이 노출 됩니다.</li>
										<li><spring:message code='front.web.view.new.menu.log'/> 후기 등록 시 등록된 게시글에 '연관상품'에는 구매한 상품정보가 노출됩니다.</li>
										<c:if test="${gsReViewUseYn eq frontConstants.COMM_YN_Y}">
											<li><spring:message code='front.web.view.new.menu.log'/> 후기 작성 후 발급되는 GS&POINT는 펫로그 후기 삭제 시 회수될 수 있습니다.</li>
										</c:if>
									</ul>
								</div>
							</div>
						</c:if>
						<!-- //사진선택 -->
					</div>
			</div>
			</form>
		</main>
	</tiles:putAttribute>
</tiles:insertDefinition>		
