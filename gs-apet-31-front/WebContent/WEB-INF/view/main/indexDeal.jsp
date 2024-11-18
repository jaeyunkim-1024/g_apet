<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<%@ page import="framework.common.constants.CommonConstants" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<%--
  Class Name  : indexShowRoom.jsp 
  Description : HotDeal
  Author   	  : 정호균
  Since       : 2017.03.17
  Modification Information 
	          수정일         	     수정자             수정내용
    ----------  -------  -------------------------------------------
    2017.03.17    오상민           최초 작성
--%>

<script type="text/javascript">
	
$(document).ready(function(){
	
	// 페이지 클릭 이벤트
	$("#deal_list_page a").click(function(){
		var page =$(this).children("span").html();
		$("#deal_list_search_page").val(page);
		reloadDealList();
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

/*
 * 딜 리스트 페이징 조회
 */
function reloadDealList() {
	$("#deal_list_form").attr("target", "_self");
//	$("#deal_list_form").attr("action", "/showroom/indexShowRoom");
	$("#deal_list_form").attr("action", "/main/indexDeal");
	$("#deal_list_form").submit();
}

</script>

<form id="deal_list_form">
<input type="hidden" id="deal_list_search_page" name="page" value="<c:out value='${so.page }' />" />
<input type="hidden" id="goods_list_rows" name="rows" value="${so.rows }" />
<input type="hidden" id="goods_list_totalCnt" value="${so.totalCount }" />
</form>

<h2 class="newTitle">DC 딜</h2>
<!-- Deal_list-- -->
<div class="main_box">
	<div class="list_col4">
		<ul>
		<c:if test="${empty dealList}">
			<div class="no_data">등록된 내용이 없습니다.</div>
		</c:if>
		<!-- Deal_list -->
		<c:if test="${not empty dealList}">
			<c:forEach items="${dealList}" var="deal" varStatus="idx">
				<li class="item">
					<div class="img_sec over_link">
						<c:if test="${deal.soldOutYn == 'Y' }">
						<div class=sold_out><span>SOLD OUT</span></div>
						</c:if>	
						<a href="/goods/indexGoodsDetail?goodsId=${deal.goodsId }&amp;dispClsfNo=">
							<frame:goodsImage imgPath="${deal.imgPath}" seq="${deal.imgSeq }" goodsId="${deal.goodsId }" size="${ImageGoodsSize.SIZE_50.size}" />
						</a>
						
						<div class="link_group">
							<div class="btn_area">
								<a href="/goods/indexGoodsDetail?goodsId=${deal.goodsId }&amp;dispClsfNo=" class="btn_cover_move" title="상품 새창보기" target="_blank"><span>상품 새창보기</span></a>
								<a href="#" onclick="insertWish(this, '${deal.goodsId }');return false;" class="btn_cover_fav <c:if test='${deal.interestYn eq "Y"}' >click</c:if>" title="위시리스트 추가"><span>위시리스트 추가</span></a>
							</div>
							<div class="mask_link" onclick="location.href='/goods/indexGoodsDetail?goodsId=${deal.goodsId}'"></div>
						</div>
					</div>
					
					<ul class="deal_sec">
						<li class="u_deal_ing">
                           <c:choose>
                               <c:when test="${deal.goodsId eq 'G000049708'}">
                                   <span class="dealNum"><strong><frame:num data="${deal.salesQty+33}" /></strong>개 구매중</span>
                               </c:when>
                               <c:when test="${deal.goodsId eq 'G000048527'}">
                                   <span class="dealNum"><strong><frame:num data="${deal.salesQty+21}" /></strong>개 구매중</span>
                               </c:when>
                               <c:when test="${deal.goodsId eq 'G000048912'}">
                                   <span class="dealNum"><strong><frame:num data="${deal.salesQty+15}" /></strong>개 구매중</span>
                               </c:when>
                               <c:when test="${deal.goodsId eq 'G000049988'}">
                                   <span class="dealNum"><strong><frame:num data="${deal.salesQty+27}" /></strong>개 구매중</span>
                               </c:when>
                               <c:when test="${deal.goodsId eq 'G000048998'}">
                                   <span class="dealNum"><strong><frame:num data="${deal.salesQty+12}" /></strong>개 구매중</span>
                               </c:when>
                               <c:when test="${deal.goodsId eq 'G000033634'}">
                                   <span class="dealNum"><strong><frame:num data="${deal.salesQty+42}" /></strong>개 구매중</span>
                               </c:when>
                               <c:when test="${deal.goodsId eq 'G000010917'}">
                                   <span class="dealNum"><strong><frame:num data="${deal.salesQty+20}" /></strong>개 구매중</span>
                               </c:when>
                               <c:when test="${deal.goodsId eq 'G000051234'}">
                                   <span class="dealNum"><strong><frame:num data="${deal.salesQty+19}" /></strong>개 구매중</span>
                               </c:when>
                               <c:when test="${deal.goodsId eq 'G000050993'}">
                                   <span class="dealNum"><strong><frame:num data="${deal.salesQty+9}" /></strong>개 구매중</span>
                               </c:when>
                               <c:when test="${deal.goodsId eq 'G000050919'}">
                                   <span class="dealNum"><strong><frame:num data="${deal.salesQty+17}" /></strong>개 구매중</span>
                               </c:when>
                               <c:when test="${deal.goodsId eq 'G000051205'}">
                                   <span class="dealNum"><strong><frame:num data="${deal.salesQty+24}" /></strong>개 구매중</span>
                               </c:when>
                               <c:when test="${deal.goodsId eq 'G000051199'}">
                                   <span class="dealNum"><strong><frame:num data="${deal.salesQty+11}" /></strong>개 구매중</span>
                               </c:when>
                               <c:when test="${deal.goodsId eq 'G000050210'}">
                                   <span class="dealNum"><strong><frame:num data="${deal.salesQty+46}" /></strong>개 구매중</span>
                               </c:when>
                               <c:when test="${deal.goodsId eq 'G000049895'}">
                                   <span class="dealNum"><strong><frame:num data="${deal.salesQty+32}" /></strong>개 구매중</span>
                               </c:when>
                               <c:when test="${deal.goodsId eq 'G000020144'}">
                                   <span class="dealNum"><strong><frame:num data="${deal.salesQty+25}" /></strong>개 구매중</span>
                               </c:when>
                               <c:when test="${deal.goodsId eq 'G000049455'}">
                                   <span class="dealNum"><strong><frame:num data="${deal.salesQty+27}" /></strong>개 구매중</span>
                               </c:when>
                               <c:when test="${deal.goodsId eq 'G000050343'}">
                                   <span class="dealNum"><strong><frame:num data="${deal.salesQty+10}" /></strong>개 구매중</span>
                               </c:when>
                               <c:when test="${deal.goodsId eq 'G000049514'}">
                                   <span class="dealNum"><strong><frame:num data="${deal.salesQty+15}" /></strong>개 구매중</span>
                               </c:when>
                               <c:when test="${deal.goodsId eq 'G000051210'}">
                                   <span class="dealNum"><strong><frame:num data="${deal.salesQty+9}" /></strong>개 구매중</span>
                               </c:when>
                               <c:when test="${deal.goodsId eq 'G000015379'}">
                                   <span class="dealNum"><strong><frame:num data="${deal.salesQty+14}" /></strong>개 구매중</span>
                               </c:when>
                               <c:otherwise>
                                   <span class="dealNum"><strong><frame:num data="${deal.salesQty}" /></strong>개 구매중</span>
                               </c:otherwise>
                           </c:choose>
							<%-- <span class="dealNum"><strong><frame:num data="${deal.salesQty}" /></strong>개 구매중</span> --%>
							<span class="dealTime">남은시간 
								<strong><span id="item_${deal.goodsId }"><frame:timestamp date="${deal.saleEndDtm}" dType="S" tType="HS" /></span></strong>
							</span>
						</li>
						
						<li class="u_tag_cost">
						<c:choose>
							<c:when test="${deal.dcAmt > 0}">
							<fmt:formatNumber value="${(deal.orgSaleAmt-deal.dcAmt) / deal.orgSaleAmt }" var="disRate" pattern=".##" />
							<span class="tag"><strong><fmt:formatNumber value="${disRate*100}" /></strong>%</span>
							<span class="cost"><strong><frame:num data="${deal.dcAmt}" /></strong> 원</span>	
							</c:when>
							<c:otherwise>
							<fmt:formatNumber value="${(deal.orgSaleAmt-deal.saleAmt) / deal.orgSaleAmt }" var="disRate" pattern=".##" />
							<span class="tag"><strong><fmt:formatNumber value="${disRate*100}" /></strong>%</span>
							<span class="cost"><strong><frame:num data="${deal.saleAmt}" /></strong> 원</span>	
							</c:otherwise>
						</c:choose>
						</li>
						
						<li class="u_name">
							<a href="/goods/indexGoodsDetail?goodsId=${deal.goodsId }">${deal.goodsNm }</a>
						</li>
					</ul>
				</li>
			</c:forEach>
		</c:if><!-- //Deal_list -->
		</ul>
	</div>
	
	<!-- 페이징 -->
	<frame:listPage recordPerPage="${so.rows }" currentPage="${so.page }" totalRecord="${so.totalCount }" indexPerPage="10" id="deal_list_page" />
	<!-- 페이징 -->
			
</div>
