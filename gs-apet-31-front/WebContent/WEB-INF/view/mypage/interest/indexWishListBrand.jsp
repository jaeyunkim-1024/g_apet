<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<script type="text/javascript">

	$(document).ready(function(){
		
		// 페이지 클릭 이벤트
		$("#wish_list_brand a").click(function(){
			var page = $(this).children("span").html();
			$("#wish_list_search_page").val(page);
			reloadWishListBrand();
			return false;
		});
		
		//전체선택 체크박스 이벤트
		$("#wish_check_box_all").click(function(){
			$(".wish_check_box").prop("checked", $(this).prop("checked"));
		});

	}); // End Ready

	$(function() {

	});
	
	/*
	 * 위시리스트 화면 리로딩
	 */
	function reloadWishListBrand(){
		$("#wish_list_form").attr("target", "_self");
		$("#wish_list_form").attr("action", "/mypage/interest/indexWishListBrand");
		$("#wish_list_form").submit();
	}
	
	/*
	 * 선택 브랜드 삭제
	 */
	function deleteWishBrands(){
		var checkWishBrands = $("input:checkbox[name=bndNos]:checked");
		
		if(checkWishBrands.length == 0){
			alert("<spring:message code='front.web.view.mypage.interest.no_select' />");
			return;
		}
		
		if(confirm("<spring:message code='front.web.view.mypage.interest.confirm.delete' />")){
			var options = {
				url : "<spring:url value='/mypage/interest/deleteWishBrands' />",
				data : $("#wish_list_form").serialize(),
				done : function(data){
					alert("<spring:message code='front.web.view.mypage.interest.delete.success' />");
					if($("input:checkbox[name=bndNos]:checked").length == $("input:checkbox[name=bndNos]").length){
						location.href ="/mypage/interest/indexWishListBrand";
					}else{
						location.reload();
					}
				}
			};
			ajax.call(options);
		}
	}
	
</script>

<div class="box_title_area">
	<h3>위시리스트</h3>
</div>

<!-- 탭 -->
<div class="tab_menu01 length4 mgt20">
	<ul>
		<li><a href="/mypage/interest/indexWishList">상품</a></li>
		<li class="on"><a href="/mypage/interest/indexWishListBrand">브랜드</a></li>
	</ul>
</div>
<!-- //탭 -->

<div class="box_area mgb15 mgt10">
	<div class="btn_area">
		<a href="#" class="btn_h25_type2" onclick="deleteWishBrands(); return false;">선택삭제</a>
	</div>
</div>

<!-- 위시 브랜드 리스트 -->
<form id="wish_list_form">
	<input type="hidden" id="wish_list_search_page" name="page" value="<c:out value="${so.page}" />" />
	<input type="hidden" id="wish_list_totalCnt" value="${so.totalCount }" />

	<table class="table_cartlist1">
		<caption>위시리스트내역_브랜드</caption>
		<colgroup>
			<col style="width:10px">	
			<!--<col style="width:70px">-->
			<col style="width:auto">
		</colgroup>
		<thead>
			<tr>
				<th scope="col"><input type="checkbox" id="wish_check_box_all" class="checkbox" title="전체선택">
				<th scope="col">브랜드정보</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${wishListBrand eq '[]'}">
			<tr>
				<td colspan="2">위시리스트가 없습니다.</td>
			</tr>
			</c:if>
			<c:if test="${wishListBrand ne '[]'}">
			<c:forEach items="${wishListBrand}" var="wish">
			<tr>
				<td>
					<input type="checkbox" class="checkbox wish_check_box" title="선택" name="bndNos" value="<c:out value="${wish.bndNo}"/>"/>
				</td>
				<!--<td class="img_cell_wide v_top">
					<a href="/brand/indexBrandDetail?bndNo=<c:out value="${wish.bndNo}" />" ><img src="${view.imgDomain }/${wish.bndItrdcImgPath}" alt="${wish.bndNm}" /></a>
				</td>-->
				<td class="align_left">
					<div class="product_name">
						<a href="/brand/indexBrandDetail?bndNo=<c:out value="${wish.bndNo}" /> "><c:out value="${wish.bndNm}" /></a> 
					</div>
				</td>
			</tr>
			</c:forEach>			
			</c:if>
		</tbody>
	</table>
</form>
<!-- // 위시 브랜드 리스트 -->

<frame:listPage recordPerPage="${so.rows}" currentPage="${so.page}" totalRecord="${so.totalCount}" indexPerPage="10" id="wish_list_brand" />
