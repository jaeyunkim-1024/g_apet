<tiles:insertDefinition name="common">
<tiles:putAttribute name="script.inline">
<script type="text/javascript" src="/_script/corner.js" ></script>

<script type="text/javascript">
	$(document).ready(function(){
		mainSet(eval('${corners}'),'${confCornerStr}', '${view.imgDomain}');
	});
</script>

<script>
/* 시간 countdown */
var itemNm = $("[id^=gItem_]");
jQuery.each(itemNm, function(i, val){
	$('#'+itemNm[i].id).countdown(itemNm[i].innerHTML, function(event) {
		  $(this).html(event.strftime('%D일 %H:%M:%S'));
		});
});
$(window).ready(function(){
	//메인 프로모션 영역
	var mainSwiper1 = new Swiper('.swiper-container.mainPromotion', {
		slidesPerView: 1,
		autoplay: 2000,
	    pagination: '.mainPromotion .swiper-pagination',
		paginationClickable: true,
		spaceBetween: 0,
		simulateTouch : false
	});

	//메인 섹션1 영역
	var mainSwiper2 = new Swiper('.swiper-container.mainSec1', {
		slidesPerView: 1,
		autoplay: 2000,
		pagination: '.swiper-pagination',
		paginationClickable: true,
		spaceBetween: 0,
		simulateTouch : false
	});

	//메인 섹션2 영역
	var mainSwiper3 = new Swiper('.swiper-container.mainSec2', {
		slidesPerView: 1,
		autoplay: 2000,
		pagination: '.swiper-pagination',
		paginationClickable: true,
		spaceBetween: 0,
		simulateTouch : false
	});

	//메인 섹션4 영역
	var mainSwiper4 = new Swiper('.swiper-container.mainSec4', {
		slidesPerView: 1,
		autoplay: 2000,
		pagination: '.swiper-pagination',
		paginationClickable: true,
		spaceBetween: 0,
		simulateTouch : false
	});
});

</script>

<%--
// 외부 연동 Block 처리
<script type="text/javascript">
 //<![CDATA[
 var NeoclickConversionDctSv="type=1,orderID=,amount=";
 var NeoclickConversionAccountID="21136";
 if(location.protocol!="file:"){
    document.write(unescape("%3Cscript%20type%3D%22text/javas"+"cript%22%20src%3D%22"+(location.protocol=="https:"?"https":"http")+"%3A//ck.ncclick.co.kr/NCDC_V2.js%22%3E%3C/script%3E"));
 }
 //]]>
</script>
--%>
</tiles:putAttribute>
<tiles:putAttribute name="content">
			<!-- main_visual -->
			<div class="main_visual">
				<!-- Swiper -->
				<div class="mainPromotion swiper-container" >
					<ul class="swiper-wrapper" id="corner_${confCorner[0]}">
					</ul>
					<!-- Add Pagination -->
					<div class="swiper-pagination slide_page">
						<span></span>
					</div>
				</div>
				<ul class="thumb" id="corner_${confCorner[1]}">
				</ul>
			</div>
			<!--// main_visual -->
			
<%--
			<!-- main_section1 -->
			<div class="main_section1">
				<p id="title_${confCorner[2]}"></p>
				<c:if test="${not empty groupList}">
				<!-- Swiper -->
				<div class="mainSec1 swiper-container group_mainSec">
					<ul class="swiper-wrapper" id="corner_${confCorner[2]}">
						<c:forEach items="${groupList}" var="o" varStatus="idx">
						<c:if test="${idx.index%8 == 0}">
						<li class="swiper-slide">
						</c:if>
						<c:if test="${idx.index%4 == 0}">
							<div class="list_col4 <c:if test="${idx.index%8 != 4}">first</c:if>">
								<ul>
						</c:if>
									<li class="item">
										<div class="img_sec over_link">
											<frame:goodsImage imgPath="${o.imgPath}" seq="${o.imgSeq}" goodsId="${o.goodsId}" size="${ImageGoodsSize.SIZE_50.size}" />
											<c:if test="${o.groupEndYn eq 'Y'}">
											<div class="group_soldout"><span>SOLD OUT</span></div>
											</c:if>
											<div class="link_group">
												<div class="btn_area">
													<a href="/goods/indexGoodsDetail?goodsId=${o.goodsId}" class="btn_cover_move" title="상품 새창보기" target="_blank"><span>상품 새창보기</span></a>
													<a href="#" class="btn_cover_fav <c:if test='${o.interestYn eq "Y"}' >click</c:if>" title="위시리스트 추가" onclick="insertWish(this,'${o.goodsId}');return false;"><span>위시리스트 추가</span></a>
												</div>
												<div class="mask_link" onclick="location.href='/deal/indexGroupBuy?goodsId=${o.goodsId}'"></div>
											</div>
											<div class="group_ico">공동구매 상품</div>
										</div>

										<ul class="text_sec">
											<li class="u_name"><a href="/goods/indexGoodsDetail?goodsId=${o.goodsId}">${o.goodsNm}</a> </li>
											<li class="groupTime"><p id="gItem_${o.goodsId}"><frame:timestamp date="${o.saleEndDtm}" dType="S" tType="HS" /></p></li>
											<li class="u_cost"><s><frame:num data="${o.orgSaleAmt}" />원</s><span><frame:num data="${o.saleAmt}" />원</span></li>
										</ul>
									</li>

						<c:if test="${idx.index%4 == 3 or idx.last}">
								</ul>
							</div>
						</c:if>
						<c:if test="${idx.index%8 == 7 or idx.last}">
						</li>
						</c:if>
						</c:forEach>
					</ul>
					<!-- Add Pagination -->
					<div class="swiper-pagination"></div>
				</div>
				</c:if>
				<div class="list_col5">
					<ul id="corner_${confCorner[2]}">
					</ul>
				</div>
			</div>
			<!--// main_section1 -->
--%>

			<!-- main_section3 -->
			<div class="main_section3">
				<p class="main_sec_title ty02" id="title_${confCorner[3]}"></p>
				<div class="list_col5">
					<ul id="corner_${confCorner[3]}">
					</ul>
				</div>
			</div>
			<!--// main_section3 -->

			<!-- main_section2 -->
			<%-- 서비스 축소
			<div class="main_section2">
				<!-- Swiper -->
				<div class="mainSec2 swiper-container">
					<p id="title_${confCorner[4]}"></p>
					<ul class="swiper-wrapper" id="corner_${confCorner[4]}">
					</ul>
					<!-- Add Pagination -->
					<div class="swiper-pagination"></div>
				</div>
				<ul class="thumb" id="corner_${confCorner[5]}">
				</ul>
			</div>
			--%>
			<!--// main_section2 -->

			<!-- main_section5 -->
			<div class="main_section5">
				<p class="main_sec_title ty02" id="title_${confCorner[6]}"></p>
				<div class="list_col5">
					<ul id="corner_${confCorner[6]}">
					</ul>
				</div>
			</div>
			<!--// main_section5 -->
            <%-- 서비스 축소
			<!-- main_section6 -->
			<div class="main_section6">
				<p class="main_sec_title ty02" id="title_${confCorner[7]}"></p>
				<div class="list_col5">
					<ul id="corner_${confCorner[7]}">
					</ul>
				</div>
			</div>
			 --%>
			<!--// main_section6 -->

			<!-- main_section4 -->
			<%-- 서비스 축소
			<div class="main_section4">
				<!-- Swiper -->
				<div class="mainSec4 swiper-container">
					<p id="title_${confCorner[8]}"></p>
					<ul class="swiper-wrapper" id="corner_${confCorner[8]}">
					</ul>
					<!-- Add Pagination -->
					<div class="swiper-pagination"></div>
				</div>
				<ul class="thumb" id="corner_${confCorner[9]}">
				</ul>
			</div>
			--%>
			<!--// main_section4 -->

			
</tiles:putAttribute>
</tiles:insertDefinition>