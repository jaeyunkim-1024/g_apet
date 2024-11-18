 <c:forEach var="reply" items="${replyList}">
	<li class="reply-item">
		<div class="pic">
			<img class="thumb" data-original="${frame:imagePath(reply.prflImg)}" src="${frame:imagePath(reply.prflImg)}" alt="">
		</div>
		<div class="con">
			<div class="tit">${reply.nickNm}</div>
			<div class="txt" id="text_${reply.patiNo}" name="aplyText">${reply.enryAply}</div>
			<div class="date" id="rewrite_${reply.patiNo}" style="display:none;"></div>
			<div class="date update-time" id="date_${reply.patiNo}" data-original="${reply.sysRegDtm}">${reply.sysRegDtm}</div>
		</div>
		<c:if test="${session.mbrNo eq reply.mbrNo}">
			<div class="menu dopMenuIcon" onclick="ui.popSel.open(this)" id="mbrReply_${reply.patiNo}">
				<div class="popSelect r">
					<input type="text" class="popSelInput" id="adminHideArea1">
					<div class="popSelInnerWrap">
						<ul>
							<c:choose>
								<c:when test="${session.mbrNo eq reply.mbrNo}">
									<li class="aply-act" data-pati-no="${reply.patiNo}" onclick="aply.update(${reply.patiNo})"><a class="bt" href="javascript:;"><b class="t">수정</b></a></li>
									<li onclick="aply.del(${reply.patiNo})"><a class="bt" href="javascript:;"><b class="t">삭제</b></a></li>
								</c:when>
								<c:otherwise>
									<li onclick="aply.rpt(${reply.patiNo})" data-pati-no="${reply.patiNo}" ><a class="bt" href="javascript:;"><b class="t">신고</b></a></li>
								</c:otherwise>
							</c:choose>
						</ul>
					</div>
				</div>
			</div>
		</c:if>
	</li>
</c:forEach>