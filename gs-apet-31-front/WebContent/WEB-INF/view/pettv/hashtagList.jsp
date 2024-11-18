<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.include" value="script.pettv"/> <!-- 지정된 스크립트 적용 -->
	
	<tiles:putAttribute name="script.inline">
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
		<script type="text/javascript">
			var page = 1;
			
			<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">	
				$(document).ready(function(){
					//$("#header_pc").removeClass("mode0").addClass("mode13");
					//$("#header_pc").attr("data-header", "set18");
					
					if("${tvo.tagNo}" != null) {
						 $(".mo-heade-tit .tit").html("#${tvo.tagNm }");
					 }
					
					//뒤로가기
					//$(".mo-header-backNtn").attr("onclick", "history.back()");
					$(".mo-header-backNtn").attr("onclick", "fncGoBack();");
				});	
			</c:if>
			
			//뒤로가기 이벤트(펫TV 홈으로 이동)-진입하는 페이지가 펫TV 홈 뿐이다.
			function fncGoBack(){
				location.href = "/tv/home";
			}
			
			<%-- 펫TV 홈/ 영상목록에서 자동재생 삭제로 인해 주석처리-CSR-1247
			<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_30 }">
				let autoPlayFlag = false;	
				
				$(document).ready(function() {
					fncAutoFlag();
				});
				
				//자동재생여부
				function fncAutoFlag(){
					toNativeData.func = "onIsAutoPlay";
					toNativeData.callback = "appIsAutoPlay";
					toNative(toNativeData);
				}
				
				function appIsAutoPlay(jsonString){
					var parseData = JSON.parse(jsonString);
					var autoPlay = parseData.isAutoPlay;
					
					if(autoPlay == "Y"){
						autoPlayFlag = true;
						$(".autoTrue").css('display', 'block');
					}else{
						autoPlayFlag = false;
					    $("a[name=autoFalse]").css('display', 'block');

					}				
				}
			</c:if>
			
			function onThumbAPIReady() {
			    thumbApi.ready();
			};
			--%>
			
			//찜하기
			function vodBookmark(obj , vdId, tagNo){
				var mbrNo = "${session.mbrNo}";
				if (mbrNo != '${frontConstants.NO_MEMBER_NO}') {
					petTvLikeDibs(obj, vdId, mbrNo, 20);
				}else {
					ui.confirm('로그인 후 서비스를 이용할 수 있어요.<br>로그인 할까요?',{
					    ycb:function(){
					    	var url = "${requestScope['javax.servlet.forward.request_uri']}" + "?tagNo=" + tagNo;
							location.href = "/indexLogin?returnUrl="+url;
					    	//storageHist.goBack("/indexLogin?returnUrl="+url);
					    },
					    ncb:function(){
					    },
					    ybt:'로그인',
					    nbt:'취소'
					});
				}
			}
			
			//좋아요
			function vodLike(obj, vdId, index, tagNo){
				var mbrNo = "${session.mbrNo}";
				var action = "";
				if (mbrNo != '0') {

					var options = {
			 			url : "<spring:url value='/tv/series/saveVdoLikeDibs' />",
						type : "POST",
			 			data : {
			 				vdId : vdId
			 				, mbrNo : mbrNo
			 				, intrGbCd : 10
			 			},
			 			done : function(data){
			 				if(data.actGubun =='add'){
								action = "like"; //클릭 이벤트-좋아요
								$(obj).addClass("on");
							}else if(data.actGubun =='remove'){
								action = "like_d"; //클릭 이벤트-좋아요 취소
								$(obj).removeClass("on");
							}
			 				
			 				$("#like_"+index).html(fnComma(data.likeCnt));
			 				//$(obj).toggleClass("on");
			 			}
			 		};
			 		ajax.call(options);
			 		userActionLog(vdId, action); //클릭 이벤트
				}else{
					ui.confirm('로그인 후 서비스를 이용할 수 있어요.<br>로그인 할까요?',{
					    ycb:function(){
					    	var url = "${requestScope['javax.servlet.forward.request_uri']}"+ "?tagNo=" + tagNo;
							location.href = "/indexLogin?returnUrl="+url;
					    	//storageHist.goBack("/indexLogin?returnUrl="+url);
					    },
					    ncb:function(){
					    },
					    ybt:'로그인',
					    nbt:'취소'
					});
				}
			}
			
			//공유하기
			function vdoShare(objId, vdId, device, url, ttl){
		 		petTvShare(objId, vdId, '30');
				
				if(device == "${frontConstants.DEVICE_GB_30}"){
					toNativeData.func = "onShare";
					toNativeData.link = url;
					toNativeData.subject = ttl
					toNative(toNativeData);
				}
			}
			
			//앱일때
			function goUrl(funcNm, type, url) {
				//videoAllPauses();
				toNativeData.func = funcNm;
				toNativeData.type = type;
				toNativeData.url = url;
				
				toNative(toNativeData);
			}
			
			function petTvDetail(vdId, tagNo){
				url ="${view.stDomain}/tv/series/indexTvDetail?vdId="+vdId+"&sortCd=&listGb=TAG_N_"+tagNo;					
				goUrl('onNewPage', 'TV', url);
			}
			
			function srisDetail(sris){
				location.href = "/tv/series/petTvSeriesList?srisNo="+sris+"&sesnNo=1";
				//storageHist.goBack("/tv/series/petTvSeriesList?srisNo="+sris+"&sesnNo=1");
			}
			
			function petTvReDetail(vdId, tagNo, param) {
				var url = '';
				if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_20}") {
					url ="/tv/series/indexTvDetail?vdId="+vdId+"&sortCd=&listGb=TAG_"+param+"_"+tagNo;
					location.href = url;
					//storageHist.goBack(url);
				}else{
					url ="${view.stDomain}/tv/series/indexTvDetail?vdId="+vdId+"&sortCd=&listGb=TAG_"+param+"_"+tagNo;					
					goUrl('onNewPage', 'TV', url);
				}
			}
			
			//더보기
			function moreVideo() {
				var startNum = $(".list-wrap ul").length;
				var addHtml = '';
				page ++;
				
				var options = {
					url : "/tv/moreVideo"
					, dataType : "html"
					, data : {
						tagNo : "${tvo.tagNo}",
						page : page
					}
					, done : function(html) {
						$(".list-wrap #vodList").append(html);
						
						<%-- 펫TV 홈/ 영상목록에서 자동재생 삭제로 인해 주석처리-CSR-1247
						if("${view.deviceGb eq frontConstants.DEVICE_GB_30 }" == "true") {
							fncAutoFlag();
							onThumbAPIReady();
						}
						--%>
						
						if("${so.totalCount}" == $(".list-wrap ul li .thumb-box").length) {
							$("#moreDiv").hide();
						}
					}
				};
				ajax.call(options);
			}
			
			//페이지 이동[storageHist사용]
			function fncGoStoragHist(url){
				storageHist.goBack(url);
			}
			
			//페이지 이동
			function fncGoUrl(url){
				location.href = url;
			}
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<main class="container page tv homeList" id="container">
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">

					<div class="pc-subtit">
						<h2>
							<c:if test="${tvo.tagNo ne null}">
		                		#${tvo.tagNm}
		                	</c:if>
						</h2>
					</div>

					<!-- 영상리스트 영역 -->
					<div class="list-wrap">
						<ul class="list" id="vodList">
							<jsp:include page="/WEB-INF/view/pettv/hashtagListPaging.jsp" />
						</ul>
						<c:if test="${so.totalCount > 12}">
							<div class='uimoreload' id="moreDiv"><button type='button' class='bt more' id='moreBtn' onclick='moreVideo();'>영상 더보기</button></div>
						</c:if>
					</div>
					
					<!-- 인기 시리즈 추천-->
					<section class="popular">
                        <div class="title-area">
                            <h2>펫TV 인기시리즈</h2>
                        </div>

                        <div class="popular-wrap" style="padding-bottom:0;">
                            <div class="ch-profile">
                                <div class="ch-profile-inner">
                                        <div>
                                        	<div class="round-img-pf" onclick="srisDetail(${random.srisNo});" style="background-image:url(${fn:indexOf(random.srisPrflImgPath, 'cdn.ntruss.com')> -1 ? random.srisPrflImgPath  : frame:optImagePath(random.srisPrflImgPath, frontConstants.IMG_OPT_QRY_786) }); cursor:pointer;"></div>
                                            <div class="tit" onclick="srisDetail(${random.srisNo});" style="cursor:pointer;">${random.srisNm}</div>
                                        </div>
                                </div>
                            </div>
                            <!-- //ch-profile -->
                            
                            <div class="popular-list">
                                <div class="swiper-div k0421">
                                    <div class="swiper-container">
                                        <ul class="swiper-wrapper">
                                        	<c:forEach items="${random.srisRandomList}" var="list">
                                            <li class="swiper-slide">
                                                <div class="thumb-box">
                                                	<c:choose>
                                                		<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_30}">
	                                                		<a href="#" onclick="goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${list.vdId}&sortCd=&listGb=SRIS_${list.srisNo}'); return false;" class="thumb-img" style="background-image:url(${fn:indexOf(list.thumPath, 'cdn.ntruss.com')> -1 ? list.thumPath  : frame:optImagePath(list.thumPath, frontConstants.IMG_OPT_QRY_754) });" data-content="${list.vdId}" data-url="${view.stDomain}/tv/series/indexTvDetail?vdId=${list.vdId}&sortCd=&listGb=SRIS_${list.srisNo}">
	                                                    		<div class="time-tag"><span>${list.totLnth}</span></div>
		                                                    </a>
                                                		</c:when>
                                                		<c:otherwise>
	                                                		<a href="#" onclick="fncGoUrl('/tv/series/indexTvDetail?vdId=${list.vdId}&sortCd=&listGb=SRIS_${list.srisNo}'); return false;" class="thumb-img" style="background-image:url(${fn:indexOf(list.thumPath, 'cdn.ntruss.com')> -1 ? list.thumPath  : frame:optImagePath(list.thumPath, frontConstants.IMG_OPT_QRY_755) });" data-content="${list.vdId}" data-url="/tv/series/indexTvDetail?vdId=${list.vdId}&sortCd=&listGb=SRIS_${list.srisNo}">
																<div class="time-tag"><span>${list.totLnth}</span></div>
		                                                    </a>
                                                		</c:otherwise>
                                                	</c:choose>
                                                    <div class="thumb-info">
                                                        <div class="info">
                                                            <div class="tlt">
	                                                            <c:choose>
			                                                		<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_30}">
				                                                		<a href="#" onclick="goUrl('onNewPage', 'TV', '${view.stDomain}/tv/series/indexTvDetail?vdId=${list.vdId}&sortCd=&listGb=SRIS_${list.srisNo}'); return false;" data-content="${list.vdId}" data-url="${view.stDomain}/tv/series/indexTvDetail?vdId=${list.vdId}&sortCd=&listGb=SRIS_${list.srisNo}">
				                                                    		${list.ttl}
					                                                    </a>
			                                                		</c:when>
			                                                		<c:otherwise>
				                                                		<a href="#" onclick="fncGoUrl('/tv/series/indexTvDetail?vdId=${list.vdId}&sortCd=&listGb=SRIS_${list.srisNo}'); return false;" data-content="${list.vdId}" data-url="/tv/series/indexTvDetail?vdId=${list.vdId}&sortCd=&listGb=SRIS_${list.srisNo}">
																			${list.ttl}
					                                                    </a>
			                                                		</c:otherwise>
			                                                	</c:choose>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                    <div class="remote-area">
                                        <button class="swiper-button-next" type="button"></button>
                                        <button class="swiper-button-prev" type="button"></button>
                                    </div>
                                </div>
                                <!-- //Swiper -->
                            </div>
                            <!-- popular-wrap -->
                        </div>
                        <!-- //popular-wrap -->
                        
                    </section>
                    <!-- //인기 시리즈 추천 -->
				</div><!-- contents -->
			</div><!-- inr -->
        </main>
        
        <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
        <script>
           // Swiper 최근
           var swiperRecent = new Swiper('.popular-list .swiper-container', {
                slidesPerView: 4,
                spaceBetween: 16,
                observer: true,
                observeParents: true,
                watchOverflow:true,
                freeMode: false,
                navigation: {
                    nextEl: '.popular-list .swiper-button-next',
                    prevEl: '.popular-list .swiper-button-prev',
                }
            });
        </script>
        </c:if>
        
        <!-- 플로팅 버튼 -->
        <jsp:include page="/WEB-INF/tiles/include/floating.jsp">
     		<jsp:param name="floating" value="${view.deviceGb eq frontConstants.DEVICE_GB_10 ? '' : 'talk'}"  />
		</jsp:include>
	</tiles:putAttribute>
	<%-- <tiles:putAttribute name="content">
		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container page tv homeList" id="container">
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">

                    <div class="pc-subtit">
                        <h2>
                       	<c:if test="${tvo.tagNo ne null}">
	                		#${tvo.tagNm}
	                	</c:if>
                        </h2>
                    </div>

                    <!-- 영상리스트 영역 -->
                    <div class="list-wrap">
                        <ul class="list">
                        	<c:forEach items="${optimalVodList}" var="vod" varStatus="idx">
	                            <li>
	                                <div class="thumb-box">
	                                    <div class="div-header">
	                                        <div class="pic" onclick="srisDetail(${vod.srisNo});"><img src="${fn:indexOf(vod.srisPrflImgPath, 'cdn.ntruss.com')> -1 ? vod.srisPrflImgPath  : frame:optImagePath(vod.srisPrflImgPath, frontConstants.IMG_OPT_QRY_786) }" alt=""></div>
	                                        <div class="tit">${vod.srisNm}</div>
	                                    </div>
	                                    <div class="div-img">
	                                    	<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 or view.deviceGb eq frontConstants.DEVICE_GB_20 }">
		                                        <c:if test="${vod.vdGbCd eq frontConstants.VD_GB_10 }">
		                                        	<a href="/tv/school/indexTvDetail?vdId=${vod.vdId}&sortCd=&listGb=TAG_N_${vod.tagNo}" class="thumb-img" style="background-image:url(${fn:indexOf(vod.thumPath, 'cdn.ntruss.com') > -1 ? vod.thumPath : frame:optImagePath(vod.thumPath, frontConstants.IMG_OPT_QRY_750)});" data-content="${vod.vdId}" data-url="/tv/school/indexTvDetail?vdId=${vod.vdId}&sortCd=&listGb=TAG_N_${vod.tagNo}">
		                                        </c:if>
		                                        <c:if test="${vod.vdGbCd eq frontConstants.VD_GB_20 }">
		                                        	<a href="/tv/series/indexTvDetail?vdId=${vod.vdId}&sortCd=&listGb=TAG_N_${vod.tagNo}" class="thumb-img" style="background-image:url(${fn:indexOf(vod.thumPath, 'cdn.ntruss.com') > -1 ? vod.thumPath : frame:optImagePath(vod.thumPath, frontConstants.IMG_OPT_QRY_751)});" data-content="${vod.vdId}" data-url="/tv/series/indexTvDetail?vdId=${vod.vdId}&sortCd=&listGb=TAG_N_${vod.tagNo}">
		                                        </c:if>
		                                            <div class="time-tag"><span>${vod.totLnth }</span></div>
		                                        </a>
		                                    </c:if>
                                          	<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_30}">
												<!-- 자동재생여부 true -->
												<div class="vthumbs autoTrue" video_id="${vod.outsideVdId}" type="video_thumb_360p" lazy="scroll" style="height:80%px;display:none;">
													<a href="petTvDetail('${vod.vdId}', '${vod.tagNo}');" class="thumb-img" id="vthum_${idx.index}" data-content="${vod.vdId}" data-url="${view.stDomain}/tv/series/indexTvDetail?vdId=${vod.vdId}&sortCd=&listGb=TAG_N_${vod.tagNo}">
				                                    	<div class="time-tag"><span>${vod.totLnth}</span></div>
				                                	</a>
			                                	</div>
												<!-- 자동재생여부 false -->
			                                	<a href="javascript:petTvDetail('${vod.vdId}', '${vod.tagNo }');" name="autoFalse" class="thumb-img" style="background-image:url(${fn:indexOf(vod.thumPath, 'cdn.ntruss.com')> -1 ? vod.thumPath  : frame:optImagePath(vod.thumPath, frontConstants.IMG_OPT_QRY_751) }); display:none;" data-content="${vod.vdId}" data-url="${view.stDomain}/tv/series/indexTvDetail?vdId=${vod.vdId}&sortCd=&listGb=TAG_N_${vod.tagNo}" >
                                   					<div class="time-tag"><span>${vod.totLnth}</span></div>
                                   				</a>
                                          	</c:if>
	                                    </div>
	                                    <div class="thumb-info">
	                                        <div class="info">
	                                            <div class="detail top">
		                                                <ul class="tag-txt">
			                                                <c:forEach items="${vod.tagList}" var="tag" begin="0" end="4">
			                                            		<li><a href="/tv/hashTagList?tagNo=${tag.tagNo}" data-content="${tag.tagNo}" data-url="/tv/hagTagList?tagNo=${tag.tagNo}">#${tag.tagNm}</a></li>
			                                                </c:forEach>
		                                                </ul>
	                                            </div>
	                                            <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 or view.deviceGb eq frontConstants.DEVICE_GB_20}">
	                                            <a href="/tv/series/indexTvDetail?vdId=${vod.vdId}&sortCd=&listGb=TAG_N_${vod.tagNo}">
	                                            <div class="tlt k0426" id="petTvListTlt_${idx.index}" data-content="${vod.vdId};" data-url="/tv/series/indexTvDetail?vdId=${vod.vdId}&sortCd=&listGb=TAG_N_${vod.tagNo}">
	                                            	${vod.ttl}
	                                            </div>
	                                            </a>
	                                            </c:if>
	                                            <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_30}">
	                                            	<div class="tlt k0426" id="petTvListTlt_${idx.index}" onclick="petTvDetail('${vod.vdId}', '${vod.tagNo}');" data-content="${vod.vdId};" data-url="${view.stDomain}/tv/series/indexTvDetail?vdId=${vod.vdId}&sortCd=&listGb=TAG_N_${vod.tagNo}">
	                                            	${vod.ttl}
	                                            </div>
	                                            </c:if>
	                                            <div class="detail">
	                                                <span class="read play"> ${vod.hits}</span>
	                                                <span class="read like" id="like_${idx.index}"> ${vod.likeCnt}</span>
	                                            </div>
	                                        </div>
	                                    </div>
	                                    <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_20 || view.deviceGb eq frontConstants.DEVICE_GB_30}">
		                                     <!-- menu bar -->
		                                    <div class="lcbmenuBar">
		                                        <div class="inner">
		                                            <ul class="bar-btn-area">
		                                            	<!-- 좋아요 -->
		                                                <li>
		                                                    <button class="logBtnBasic btn-like ${vod.likeYn == 'Y' ? 'on' : ''}" onclick="vodLike(this, '${vod.vdId}', ${idx.index})"></button>
		                                                </li>
		                                                <!-- 댓글 -->
		                                                <li>
		                                                	<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_20 }">
		                                                		<button type="button" class="logBtnBasic btn-comment" id="cmt_${idx.index}" onClick="petTvReDetail('${vod.vdId}', '${vod.tagNo}', 'R');" data-content="${vod.vdId}" data-url="/tv/series/indexTvDetail?vdId=${vod.vdId}&sortCd=&listGb=TAG_R_${vod.tagNo}"></button>
		                                                	</c:if>
		                                                	<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_30 }">
		                                                		<button type="button" class="logBtnBasic btn-comment" id="cmt_${idx.index}" onClick="petTvReDetail('${vod.vdId}', '${vod.tagNo}', 'R');" data-content="${vod.vdId}" data-url="${view.stDomain}/tv/series/indexTvDetail?vdId=${vod.vdId}&sortCd=&listGb=TAG_R_${vod.tagNo}"></button>
		                                                	</c:if>
		                                                </li>
		                                                <!-- 공유 -->
		                                                <li>
														<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_30 }">
															<button class="logBtnBasic btn-share" id="vdoShare_${idx.index}" data-clipboard-text="${vod.srtUrl}" onclick="vdoShare('null', '${vod.vdId}', '${view.deviceGb}', '${vod.srtUrl}', '${vod.ttl}');" data-content=""  data-url="${vod.srtUrl}"><span>공유</span></button>
														</c:if>
														<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 || view.deviceGb eq frontConstants.DEVICE_GB_20}">
					                         				<button class="logBtnBasic btn-share" id="vdoShare_${idx.index}" data-message="URL을 복사하였습니다."  data-clipboard-text="${vod.srtUrl}" onclick="vdoShare(this.id, '${vod.vdId}', '${view.deviceGb}', '${vod.srtUrl}', '${vod.ttl}');" data-content="" data-url="${vod.srtUrl}"><span>공유</span></button>
														</c:if>
		                                                </li>
		                                                <!-- 북마크 -->
		                                                <li class="ml20">
	                                                		<button class="logBtnBasic btn-bookmark ${vod.zzimYn == 'Y' ? 'on' : ''}" onclick="vodBookmark(this, '${vod.vdId}');">
		                                                	<span>북마크</span></button>
		                                                </li>
		                                            </ul>
		                                            <!-- 연관상품 -->
		                                            <c:if test="${vod.goodsCount > 0}">
			                                            <div class="log_connectTingWrap">
			                                            	<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_20 }">
			                                            		<a href="#" onclick="petTvReDetail('${vod.vdId}', '${vod.tagNo}', 'T'); return false;" id="goodsCnt_${idx.index}" class="tvConnectedTing"  data-content="${vod.vdId}" data-url="/tv/series/indexTvDetail?vdId=${vod.vdId}&sortCd=&listGb=TAG_T_${vod.tagNo}">
			                                            	</c:if>
			                                            	<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_30 }">
			                                            		<a href="#" onclick="petTvReDetail('${vod.vdId}', '${vod.tagNo}', 'T'); return false;" id="goodsCnt_${idx.index}" class="tvConnectedTing"  data-content="${vod.vdId}" data-url="${view.stDomain}/tv/series/indexTvDetail?vdId=${vod.vdId}&sortCd=&listGb=TAG_T_${vod.tagNo}">
			                                            	</c:if>
			                                            	연관상품<span>${vod.goodsCount}</span></a>
			                                            </div>
		                                            </c:if>
		                                        </div>
		                                    </div>
	                                    </c:if>
	                                    <!-- // menu bar -->
	                                </div>
	                            </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <!-- //영상리스트 영역 -->

				</div><!-- contents -->
			</div><!-- inr -->
        </main> --%>
	<%-- </tiles:putAttribute> --%>
</tiles:insertDefinition> 


