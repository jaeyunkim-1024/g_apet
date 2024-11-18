<ul class="alist" style="max-height:320px;">
	<c:if test = "${fn:length(pushList) > 0 }">
		<c:forEach items ="${pushList }" var="push">
			<c:choose>
				<c:when test ="${push.ctgCd eq frontConstants.CTG_60 }">
					<li class="tv">								
				</c:when>
				<c:when test ="${push.ctgCd eq frontConstants.CTG_70 }">
					<li class="log">								
				</c:when>
				<c:when test ="${push.ctgCd eq frontConstants.CTG_80 }">
					<li class="shop">								
				</c:when>
				<c:when test ="${push.ctgCd eq frontConstants.CTG_90 }">
					<li class="cm">								
				</c:when>
				<c:when test ="${push.ctgCd eq frontConstants.CTG_100 }">
					<li class="live">								
				</c:when>
				<c:otherwise>
					<li class="ev">	
				</c:otherwise>
			</c:choose>
			<a href="${push.landingUrl }" class="box">
				<div class="aht"><em class="tt">${push.subject }</em> 
					<i class="tm">${push.strDateDiff }</i>
<%-- 				<c:if test = "${push.dateDiff ge 60}"> --%>
<%-- 					<i class="tm"><frame:timeCalculation time = "${push.dateDiff }" type="M"/>전</i>										 --%>
<%-- 				</c:if> --%>
<%-- 				<c:if test = "${push.dateDiff lt 60 }"> --%>
<!-- 					<i class="tm">방금</i>						 -->
<%-- 				</c:if> --%>
				</div>
				<div class="adt">
					<p class="msg">${push.contents }</p>
				</div>
			</a>
		</li>
		</c:forEach>
	</c:if>
	<c:if test = "${fn:length(pushList) <= 0 }">
	<li class="nodata">
		<p class="msg"><spring:message code='front.web.view.common.msg.no.new.notify' /></p>
	</li> 
	</c:if>
</ul>