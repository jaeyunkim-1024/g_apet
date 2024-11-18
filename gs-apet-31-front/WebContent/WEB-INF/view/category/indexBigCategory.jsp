<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<script type="text/javascript">
var imgDomain = "";

$(document).ready(function(){
	//TODO 데모 작업을 위해 주석처리 : 대카테고리만 나오도록 수정
	//var headerFixed = new ThatFixed(".categorySub_box", {posY:45}); 
	
	//category visual 프로모션 영역
	var cateSwiper1 = new Swiper('.swiper-container.catePromotion', {		
		slidesPerView: 1,
		pagination: '.catePromotion .swiper-pagination',  
		paginationClickable: true,
		nextButton: '.category_promotion_wrap .swiper-button-next ',
        prevButton: '.category_promotion_wrap .swiper-button-prev ',
		spaceBetween: 0,
		simulateTouch : false
	});

	//mdPick 영역
	var mdPickSwiper2 = new Swiper('.swiper-container.mdPick', {		
		slidesPerView: 1,
		autoplay: 2000,   
		pagination: '.swiper-pagination',
		paginationClickable: true,
		nextButton: '.mdPick_wrap .swiper-button-next',
        prevButton: '.mdPick_wrap .swiper-button-prev',
		spaceBetween: 0,
		simulateTouch : false
	});	
	
	imgDomain = '${view.imgDomain}';
	initSearch();
});

function initSearch() {
	// 선택 혜택 체크
	<c:forEach items="${searchVo.searchBenefitPC}" var="benefit" >
	$('input:checkbox[id="${benefit}"]').prop("checked", true); 
	</c:forEach>   
}

$(function() {
	// 페이지 클릭 이벤트
	$("#goods_list_page a").click(function(){
		var page =$(this).children("span").html();
		$("#page").val(page);
		getGoodsList();
		return false;
	});
	
	$("input[name=searchBenefitPC]:checkbox").change(function(){
		changeGoodsList();
	});
});

function changeGoodsList() {
	$("#page").val("1");
	getGoodsList();
}

function getGoodsList() {
	$('#goods_list_form').submit();
}

function setCateList(dispClsfNo) {
	location.href = "/category/indexCategory?dispClsfNo=" + dispClsfNo;
}

</script>

	<h2 class="newTitle">${so.dispClsfNm}</h2>

	<c:if test="${bannerCount > 0}">
	<!-- category_visual_wrap -->
	<div class="category_visual_wrap">				
		<div class="category_promotion_wrap">				
			<!-- Swiper -->
			<div class="catePromotion swiper-container">
				<ul class="swiper-wrapper">
					<c:forEach items="${banner1}" var="banner">
					<li class="swiper-slide"><a href="${banner.bnrLinkUrl}"><img src="${view.imgDomain}${banner.bnrImgPath}" alt="${banner.bnrDscrt}"></a></li>
					</c:forEach>
				</ul>
				<!-- Add Pagination -->
				<div class="swiper-pagination slide_page">
					<span></span>
				</div>
			</div>
			<!-- next_back -->
			<div class="swiper-button-next"></div>
			<div class="swiper-button-prev"></div>
		</div>
		<div class="catePromotionRight">
			<c:if test="${banner2 ne '[]'}">
			<a href="${banner2[0].bnrLinkUrl}"><img src="${view.imgDomain}${banner2[0].bnrImgPath}" alt="${banner2[0].bnrDscrt}"></a>
			</c:if>
		</div>
	</div>	
	<!--// category_visual_wrap -->
	</c:if>
	
	<!-- TODO 데모 작업을 위해 주석처리 : 대카테고리만 나오도록 수정 -->
	<%-- <div class="categorySub_box bigCate">
		<div class="category_area">
			<p class="area_title">카테고리</p>
			<div class="area_content">
				<ul>
					<li><a href="javascript:setCateList('${dispClsfNo}');">전체</a></li>
					<c:if test="${midDispCateList ne '[]'}">
					<c:forEach items="${midDispCateList}" var="cate">
						<li><a href="javascript:setCateList('${cate.dispClsfNo}');">${cate.dispClsfNm}</a></li>
					</c:forEach>
					</c:if>
				</ul>
			</div>
		</div>
	</div> --%>

	<c:if test="${pick ne null and pick ne '[]'}">
	<!-- md pick -->
	<div class="main_box mgt30">
		<p class="main_sec_title">MD's <strong>PICK</strong></p>
		<!-- mdPick_wrap -->
		<div class="mdPick_wrap">
			<!-- Swiper -->
			<div class="mdPick swiper-container">
				<ul class="swiper-wrapper">
					<c:forEach items="${pick}" var="o" varStatus="idx">
					
					<c:if test="${idx.index % 4 == 0}">
					<li class="swiper-slide">
						<div class="list_col4">
							<ul>
					</c:if>
								<li class="item">
									<%-- <c:if test="${o.dealYn == 'Y' }">
									<div class="deal_ico">딜 상품</div>
									</c:if> --%>
									<c:if test="${o.groupYn eq 'Y'}">
									<div class="group_ico">공동구매 상품</div>
									</c:if>
									<div class="img_sec over_link">
										<c:if test="${o.soldOutYn == 'Y' }">
										<div class="sold_out"><span>SOLD OUT</span></div>
										</c:if>
										<a href="/goods/indexGoodsDetail?goodsId=${o.goodsId}">
											<frame:goodsImage imgPath="${o.imgPath}" goodsId="${o.goodsId}" seq="${o.imgSeq}" size="${ImageGoodsSize.SIZE_50.size}" alt="${o.goodsNm}"/>
										</a>
										<c:if test="${o.groupEndYn eq 'Y'}">
										<div class="group_soldout"><span>SOLD OUT</span></div>
										</c:if>
										<div class="link_group">
											<div class="btn_area">
												<a href="/goods/indexGoodsDetail?goodsId=${o.goodsId}" class="btn_cover_move" title="상품 새창보기" target="_blank"><span>상품 새창보기</span></a>
												<a href="#" class="btn_cover_fav <c:if test='${o.interestYn eq "Y"}'>click</c:if>" title="위시리스트 추가" onclick="insertWish(this,'${o.goodsId}');return false;"><span>위시리스트 추가</span></a>
											</div>
											<div class="mask_link" onclick="location.href='/goods/indexGoodsDetail?goodsId=${o.goodsId}'"></div>
										</div>
									</div>
										
									<ul class="text_sec">
										<c:set var="tagCnt" value="0" />
										<c:if test="${(o.newYn ne null and o.newYn == 'Y') || (o.couponYn != null && o.couponYn == 'Y') || (o.freeDlvrYn ne null and o.freeDlvrYn == 'Y') || (o.bestYn ne null and o.bestYn == 'Y')}">
										<li class="u_tag">
										</c:if>
										
										<c:if test="${o.newYn ne null and o.newYn == 'Y'}"><span class="tag">NEW</span><c:set var="tagCnt" value="${tagCnt+1}" /></c:if>
										
										<c:if test="${o.couponYn != null && o.couponYn == 'Y'}"><span class="tag">쿠폰</span><c:set var="tagCnt" value="${tagCnt+1}" /></c:if>
										
										<c:if test="${o.freeDlvrYn ne null and o.freeDlvrYn == 'Y'}"><span class="tag">무료배송</span><c:set var="tagCnt" value="${tagCnt+1}" /></c:if>
										
										<c:if test="${o.bestYn ne null and o.bestYn == 'Y' and tagCnt < 3}"><span class="tag">BEST</span></c:if>
								
										<c:if test="${(o.newYn ne null and o.newYn == 'Y') || (o.couponYn != null && o.couponYn == 'Y') || (o.freeDlvrYn ne null and o.freeDlvrYn == 'Y') || (o.bestYn ne null and o.bestYn == 'Y')}">
										</li>
										</c:if>
										
										<c:if test="${o.prWdsShowYn eq 'Y'}">
										<li class="u_event"><c:out value="${o.prWds }" /></li>
										</c:if>
										<li class="u_brand">${o.bndNm}</li>
										<li class="u_name"><a href="/goods/indexGoodsDetail?goodsId=${o.goodsId}">${o.goodsNm}</a> </li>
										<li class="u_cost">
										<c:choose>
											<c:when test="${o.dealYn == 'Y' or o.groupYn eq 'Y'}">
												<c:choose>
												<c:when test="${o.dcAmt > 0}">
												<fmt:formatNumber value="${(o.orgSaleAmt-o.dcAmt) / o.orgSaleAmt }" var="disRate" pattern=".##" />
												<span class="sale">[<fmt:formatNumber value="${disRate }" type="percent" />]</span>
												</c:when>
												<c:otherwise>
												<fmt:formatNumber value="${(o.orgSaleAmt-o.saleAmt) / o.orgSaleAmt }" var="disRate" pattern=".##" />
												<span class="sale">[<fmt:formatNumber value="${disRate }" type="percent" />]</span>
												</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise>
												<c:if test="${o.dcAmt > 0}">
												<fmt:formatNumber value="${(o.saleAmt-o.dcAmt) / o.saleAmt }" var="disRate" pattern=".##" />
												<span class="sale">[<fmt:formatNumber value="${disRate }" type="percent" />]</span>
												</c:if>
											</c:otherwise>
										</c:choose>
										<frame:num data="${o.foSaleAmt}" /> 원
										</li>										
									</ul>
								</li>									
																	
					<c:if test="${idx.index % 4 == 3 or idx.last}">
							</ul>
						</div>
					</li>
					</c:if>		

					</c:forEach>
				</ul>
				<!-- Add Pagination -->
				<div class="swiper-pagination slide_page">
					<span></span>
				</div>
			</div><!--// Swiper -->
			<!-- next_back -->
			<div class="swiper-button-next"></div>
			<div class="swiper-button-prev"></div>
		</div><!--// mdPick_wrap -->
	</div>	
	<!--// md pick -->
	</c:if>
	
<form id="goods_list_form" method="POST" action="/category/indexCategory?dispClsfNo=${dispClsfNo}">
	
	<input type="hidden" id="dispLvl" name="dispLvl" value="${so.dispLvl}" />
	<input type="hidden" id="page" name="pageNumber" value="${searchVo.pageNumber}"/>
	<input type="hidden" id="totalPage" name="totalPage" value="${searchVo.totalPage}"/>

	<!-- search_list / category_list -->	
	<div class="search_list_wrap">
		<div class="main_box mgt30">
			<div class="main_box_top">
				<div class="sort_list_count"><span class="num"><c:out value="${searchVo.tab_totalSize}" /></span>개의 상품이 있습니다.</div>
				<div class="search_sort">
					<ul class="sort_condition">
						<li><input type="checkbox" id="gonggu" name="searchBenefitPC" value="gonggu"><label for="gonggu">공동구매</label></li>
						<li><input type="checkbox" id="free" name="searchBenefitPC" value="free"><label for="free">무료배송</label></li>
						<li><input type="checkbox" id="coupon" name="searchBenefitPC" value="coupon"><label for="coupon">쿠폰</label></li>
					</ul>
				
					<div class="sort_select">
						<select id="sort_standard" id="searchSort" name="searchSort" class="select2" style="width:120px" onchange="javascrit:changeGoodsList();return false;">
							<option value="best" <c:if test="${searchVo.searchSort eq 'best'}">selected</c:if>>인기순</option>
							<option value="date" <c:if test="${searchVo.searchSort eq 'date'}">selected</c:if>>최근등록순</option>
							<option value="highprice" <c:if test="${searchVo.searchSort eq 'highprice'}">selected</c:if>>높은가격순</option>
							<option value="lowprice" <c:if test="${searchVo.searchSort eq 'lowprice'}">selected</c:if>>낮은가격순</option>
							<option value="comment" <c:if test="${searchVo.searchSort eq 'comment'}">selected</c:if>>상품리뷰순</option>
						</select>
						<select id="goods_list_rows" id="searchDisplay" name="searchDisplay" class="select2" style="width:50px" onchange="javascrit:changeGoodsList();return false;">
							<option value="20" <c:if test="${searchVo.searchDisplay eq '20'}">selected</c:if>>20</option>
							<option value="40" <c:if test="${searchVo.searchDisplay eq '40'}">selected</c:if>>40</option>
							<option value="60" <c:if test="${searchVo.searchDisplay eq '60'}">selected</c:if>>60</option>
							<option value="80" <c:if test="${searchVo.searchDisplay eq '80'}">selected</c:if>>80</option>
						</select>	
					</div>
				</div>
			</div>
			
			<c:choose>
			<c:when test="${goodsList ne '[]'}">
			<div class="list_col5">
				<ul>
					<c:forEach items="${goodsList }" var="o" varStatus="status">
					<li class="item">
						<%-- <c:if test="${o.hotdeal eq 'Y'}">
						<div class="deal_ico">딜 상품</div>
						</c:if> --%>
						<c:if test="${o.gonggu eq 'Y'}">
						<div class="group_ico">공동구매 상품</div>
						</c:if>
						<div class="img_sec over_link">
							<a href="/goods/indexGoodsDetail?goodsId=${o.goodsid}">
								<frame:goodsImage imgPath="${o.imgpath}" goodsId="${o.goodsid}" seq="${o.imgseq}" size="${ImageGoodsSize.SIZE_60.size}" alt="${o.goodsnm}"/>
								<c:if test="${o.soldoutyn eq 'Y'}">
								<div class="sold_out_layer"><span class="sold_out_text">SOLD OUT</span></div>
								</c:if>
								<c:if test="${o.bulkordendyn eq 'Y'}">
								<div class="group_soldout"><span>SOLD OUT</span></div>
								</c:if>
							</a>
							<div class="link_group">
								<div class="btn_area">
									<a href="/goods/indexGoodsDetail?goodsId=${o.goodsid}" class="btn_cover_move" title="상품 새창보기" target="_blank"><span>상품 새창보기</span></a>
									<a href="#" class="btn_cover_fav <c:if test='${o.interestyn eq "Y"}' >click</c:if>" title="위시리스트 추가" onclick="insertWish(this,'${o.goodsid}');return false;"><span>위시리스트 추가</span></a>
								</div>
								<div class="mask_link" onclick="location.href='/goods/indexGoodsDetail?goodsId=${o.goodsid}'"></div>
							</div>
						</div>
						
						<ul class="text_sec">		
							<c:set var="tagCnt" value="0" />
							<c:if test="${(o.newyn ne null and o.newyn == 'Y') || (o.couponyn != null && o.couponyn == 'Y') || (o.freedlvryn ne null and o.freedlvryn == 'Y') || (o.bestyn ne null and o.bestyn == 'Y')}">
							<li class="u_tag">
							</c:if>
							
							<c:if test="${o.newyn ne null and o.newyn == 'Y'}"><span class="tag">NEW</span><c:set var="tagCnt" value="${tagCnt+1}" /></c:if>
							
							<c:if test="${o.couponyn != null && o.couponyn == 'Y'}"><span class="tag">쿠폰</span><c:set var="tagCnt" value="${tagCnt+1}" /></c:if>
							
							<c:if test="${o.freedlvryn ne null and o.freedlvryn == 'Y'}"><span class="tag">무료배송</span><c:set var="tagCnt" value="${tagCnt+1}" /></c:if>
							
							<c:if test="${o.bestyn ne null and o.bestyn == 'Y' and tagCnt < 3}"><span class="tag">BEST</span></c:if>
					
							<c:if test="${(o.newyn ne null and o.newyn == 'Y') || (o.couponyn != null && o.couponyn == 'Y') || (o.freedlvryn ne null and o.freedlvryn == 'Y') || (o.bestyn ne null and o.bestyn == 'Y')}">
							</li>
							</c:if>
							
							<c:if test="${o.prwdsshowyn eq 'Y'}">
							<li class="u_event"><c:out value="${o.prwds }" /></li>
							</c:if>
							<li class="u_brand">${o.bndnmko}</li>
							<li class="u_name"><a href="/goods/indexGoodsDetail?goodsId=${o.goodsid}">${o.goodsnm}</a> </li>
							<li class="u_cost">
								<c:if test="${o.salepct > 0}">
								<span class="sale">[${o.salepct}%]</span>
								</c:if>
								<frame:num data="${o.prmtdcamt}" /> 원
							</li>	
						</ul>
					</li>		
					</c:forEach>
				</ul>
			</div>
			</c:when>
			<c:otherwise>
			<div style="padding:54px 0px; text-align:center; color:#666666;">
				<div class="nodata">
					<p>선택한 조건의 검색 결과가 없습니다.</p>
					<p>다른 항목을 선택해 보세요.</p>
				</div>
			</div>
			</c:otherwise>
		</c:choose>
			
		<!-- 페이징 -->
		<frame:listPage recordPerPage="${searchVo.searchDisplay}" currentPage="${searchVo.pageNumber}" totalRecord="${searchVo.shop_totalSize}" indexPerPage="10" id="goods_list_page" />
		<!-- 페이징 -->
			
		</div>
	</div>
	<!-- //search_list / category_list -->	
	
</form>