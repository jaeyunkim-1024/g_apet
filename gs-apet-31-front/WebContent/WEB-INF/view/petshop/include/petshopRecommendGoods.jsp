<script type="text/javascript">
// 	function getRecOtherPetGoodsList() {
// 		var petNo = $("#petNo_rec").val();
// 		var petNos = "${session.petNos}";
// 		petNos = petNos.replace(petNo,'').replace(',,',',');
// 		if(petNos.startsWith(',')) {
// 			petNos = petNos.substr(1);
// 		}
// 		var options = {
// 				url : "<spring:url value='/shop/getRecOtherPetGoodsList' />"
// 				, type : "GET"
// 				, dataType : "html"
// 				, data : {
// 					dispClsfNo : '${view.dispClsfNo}',
// 					dispCornNo : $("#dispCornNo_rec").val(),
// 					dispClsfCornNo : $("#dispClsfCornNo_rec").val(),
// 					petNos: petNos,
// 					mbrNo: '${session.mbrNo}',
// 					callGb : 'main'
// 				}
// 				, done :function(result){
// 					ui.disp.init(); 
// 				}
// 			};
// 			ajax.call(options);
// 	}

function recList(dispClsfNo, dispCornNo, dispClsfCornNo, petNo) {
	$("#petNo_rec").val(petNo);
	loadCornerGoodsList(dispClsfNo, dispCornNo, dispClsfCornNo, '${frontConstants.GOODS_MAIN_DISP_TYPE_RCOM}');
}
</script>
<c:forEach var="cornerList" items="${totalCornerList}"  varStatus="status" >
	<c:if test="${param.dispCornNo == cornerList.dispCornNo }">
		<!-- 맞춤추천 -->
		<input type="hidden" id="dispCornNo_rec" value="${param.dispCornNo}"/>
		<input type="hidden" id="dispClsfCornNo_rec" value="${cornerList.dispClsfCornNo}"/>
		<input type="hidden" id="petNo_rec" value=""/>
		<c:forEach var="recommendTotalGoodsList" items="${cornerList.recommendTotalGoodsList}"  varStatus="idx" >
		<c:set var="petNo" value="${recommendTotalGoodsList[0].petNo}"/>
			<c:choose>
				<c:when test="${recommendTotalGoodsList[0].petGbCd eq frontConstants.PET_GB_20}">
					<c:set var="myPet" value="🐱"/>
				</c:when>
				<c:otherwise>
					<c:set var="myPet" value="🐶"/>
				</c:otherwise>
			</c:choose>
			<section class="sect mn recom" id="goSection_${param.dispCornNo}_${petNo}">
				<div class="hdts">
					<a class="hdt" href="javascript:void(0);" id="goodsList_${cornerList.dispClsfCornNo}" onclick="recList(${view.dispClsfNo},${param.dispCornNo},${cornerList.dispClsfCornNo},${petNo});return false;">
						<span class="tit"><em class="b" id="myPet">${recommendTotalGoodsList[0].petNm}</em>&nbsp;${cornerList.dispCornNm}&nbsp;<em id="petGbCd">${myPet}</em></span> <span class="more"><b class="t"><spring:message code='front.web.view.common.msg.fullscreen'/></b></span>
					</a>
				</div>
				<div class="mn_recom_sld">
					<div class="sld-nav">
						<button type="button" class="bt prev"><spring:message code='front.web.view.common.msg.previous'/></button>
						<button type="button" class="bt next"><spring:message code='front.web.view.common.msg.next'/></button>
					</div>
					<div class="swiper-container slide">
						<ul class="swiper-wrapper list k0425" id="otherPetGoodsList">
							<c:forEach var="goods" items="${recommendTotalGoodsList}"  varStatus="status" >
							<li class="swiper-slide">
								<div class="gdset recom" id="recom_${goods.goodsId}">
<%-- 									<c:if test="${goods.intRate > 50}"> --%>
<%-- 									<div class="bdg"><b class="n">${goods.intRate}</b><i class="w">%</i> <b class="t">일치</b></div> --%>
									<div class="thum">
										<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="pic" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">
											<img class="img" src="${frame:optImagePath(goods.imgPath, frontConstants.IMG_OPT_QRY_510)}" alt="${goods.goodsNm}" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'">
										</a>
										<button type="button" class="bt zzim ${goods.interestYn eq 'Y' ? 'on' : ''}" data-content='${goods.goodsId}' data-url="/goods/insertWish?goodsId=${goods.goodsId}" data-action="interest" data-yn="N" data-goods-id="${goods.goodsId}" data-target="goods"><spring:message code='front.web.view.brand.button.wishBrand'/></button>
									</div>
									<div class="boxs">
										<div class="tit">
											<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="lk" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">${goods.goodsNm}</a>
										</div>
										<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="inf" data-content='${goods.goodsId}' data-url="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">
											<span class="prc"><em class="p"><fmt:formatNumber value="${goods.saleAmt}" type="number" pattern="#,###,###"/></em><i class="w"><spring:message code='front.web.view.common.moneyUnit.title'/></i></span>
										</a>
										<c:if test="${not empty goods.goodsTagList}" >
										<div class="tag">
											<c:forEach var="goodsTag" items="${goods.goodsTagList}" begin="0" end="2">
												<a href="/shop/indexPetShopTagGoods?tags=${goodsTag.tagNo}&tagNm=${goodsTag.tagNm}" class="tg">#${goodsTag.tagNm }</a>
											</c:forEach>
										</div>
										</c:if>
									</div>
<%-- 									</c:if> --%>
								</div>
							</li>
							</c:forEach>
							<li class="swiper-slide mbtn" id="viewmore-2">
								<a href="javascript:void(0);" class="gotolist" onclick="recList(${view.dispClsfNo},${param.dispCornNo},${cornerList.dispClsfCornNo},${petNo});return false;">더보기</a>
							</li>
						</ul>
					</div>
	<%-- 				<c:if test="${fn:contains(session.petNos, ',')}"> --%>
	<!-- 				<div class="bts bot"> -->
	<%-- 					<button type="button" class="bt refresh" onclick="getRecOtherPetGoodsList();"><spring:message code='front.web.view.petshop.recommend.goods.other.product'/></button> --%>
	<!-- 				</div> -->
	<%-- 				</c:if> --%>
				</div>
			</section>
		</c:forEach>
	</c:if>
</c:forEach>