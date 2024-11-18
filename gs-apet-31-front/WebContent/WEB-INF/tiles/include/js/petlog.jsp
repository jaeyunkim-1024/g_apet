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
		/*  소리 아이콘 오른쪽(디자인)으로 이동하려면 사용하면 됨.(현재 왼쪽-기획서) */
		.vthumbs > div > div{left:auto !important;}
		
</style>
<script type="text/javascript">
var deviceGb = "${view.deviceGb}";
//검색API 클릭 이벤트(사용자 액션 로그 수집)

function userActionLog(petLogNo, action){	
	var mbrNo = "${session.mbrNo}";
	var litd = "";
	var lttd = "";
	if( action == "petlog" ){
		litd = $('#petLogBaseForm [name="logLitd"]').val();
		lttd = $('#petLogBaseForm [name="logLttd"]').val();
	}
	
	//alert(action+","+petLogNo+","+litd+","+lttd);
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
				, "litd" : litd
				, "lttd" : lttd
				, "prclAddr" : ""
				, "roadAddr" : ""
				, "postNoNew" : ""
				, "timestamp" : ""
			}
		});
	}
}
</script>		
<script>
	// 게시물 등록/수정 swiper 객체
	//var madePetlog; // 04.12 주석처리

	//app 위치정보 허용 여부
	var appLocAuthYn = "N";
	// 위치정보 약관동의 여부
	var pstInfoAgrYn = "N";	
<c:if test="${loginUserInfo != null and loginUserInfo.pstInfoAgrYn == 'Y'}">
	pstInfoAgrYn = "Y";
</c:if>

	function onThumbAPIReady() {
	    thumbApi.ready();
		$("#likePetLogList").find(".vv_mutd_off").hide();
		$("#likePetLogList").find(".v_mutd_on").hide();
		$("#popularTagList").find(".vv_mutd_off").hide();
		$("#popularTagList").find(".v_mutd_on").hide();
		
	};
	
	//console.log("view.deviceGb==>",'${view.deviceGb}');
	//console.log("session.mbrNo ==>",'${session.mbrNo}');
	//console.log("로그인 여부==>", "${session.isLogin()}");
	//console.log("펫등록  여부==>", "${loginUserInfo.petRegYn}");
	
</script>

<script>
	
/* 	function vodEncodingMsg(vdId){
		var prflImg = $(".vthumbs[video_id="+vdId[0]+"]").parents("section").find(".pic>img").attr("src")
		var thtml_v2 = '<div class="logVodLoadingMsg">\n' +
	      '<div style="padding: 10px 21px 10px 20px;border-radius: 0 0 5px 5px;line-height: 1.29;background: white;">' +
	      '<div class="userInfo" style="position: relative;display: flex;align-items: center;margin-top: 0;">' +
	      '<div class="pic" onclick="javascript:goMyPetLog(\'${session.petLogUrl}\',\'${session.mbrNo}\',event)">' +
	      '<img src="'+prflImg+'" alt="dog">' +
	      '</div>' +
	      '<div class="con">' +
	      '<div class="txt" style="color: #9a9a9a;align-items: center;">' +
	      '<span>영상을 등록하고 있어요. 잠시만 기다려주세요.</span>' +
	      '</div>' +
	      '</div>' +
	      '</div>' +
	      '</div>' +
	      '</div>';
	    if(vdId){
			for(var i = 0; i < vdId.length ; i++){
				$(".vthumbs[video_id="+vdId[i]+"]").parents("section").children().hide()
			    $(".vthumbs[video_id="+vdId[i]+"]").parents("section").append(thtml_v2)
		   	}
	    }
	} */
	
/* 	function vodEncodingCallBack(mbrNo , vdId){
			console.log(mbrNo + "=1="+ '${session.mbrNo}');
		
		if( mbrNo == '${session.mbrNo}' ){
				console.log(mbrNo + "=2="+ '${session.mbrNo}');
			
			$(".uimoreview.refresh").slideDown(2000);
			updateEncCpltYn(vdId);
			
				var resultMsg = "게시물이 등록되었습니다.";
				ui.toast('<div class="link"><p class="tt">'+resultMsg+'</p><a href="javascript:goMyPetLog(\'${session.petLogUrl}\',\'${session.mbrNo}\');" class="lk">바로가기</a></div>',{
				    bot:74  // 바닥에서 띄울 간격
				    ,sec:3000 // 사라질 시간 number
				});
		}
	} */
	
	//인코딩check callBack
	function onPetLogEncodingCheckCallback(vdId){
		if(vdId){ updateEncCpltYn(vdId , 'Y') }
	}
	
	function onInsertPetLogEncodingCheckCallback(vdId){
		if(vdId){ updateEncCpltYn(vdId , 'N') }
	}
	
	
	//인코딩 완료 시 인코딩 여부 컬럼 업데이트
	function updateEncCpltYn(vdId , reload){
		var options = {
				url : "${view.stDomain}/log/encCpltYnUpdate"
				, data : {
					vdPath : vdId
					, encCpltYn : "Y"
				}
				, done : function(result){
					if(reload == "Y"){
						location.reload();	
					}
// 					if(result > 0){
// 						$(".uimoreview.refresh").removeClass("onWeb_b");
// 						toastCallBack();
// 						$(".vthumbs[video_id='"+vdId+"']").data("enchk" , "Y");
// 						$(".vthumbs[video_id='"+vdId+"']").parents("section").find(".logVodLoadingMsg").remove();
// 					}
				}
		}
		//혹시라도 중복으로 업데이트 안되게
// 		if($(".vthumbs[video_id='"+vdId+"']").data("enchk") == "N"){
			ajax.call(options);				
// 		}
	}
	
	function toastCallBack(){
		
		if( '${session.isLogin()}' ==  "true" && '${so.petLogNo}' != null && '${so.petLogNo}' != ''){
			//alert("toastCallBack:${so.petLogNo}");
			var resultMsg = "게시물이 등록되었어요";
			ui.toast('<div class="link"><p class="tt">'+resultMsg+'</p><a href="javascript:goMyPetLog(\'${session.petLogUrl}\',\'${session.mbrNo}\');" class="lk">바로가기</a></div>',{
			    bot:74  // 바닥에서 띄울 간격
			    ,sec:3000 // 사라질 시간 number
			});
			storageHist.replaceHist("${view.stDomain}/log/home")
		}
		
	}
	
	//펫로그 등록 후 인코딩중인 게시물 hidden
	function videoSectionHide(){
		var section = $(".logContentBox");
		for(var i = 0 ; i < section.length ; i ++){
			if($(".logContentBox").eq(i).find(".vthumbs").data("enchk") == "N"){
				section.eq(i).hide()
			}
		}
	}

	$(document).on("click" , function(){
		//아무대나 눌러도 레이어창 닫힘
		ui.popSel.closeAll();
	});
	$(document).on("input change paste" , "textarea[name=reply]" , function(){
		var value = $(this).val();
		//console.log(value.length);
		
		if(value.length > 300){ 
			ui.toast('300자까지 입력 가능합니다.',{
			    bot:74,  // 바닥에서 띄울 간격
			    sec:2000 // 사라질 시간 number
			});
			$(this).val(value.substr(0 , 300));
		}
		$("button.del").css('visibility','hidden');
	});
	
	$(function(){
		$(document).on('click', '.commendListBox div.tit span', function(){
			$(this).parents('li').find('.pic').trigger('click');
		});
		
	})
	
	function savePetLogReply(petLogNo, listNo, petLogAplySeq){
		if( checkLogin() && checkRegPet() ){
		
			var reply = $("#reply"+listNo+"_"+petLogNo).val().trim();
			 $('#petLogReplyForm [name="petLogNo"]').val(petLogNo);
			 $('#petLogReplyForm [name="aply"]').val(reply);
			 $('#petLogReplyForm [name="petLogAplySeq"]').val(petLogAplySeq);
			 //alert($('#petLogReplyForm [name="aply"]').val());
			 
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
							//alert("<spring:message code='front.web.view.common.msg.result.insert' />");
							ui.toast(msg ,{   // 토스트 창띄우기
								bot:70
							});
							 
							// 댓글목록 재조회
							searchPetLogReply(petLogNo, listNo);
							 
							 $('#uptCmtDisp'+listNo +"_"+petLogNo).css("display","none");
							 
							 // 댓글 입력 시  action Log
							 if( petLogAplySeq == '')  userActionLog(petLogNo, "reply"); 
						
						}
					};
					ajax.call(options);
			 } 

		}
	}
	
	
	function deletePetLogReply (petLogNo, petLogAplySeq, no) {
		ui.confirm('댓글을 삭제할까요?',{ // 컨펌 창 띄우기
			ycb:function(){
				
				$('#petLogReplyForm [name="petLogAplySeq"]').val(petLogAplySeq);
				$('#petLogReplyForm [name="petLogNo"]').val(petLogNo);
				
				var options = {
						url : "<spring:url value='/log/petLogReplyDelete' />"
						, data : $("#petLogReplyForm").serialize()
						, done : function(data){
							//alert("<spring:message code='front.web.view.common.msg.result.delete' />");
							ui.toast('댓글이 삭제되었어요',{   // 토스트 창띄우기
								bot:70
							});

							//callback 함수 호출
							searchPetLogReply(petLogNo, no);
						}
					};
				ajax.call(options);
			},
			ncb:function(){
				//console.log('컨펌취소결과');
				/* ui.toast('취소 되었습니다.',{   // 토스트 창띄우기
					bot:70
				});*/
			},
			ybt:'예',
			nbt:'아니오'	
		});
		
		
		
// 		$('#petLogReplyForm [name="petLogAplySeq"]').val(petLogAplySeq);
// 		 $('#petLogReplyForm [name="petLogNo"]').val(petLogNo);
		 
// 		if(confirm("<spring:message code='front.web.view.common.msg.confirm.delete' />")){
// 			var options = {
// 				url : "<spring:url value='/log/petLogReplyDelete' />"
// 				, data : $("#petLogReplyForm").serialize()
// 				, done : function(data){
// 					alert("<spring:message code='front.web.view.common.msg.result.delete' />");
// 					//callback 함수 호출
// 					searchPetLogReply(petLogNo, no);
// 				}
// 			};
// 			ajax.call(options);
// 		}
	}		

	function viewReply(petLogNo, listNo, obj){
		if( '${view.deviceGb}' == '${frontConstants.DEVICE_GB_10}'){
			searchPetLogReply(petLogNo, listNo);
		}else{
			var selIdx = "";
			var imgIndex = 0 ;
			//var $this  = $(obj).parents(".logContentBox").find(".swiper-container");
			//var idx = $(".logContentBox .swiper-container").index($this);
			var $this  = $(obj).parents(".logContentBox").find(".swiper-container").find(".swiper-pagination-current");
			var idx = $(".logContentBox .swiper-container .swiper-pagination-current").index($this);
			//console.log($(obj).parents(".logContentBox").find(".swiper-container").find(".swiper-pagination-current").text());
			
			if( idx > -1 ){
				//selIdx = swiperBox[0][idx].realIndex;
 				imgIndex = $(obj).parents(".logContentBox").find(".swiper-container").find(".swiper-pagination-current").text();
				if(imgIndex != '0' ){
					selIdx = imgIndex-1 ;
				}else{
				 	selIdx = 0;
				}			 
			}
			
			popupPetLogReply(petLogNo, listNo, selIdx);
		}
	}
	
	function updatePetLogReplySet(petLogNo, petLogAplySeq, listNo){
		 // 수정중 삭제..
		 $(".rewrite").remove();
         $(".date").css("display","block");
		 $(".menu.dopMenuIcon").show();		
		 $('#petLogReplyForm [name="petLogNo"]').val(petLogNo);
		 $('#petLogReplyForm [name="petLogAplySeq"]').val(petLogAplySeq);
		
		 var aplyObj = $("#aply"+ listNo + "_" + petLogNo + "_" +petLogAplySeq);
		 var modify = $("#modify_"+ listNo + "_" + petLogNo + "_" +petLogAplySeq);

		var aply = aplyObj.text();
		//alert(aply);
		
		//탈퇴회원 처리된 닉네임은 수정 시 내용 제외
		aply = aply.replaceAll("@어바웃펫 회원" , "")
		
		 //$('#reply'+listNo +"_"+petLogNo).text(aply);
		 $('#reply'+listNo +"_"+petLogNo).val(aply);
		 
		 // 수정중 disply
		 //$('.alert-commentBox').css("display","block");
		 $('#uptCmtDisp'+listNo +"_"+petLogNo).css("display","block");
		 var span =  $('<div class="rewrite">수정중....</div>');
		 var lenPr = aplyObj.prev().find(".rewrite").length;
		 var lenNe = aplyObj.next().find(".rewrite").length;
			//console.log("len="+len);
		 if(lenPr == 0 && lenNe == 0){
			 aplyObj.next("div").append(span);
			 modify.css("display","none");
		 }

		 // 수정 할 시 해당 댓글 더보기 버튼 hide
		 aplyObj.parent().next().hide();
		 
		 // 등록 버튼 이벤트 셋팅
		 $('#regBtn'+listNo +"_"+petLogNo).removeAttr("onClick");
		 $('#regBtn'+listNo +"_"+petLogNo).attr("onClick","savePetLogReply('"+petLogNo+"','"+listNo+"','"+petLogAplySeq+"');");
		
	}
	
	function searchPetLogReply(petLogNo, no){
		
		 $('#petLogReplyForm [name="petLogNo"]').val(petLogNo);
		 
		//<div class="commentBoxAp logcommentBox pop1" id='" + petLogNo + "'>\			 
		var options = {
			url : "<spring:url value='/log/listPetLogReply' />"
			, data : $("#petLogReplyForm").serialize()
			, done : function(data){				
				
				var replyCnt = data.petLogReplyList.length;					
				
				$("#replyCnt"+no+"_"+petLogNo).text(replyCnt);
				//alert("replyCnt==>"+$("#replyCnt_"+petLogNo).text());
				
				var addHtml = '\
				<div class="head t2">\
					<div class="con">\
						<div class="tit">댓글 <span class="price-box">'  + replyCnt + '</span></div>\
						<a href="javascript:;" class="close" onClick="ui.commentBox.close(this)"></a>\
					</div>\
				</div>\
				<div class="con t2">\
					<div class="box inf">';
				
				if(data.petLogReplyList.length > 0){
					addHtml += '\
						<div class="commendListBox">\
						<ul>';
						
					var listHtml = '';
					for(var i=0; i<data.petLogReplyList.length; i++){ 
						var obj = data.petLogReplyList[i];
						var date = "";
						if( obj.sysRegDtm != null && obj.sysRegDtm != '') date = elapsedTime(obj.sysRegDtm, "년월일");
						
						var pic = '${frame:optImagePath("'+ obj.prflImg +'", frontConstants.IMG_OPT_QRY_490)}';
						if (obj.prflImg == null || obj.prflImg == '') {									
							pic = '../../_images/common/icon-img-profile-default-m@2x.png'
						}	
						var picLink = 'onclick="javascript:goMyPetLog(\'' + obj.petLogUrl+ '\',\''+  obj.mbrNo+ '\',event);"';
						if(obj.mbrStatCd == '50'){ //탈퇴회원인 경우 링크삭제
							picLink = '';
						}
						listHtml += '\
							<li>\
								<div class="pic" '+ picLink +'><img src="'+ pic +'" alt="img"></div>\
								<div class="con">\
									<div class="tit"><span style="cursor:pointer;">' + obj.nickNm;
									
// 							if('${session.mbrNo}'== obj.mbrNo )	{
// 								listHtml += '<span class="nameCardAp">작성자</span>';
// 							}
//console.log(obj.aply)
							listHtml += '\
									</span></div>\
									<div class="txt" id="aply' + no + '_' + obj.petLogNo + '_' + obj.petLogAplySeq+ '">' + obj.aply + '</div>\
									<div class="date"></div>\
									<div class="date" id="modify_' + no + '_' + obj.petLogNo + '_' + obj.petLogAplySeq+ '">' + date + '</div>\
								</div>\
								<!-- select box -->\
								<div class="menu dopMenuIcon" onClick="ui.popSel.open(this,event)">\
									<div class="popSelect">\
										<input type="text" class="popSelInput">\
										<div class="popSelInnerWrap">\
											<ul>';
											
							if('${session.mbrNo}'== obj.mbrNo )	{
								listHtml += '\
												<li><a class="bt" href="javascript:updatePetLogReplySet(\''+ obj.petLogNo +'\',\'' + obj.petLogAplySeq+ '\', \''+ no +'\');"><b class="t">수정</b></a></li>\
												<li><a class="bt" href="javascript:deletePetLogReply(\''+ obj.petLogNo +'\',\'' + obj.petLogAplySeq+ '\', \''+ no +'\');"><b class="t">삭제</b></a></li>';
							}else{
								if( obj.rptpYn == null || obj.rptpYn == 'N'){
								listHtml += '\
												<li><a class="bt" href="javascript:layerPetLogReport(\''+ obj.petLogNo +'\',\'' + obj.petLogAplySeq+ '\', \''+ no + '\');"><b class="t">신고</b></a></li>';
								}else{
									//listHtml += '<li><a class="bt" href="javascript:alert(\'댓글 당 1번만 신고할 수 있습니다.\');">신고</a></li>';
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
					
					// 댓글 수정 중 알림.
// 					addHtml += '\
// 					<div class="alert-commentBox" id="uptCmtDisp'+no+'_'+obj.petLogNo+'" style="display:none;">\
// 						<p><span class="icon-speechBubble"></span>댓글을 수정 중입니다.</p>\
// 						<button class="close" onClick="hideUptCmtDisp(\''+ obj.petLogNo + '\', \''+ no + '\')"></button>\
// 					</div>';
					
				}else{
					addHtml += '\
					<div class="no_data i1">\
						<div class="inr">\
							<div class="msg">첫번째 댓글을 남겨주세요.</div>\
						</div>\
					</div>';						
				}
				
				addHtml += '\
				</div>\
				<div class="input">';
					
			<c:choose>		
				<c:when test="${session.isLogin() ne true}">
				addHtml += '\
					<span id="reply'+ no + '_'+ petLogNo + '_byte"></span>\
					<textarea onClick="checkReplyInput();" placeholder="로그인 후 댓글을 입력해주세요." id="reply'+ no + '_'+ petLogNo + '" name="reply" tabindex="-1"></textarea>';
				</c:when>	
				<c:otherwise>
				addHtml += '\
					<span id="reply'+ no + '_'+ petLogNo + '_byte">\
					<c:if test="${not empty session.prflImg}">
						<img src="${frame:optImagePath(session.prflImg, frontConstants.IMG_OPT_QRY_490)}">\
					</c:if>
					</span>\
					<textarea onClick="checkReplyInput();" placeholder="댓글을 입력해주세요." id="reply'+ no + '_'+ petLogNo + '" name="reply" tabindex="-1"></textarea>\
					<button id="regBtn'+no+ '_'+ petLogNo+ '" name="regBtn" onClick="savePetLogReply(\'' + petLogNo + '\', \''+ no + '\', \'\')">등록</button>';					
				</c:otherwise>
			</c:choose>

				addHtml += '\
				</div>\
				<div class="fixed_box">\
					<div class="key-word-list" style="display:none;">\
						<ul id="add_tag_list_'+ no + '_'+ petLogNo + '">\
						</ul>\
					</div>';
				
				addHtml += '\
					<div class="alert-commentBox" id="uptCmtDisp'+no+'_'+ petLogNo+'" style="display:none;">\
						<p><span class="icon-speechBubble"></span>댓글을 수정 중입니다.</p>\
						<button class="close" onClick="hideUptCmtDisp(\''+ petLogNo + '\', \''+ no + '\')"></button>\
					</div>\
				</div>';
				
				
				// 댓글 수정 중 알림.
				addHtml += '\
			</div>';	
			
				//alert(addHtml);
				$("#pop"+no+"_"+petLogNo).html(addHtml);	
				
				// 태그, 닉네임 자동완성을 위한 셋팅
				roadTagFunc( no , petLogNo );
				
				//댓글 #/@ 링크 변환
				setAplyLink();
				
				ui.addInputDel.createAddSource("#reply"+ no + "_"+ petLogNo);
				
				// 열린 commentBox 가 있으면 먼저 다 닫는다
				$('.commentBoxAp .close').each(function(){
				 	ui.commentBox.close($(this));
				});
				
				ui.commentBox.open('#pop'+no+'_'+petLogNo);		
			}
		};
		ajax.call(options);
	}
	
	
	var firstChar;
	var whileFetching = false;
	var resJsonArr = new Array();
	let abortController;
	// 태그/닉네임 자동완성 관련
	function roadTagFunc( no , petLogNo ){	
		var gb = '';
		$(document).on("input keyup click ", "textarea[name=reply]", function(e) {
			var formData = new FormData();
			let replyId = "reply"+ no + "_"+ petLogNo;
			let element = document.getElementById(replyId);
			let strOriginal = element.value;
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
				firstChar = "\#"
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
						searchTagTxt = '';
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
			            	.then(response => {
			            		var jsonObject = JSON.parse(response);
			            		jsonObject.no = no;
			            		jsonObject.petLogNo = petLogNo;
			            		jsonObject.replyId = replyId;
			            		autoCompleteSuccess(jsonObject , "tag")})
			            	.catch(err => console.log(err))				        
					} else{ 
						$("#add_tag_list_"+ no + "_"+ petLogNo).html("");
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
				            	.then(res => {
				            		var jsonObject = JSON.parse(res);
				            		jsonObject.no = no;
				            		jsonObject.petLogNo = petLogNo;
				            		jsonObject.replyId = replyId;
				            		autoCompleteSuccess(jsonObject , "mention")})
				            	.catch(err => console.log(err))  				        
						} else{ 
							$("#add_tag_list_"+ no + "_"+ petLogNo).html("");
						}
						// xhr 통신 추가 end
						//////////////////////////////////////////////////
					} else return;
				}
		});
	}

	function autoCompleteSuccess(resBody , separator){
		resJsonArr = [];
		whileFetching = false;
		if(resBody.STATUS.CODE == "200"){
			let html = ''
			if( resBody.DATA.ITEMS.length > 0) {
				let item = resBody.DATA.ITEMS;
				if(resBody.petLogNo) $("#add_tag_list_"+ resBody.no + "_"+ resBody.petLogNo).empty();
				else $("#add_tag_list").empty();	
				for(var i=0;i<resBody.DATA.ITEMS.length;i++){
					//',",`와 같은 특수문자가 닉네임에 포함 될 시 스크립트 깨지는 현상때문에 json형태로 수정 
					var resJson = new Object;
					resJson.selTag = unescape(item[i].KEYWORD);
					resJson.firstChar = firstChar;
					resJson.replyId = resBody.replyId;
					resJsonArr.push(resJson)
					
					if(separator == "mention"){
						let pic = '${frame:optImagePath("'+ item[i].PRFL_IMG +'", frontConstants.IMG_OPT_QRY_786)}';
						if (!item[i].PRFL_IMG) {
							pic = '../../_images/common/icon-img-profile-default-m@2x.png'
						}
						html += '<li onclick="javascript:selectTag('+i+');"><div class="pic"><img src="'+ pic + '" style="margin:9px 5px 0px 5px;float:left;width:28px;height:28px;border-radius:100%;overflow:hidden;background:#c7cdd5 no-repeat center;background-size:38px auto;"></div>' + item[i].HIGHLIGHT.replace(/\¶HS¶/gi, '<span>').replace(/\¶HE¶/gi, '</span>')
					}else{
						html += '<li onclick="javascript:selectTag('+i+');" style="color:black;"><span style="color: #669aff";>#</span>' + item[i].HIGHLIGHT.replace(/\¶HS¶/gi, '<span style="color: #669aff;">').replace(/\¶HE¶/gi, '</span>') + '</li>';
					}
				}
			}
			if(resBody.petLogNo) $("#add_tag_list_"+ resBody.no + "_"+ resBody.petLogNo).html(html); 
			else $("#add_tag_list").html(html);  
			$(".key-word-list").css("display", "block");
		}
	}
	
	// 댓글,만들기 #/@ 검색어 선택
	function selectTag(index){
		let element;
		if(resJsonArr[index].replyId){
			 element = document.getElementById(resJsonArr[index].replyId);
			$("#"+resJsonArr[index].replyId).trigger('blur');
			$("#"+resJsonArr[index].replyId).focus();
		}else{
			element = document.getElementById('dscrt');
			$("#dscrt").trigger('blur');
			$("#dscrt").focus();
		}
		
		let strOriginal = element.value;
		let iStartPos = element.selectionStart;
		let iEndPos = element.selectionEnd;
		
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
		
		console.log(resJsonArr)
		var fromFirstChar =  strOriginal.substring(selTagChar, strOriginal.length)
		var selTagFind = new RegExp(/^[@#][^\s@#]*/, 'g')
		var selTagReplLength = fromFirstChar.match(selTagFind)[0].length
		var selTagRepl = resJsonArr[index].firstChar+resJsonArr[index].selTag;
		var afterSelTagStr =fromFirstChar.substring(selTagReplLength,fromFirstChar.length)
		var space = afterSelTagStr.substring(0, 1) == ' ' ? '' : ' ';
		
		
		element.value = b4firstCharStr+selTagRepl+space+afterSelTagStr
		
		$("#add_tag_list").html("");
		$(".key-word-list").css("display", "none");
	};

	
	function checkReplyInput(){

		if( checkLogin() && checkRegPet() ){
			//alert('등록 가능');
			// 키패드 노출..
		} 
	}
	

	function hideUptCmtDisp(petLogNo, listNo){
		// 컨펌 띄우기
		
		ui.confirm('댓글 수정을 취소할까요?',{ // 컨펌 창 옵션들
			ycb:function(){
				// 수정중 삭제..
				$(".rewrite").parents(".con").next().show()
				$(".rewrite").remove();
				
				$('#uptCmtDisp'+listNo +"_"+petLogNo).css("display","none");
				$(".date").css("display","block");
				$(".del").trigger("click");
				$("#reply"+listNo+"_"+petLogNo).val("");
				$('#regBtn'+listNo +"_"+petLogNo).attr("onClick","savePetLogReply('"+petLogNo+"','"+listNo+"','');");
				$("#add_tag_list_"+listNo+"_"+petLogNo).html('');
			},
			ncb:function(){
				return false;
			},
			ybt:"예", // 기본값 "확인"
			nbt:"아니오"  // 기본값 "취소"
		});		
		
		
	}
	
	// 관심구분코드(10-좋아요, 20-찜) 
	function savePetLogInterest(petLogNo, intsGbCd, saveGb, listNo){
		if( checkLogin() ){
		
			 $('#petLogInterestForm [name="intsGbCd"]').val(intsGbCd);
			 $('#petLogInterestForm [name="petLogNo"]').val(petLogNo);
			 $('#petLogInterestForm [name="saveGb"]').val(saveGb);
	
			 var action = "like";
			 
			 var options = {
				url : "<spring:url value='/log/petLogInterestSave' />"
				, data : $("#petLogInterestForm").serialize()
				, done : function(data){
					//alert("<spring:message code='front.web.view.common.msg.result.insert' />");
					if(data.existCheck == "Y"){
						saveGb = "D";
					}
					if( intsGbCd == '20' ){	
						action = "interest";
						
						var tText = '<div class="link"><p class="tt">찜리스트에 추가되었어요</p><a href="/mypage/log/myWishList" data-content="${session.mbrNo}" data-url="/mypage/log/myWishList" class="lk">바로가기</a></div>';
						if( saveGb == 'D') tText = "찜리스트에서 삭제되었어요";
						ui.toast(tText,{   // 토스트 창띄우기
							bot:70
						});
					}			
					
					//callback 함수 호출
					//alert(data.petLogNo+"등록되었습니다.");
					var cnt = 0;
					if( intsGbCd == '10' ) cnt = data.likeCnt;
					reloadInterest(petLogNo, intsGbCd, saveGb, listNo, cnt);
					
					if( saveGb == 'D'){
						action += "_d";						
					}
					userActionLog(petLogNo, action);	
					 
				}
			};
			ajax.call(options);
		}
	}	
	
	// 좋아요/찜하기 등록/삭제 후 리로드
	function reloadInterest(petLogNo, intsGbCd, saveGb, listNo, cnt){
		var addHtml = '';
		//alert(petLogNo+","+intsGbCd+","+saveGb+","+listNo+","+cnt);
		if( intsGbCd == "10" ){	// 좋아요
			if( saveGb == 'I'){
				addHtml = '<button class="logBtnBasic btn-like on" onclick="savePetLogInterest(\''+petLogNo+'\',\'10\',\'D\',\''+ listNo + '\');">' + cnt + '</button>';	
			}else{
				addHtml = '<button class="logBtnBasic btn-like" onclick="savePetLogInterest(\''+petLogNo+'\',\'10\',\'I\',\''+ listNo + '\');">' + cnt + '</button>';	
			}
		//alert(addHtml);
		
			$("#likeBtn"+listNo+"_"+petLogNo).html("");
			$("#likeBtn"+listNo+"_"+petLogNo).html(addHtml);	
			
		}else{					// 찜하기
			if( saveGb == 'I'){
				addHtml = '<button class="logBtnBasic btn-bookmark on" onclick="savePetLogInterest(\''+petLogNo+'\',\'20\',\'D\',\''+ listNo + '\');"><span>북마크</span></button>';	
			}else{
				addHtml = '<button class="logBtnBasic btn-bookmark" onclick="savePetLogInterest(\''+petLogNo+'\',\'20\',\'I\',\''+ listNo + '\');"><span>북마크</span></button>';	
			}
			$("#bookBtn"+listNo+"_"+petLogNo).html("");
			$("#bookBtn"+listNo+"_"+petLogNo).html(addHtml);	
		}
	}
	
	
	// 공유채널코드(10:카카오, 20:네이버, 30:URL, 40:APP)
	function sharePetLog(shareNo, objId, shareGb){
		
		var shortUrl = $("#"+objId).attr("data-clipboard-text");
		var nickNm = $("#"+objId).attr("data-title");
		
		if( shortUrl == null || shortUrl == '') {
			getShortUrl(shareNo, objId, shareGb, nickNm);
		}else{
			//alert(shortUrl);
			insertPetLogShare(shareNo, objId, shareGb, shortUrl, nickNm);
		}
	}
	
	// 공유채널코드(10:카카오, 20:네이버, 30:URL)
	function insertPetLogShare(shareNo, objId, shareGb, shortUrl, nickNm){
		var shrChnlCd = "40";	 // app 일 경우.
		var shrPetLogUrl, petLogNo;
		if( shareGb == "M" ){
			if( objId.indexOf("_") > 0 ) shrPetLogUrl = objId.substring(objId.indexOf("_")+1);
			else shrPetLogUrl = objId;
		}
		else{
			petLogNo = shareNo;
		}
		
		
	<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_30 }">	
		copyUrl(objId);
		shrChnlCd = "30";
		ui.toast($("#"+objId).attr("data-message"), {
			bot:70
		});
	</c:if>
		
		var options = {
			url : "<spring:url value='/log/petLogShareInsert' />"
			, data : {
				petLogNo : petLogNo 
				, shrPetLogUrl : shrPetLogUrl
				, shrChnlCd : shrChnlCd //공유채널코드 (30:URL)
			}
			, done : function(data){
				// action log 처리
				userActionLog(petLogNo, "share"); 
				
				//alert("${view.deviceGb}");
			<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_30 }">	
				callAppFunc("onShare", shortUrl, nickNm);
			</c:if>
				
			}
		};
		ajax.call(options);
	}
	
	
	function getShortUrl(shareNo, objId, shareGb, nickNm){
		var originUrl = "${view.stDomain}/log/petLogShare?shareGb="+shareGb+"&shareNo="+shareNo;
		
		if( shareGb !== undefined && shareGb == 'M'){
			if( objId.indexOf("_") > 0 ){
				originUrl = "${view.stDomain}/log/petLogShare?shareGb="+shareGb+"&shareNo="+objId.substring(objId.indexOf("_")+1)+"_"+shareNo;
			}else{
				originUrl = "${view.stDomain}/log/petLogShare?shareGb="+shareGb+"&shareNo="+objId+"_"+shareNo;
			}
		}
			
			
		//alert(originUrl);
		var options = {
				url : "<spring:url value='/log/getShortUrl' />",
				data : {
					originUrl : originUrl
					,shareGb : shareGb
					,shareNo : shareNo
				},
				done : function(data) {
					if( data == null ){
						ui.alert("getShortUrl : 오류가 발생되었습니다. 다시 시도하여 주십시오.");
						//return null;
					}else{
						$("#"+objId).attr("data-clipboard-text", data);					
						//$("#"+objId).trigger("click");
						sharePetLog(shareNo, objId, shareGb);
					}
				}
			}
			ajax.call(options);
	}
	
	/******************************************************************
	//공유하기 APP
	function regShareApp(shortUrl){	
		toNativeData.func = "onShare";
		toNativeData.link = shortUrl;				
		toNative(toNativeData);
	}
	/******************************************************************/

	// 신고하기 layer popup 띄우기
	function layerPetLogReport(petLogNo, petLogAplySeq, listNo, rvwYn){
		if( checkLogin() ){	
			ui.popLayer.open("popReport");
			
			// layer form 초기화.
			form.clear('petLogRptpForm');
			$('#petLogRptpForm [name="rptpRsnCd"]').prop('checked', false);		
			
			
			var $title = $(".pbd .phd .tit"); 
			if(petLogAplySeq != undefined && petLogAplySeq != '' ){
				$title.text("댓글 신고 ");
			}else{
				if( rvwYn != null && rvwYn != '' && rvwYn == "Y" ){
					$title.text("후기 신고 ");
				}else{
					rvwYn = "N";
					$title.text("게시물 신고 ");
				}
				$('#petLogRptpForm [name="rvwYn"]').val(rvwYn);
			}
			
			$('#petLogRptpForm [name="petLogNo"]').val(petLogNo);
			$('#petLogRptpForm [name="petLogAplySeq"]').val(petLogAplySeq);
			$('#petLogRptpForm [name="mbrNo"]').val('${session.mbrNo}');
			$('#petLogRptpForm [name="listNo"]').val(listNo);

			
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
	$(document).ready(function(){
		$(document).on("propertychange change keyup paste input" , "[name=rptpContent]"  , function(){
			var toastH;
			
			if(isIOS()){
			 	toastH = 330 - $(".pct").scrollTop();
			}else{
				toastH = 70;
			}
			
			if($(this).val().length > 200){
				ui.toast("내용은 200자까지 입력할 수 있어요." , {  
					bot:toastH
				});
				$(this).val($(this).val().substring(0,200))
			}
		})	
		
		$(document).on('propertychange change keyup paste input click focus', 'textarea', function(){
			if($('#popReport').css('display') == 'block'){
				if($(this).parents('#popReport').length != 1){
					$(this).blur();
				}
			}
		});
		
		$(document).on("propertychange change keyup paste input" , "[name=rptpRsnCd]" , function(){
			var checked = $("[name=rptpRsnCd]:checked").val();
			if(checked){
				$("#commitBtn").removeClass("disabled");
			}else{
				$("#commitBtn").addClass("disabled");
			}
		})
	})
	// 신고하기 등록
	function insertPetLogRptp(layerPop){
		if($("input[type=radio][name='rptpRsnCd']").is(":checked") == false){
			ui.toast('신고 사유를 선택해주세요.',{   // 토스트 창띄우기
				bot:70
			});
			
			$("#petLogRptpForm [name='rptpRsnCd']").eq(0).focus();
			return false;			
		}
		
// 		if($("[name=rptpContent]").val().length <= 0){
// 			ui.toast("신고 내용을 입력해주세요.")
// 			return false;
// 		}
		
		var petLogNo = $('#petLogRptpForm [name="petLogNo"]').val();
		var listNo = $('#petLogRptpForm [name="listNo"]').val();
		var petLogAplySeq = $('#petLogRptpForm [name="petLogAplySeq"]').val();

		var options = {
			url : "<spring:url value='${view.stDomain}/log/petLogRptpInsert' />"
			, data : $("#petLogRptpForm").serialize()
			, done : function(data){
				//alert("<spring:message code='front.web.view.common.msg.result.insert' />");
				ui.toast('신고가 완료되었어요',{   // 토스트 창띄우기
					bot:70
				});				
				//callback 함수 호출
				ui.popLayer.close(layerPop);
				if( petLogAplySeq != '' ){
					searchPetLogReply(petLogNo, listNo);
				}else{
					var rvwYn = $('#petLogRptpForm [name="rvwYn"]').val();
					var obj = "#btRptp"+listNo+"_"+petLogNo;						
					$(obj).removeAttr("href");
					
					if( rvwYn != null && rvwYn != '' && rvwYn == 'Y' ) $(obj).attr("onClick" ,"javascript:ui.toast('이미 신고한 후기에요',{ bot:70 });");	
					else $(obj).attr("onClick" ,"javascript:ui.toast('이미 신고한 게시물이에요',{ bot:70 });");	
				}
			}
		};
		ajax.call(options);
	}
	
	// 모바일 - 댓글 팝업 띄우기.
	function popupPetLogReply(petLogNo,listNo, idx){
		var selIdx = "";
		if( idx != undefined && idx != ''){
			selIdx = "&selIdx="+idx;
		}
		//alert("selIdx="+selIdx);
		
// 		var options = {
// 			url : "${view.stDomain}/log/popupPetLogReplyList"
// 			, data : {
// 				callBackFnc : replyCallBack
// 				, petLogNo : petLogNo
// 				, listNo : listNo+selIdx
// 			}
// 			, dataType : "html"
// 			, done : function(html){
// 				console.log(html);
// 			}
// 		}
// 		ajax.call(options)
		if(opener == null){
			window.open("${view.stDomain}/log/popupPetLogReplyList?callBackFnc=replyCallBack&petLogNo="+petLogNo+"&listNo="+listNo+selIdx, "replyPopup");
		}else{
			location.href = "${view.stDomain}/log/popupPetLogReplyList?callBackFnc=replyCallBack&petLogNo="+petLogNo+"&listNo="+listNo+selIdx;
		}
	}
	

	
	
	function replyCallBack(result , mbrNo){
		$("#replyCnt"+result.listNo+"_"+result.petLogNo).text(result.replyCnt);

		if(mbrNo != "${session.mbrNo}"){
			location.reload();
			$("html , body ").scrollTop(0)
		}else{
			if(result.imgSrcArr){
				for(var i = 0 ; i < result.imgSrcArr.length ; i++){
					$("#"+result.petLogNo).find("img").eq(i+1).attr("src" , result.imgSrcArr[i]);
				}
			}
		}
		if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
			callAppFunc('onDisableKeyboardEvent');
			callAppFunc('onPetLogEncodingCheck' , 'onPetLogEncodingCheckCallback' , 'Y');
		}
	}
	// 회원 - 팔로우
	function saveFollowMapMember(mbrNo, saveGb, obj){
		var followId = $(obj).attr("id");
		
		if( checkLogin() && checkRegPet() ){
			var options = {
				url : "<spring:url value='/log/followMapMemberSave' />"
				, data : {
					mbrNoFollowed : mbrNo
					,saveGb : saveGb
					,mbrNo : '${session.mbrNo}'
				}
				, done : function(data){
					//alert("<spring:message code='front.web.view.common.msg.result.insert' />");
					var tMsg = "친구를 팔로우 했어요";
					var action = "followm";
					//callback 함수 호출
					if( saveGb == 'I' ){
						$(obj).removeClass('a');
						$(obj).removeClass('b');
						$(obj).addClass('c');
						$(obj).text('팔로잉');
						saveGb = 'D';
						
						//다른탭에서도 동일한 회원이 존재하는경우 팔로잉처리
						if(followId != '' && followId != null){
							if(followId.indexOf("I_") > -1){
								followId = followId.replace("I_","IW_");
							}else if(followId.indexOf("IW_") > -1){
								followId = followId.replace("IW_","I_");
							}else if(followId.indexOf("D_") > -1){
								followId = followId.replace("D_","DW_");
							}else if(followId.indexOf("DW_") > -1){
								followId = followId.replace("DW_","D_");
							}
							
							$("#"+followId).removeClass('a');
							$("#"+followId).removeClass('b');
							$("#"+followId).addClass('c');
							$("#"+followId).text('팔로잉');
							
							$("#"+followId).removeAttr("onClick");
							$("#"+followId).attr("onClick","saveFollowMapMember('"+mbrNo+"','D', this);");	
						
						}
						
						//헤더 팔로잉 버튼이 기존 버튼 디자인과 다름
						var mdtLength = $(obj).closest(".mdt").length;
						if(mdtLength > 0){
							$(obj).removeClass('c');
							$(obj).addClass('a');
						}
					}
					else{
						$(obj).removeClass('b');
						$(obj).removeClass('c');
						$(obj).addClass('a');
						$(obj).text('팔로우');
						saveGb = 'I';
						tMsg = "팔로우를 취소했어요";
						action = "followm_d";
						
						//다른탭에서도 동일한 회원이 존재하는경우 팔로잉처리
						if(followId != '' && followId != null){
							if(followId.indexOf("I_") > -1){
								followId = followId.replace("I_","IW_");
							}else if(followId.indexOf("IW_") > -1){
								followId = followId.replace("IW_","I_");
							}else if(followId.indexOf("D_") > -1){
								followId = followId.replace("D_","DW_");
							}else if(followId.indexOf("DW_") > -1){
								followId = followId.replace("DW_","D_");
							}
							
							$("#"+followId).removeClass('b');
							$("#"+followId).removeClass('c');
							$("#"+followId).addClass('a');
							$("#"+followId).text('팔로우');
							
							$("#"+followId).removeAttr("onClick");
							$("#"+followId).attr("onClick","saveFollowMapMember('"+mbrNo+"','I', this);");
					
							 
						}						

					}		
					
					ui.toast(tMsg,{   // 토스트 창띄우기
						bot:70
					});
					
					 // 팔로우/팔로잉 버튼 이벤트 셋팅
						 $(obj).removeAttr("onClick");
						 $(obj).attr("onClick","saveFollowMapMember('"+mbrNo+"','"+saveGb+"', this);");
					 
					// action log 처리
					userActionLog(mbrNo, action); 	
					$.cookie("reloadYn" , "Y" , {path:"/"})
				}
			};
			ajax.call(options);
		}
	}	
	
	function checkLogin(){
		<c:choose>		
			<c:when test="${session.isLogin() ne true}">
				ui.confirm('로그인 후 서비스를 이용할 수 있어요.<br>로그인 할까요?',{ // 컨펌 창 옵션들
					ycb:function(){
						//location.href = "${view.stDomain}/indexLogin";
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
// 		var returnFlag;
// 		var promise = new Promise(function(resolve , reject){
// 		var options = {
// 				url : "/log/checkRegPet"
// 				, data : {
// 					mbrNo : "${session.mbrNo}"		
// 				}
// 				, done : function(result){
// 					if(result < 1){
// 						ui.confirm('펫 등록 후 서비스를 이용할 수 있어요<br/>등록 할까요?',{ // 컨펌 창 옵션들
// 			 				ycb:function(){
// 			 					// 반려동물 등록 화면으로 이동.
// 			 					location.href = "${view.stDomain}/my/pet/petInsertView";
// 			 				},
// 			 				ncb:function(){
// 			 					//alert('취소');
// 			 					return false;
// 			 				},
// 			 				ybt:"등록하기", // 기본값 "확인"
// 			 				nbt:"취소"  // 기본값 "취소"
// 						});
// 						returnFlag = false;
// 					}else{
// 						returnFlag = true;
// 					}
// 			}
// 		}
// 		ajax.call(options);
// 		})
// 		return returnFlag(returnFlag)

		if("${loginUserInfo.petRegYn}" == "Y"){
			return true
		}else{
			ui.confirm('펫 등록 후 서비스를 이용할 수 있어요<br/>등록 할까요?',{ // 컨펌 창 옵션들
	 				ycb:function(){
	 					// 반려동물 등록 화면으로 이동.
	 					location.href = "${view.stDomain}/my/pet/petInsertView";
	 				},
	 				ncb:function(){
	 					//alert('취소');
	 					return false;
	 				},
	 				ybt:"등록하기", // 기본값 "확인"
	 				nbt:"취소"  // 기본값 "취소"
				});
			return false;
		}
	}
	// 태그 - 팔로우
	function saveFollowMapTag(tagNo, saveGb, obj){
		if(tagNo == null || tagNo == ""){
			ui.alert('팔로우 할 수 없는 태그입니다.');
			return;
		}
		if( checkLogin() && checkRegPet() ){			
			var options = {
				url : "<spring:url value='/log/followMapTagSave' />"
				, data : {
					tagNoFollowed : tagNo
					,saveGb : saveGb
					,mbrNo : '${session.mbrNo}'
				}
				, done : function(data){
					//alert("<spring:message code='front.web.view.common.msg.result.insert' />");
					var tMsg = "태그를 팔로우 했어요";
					var action = "followt";
					//callback 함수 호출
					if( saveGb == 'I' ){
						$(obj).removeClass('a');
						$(obj).removeClass('c');
						$(obj).addClass('b');
						$(obj).text('팔로잉');
						saveGb = 'D';
					}
					else{
						$(obj).removeClass('b');
						$(obj).removeClass('c');
						$(obj).addClass('a');
						$(obj).text('팔로우');
						saveGb = 'I';
						tMsg = "팔로우를 취소했어요";
						action = "followt_d";
					}					
					ui.toast(tMsg,{   // 토스트 창띄우기
						bot:70
					});
					
					 // 팔로우/팔로잉 버튼 이벤트 셋팅
					 $(obj).removeAttr("onClick");
					 $(obj).attr("onClick","saveFollowMapTag('"+tagNo+"','"+saveGb+"', this);");					
					 
					// action log 처리
					userActionLog(tagNo, action); 
				}
			};
			ajax.call(options);
		}
	}	
	
	
	function goLikePetLogList(selIdx , page){			
		/* var param ="";
		if( idx !== undefined && idx != '' ) param = "?petLogNo="+idx;
		location.href = "${view.stDomain}/log/indexLikePetLogList"+param;	 */	
		
		goPetLogList("L", selIdx , page);
	}
	
	function goPetLogList(pageType, selIdx , page){
		var param ="";
		
		if(selIdx ){			
			param += "?selIdx="+selIdx;
		}
		// 태그리스트, 마이펫로그 리스트의 경우, title 셋팅
		if(pageType){
			if(param.length > 1 ) param += "&pageType="+pageType;
			else param += "?pageType="+pageType;
		}
		
		if(page){
			param += "&recommendPage="+page
		}
		
		location.href = "${view.stDomain}/log/indexPetLogList"+param;
	}
	
	
	// 태그 모아보기
	function goPetLogTagList(tag , sidx){
		var url = "${view.stDomain}/log/indexPetLogTagList?tag="+tag;
		if(sidx){
			url = url + "&sidx="+sidx;
		}
		location.href = url;
	}
	
	// 펫로그 삭제 --> 확인 후 작업.(TODO)
	function deletePetLog (petLogNo) {		
		var resultMsg = "게시물이 삭제되었어요";
		ui.confirm('게시물을 삭제할까요? ',{ // 컨펌 창 띄우기
			ycb:function(){
				var options = {
						url : "<spring:url value='/log/petLogBaseDelete' />"
						, data : {petLogNo : petLogNo}
						, done : function(data){
							$("#"+petLogNo).remove();					
							ui.toast('<div class="link"><p class="tt">'+resultMsg+'</p><a href="javascript:goMyPetLog(\'${session.petLogUrl}\',\'${session.mbrNo}\');" class="lk">바로가기</a></div>',{
								bot:70
							});
						var petLogOne = $(".logContentBox").length;
						if(petLogOne == 1){
							$('.hdr').removeClass("active");
							}
						}
					}
					ajax.call(options);
			},
			ncb:function(){
				return false;
			},
			ybt:'예',
			nbt:'아니오'	
		});
	}
	
	// 펫로그 만들기
	function goPetLogInsertView(tag){
	<c:choose>
		<c:when test="${view.deviceGb ne frontConstants.DEVICE_GB_30 }">
			ui.confirm('어바웃펫 앱에서 이용할 수 있어요<br>앱으로 이동할까요?',{ // 컨펌 창 옵션들
				ycb:function(){
					
					if("${view.os}"=="${frontConstants.DEVICE_TYPE_20}"){ //IOS
						location.href = "https://BXPD5Og4xEKwhWif2aXoog.adtouch.adbrix.io/api/v1/click/q0Tv42H19kWYmqRJzTFsyw?m_adid=__device_id__&cb_5=__callback_param__&cb_1=__AID__%5F__CID__%5F__CAMPAIGN_ID__&cb_2=__UA__%5F__UA1__&cb_3=__IDFA__%5F__OS__%5F__GAID__&cb_4=__TS__%5F__IP__%5F__SL__";
					}else{
						// location.href = "Intent://splash#Intent;scheme=aboutpetlink;package=com.petsbe.android.petsbemall;end";
						location.href = "https://BXPD5Og4xEKwhWif2aXoog.adtouch.adbrix.io/api/v1/click/kMT9ioBptEGz51TtzV712A";
					}
				},
				ncb:function(){
					return false;
				},
				ybt:"앱으로 이동", // 기본값 "확인"
				nbt:"취소"  // 기본값 "취소"
			});	
		</c:when>
		<c:otherwise>
			if( checkLogin() && checkRegPet() ){
				var param = "";
				if( tag !== undefined && tag !== '' ) param = "&tag="+tag;		
				location.href = "${view.stDomain}/log/indexPetLogInsertView?petLogChnlCd=${frontConstants.PETLOG_CHNL_10}"+param;	
			}
		</c:otherwise>
	</c:choose>
	}

	// 펫로그 수정하기
	function updatePetLog(petLogNo){
		<c:choose>
		<c:when test="${view.deviceGb ne frontConstants.DEVICE_GB_30 }">
			ui.toast("게시물 수정은 모바일 앱에서만 할 수 있어요",{   // 토스트 창띄우기
				bot:70
			});	
		</c:when>
		<c:otherwise>		
			location.href = "${view.stDomain}/log/indexPetLogUpdateView?petLogNo="+petLogNo;
		</c:otherwise>
	</c:choose>
	}
	
	
	function goFollowList(tabGb, mbrNo){
		location.href = "${view.stDomain}/log/indexMyFollowList?tabGb="+tabGb+"&mbrNo="+mbrNo;
	}
	
// 	function goFollowerList(mbrNo, nickNm){
// 		location.href = "${view.stDomain}/log/indexMyFollowerList?mbrNo="+mbrNo+"&nickNm="+nickNm;
// 	}
	
// 	function goFollowingList(mbrNo, nickNm){
// 		location.href = "${view.stDomain}/log/indexMyFollowingList?mbrNo="+mbrNo+"&nickNm="+nickNm;
// 	}	
	
	function goMyPetLog(petLogUrl, mbrNo, event , insertYn){
		if(!insertYn){
			insertYn = "N";
		}
		
		//event.preventDefault;
		if(event !== undefined ){
			if(event.stopPropagation() !== undefined ){
				event.stopPropagation();
				//console.log("111-"+event.stopPropagation())		
			}else{
				//console.log("222-"+event.cancelBubble)
				event.cancelBubble = true;
			}
		}
		location.href = "${view.stDomain}/log/indexMyPetLog/"+ petLogUrl + "?mbrNo=" + mbrNo + "&insertYn="+insertYn;
	}
	
	
	function goMyPetLogWithRate(petLogUrl, mbrNo, rate, event){
		//event.preventDefault;
		if(event !== undefined ){
			if(event.stopPropagation() !== undefined ){
				event.stopPropagation();
				//console.log("111-"+event.stopPropagation())		
			}else{
				//console.log("222-"+event.cancelBubble)
				event.cancelBubble = true;
			}
		}
		location.href = "${view.stDomain}/log/indexMyPetLog/"+ petLogUrl + "?mbrNo=" + mbrNo+"&rate="+rate;
	}
	
	
	function goPetLogHome(){
		//location.href = "${view.stDomain}/log/home";
		history.back();
	}
	
	//위치 관련 설정 체크
	function checkLocationSetting(){
		//alert("checkLocationSetting::appLocAuthYn:"+appLocAuthYn);		
		//appLocAuthYn = "Y";// web 에서 테스트를 위해서 추가함.(TODO : 테스트 후 삭제해야함.)
		// 약관동의 여부 확인
		if( appLocAuthYn == "N"){		
			
			// App 위치정보 서비스 설정 확인
			//alert(" App 위치정보 서비스 설정 확인~");
			callAppFunc("onCurrentLoc");
							
		}else{
			if( pstInfoAgrYn == "N" ){
				// 약관동의 팝업 띄우기//
			ui.confirm('위치정보 기반 서비스 제공을 위해<br/>위치정보를 수집, 이용하는 것에 동의합니다.<br/><a style="text-decoration:underline;" href="javascript:openTermsSetting(\'2003\', \'Y\');">위치기반서비스 이용약관</a><br/>앱을 사용하는 동안 사용자의 위치에 접근하도록<br/>허용하시겠습니까?',{ 
			//ui.confirm('위치정보 기반 서비스 제공을 위해<br/>위치정보를 수집, 이용하는 것에 동의합니다.<br/>위치기반서비스 이용약관<br/>앱을 사용하는 동안 사용자의 위치에 접근하도록<br/>허용하시겠습니까?',{ 
					ycb:function(){
						//alert("약관동의 Y : memberInfoSave 호출");
						// 약관동의 저장하기.
						memberInfoSave();					
					},
					ncb:function(){				
						//alert("약관동의 N : 위치서비스 설정하기 노출");
						// 위치서비스 설정하기 노출
						setResultArea('');					
						return false;
					},
					ybt:"허용", // 기본값 "확인"
					nbt:"허용안함"  // 기본값 "취소"
				});
				

			}else{
				// 모두 동의 한 경우.
				// 결과 영역 empty
				//alert("setResultArea call : 모두 Y");
				setResultArea(kakao.maps.services.Status.OK);
			}
		}

	}
	
	
	
	//위치 관련 설정 체크
/* 	function checkLocationSetting(){
		//alert("checkLocationSetting::appLocAuthYn:"+appLocAuthYn);
		// 약관동의 여부 확인
		if( pstInfoAgrYn == "N"){
			// 약관동의 팝업 띄우기//
			ui.confirm('위치정보 기반 서비스 제공을 위해<br/>위치정보를 수집, 이용하는 것에 동의합니다.<br/><a href="javascript:openTermsSetting(\'47\', \'N\');">위치기반서비스 이용약관</a><br/>앱을 사용하는 동안 사용자의 위치에 접근하도록<br/>허용하시겠습니까?',{ 
				ycb:function(){
					//alert("약관동의 Y : memberInfoSave 호출");
					// 약관동의 저장하기.
					memberInfoSave();					
				},
				ncb:function(){				
					//alert("약관동의 N : 위치서비스 설정하기 노출");
					// 위치서비스 설정하기 노출
					setResultArea('');					
					return false;
				},
				ybt:"허용", // 기본값 "확인"
				nbt:"허용안함"  // 기본값 "취소"
			});				
		}else{
			if( appLocAuthYn == "N" ){
				// App 위치정보 서비스 설정 확인
				//alert(" App 위치정보 서비스 설정 확인~");
				callAppFunc("onCurrentLoc");
			}else{
				// 모두 동의 한 경우.
				// 결과 영역 empty
				//alert("setResultArea call : 모두 Y");
				setResultArea(kakao.maps.services.Status.OK);
			}
		}

	} */
	
	
	//위치정보 약관동의 저장
	function memberInfoSave(){	
		 var options = {
			url : "<spring:url value='/log/memberInfoSave' />"
			, data : {
				pstInfoAgrYn : "Y"
			}
			, done : function(data){
				ui.toast("위치기반서비스 이용약관 동의 되었습니다.",{   // 토스트 창띄우기
					bot:70
				});	
				
				pstInfoAgrYn = "Y";					

	 			// 결과 영역 empty
	 			setResultArea(kakao.maps.services.Status.OK);				
				
				//alert("APP 위치서비스 활성화 여부 확인");
				//console.log("위치정보 서비스 설정 확인: app ");					
				// App 위치정보 서비스 설정 확인
			 	//callAppFunc("onCurrentLoc"); //주석 처리 순서 바뀜.
			}
		};
		ajax.call(options);
		
	}

	// 위치검색 팝업 로드 시.
	function onCurrentLocCallBack(resultJson){
		//alert("onCurrentLocCallBack:resultJson:" + resultJson);
		var result = $.parseJSON(resultJson);
		//alert("onCurrentLocCallBack:result:" + result);//이건 그냥 object
		
		if( result.authYn !== undefined && result.authYn == 'Y'){
			appLocAuthYn = "Y";		
			
 			$('#petLogLocForm [name="logLttd"]').val(result.latitude); //위도
 			$('#petLogLocForm [name="logLitd"]').val(result.longitude);//경도
 			checkLocationSetting();
 			
// 			// 결과 영역 empty
// 			setResultArea(kakao.maps.services.Status.OK);
		}else{
			appLocAuthYn = "N";
			// 위치서비스 설정 노출
 			setResultArea('');
		}
	}	
	
	/******************************************************************************/
	// 펫로그 등록(사진/동영상 등록 관련-미리보기, 삭제, 업로드)
	// 선택 이미지 미리보기
	function onOpenGalleryCallBack ( resultJson ) {
		//alert("onOpenGalleryCallBack.resultJson==>"+resultJson);
		var result = $.parseJSON(resultJson);
		var fileId = result.fileId;
		//alert("onOpenGalleryCallBack.ext==>"+result.ext);// object
		// onImageEdit 의 callBack 일 경우
		if( result.editFileId != undefined && result.editFileId != null){
			//alert("onImageEdit callback ->" + result.editFileId);
			/*
			if( $("#"+result.fileId).closest("li") !== undefined ) $("#"+result.fileId).closest("li").remove();			
			fileId = result.editFileId;
			*/
			
			// 편집한 파일의 src 와 id만 변경한다 - 2021.04.06
			$("#"+result.fileId).attr("src", result.imageToBase64);
			$("#"+result.fileId).attr("alt", result.mediaType);
						
			$("#"+result.fileId).parent("div").prev().prop("href", "javascript:callAppFunc('onDeleteImage','" + result.editFileId +"');");
			$("#"+result.fileId).next().prop("href", "javascript:callAppFunc('onImageEdit','" + result.editFileId +"');"); 
			
			$("#"+result.fileId).attr("id" ,result.editFileId);			
			
			resizeImg();
			// 등록버튼 활성/비활성화.(slide 안함)
			reloadImageView('E');
			
		}else{	
		
			//alert("onOpenGalleryCallBack.result.mediaType==>"+result.mediaType);
			//alert("onOpenGalleryCallBack.result.fileId==>"+fileId);
			var editHtml = '';
			// 이미지인 경우만 편집가능하도록
			if(result.mediaType == "I" ){ //&& result.ext != "gif" ){
				//alert("onOpenGalleryCallBack.result.fileName="+result.fileName);
				//if( result.fileName.indexOf(".gif") > -1 ) alert("onOpenGalleryCallBack.gif 임");
				editHtml = '<a href="javascript:callAppFunc(\'onImageEdit\',\''+ fileId + '\',\'' + result.ext + '\');" class="pic_icon onWeb_b"></a>';
			}
			
			var addHtml = '<li class="swiper-slide">'
						 + 	'<a href="javascript:callAppFunc(\'onDeleteImage\',\''+ fileId + '\');" class="lmp_colseBt onWeb_b"></a>'
						 + 	'<div class="pic">'
						// + 	 	'<input type="hidden" name="imgPath" />'				
						 + 	 	'<img class="img" name="petLogImgPathView" id="'+ fileId + '" src="' + result.imageToBase64 +'" alt="'+result.mediaType +'" style="width:100%"/>'
						 + 	editHtml
						 + 	'</div>'
						 +'</li>';
						 
			//alert(addHtml);
			$("#add_image_list").append(addHtml);
			
			resizeImg();
			//madePetlog.update(); // 04.12 주석처리
			
			// 등록버튼 활성/비활성화.
			reloadImageView("G"); // 2021.04.22 - 갤러리 오픈상태에서는 편집/추가 버튼 노출 안시키게
		
		}
		
		
		//madePetlog.slideTo( );
		
		// 등록버튼 활성/비활성화.
		//reloadImageView();
// 		if( selectImageVod() ) $(".btnSet a").removeClass("disabled");
// 		else $(".btnSet a").addClass("disabled");
	}	
	
	function onDeletePreviewImage( resultJson ){
		//alert(fileId+"- 이미지 삭제");
		var result = $.parseJSON(resultJson);
		
		if( $("#"+result.fileId).closest("li") !== undefined ) $("#"+result.fileId).closest("li").remove();
		
		// madePetlog.update();// 04.12 주석처리
		// 등록버튼 활성/비활성화.
		reloadImageView("G");
// 		if( selectImageVod() ) $(".btnSet a").removeClass("disabled");
// 		else $(".btnSet a").addClass("disabled");
	}
	
	
	var isFileUploadCallBack = false;
	function onFileUploadCallBack( resultJson ){
		//alert("onFileUploadCallBack:"+resultJson);
		var result = $.parseJSON(resultJson);
		var imgType = "I";
		//alert("onFileUploadCallBack:"+result); //object
		if( result.images !== undefined && result.images.length > 0 ){  // 이미지 등록
			var arrImages = result.images;
		//alert("onFileUploadCallBack:arrImages.length:"+arrImages.length);
			for(var i in arrImages) {
				//alert("onFileUploadCallBack-image:"+arrImages[i].filePath);
				$("#petLogBaseForm").append("<input type='hidden' name='imgPath' value='"+arrImages[i].filePath+"' />");
				//alert("imgPath:"+$('#petLogBaseForm [name="imgPath"]').val());
			}
		}else{ //동영상 등록
			var arrVideos = result.videos;
			for(var i in arrVideos) {
				//console.log("onFileUploadCallBack-video:"+arrVideos[i].video_id);
				$("#petLogBaseForm").append("<input type='hidden' name='vdPath' value='"+arrVideos[i].video_id+"' />");
				$("#petLogBaseForm").append("<input type='hidden' name='vdThumPath' value='"+arrVideos[i].thumb_url+"' />");
			}
			imgType = "V";
		}

		// 게시물 등록 요청
		//$('#petLogBaseForm [name="petLogChnlCd"]').val("${frontConstants.PETLOG_CHNL_10}");
		isFileUploadCallBack = true;
		//alert("savePetLogBase call~~~");
		
		savePetLogBase($('#petLogBaseForm [name="saveGb"]').val(), imgType);
		//insertPetLogBase();
	}
	/******************************************************************************/
	
	
	/******************************************************************************/
	// 프로필 등록(사진 등록 관련-미리보기, 삭제, 업로드)
	// 선택 이미지 미리보기	
	function onOpenGalleryProfileCallBack ( resultJson ) {
		var result = $.parseJSON(resultJson);
		//alert("onOpenGalleryCallBack:resultJson==>"+resultJson);
		//alert("onOpenGalleryCallBack:result==>"+result); // 이건 그냥 object
		var fileId = result.fileId;
		
		// onImageEdit 의 callBack 일 경우
		if( result.editFileId != undefined && result.editFileId != null){ 
			//alert("onImageEdit callback ->" + result.editFileId);
			if( $("#"+result.fileId) !== undefined ) $("#"+result.fileId).remove();
			
			fileId = result.editFileId;
		}
		var addHtml = '<img class="img" name="petLogImgPathView" id="'+ fileId + '" src="' + result.imageToBase64 +'" alt="'+result.mediaType +'"/>';
		$("#profile_image").html(addHtml);	
		//alert(addHtml);
		
		// 이미지 변경 체크
		//saveBtnEnabled();
		isImgChanged();
	}
	function onDeletePreviewProfileImage( resultJson ){
       //alert("onDeletePreviewProfileImage:"+resultJson);
		var result = $.parseJSON(resultJson);
		//alert(result.fileId+"- 이미지 삭제");
		if( $("#"+result.fileId) !== undefined ) $("#"+result.fileId).remove();
	}
	
	function onFileUploadProfileCallBack( resultJson ){
		//alert(resultJson);
		var result = $.parseJSON(resultJson);
		//alert(result);  //이건 그냥 object
		if( result.images !== undefined  && result.images.length > 0 ){  // 이미지 등록
			var arrImages = result.images;
			for(var i in arrImages) {
				//var image = arrImages[i];
				//alert("onFileUploadCallBack-image:"+arrImages[i].filePath);
				$("#memberBaseForm").append("<input type='hidden' name='prflImg' value='"+arrImages[i].filePath+"' />");
				//alert("imgPath:"+$('#memberBaseForm [name="prflImg"]').val());
			}
		}

		// 프로필 등록 요청
		insertMemberProfile();
	}	
	/******************************************************************************/
	
	
	// App 호출 함수
	function callAppFunc( funcNm, obj, param ) {
		
		toNativeData.func = funcNm;
		if(funcNm == 'onOpenGalleryProfile'){ // 갤러리 열기 - 프로필 편집
			toNativeData.func = "onOpenGallery";
			toNativeData.useCamera = "P";//(P : 사진만 촬영 / PV : 사진 + 영상 촬영 / N : 사용안함)(Default : N)
			toNativeData.galleryType = "P";//(P : 사진 / PV : 사진 + 영상 / V : 영상)(Default : P)
			toNativeData.usePhotoEdit = "Y";//사진 편집 여부(Y : 사용 / N : 사용안함)(Default : N)
			toNativeData.editType = "S";//R(3:4), S(1:1)로 편집(usePhotoEdit 값이 Y 인경우에만 처리함)
			//미리보기 영역에 선택된 이미지가 있을 경우.------------//
			let fileIds = new Array();
			let fileIdDivs = $("img[name=petLogImgPathView]");
			fileIdDivs.each(function(i, v) {
				fileIds[i] = $(this).attr("id");
			});
			toNativeData.fileIds = fileIds;
			//---------------------------------------//
			toNativeData.title = "사진 선택";
			toNativeData.maxCount = "1";
			toNativeData.previewWidth = "150";
			toNativeData.previewHeight = "150";
			toNativeData.callback = "onOpenGalleryProfileCallBack";
			toNativeData.callbackDelete = "onDeletePreviewProfileImage";
			
			//APETQA-4860 갤러리 열고 닫을 때 헤더 위치 조정
// 			$('.mo-header-backNtn').hide();
// 			$('.mo-heade-tit').css('text-align','center').css('width','100%');
 
		}else if(funcNm == 'onOpenGallery'){ // 갤러리 열기 - 게시물 등록
			// 데이터 세팅
			toNativeData.useCamera = "PV";
			toNativeData.galleryType = "PV";
			toNativeData.usePhotoEdit = "N";
			toNativeData.editType = "R";
			//미리보기 영역에 선택된 이미지가 있을 경우.------------//
			let fileIds = new Array();
			let fileIdDivs = $("img[name=petLogImgPathView]");
			fileIdDivs.each(function(i, v) {
				fileIds[i] = $(this).attr("id");
			});
			toNativeData.fileIds = fileIds;
			//---------------------------------------//
			toNativeData.maxCount = "5";
			if( beforeImg !== undefined && beforeImg.cnt() > 0 ){
				toNativeData.maxCount = "" + (5-beforeImg.cnt()) ; 
			}
			toNativeData.title = "갤러리 선택";
			toNativeData.previewWidth = "188";
			toNativeData.previewHeight = "250";
			toNativeData.callback = "onOpenGalleryCallBack";
			toNativeData.callbackDelete = "onDeletePreviewImage";			
			
		}else if(funcNm == 'onImageEditProfile'){ // 편집 할 이미지(base64)를 받아서 편집 처리 - 프로필 편집
			toNativeData.func = "onImageEdit";
			// 데이터 세팅
			var image = $("#"+obj).attr("src");
			//alert("image:"+image);
			//alert("onImageEditProfile: fileId==>"+obj);
			
			toNativeData.image = image;
			toNativeData.fileId = obj;
			toNativeData.editType = "S";//R(3:4), S(1:1)로 편집
			toNativeData.callback = "onOpenGalleryProfileCallBack";
		
		}else if(funcNm == 'onImageEdit'){ // 편집 할 이미지(base64)를 받아서 편집 처리 - 게시글 등록
			// 데이터 세팅
			var image = $("#"+obj).attr("src");
			//alert("image:"+image);
			//alert("onImageEdit: fileId==>"+obj);
			// gif 이미지는 편집 불가함.
			if( param == "gif" ){
				ui.toast('gif 파일은 편집할 수 없어요',{
				    bot:74
				});				
				return false;
			}else{
				toNativeData.image = image;
				toNativeData.fileId = obj;
				toNativeData.editType = "R";//R(3:4), S(1:1)로 편집
				toNativeData.callback = "onOpenGalleryCallBack";
			}
			
		}else if(funcNm == 'onDeleteImage'){ // 미리보기 썸네일 삭제 - 게시글 등록
			// 화면에서 먼저 삭제
   			if( $("#"+obj).closest("li") !== undefined ) $("#"+obj).closest("li").remove();
   			
   			// 등록버튼 활성/비활성화.
   			reloadImageView();
//    			if( selectImageVod() ) $(".btnSet a").removeClass("disabled");
//    			else $(".btnSet a").addClass("disabled");
			// 데이터 세팅
			toNativeData.fileId = obj;

		}else if(funcNm == 'onDeleteUpdateImage'){ // 미리보기 썸네일 삭제 - 게시글 수정(기등록 이미지)
			// 화면에서 먼저 삭제
   			if( $("#"+obj).closest("li") !== undefined ) $("#"+obj).closest("li").remove();
   			// 기존이미지 삭제 시 
			isChange = true;
		
		//alert("onDeleteUpdateImage: " +$('#petLogBaseForm [name="imgPath"]').length);
   			// 등록버튼 활성/비활성화.
   			reloadImageView("U");

   		 	return false;
			
			
		}else if(funcNm == 'onCurrentLoc'){ // 현재 위치 정보 요청
			//alert("onCurrentLoc call 함.");
			// 데이터 세팅
			toNativeData.callback = "onCurrentLocCallBack";
			//var resultJson = '{"authYn ":"Y","latitude":"123.2222","longitude":"235.3224"}';
			//onCurrentLocCallBack(resultJson);
			
		}else if(funcNm == 'onShare'){ // 공유
			//alert(funcNm+":"+obj +"|"+param);
			// 데이터 세팅

			toNativeData.link = obj;
			toNativeData.subject = param;

		}else if(funcNm == 'onFileUpload'){ // 파일 업로드 - 펫로그 등록
			
			toNativeData.prefixPath = "/log/"+obj;
			toNativeData.channel_id = "aboutpet_log";
			toNativeData.playlist_id = "unclassified"
			toNativeData.callback = "onFileUploadCallBack";	
			toNativeData.uploadWithProgress = "Y";
			
		}else if(funcNm == 'onFileUploadProfile'){ // 파일 업로드 -프로필 편집
			toNativeData.func = "onFileUpload";
			toNativeData.prefixPath = "/log/"+obj+"/profile";
			toNativeData.channel_id = "aboutpet_log";
			toNativeData.playlist_id = "unclassified";
			toNativeData.callback = "onFileUploadProfileCallBack";
			toNativeData.uploadWithProgress = "N";
			
		}else if(funcNm == 'onClose'){ // 화면 닫기
			// 데이터 세팅
			toNativeData.func = funcNm;
		
		}else if(funcNm == 'onPetLogUploadComplete'){
			toNativeData.func = "onPetLogUploadComplete";
			toNativeData.viedoId = obj
			
		}else if(funcNm == 'onPetLogEncodingCheck'){
			toNativeData.func = "onPetLogEncodingCheck";
			toNativeData.callback = obj
			toNativeData.callbackData = "onInsertPetLogEncodingCheckCallback"
			if(param){	toNativeData.isForcedUI = param; }
			
		}else if(funcNm == 'onEnableKeyboardEvent'){
			toNativeData.func = "onEnableKeyboardEvent";
			toNativeData.callback = "onEnableKeyboardEventCallBack";
			
		}else if(funcNm == 'onDisableKeyboardEvent'){
			toNativeData.func = "onDisableKeyboardEvent";
		}
		//console.log(toNativeData.func);
		//alert("toNativeData:"+toNativeData.func);
		// 호출
		toNative(toNativeData);
	}	

</script>

<script>
	// 펫로그 등록/수정 관련 ------------------------------------//	
	var inquiryValidate = {
		all : function(){
			//alert("inquiryValidate.all(): "+$('#petLogBaseForm [name="imgPath"]').length);
			//alert($('#petLogBaseForm [name="vdPath"]'));
// 			if ( $('#petLogBaseForm [name="imgPath"]').length == 0 &&
// 					( $('#petLogBaseForm [name="vdPath"]').val() == undefined || $('#petLogBaseForm [name="vdPath"]').val() == "") ) {
// 				ui.toast('사진 또는 영상을 등록해주세요',{
// 				    bot:74
// 				});
// 				return false;
// 			}
			
			if($("#chkGoodsRcomYn").is(":checked")) {
				$("#goodsRcomYn").val("Y");
			}else{
				$("#goodsRcomYn").val("N");
			}
			return true;
		}
	};

	
	// 이미지/동영상 선택 여부 확인.
	function selectImageVod(){
		//alert( $("li .pic img").length);
		if( $("li .pic img").length > 0 ){					
			return true;
		}
		return false;
	}	
	
	// 이미지 영역, 버튼 영역 처리
	function reloadImageView( gb ){
		//var imgCnt = $("img[name=petLogImgPathView]").length;
		var imgCnt = $(".pic img").length;
		// 2021.04.21 추가함.
		//resizeImg();
		
		//alert("reloadImageView: imgCnt:"+imgCnt);
		//alert("reloadImageView: imgPath.length:" +$('#petLogBaseForm [name="imgPath"]').length);
		var oldImgCnt = 0;
		if( gb !== undefined && gb == "U" ){
			$("li .pic img").each(function(i, v) {
				var updateImgId = $(this).attr("data-update-id");
				if( updateImgId !== undefined && updateImgId != null && updateImgId != '' ){
					oldImgCnt++;
				}
			});	
		}
		// 등록버튼 활성/비활성화.
		if( imgCnt > 0 && !(gb !== undefined && gb == "U")){
			if($("#petLogChnlCd").val() != '20'){
				$(".btnSet > .a").removeClass("disabled");
			}else if($("#petLogChnlCd").val() == '20' && $('#dscrt').val().replaceAll(' ', '').length >= 10){
				$(".btnSet > .a").removeClass("disabled");
			}
		}else if( imgCnt > 0 && gb !== undefined && gb == "U"){
			
		}else{
			$(".btnSet > .a").addClass("disabled");
		}
		
		// 이미지 영역에 추가/편집  노출(활성/비활성)/비노출
		if(imgCnt > 0){
			$("#addPicFirstLi").hide();
			if( $("#addPicLastLi") !== undefined ) $("#addPicLastLi").remove();
			
			// 맨 앞 미리보기이미지 의 mediaType
			var mediaType = $(".pic img:eq(0)").attr("alt");//$("img[name=petLogImgPathView]:eq(0)").attr("alt");
			//alert("reloadImageView:"+imgCnt+",mediaType:"+mediaType);
			//console.log(imgCnt +","+ gb);
			if( gb == undefined || ( gb != "G" && gb != "U" ) ){  // 갤러리 오픈되어, 미리보기에 추가하는 경우는 제외. -2021.04.22
			
				// 이미지가 5개 이거나, 동영상 등록의 경우- 비활성화. 선택 안됨 
				if( imgCnt == 5 || mediaType == "V" ){ 
					var addHtml = 
						 '<li class="swiper-slide box_block" id="addPicLastLi">'
						 + 	'<a href="javascript:uploadDeadEnd();" class="lmp_addpicBt">'							 
						 + 	'	<div style="opacity:0.5">'
						 +	'		<span class="lmp_addPicIcon"></span>'
						 +	'		<div class="txt">추가/편집</div>'
						 +	'	</div>'
						 +	'</a>'
						 +'</li>';
					$("#add_image_list").append(addHtml);
				}else{
					var addHtml = 
						 '<li class="swiper-slide" id="addPicLastLi">'
						 + 	'<a href="javascript:openPictureCon();" class="lmp_addpicBt">'
						 + 	'	<div>'
						 +	'		<span class="lmp_addPicIcon"></span>'
						 +	'		<div class="txt">추가/편집</div>'
						 +	'	</div>'
						 +	'</a>'
						 +'</li>';
					$("#add_image_list").append(addHtml);
				}
			}
			
			// 이미지 edit 일 때는 제외 - 2021.04.06
			if( gb == undefined || gb != "E" ){			
				// 이미지 추가 시 마지막 이미지로 slide
				//madePetlog.slideTo(imgCnt-1 , 500, false); // 04.12 주석처리
				
				//alert("reloadImageView:"+imgCnt);
				// 추가된 이미지를 중앙으로
				$("#insertSwiper").animate({"scrollLeft":$(".log_makePicWrap .swiper-slide:eq("+imgCnt+")").position().left},300);
			}

		}else{
			// 이미지가 없을 경우. 추가/편집 비노출
			if( $("#addPicLastLi") !== undefined ) $("#addPicLastLi").remove();
			$("#addPicFirstLi").show();
			$(".con.swiper-container").animate({"scrollLeft":0},300);
		}
		
		//2021.04.21 추가 - 삭제 시 추가편집 onWeb_b 제거
// 		if( gb !== undefined && gb == "D" ){
// 			$(this).children("a").not("a.lmp_addpicBt").addClass("onWeb_b");
// 		}
		
	}
	
	/* img size */
	function resizeImg(){
		$(".log_makePicWrap .swiper-slide img").each(function(i,n){
			let w = $(n).innerWidth();
			let h = $(n).innerHeight();
			let cl = (w<h)?"a w":"a h";
			$(n).attr("class",cl);
			//console.log(i + " : " + $(n).innerWidth() + " : " + $(n).parent().innerWidth());
			if($(n).innerWidth() < $(n).parent().innerWidth()){
				//console.log("re class : " + i)
				$(n).attr("class","a w");
			}
			//console.log(i + " : " + $(n).innerHeight() + " : " + $(n).parent().innerHeight());
			if($(n).innerHeight() < $(n).parent().innerHeight()){
				//console.log("re class : " + i)
				$(n).attr("class","a h");
			}
		})
	};
	
	// 게시물 등록
	function savePetLogBase( saveGb, imgType ){
		//alert("savePetLogBase:"+saveGb);
		var url =  "<spring:url value='/log/petLogBaseInsert' />";
		var resultMsg = "게시물이 등록되었어요";
		var confirmMsg = "<spring:message code='front.web.view.common.msg.confirm.insert' />";
		if( saveGb == "U" ){
			url =  "<spring:url value='/log/petLogBaseUpdate' />";
			resultMsg = "게시물이 수정되었습니다.";
			confirmMsg = "<spring:message code='front.web.view.common.msg.confirm.update' />";
		}
		
		if(inquiryValidate.all()){
			//alert("savePetLogBase: imgPath.length:" +$('#petLogBaseForm [name="imgPath"]').length);
			var formData = $("#petLogBaseForm").serialize();
			var jsonFormData = $("#petLogBaseForm").serializeJson();
			var commentYn = "${commentYn}";
			//alert("formData:"+formData);
			var options = {
				url : url
				, data : formData
				, done : function(data){	
					var returnUrl = "${view.stDomain}/log/home";
					// 업로드 한 게시물에 영상이 있을 시에만 인터페이스 콜
					if(jsonFormData.vdPath){
						callAppFunc("onPetLogUploadComplete" , jsonFormData.vdPath);
					}
					
					if(jsonFormData.petLogChnlCd != "20"){
// 						ui.toast('<div class="link"><p class="tt">'+resultMsg+'</p><a href="javascript:goMyPetLog(\'${session.petLogUrl}\',\'${session.mbrNo}\');" class="lk">바로가기</a></div>',{
// 						    bot:74  // 바닥에서 띄울 간격
// 						    ,sec:3000 // 사라질 시간 number
// 						});
						
						if( imgType == undefined || imgType == null ){
							imgType = "I"; 
						}
						
						if( saveGb == "I" ){							
							// action log 처리
							userActionLog(data.petLogNo, "petlog");
							
							returnUrl = "${view.stDomain}/log/home?petLogNo="+data.petLogNo+"&imgType="+imgType;
						}
						if( "${rtnUrl}" != null && "${rtnUrl}" != "" ){
							returnUrl = "${rtnUrl}";
							returnUrl = returnUrl.replace(/&amp;/gi, "&");
						}
						//setTimeout(function(){
							// 홈 또는 rtnUrl 로 이동.
							location.href = returnUrl;
						//}, 3000);
					}else{
						if(saveGb == "U"){
							// 마이페이지 상품후기에서 진입 시 상품후기 return or 펫로그 메인							
							returnUrl = commentYn != '' ? "/mypage/goodsCommentList?selectTab=aftTab" : returnUrl;
							//후기 수정 return 은 펫로그 메인으로 변경 - 2021.04.23
							location.href = returnUrl;						
						}else{
							var gsReViewUseYn = data.gsReViewUseYn;
							if(gsReViewUseYn == "${frontConstants.USE_YN_Y}" && data.ordNo != undefined && data.goodsEstmNo != undefined){
								location.href="/log/layerPetlogReviewPop" +
										"?ordNo="+data.ordNo +
										"&goodsEstmNo="+data.goodsEstmNo;
							}else{
								location.href="/mypage/goodsCommentList?selectTab=aftTab&popYn=Y";
							}
						}
					}
				}
			};
			ajax.call(options);
		}
	}

	// 모바일 - 위치등록 팝업 띄우기.
	function popupPetLogInsertLoc( gb ){
		var addParam = "";
		if( gb !== undefined && gb == "U" ){
			addParam = "&gb="+gb;
		}
		window.open("${view.stDomain}/log/popupPetLogInsertLoc?callBackFnc=locCallBack"+addParam, "locPopup");
	}
	
	// 위치등록 팝업 - callback
	function locCallBack(addr, gb){
		var addHtml = '\
				<ul>\
					<li>\
						<div class="tit">'+ addr.place_name + '</div>\
						<div class="con">'+ addr.road_address_name + '</div>\
						<a href="javascript:deleteLoc(\''+ gb +'\');" class="log_pelClose"></a>\
					</li>\
				</ul>';	
		
		$(".log_pointEnterList").html(addHtml);
		$(".log_pointEnterList").removeClass("onWeb_b");
		// 위치정보 셋팅
		$("#logLitd").val(addr.x);
		$("#logLttd").val(addr.y);
		$("#prclAddr").val(addr.address_name);
		$("#roadAddr").val(addr.road_address_name);
		$("#pstNm").val(addr.place_name);				
		$("#pstNm").trigger('change');
		
		// 위치등록 영역 hidden
		$("#area_pop_loc").addClass("onWeb_b");
		//$(".log_topBbox").addClass("onWeb_b");
		//$(".pointTxtArea").addClass("onWeb_b");	
		
		if( gb !== undefined && gb == "U" ){
			isChange = true;
			//alert("gb="+gb);
			reloadImageView(gb);
		}
	}
	
	
	function deleteLoc(gb){
		
		$(".log_pointEnterList").html("");
		$(".log_pointEnterList").addClass("onWeb_b");
		
		// 위치등록 영역 display
		$("#area_pop_loc").removeClass("onWeb_b");
		//$(".log_topBbox").removeClass("onWeb_b");
		//$(".pointTxtArea").removeClass("onWeb_b");	
		
		// 위치정보 리셋
		$("#logLitd").val("");
		$("#logLttd").val("");
		$("#prclAddr").val("");
		$("#roadAddr").val("");
		$("#pstNm").val("");
		$("#pstNm").trigger('change');
		
		if( gb !== undefined && gb == "U" ){
			if(isChangedFormValue()) isChange = true;
			else isChange = false;
			reloadImageView(gb);
		}
	}
	
	
	
    function fnGetAutocomplete(searchText){
		var formData = new FormData();
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
        	.then(res => {
        		var jsonObject = JSON.parse(res);
        		autoCompleteSuccess(jsonObject , "tag")})
        	.catch(err => console.log(err))
    }    
     
    function setContentLink(){
    	$("section .lcbWebRconBox .lcbConTxt_content").each(function(i, v) {
			
			let strOriginal =  $(this).text();
			
			var inputString = strOriginal;
			//inputString = inputString.replace(/#[^#\s]+|@[^@\s]+/gm, function (tag){
			inputString = inputString.replace(/#[^#\s\<\>\@\&\\']+/gm, function (tag){
				return (tag.indexOf('#')== 0 && tag.length < 22) ? '<a href="/log/indexPetLogTagList?tag=' + encodeURIComponent(tag.replace('#','')) + '" style="color:#669aff;">' + tag + '</a>' : tag;
			});
			$(this).html(inputString);
			
// 			if(inputString.indexOf('\n') > 0){
// 				$(this).html(inputString).css("white-space", "pre-wrap");
// 				<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">				
// 					$(this).html(inputString).css('height', '1.4em');
// 				</c:if>
// 				$(this).next(".btn_logMain_more").removeClass("onWeb_b");
// 			}
		});
    }
    
   	function substrUserInfo(){
   		$("section .lcbConTxt .userInfo .txt").each(function(i, v) {
   			//특수 문자 unescape처리 완료 된 이후에 substr하기 위해
   			var tag = $(v).find(".tag").data("orgin-tag")
   			var nickNm = $(v).find(".nickname").data("orgin-nick")
   			
   			if(tag && tag.length > 6){
   				$(v).find(".tag").html(tag.substr(0,6) + "...");
   			}
   			
   			if(nickNm && nickNm.length > 10){
   				$(v).find(".nickname").html(nickNm.substr(0,10) + "...");
   			}
   		})
   	}
    
    function setTimeConvert(){	
		$('.con .txt .time').each(function(){
			if( $(this).text() != undefined && $(this).text() != '') {
				if($(this).data("converted") != "Y"){
					var timeTxt = new Date($(this).text().replace(/\s/, 'T'));					
					var converTime = elapsedTime(timeTxt, "년월일");
					$(this).text(converTime);
					$(this).data("converted" , "Y");
				}
			}
		});
    }
    
    
    function setAplyLink(){
		$("li .con .txt").each(function(i, v) {
		
			let strOriginal =  $(this).text();
			var inputString = strOriginal;
			inputString = inputString.replace(/#[^#\s\<\>\@\&\\']+|@[^@\s]+/gm, function (tag){
				var ret = "";
				if(tag.indexOf('#')== 0 && tag.length < 22){
					var tagUrl = '/log/indexPetLogTagList?tag=' + encodeURIComponent(tag.replace('#',''));
					ret = '<a href="' + tagUrl + '" style="color:#669aff;">' + tag + '</a>'
				}
				else{
					if( tag.split('|').length == 3){
						var myPetLogUrl = "/log/indexMyPetLog/"+ tag.split('|')[2] + "?mbrNo=" + tag.split('|')[1];
						
						ret = '<a href="' + myPetLogUrl + '" style="font-weight:bold;">' + tag.split('|')[0] + '</a>'
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
    
    
	/* 게시물 img size */
	function resizeLogImg(){
		$(".logContentBox .lcbPicture img, .logContentBox .lcbPicture .vthumbs").each(function(i,n){
			let w = $(n).parent().innerWidth();
			let h = (w / 3) * 4 ;
			$(n).parent().attr("style","height:"+h + "px;");
			if($(n).find(".vv_mutd_off").length > 1){
				$(n).find(".vv_mutd_off").last().remove();
				$(n).find(".v_mutd_on").last().remove();
			}
			
			if($(n).find(".v_mutd_on").length > 1){
				$(n).find(".vv_mutd_off").last().remove();
				$(n).find(".v_mutd_on").last().remove();
			}
		})
	}
	
	/* 사진 5개 이상이거나 영상 업로드 시 toast 알림문구 */
	function uploadDeadEnd(){
		var mediaType = $(".pic img:eq(0)").attr("alt");
		
		if(mediaType == "V"){
			ui.toast('영상은 1개만 등록할 수 있어요',{ 
				bot:70
			});
		} else {
			ui.toast('사진은 5개까지만 등록할 수 있어요',{ 
				bot:70
			});
		}
	}
	
	/* MO - 내용 더보기 버튼 처리.  */
	function moContxtMoreSet(page){
    	
    	//07.01 추가
    	//페이징 시 이미 처리 완료된 게시물도 타겟팅해 더보기 버튼이 미노출 처리되기에 contxtWrap${page} name 선택자로 변경
		$("[name=contxtWrap"+page+"]").each(function(i, n) {
			var aad = 32;				//lcbConTxt_content 의 max높이값
			var bbd = $(n).find(".lcbConTxt_content").height();  //lcbConTxt_content 의 높이값
			if( bbd > aad ) {							//lcbConTxt_content 의 높이값이 32보다 크면
				$(n).find(".lcbConTxt_content").css("max-height", 32);
				$(n).find(".lcbConTxt_content").next().removeClass("onWeb_b");
			}else if( bbd <= aad ) {						//lcbConTxt_content 의 높이값이 32보다 작거나 같으면 2021.08.03 수정함 APETQA-6556
				$(n).find(".lcbConTxt_content").next().addClass("onWeb_b");					
			}
		});
	}
	
	// 펫로그 메인화면에서 만들기 넘어가는경우 
	function goPetLogMake(tag){
	<c:choose>
		<c:when test="${view.deviceGb ne frontConstants.DEVICE_GB_30 }">
			ui.confirm('어바웃펫 앱에서 이용할 수 있어요<br>앱으로 이동할까요?',{ // 컨펌 창 옵션들
				ycb:function(){
					if("${view.os}"=="${frontConstants.DEVICE_TYPE_20}"){ //IOS
						location.href = "https://BXPD5Og4xEKwhWif2aXoog.adtouch.adbrix.io/api/v1/click/q0Tv42H19kWYmqRJzTFsyw?m_adid=__device_id__&cb_5=__callback_param__&cb_1=__AID__%5F__CID__%5F__CAMPAIGN_ID__&cb_2=__UA__%5F__UA1__&cb_3=__IDFA__%5F__OS__%5F__GAID__&cb_4=__TS__%5F__IP__%5F__SL__";
					}else{
						// location.href = "Intent://splash#Intent;scheme=aboutpetlink;package=com.petsbe.android.petsbemall;end";
						location.href = "https://BXPD5Og4xEKwhWif2aXoog.adtouch.adbrix.io/api/v1/click/kMT9ioBptEGz51TtzV712A";
					}
				},
				ncb:function(){
					return false;
				},
				ybt:"앱으로 이동", // 기본값 "확인"
				nbt:"취소"  // 기본값 "취소"
			});	
		</c:when>
		<c:otherwise>
			if( checkLogin() && checkRegPet() ){
				var param = "";
				if( tag !== undefined && tag !== '' ) param = "&tag="+tag;	
				location.href = "${view.stDomain}/log/indexPetLogInsertView?petLogChnlCd=${frontConstants.PETLOG_CHNL_10}&goMain=Y"+param;	
			}
		</c:otherwise>
	</c:choose>
	}
	
	//APP일 경우 영상 상세 이동 URL 페이지 호출
	function goUrl(funcNm, type, url) {
		toNativeData.func = funcNm;
		toNativeData.type = type;
		toNativeData.url = url;
		
		toNative(toNativeData);
	}
</script>
		<script type="text/javascript">
			function openTermsSetting(termsCd, settingYn){
				var options = {
					url : "/introduce/terms/indexTerms"
					, data : {
						termsCd : termsCd
						, settingYn : settingYn
					}
					, dataType : "html"
					, done : function(html){
						$("#layers").html(html);
						ui.popLayer.open("termsContentPop");
						$("#termsContentPop").css("z-index",10000);
					}
				};
				ajax.call(options);
			}
		</script>
