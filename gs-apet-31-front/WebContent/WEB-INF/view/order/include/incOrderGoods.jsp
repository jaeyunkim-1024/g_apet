<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
	
	function directOrderFunc(cartId, goodsId, itemNo, pakGoodsId, mkiGoodsYn, mkiGoodsOptContent, isMiniCart, directGoodsNm, directGoodsOptNm ,isLogin){
		if(isLogin == 'false'){
			ui.confirm('로그인 후 서비스를 이용할 수 있어요.<br>로그인 할까요?', { // 컨펌 창 옵션들
				ycb: function () {
					var url = encodeURIComponent(document.location.href);
					console.log("url :"+url);
					if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true" && document.location.href.indexOf("/tv/series/indexTvDetail") > -1){
						fncAppCloseMoveLogin(url);
					}else{
						document.location.href = '/indexLogin?returnUrl=' + url;
					}
				},
				ncb: function () {
					return false;
				},
				ybt: '확인', // 기본값 "확인"
				nbt: '취소'  // 기본값 "취소"
			});
		}else{
			cartGoods.directOrder(cartId,goodsId, itemNo, pakGoodsId,mkiGoodsYn, mkiGoodsOptContent, isMiniCart, directGoodsNm, directGoodsOptNm);
		}
	}
	
</script>
<li>
	<div class="untcart ${cart.salePsbCd ne frontConstants.SALE_PSB_00 ? 'sold' : (not empty cart.totalSalePsbCd and cart.totalSalePsbCd ne frontConstants.SALE_PSB_00 ? 'sold' : '')}" id="untcart${cart.cartId}">
	<input type="hidden" name="salePrc" value="${cart.salePrc }"/>
	<input type="hidden" name="prmtDcAmt" value="${cart.prmtDcAmt }"/>
	<input type="hidden" name="salePsbCd" value="${cart.salePsbCd }"/>
	<input type="hidden" name="selMbrCpNo" value="${cart.selMbrCpNo }"/>
	<input type="hidden" name="totCpDcAmt" value="${cart.selTotCpDcAmt }"/>
	<input type="hidden" name="cpDcAmt" value="${cart.selCpDcAmt }"/>
	<input type="hidden" name="dlvrcPlcNo" value="${cart.dlvrcPlcNo }"/>
	<input type="hidden" name="compGbCd" value="${cart.compGbCd }"/>
	<input type="hidden" name="goodsId" value="${cart.goodsId }"/>
	<input type="hidden" name="itemNo" value="${cart.itemNo }"/>
	<input type="hidden" name="pakGoodsId" value="${cart.pakGoodsId }"/>
	<input type="hidden" name="freeDlvrYn" value="${cart.freeDlvrYn}"/>
	
	
	<label class="checkbox">
		<input type="checkbox" id="chkCartId${cart.cartId}" name="cartIds" value="${cart.cartId}"
		   ${cart.goodsPickYn eq 'Y' && cart.salePsbCd eq frontConstants.SALE_PSB_00 && empty cart.totalSalePsbCd ? 'checked="checked"' : (not empty cart.totalSalePsbCd and cart.goodsPickYn eq 'Y' and cart.totalSalePsbCd eq frontConstants.SALE_PSB_00 ? 'checked="checked"' : '')}
		   ${cart.salePsbCd ne frontConstants.SALE_PSB_00 ? 'disabled' : (not empty cart.totalSalePsbCd and cart.totalSalePsbCd ne frontConstants.SALE_PSB_00 ? 'disabled' : '')}>
		<span class="txt"></span>
	</label>
	<button type="button" class="bt del" onclick="cartGoods.del('${cart.cartId}', ${isMiniCart})" data-content="${cart.cartId}" data-url="${view.stDomain}/order/deleteCart">삭제</button>
	<div class="box">
		<div class="tops">
			<a href="${view.stDomain}/goods/indexGoodsDetail?goodsId=${not empty cart.pakGoodsId ? cart.pakGoodsId : cart.goodsId }" class="pic"  data-content="${not empty cart.pakGoodsId ? cart.pakGoodsId : cart.goodsId }" data-url="${view.stDomain}/goods/indexGoodsDetail?goodsId=${not empty cart.pakGoodsId ? cart.pakGoodsId : cart.goodsId }">
				<img src="${fn:indexOf(cart.imgPath, 'cdn.ntruss.com') > -1 ? cart.imgPath : frame:optImagePath(cart.imgPath, frontConstants.IMG_OPT_QRY_500)}" alt="${cart.goodsNm }" class="img">
				<c:if test="${cart.salePsbCd eq frontConstants.SALE_PSB_10}">
					<em class="sold">판매중지</em>
				</c:if>
				<c:if test="${cart.salePsbCd eq frontConstants.SALE_PSB_20}">
					<em class="sold">판매종료</em>
				</c:if>
				<c:if test="${cart.salePsbCd eq frontConstants.SALE_PSB_30}">
					<em class="sold"><spring:message code='front.web.view.common.goods.saleSoldOut.title'/></em>
				</c:if>
				<c:if test="${cart.salePsbCd eq frontConstants.SALE_PSB_00}">
					<c:choose>
						<c:when test="${cart.totalSalePsbCd eq frontConstants.SALE_PSB_10}">
							<em class="sold">판매중지</em>
						</c:when>
						<c:when test="${cart.totalSalePsbCd eq frontConstants.SALE_PSB_20}">
							<em class="sold">판매종료</em>
						</c:when>
						<c:when test="${cart.totalSalePsbCd eq frontConstants.SALE_PSB_30}">
							<em class="sold"><spring:message code='front.web.view.common.goods.saleSoldOut.title'/></em>
						</c:when>
					</c:choose>
				</c:if>
			</a>
			<div class="name">
				<a href="${view.stDomain}/goods/indexGoodsDetail?goodsId=${not empty cart.pakGoodsId ? cart.pakGoodsId : cart.goodsId }" class="tit" data-content="${not empty cart.pakGoodsId ? cart.pakGoodsId : cart.goodsId }" data-url="${view.stDomain}/goods/indexGoodsDetail?goodsId=${not empty cart.pakGoodsId ? cart.pakGoodsId : cart.goodsId }">${cart.goodsNm }</a>
				<c:forEach var="freebie" items="${cart.freebieList}" varStatus="freeStatus">
					<!-- 대표사은품 1개만 노출 -->
					<c:if test="${freeStatus.first }">
						<div class="stt">
							${freebie.goodsNm}
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
		
		<c:if test="${(cart.goodsCstrtTpCd eq frontConstants.GOODS_CSTRT_TP_PAK and not empty cart.optGoodsNm)  or (cart.goodsCstrtTpCd eq frontConstants.GOODS_CSTRT_TP_ATTR and fn:length(cart.goodsOptList) > 0) 
					or cart.mkiGoodsYn eq 'Y' && not empty cart.mkiGoodsOptContent}">
			<ul class="opts">
				<c:if test="${cart.goodsCstrtTpCd eq frontConstants.GOODS_CSTRT_TP_PAK and  not empty cart.optGoodsNm}" >
					<li class="opt">
						<!-- 묶음상품 옵션 명  -->
						<em class="tt">옵션</em>
						<span class="dt">${cart.optGoodsNm }</span>
					</li>
				</c:if>
				<c:if test="${cart.goodsCstrtTpCd eq frontConstants.GOODS_CSTRT_TP_ATTR and fn:length(cart.goodsOptList) > 0 }">
					<li class="opt">
						<em class="tt">옵션</em>
						<span class="dt">
							<c:forEach var="goodsOpt" items="${cart.goodsOptList }" varStatus="optStatus">
								${goodsOpt.showNm } : ${goodsOpt.attrVal} ${!optStatus.last ? ' / ' : '' }
							</c:forEach>
						</span>
					</li>
				</c:if>
				<c:if test="${cart.mkiGoodsYn eq 'Y' && not empty cart.mkiGoodsOptContent}">
					<c:forTokens var="optContent" items="${cart.mkiGoodsOptContent }" delims="|" varStatus="conStatus">
						<li class="opt">
							<em class="tt">각인문구${conStatus.count}</em>
							<span class="dt"><a href="${view.stDomain}/goods/indexGoodsDetail?goodsId=${not empty cart.pakGoodsId ? cart.pakGoodsId : cart.goodsId }">${optContent }</a></span>
						</li>
					</c:forTokens>
				</c:if>
			</ul>
		</c:if>
		<div class="amount">
			<c:set var="maxOrdQty" value="${cart.stkQty}"/>
			<c:if test="${not empty cart.maxOrdQty and cart.maxOrdQty lt cart.stkQty  }">
				<c:set var="maxOrdQty" value="${cart.maxOrdQty}"/>
			</c:if>
			
			<c:choose>
				<c:when test="${isMiniCart }">
					<div class="uispiner" ${cart.mkiGoodsYn eq 'Y' && not empty cart.mkiGoodsOptContent ? 'style="display:none"' : ''}>
						<input type="number" class="amt" disabled
								id="buyQty${cart.cartId}" name="buyQty"
							    value="${cart.buyQty}"
							   data-cart-id="${cart.cartId}"
							   data-min-ord-qty="${cart.minOrdQty}"
							   data-max-ord-qty="${maxOrdQty}" >
						<button type="button" class="bt minus" data-content="${cart.cartId}" data-url="${view.stDomain}/order/updateCartBuyQtyAndCheckYn">수량더하기</button>
						<button type="button" class="bt plus" data-content="${cart.cartId}" data-url="${view.stDomain}/order/updateCartBuyQtyAndCheckYn">수량빼기</button>
					</div>
				</c:when>
				<c:otherwise>
					<span class="uispined" data-max="${maxOrdQty }" data-min="${cart.minOrdQty }" ${cart.mkiGoodsYn eq 'Y' && not empty cart.mkiGoodsOptContent ? 'style="display:none"' : ''}>
						<input type="number" class="amt" id="buyQty${cart.cartId}" name="buyQty" value="${cart.buyQty}" ${cart.salePsbCd ne frontConstants.SALE_PSB_00 ? 'disabled' : (not empty cart.totalSalePsbCd and cart.totalSalePsbCd ne frontConstants.SALE_PSB_00 ? 'disabled' : '')}
							   data-cart-id="${cart.cartId}"
							   data-min-ord-qty="${cart.minOrdQty}"
							   data-max-ord-qty="${maxOrdQty}">
					</span>
				</c:otherwise>
			</c:choose>
			
			
			
			<%-- <span class="uispined" data-max="${maxOrdQty }"><input class="amt" value="${cart.buyQty}" type="number"></span> --%>
			
			<div class="prcs">
				<em class="st" ${empty cart.selMbrCpNo ? 'style="display:none"' : ''}>쿠폰적용가</em>
				<span class="prc"><em class="p"><frame:num data="${(cart.salePrc - cart.prmtDcAmt) * cart.buyQty - cart.selTotCpDcAmt  }"/></em><i class="w">원</i></span>
			</div>
			<c:if test="${(!isMiniCart && cart.salePsbCd eq frontConstants.SALE_PSB_00)
							and (empty cart.totalSalePsbCd or (not empty cart.totalSalePsbCd and cart.totalSalePsbCd eq frontConstants.SALE_PSB_00))}">
				<c:choose>
					<c:when test="${cart.freeDlvrYn eq 'Y' }">
						<div class="free">무료 배송</div>
					</c:when>
					<c:when test="${cart.dlvrcStdCd eq frontConstants.DLVRC_STD_10}">
						<div class="free">무료 배송</div>
					</c:when>
					<c:when test="${cart.dlvrcStdCd eq frontConstants.DLVRC_STD_20}">
						<div class="free">
							<frame:num data="${cart.dlvrcDlvrAmt }"/>원
							<c:choose>
								<c:when test="${cart.dlvrcCdtStdCd eq frontConstants.DLVRC_CDT_STD_10}">
									<!-- 유료배송 -->
									<c:if test="${cart.dlvrcCdtCd eq frontConstants.DLVRC_CDT_10}">
										<!-- 개당적용 -->
										(수량별)
									</c:if>
								</c:when>
								<c:when test="${cart.dlvrcCdtStdCd eq frontConstants.DLVRC_CDT_STD_20}">
									<!-- 조건부 무료배송 - 가격-->
									<c:if test="${cart.dlvrcCdtCd eq frontConstants.DLVRC_CDT_10}">
										<!-- 개당적용 -->
										(수량별/<frame:num data="${cart.dlvrcBuyPrc}"/>원 이상 무료배송)
									</c:if>
									<c:if test="${cart.dlvrcCdtCd eq frontConstants.DLVRC_CDT_20}">
										<!-- 주문당적용 -->
										(<frame:num data="${cart.dlvrcBuyPrc}"/>원 이상 무료배송)
									</c:if>
								</c:when>
								<c:when test="${cart.dlvrcCdtStdCd eq frontConstants.DLVRC_CDT_STD_30}">
									<!-- 조건부 무료배송 - 수량-->
									<!-- 조건부 무료배송 - 가격-->
									<c:if test="${cart.dlvrcCdtCd eq frontConstants.DLVRC_CDT_10}">
										<!-- 개당적용 -->
										(수량별/<frame:num data="${cart.dlvrcBuyQty}"/>개 이상 무료배송)
									</c:if>
									<c:if test="${cart.dlvrcCdtCd eq frontConstants.DLVRC_CDT_20}">
										<!-- 주문당적용 -->
										(<frame:num data="${cart.dlvrcBuyQty}"/>개 이상 무료배송)
									</c:if>
								</c:when>
							</c:choose>
						</div>
					</c:when>
					<c:otherwise>
					
					</c:otherwise>
				</c:choose>
			</c:if>
		</div>
		<div class="btns">
			<c:choose>
				<c:when test="${(cart.salePsbCd eq frontConstants.SALE_PSB_00) and (empty cart.totalSalePsbCd or (not empty cart.totalSalePsbCd and cart.totalSalePsbCd eq frontConstants.SALE_PSB_00))}">
					<c:if test="${fn:length(cart.couponList) > 0 && !isMiniCart}">
						<a href="javascript:;" class="btn sm d cpm" onclick="cartGoods.openCouponPop('${cart.cartId}')" data-content="${cart.cartId}" data-url="${view.stDomain}/order/popupCouponUse">쿠폰변경</a>
					</c:if>
					<a href="javascript:;" class="btn sm a buy" onclick="directOrderFunc('${cart.cartId }','${cart.goodsId}', '${cart.itemNo }', '${cart.pakGoodsId }', '${cart.mkiGoodsYn }', '${cart.mkiGoodsOptContent }', '${isMiniCart}', '${cart.goodsNm}', '${cart.optGoodsNm}','${session.isLogin()}'
					);" data-content="${cart.cartId}" data-url="${view.stDomain}/order/indexOrderPayment">바로구매</a>
				</c:when>
				<c:when test="${(cart.salePsbCd eq frontConstants.SALE_PSB_30 or (cart.salePsbCd eq frontConstants.SALE_PSB_00 and not empty cart.totalSalePsbCd and cart.totalSalePsbCd eq frontConstants.SALE_PSB_30)) and cart.ioAlmYn eq 'Y'}">
					<c:choose>
						<c:when test="${empty cart.pakGoodsId}">
							<c:set var="almGoodsId" value="${cart.goodsId}"/>
						</c:when>
						<c:otherwise>
							<c:set var="almGoodsId" value="${cart.goodsId}:${cart.pakGoodsId}"/>
						</c:otherwise>
					</c:choose>
					<a href="javascript:;" class="btn sm d alim" 
					data-target="goods" 
					data-action="ioAlarm"
					data-goods-id="${almGoodsId }" 
					data-content="${almGoodsId }"
					data-url="">재입고알림</a>
				</c:when>
				<c:otherwise>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	</div>
</li>
