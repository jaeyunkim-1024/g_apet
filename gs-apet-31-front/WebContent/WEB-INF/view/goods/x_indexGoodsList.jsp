<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<script type="text/javascript">
var history_data = new Object();

	$(document).ready(function(){
		// 페이지 클릭 이벤트
		$("#goods_list_page a").click(function(){
			var page =$(this).children("span").html();
			$("#goods_list_search_page").val(page);
			reloadGoodsList();
			return false;
		});
		
		$("#goods_list_rows").change(function(){
			$("#goods_list_search_page").val("1");
			reloadGoodsList();
		});
		
		if($('.img_hover_view').is(':visible')){
			$('.img_hover_view').mouseenter(function(){
				if($(this).find('img').length>1){
					$(this).find('img').eq(0).hide();
				}
			});
			$('.img_hover_view').mouseleave(function(){
				if($(this).find('img').length>1){
					$(this).find('img').eq(0).show();
				}
			});
			
		}
		
		var ctgGb = $("#goods_list_ctg_gb").val();
		
		if (ctgGb != "PREMIUM" && ctgGb != "BEST") {
			var url = "";
			if (document.location.hash)
				url = document.URL.split('#')[0];
			else
				url = document.URL;
			
			history_data.page = $("#goods_list_search_page").val();
			history_data.ctgGb = ctgGb;
			history_data.bndNo = $("#goods_list_bnd_no").val();
			history_data.compNo = $("#goods_list_comp_no").val();
			history_data.dealYn = '${so.dealYn}';
			history_data.groupYn = '${so.groupYn}';
			history_data.freeDlvrYn = '${so.freeDlvrYn}';
			history_data.couponYn = '${so.couponYn}';
			history_data.sortType = '${so.sortType}';
			history_data.rows = '${so.rows}';
			history_data.dispClsfNo = '${so.dispClsfNo}';
			
			var pos = $("#list_pos").val();
			if (pos != "" && pos > 0) { 
				$('html, body').animate({scrollTop : pos}, 500);
			}
			history.replaceState(history_data, null, url + "#page=" + history_data.page);
		}
	}); // End Ready

	function currentScrollY() {
		var de = document.documentElement;
		var b = document.body;
		var now = {};
		now.X = document.all ? (!de.scrollLeft ? b.scrollLeft : de.scrollLeft) : (window.pageXOffset ? window.pageXOffset : window.scrollX);
		now.Y = document.all ? (!de.scrollTop ? b.scrollTop : de.scrollTop) : (window.pageYOffset ? window.pageYOffset : window.scrollY);
	
		return now.Y;
	
	}
	
	/*
	 * 상품 목록 재조회
	 */
	function reloadGoodsList(){
		$("#list_pos").val(0);
		
		ajax.load("<c:out value='${targetId}' />", "/goods/indexGoodsList", $("#goods_list_form").serializeJson());
		$('html,body').animate({scrollTop : $('#${targetId}').offset().top-150}, 500);
	}

	function goDetail(goodsId) {
		history_data.pos = currentScrollY();
		history.replaceState(history_data, null, document.URL);
		
		location.href = "/goods/indexGoodsDetail?goodsId=" + goodsId;
	}
	
	// 정렬순서 설정
	function setGoodsListSidx(sortType){
		$("#goods_list_sort_type").val(sortType);
		$("#goods_list_search_page").val("1");
		reloadGoodsList();
	}
	 
	$(':checkbox').change(function () {
		$("#goods_list_search_page").val("1");
		$(this).val($(this).is(':checked')?"Y":"N");
		reloadGoodsList();
	});
	
	$('select[name=sortType]').change(function () {
		$("#goods_list_search_page").val("1");
		reloadGoodsList();
	});
	$('select[name=rows]').change(function () {
		$("#goods_list_search_page").val("1");
		reloadGoodsList();
	});
</script>

<div class="main_box mgt30">

<form id="goods_list_form">
	<input type="hidden" id="goods_list_target_id" name="targetId" value="<c:out value='${targetId}' />" />
	<input type="hidden" id="goods_list_search_page" name="page" value="<c:out value='${so.page}' />" />
	<input type="hidden" id="goods_list_ctg_gb" name="ctgGb" value="<c:out value='${so.ctgGb}' />" />
	<input type="hidden" id="goods_list_bnd_no" name="bndNo" value="<c:out value='${so.bndNo}' />" />
	<input type="hidden" id="goods_list_comp_no" name="compNo" value="<c:out value='${so.compNo}' />" />
	<input type="hidden" id="goods_list_dispClsfNo_no" name="dispClsfNo" value="<c:out value='${so.dispClsfNo}' />" />
	<input type="hidden" id="goods_list_totalCnt" value="<c:out value='${so.totalCount}' />" />
	<input type="hidden" id="list_pos" name="pos" value="<c:out value='${pos}' />" />

<c:if test="${so.ctgGb ne 'BEST' and so.ctgGb ne 'PREMIUM'}">
	<div class="main_box_top">
		<div class="sort_list_count"><span class="num"><c:out value="${so.totalCount}" /></span>개의 상품이 있습니다.</div>
		<div class="search_sort">
			<ul class="sort_condition">
				<li><input type="checkbox" id="aa" name="groupYn" <c:if test='${so.groupYn eq "Y"}'>checked</c:if> value="Y"><label for="aa">공동구매</label></li>
				<li><input type="checkbox" id="bb" name="freeDlvrYn" <c:if test='${so.freeDlvrYn eq "Y"}'>checked</c:if> value="Y"><label for="bb">무료배송</label></li>
				<li><input type="checkbox" id="cc" name="couponYn" <c:if test='${so.couponYn eq "Y"}'>checked</c:if> value="Y"><label for="cc">쿠폰</label></li>
			</ul>
			
			<div class="sort_select">
				<select id="sort_standard" name="sortType" class="select2" style="width:120px">
					<option value="<c:out value="${FrontWebConstants.SORT_TYPE_POPULAR}" />" <c:if test='${so.sortType eq FrontWebConstants.SORT_TYPE_POPULAR}'>selected</c:if> value="<c:out value="${FrontWebConstants.SORT_TYPE_POPULAR}" />">인기순</option>
					<option value="<c:out value="${FrontWebConstants.SORT_TYPE_NEW}" />" <c:if test='${so.sortType eq FrontWebConstants.SORT_TYPE_NEW}'>selected</c:if> value="<c:out value="${FrontWebConstants.SORT_TYPE_NEW}" />">신상품순</option>
					<option value="<c:out value="${FrontWebConstants.SORT_TYPE_PRICE_HIGH}" />" <c:if test='${so.sortType eq FrontWebConstants.SORT_TYPE_PRICE_HIGH}'>selected</c:if>  value="<c:out value="${FrontWebConstants.SORT_TYPE_PRICE_HIGH}" />">높은가격순</option>
					<option value="<c:out value="${FrontWebConstants.SORT_TYPE_PRICE_LOW}" />" <c:if test='${so.sortType eq FrontWebConstants.SORT_TYPE_PRICE_LOW}'>selected</c:if>  value="<c:out value="${FrontWebConstants.SORT_TYPE_PRICE_LOW}" />">낮은가격순</option>
					<option value="<c:out value="${FrontWebConstants.SORT_TYPE_REVIEW}" />" <c:if test='${so.sortType eq FrontWebConstants.SORT_TYPE_REVIEW}'>selected</c:if>  value="<c:out value="${FrontWebConstants.SORT_TYPE_REVIEW}" />">상품리뷰순</option>
				</select>
				<select id="goods_list_rows" name="rows" class="select2" style="width:50px">
					<option value="20" <c:if test='${so.rows eq 20}'>selected</c:if>>20</option>
					<option value="40" <c:if test='${so.rows eq 40}'>selected</c:if>>40</option>
					<option value="60" <c:if test='${so.rows eq 60}'>selected</c:if>>60</option>
					<option value="80" <c:if test='${so.rows eq 80}'>selected</c:if>>80</option>
				</select>	
			</div>
		</div>
	</div>
</c:if>
</form>

<c:choose>
<c:when test="${goodsList ne '[]'}">
	<div class="list_col5">
		<ul>
			<c:forEach items="${goodsList }" var="o" varStatus="status">
			<li class="item">
				<c:if test="${so.ctgGb eq 'BEST'}">
				<div class="lank_sec"><span <c:if test='${status.index < 5}'>class="hot"</c:if>><em>BEST</em> ${status.index+1}</span></div>
				</c:if>
				<c:if test="${o.groupYn eq 'Y'}">
				<div class="group_ico">공동구매 상품</div>
				</c:if>
				<%-- <c:if test="${o.dealYn eq 'Y'}">
				<div class="deal_ico">딜 상품</div>
				</c:if> --%>
				<div class="img_sec over_link">
					<c:if test="${o.soldOutYn eq 'Y' }">
					<div class="sold_out"><span>SOLD OUT</span></div>
					</c:if>
					<a href="javascript:goDetail('${o.goodsId}')">
						<frame:goodsImage imgPath="${o.imgPath}" goodsId="${o.goodsId}" seq="${o.imgSeq}" size="${ImageGoodsSize.SIZE_60.size}" alt="${o.goodsNm}"/>
					</a>
					<c:if test="${o.groupEndYn eq 'Y'}">
					<div class="group_soldout"><span>SOLD OUT</span></div>
					</c:if>
					<div class="link_group">
						<div class="btn_area">
							<a href="/goods/indexGoodsDetail?goodsId=${o.goodsId}" class="btn_cover_move" title="상품 새창보기" target="_blank"><span>상품 새창보기</span></a>
							<a href="#" class="btn_cover_fav <c:if test='${o.interestYn eq "Y"}' >click</c:if>" title="위시리스트 추가" onclick="insertWish(this,'${o.goodsId}');return false;"><span>위시리스트 추가</span></a>
						</div>
						<div class="mask_link" onclick="javascript:goDetail('${o.goodsId}')"></div>
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
					<c:if test="${so.ctgGb ne 'BRAND'}"><li class="u_brand">${o.bndNm}</li></c:if>
					<c:if test="${so.ctgGb eq 'BRAND'}"><li class="u_brand">${o.compNm}</li></c:if>
					<li class="u_name"><a href="javascript:goDetail('${o.goodsId}')">${o.goodsNm}</a> </li>
					<li class="u_cost">
					<c:choose>
						<c:when test="${o.dealYn == 'Y' or o.groupYn == 'Y'}">
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
			</c:forEach>
		</ul>
	</div>
	<c:if test='${(so.ctgGb ne "PREMIUM") and (so.ctgGb ne "BEST")}'>
	<!-- 페이징 -->
	<frame:listPage recordPerPage="${so.rows}" currentPage="${so.page}" totalRecord="${so.totalCount}" indexPerPage="10" id="goods_list_page" />
	<!-- 페이징 -->
	</c:if>
	
	</c:when>
	<c:otherwise>
	<div style="padding:54px 0px; text-align:center; color:#666666;">
		<div class="nodata">
			해당하는 상품이 없습니다.
		</div>
	</div>
	</c:otherwise>
	</c:choose>
</div>