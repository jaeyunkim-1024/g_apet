<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<tiles:insertDefinition name="default">


	<tiles:putAttribute name="script.inline">
	
	<script src="<spring:eval expression="@bizConfig['vod.player.api.url']" />/thumb_api/v1.js"></script>
	<style>
			/* 소리가 켜져있을때 아이콘 */
			.v_mutd_on{
				width:30px;
				height:30px;
				border-radius:100%;
				background-color:rgba(0,0,0,0.5);
				background-image:url(<spring:eval expression="@bizConfig['aboutpet.sgr.url']" />/dist/images/speaker-high-fill-white.svg);
				background-position:center;
				background-size:50%;
				background-repeat:no-repeat;
	/* 			position:absolute; top:20px; right:20px; */
			}
			
			/* 음소거 상태의 아이콘 */
			.v_mutd_off{
				width:30px;
				height:30px;
				border-radius:100%;
				background-color:rgba(0,0,0,0.5);
				background-image:url(<spring:eval expression="@bizConfig['aboutpet.sgr.url']" />/dist/images/speaker-slash-fill-white.svg);
				background-position:center;
				background-size:50%;
				background-repeat:no-repeat;
	/* 			position:absolute; top:20px; right:20px; */
			} 			
	
	</style>	
	<script>
	$(document).on("click" , function(){
		//아무대나 눌러도 레이어창 닫힘
		ui.popSel.closeAll();
	});
	//검색API 클릭 이벤트(사용자 액션 로그 수집)
	function userActionLog(petLogNo, action){	
		var mbrNo = "${session.mbrNo}";
		
		//console.log(action+","+petLogNo);
		if (mbrNo != "${frontConstants.NO_MEMBER_NO}") {
			$.ajax({
				type: 'POST'
				, url : "/common/sendSearchEngineEvent"
				, dataType: 'json'
				, data : {
					"logGb" : "ACTION"
					, "mbr_no" : mbrNo
					, "section" : "log" 
					, "content_id" : petLogNo
					, "action" : action
					, "url" : document.location.href
					, "targetUrl" : document.location.href
					, "litd" : ""
					, "lttd" : ""
					, "prclAddr" : ""
					, "roadAddr" : ""
					, "postNoNew" : ""
					, "timestamp" : ""
				}
			});
		}
	}
	
	function onThumbAPIReady() {
	    thumbApi.ready();
	};
	
	var imgSlide = new Array();
		$(function(){
			$("meta[name=viewport]").attr("content", "width=device-width, initial-scale=1, maximum-scale=4, user-scalable=no");
			
			/* 사진선택 높이 */
			var h = ($(window).height() - ($(".log_makePicWrap").offset().top + $(".log_makePicWrap").height() - $(window).scrollTop() - 24)) / ($(window).height() * 0.01) - 5;
			$(".commentBoxAp").data({"priceh":h+"%","min":h});
			ui.commentBox.open('#exid');/* 하단 팝업 open */
		

// 			$(".blur-background-area").css("background-image","url(" + $(".img-slide .swiper-slide:eq(0) img").attr("src") + ")");
			$('.img-slide .swiper-container').each(function(i,n){
				imgSlide.push(new Swiper($(n), {
					slidesPerView: "auto",
					spaceBetween: 8,
					centeredSlides: true,
					on: {
						slideChangeTransitionEnd: function(){
							var bg = $(".img-slide .swiper-slide:eq("+(imgSlide[0].activeIndex)+") img").data("src");
							$(".blur-background-area").css("background-image","url(" + bg + ")");
						},
					}
				}));
			});
			
			// 추가 바디스크롤 막기 2021.07.15 추가함 start
			setScrollReply();
			
		});
 
		function setScrollReply(){
			$(".commentBoxAp > .head").click(function(){
				ui.lock.using(true); 
			});
			$(".commentBoxAp > .head").bind("touchstart",function(e){
				ui.lock.using(true);
			})
			.bind("touchmove",function(e){
				ui.lock.using(true);
			})
			.bind("touchend",function(e){
				ui.lock.using(true);
			});	
		}
		
		function openPictureCon(){
			if($("#container").hasClass("changeBg")){
				$("#container").removeClass("changeBg");
			}else{
				$("#container").addClass("changeBg");
			};
			$(".logCommentBox .btn_right,.logCommentBox .btn_left").click(function(){
				$("#container").removeClass("changeBg");
			});
		};

		function savePetLogReply(petLogAplySeq){
			var reply = $("#reply").val().trim();
			$('#petLogReplyForm [name="aply"]').val(reply);
			$('#petLogReplyForm [name="petLogAplySeq"]').val(petLogAplySeq);
			
			if( reply == ""){
				 ui.toast('입력된 내용이 없습니다.',{   // 토스트 창띄우기
						bot:70
					});
				 return false;
			 }else{			
				 reply = reply.replace(/#[^#\s]+/gm, function(tag){
					var newtag = '';
					tag.replace(/#[^#\s\<\>\@\&\\']+/gm, function(replaceTag){
						newtag = replaceTag;
					});
					if(tag != newtag){
						tag = tag.replace(newtag, newtag+' ');
					}
					return tag;
				});
				
				$('#petLogReplyForm [name="aply"]').val(reply);
				
				var options = {
					url : "<spring:url value='/log/petLogReplySave' />"
					, data : $("#petLogReplyForm").serialize()
					, done : function(data){
						var msg;
						if($("[name=petLogAplySeq]").val()){
							msg = "<spring:message code='front.web.view.event.msg.comment.update' />"
						}else{
							msg = "<spring:message code='front.web.view.event.msg.comment.insert' />";
						}
						ui.toast(msg ,{   // 토스트 창띄우기
							bot:70
						});

						// 댓글목록 재조회
						searchPetLogReply();							
						$('.alert-commentBox').css("display","none");
						
						 // 댓글 입력  시  actionLog
						 if( petLogAplySeq == '') userActionLog('${param.petLogNo}', "reply"); 
					}
				};
				ajax.call(options);
			}
		}
		
		
		function updatePetLogReplySet(petLogAplySeq){
			// 이전 수정중이던건 삭제
			$(".rewrite").remove();
			$(".date").css("display","block");						
			$(".menu.dopMenuIcon").show();
			
			var aplyObj = $("#aply_"+petLogAplySeq);
			var modify = $("#modify_"+petLogAplySeq);
			$('#petLogReplyForm [name="petLogAplySeq"]').val(petLogAplySeq);	
			
			ui.addInputDel.createAddSource($("#reply"));
			//탈퇴회원 처리된 닉네임은 수정 시에 input창에서 제거
			$('#reply').val(aplyObj.text().replaceAll("@어바웃펫 회원" , ""));

			$('.alert-commentBox').css("display","block");			 
			
			var span =  $('<div class="rewrite">수정중....</div>');
			var lenPr = aplyObj.prev().find(".rewrite").length;
			var lenNe = aplyObj.next().find(".rewrite").length;
			if(lenPr == 0 && lenNe == 0) {
				aplyObj.next("div").append(span);
				modify.css("display","none");
			}
	 		aplyObj.parent().next().hide()
			$('#regBtn').removeAttr("onClick");
			$('#regBtn').attr("onClick","savePetLogReply('"+petLogAplySeq+"');");
			
			// 수정/삭제 버튼 onclick 막기
			//$(obj).parents(".menu dopMenuIcon").removeAttr("onClick");
		}
		
		function deletePetLogReply (petLogAplySeq) {
			ui.confirm('댓글을 삭제할까요?',{ // 컨펌 창 띄우기
				ycb:function(){
					
					$('#petLogReplyForm [name="petLogAplySeq"]').val(petLogAplySeq);
					
					var options = {
							url : "<spring:url value='/log/petLogReplyDelete' />"
							, data : $("#petLogReplyForm").serialize()
							, done : function(data){
								ui.toast('댓글이 삭제되었어요',{   // 토스트 창띄우기
									bot:70
								});
								//callback 함수 호출
								searchPetLogReply();
							}
						};
					ajax.call(options);
				},
				ncb:function(){
				//	ui.toast('취소 되었습니다.',{   // 토스트 창띄우기
					//	bot:70
					//});
				},
				ybt:'예',
				nbt:'아니오'	
			});
			
		}
		
		var replyCnt = '${petLogBase.replyCnt}';
		
		function searchPetLogReply(){
			var options = {
					url : "<spring:url value='/log/listPetLogReply' />"
					, data : $("#petLogReplyForm").serialize()
					, done : function(data){				
						replyCnt = data.petLogReplyList.length;					
					
						var addHtml = '\
						<div class="head t2">\
							<div class="con">\
								<div class="tit">댓글<span class="price-box">'  + replyCnt + '</span>개</div>\
								<a href="javascript:;" class="close" onClick="closePopup();"></a>\
							</div>\
						</div>\
						<div class="con t2">\
							<div class="box">';
						
						if(data.petLogReplyList.length > 0){
							addHtml += '\
								<div class="commendListBox" style="display:block;">\
								<ul>';
								
							var listHtml = '';
							for(var i=0; i<data.petLogReplyList.length; i++){ 
								var obj = data.petLogReplyList[i];								
								var regDate = new Date(obj.sysRegDtm);
								//var regDate = obj.sysRegDtm;
								
								var pic = '${frame:optImagePath("'+ obj.prflImg +'", frontConstants.IMG_OPT_QRY_786)}';
								if (obj.prflImg == null || obj.prflImg == '') {									
									pic = '../../_images/common/icon-img-profile-default-m@2x.png'
								}	
								var picLink = 'onclick="javascript:goToUrl(\'/log/indexMyPetLog/' + obj.petLogUrl+ '?mbrNo='+  obj.mbrNo+ '\');"';
								if(obj.mbrStatCd == '50'){
									picLink = '' ;
								}
								listHtml += '\
									<li>\
										<div class="pic" '+ picLink +'><img src="'+ pic +'" alt="img"></div>\
										<div class="con">\
											<div class="tit"><a href="#" '+picLink+'>' + obj.nickNm + '</a>';
											
									listHtml += '\
											</div>\
											<div class="txt" id="aply_' + obj.petLogAplySeq+ '">' + obj.aply + '</div>\
											<div class="date"></div>\
											<div class="date" id="modify_' + obj.petLogAplySeq+ '" style="display: block">' + regDate + '</div>\
										</div>\
										<!-- select box -->\
										<div class="menu dopMenuIcon" onClick="ui.popSel.open(this,event)">\
											<div class="popSelect">\
												<input type="text" class="popSelInput" tabindex="-1" >\
												<div class="popSelInnerWrap">\
													<ul>';
													
									if('${session.mbrNo}'== obj.mbrNo )	{
										listHtml += '\
														<li><a class="bt" href="javascript:updatePetLogReplySet(\'' + obj.petLogAplySeq+ '\');"><b class="t" style="color:#000000;">수정</b></a></li>\
														<li><a class="bt" href="javascript:deletePetLogReply(\''+ obj.petLogAplySeq+ '\');"><b class="t" style="color:#000000;">삭제</b></a></li>';
									}else{
										if(  obj.rptpYn == null || obj.rptpYn == 'N'){
										listHtml += '\
														<li><a class="bt" href="javascript:layerPetLogReport(\''+ obj.petLogNo +'\',\'' + obj.petLogAplySeq+ '\');" tabindex="-1" ><b class="t">신고</b></a></li>';
										}else{
											listHtml += '<li><a class="bt" href="javascript:ui.toast(\'이미 신고한 댓글이에요\',{ bot:70 });">신고</a></li>';
										}
									}
									
									listHtml += '\
													</ul>\
												</div>\
											</div>\
										</div>\
										<!-- // select box -->\
									</li>';
									
							}
							addHtml = addHtml + listHtml;
							addHtml += '\
							</ul>\
							</div>';	
							
						}else{
							addHtml += '\
							<div class="commentBox-noneBox">\
								<div>\
									<span class="ico-commentbox-none"></span>\
									첫번째 댓글을 남겨주세요.\
								</div>\
							</div>';						
						}
						
						addHtml += '\
						</div>\
						<div class="input textarea">';
							
				<c:choose>		
					<c:when test="${session.isLogin() ne true}">	
						addHtml += '\
							<span></span>\
							<textarea type="text" onClick="checkReplyInput();" placeholder="로그인 후 댓글을 입력해주세요." id="reply" name="reply" tabindex="-1"></textarea>';	
					</c:when>	
					<c:otherwise>	
						addHtml += '\
							<span>\
						<c:if test="${session.prflImg ne null and session.prflImg ne ''}">						
								<img src="${frame:optImagePath(session.prflImg, frontConstants.IMG_OPT_QRY_786)}" >\
						</c:if>
							</span>\
							<textarea type="text" onClick="checkReplyInput();" placeholder="댓글을 입력해주세요." id="reply" name="reply" tabindex="-1"></textarea>\
							<button id="regBtn" onClick="savePetLogReply(\'\')">등록</button>';
					</c:otherwise>
				</c:choose>
				
					addHtml += '\
						</div>\
						<div class="fixed_box" style="display:block;">\
							<div class="key-word-list" style="display:none;">\
								<ul id="add_tag_list">\
								</ul>\
							</div>\
							<div class="alert-commentBox" id="uptCmtDisp" style="display:none;">\
								<p><span class="icon-speechBubble"></span>댓글을 수정 중입니다.</p>\
								<button class="close" onClick="hideUptCmtDisp()"></button>\
							</div>\
						</div>\
					</div>';	
					
					$("#exid").html(addHtml);	
					ui.commentBox.open($('.commentBoxAp.logcommentBox.pop1'));
					//ui.commentBox.open('#pop'+no+'_'+petLogNo);	
										
					//날짜 형식 변환.
					setAplyTimeConvert2();
					//댓글 #/@ 링크 변환
					setAplyLink();
					setScrollReply();
					ui.init();
					}
		};
				ajax.call(options);
		}		
		
		
		function hideUptCmtDisp(){
			// 컨펌 띄우기
			
			ui.confirm('댓글 수정을 취소할까요?',{ // 컨펌 창 옵션들
				ycb:function(){
					// 수정중 삭제
					$(".rewrite").parents(".con").next().show();
					$(".rewrite").remove();
					
					$("#uptCmtDisp").css("display","none");					
					$(".date").css("display","block");					
					//$("#reply").closest(".input").find(".btn_wrap > .del").click();
					$(".del").trigger("click");
					$("#reply").val("");
					$('#regBtn').attr("onClick","savePetLogReply('');");
					$("#add_tag_list").html('');
					//$("#reply").text("");
				},
				ncb:function(){
					return false;
				},
				ybt:"예", // 기본값 "확인"
				nbt:"아니오"  // 기본값 "취소"
			});		
		}
		
		function checkReplyInput(){
			if( checkLogin() && checkRegPet() ){
				//alert('등록 가능');
				// 키패드 노출..
			} 
		}
		
		function checkLogin(){
			<c:choose>		
				<c:when test="${session.isLogin() ne true}">
					ui.confirm('로그인 후 서비스를 이용할 수 있어요.<br>로그인 할까요?',{ // 컨펌 창 옵션들
						ycb:function(){
							location.href = "${view.stDomain}/indexLogin?returnUrl=${requestScope['javax.servlet.forward.servlet_path']}" + location.search;
						},
						ncb:function(){
							return false;
						},
						ybt:"로그인", // 기본값 "확인"
						nbt:"취소"  // 기본값 "취소"
					});			
				</c:when>	
				<c:otherwise>	
					return true;
				</c:otherwise>
			</c:choose>
		}
		
		function checkRegPet(){	
			<c:choose>		
				<c:when test="${loginUserInfo.petRegYn ne 'Y'}">
				ui.confirm('마이펫 등록 후 <br/>이용할 수 있어요.<br/>펫 정보를 등록할까요?',{ // 컨펌 창 옵션들
					ycb:function(){
						// 반려동물 등록 화면으로 이동.
						location.href = "${view.stDomain}/my/pet/petInsertView?returnUrl=${requestScope['javax.servlet.forward.servlet_path']}" + location.search;
					},
					ncb:function(){
						//alert('취소');
						return false;
					},
					ybt:"예", // 기본값 "확인"
					nbt:"아니요"  // 기본값 "취소"
				});				
				</c:when>	
				<c:otherwise>	
					return true;
				</c:otherwise>
			</c:choose>
		}
		var imgSrcArr = new Array();
		// 검색주소 리턴
		function closePopup(){
			for(var i = 0 ; i < $(".img-slide").find("img").length ; i++){
				imgSrcArr.push($(".img-slide").find("img").eq(i).attr("src"));
			}
			var result = {
				listNo : '${param.listNo}', 			
				petLogNo : '${param.petLogNo}',
				replyCnt : replyCnt ,
				imgSrcArr : imgSrcArr
			};
			// IE에서 opener관련 오류가 발생하는 경우, 부모창에서 지정한 이름으로 opener를 재정의
			if(opener == null || opener == undefined) opener = window.open("", "replyPopup");
			opener.<c:out value="${param.callBackFnc}" />(result , "${session.mbrNo}");
			window.open("about:blank","_self").close();
		}
	
		
		
		function goToUrl( url ){
						
			// IE에서 opener관련 오류가 발생하는 경우, 부모창에서 지정한 이름으로 opener를 재정의
			if(opener == null || opener == undefined) opener = window.open("", "replyPopup");
			//alert(opener);
			opener.location.href = url;			
			window.open("about:blank","_self").close();
		}
		

		// 신고하기 layer popup 띄우기
		function layerPetLogReport(petLogNo, petLogAplySeq){
			if( checkLogin() ){			
				ui.popLayer.open("popReport");
				
				// layer form 초기화.
				form.clear('petLogRptpForm');
				$('#petLogRptpForm [name="rptpRsnCd"]').prop('checked', false);	
				
				$(".pbd .phd .tit").text("댓글 신고 ");
				
				$('#petLogRptpForm [name="petLogNo"]').val(petLogNo);
				$('#petLogRptpForm [name="petLogAplySeq"]').val(petLogAplySeq);
				$('#petLogRptpForm [name="mbrNo"]').val('${session.mbrNo}');
				//$('#petLogRptpForm [name="listNo"]').val(listNo);
			}
		}	

		
		// 신고하기 등록
		function insertPetLogRptp(layer){
			if($("#petLogRptpForm [name='rptpRsnCd']").is(":checked") == false){
				//alert("신고 사유를 선택해주세요.")
				ui.toast('신고 사유를 선택해주세요.',{   // 토스트 창띄우기
							bot:70
						});					
				$("#petLogRptpForm [name='rptpRsnCd']").eq(0).focus();
				return false;			
			}			
			
			var options = {
					url : "<spring:url value='${view.stDomain}/log/petLogRptpInsert' />"
					, data : $("#petLogRptpForm").serialize()
					, done : function(data){
						/* $("#commitBtn").removeClass("a"); */
						$("#commitBtn").addClass("disabled");						
						//alert("<spring:message code='front.web.view.common.msg.result.insert' />");
						ui.toast('신고 완료되었습니다.',{   // 토스트 창띄우기
							bot:70
						});	
						
						//callback 함수 호출
						ui.popLayer.close(layer);
						searchPetLogReply();
					}
				};
				ajax.call(options);
		}	
		
		/* img size */
		function resizeImg(){
			$(".log_makePicWrap .swiper-slide img").each(function(i,n){
				let w = $(n).innerWidth();
				let h = $(n).innerHeight();
				let cl = (w<h)?"a w":"a h";
				$(n).attr("class",cl);
				if($(n).innerWidth() < $(n).parent().innerWidth()){
					$(n).attr("class","a w");
				}
				if($(n).innerHeight() < $(n).parent().innerHeight()){
					$(n).attr("class","a h");
				}
			})
		};
	</script>	
	<script>
	var keypadHeight;
	$(window).ready(function(){
		var idx = "${selIdx}";
		if( idx != null && idx != "") {
			// 게시물의 이미지가 2개이상의 경우 - 선택된 이미지 선택되도록.
			imgSlide[0].slideTo(idx);
		}
		
		//날짜 형식 변환.
		setAplyTimeConvert();
		//댓글 #/@ 링크 변환
		setAplyLink();
		
		resizeImg();
		
		/* 04.05 : 추가 바디스크롤 막기 */
		ui.lock.using(true);
		if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
			toNativeData.func = "onEnableKeyboardEvent";
			toNativeData.callback = "onEnableKeyboardEventCallBack";
			toNative(toNativeData);
		}
		
		$(document).on("propertychange change keyup paste input" , " [name=rptpRsnCd]" , function(){
			var checked = $("[name=rptpRsnCd]:checked").val();
			if(checked){
				$("#commitBtn").removeClass("disabled");
			}else{
				$("#commitBtn").addClass("disabled");
			}
		})
		
		$(document).on("propertychange change keyup paste input" , "[name=rptpContent]"  , function(){
			var toastH;
			
			if(isIOS()){
			 	toastH = 330 - $(".pct").scrollTop();
			}else{
				toastH = 70;
			}
			
			if($(this).val().length > 200){
				ui.toast("내용은 200자까지 입력할 수 있어요." , {  
					bot:74
				});
				$(this).val($(this).val().substring(0,200))
			}
		})	
	});
	
	
	function onEnableKeyboardEventCallBack(data){
		if(keypadHeight != data){
			$("html,body").scrollTop(9999999);
			keypadHeight = data;	
		}else{
			setScrollReply();	
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
	</script>
	<script>
		// event type은 변경하셔도 됩니다. 
		var gb = '';
		var firstChar;
		var whileFetching = false;
		var resJsonArr = new Array();
		let abortController;
		$(document).on("input keyup click", "textarea[name=reply]", function(e) {
			var formData = new FormData();
			let element = document.getElementById('reply');
			let strOriginal = element.value;
			strOriginal = strOriginal.replaceAll('\n', ' ');
			strOriginal = strOriginal.substr(0, element.selectionStart);
			let inTag = strOriginal.indexOf('#');
			let inMention = strOriginal.indexOf('@');
			if(inTag > -1 || inMention > -1) {
				$(".key-word-list").css("display", "block");
			}else{
				$(".key-word-list").css("display", "none");
			}
			let index = strOriginal.lastIndexOf('\#');
			if (index < strOriginal.lastIndexOf('\@') && element.selectionStart > strOriginal.lastIndexOf('\@')) {
				index = strOriginal.lastIndexOf('\@');
			}
			let txt = strOriginal.substring(index, element.selectionStart);
			txt = txt.substring(0, 1);
			gb = txt;			
			// hashtag
			if (gb.indexOf('\#') > -1) {
				firstChar = "\#";
				let iStartPos = element.selectionStart;
				let iEndPos = element.selectionEnd;
				let strFront = "";
				let strEnd = "";
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
					
					if( searchTagTxt != '' ){
						//중복 호출시 기존 request 취소를 위해 fetch로 변경
						if(whileFetching) abortController.abort();
						
						abortController = new AbortController;
						whileFetching = true;
						
						formData.append('searchText' , searchTagTxt);
						formData.append('label' , 'pet_log_autocomplete');
						formData.append('size' , 30);
			            fetch("/log/getAutocomplete" , {
			            	method : "POST"
			            	, body : formData
			            	, signal : abortController.signal
			            	}).then(res => res.json())
			            	.then(res => autoCompleteSuccess(JSON.parse(res) , "tag"))
			            	.catch(err => console.log(err))       
					} else { 
						 $("#add_tag_list").html("");
					}
				} else return;
			}
			
			// mention
			if (gb.indexOf('\@') > -1) {
				firstChar = "\@";
				let iStartPos = element.selectionStart;
				let iEndPos = element.selectionEnd;
				let strFront = "";
				let strEnd = "";
				if(iStartPos == iEndPos) {
					String.prototype.startsWith = function(str) {
						if (this.length < str.length) { return false; }
						return this.indexOf(str) == 0;
					}
					
					strFront = strOriginal.substring(0, iStartPos);
					var mentionChar =0;
					
					for(var i =0; i<strFront.length; i++){
						if(strFront[i] == firstChar){
							mentionChar = i+1
						}
					}
					
					var fromMention =  strOriginal.substring(mentionChar, strOriginal.length)
					var mentionFind = new RegExp(/[^s\@]*/, 'g')
					var mentionReplLength = fromMention.match(mentionFind)[0].length
					searchMentionTxt =  strOriginal.substring(mentionChar, mentionChar+mentionReplLength)
					
					//태그가 끝나는 지점에서 공백이나 개행문자가 있을 시 추천리스트 노출하지 않음.
					if(strFront.lastIndexOf('@') < strFront.lastIndexOf(' ')
							|| strFront.lastIndexOf('@') < strFront.lastIndexOf('\n')){
						searchMentionTxt = "";
					}

					if( searchMentionTxt != '' ){
						//중복 호출시 기존 request 취소를 위해 fetch로 변경
						if(whileFetching) abortController.abort();
						
						abortController = new AbortController;
						whileFetching = true;
						
						formData.append('searchText' , searchMentionTxt);
						formData.append('label' , 'log_member_nick_name');
						formData.append('size' , 30);
						formData.append('petLogYn' , "Y");
			            fetch("/log/getAutocomplete" , {
			            	method : "POST"
			            	, body : formData
			            	, signal : abortController.signal
			            	}).then(res => res.json())
			            	.then(res => autoCompleteSuccess(JSON.parse(res) , "mention"))
			            	.catch(err => console.log(err))       
					} else{ 
						 $("#add_tag_list").html("");
					}
				} else return;
			}
		
		});
		
		
		$(document).on("input change paste" , "#reply" , function(){
			var value = $(this).val();
			//console.log(value.length);
			if(value.length > 300){ 
				ui.toast('300자까지 입력 가능합니다.',{
				    bot:74  // 바닥에서 띄울 간격
				    //,sec:1000 // 사라질 시간 number
				});
				$(this).val(value.substr(0 , 300));
			}
			$("button.del").css('visibility','hidden');
		});
		
		function setAplyLink(){
			$("li .con .txt").each(function(i, v) {
			
				let strOriginal =  $(this).text();
				var inputString = strOriginal;
				inputString = inputString.replace(/#[^#\s\<\>\@\&\\']+|@[^@\s]+/gm, function (tag){
					var ret = "";
					if(tag.indexOf('#')== 0 && tag.length < 22){
						var tagUrl = '/log/indexPetLogTagList?tag=' + encodeURIComponent(tag.replace('#',''));
						ret = '<a href="javascript:goToUrl(\'' + tagUrl + '\');" style="color:#669aff;">' + tag + '</a>'
					}
					else{
						if( tag.split('|').length == 3){
							var myPetLogUrl = "/log/indexMyPetLog/"+ tag.split('|')[2] + "?mbrNo=" + tag.split('|')[1];
							
							ret = '<a href="javascript:goToUrl(\'' + myPetLogUrl + '\');" style="font-weight:bold;">' + tag.split('|')[0] + '</a>'
						}else{
							ret = tag;
						}						
					}
					return ret;
				});
				inputString = inputString.replaceAll(' <a href="/log/indexMyPetLog', '<a href="/log/indexMyPetLog');
				$(this).html(inputString);
			});
		}

		function setAplyTimeConvert(){
			$('.commendListBox .con .date').each(function(){
				if( $(this).text() != undefined && $(this).text() != '') {
					var timeTxt = new Date($(this).text().replace(/\s/, 'T'));					
					var converTime = elapsedTime(timeTxt, "년월일");
					$(this).text(converTime);
					//console.log(converTime);
				}
			});
		}
		
		function setAplyTimeConvert2(){
			$('.commendListBox .con .date').each(function(){
				if( $(this).text() != undefined && $(this).text() != '') {
					//var timeTxt = new Date($(this).text().replace(/\s/, 'T'));					
					var converTime = elapsedTime($(this).text(), "년월일");
					$(this).text(converTime);
					//console.log(converTime);
				}
			});
		}
		
		// MO - 댓글 #/@ 검색어 선택
		function selectTag(index){
			let element = document.getElementById('reply');
			let strOriginal = element.value; // textarea에 입력한 값
			let iStartPos = element.selectionStart; // 현재커서의 위치
			let iEndPos = element.selectionEnd;
			$("#reply").blur();
			$("#reply").focus();
			
			var searchStr = strOriginal.substring(0,iStartPos)
			var selTagChar =0;
			var b4firstCharStr='';
			for(var i =0; i<searchStr.length; i++){
				if(searchStr[i] == firstChar){
					selTagChar = i
				}
			}
			if(selTagChar >0){
				b4firstCharStr = strOriginal.substring(0, selTagChar)
			}
			var fromFirstChar =  strOriginal.substring(selTagChar, strOriginal.length)
			var selTagFind = new RegExp(/^[@#][^\s@#]*/, 'g')
			var selTagReplLength = fromFirstChar.match(selTagFind)[0].length
			var selTagRepl = resJsonArr[index].firstChar + resJsonArr[index].selTag;
			var afterSelTagStr =fromFirstChar.substring(selTagReplLength,fromFirstChar.length)
			var space = afterSelTagStr.substring(0, 1) == ' ' ? '' : ' ';
			
			element.value = b4firstCharStr+selTagRepl+space+afterSelTagStr

			$("#add_tag_list").html("");
			$(".key-word-list").css("display", "none");
		}
		
		function autoCompleteSuccess(resBody , separator){
			resJsonArr = [];
			whileFetching = false;
			if(resBody.STATUS.CODE == "200"){
				let html = ''
				if( resBody.DATA.ITEMS.length > 0) {
					let item = resBody.DATA.ITEMS;
					$("#add_tag_list").empty();
					for(var i=0;i<resBody.DATA.ITEMS.length;i++){
						//',",`와 같은 특수문자가 닉네임에 포함 될 시 스크립트 깨지는 현상때문에 json형태로 수정 
						var resJson = new Object;
						resJson.selTag = item[i].KEYWORD;
						resJson.firstChar = firstChar;
						resJsonArr.push(resJson)
						if(separator == "mention"){
							let pic = '${frame:optImagePath("'+ item[i].PRFL_IMG +'", frontConstants.IMG_OPT_QRY_786)}';
							if (!item[i].PRFL_IMG) {
								pic = '../../_images/common/icon-img-profile-default-m@2x.png'
							}
							html += '<li onclick="javascript:selectTag('+i+');"><div class="pic"><img src="'+ pic + '" style="margin:9px 5px 0px 5px;float:left;width:28px;height:28px;border-radius:100%;overflow:hidden;background:#c7cdd5 no-repeat center;background-size:38px auto;"></div>' + item[i].HIGHLIGHT.replace(/\¶HS¶/gi, '<span>').replace(/\¶HE¶/gi, '</span>')
						}else{
							html += '<li onclick="javascript:selectTag('+i+');"><span>#</span>' + item[i].HIGHLIGHT.replace(/\¶HS¶/gi, '<span>').replace(/\¶HE¶/gi, '</span>') + '</li>';	
						}
					}
				}
				$("#add_tag_list").html(html);
				$(".key-word-list").css("display", "block");
			}
		}
		
		/* 신고하기 항목 선택시 완료버튼 활성화*/
// 		function rptpRsnCdChYn(){
// 			var rptpRsnCdFlag = $("input[type=radio][name='rptpRsnCd']").is(":checked");		
// 			if(rptpRsnCdFlag){
// 				$("#commitBtn").addClass("b");
// 				$("#commitBtn").addClass("a");
// 			}
// 		}		
	</script>	
	
	</tiles:putAttribute>

	<%-- 
	Tiles content put
	--%>		
	<tiles:putAttribute name="content">
		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container page" id="container">
			<form id="petLogReplyForm" name="petLogReplyForm" method="post" onSubmit="return false;">
			<input type="hidden" id="contsStatCd" name="contsStatCd" value="10" /><!-- 컨텐츠 상태코드(10-노출, 20-미노출, 30-신고차단) -->
			<input type="hidden" id="aply" name="aply" /><!-- 댓글 -->	
			<input type="hidden" name="petLogNo"  value="${param.petLogNo}"/><!-- 펫로그번호 -->	
			<input type="hidden" name="petLogAplySeq"/><!-- 댓글 순번 -->	
			<input type="hidden" name="mbrNo" value="${session.mbrNo}" /><!-- 로그인회원번호 -->		
			</form>
			<div class="inr">
				<!-- 본문 -->
				<div class="contents log" id="contents">
                    <!-- picture -->
					<div class="log_makePicWrap t2">
			<c:choose>
				<c:when test="${petLogBase.vdThumPath ne null and petLogBase.vdThumPath ne ''}">
						<div class="blur-background-area" style="background-image:url('${petLogBase.vdThumPath}')"></div>
						<div class="img-slide">
							<div class="swiper-container">
								<div class="swiper-pagination"></div>
								<ul class="swiper-wrapper slide">								
									<li class="swiper-slide">
										<div class="vthumbs" video_id="${petLogBase.vdPath}" type="video_thumb_360p" uid="${petLogBase.mbrNo}|${session.mbrNo}" style="width:100%; height:100%"></div>
									</li>
								</ul>
							</div>
						</div>						
				</c:when>
				<c:otherwise>
						<div class="blur-background-area" style="background-image:url('${frame:optImagePath(petLogBase.imgPath1,frontConstants.IMG_OPT_QRY_772)}')"></div>
						<!-- slider -->
						<div class="img-slide">
							<div class="swiper-container">
								<div class="swiper-pagination"></div>
								<ul class="swiper-wrapper slide">								
									<li class="swiper-slide">
										<a class="petLogCardBox"><img class="img" src="${fn:indexOf(petLogBase.imgPath1, '.gif') > -1? frame:imagePath(petLogBase.imgPath1) : frame:optImagePath(petLogBase.imgPath1,frontConstants.IMG_OPT_QRY_772)}" alt="img01" data-src="${frame:optImagePath(petLogBase.imgPath1,frontConstants.IMG_OPT_QRY_772) }"/></a>
									</li>
<c:if test="${petLogBase.imgPath2 ne null and petLogBase.imgPath2 ne ''}">
									<li class="swiper-slide">
										<a class="petLogCardBox"><img class="img" src="${fn:indexOf(petLogBase.imgPath2, '.gif') > -1? frame:imagePath(petLogBase.imgPath2) : frame:optImagePath(petLogBase.imgPath2,frontConstants.IMG_OPT_QRY_772)}" alt="img01" data-src="${frame:optImagePath(petLogBase.imgPath2,frontConstants.IMG_OPT_QRY_772) }"/></a>
									</li>
</c:if>	
<c:if test="${petLogBase.imgPath3 ne null and petLogBase.imgPath3 ne ''}">
									<li class="swiper-slide">
										<a class="petLogCardBox"><img class="img" src="${fn:indexOf(petLogBase.imgPath3, '.gif') > -1? frame:imagePath(petLogBase.imgPath3) : frame:optImagePath(petLogBase.imgPath3,frontConstants.IMG_OPT_QRY_772)}" alt="img01" data-src="${frame:optImagePath(petLogBase.imgPath3,frontConstants.IMG_OPT_QRY_772) }"/></a>
									</li>
</c:if>
<c:if test="${petLogBase.imgPath4 ne null and petLogBase.imgPath4 ne ''}">
									<li class="swiper-slide">
										<a class="petLogCardBox"><img class="img" src="${fn:indexOf(petLogBase.imgPath4, '.gif') > -1? frame:imagePath(petLogBase.imgPath4) : frame:optImagePath(petLogBase.imgPath4,frontConstants.IMG_OPT_QRY_772)}" alt="img01" data-src="${frame:optImagePath(petLogBase.imgPath4,frontConstants.IMG_OPT_QRY_772) }" /></a>
									</li>
</c:if>
<c:if test="${petLogBase.imgPath5 ne null and petLogBase.imgPath5 ne ''}">
									<li class="swiper-slide">
										<a class="petLogCardBox"><img class="img" src="${fn:indexOf(petLogBase.imgPath5, '.gif') > -1? frame:imagePath(petLogBase.imgPath5) : frame:optImagePath(petLogBase.imgPath5,frontConstants.IMG_OPT_QRY_772)}" alt="img01" data-src="${frame:optImagePath(petLogBase.imgPath5,frontConstants.IMG_OPT_QRY_772) }"/></a>
									</li>
</c:if>
								</ul>
							</div>
							<div class="remote-area t1">
								<button class="swiper-button-next" type="button"></button>
								<button class="swiper-button-prev" type="button"></button>
							</div>
						</div>
						<!-- // slider -->				
				</c:otherwise>
			</c:choose>	
					</div>
                    <!-- // picture -->
					<!-- 댓글 pop -->
					<div class="commentBoxAp logcommentBox pop1" id="exid" data-priceh="80%">
						<div class="head t2">
							<div class="con">
								<div class="tit">
									댓글<span class="price-box"> ${petLogBase.replyCnt}</span>개
								</div>
								<a href="javascript:;" class="close" onClick="closePopup()"></a>
							</div>
						</div>
						<div class="con t2">
							<div class="box">
							<c:choose>
								<c:when test="${petLogBase.replyCnt > 0}">							
									<div class="commendListBox" style="display:block;">
										<ul>
										<c:forEach items="${petLogReplyList}" var="petLogReply" varStatus="idx">									
											<li>
												<c:choose>
													<c:when test="${petLogReply.mbrStatCd eq 50}">
														<div class="pic">
													</c:when>
													<c:otherwise>
														<div class="pic" onclick="javascript:goToUrl('/log/indexMyPetLog/${petLogReply.petLogUrl}?mbrNo=${petLogReply.mbrNo}');">
													</c:otherwise>
												</c:choose>
												<c:if test="${petLogReply.prflImg ne null and petLogReply.prflImg ne ''}">
													<img src="${frame:optImagePath(petLogReply.prflImg, frontConstants.IMG_OPT_QRY_786)}" alt="img">
												</c:if>
												</div>
												<div class="con">
													<div class="tit">
														<c:choose>
															<c:when test ="${petLogReply.mbrStatCd eq frontConstants.MBR_STAT_50 }">
																${petLogReply.nickNm}	 												
															</c:when>
															<c:otherwise>
																<a href="#" onclick="javascript:goToUrl('/log/indexMyPetLog/${petLogReply.petLogUrl}?mbrNo=${petLogReply.mbrNo}');">${petLogReply.nickNm}</a> 
															</c:otherwise>
														</c:choose>
	<!-- 												<span class="nameCardAp">작성자</span> -->
													</div>
													<div class="txt" id="aply_${petLogReply.petLogAplySeq}" data-pet-log-url="${petLogReply.petLogUrl}" data-mbr-no="${petLogReply.mbrNo}">${petLogReply.aply}</div>
													<div class="date"></div>
													<div class="date" id="modify_${petLogReply.petLogAplySeq}" style="display: block;">${petLogReply.sysRegDtm}</div>
												</div>
												<!-- select box -->
												<div class="menu dopMenuIcon" onClick="ui.popSel.open(this,event)">
													<div class="popSelect">
														<input type="text" class="popSelInput" tabindex="-1" >
														<div class="popSelInnerWrap">
															<ul>
															<c:choose>					
																<c:when test="${session.mbrNo eq petLogReply.mbrNo}">									
																	<li><a class="bt" href="javascript:updatePetLogReplySet('${petLogReply.petLogAplySeq}');"><b class="t" style="color:#000000;">수정</b></a></li>
																	<li><a class="bt" href="javascript:deletePetLogReply('${petLogReply.petLogAplySeq}');"><b class="t" style="color:#000000;">삭제</b></a></li>
																</c:when>
																<c:otherwise>
																	<c:choose>					
																		<c:when test="${petLogReply.rptpYn eq null or petLogReply.rptpYn eq 'N'}">
																			<li><a class="bt" href="javascript:layerPetLogReport('${petLogBase.petLogNo}','${petLogReply.petLogAplySeq}');" tabindex="-1" ><b class="t">신고</b></a></li>
																		</c:when>
																		<c:otherwise>
																			<li><a class="bt" href="javascript:ui.toast('이미 신고한 댓글이에요',{ bot:70 });">신고</a></li>
																		</c:otherwise>
																	</c:choose>	
																</c:otherwise>
															</c:choose>												
															</ul>
														</div>
													</div>
												</div>
												<!-- // select box -->
											</li>
										</c:forEach>										
										</ul>
									</div>
								</c:when>
								<c:otherwise>								
									<!-- 021.02.01 : 수정 추가  -->
									<!-- none -->
									<div class="commentBox-noneBox">
										<div>
											<span class="ico-commentbox-none"></span>
											첫번째 댓글을 남겨주세요.
										</div>
									</div>
								</c:otherwise>
							</c:choose>								
								<!-- // none -->
								<!-- 댓글 수정 중 알림 
								<div class="alert-commentBox" style="display:none;">
									<p><span class="icon-speechBubble"></span>댓글을 수정 중입니다.</p>
									<button class="close" onClick="$(this).parent().hide();"></button>
								</div>
								<!-- // 댓글 수정 중 알림 -->
								<!-- // 2021.02.01 : 수정 추가  -->
							</div>
							<div class="input textarea">
								
				<c:choose>		
					<c:when test="${session.isLogin() ne true}">
								<span></span>								
								<textarea type="text" onClick="checkReplyInput();" placeholder="로그인 후 댓글을 입력해주세요." id="reply" name="reply" tabindex="-1"></textarea>
					</c:when>	
					<c:otherwise>	
								<span>
							<c:if test="${session.prflImg ne null and session.prflImg ne ''}"><img src="${frame:optImagePath(session.prflImg, frontConstants.IMG_OPT_QRY_786)}"></c:if>
								</span>
								<textarea type="text" onClick="checkReplyInput();" placeholder="댓글을 입력해주세요." id="reply" name="reply" tabindex="-1"></textarea>
								<button id="regBtn" onClick="savePetLogReply('');">등록</button>
					</c:otherwise>
				</c:choose>
								
							</div>
							<div class="fixed_box" style="display:block;">
								<!-- // tag -->
								<div class="key-word-list" style="display:none;"><!-- 높이만큼 top속성 -주시면 됩니다 -->
									<ul id="add_tag_list">
<!-- 										<li>#산책</li> -->
									</ul>
								</div>
								<!-- // tag -->
								<!-- 댓글 수정 중 알림 -->
								<div class="alert-commentBox" id="uptCmtDisp" style="display:none;">
									<p><span class="icon-speechBubble"></span>댓글을 수정 중입니다.</p>
<!-- 									<button class="close" onClick="$(this).parent().hide();"></button> -->
									<button class="close" onClick="hideUptCmtDisp()"></button>
								</div>
								<!-- // 댓글 수정 중 알림 -->
							</div>
						</div>
					</div>
					<!-- //댓글 -->
				</div>
			</div>
		</main>
	</tiles:putAttribute>
	
		
	<tiles:putAttribute name="layerPop">
		<jsp:include page="/WEB-INF/view/petlog/layerPetLogReplyReport.jsp" />	
	</tiles:putAttribute>
	
	
</tiles:insertDefinition>