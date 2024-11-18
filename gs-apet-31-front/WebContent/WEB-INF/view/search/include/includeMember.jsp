<c:forEach items="${result.memberList}" var="member" varStatus="idx" >
	<li class="scrhItem lm${member.mbr_no}" onclick="searchResult.goMember('${member.pet_log_url}','${member.mbr_no}')">
		<p class="img"><img src="${fn:indexOf(member.prfl_img, 'cdn.ntruss.com') > -1 ? member.prfl_img : frame:optImagePath(member.prfl_img, frontConstants.IMG_OPT_QRY_710)}" alt="${member.prfl_img}" onerror="this.src='../../_images/common/icon-img-profile-default-m@2x.png'"></p>
		<div class="txt">
			<p class="t1">${member.nick_nm}</p>
			<p class="t2">
				<span>게시물 ${member.log_cnt}</span>
				<span>팔로워 ${member.follow_cnt}</span>
			</p>
		</div> 
	</li>
</c:forEach>
	
		