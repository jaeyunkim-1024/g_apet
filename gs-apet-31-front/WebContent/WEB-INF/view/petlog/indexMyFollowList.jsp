<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<tiles:insertDefinition name="noheader_mo">
	
	<tiles:putAttribute name="script.include" value="script.petlog"/> <!-- 지정된 스크립트 적용 -->
	<%-- 
	Tiles script.inline put
	불 필요시, 해당 영역 삭제 
	--%>
	<tiles:putAttribute name="script.inline">
	<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">	
	<script>
	$(document).ready(function(){
		$("#header_pc").removeClass("mode0");	
		$("#header_pc").addClass("mode6");
		$("#header_pc").addClass("noneAc");
		$(".mo-heade-tit .tit").html("${petLogUser.nickNm}");
		$(".mo-header-btnType01").text("");
	});
	</script>
</c:if>
	<script>
	$(document).ready(function(){
		// 탭 선택.
		$( "#"+ "${tabGb}"+ "Tab").click();
		setTimeout(function(){
			ui.tapTouchAc.tab_height($(".uiTab_content > ul"));
		}, 600);
		
		//temp 퍼블 수정 필요
		$(".uiTab > li").click(function(){
			setTimeout(function(){
				ui.tapTouchAc.tab_height($(".uiTab_content > ul"));
			}, 600);
		})
	});

	
	//PC , mWeb 브라우저 뒤로가기 시 변경사항이 있다면 reload
	window.onpageshow = function(event){
		if((event.persisted || window.performance.navigation.type == 2) 
				&& "${view.deviceGb}" != "${frontConstants.DEVICE_GB_30}"){
			if($.cookie("reloadYn")){
				$.removeCookie("reloadYn" , {path:"/"})
				location.reload();
			}					
		}
	} 
	
	</script>
	</tiles:putAttribute>
	
	<%-- 
	Tiles content put
	--%>			
	<tiles:putAttribute name="content"> 
		<main class="container page 1dep 2dep" id="container">
			<div class="inr">
				
				<!-- 본문 -->
				<div class="contents" id="contents">
					<%-- <!-- 페이지 헤더 -->
						<ul class="uiTab a line">
							<li class="active">
								<a class="bt" href="javascript:;">
									팔로워 
									<span>0</span>
								</a>
							</li>
							<li class="">
								<a class="bt active" href="javascript:;">
									팔로잉
									<span>392</span>
								</a>
							</li>
						</ul>
					<!-- // 페이지 헤더 --> --%>
					<section class="log_listviewTop">
						<div class="pic">
							<a href="/log/indexMyPetLog/${petLogUser.petLogUrl}?mbrNo=${petLogUser.mbrNo}"><img src="${petLogUser.prflImg eq null or petLogUser.prflImg eq '' ? '../../_images/common/icon-img-profile-default-m@2x.png' : frame:optImagePath(petLogUser.prflImg, frontConstants.IMG_OPT_QRY_786)}" alt=""></a>
						</div>
						<h1><a href="/log/indexMyPetLog/${petLogUser.petLogUrl}?mbrNo=${petLogUser.mbrNo}">${petLogUser.nickNm}</a></h1>
					</section>
					<!-- tab -->
					<section class="sect petTabContent hmode_auto follow mode_fixed">
						<ul class="uiTab a line">
							<li class="active" id="followerTab">
								<a class="bt active" href="javascript:;"><spring:message code='front.web.view.petlog.follow.title' /> <span>${followerCnt}</span></a>
							</li>
							<li class="" id="followingTab">
								<a class="bt" href="javascript:;"><spring:message code='front.web.view.petlog.following.title' /> <span>${followingCnt}</span></a>
							</li>
						</ul>
						<div class="uiTab_content">
							<ul>
<!-- 팔로워  -->
<c:choose>
	<c:when test="${followerCnt > 0}">							
								<li>
									<section class="follow-listBox">
										<ul>
		<c:forEach items="${followerList }" var="petLogBase" varStatus="status">
											<li>
												<a href="/log/indexMyPetLog/${petLogBase.petLogUrl}?mbrNo=${petLogBase.mbrNo}">
												<span class="pic">
													<img src="${petLogBase.prflImg eq null or petLogBase.prflImg eq '' ? '../../_images/common/icon-img-profile-default-m@2x.png' : frame:optImagePath(petLogBase.prflImg, frontConstants.IMG_OPT_QRY_786)}" alt="">
<!-- 													<img src="../../_images/_temp/temp_logDogImg03.png" alt="">									 -->
												</span>
												<span class="nick">${petLogBase.nickNm}</span>
												</a>
			<c:if test="${session.mbrNo ne petLogBase.mbrNo}">			
				<c:choose>
					<c:when test="${petLogBase.followYn ne null and petLogBase.followYn eq 'Y'}">
													<button href="javascript:;" onclick="saveFollowMapMember('${petLogBase.mbrNo}', 'D' , this);" class="btn c" id="D_${petLogBase.mbrNo}"><spring:message code='front.web.view.petlog.following.title' /></button>
					</c:when>
					<c:otherwise>
													<button href="javascript:;" onclick="saveFollowMapMember('${petLogBase.mbrNo}', 'I', this);" class="btn a" id="I_${petLogBase.mbrNo}"><spring:message code='front.web.view.petlog.follow.title' /></button>
					</c:otherwise>
				</c:choose>	
			</c:if>								
											</li>
		</c:forEach>	
										</ul>
									</section>	
								</li>
	</c:when>
	<c:otherwise>
							<li>
								<div class="noneBoxPoint p3" style="height:calc(100vh - 157px)">
									<!-- no data -->
									<section class="no_data i1">
										<div class="inr">
											<div class="msg"><spring:message code='front.web.view.petlog.follow.notyet.msg.friend' /></div>
										</div>
									</section>
									<!-- // no data -->
								</div>
							</li>
	</c:otherwise>
</c:choose>	
<!-- 팔로잉  -->
<c:choose>
	<c:when test="${followingCnt > 0}">							
								<li>
									<section class="follow-listBox">
										<ul>

		<c:forEach items="${followingList }" var="petLogBase" varStatus="status">
											<li>
												<c:set var="nickLink" value="${view.stDomain}/log/indexMyPetLog/${petLogBase.petLogUrl}?mbrNo=${petLogBase.followedNo}" />
			<c:if test="${petLogBase.followType eq 'T'}">
												<c:set var="nickLink" value="${view.stDomain}/log/indexPetLogTagList?tag=${petLogBase.followedNm}" />
			</c:if>									
												<a href="${nickLink}">
													<span class="pic">
			<c:if test="${petLogBase.followType eq 'M'}">			
													<img src="${petLogBase.prflImg eq null or petLogBase.prflImg eq '' ? '../../_images/common/icon-img-profile-default-m@2x.png' : frame:optImagePath(petLogBase.prflImg, frontConstants.IMG_OPT_QRY_786)}" alt="">
			</c:if>													
													</span>
													<span class="nick">${petLogBase.followedNm}</span>
												</a>
			<c:choose>
				<c:when test="${petLogBase.followType eq 'M'}">
					<c:if test="${session.mbrNo ne petLogBase.followedNo}">
						<c:choose>
							<c:when test="${petLogBase.followYn ne null and petLogBase.followYn eq 'Y'}">
													<button href="javascript:;" onclick="saveFollowMapMember('${petLogBase.followedNo}', 'D' , this);" class="btn c" id="DW_${petLogBase.followedNo}"><spring:message code='front.web.view.petlog.following.title' /></button>
							</c:when>
							<c:otherwise>
													<button href="javascript:;" onclick="saveFollowMapMember('${petLogBase.followedNo}', 'I', this);" class="btn a" id="IW_${petLogBase.followedNo}"><spring:message code='front.web.view.petlog.follow.title' /></button>
							</c:otherwise>
						</c:choose>
					</c:if>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${petLogBase.followYn ne null and petLogBase.followYn eq 'Y'}">
													<button href="javascript:;" onclick="saveFollowMapTag('${petLogBase.followedNo}', 'D' , this);" class="btn c" id="DW_${petLogBase.followedNo}"><spring:message code='front.web.view.petlog.following.title' /></button>
						</c:when>
						<c:otherwise>
													<button href="javascript:;" onclick="saveFollowMapTag('${petLogBase.followedNo}', 'I' , this);" class="btn a" id="IW_${petLogBase.followedNo}"><spring:message code='front.web.view.petlog.follow.title' /></button>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
											</li>
		</c:forEach>	
										</ul>
									</section>	
								</li>		
	</c:when>
	<c:otherwise>
								<li>
										<div class="noneBoxPoint p3" style="height:calc(100vh - 157px)">
										<!-- no data -->
										<section class="no_data i1">
											<div class="inr">
												<div class="msg"><spring:message code='front.web.view.petlog.following.notyet.msg.friend' /></div>
											</div>
										</section>
										<!-- // no data -->
									</div>
								</li>	
	</c:otherwise>
</c:choose>	
							</ul>
						</div>
					</section>
					<!-- // tab -->
				</div>
				
			</div>
		</main>
		
<%--         <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}"> --%>
<%--         	<jsp:include page="/WEB-INF/tiles/include/floating.jsp"> --%>
<%-- 	        	<jsp:param name="floating" value="talk" /> --%>
<%-- 	        </jsp:include> --%>
<%--         </c:if>		 --%>
		
	</tiles:putAttribute>
	
</tiles:insertDefinition>