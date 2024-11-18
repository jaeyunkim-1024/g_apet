<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<script type="text/javascript">
var imgDomain = "";

$(document).ready(function(){
	var headerFixed = new ThatFixed(".categorySub_box", {posY:45}); 
	
	//mdPick 영역
	var mainSwiper2 = new Swiper('.swiper-container.mdPick', {		
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
	// 선택 브랜드 체크
	var brand_list = [];
	<c:forEach items="${searchVo.searchBrand}" var="brand" >
	$('input:checkbox[id="${brand}"]').prop("checked", true); 
	brand_list.push('${brand}');
	</c:forEach>   
	
	$('#searchBrand').val(brand_list);
	displayBrandKeyword();
	
	// 선택 혜택 체크
	<c:forEach items="${searchVo.searchBenefitPC}" var="benefit" >
	$('input:checkbox[id="${benefit}"]').prop("checked", true); 
	</c:forEach>   
	
	// 선택 가격 체크
	var price_list = [];
	<c:forEach items="${searchVo.buttonPrice}" var="price" >
	price_list.push('${price}');
	</c:forEach>   
	
	$('#buttonPrice').val(price_list);
	if ($('#searchStartPrice').val() != '') {
		$("#direct").prop("checked", true);
		
		$("#price1").val(valid.numberWithCommas($('#searchStartPrice').val()));
		$("#price2").val(valid.numberWithCommas($('#searchEndPrice').val()));
	}
	else {
		$("#price1").val(valid.numberWithCommas($('#resultStartPrice').val()));
		$("#price2").val(valid.numberWithCommas($('#resultEndPrice').val()));
	}
}

$(function() {
	// 페이지 클릭 이벤트
	$("#goods_list_page a").click(function(){
		var page =$(this).children("span").html();
		$("#page").val(page);
		getGoodsList();
		return false;
	});
	
	$("input[name=checkBrand]:checkbox").change(function(){
		displayBrandKeyword();
		changeBrand();
	});

	$("#cate_keyword button").click(function(){
		$("#cate_keyword div").html("");
		$("input[name=checkBrand]").prop("checked", false);
		$("#cate_keyword").hide();
		
		changeBrand();
	});
	
	
	$("input[name=searchBenefitPC]:checkbox").change(function(){
		changeGoodsList();
	});
	
	// 가격대버튼 클릭
	$(".price_btn").click(function(){
		if($(".search_price_content").css("display") == "none"){
			$(".search_price_content").show();
		}else{
			$(".search_price_content").hide();
		}
	});
	
	// 가격대버튼 외부클릭처리
	$('body').click(function(e){
		if($(".search_price_content").css("display") == "block"){
			if(!$(".search_price_wrap").has(e.target).length){
				$(".search_price_content").hide();
			}
		}
	});
	
	// 가격대버튼 가격범위버튼 클릭
	$(".price_in_btn").click(function(){
		
		$("#searchStartPrice").val('');
		$("#searchEndPrice").val('');
		
		$("#price1").val(valid.numberWithCommas($('#resultStartPrice').val()));
		$("#price2").val(valid.numberWithCommas($('#resultEndPrice').val()));
			
		$("#direct").prop("checked", false);
		
		//$(this).addClass("active");
		$(this).toggleClass("active");
		
	});
	
	// 가격대버튼 직접입력 체크박스 클릭시
	$("#direct").click(function(){
		if ($("#direct").is(":checked")) {
			$(".price_box .price_in_btn").removeClass("active");
		}
		else {
		}
	});
	
	// 가격대버튼 적용버튼 클릭시
	$(".search_direct_btn").click(function(){
		if ($("#direct").is(":checked")) {
			var price1 = $('#price1').val().replace(/,/g, '');
			var price2 = $('#price2').val().replace(/,/g, '');
			
			if (price1 == "" || price2 == "") {
				alert("검색 가격 범위를 입력하세요.");
				$('#price1').focus();
				return false;
			}
			
			$('#searchStartPrice').val(price1);
			$('#searchEndPrice').val(price2);
			
			var searchStart = parseInt($('#searchStartPrice').val());
			var searchEnd = parseInt($('#searchEndPrice').val());
			
			var resultStart = parseInt($('#resultStartPrice').val());
			var resultEnd = parseInt($('#resultEndPrice').val());
			
			if (!((searchStart>=resultStart && searchStart<=resultEnd) && (searchEnd>=resultStart && searchEnd<=resultEnd))) {
				alert("가격은 " + valid.numberWithCommas(resultStart) + "원 ~ " + valid.numberWithCommas(resultEnd) + "원 범위 내에서 입력 가능합니다.");
				$('#price1').focus();
				return false;
			}
			
			$('#buttonPrice').val("");
			changeGoodsList();
		} 
		else if ($(".price_box").find(".active").length > 0) {
			$('#searchStartPrice').val(price1);
			$('#searchEndPrice').val(price2);
			
			var btn_price_val = [];
			$(".price_box .active").each(function(i) {
				btn_price_val.push($(this).val());
			});
						
			$('#buttonPrice').val(btn_price_val);
			changeGoodsList();
		} else{
			alert("선택한 값이 없습니다");
			return false;
		}
	});
	
	
	$('.search_direct input').on("keyup", function(e){
		$("#direct").prop("checked", true);
		$(".price_box .price_in_btn").removeClass("active");
		
		var num = $(this).val().replace(/\,/g, '');
		num = valid.numberWithCommas(num);
		$(this).val(num);
	});	
	
	
});

//가격대버튼 선택해제 클릭시
function initPrice() {
	
	$("#direct").prop("checked", false);
	
	$("#price1").val(valid.numberWithCommas($('#resultStartPrice').val()));
	$("#price2").val(valid.numberWithCommas($('#resultEndPrice').val()));
	
	$(".price_box .price_in_btn").removeClass("active");
	$('#buttonPrice').val("");
	
	return false;
}

function displayBrandKeyword() {
	var count = 0;
	var listString = "";
	
	$("input[name=checkBrand]:checked").each(function() {
		var groupNm = $(this).attr("id");
    	listString +='<span class="word" data="' + groupNm + '">' + groupNm.split('$')[1] + '<button type="button" onclick="javascript:brandDel(this);" class="close"><span>닫기</span></button></span>';
    	
		count++;
	});
	
	$("#cate_keyword div").html(listString);
	
	if (count ==0) 
		$("#cate_keyword").hide();
	else 
		$("#cate_keyword").show();
}

function brandDel(obj) {
	var parent = $(obj).parent();
	var id = parent.attr("data");
	
	$('input:checkbox[id="' + id + '"]').attr("checked", false); 
	parent.remove();
	
	var count = $("#cate_keyword div").children('span').length;
	if (count == 0) 
		$("#cate_keyword").hide();
	
	changeBrand();
}

function changeBrand() {
	var brand_list = [];
	
	$("input[name=checkBrand]:checked").each(function() {
		brand_list.push($(this).attr("id"));
	});
	$('#searchBrand').val(brand_list);
	
	changeGoodsList();
}

function changeTab(searchCategory) {
	$('#searchCategory').val(searchCategory);
	changeGoodsList();
}

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

<form id="goods_list_form" method="POST" action="/category/indexCategory?dispClsfNo=${dispClsfNo}">
	
	<input type="hidden" id="dispLvl" name="dispLvl" value="${so.dispLvl}" />
	<input type="hidden" id="page" name="pageNumber" value="${searchVo.pageNumber}"/>
	<input type="hidden" id="totalPage" name="totalPage" value="${searchVo.totalPage}"/>
	<input type="hidden" id="searchCategory" name="searchCategory" value="${searchVo.searchCategory}" />
	<input type="hidden" id="searchBrand" name="searchBrand" value="${searchVo.searchBrand}" />
	<input type="hidden" id="searchStartPrice" name="searchStartPrice" value="${searchVo.searchStartPrice}"/>
	<input type="hidden" id="searchEndPrice" name="searchEndPrice" value="${searchVo.searchEndPrice}"/>
   	<input type="hidden" id="resultStartPrice" name="resultStartPrice" value="${searchVo.resultStartPrice}"/>
	<input type="hidden" id="resultEndPrice" name="resultEndPrice" value="${searchVo.resultEndPrice}"/>
	<input type="hidden" id="buttonPrice" name="buttonPrice" value="${searchVo.buttonPrice}" />
	
	<div class="categorySub_box">
		<div class="category_area">
			<p class="area_title">카테고리</p>
			<div class="area_content">
				<ul>
					<c:if test="${so.dispLvl eq 2}">
					<c:set var="allDispClsfNo" value="${so.dispClsfNo}"/>
					</c:if> 
					<c:if test="${so.dispLvl eq 3}">
					<c:set var="allDispClsfNo" value="${so.upDispClsfNo}"/>
					</c:if> 
					<li <c:if test="${searchVo.cateMcode eq allDispClsfNo}">class="active"</c:if>><a href="javascript:setCateList('${allDispClsfNo}');">전체</a></li>
					<c:if test="${smallDispCateList ne '[]'}">
						<c:forEach items="${smallDispCateList}" var="cate">
							<li <c:if test="${searchVo.cateScode eq cate.dispClsfNo}">class="active"</c:if>><a href="javascript:setCateList('${cate.dispClsfNo}');">${cate.dispClsfNm}</a></li>
						</c:forEach>
					</c:if>
				</ul>
			</div>
		</div>
		<div class="brand_area">
			<p class="area_title">브랜드</p>
			<div class="area_content">
				<ul>
					<c:forEach items="${brandGroupList}" var="brand">
					<li><input type="checkbox" name="checkBrand" class="checkPink" id="${brand.groupNm}" value="${brand.groupNm}" <c:if test="${fn:contains(searchVo.searchBrand, brand.groupNm)}">checked</c:if>><label for="${brand.groupNm}">${fn:split(brand.groupNm,'$')[1]} (${brand.groupCount})</label></li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<!-- keyword_wrap -->	
		<div class="keyword_wrap" id="cate_keyword" style="display:none" >
			<div></div>
			<button type="button" class="close">초기화 <span>닫기</span></button>
		</div>
		<!--// keyword_wrap -->	
	</div>

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
												<a href="#" class="btn_cover_fav <c:if test='${o.interestYn eq "Y"}' >click</c:if>" title="위시리스트 추가" onclick="insertWish(this,'${o.goodsId}');return false;"><span>위시리스트 추가</span></a>
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

	<!-- search_list / category_list -->	
	<div class="search_list_wrap">
		<!-- tab : search_list_tabBox -->
		<div class="search_list_tabBox">
			<div class="search_sort">
				<ul class="sort_condition">
					<li><input type="checkbox" id="gonggu" name="searchBenefitPC" value="gonggu"><label for="gonggu">공동구매</label></li>
					<li><input type="checkbox" id="free" name="searchBenefitPC" value="free"><label for="free">무료배송</label></li>
					<li><input type="checkbox" id="coupon" name="searchBenefitPC" value="coupon"><label for="coupon">쿠폰</label></li>
				</ul>
				
				<div class="search_price_wrap">
					<button type="button" class="price_btn">가격대</button>
					<div class="search_price_content" style="display:none;">
						<ul class="price_box">
							<c:forEach var="plist" items="${plist}" varStatus="status" >
							<li><button type="button" id="price_in_btn" class="price_in_btn <c:forEach var="list" items="${searchVo.buttonPrice}" varStatus="status"><c:if test="${list eq plist}">active</c:if></c:forEach>" value="${plist}">${plist}</button></li>
							</c:forEach>
						</ul>
						<div class="search_direct_box">
							<input type="checkbox" id="direct" name="direct"><label for="direct">직접입력</label>
							<!-- search_direct -->
							<span class="search_direct">
								<input type="text" id="price1" class="price" placeholder="원" onkeydown="return inputNumKey(event)">
								<span class="bar">~</span>
								<input type="text" id="price2" class="price" placeholder="원" onkeydown="return inputNumKey(event)">
							</span><!-- //search_direct -->								
							<a href="#" class="search_direct_btn">적용</a>														
						</div>
						<a id="btn_prc_cancle" onclick="javascript:initPrice();">선택해제</a>
					</div>
				</div>
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
			<ul class="searchList">
				<li <c:if test="${searchVo.searchCategory eq ''}">class="active"</c:if>><a href="javascript:changeTab('')">전체<span>(${searchVo.tab_totalSize})</span></a></li>
				<c:if test="${prmtCnt > 0}">
				<li <c:if test="${searchVo.searchCategory eq 'prmt'}">class="active"</c:if>><a href="javascript:changeTab('prmt')">프리미엄<span>(${prmtCnt})</span></a></li>
				</c:if>
			</ul>
		</div>
		<!--// tab : search_list_tabBox -->

		<!-- tabCont :  searchListContainer  -->
		<div class="searchListContainer">
			<div class="searchListContent">
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
			</div>
			<!-- 페이징 -->
			<frame:listPage recordPerPage="${searchVo.searchDisplay}" currentPage="${searchVo.pageNumber}" totalRecord="${searchVo.shop_totalSize}" indexPerPage="10" id="goods_list_page" />
			<!-- 페이징 -->

		</div>
		<!--// tabCont :  searchListContainer  -->				
	</div>
	<!-- //search_list / category_list -->	
</form>
