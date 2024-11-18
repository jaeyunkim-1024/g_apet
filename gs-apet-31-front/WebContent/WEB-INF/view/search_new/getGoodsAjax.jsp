<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="framework.common.constants.CommonConstants" %> 
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<!-- tab : search_list_tabBox -->
<div class="search_list_tabBox">
	<div class="search_sort">
		<ul class="sort_condition">
			<li class="searchBenefit" data-value="gonggu"><input type="checkbox"  id="aa" name="searchBenefitPC" data-type="benefit" data-value="gonggu" value="gonggu" <c:if test="${not empty searchVo.searchBenefitPC}"><c:forEach var="searchList" items="${searchVo.searchBenefitPC}" varStatus="status" ><c:if test="${searchList eq 'gonggu'}"> checked="checked" </c:if> </c:forEach> </c:if> ><label for="aa">공동구매</label></li>
			<li class="searchBenefit" data-value="free"><input type="checkbox" id="bb" name="searchBenefitPC" data-type="benefit" data-value="free" value="free" <c:if test="${not empty searchVo.searchBenefitPC}"><c:forEach var="searchList" items="${searchVo.searchBenefitPC}" varStatus="status" ><c:if test="${searchList eq 'free'}"> checked="checked" </c:if> </c:forEach> </c:if> ><label for="bb">무료배송</label></li>
			<li class="searchBenefit" data-value="coupon"><input type="checkbox" id="cc" name="searchBenefitPC" data-type="benefit" data-value="coupon" value="coupon" <c:if test="${not empty searchVo.searchBenefitPC}"><c:forEach var="searchList" items="${searchVo.searchBenefitPC}" varStatus="status" ><c:if test="${searchList eq 'coupon'}"> checked="checked" </c:if> </c:forEach> </c:if> ><label for="cc">쿠폰</label></li>
		</ul>
		<div class="search_price_wrap">
			<button type="button" class="price_btn">가격대</button>
			<div class="search_price_content" style="display:none;">
				<ul class="price_box">
					<c:forEach var="plist" items="${plist}" varStatus="status" >
						<li><button type="button" id="price_in_btn" class="price_in_btn <c:forEach var="list" items="${searchVo.buttonPrice}" varStatus="status"><c:if test="${list eq plist}">active</c:if></c:forEach>" value="${plist}">${plist}</button></li>
					</c:forEach>
				</ul>
				<div class="search_direct_box">
					<input type="checkbox" id="dd" <c:if test="${searchVo.searchStartPrice ne ''}">checked="checked"</c:if> /><label for="dd">직접입력</label>
					<!-- search_direct -->
					<span class="search_direct">
						<input type="text" id="searchStartPrice" class="price numOnly" onkeyup="prcAutoChk();" value="${searchVo.searchStartPrice}" placeholder="<fmt:formatNumber value="${searchVo.resultStartPrice}" />원">
						<span class="bar">~</span>
						<input type="text" id="searchEndPrice" class="price numOnly" onkeyup="prcAutoChk();" value="${searchVo.searchEndPrice}" placeholder="<fmt:formatNumber value="${searchVo.resultEndPrice}" />원">
					</span><!-- //search_direct -->								
					<a href="#" class="search_direct_btn">적용</a>														
				</div>
				<a id="prc_btn_cancle" href="">선택해제</a>
			</div>
		</div>
		<div class="sort_select">
			<select id="searchSort" name="searchSort" class="select2" style="width:120px;" onchange="sortChange(this.value);">
				<option value="best" <c:if test="${searchVo.searchSort eq 'best'}">selected="selected"</c:if>>인기순</option>
				<option value="date" <c:if test="${searchVo.searchSort eq 'date'}">selected="selected"</c:if>>최근등록순</option>
				<option value="highprice" <c:if test="${searchVo.searchSort eq 'highprice'}">selected="selected"</c:if>>높은가격순</option>
				<option value="lowprice" <c:if test="${searchVo.searchSort eq 'lowprice'}">selected="selected"</c:if>>낮은가격순</option>
				<option value="comment" <c:if test="${searchVo.searchSort eq 'comment'}">selected="selected"</c:if>>상품리뷰순</option>
			</select>
			<select id="searchDisplay" name="searchDisplay" class="select2" style="width:50px" onchange="pageChange(this.value);">
				<option value="20" <c:if test="${searchVo.searchDisplay eq '20'}">selected="selected"</c:if>>20</option>
				<option value="40" <c:if test="${searchVo.searchDisplay eq '40'}">selected="selected"</c:if>>40</option>
				<option value="60" <c:if test="${searchVo.searchDisplay eq '60'}">selected="selected"</c:if>>60</option>
				<option value="80" <c:if test="${searchVo.searchDisplay eq '80'}">selected="selected"</c:if>>80</option>
			</select>	
		</div>
	</div>
	<ul id="searchCategory" class="searchList">
		<li <c:if test="${searchVo.searchCategory eq ''}">class="active"</c:if>><a href="javascript:cateChange('');">전체<span>(<fmt:formatNumber value="${searchVo.tab_totalSize}" />)</span></a></li>
		<c:if test="${prmtCnt > 0}">
		<li <c:if test="${searchVo.searchCategory eq 'prmt'}">class="active"</c:if>><a href="javascript:cateChange('prmt');">프리미엄<span>(<fmt:formatNumber value="${prmtCnt	}" />)</span></a></li>
		</c:if>
	</ul>
</div>
<!--// tab : search_list_tabBox -->

<!-- tabCont :  searchListContainer  -->
<div class="searchListContainer">
	<div class="searchListContent">	
		<div class="list_col5">
			<c:choose>
			<c:when test="${searchVo.shop_totalSize >0}">
			<ul class="prd_area">
				<c:forEach var="list" items="${goodsList}" varStatus="index">
					<li class="item">
						<c:if test="${list.hotdeal eq 'Y'}">
						<div class="deal_ico">딜 상품</div>
						</c:if>
						<c:if test="${list.gonggu eq 'Y'}">
						<!-- 공동구매 상품일 때 -->
						<div class="group_ico">공동구매 상품</div>
						</c:if>
						<div class="img_sec over_link">
							<c:if test="${list.soldoutyn eq 'Y'}">
								<div class="sold_out"><span>SOLD OUT</span></div>
							</c:if>
							<a href="javascript:goShopView('${list.goodsid}');" class="img_hover_view">
								<frame:goodsImage imgPath="${list.imgpath}" goodsId="${list.goodsid}" seq="${list.imgseq}" size="${ImageGoodsSize.SIZE_50.size}" alt="${list.goodsnm}"/>
							</a>
							<c:if test="${list.bulkordendyn eq 'Y'}">
							<!-- 공동구매 강제종료되었을 때 -->
							<div class="group_soldout"><span>SOLD OUT</span></div>
							</c:if>
							<div class="link_group">
								<div class="btn_area">
									<a href="/goods/indexGoodsDetail?goodsId=${list.goodsid}" class="btn_cover_move" title="상품 새창보기" target="_blank"><span>상품 새창보기</span></a>
									<a href="#" class="btn_cover_fav" title="위시리스트 추가" onclick="insertWishS(this,'${list.goodsid}','<c:out value="${searchVo.searchQuery}" />');return false;"><span>위시리스트 추가</span></a>
								</div>
								<div class="mask_link" onclick="javascript:goShopView('${list.goodsid}');"></div>
							</div>
						</div>
						<ul class="text_sec">
							<li class="u_tag">
								<c:set var="tagCnt" value="0" />
								<%-- <c:if test="${list.prmtdcamt eq 'Y'}">
								<span class="tag hot">HOT</span>
								</c:if>	 --%>					
								<c:if test="${list.newyn eq 'Y'}">
								<span class="tag">NEW</span>
								<c:set var="tagCnt" value="${tagCnt+1}" />
								</c:if>						
								<c:if test="${list.couponyn eq 'Y'}">
								<span class="tag">쿠폰</span>
								<c:set var="tagCnt" value="${tagCnt+1}" />
								</c:if>						
								<c:if test="${list.freedlvryn eq 'Y'}">
								<span class="tag">무료배송</span>
								<c:set var="tagCnt" value="${tagCnt+1}" />
								</c:if>						
								<c:if test="${list.bestyn eq 'Y' and tagCnt < 3}">
								<span class="tag">BEST</span>
								</c:if>
							</li>
							<li class="u_brand">${list.bndnmko}</li>
							<li class="u_name"><a href="/goods/indexGoodsDetail?goodsId=${list.goodsid}&amp;dispClsfNo=">${list.goodsnm}</a> </li>
							<li class="u_cost"><c:if test="${list.salepct > 0}"><span class="sale">[${list.salepct}%]</span></c:if> <fmt:formatNumber value="${list.prmtdcamt}"/> 원</li>										
						</ul>
					</li>
				</c:forEach>
			</ul>
			</c:when>
			<c:otherwise>
			<!-- search_msg -->	
			<div class="searchMsg">
				<ul>
					<li>선택된 조건에 맞는 상품이 없습니다.</li>
					<li>필터를 다시 선택해주세요.</li>
				</ul>
			</div>
			</c:otherwise>
			</c:choose>
		</div>
	</div>
	<!-- pageNavi -->
	${shopPagination}
	<!-- //pageNavi -->
</div>
<!--// tabCont :  searchListContainer  -->	
