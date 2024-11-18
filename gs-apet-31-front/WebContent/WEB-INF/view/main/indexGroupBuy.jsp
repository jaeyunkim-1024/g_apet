<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<%@ page import="framework.common.constants.CommonConstants" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>


<script type="text/javascript">
	
$(document).ready(function(){
	
	// 페이지 클릭 이벤트
	$("#list_page a").click(function(){
		var page =$(this).children("span").html();
		$("#curr_page").val(page);
		reloadList();
		return false;
	});
	
	/* 시간 countdown */
	var itemNm = $("[id^=item_]");
	jQuery.each(itemNm, function(i, val){
		$('#'+itemNm[i].id).countdown(itemNm[i].innerHTML, function(event) {
			  $(this).html(event.strftime('%D일 %H:%M:%S'));
			});			
	});	
});

$(window).load(function(){
	var select = $(".group_pro.select");
	if (select.length > 0) {
		var offset = select.offset();
		$('html, body').animate({scrollTop : offset.top-70}, 300);
	}
});

$(function() {
	$('select[name=sortType]').change(function () {
		$("#curr_page").val("1");
		reloadList();
	});
});

/*
 * 공동구매 리스트 페이징 조회
 */
function reloadList() {
	$("#list_form").attr("target", "_self");
	$("#list_form").attr("action", "/deal/indexGroupBuy");
	$("#list_form").submit();
}

</script>

<h2 class="newTitle">팔때사</h2>
<c:if test="${banner ne null}">
<div class="group_banner"><a href="#"><img src="${view.imgDomain}${banner.bnrImgPath}" alt="${banner.bnrDscrt}"></a></div>
</c:if>
<c:if test="${video ne null}">
<div class="group_video">
	<iframe width="960" height="540" src="${video.bnrImgPath}" frameborder="0" allowfullscreen></iframe>
</div>
</c:if>
<!-- main_box -->
<div class="main_box">
	<c:if test="${topGoods != null and not empty topGoods}">
	<!-- group_top_wrap -->
	<div class="group_top_wrap">
		<ul class="group_top_pro_list">
			<c:forEach items="${topGoods}" var="o" varStatus="idx">
			<li class="group_pro<c:if test="${o.groupEndYn eq 'Y'}"> end</c:if>">
				<!-- pro_wrap -->
				<div class="pro_wrap">
					<!-- pro_top -->
					<div class="pro_top">
						<c:if test="${o.groupEndYn eq 'N'}">
						<span class="status"><em>진행중</em></span>
						<span class="hour" id="item_${o.goodsId}"><frame:timestamp date="${o.saleEndDtm}" dType="S" tType="HS" /></span>
						</c:if>
						<c:if test="${o.groupEndYn eq 'Y'}">
						<span class="status"><em>종료</em></span>
						<span class="hour">0일 00:00:00</span>
						</c:if>
					</div><!-- //pro_top -->
					<!-- pro_img -->
					<div class="pro_img over_link">
						<frame:goodsImage imgPath="${o.imgPath}" seq="${o.imgSeq}" goodsId="${o.goodsId}" size="${ImageGoodsSize.SIZE_20.size}" alt="${o.goodsNm}"/>
						
						<c:if test="${o.groupEndYn eq 'Y'}">
						<div class="group_soldout"><span>SOLD OUT</span></div>
						</c:if>
						<!-- link_group -->
						<div class="link_group">
							<div class="btn_area">
								<a href="/goods/indexGoodsDetail?goodsId=${o.goodsId}" class="btn_cover_move" title="상품 새창보기" target="_blank"><span>상품 새창보기</span></a>
								<a href="#" class="btn_cover_fav <c:if test='${o.interestYn eq "Y"}' >click</c:if>" title="위시리스트 추가" onclick="insertWish(this,'${o.goodsId}');return false;"><span>위시리스트</span></a>
							</div>
							<div class="mask_link" onclick="location.href='/goods/indexGoodsDetail?goodsId=${o.goodsId}'"></div>
						</div><!-- //link_group -->
					</div><!-- //pro_img -->
					<!-- pro_info -->
					<div class="pro_info">
						<a href="#"><span class="pro_name">${o.goodsNm}</span></a>
						<!-- sale_info_wrap -->
						<div class="sale_info_wrap">
							<span class="discount_basis"><em><frame:num data="${o.minOrdQty}" /></em>개 구매하면 이 가격</span>
							<span class="price_info">
								<del><frame:num data="${o.orgSaleAmt}" />원</del>
								<span class="now_parice"><em><frame:num data="${o.saleAmt}" /></em>원</span>
							</span>
							<fmt:formatNumber value="${(o.orgSaleAmt-o.saleAmt) / o.orgSaleAmt}" var="disRate" pattern=".##" />
							<span class="sale_num"><em><fmt:formatNumber value="${disRate*100}" /></em></span>
						</div><!-- //sale_info_wrap -->
					</div><!-- //pro_info -->
					<!-- purchase_graph -->
					<div class="purchase_graph">
						<fmt:formatNumber value="${(o.strtOrdQty+o.salesQty) / o.trgtQty}" var="buyRate" pattern=".##" />
						<fmt:formatNumber value="${buyRate*100}" var="buyRate" />
						<c:if test="${o.groupEndYn eq 'N'}">
						
						<span class="comment"><em>
						<c:choose>
						<c:when test="${buyRate <= 10}">드루와!</c:when>
						<c:when test="${buyRate <= 50}">안사면 손해!</c:when>
						<c:when test="${buyRate <= 80}">핫해! 핫해!</c:when>
						<c:when test="${buyRate <= 99}">서둘러요!</c:when>
						<c:otherwise>인기폭발!</c:otherwise>
						</c:choose>
						
						</em></span>
						<div class="graph">
							<span class="bar" style="width:${buyRate}%"></span>
							<span class="purchase_num"><em><frame:num data="${o.strtOrdQty+o.salesQty}" /></em>개</span>
						</div>
						</c:if>
						
						<c:if test="${o.groupEndYn eq 'Y'}">
						<span class="comment"><em>커밍순</em></span>
						<div class="graph">
							<span class="bar" style="width:100%"></span>
							<span class="purchase_num"><em>판매완료</em></span>
						</div>
						</c:if>
					</div><!-- //purchase_graph -->
				</div><!-- //pro_wrap -->
			</li>
			</c:forEach>
		</ul>
	</div><!-- //group_top_wrap -->
	</c:if>
	<!-- group_list_wrap -->
	<div class="group_list_wrap">
		<div class="main_box_top group_main_box_top">
			<form id="list_form" method="POST">
			<input type="hidden" id="curr_page" name="page" value="<c:out value='${so.page }' />" />
	
			<p class="sub_sec_title"><em>${so.totalCount}</em>개의 상품이 있습니다.</p>
			<div class="search_sort">
				<div class="sort_select">
					<select id="sort_standard" name="sortType" class="select2" style="width:120px">
						<option value="<c:out value="${FrontWebConstants.SORT_TYPE_POPULAR}" />" <c:if test='${so.sortType eq FrontWebConstants.SORT_TYPE_POPULAR}'>selected</c:if> value="<c:out value="${FrontWebConstants.SORT_TYPE_POPULAR}" />">인기순</option>
						<option value="<c:out value="${FrontWebConstants.SORT_TYPE_NEW}" />" <c:if test='${so.sortType eq FrontWebConstants.SORT_TYPE_NEW}'>selected</c:if> value="<c:out value="${FrontWebConstants.SORT_TYPE_NEW}" />">신상품순</option>
						<option value="<c:out value="${FrontWebConstants.SORT_TYPE_PRICE_HIGH}" />" <c:if test='${so.sortType eq FrontWebConstants.SORT_TYPE_PRICE_HIGH}'>selected</c:if>  value="<c:out value="${FrontWebConstants.SORT_TYPE_PRICE_HIGH}" />">높은가격순</option>
						<option value="<c:out value="${FrontWebConstants.SORT_TYPE_PRICE_LOW}" />" <c:if test='${so.sortType eq FrontWebConstants.SORT_TYPE_PRICE_LOW}'>selected</c:if>  value="<c:out value="${FrontWebConstants.SORT_TYPE_PRICE_LOW}" />">낮은가격순</option>
						<option value="<c:out value="${FrontWebConstants.SORT_TYPE_REVIEW}" />" <c:if test='${so.sortType eq FrontWebConstants.SORT_TYPE_REVIEW}'>selected</c:if>  value="<c:out value="${FrontWebConstants.SORT_TYPE_REVIEW}" />">상품리뷰순</option>
					</select>
				</div>
			</div>
			</form>
		</div>

		<ul class="group_pro_list">
			<c:if test="${not empty list}">
			<c:forEach items="${list}" var="o" varStatus="idx">
			<li class="group_pro<c:if test="${so.goodsId ne null and so.goodsId eq o.goodsId}"> select</c:if><c:if test="${o.groupEndYn eq 'Y'}"> end</c:if>">
				<!-- pro_wrap -->
				<div class="pro_wrap">
					<!-- pro_top -->
					<div class="pro_top">
						<c:if test="${o.groupEndYn eq 'N'}">
						<span class="status"><em>진행중</em></span>
						<span class="hour" id="item_${o.goodsId}"><frame:timestamp date="${o.saleEndDtm}" dType="S" tType="HS" /></span>
						</c:if>
						<c:if test="${o.groupEndYn eq 'Y'}">
						<span class="status"><em>종료</em></span>
						<span class="hour">0일 00:00:00</span>
						</c:if>
					</div><!-- //pro_top -->
					<!-- pro_img -->
					<div class="pro_img over_link">
						<frame:goodsImage imgPath="${o.imgPath}" seq="${o.imgSeq}" goodsId="${o.goodsId}" size="${ImageGoodsSize.SIZE_50.size}" alt="${o.goodsNm}"/>
						
						<c:if test="${o.groupEndYn eq 'Y'}">
						<div class="group_soldout"><span>SOLD OUT</span></div>
						</c:if>
						<!-- link_group -->
						<div class="link_group">
							<div class="btn_area">
								<a href="/goods/indexGoodsDetail?goodsId=${o.goodsId}" class="btn_cover_move" title="상품 새창보기" target="_blank"><span>상품 새창보기</span></a>
								<a href="#" class="btn_cover_fav <c:if test='${o.interestYn eq "Y"}' >click</c:if>" title="위시리스트 추가" onclick="insertWish(this,'${o.goodsId}');return false;"><span>위시리스트</span></a>
							</div>
							<div class="mask_link" onclick="location.href='/goods/indexGoodsDetail?goodsId=${o.goodsId}'"></div>
						</div><!-- //link_group -->
					</div><!-- //pro_img -->
					<!-- pro_info -->
					<div class="pro_info">
						<a href="#"><span class="pro_name">${o.goodsNm}</span></a>
						<!-- sale_info_wrap -->
						<div class="sale_info_wrap">
							<span class="discount_basis"><em><frame:num data="${o.minOrdQty}" /></em>개 구매하면 이 가격</span>
							<span class="price_info">
								<del><frame:num data="${o.orgSaleAmt}" />원</del>
								<span class="now_parice"><em><frame:num data="${o.saleAmt}" /></em>원</span>
							</span>
							<fmt:formatNumber value="${(o.orgSaleAmt-o.saleAmt) / o.orgSaleAmt}" var="disRate" pattern=".##" />
							<span class="sale_num"><em><fmt:formatNumber value="${disRate*100}" /></em></span>
						</div><!-- //sale_info_wrap -->
					</div><!-- //pro_info -->
					<!-- purchase_graph -->
					<div class="purchase_graph">
						<fmt:formatNumber value="${(o.strtOrdQty+o.salesQty) / o.trgtQty}" var="buyRate" pattern=".##" />
						<fmt:formatNumber value="${buyRate*100}" var="buyRate" />
						<c:if test="${o.groupEndYn eq 'N'}">
						
						<span class="comment"><em>
						<c:choose>
						<c:when test="${buyRate <= 10}">드루와!</c:when>
						<c:when test="${buyRate <= 50}">안사면 손해!</c:when>
						<c:when test="${buyRate <= 80}">핫해! 핫해!</c:when>
						<c:when test="${buyRate <= 99}">서둘러요!</c:when>
						<c:otherwise>인기폭발!</c:otherwise>
						</c:choose>
						
						</em></span>
						<div class="graph">
							<span class="bar" style="width:${buyRate}%"></span>
							<span class="purchase_num"><em><frame:num data="${o.strtOrdQty+o.salesQty}" /></em>개</span>
						</div>
						</c:if>
						
						<c:if test="${o.groupEndYn eq 'Y'}">
						<span class="comment"><em>커밍순</em></span>
						<div class="graph">
							<span class="bar" style="width:100%"></span>
							<span class="purchase_num"><em>판매완료</span>
						</div>
						</c:if>
					</div><!-- //purchase_graph -->
				</div><!-- //pro_wrap -->
			</li>
			</c:forEach>
			</c:if>
		</ul>
	</div><!-- //group_list_wrap -->
	
	<!-- 페이징 -->
	<frame:listPage recordPerPage="${so.rows}" currentPage="${so.page}" totalRecord="${so.totalCount}" indexPerPage="10" id="list_page" />
	<!-- 페이징 -->
	
</div><!-- //main_box -->


