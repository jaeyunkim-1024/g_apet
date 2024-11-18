<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">

$(document).ready(function(){
	
	listContnetsGoods(true);
	
	var fitMovDevSet = {
			observer: true,
			observeParents: true,
			watchOverflow:true,
			freeMode: false,
			slidesPerView: 4,
			slidesPerGroup:4,
			spaceBetween: 16,
			breakpoints: {
				1024: {
					spaceBetween: 8,
					slidesPerView: "auto",
					slidesPerGroup:1,
					freeMode: true,
				}
			},
	        navigation: {
				nextEl: '.ui_fitmove_slide .sld-nav .bt.next',
				prevEl: '.ui_fitmove_slide .sld-nav .bt.prev',
			}
	    };

	var fitmoveDev = new Swiper('.ui_fitmove_slide .swiper-container', fitMovDevSet);
	
	fitmoveDev.on('transitionEnd', function() {
		if(fitmoveDev.realIndex > 0 && ( parseInt($("#contentList").data('page')) < parseInt($("#contentList").data('totpage')))){
			listContnetsGoods(false);
//				  fitmoveDev.destroy();
			fitMovDevSet = $.extend({}, fitMovDevSet, {initialSlide: fitmoveDev.realIndex});
			fitmoveDev = new Swiper('.ui_fitmove_slide .swiper-container', fitMovDevSet);
		}
	});

})

//시리즈목록 이동
function fncGoSrisList(srisNo){
	location.href = "/tv/series/petTvSeriesList?srisNo="+srisNo+"&sesnNo=1";
}

function listContnetsGoods(firstFlag) {
	
	var options = {
		url : '<spring:url value="/goods/listContentsGoods"/>'
		, type : "POST"
		, data : { goodsId : "${goods.goodsId}", page : (parseInt($("#contentList").data('page'))+1) }
		, done : function(result){
			var html = '';
			
			if(firstFlag){
				if(result.contentsSO.totalCount < 1){
					$("#contentsMov").hide();
					$("#contentsTabCnt").closest('li').hide();
				}else{
					$("#contentsTabCnt").text(result.contentsSO.totalCount);
					$("#contentsTabCnt").closest('li').show();
				}
			}
			
			if(result.listGoodsContents.length > 0 ){
				
				var list = result.listGoodsContents;
				
				for(i in list){
					
					var srisPrflImgPath = list[i].srisPrflImgPath;
					var thumPath = list[i].thumPath;
					
					if(srisPrflImgPath != null && srisPrflImgPath.indexOf('cdn.ntruss.com') == -1){
						srisPrflImgPath = "${frame:optImagePath('"+ srisPrflImgPath +"', frontConstants.IMG_OPT_QRY_785)}";
					}
					
					if(thumPath != null && thumPath.indexOf('cdn.ntruss.com') == -1){
						thumPath = "${frame:optImagePath('"+ thumPath +"', frontConstants.IMG_OPT_QRY_20)}";
					}
					
					html += '<li class="swiper-slide">';
					html += '	<div class="fitMoveSet">';
					html += '		<div class="thum">';
					html += '			<a href="javascript:fnPetTvDetail(\''+list[i].vdId+'\');" data-content="'+list[i].vdId+'" data-url="/tv/series/indexTvDetail?vdId='+list[i].vdId+'&sortCd=&listGb=HOME" class="pic">';
					html += '				<img class="img" src="' + thumPath + '" alt="이미지">';
					html += '				<span class="tm"><i class="i">' + list[i].totLnth + '</i></span></a>';
					html += '		</div>';
					html += '		<div class="boxs">';
					html += '			<div class="spic">';
					html += '				<a href="javascript:fncGoSrisList(\''+ list[i].srisNo +'\');" class="pic"><img class="img" src="' + srisPrflImgPath + '" alt="이미지"></a>';
					html += '			</div>';
					html += '			<div class="desc">';
					html += '				<div class="tit"><a href="javascript:fnPetTvDetail(\''+list[i].vdId+'\');" data-content="'+list[i].vdId+'" data-url="/tv/series/indexTvDetail?vdId='+list[i].vdId+'&sortCd=&listGb=HOME" class="lk">' + xssCheck(list[i].ttl, 1) + '</a></div>';
					html += '				<div class="inf">';
					//html += '					<span class="pct"><i class="nm">' + list[i].rate + '%</i>일치</span>';//APETQA-3525 일치율 노출하지 않음.
					//html += '					<span class="hit"><i class="nm">' + fnComma(list[i].hits) + '</i></span>';
					html += '					<span class="fav"><i class="nm" data-read-like="'+list[i].vdId+'">' + fnComma(list[i].likeCnt) + '</i></span>';
					html += '				</div>';
					html += '			</div>';
					html += '		</div>';
					html += '	</div>';
					html += '</li>';
				}
				
				$("#contentList").append(html);
				$("#contentList").data('page', result.contentsSO.page);
				$("#contentList").data("totpage", result.contentsSO.totalPageCount);
				$("#contentsCnt").text(result.contentsSO.totalCount);
			}
			
// 			ui.shop.fitMov.using();
			
		}
	};
	
	ajax.call(options);
}

//펫TV 상세화면 이동
function fnPetTvDetail(vd_id) {
	if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true"){
		// 데이터 세팅
		toNativeData.func = "onNewPage";
		toNativeData.type = "TV";
		toNativeData.url = "${view.stDomain}/tv/series/indexTvDetail?vdId="+ vd_id +'&sortCd=&listGb=GOODS_${goods.goodsId}';
		// APP 호출
		toNative(toNativeData);
	}else{
		location.href = "/tv/series/indexTvDetail?vdId="+ vd_id +'&sortCd=&listGb=GOODS_${goods.goodsId}';
	}
}
</script>

<div class="hdts">
	<span class="tit"><em class="t">관련영상</em> <i class="i" id="contentsCnt">0</i></span>
</div>
<div class="cdts">
	<div class="ui_fitmove_slide">
		<div class="swiper-container slide">
			<ul class="swiper-wrapper list" id="contentList" data-page="0">
				
			</ul>
		</div>
		<div class="sld-nav">
			<button type="button" class="bt prev">이전</button>
			<button type="button" class="bt next">다음</button>
		</div>
	</div>
</div>
