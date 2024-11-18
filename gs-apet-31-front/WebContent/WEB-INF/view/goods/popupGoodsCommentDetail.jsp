<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<script type="text/javascript">

	$(document).ready(function(){
	}); // End Ready

	$(function() {

	});



</script>
<div id="pop_contents">
	<c:if test="${param.goodsDisp eq 'Y'}">
	<div class="review_pro_area">
		<table class="table_review">
			<caption>상품 목록</caption>
			<colgroup>
				<col width="80px" />
				<col width="auto" />
				<col width="125px" />
				<col width="18%" />
			</colgroup>
			<tbody>
				<tr>
					<td class="imgcont"><frame:goodsImage imgPath="${goods.imgPath}" seq="${goods.imgSeq}" goodsId="${goods.goodsId}" size="${ImageGoodsSize.SIZE_70.size}"/></td>
					<td><a href="/goods/indexGoodsDetail?goodsId=<c:out value="${goods.goodsId }"/>">[<c:out value="${goods.bndNmKo}"/>]&nbsp;<c:out value="${goods.goodsNm}"/></a></td>
				</tr>
			</tbody>
		</table>
	</div>
	</c:if>
	<div class="pop_reivew_title">
		<div class="title">
			<c:if test="${goodsComment.rcomYn eq 'Y'}">
			<span class="btn_h20_type5">BEST</span>
			</c:if>
			<c:out value="${goodsComment.ttl}" />
		</div>
		<div class="pos_a">
			<span class="u_id"><frame:secret data="${goodsComment.estmId}" /></span>
			<span class="col">|</span>
			<span class="date"><frame:timestamp date="${goodsComment.sysRegDtm}" dType="H" /></span>
		</div>
	</div>
	<div class="pop_review_contents ">
	
		<div class="para">
			<frame:content data="${goodsComment.content}" />
		</div>
		<div class="img_section mgt20">
			<c:if test="${goodsComment.imgRegYn eq 'Y'}">
				<c:forEach items="${goodsComment.goodsCommentImageList}" var="goodsCommentImage">
				<img class="mgt10" src="<c:out value='${view.imgDomain}'/>/<c:out value='${goodsCommentImage.imgPath}' />" alt="" />
				</c:forEach>
			</c:if>
		</div>
	</div>
</div>
	<!-- pop_btn_section -->
	<c:if test="${goodsComment.estmMbrNo eq session.mbrNo}">
	<div class="pop_btn_section border_none">
		<a href="/mypage/service/indexGoodsCommentList" class="btn_pop_type1">수정</a>
	</div><!-- //pop_btn_section -->
	</c:if>