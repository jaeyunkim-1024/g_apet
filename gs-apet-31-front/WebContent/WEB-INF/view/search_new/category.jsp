<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %> 
<%@ page import="framework.common.constants.CommonConstants" %> 


테스트
<c:forEach var="list" items="${goodsList}" varStatus="index">
			<!-- prd_box -->
			<div class="prd_box">
				<a href="#" data-id="${list.goodsid}">
					<!-- prd_photo -->
					<div class="prd_photo">
						<img src="http://img.tobemallx.com${list.imgpath}" alt="">
						<c:if test="${list.soldoutyn eq 'Y'}">
							<div class="soldOut"><span class="txt">SOLD OUT</span></div>
						</c:if>
					</div><!-- //prd_photo -->
					<ul class="prd_list">
						<li class="prodTag">						
						<c:if test="${list.prmtdcamt eq 'Y'}">
						<span class="tag hot">HOT</span>
						</c:if>						
						<c:if test="${list.newyn eq 'Y'}">
						<span class="tag">NEW</span>
						</c:if>						
						<c:if test="${list.couponyn eq 'Y'}">
						<span class="tag">쿠폰</span>
						</c:if>						
						<c:if test="${list.freedlvryn eq 'Y'}">
						<span class="tag">무료배송</span>
						</c:if>						
						<c:if test="${list.bestyn eq 'Y'}">
						<span class="tag">BEST</span></li>
						</c:if>
						<li class="brand">${list.bndnmko}</li>
						<li class="title">${list.goodsnm}</li>
						<li class="price"><span class="price_no"><fmt:formatNumber value="${list.prmtdcamt}" /></span></li>
					</ul>
				</a>
			    <!--  <button class="wish_btn"><span>좋아요</span></button> -->
			</div><!-- //prd_box -->
		</c:forEach>