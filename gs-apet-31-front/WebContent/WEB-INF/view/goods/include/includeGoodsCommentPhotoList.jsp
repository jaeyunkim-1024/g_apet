<script type="text/javascript">
	$(function(){
		$("#popRvPhoto").children('.pbd').children('.phd').find('.n').text(imgPopTotalCnt);
		
		$("#plist").on('click', 'a', function(){
			var goodsEstmNo = $(this).data('goodsEstmNo');
			goodsComment.getAllGoodsCommentDetail(goodsEstmNo);
		})
	});
	var imgPopTotalCnt = 0;
	<c:forEach var="imgData" items="${imgList }">
	imgPopTotalCnt++;
	</c:forEach>
	
</script>
<!-- 팝업레이어 A 전체 덮는크기 -->
<article class="popLayer a popRvPhoto" id="popRvPhoto">
	<div class="pbd">
		<div class="phd">
			<div class="in">
				<h1 class="tit"><em class="t">포토후기</em> <em class="n">${so.totalCount }</em></h1>
				<button type="button" class="btnPopClose">닫기</button>
			</div>
		</div>
		<div class="pct">
			<main class="poptents"> 
				<div class="rvPicList">
					<ul class="plist" id="plist">
						<c:if test="${not empty imgList }">
							<c:forEach var="imgData" items="${imgList }">
								<li>
									<a href="javascript:;" class="thum" data-goods-estm-no="${imgData.goodsEstmNo }">
										<span class="pic"><img class="img" src="${frame:imagePath(imgData.imgPath)}" alt="이미지"></span>
										<c:if test="${not empty imgData.imgCnt && imgData.imgCnt > 1}">
											<div class="n">${imgData.imgCnt }</div>
										</c:if>
									</a>
								</li>
							</c:forEach>
						</c:if>
					</ul>
				</div>
			</main>
		</div>
	</div>
</article>