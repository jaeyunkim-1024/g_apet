<c:forEach var="vo" items="${bfVOList }">
	<div class="item" name="orderGoods" data-goods-id="${vo.goodsId }" data-ord-no="${vo.ordNo }" data-ord-dtl-seq="${vo.ordDtlSeq }" 
										data-pak-goods-id="${vo.pakGoodsId }" data-goods-estm-no="${vo.goodsEstmNo }">
		<div class="inr">
			<div class="top">
				<p class="pic"><img src="${frame:imagePath(vo.goodsImgPath)}" alt="상품" class="img"></p>
				<div class="txt">
					<%-- <p class="t1">${not empty vo.pakGoodsNm ? vo.pakGoodsNm : vo.goodsNm }</p> --%>
					<p class="t1">${vo.goodsNm }</p>
					<p class="t2 k0423">${vo.cstrtShowNm}</p>
				</div>
			</div>
			<div class="bottom">
				<p class="txt"><strong>구매확정</strong> <fmt:formatDate value="${vo.sysRegDtm }" pattern="yyyy.MM.dd"/> </p>
				<button type="button" href="javascript:;" class="btn" onclick="myComment.writePop(this)">후기 작성</button>
			</div>
		</div>
	</div>
</c:forEach>