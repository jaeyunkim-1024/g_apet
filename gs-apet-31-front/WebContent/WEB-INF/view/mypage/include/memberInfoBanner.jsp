<section class="sect top">
	<dl>
		<dt class="pic">
			<c:choose>
				<c:when test="${not empty prflImg}">
					<img class="thumb"  src="${frame:optImagePath(prflImg, frontConstants.IMG_OPT_QRY_794)}" class="img" onclick="${view.deviceGb ne frontConstants.DEVICE_GB_10 ? 'location.href=\'/indexMyInfo\'' : ''}">
<%-- 					<img class="thumb"  src="${frame:imagePath(prflImg) }" class="img" onclick="${view.deviceGb ne frontConstants.DEVICE_GB_10 ? 'location.href=\'/indexMyInfo?returnUrl=/mypage/indexMyPage\'' : ''}"> --%>
				</c:when>
				<c:otherwise>
					<img src="../../_images/common/icon-img-profile-default-m@2x.png" class="img"  onclick="${view.deviceGb ne frontConstants.DEVICE_GB_10 ? 'location.href=\'/indexMyInfo\'' : ''}">
<%-- 					<img src="../../_images/common/icon-img-profile-default-m@2x.png" class="img"  onclick="${view.deviceGb ne frontConstants.DEVICE_GB_10 ? 'location.href=\'/indexMyInfo?returnUrl=/mypage/indexMyPage\'' : ''}"> --%>
				</c:otherwise>
			</c:choose>
			
		</dt>
		<dd class="info-bx">
			<P>
				<span class="nm" onclick="${view.deviceGb ne frontConstants.DEVICE_GB_10 ? 'location.href=\'/indexMyInfo?returnUrl=/mypage/indexMyPage\'' : ''}">${session.nickNm }<spring:message code='front.web.view.common.member.info.banner.sir' /></span> <!-- mong2mom -->
				<button class="btn re" onclick="location.href='/mypage/info/indexManageCheck'" data-content="" data-url="/mypage/info/indexManageCheck"><spring:message code='front.web.view.common.update' /></button>
			</P>
			<ul class="data">
				<li>
					<span><spring:message code='front.web.view.common.member.info.banner.level' /></span>
					<c:choose>
						<c:when test="${session.mbrGrdCd eq frontConstants.MBR_GRD_10   }">
						<a class="rank_icon" href="javascript:rankBox();"><i class="label vvip"><spring:message code='front.web.view.common.member.info.banner.level.vvip' /></i></a>
						</c:when>
						<c:when test="${session.mbrGrdCd eq frontConstants.MBR_GRD_20   }">
						<a class="rank_icon" href="javascript:rankBox();"><i class="label vip"><spring:message code='front.web.view.common.member.info.banner.level.vip' /></i></a>
						</c:when>
						<c:when test="${session.mbrGrdCd eq frontConstants.MBR_GRD_30   }">
						<a class="rank_icon" href="javascript:rankBox();"><i class="label family"><spring:message code='front.web.view.common.member.info.banner.level.family' /></i></a>
						</c:when>
						<c:otherwise>
						<a class="rank_icon" href="javascript:rankBox();"><i class="label welcome"><spring:message code='front.web.view.common.member.info.banner.level.welcome' /></i></a>
						</c:otherwise>
					</c:choose>
				</li>
				<li>
					<span id="gsPointTit" ><spring:message code='front.web.view.common.member.info.banner.gs' />&amp;<spring:message code='front.web.view.common.member.info.banner.point' /></span>
					
					<%-- <c:choose>
					<c:when test="${session.certifyYn != 'Y' or session.gsptNo == null }">
						<a href="javascript:okCertPopup('01',${session.mbrNo} );" class="bt point">포인트조회</a>
					</c:when>
					<c:otherwise>
						<em class="blue" id="gsPoint">${gsPoint }</em>P 
					</c:otherwise>
					</c:choose> --%>
				</li>
			</ul>
		</dd>
	</dl>
</section>