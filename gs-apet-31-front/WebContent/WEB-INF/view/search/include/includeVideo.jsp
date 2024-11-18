<c:forEach items="${result.videoList}" var="video" varStatus="idx" >
<div class="item scrhItem tv${video.vd_id}">
	<div class="movie" onclick="searchResult.goVideo('${video.vd_id}')">
		<c:choose>
			<c:when test="${fn:indexOf(video.vd_id, 'E') > -1 }">
				<img src="${fn:indexOf(video.thum_path, 'cdn.ntruss.com') > -1 ? frame:optImagePathSgr(video.thum_path, frontConstants.IMG_OPT_QRY_720) : frame:optImagePath(video.thum_path, frontConstants.IMG_OPT_QRY_720)}" alt="${video.thum_path}">
			</c:when>
			<c:otherwise>
				<img src="${fn:indexOf(video.thum_path, 'cdn.ntruss.com') > -1 ? video.thum_path : frame:optImagePath(video.thum_path, frontConstants.IMG_OPT_QRY_720)}" alt="${video.thum_path}">\
				<div class="time">
					${video.vd_lnth}
				</div>
			</c:otherwise>
		</c:choose>
	</div>
	<div class="text-box">
		<!-- <p class="t1">시리즈명노출영역</p> -->
		<p class="t2" id="videoTtl" onclick="searchResult.goVideo('${video.vd_id}')">${fn:replace(video.ttl, 'amp;', '')}</p>
		<div class="box">
			<!--<p class="play">${video.hits}</p>-->
			<p class="like">${video.like_cnt}</p>
		</div>
	</div>
</div>
</c:forEach>
