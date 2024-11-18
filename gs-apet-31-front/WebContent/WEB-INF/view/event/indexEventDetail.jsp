<tiles:insertDefinition name="noheader_mo">
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">
			var isLogin = "${isLogin}";
			var isPc = "${view.deviceGb}" == "${frontConstants.DEVICE_GB_10}";
			var isMobileWeb = "${view.deviceGb}" == "${frontConstants.DEVICE_GB_20}";
			var firstChar;
			var whileFetching = false;
			var resJsonArr = new Array();
			let abortController;
			let replyAplySeq = 0;
			
			$(window).ready(function(){
				aplyText();
				setAplyTimeConvert();
			});
			
			/* 21.06.24 CSR-834 수정-삭제 토글팝업 바탕 클릭 시 닫기 */
			$(document).on("click", ".commendListBox .menu.dopMenuIcon", function(e) {
				$(".commentBoxAp.commendListBox ,body").one("click", function(e){
					if (!$(e.target).hasClass("popSelect") && !$(e.target).hasClass("dopMenuIcon")) {
						ui.popSel.closeAll();
					}
				});
			});
			
			//멘션 볼드처리
			function aplyText(){
				$("div[name=aplyText]").each(function(){
					let strOriginal =  $(this).text();
					var inputString = strOriginal;
					var ret = "";		
					
					inputString = strOriginal.replace(/@[^@\s]+/gm, function (tag){
						
						if(tag.indexOf("@") !== -1){
							if(tag.indexOf("@어바웃펫회원") !== -1){
								return "@어바웃펫 회원";
							}else{
								var tempTag = tag.split("|");
								if(tempTag.length > 1){
									return '<span style="font-weight:bold;">' + tempTag[0] + '</span>';
								}else{
									return tempTag[0];
								}
							}
						}else{
							return '<span style="font-weight:bold;">' + tag + '</span>';
						}
					});
					$(this).html(inputString);
				});
			}
			
			function goPop(url){
				if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
					toNativeData.func = "onOrderPage";
					toNativeData.url = url;
					toNativeData.title = "이벤트상세";
					toNative(toNativeData);
				 }else{
					location.href=url;
				}
			}
			
			var aply = {
				save : function(btn){
					var eventNo = "${event.eventNo}"
					var patiNo = $(btn).attr("data-pati-no");
					var aplyContent = $("#enryAply").val();
					var nickNmArr = [];
					
					aplyContent.replace(/@[^@\s]+/gm, function (tag){
						nickNmArr.push(tag.replace('@', ''));
					});
					
					var toastH;
					if(isIOS()){
				 	 	toastH = 330 - $(".commentBoxAp").scrollTop();
					}else{
						toastH = 70;
					}
					
					if(aplyContent.trim() == ""){
						ui.toast('입력된 내용이 없습니다.',{   // 토스트 창띄우기
								bot:toastH
							});
						return false;
					}
					
					var msg;
					if(patiNo){
						msg = "<spring:message code='front.web.view.event.msg.comment.update' />"	
					}else{
						msg = "<spring:message code='front.web.view.event.msg.comment.insert' />"
					}
					
					var data = {
						//enryAply : $("[name='enryAply']").val()
						enryAply : $("#enryAply").val()
						, eventNo : eventNo
						, patiNo : patiNo
						, nickNmArr : nickNmArr
					//	, nickNm : "${session.nickNm}"
						, nickNm : $("#nickNm").val()
						, landingUrl : "${view.stDomain}" + "${requestScope['javax.servlet.forward.request_uri']}?home=event" +"&eventNo=" + eventNo 
					};
					
					var options ={
						url : "/event/detail/aply"
						, data : data
						, done : function(result){
							var resultCode = result.resultCode;
							if(resultCode == "${frontConstants.CONTROLLER_RESULT_CODE_SUCCESS}"){
								ui.toast(msg);
								$("#aplyRegister").attr("data-pati-no","");
								
							}else if(resultCode == "${frontConstants.CONTROLLER_RESULT_CODE_FAIL}"){
								ui.alert("<spring:message code='front.web.view.event.alert.do.try.again' />");
							}else{
								ui.alert(result.resultMsg);
							}
							
							aply.realod(patiNo);
						}
					};
					ajax.call(options);
				},
				rpt : function(patiNo){
				},
				//수정
				update : function(patiNo){
					$(".rewrite").remove();
					$("[id^=rewrite]").css('display', 'none');
					$(".update-time").css("display", "block");	
					$("#eventModifyPop").css('display', 'block');
					$(".dopMenuIcon").css('display', 'block');
					
					$("#aplyRegister").attr("data-pati-no", patiNo);
					$(".btn_wrap").addClass('active3');
					
					var len = $(".rewrite").length;
					var span = $('<div class="rewrite">수정중....</div>');
					var aply = $("#text_"+patiNo);
					
					if(len == 0){
						$("#mbrReply_"+patiNo).css('display', 'none');
						$("#rewrite_"+patiNo).css('display','block');
						$("#date_"+patiNo).css('display', 'none');
						$("#text_"+patiNo).next("div").append(span);
					}
					
					var replyTxt = $("#text_"+patiNo).text();
					$("#enryAply").val(replyTxt);
					
// 					fncBtnDispGb("Y"); //버튼 노출
					$("#enryAply").blur();
					$("#enryAply").focus();
					
					modifyHeight();
					
				},
				//삭제
				del : function(patiNo){
					var eventNo = "${event.eventNo}"; 
					ui.confirm("<spring:message code='front.web.view.event.confirm.msg.question.delete.comment' />" , {
						ycb : function(){
							var options ={
								url : "/event/detail/delete-aply"
								, data : {patiNo : patiNo , eventNo : eventNo}
								, done : function(result){
									ui.toast("<spring:message code='front.web.view.event.confirm.msg.delete.comment' />")
									if(replyAplySeq != 0) {
										$("#aplyRegister").attr("data-pati-no","");
// 										fncBtnDispGb("N"); //버튼 숨김
// 										$("#enryAply").val("");
									}
									aply.realod();
								}
							};
							ajax.call(options);
						}
						, ybt : "<spring:message code='front.web.view.common.yes' />"
						, nbt : "<spring:message code='front.web.view.common.no' />"
					});
				},
				realod : function(patiNo){
					$.ajax({
						url : "/event/detail/aply-list"
						,data : {eventNo : "${event.eventNo}"}
						, type : "GET"
						, dataType : "HTML"
						, success : function(html){
							waiting.start();
// 							$("#aplyRegister").text("<spring:message code='front.web.view.common.registration' />");
							$("#enryAply").val("");
							$(".btn_wrap").removeClass('active3');
							$("#reply-list").empty().append(html);
							$("#enryAply").blur();
//							$("#enryAply").focus();
							$("#aplyCnt").text($(".reply-item").length);
							$("#eventModifyPop").css('display', 'none');
							$(".evt-keyword-list").hide();
							$("#mbrReply_"+patiNo).css('display', 'block');
							replyAplySeq = 0;
							setAplyTimeConvert();
							aplyText();
							waiting.stop();
						}
					});
// 					var options ={
// 						url : "/event/detail/aply-list"
// 						,data : {eventNo : "${event.eventNo}"}
// 						, type : "GET"
// 						, dataType : "HTML"
// 						, done : function(html){
// 							waiting.start();
// 							$("#aplyRegister").text("<spring:message code='front.web.view.common.registration' />");
// 							$("#reply-list").empty().append(html);
// 							$("#aplyCnt").text($(".reply-item").length);
// 							replyAplySeq = 0;
// 							waiting.stop();
// 							setAplyTimeConvert();
// 						}
// 					};
// 					ajax.call(options);
				}
			};

			//공유하기 버튼 클릭
			function shareBtnClick(){
				var eventNo = "${event.eventNo}";
				var eventTtl = "${event.ttl}"
				
				//app인 경우
				var url = window.location.protocol + "//" + window.location.host + "/event/eventShare?eventNo="+eventNo;
// 				var url = window.location.protocol + "//" + window.location.host +  window.location.pathname + "?eventNo="+"${event.eventNo}";
				if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
					// 데이터 세팅
					toNativeData.func = "onShare";
					toNativeData.image = $("#dlgtImgPath").val();
					toNativeData.subject = eventTtl;
					toNativeData.link = url;
					// 호출
					toNative(toNativeData);
				}else{
					//web인 경우
					var t = document.createElement("textarea");
					document.body.appendChild(t);
					t.value = url;
					t.select();
					document.execCommand('copy');
					document.body.removeChild(t);

					ui.toast("<spring:message code='front.web.view.common.msg.result.share' />");
				}
			}

			function fnGoKaKaoChannel(){
				if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
					toNativeData.func = "onOrderPage";
					toNativeData.url = "https://pf.kakao.com/_pBZhs";
					toNativeData.title = "<spring:message code='front.web.view.event.title' />";
					toNative(toNativeData);
				}else{
					window.location.href = "https://pf.kakao.com/_pBZhs";
				}
			}

			function fnOnLoadDocument(){
				$("#lnb").remove();
				if(isMobileWeb){
					//2021.05.11 기준 : commentBoxAp 선택자가 중복으로 인해 css 강제 수정
					$(".commentBoxAp.logpet.up.app").css("position","fixed");
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
			
			$(function(){
				fnOnLoadDocument();
				<c:if test="${session.mbrNo eq reply.mbrNo}">
					$("#adminHideArea1").css("display","none");
				</c:if>
				
				//모바일 헤더 수정
				<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
					$(".mo-heade-tit .tit").text("이벤트 상세");
					//$(".mo-header-backNtn").attr('onclick', 'storageHist.getOut("event/detail");');
					
				
					//- - - - - - $(".mo-header-backNtn").attr('onclick', 'storageHist.goBack();');
					//home=event가 있을때 /shop/home/ 으로 이동 
					<c:if test="${fn:indexOf(requestScope['javax.servlet.forward.query_string'], 'home=event' )  > -1}">
						$(".mo-header-backNtn").attr('onclick', 'storageHist.goBack("/shop/home/");');
					</c:if>
					//(home=event가 없는거)
					<c:if test="${fn:indexOf(requestScope['javax.servlet.forward.query_string'], 'home=event') <= -1}">
						$(".mo-header-backNtn").attr('onclick', 'storageHist.goBack();');
					</c:if>
				
					$("#header_pc").addClass('logHeaderAc');
					
					$('.floatNav').hide();
				</c:if>
				
				//댓글 입력 시
				$(document).on("input keyup click", "#enryAply", function(){
						var toastH;
						var gb = '';
						var formData = new FormData();
						
						$(".btn_wrap").addClass('active3');						
						if(isIOS()){
					 	 	toastH = 330 - $(".commentBoxAp").scrollTop();
						}else{
							toastH = 70;
						}
						
						if($(this).val().length > 300){ 
							ui.toast('300자까지 입력 가능합니다.',{
								bot:toastH
							});
							$(this).val($(this).val().substr(0 , 300));
						}
						
						let element = document.getElementById('enryAply');
						let strOriginal = element.value;
						strOriginal = strOriginal.replaceAll('\n', ' ');
						strOriginal = strOriginal.substr(0, element.selectionStart);
						let inMention = strOriginal.indexOf('@');
						if(inMention > -1) {
							$(".evt-keyword-list").show();
						}else{
							gb = '';
							$(".evt-keyword-list").hide();
//						modifyHeight();  //@가 없으면, 리스트 보여주지않음. 리스트 보여주지 않기때문에,설정할 필요가 없어보임.
						}
								
						index = strOriginal.lastIndexOf('\@');
						
						let txt = strOriginal.substring(index, element.selectionStart);
						txt = txt.substring(0, 1);
						gb = txt;
						
						if (gb.indexOf('\@') > -1) {
							firstChar = "\@"
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
								
								if( searchMentionTxt != ''){
									//중복 호출시 기존 request 취소를 위해 fetch로 변경
									if(whileFetching) abortController.abort();
									
									abortController = new AbortController;
									whileFetching = true;
									
									formData.append('searchText' , searchMentionTxt);
									formData.append('label' , 'log_member_nick_name');
									formData.append('size' , 30);
						            fetch("/log/getAutocomplete" , {
						            	method : "POST"
						            	, body : formData
						            	, signal : abortController.signal
						            	}).then(res => res.json())
						            	.then(res => {
						            		var jsonObject = JSON.parse(res);
						            		autoCompleteSuccess(jsonObject , "mention")})
						            	.catch(err => console.log(err))  
								}else{
									modifyHeight();
									$("#keyword_list").html("");
								}
							}
						} else if(gb.indexOf('\@') == -1){ // (모바일에서) @썼다가 지웠을때 fixed_Box에 top이 생겨 공유하기 버튼을 가려 클릭이 되지않아 추가 
							$('.fixed_box').css('top', '');
						}
				});
			});
			
			function autoCompleteSuccess(resBody , separator){
				resJsonArr = [];
				whileFetching = false;
				if(resBody.STATUS.CODE == "200"){
					let html = ''
					if( resBody.DATA.ITEMS.length > 0) {
						let item = resBody.DATA.ITEMS;
						$("#keyword_list").empty();
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
								html += '<li onclick="javascript:selectTag('+i+');"><div class="pic"><img src="'+ pic + '" style="padding-bottom:20px"></div>' + item[i].HIGHLIGHT.replace(/\¶HS¶/gi, '<span style="color: #669aff;">').replace(/\¶HE¶/gi, '</span>')
							}else{
								html += '<li onclick="javascript:selectTag('+i+');" style="color:black;">#' + item[i].HIGHLIGHT.replace(/\¶HS¶/gi, '<span style="color: #669aff;">').replace(/\¶HE¶/gi, '</span>') + '</li>';
							}
						}
					}
					$("#keyword_list").html(html);  
					$(".evt-keyword-list").show();
					
					var dispYn = $("#eventModifyPop").css('display');
					var chp = $(".evt-keyword-list").innerHeight();
					//수정중 없을때
					if(dispYn == "none"){
						if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10}"){
							$('.fixed_box').css('top',-(chp - "60")+'px');
						}else{
							$('.fixed_box').css('top',-(chp)+'px');
						}
					//수정중 있을때
					}else if(dispYn == "block"){
						chp = $(".evt-keyword-list").innerHeight() + $(".alert-commentBox").innerHeight();
						if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10}"){
							let chpm = $(".evt-keyword-list").innerHeight() + $(".alert-commentBox").innerHeight() - "60";
							$('.fixed_box').css('top',-(chpm)+'px');
						}else{ 
							$('.fixed_box').css('top',-(chp)+'px');
						}
					}
				}
			}
			
			
			function modifyHeight(){
				var ch = "";
				if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10}"){
					ch = "14";
				}else{
					ch = "-46";
				}
				$('.fixed_box').css('top', ch+'px');
			}
			
			//삭제버튼
			function fncCloseModifyAlert(){
				ui.confirm('댓글 수정을 취소할까요?',{
				    ycb:function(){ // '네' 버튼 클릭
						$("#eventModifyPop").css('display', 'none');
						$(".evt-keyword-list").css('display', 'none'); 
// 						fncBtnDispGb("N"); //버튼 숨김
						
						var replyNo = $("#aplyRegister").attr("data-pati-no");
						$("#date_"+replyNo).css('display', 'block');
						$("#modify_"+replyNo).css('display', 'none');
						$("#rewrite_"+replyNo).css('display', 'none');
						$("#mbrReply_"+replyNo).css('display', 'block');
						
						$("#enryAply").val("");
						$("#enryAply").blur();
				    },
				    ncb:function(){ // '아니오' 버튼 클릭
				    	$("#enryAply").focus();
				    },
				    ybt:'예',
				    nbt:'아니오',
				});				
			}
			
			// 버튼 show/hide function
			function fncBtnDispGb(dispGb) {
				if (dispGb == "Y") {
					$("#aplyRegister").show();
// 					$("#aplyRegister").siblings("button.del").show();
				} else {
					$("#aplyRegister").hide();
// 					$("#aplyRegister").siblings("button.del").hide();
				}
			}
			
			function setAplyTimeConvert(){
				$('.commendListBox .con .update-time').each(function(){
					if( $(this).text() != undefined && $(this).text() != '') {
						var timeTxt = new Date($(this).text().replace(/\s/, 'T'));					
						var converTime = elapsedTime(timeTxt, "년월일");
						$(this).text(converTime);
					}
				});
			}
		
			//멘션추가, 태그 검색 후 li 태그 클릭 시 이벤트 
			function selectTag(index){
				let element = document.getElementById('enryAply');
				let strOriginal = element.value;
				let iStartPos = element.selectionStart;
				$("#enryAply").blur();
				$("#enryAply").focus();
				
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

				$(".evt-keyword-list").hide();
				$("#keyword_list").html("");
				$('.fixed_box').css('top',''); //mobile web에서  @태그 후에 fixed_box가 공유하기 버튼을 가리고있어 추가
			}
			
			//로그인 체크
			function checkLogin(){
				if(isLogin == "${frontConstants.COMM_YN_N}"){
					ui.confirm("<spring:message code='front.web.view.common.msg.using.login.service' />",{
						ycb: function(){
							var url = "/indexLogin?returnUrl=event/detail?eventNo="+"${event.eventNo}";
							window.location.href = url;
						}
						,	ncb: function(){
								$("#enryAply").val("");
								$("#aplyRegister").hide();
						}
						,	ybt:"<spring:message code='front.web.view.login.popup.title' />"
						,	nbt:"<spring:message code='front.web.view.common.msg.cancel' />"
					});
				}
			}	
	</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<div id="hidden-field">
			<input type="hidden" id="dlgtImgPath" value="${frame:imagePath(event.dlgtImgPath)}" />
			<input type="hidden" id="nickNm" value="${session.nickNm}"/>
		</div>

		<main class="container page comm event detail" id="container">
			<div class="pageHeadPc lnb">
				<div class="inr">
					<div class="hdt">
						<h3 class="tit"><spring:message code='front.web.view.event.title_detail' /></h3>
						
						<!-- 상세 | 설명 및 날짜(PC) -->
						<p class="sub">${event.ttl}</p>
						<em class="date"><fmt:formatDate value="${event.aplStrtDtm}" pattern="yyyy.MM.dd"/> ~ <fmt:formatDate value="${event.aplEndDtm}" pattern="yyyy.MM.dd"/></em>
					</div>
				</div>
			</div>
					
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<!-- 펫샵 - 이벤트 -->
					<input type="hidden" id="dispClsfNo_" value="${view.dispClsfNo}"/>
					<input type="hidden" id="returnUrl" value="${returnUrl}"/>

					<!-- 상세 | 설명 및 날짜(MO) -->
					<div class="pageHeadMo">
						<p class="sub">${event.ttl}</p>
						<em class="date"><fmt:formatDate value="${event.aplStrtDtm}" pattern="yyyy.MM.dd"/> ~ <fmt:formatDate value="${event.aplEndDtm}" pattern="yyyy.MM.dd"/></em>
					</div>

					<section class="sect detail">
						<div class="top" id="event-content">
							<!-- 카카오 채널 추가 이벤트 일 떄 -->
							<c:if test="${event.isKaKaoChannelYn eq frontConstants.COMM_YN_Y}">
								<c:choose>
									<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
										<div class="map-area">
											<c:out value="${event.content}" escapeXml="false"/>
										</div>
										<map id="map" name="map">
											<area target="_blank" title="지금즉시 2천원 할인쿠폰 받기" href="#" onclick="fnGoKaKaoChannel();" coords="74,2968,826,3096" shape="rect">
										</map>
									</c:when>
									<c:otherwise>
										<div class="map-area">
											<c:out value="${event.content}" escapeXml="false"/>
											<a class="bt-map" href="#" onclick="fnGoKaKaoChannel();" title="지금즉시 2천원 할인쿠폰 받기"></a>
										</div>
									</c:otherwise>
								</c:choose>
							</c:if>

							<!-- 카카오 채널 추가 이벤트 아닐 떄 -->
							<c:if test="${empty event.isKaKaoChannelYn or  event.isKaKaoChannelYn eq frontConstants.COMM_YN_N}">
								<div class="map-area">
									<c:out value="${event.content}" escapeXml="false"/>
								</div>
							</c:if>
						</div>

						<div class="commentBoxAp">
							<ul class="bar-btn-area">
								<li>
									<button class="btn-share" onclick="shareBtnClick();"><span><spring:message code='front.web.view.common.sharing' /></span></button>
								</li>
								<c:if test="${event.aplyUseYn eq frontConstants.COMM_YN_Y}">
									<li>
										<button class="btn-comment" id="aplyCnt">${event.aplyCnt}</button>
									</li>
								</c:if>
							</ul>
							
							<c:if test="${event.aplyUseYn eq frontConstants.COMM_YN_Y}">
								<div class="con">
									<!-- 2021.05.28 CSR-834 이벤트 댓글추가 -->
<%-- 									<div class="fixed_box" style="${view.deviceGb eq frontConstants.DEVICE_GB_10 ? 'top:-46px;' : 'top:0px'}"> --%>
									<div class="fixed_box">
										<div class="evt-keyword-list" style="display:none;" > <!-- 21.06.21 CSR-834 lcm01 : @멘션기능만 남깁니다 -->
											<ul id="keyword_list">
											</ul>
										</div>
										
										<div class="alert-commentBox" id="eventModifyPop" style="display:none;">
											<p><span class="icon-speechBubble"></span>댓글을 수정 중입니다.</p>
											<button class="close" onclick="fncCloseModifyAlert();"></button>
										</div>
									</div>						
										
									<div class="input" id="replyTextarea">
										<span>
											<img class="thumb" data-original="${frame:imagePath(session.prflImg)}" src="${frame:imagePath(session.prflImg)}" alt="">
										</span>
										<c:choose>
											<c:when test="${isLogin eq frontConstants.COMM_YN_Y}">
												<c:set var="placeholder"><spring:message code='front.web.view.common.msg.try.comment.insert' /></c:set>
											</c:when>
											<c:otherwise>
												<c:set var="placeholder"><spring:message code='front.web.view.common.msg.comment.after.login' /></c:set>
											</c:otherwise>
										</c:choose>
										<textarea type="text" id="enryAply" name="enryAply" placeholder="${placeholder}" onclick="checkLogin();"></textarea>
										<c:if test="${session.mbrNo ne frontConstants.NO_MEMBER_NO}">
											<button type="button" id="aplyRegister" onclick="aply.save(this);" data-pati-no=""><spring:message code='front.web.view.common.registration' /></button>
										</c:if>
									</div>
									<div class="box">
										<div class="commendListBox">
											<ul id="reply-list">
												<jsp:include page="indexEventAply.jsp"/>
											</ul>
										</div>
									</div>
								</div>
							</c:if>
						</div>
					</section>
				</div>

			</div>
		</main>
	</tiles:putAttribute>
</tiles:insertDefinition>