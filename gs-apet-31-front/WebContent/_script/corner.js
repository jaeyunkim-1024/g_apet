function mainSet(corner, confStr, imgDomain) {
	var confCorner = confStr.split(":");
	for (var i = 0; i < corner.length; i++) {
		var addHtml = "";
		var dispCornNo = corner[i].dispCornNo;

		switch (dispCornNo) {
		case parseInt(confCorner[0]):
			for (var j = 0; j < corner[i].listBanner.length; j++) {
				var banner = corner[i].listBanner[j];
				addHtml += '						<li class="swiper-slide"><a href="'
						+ banner.bnrLinkUrl + '"><img src="' + imgDomain
						+ banner.bnrImgPath + '" alt="' + banner.bnrDscrt
						+ '"></a></li>';
			}
			$("#corner_" + dispCornNo).html(addHtml);
			break;
		case parseInt(confCorner[1]):
			for (var j = 0; j < corner[i].listBanner.length; j++) {
				var banner = corner[i].listBanner[j];
				addHtml += '					<li><a href="' + banner.bnrLinkUrl
						+ '"><img src="' + imgDomain + banner.bnrImgPath
						+ '" alt="' + banner.bnrDscrt + '"></a></li>';
			}
			$("#corner_" + dispCornNo).html(addHtml);
			break;
		case parseInt(confCorner[2]):

			// 협의에 따라서 수정필요
			/*
			 * if(corner[i].linkUrl != null && corner[i].linkUrl != ""){
			 * if((corner[i].cornImgPath == '' || corner[i].cornImgPath == null) &&
			 * (corner[i].cntsTtl != '' && corner[i].cntsTtl != null))
			 * $("#title_"+dispCornNo).html(corner[i].cntsTtl+'<a href="'
			 * +corner[i].linkUrl+ '"><span class="btnGo">MORE</span></a>');
			 * else $("#title_"+dispCornNo).html('<a href="'
			 * +corner[i].linkUrl+ '"><img
			 * src="'+imgDomain+corner[i].cornImgPath+'"
			 * alt="'+corner[i].cntsTtl+'"></a>'); }else{
			 * if((corner[i].cornImgPath == '' || corner[i].cornImgPath == null) &&
			 * (corner[i].cntsTtl != '' && corner[i].cntsTtl != null))
			 * $("#title_"+dispCornNo).html(corner[i].cntsTtl); else
			 * $("#title_"+dispCornNo).html('<img
			 * src="'+imgDomain+corner[i].cornImgPath+'"
			 * alt="'+corner[i].cntsTtl+'">'); }
			 */
			if (corner[i].linkUrl != null && corner[i].linkUrl !== "") {
				if ((corner[i].cornImgPath === '' || corner[i].cornImgPath == null)
						&& (corner[i].cntsTtl !== '' && corner[i].cntsTtl != null))
					$("#title_" + dispCornNo).html(corner[i].cntsTtl);
				else
					$("#title_" + dispCornNo).html(
							'<img src="' + imgDomain + corner[i].cornImgPath
									+ '" alt="' + corner[i].cntsTtl + '">');
			} else {
				if ((corner[i].cornImgPath === '' || corner[i].cornImgPath == null)
						&& (corner[i].cntsTtl !== '' && corner[i].cntsTtl != null))
					$("#title_" + dispCornNo).html(corner[i].cntsTtl);
				else
					$("#title_" + dispCornNo).html(
							'<img src="' + imgDomain + corner[i].cornImgPath
									+ '" alt="' + corner[i].cntsTtl + '">');
			}

			if (corner[i].goodsList != null
					&& corner[i].goodsList !== 'undefined') {
				for (var j = 0; j < corner[i].goodsList.length; j++) {
					var good = corner[i].goodsList[j];

					addHtml += getGoodsHtml(good, imgDomain);
				}
				$("#corner_" + dispCornNo).html(addHtml);
			}

			break;

		case parseInt(confCorner[3]):
			// 협의에 따라서 수정필요
			if (corner[i].linkUrl != null && corner[i].linkUrl !== "") {
				if ((corner[i].cornImgPath === '' || corner[i].cornImgPath == null)
						&& (corner[i].cntsTtl !== '' && corner[i].cntsTtl != null))
					$("#title_" + dispCornNo).html(corner[i].cntsTtl);
				else
					$("#title_" + dispCornNo).html(
							'<img src="' + imgDomain + corner[i].cornImgPath
									+ '" alt="' + corner[i].cntsTtl + '">');
			} else {
				if ((corner[i].cornImgPath === '' || corner[i].cornImgPath == null)
						&& (corner[i].cntsTtl !== '' && corner[i].cntsTtl != null))
					$("#title_" + dispCornNo).html(corner[i].cntsTtl);
				else
					$("#title_" + dispCornNo).html(
							'<img src="' + imgDomain + corner[i].cornImgPath
									+ '" alt="' + corner[i].cntsTtl + '">');
			}

			if (corner[i].goodsList != null
					&& corner[i].goodsList !== 'undefined') {
				for (var j = 0; j < corner[i].goodsList.length; j++) {
					var good = corner[i].goodsList[j];

					addHtml += getGoodsHtml(good, imgDomain);
				}
				$("#corner_" + dispCornNo).html(addHtml);
			}

			break;
		case parseInt(confCorner[4]):
			$("#title_" + dispCornNo).html(
					'<a href="'
							+ (corner[i].linkUrl !== '' ? corner[i].linkUrl
									: '#') + '"><img src="' + imgDomain
							+ corner[i].cornImgPath + '" alt="'
							+ corner[i].cntsTtl + '"></a>');
			$(".mainSec2").css("background-color", corner[i].bgColor);

			if (corner[i].goodsList != null
					&& corner[i].goodsList !== 'undefined') {
				for (var j = 0; j < corner[i].goodsList.length; j++) {
					var good = corner[i].goodsList[j];

					if (j % 3 === 0) {
						addHtml += '						<li class="swiper-slide">';
						addHtml += '							<div class="list_col5">';
						addHtml += '								<ul>';
					}

					addHtml += getGoodsHtml(good, imgDomain);

					if (j % 3 === 2) {
						addHtml += '								</ul>';
						addHtml += '							</div>';
						addHtml += '						</li>';
					}
				}
				$("#corner_" + dispCornNo).html(addHtml);
			}
			break;
		case parseInt(confCorner[5]):
			for (var j = 0; j < corner[i].listBanner.length; j++) {
				var banner = corner[i].listBanner[j];
				addHtml += '						<li class="swiper-slide"><a href="'
						+ banner.bnrLinkUrl + '"><img src="' + imgDomain
						+ banner.bnrImgPath + '" alt="' + banner.bnrDscrt
						+ '"></a></li>';
			}
			$("#corner_" + dispCornNo).html(addHtml);
			break;
		case parseInt(confCorner[6]):
			// 협의에 따라서 수정필요
			if (corner[i].linkUrl != null && corner[i].linkUrl !== "") {
				if ((corner[i].cornImgPath === '' || corner[i].cornImgPath == null)
						&& (corner[i].cntsTtl !== '' && corner[i].cntsTtl != null))
					$("#title_" + dispCornNo).html(corner[i].cntsTtl);
				else
					$("#title_" + dispCornNo).html(
							'<img src="' + imgDomain + corner[i].cornImgPath
									+ '" alt="' + corner[i].cntsTtl + '">');
			} else {
				if ((corner[i].cornImgPath === '' || corner[i].cornImgPath == null)
						&& (corner[i].cntsTtl !== '' && corner[i].cntsTtl != null))
					$("#title_" + dispCornNo).html(corner[i].cntsTtl);
				else
					$("#title_" + dispCornNo).html(
							'<img src="' + imgDomain + corner[i].cornImgPath
									+ '" alt="' + corner[i].cntsTtl + '">');
			}

			if (corner[i].goodsList != null
					&& corner[i].goodsList !== 'undefined') {
				for (var j = 0; j < corner[i].goodsList.length; j++) {
					var good = corner[i].goodsList[j];

					addHtml += getGoodsHtml(good, imgDomain);
				}
				$("#corner_" + dispCornNo).html(addHtml);
			}
			break;
		case parseInt(confCorner[7]):
			// 협의에 따라서 수정필요
			if (corner[i].linkUrl != null && corner[i].linkUrl !== "") {
				if ((corner[i].cornImgPath === '' || corner[i].cornImgPath == null)
						&& (corner[i].cntsTtl !== '' && corner[i].cntsTtl != null))
					$("#title_" + dispCornNo).html(corner[i].cntsTtl);
				else
					$("#title_" + dispCornNo).html(
							'<img src="' + imgDomain + corner[i].cornImgPath
									+ '" alt="' + corner[i].cntsTtl + '">');
			} else {
				if ((corner[i].cornImgPath === '' || corner[i].cornImgPath == null)
						&& (corner[i].cntsTtl !== '' && corner[i].cntsTtl != null))
					$("#title_" + dispCornNo).html(corner[i].cntsTtl);
				else
					$("#title_" + dispCornNo).html(
							'<img src="' + imgDomain + corner[i].cornImgPath
									+ '" alt="' + corner[i].cntsTtl + '">');
			}

			if (corner[i].goodsList != null
					&& corner[i].goodsList !== 'undefined') {
				for (var j = 0; j < corner[i].goodsList.length; j++) {
					var good = corner[i].goodsList[j];

					addHtml += getGoodsHtml(good, imgDomain);
				}
				$("#corner_" + dispCornNo).html(addHtml);
			}
			break;

		case parseInt(confCorner[8]):
			$("#title_" + dispCornNo).html(
					'<img src="' + imgDomain + corner[i].cornImgPath
							+ '" alt="' + corner[i].cntsTtl + '">');
			$(".mainSec4").css("background-color", corner[i].bgColor);

			if (corner[i].goodsList != null
					&& corner[i].goodsList !== 'undefined') {
				for (var j = 0; j < corner[i].goodsList.length; j++) {
					var good = corner[i].goodsList[j];

					if (j % 3 === 0) {
						addHtml += '						<li class="swiper-slide">';
						addHtml += '							<div class="list_col5">';
						addHtml += '								<ul>';
					}
					addHtml += '									<li class="item">';
					addHtml += '										<div class="img_sec over_link">';
					addHtml += '											<a href="/goods/indexGoodsDetail?goodsId='
							+ good.goodsId + '">';
					addHtml += '												'
							+ tag
									.goodsImage(imgDomain, good.goodsId,
											good.imgPath, good.imgSeq, 60,
											good.goodsNm);
					addHtml += '											<div class="link_group">';
					addHtml += '												<div class="text_area">';
					addHtml += '													<p class="over_brand">'
							+ good.bndNm + '</p>';
					addHtml += '													<p class="over_name">'
							+ good.goodsNm + '</p>';
					addHtml += '													<p class="over_price">'
							+ format
									.num((good.dcAmt != null && good.dcAmt > 0) ? good.dcAmt
											: good.saleAmt) + ' 원</p>';
					addHtml += '												</div>	';
					addHtml += '											</div>';
					addHtml += '											</a>';
					addHtml += '										</div>';
					addHtml += '									</li>	';
					if (j % 3 === 2) {
						addHtml += '								</ul>';
						addHtml += '							</div>';
						addHtml += '						</li>';
					}
				}
				$("#corner_" + dispCornNo).html(addHtml);
			}
			break;
		case parseInt(confCorner[9]):
			for (var j = 0; j < corner[i].listBanner.length; j++) {
				var banner = corner[i].listBanner[j];
				addHtml += '						<li><a href="' + banner.bnrLinkUrl
						+ '"><img src="' + imgDomain + banner.bnrImgPath
						+ '" alt="' + banner.bnrDscrt + '"></a></li>';
			}
			$("#corner_" + dispCornNo).html(addHtml);
			break;
		default:
			break;
		}
	}

}

function getGoodsHtml(good, imgDomain) {
	var addHtml = "";
	var disRate = 0;
	var wishClass = "";

	addHtml += '								<li class="item">';
	/*
	 * if (good.dealYn == "Y") addHtml += ' <div class="deal_ico">딜 상품</div>';
	 */
	if (good.groupYn === "Y")
		addHtml += '								<div class="group_ico">공동구매 상품</div>';
	addHtml += '									<div class="img_sec over_link">';
	if (good.soldOutYn === "Y")
		addHtml += '									<div class="sold_out"><span>SOLD OUT</span></div>';
	addHtml += '										<a href="/goods/indexGoodsDetail?goodsId='
			+ good.goodsId + '">';
	addHtml += '											'
			+ tag.goodsImage(imgDomain, good.goodsId, good.imgPath,
					good.imgSeq, 60, good.goodsNm);
	addHtml += '										</a>';
	if (good.groupEndYn === "Y")
		addHtml += '									<div class="group_soldout"><span>SOLD OUT</span></div>';
	addHtml += '										<div class="link_group">';
	addHtml += '											<div class="btn_area">';
	addHtml += '												<a href="/goods/indexGoodsDetail?goodsId='
			+ good.goodsId
			+ '" class="btn_cover_move" title="상품 새창보기" target="_blank"><span>상품 새창보기</span></a>';
	if (good.interestYn === "Y")
		wishClass = "click";
	addHtml += '												<a href="#" class="btn_cover_fav ' + wishClass
			+ '" title="위시리스트 추가" onclick="insertWish(this,\'' + good.goodsId
			+ '\');return false;"><span>위시리스트</span></a>';
	addHtml += '											</div>';
	addHtml += '											<div class="mask_link" onclick="location.href=\'/goods/indexGoodsDetail?goodsId='
			+ good.goodsId + '\'"></div>';
	addHtml += '										</div>';
	addHtml += '									</div>';
	addHtml += '									<ul class="text_sec">									';
	addHtml += '										<li class="u_brand">' + good.bndNm + ' </li>';
	addHtml += '										<li class="u_name"><a href="/goods/indexGoodsDetail?goodsId='
			+ good.goodsId + '">' + good.goodsNm + '</a> </li>';
	if (good.dealYn === "Y" || good.groupYn === "Y") {
		if (good.dcAmt > 0)
			disRate = Math
					.round(((good.orgSaleAmt - good.dcAmt) / good.orgSaleAmt) * 100);
		else
			disRate = Math
					.round(((good.orgSaleAmt - good.saleAmt) / good.orgSaleAmt) * 100);
	} else {
		if (good.dcAmt > 0)
			disRate = Math
					.round(((good.saleAmt - good.dcAmt) / good.saleAmt) * 100);
	}
	addHtml += '										<li class="u_cost">';
	if (disRate > 0)
		addHtml += '<span class="sale">[' + disRate + '%]</span> ';
	addHtml += format.num(good.foSaleAmt) + ' 원</li>';
	addHtml += '									</ul>';
	addHtml += '								</li>	';

	return addHtml;
}
