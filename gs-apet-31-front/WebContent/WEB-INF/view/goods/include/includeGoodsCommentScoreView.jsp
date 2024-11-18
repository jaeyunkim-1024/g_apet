<div class="starpan">
	<div class="inr">
		<div class="ptbox">
			<div class="pnt"><fmt:formatNumber value="${not empty scoreList.estmAvg ? scoreList.estmAvg/2 : 0}" pattern="0.0"/> </div>
			<div class="sta starpoint"><span class="stars p_${fn:replace(scoreList.estmAvgStar, ".", "_") }"></span></div>
		</div>
		<div class="ptlit">
			<ul class="plist">
				<c:forEach var="score" items="${scoreList.goodsCommentScoreVOList}" varStatus="status">
				<li class="${score.maxYn eq 'Y' ? 'act' : '' }" >
					<span class="pnt"><b class="p"><c:out value="${score.estmScore}" /></b><i class="w">점</i></span>
					<span class="gage"><em class="bar" style="width: ${score.scoreTotal != 0 && scoreList.scoreTotal != 0 ? score.scoreTotal / scoreList.scoreTotal * 100 : 0}%;"></em></span>
					<span class="pct"><b class="p"><fmt:formatNumber value="${score.scoreTotal != 0 && scoreList.scoreTotal != 0 ? score.scoreTotal / scoreList.scoreTotal * 100 : 0}" pattern="##"/> </b><i class="w">%</i></span>
				</li>
				</c:forEach>
			</ul>
		</div>
	</div>
	<div class="infs">
		<ul class="iflist">
			<c:forEach var="estm" items="${estmList}">
				<li>
					<div class="ht"><span class="tt">${estm.qstClsf }</span></div>
					<div class="dd">
						<span class="tt">"${estm.itemContent }"</span>
						<span class="ss"><fmt:formatNumber value="${estm.estmAvg }" pattern="##"/>% (${not empty estm.estmCnt? estm.estmCnt : 0 }명)</span>
					</div>
				</li>
			</c:forEach>
		</ul>
	</div>
</div>
<div class="rvdetail">
	<ul class="drvlist">
		<c:forEach var="estm" items="${estmList}">
			<li>
				<div class="hdd"><em class="t">${estm.qstClsf }</em></div>
				<ul class="prlist">
					<c:forEach var="estmDetail" items="${estm.estmQstVOList}">
						<li class="${estm.maxQst eq estmDetail.estmItemNo? 'act':''}">
							<span class="pnt"><b class="p">${estmDetail.itemContent }</b></span>
							<span class="gage"><em class="bar" style="width: ${not empty estm.estmTotal && not empty estmDetail.estmCnt ? estmDetail.estmCnt / estm.estmTotal * 100: 0}%;"></em></span>
							<span class="pct"><b class="p"><fmt:formatNumber value="${not empty estm.estmTotal && not empty estmDetail.estmCnt ? estmDetail.estmCnt / estm.estmTotal * 100: 0}" pattern="##"/></b><i class="w">%</i></span>
						</li>
					</c:forEach>
				</ul>
			</li>
		</c:forEach>
	</ul>
	<div class="btnmore"><button type="button" class="bt view" data-ui-revmore='more'>자세히보기</button></div>
</div>