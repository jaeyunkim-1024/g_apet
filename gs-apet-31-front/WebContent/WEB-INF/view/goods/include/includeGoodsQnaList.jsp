<script type="text/javascript">
	goodsQna.totalPageCount = ${so.totalPageCount};
	goodsQna.page = ${so.page};
	if(goodsQna.totalPageCount == goodsQna.page){
		$("#qnaMore").hide();
	}else{
		$("#qnaMore").show();
	}
	$("i[name=pdQnaCnt]").text('${not empty so.totalCount ? so.totalCount : 0}');
</script>

<c:forEach var="qnaData" items="${list}">
	<li ${qnaData.hiddenYn eq 'Y' ? 'class="secret"':'' }" name="qnaListLi" data-rpl-alm-rcv-yn="${qnaData.rplAlmRcvYn }" data-hidden-yn="${qnaData.hiddenYn }" data-goods-iqr-no="${qnaData.goodsIqrNo}">
	<!-- <li class="secret"> 비밀글 -->
		<div class="hBox" name="hIqrDiv">
			<div class="tit" name="qnaTit">${qnaData.hiddenYn eq 'Y' && qnaData.eqrrMbrNo ne session.mbrNo ? '비밀글입니다.' : qnaData.iqrContent}</div>
			<div class="info">
				<div class="dds">
					<em class="dd ids">${qnaData.eqrrId}</em>
					<em class="dd date"><fmt:formatDate value="${qnaData.sysRegDtm}" pattern="yyyy.MM.dd"/> </em>
					<c:if test="${qnaData.goodsIqrStatCd eq '10'}">
						<em class="dd rep">답변대기</em>
					</c:if>
					<c:if test="${qnaData.goodsIqrStatCd eq '20'}">
						<em class="dd rep com">답변완료</em>
					</c:if>
				</div>
				<c:if test="${qnaData.eqrrMbrNo eq session.mbrNo}">
					<div class="stat">
						<!-- <em class="dd mys">작성글</em> -->
						<nav class="uidropmu dmenu">
							<button type="button" class="bt st">메뉴열기</button>
							<div class="list">
								<ul class="menu">
									<li><button type="button" class="bt" name="reWriteBtn" onclick="qnaMenu(this); return false;">수정</button></li>
									<li><button type="button" class="bt" name="deleteQnaBtn" onclick="qnaMenu(this); return false;">삭제</button></li>
								</ul>
							</div>
						</nav>
					</div>
				</c:if>
 			</div>
			<button type="button" class="btnTog" ${qnaData.hiddenYn eq 'Y' && qnaData.eqrrMbrNo ne session.mbrNo ? 'disabled' : ''} >버튼</button>
		</div>
		<div class="cBox" style="display: none;">
			<div class="addpic">
				<ul class="pics" name="qnaPics">
					<c:if test="${not empty qnaData.goodsIqrImgList }">
						<c:forEach var="imgList" items="${qnaData.goodsIqrImgList }">
							<li><a href="javascript:;" class="pic">
							<img class="img" src="${frame:imagePath(imgList.imgPath)}" data-img-seq="${imgList.imgSeq }" alt="첨부이미지">
							</a></li>
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
							<em class="dd ids">판매자</em> <em class="dd date"><fmt:formatDate value="${qnaData.rplDtm }" pattern="yyyy.MM.dd hh:mm"/></em>
						</div>
					</div>
				</div>
			</c:if>
		</div>
	</li>
</c:forEach>