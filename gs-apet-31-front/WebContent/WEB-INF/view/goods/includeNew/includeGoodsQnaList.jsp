<c:forEach var="qnaData" items="${list}">
	<li ${qnaData.hiddenYn eq 'Y' ? 'class="secret"':'' }" name="qnaListLi" data-rpl-alm-rcv-yn="${qnaData.rplAlmRcvYn }" data-hidden-yn="${qnaData.hiddenYn }" data-goods-iqr-no="${qnaData.goodsIqrNo}">
	<!-- <li class="secret"> 비밀글 -->
		<div class="hBox" name="hIqrDiv">
			<div class="tit k0428" name="qnaTit"><c:out value="${qnaData.hiddenYn eq 'Y' && qnaData.eqrrMbrNo ne session.mbrNo ? '비밀글입니다.' : qnaData.iqrContent}" escapeXml="false"/></div>
			<div class="info">
				<div class="dds">
					<em class="dd ids">${qnaData.nickNm eq null ? qnaData.eqrrId : qnaData.nickNm}</em>
					<em class="dd date"><fmt:formatDate value="${qnaData.sysRegDtm}" pattern="yyyy.MM.dd"/> </em>
					<c:if test="${qnaData.goodsIqrStatCd eq '10'}">
						<em class="dd rep"><spring:message code='front.web.view.goods.qna.reply.wait.title' /></em>
					</c:if>
					<c:if test="${qnaData.goodsIqrStatCd eq '20'}">
						<em class="dd rep com"><spring:message code='front.web.view.goods.qna.reply.completion.title' /></em>
					</c:if>
				</div>
				<c:if test="${qnaData.eqrrMbrNo eq session.mbrNo}">
					<div class="stat">
						<!-- <em class="dd mys">작성글</em> -->
						<nav class="uidropmu dmenu">
							<button type="button" class="bt st"><spring:message code='front.web.view.goods.qna.reply.menu.open.title' /></button>
							<div class="list">
								<ul class="menu">
									<li><button type="button" class="bt" name="reWriteBtn" onclick="qnaMenu(this); return false;"><spring:message code='front.web.view.common.update' /></button></li>
									<li><button type="button" class="bt" name="deleteQnaBtn" onclick="qnaMenu(this); return false;"><spring:message code='front.web.view.goods.delete.btn' /></button></li>
								</ul>
							</div>
						</nav>
					</div>
				</c:if>
 			</div>
			<%-- <c:if test="${not empty qnaData.rplContent || not empty qnaData.goodsIqrImgList}"> --%>
				<button type="button" class="btnTog">버튼</button>
			<%-- </c:if> --%>
		</div>
		<div class="cBox" style="display: none;">
		<c:choose>
			<c:when test="${qnaData.hiddenYn eq 'Y' && qnaData.eqrrMbrNo ne session.mbrNo}"></c:when>
			<c:when test="${empty qnaData.rplContent && empty qnaData.goodsIqrImgList}"></c:when>
			<c:otherwise>
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
<script type="text/javascript" id="qnaListScript">
	
	$(document).ready(function(){
		
		for(var i =0 ; i < $(".hBox > .tit").length ; i++){
			var content = $(".hBox > .tit").eq(i);
			var res;
			var cont = $('<div>'+content.text()+'</div>').css("display", "table")
			.css("z-index", "-1").css("position", "absolute")
			.css("font-family", content.css("font-family"))
			.css("font-size", content.css("font-size"))
			.css("font-weight", content.css("font-weight")).appendTo('body');
			res = (cont.width()>content.width());
			cont.remove();
		   	
			if(!res && $(".cBox").eq(i).find("img").length < 1 
					&& $(".cBox").eq(i).find(".reply").length < 1){
				$(".btnTog").eq(i).hide();
				$(".tit").removeAttr("onclick")
		   		
				$(".hBox:eq("+i+") > .tit" ).on("click" , function(){
					return false;
				}) 
			}
		}
	});
	goodsQna.totalPageCount = ${so.totalPageCount};
	goodsQna.page = ${so.page};
	if(goodsQna.totalPageCount == goodsQna.page){
		$("#qnaMoreLoad").hide();
	}else{
		$("#qnaMoreLoad").show();
	}
	//$("i[name=pdQnaCnt]").text('${not empty so.totalCount ? so.totalCount : 0}');

	<c:if test="${empty list}">
		$("#qnaList").html("<li name=\"noQna\" style=\"text-align: center;\"><spring:message code='front.web.view.goods.qna.no.existence.msg' /></li>");
		//$("#qnaHidden").hide();
		
	</c:if>
</script>