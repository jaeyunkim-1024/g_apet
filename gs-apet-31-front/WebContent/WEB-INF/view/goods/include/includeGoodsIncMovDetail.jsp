<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">

</script>

<div class="hdts">
	<span class="tit"><em class="t">관련영상</em> <i class="i">${goodsTotalCount.goodsContentsTotal}</i></span>
</div>
<div class="cdts">
	<div class="ui_fitmove_slide">
		<!-- ui.shop.fitMov.using(); -->
		<div class="swiper-container slide">
			<ul class="swiper-wrapper list">
<%--			관련 영상 listGoodsContents --%>
				<c:forEach items="${listGoodsContents}" var="goodsContents" varStatus="idx">
					<li class="swiper-slide">
						<div class="fitMoveSet">
							<div class="thum">
<%--								<a href="javascript:;" class="pic"><img class="img" src="${goodsContents.imgPath}" alt="이미지">--%>
								<a href="/tv/series/indexTvDetail?vdId=${goodsContents.vdId}&sortCd=&listGb=HOME" class="pic">
									<img class="img" src="${goodsContents.phyPath}" alt="이미지">
<%--									<img class="img" style="background-image:url(${goodsContents.phyPath});"  alt="이미지">--%>
									<span class="tm">
										<i class="i">
											<fmt:formatNumber type="vdLnth_hour" pattern="##" minIntegerDigits="2" value="${goodsContents.vdLnth/60}" />
											: <fmt:formatNumber type="vdLnth_minute" pattern="##" minIntegerDigits="2" value="${goodsContents.vdLnth%60}" /></i>
									</span></a>
							</div>
							<div class="boxs">
								<div class="spic">
									<a href="javascript;" class="pic">
										<img class="img" src="../../_images/_temp/goods_1.jpg" alt="이미지">
									</a>
								</div>
								<div class="desc">
									<div class="tit"><a href="/tv/series/indexTvDetail?vdId=${goodsContents.vdId}&sortCd=&listGb=HOME" class="lk">${goodsContents.ttl}</a></div>
									<div class="inf">
										<span class="pct"><i class="nm">90%</i>일치</span>
										<span class="hit"><i class="nm">${goodsContents.playCnt}</i></span>
										<span class="fav"><i class="nm">${goodsContents.likeCnt}</i></span>
									</div>
								</div>
							</div>
						</div>
					</li>

				</c:forEach>

<%--				<li class="swiper-slide">--%>
<%--					<div class="fitMoveSet">--%>
<%--						<div class="thum">--%>
<%--							<a href="javascript:;" class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="이미지"> <span class="tm"><i class="i">10:08</i></span></a>--%>
<%--						</div>--%>
<%--						<div class="boxs">--%>
<%--							<div class="spic">--%>
<%--								<a href="javascript:;" class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="이미지"></a>--%>
<%--							</div>--%>
<%--							<div class="desc">--%>
<%--								<div class="tit"><a href="javascript:;" class="lk">뭐라하는지 다 알아듣는 강아지 몽자가 나타났다!! 뭐라하는지 다 알아듣는 강아지 몽자가 나타났다!!</a></div>--%>
<%--								<div class="inf">--%>
<%--									<span class="pct"><i class="nm">90%</i>일치</span>--%>
<%--									<span class="hit"><i class="nm">86,437</i></span>--%>
<%--									<span class="fav"><i class="nm">320</i></span>--%>
<%--								</div>--%>
<%--							</div>--%>
<%--						</div>--%>
<%--					</div>--%>
<%--				</li>--%>
<%--				<li class="swiper-slide">--%>
<%--					<div class="fitMoveSet">--%>
<%--						<div class="thum">--%>
<%--							<a href="javascript:;" class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="이미지"> <span class="tm"><i class="i">10:08</i></span></a>--%>
<%--						</div>--%>
<%--						<div class="boxs">--%>
<%--							<div class="spic">--%>
<%--								<a href="javascript:;" class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="이미지"></a>--%>
<%--							</div>--%>
<%--							<div class="desc">--%>
<%--								<div class="tit"><a href="javascript:;" class="lk">뭐라하는지 다 알아듣는 강아지 몽자가 나타났다!!</a></div>--%>
<%--								<div class="inf">--%>
<%--									<span class="pct"><i class="nm">90%</i>일치</span>--%>
<%--									<span class="hit"><i class="nm">86,437</i></span>--%>
<%--									<span class="fav"><i class="nm">320</i></span>--%>
<%--								</div>--%>
<%--							</div>--%>
<%--						</div>--%>
<%--					</div>--%>
<%--				</li>--%>
<%--				<li class="swiper-slide">--%>
<%--					<div class="fitMoveSet">--%>
<%--						<div class="thum">--%>
<%--							<a href="javascript:;" class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="이미지"> <span class="tm"><i class="i">10:08</i></span></a>--%>
<%--						</div>--%>
<%--						<div class="boxs">--%>
<%--							<div class="spic">--%>
<%--								<a href="javascript:;" class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="이미지"></a>--%>
<%--							</div>--%>
<%--							<div class="desc">--%>
<%--								<div class="tit"><a href="javascript:;" class="lk">뭐라하는지 다 알아듣는 강아지 몽자가 나타났다!!</a></div>--%>
<%--								<div class="inf">--%>
<%--									<span class="pct"><i class="nm">90%</i>일치</span>--%>
<%--									<span class="hit"><i class="nm">86,437</i></span>--%>
<%--									<span class="fav"><i class="nm">320</i></span>--%>
<%--								</div>--%>
<%--							</div>--%>
<%--						</div>--%>
<%--					</div>--%>
<%--				</li>--%>
<%--				<li class="swiper-slide">--%>
<%--					<div class="fitMoveSet">--%>
<%--						<div class="thum">--%>
<%--							<a href="javascript:;" class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="이미지"> <span class="tm"><i class="i">10:08</i></span></a>--%>
<%--						</div>--%>
<%--						<div class="boxs">--%>
<%--							<div class="spic">--%>
<%--								<a href="javascript:;" class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="이미지"></a>--%>
<%--							</div>--%>
<%--							<div class="desc">--%>
<%--								<div class="tit"><a href="javascript:;" class="lk">뭐라하는지 다 알아듣는 강아지 몽자가 나타났다!!</a></div>--%>
<%--								<div class="inf">--%>
<%--									<span class="pct"><i class="nm">90%</i>일치</span>--%>
<%--									<span class="hit"><i class="nm">86,437</i></span>--%>
<%--									<span class="fav"><i class="nm">320</i></span>--%>
<%--								</div>--%>
<%--							</div>--%>
<%--						</div>--%>
<%--					</div>--%>
<%--				</li>--%>
<%--				<li class="swiper-slide">--%>
<%--					<div class="fitMoveSet">--%>
<%--						<div class="thum">--%>
<%--							<a href="javascript:;" class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="이미지"> <span class="tm"><i class="i">10:08</i></span></a>--%>
<%--						</div>--%>
<%--						<div class="boxs">--%>
<%--							<div class="spic">--%>
<%--								<a href="javascript:;" class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="이미지"></a>--%>
<%--							</div>--%>
<%--							<div class="desc">--%>
<%--								<div class="tit"><a href="javascript:;" class="lk">뭐라하는지 다 알아듣는 강아지 몽자가 나타났다!!</a></div>--%>
<%--								<div class="inf">--%>
<%--									<span class="pct"><i class="nm">90%</i>일치</span>--%>
<%--									<span class="hit"><i class="nm">86,437</i></span>--%>
<%--									<span class="fav"><i class="nm">320</i></span>--%>
<%--								</div>--%>
<%--							</div>--%>
<%--						</div>--%>
<%--					</div>--%>
<%--				</li>--%>
<%--				<li class="swiper-slide">--%>
<%--					<div class="fitMoveSet">--%>
<%--						<div class="thum">--%>
<%--							<a href="javascript:;" class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="이미지"> <span class="tm"><i class="i">10:08</i></span></a>--%>
<%--						</div>--%>
<%--						<div class="boxs">--%>
<%--							<div class="spic">--%>
<%--								<a href="javascript:;" class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="이미지"></a>--%>
<%--							</div>--%>
<%--							<div class="desc">--%>
<%--								<div class="tit"><a href="javascript:;" class="lk">뭐라하는지 다 알아듣는 강아지 몽자가 나타났다!!</a></div>--%>
<%--								<div class="inf">--%>
<%--									<span class="pct"><i class="nm">90%</i>일치</span>--%>
<%--									<span class="hit"><i class="nm">86,437</i></span>--%>
<%--									<span class="fav"><i class="nm">320</i></span>--%>
<%--								</div>--%>
<%--							</div>--%>
<%--						</div>--%>
<%--					</div>--%>
<%--				</li>--%>
<%--				<li class="swiper-slide">--%>
<%--					<div class="fitMoveSet">--%>
<%--						<div class="thum">--%>
<%--							<a href="javascript:;" class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="이미지"> <span class="tm"><i class="i">10:08</i></span></a>--%>
<%--						</div>--%>
<%--						<div class="boxs">--%>
<%--							<div class="spic">--%>
<%--								<a href="javascript:;" class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="이미지"></a>--%>
<%--							</div>--%>
<%--							<div class="desc">--%>
<%--								<div class="tit"><a href="javascript:;" class="lk">뭐라하는지 다 알아듣는 강아지 몽자가 나타났다!!</a></div>--%>
<%--								<div class="inf">--%>
<%--									<span class="pct"><i class="nm">90%</i>일치</span>--%>
<%--									<span class="hit"><i class="nm">86,437</i></span>--%>
<%--									<span class="fav"><i class="nm">320</i></span>--%>
<%--								</div>--%>
<%--							</div>--%>
<%--						</div>--%>
<%--					</div>--%>
<%--				</li>--%>
<%--				<li class="swiper-slide">--%>
<%--					<div class="fitMoveSet">--%>
<%--						<div class="thum">--%>
<%--							<a href="javascript:;" class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="이미지"> <span class="tm"><i class="i">10:08</i></span></a>--%>
<%--						</div>--%>
<%--						<div class="boxs">--%>
<%--							<div class="spic">--%>
<%--								<a href="javascript:;" class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="이미지"></a>--%>
<%--							</div>--%>
<%--							<div class="desc">--%>
<%--								<div class="tit"><a href="javascript:;" class="lk">뭐라하는지 다 알아듣는 강아지 몽자가 나타났다!!</a></div>--%>
<%--								<div class="inf">--%>
<%--									<span class="pct"><i class="nm">90%</i>일치</span>--%>
<%--									<span class="hit"><i class="nm">86,437</i></span>--%>
<%--									<span class="fav"><i class="nm">320</i></span>--%>
<%--								</div>--%>
<%--							</div>--%>
<%--						</div>--%>
<%--					</div>--%>
<%--				</li>--%>
<%--				<li class="swiper-slide">--%>
<%--					<div class="fitMoveSet">--%>
<%--						<div class="thum">--%>
<%--							<a href="javascript:;" class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="이미지"> <span class="tm"><i class="i">10:08</i></span></a>--%>
<%--						</div>--%>
<%--						<div class="boxs">--%>
<%--							<div class="spic">--%>
<%--								<a href="javascript:;" class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="이미지"></a>--%>
<%--							</div>--%>
<%--							<div class="desc">--%>
<%--								<div class="tit"><a href="javascript:;" class="lk">뭐라하는지 다 알아듣는 강아지 몽자가 나타났다!!</a></div>--%>
<%--								<div class="inf">--%>
<%--									<span class="pct"><i class="nm">90%</i>일치</span>--%>
<%--									<span class="hit"><i class="nm">86,437</i></span>--%>
<%--									<span class="fav"><i class="nm">320</i></span>--%>
<%--								</div>--%>
<%--							</div>--%>
<%--						</div>--%>
<%--					</div>--%>
<%--				</li>--%>
<%--				<li class="swiper-slide">--%>
<%--					<div class="fitMoveSet">--%>
<%--						<div class="thum">--%>
<%--							<a href="javascript:;" class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="이미지"> <span class="tm"><i class="i">10:08</i></span></a>--%>
<%--						</div>--%>
<%--						<div class="boxs">--%>
<%--							<div class="spic">--%>
<%--								<a href="javascript:;" class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="이미지"></a>--%>
<%--							</div>--%>
<%--							<div class="desc">--%>
<%--								<div class="tit"><a href="javascript:;" class="lk">뭐라하는지 다 알아듣는 강아지 몽자가 나타났다!!</a></div>--%>
<%--								<div class="inf">--%>
<%--									<span class="pct"><i class="nm">90%</i>일치</span>--%>
<%--									<span class="hit"><i class="nm">86,437</i></span>--%>
<%--									<span class="fav"><i class="nm">320</i></span>--%>
<%--								</div>--%>
<%--							</div>--%>
<%--						</div>--%>
<%--					</div>--%>
<%--				</li>--%>
			</ul>
		</div>
		<div class="sld-nav">
			<button type="button" class="bt prev">이전</button>
			<button type="button" class="bt next">다음</button>
		</div>
	</div>
</div>
