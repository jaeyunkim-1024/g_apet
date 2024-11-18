<c:forEach var="cornerList" items="${totalCornerList}"  varStatus="status" >
	<c:if test="${param.dispCornNo == cornerList.dispCornNo }">
		<!-- 미로그인 배너 -->
		<section class="sect mn nlogn">
			<div class="hdts">
				<div class="hdt" ><span class="tit"><em class="b"><spring:message code='front.web.view.common.aboutPet.title'/></em><spring:message code='front.web.view.petshop.reg.member.banner.first.time'/></span></div>
			</div>
			<div class="bnbox">
				<div class="tit"><spring:message code='front.web.view.petshop.reg.member.banner.join.benefit'/></div>
				<div class="bts"><a href="/join/indexTerms" data-content="" data-url="/join/indexTerms" class="bt reg"><spring:message code='front.web.view.petshop.reg.member.banner.go.to.join'/></a></div>
			</div>
		</section>
	</c:if>
</c:forEach>