<article class="popLayer a popPhotoRv" id="popPhotoRv">
	<div class="pbd">
		<div class="phd">
			<div class="in">
				<h1 class="tit"><em class="tt">포토후기</em>
					<em class="nm goodsPhotoCommetListCount"><i class="n" name="viewPoint">1</i>/<i class="s">${so.totalCount}</i></em>
				</h1>
				<button type="button" class="bt rvlist" name="detailClose">후기리스트</button>
				<button type="button" class="btnPopClose">닫기</button>
			</div>
		</div>
		<div class="pct">
			<main class="poptents">
				<div class="photo_review_sld">
					<div class="sld-nav"><button type="button" class="bt prev">이전</button><button type="button" class="bt next">다음</button></div>
					<div class="swiper-container slide k0422">
						<ul class="revlists swiper-wrapper" id="photoDetailList">
							<c:forEach var="dataList" items="${vo}">
								<li class="swiper-slide" id="photoCommentEstmNo_${dataList.goodsEstmNo }">
									<div class="box" name="estmDataArea" data-goods-estm-no="${dataList.goodsEstmNo }" data-goods-estm-no="${dataList.goodsEstmNo}">
										<div class="rhdt">
											<div class="tinfo">
												<span class="pic"><img src="${dataList.prflImg eq null or dataList.prflImg eq '' ? '../../_images/common/img-default-profile@2x.png' : frame:optImagePath( dataList.prflImg , frontConstants.IMG_OPT_QRY_794 )}" alt="사진" class="img" onerror="this.src='../../_images/common/img-default-profile@2x.png'"></span>
												<div class="def">
													<em class="dd ids">${dataList.nickNm }</em>
													<em class="dd date"><fmt:formatDate value="${dataList.sysRegDtm }" pattern="yyyy.MM.dd"/></em> <!-- <em class="ds me">작성글</em> -->
													<c:if test="${dataList.bestYn eq 'Y'}"><em class="ds me">BEST</em></c:if>
													<c:if test="${dataList.estmMbrNo ne session.mbrNo}">
														<nav class="uidropmu dmenu only_down">
															<button type="button" class="bt st gb">메뉴열기</button>
															<div class="list">
																	<ul class="menu">
																		<li><button type="button" class="bt" onclick="goodsComment.commentReportPop(this, 'popPhotoRv')" data-goods-estm-no="${dataList.goodsEstmNo }">신고</button></li>
																	</ul>
															</div>
														</nav>
													</c:if>
												</div>
												<div class="spec">
												<c:if test="${not empty dataList.petNm }">
													 <em class="b">${dataList.petNm }<span>${petGdGbCd eq '10' ? '(수컷)' : petGdGbCd eq '20' ? '(암컷)' : '' }</span></em> <em class="b">${dataList.age }살 </em> <em class="b"><fmt:formatNumber value="${dataList.weight}" pattern="##.#"/>kg</em>
												</c:if>
												</div>
											</div>
											<div class="hpset">
												<em class="htxt">도움이돼요</em>
												<button type="button" onclick="goodsComment.likeComment(this)" class="bt hlp ${dataList.rcomYn eq 'Y' ? 'me ' : ''} ${not empty dataList.likeCnt && dataList.likeCnt != 0 ? ' on':'' } ">
													<i class="n">${not empty dataList.likeCnt?dataList.likeCnt:0 }</i><b class="t">도움</b></button>
											</div>
										</div>
										<div class="rcdt">
											<div class="stpnt starpoint">
												<span class='stars sm p_${fn:replace(((dataList.estmScore/2)+""), ".", "_") }'></span>
											</div>
											<ul class="satis">
												<c:forEach var="qstList" items="${dataList.goodsEstmQstVOList }">
												<li><span class="dt">${qstList.qstClsf }</span> <span class="dd">${qstList.itemContent }</span></li>
												</c:forEach>
											</ul>
											<div class="rvPicSld">
												<div class="photo_rpic_sld">
													<div class="swiper-container slide">
														<div class="swiper-pagination"></div>
														<ul class="swiper-wrapper list">
															<c:forEach var="imgList" items="${dataList.goodsCommentImageList}">
																<li class="swiper-slide">
																	<span class="pic"><img class="img" src="${fn:indexOf(imgList.imgPath,'http') > -1 ? imgList.imgPath : frame:optImagePath(imgList.imgPath, frontConstants.IMG_OPT_QRY_772)}" alt="첨부이미지"></span>
																</li>
															</c:forEach>
														</ul>
														<!-- 04.07 : 추가 -->
														<c:if test="${view.deviceGb eq 'PC'}">
															<div class="swiper-button-prev"></div>
															<div class="swiper-button-next"></div>
														</c:if>
														<!-- // 04.07 : 추가 -->
													</div>
												</div>
											</div>
											<div class="opts" <c:if test="${not empty dataList.attrVal }">onclick="location.href='/goods/indexGoodsDetail?goodsId=${dataList.goodsId }'"</c:if>>${dataList.attrVal }</div>
											<div class="msgs">${dataList.content }</div>
										</div>
									</div>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</main>
		</div>
	</div>
</article>