<script type="text/template" id="timeTemplate">
<li class="swiper-slide" id="liTag_{{goodsId}}">
	<div class="gdset tdeal">
		<div class="thum">
			<a href="/goods/indexGoodsDetail?goodsId={{goodsId}}" class="pic" data-content='{{goodsId}}' data-url="/goods/indexGoodsDetail?goodsId={{goodsId}}">
				<img class="img" src="{{imgSrc}}" alt="{{goodsNm}}" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'">
			</a>
			<button type="button" class="bt zzim {{zzimCalss}}" data-content='{{goodsId}}' data-url="/goods/insertWish?goodsId={{goodsId}}" data-action="interest" data-yn="N" data-goods-id="{{goodsId}}" data-target="goods">찜하기</button>
			<input type="hidden" id="timeDeal_{{goodsId}}" value="{{saleEndDtm}}"/>
			<div class="time" id="time_{{goodsId}}">{{dealDate}}</div>
		</div>
		<div class="boxs">
			<div class="tit">
				<a href="/goods/indexGoodsDetail?goodsId={{goodsId}}" class="lk" data-content='{{goodsId}}' data-url="/goods/indexGoodsDetail?goodsId={{goodsId}}">{{goodsNm}}</a>
			</div>
			<a href="/goods/indexGoodsDetail?goodsId={{goodsId}}" class="inf" data-content='{{goodsId}}' data-url="/goods/indexGoodsDetail?goodsId={{goodsId}}">
				<span class="prc"><em class="p">{{foSaleAmt}}</em><i class="w">원</i></span>
				<span class="pct" {{rateStyle}}><em class="n">{{rate}}</em><i class="w">%</i></span>
			</a>
		</div>
	</div>
</li>
</script>
<script type="text/javascript">
//베스트20 목록
var timeDealList = [];
var timeDealSoonList = [];

<c:forEach var="cornerList" items="${totalCornerList}">
<c:if test="${param.dispCornNo == cornerList.dispCornNo }">

	var template = document.querySelector("#timeTemplate").innerHTML;
	
	var html = '<li class="swiper-slide mbtn" id="viewmore-3"><a href="javascript:void(0);" class="gotolist" onclick="timedealList(${view.dispClsfNo},${param.dispCornNo},${cornerList.timeDealList[0].dispClsfCornNo},\'${frontConstants.GOODS_MAIN_DISP_TYPE_DEAL}\');return false;">더보기</a></li>';
	<c:forEach var="goods" items="${cornerList.timeDealList}"  varStatus="status" >
		var dispType = '${goods.dispType}';
		var goodsId = '${goods.goodsId}';
		var goodsNm = '${goods.goodsNm }';
		var imgSrc = '${frame:optImagePath(goods.imgPath, frontConstants.IMG_OPT_QRY_510)}';
		var interestYn = '${goods.interestYn}';
		var zzimCalss = (interestYn == 'Y') ? 'on' : '';
		var saleEndDtm = '${goods.saleEndDtm}';
		var dealDate = "";
		if(dispType == '${frontConstants.GOODS_MAIN_DISP_TYPE_DEAL_SOON}') {
			dealDate = "<fmt:formatDate value='${goods.dealDate}' pattern='M월 dd일 HH:mm'/>";
		}
		var foSaleAmt = '${goods.foSaleAmt }'*1;
		var orgSaleAmt = '${goods.orgSaleAmt }'*1;
		var saleAmt = '${goods.saleAmt }'*1;
		var rate = 0;
		var rateStyle = 'style="display:none"';
		if(orgSaleAmt > saleAmt && ((orgSaleAmt - saleAmt) / orgSaleAmt * 100 ) >= 1 ) {
			rateStyle = 'style="display:"';
			rate = Math.floor(100 - (foSaleAmt * 100) / orgSaleAmt);
		}
		
		var timeDeal = template.replace(/{{goodsId}}/gi, goodsId)
			.replace(/{{goodsNm}}/gi, goodsNm)
			.replace(/{{imgSrc}}/gi, imgSrc)
			.replace(/{{zzimCalss}}/gi, zzimCalss)
			.replace(/{{saleEndDtm}}/gi, saleEndDtm)
			.replace(/{{dealDate}}/gi, dealDate)
			.replace(/{{foSaleAmt}}/gi, numberWithCommas(foSaleAmt))
			.replace(/{{rateStyle}}/gi, rateStyle)
			.replace(/{{rate}}/gi, rate)
		if(dispType == '${frontConstants.GOODS_MAIN_DISP_TYPE_DEAL_NOW}') {
			timeDealList.push(timeDeal);
		}else if(dispType == '${frontConstants.GOODS_MAIN_DISP_TYPE_DEAL_SOON}') {
			timeDealSoonList.push(timeDeal);
		}
	</c:forEach>
	timeDealList.push(html);
	timeDealSoonList.push(html);
</c:if>
</c:forEach>
	var goodsArr = new Array();
	$(document).ready(function(){
		
		$("#timeDealList").append(timeDealList);
		$("#timeDealSoonList").append(timeDealSoonList);
		
		<c:forEach var="timeDeal" items="${timeDealList}">
		<c:if test="${timeDeal.dispType eq frontConstants.GOODS_MAIN_DISP_TYPE_DEAL_NOW}">
		goodsArr.push('${timeDeal.goodsId}');
		</c:if>
		</c:forEach>
		timeBefore()
		$("li[id^=btn]:first-child").children().first().click();
	});
	
	// 타임딜 시간 셋팅	
	function timeBefore(){
		var curTime = "<%=framework.common.util.DateUtil.getNowDateTime()%>";
		var serverTime = new Date(curTime.replace(/\s/, 'T'));
		$("[id^='timeDeal_']").each(function(index) {
			var $this = $(this);
			var dre = $this.val();
			var timeDeal = new Date(dre.replace(/\s/, 'T'));
			
			var serverTime = new Date(curTime.replace(/\s/, 'T'));
			var now = new Date();
			var dateGap = serverTime.getTime() - now.getTime();
			var realTime = timeDeal - dateGap;
			
			$this.countdown(realTime, function(event) {
				var resultTime = ( event.strftime('%D') != 0 ? event.strftime('%D') + '일  ' : '' ) + event.strftime('%H:%M:%S');
				$("#time_"+goodsArr[index]).text( "⌛️ "+resultTime);
			}).on('finish.countdown', function () {
				var timeDealLength = $("ul[id=timeDealList] li[id^=liTag_]").length;
				if(timeDealLength > 1) {
					$("#liTag_"+goodsArr[index]).hide();
					ui.disp.sld.tdeal.using();
				}else {
					$("section[class~=tdeal]").hide();
				}
			});
		});
	}

	function timedealList(dispClsfNo, dispCornNo, dispClsfCornNo, dispType) {
		var timeDeal = $("li[id^=btn][class=active]").attr("id").replace("btn", "");
		loadCornerGoodsList(dispClsfNo, dispCornNo, dispClsfCornNo, dispType, timeDeal);
	}
	
</script>


<c:forEach var="cornerList" items="${totalCornerList}">

	<c:set var="goodsCount" value="${not empty cornerList.goodsCount ? cornerList.goodsCount : 0}"/>
	<c:set var="nowDealCount" value="${cornerList.timeDealList[0].dispType eq 'NOW' ? cornerList.timeDealList[0].dispTypeCount : 0}"/>
	<c:set var="soonDealCount" value="${goodsCount - nowDealCount}"/>			
	
	<c:if test="${param.dispCornNo == cornerList.dispCornNo }">
	
		<!-- 타임딜 -->
		<input type="hidden" id="dispCornNo_td" value="${param.dispCornNo}"/>
		<input type="hidden" id="dispClsfCornNo_td" value="${cornerList.timeDealList[0].dispClsfCornNo}"/>
		<section class="sect mn tdeal" id="goSection_${param.dispCornNo}">
			<div class="hdts">
				<a class="hdt" href="javascript:void(0);" id="goodsList_${cornerList.timeDealList[0].dispClsfCornNo}" onclick="timedealList(${view.dispClsfNo},${param.dispCornNo},${cornerList.timeDealList[0].dispClsfCornNo},'${frontConstants.GOODS_MAIN_DISP_TYPE_DEAL}');return false;">
					<span class="tit"> 망설이면 마감! <br> 파격특가 <em class="b">${cornerList.dispCornNm}</em></span> <span class="more"><b class="t">전체보기</b></span>
				</a>
			</div>
			<ul class="uiTab f tmenu">
				<c:choose>
					<c:when test="${goodsCount == nowDealCount && cornerList.timeDealList[0].dispType == 'NOW'}">
						<li class="active" id="btnNOW">
							<button type="button" class="btn" data-ui-tab-btn="tab_deal" data-ui-tab-val="tab_deal_a">진행중</button>
						</li>
					</c:when>
					<c:when test="${goodsCount == soonDealCount && cornerList.timeDealList[0].dispType != 'NOW'}">
						<li class="active" id="btnSOON">
							<button type="button" class="btn" data-ui-tab-btn="tab_deal" data-ui-tab-val="tab_deal_b">다음 타임딜</button>
						</li>
					</c:when>
					<c:otherwise>
						<li class="active" id="btnNOW">
							<button type="button" class="btn" data-ui-tab-btn="tab_deal" data-ui-tab-val="tab_deal_a">진행중</button>
						</li>
						<li id="btnSOON">
							<button type="button" class="btn" data-ui-tab-btn="tab_deal" data-ui-tab-val="tab_deal_b">다음 타임딜</button>
						</li>
					</c:otherwise>
				</c:choose>
			</ul>
			<div data-ui-tab-ctn="tab_deal" data-ui-tab-val="tab_deal_a" class="tbctn active">
				<div class="mn_tdeal_sld">
					<div class="sld-nav">
						<button type="button" class="bt prev">이전</button>
						<button type="button" class="bt next">다음</button>
					</div>
					<div class="swiper-container slide">
						<ul class="swiper-wrapper list" id="timeDealList">
						</ul>
					</div>
				</div>
			</div>
			<div data-ui-tab-ctn="tab_deal" data-ui-tab-val="tab_deal_b" class="tbctn">
				<div class="mn_tdeal_sld">
					<div class="sld-nav">
						<button type="button" class="bt prev">이전</button>
						<button type="button" class="bt next">다음</button>
					</div>
					<div class="swiper-container slide">
						<ul class="swiper-wrapper list" id="timeDealSoonList">
						</ul>
					</div>
				</div>
			</div>
		</section>
	</c:if>
</c:forEach>