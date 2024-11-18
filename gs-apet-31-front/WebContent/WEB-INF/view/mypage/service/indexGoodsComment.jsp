<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %> 
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<script type="text/javascript">

	$(document).ready(function(){
	
		// 페이지 클릭 이벤트
		$("#goods_comment_list_page a").click(function(){
			var page =$(this).children("span").html();
			$("#goods_comment_list_search_page").val(page);
			loadGoodsComment();
			return false;
		});
		
	}); // End Ready

	/*
	 * 작성가능한 상품평 화면 재조회
	 */
	function loadGoodsComment(){
		$("#goods_comment_list_form").attr("target", "_self");
		$("#goods_comment_list_form").attr("action", "/mypage/service/indexGoodsComment");
		$("#goods_comment_list_form").submit();
	}
	
	/*
	 * 상품평 등록 팝업 호출
	 */
	function openPopGoodsCommentReg(sGoodsId, sOrdNo , sOrdDtlSeq){
		var options = {
			url : "/mypage/service/popupGoodsCommentReg",
			params : {goodsId : sGoodsId, goodsEstmNo : '', ordNo : sOrdNo, ordDtlSeq : sOrdDtlSeq},
			width : 580,
			height: 598,
			callBackFnc : "cbGoodsCommentReg",
			modal : true
		};
		pop.open("popupGoodsCommentReg", options);	
	}
	
	/*
	 * 상품평 등록 CallBack
	 */
	function cbGoodsCommentReg(data){
		$("#goods_comment_list_search_page").val("1");
		loadGoodsComment();
	}
	
	/*
	 * 주문상세 페이지 이동
	 */
	function goOrderDetail(ordNo){
		var inputs = "<input type=\"hidden\" name=\"ordNo\" value=\""+ordNo+"\"/>";
		jQuery("<form action=\"/mypage/order/indexDeliveryDetailMem\" method=\"get\">"+inputs+"</form>").appendTo('body').submit();
	}



</script>

<div class="box_title_area">
	<h3>상품 리뷰 관리</h3>
	<div class="sub_text2">구매하신 상품 리뷰를 등록/조회하실 수 있습니다.</div>
</div>

<!-- 탭 -->
<div class="tab_menu01 length5s mgt10">
	<ul>
		<li class="on"><a href="/mypage/service/indexGoodsComment">리뷰 작성</a></li>
		<li><a href="/mypage/service/indexGoodsCommentList">리뷰 수정/보기</a></li>
	</ul>
</div>

<div class="mgl20 mgt20">등록 가능 한 상품리뷰가 <strong class="point2">${paging.totalRecord}</strong>건 있습니다.</div>
<!-- 주문내역 -->
<table class="table_cartlist1 mgt15">
	<caption>주문내역</caption>
	<colgroup>
		<col style="width:20%">
		<col style="width:70px">
		<col style="width:auto">
		<col style="width:20%">
	</colgroup>
	<thead>
		<tr>
			<th scope="col">주문정보</th>
			<th scope="col" colspan="3">상품정보</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${commentList eq '[]'}">
		<tr>
			<td colspan="4">상품리뷰 등록 가능한 주문내역이 없습니다.</td>
		</tr>
		</c:if>
		<c:if test="${commentList ne '[]'}">
		<c:forEach items="${commentList}" var="goods">
		<tr>
			<td><a href="#" onclick="goOrderDetail('${goods.ordNo}');return false;" class="order_number"><c:out value="${goods.ordNo}" /></a></td>
			<td class="img_cell v_top">
				<a href="/goods/indexGoodsDetail?goodsId=<c:out value="${goods.goodsId }"/>" >
					<frame:goodsImage goodsId="${goods.goodsId}" seq="${goods.imgSeq}" imgPath="${goods.imgPath}" size="${ImageGoodsSize.SIZE_70.size}" />
				</a>
			</td>
			<td class="align_left v_top">
				<div class="product_name">
					<a href="/goods/indexGoodsDetail?goodsId=<c:out value="${goods.goodsId }"/>" >
						[${goods.bndNmKo}] <c:out value="${goods.goodsNm}" />
					</a>
					<div class="product_option">
						<span><c:out value="${goods.itemNm}" /></span>
					</div>	
					<div class="product_cost">
						<frame:num data="${goods.saleAmt}" />원 / ${goods.ordQty}개
					</div>
				</div>
			</td>
			<td>
				<a href="#" onclick="openPopGoodsCommentReg('${goods.goodsId}','${goods.ordNo}','${goods.ordDtlSeq}');return false;" class="btn_h20_type5">리뷰 작성</a>
			</td>
		</tr>
		
		</c:forEach>
		</c:if>
	</tbody>
</table>

<!-- 페이징 -->
<form id="goods_comment_list_form">
<input type="hidden" id="goods_comment_list_search_page" name="page" value="<c:out value="${paging.page}" />" />
<frame:listPage recordPerPage="${paging.rows}" currentPage="${paging.page}" totalRecord="${paging.totalRecord}" indexPerPage="10" id="goods_comment_list_page" />
</form>
<!-- 페이징 -->