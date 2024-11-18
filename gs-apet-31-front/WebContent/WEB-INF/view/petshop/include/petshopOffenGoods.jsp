<script type="text/template" id="offenTemplate">
<li class="swiper-slide">
	<div class="gdset often">
		<div class="thum">
			<a href="/goods/indexGoodsDetail?goodsId={{goodsId}}" class="pic" data-content='{{goodsId}}' data-url="/goods/indexGoodsDetail?goodsId={{goodsId}}">
				<img class="img" src="{{imgSrc}}" alt="{{goodsNm}}" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'">
			</a>
			<button type="button" class="bt zzim {{zzimCalss}}" data-content='{{goodsId}}' data-url="/goods/insertWish?goodsId={{goodsId}}" data-action="interest" data-yn="N" data-goods-id="{{goodsId}}" data-target="goods">찜하기</button>
		</div>
		<div class="boxs">
			<div class="num">{{ordQty}}<spring:message code='front.web.view.petshop.often.goods.times.purchase'/></div>
			<div class="tit">
				<a href="/goods/indexGoodsDetail?goodsId={{goodsId}}" class="lk" data-content='{{goodsId}}' data-url="/goods/indexGoodsDetail?goodsId={{goodsId}}">{{goodsNm}}</a>
			</div>
			<a href="/goods/indexGoodsDetail?goodsId={{goodsId}}" class="inf" data-content='{{goodsId}}' data-url="/goods/indexGoodsDetail?goodsId={{goodsId}}">
				<span class="prc"><em class="p">{{foSaleAmt}}</em><i class="w"><spring:message code='front.web.view.common.moneyUnit.title'/></i></span>
				<span class="pct" {{rateStyle}}><em class="n">{{rate}}</em><i class="w">%</i></span>
			</a>
			<div class="bts"><a href="javascript:void(0);" class="bt cart" onclick="insertCart('{{goodsId}}', '{{itemNo}}', '{{ordmkiYn}}'); return false;" data-content="{{goodsId}}" data-url="/order/insertCart"><spring:message code='front.web.view.petshop.often.goods.add'/></a></div>
		</div>
	</div>
</li>
</script>
<script type="text/javascript">
	
	// 자주구매한 상품 목록
	var offenGoodsList = [];
	
	<c:forEach var="cornerList" items="${totalCornerList}">
	<c:if test="${param.dispCornNo == cornerList.dispCornNo }">

		var template = document.querySelector("#offenTemplate").innerHTML;

		<c:forEach var="goods" items="${cornerList.offenGoodsList}"  varStatus="status" >
			var goodsId = '${goods.goodsId}';
			var goodsNm = '${goods.goodsNm }';
			var imgSrc = '${frame:optImagePath(goods.imgPath, frontConstants.IMG_OPT_QRY_510)}';
			var interestYn = '${goods.interestYn}';
			var zzimCalss = (interestYn == 'Y') ? 'on' : '';
			var ordQty = '${goods.ordQty}';
			var foSaleAmt = '${goods.foSaleAmt }'*1;
			var orgSaleAmt = '${goods.orgSaleAmt }'*1;
			var saleAmt = '${goods.saleAmt }'*1;
			var rate = 0;
			var rateStyle = 'style="display:none"';
			if(orgSaleAmt > saleAmt && ((orgSaleAmt - saleAmt) / orgSaleAmt * 100 ) >= 1 ) {
				rateStyle = 'style="display:"';
				rate = Math.floor(100 - (foSaleAmt * 100) / orgSaleAmt);
			}
			var itemNo = '${goods.itemNo}';
			var ordmkiYn = '${empty goods.ordmkiYn ? "N" : goods.ordmkiYn}';
			
			var offen = template.replace(/{{goodsId}}/gi, goodsId)
				.replace(/{{goodsNm}}/gi, goodsNm)
				.replace(/{{imgSrc}}/gi, imgSrc)
				.replace(/{{zzimCalss}}/gi, zzimCalss)
				.replace(/{{ordQty}}/gi, ordQty)
				.replace(/{{foSaleAmt}}/gi, numberWithCommas(foSaleAmt))
				.replace(/{{rateStyle}}/gi, rateStyle)
				.replace(/{{rate}}/gi, rate)
				.replace(/{{itemNo}}/gi, itemNo)
				.replace(/{{ordmkiYn}}/gi, ordmkiYn);

			offenGoodsList.push(offen);

		</c:forEach>
		var html = '<li class="swiper-slide mbtn" id="viewmore-1"><a href="javascript:void(0);" class="gotolist" onclick="loadCornerGoodsList(${view.dispClsfNo},${param.dispCornNo},${cornerList.dispClsfCornNo},\'${frontConstants.GOODS_MAIN_DISP_TYPE_OFFEN}\');return false;">더보기</a></li>';
		offenGoodsList.push(html);
	</c:if>
	</c:forEach>
	
	$(document).ready(function(){
		$('#offenGoodsList').append(offenGoodsList);
	});
	
	// 장바구니 담기
	function insertCart(goodsId, itemNo, ordmkiYn) {
		if(ordmkiYn != 'Y') {
			var goodsInfo = goodsId+":"+itemNo+":";
			commonFunc.insertCart(goodsInfo, '1', 'N');
		}else {
			ui.confirm("<spring:message code='front.web.view.order.cart.custom.product.go.detail' />",{ // 컨펌 창 옵션들
			    ycb:function(){
			    	location.href="/goods/indexGoodsDetail?goodsId="+goodsId;
			    },
			    ncb:function(){
			    },
			    ybt:"예", // 기본값 "확인"
			    nbt:"아니오"  // 기본값 "취소"
			});
		}
	}
</script>
<c:forEach var="cornerList" items="${totalCornerList}"  varStatus="status" >
	<c:if test="${param.dispCornNo == cornerList.dispCornNo }">
		<!-- 자주구매 -->
		<input type="hidden" id="dispCornNo_offen" value="${param.dispCornNo}"/>
		<input type="hidden" id="dispClsfCornNo_offen" value="${cornerList.offenGoodsList[0].dispClsfCornNo}"/>
		<section class="sect mn often" id="goSection_${param.dispCornNo}">
			<div class="hdts">
				<a class="hdt" href="javascript:void(0);" id="goodsList_${cornerList.offenGoodsList[0].dispClsfCornNo}" onclick="loadCornerGoodsList(${view.dispClsfNo},${param.dispCornNo},${cornerList.dispClsfCornNo},'${frontConstants.GOODS_MAIN_DISP_TYPE_OFFEN}');return false;">
					<span class="tit">${cornerList.dispCornNm}</span> <span class="more"><b class="t">전체보기</b></span>
				</a>
			</div>
			<div class="mn_often_sld" >
				<div class="sld-nav">
					<button type="button" class="bt prev">이전</button>
					<button type="button" class="bt next">다음</button>
				</div>
				<div class="swiper-container slide">
					<ul class="swiper-wrapper list" id="offenGoodsList">
					</ul>
				</div>
			</div>
		</section>
	</c:if>
</c:forEach>