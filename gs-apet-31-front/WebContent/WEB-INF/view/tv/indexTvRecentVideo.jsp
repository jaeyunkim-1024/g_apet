<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%--
  Class Name  : indexPetTvDetail.jsp 
  Description : 마이페이지 > 최근 본 영상
  Author      : LDS
  Since       : 2021.02.10
  Modification Information 
	          수정일         	     수정자             수정내용
    ----------  -------  -------------------------------------------
    2021.02.10   이동식          	최초 작성
--%>

<%-- 
사용 Tiles 지정
--%>
<tiles:insertDefinition name="mypage_mo_nofooter">
	<%-- 
	Tiles script.include put
	불 필요시, 해당 영역 삭제 
	--%>
	<tiles:putAttribute name="script.include" value="script.pettv"/> <!-- 지정된 스크립트 적용 -->
	
	<%-- 
	Tiles script.inline put
	불 필요시, 해당 영역 삭제 
	--%>
	<tiles:putAttribute name="script.inline">
		<style>
		.singleline {
			overflow: hidden;
			text-overflow: ellipsis;
			white-space: nowrap;
			width: 90%;
		}
		/* .multiline {
			overflow: hidden;
			text-overflow: ellipsis;
			line-height: 18px;
			height: 36px;
			width: 90%;
		}
		.multiline:before {
		  content: '...';
		  position: absolute;
		  right: 0;
		  margin-top: 0.9em;
		}
		.multiline:after {
		  content: '';
		  position: absolute;
		  right: 0;
		  width: 1em;
		  height: 1em;
		  margin-top: 1em;
		  background: white;
		} */
		</style>
		
		<script type="text/javascript">
		
			$(document).ready(function(){
				//$("#header_pc").removeClass("mode0");
				//$("#header_pc").addClass("mode16");
				//$("#header_pc").attr("data-header", "set16");
				
				$("#header_pc").addClass("noneAc");
				$(".mo-heade-tit .tit").html("최근 본 영상");
				
				/*var listGb = "${so.listGb}";
				$(".mo-header-backNtn").bind("click", function(){
					if(listGb == "TV"){
						location.href="/tv/home"
					}else if(listGb == "MY"){
						location.href="/mypage/indexMyPage"
					}else{
						history.go(-1);
					}
				});*/
				
				$(".mo-header-backNtn").attr("onclick", "fncGoBack()");
			}); // End Ready
			
			//뒤로가기(<) 클릭 이벤트
			function fncGoBack(){
				/*var listGb = "${so.listGb}";
				
				if(listGb == "TV"){
					location.href="/tv/home"
				}else if(listGb == "MY"){
					location.href="/mypage/indexMyPage"
				}else{
					history.go(-1);
				}*/
				
				storageHist.goBack();
			}
			
			//SGR 썸네일API 실행
			<%--function onThumbAPIReady() {
			    thumbApi.ready();
			};--%>
			
			//펫TV 홈 이동
			function fncGoPetTvHome() {
				location.href='/tv/home';
			}
			
			//펫스쿨 상세화면 이동
			function fncGoPetSchoolDetail(vd_id) {
				/* APP에서 펫스쿨 상세 기존 onNewPage 호출 ==> 페이지 호출방식으로 변경 / 펫스쿨 상세는 pc, mo, app 모두 호출방식 동일함.
				if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true"){
					// 데이터 세팅
					toNativeData.func = "onNewPage";
					toNativeData.type = "TV";
					toNativeData.url = "${view.stDomain}/tv/school/indexTvDetail?vdId="+ vd_id;
					// APP 호출
					toNative(toNativeData);
				}else{*/
					location.href = "/tv/school/indexTvDetail?vdId="+ vd_id;
					//storageHist.goBack("/tv/school/indexTvDetail?vdId="+ vd_id);
				//}
			}
			
			//펫TV 상세화면 이동
			function fncGoPetTvDetail(vd_id) {
				if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true"){
					// 데이터 세팅
					toNativeData.func = "onNewPage";
					toNativeData.type = "TV";
					toNativeData.url = "${view.stDomain}/tv/series/indexTvDetail?vdId="+ vd_id +"&sortCd=&listGb=RECENT";
					// APP 호출
					toNative(toNativeData);
				}else{
					location.href = "/tv/series/indexTvDetail?vdId="+ vd_id +"&sortCd=&listGb=RECENT";
					//storageHist.goBack("/tv/series/indexTvDetail?vdId="+ vd_id +"&sortCd=&listGb=RECENT");
				}
			}
			
			//최근 본 영상 삭제
			function fncDelRecentVdo(vd_id){
				$.ajax({
					type: 'POST',
					url: '/tv/series/deleteRecentVdo',
					async: false,
					dataType: 'json',
					data : {
						vdId : vd_id //영상ID
					},
					success: function(data) {
						if(data.actGubun == "success"){
							$("#item_"+vd_id).remove();
							
							ui.toast("최근 본 영상이 삭제되었어요.", {
								bot:70
							});
						}else{
							ui.toast("최근 본 영상목록에서 삭제에 실패했어요.", {
								bot:70
							});
						}
						
						var itemLng = $(".watch-movie .item").length;
						if(itemLng == 0){
							$(".no_data").removeAttr("style");
							$(".watch-movie").css("display", "none");
						}
						
						userActionLog(vd_id, "delete"); //클릭 이벤트-최근 본 영상 삭제
					},
					error: function(request,status,error) {
						ui.alert("오류가 발생되었습니다. 다시 시도하여 주십시오.");
					}
				});
			}
			
		</script>		
	</tiles:putAttribute>
	
	<%-- 
	Tiles content put
	--%>			
	<tiles:putAttribute name="content">
		<!-- content 내용 부분입니다.	-->	
		<main class="container lnb page my" id="container">
			<!-- mobile -->
			<!-- <div class="pageHead heightNone">
				<div class="inr">
					<div class="hdt">
						<button class="back" type="button">뒤로가기</button>
					</div>
					<div class="cent t2"><h2 class="subtit">최근 본 영상</h2></div>
				</div>
			</div> -->
			<!-- // mobile -->
			
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<!-- PC 타이틀 영역 -->
					<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
						<%-- <tiles:putAttribute name="header.title"/> --%>
						
						<div class="pc-tit">
							<h2>최근 본 영상</h2>
						</div>
					</c:if>
					<!-- PC 타이틀 영역 -->
					
					<!-- 컨텐츠가 없을 경우 style 제거 -->
					<section class="no_data i5" <c:if test="${not empty recentVdoList && fn:length(recentVdoList) > 0 }">style="display:none;"</c:if>>
						<div class="inr">
							<div class="msg">
								최근 본 영상이 없습니다.<br />
								반려동물과 함께하는 <strong><spring:message code='front.web.view.new.menu.tv'/></strong>를 시청해보세요. <!-- APET-1250 210728 kjh02  -->
							</div>
							<div class="uimoreview">
								<a href="#" class="bt more" onclick="fncGoPetTvHome(); return false;" data-content="${session.mbrNo }" data-url="/tv/home"><spring:message code='front.web.view.new.menu.tv'/>  바로가기</a> <!-- APET-1250 210728 kjh02  -->
							</div>
						</div>
					</section>
					<!-- 컨텐츠가 없을 경우 style 제거 -->
					
					<!-- 최근 싱청한 영상  -->
					<div class="watch-movie" <c:if test="${empty recentVdoList || fn:length(recentVdoList) == 0 }">style="display:none;"</c:if>>
						<c:if test="${not empty recentVdoList }">
							<c:forEach items="${recentVdoList }" var="list" varStatus="status">
								<c:if test="${list.vdGbCd eq '10' }">
									<div class="item" id="item_${list.vdId }">
										<div class="movie">
											<a href="#" onClick="fncGoPetSchoolDetail('${list.vdId }'); return false;" data-content="${list.vdId }" data-url="/tv/school/indexTvDetail?vdId=${list.vdId }">
												<%-- <div class="vthumbs" video_id="${list.acdOutsideVdId }" type="image"></div> --%>
												<%-- <img src="https://pmbaxtsxxtzz5736608.cdn.ntruss.com/vod/${list.acdOutsideVdId}/video.png" alt=""> --%>
												<img src="${fn:indexOf(list.acPrflImgPath, 'cdn.ntruss.com') > -1 ? list.acPrflImgPath : frame:optImagePath(list.acPrflImgPath, frontConstants.IMG_OPT_QRY_570) }" alt="">
											</a>
											<c:if test="${list.progressBar > 9 }">
												<p class="progressbar" style="width: ${list.progressBar }%">동영상 진행 상태</p>
											</c:if>
										</div>
										<div class="text-box">
											<p class="t1 singleline">${list.ctgMnm }</p>
											<p class="t2">
												<a href="#" onClick="fncGoPetSchoolDetail('${list.vdId }'); return false;" data-content="${list.vdId }" data-url="/tv/school/indexTvDetail?vdId=${list.vdId }">${list.ttl }</a>
											</p>
											<a href="#" class="btn close" onClick="fncDelRecentVdo('${list.vdId }'); return false;">삭제</a>
										</div>
									</div>
								</c:if>
								<c:if test="${list.vdGbCd eq '20' }">
									<div class="item" id="item_${list.vdId }">
										<div class="movie">
											<a href="#" onClick="fncGoPetTvDetail('${list.vdId }'); return false;" data-content="${list.vdId }" data-url="/tv/series/indexTvDetail?vdId=${list.vdId }&sortCd=&listGb=RECENT">
												<img src="${fn:indexOf(list.acPrflImgPath, 'cdn.ntruss.com') > -1 ? list.acPrflImgPath : frame:optImagePath(list.acPrflImgPath, frontConstants.IMG_OPT_QRY_570) }" alt="">
											</a>
											<div class="time">${list.acTotTimeStr }</div>
											<c:if test="${list.progressBar > 9 }">
												<p class="progressbar" style="width: ${list.progressBar }%">동영상 진행 상태</p>
											</c:if>
										</div>
										<div class="text-box">
											<p class="t1 singleline">${list.srisNm }</p>
											<p class="t2">
												<a href="#" onClick="fncGoPetTvDetail('${list.vdId }'); return false;" data-content="${list.vdId }" data-url="/tv/series/indexTvDetail?vdId=${list.vdId }&sortCd=&listGb=RECENT">${list.ttl }</a>
											</p>
											<div class="box">
												<%--운영오픈으로인해 잠시 주석처리-추후에 주석 제거
												<p class="play">${list.hits }</p>--%>
												<p class="like" style="margin-left:0px;" data-read-like="${list.vdId }"><fmt:formatNumber type="number" value="${list.likeCnt }"/></p>
											</div>
											<a href="#" class="btn close" onClick="fncDelRecentVdo('${list.vdId }'); return false;">삭제</a>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</c:if>
					</div>
					<!-- // 최근 싱청한 영상  -->
				</div>
			</div>
		</main>
		
		<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
        	<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
	        	<jsp:param name="floating" value="talk" />
	        </jsp:include>
        </c:if>

		<div class="layers">
			<!-- 레이어팝업 넣을 자리 -->
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>