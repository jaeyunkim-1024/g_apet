<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">var thumbApi;</script>
<script src="<spring:eval expression="@bizConfig['vod.player.api.url']" />/thumb_api/v1.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	if(thumbApi != undefined){
		onThumbAPIReady();
	}
	
	var index = Number("${index}")-1;
	if(!index){
		index = 0;
	}
	setTimeConvert();
	setContentLink();
	
	if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10}" && dispClsfCornNo != null && dispClsfCornNo != ''){
		move_scroll(index)
	}
	
	$(".contxtWrap").each(function(i, n) {
		var aad = 32;				//lcbConTxt_content 의 max높이값
		var bbd = $(n).find(".lcbConTxt_content").height();  //lcbConTxt_content 의 높이값
		
		if( bbd > aad ) {							//lcbConTxt_content 의 높이값이 32보다 크면
			$(n).find(".lcbConTxt_content").css("max-height", 32);
			$(n).find(".lcbConTxt_content").next().removeClass("onWeb_b");
		}else if( bbd < aad ) {						//lcbConTxt_content 의 높이값이 32보다 작거나 같으면 2021.08.03 수정함 APETQA-6556
			$(n).find(".lcbConTxt_content").next().addClass("onWeb_b");					
		}
	});
	
});
var dispClsfCornNo = '${so.dispClsfCornNo}';
function onThumbAPIReady() {
	thumbApi.ready();
};

//안드로이드 계열에서 저장되는 것 막음 / javascript Ready Function에 추가
$(document).bind("contextmenu", function(e) {
    return false;
});

function move_scroll(n){
	var scrollTop = $("#popLogRv .revlists.swiper-wrapper > .swiper-slide:eq("+n+")").position().top + 10
	$("#popLogRv .log_review_sld").closest(".pct").scrollTop(scrollTop);
}

function setTimeConvert(){	
	$('.time').each(function(){
		if($(this).text()) {
			var timeTxt = new Date($(this).text().replace(/\s/, 'T'));					
			var converTime = elapsedTime(timeTxt);
			$(this).text(converTime);
		}
	});
}


function setContentLink(){
	<c:choose>
		<c:when test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
			$("section .lcbWebRconBox .lcbConTxt_content").each(function(i, v) {	
		</c:when>
		<c:otherwise>
			$("[name=logDscrt]").each(function(i, v) {
		</c:otherwise>
	</c:choose>
		let strOriginal =  $(this).text();
		
		var inputString = strOriginal;
		//inputString = inputString.replace(/#[^#\s]+|@[^@\s]+/gm, function (tag){
		inputString = inputString.replace(/#[^#\s\<\>\@\&\\']+/gm, function (tag){
			return (tag.indexOf('#')== 0 && tag.length < 22) ? '<a href="/log/indexPetLogTagList?tag=' + encodeURIComponent(tag.replace('#','')) + '" style="color:#669aff;">' + tag + '</a>' : tag;
		});
		$(this).html(inputString);
		
// 		if(inputString.indexOf('\n') > 0){
// 			$(this).html(inputString).css("white-space", "pre-wrap");
// 			<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">				
// 				$(this).html(inputString).css('height', '1.4em').css("display", "-webkit-box").css("-webkit-line-clamp", "1").css("-webkit-box-orient", "vertical").css("word-wrap", "break-word");
// 			</c:if>
// 			$(this).next(".btn_logMain_more").removeClass("onWeb_b");
// 		}
	});
}



//펫로그 후기 삭제
function petLogDel(index){
	ui.confirm('후기를 삭제할까요?',{ // 컨펌 창 띄우기
		ycb:function(){
			var options = {
					url : "<spring:url value='/goods/petLogCmtDelete' />"
					, data : $("#updateForm"+index).serializeJson()
					, done : function(data){
						ui.popLayer.close('popLogRv');
						petLogList.reload('delete');
						ui.toast('후기가 삭제 되었어요',{   // 토스트 창띄우기
							bot:70
						});
						//location.reload();
					}
				};
				ajax.call(options);
		},
		ncb:function(){
			/* ui.toast('취소 되었습니다.',{   // 토스트 창띄우기
				bot:70
			}); */
			return false;
		},
		ybt:'예',
		nbt:'아니오'	
	});
}

//펫로그 후기 수정
function petLogUpdate(petLogNo , index , mbrNo){
	if("${view.deviceGb}" != "APP"){
		ui.alert('펫로그 후기는 <br>모바일 앱에서 수정 가능합니다.');
		return false;
	}else{
		if(dispClsfCornNo == undefined && !(goodsComment.selectTab == "PLG")){
			$('button[data-ui-tab-val=tab_rvt_a]').trigger('click');
		}
		
		$('#goodsLayers #popLogRv button.btnPopClose').trigger('click');
		var url = "/mypage/commentWriteView"
		var goform = $("<form>",
			{ method : "post",
			action : url,
			target : "_self",
			html : $("#updateForm"+index).html()
			}).appendTo("body");
			goform.submit();
	}
}

function insertPetLogLike(petLogNo , btn){
	var saveGb;
	var likeYn = $(btn).data("likeyn");
	if(likeYn == "Y"){
		saveGb = "D"
	}else{
		saveGb = "I"
	}
	var options = {
			url : "/log/petLogInterestSave"
			, data : {
				petLogNo : petLogNo
				 , mbrNo : "${session.mbrNo}"
				 , intsGbCd : "${frontConstants.INTR_GB_10}"
				 , saveGb : saveGb
				 
			}
			, done : function(result){
				$(btn).find("i").text(result.likeCnt);
				
				if(result.existCheck == "Y"){
					saveGb = "D";
				}
				
				if(saveGb == "I"){
					$(btn).data("likeyn" , "Y");
					$(btn).addClass("me on")
				}else{
					$(btn).data("likeyn" , "N");
					$(btn).removeClass("me")
				}
				
				if(result.likeCnt == 0){
					$(btn).removeClass('on');
				}
			}
	}
	if(checkLogin()){
		ajax.call(options);	
	}
}

function layerPetLogReport(petLogNo, rvwYn , btn){
	if($(btn).data("rpt-yn") == "Y"){
		ui.toast("이미 신고한 게시물이에요");
		return false;
	}
	if(checkLogin()){
		ui.popLayer.open("popReport");
		
		// layer form 초기화.
		form.clear('petLogRptpForm');
		$('#petLogRptpForm [name="rptpRsnCd"]').prop('checked', false);		
		var $title = $("#popReport .pbd .phd .tit").text("후기 신고")
		
		$('#petLogRptpForm [name="rvwYn"]').val(rvwYn);
		$('#petLogRptpForm [name="petLogNo"]').val(petLogNo);
		$('#petLogRptpForm [name="mbrNo"]').val('${session.mbrNo}');
	}
}

// 신고하기 등록
function insertPetLogRptp(layerPop){
	if($("#petLogRptpForm [name='rptpRsnCd']").is(":checked") == false){
		ui.toast('신고 사유를 선택해주세요.',{   // 토스트 창띄우기
			bot:70
		});
		
		$("#petLogRptpForm [name='rptpRsnCd']").eq(0).focus();
		return false;			
	}
	
	var petLogNo = $('#petLogRptpForm [name="petLogNo"]').val();
	var options = {
		url : "<spring:url value='${view.stDomain}/log/petLogRptpInsert' />"
		, data : $("#petLogRptpForm").serialize()
		, done : function(data){
			//alert("<spring:message code='front.web.view.common.msg.result.insert' />");
			ui.toast('신고 완료되었습니다.',{   // 토스트 창띄우기
				bot:70
			});				
			
			//callback 함수 호출
			ui.popLayer.close(layerPop);
			
			if(data.petLogNo){
				$("[data-pet-log-no="+data.petLogNo+"]").data("rpt-yn" , "Y");
			}
		}
	};
	ajax.call(options);
}



function checkLogin(){
	<c:choose>		
		<c:when test="${session.isLogin() ne true}">
			ui.confirm('로그인 후 서비스를 이용할 수 있어요.<br>로그인 할까요?',{ // 컨펌 창 옵션들
				ycb:function(){
					document.location.href = '/indexLogin?returnUrl='+encodeURIComponent(document.location.href);
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


</script>

<article class="popLayer a popLogRv" id="popLogRv">
	<div class="pbd">
		<div class="phd">
			<div class="in">
				<h1 class="tit"><em class="tt"><spring:message code='front.web.view.new.menu.log'/> 후기</em> <!-- APET-1250 210728 kjh02  --> <em class="nm petLogCommentCount"><i class="n" id="listIndex">${index }</i>/<i class="s">${so.totalCount}</i></em></h1>
<!-- 				<button type="button" class="bt rvlist">후기리스트</button> --> 
				<button type="button" class="btnPopClose">닫기</button>
			</div>
		</div>
		<div class="pct">
			<main class="poptents">
				<div class="log_review_sld">
					<div class="sld-nav"><button type="button" class="bt prev" id="prevBtn">이전</button><button type="button" class="bt next" id="nextBtn">다음</button></div>
					<div class="swiper-container slide">
						<ul class="revlists swiper-wrapper" id="petLogDetails">
							<c:forEach items="${petLogReView}" var="petLog" varStatus="status">
							<li class="swiper-slide" id="petLogDetails_${petLog.petLogNo}" name="petLogDetail" data-idx="${status.index }" data-pet-log-no="${petLog.petLogNo }">
								<form id ="updateForm${status.index }">
									<input type="hidden" name="goodsId" value="${petLog.goodsId}">
									<input type="hidden" name="ordNo" value="${petLog.ordNo}">
									<input type="hidden" name="ordDtlSeq" value="${petLog.ordDtlSeq}">
									<input type="hidden" name="goodsEstmTp" value="${petLog.goodsEstmTp}">
									<input type="hidden" name="goodsEstmNo" value="${petLog.goodsEstmNo}">
									<input type="hidden" name="petLogNo" value="${petLog.petLogNo}">
								</form>
								<div class="box">
									<div class="rhdt">
										<div class="tinfo">
											<span class="pic"><img src="${frame:imagePath(petLog.prflImg)}" alt="사진" class="img" onerror="this.src='../../_images/_temp/temp_logDogImg02.png'"></span>
											<div class="def">
												<em class="dd ids">${petLog.nickNm}</em> 
												<em class="dd date"><frame:timestamp date="${petLog.sysRegDtm}" dType="H" /></em> 
												<c:if test ="${petLog.bestYn eq 'Y'}"><em class="ds me">BEST</em></c:if>
													<nav class="uidropmu dmenu only_down">
														<c:if test ="${petLog.mbrNo ne session.mbrNo || view.deviceGb ne frontConstants.DEVICE_GB_10}">
															<button type="button" class="bt st gb" name="menuBtn">메뉴열기</button>
														</c:if>
														<div class="list">
															<ul class="menu">
																<c:if test ="${petLog.mbrNo eq session.mbrNo }">
																	<li><button type="button" class="bt" onclick="petLogUpdate(${petLog.petLogNo} , ${status.index } , ${petLog.mbrNo });">수정</button></li>
																	<li><button type="button" class="bt" onclick="petLogDel(${status.index});">삭제</button></li>
																</c:if>
																<c:if test ="${petLog.mbrNo ne session.mbrNo }">
																	<li><button type="button" class="bt" onclick="layerPetLogReport(${petLog.petLogNo} , 'Y' , this);" data-pet-log-no="${petLog.petLogNo }" data-rpt-yn="${petLog.rptYn }">신고</button></li>	
																</c:if>
															</ul>
														</div>
													</nav>
											</div>
											<div class="spec"><em class="b">${petLog.petNm}<span>(${petLog.petGdNm })</span></em>
												<c:choose>
													<c:when test ="${petLog.age ne '' and petLog.age ne null }"> 
														<em class="b">${petLog.age}살 </em>
													</c:when>
													<c:otherwise>
														<em class="b">${petLog.month}개월 </em>
													</c:otherwise>
												</c:choose>
												<c:if test ="${petLog.weight ne '' and petLog.weight ne null}">
													<em class="b">${petLog.weight}kg</em>
												</c:if>
											</div>
										</div>
										<div class="hpset">
											<em class="htxt">도움이돼요</em>
											<button type="button" data-likeyn="${petLog.likeYn }" class="bt hlp on<c:if test="${petLog.likeYn eq 'Y' }"> me</c:if>" onclick="insertPetLogLike('${petLog.petLogNo}' , this)"><i class="n">${petLog.likeCnt}</i><b class="t">도움</b></button>
										</div>
									</div>
									<div class="rcdt">
										<div class="stpnt starpoint">
    										<span class='stars sm p_${fn:replace(((petLog.estmScore/2)+""), ".", "_") }'></span>
										</div>
										<ul class="satis">
							 				<c:forEach items="${petLog.petLogGoodsList}" var="goods" varStatus="item">
												<c:choose>
													<c:when test="${item.index eq 0}">
														<li><span class="dt">맛 만족</span> <span class="dd">${goods.itemContent}</span></li>
													</c:when>
													<c:when test="${item.index eq 1}">
														<li><span class="dt">유통기한</span> <span class="dd">${goods.itemContent}</span></li>
													</c:when>
													<c:otherwise>
														<li><span class="dt">가성비</span> <span class="dd">${goods.itemContent}</span></li>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</ul>
										<div class="opts">
											<a href="/goods/indexGoodsDetail?goodsId=${petLog.goodsId}" class="opts" data-content='${petLog.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${petLog.goodsId}">${petLog.optName }</a>
										</div>
										<div class="rvPicSld">
											<section class="logRvSet" style="padding-top: 0px;">
												<c:choose>
												<c:when test="${petLog.vdPath ne null and petLog.vdPath ne ''}">
													<div class="picture mov"><!-- 영상일경우 mov -->
														<div class="vthumbs" video_id="${petLog.vdPath}" type="video_thumb_360p" style="height: 100%" lazy="scroll" uid="${petLog.mbrNo}|${session.mbrNo}" ></div>
													</div>
												</c:when>
												<c:otherwise>
													<section class="logContentBox review">
														<div class="lcbPicture sw">
															<div class="swiper-container logMain">
																<c:set var="imgPathList" value="${fn:split(petLog.imgPathAll,'[|]')}" />
																<c:if test ="${fn:length(imgPathList) > 1 }">
																	<div class="swiper-pagination"></div>
																</c:if>
																<ul class="swiper-wrapper slide"> 
																	<c:choose>
																		<c:when test="${fn:length(imgPathList) > 1 }">
																			<c:forEach items="${imgPathList}" var="imgPath">
																				<c:choose>
																					<c:when test="${fn:indexOf(imgPath, '/log/') > -1 }">
																						<c:set var="optImage"
																							value="${frame:optImagePath(imgPath, view.deviceGb eq frontConstants.DEVICE_GB_10 ? frontConstants.IMG_OPT_QRY_650 : frontConstants.IMG_OPT_QRY_640)}" />
																						<c:if test="${fn:indexOf(imgPath, '.gif') > -1 }">
																							<c:set var="optImage"
																							value="${frame:imagePath(imgPath)}" />
																						</c:if>
																					</c:when>
																					<c:otherwise>
																						<c:set var="optImage"
																							value="../../_images/_temp/temp_logsImg01.png" />
																						<!-- 퍼블이미지 -->
																					</c:otherwise>
																				</c:choose>
																				<li class="swiper-slide">
																					<div class="inr">
																						<img src="${optImage}">
																					</div>
																				</li>
																			</c:forEach>
																		</c:when>
																		<c:otherwise>
																			<c:choose>
																				<c:when test="${fn:indexOf(imgPathList[0], '/log/') > -1 }">
																					<c:set var="optImage" value="${frame:optImagePath(imgPathList[0], view.deviceGb eq frontConstants.DEVICE_GB_10 ? frontConstants.IMG_OPT_QRY_650 : frontConstants.IMG_OPT_QRY_640)}" />
																					<c:if test="${fn:indexOf(imgPathList[0], '.gif') > -1 }">
																						<c:set var="optImage" value="${frame:imagePath(imgPathList[0])}" />
																					</c:if>
																				</c:when>
																				<c:otherwise>
																					<c:set var="optImage" value="../../_images/_temp/temp_logsImg01.png" />
																					<!-- 퍼블이미지 -->
																				</c:otherwise>
																			</c:choose>
																				<li class="swiper-slide">
																					<div class="inr">
																						<img src="${optImage}">
																					</div>
																				</li>
																		</c:otherwise>
																	</c:choose>
																</ul>
																<div class="remote-area">
																	<button class="swiper-button-next" type="button"></button>
																	<button class="swiper-button-prev" type="button"></button>
																</div> 															
															</div>
														</div>
													</c:otherwise>
												</c:choose>
												<c:set var="dscrt" value="${petLogReView[status.index].dscrt}" />
												<c:set var="pstNm" value="${petLogReView[status.index].pstNm}" />
												<c:set var="nickNm" value="${petLogReView[status.index].nickNm}" />
												<c:set var="sysRegDtm" value="${petLogReView[status.index].sysRegDtm}" />
												<div class="lcbWebRconBox">
													<!-- span class="iconOm_arr"></span -->
													<div class="contxtWrap">
														<div class="lcbConTxt_content" name="logDscrt">${dscrt}</div>
														<!-- more btn -->
														<button class="btn_logMain_more onWeb_b"><spring:message code='front.web.view.common.seemore.title' /></button>
														<!-- // more btn -->
													</div>
													<!-- // content txt -->
												</div>
											</section>
											</section>
										</div>
										<c:if test ="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
											<div class="msgs" name="logDscrt" style="white-space: pre-wrap;">${petLog.dscrt}</div>
										</c:if>
									</div>
									
								</div>
							</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</main>
		</div>
	</div>
</article>	 
<script>
$(document).on("click",".logRvSet .contxt .bt.tog",function(e){
	$(this).closest(".rconbox").toggleClass("active");
});
$(document).on("click",".logRvSet .picture .bt.sound",function(e){
	$(this).toggleClass("on");
});
</script>

<c:if test="${not empty so.dispClsfCornNo}">
<script>
ui.popLayer.open("popLogRv");
var swiperBox = new Array();
$(function(){
	if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_10}"){
		$(".swiper-container.logMain").each(function(i,n){
			//PC
			/* 메인 스와이프 */
			swiperBox.push(new Swiper(".swiper-container.logMain", {
				slidesPerView: 1,
				slidesPerGroup: 1,
				freeMode: false,
				navigation: {
					nextEl: '.swiper-container.logMain .swiper-button-next',
					prevEl: '.swiper-container.logMain .swiper-button-prev',
				},
				pagination: {
					el: '.swiper-container.logMain .swiper-pagination',
					type: 'fraction',
				},
				on: {
					slideResetTransitionStart: function() {
						if ((this.snapIndex + 1) == this.imagesLoaded) {
							$(this.wrapperEl).find(".swiper-slide-active").removeClass("swiper-slide-active").addClass("si_last");
						} else {
							$(this.wrapperEl).find(".si_last").removeClass("si_last");
						}
					}
				}
			}));
		});
	}else{
		//MOBILE
		/* 메인 스와이프 */
		swiperBox.push(new Swiper(".swiper-container.logMain", {
			slidesPerView: 1.11,
			slidesPerGroup: 1,
			spaceBetween: 10,
			centeredSlides: true,
			freeMode: false,
			navigation: {
				nextEl: '.swiper-container.logMain .swiper-button-next',
				prevEl: '.swiper-container.logMain .swiper-button-prev',
			},
			pagination: {
				el: '.swiper-container.logMain .swiper-pagination',
				type: 'fraction',
			},
		}));
	}
	
	//펫로그 후기 이미지 페이징 업데이트 처리
	for(var i=0; i<swiperBox[0].length; i++){
		if(swiperBox[0][i].$el.find('.swiper-slide').length > 1){
			swiperBox[0][i].pagination.update();
		}
	};
	
});

</script>
</c:if>
<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
	<script>
		/* 게시글 펼쳐보고 버튼 모바일 경우만 작동 */
		$(".btn_logMain_more").click(function(){
			$(this).closest(".contxtWrap").addClass("open");
			$(this).closest(".contxtWrap").find(".lcbConTxt_content").css('height', '').css("display", "").css("-webkit-line-clamp", "").css("-webkit-box-orient", "").css("word-wrap", "");
		});
		
		/* MO - 내용 더보기 버튼 처리.  */
			$(".contxtWrap").each(function(i, n) {
				var aad = 32;				//lcbConTxt_content 의 max높이값
				var bbd = $(n).find(".lcbConTxt_content").height();  //lcbConTxt_content 의 높이값
				
				if( bbd > aad ) {							//lcbConTxt_content 의 높이값이 32보다 크면
					$(n).find(".lcbConTxt_content").css("max-height", 32);
					$(n).find(".lcbConTxt_content").next().removeClass("onWeb_b");
				}else if( bbd < aad ) {						//lcbConTxt_content 의 높이값이 32보다 작거나 같으면 2021.08.03 수정함 APETQA-6556
					$(n).find(".lcbConTxt_content").next().addClass("onWeb_b");					
				}
			});
// 		}); 
		
		/* 04.12 */
		$(".popLogRv .phd .nm .s").text($(".pct .revlists.swiper-wrapper > .swiper-slide").length);
		/* 모바일 대응 */
		/* scroll 이벤트 추가 */
	if(ui.check_brw.mo()){
			$(document).ready( function() {
				var $firstChild = $(this).find(".revlists.swiper-wrapper > .swiper-slide");
				var firstMax = $firstChild.length;
				if(firstMax > 0){
					$(".popLogRv .phd .nm .n").text("1");

					$(".pct").scroll(function(){
						var $child = $(this).find(".revlists.swiper-wrapper > .swiper-slide");
						var max = $child.length;
						var position = new Array();
						var st =  $(this).scrollTop();
						var ind = 1;
						$child.each(function(i,n){
							position[(max - i - 1)] = $(n).position().top;
						});
						for(var i=0; i<position.length; i++){
							if(st >= (position[i]) ){
								ind = max - i;
								break;
							}
						}
						
						/* <c:if test="${empty so.dispClsfCornNo}">
							ind = $('#petLogDetails li[name=petLogDetail]').data('idx')+1;
							console.log(ind);
						</c:if> */
						$(".popLogRv .phd .nm .n").text(ind);
						
					});
				}
				else {
					$(".popLogRv .phd .nm .n").text("0");
				}
			});
		};
	</script>
</c:if>

<jsp:include page="/WEB-INF/view/petlog/layerPetLogReplyReport.jsp" />
