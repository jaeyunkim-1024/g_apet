<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %> 
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<%--
  Class Name  : indexPremium.jsp
  Description : 메인페이지
  Author   	  : 고희정
  Since       : 2016.05.10
  Modification Information 
	          수정일         	     수정자             수정내용
    ----------  -------  -------------------------------------------
    2016.05.10    고희정           최초 작성
--%>
<script type="text/javascript" src="/_script/corner.js" ></script>

<script type="text/javascript">
	$(document).ready(function(){
		//brandSeller 프로모션 영역
		var brandSwiper1 = new Swiper('.swiper-container.brandSeller', {		
			slidesPerView: 1,
			autoplay: 2000,
	        pagination: '.brandSeller .swiper-pagination',  
			paginationClickable: true,
			nextButton: '.brandSeller_wrap .swiper-button-next ',
	        prevButton: '.brandSeller_wrap .swiper-button-prev ',
			spaceBetween: 0,
			simulateTouch : false
		});

		//brand visual 프로모션 영역
		var brandSwiper2 = new Swiper('.swiper-container.brandPromotion', {		
			slidesPerView: 'auto',
			autoplay: 2000,
	        pagination: '.brandPromotion_wrap .swiper-pagination',  
			paginationType: 'fraction',
			paginationClickable: true,
			nextButton: '.brandPromotion_wrap .swiper-button-next ',
	        prevButton: '.brandPromotion_wrap .swiper-button-prev ',		
			loop: true,
			spaceBetween: 30,
			simulateTouch : false
		});
		loadGoodsList('');
	});
	
	function loadGoodsList(dispClsfNo) { 
		if(dispClsfNo != null && dispClsfNo != '' ){
			$('.main_box_menu li').removeClass('active');
			$("#li_"+dispClsfNo).addClass('active');
		}else{
			$('.main_box_menu li').removeClass('active');
			$("#li_all").addClass('active');
		}
		ajax.load(
			"goods_list", 
			"/premium/getGoodsList",
			{
				targetId : 'goods_list', 
				dispClsfNo : dispClsfNo, 
				ctgGb : 'PREMIUM'
			}
		); 
	}
</script>
			<h2 class="newTitle">프리미엄</h2>
			<!-- brand_visual_promotion -->
			<div class="brand_visual_promotion">				
				<div class="brandSeller_wrap">				
					<!-- Swiper -->
					<c:if test="${not empty corners and not empty corners[0]}">
					<div class="brandSeller swiper-container">
						<ul class="swiper-wrapper">
						<c:forEach var="banner" items="${corners[0].listBanner}" varStatus="status">
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
					</c:if>
				</div>

				<div class="brandPromotion_wrap">	
					<div class="mgb30"><a href="${corners[1].linkUrl}"><img src="${view.imgDomain}${corners[1].cornImgPath}" alt="${corners[1].cntsTtl}"></a></div>
					<!-- Swiper -->
					<c:if test="${not empty corners[1].goodsList}">
					<div class="swiper-container brandPromotion">
						<ul class="swiper-wrapper">
							<c:forEach var="good" items="${corners[1].goodsList}" varStatus="status">
							<li class='${!status.first?"item ":"" }swiper-slide'>
								<a href="/goods/indexGoodsDetail?goodsId=${good.goodsId}&amp;dispClsfNo=">
									<frame:goodsImage imgPath="${good.imgPath}" goodsId="${good.goodsId}" seq="${good.imgSeq}" size="${ImageGoodsSize.SIZE_50.size}" alt="${good.goodsNm}"/>
								</a>
							</li>
							</c:forEach>
						</ul>						
					</div>	
					<!-- Add Pagination -->
					<div class="swiper-pagination"></div>
					<!-- next_back -->
					<div class="swiper-button-next"></div>
					<div class="swiper-button-prev"></div>
					</c:if>
				</div>
			</div>	
			<!--// brand_visual_promotion -->
			
			<div class="banner_wrap mgb0">
				<a href="${corners[2].linkUrl}">
					<img src="${view.imgDomain}${corners[2].cornImgPath}" alt="${corners[2].cntsTtl}">
				</a>
			</div>
			<!-- template col2 -->
			<div class="main_box">				
			<c:forEach var="good" items="${corners[2].goodsList}" varStatus="status">
				<c:if test="${status.index eq 0 }">
				<div class="list_col2">
					<ul>
				</c:if>
				<c:if test="${status.index eq 2 }">
				<div class="list_col4 pdt0">
					<ul>
				</c:if>
						<li class="item">
							<%-- <c:if test="${good.dealYn eq 'Y'}">
							<div class="deal_ico">딜 상품</div>
							</c:if> --%>
							<c:if test="${good.groupYn eq 'Y'}">
							<div class="group_ico">공동구매 상품</div>
							</c:if>
							<div class="img_sec over_link">
								<c:if test="${good.soldOutYn eq 'Y' }">
								<div class="sold_out"><span>SOLD OUT</span></div>
								</c:if>
								<a href="/goods/indexGoodsDetail?goodsId=${good.goodsId}">
									<c:if test="${status.index < 2}">
									<frame:goodsImage imgPath="${good.imgPath}" goodsId="${good.goodsId}" seq="${good.imgSeq}" size="${ImageGoodsSize.SIZE_20.size}" />
									</c:if>
									<c:if test="${status.index >=2}">
									<frame:goodsImage imgPath="${good.imgPath}" goodsId="${good.goodsId}" seq="${good.imgSeq}" size="${ImageGoodsSize.SIZE_50.size}" />
									</c:if>
								</a>
								<c:if test="${good.groupEndYn eq 'Y'}">
								<div class="group_soldout"><span>SOLD OUT</span></div>
								</c:if>
								<div class="link_group">
									<div class="btn_area">
										<a href="/goods/indexGoodsDetail?goodsId=${good.goodsId}" class="btn_cover_move" title="상품 새창보기" target="_blank"><span>상품 새창보기</span></a>
										<a href="#" class="btn_cover_fav <c:if test='${good.interestYn eq "Y"}' >click</c:if>" title="위시리스트 추가" onclick="insertWish(this,'${good.goodsId}');return false;"><span>위시리스트 추가</span></a>
									</div>
									<div class="mask_link" onclick="location.href='/goods/indexGoodsDetail?goodsId=${good.goodsId}'"></div>
								</div>
							</div>
								
							<ul class="text_sec">
								<c:set var="tagCnt" value="0" />
								<c:if test="${(good.newYn ne null and good.newYn == 'Y') || (good.couponYn != null && good.couponYn == 'Y') || (good.freeDlvrYn ne null and good.freeDlvrYn == 'Y') || (good.bestYn ne null and good.bestYn == 'Y')}">
								<li class="u_tag">
								</c:if>
								
								<c:if test="${good.newYn ne null and good.newYn == 'Y'}"><span class="tag">NEW</span><c:set var="tagCnt" value="${tagCnt+1}" /></c:if>
								
								<c:if test="${good.couponYn != null && good.couponYn == 'Y'}"><span class="tag">쿠폰</span><c:set var="tagCnt" value="${tagCnt+1}" /></c:if>
								
								<c:if test="${good.freeDlvrYn ne null and good.freeDlvrYn == 'Y'}"><span class="tag">무료배송</span><c:set var="tagCnt" value="${tagCnt+1}" /></c:if>
								
								<c:if test="${good.bestYn ne null and good.bestYn == 'Y' and tagCnt < 3}"><span class="tag">BEST</span></c:if>
						
								<c:if test="${(good.newYn ne null and good.newYn == 'Y') || (good.couponYn != null && good.couponYn == 'Y') || (good.freeDlvrYn ne null and good.freeDlvrYn == 'Y') || (good.bestYn ne null and good.bestYn == 'Y')}">
								</li>
								</c:if>
							<c:if test="${good.prWdsShowYn eq FrontWebConstants.COMM_YN_Y}">
								<li class="u_event"><c:out value="${good.prWds }" /></li>
							</c:if>
								<li class="u_brand"><c:out value="${good.bndNm }" /> </li>
								<li class="u_name"><a href="/goods/indexGoodsDetail?goodsId=<c:out value="${good.goodsId }"/>&dispClsfNo="><c:out value="${good.goodsNm }" /></a> </li>
								<li class="u_cost">
								<c:choose>
									<c:when test="${good.dealYn == 'Y' or good.groupYn == 'Y'}">
										<c:choose>
										<c:when test="${good.dcAmt > 0}">
										<fmt:formatNumber value="${(good.orgSaleAmt-good.dcAmt) / good.orgSaleAmt }" var="disRate" pattern=".##" />
										<span class="sale">[<fmt:formatNumber value="${disRate }" type="percent" />]</span>
										</c:when>
										<c:otherwise>
										<fmt:formatNumber value="${(good.orgSaleAmt-good.saleAmt) / good.orgSaleAmt }" var="disRate" pattern=".##" />
										<span class="sale">[<fmt:formatNumber value="${disRate }" type="percent" />]</span>
										</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<c:if test="${good.dcAmt > 0}">
										<fmt:formatNumber value="${(good.saleAmt-good.dcAmt) / good.saleAmt }" var="disRate" pattern=".##" />
										<span class="sale">[<fmt:formatNumber value="${disRate }" type="percent" />]</span>
										</c:if>
									</c:otherwise>
								</c:choose>
								<frame:num data="${good.foSaleAmt}" /> 원
								</li>										
							</ul>
						</li>
				<c:if test="${status.index eq 1 }">
					</ul>
				</div>
				</c:if>
				<c:if test="${status.index eq 6 }">
					</ul>
				</div>
				</c:if>
			</c:forEach>
			</div>	
			<!-- template col2 -->
	
			<!-- template col4 -->			
			<div class="main_box">
				<div class="main_box_top t_center">
					<ul class="main_box_menu">
						<li class="active" id="li_all"><a href="javascript:loadGoodsList('');"><span>전체</span></a></li>
					<c:forEach var="dispClsfNo" items="${dispClsfNos}" varStatus="status">
						<li class="" id="li_${dispClsfNo.dispClsfNo}"><a href="javascript:loadGoodsList('${dispClsfNo.dispClsfNo}');" ><span>${dispClsfNo.dispClsfNm}</span></a></li>
					</c:forEach>
					</ul>
				</div>
				<div id="goods_list">
				</div>	
			</div>
