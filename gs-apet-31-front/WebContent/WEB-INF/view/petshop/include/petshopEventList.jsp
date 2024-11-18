<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.include" value="script.petshop"/>
	<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">	
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">
			$(document).ready(function(){
				$(".mo-header-backNtn").attr("onClick", "goPetShopMain();");
			});	
		</script>
	</tiles:putAttribute>
	</c:if>
	<tiles:putAttribute name="content">
		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container lnb page shop hm event" id="container">
		<div class="pageHeadPc lnb"></div>
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<section class="sect ct event">
						<ul class="list">
							<c:forEach var="bannerList" items="${bannerList }">
							<li>
								<div class="gdset event">
									<c:if test="${fn:indexOf(bannerList.bnrLinkUrl, '/event/detail') == -1}">
										<a href="${bannerList.bnrLinkUrl}" class="box">
											<img class="img mo" src="${frame:optImagePath(bannerList.bnrMobileImgPath, frontConstants.IMG_OPT_QRY_743)}" alt="">
											<img class="img pc" src="${frame:optImagePath(bannerList.bnrImgPath, frontConstants.IMG_OPT_QRY_779)}" alt="">
										</a>
									</c:if>
									<c:if test="${fn:indexOf(bannerList.bnrLinkUrl, '/event/detail') > -1}">
										<a href="${bannerList.bnrLinkUrl}&returnUrl=${requestScope['javax.servlet.forward.servlet_path']}" class="box">
											<img class="img mo" src="${frame:optImagePath(bannerList.bnrMobileImgPath, frontConstants.IMG_OPT_QRY_743)}" alt="">
											<img class="img pc" src="${frame:optImagePath(bannerList.bnrImgPath, frontConstants.IMG_OPT_QRY_779)}" alt="">
										</a>
									</c:if>
								</div>
							</li>
							</c:forEach>
						</ul>
					</section>
				</div>
			</div>
		</main>
	</tiles:putAttribute>	
</tiles:insertDefinition>