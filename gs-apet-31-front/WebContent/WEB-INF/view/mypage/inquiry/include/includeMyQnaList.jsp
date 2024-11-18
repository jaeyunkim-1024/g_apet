<script type="text/javascript">
goodsQna.totalCount = ${fn:length(myQnaList)}
</script>

<c:choose>
	<c:when test="${myQnaList != null and fn:length(myQnaList)>0}">
		<div class="uiqnalist">
			<ul class="uiAccd qalist" data-accd="accd" id="uiQna">
				<c:forEach var="qnaData" items="${myQnaList}">
				<li name="qnaListLi" data-rpl-alm-rcv-yn="${qnaData.rplAlmRcvYn }" data-hidden-yn="${qnaData.hiddenYn }" data-goods-iqr-no="${qnaData.goodsIqrNo}">
					<div class="hBox">
						<div class="tit" name="qnaTit">${qnaData.iqrContent}</div>
						<div class="info">
							<div class="dds">
								<em class="dd date"><fmt:formatDate value="${qnaData.sysRegDtm}" pattern="yyyy.MM.dd"/></em>
								<c:if test="${qnaData.goodsIqrStatCd eq '10'}">
									<em class="dd rep com"><spring:message code='front.web.view.goods.qna.reply.wait.title' /></em>
								</c:if>
								<c:if test="${qnaData.goodsIqrStatCd eq '20'}">
									<em class="dd rep com"><spring:message code='front.web.view.goods.qna.reply.completion.title' /></em>
								</c:if>
							</div>
							<div class="go_prdt">
								<a href="/goods/indexGoodsDetail?goodsId=${qnaData.goodsId}" class="pic" data-content='${qnaData.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${qnaData.goodsId}">상품바로가기</a>
							</div>
							<div class="stat">
								<nav class="uidropmu dmenu">
									<button type="button" class="bt st gb">메뉴열기</button>
									<div class="list">
										<ul class="menu">
										<c:if test="${qnaData.goodsIqrStatCd eq '10'}">
											<li><button type="button" class="bt" name="reWriteBtn" onclick="qnaMenu(this); return false;"><spring:message code='front.web.view.common.update' /></button></li>
										</c:if>
											<li><button type="button" class="bt" name="deleteQnaBtn" onclick="qnaMenu(this); return false;"><spring:message code='front.web.view.goods.delete.btn' /></button></li>
										</ul>
									</div>
								</nav>
							</div>
						</div>
						<button type="button" class="btnTog">버튼</button>
					</div>
					<div class="cBox" style="display: none;">
						<c:choose>
							<c:when test="${empty qnaData.rplContent && empty qnaData.goodsIqrImgList}"></c:when>
							<c:otherwise>
									<div class="addpic">
										<ul class="pics" name="qnaPics">
											<c:if test="${not empty qnaData.goodsIqrImgList }">
												<c:forEach var="imgList" items="${qnaData.goodsIqrImgList }">
													<li><a href="javascript:void(0);" class="pic"><img onclick="detailInquiryImgPop(this)" src="${frame:optImagePath(imgList.imgPath, frontConstants.IMG_OPT_QRY_794)}" data-img-seq="${imgList.imgSeq }" alt="이미지" class="img"></a></li>
												</c:forEach>
											</c:if>
										</ul>
									</div>
									<c:if test="${not empty qnaData.rplContent}">
										<div class="reply">
											<div class="msg">
											<c:if test="${not empty qnaData.rplContentHeader }">
											${qnaData.rplContentHeader }
											<br />
											</c:if>
											${qnaData.rplContent }
											<c:if test="${not empty qnaData.rplContentFooter }">
											<br />
											${qnaData.rplContentFooter }
											</c:if>
											</div>
											<div class="info">
												<div class="dds">
													<em class="dd ids"><spring:message code='front.web.view.goods.qna.seller.title' /></em> <em class="dd date"><fmt:formatDate value="${qnaData.rplDtm }" pattern="yyyy.MM.dd hh:mm"/></em>
												</div>
											</div>
										</div>
									</c:if>
							</c:otherwise>
						</c:choose>
					</div>
				</li>
				</c:forEach>
			</ul>
		</div>
	</c:when>
	<c:otherwise>
		<div class="inr">
			<div class="msg">등록된 문의글이 없습니다.</div>
		</div>
	</c:otherwise>
</c:choose>