<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<% pageContext.setAttribute("newLineChar", "\n");%> 
<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.inline">
		<script src="https://sgr.aboutpet.co.kr/player/thumb_api/v1.js"></script>
		<script type="text/javascript" src="/_script/corner.js" ></script>
		<script type="text/javascript">
			<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">	
				$(document).ready(function(){
					//$("#header_pc").removeClass("mode0").addClass("mode6");
					//$("#header_pc").attr("data-header", "set6");
					
					//뒤로가기
					$("button[class=back]").bind("click", function(){
						if("${callParam}" != ""){
							//App & 펫TV 영상상세 화면에서 호출일때만 callParam값이 있다.
							var callParam = "${callParam}";
							var goBackYn = callParam.split("-")[1];
							var params = callParam.split("-")[0].split(".");
							var url = "";
							if(params.length == 2){
								url = "${view.stDomain}/tv/series/indexTvDetail?vdId="+params[0]+"&sortCd=&listGb="+params[1];
							}else{
								url = "${view.stDomain}/tv/series/indexTvDetail?vdId="+params[0]+"&sortCd="+params[1]+"&listGb="+params[2];
							}
							
							// 데이터 세팅
							toNativeData.func = "onNewPage";
							toNativeData.type = "TV";
							toNativeData.url = url;
							// 호출
							toNative(toNativeData);
							
							if(goBackYn == "N"){
								var path = "${requestScope['javax.servlet.forward.servlet_path']}";
								var queryString = "${requestScope['javax.servlet.forward.query_string']}".split("&");
								var url= path+"?"+queryString[0];
								storageHist.getOut(url);
							}else{
								storageHist.goBack();
							}
						}else{
							//history.go(-1);
							
							var path = "${requestScope['javax.servlet.forward.servlet_path']}";
							var queryString = "${requestScope['javax.servlet.forward.query_string']}".split("&");
							var url= path+"?"+queryString[0];
							storageHist.getOut(url);
						}
						
						/*
						 * 현재 시리즈 홈 화면을 하나의 페이지로 보고 시리즈 목록 팝업으로 시리즈 변경 및 시즌 변경 후 [<] 클릭으로 이전화면으로 넘어가야 한다면 getOut(url)을 사용하면 된다.
						 * getOut(url) 사용시 url에 현재 페이지의 주소를 넣어주면 동일 주소가 포함된 url 삭제 후 이전화면으로 이동된다.
						 * 예)1=/tv/home, 2=/tv/series/petTvSeriesList?srisNo=37&sesnNo=1, 3=/tv/series/petTvSeriesList?srisNo=37&sesnNo=2, 4=/tv/series/petTvSeriesList?srisNo=37&sesnNo=3
						 * 위에처럼 4개의 화면전환이 이루어진 상태에서 [<] 뒤로가기 버튼을 눌렀을때 getOut("/tv/series/petTvSeriesList") 올 호출하면 위의 2,3,4 를 삭제하고 1번으로 화면이동이 이루어진다.
						 * 현재 화면의 주소를 가져오는건 ["${requestScope['javax.servlet.forward.servlet_path']}"] 이걸 사용하면 된다.
						 */
						//storageHist.getOut("${requestScope['javax.servlet.forward.servlet_path']}");
					
						/*
						 * replaceHist() 를 사용하면 이동하는 URL을 현재 URL로 업데이트한다.
						 * 예)1=/tv/home, 2=/tv/series/petTvSeriesList?srisNo=37&sesnNo=1
						 * 위에처럼 시리즈 홈 화면에서 시즌 변경시 replaceHist를 사용하면
						 * 예)1=/tv/home, 2=/tv/series/petTvSeriesList?srisNo=37&sesnNo=2
						 * 위에처럼 기존 URL을 변경된 URL로 업데이트 한다.
						 */
						//storageHist.replaceHist();
						 
						/*
						 * goBack() 을 사용하면 이전화면을 호출한다.
						 * 예)1=/tv/home, 2=/tv/series/petTvSeriesList?srisNo=37&sesnNo=1, 3=/tv/series/petTvSeriesList?srisNo=37&sesnNo=2
						 * 위에처럼 되어있는 상황에서 goBack() 사용하면 2번 화면을 호출한다.
						 *
						 * goBack(url) 을 사용하면 url 이후의 url은 삭제 후 이동한다.
						 * 예)1=/tv/home, 2=/tv/series/petTvSeriesList?srisNo=37&sesnNo=1, 3=/tv/series/petTvSeriesList?srisNo=37&sesnNo=2, 4=/tv/series/petTvSeriesList?srisNo=37&sesnNo=3, 5=/tv/series/petTvSeriesList?srisNo=56&sesnNo=1
						 * 위에처럼 되어있는 상황에서 goBack("/tv/series/petTvSeriesList?srisNo=37&sesnNo=1") 2번을 호출하면 3,4,5 번 삭제 후 화면이동된다. 아래처럼 남아있다.
						 * 예)1=/tv/home, 2=/tv/series/petTvSeriesList?srisNo=37&sesnNo=1
						 */
						//storageHist.goBack();
						//storageHist.goBack("http://aboutpet.co.kr:8180/tv/series/petTvSeriesList?srisNo=37&sesnNo=1");
					});
				});	
			</c:if>
			
			$(function(){
				var sesnText = $("#"+"${so.sesnNo}").text();
				$(".btSel").text(sesnText);
				$("[name=select_pop_1]").val('${so.sesnNo}')
			});
			
			//시즌선택
			$(document).on("click",".pop-select .list>li button",function(e){
				var sesnNo = $(this).val();
				var srisNo = $("#srisNo").val();
				var callParam = "";
				if("${callParam}" != ""){
					if("${callParam}".indexOf("-N") == -1){
						callParam = "&callParam=${callParam}-N";
					}else{
						callParam = "&callParam=${callParam}";
					}
				}
				
				url = "/tv/series/petTvSeriesList?srisNo="+srisNo+"&sesnNo="+sesnNo+callParam;
				location.href = url;
				//storageHist.goBack(url);
			});
			
			//최신순, 인기순
			$(document).on("click",".uisort .list>ul>li button",function(e){
				var sortCd;
				
				if($(this).val() == "v_1"){
					sortCd = "";
				}else if($(this).val() == "v_2"){
					sortCd = "20";
				}
				
		 		var options = {
		 			url : "<spring:url value='/tv/series/getSesnList' />",
					type : "POST",
					dataType : "html",
		 			data : {
		 				sesnNo : $("#sesnNo").val(),
		 				srisNo : $("#srisNo").val(),
		 				sortCd : sortCd
		 			},
		 			done : function(result){
		 				$("#getVod").empty();
		 				$("#getVod").html(result);
		 			}
		 		};
		 		ajax.call(options);
			});
			
			function srisDetail(vdId, srisNo, index){
				var url = "";
				if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_10}" || "${view.deviceGb}" == "${frontConstants.DEVICE_GB_20}") {
					url = "/tv/series/indexTvDetail?vdId="+vdId+"&sortCd=10&listGb=SRIS_"+srisNo;	
					location.href = url;
					//storageHist.goBack(url);
				}else{
					url = "${view.stDomain}/tv/series/indexTvDetail?vdId="+vdId+"&sortCd=10&listGb=SRIS_"+srisNo;
					goUrl('onNewPage', 'TV', url);
				}
				
				$("#srisIndex_"+index).attr('data-url', url);
			}
			
			//앱일때
			function goUrl(funcNm, type, url) {
				//videoAllPauses();
				toNativeData.func = funcNm;
				toNativeData.type = type;
				toNativeData.url = url;
				
				toNative(toNativeData);
			}
			
			//시리즈 팝업
			function srisOpen(){
				var options = {
					url : "<spring:url value='/tv/series/getSeriesList' />"
					, type : "POST"
					, dataType : "html"
					, data : { }
					, done : function(result){
						$("#srisListPopup").empty()
						$("#srisListPopup").html(result);
						
						if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_10}"){
							ui.popLayer.open('popSeriesList',{
								ocb:function(){
									$("#srisListPopup .swiper-slide .thumb-box").removeClass('on');
									$("#srisListPopup #srisId_"+$("#srisNo").val()+"_"+$("#sesnNo").val()).addClass('on');
									$("#srisListPopup #srisId_"+$("#srisNo").val()+"_"+$("#sesnNo").val())[0].scrollIntoView();
									$("#srisListPopup #ch_"+$("#srisNo").val())[0].scrollIntoView();
								},
								ccb:function(){
									
								}
							});
						}else{
							ui.popLayer.open('popSeriesList',{
								ocb:function(){
									/*$("#srisListPopup .swiper-slide .thumb-box").removeClass('on');
									$("#srisListPopup #srisId_"+$("#srisNo").val()+"_"+$("#sesnNo").val()).addClass('on');
									$("#srisListPopup #srisId_"+$("#srisNo").val()+"_"+$("#sesnNo").val())[0].scrollIntoView();*/
									
									/* alert($("#srisNo").val());
									var hei = $("#srisListPopup .poptents #ch_"+$("#srisNo").val()).position();
									alert(hei.top);
									alert($("#srisListPopup .in").height());
									hei = hei.top - $("#popSeriesList .in").height();
									alert(hei);
									window.scrollTo({top : hei}); */
									
									
									var onThm = $("#srisId_"+ $("#srisNo").val() +"_"+ $("#sesnNo").val()).offset().top;
									$(".popLayer.a .pct").animate( { scrollTop : $("#srisId_"+ $("#srisNo").val() +"_"+ $("#sesnNo").val()).offset().top - 114 }, 0 );
									
									$(".poptents #srisId_"+ $("#srisNo").val() +"_"+ $("#sesnNo").val()).addClass('on');
									$(".poptents #srisId_"+ $("#srisNo").val() +"_"+ $("#sesnNo").val()).parents(".swiper-container").addClass("find");
									
									var bgSwiper = new Swiper(".swiper-container.find",{	//해당 스와이퍼 변수 찾을 수 없어 다시 그려줌.
										slidesPerView: 'auto',
										observer: true,
										observeParents: true,
										watchOverflow:true,
										freeMode: false
									});
									bgSwiper.slideTo($("#sesnNo").val() - 1, 0);	//스와이퍼는 0부터라 1빼쥼
								},
								ccb:function(){
									
								}
							});
						}
					}
				};
				ajax.call(options);
			}
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<input type="hidden" id="srisNo" name="srisNo" value="${so.srisNo}"/>
		<input type="hidden" id="sesnNo" name="sesnNo" value="${so.sesnNo}"/>
		<input type="hidden" id="callParam" value="${callParam }"/>
		<main class="container page tv seriesHome" id="container">
			<div class="inr">
                <div class="pageHead k0429">
                    <div class="inr">
                        <div class="hdt">
                            <button class="back" type="button">뒤로가기</button>
                            <div class="pics"><img class="img" src="${fn:indexOf(foGetSeries.srisPrflImgPath, 'cdn.ntruss.com') > -1 ? foGetSeries.srisPrflImgPath : frame:optImagePath(foGetSeries.srisPrflImgPath, frontConstants.IMG_OPT_QRY_786)}" alt="사진"></div>
                            
                            <h2 class="subtit">${foGetSeries.srisNm}</h2>
                        </div>
                        <div class="mdt">
                            <button type="button" onClick="srisOpen();" class="golist">시리즈목록</button>
                        </div>
                    </div>
                </div>
                
				<!-- 본문 -->
				<div class="contents" id="contents">
                    <div class="pc-subtit">
                    	<span class="pics">
                            <img class="img" src="${fn:indexOf(foGetSeries.srisPrflImgPath, 'cdn.ntruss.com') > -1 ? foGetSeries.srisPrflImgPath : frame:optImagePath(foGetSeries.srisPrflImgPath, frontConstants.IMG_OPT_QRY_786)}"" alt="사진">
                        </span>
                        <h2>${foGetSeries.srisNm}</h2>
                        <div class="mdt">
                            <button type="button" onClick="srisOpen();" class="golist">시리즈목록</button>
                        </div>
                    </div>

                    <!-- 시리즈 배너 -->
                    <section class="main-banner">
                        <div class="thumb-box">
                            <div class="thumb-img s0427" style="background-image:url(${fn:indexOf(foGetSeries.sesnImgPath, 'cdn.ntruss.com') > -1 ? foGetSeries.sesnImgPath : frame:optImagePath(foGetSeries.sesnImgPath, frontConstants.IMG_OPT_QRY_749)});">
                            </div>
                            <p class="tlt">
                            	${fn:replace(foGetSeries.sesnDscrt,newLineChar, '<br>')}
                            </p>
                        </div>
                    </section>

                    <!-- 시리즈 리스트 -->
					<div class="list-wrap">
						<div class="list-top">
							<c:if test="${fn:length(foGetSeason) > 1}">
								<span class="select-pop">
									<select class="sList" name="select_pop_1" data-select-title="시즌선택" value="">
										<c:forEach items="${foGetSeason}" var="sesn">
											<option value="${sesn.sesnNo}" id="${sesn.sesnNo}">${sesn.sesnNm}</option>
										</c:forEach>
									</select>
								</span>
							</c:if>
							<!-- select-box -->
	
							<nav class="uisort only_down">
								<button type="button" class="bt st"></button>
								<div class="list">
									<ul class="menu">
										<li id="recently"><button type="button" class="bt" value="v_1">최신순</button></li>
										<li id="popular"><button type="button" class="bt" value="v_2">인기순</button></li>
									</ul>
								</div>
							</nav>
						</div>
						<!-- list-top -->
	
						<div class="list-cont"  id="getVod">
							<ul class="list vodList">
								<c:forEach items="${foSesnVodList}" var="vod" varStatus="idx">
									<li>
										<div class="thumb-box">
											<div class="div-img">
												<c:if test="${vod.newYn == 'Y'}">
													<i class="icon-n">N</i>
												</c:if>
												<a href="javascript:srisDetail('${vod.vdId}', '${vod.srisNo}', '${idx.index}');" id="srisIndex_${idx.index}" class="thumb-img" style="background-image:url(${fn:indexOf(vod.thumPath, 'cdn.ntruss.com') > -1 ? vod.thumPath : frame:optImagePath(vod.thumPath, frontConstants.IMG_OPT_QRY_765)});" data-content="${vod.vdId}" data-url="">
													<div class="time-tag"><span>${vod.totLnth}</span></div>
													<c:if test="${vods.histLnth == null && vod.histLnth != '' && (vod.histLnth/vod.totalLnth)*100 >= 10.0}">
														<div class="progress-bar" style="width:${(vod.histLnth/vod.totalLnth)*100}%;"></div>
													</c:if>
												</a>
											</div>
											<div class="thumb-info">
												<div class="info">
													<div class="tlt">
														<a href="javascript:srisDetail('${vod.vdId}', '${vod.srisNo}', '${idx.index}');" data-content="${vod.vdId}" data-url="">
															${vod.ttl}
														</a>
													</div>
													<div class="detail">
														<!--<span class="read play"><fmt:formatNumber type="number" value="${vod.hits}"/></span>-->
														<span class="read like" data-read-like="${vod.vdId}"><fmt:formatNumber type="number" value="${vod.likeCnt}"/></span>
													</div>
												</div>
											</div>
										</div>
									</li>
								</c:forEach>
							</ul>
						</div><!-- list-cont -->
					</div><!-- list-wrap -->
				</div><!-- contents -->
			</div><!-- inr -->
		</main>
		<div class="seriesHome" id="srisListPopup"></div>
	</tiles:putAttribute>
</tiles:insertDefinition> 