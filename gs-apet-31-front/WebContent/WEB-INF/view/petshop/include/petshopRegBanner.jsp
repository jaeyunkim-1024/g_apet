<c:forEach var="cornerList" items="${totalCornerList}"  varStatus="status" >
	<c:if test="${param.dispCornNo == cornerList.dispCornNo }">
		<!-- 반려동물 등록 -->
		<section class="sect mn petsb">
			<div class="hdts">
				<div class="hdt" ><span class="tit"><em class="b"><spring:message code='front.web.view.join.info.pet.question.result.title'/> </em><spring:message code='front.web.view.join.info.pet_with.question.result.title'/></span></div>
			</div>
			<div class="bnbox dog">
				<div class="tit"><spring:message code='front.web.view.join.info.mypet_input.msg.title'/><br><spring:message code='front.web.view.join.info.mypet_input_contents.msg.title'/></div>
				<div class="bts"><a href="javascript:void(0);" class="bt reg" data-content="" onClick="location.href='/my/pet/petInsertView'" data-url="/my/pet/petInsertView">마이펫 등록하기</a></div>
			</div>
		</section>
	</c:if>
</c:forEach>