<article class="popLayer a popconTing" id="popconTing">
	<div class="pbd">
		<div class="pct">						
			<!-- 본문 -->
			<div class="contents log" id="popconTingContents">
				<!-- picture -->
				<div class="log_makePicWrap t2">
			<c:choose>
				<c:when test="${petLogBase.vdPath ne null and petLogBase.vdPath ne ''}">
					<div id="stop_gif" class="blur-background-area" style="background-image:url('${petLogBase.vdThumPath}')"></div>
					<div class="img-slide">
						<div class="swiper-container">
							<div class="swiper-pagination"></div>
							<ul class="swiper-wrapper slide">
								<li class="swiper-slide">
									<div class="vthumbs" video_id="${petLogBase.vdPath}" type="video_thumb_360p" uid="${petLogBase.mbrNo}|${session.mbrNo}" style="width:100%; height:100%"></div>
								</li>
							</ul>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div id="stop_gif" class="blur-background-area" style="background-image:url('${frame:optImagePath(petLogBase.imgPath1,frontConstants.IMG_OPT_QRY_772)}')"></div>
						<!-- slider -->
						<div class="img-slide">
							<div class="swiper-container">
								<div class="swiper-pagination"></div>
								<ul class="swiper-wrapper slide">								
									<li class="swiper-slide">
										<a class="petLogCardBox"><img class="img" src="${fn:indexOf(petLogBase.imgPath1, '.gif') > -1? frame:imagePath(petLogBase.imgPath1) : frame:optImagePath(petLogBase.imgPath1,frontConstants.IMG_OPT_QRY_772)}" alt="img01" data-src="${frame:optImagePath(petLogBase.imgPath1,frontConstants.IMG_OPT_QRY_772) }"/></a>
									</li>
									<c:if test="${petLogBase.imgPath2 ne null and petLogBase.imgPath2 ne ''}">
									<li class="swiper-slide">
										<a class="petLogCardBox"><img class="img" src="${fn:indexOf(petLogBase.imgPath2, '.gif') > -1? frame:imagePath(petLogBase.imgPath2) : frame:optImagePath(petLogBase.imgPath2,frontConstants.IMG_OPT_QRY_772)}" alt="img01" data-src="${frame:optImagePath(petLogBase.imgPath2,frontConstants.IMG_OPT_QRY_772) }"/></a>
									</li>
									</c:if>
									<c:if test="${petLogBase.imgPath3 ne null and petLogBase.imgPath3 ne ''}">
									<li class="swiper-slide">
										<a class="petLogCardBox"><img class="img" src="${fn:indexOf(petLogBase.imgPath3, '.gif') > -1? frame:imagePath(petLogBase.imgPath3) : frame:optImagePath(petLogBase.imgPath3,frontConstants.IMG_OPT_QRY_772)}" alt="img01" data-src="${frame:optImagePath(petLogBase.imgPath3,frontConstants.IMG_OPT_QRY_772) }"/></a>
									</li>
									</c:if>
									<c:if test="${petLogBase.imgPath4 ne null and petLogBase.imgPath4 ne ''}">
									<li class="swiper-slide">
										<a class="petLogCardBox"><img class="img" src="${fn:indexOf(petLogBase.imgPath4, '.gif') > -1? frame:imagePath(petLogBase.imgPath4) : frame:optImagePath(petLogBase.imgPath4,frontConstants.IMG_OPT_QRY_772)}" alt="img01" data-src="${frame:optImagePath(petLogBase.imgPath4,frontConstants.IMG_OPT_QRY_772) }" /></a>
									</li>
									</c:if>
									<c:if test="${petLogBase.imgPath5 ne null and petLogBase.imgPath5 ne ''}">
									<li class="swiper-slide">
										<a class="petLogCardBox"><img class="img" src="${fn:indexOf(petLogBase.imgPath5, '.gif') > -1? frame:imagePath(petLogBase.imgPath5) : frame:optImagePath(petLogBase.imgPath5,frontConstants.IMG_OPT_QRY_772)}" alt="img01" data-src="${frame:optImagePath(petLogBase.imgPath5,frontConstants.IMG_OPT_QRY_772) }"/></a>
									</li>
									</c:if>
								</ul>
							</div>
							<div class="remote-area t1">
								<button class="swiper-button-next" type="button"></button>
								<button class="swiper-button-prev" type="button"></button>
							</div>
						</div>
				</c:otherwise>
			</c:choose>	
				<!-- // picture -->
				<!-- 댓글 pop -->
				<jsp:include page="/WEB-INF/view/goods/common/popupGoodsRelated.jsp" />
				<%-- <div class="commentBoxAp type01 handHead tabMode popconTingBox" id="exid" data-autoOpen = "true" data-priceh="60%" ><!-- commentBoxAp logcommentBox pop1 -->
					<div class="head h2 bnone">
						<div class="con">
							<button class="mo-header-backNtn t2">뒤로</button>
							<div class="tit">
								<!-- tab header -->
								<section class="sect petTabHeader">
									<ul class="uiTab b">
										<li class="active">
											<a class="bt" href="javascript:;">연관상품</a>
										</li>
										<li>
											<a class="bt active" href="javascript:;">장바구니</a>
										</li>
									</ul>
								</section>
								<!-- // tab header -->
							</div>
							<a href="javascript:;" class="close" onClick="ui.popLayer.close('popconTing');"></a>
						</div>
					</div>
					<div class="con">
						<!-- tab -->
						<section class="sect petTabContent">
							<!-- tab content -->
							<div class="uiTab_content">
								<ul>
									<li><!-- 
										no 이미지
										<div class="commentBox-noneBox" style="display:none;">
											<section class="no_data i2">
												<div class="inr">
													<div class="msg">
														연관된 상품이 없어요
													</div>
													<div class="uimoreview">
														<a href="javascript:;" class="bt more">펫로그 만들기</a>
													</div>
												</div>
											</section>
										</div>
										// no 이미지 -->
										<!-- 연관 상품 -->
										<div class="product-area" style="padding:20px 20px 0;">
											<c:forEach>
												<div class="item">
													<!-- 21.03.03 HTML 링크 변경 -->
													<div class="img-box">
														<a href="javascript:;">
															<img src="/../_images/tv/@temp01.jpg" alt="">
														</a>
														<button class="keep">보관하기</button>
														<button class="cart">장바구니</button>
													</div>
													<div class="tit"><a href="javascript:;">반려견 습식사료 아미로 후코이단 홀리티 20개 set</a></div>
													<div class="price">
														<a href="javascript:;">
															<strong class="num">23,000</strong>
															<span>원</span>
															<strong class="discount">10%</strong>
														</a>
													</div>
												</div>
											</c:forEach>
										</div>
										<!-- // 연관 상품 -->
									</li>
									<li>
										<!-- no 이미지 -->
										<div class="commentBox-noneBox" style="display:none;">
											<!-- no data -->
											<section class="no_data i2">
												<div class="inr">
													<div class="msg">
														장바구니에 담긴 상품이<br> 없습니다.
													</div>
													<div class="uimoreview">
														<a href="javascript:;" class="bt more">펫샵 쇼핑하로가기</a>
													</div>
												</div>
											</section>
											<!-- // no data -->
										</div>
										<!-- // no 이미지 -->
										<!-- 장바구니 -->
										<div class="cart-area cmb_inr_scroll">
											<!-- 04.14 : 수정 -->
											<div class="all-check">
												<label class="checkbox t01">
													<input type="checkbox"><span class="txt">전체 선택</span>
												</label>
											</div>
											<div class="check-list">
												<ul class="list">
													<c:forEach>
														<li>
															<div class="untcart">
																<label class="checkbox"><input type="checkbox"><span class="txt"></span></label>
																<div class="box">
																	<div class="tops">
																		<div class="pic"><img src="../../_images/_temp/goods_1.jpg" alt="상품" class="img"></div>
																		<div class="name">
																			<a href="javascript:;" class="tit">반려견 습식사료 아미로 후코이단 홀리티 20개 set</a>
																			<!-- 21.03.03 HTML 링크 변경 -->
																			<div class="stt">한입 맛보기 습식사료 체험 추가 증정</div>
																		</div>
																	</div>
																	<div class="amount">
																		<div class="uispiner">
																			<input type="text" value="1" class="amt" disabled>
																			<button type="button" class="bt minus">수량더하기</button>
																			<button type="button" class="bt plus">수량빼기</button>
																		</div>
																		<div class="prcs">
																			<span class="prc"><em class="p">25,000</em><i class="w">원</i></span>
																			<a href="javascript:;" class="btn sm a buy">바로구매</a>
																		</div>
																	</div>
																</div>
															</div>
														</li>
													</c:forEach>
												</ul>
												<p class="info-t1">최근에 장바구니에 담은 상품 5개까지만 노출됩니다.</p>
												<div class="btn-area">
													<a href="#" class="btn round" onclick="fncGoodsAppCloseMove('/order/indexCartList'); return false;" data-url="https://stg.aboutpet.co.kr/order/indexCartList">
														장바구니 전체보기<span class="arrow"></span>
													</a>
												</div>
											</div>
										</div>
										<nav class="cartNavs t2">
											<!-- t2클래스 삭제 -->
											<div class="inr">
												<!-- <div class="pdinfo">
													<div class="box">
														<span class="pic"><img class="img" src="../../_images/common/img_default_thumbnail@2x.png" alt=""></span>
														<div class="disc">
															<div class="names">반려견 습식사료 아미로 후코이단 홀리티 20개 후코이단 홀리티 20개 </div>
															<div class="price">
																<em class="p">23,000</em><i class="w">원</i>
															</div>
														</div>
													</div>
												</div> -->
												<div class="btns">
													<div class="obts">
														<button type="button" class="bt btOrde"><span class="t">구매하기</span></button>
														<!-- <button type="button" class="bt btAlim"><span class="t">입고알림</span></button> -->
													</div>
												</div>
											</div>
										</nav>
									</li>
								</ul>
							</div>
							<!-- // tab content -->
						</section>
						<!-- // tab -->
					</div>
				</div> --%>
				<!-- //댓글 -->
			</div>
			<!-- //본문 -->		
		</div>				
	</div>
</article>