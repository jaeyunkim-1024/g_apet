<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="framework.common.constants.CommonConstants" %>
<script type="text/javascript">
	$(document).ready(function(){
		var addCnt = "${insertCouponCnt}";
		var addMsg = "${insertCouponMsg}";
		console.log("addCnt : " + addCnt + ", addMsg : " + addMsg);
		if(addCnt == 0 && addMsg.length > 0){
			alert(addMsg);
		}
		console.log("sto : " + JSON.stringify('${sto}') );
		// divMoreload
		var goodsCouponPage = "${goodsCouponPage}";
		var goodsCouponTotalPageCount = "${goodsCouponTotalPageCount}";
		var listCouponSize = "${listCouponSize}";
		console.log("goodsCouponPage : " + goodsCouponPage + ", goodsCouponTotalPageCount : " + goodsCouponTotalPageCount + ", listCouponSize : " + listCouponSize);
		$("#divCouponMoreload").hide();
		if(goodsCouponPage < goodsCouponTotalPageCount){
			$("#divCouponMoreload").show();
		}
	}); // End Ready
</script>

<main class="poptents">
	<input type="hidden" name="isCouponMember" id="isCouponMember" value="${isCouponMember}" />
	<c:if test="${!goods.goodsCstrtTpCd eq CommonConstants.GOODS_CSTRT_TP_ATTR or goods.goodsCstrtTpCd eq CommonConstants.GOODS_CSTRT_TP_PAK}">
		<div class="btstop" >
			<div class="revalls">
				<div class="selopts">
				<span class="select-pop">
					<select class="sList" name="select_pop_123">
<%--						<option value="${goodsId}">전체 상품 쿠폰</option>--%>
						<button type="button" class="bt cpnall" onclick="ui.popBot.open('popOptPdSel');">전체 상품 쿠폰</button><!-- 쿠폰상품선택 @@02.25 추가 수정 -->
							<article class="popBot popOptPdSel" id="popOptPdSel">
								<div class="pbd">
									<div class="phd">
										<div class="in">
											<h1 class="tit">상품선택</h1>
											<button type="button" class="btnPopInClose"  onclick="ui.popBot.close('popOptPdSel');">닫기</button>
										</div>
									</div>
									<div class="pct">
										<main class="poptents">
											<div class="ugdoptlist">
												<ul class="gdtlist">
													<li>
														<div class="unitSel">
															<div class="box">
																<div class="infs">
																	<a href="javascript:" class="lk">전체 상품 쿠폰</a>
																</div>
															</div>
														</div>
													</li>
													<li>
														<div class="unitSel gpic"><!--@@ 상품에 썸네일 있을경우 .gpic 클래스 02.06-->
															<div class="box">
																<div class="thum">
																	<div class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="상품"></div>
																</div>
																<div class="infs">
																	<div class="cate">상품1</div>
																	<a href="javascript:" class="lk">HOTHALO 스몰브리드 연어&amp;흰살생선 300g 10개 묶음 (+10,000)</a>
																</div>
																<div class="price"><em class="p">40,000</em><i class="w">원</i></div>
															</div>
														</div>
													</li>
													<li>
														<div class="unitSel gpic"><!--@@ 상품에 썸네일 있을경우 .gpic 클래스 02.06-->
															<div class="box">
																<div class="thum">
																	<div class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="상품"></div>
																</div>
																<div class="infs">
																	<div class="cate">상품1</div>
																	<a href="javascript:" class="lk">HOTHALO 스몰브리드 연어&amp;흰살생선 300g 10개 묶음 (+10,000)</a>
																</div>
																<div class="price"><em class="p">40,000</em><i class="w">원</i></div>
															</div>
														</div>
													</li>
													<li>
														<div class="unitSel gpic"><!--@@ 상품에 썸네일 있을경우 .gpic 클래스 02.06-->
															<div class="box">
																<div class="thum">
																	<div class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="상품"></div>
																</div>
																<div class="infs">
																	<div class="cate">상품1</div>
																	<a href="javascript:" class="lk">HOTHALO 스몰브리드 연어&amp;흰살생선 300g 10개 묶음 (+10,000)</a>
																</div>
																<div class="price"><em class="p">40,000</em><i class="w">원</i></div>
															</div>
														</div>
													</li>
												</ul>
											</div>
										</main>
									</div>
								</div>
							</article>
						<c:forEach var="item" items="${goodsCstrtInfoList}">
							<option value="${item.cstrtGoodsId}" <c:if test="${searchGoodsId eq item.cstrtGoodsId}">selected</c:if>>${item.goodsNm}</option>
						</c:forEach>
					</select>
				</span>
				</div>
			</div>
		</div>
	</c:if>

	<c:if test="${not empty listCoupon}">
		<div class="cupon-wrap">
			<div class="cupon-area t2 setAutoh" data-dh="60">
				<ul class="cupon-list">
					<c:forEach var="item" items="${listCoupon}">
						<li <c:if test="${item.cpDwYn == 'Y'}">class="disabled"</c:if> style="min-height: 105px;">
							<div class="sale">
								<c:if test="${item.aplVal > 0}">
									<c:choose>
										<c:when test="${item.cpAplCd eq '20'}">
											${item.aplVal}원 할인
										</c:when>
										<c:when test="${item.cpAplCd eq '10'}">
											${item.aplVal}% 할인
										</c:when>
										<c:otherwise>
											${item.aplVal}원 할인
										</c:otherwise>
									</c:choose>
								</c:if>

								<c:if test="${item.notice != '<p>&nbsp;</p>'}" >
									<div class="uitooltip">
										<button type="button" class="btn i btnTooltop">이용안내</button>
										<div class="toolctn">
											<div class="tptit">이용안내</div>
											<ul class="tplist">
												<li><c:out value="${item.notice}" escapeXml="false"/></li>
													<%--										<li>‘미용/목욕’ 카테고리에서만 사용 가능한 쿠폰입니다.</li>--%>
												<li>쿠폰 등록 시 이용안내에 입력한 내용이 노출됩니다</li>
											</ul>
										</div>
									</div>
								</c:if>


									<%--							<button type="button" class="btn i" onclick="fnCouponNotice('${item.notice}')">이용안내 팝업</button>--%>
							</div>
							<p class="tit">${item.cpNm}</p>
							<div class="bottom-item">

								<div class="txt">
									<p>
										<c:if test="${item.minBuyAmt > 0}">${item.minBuyAmt}원 이상 구매 시</c:if>
										<c:if test="${item.minBuyAmt > 0 and item.maxDcAmt > 0}">/</c:if>
										<c:if test="${item.maxDcAmt > 0}">${item.maxDcAmt}원 할인</c:if>
									</p>
									<p><fmt:formatDate value="${item.vldPrdStrtDtm}" pattern="yyyy-MM-dd HH:mm"/> ~ <fmt:formatDate value="${item.vldPrdEndDtm}" pattern="yyyy-MM-dd HH:mm"/></p>
								</div>

							</div>

							<button class="btn-down" data-cpn-no="${item.cpNo}" <c:if test="${item.cpDwYn == 'Y'}" >disabled</c:if>>
								쿠폰 다운로드
							</button>
						</li>
					</c:forEach>
				</ul>
				<div class="moreload" id="divCouponMoreload" onclick="fnCouponInfo('${searchGoodsId}', '${goodsCouponPage}')">
					<button type="button" class="bt more" id="goodsMore">쿠폰 더보기</button>
				</div>
			</div>
		</div>
	</c:if>
</main>

<%--<tiles:insertDefinition name="default">--%>
<%--	<tiles:putAttribute name="content">--%>
<%--		--%>
<%--	</tiles:putAttribute>--%>
<%--</tiles:insertDefinition>--%>
