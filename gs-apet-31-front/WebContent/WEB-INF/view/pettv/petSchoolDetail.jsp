<%--	
 - Class Name	: /pettv/petSchoolDetail.jsp
 - Description	: 펫스쿨 상세
 - Since		: 2021.1.21
 - Author		: KWJ
--%>

<tiles:insertDefinition name="header_pc">
	<style>
        .popFixed{position:fixed; top:0; left:0; z-index:1000; width:100%; height:100%;}
        .popFixed > .popup-wrap{height:100%;}
        .popFixed .content{height:calc(100% - 46px); overflow:auto;}
        .popFixed .content main img{width:100%; height:auto;}
        .popFixed > .popup-wrap > .top{background:#fff;}       
        
        body, html, .wrap{height:100% !important;}
    </style>
    <%-- <tiles:putAttribute name="script.include" value="script.pettv"/> --%>
 	
	<tiles:putAttribute name="script.inline">	
	<!-- <script src="https://devsgr.aboutpet.co.kr/player/thumb_api/v1.js"></script> -->
	<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10}">
	<style>
	 body{background-color:#000;}   
    </style>
    </c:if>
		<script>
		// 동영상 마우스 우클릭 방지
		$("#sgrplayer_r1cpmgj14rc").on("contextmenu", function(event) { event.preventDefault();});
		var autoFlag = false;
		var shareThumImgBase64 = "";
		var shareThumImg;
		var execEvent = false;
		var histCnt = Number("${histCnt}");
		var histLoginCnt = Number("${histLoginCnt}");
		histCnt = histCnt + histLoginCnt; 
		
		$(document).ready(function(){
			<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_30}">
			//App이고 펫스쿨 상세 진입시 영상상세의 PIP를 닫아야함
			toNativeData.func = "onClosePIP";			
			toNative(toNativeData);
			</c:if>
			
			<c:if test="${view.twcUserAgent eq true }">
			toNativeData.func = "onTitleBarHidden";			
			toNativeData.hidden = "Y";
			toNative(toNativeData);
			</c:if>
			
			$("head").append("<style>body, html, .wrap{height:100%;}</style>");
			
			<c:if test="${empty eduConts or (!empty eduConts and eduConts.dispYn eq 'N' )}" >	
			$("body").html("");
			ui.alert("재생할 수 없는 영상입니다.<br>펫스쿨 메인으로 이동합니다.",{ // 알럿 옵션들
			    tit:"ERROR",
			    ycb:function(){
			    	location.href="/tv/petSchool";
			    	//storageHist.goBack("/tv/petSchool");
			    },
			    ybt:"확인" // 기본값 "확인"
			});
			</c:if>
			
			/* 앱 화면 상,하단 색상 변경. 펫스쿨에서만 black */
			<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_30 and view.os eq frontConstants.DEVICE_TYPE_20}">				
				toNativeData.color = "black";	
				toNativeData.func = "onColorChange";				
				toNative(toNativeData);						
			</c:if>
			
			<c:set var ="slideSpeed" value = "1" />/* 슬라이드전환속도 */
			<c:if test="${view.deviceGb ne 'PC' }">
				<c:set var ="slideSpeed" value = "500" />			
			</c:if>			
			//시청이력 저장
			saveEduHistory(0);
			//자동재생제어
			fncAutoFlag();
			//조회수 저장
			regHitCnt();
			 //클릭 이벤트-시청
			userActionLog("${eduConts.vdId}", "watch");
			
			$(".swiper-pagination span").last().css("display","none");
			$(".swiper-pagination").show();
			
			$(document).click(function (e) {
				if(!$(e.target).closest(".prd-layer .cont").length ) {
					$('.prd-layer').slideUp('300');
					e.stopPropagation();
				}
			});
			
			/* 04.08 : 추가 */
			$(".page.tv .prd-layer .top .inner").click(function(e){
				e.stopPropagation();
			});
			/* 04.08 : 추가 */
			
			if("${view.deviceGb ne frontConstants.DEVICE_GB_10}" == "true"){
				//연관상품 바텀시트 오픈 후 화면이동이면 연관상품 바텀시트 오픈시킴
				var queryString = "${requestScope['javax.servlet.forward.query_string']}";
				var newQueryString = queryString.substring(0, queryString.indexOf("&goodsVal"));
				
				var goodsVal = "${goodsVal}";
				if(goodsVal.indexOf("goods") !== -1){
					var replaceUrl = "/tv/school/indexTvDetail?"+newQueryString;
					history.replaceState("", "", replaceUrl);
					storageHist.replaceHist(replaceUrl);
					
					var goodsParam = goodsVal.split("-");
					if(goodsParam.length > 1){
						getRelatedGoodsWithTv($("#videoTing"), '<c:out value="${eduConts.vdId}" />', "N|"+goodsParam[1]);
					}else{
						getRelatedGoodsWithTv($("#videoTing"), '<c:out value="${eduConts.vdId}" />', "N");
					}
				}else if(goodsVal.indexOf("cart") !== -1){
					var replaceUrl = "/tv/school/indexTvDetail?"+newQueryString;
					history.replaceState("", "", replaceUrl);
					storageHist.replaceHist(replaceUrl);
					
					getRelatedGoodsWithTv($("#videoTing"), '<c:out value="${eduConts.vdId}" />', "Y");
				}
			}
		});
		
		var myLastStep = <c:out value="${empty histVo.stepNo?'0':histVo.stepNo}" />;//시청이력이 있는경우 저장된 마지막 스텝
		var myLastStepTime = <c:out value="${empty histVo.vdLnth?'0':histVo.vdLnth}" />;//시청이력이 있는경우 마지막 영상의 길이
		var outVdIdArr = new Array();//외부비디오ID ARR		
		var nowStepIdx = 0;
		<c:set var ="deviceGb" value = "${view.deviceGb eq 'PC'?'pc':'mobile' }" />/* 디바이스구분 */
		<c:set var ="lastStep" value = "0" />/* 본 교육의 마지막 스텝 */
		<c:set var ="nowStep" value = "${histVo.stepNo}" />/* 페이지 진입시 시청이력이 있을경우 스텝 세팅 */		
		<c:choose>
	        <c:when test="${eduConts.eudContsCtgLCd ne '20' and !empty eduConts.detailList}">/* 교육 */
				<c:forEach items="${eduConts.detailList}" var="detail"  varStatus="idx">
					<c:if test="${detail.stepNo eq histVo.stepNo}">					
					nowStepIdx = ${idx.index};	
					<c:set var ="nowStep" value = "${idx.index}" />
					</c:if>					
					<c:if test="${idx.last}"><c:set var ="lastStep" value =  "${detail.stepNo}" /></c:if>					
					outVdIdArr.push("${ detail.outsideVdId}");
				</c:forEach>
			</c:when>
			<c:when test="${eduConts.eudContsCtgLCd eq '20' and !empty eduConts.fileList}">/* 인트로 */
				<c:forEach items="${eduConts.fileList}" var="vod" varStatus="idx" >
					<c:if test="${vod.contsTpCd eq '60'}">							
					outVdIdArr.push("${vod.outsideVdId}");					
					</c:if>
					
				</c:forEach>	
			</c:when>
		</c:choose>
		
		// 외부영역 클릭 시 팝업 닫기
		$(document).mouseup(function (e){
			var LayerPopup = $(".popup-layer");
			var prdLayerPopup = $(".prd-layer");
			  
			if(prdLayerPopup.has(e.target).length === 0){ // 연관상품 팝업이 아닐때
				if(LayerPopup.has(e.target).length === 0){
					$(".btnPopClose").click();
				}  
			}
		});
		
		</script>	
				
	</tiles:putAttribute>
	
	<tiles:putAttribute name="content"> 
		<!-- content 내용 부분입니다.	-->	
		<!-- 필요에 따라 로케이션 추가 : jsp:include page="/WEB-INF/tiles/b2c/include/location.jsp" -->
		<!-- 바디 - 여기위로 템플릿 -->
		<form id="petTvDetailForm" > 
			<input type="hidden" id="vdId" 			 name="vdId" 		   value="<c:out value="${eduConts.vdId}" />" />
			<input type="hidden" id="petGbCd" 		 name="petGbCd" 	   value="<c:out value="${eduConts.petGbCd}" />" />
			<input type="hidden" id="eudContsCtgLCd" name="eudContsCtgLCd" value="<c:out value="${eduConts.eudContsCtgLCd}" />" />
			<input type="hidden" id="eudContsCtgMCd" name="eudContsCtgMCd" value="<c:out value="${eduConts.eudContsCtgMCd}" />" />
			<input type="hidden" id="eudContsCtgSCd" name="eudContsCtgSCd" value="<c:out value="${eduConts.eudContsCtgSCd}" />" />			
		</form>
		<main class="container page tv schoolDetail" id="container">
			<div class="inr">			

				<!-- 본문 -->
				<div class="contents" id="contents">
                    <div class="inner-wrap">

                        <div class="pageHead black">
							<div class="inr">
								<div class="hdt">
									<button class="back" type="button" onclick="pageBack();" data-content="${eduConts.vdId}" data-url="/tv/petSchool?vdId=${eduConts.vdId}">뒤로가기</button>
								</div>
								<div class="cent"><h2 class="subtit">${eduConts.ttl }</h2></div>
							</div>
                        </div>
                        
                        <div class="pc-subtit"><h2>${eduConts.ttl }</h2></div>

                        <div class="schoolD-wrap">

                            <div class="swiper-div">
                                <div class="swiper-container full">
                                    <ul class="swiper-wrapper">   
                                    	<c:choose>
									        <c:when test="${eduConts.eudContsCtgLCd ne '20' and !empty eduConts.detailList}"><!-- 교육 --> 
												<c:forEach items="${eduConts.detailList}" var="detail"  varStatus="idx">
													<li class="swiper-slide">
			                                            <div class="div-wrap <c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10}">videoAndListWrap</c:if>">
			                                                <!-- video-area -->
			                                                <div class="video-area">
			                                                    <div class="video-palyer">
			                                                        <div id="player<c:out value='${idx.index }' />" class = "video" style="background-color:#000;"></div>
			                                                    </div>
			                                                </div>
			                                                <!-- //video-area -->
			                        
			                                                <!-- info-zone -->
			                                                <div class="info-zone" <c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10}">style="background-color:#000;"</c:if>>
			                                                    <div class="info">			                                                        
			                                                        <div class="top">
			                                                            <c:choose>			                                                            	
			                                                            	<c:when test= "${detail.stepNo eq 0 }" >
			                                                            		<div class="tit">교육 소개</div>
			                                                            	</c:when>
			                                                            	<c:otherwise>
			                                                            		<div class="tit">Step${detail.stepNo}. ${detail.ttl }</div>
			                                                            	</c:otherwise>
			                                                            </c:choose>
			                                                            <c:if test="${idx.index eq 0 }">
			                                                            <div class="type" style="display:block"><!-- type 유/무  -->
			                                                                <ul> 
			                                                                    <li>
			                                                                        <strong>난이도</strong>
			                                                                        <span class="level lv<c:out value="${fn:substring(eduConts.lodCd,0,1)}" />"><!-- 난이도별 class lv1, lv2, lv3 -->
			                                                                            <span>난이도1</span>
			                                                                            <span>난이도2</span>
			                                                                            <span>난이도3</span>
			                                                                        </span>
			                                                                    </li>
			                                                                    <li>
			                                                                        <strong>준비물</strong>
			                                                                        <div class="material">
								                                                        <c:set var="prpmCd" value="${fn:split(eduConts.prpmCd,',')}" />
									                                                    <c:forEach var="prpm" items="${prpmCd}" varStatus="g">
																						     <span><c:if test="${g.count > 1}">, </c:if><frame:codeValue items="${prpmCdList}" dtlCd="${prpm}"  /></span>
																						</c:forEach>
								                                                    </div>
			                                                                    </li>
			                                                                </ul>
			                                                            </div>
			                                                            </c:if>			                                                            
			                                                        </div>			                                                        
			                                                        <div class="cont" >                                                        	
			                                                        	<c:choose>			                                                            	
			                                                            	<c:when test= "${detail.stepNo eq 0 }" >
			                                                            		<p style="white-space: pre-line;"><c:out escapeXml = "false" value = "${eduConts.content}" /></p> 
			                                                            	</c:when>
			                                                            	<c:otherwise>
			                                                            		<p style="white-space: pre-line;"><c:out escapeXml = "false" value = "${detail.dscrt}" /></p> 
			                                                            	</c:otherwise>
			                                                            </c:choose>                                                            
			                                                        </div>
			                                                    </div>
			                                                    <!-- //info-zone -->
			
			                                                    <ul class="tip" <c:if test= "${eduConts.eudContsCtgLCd eq '20' }" >style = "display:none" </c:if>>
			                                                        <li>
			                                                            <a href="javascript:;" onClick="popLayer01();" class="txt-btn" data-content="layerAlert" data-url="popLayer01();">
			                                                                <div class="round-img-pf pet"></div>
			                                                                <h2>언제 교육이 필요할까요?</h2>
			                                                            </a>
			                                                        </li>
			                                                        <li class="btn-rnd">
			                                                            <button type="button" onclick="popLayer02();" data-content="layerAlert" data-url="popLayer02();">Tip!</button>
			                                                            <button type="button" onclick="popLayer03();" data-content="layerAlert" data-url="popLayer03();">Q&A</button>
			                                                        </li>
			                                                    </ul>
			
			                                                    <!-- 이하 레이어3개는 첫번째 li에만 있음 -->
			                                                    <!-- 교육 popLayer -->
			                                                    <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 or idx.index eq 0 }" >
			                                                    <c:set var="popIdx" value="${view.deviceGb eq frontConstants.DEVICE_GB_10?idx.index:'' }" />			                                                    
			                                                    <article class="popup-layer typeA <c:out value="${view.deviceGb eq frontConstants.DEVICE_GB_10?'noLock':'' }" />" id="popLayer01<c:out value='${popIdx }' />" style = "display:none;">
			                                                        <div class="popup-wrap">
			                                                            <div class="top">
			                                                                <h2 class="tit">언제 교육이 필요할까요?</h2>
			                                                                <button type="button" class="btnPopClose" data-content="layerAlert" data-url=""><span>닫기</span></button>
			                                                            </div>
			                                                            <div class="content">
			                                                                <main>			                                                                
			                                                                <c:forEach items="${eduConts.fileList}" var="file" varStatus="idx" >
			                                                                	<c:if test="${file.contsTpCd eq '30' }" >
			                                                                		<img src="${frame:imagePath(file.phyPath) }" alt="이미지명" />
			                                                                	</c:if>
			                                                                </c:forEach>			                                                                    
			                                                                </main>
			                                                            </div>
			                                                        </div>
			                                                    </article>
			                                                    <!-- //교육 popLayer -->
			
			                                                    <!-- 팁 popLayer -->
			                                                    <article class="popup-layer typeB <c:out value="${view.deviceGb eq frontConstants.DEVICE_GB_10?'noLock':'k0427' }" />" id="popLayer02<c:out value='${popIdx }' />" style="height:50%;display:none;">
			                                                        <div class="popup-wrap">
			                                                            <div class="top">
			                                                                <h2 class="tit">교육 Tip!</h2>
			                                                                <button type="button" class="btnPopClose" data-content="layerAlert" data-url=""><span>닫기</span></button>
			                                                            </div>
			                                                            <div class="content">
			                                                                <main>
			                                                                    <ul class="tip-list">
			                                                                       <c:forEach items="${eduConts.cnstrList}" var="tip" varStatus="idx" >
																						<c:if test="${tip.cstrtGbCd eq '10'}">														
																							<li style="white-space: pre-line;">
																								<c:out escapeXml = "false" value = "${tip.content }"></c:out>
																							</li>															
																						</c:if>
																					</c:forEach>
			                                                                    </ul>
			                                                                </main>
			                                                            </div>
			                                                        </div>
			                                                    </article>
			                                                    <!-- //팁 popLayer -->
			
			                                                    <!-- QnA popLayer -->
			                                                    <article class="popup-layer typeB <c:out value="${view.deviceGb eq frontConstants.DEVICE_GB_10?'noLock':'k0427' }" />" id="popLayer03<c:out value='${popIdx }' />" style="height:50%;display:none;">
			                                                        <div class="popup-wrap">
			                                                            <div class="top">
			                                                                <h2 class="tit">교육 Q&A</h2>
			                                                                <button type="button" class="btnPopClose" data-content="layerAlert" data-url=""><span>닫기</span></button>
			                                                            </div>
			                                                            <div class="content">
			                                                                <main>
			                                                                    <ul class="uiAccd qna-list" data-accd="accd">
			                                                                    <c:set var="qnaCnt" value="0"/>
			                                                                    <c:forEach items="${eduConts.cnstrList}" var="qna" varStatus="idx">
			                                                                    	<c:if test="${qna.cstrtGbCd eq '20'}">
			                                                                        <li <c:if test="${qnaCnt eq 0}">class="open"</c:if>>
			                                                                            <div class="hBox">
			                                                                                <span class="tit" style = "width:80%;">${qna.ttl}</span> 
			                                                                                <button type="button" class="btnTog" data-content="layerAlert" data-url=""><span>버튼</span></button>
			                                                                            </div>
			                                                                            <div class="cBox">
			                                                                                <p style="white-space: pre-line;">${qna.content}</p>
			                                                                            </div>
			                                                                        </li>
			                                                                        <c:set var="qnaCnt" value="${qnaCnt+1}"/>
			                                                                        </c:if>
			                                                                    </c:forEach>
			                                                                    </ul>
			                                                                </main>
			                                                            </div>
			                                                        </div>
			                                                    </article>
			                                                    <!-- //QnA popLayer -->
			                                                    </c:if>
			
			                                                </div>
			                                                <!-- //info-zone -->
			                                            </div>
			                                        </li>  
												</c:forEach>
													<li class="swiper-slide">
													</li>
											</c:when>
											<c:when test="${eduConts.eudContsCtgLCd eq '20' and !empty eduConts.fileList}"><!-- 인트로 -->
												<c:forEach items="${eduConts.fileList}" var="detail" varStatus="idx" >
													<c:if test="${detail.contsTpCd eq '60'}">
													<li class="swiper-slide">
			                                            <div class="div-wrap <c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10}">videoAndListWrap</c:if>">
			                                                <!-- video-area -->
			                                                <div class="video-area">
			                                                    <div class="video-palyer">
			                                                        <div id="player0" class = "video" style="background-color:#000;"></div>
			                                                    </div>
			                                                </div>
			                                                <!-- //video-area -->			                        
			                                                <!-- info-zone -->
			                                                <div class="info-zone">
			                                                    <div class="info">
			                                                        <div class="top">
			                                                            <div class="tit">펫스쿨 소개 영상</div>
			                                                        </div>
			                                                        <div class="cont" style="white-space: pre-line;">                                                        	
			                                                        	교육이 필요한이유에 대한 설명입니다.			                                                        	                                                   
			                                                        </div>
			                                                    </div>
			                                                    <!-- //info-zone -->
			                                                </div>
			                                                <!-- //info-zone -->
			                                            </div>
			                                        </li>
													</c:if>
												</c:forEach>	
											</c:when>
										</c:choose>
                                    	                                 	
                                       
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!-- //schoolD-wrap -->
                        
                        <c:if test="${eduConts.eudContsCtgLCd ne '20'}">
	                        <div class="paging-wrap">
	                        	<c:set var ="pre" value = "이전" />
	                        	<c:set var ="next" value = "다음" />
	                        	<c:set var ="nextCss" value = "btn-next" />
	                        	<c:choose>
							        <c:when test="${histVo.stepNo eq 0 }">
							        	<c:set var ="pre" value = "교육 시작하기" />
										<c:set var ="next" value = "교육 시작하기" />
										<c:set var ="nextCss" value = "btn-blue" />
									</c:when>
									<%-- <c:when test="${histVo.stepNo eq 1 and histVo.stepNo eq lastStep}">
										<c:set var ="pre" value = "처음화면" />
										<c:set var ="next" value = "교육종료" />
									</c:when>
									<c:when test="${histVo.stepNo eq 1 and histVo.stepNo ne lastStep}">
										<c:set var ="pre" value = "처음화면" />
										<c:set var ="next" value = "다음" />
									</c:when>
									<c:when test="${histVo.stepNo ne 1 and histVo.stepNo eq lastStep}">
										<c:set var ="pre" value = "이전" />
										<c:set var ="next" value = "교육종료" />
									</c:when> --%>
								</c:choose>
								
								<button type="button" class="btn-prev" id="btnPrev" data-content="${eduConts.vdId}" data-url="prevVideo();" onclick="prevVideo();" <c:if test="${histVo.stepNo eq 0 }" >style="visibility:hidden"</c:if> ><c:out value="${pre}" /></button>							
								<div class="swiper-pagination" style="display:none"></div>
	                            <button type="button" class="${nextCss }" id="btnNext" data-content="${eduConts.vdId}" data-url="nextVideo();" onclick="nextVideo();"><c:out value="${next}" /></button>							
	                        </div>
                        </c:if>
                    </div><!-- //inner-wrap -->
                </div><!-- //contents -->
            </div><!-- //inr -->

             <!-- 하단바 -->
             <div class="bottom-bar">
                <div class="inner">
                    <ul class="bar-btn-area">
                        <li>
                            <button class="btn-like<c:if test="${interestVo.likeCnt gt 0 }" > on</c:if>" onClick="regLike(this);" data-content="${eduConts.vdId}" data-url="regLike(this);"><c:out value="${eduConts.likeCnt}" /></button>
                        </li>
                    	
                    	<li>
                        	<c:choose>
								<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_30 }">
									<button class="btn-share"  id="share" title="COPY URL" onclick="regShareApp();" data-content="${eduConts.vdId}" data-url="regShareApp();"><span>공유</span></button>
								</c:when>
								<c:otherwise>
									<c:set var="nowUrl" value="${view.stDomain}/tv/school/indexTvDetail?vdId=${eduConts.vdId}" />
                        			<button class="btn-share"  data-message="링크가 복사되었어요" id="share" title="COPY URL" data-clipboard-text="${shareUrl }" onclick="regShare(this.id);" data-content="${eduConts.vdId}" data-url="regShare(this.id);"><span>공유</span></button>
								</c:otherwise>
							</c:choose>
                        </li>
                    	    
                        <li>                            
                            <button id="video_mark" class="btn-bookmark<c:if test="${interestVo.zzimCnt gt 0 }" > on</c:if>" onclick="fncBookToast(this);" data-content="${eduConts.vdId}" data-url="fncBookToast(this);"><span>찜</span></button>
                        </li>
                    	 
                    </ul>
                    <!-- <buttron class="tvConnectedTing">연관상품</buttron> -->                    
                    <!-- 2021.02.23 HTML 변경 -->
                    <c:if test="${relatedGoodsCount > 0}">
                    <buttron class="tvConnectedTing">연관상품</buttron>
                    <div class="btn-with-wrap">
                        <!-- <button class="btn-with-prd" data-content="layerAlert" data-url="" onClick="ui.commentBox.open('.relation-pop');"> --><!-- 2021.02.04 : onClick이벤트 추가 -->
                        <button id="videoTing" class="btn-with-prd" data-content="${eduConts.vdId}" data-url="getRelatedGoodsWithTv(this, '${eduConts.vdId}', 'N')">    
                        	<c:set var="gImg" value="${frame:optImagePath(goodsImg.imgPath,frontConstants.IMG_OPT_QRY_500)}" />
							<c:if test="${fn:indexOf(goodsImg.imgPath, 'cdn.ntruss.com') > -1 }" >
								<c:set var="gImg" value="${goodsImg.imgPath}" />      
							</c:if>              
                            <strong style="background-image:url(<c:out value='${gImg }' />);"></strong>
                        </button>
                        <span class="num"><c:out value="${relatedGoodsCount}" /></span>
                    </div>
                    </c:if>
                    <!-- // 2021.02.23 HTML 변경 -->
                </div>
            </div>
            <!-- //하단바 -->  
            
        </main>
        <!-- 20210126 변경 시작 -->
        
        <%--pc에서 상담톡 안보이도록 처리-2021.04.30
        <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
        	<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
	        	<jsp:param name="floating" value="talk" />
	        </jsp:include>
        </c:if>
        --%>
        <script>
            var swiperFit = null;
            swiperFit = new Swiper('.schoolD-wrap .swiper-container', {
                slidesPerView: 1,
                initialSlide: <c:out value="${nowStep}" />,
               	<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 or eduConts.eudContsCtgLCd eq '20'}">
                simulateTouch:false,
                watchOverflow:true,
                </c:if>
               	<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10}">
//               	autoHeight: true,/* 04.07 : 추가 */
               	</c:if>               	
                pagination: {
                    el: '.swiper-pagination',
                },
            });
            
            swiperFit.on('slideNextTransitionStart', function() {            	
            	if(nowStepIdx == <c:out value="${lastStep}" /> ){//교육종료            			
            		eduComplete();
    			}else{
    				nextStepSwipe();
    			}            	
            });            	
            	
            swiperFit.on('slidePrevTransitionStart', function() {preStepSwipe();});
            /* swiperFit.on('transitionStart', function() {            	
            	if(this.swipeDirection == "next" && nowStepIdx == <c:out value="${lastStep}" /> && !execEvent && this.previousIndex != <c:out value="${lastStep}" />){//교육종료
            		eduComplete();
    			}
    			execEvent = false;    			
           	});      
            //마지막 슬라이드에서 기기 회전시 transitionStart 이벤트가 실행되어 아래 코드 추가함.	
           	swiperFit.on('orientationchange', function() {           		
           		execEvent = true;
           	});	 */           	
            
            <c:choose>
            	<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
					setHeight();
		            $(window).resize(function(){
		                setHeight();
		            });
		            function setHeight(){
		            	var videoHeight = $(".video-area").outerHeight();
		                $(".info-zone").css("height", videoHeight);
		            };    
				</c:when>
				<c:otherwise>
					/* 04.12 */
		            $(window).resize(function(){
		                setTimeout(function(){
		                    swiperFit.update();
		                },500);
		            });
		            /* 04.12 */
					checkLayout();
		            function checkLayout(){
		                var w = window.innerWidth;
		                if(w <= 1023){
		                    /* mobile */
		                    $("body").append($("#popLayer01"));
		                    $("body").append($("#popLayer02"));
		                    $("body").append($("#popLayer03"));
		                    $("#popLayer01").addClass("popFixed")
		                }else{
		                    /* pc */
		                    $(".info-zone").append($("#popLayer01"));
		                    $(".info-zone").append($("#popLayer02"));
		                    $(".info-zone").append($("#popLayer03"));
		                    $("#popLayer01").removeClass("popFixed")
		                };
		            };
				</c:otherwise>
			</c:choose>

            // 교육 레이어팝업
            var popLayer01 = function(){
            	var id = "popLayer01";
            	<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }" >
            		id += swiperFit.realIndex;
            	</c:if>            	
            	
                ui.popLayer.open(id,{
                    ocb:function(){
                    },
                    ccb:function(){                        
                    }
                });
            }

            // 팁 레이어팝업
            var popLayer02 = function(){
            	var id = "popLayer02";
            	<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }" >
            		id += swiperFit.realIndex;
            	</c:if>
            	
                ui.popLayer.open(id,{
                    ocb:function(){           
                
                    },
                    ccb:function(){        
                    	
                    }
                });
            }

            // Q&A 레이어팝업
            var popLayer03 = function(){
            	var id = "popLayer03";
            	<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }" >
            		id += swiperFit.realIndex;
            	</c:if>
            	
                ui.popLayer.open(id,{
                    ocb:function(){                        
                    },
                    ccb:function(){                        
                    }
                });
            }

            $(".btnPopClose").click(function(){
                $(this).parents(".popup-layer").hide();
            })
             
            $(".popup-layer .btnPopClose").click(function(){
                $("html").removeClass("lock");
            });
            
            /* 플레이어 관련 스크립트 */
            var startTime = <c:out value = '${empty histVo.vdLnth?0:histVo.vdLnth}' />;/* 시청이력이 있을경우 시작시간 세팅 */		
			var player;
		
			<!-- 플레이어 생성 함수 (자동실행) -->
			function onIframeAPIReady() {
				//과금 여부 확인 후 플레이어 세팅
				//fncLtePlay();
			    playSet(outVdIdArr[nowStepIdx]);
			    // === 퍼블 테스트
	            sss();
	            $(window).resize(function(){
	                sss();
	            })
	            function sss(){
	                var horizontal = window.matchMedia('(orientation: landscape)').matches;
	                var h2 = $(window).innerHeight() - ($(".video-palyer").innerWidth() + 158);
	                if(horizontal){
	                    $(".info-zone").css("height","");
	                       $("body, html, #wrap.wrap").css("height","auto");
	                }else{
	                    $(".info-zone").height(h2);
	                }
	            }
			    // === 퍼블 테스트
			}	
			
			function fncLtePlay(){
				if("${view.deviceGb ne frontConstants.DEVICE_GB_10}" == "true"){
					var cookieData = document.cookie;					
					if(cookieData.indexOf("popMwPlay=done") < 0){
						ui.confirm("3G/LTE 등으로 영상재생시<br>데이터 사용료가 발생할 수 있습니다.",{ // 컨펌 창 띄우기
							ycb:function(){
								autoFlag = true;
								playSet(outVdIdArr[nowStepIdx]);								
								setPlayerCookie("popMwPlay", "done" , 24 );
							},
							ncb:function(){
								autoFlag = false;
								playSet(outVdIdArr[nowStepIdx]);								
								setPlayerCookie("popMwPlay", "done" , 24 );
							},
							ybt:'재생',
							nbt:'취소'	
						});
					}else{
						playSet(outVdIdArr[nowStepIdx]);
					}
				}else{					
					playSet(outVdIdArr[nowStepIdx]);				
				}
			}
			
			function onPlaying(){}
			function onPause(){}
			function onEnded(){}
			function onMuted(state){
			    if(state==true) {
				    console.log('onMuted', '음소거됨');
			    }else{
				    console.log('onMuted', '음소거해제');
			    }
			}
			function onActiveControlbar(state){
			    if(state==true) {			    
			    }else{			    
			    }
			}
			//시청보고 5초마다 / 현재시간 : sec
			function onKeepPlaying(sec){
				saveEduHistory(sec);
			}	
			
			function playSet(id){	
				player = SGRPLAYER;	
				player.setup("player"+nowStepIdx, {
					height: '100%',
					width: '100%',
					video_id: id,
					vtype:'mp4',
					loop:1,
					ui:"<c:out value='${deviceGb}' />", //UI 분기를 위하여 추가
					autoplay:autoFlag, //자동재생
					start_time:startTime, // 5초부터 시작
					is_ad:false, // 프리롤 광고 여부
					uploader_id:'${eduConts.sysRegrNo}', //업로드한 유저 아이디
					viewer_id:'${session.mbrNo}', //시청하는 유저 아이디
					controlBar: {
						volumePanel:true,  //볼륨컨트롤
						playToggle: true, //플레이 버튼
						progressControl:false, //프로그래시바
						fullscreenToggle: false, //플스크린버튼
						playbackRateMenuButton: false, //재생속도 버튼
						pictureInPictureToggle:false,  // PIP 버튼
						timeDisplay:false, //영상 시간 표시
					},
					events:{
						playing:onPlaying, //재생시작시 호출
						pause:onPause, // 일시정지시 호출
						ended:onEnded, //재생 종료시 호출
						muted:onMuted, //음소거 변화가 발생하면 호출 , 현재 상태값 전달
						keepPlaying:onKeepPlaying, //영상 재생시 , 현재 재생위치 5초마다 보고
						//nextVideo:onNextVideo, //다음영상 UI 클릭시 실행 , 이벤트를 등록해야만 UI 노출됨
						//prevVideo:onPrevVideo,  //이전영상 UI 클릭시 실행 , 이벤트를 등록해야만 UI 노출됨
						activeControlbar:onActiveControlbar, //컨트롤바가 활성/비활성시 호출
					}
			    });
				<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10}">
				//swiperFit.updateAutoHeight(1);
               	</c:if> 
			}
			
			function setPlayerCookie( name, value, expirehours ) {
				var todayDate = new Date();
				todayDate.setHours( todayDate.getHours() + expirehours );
				document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
			}
			
			/* 모바일 swipe next*/
			function nextStepSwipe(){			
				cleanPlayer();
				$(".btnPopClose").click();
				playSet(outVdIdArr[++nowStepIdx]);
				btnControl(nowStepIdx);			
				saveEduHistory(0);
			}
			/* 모바일 swipe prev*/
			function preStepSwipe(){			
				cleanPlayer();
				$(".btnPopClose").click();
				playSet(outVdIdArr[--nowStepIdx]);
				btnControl(nowStepIdx);
				saveEduHistory(0);
			}
			/* 다음단계버튼 */
			function nextVideo(){
				if(nowStepIdx == <c:out value="${lastStep}" />){//교육종료							
					eduComplete();
				}else{
					swiperFit.slideNext(<c:out value="${slideSpeed}"/>, function(){nextStepSwipe()});				
				}
			}
			/* 이전단계버튼 */
			function prevVideo(){		
				swiperFit.slidePrev(<c:out value="${slideSpeed}"/>, function(){preStepSwipe()});
			}
			
			/* 이동버튼 제어 */
			function btnControl(step){
				if(step == 0){//처음화면
					$("#btnPrev").html("교육 시작하기");
					$("#btnPrev").css("visibility","hidden");
					$("#btnNext").html("교육 시작하기");
					$("#btnNext").attr("class","btn-blue");
				}else{
					$("#btnNext").html("다음");
					$("#btnPrev").css("visibility","visible");
					$("#btnPrev").html("이전");
					$("#btnNext").attr("class","btn-next");
				}
			}
			/* 플레이어 리셋 */
			function cleanPlayer(){
				$("[id^='player']").empty();
				fncAutoFlag();
			}		
				
			/* 모바일 상단 뒤로가기 버튼 */
			function pageBack(){								
				/* if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true"){
					toNativeData.func = "onClose";					
					toNative(toNativeData);
				}else{
					history.go(-1);
				} */
				
				<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_30 and view.os eq frontConstants.DEVICE_TYPE_20}">				
					toNativeData.func = "onColorChange";				
					toNativeData.color = "white";	
					toNative(toNativeData);						
				</c:if>
				
				<c:if test="${view.twcUserAgent eq true }">			
				toNativeData.func = "onClose";					
				toNative(toNativeData);
				</c:if>
				
				<c:if test="${view.twcUserAgent eq false }">
				/*//로컬에서는 document.referrer 없음..
				if("<spring:eval expression="@bizConfig['envmt.gb']" />" == "local"){
					if("${linkYn}" == "Y"){
						location.href = "/tv/petSchool";
					}else{
						history.go(-1 + (histCnt*-1));
					}
				}else{
					// 히스토리가 있으면
					if ( document.referrer && document.referrer.indexOf("aboutpet") != -1 ) { 
						if("${linkYn}" == "Y"){
							location.href = "/tv/petSchool";
						}else{
							history.go(-1 + (histCnt*-1));
						}
					}else {// 히스토리가 없으면, 
						if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true"){//앱에서는 document.referrer 없음..
							if("${linkYn}" == "Y"){
								location.href = "/tv/petSchool";
							}else{
								history.go(-1 + (histCnt*-1));
							}
						}else{
							location.href = "/tv/petSchool";
						}
						
					}
				}*/
				
				if("${linkYn}" == "Y"){
					location.href = "/tv/petSchool";
					//storageHist.goBack("/tv/petSchool");
				}else{
					//storageHist.goBack();
					storageHist.getOut("${requestScope['javax.servlet.forward.servlet_path']}", true);
				}
				</c:if>
			}
			
			/* 시청이력저장 */
			function saveEduHistory(time){				
				time = Math.floor(time);
				var mbrNo = "${session.mbrNo}";
				var nowStep = nowStepIdx;//현재 시청중인 교육 스텝
				var nowTime = time;//현재 시청 시간
				
				if (mbrNo != '0') {
					petTvViewHist('<c:out value="${eduConts.vdId}" />', mbrNo,time, nowStep, "N");			    
				}
			}
			
			//교육종료
			function eduComplete(){
				player.pause();
				waiting.start();
				location.href = "/tv/school/indexTvComplete?vdId=<c:out value="${eduConts.vdId}" />&histCnt="+histCnt+"&linkYn=${linkYn}";
				//storageHist.goBack("/tv/school/indexTvComplete?vdId=<c:out value="${eduConts.vdId}" />&histCnt="+histCnt+"&linkYn=${linkYn}");
			}
			
			//좋아요
			function regLike(obj){
				var clickOn = $(obj).hasClass("on"); 
				var mbrNo = "${session.mbrNo}";
				if (mbrNo != '0') {
					petTvLikeDibs(obj, '<c:out value="${eduConts.vdId}" />', mbrNo, "10"); //10:좋아요, 20:찜				
					/*//클릭 이벤트-시청					
					if(!clickOn){						
						userActionLog('<c:out value="${eduConts.vdId}" />', "like");
					}else{						
						userActionLog('<c:out value="${eduConts.vdId}" />', "like_d");
					}*/
				}else{
					//var url = "returnUrl=${requestScope['javax.servlet.forward.request_uri']}?vdId=<c:out value="${eduConts.vdId}" />";
					var url = "returnUrl=${requestScope['javax.servlet.forward.request_uri']}"+ encodeURIComponent("?vdId=<c:out value="${eduConts.vdId}" />&histLoginCnt=2&histCnt=${histCnt}&linkYn=${linkYn}");
					if ("${session.mbrNo}" == '0'){		
						url = "/indexLogin?"+url;
						showConfirm("로그인 후 서비스를 이용할 수 있어요.\n로그인 할까요?", url);				
						return false;
					}
				}
			}
			
			function showConfirm(msg, url, loginCheck){		
				var ybtText = loginCheck != null ? "로그인" : "확인"
				ui.confirm(msg,{ // 컨펌 창 옵션들
				    tit:"",
				    ycb:function(){			    	
				    	location.href = url;
				    	//storageHist.goBack(url);
				    },
				    ncb:function(){			        
				    },
				    ybt:ybtText,
				    nbt:'취소'
				});
			}
			
			//찜 토스트창 띄우기
			function fncBookToast(obj){
				var clickOn = $(obj).hasClass("on"); 
				var mbrNo = "${session.mbrNo}";
				if (mbrNo != '0') {
					petTvLikeDibs(obj, '<c:out value="${eduConts.vdId}" />', mbrNo, "20"); //10:좋아요, 20:찜		
					/*//클릭 이벤트-시청					
					if(!clickOn){						
						userActionLog('<c:out value="${eduConts.vdId}" />', "interest");
					}else{						
						userActionLog('<c:out value="${eduConts.vdId}" />', "interest_d");
					}*/
				}else{
					//var url = "returnUrl=${requestScope['javax.servlet.forward.request_uri']}?vdId=<c:out value="${eduConts.vdId}" />";
					var url = "returnUrl=${requestScope['javax.servlet.forward.request_uri']}"+ encodeURIComponent("?vdId=<c:out value="${eduConts.vdId}" />&histLoginCnt=2&histCnt=${histCnt}&linkYn=${linkYn}");
					if ("${session.mbrNo}" == '0'){		
						url = "/indexLogin?"+url;
						showConfirm("로그인 후 서비스를 이용할 수 있어요.\n로그인 할까요?", url);				
						return false;
					}
				}			
			}
			
			//공유하기 등록
			function regShare(objId){
				petTvShare(objId, '<c:out value="${eduConts.vdId}" />', '30');
				/*//클릭 이벤트-시청
				userActionLog("${eduConts.vdId}", "share");*/
			}
			
			//공유하기 APP
			function regShareApp(){		
				petTvShare("null", '<c:out value="${eduConts.vdId}" />', '30');
				/*//클릭 이벤트-시청
				userActionLog("${eduConts.vdId}", "share");*/
				
				var ttl = "${eduConts.ttl}";
				ttl = ttl.replace(/amp;/gi, "");
				toNativeData.func = "onShare";
				toNativeData.image = "";//shareThumImgBase64;
				toNativeData.subject = ttl;
				toNativeData.link = "${shareUrl }";
				toNative(toNativeData);
				
			}

			//자동재생여부
			function fncAutoFlag(){
				if("${view.deviceGb eq frontConstants.DEVICE_GB_10}" == "true"){ //PC					
					autoFlag = true;			
				}else if("${view.deviceGb eq frontConstants.DEVICE_GB_20}" == "true"){ //MO					
					autoFlag = false;			
				}else if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true"){ //APP					
					//자동재생여부 판단
					// 데이터 세팅
					toNativeData.func = "onIsAutoPlay";
					toNativeData.callback = "appIsAutoPlay";
					// APP 호출
					toNative(toNativeData);
				}
			}
			
			//App 자동재생여부값
			function appIsAutoPlay(jsonString){
				var parseData = JSON.parse(jsonString);
				var autoPlay = parseData.isAutoPlay;			
				if(autoPlay == "Y"){
					autoFlag = true;
				}else{
					autoFlag = false;
				}				
			}
			
			//조회수 저장
			function regHitCnt(){
				var options = {
			        url : "<spring:url value='/tv/school/saveContsHit' />",
			        data : {
			            vdId : '<c:out value="${eduConts.vdId}" />' //영상ID			         			            
			        },
			        async : false,
			        done : function(data){			       
			           
			        }
			    };			   
			    ajax.call(options);							
			}
			
        </script>
        <!-- //20210126 변경 끝 -->        
        <jsp:include page="/WEB-INF/tiles/include/js/pettv.jsp" />
        <%-- <script src="<spring:eval expression="@bizConfig['vod.player.api.url']" />/iframe_api/v1.js"></script> --%>        
	</tiles:putAttribute>
	
	<%-- 
	Tiles popup put
	불 필요시, 해당 영역 삭제
	--%>
	<tiles:putAttribute name="popup">
		<!-- popup 내용 부분입니다. -->
	</tiles:putAttribute>
</tiles:insertDefinition>

