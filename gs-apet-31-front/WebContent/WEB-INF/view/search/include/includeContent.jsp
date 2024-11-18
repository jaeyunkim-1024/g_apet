<c:forEach items="${result.contentList}" var="content" varStatus="idx" >
	<li class="scrhItem lc${content.pet_log_no}">
		<a href="javascript:searchResult.goContent('${content.pet_log_no}')" class="logPicBox">
			<c:choose>
				<c:when test="${empty content.vd_thum_path}">
					<span class="logIcon_pic <c:if test="${content.img_path2 != null && content.img_path2 != '' }">i02</c:if>"></span>
					<img src="${fn:indexOf(content.img_path1, 'cdn.ntruss.com') > -1 ? content.img_path1 : frame:optImagePath(content.img_path1, frontConstants.IMG_OPT_QRY_730)}" alt="${content.img_path1}" onerror="this.src='../../_images/common/icon-img-profile-default-m@2x.png'">
				</c:when>
				<c:otherwise>
					<span class="logIcon_pic i01"></span>
					<img src="${fn:indexOf(content.vd_thum_path, 'cdn.ntruss.com') > -1 ? frame:optImagePathSgr(content.vd_thum_path, frontConstants.IMG_OPT_QRY_730) : frame:optImagePath(content.vd_thum_path, frontConstants.IMG_OPT_QRY_730)}" alt="${content.vd_thum_path}" onerror="this.src='../../_images/common/icon-img-profile-default-m@2x.png'">
				</c:otherwise>
			</c:choose>
		</a>
	</li>
</c:forEach>