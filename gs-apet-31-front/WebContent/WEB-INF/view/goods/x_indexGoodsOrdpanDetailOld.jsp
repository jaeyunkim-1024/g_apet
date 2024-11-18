<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="framework.front.constants.FrontConstants" %>
<tiles:insertDefinition name="default">
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">
			$(document).ready(function(){
			
			});

			function fnClickItemTotalCnt(){
				var priceCntStr = $("#inputPriceItemCnt").val();
				console.log("priceCntStr : " + priceCntStr);
				var priceCnt = Number(priceCntStr);
				var originPrice = Number("${listItems.saleAmt}");
				console.log("priceCnt : " + priceCnt + ", upDown : " + upDown + ", originPrice : " + originPrice);
				$("#emPriceTotalCnt").html(priceCnt);
				$("#emPriceTotalAmtItem").html(originPrice * priceCnt);
				$("#emPriceTotalAmt").html(originPrice * priceCnt);
			}

			$(document).off("click", ".uispiner .bt");
			//수량 컨트롤
			// $(document).on("click",".uispiner .plus",function(e){
			// 	e.preventDefault();
			// 	var $qtyObj = $(this).siblings(".amt");
			// 	console.log("plus", $qtyObj);
			// 	var maxOrdQty = $qtyObj.data("maxOrdQty");
			// 	if (!maxOrdQty || parseInt($qtyObj.val()) < maxOrdQty) {
			// 		var cartQty = parseInt($qtyObj.val()) + 1;
			// 		$qtyObj.val(cartQty);
			// 		var itemNo = $qtyObj.data("itemNo");
			// 		console.log("itemNo : " + itemNo + ", cartQty : " + cartQty);
			// 	}
			// });
			//
			// $(document).on("click",".uispiner .minus",function(e){
			// 	e.preventDefault();
			//
			// 	var $qtyObj = $(this).siblings(".amt");
			// 	console.log("minus", $qtyObj);
			// 	var minOrdQty = $qtyObj.data("minOrdQty") ? $qtyObj.data("minOrdQty") : 1;
			// 	if (parseInt($qtyObj.val()) > minOrdQty) {
			// 		var cartQty = parseInt($qtyObj.val()) - 1
			// 		$qtyObj.val(cartQty);
			//
			// 		var arrCart = new Array();
			// 		var itemNo = $qtyObj.data("itemNo");
			// 		console.log("itemNo : " + itemNo + ", cartQty : " + cartQty);
			// 	}
			// });

		</script>
	</tiles:putAttribute>

	<tiles:putAttribute name="content">

<%--		<article class="uiPdOrdPan open">--%>
			<input type="hidden" name="goodsItemTotalAmt" id="goodsItemTotalAmt" value="${listItems.saleAmt}" />
			<button type="button" class="btDrag">열기/닫기</button>
			<div class="hdts">
				<div class="inr">
					<div class="bts"><button type="button" class="bt close">닫기</button></div>
					<span class="tit">상품선택</span>
				</div>
			</div>
			<div class="optpan">
				<div class="inr">

					<div class="cdtwrap">
						<c:if test="${goodsCstrtTp ne FrontConstants.GOODS_CSTRT_TP_ITEM and goodsCstrtTp ne FrontConstants.GOODS_CSTRT_TP_SET}">
							<!-- 단품&세트인경우 품절 제외 버튼 무시. -->
							<div class="outof"><label class="checkbox"><input type="checkbox"><span class="txt">품절제외</span></label></div>
						</c:if>
						<div class="cdt cdt_l">
							<!-- 옵션 START -->
							<c:if test="${goodsCstrtTp ne FrontConstants.GOODS_CSTRT_TP_ITEM and goodsCstrtTp ne FrontConstants.GOODS_CSTRT_TP_SET}">
								<div class="optsets">
									<button type="button" class="btnsel">옵션을 선택해 주세요</button>
									<ul class="list">
										<li>
											<div class="unitSel gpic"><!--@@ 상품에 썸네일 있을경우 .gpic 클래스 02.06-->
												<div class="box"><!--@@ .box div 추가 02.06-->
													<div class="thum">
														<div class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="상품"></div>
													</div>
													<div class="infs"><!--@@ .infs div 추가 02.06-->
														<div class="cate">상품1</div>
														<a href="javascript:;" class="lk">HOTHALO 스몰브리드 연어&흰살생선 300g 10개 묶음 (+10,000)</a>
													</div>
													<div class="price"><em class="p">40,000</em><i class="w">원</i></div>
												</div>
												<div class="msgs"><!--@@ .msgs div 추가 02.06-->
													<span class="input"><input type="text" placeholder="각인문구를 입력해주세요" title="각인문구"></span>
													<div class="gud">상품을 담기전에 입력하신 내용을 한번 더 확인해주세요.</div>
												</div>
											</div>
										</li>
										<li>
											<div class="unitSel gpic soldout"><!-- 품절일때 .sold 클래스 -->
												<div class="box">
													<div class="thum">
														<div class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="상품"><em class="sold">품절</em></div>
													</div>
													<div class="infs">
														<div class="cate">상품2</div>
														<a href="javascript:;" class="lk">HOTHALO 스몰브리드 연어&흰살생선 300g 10개 묶음 (+10,000)</a>
													</div>
													<div class="price"><em class="p">40,000</em><i class="w">원</i></div>
												</div>
											</div>
										</li>
										<li>
											<div class="unitSel soldout">
												<div class="box">
													<div class="infs">
														<a href="javascript:;" class="lk">HOTHALO 스몰브리드 연어&흰살생선 300g 10개 묶음 (+10,000)</a>
													</div>
													<div class="price"><button type="button" class="bt alim">입고알림</button></div>
												</div>
											</div>
										</li>
										<li>
											<div class="unitSel">
												<div class="box">
													<div class="infs">
														<a href="javascript:;" class="lk">HOTHALO 스몰브리드 연어&흰살생선</a>
													</div>
													<div class="price"><em class="p">40,000</em><i class="w">원</i></div>
												</div>
											</div>
										</li>
										<li>
											<div class="unitSel">
												<div class="box">
													<div class="infs">
														<a href="javascript:;" class="lk">빨강</a>
													</div>
													<div class="price"><em class="p">40,000</em><i class="w">원</i></div>
												</div>
											</div>
										</li>
										<li>
											<div class="unitSel">
												<div class="box">
													<div class="infs">
														<a href="javascript:;" class="lk">파랑</a>
													</div>
													<div class="price"><em class="p">40,000</em><i class="w">원</i></div>
												</div>
											</div>
										</li>
									</ul>
								</div>
								<div class="optsets">
									<button type="button" class="btnsel">옵션을 선택해 주세요</button>
									<ul class="list">
										<li>
											<div class="unitSel gpic">
												<div class="box">
													<div class="thum">
														<div class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="상품"><em class="sold">품절</em></div>
													</div>
													<div class="infs">
														<div class="cate">상품1</div>
														<a href="javascript:;" class="lk">HOTHALO 스몰브리드 연어&흰살생선 300g 10개 묶음 (+10,000)</a>
													</div>
													<div class="price"><em class="p">40,000</em><i class="w">원</i></div>
												</div>
											</div>
										</li>
										<li>
											<div class="unitSel soldout">
												<div class="box">
													<div class="infs">
														<a href="javascript:;" class="lk">HOTHALO 스몰브리드 연어&흰살생선 300g 10개 묶음 (+10,000)</a>
													</div>
													<div class="price"><button type="button" class="bt alim">입고알림</button></div>
												</div>
											</div>
										</li>
										<li>
											<div class="unitSel">
												<div class="box">
													<div class="infs">
														<a href="javascript:;" class="lk">HOTHALO 스몰브리드 연어&흰살생선 300g 10개 묶음 (+10,000)</a>
													</div>
													<div class="price"><em class="p">40,000</em><i class="w">원</i></div>
												</div>
											</div>
										</li>
									</ul>
								</div>
								<!-- 옵션 END -->
							</c:if>

							<div class="optresul">
								<!-- 단품&세트 상품 -->
<%--								goodsCstrtTp--%>
								<c:if test="${goodsCstrtTp eq FrontConstants.GOODS_CSTRT_TP_ITEM}">
									<ul class="list">
										<li>
											<div class="unitRes">
												<div class="box">
<%--													<button type="button" class="bt del">삭제</button>--%>
													<div class="infs">
<%--														<a href="javascript:;" class="lk">HOTHALO 스몰브리드 연어&흰살생선 300g 10개 묶음 (+10,000)</a>--%>
														<a href="javascript:;" class="lk">${listItems.itemNm}</a>
													</div>
												</div>
												<div class="cots">
													<div class="uispiner"  data-max="5">
<%--														<input type="text" value="1" class="amt" step="1" id="inputPriceItemCnt" name="inputPriceItemCnt">--%>
														<input type="text" value="1" name="buyQty" class="amt"
															   id="buyQty${listItems.itemNo}" name="buyQty"
															   data-item-no="${listItems.itemNo}"
															   data-min-ord-qty="1"
															   data-max-ord-qty="5" >
<%--														data-content="" data-url=""--%>
														<button type="button" class="bt minus" >수량빼기</button>
														<button type="button" class="bt plus" >수량더하기</button>
													</div>
													<div class="price">
<%--														<em class="p">23,000</em><i class="w">원</i>--%>
														<em class="p" id="emPriceTotalAmtItem">${listItems.saleAmt}</em><i class="w">원</i>
													</div>
												</div>
												<div class="msgs">
													<span class="input"><input type="text" placeholder="각인문구를 입력해주세요" title="각인문구"></span>
													<div class="gud">상품을 담기전에 입력하신 내용을 한번 더 확인해주세요.</div>
												</div>
											</div>
										</li>
									</ul>
								</c:if>

							</div>
						</div>
						<div class="cdt cdt_r">
							<div class="optresul">
								<c:if test="${goodsCstrtTp ne FrontConstants.GOODS_CSTRT_TP_ITEM and goodsCstrtTp ne FrontConstants.GOODS_CSTRT_TP_SET}">
									<ul class="list">
										<li>
											<div class="unitRes gpic">
												<div class="box">
													<button type="button" class="bt del">삭제</button>
													<div class="thum">
														<div class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="상품"></div>
													</div>
													<div class="infs">
														<div class="cate">상품1</div>
														<a href="javascript:;" class="lk">HOTHALO 스몰브리드 연어&흰살생선 300g 10개 묶음 (+10,000)</a>
													</div>
												</div>
												<div class="cots">
													<div class="uispiner"  data-max="5">
														<input type="text" value="1" class="amt">
														<button type="button" class="bt minus">수량더하기</button>
														<button type="button" class="bt plus">수량빼기</button>
													</div>
													<div class="price">
														<em class="p">23,000</em><i class="w">원</i>
													</div>
												</div>
												<div class="msgs">
													<span class="input"><input type="text" placeholder="각인문구를 입력해주세요" title="각인문구"></span>
													<div class="gud">상품을 담기전에 입력하신 내용을 한번 더 확인해주세요.</div>
												</div>
											</div>
										</li>
										<li>
											<div class="unitRes gpic soldout">
												<div class="box">
													<button type="button" class="bt del">삭제</button>
													<div class="thum">
														<div class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="상품"><em class="sold">품절</em></div>
													</div>
													<div class="infs">
														<div class="cate">상품1</div>
														<a href="javascript:;" class="lk">HOTHALO 스몰브리드 연어&흰살생선 300g 10개 묶음 (+10,000)</a>
													</div>
												</div>
												<div class="cots">
													<div class="uispiner"  data-max="5">
														<input type="text" value="1" class="amt" id="emPriceItemCnt" min="1">
														<button type="button" class="bt minus">수량더하기</button>
														<button type="button" class="bt plus">수량빼기</button>
													</div>
													<div class="price">
														<em class="p">23,000</em><i class="w">원</i>
													</div>
												</div>
											</div>
										</li>
										<li>
											<div class="unitRes">
												<div class="box">
													<button type="button" class="bt del">삭제</button>
													<div class="infs">
														<a href="javascript:;" class="lk">HOTHALO 스몰브리드 연어&흰살생선 300g 10개 묶음 (+10,000)</a>
													</div>
												</div>
												<div class="cots">
													<div class="uispiner"  data-max="5">
														<input type="text" value="1" class="amt">
														<button type="button" class="bt minus">수량더하기</button>
														<button type="button" class="bt plus">수량빼기</button>
													</div>
													<div class="price">
														<em class="p">23,000</em><i class="w">원</i>
													</div>
												</div>
											</div>
										</li>
										<li>
											<div class="unitRes">
												<div class="box">
													<button type="button" class="bt del">삭제</button>
													<div class="infs">
														<a href="javascript:;" class="lk">HOTHALO 스몰브리드 연어&흰살생선 300g 10개 묶음 (+10,000)</a>
													</div>
												</div>
												<div class="cots">
													<div class="uispiner"  data-max="5">
														<input type="text" value="1" class="amt">
														<button type="button" class="bt minus">수량더하기</button>
														<button type="button" class="bt plus">수량빼기</button>
													</div>
													<div class="price">
														<em class="p">23,000</em><i class="w">원</i>
													</div>
												</div>
											</div>
										</li>
										<li>
											<div class="unitRes">
												<div class="box">
													<button type="button" class="bt del">삭제</button>
													<div class="infs">
														<a href="javascript:;" class="lk">HOTHALO 스몰브리드 연어&흰살생선 300g 10개 묶음 (+10,000)</a>
													</div>
												</div>
												<div class="cots">
													<div class="uispiner"  data-max="5">
														<input type="text" value="1" class="amt">
														<button type="button" class="bt minus">수량더하기</button>
														<button type="button" class="bt plus">수량빼기</button>
													</div>
													<div class="price">
														<em class="p">23,000</em><i class="w">원</i>
													</div>
												</div>
											</div>
										</li>
										<li>
											<div class="unitRes">
												<div class="box">
													<button type="button" class="bt del">삭제</button>
													<div class="infs">
														<a href="javascript:;" class="lk">HOTHALO 스몰브리드 연어&흰살생선 300g 10개 묶음 (+10,000)</a>
													</div>
												</div>
												<div class="cots">
													<div class="uispiner"  data-max="5">
														<input type="text" value="1" class="amt">
														<button type="button" class="bt minus">수량더하기</button>
														<button type="button" class="bt plus">수량빼기</button>
													</div>
													<div class="price">
														<em class="p">23,000</em><i class="w">원</i>
													</div>
												</div>
											</div>
										</li>
									</ul>
								</c:if>
							</div>
						</div>
					</div>

					<div class="tots">
						<div class="inr">
							<div class="amts">
								<i class="t">총 수량</i>
								<em class="amt"><i class="i" id="emPriceTotalCnt">1</i><i class="s">개</i></em>
							</div>
							<div class="price">
								<i class="t">합계</i>
								<em class="prc"><i class="i" id="emPriceTotalAmt">${listItems.saleAmt}</i><i class="s">원</i></em>
							</div>
						</div>
					</div>
				</div>
			</div>
<%--		</article>--%>

	</tiles:putAttribute>
</tiles:insertDefinition>

