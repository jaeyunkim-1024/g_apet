<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">
	var cstrtArr = new Array();
	<c:if test="${!empty goodsCstrtList}">
		<c:forEach items="${goodsCstrtList}" var="goodsCstrt" varStatus="status">
		var cstrt = {};
		cstrt.goodsId = '<c:out value="${goodsCstrt.goodsId}"/>';
		cstrt.goodsNm = '<c:out value="${goodsCstrt.goodsNm}"/>';
		cstrt.count = '<c:out value="${status.count}"/>';

		cstrtArr.push(cstrt);
		</c:forEach>
	</c:if>

	$(function(){

		/**
		 * 상품 상세
		 */
		var options = {
			url : '<spring:url value="/goods/getGoodsDesc"/>'
			, data : {goodsId:'<c:out value="${goods.goodsId}"/>'}
			, done : function(result){
				if(result.bannerContent) {
					$.each(result.bannerContent, function(i, v){
						$('#bannerPc').append($.parseHTML(v.bnrHtml));
						$('#bannerMobile').append($.parseHTML(v.bnrHtml));

						$('#bannerPc').not('img').addClass('template_area');
						//이미지에는 풀 css
						$('#bannerPc img').addClass('full_img_area');
					});
				}
				if(result.goodsDesc) {
					var goodsDesc = result.goodsDesc;

					$('#contentPc').prepend($.parseHTML(goodsDesc.contentPc));
					$('#contentMobile').prepend($.parseHTML(goodsDesc.contentMobile));

					$('#contentPc').not('img').addClass('template_area');
					//이미지에는 풀 css
					$('#contentPc img').addClass('full_img_area');
				}
			}
		};
		ajax.call(options);
	});

	/**
	 * [레이어] 자세히 열기
	 */
	function fnOpenPopPdDetView(goodsId, isOpen) {
		var goodsNm = '';
		var goodsCount = '';
		$.each(cstrtArr, function(i, v){
			if(v.goodsId == goodsId) {
				goodsNm = v.goodsNm;
				goodsCount = '상품'+v.count;
			}
		});
		$('#optPdNm').text(goodsNm);
		$('#optPdCount').text(goodsCount);

		var options = {
			url : '<spring:url value="/goods/getGoodsDesc"/>'
			, data : {goodsId:goodsId}
			, done : function(result){
				if(result.goodsDesc) {
					var goodsDesc = result.goodsDesc;
					var goodsNm = '';

					$('#cstrtPc').html($.parseHTML(goodsDesc.contentPc));
					$('#cstrtMobile').html($.parseHTML(goodsDesc.contentMobile));

					if(isOpen) {
						ui.popLayer.open('popPdDetView');
					}
				}
			}
		};
		ajax.call(options);
	}

	/**
	 * [레이어] 자세히 닫기
	 */
	function fnClosePopPdDetView() {
		$('#cstrtPc').html();
		$('#cstrtMobile').html('');

		ui.popBot.close('popOptPdSel');
		ui.popLayer.close('popPdDetView');
	}
</script>

<div class="cdts">

	<!-- 공통 상품 배너 정보
	<div class="html_editor mo" id="bannerMobile"></div>
	<div class="html_editor pc" id="bannerPc"></div>
	-->
	<!-- 묶음 상품 정보 -->
	<c:if test="${ (goods.goodsCstrtTpCd eq 'ATTR' || goods.goodsCstrtTpCd eq 'PAK') && goods.attrShowTpCd eq frontConstants.ATTR_SHOW_TP_20}">
		<c:if test="${!empty goodsCstrtList}">
			<div class="uibdgoods">
				<ul class="bdlist">
					<c:forEach items="${goodsCstrtList}" var="goodsCstrt" varStatus="status">
						<li>
							<div class="gdset bundl">
								<div class="num">상품 <c:out value="${status.count}"/></div>
								<div class="thum">
									<%-- <c:if test="${goodsCstrt.soldOutYn eq 'Y'}">
										<div class="soldouts"><em class="ts">품절</em></div>
									</c:if> --%>
									<c:if test="${goodsCstrt.salePsbCd eq frontConstants.SALE_PSB_10}" > <!-- 판매중지 -->
										<div class="soldouts"><em class="ts">판매중지</em></div>
									</c:if>
									<c:if test="${goodsCstrt.salePsbCd eq frontConstants.SALE_PSB_20}" > <!-- 판매종료 -->
										<div class="soldouts"><em class="ts">판매종료</em></div>
									</c:if>
									<c:if test="${goodsCstrt.salePsbCd eq frontConstants.SALE_PSB_30}" > <!-- 품절 -->
										<div class="soldouts"><em class="ts"><spring:message code='front.web.view.common.goods.saleSoldOut.title'/></em></div>
									</c:if>
									<a href="javascript:;" class="pic">
<!-- 										직사각형을 정사각형으로 변경함. frontConstants.IMG_OPT_QRY_340 >>>> frontConstants.IMG_OPT_QRY_500 -->
										<img class="img" src="${frame:optImagePath( goodsCstrt.imgPath , frontConstants.IMG_OPT_QRY_500 )}" alt="이미지"/>
									</a>
								</div>
								<div class="boxs">
									<div class="tit"><a href="javascript:;" class="lk"><c:out value="${goodsCstrt.goodsNm}"/></a></div>
									<a href="javascript:;" class="inf">
										<span class="prc"><em class="p"><frame:num data="${goodsCstrt.saleAmt}" /></em><i class="w">원</i></span>
										<c:if test="${goodsCstrt.orgSaleAmt > goodsCstrt.saleAmt and ((goodsCstrt.orgSaleAmt - goodsCstrt.saleAmt)/goodsCstrt.orgSaleAmt * 100) > 1 }">
											<span class="pct"><em class="n"><fmt:formatNumber value="${(goodsCstrt.orgSaleAmt - goodsCstrt.saleAmt)/goodsCstrt.orgSaleAmt * 100}" type="percent" pattern="#,###,###"/></em><i class="w">%</i></span>
										</c:if>
									</a>
									<div class="bts btnSet">
										<button type="button" class="btn c sm" onclick="fnOpenPopPdDetView('<c:out value="${goodsCstrt.goodsId}"/>', true);">자세히</button>
										<button type="button" class="btn c sm <c:if test="${goodsCstrt.salePsbCd ne frontConstants.SALE_PSB_00 }">disabled</c:if>" <c:if test="${goodsCstrt.salePsbCd eq frontConstants.SALE_PSB_00 }">onclick="fnOption.exPaksAdd('add', '', '${goodsCstrt.itemNo }', '${goodsCstrt.saleAmt}', '${goodsCstrt.imgPath}', '${goodsCstrt.cstrtShowNm}', '${goodsCstrt.goodsId}', '${goodsCstrt.minOrdQty}', '${goodsCstrt.maxOrdQty}', '${goodsCstrt.ordmkiYn}', '0', '${goodsCstrt.salePsbCd}', 'DETAILSEL', '${goodsCstrt.ioAlmYn}', '${goods.saleAmt}', '${goodsCstrt.attrVals}')"</c:if>>상품선택</button>
									</div>
								</div>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
			<jsp:include page="/WEB-INF/view/goods/includeNew/includeGoodsCstrtDetail.jsp" />
		</c:if>
	</c:if>

	<div class="html_editor mo" id="contentMobile">
		<jsp:include page="/WEB-INF/view/goods/includeNew/includeGoodsProductDetail.jsp" />
	</div>

	<div class="html_editor pc" id="contentPc">
		<jsp:include page="/WEB-INF/view/goods/includeNew/includeGoodsProductDetail.jsp" />
	</div>

	<div class="btsmore">
		<button type="button" class="bt more" data-ui-btsmore="more"><em class="t">상품정보 더보기</em></button>
	</div>
</div>
