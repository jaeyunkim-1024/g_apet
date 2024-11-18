<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">
</script>
<!-- 상품 이미지 -->
	<article class="popLayer a popPdImgView" id="popPdImgView">
		<div class="pbd">
			<div class="phd">
				<div class="in">
					<h1 class="tit">상품 이미지 보기</h1>
					<button type="button" class="btnPopClose">닫기</button>
				</div>
			</div>
			<div class="pct">
				<main class="poptents">
					<section class="pdPhoto">
						<div class="pdDtPicSld">
							<div class="swiper-container">
								<ul class="swiper-wrapper slide">
									<c:forEach items="${goodsImgList }" var="img" varStatus="status">
										<li class="swiper-slide">
											<div class="box swiper-zoom-container">
												<span class="pic">
<!-- 													직사각형을 정사각형으로 변경함. frontConstants.IMG_OPT_QRY_210 >>>> frontConstants.IMG_OPT_QRY_756 -->
													<img class="img" src="${frame:optImagePath( img.imgPath , frontConstants.IMG_OPT_QRY_756 )}" alt="">
												</span>
											</div>
										</li>
									</c:forEach>
								</ul>
							</div>

							<div class="sld-nav"><!-- @@ 02.24추가 -->
								<button type="button" class="bt prev">이전</button>
								<button type="button" class="bt next">다음</button>
							</div>
						</div>
						

					</section>
					
				</main>
			</div>
			<div class="pbt">
				<div class="pdDtThmSld">
					<div class="swiper-container">
						<ul class="swiper-wrapper slide">
							<c:forEach items="${goodsImgList }" var="img" varStatus="status">
								<li class="swiper-slide">
									<a href="javascript:" class="box">
										<span class="pic">
<!-- 											직사각형을 정사각형으로 변경함. frontConstants.IMG_OPT_QRY_210 >>>> frontConstants.IMG_OPT_QRY_756 -->
											<img class="img" src="${frame:optImagePath( img.imgPath , frontConstants.IMG_OPT_QRY_756 )}" >
										</span>
									</a>
								</li>
							</c:forEach>
						</ul>
					</div>
					<div class="sld-nav">
						<button type="button" class="bt prev">이전</button>
						<button type="button" class="bt next">다음</button>
					</div>
				</div>
			</div>
		</div>
	</article>
