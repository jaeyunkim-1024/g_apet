<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.inline">
		<script src="<spring:eval expression="@bizConfig['vod.player.api.url']" />/thumb_api/v1.js"></script>
		<script>
			var page = 1;
			
			$(document).ready(function(){
				 //$("#header_pc").removeClass('mode0');
				 //$("#header_pc").addClass('mode7-1 noneAc');
				 $("#header_pc").addClass('noneAc');
				 
				 if("${tvo.tagNo}" != null) {
					 $(".mo-heade-tit .tit").html("#${tvo.tagNm }");
				 }
				 
				 $(".mo-header-backNtn").attr("onclick", "fncGoBack()");
			});
			
			//뒤로가기(<) 클릭 이벤트
			function fncGoBack(){
				if("${callParam}" != ""){
					//App & 펫TV 영상상세 화면에서 호출일때만 callParam값이 있다.
					var callParam = "${callParam}";
					var params = callParam.split(".");
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
				}
				
				//history.go(-1);
				storageHist.goBack();
			}
			
			// 최신순/인기순 정렬
			function sortBtn(sort) {
				page = 1;
				var options = {
					  url : " <spring:url value='/tv/hashTagListSort' />"
					  , data : {
							tagNo : "${tagVodList[0].tagNo}",
				  		    sidx : sort,
				  		    page : page
					  }
					  , done : function(data) {
						  $("#vodList").empty();
						  for(i in data.tagVodList) {
							  if(data.tagVodList[i].thumPath.indexOf('cdn.ntruss.com') != -1){
					              thumPath = data.tagVodList[i].thumPath;
					          }else{
					              thumPath = "${frame:optImagePath('"+ data.tagVodList[i].thumPath +"', frontConstants.IMG_OPT_QRY_753)}";
					          }
							  
							  if(data.tagVodList[i].srisPrflImgPath.indexOf('cdn.ntruss.com') != -1){
					              srisPrflImgPath = data.tagVodList[i].srisPrflImgPath;
					          }else{
					              srisPrflImgPath = "${frame:optImagePath('"+ data.tagVodList[i].srisPrflImgPath +"', frontConstants.IMG_OPT_QRY_785)}";
					          }
							  
							  var html = '';
							  html += '<li>';
							  html += '<div class="thumb-box">';
							  html += '<div class="div-img">';
							  if(data.tagVodList[i].newYn == 'Y') {
								  html += '<i class="icon-n">N</i>';
							  }
							  /* if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_10}" || "${view.deviceGb}" == "${frontConstants.DEVICE_GB_20}") { */
								  /* html += '<a href="/tv/series/indexTvDetail?vdId='+data.tagVodList[i].vdId+'&sortCd=&listGb=TAG_'+data.tagVodList[i].tagNo+'" class="thumb-img" style="background-image:url('+thumPath+');">'; */
								  html += '<a href="#" onclick="tvDetail(\''+data.tagVodList[i].vdId+'\', \'N\', \''+data.tagVodList[i].tagNo+'\'); return false;" class="thumb-img" style="background-image:url('+thumPath+');">';
							  /* } else {
								  html += '<a href="javascript:tvDetail('+data.tagVodList[i].vdId+', \'N\', '+data.tagVodList[i].tagNo+');" class="thumb-img" style="background-image:url('+thumPath+');">';
							  } */
							  html += '<div class="time-tag"><span>'+data.tagVodList[i].totLnth+'</span></div>';
							  html += '</a>';
							  html += '</div>';
							  html += '<div class="thumb-info top">';
							  html += '<div class="round-img-pf" onclick="srisDetail('+ data.tagVodList[i].srisNo +');" style="background-image:url('+srisPrflImgPath+'); cursor:pointer;"></div>';
							  html += '<div class="info">';
							  html += '<div class="tlt k0426">';
							  html += '<a href="#" onclick="tvDetail(\''+data.tagVodList[i].vdId+'\', \'N\', \''+data.tagVodList[i].tagNo+'\'); return false;">';
							  html += data.tagVodList[i].ttl;
							  html += '</a>';
							  html += '</div>';
							  html += '<div class="detail">';
							  /* html += '<span class="read play">'+data.tagVodList[i].hits+'</span>'; */
							  html += '<span class="read like">'+data.tagVodList[i].likeCnt+'</span>';
							  html += '</div>';
							  html += '</div>';
							  html += '</div>';
							  html += '</div>';
							  html += '</li>';
							  
							  $("#vodList").append(html);
						  }
						  
						  if("${so.totalCount}" > 12 && $("#moreDiv").css("display") == "none") {
							  //$("#vodList").after("<div class='uimoreload' id='moreDiv'><button type='button' class='bt more' id='moreBtn' onclick='moreVideo();'>영상 더보기</button></div>");
							  $("#moreDiv").show();
						  }
					  }
			  	};
			 	ajax.call(options);
			}
			  
			//APP  영상 상세 이동 URL 페이지 호출
			function goUrl(funcNm, type, url) {
				//videoAllPauses();
				toNativeData.func = funcNm;
				toNativeData.type = type;
				toNativeData.url = url;
				
				toNative(toNativeData);
			}
			
			//영상 상세 url
			function tvDetail(vdId, vdGb, tagNo) {
				var url = '';
				var sortCd = '';
				if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_10}" || "${view.deviceGb}" == "${frontConstants.DEVICE_GB_20}") {
					if(vdGb == 'S') {
						if($(".uisort .list .menu").children('li').eq(0).hasClass('active')) {
							sortCd = "10";
						} else {
							sortCd = "20";
						}
						url = "/tv/school/indexTvDetail?vdId="+vdId+"&sortCd="+sortCd+"&listGb=COLL_"+tagNo;
						location.href = url;
						//storageHist.goBack(url);
					} else {
						if($(".uisort .list .menu").children('li').eq(0).hasClass('active')) {
							sortCd = "10";
						} else {
							sortCd = "20";
						}
						url = "/tv/series/indexTvDetail?vdId="+vdId+"&sortCd="+sortCd+"&listGb=COLL_"+tagNo;
						location.href = url;
						//storageHist.goBack(url);
					}
				}else{
					if(vdGb == 'S') {
						if($(".uisort .list .menu").children('li').eq(0).hasClass('active')) {
							sortCd = "10";
						} else {
							sortCd = "20";
						}
						url = "${view.stDomain}/tv/school/indexTvDetail?vdId="+vdId+"&sortCd="+sortCd+"&listGb=COLL_"+tagNo;
						location.href = url;
						//storageHist.goBack(url);
					} else {
						if($(".uisort .list .menu").children('li').eq(0).hasClass('active')) {
							sortCd = "10";
						} else {
							sortCd = "20";
						}
						url = "${view.stDomain}/tv/series/indexTvDetail?vdId="+vdId+"&sortCd="+sortCd+"&listGb=COLL_"+tagNo;
						goUrl('onNewPage', 'TV', url);
					}
				}
			}
			
			//영상 더보기
			function moreVideo() {
				page++;
				var sidx = '';
				if($(".list .menu li").eq(0).hasClass('active')) {
					sidx = "SYS_REG_DTM";
				} else {
					sidx = "HITS";
				}
				
				var options = {
					url : "/tv/collectTagsPaging"
					, data : {
						tagNo : "${tvo.tagNo}"
						,page : page
						,sidx : sidx
					}
					, dataType : "html"
					, done : function(html) {
						$("#vodList").append(html);
						
						if($("#vodList li .thumb-box").length == "${so.totalCount}") {
							$("#moreDiv").hide();
						}
					}
				};
				ajax.call(options);
			}
			
			function srisDetail(srisNo){
				url = "/tv/series/petTvSeriesList?srisNo="+srisNo+"&sesnNo=1";
				location.href = url;
				//storageHist.goBack(url);
			}
	    </script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container page tv tagSet" id="container">
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<c:if test="${tvo.tagNo ne null}">
						<!-- PC 타이틀 모바일에서 제거  -->
	                    <div class="pc-tit">
	                        <h2>#${tvo.tagNm }</h2>
	                    </div>
						<!-- // PC 타이틀 모바일에서 제거  -->
	                    <div class="tag-title">#${tvo.tagNm }</div>
					</c:if>
					
                    <div class="list-wrap">
                        <div class="list-top">
                            <div class="tag-total">
                                <strong>TV</strong>
                                <em>${so.totalCount}개</em>
                            </div>

                            <nav class="uisort">
								<button type="button" class="bt st"></button>
								<div class="list">
									<ul class="menu">
										<li><button type="button" onclick="sortBtn('SYS_REG_DTM');" class="bt" value="v_1">최신순</button></li>
										<li><button type="button" onclick="sortBtn('HITS');" class="bt" value="v_2">인기순</button></li>
									</ul>
								</div>
							</nav>
                        </div>
                        <!-- list-top -->

                        <ul class="list s0423" id="vodList">
                       		<jsp:include page="/WEB-INF/view/pettv/collectTagsPaging.jsp" />
                        </ul>
						<div class='uimoreload' id="moreDiv" <c:if test ="${so.totalCount < 13 }">style ="display:none"</c:if>><button type='button' class='bt more' id='moreBtn' onclick='moreVideo();'>영상 더보기</button></div>
                    </div>

				</div><!-- contents -->
			</div><!-- inr -->
        </main>
        
        <!-- 플로팅 버튼 -->
        <jsp:include page="/WEB-INF/tiles/include/floating.jsp">
             <jsp:param name="floating" value="${view.deviceGb eq frontConstants.DEVICE_GB_10 ? '' : 'talk'}"  />
        </jsp:include>
	</tiles:putAttribute>
</tiles:insertDefinition>
