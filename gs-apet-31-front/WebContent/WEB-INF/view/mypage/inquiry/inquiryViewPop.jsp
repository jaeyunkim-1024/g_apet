<script type="text/javascript">
	var rplAlmRcvYn = '${vo.pstAgrYn}';
	$(function(){
		if(rplAlmRcvYn == 'Y'){
			$("input[name=pstAgrYn]").trigger('click');
		}
		qnaImgCheck();

		$(document).off("click" , ".popLayer:not(.win) .btnPopClose:not(.none)");
	})
</script>
<article class="popLayer a popQnaMod" id="popInquiryMod">
	<div class="pbd inquire">
		<div class="phd">
			<div class="in">
				<h1 class="tit">1:1 문의하기</h1>
				<button type="button" class="btnPopClose" id="closeBtn">닫기</button>
			</div>
		</div>
		<form id="inquiryForm">
			<input type="hidden" name="cusNo" value="${vo.cusNo }"/>
			<div class="pct">
				<main class="poptents">		
					<div class="uiqnaset">
						<div class="inquire">
							<strong class="tit">문의내용</strong>
							<section class="sect" data-sid="ui-inputs">
								<div style="position: relative;">
									<span class="select-pop mo-t-fixed pc-option-w100">
										<select class="sList" name="cusCtg1Cd" id="cusCtg1Cd" data-select-title="문의 유형선택">
											<c:forEach var="ctgList" items="${ctgList}">
												<option value="${ctgList.dtlCd }" ${ctgList.dtlCd == vo.cusCtg1Cd ? 'selected' : ''} >${ctgList.dtlNm}</option>
											</c:forEach>
										</select>
									</span>
								</div>
							</section>
						</div>
						<div class="set memo">
							<div class="textarea">
								<textarea id="content" name="content" placeholder="문의 내용을 입력해 주세요 (최소 10자 이상)">${vo.content }</textarea>
							</div>
						</div>
						<div class="set file t2">
							<div class="btnSet">
								<button type="button" class="btn lg btnAddPic" onclick="${view.deviceGb ne 'APP'?"$('#imgAdd-qna').trigger('click')":"callAppFuncInquiry('onOpenGallery', this)"}" id="imgAddBtn-qna">사진 첨부하기</button>
								<input type="file" id="imgAdd-qna" onclick="goodsQna.imageUpload(); return false;" style="display: none;" accept="image/*"/>
							</div>
							<p class="gmsg info-t1">이미지는 20MB 이내, JPG, PNG 파일만 등록 가능합니다.(최대 5장 첨부 가능)</p>
							<div class="addfile">
								<ul class="photo addfile-list" id="qnaImgArea">
									<input type="hidden" name="delFlNo" value="${vo.flNo}">
									<c:forEach var="imgPath" items="${vo.phyPaths }" varStatus="vs">
										<li id="qnaImgArea_1">
											<span class="pic" name="orgImg" data-img-seq="${vo.seqs[vs.index] }">
												<img class="img" src="${imgPath}" alt="사진">
												<button type="button" class="bt del" name="delImg">삭제</button>
											</span>
										</li>
									</c:forEach>
								</ul>
							</div>
						</div>
						<div class="set chck">
							<label class="checkbox"><input type="checkbox" id="pstAgrYn" name="pstAgrYn"><span class="txt"><em class="tt">답변등록 앱으로 알림 받기</em></span></label>
						</div>
						<div class="set gud onWeb_b">
							<div class="hdt">
								<span class="tit">유의사항</span>
							</div>
							<div class="cdt info-txt t3" data-ui-tog="ctn open" data-ui-tog-val="tog_guds_1">
								<ul>
									<li>개인정보가 포함된 문의 시 비공개로 문의해 주시기 바랍니다.</li>
									<li style="margin-top:0px;">저작권 침해, 음락, 욕설, 비방글, 판매, 광고 및 홍보성의 글은 임의로 삭제 처리 될 수 있습니다.</li>
								</ul>
							</div>
						</div>
						<!-- 모바일 버튼 -->
						<div class="btnSet onMo_b">
							<button type="button" id="insertQna" class="btn lg a insertBtn ${empty vo.content ? 'disabled' : ''}">등록</button>
						</div>
						<!-- // 모바일 버튼 -->
						<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
						<div class="set gud">
							<div class="hdt">
								<span class="tit">유의사항</span>
							</div>
							<div class="cdt info-txt t3" data-ui-tog="ctn open" data-ui-tog-val="tog_guds_1">
								<ul>
									<li>개인정보가 포함된 문의 시 비공개로 문의해 주시기 바랍니다.</li>
									<li style="margin-top:0px;">저작권 침해, 음락, 욕설, 비방글, 판매, 광고 및 홍보성의 글은<br>임의로 삭제 처리 될 수 있습니다.</li>
								</ul>
							</div>
						</div>
						</c:if>
					</div>				
				</main>
			</div>
		</form>
		<div class="pbt fixed onWeb_b">
			<div class="bts">
				<button type="button" class="btn xl" onclick="popLayerClose();">취소</button>
				<button type="button" id="insertQna" class="btn xl a insertBtn ${empty vo.content ? 'disabled' : ''}">등록</button>
			</div>
		</div>
	</div>
</article>