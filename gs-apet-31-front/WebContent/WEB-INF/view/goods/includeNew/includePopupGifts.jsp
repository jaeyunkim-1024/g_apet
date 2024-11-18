<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">
</script>
<!-- 사은품 안내 -->
<div class="layers">
	<article class="popBot popGiftsInfo" id="popGiftsInfo">
		<div class="pbd">
			<div class="phd">
				<div class="in">
					<h1 class="tit">사은품 안내</h1>
					<button type="button" class="btnPopClose">닫기</button>
				</div>
			</div>
			<div class="pct">
				<main class="poptents">
					<c:if test="${!empty goodsGifts}">
						<ul class="scgiftinfo">
							<c:forEach items="${goodsGifts}" var="gift">
								<li>
									<div class="hinf">
										<div class="tt"><c:out value="${gift.prmtNm}"/></div>
										<div class="ss">구매시증정</div>
									</div>
									<div class="dinf">
										<div class="thum">
<!-- 											직사각형을 정사각형으로 변경함. frontConstants.IMG_OPT_QRY_210 >>>> frontConstants.IMG_OPT_QRY_756 -->
											<div class="pic"><img class="img" src="${frame:optImagePath( gift.imgPath , frontConstants.IMG_OPT_QRY_756 )}" /></div>
										</div>
										<div class="name">${gift.goodsNm}</div>
									</div>
								</li>
							</c:forEach>
						</ul>
					</c:if>
				</main>
			</div>
		</div>
	</article>
</div>
