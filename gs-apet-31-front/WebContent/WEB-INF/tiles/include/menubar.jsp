<script type="text/javascript">
	$(document).ready(function(){
		$("li[id^=liTag_]").one('click', function(){
			$(this).addClass("active");
	    });
		
	});
</script>

<nav class="menubar">
	<div class="inr">
		<ul class="menu">
		<!--  펫로그 파트너사인 경우 메뉴가 비활성 -->
		<c:choose>
			<c:when test="${not empty session.bizNo}">
				<li class="tv">
					<a class="bt"><span><spring:message code='front.web.view.new.menu.tv' /></span></a> <!-- APET-1250 210728 kjh02  -->
				</li>
				<li id="liTag_30" class="log ${fn:indexOf(session.reqUri, '/log/') > -1 ? fn:indexOf(session.reqUri, '/mypage/') > -1 ? '' : 'active' : ''}">
					<a href="/log/home/" class="bt"><span><spring:message code='front.web.view.new.menu.log' /></span></a> <!-- APET-1250 210728 kjh02  -->
				</li>
				<li class="shop">
					<a class="bt"><span><spring:message code='front.web.view.new.menu.store' /></span></a> <!-- APET-1250 210728 kjh02  -->
				</li>
				<li id="liTag_00" class="my ${fn:indexOf(session.reqUri, 'my') > -1  or fn:indexOf(session.reqUri, '/indexTvRecentVideo') > -1 ? 'active' : '' }">
					<a href="/log/partnerPswdUpdate?returnUrl=/log/home" class="bt"><span>MY</span></a>
				</li>
			</c:when>
			<c:otherwise>
				<li id="liTag_20" class="tv ${fn:indexOf(session.reqUri, '/tv/') > -1 ? fn:indexOf(session.reqUri, '/mypage/') > -1 or fn:indexOf(session.reqUri, '/indexTvRecentVideo') > -1 ? '' : 'active' : ''}">
					<a href="javascript:void(0);" onclick="location.href='${view.stDomain}/tv/home/'" class="bt"><span><spring:message code='front.web.view.new.menu.tv' /></span></a> <!-- APET-1250 210728 kjh02  -->
				</li>
				<li id="liTag_30" class="log ${fn:indexOf(session.reqUri, '/log/') > -1 ? fn:indexOf(session.reqUri, '/mypage/') > -1 ? '' : 'active' : ''}">
					<a href="javascript:void(0);" onclick="location.href='${view.stDomain}/log/home/'" class="bt"><span><spring:message code='front.web.view.new.menu.log' /> </span></a> <!-- APET-1250 210728 kjh02  -->
				</li>
				<li id="liTag_10" class="shop ${(fn:indexOf(session.reqUri, '/shop/') > -1 or fn:indexOf(session.reqUri, '/goods/') > -1 or fn:indexOf(session.reqUri, '/brand/') > -1 or fn:indexOf(session.reqUri, '/event/shop') > -1 or fn:indexOf(session.reqUri, 'Exhibition') > -1) ? fn:indexOf(session.reqUri, '/mypage/') > -1 ? '' : 'active' : ''}">
					<a href="javascript:void(0);" onclick="location.href='${view.stDomain}/shop/home/'" class="bt"><span><spring:message code='front.web.view.new.menu.store' /></span></a> <!-- APET-1250 210728 kjh02  -->
				</li>
				<li id="liTag_00" class="my ${fn:indexOf(session.reqUri, 'my') > -1  or fn:indexOf(session.reqUri, '/indexTvRecentVideo') > -1 ? 'active' : '' }">
					<a href="javascript:void(0);" onclick="location.href='${view.stDomain}/mypage/indexMyPage/'" class="bt"><span>MY</span></a>
				</li>
			</c:otherwise>
		</c:choose>
		</ul>
	</div>
</nav>