<script type="text/javascript">
	var hiddenYn = '${vo.hiddenYn}';
	var rplAlmRcvYn = '${vo.rplAlmRcvYn}';
	$(function(){
		if(hiddenYn =='Y'){
			$("#hiddenYnChck").trigger('click');
		}
		if(rplAlmRcvYn == 'Y'){
			$("#rplAlmRcvYnChck").trigger('click');
		}
		qnaImgCheck();

		$(document).off("click" , ".popLayer:not(.win) .btnPopClose:not(.none)");
	})
</script>
<article class="popLayer a popQnaMod" id="popQnaMod">
	<div class="pbd">
		<div class="phd">
			<div class="in">
				<h1 class="tit"><spring:message code='front.web.view.goods.qna.write.title' /></h1>
				<button type="button" class="btnPopClose" name="notClose"><spring:message code='front.web.view.common.close.btn' /></button>
			</div>
		</div>
		<form id="qnaForm">
			<input type="hidden" name="goodsIqrNo" value="${vo.goodsIqrNo }"/>
			<div class="pct">
				<main class="poptents">
					<div class="uiqnaset">
						<div class="set memo">
							<div class="textarea">
								<textarea name="iqrContent" placeholder="<spring:message code='front.web.view.goods.qna.content.write' />">${vo.iqrContent }</textarea>
							</div>
						</div>
						<div class="set file">
							<div class="addfile">
								<div class="btnSet">
									<button type="button" class="btn lg btnAddPic" onclick="${view.deviceGb ne 'APP'?"$('#imgAdd-qna').trigger('click')":"callAppFunc('onOpenGallery', this)"}" id="imgAddBtn-qna">사진 첨부하기</button>
									<input type="file" id="imgAdd-qna" onclick="goodsQna.imageUpload(); return false;" style="display: none;" accept="image/*"/>
								</div>
								<ul class="photo" id="qnaImgArea">
									<!-- <li id="qnaImgArea_1"><span class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="사진"><button type="button" class="bt del">삭제</button></span></li> -->
									<c:forEach var="imgPath" items="${vo.imgPaths }" varStatus="vs">
										<li id="qnaImgArea_1">
											<span class="pic" name="orgImg" data-img-seq="${vo.imgSeqs[vs.index] }">
												<img class="img" src="${imgPath }" alt="사진">
												<button type="button" class="bt del" name="delImg">삭제</button>
											</span>
										</li>
									</c:forEach>
								</ul>
							</div>
							<p class="gmsg info-t1"><spring:message code='front.web.view.goods.qna.img.information1' /><br/><spring:message code='front.web.view.goods.qna.img.information2' /></p>
						</div>
						<div class="set chck">
							<input type="hidden" name="hiddenYn" value="${not empty qnaData.hiddenYn ? qnaData.hiddenYn: 'N' }">
							<input type="hidden" name="rplAlmRcvYn" value="${not empty qnaData.rplAlmRcvYn ? qnaData.rplAlmRcvYn: 'N' }">
							<label class="checkbox"><input type="checkbox" id="hiddenYnChck" name="hiddenYnChck"><span class="txt"><em class="tt"><spring:message code='front.web.view.goods.qna.private.setup' /></em></span></label>
							<!--TODO  -->
						<label class="checkbox"><input type="checkbox" id="rplAlmRcvYnChck" name="rplAlmRcvYnChck"><span class="txt"><em class="tt"><spring:message code='front.web.view.goods.qna.reply.app.accept' /></em></span></label>
						</div>
						<div class="set btts">
							<div class="btnSet">
								<button type="button" class="btn lg d" onclick="popLayerClose();"><spring:message code='front.web.view.common.msg.cancel' /></button>
								<button type="button" class="btn lg a ${not empty vo.iqrContent ? '':'disabled'}" id="insertQna"><spring:message code='front.web.view.common.registration' /></button>
							</div>
						</div>
						<div class="set gud">
							<div class="hdt">
								<span class="tit"><spring:message code='front.web.view.common.title.notice' /></span>
							</div>
							<div class="cdt info-txt" data-ui-tog="ctn open" data-ui-tog-val="tog_guds_1">
								<ul>
									<li><spring:message code='front.web.view.goods.qna.note1' /></li>
									<li><spring:message code='front.web.view.goods.qna.note2' /></li>
								</ul>
							</div>
						</div>
					</div>
				</main>
			</div>
		</form>
	</div>
</article>