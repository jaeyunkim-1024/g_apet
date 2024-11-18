<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">

	/**
	 * [POPBOT] 상품 선택 콤보창 열기
	 */
	function fnOpenPopOptPdSel() {
		ui.popBot.open('popOptPdSel', {pop: true});
	}

	/**
	 * [POPBOT] 상품 선택 , 상품 선택 콤보창 닫기
	 */
	function fnClosePopOptPdSel(goodsId) {
		if(goodsId) {
			fnOpenPopPdDetView(goodsId, false);
		}
		ui.popBot.close('popOptPdSel');
	}
</script>
<article class="popLayer a popPdDetView" id="popPdDetView">
	<div class="pbd">
		<div class="phd">
			<div class="in">
				<h1 class="tit">상품 자세히 보기</h1>
				<button type="button" class="btnPopClose" onclick="fnClosePopPdDetView();">닫기</button>
			</div>
		</div>
		<div class="pct">
			<main class="poptents">
				<div class="btstop">
					<button type="button" class="bt cpnall" onclick="fnOpenPopOptPdSel()">
						<span class="tit" id="optPdCount"></span>
						<span class="con" id="optPdNm" style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap;"></span>
					</button>
					<article class="popBot popOptPdSel" id="popOptPdSel">
						<div class="pbd">
							<div class="phd">
								<div class="in">
									<h1 class="tit">상품선택</h1>
									<button type="button" class="btnPopInClose" onclick="fnClosePopOptPdSel()">닫기</button>
								</div>
							</div>
							<div class="pct" style="height: 611px;">
								<main class="poptents">
									<div class="ugdoptlist">
										<ul class="gdtlist">
											<c:if test="${!empty goodsCstrtList}">
												<c:forEach items="${goodsCstrtList}" var="goodsCstrt" varStatus="status">
													<li>
														<div class="unitSel gpic <c:if test="${goodsCstrt.salePsbCd ne frontConstants.SALE_PSB_00 }">soldOut</c:if>" onclick="javascript:fnClosePopOptPdSel('<c:out value="${goodsCstrt.goodsId}"/>');">
															<div class="box">
																<div class="thum">
																	<div class="pic">
<!-- 																		직사각형을 정사각형으로 변경함. frontConstants.IMG_OPT_QRY_60 >>>> frontConstants.IMG_OPT_QRY_700 -->
																		<img class="img" src="${frame:optImagePath( goodsCstrt.imgPath , frontConstants.IMG_OPT_QRY_700 )}" onerror="this.src='${view.noImgPath}'" alt="이미지"/>
																		<c:if test="${goodsCstrt.salePsbCd eq frontConstants.SALE_PSB_10}" > <!-- 판매중지 -->
																			<p class="txt">판매중지</p> 
																		</c:if>
																		<c:if test="${goodsCstrt.salePsbCd eq frontConstants.SALE_PSB_20}" > <!-- 판매종료 -->
																			<p class="txt">판매종료</p>
																		</c:if>
																		<c:if test="${goodsCstrt.salePsbCd eq frontConstants.SALE_PSB_30}" > <!-- 품절 -->
																			<p class="txt"><spring:message code='front.web.view.common.goods.saleSoldOut.title'/></p>
																		</c:if>
																	</div>
																</div>
																<div class="infs">
																	<div class="cate">상품<c:out value="${status.count}"/></div>
																	<a href="javascript:;" class="lk"><c:out value="${goodsCstrt.goodsNm}"/></a>
																</div>
																<div class="price"><em class="p"><frame:num data="${goodsCstrt.saleAmt}"></frame:num></em><i class="w">원</i></div>
															</div>
														</div>
													</li>
												</c:forEach>
											</c:if>
										</ul>
									</div>
								</main>
							</div>
						</div>
					</article>
				</div>
				<div class="html_editor mo" id="cstrtMobile"></div>
				<div class="html_editor pc" id="cstrtPc"></div>
			</main>
		</div>
	</div>
</article>