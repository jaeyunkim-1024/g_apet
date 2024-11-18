<c:forEach var="vo" items="${aftVOList }" varStatus="vs">
<div class="item" name="estmData" data-goods-estm-no="${vo.goodsEstmNo }" data-goods-id="${vo.goodsId }" data-ord-no="${vo.ordNo }"
								  data-pak-goods-id="${vo.pakGoodsId }" data-pet-log-no="${vo.petLogNo }" 
								  data-goods-estm-tp="${vo.goodsEstmTp }" data-ord-dtl-seq="${vo.ordDtlSeq }">
	<div class="inr">
		<div class="top">
			<p class="pic"><img src="${frame:imagePath(vo.goodsImgPath)}" alt="상품" class="img"></p>
			<div class="txt">
				<p class="t1">${vo.goodsNm }</p>
				<p class="t2 k0423">${vo.cstrtShowNm}</p>
			</div>
		</div>
		<div class="bottom">
			<p class="txt"><strong>주문일</strong><fmt:formatDate value="${vo.ordAcptDtm }" pattern="yyyy.MM.dd"/></p>
			<nav class="uidropmu dmenu">
				<button type="button" class="bt st">메뉴열기</button>
				<div class="list">
					<ul class="menu">
						<li><button type="button" class="bt" onclick="myComment.updateMyComment(this); return false;">수정</button></li>
						<li><button type="button" class="bt" onclick="myComment.deleteMyComment(this); return false;">삭제</button></li>
					</ul>
				</div>
			</nav>
		</div>
	</div>
	<div class="review" name="myEstmResult" >
		<!-- 평점 -->
		<div class="starpoint">
			<span class='stars sm p_${fn:replace(((vo.estmScore/2)+""), ".", "_") }'></span>
		</div>
		<div class="list">
			<ul>
				<c:forEach var="estmList" items="${vo.goodsEstmQstVOList }">
					<li>
						<span>${estmList.qstClsf }</span><span>${estmList.itemContent }</span>
					</li>
				</c:forEach>
			</ul>
		</div>
		<!-- // 평점 -->
		<div class="like-area">
			도움이돼요
			<button class="like"><c:if test="${!empty vo.likeCnt}"><span>${vo.likeCnt }</span></c:if></button>
		</div>
	</div>
</div>
</c:forEach>