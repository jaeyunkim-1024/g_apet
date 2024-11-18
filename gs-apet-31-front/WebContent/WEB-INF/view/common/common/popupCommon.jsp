<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ page import="front.web.config.constants.FrontWebConstants" %>


<script type="text/javascript">
$(document).ready(function(){
});

</script>

<div id="pop_contents" class="pop_contents">
<c:choose>
	<c:when test="${popup.popupTpCd eq '20'}">
			<div class="pop_recommand_wrap">
				<div class="popup_recommand_copy">
					고객님! <br>이 <em>상품</em>은 어떠세요?
				</div>
				<!-- recommand_list_container -->
				<div class="recommand_list_container list_col4 swiper-container">
					<ul class="swiper-wrapper">
					<c:forEach items="${popup.goodsList}" var="goods" varStatus="status1">
						<li class="item swiper-slide">
							<div class="img_sec over_link">
								<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">
									<img src="<c:out value="${view.imgDomain}"/>${goods.imgPath }" alt="" onerror="this.src='<c:out value="${view.noImgPath}" />';" >
								</a>
							</div>
							<ul class="text_sec">
								<c:if test="${goods.prWdsShowYn eq FrontMobileConstants.COMM_YN_Y }">
								<li class="u_brand"><c:out value="${goods.prWds }" /></li>
								</c:if>
								<li class="u_brand">${goods.bndNm}</li>
								<li class="u_name"><a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}">${goods.goodsNm}</a> </li>
								<li class="u_cost">
									<c:choose>
										<c:when test="${not empty goods.dcAmt and goods.dcAmt > 0}">
											<fmt:formatNumber value="${(goods.saleAmt-goods.dcAmt) / goods.saleAmt }" var="disRate" pattern=".##" />
											<strong> [<fmt:formatNumber value="${disRate }" type="percent" />] <frame:num data="${goods.dcAmt }" /> 원</strong>
										</c:when>
										<c:otherwise>
											<frame:num data="${goods.saleAmt}" />원
										</c:otherwise>
									</c:choose>
								</li>
								<li class="u_util">
									<div class="flag"></div>
								</li>
							</ul>
						</li>
						</c:forEach>
					</ul>
					<div class="swiper-pagination"></div>
				</div><!-- //recommand_list_container -->
			</div><!-- //pop_recommand_wrap -->
			<div class="swiper-button-next"></div>
			<div class="swiper-button-prev swiper-button-disabled"></div>
	</c:when>
	<c:otherwise>
	<!-- popup_container -->
		<c:out value="${popup.content}" escapeXml ="false"/>
	</c:otherwise>
</c:choose>
	
</div>

<!-- 버튼 공간 -->
<div class="pop_btn_section">
	<a href="#" class="btn_pop_type2" onclick="dialog.close('<c:out value="${param.popId}" />');return false;">닫기</a>
	<a href="#" class="btn_pop_type1" onclick="todaycloseWin('<c:out value="${param.popId}" />');dialog.close('<c:out value="${param.popId}" />');return false;">오늘 하루 열지 않기</a>
</div>
<!-- //버튼 공간 -->

<script>
	var recommand_swiper = new Swiper('.recommand_list_container', {
		pagination: '.swiper-pagination',
		paginationClickable: true,
		nextButton: '.swiper-button-next',
		prevButton: '.swiper-button-prev',
		simulateTouch : false
	});
</script>