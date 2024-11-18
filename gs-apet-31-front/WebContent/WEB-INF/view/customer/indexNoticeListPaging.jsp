	<c:forEach items="${noticeList }" var="notice">
		<li>
			<div class="hBox">
				<input type="hidden" name="intervalDay" value='${notice.intervalDay }'>
				<p>
					<span class="tit">${notice.bbsGbNm }${notice.ttl }</span>
				</p>
				<span class="date"><frame:date date="${notice.stringRegDtm }" type="C" /></span>
				<button type="button" class="btnTog" data-content="" data-url="">버튼</button>
			</div>
			<div class="cBox" style ="display:none;">
				${notice.content }
			</div>
		</li>
	</c:forEach>
