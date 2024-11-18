<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<tiles:insertDefinition name="mypage_mo_nofooter">

	<tiles:putAttribute name="script.include" value="script.petlog"/> <!-- 지정된 스크립트 적용 -->
	
	<tiles:putAttribute name="script.inline">
	<script>
		$(function(){
			var hTimer = setInterval(function(){
				$("#header_pc .tmenu .list li:eq(1)").addClass("active").siblings().removeClass("active")
				if($("#header_pc").length) clearInterval(hTimer);
			});
		});
	</script>
	<script>
		
		function searchPetLogTagList(sort) {
			location.href = "${view.stDomain}/log/indexPetLogTagList?tag=${so.tag}&sidx="+sort;
		}
		
	</script>
<c:choose>
<c:when test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
	<script>
	$(document).ready(function(){
		$(".lnb.my").hide();
	});	
	</script>	
</c:when>		
<c:otherwise>	
	<script>
	$(document).ready(function(){
		$("#header_pc").removeClass("mode0");	
		$("#header_pc").addClass("mode6");
		$(".mo-heade-tit .tit").html("#"+"${so.tag}");
	<c:choose>
		<c:when test="${tagFollowYn ne null and tagFollowYn eq 'Y'}">
			$(".mo-header-btnType01").text("<spring:message code='front.web.view.petlog.following.title' />");					
			$(".mo-header-btnType01").attr("onClick","saveFollowMapTag('${so.tagNo}', 'D' , this);");	
		</c:when>
		<c:otherwise>
			$(".mo-header-btnType01").text("<spring:message code='front.web.view.petlog.follow.title' />");					
			$(".mo-header-btnType01").attr("onClick","saveFollowMapTag('${so.tagNo}', 'I', this);");	
		</c:otherwise>
	</c:choose>		
	
		// app 에서 document.referrer 없음 
		if("${requestScope['javax.servlet.forward.query_string']}".indexOf('&sidx=') > -1){
			$(".mo-header-backNtn").attr("onClick", "storageHist.getOut('/log/indexPetLogTagList');");
		}else{
			$(".mo-header-backNtn").attr("onClick", "storageHist.goBack();");
		}
	 
		
		
	});
	</script>
</c:otherwise>
</c:choose>

 	<script>
	var petLogPage = 1;
	var result;
	var scrollPrevent = true;
	var pageRow = ${frontConstants.PAGE_ROWS_12};
		$(function(){
			result = $("#myPetLogList").find("li").length < pageRow ? false : true;
			
			$(window).on("scroll , touchmove" , function(){
				if($(window).scrollTop()+1 >= $(document).height() - $(window).height() - 100){
					if(result && scrollPrevent){
						petLogPage++;
						scrollPrevent = false;
						pagingPetLogTagList(petLogPage);
					}
				}					
			});
		});
	
		function goPetLogListT(selIdx , page){
			var viewIdx = selIdx;
			var page = Number(page);
			// 첫 페이지 24개 일 시 페이지 및 index set
			if(viewIdx >= 12){
				if(page == 1){
					viewIdx = viewIdx-12;					
				}
				page = page+1;
				 
			}
			location.href = "/log/indexPetLogList?pageType=T&selIdx="+viewIdx+"&tag=${so.tag}&sort=${so.sidx}&page="+page
		}
		
		
		
		function pagingPetLogTagList(petLogPage){
			var options = {
					url : "${view.stDomain}/log/indexPetLogTagList?tag=${so.tag}&sidx=${so.sidx}"
					, data : {
						page : petLogPage
					}
					, dataType : "html"
					, done : function(html){
						if($(html).find("li").length != 0){
							$("#myPetLogList").append($(html).find("script"));
							$("#myPetLogList").append($(html).find("li"));
							scrollPrevent = true;
							
							imgResize();
							thumbApi.ready();
						}
						if($(html).find("li").length < pageRow){
							result = false;
						}
					}
			}
			ajax.call(options);
		}
	</script>


	</tiles:putAttribute>

	<tiles:putAttribute name="content">

		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container page" id="container">
			<div class="inr">
				<!-- 본문 -->
				<div class="contents log my" id="contents">
 					<!-- 타이틀 -->
					<div class="logTagHeader">
						<div class="tit onWeb_b">
							<h1>
								#<c:out value='${so.tag}' />
							</h1>
							<c:choose>
								<c:when test="${tagFollowYn ne null and tagFollowYn eq 'Y'}">
									<button class="btn" onclick="saveFollowMapTag('${so.tagNo}', 'D' , this);"><spring:message code='front.web.view.petlog.following.title' /></button>
								</c:when>
								<c:otherwise>
									<button class="btn a" onclick="saveFollowMapTag('${so.tagNo}', 'I', this);"><spring:message code='front.web.view.petlog.follow.title' /></button>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="had">
							<div class="log-count-box"><spring:message code='front.web.view.petlog.log.title' />  <span><c:out value='${so.totalCount}' /><spring:message code='front.web.view.common.goods.count.number' /></span></div>
							<nav class="uisort">
								<button type="button" class="bt st" value="v_1"><spring:message code='front.web.view.petlog.newdate.sort.title' /></button>
								<div class="list">
									<ul class="menu">
										<li class="${so.sidx eq 'SYS_REG_DTM' ? 'active':''}"><button type="button" class="bt" value="v_1" onclick="searchPetLogTagList('SYS_REG_DTM');"><spring:message code='front.web.view.petlog.newdate.sort.title' /></button></li>
										<li class="${so.sidx eq 'LIKE_CNT' ? 'active':''}"><button type="button" class="bt" value="v_2" onclick="searchPetLogTagList('LIKE_CNT');"><spring:message code='front.web.view.petlog.like.sort.title' /></button></li>
									</ul>
								</div>
							</nav>
						</div>
					</div>
					<!-- // 타이틀 -->
					<!-- content -->
					<div class="logPicMetric">
							<ul id ="myPetLogList">
<c:forEach items="${tagPetLogList}" var="petLogBase" varStatus="idx">								
								<li>								
										<a href="javascript:goPetLogListT('${idx.index }' , '${so.page }')" class="logPicBox">
					<c:choose>
						<c:when test="${petLogBase.vdPath ne null and petLogBase.vdPath != ''}">
										<span class="logIcon_pic i01" style="z-index:1;"></span>
										<div class="vthumbs" video_id="${petLogBase.vdPath}" type="video_thumb" style="height:100%" uid="${petLogBase.mbrNo}|${session.mbrNo}"></div>
						</c:when>	
						<c:otherwise>
							<c:if test="${petLogBase.imgCnt > 1}">
										<span class="logIcon_pic i02"></span>
							</c:if>										
							<c:choose>
								<c:when test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
										<img src="${frame:optImagePath(petLogBase.imgPath1, frontConstants.IMG_OPT_QRY_490)}" alt="">
								</c:when>
								<c:otherwise>
										<img src="${frame:optImagePath(petLogBase.imgPath1, frontConstants.IMG_OPT_QRY_510)}" alt="">
								</c:otherwise>
							</c:choose>
<!--  										<img src="../../_images/_temp/temp_logimg001.jpg" alt=""> -->
						</c:otherwise>
					</c:choose>
										</a>
								</li>
</c:forEach>
							</ul>
						</div>
					</div>
					<!-- // content -->
					<!-- popup 내용 부분입니다. -->
					<!-- both popup -->
<!-- 					<div id="include_regist" class="commentBoxAp logpet" data-autoCloseUp="true" data-close="true" data-min="75px" data-max="180px" data-autoOpen="true" data-priceh="75px">data-priceh : 오픈 시 올라가는 높이 -->
<!-- 					</div> -->
					<!-- // both popup -->					
				</div>
			</div>
		</main>
		
		
		<script>
		var timer = null;
		function imgResize(){
			if(timer !== null) clearInterval(timer);
			timer = setInterval(function(){
				var max = $("#myPetLogList li").length;
				var img = $("#myPetLogList li img").length;
				var vid = $("#myPetLogList li video").length;
				//console.log("1max : " + max);
				//console.log("2img : " + img);
				//console.log("3vid : " + vid);
				if(max <= (img + vid)){
					$("#myPetLogList li").each(function(){
						$(this).find("img, video").height($(this).width());
					});
					$(".vthumbs>div>div>img").height("")
					clearInterval(timer);
				}
			},500);
		};
		
		$(function(){
			$(window).resize(imgResize);
			imgResize();
		});
		</script>
		
        <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
        	<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
	        	<jsp:param name="floating" value="talk" />
	        </jsp:include>
        </c:if>		
		
	</tiles:putAttribute>
	
<%-- 	<tiles:putAttribute name="layerPop">
		<jsp:include page="/WEB-INF/view/petlog/layerBottomRegist.jsp" />		
	</tiles:putAttribute> --%>
		
</tiles:insertDefinition>		
