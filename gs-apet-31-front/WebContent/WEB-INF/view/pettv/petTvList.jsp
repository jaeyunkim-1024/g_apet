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
			$(document).ready(function(){
				<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">	
					//$("#header_pc").removeClass("mode0").addClass("mode13");
					//$("#header_pc").attr("data-header", "set18");
		
					if("${so.dispCornNo}" == '569'){
						//var sessNickNm = '${session.nickNm}';
						var sessNickNm = $("#sessNickNm").val();
						var nickNmLen = sessNickNm.length;
						if(nickNmLen > 7) {
							sessNickNm = sessNickNm.substr(0, 7)+ '...';
						}
						$(".mo-heade-tit .tit").html("<b class=e><em>" + sessNickNm + "</em>님을 위한 맞춤 영상</b>");
					}else if("${so.dispCornNo}" == '567'){
						$(".mo-heade-tit .tit").text("따끈따끈 신규 영상");
		 			}else if("${so.dispCornNo}" == '568'){
		 				$(".mo-heade-tit .tit").text("지금 뜨는 인기영상");
		 			}
					
					//뒤로가기
					//$(".mo-header-backNtn").attr("onclick", "history.back()");
					$(".mo-header-backNtn").attr("onclick", "fncGoBack();");
				</c:if>
			});
			
			//뒤로가기 이벤트(펫TV 홈으로 이동)-진입하는 페이지가 펫TV 홈 뿐이다.
			function fncGoBack(){
				//location.href = "/tv/home";
				//storageHist.getOut("${requestScope['javax.servlet.forward.servlet_path']}");
				storageHist.goBack();
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
						$(".autoTrue").show();
// 						$(".autoTrue").css('display', 'block');
					}else{
						autoPlayFlag = false;
						$("a[name=autoFalse]").show();
// 						$("a[name=autoFalse]").css('display', 'block');
					}				
				}
			</c:if>
			
			function onThumbAPIReady() {
			    thumbApi.ready();
			};
			--%>
			
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
 					//petTvLikeDibs(obj, vdId, mbrNo, 10);
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
				//videoAllPauses();
				toNativeData.func = funcNm;
				toNativeData.type = type;
				toNativeData.url = url;
				
				toNative(toNativeData);
			}
			
			function petTvDetail(vdId, index, param, ttl){
				var url = '';
				var param2 = '';
				
				//맞춤영상
				if("${so.dispCornNo}" == '569'){
					param2 = 'F';		
				//신규
				}else if("${so.dispCornNo}" == '567'){
					param2 = 'N';	
				//인기
				}else{
					param2 = 'P';	
				}
				
				if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_10}" || "${view.deviceGb}" == "${frontConstants.DEVICE_GB_20}") {
					url ="/tv/series/indexTvDetail?vdId="+vdId+"&sortCd=&listGb=VDO_"+param2+"_"+param;
					location.href = url;
					//storageHist.goBack(url);
				}else{
					url ="${view.stDomain}/tv/series/indexTvDetail?vdId="+vdId+"&sortCd=&listGb=VDO_"+param2+"_"+param;					
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
			
			function srisDetail(sris){
				location.href = "/tv/series/petTvSeriesList?srisNo="+sris+"&sesnNo=1";
				//storageHist.goBack("/tv/series/petTvSeriesList?srisNo="+sris+"&sesnNo=1");
			}
			
			var petTvMore = {
				rows : "12",
				paging : function(){
					if($("#petTvPage").val() === '0'){
			            $("#petTvPage").val(1);
			        }
			        var page = $("#petTvPage").val()*1 +1;
			        $("#petTvPage").val(page);
			        
				 	var options = {
				 		url : "<spring:url value='/tv/petTvPaging' />"
				 		, type : "POST"
				 		, dataType : "html"
				 		, data : {
				 			page : page,
				 			dispCornNo : $("#dispCornNo").val()
				 		}
				 		, done :function(html){
				 			$("#petTvVodList").append(html);
				 			
				 			if($("#petTvVodList li .thumb-box").length % petTvMore.rows != 0 || $("#petTvVodList li .thumb-box").length == $("#totalCnt").val()){
				 				$("#petTvMore").hide();	
							}
				 			
				 			<%-- 펫TV 홈/ 영상목록에서 자동재생 삭제로 인해 주석처리-CSR-1247
				 			if("${view.deviceGb}" ==  "${frontConstants.DEVICE_GB_30}"){
					 			fncAutoFlag();
								onThumbAPIReady();
				 			}
				 			--%>
				 		}	
				 	};
				 	ajax.call(options);
				}
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
		<input type="hidden" id="dispCornNo" value="${so.dispCornNo}"/>
		<input type="hidden" id="petTvPage" value="${so.page}"/>
		<input type="hidden" id="sessNickNm" value="${session.nickNm }"/>
		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container page tv homeList" id="container">
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">

                    <div class="pc-subtit">
                        <h2>
						<c:set var="dispCornNo" value="${so.dispCornNo}" />
							<c:choose>
								<c:when test="${dispCornNo == '569'}">
		                        	<em>${session.nickNm}</em>님을 위한 맞춤 영상
								</c:when>
								<c:when test="${dispCornNo == '567'}">
									따끈따끈 신규 영상
								</c:when>
					 			<c:when test="${dispCornNo == '568'}">
									지금 뜨는 인기영상
								</c:when>
							</c:choose>  
                        </h2>
                    </div>

                    <!-- 영상리스트 영역 -->
                    <div class="list-wrap">
                        <ul class="list" id="petTvVodList">
                        	<jsp:include page="/WEB-INF/view/pettv/petTvListPaging.jsp" />
                        </ul>
                    </div>
                    <!-- //영상리스트 영역 -->
					
					<%--신규영상일때만 더보기 버튼 노출--%>
					<c:if test="${so.dispCornNo eq '567'}">
					<!-- 2021.0503 상품더보기 버튼추가 -->
                        <div class="morebtn moreload" id="petTvMore">
                            <button type="button" class="bt more" onclick="petTvMore.paging();">더보기</button>
                        </div>
					</c:if>
			
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
                                                			<a href="#" onclick="fncGoUrl('/tv/series/indexTvDetail?vdId=${list.vdId}&sortCd=&listGb=SRIS_${list.srisNo}'); return false;" onclick="videoAllPauses();" class="thumb-img" style="background-image:url(${fn:indexOf(list.thumPath, 'cdn.ntruss.com')> -1 ? list.thumPath  : frame:optImagePath(list.thumPath, frontConstants.IMG_OPT_QRY_755) });" data-content="${list.vdId}" data-url="/tv/series/indexTvDetail?vdId=${list.vdId}&sortCd=&listGb=SRIS_${list.srisNo}">
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


