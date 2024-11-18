<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<section class="sect info" id="goodsCoupon${cart.cartId }">
	<input type="hidden" name="cartId" value="${cart.cartId}"/>
	<input type="hidden" name="saleAmt" value="${(cart.salePrc - cart.prmtDcAmt) * cart.buyQty }"/>
	<input type="hidden" name="optimalMbrCpNo"  value="${cart.optimalMbrCpNo}"/>
	<input type="hidden" name="selMbrCpNo"  value="${cart.selMbrCpNo}"/>
	<input type="hidden" name="compGbCd"  value="${cart.compGbCd}"/>
	
	<div class="pdset">
		<div class="pic"><%--<img src="${cart.imgPath }" alt="이미지" class="img">--%>
			<img src="${fn:indexOf(cart.imgPath, 'cdn.ntruss.com') > -1 ? cart.imgPath : frame:optImagePath(cart.imgPath, frontConstants.IMG_OPT_QRY_210)}" alt="${cart.goodsNm }" class="img"></div>
		<div class="disc">
			<span class="name">${cart.goodsNm }</span>
			<c:if test="${cart.goodsCstrtTpCd eq frontConstants.GOODS_CSTRT_TP_PAK and  not empty cart.optGoodsNm}" >
				<div class="opt k0423">${cart.optGoodsNm }</div>
			</c:if>
			<c:if test="${cart.goodsCstrtTpCd eq frontConstants.GOODS_CSTRT_TP_ATTR and fn:length(cart.goodsOptList) > 0 }">
				<div class="opt k0423">
					<c:forEach var="goodsOpt" items="${cart.goodsOptList }" varStatus="optStatus">
						${goodsOpt.showNm } : ${goodsOpt.attrVal} ${!optStatus.last ? ' / ' : '' }
					</c:forEach>
				</div>
			</c:if>
		</div>
	</div>
	<div class="totprc">
		<div class="price ptp">
			<span class="tit">판매가</span>
			<span class="prc"><em class="p"><frame:num data="${(cart.salePrc - cart.prmtDcAmt) * cart.buyQty }"/></em><i class="w">원</i></span>
		</div>
		<div class="price dis">
			<i class="cq m">-</i>
			<span class="tit">할인금액</span>
			<span class="prc"><em class="p" id="goodsDcAmt${cart.cartId}"></em><i class="w">원</i></span>
		</div>
		<div class="price cpn">
			<i class="cq e">=</i>
			<span class="tit">쿠폰 적용가</span>
			<span class="prc"><em class="p" id="goodsTotalAmt${cart.cartId}"></em><i class="w">원</i></span>
		</div>
	</div>
</section>
<section class="sect list">
	<ui class="cplist">
		<c:set var="selNotice" value=""/>
		<c:forEach var="coupon" items="${cart.couponList}" >
			<c:set var="isExist" value="false"/>
			
			<c:forEach var="goodsCpParam" items="${goodsCpParamList}" >
				<c:if test="${cart.cartId ne goodsCpParam.cartId and coupon.mbrCpNo eq goodsCpParam.selMbrCpNo}">
					<c:set var="isExist" value="true"/>
				</c:if>
			</c:forEach>
			<c:if test="${cart.selMbrCpNo eq coupon.mbrCpNo}">
				<c:set var="selNotice" value="${coupon.notice }"/>
			</c:if>
							
			<li>
				<label class="radio">
					<input type="hidden" name="cpNo" value="${coupon.cpNo}">
					<input type="hidden" name="cpDcAmt" value="${coupon.dcAmt}">
					<input type="hidden" name="totCpDcAmt"  value="${coupon.totDcAmt}">
					<input type="hidden" name="notice"  value='<c:out value="${coupon.notice}"/>'>
					<input type="radio" name="rdb_cpupon_a${cart.cartId }" value="${coupon.mbrCpNo}" 
					${cart.selMbrCpNo eq coupon.mbrCpNo ? 'checked' : ''}
					data-cart-id="${cart.cartId }">
					
					<div class="txt">
						<div class="hdd">
							<c:choose>
								<c:when test="${coupon.cpAplCd eq frontConstants.CP_APL_10 }">
									<em class="amt"><em class="p">${coupon.aplVal }</em><i class="w">%</i></em>
									<em class="prc"><em class="p"><frame:num data="${coupon.totDcAmt }"/></em><i class="w">원</i></em>
								</c:when>
								<c:otherwise>
									<em class="prc"><em class="p"><frame:num data="${coupon.totDcAmt }"/></em><i class="w">원</i></em>
								</c:otherwise>
							</c:choose>
								<span class="msg" ${isExist ? '' : 'style="display:none;"' }>다른 상품 적용중</span>
						</div>
						<div class="cdd">
							<div class="dt">${coupon.cpNm }</div>
							<c:if test="${(not empty coupon.minBuyAmt && coupon.minBuyAmt > 0 ) or (coupon.cpAplCd eq frontConstants.CP_APL_10 && coupon.maxDcAmt > 0)}">
								<div class="dd">
									<c:if test="${not empty coupon.minBuyAmt && coupon.minBuyAmt > 0}">
										최소 <frame:num data="${coupon.minBuyAmt}"/>원 이상 구매시
									</c:if>
									<c:if test="${coupon.cpAplCd eq frontConstants.CP_APL_10 && coupon.maxDcAmt > 0}">
										최대 <frame:num data="${coupon.maxDcAmt}"/>원 할인
									</c:if>
								</div>
							</c:if>
						</div>
					</div>
				</label>
			</li>
		</c:forEach>
		<li>
			<label class="radio">
				<input type="hidden" name="cpDcAmt" value="0">
				<input type="hidden" name="totCpDcAmt"  value="0">
				<input type="radio" name="rdb_cpupon_a${cart.cartId }" id="noAplGoodsBtn${cart.cartId}" value=""
				${empty cart.selMbrCpNo ? 'checked' : ''}
				data-cart-id="${cart.cartId }">
				<div class="txt">
					<div class="hdd">
						<em class="amt"><em class="t">적용안함</em></em>
					</div>
				</div>
			</label>
		</li>
	</ui>
	<c:if test="${frontConstants.CP_POP_TP_CART eq param.cpPopTp}">
	<section class="sect warn">
		<div class="hdt">
			<span class="tit">이용안내</span>
			<button type="button" data-ui-tog="btn" data-ui-tog-val="tog_cpn_warn${cart.cartId}" class="bt tog" data-content="" data-url="" ${empty selNotice ? 'disabled' : '' }>더보기</button>
		</div>
		<div class="cdt" data-ui-tog="ctn" data-ui-tog-val="tog_cpn_warn${cart.cartId}">
			<c:out value="${selNotice }" escapeXml="false"/>
		</div>
	</section>
	</c:if>
</section>