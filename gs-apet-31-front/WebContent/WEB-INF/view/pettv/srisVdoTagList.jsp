<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.include" value="script.pettv"/> <!-- 지정된 스크립트 적용 -->
	
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">
			var page = 1;
			
			$(document).ready(function(){
				<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">	
					//$("#header_pc").removeClass("mode0").addClass("mode13");
					//$("#header_pc").attr("data-header", "set18");
					$(".mo-heade-tit .tit").text($("#dispCornNm").val());
					$(".mo-header-backNtn").attr("onclick", "fncGoBack();"); //뒤로가기
				</c:if>
			});
			
			//뒤로가기 이벤트(펫TV 홈으로 이동)-진입하는 페이지가 펫TV 홈 뿐이다.
			function fncGoBack(){
				location.href = "/tv/home";
			}
			
			//찜하기
			function vodBookmark(obj , vdId, cornNo){
				var mbrNo = "${session.mbrNo}";
				if (mbrNo != '${frontConstants.NO_MEMBER_NO}') {
					petTvLikeDibs(obj, vdId, mbrNo, 20);
				}else {
					ui.confirm('로그인 후 서비스를 이용할 수 있어요.<br>로그인 할까요?',{
					    ycb:function(){
					    	var url = "${requestScope['javax.servlet.forward.request_uri']}" + "?dispCornNo=" + cornNo;
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
			function vodLike(obj, vdId, cornNo, index){
				var action = "";
				var mbrNo = "${session.mbrNo}";
				if (mbrNo != '0') {

					var options = {
			 			url : "<spring:url value='/tv/series/saveVdoLikeDibs' />",
						type : "POST",
						async: false,
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
					    	var url = "${requestScope['javax.servlet.forward.request_uri']}" + "?dispCornNo=" + cornNo;
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
				toNativeData.func = funcNm;
				toNativeData.type = type;
				toNativeData.url = url;
				
				toNative(toNativeData);
			}
			
			//영상상세 이동
			function petTvDetail(vdId, index, param, ttl){
				var url = '';
				
				if("${view.deviceGb ne frontConstants.DEVICE_GB_30}" == "true") {
					url ="/tv/series/indexTvDetail?vdId="+vdId+"&sortCd=&listGb=VT_${cornInfo.dispCornNo}_"+param;
					location.href = url;
					//storageHist.goBack(url);
				}else{
					url ="${view.stDomain}/tv/series/indexTvDetail?vdId="+vdId+"&sortCd=&listGb=VT_${cornInfo.dispCornNo}_"+param;
					goUrl('onNewPage', 'TV', url);
				}
				
				if(ttl == 'TTL'){
					$("#petTvListTlt_"+index).attr('data-url', url);
				}else if(ttl == 'CMT'){
					$("#cmt_"+index).attr('data-url', url);
				}else if(ttl == 'goodsCnt'){
					$("#goodsCnt_"+index).attr('data-url', url);
				}else if(ttl == 'PLY'){
					$("#player_"+index).attr('data-url', url); 
				}else if(ttl == 'VTHUM'){
					$("#vthum_"+index).attr('data-url', url); 
				}
			}
			
			//영상 더보기
			function moreVideo() {
				page++;
				var url = "";
				var dispCornTpCd = "${cornInfo.dispCornTpCd}";
				if(dispCornTpCd == "130" || dispCornTpCd == "132"){
					url = "/tv/seriesTagListMore";
				}else{
					url = "/tv/tagVodListMore";
				}
				
				var options = {
					url : url
					, type : "POST"
			 		, dataType : "html"
			 		, data : {
			 			page : page
			 			, dispCornNo : $("#dispCornNo").val()
			 		}
			 		, done :function(html){
			 			$("#srisVdoTagList").append(html);
						
						if($("#srisVdoTagList li .thumb-box").length == $("#totalCnt").val()) {
							$("#srisVdoTagMore").hide();
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
		<input type="hidden" id="totalCnt" value="${cornSo.totalCount}"/>
		<input type="hidden" id="dispCornNo" value="${cornInfo.dispCornNo}"/>
		<input type="hidden" id="dispCornNm" value="${cornInfo.dispCornNm}"/>
		
		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container page tv homeList" id="container">
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
                    <div class="pc-subtit">
                        <h2>${cornInfo.dispCornNm }</h2>
                    </div>

                    <!-- 영상리스트 영역 -->
                    <div class="list-wrap">
                        <ul class="list" id="srisVdoTagList">
                        	<c:if test="${cornInfo.dispCornTpCd eq '130' or cornInfo.dispCornTpCd eq '132' }">
                        		<jsp:include page="/WEB-INF/view/pettv/seriesTagListPaging.jsp" />
                        	</c:if>
                        	<c:if test="${cornInfo.dispCornTpCd eq '131' or cornInfo.dispCornTpCd eq '133' }">
                        		<jsp:include page="/WEB-INF/view/pettv/tagVodListPaging.jsp" />
                        	</c:if>
                        </ul>
                    </div>
                    <!-- //영상리스트 영역 -->
                    
                    <c:if test="${ (cornInfo.dispCornTpCd eq '132' and cornSo.totalCount > 12) or (cornInfo.dispCornTpCd eq '133' and cornSo.totalCount > 12) }">
                        <div class="morebtn moreload" id="srisVdoTagMore">
                            <button type="button" class="bt more" onclick="moreVideo();">더보기</button>
                        </div>
					</c:if>
                    
                    <!-- 인기 시리즈 추천 -->
					<section class="popular">
                        <div class="title-area">
                            <h2>펫TV 인기시리즈</h2>
                        </div>

                        <div class="popular-wrap" style="padding-bottom:0;">
                            <div class="ch-profile">
                                <div class="ch-profile-inner">
                                        <div>
                                        	<div class="round-img-pf" onclick="fncGoUrl('/tv/series/petTvSeriesList?srisNo=${random.srisNo}&sesnNo=1');" style="background-image:url(${fn:indexOf(random.srisPrflImgPath, 'cdn.ntruss.com')> -1 ? random.srisPrflImgPath  : frame:optImagePath(random.srisPrflImgPath, frontConstants.IMG_OPT_QRY_786) }); cursor:pointer;"></div>
                                            <div class="tit" onclick="fncGoUrl('/tv/series/petTvSeriesList?srisNo=${random.srisNo}&sesnNo=1');" style="cursor:pointer;">${random.srisNm}</div>
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
</tiles:insertDefinition> 