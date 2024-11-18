<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.inline">	
		<script type="text/javascript">
			var toastH = 74;
		
			$(document).ready(function(){
	        	$(".menubar").remove();
	        	$("#footer").remove();
	        	$(".mo-heade-tit .tit").html("FAQ");
	        	$(".mo-header-backNtn").attr('onclick', 'goOut();')
	        	$("#header_pc").addClass('logHeaderAc');
	        	
				$(".uiTab li").eq(0).addClass('active');
				$(".uiTab li a").eq(0).addClass('active');
				$(".uiAccd li").removeClass('open');
				$(".cBox").css("display", "none");
				
				if(${fn:length(faqList) < 0}) {
					$("#noDatas").css("display", "block");
				} else {
					$("#noDatas").css("display", "none");
				}
				
				$(".btnDel").hide();
				
				//검색란 엔터 이벤트
				$("#searchWord").keydown(function(key) {
					if(key.keyCode == 13) {
						searchFaq();
					}
				});
				
// 				$(".mo-header-backNtn").click(function() {
// 					if(document.referrer.indexOf("tv/home") > -1){
// 						location.href = '/tv/home';
// 					} else {
// 						history.go(-1)
// 					}
// 				})
				
				if( isIOS() ) {
					toastH = 330;
				}
				
				if($(".uiTab li").eq(0).hasClass('active') === true) {
					if($(".uiAccd li").length > 10) {
						for(var i = 0; i < $(".uiAccd li").length; i++) {
							$(".uiAccd li").eq(i).css("display", "none");
						}
						$(".uiAccd li").slice(0,10).show();
						$(".uiAccd").append("<div class='uimoreload'><button type='button' class='bt more' id='moreBtn' onclick='moreFaq();'><spring:message code='front.web.view.include.comment.faq.more.view' /></button></div>");
					}
				}
				backImgCtr();
			});
			
			//전체 탭일 경우 더보기 event
			function moreFaq() {
				var index;
				for(var i = 0; i < $(".uiAccd li").length; i++) {
					if(!$(".uiAccd li").eq(i).is(":visible")) {
						index = i;
						break;
					}
				}
				
				$(".uiAccd li").slice(index, index+10).show();
				
				if($(".uiAccd li:hidden").length == 0) {
					$(".uimoreload").hide();
				}
			}
			
			
			function goOut(){
				if("${requestScope['javax.servlet.forward.query_string']}".indexOf('home=tv') > -1){
					storageHist.goBack('/tv/home/');
				}else if("${requestScope['javax.servlet.forward.query_string']}".indexOf('home=log') > -1){
					storageHist.goBack('/log/home/');
				}else{
					storageHist.getOut("${requestScope['javax.servlet.forward.servlet_path']}", true);	
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
			
			//faq 리스트
			function faqList(bbsGbNo, bbsId) {
				var options = {
						url : "/customer/faq/faqGbList",
						data : {
							bbsGbNo : bbsGbNo
							, bbsId : bbsId
						}
						, done : function(data) {
							if($(".uiTab li").eq(0).hasClass('active') === true) {
								if(data.faqList.length > 0) {
									$(".result").css("display", "none");
									$("#noDatas").css("display", "none");
									
									$(".uiAccd").empty();
									var html = '';
									
									for(i in data.faqList) {
										var newContent = data.faqList[i].content.replace(/(<([^>]+)>)/ig,"");
										
										html += '<li class="open">';
										html += 	'<div class="hBox" name="noBtn">';
										html += 		'<p name="btnChk">';
										html += 			'<span class="tit"><em class="blue">'+data.faqList[i].bbsGbNm+'</em> '+data.faqList[i].ttl+' </span>';
										html += 		'</p>';
										html += 		'<button type="button" class="btnTog"><spring:message code='front.web.view.common.msg.button' /></button>';
										html += 	'</div>';
										html += 	'<div class="cBox">';
										html += 		data.faqList[i].content;
										html += 	'</div>';
										html += '</li>';
									}
									$(".notilist .uiAccd").append(html);
									$(".uiAccd li").removeClass('open');
									$(".cBox").css("display", "none");
									$("#searchWord").val("");
									
									if(data.faqList.length > 10) {
										for(var i = 0; i < data.faqList.length; i++) {
											$(".uiAccd li").eq(i).css("display", "none");
										}
										$(".uiAccd li").slice(0,10).show();
										$(".uiAccd").append("<div class='uimoreload'><button type='button' class='bt more' id='moreBtn' onclick='moreFaq();'><spring:message code='front.web.view.include.comment.faq.more.view' /></button></div>");
									}
								} else {
									$(".result").css("display", "none");
									$(".uiAccd").empty();
									$("#noDatas").css("display", "block");
									$("#searchWord").val("");
								}
							} else {
								if(data.faqList.length > 0) {
									$(".result").css("display", "none");
									$("#noDatas").css("display", "none");
									
									$(".uiAccd").empty();
									var html = '';
									
									for(i in data.faqList) {
										var newContent = data.faqList[i].content.replace(/(<([^>]+)>)/ig,"");
										
										html += '<li class="open">';
										html += 	'<div class="hBox" name="noBtn">';
										html += 		'<p name="btnChk">';
										html += 			'<span class="tit"><em class="blue">'+data.faqList[i].bbsGbNm+'</em> '+data.faqList[i].ttl+' </span>';
										html += 		'</p>';
										html += 		'<button type="button" class="btnTog"><spring:message code='front.web.view.common.msg.button' /></button>';
										html += 	'</div>';
										html += 	'<div class="cBox">';
										html += 		data.faqList[i].content;
										html += 	'</div>';
										html += '</li>';
									}
									$(".notilist .uiAccd").append(html);
									$(".uiAccd li").removeClass('open');
									$(".cBox").css("display", "none");
									$("#searchWord").val("");
								} else {
									$(".result").css("display", "none");
									$(".uiAccd").empty();
									$("#noDatas").css("display", "block");
									$("#searchWord").val("");
								}
							}
							backImgCtr();
						}
				};
				ajax.call(options);
				
			}
			
			//faq 검색
			function searchFaq() {
				var searchWord = $("#searchWord").val();
				
				//미입력 및 공백 체크
				if(searchWord.replace(/\s| /gi, "").length == 0) {
					// 토스트 창띄우기
					ui.toast('<spring:message code='front.web.view.include.comment.insert.keyword' />');
					ui.toast('<spring:message code='front.web.view.include.comment.insert.keyword' />',{
					    cls:'abcd', // null , string
					    bot:toastH,  // 바닥에서 띄울 간격
					    sec:3000 // 사라질 시간 number
					});
					$("#searchWord").val("");
					$("#searchWord").focus();
					return;
				}
				
				var options = {
						url : "/customer/faq/searchFaq",
						data : {
							searchWord : searchWord
						}
						, done : function(data) {
							if(data.searchFaq.length > 0) {
								$(".result").css("display", "block");
								$(".result b").text(data.searchFaq.length + "건");
								
								$("#noDatas").css("display", "none");
								$(".uiAccd").empty();
								
								var html = '';
								
								for(i in data.searchFaq) {
									var newContent = data.searchFaq[i].content.replace(/(<([^>]+)>)/ig,"");
									
									html += '<li class="open">';
									html += 	'<div class="hBox" name="noBtn">';
									html += 		'<p name="btnChk">';
									html += 			'<span class="tit"><em class="blue">'+data.searchFaq[i].bbsGbNm+'</em> '+data.searchFaq[i].ttl+' </span>';
									html += 		'</p>';
									html += 		'<button type="button" class="btnTog"><spring:message code='front.web.view.common.msg.button' /></button>';
									html += 	'</div>';
									html += 	'<div class="cBox">';
									html += 		'<p>'+newContent+'</p>';
									html += 	'</div>';
									html += '</li>';
								}
								$(".notilist .uiAccd").append(html);
								$(".uiAccd li").removeClass('open');
								$(".cBox").css("display", "none");
								$(".mt15").css("display", "none");
							} else {
								$(".result").css("display", "none");
								
								$(".uiAccd").empty();
								$("#noDatas").css("display", "block");
								$(".mt15").css("display", "none");
							}
						}
				};
				ajax.call(options)
			}
			
			function call() {
				if("${view.deviceGb}" == "APP") {
					document.location.href="tel:1644-9601";
				} else {
					ui.alert('<spring:message code='front.web.view.include.ask.servicecenter.number' />');	//APP이 아닐 경우 메시지 노출
					ui.alert('<spring:message code='front.web.view.include.ask.servicecenter.number' />',{
					    tit:"<spring:message code='front.web.view.include.call.servicecenter' />",
					    ycb:function(){
					    },
					    ybt:"<spring:message code='front.web.view.common.msg.confirmation' />" // 기본값 "확인"
					});
				}
			}
			
			function backImgCtr(){
				$('.cBox').each(function (index, item) {
					/* var $cBoxChild = $(this).children().not(":first");					
					var objLength = $cBoxChild.length;					
					$cBoxChild.each(function (ii, item) {
						if(ii != objLength-1){
							$(this).css("background",'url("")').css("padding-bottom","0px");
						}else{
							$(this).css("background",'url("")');
						}						
					}); */
					var $cBoxChild = $(this).children();
					var objLength = $cBoxChild.length;					
					if(objLength > 1){
						$cBoxChild.each(function (ii, item) {
							if(ii == 0){
								$(this).css("padding-bottom","0px");
							}else if(ii != objLength-1){
								$(this).css("background",'url("")').css("padding-bottom","0px").css("padding-top","7px");
							}else{
								$(this).css("background",'url("")').css("padding-top","7px");
							}						
						});
					}
					
				});				
			}
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">	
		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container page noti faq" id="container">

			<div class="inr">
				
				<!-- 본문 -->
				<div class="contents" id="contents">

					<!-- PC 타이틀 모바일에서 제거  -->
					<div class="pc-tit">
						<h2><spring:message code='front.web.view.include.title.faq' /></h2>
					</div>
					<!-- // PC 타이틀 모바일에서 제거  -->

					<!-- FAQ 검색 영역 -->
					<section class="sect top">
						<div class="input del">
							<input type="text" id="searchWord" placeholder="<spring:message code='front.web.view.include.insert.faq.question' />" value="">
							<button type="button" class="btnDel" tabindex="-1"><spring:message code='front.web.view.goods.delete.btn' /></button>
							<button type="button" class="btnfaq" onclick="searchFaq();"><spring:message code='front.web.view.common.searchdetail.btn' /></button>
						</div>
						<P class="result" style="display:none;"><spring:message code='front.web.view.common.searchdetail.result' /><b></b></P>
					</section>

					<!-- FAQ 메뉴 영역 -->
					<section class="sect menu mt15">
						<ul class="uiTab h">
						<c:forEach var="faqGbList" items="${faqGbList }" varStatus="status">
							<li><a href="javascript:faqList('${faqGbList.bbsGbNo}', 'dwFaq')" class="bt" data-ui-tab-btn="tab_cate" data-ui-tab-val="tab_cate_${status.index + 1}">${faqGbList.bbsGbNm}</a></li>
						</c:forEach>
						</ul>
					</section>
					
					<!-- FAQ 컨텐츠 영역 -->
					<section class="sect flist notilist">
						<li class="nodata min_h" id="noDatas" style="min-height: 150px;">
							<p class="txt"><spring:message code='front.web.view.common.no.searchdetail.result' /><span class="sm"><i><spring:message code='front.web.view.include.comment.go.to.ask' /></i><spring:message code='front.web.view.include.comment.if.you.ask.question' /><br>
							<spring:message code='front.web.view.include.comment.give.answer.kindly' /></span></p>
						</li>
						
						<ul class="uiAccd" data-accd="accd">
							<c:forEach var="faqList" items="${faqList }">
							<li class="open">
								<div class="hBox" name="noBtn">
									<p name="btnChk">
										<span class="tit no_ellipsis"><em class="blue">${faqList.bbsGbNm}</em> ${faqList.ttl}</span>
									</p>
									<button type="button" class="btnTog"><spring:message code='front.web.view.common.msg.button' /></button>
								</div>
								<div class="cBox">
									<!-- 퍼블작업 완료 시 수정 -->									
									${faqList.content}
									<%-- <p>
										<c:out value='${faqList.content.replaceAll("\\\<.*?\\\>","")}' escapeXml="false"/>
									</p> --%>
								</div>
							</li>
							</c:forEach>
						</ul>
						<dl class="guide">
							<dt><spring:message code='front.web.view.include.title.faq.information' /></dt>
							<dd>
								<p class="box" onclick="call();">
									<span class="call"><spring:message code='front.web.view.include.title.faq.servicecenter.number' /></span>
									<span><spring:message code='front.web.view.include.title.faq.servicecenter.openhours' /></span>
									<span><spring:message code='front.web.view.include.title.faq.servicecenter.lunchtime' /></span>
								</p>
								<span class="btnSet">
									<a href="/customer/inquiry/inquiryView?popupChk=popOpen" class="btn lg a base"><spring:message code='front.web.view.include.comment.go.to.ask.btn' /></a>
									<a href="/customer/inquiry/inquiryView" class="btn lg a base"><spring:message code='front.web.view.include.comment.go.to.ask.page.btn' /></a>
								</span>
							</dd>
						</dl>
					</section>
				</div>
			</div>
		</main>
		
		<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
		<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
		       <jsp:param name="floating" value="" />
		</jsp:include>
		</c:if>
		
	</tiles:putAttribute>
</tiles:insertDefinition>

		<div class="layers">
			<!-- 레이어팝업 넣을 자리 -->
		</div>
		<!-- 바디 - 여기 밑으로 템플릿 -->