<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>


<script type="text/javascript">

	$(document).ready(function(){
		
		//전체선택 체크박스 이벤트
		$("#wish_check_box_all").click(function(){
			$(".wish_check_box").prop("checked", $(this).prop("checked"));
		});
		
		//로드시 셀렉트 박스 선택
		$("#option_first").val('<c:out value="${so.dispClsfNo}" />').attr('selected','selected');
		$("#option_second").val('<c:out value="${so.sidx}" />').attr('selected','selected');
		if($("#wish_list_search_sord").val() == 'ASC'){
 			$("#option_second option:last").attr('selected','selected');
		}

	}); // End Ready

	$(function() {
		
		// 페이지 클릭 이벤트
		$("#wish_list_page a").click(function(){
			var page = $(this).children("span").html();
			$("#wish_list_search_page").val(page);
			reloadWishList();
			
			return false;
		});

	});
	
	/*
	 * 위시리스트 화면 리로딩
	 */
	function reloadWishList(){
		$("#wish_list_form").attr("target", "_self");
		$("#wish_list_form").attr("action", "/mypage/interest/indexWishList");
		$("#wish_list_form").submit();
	}
	
	/*
	 * 선택 상품 삭제
	 */
	function deleteWish(){
		var checkWish = $("input:checkbox[name=goodsIds]:checked");
		
		if(checkWish.length == 0){
			alert("<spring:message code='front.web.view.order.cart.msg.no_select' />");
			return;
		}
		
		if(confirm("<spring:message code='front.web.view.order.cart.confirm.delete' />")){
			var options = {
				url : "<spring:url value='/mypage/interest/deleteWish' />",
				data : $("#wish_list_form").serialize(),
				done : function(data){
					alert("<spring:message code='front.web.view.order.cart.delete.success' />");
					if($("input:checkbox[name=goodsIds]:checked").length == $("input:checkbox[name=goodsIds]").length){
						location.href ="/mypage/interest/indexWishList";
					}else{
						location.reload();
					}
				}
			};
			ajax.call(options);
		}
	}
	
	/*
	 * 검색 조건 선택
	 */
	function searchOption(){
		$('#wish_list_search_page').attr('value','1');
		$('#wish_list_search_option_first').attr('value',$('#option_first option:selected').val());
		$('#wish_list_search_option_second').attr('value',$('#option_second option:selected').val());
		if($('#wish_list_search_option_second').val() == 'SALE_AMT_ASC'){
			$('#wish_list_search_option_second').attr('value','SALE_AMT');
			$('#wish_list_search_sord').attr('value','ASC');
		}else{
			$('#wish_list_search_sord').attr('value','DESC');
		}
		reloadWishList();
		
		return false;
	}
	
	/*
	 * 품절상품 제외 보기
	 */
	function removeGoodsSoldOut(){
		var soldOutObjs = $(".goods_sold_out_yn");
		
		if(soldOutObjs.length > 0){
			for(var i=0; i <soldOutObjs.length; i++){
				if($(soldOutObjs[i]).val() == "Y"){
					$(soldOutObjs[i]).parent().parent().remove();
				}
			}
		}
	}
	
</script>

<div class="box_title_area">
	<h3>위시리스트</h3>
</div>

<!-- 탭 -->
<div class="tab_menu01 length4 mgt20">
	<ul>
		<li class="on"><a href="/mypage/interest/indexWishList">상품</a></li>
		<li><a href="/mypage/interest/indexWishListBrand">브랜드</a></li>
	</ul>
</div>
<!-- //탭 -->

<div class="box_area mgb15 mgt10">
	<div class="select_area">
		<select title="카테고리 목록" style="width:110px;" class="h25 lh25" id="option_second" onchange="searchOption();">
			<option value="SYS_REG_DTM">최근 담은순</option>
			<option value="SALE_STRT_DTM">신상품</option>
			<option value="SALE_AMT">높은 가격 순</option>
			<option value="SALE_AMT_ASC">낮은 가격 순</option>
		</select>
		<a href="#" class="btn_h25_type2 mgl10" onclick="removeGoodsSoldOut();return;">품절상품 제외 보기</a>
	</div>
	<div class="btn_area">
		<a href="#" class="btn_h25_type2" onclick="deleteWish(); return false;">선택삭제</a>
	</div>
</div>

<!-- 상품리스트 -->
<form id="wish_list_form">
	<input type="hidden" id="wish_list_search_page" name="page" value="<c:out value="${so.page}" />" />
	<input type="hidden" id="wish_list_search_option_first" name="dispClsfNo" value="<c:out value="${so.dispClsfNo}" />" />
	<input type="hidden" id="wish_list_search_option_second" name="sidx" value="<c:out value="${so.sidx}" />" />
	<input type="hidden" id="wish_list_search_sord" name="sord" value="<c:out value="${so.sord}" />" />

	<table class="table_cartlist1">
		<caption>위시리스트내역</caption>
		<colgroup>
			<col style="width:10px">	
			<col style="width:70px">
			<col style="width:auto">
			<col style="width:18%">
			<col style="width:15%">
		</colgroup>
		<thead>
			<tr>
				<th scope="col"><input type="checkbox" id="wish_check_box_all" class="checkbox" title="전체선택">
				<th scope="col" colspan="2">상품정보</th>
				<th scope="col">판매가</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${wishList eq '[]'}">
			<tr>
				<td colspan="6">위시리스트가 없습니다.</td>
			</tr>
			</c:if>
			<c:if test="${wishList ne '[]'}">
			<c:forEach items="${wishList}" var="wish">
			<tr>
				<td>
					<input type="hidden" class="goods_sold_out_yn" value="${wish.goodsSoldoutYn}" />
					<input type="checkbox" class="checkbox wish_check_box" title="선택" name="goodsIds" value="<c:out value="${wish.goodsId}"/>"/>
				</td>
				<td class="img_cell v_top"><a href="/goods/indexGoodsDetail?goodsId=<c:out value="${wish.goodsId}" />&dispClsfNo=<c:out value="${wish.dispClsfNo}" />"><frame:goodsImage goodsId="${wish.goodsId}" seq="${wish.imgSeq}" imgPath="${wish.imgPath}" size="${ImageGoodsSize.SIZE_60.size}" /></a></td>
				<td class="align_left v_top">
					<div class="product_name">
						<a href="/goods/indexGoodsDetail?goodsId=<c:out value="${wish.goodsId}" />&dispClsfNo=<c:out value="${wish.dispClsfNo}" />">[<c:out value='${wish.bndNm}' />] <c:out value="${wish.goodsNm}" /></a> 
					</div>
				</td>
				<c:choose>
				<c:when test="${wish.goodsStatCd eq FrontWebConstants.GOODS_STAT_50 or wish.goodsStatCd eq FrontWebConstants.GOODS_STAT_60}">
				<td class="soldout">
					<frame:codeValue items="${goodsStatCdList}" dtlCd="${wish.goodsStatCd}" /> 된 상품입니다.
				</td>
				</c:when>
				<c:when test="${wish.soldOutYn eq FrontWebConstants.COMM_YN_Y}">
				<td class="soldout">
					품절된 상품입니다.
				</td>
				</c:when>
				<c:otherwise>
				<td>
					<div>
					<c:choose>
						<c:when test="${wish.dealYn == 'Y' or wish.groupYn == 'Y'}">
							<c:choose>
							<c:when test="${wish.dcAmt > 0}">
							<fmt:formatNumber value="${(wish.orgSaleAmt-wish.dcAmt) / wish.orgSaleAmt }" var="disRate" pattern=".##" />
							[<fmt:formatNumber value="${disRate }" type="percent" />]
							</c:when>
							<c:otherwise>
							<fmt:formatNumber value="${(wish.orgSaleAmt-wish.saleAmt) / wish.orgSaleAmt }" var="disRate" pattern=".##" />
							[<fmt:formatNumber value="${disRate }" type="percent" />]
							</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<c:if test="${wish.dcAmt > 0}">
							<fmt:formatNumber value="${(wish.saleAmt-wish.dcAmt) / wish.saleAmt }" var="disRate" pattern=".##" />
							[<fmt:formatNumber value="${disRate }" type="percent" />]
							</c:if>
						</c:otherwise>
					</c:choose>
					<frame:num data="${wish.foSaleAmt}" /> 원
					</div>		
				</td>
				</c:otherwise>
				</c:choose>
			</tr>
			</c:forEach>
			</c:if>
		</tbody>
	</table>
</form>
<!-- // 삼품리스트 -->

<!--  선택된 상품 영역 -->
<form id="wish_detail_form">
<input type="hidden" id="goods_id" name="goodsId" value="" />
<input type="hidden" name="nowBuyYn" value="N" />
</form>
<!--  선택된 상품 영역 -->

<frame:listPage recordPerPage="${so.rows}" currentPage="${so.page}" totalRecord="${so.totalCount}" indexPerPage="10" id="wish_list_page" />
