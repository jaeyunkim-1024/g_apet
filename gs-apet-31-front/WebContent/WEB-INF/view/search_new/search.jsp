<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %> 
<%@ page import="framework.common.constants.CommonConstants" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<script type="text/javascript">
$(document).ready(function(){
 	$(".numOnly").css({"ime-mode" : "disabled"});  // ime-mode : disabeld 시키기 
 	$(".numOnly").number(true);  // jquery.number 함수

	//메뉴탭 리스트 노출
	var display = $("#menuActive").val();
	var display2 = "";
	
	if(display == "cate" || display == ""){
		display2 = "searchMenu1";
	}else if(display == "brand"){
		display2 = "searchMenu2";
	}else if(display == "store"){
		display2 = "searchMenu3";
	}else if(display == "design"){
		display2 = "searchMenu4";
	}else if(display == "prmt"){
		display2 = "searchMenu5";
	}
	$(".searchMenuContent").hide();
	$("#"+ display2).show();
	
	var str_hash = document.location.hash;
	
	if(str_hash != ""){
		str_hash = str_hash.replace("#","");
		var arr_curpage = new Array();
		arr_curpage=str_hash.split("^");
		if(arr_curpage.length > 0){
			var pageNum = arr_curpage[0];
			var shopView = arr_curpage[1];
			if(shopView == "Y" && pageNum!=1){
				ajaxShopList(pageNum);
				displayOptionView();
			}
		}
	}
	
});
</script>

	<div class="location_path">
		<ul>
			<li class="home"><a href="/main">Home</a></li>
			<li class="current">검색결과</li>
		</ul>
	</div>
	<!-- content -->	
	<form method="post" id="searchDetail" name="searchDetail" action="/search_new/search"><!--detailForm -->
		<input type="hidden" id="searchQueryDetail" name="searchQuery" value="<c:out value="${searchVo.searchQuery}" />"/>
		<input type="hidden" id="researchQueryDetail" name="researchQuery" value="<c:out value="${searchVo.researchQuery}" />"/>
		<input type="hidden" id="allsearchQueryDetail" name="allsearchQuery" value="<c:out value="${searchVo.allsearchQuery}" />"/>
		<input type="hidden" id="searchCategoryDetail" name="searchCategory" value="${searchVo.searchCategory}"/>
		<input type="hidden" id="searchDisplayDetail" name="searchDisplay" value="${searchVo.searchDisplay}"/>
		<input type="hidden" id="searchStartPriceDetail" name="searchStartPrice" value="${searchVo.searchStartPrice}"/>
		<input type="hidden" id="searchEndPriceDetail" name="searchEndPrice" value="${searchVo.searchEndPrice}"/>
		<c:forEach var="buttonPriceList" items="${searchVo.buttonPrice}" varStatus="status" >
			<input type="hidden" name="buttonPrice" value="<c:out value="${buttonPriceList}"></c:out>" />
		</c:forEach>
		<input type="hidden" id="sCateShow" name="sCateShow" value="${searchVo.sCateShow}"/>
		<input type="hidden" id="menuActive" name="menuActive" value="${searchVo.menuActive}"/>
		<input type="hidden" id="pageNumberDetail" name="pageNumber" value="1"/>
		<input type="hidden" id="searchType" name="searchType" />	
		<input type="hidden" id="shopView" name="shopView"/>	
		<div id="content">
			<c:choose>
			<c:when test="${searchVo.group_totalSize > 0}">
			<!-- search_word -->
			<div class="search_word_wrap">
				<div class="keyword_result"><span>[<c:out value="${fn:replace(searchVo.allsearchQuery, '$|', ', ')}"></c:out>]</span> 검색결과 <span><fmt:formatNumber value="${searchVo.group_totalSize}"/></span></li></span>개</div>
				<div class="inner_search">
					<!-- search_box -->
					<div class="search_box">
						<input type="text" id="research" name="research" autocomplete="off" placeholder="결과 내 검색" style="outline:none"/>
						<button onclick="goReSearch(); return false;" >검색</button>
					</div>
					<!-- //search_box -->	
					
					<!-- commend_wrap -->
					<c:if test="${not empty relationResultList}">
						<div class="commend_wrap">
							<div class="commend_title">추천검색어</div>
							<ul class="commend_list">
								<c:forEach var="list" items="${relationResultList}" varStatus="index">
									<li><a href="javascript:goDirectSearch('${list.keyword}');">${list.keyword}</a></li>
								</c:forEach>
							</ul>
						</div>
					</c:if>
					<!-- //commend_wrap -->	
				</div>
			</div>
			<!-- //search_word -->	
			<!-- search_menu -->	
			<div class="search_menu_wrap">
				<!-- tab : search_menu_box -->
				<div class="search_menu_box">
					<ul class="searchMenu">
						<li <c:if test="${searchVo.menuActive eq 'cate' || searchVo.menuActive eq ''}">class="active"</c:if> data-value="cate" rel="searchMenu1"><a href="javascript:void(0)">카테고리</a></li>
						<li <c:if test="${searchVo.menuActive eq 'brand'}">class="active"</c:if> <c:if test="${brandCnt == 0}">class="disabled"</c:if>data-type="${brandCnt}" data-value="brand" rel="searchMenu2"><a href="javascript:void(0)">브랜드</a></li>
						<li <c:if test="${searchVo.menuActive eq 'store'}">class="active"</c:if> <c:if test="${groupStoreCnt == 0}">class="disabled"</c:if>data-type="${groupStoreCnt}" data-value="store"data-value="cate" rel="searchMenu3"><a href="javascript:void(0)">스토어</a></li>
						<li <c:if test="${searchVo.menuActive eq 'design'}">class="active"</c:if> <c:if test="${groupDesignCnt == 0}">class="disabled"</c:if>data-type="${groupDesignCnt}" data-value="design" rel="searchMenu4"><a href="javascript:void(0)">디자이너</a></li>
						<li <c:if test="${searchVo.menuActive eq 'prmt'}">class="active"</c:if> <c:if test="${groupPrmtCnt == 0}">class="disabled"</c:if> data-type="${groupPrmtCnt}" data-value="prmt" rel="searchMenu5"><a href="javascript:void(0)">프리미엄</a></li>
					</ul>
				</div>
				<!--// tab : search_menu_box -->
	
				<!-- tabCont : searchMenuContainer -->
				<div class="searchMenuContainer">
					<!-- 카테고리 -->
					<div id="searchMenu1" class="searchMenuContent cate">						
						<!-- tab : searchCate -->
						<ul class="searchCate">
							<c:forEach var="lcateList" items="${lcateGroupList}" varStatus="index">
								<c:set var="firstClass" value=""></c:set>
								<c:if test="${index.count eq 1}">
									<c:set var="firstClass" value="active"></c:set>
								</c:if>
								<li class="${firstClass}" rel="cateSub${index.count}"><a href="javascript:void(0)">${lcateList.groupNm}<span>(<fmt:formatNumber value="${lcateList.groupCount}" />)</span></a></li>
							</c:forEach>
						</ul>
						<!--// tab : searchCate -->
						
						<!-- tabCont : categorySub  -->
						<c:forEach var="lcateList" items="${lcateGroupList}" varStatus="lIndex">
							<c:set var="Lcate" value="${lcateList.groupNm}" />
							<div id="cateSub${lIndex.count}" class="categorySub">
								<c:set var="mTotalCnt" value="0" />
								<c:set var="mCnt" value="0" />
								<c:set var="ulCnt" value="0" />
								<c:forEach var="mcateList" items="${mcateGroupList}" varStatus="index">
									<c:set var="mcateArr" value="${fn:split(mcateList.groupNm, '>')}" />
									<c:if test="${Lcate eq mcateArr[0]}">
									<c:set var="mTotalCnt" value="${mTotalCnt+1}" />
									</c:if>
								</c:forEach>
								<c:forEach var="mcateList" items="${mcateGroupList}" varStatus="mIndex">
									<c:set var="mcateArr" value="${fn:split(mcateList.groupNm, '>')}" />
									<c:if test="${Lcate eq mcateArr[0]}">
										<c:set var="mCnt" value="${mCnt+1}" />
									</c:if>
									<c:if test="${(mCnt%5) eq 1 && Lcate eq mcateArr[0]}">
										<ul class="subCate">
									</c:if>
									<c:if test="${Lcate eq mcateArr[0]}">
										<li data-value="${mcateList.groupNm}" data-type="M"><input type="checkbox" data-value="mcatelist${mIndex.index}" data-type="M" id="m${mIndex.count}" name="searchMcate" value="${mcateList.groupNm}" <c:forEach var="list" items="${searchVo.searchMcate}" varStatus="status"><c:if test="${list eq  mcateList.groupNm }">checked="checked"</c:if></c:forEach> ><label for="m${mIndex.count}" data-value="mcatelist${mIndex.index}" >${mcateArr[1]}(<fmt:formatNumber value="${mcateList.groupCount}" />)</label></li>
									</c:if>
									<c:if test="${((mCnt%5) eq 0 || mCnt == mTotalCnt) && Lcate eq mcateArr[0]}"> 
										</ul>
										<c:set var="ulmCnt" value="0" />
										<c:forEach var="mcateList" items="${mcateGroupList}" varStatus="index">
											<c:set var="mcateArr" value="${fn:split(mcateList.groupNm, '>')}" />
											<c:set var="mcate" value="${mcateList.groupNm }" />
											<c:set var="mcateIndex" value="${mcateList.groupNm }>" />
											<c:if test="${Lcate eq mcateArr[0]}">
												<c:if test="${ulmCnt >= ulCnt * 5  && ulmCnt < (ulCnt+1) * 5}">
													<div class="lastCate_wrap" style="display:none;" id="mcatelist${index.index}">
														<ul class="lastCate">		
															<c:forEach var="scateList" items="${scateGroupList}" varStatus="sindex">
																<c:if test="${ fn:indexOf(scateList.groupNm, mcateIndex) >=0 }">
																	<c:set var="scateArr" value="${fn:split(scateList.groupNm, '>')}" />						
																	<li data-value="${scateList.groupNm }" data-type="S"><input type="checkbox" data-value="mcatelist${index.index}" data-type="S" id="s${sindex.count}" name="searchScate" value="${scateList.groupNm}" <c:forEach var="list" items="${searchVo.searchScate}" varStatus="status"><c:if test="${list eq  scateList.groupNm }">checked="checked"</c:if></c:forEach> ><label for="s${sindex.count}">${scateArr[2]} (<fmt:formatNumber value="${scateList.groupCount}" />)</label></li>
																</c:if>
															</c:forEach>
														</ul>
													</div>
												</c:if>
												<c:set var="ulmCnt" value="${ulmCnt+1}"></c:set>
											</c:if>
										</c:forEach>
										<c:set var="ulCnt" value="${ulCnt+1}" />
									</c:if>
								</c:forEach>
							</div>
						</c:forEach>
						<!-- // tabCont : categorySub  -->
					</div>
					<!--// 카테고리 -->					
	
					<!-- 브랜드 -->
					<div id="searchMenu2" class="searchMenuContent brand">
						<!-- tab : searchBrand -->
						<ul class="searchBrand">
							<li class="active" rel="brSub1" data-value="N"><a href="javascript:void(0)">BRAND<span>(${brandCnt})</span></a></li>
							<li rel="brSub2" data-value="Y" <c:if test="${styleDCGCnt == 0}">class="disabled"</c:if>><a href="javascript:void(0)">VECI<span>(${styleDCGCnt})</span></a></li>
						</ul>
						<!--// tab : searchCate -->
						
						<!-- tabCont : brandSub  -->
						<div id="brSub1" class="brandSub">
							<!-- lang_wrap -->
							<div class="lang_wrap">	
								<div class="lang_kind">
									<input id="korBrand" type="radio" name="brandRadio" value="korBrand" class="change_btn kor" checked="checked"><label for="korBrand">ㄱㄴㄷ순</label>
									<input id="engBrand" type="radio" name="brandRadio" value="2" class="change_btn eng"><label for="engBrand">ABC순</label>
								</div>
								<!-- lang_container -->
								<div id="engBrandDisplay" class="lang_container eng" style="display:none;">																
									<ul class="lang_list">
										<li data-value="ALL" class="active"><a href="#"><span>All</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'A') <0 }">class="disabled"</c:if> data-value="A"><a href="#"><span>A</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'B') <0 }">class="disabled"</c:if> data-value="B"><a href="#"><span>B</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'C') <0 }">class="disabled"</c:if> data-value="C"><a href="#"><span>C</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'D') <0 }">class="disabled"</c:if> data-value="D"><a href="#"><span>D</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'E') <0 }">class="disabled"</c:if> data-value="E"><a href="#"><span>E</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'F') <0 }">class="disabled"</c:if> data-value="F"><a href="#"><span>F</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'G') <0 }">class="disabled"</c:if> data-value="G"><a href="#"><span>G</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'H') <0 }">class="disabled"</c:if> data-value="H"><a href="#"><span>H</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'I') <0 }">class="disabled"</c:if> data-value="I"><a href="#"><span>I</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'J') <0 }">class="disabled"</c:if> data-value="J"><a href="#"><span>J</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'K') <0 }">class="disabled"</c:if> data-value="K"><a href="#"><span>K</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'L') <0 }">class="disabled"</c:if> data-value="L"><a href="#"><span>L</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'M') <0 }">class="disabled"</c:if> data-value="M"><a href="#"><span>M</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'N') <0 }">class="disabled"</c:if> data-value="N"><a href="#"><span>N</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'O') <0 }">class="disabled"</c:if> data-value="O"><a href="#"><span>O</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'P') <0 }">class="disabled"</c:if> data-value="P"><a href="#"><span>P</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'Q') <0 }">class="disabled"</c:if> data-value="Q"><a href="#"><span>Q</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'R') <0 }">class="disabled"</c:if> data-value="R"><a href="#"><span>R</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'S') <0 }">class="disabled"</c:if> data-value="S"><a href="#"><span>S</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'T') <0 }">class="disabled"</c:if> data-value="T"><a href="#"><span>T</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'U') <0 }">class="disabled"</c:if> data-value="U"><a href="#"><span>U</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'V') <0 }">class="disabled"</c:if> data-value="V"><a href="#"><span>V</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'W') <0 }">class="disabled"</c:if> data-value="W"><a href="#"><span>W</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'X') <0 }">class="disabled"</c:if> data-value="X"><a href="#"><span>X</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'Y') <0 }">class="disabled"</c:if> data-value="Y"><a href="#"><span>Y</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'Z') <0 }">class="disabled"</c:if> data-value="Z"><a href="#"><span>Z</span></a></li>
										<li data-value="ETC"><a href="#"><span>etc</span></a></li>
									</ul>	
								</div><!-- //lang_container : kor -->
								<!-- lang_container -->
								<div id="korBrandDisplay" class="lang_container kor" style="display:block;">									
									<ul class="lang_list">
										<li class="active" data-value="ALL"><a href="#"><span>All</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'ㄱ') <0 }">class="disabled"</c:if> data-value="ㄱ"><a href="#"><span>ㄱ</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'ㄴ') <0 }">class="disabled"</c:if> data-value="ㄴ"><a href="#"><span>ㄴ</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'ㄷ') <0 }">class="disabled"</c:if> data-value="ㄷ"><a href="#"><span>ㄷ</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'ㄹ') <0 }">class="disabled"</c:if> data-value="ㄹ"><a href="#"><span>ㄹ</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'ㅁ') <0 }">class="disabled"</c:if> data-value="ㅁ"><a href="#"><span>ㅁ</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'ㅂ') <0 }">class="disabled"</c:if> data-value="ㅂ"><a href="#"><span>ㅂ</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'ㅅ') <0 }">class="disabled"</c:if> data-value="ㅅ"><a href="#"><span>ㅅ</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'ㅇ') <0 }">class="disabled"</c:if> data-value="ㅇ"><a href="#"><span>ㅇ</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'ㅈ') <0 }">class="disabled"</c:if> data-value="ㅈ"><a href="#"><span>ㅈ</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'ㅊ') <0 }">class="disabled"</c:if> data-value="ㅊ"><a href="#"><span>ㅊ</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'ㅋ') <0 }">class="disabled"</c:if> data-value="ㅋ"><a href="#"><span>ㅋ</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'ㅌ') <0 }">class="disabled"</c:if> data-value="ㅌ"><a href="#"><span>ㅌ</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'ㅍ') <0 }">class="disabled"</c:if> data-value="ㅍ"><a href="#"><span>ㅍ</span></a></li>
										<li <c:if test="${fn:indexOf(brandChoList, 'ㅎ') <0 }">class="disabled"</c:if> data-value="ㅎ"><a href="#"><span>ㅎ</span></a></li>
									</ul>	
								</div><!-- //lang_container : kor -->								
							</div><!--// lang_wrap -->
							<!--  brandSubResult  -->
							<div class="brandSubResult">
								<ul class="subCate">
									<c:forEach var="brandList" items="${brandGroupList}" varStatus="bIndex">
										<c:set var="brandArr" value="${fn:split(brandList.groupNm, '$')}"></c:set>
											<li data-value="${brandArr[0]}" data-cho="${brandArr[2]}"><input type="checkbox" id="b${bIndex.count}" name="searchBrand" value="${brandList.groupNm}" data-value="${brandList.groupNm}"  data-type="brand" <c:forEach var="list" items="${searchVo.searchBrand}" varStatus="status"><c:if test="${list eq  brandList.groupNm }">checked="checked"</c:if></c:forEach> ><label for="b${bIndex.count}">${brandArr[1]} (<fmt:formatNumber value="${brandList.groupCount}" />)</label></li>
									</c:forEach>
								</ul>
							</div><!-- // brandSubResult  -->
						</div>
						<div id="brSub2" class="brandSub">
							<!-- lang_wrap -->
							<div class="lang_wrap">	
								<div class="lang_kind">
									<input id="korBrand2" type="radio" name="brandStyleRadio" value="korBrand2" class="change_btn kor" checked="checked"><label for="korBrand2">ㄱㄴㄷ순</label>
									<input id="engBrand2" type="radio" name="brandStyleRadio" value="2" class="change_btn eng"><label for="engBrand2">ABC순</label>
								</div>
								<!-- lang_container -->
								<div id="engBrandDisplay2" class="lang_container eng" style="display:none;">																
									<ul class="lang_list lang_list2">
										<li data-value="ALL" class="active"><a href="#"><span>All</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'A') <0 }">class="disabled"</c:if> data-value="A"><a href="#"><span>A</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'B') <0 }">class="disabled"</c:if> data-value="B"><a href="#"><span>B</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'C') <0 }">class="disabled"</c:if> data-value="C"><a href="#"><span>C</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'D') <0 }">class="disabled"</c:if> data-value="D"><a href="#"><span>D</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'E') <0 }">class="disabled"</c:if> data-value="E"><a href="#"><span>E</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'F') <0 }">class="disabled"</c:if> data-value="F"><a href="#"><span>F</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'G') <0 }">class="disabled"</c:if> data-value="G"><a href="#"><span>G</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'H') <0 }">class="disabled"</c:if> data-value="H"><a href="#"><span>H</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'I') <0 }">class="disabled"</c:if> data-value="I"><a href="#"><span>I</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'J') <0 }">class="disabled"</c:if> data-value="J"><a href="#"><span>J</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'K') <0 }">class="disabled"</c:if> data-value="K"><a href="#"><span>K</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'L') <0 }">class="disabled"</c:if> data-value="L"><a href="#"><span>L</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'M') <0 }">class="disabled"</c:if> data-value="M"><a href="#"><span>M</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'N') <0 }">class="disabled"</c:if> data-value="N"><a href="#"><span>N</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'O') <0 }">class="disabled"</c:if> data-value="O"><a href="#"><span>O</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'P') <0 }">class="disabled"</c:if> data-value="P"><a href="#"><span>P</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'Q') <0 }">class="disabled"</c:if> data-value="Q"><a href="#"><span>Q</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'R') <0 }">class="disabled"</c:if> data-value="R"><a href="#"><span>R</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'S') <0 }">class="disabled"</c:if> data-value="S"><a href="#"><span>S</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'T') <0 }">class="disabled"</c:if> data-value="T"><a href="#"><span>T</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'U') <0 }">class="disabled"</c:if> data-value="U"><a href="#"><span>U</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'V') <0 }">class="disabled"</c:if> data-value="V"><a href="#"><span>V</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'W') <0 }">class="disabled"</c:if> data-value="W"><a href="#"><span>W</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'X') <0 }">class="disabled"</c:if> data-value="X"><a href="#"><span>X</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'Y') <0 }">class="disabled"</c:if> data-value="Y"><a href="#"><span>Y</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'Z') <0 }">class="disabled"</c:if> data-value="Z"><a href="#"><span>Z</span></a></li>
										<li data-value="ETC"><a href="#"><span>etc</span></a></li>
									</ul>	
								</div><!-- //lang_container : kor -->
								<!-- lang_container -->
								<div id="korBrandDisplay2" class="lang_container kor" style="display:block;">									
									<ul class="lang_list lang_list2">
										<li class="active" data-value="ALL"><a href="#"><span>All</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'ㄱ') <0 }">class="disabled"</c:if> data-value="ㄱ"><a href="#"><span>ㄱ</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'ㄴ') <0 }">class="disabled"</c:if> data-value="ㄴ"><a href="#"><span>ㄴ</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'ㄷ') <0 }">class="disabled"</c:if> data-value="ㄷ"><a href="#"><span>ㄷ</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'ㄹ') <0 }">class="disabled"</c:if> data-value="ㄹ"><a href="#"><span>ㄹ</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'ㅁ') <0 }">class="disabled"</c:if> data-value="ㅁ"><a href="#"><span>ㅁ</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'ㅂ') <0 }">class="disabled"</c:if> data-value="ㅂ"><a href="#"><span>ㅂ</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'ㅅ') <0 }">class="disabled"</c:if> data-value="ㅅ"><a href="#"><span>ㅅ</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'ㅇ') <0 }">class="disabled"</c:if> data-value="ㅇ"><a href="#"><span>ㅇ</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'ㅈ') <0 }">class="disabled"</c:if> data-value="ㅈ"><a href="#"><span>ㅈ</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'ㅊ') <0 }">class="disabled"</c:if> data-value="ㅊ"><a href="#"><span>ㅊ</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'ㅋ') <0 }">class="disabled"</c:if> data-value="ㅋ"><a href="#"><span>ㅋ</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'ㅌ') <0 }">class="disabled"</c:if> data-value="ㅌ"><a href="#"><span>ㅌ</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'ㅍ') <0 }">class="disabled"</c:if> data-value="ㅍ"><a href="#"><span>ㅍ</span></a></li>
										<li <c:if test="${fn:indexOf(brandStyleChoList, 'ㅎ') <0 }">class="disabled"</c:if> data-value="ㅎ"><a href="#"><span>ㅎ</span></a></li>
									</ul>	
								</div><!-- //lang_container : kor -->								
							</div><!--// lang_wrap -->
							<!--  brandSubResult  -->
							<div class="brandSubResult2">
								<ul class="subCate">
									<c:forEach var="brandList" items="${brandGroupList}" varStatus="bIndex">
										<c:set var="brandArr" value="${fn:split(brandList.groupNm, '$')}"></c:set>
										<c:if test="${brandArr[0] ne 'N'}">
											<li data-value="${brandArr[0]}" data-cho="${brandArr[2]}"><input type="checkbox" id="b${bIndex.count}" name="searchBrand" value="${brandList.groupNm}" data-value="${brandList.groupNm}"  data-type="brand" <c:forEach var="list" items="${searchVo.searchBrand}" varStatus="status"><c:if test="${list eq  brandList.groupNm }">checked="checked"</c:if></c:forEach> ><label for="b${bIndex.count}">${brandArr[1]} (<fmt:formatNumber value="${brandList.groupCount}" />)</label></li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
						</div>
						<!-- // tabCont : brandSub  -->
					</div>
					<!--// 브랜드 -->
	
					<!-- 스토어 -->
					<div id="searchMenu3" class="searchMenuContent store">
						<!-- lang_wrap -->
						<div class="lang_wrap">	
							<div class="lang_kind">
								<input id="korStr" type="radio" name="storeRadio" value="korStr" class="change_btn kor" checked="checked"><label for="korStr">ㄱㄴㄷ순</label>
								<input id="engStr" type="radio" name="storeRadio" value="3" class="change_btn eng"><label for="engStr">ABC순</label>
							</div>
							<!-- lang_container -->
							<div id="engStrDisplay" class="lang_container eng" style="display:none;">																
								<ul class="lang_list">
									<li data-value="ALL" class="active"><a href="#"><span>All</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'A') <0 }">class="disabled"</c:if> data-value="A"><a href="#"><span>A</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'B') <0 }">class="disabled"</c:if> data-value="B"><a href="#"><span>B</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'C') <0 }">class="disabled"</c:if> data-value="C"><a href="#"><span>C</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'D') <0 }">class="disabled"</c:if> data-value="D"><a href="#"><span>D</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'E') <0 }">class="disabled"</c:if> data-value="E"><a href="#"><span>E</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'F') <0 }">class="disabled"</c:if> data-value="F"><a href="#"><span>F</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'G') <0 }">class="disabled"</c:if> data-value="G"><a href="#"><span>G</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'H') <0 }">class="disabled"</c:if> data-value="H"><a href="#"><span>H</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'I') <0 }">class="disabled"</c:if> data-value="I"><a href="#"><span>I</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'J') <0 }">class="disabled"</c:if> data-value="J"><a href="#"><span>J</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'K') <0 }">class="disabled"</c:if> data-value="K"><a href="#"><span>K</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'L') <0 }">class="disabled"</c:if> data-value="L"><a href="#"><span>L</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'M') <0 }">class="disabled"</c:if> data-value="M"><a href="#"><span>M</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'N') <0 }">class="disabled"</c:if> data-value="N"><a href="#"><span>N</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'O') <0 }">class="disabled"</c:if> data-value="O"><a href="#"><span>O</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'P') <0 }">class="disabled"</c:if> data-value="P"><a href="#"><span>P</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'Q') <0 }">class="disabled"</c:if> data-value="Q"><a href="#"><span>Q</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'R') <0 }">class="disabled"</c:if> data-value="R"><a href="#"><span>R</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'S') <0 }">class="disabled"</c:if> data-value="S"><a href="#"><span>S</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'T') <0 }">class="disabled"</c:if> data-value="T"><a href="#"><span>T</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'U') <0 }">class="disabled"</c:if> data-value="U"><a href="#"><span>U</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'V') <0 }">class="disabled"</c:if> data-value="V"><a href="#"><span>V</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'W') <0 }">class="disabled"</c:if> data-value="W"><a href="#"><span>W</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'X') <0 }">class="disabled"</c:if> data-value="X"><a href="#"><span>X</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'Y') <0 }">class="disabled"</c:if> data-value="Y"><a href="#"><span>Y</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'Z') <0 }">class="disabled"</c:if> data-value="Z"><a href="#"><span>Z</span></a></li>
									<li data-value="ETC"><a href="#"><span>etc</span></a></li>
								</ul>	
							</div><!-- //lang_container : kor -->
							<!-- lang_container -->
							<div id="korStrDisplay" class="lang_container kor" style="display:block;">									
								<ul class="lang_list">
									<li class="active" data-value="ALL"><a href="#"><span>All</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'ㄱ') <0 }">class="disabled"</c:if> data-value="ㄱ"><a href="#"><span>ㄱ</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'ㄴ') <0 }">class="disabled"</c:if> data-value="ㄴ"><a href="#"><span>ㄴ</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'ㄷ') <0 }">class="disabled"</c:if> data-value="ㄷ"><a href="#"><span>ㄷ</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'ㄹ') <0 }">class="disabled"</c:if> data-value="ㄹ"><a href="#"><span>ㄹ</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'ㅁ') <0 }">class="disabled"</c:if> data-value="ㅁ"><a href="#"><span>ㅁ</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'ㅂ') <0 }">class="disabled"</c:if> data-value="ㅂ"><a href="#"><span>ㅂ</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'ㅅ') <0 }">class="disabled"</c:if> data-value="ㅅ"><a href="#"><span>ㅅ</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'ㅇ') <0 }">class="disabled"</c:if> data-value="ㅇ"><a href="#"><span>ㅇ</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'ㅈ') <0 }">class="disabled"</c:if> data-value="ㅈ"><a href="#"><span>ㅈ</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'ㅊ') <0 }">class="disabled"</c:if> data-value="ㅊ"><a href="#"><span>ㅊ</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'ㅋ') <0 }">class="disabled"</c:if> data-value="ㅋ"><a href="#"><span>ㅋ</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'ㅌ') <0 }">class="disabled"</c:if> data-value="ㅌ"><a href="#"><span>ㅌ</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'ㅍ') <0 }">class="disabled"</c:if> data-value="ㅍ"><a href="#"><span>ㅍ</span></a></li>
									<li <c:if test="${fn:indexOf(storeChoList, 'ㅎ') <0 }">class="disabled"</c:if> data-value="ㅎ"><a href="#"><span>ㅎ</span></a></li>
								</ul>	
							</div><!-- //lang_container : kor -->								
						</div><!--// lang_wrap -->
						<div class="storeSub">
							<ul class="subCate">
								<c:forEach var="strList" items="${strGroupList}" varStatus="strIndex">
									<c:set var="brandArr" value="${fn:split(strList.groupNm, '$')}"></c:set>
									<li data-cho="${brandArr[1]}"><input type="checkbox" id="str${strIndex.count}" name="searchStore" value="${strList.groupNm}" data-value="${strList.groupNm}" data-type="store" <c:forEach var="list" items="${searchVo.searchStore}" varStatus="status"><c:if test="${list eq  strList.groupNm }">checked="checked"</c:if></c:forEach> ><label for="str${strIndex.count}">${brandArr[0]} (<fmt:formatNumber value="${strList.groupCount}" />)</label></li>
								</c:forEach>
							</ul>
						</div><!--// storeSub -->
					</div>
					<!--// 스토어 -->
					<!-- 디자이너 -->
					<div id="searchMenu4" class="searchMenuContent designer">
						<!-- lang_wrap -->
						<div class="lang_wrap">	
							<div class="lang_kind">
								<input id="korDsr" type="radio" name="dsnrRadio" value="korDsr" class="change_btn kor" checked="checked"><label for="korDsr">ㄱㄴㄷ순</label>
								<input id="engDsr" type="radio" name="dsnrRadio" value="3" class="change_btn eng"><label for="engDsr">ABC순</label>
							</div>
							<!-- lang_container -->
							<div id="engDsrDisplay" class="lang_container eng" style="display:none;">																
								<ul class="lang_list">
									<li data-value="ALL" class="active"><a href="#"><span>All</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'A') <0 }">class="disabled"</c:if> data-value="A"><a href="#"><span>A</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'B') <0 }">class="disabled"</c:if> data-value="B"><a href="#"><span>B</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'C') <0 }">class="disabled"</c:if> data-value="C"><a href="#"><span>C</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'D') <0 }">class="disabled"</c:if> data-value="D"><a href="#"><span>D</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'E') <0 }">class="disabled"</c:if> data-value="E"><a href="#"><span>E</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'F') <0 }">class="disabled"</c:if> data-value="F"><a href="#"><span>F</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'G') <0 }">class="disabled"</c:if> data-value="G"><a href="#"><span>G</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'H') <0 }">class="disabled"</c:if> data-value="H"><a href="#"><span>H</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'I') <0 }">class="disabled"</c:if> data-value="I"><a href="#"><span>I</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'J') <0 }">class="disabled"</c:if> data-value="J"><a href="#"><span>J</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'K') <0 }">class="disabled"</c:if> data-value="K"><a href="#"><span>K</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'L') <0 }">class="disabled"</c:if> data-value="L"><a href="#"><span>L</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'M') <0 }">class="disabled"</c:if> data-value="M"><a href="#"><span>M</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'N') <0 }">class="disabled"</c:if> data-value="N"><a href="#"><span>N</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'O') <0 }">class="disabled"</c:if> data-value="O"><a href="#"><span>O</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'P') <0 }">class="disabled"</c:if> data-value="P"><a href="#"><span>P</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'Q') <0 }">class="disabled"</c:if> data-value="Q"><a href="#"><span>Q</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'R') <0 }">class="disabled"</c:if> data-value="R"><a href="#"><span>R</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'S') <0 }">class="disabled"</c:if> data-value="S"><a href="#"><span>S</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'T') <0 }">class="disabled"</c:if> data-value="T"><a href="#"><span>T</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'U') <0 }">class="disabled"</c:if> data-value="U"><a href="#"><span>U</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'V') <0 }">class="disabled"</c:if> data-value="V"><a href="#"><span>V</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'W') <0 }">class="disabled"</c:if> data-value="W"><a href="#"><span>W</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'X') <0 }">class="disabled"</c:if> data-value="X"><a href="#"><span>X</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'Y') <0 }">class="disabled"</c:if> data-value="Y"><a href="#"><span>Y</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'Z') <0 }">class="disabled"</c:if> data-value="Z"><a href="#"><span>Z</span></a></li>
									<li data-value="ETC"><a href="#"><span>etc</span></a></li>
								</ul>	
							</div><!-- //lang_container : kor -->
							<!-- lang_container -->
							<div id="korDsrDisplay" class="lang_container kor" style="display:block;">									
								<ul class="lang_list">
									<li class="active" data-value="ALL"><a href="#"><span>All</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'ㄱ') <0 }">class="disabled"</c:if> data-value="ㄱ"><a href="#"><span>ㄱ</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'ㄴ') <0 }">class="disabled"</c:if> data-value="ㄴ"><a href="#"><span>ㄴ</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'ㄷ') <0 }">class="disabled"</c:if> data-value="ㄷ"><a href="#"><span>ㄷ</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'ㄹ') <0 }">class="disabled"</c:if> data-value="ㄹ"><a href="#"><span>ㄹ</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'ㅁ') <0 }">class="disabled"</c:if> data-value="ㅁ"><a href="#"><span>ㅁ</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'ㅂ') <0 }">class="disabled"</c:if> data-value="ㅂ"><a href="#"><span>ㅂ</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'ㅅ') <0 }">class="disabled"</c:if> data-value="ㅅ"><a href="#"><span>ㅅ</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'ㅇ') <0 }">class="disabled"</c:if> data-value="ㅇ"><a href="#"><span>ㅇ</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'ㅈ') <0 }">class="disabled"</c:if> data-value="ㅈ"><a href="#"><span>ㅈ</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'ㅊ') <0 }">class="disabled"</c:if> data-value="ㅊ"><a href="#"><span>ㅊ</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'ㅋ') <0 }">class="disabled"</c:if> data-value="ㅋ"><a href="#"><span>ㅋ</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'ㅌ') <0 }">class="disabled"</c:if> data-value="ㅌ"><a href="#"><span>ㅌ</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'ㅍ') <0 }">class="disabled"</c:if> data-value="ㅍ"><a href="#"><span>ㅍ</span></a></li>
									<li <c:if test="${fn:indexOf(dsgnrChoList, 'ㅎ') <0 }">class="disabled"</c:if> data-value="ㅎ"><a href="#"><span>ㅎ</span></a></li>
								</ul>	
							</div><!-- //lang_container : kor -->								
						</div><!--// lang_wrap -->
						<div class="designerSub" >
							<ul class="subCate" id="searchDesignerSub">
								<c:forEach var="dsgnrList" items="${dsgnrGroupList}" varStatus="dIndex">
									<c:set var="brandArr" value="${fn:split(dsgnrList.groupNm, '$')}"></c:set>
									<li data-cho="${brandArr[1]}" class="designerLi"><input type="checkbox" id="d${dIndex.count}" name="searchDesigner" value="${dsgnrList.groupNm}" data-value="${dsgnrList.groupNm}" data-type="designer" <c:forEach var="list" items="${searchVo.searchDesigner}" varStatus="status"><c:if test="${list eq  dsgnrList.groupNm }">checked="checked"</c:if></c:forEach> ><label for="d${dIndex.count}">${brandArr[0]} (<fmt:formatNumber value="${dsgnrList.groupCount}" />)</label></li>
								</c:forEach>
							</ul>
						</div><!--// designerSub -->						
					</div>
					<!--// 디자이너 -->
					<!-- 프리미엄 -->
					<div id="searchMenu5" class="searchMenuContent premium">
						<!-- lang_wrap -->
						<div class="lang_wrap">	
							<div class="lang_kind">
								<input id="korPri" type="radio" name="rpmtRadio" value="korPri" class="change_btn kor" checked="checked"><label for="korPri">ㄱㄴㄷ순</label>
								<input id="engPri" type="radio" name="rpmtRadio" value="3" class="change_btn eng" ><label for="engPri">ABC순</label>
							</div>
							<!-- lang_container -->
							<div id="engPriDisplay" class="lang_container eng" style="display:none;">																
								<ul class="lang_list">
									<li data-value="ALL" class="active"><a href="#"><span>All</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'A') <0 }">class="disabled"</c:if> data-value="A"><a href="#"><span>A</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'B') <0 }">class="disabled"</c:if> data-value="B"><a href="#"><span>B</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'C') <0 }">class="disabled"</c:if> data-value="C"><a href="#"><span>C</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'D') <0 }">class="disabled"</c:if> data-value="D"><a href="#"><span>D</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'E') <0 }">class="disabled"</c:if> data-value="E"><a href="#"><span>E</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'F') <0 }">class="disabled"</c:if> data-value="F"><a href="#"><span>F</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'G') <0 }">class="disabled"</c:if> data-value="G"><a href="#"><span>G</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'H') <0 }">class="disabled"</c:if> data-value="H"><a href="#"><span>H</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'I') <0 }">class="disabled"</c:if> data-value="I"><a href="#"><span>I</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'J') <0 }">class="disabled"</c:if> data-value="J"><a href="#"><span>J</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'K') <0 }">class="disabled"</c:if> data-value="K"><a href="#"><span>K</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'L') <0 }">class="disabled"</c:if> data-value="L"><a href="#"><span>L</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'M') <0 }">class="disabled"</c:if> data-value="M"><a href="#"><span>M</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'N') <0 }">class="disabled"</c:if> data-value="N"><a href="#"><span>N</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'O') <0 }">class="disabled"</c:if> data-value="O"><a href="#"><span>O</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'P') <0 }">class="disabled"</c:if> data-value="P"><a href="#"><span>P</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'Q') <0 }">class="disabled"</c:if> data-value="Q"><a href="#"><span>Q</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'R') <0 }">class="disabled"</c:if> data-value="R"><a href="#"><span>R</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'S') <0 }">class="disabled"</c:if> data-value="S"><a href="#"><span>S</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'T') <0 }">class="disabled"</c:if> data-value="T"><a href="#"><span>T</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'U') <0 }">class="disabled"</c:if> data-value="U"><a href="#"><span>U</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'V') <0 }">class="disabled"</c:if> data-value="V"><a href="#"><span>V</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'W') <0 }">class="disabled"</c:if> data-value="W"><a href="#"><span>W</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'X') <0 }">class="disabled"</c:if> data-value="X"><a href="#"><span>X</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'Y') <0 }">class="disabled"</c:if> data-value="Y"><a href="#"><span>Y</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'Z') <0 }">class="disabled"</c:if> data-value="Z"><a href="#"><span>Z</span></a></li>
									<li data-value="ETC"><a href="#"><span>etc</span></a></li>
								</ul>	
							</div><!-- //lang_container : kor -->
							<!-- lang_container -->
							<div id="korPriDisplay" class="lang_container kor" style="display:block;">									
								<ul class="lang_list">
									<li class="active" data-value="ALL"><a href="#"><span>All</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'ㄱ') <0 }">class="disabled"</c:if> data-value="ㄱ"><a href="#"><span>ㄱ</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'ㄴ') <0 }">class="disabled"</c:if> data-value="ㄴ"><a href="#"><span>ㄴ</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'ㄷ') <0 }">class="disabled"</c:if> data-value="ㄷ"><a href="#"><span>ㄷ</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'ㄹ') <0 }">class="disabled"</c:if> data-value="ㄹ"><a href="#"><span>ㄹ</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'ㅁ') <0 }">class="disabled"</c:if> data-value="ㅁ"><a href="#"><span>ㅁ</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'ㅂ') <0 }">class="disabled"</c:if> data-value="ㅂ"><a href="#"><span>ㅂ</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'ㅅ') <0 }">class="disabled"</c:if> data-value="ㅅ"><a href="#"><span>ㅅ</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'ㅇ') <0 }">class="disabled"</c:if> data-value="ㅇ"><a href="#"><span>ㅇ</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'ㅈ') <0 }">class="disabled"</c:if> data-value="ㅈ"><a href="#"><span>ㅈ</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'ㅊ') <0 }">class="disabled"</c:if> data-value="ㅊ"><a href="#"><span>ㅊ</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'ㅋ') <0 }">class="disabled"</c:if> data-value="ㅋ"><a href="#"><span>ㅋ</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'ㅌ') <0 }">class="disabled"</c:if> data-value="ㅌ"><a href="#"><span>ㅌ</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'ㅍ') <0 }">class="disabled"</c:if> data-value="ㅍ"><a href="#"><span>ㅍ</span></a></li>
									<li <c:if test="${fn:indexOf(prmtChoList, 'ㅎ') <0 }">class="disabled"</c:if> data-value="ㅎ"><a href="#"><span>ㅎ</span></a></li>
								</ul>	
							</div><!-- //lang_container : kor -->								
						</div><!--// lang_wrap -->
						<div class="premiumSub">
							<ul class="subCate">
								<c:forEach var="prmtList" items="${prmtBrandGroupList}" varStatus="pIndex">
									<c:set var="brandArr" value="${fn:split(prmtList.groupNm, '$')}"></c:set>
									<li data-cho="${brandArr[1]}"><input type="checkbox" id="p${pIndex.count}" name="searchPremium" value="${prmtList.groupNm}" data-value="${prmtList.groupNm}" data-type="premium" <c:forEach var="list" items="${searchVo.searchPremium}" varStatus="status"><c:if test="${list eq  prmtList.groupNm }">checked="checked"</c:if></c:forEach>><label for="p${pIndex.count}">${brandArr[0]} (<fmt:formatNumber value="${prmtList.groupCount}" />)</label></li>
								</c:forEach>
							</ul>
						</div><!--// premiumSub -->
					</div>
					<!--// 프리미엄 -->
				</div>	
			</div>
			<!-- //tabCont : searchMenuContainer -->	
	
			<!-- keyword_wrap -->	
			<div class="keyword_wrap" style="display:none;">
			</div>
			<!--// keyword_wrap -->	
			
			<!--  MD's Pick -->
			<div class="main_box">
				<p class="main_sec_title">MD's <strong>PICK</strong></p>
				<div class="list_col4">
					<ul>
						<c:forEach var="list" items="${mdList}" varStatus="index">
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
										</c:if>		 --%>				
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
				</div>
			</div>	
			<!--// MD's Pick -->
			
			<!-- search_list -->	
			<div class="search_list_wrap" id="search_list_wrap">
				<!-- tab : search_list_tabBox -->
				<div class="search_list_tabBox">
					<div class="search_sort">
						<ul class="sort_condition">
							<li class="searchBenefit" data-value="gonggu"><input type="checkbox"  id="aa" name="searchBenefitPC" data-type="benefit" data-value="gonggu" value="gonggu" <c:if test="${not empty searchVo.searchBenefitPC}"><c:forEach var="searchList" items="${searchVo.searchBenefitPC}" varStatus="status" ><c:if test="${searchList eq 'gonggu'}"> checked="checked" </c:if> </c:forEach> </c:if> ><label for="aa">공동구매</label></li>
							<li class="searchBenefit" data-value="free"><input type="checkbox" id="bb" name="searchBenefitPC" data-type="benefit" data-value="free" value="free" <c:if test="${not empty searchVo.searchBenefitPC}"><c:forEach var="searchList" items="${searchVo.searchBenefitPC}" varStatus="status" ><c:if test="${searchList eq 'free'}"> checked="checked" </c:if> </c:forEach> </c:if> ><label for="bb">무료배송</label></li>
							<li class="searchBenefit" data-value="coupon"><input type="checkbox" id="cc" name="searchBenefitPC" data-type="benefit" data-value="coupon" value="coupon" <c:if test="${not empty searchVo.searchBenefitPC}"><c:forEach var="searchList" items="${searchVo.searchBenefitPC}" varStatus="status" ><c:if test="${searchList eq 'coupon'}"> checked="checked" </c:if> </c:forEach> </c:if> ><label for="cc">쿠폰</label></li>
						</ul>
						<div class="search_price_wrap">
							<button type="button" class="price_btn">가격대</button><!-- style="text-align:right" -->
							<div class="search_price_content" style="display:none;">
								<ul class="price_box">
									<c:forEach var="plist" items="${plist}" varStatus="status" >
										<li><button type="button" id="price_in_btn" class="price_in_btn <c:forEach var="list" items="${searchVo.buttonPrice}" varStatus="status"><c:if test="${list eq plist}">active</c:if></c:forEach>" value="${plist}">${plist}</button></li>
									</c:forEach>
								</ul>
								<div class="search_direct_box">
									<input type="checkbox" id="dd"><label for="dd">직접입력</label>
									<!-- search_direct -->
									<span class="search_direct">
										<input type="text" id="searchStartPrice" class="price numOnly" onkeyup="prcAutoChk();" placeholder="<fmt:formatNumber value="${searchVo.resultStartPrice}" />원">
										<span class="bar">~</span>
										<input type="text" id="searchEndPrice" class="price numOnly" onkeyup="prcAutoChk();" placeholder="<fmt:formatNumber value="${searchVo.resultEndPrice}" />원">
									</span><!-- //search_direct -->								
									<a href="#" class="search_direct_btn">적용</a>														
								</div>
								<a id="prc_btn_cancle" href="#">선택해제</a>
							</div>
						</div>
						<div class="sort_select">
							<select id="searchSort" name="searchSort" class="select2" style="width:120px;" onchange="sortChange(this.value);"> <!--style="width:120px;direction:rtl;"  -->
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
						<c:if test="${storeCnt > 0}">
						<li <c:if test="${searchVo.searchCategory eq 'store'}">class="active"</c:if>> <a href="javascript:cateChange('store');">스토어<span>(<fmt:formatNumber value="${storeCnt}" />)</span></a></li>
						</c:if>
						<c:if test="${designerCnt > 0}">
						<li <c:if test="${searchVo.searchCategory eq 'designer'}">class="active"</c:if>><a href="javascript:cateChange('designer');">디자이너<span>(<fmt:formatNumber value="${designerCnt}" />)</span></a></li>
						</c:if>
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
											<li class="u_name"><a href="/goods/indexGoodsDetail?goodsId=${list.goodsid}">${list.goodsnm}</a> </li>
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
			</div>
			<!-- //search_list -->	
			</c:when>
			<c:otherwise>
			<!-- search_word -->	
			<div class="search_word_wrap">
				<div class="keyword_result"><span>[<c:out value="${fn:replace(searchVo.allsearchQuery, '$|', ', ')}"></c:out>]</span>에 대한 검색결과가 없습니다.</div>
			</div>
			<!-- //search_word -->	
	 
			<!-- search_msg -->	
			<div class="searchMsg">
				<ul>
					<li>검색어의 철자를 다시 확인해주세요.</li>
					<li>검색어의 띄어쓰기를 다르게 해보세요.</li>
					<li>보다 일반적인 단어로 검색해보세요.</li>
				</ul>
			</div>
			<!-- //search_msg -->	
			<!-- product_wrap -->
			<%-- <div class="main_box">
				<p class="main_sec_title t_center">고객님, 이 <strong>상품</strong>은 어떠세요?</p>				
				<div class="mdPick_wrap">
					<div class="list_col5">
						<ul>
							<c:forEach var="list" items="${rcmdList}" varStatus="index">
								<li class="item">
									<div class="img_sec over_link">
										<c:if test="${list.soldoutyn eq 'Y'}">
											<div class="sold_out"><span>SOLD OUT</span></div>
										</c:if>
										<a href="/goods/indexGoodsDetail?goodsId=${list.goodsid}&amp;dispClsfNo=" class="img_hover_view">
											<frame:goodsImage imgPath="${list.imgpath}" goodsId="${list.goodsid}" seq="${list.imgseq}" size="${ImageGoodsSize.SIZE_50.size}" alt="${list.goodsnm}"/>
										</a>
										<div class="link_group">
											<div class="btn_area">
												<a href="/goods/indexGoodsDetail?goodsId=${list.goodsid}" class="btn_cover_move" title="상품 새창보기" target="_blank"><span>상품 새창보기</span></a>
												<a href="#" class="btn_cover_fav" title="위시리스트 추가" onclick="insertWishS(this,'${list.goodsid}','${searchVo.searchQuery}');return false;"><span>위시리스트 추가</span></a>
											</div>
											<div class="mask_link" onclick="location.href='/goods/indexGoodsDetail?goodsId=${list.goodsid}'"></div>
										</div>
									</div>
									<ul class="text_sec">
										<li class="u_tag">
											<c:set var="tagCnt" value="0" />
											<c:if test="${list.prmtdcamt eq 'Y'}">
											<span class="tag hot">HOT</span>
											</c:if>						
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
					</div>
				</div><!--// product_wrap -->
			</div> --%>
			</c:otherwise>
			</c:choose>
		</div><!-- //content -->
	</form>
	<form method="post" id="searchMove" name="searchMove" action="/search_new/search">		
		<input type="hidden" id="searchQueryMove" name="searchQuery" value="<c:out value="${searchVo.searchQuery}" />"/>
		<input type="hidden" id="researchQueryMove" name="researchQuery" value="<c:out value="${searchVo.researchQuery}" />"/>
		<input type="hidden" id="allsearchQueryMove" name="allsearchQuery" value="<c:out value="${searchVo.allsearchQuery}" />"/>
		<input type="hidden" id="searchCategoryMove" name="searchCategory" value="${searchVo.searchCategory}"/>
		<input type="hidden" id="searchSortMove" name="searchSort" value="${searchVo.searchSort}"/>
		<c:forEach var="benefitList" items="${searchVo.searchBenefitPC}" varStatus="status" >
			<input type="hidden" name="searchBenefitPC" value="<c:out value="${benefitList}"></c:out>" />
		</c:forEach> 
		<input type="hidden" id="searchDisplayMove" name="searchDisplay" value="${searchVo.searchDisplay}"/>
		<input type="hidden" id="pageNumberMove" name="pageNumber" value="${searchVo.pageNumber}"/>
		<c:forEach var="buttonPriceList" items="${searchVo.buttonPrice}" varStatus="status" >
			<input type="hidden" name="buttonPrice" value="<c:out value="${buttonPriceList}"></c:out>" />
		</c:forEach> 
		<input type="hidden" id="searchStartPriceMove" name="searchStartPrice" value="${searchVo.searchStartPrice}"/>
		<input type="hidden" id="searchEndPriceMove" name="searchEndPrice" value="${searchVo.searchEndPrice}"/>
		<input type="hidden" id="resultStartPriceMove" name="resultStartPrice" value="${searchVo.resultStartPrice}"/>
		<input type="hidden" id="resultEndPriceMove" name="resultEndPrice" value="${searchVo.resultEndPrice}"/>
		<input type="hidden" id="searchTypeMove" name="searchType" />
		<input type="hidden" id="sCateShowMove" name="sCateShow" value="${searchVo.sCateShow}"/>
		<input type="hidden" id="menuActiveMove" name="menuActive" value="${searchVo.menuActive}"/>
		<input type="hidden" id="searchDisplayMove" name="searchDisplay" value="${searchVo.searchDisplay}"/>
		<c:forEach var="list" items="${searchVo.searchBrand }"  varStatus="w" >
	   		<input type="hidden" name="searchBrand" value="${list}" />
	   	</c:forEach>   
	   	<c:forEach var="list" items="${searchVo.searchPremium }"  varStatus="w" >
	   		<input type="hidden" name="searchPremium" value="${list}" />
	   	</c:forEach> 
	   	<c:forEach var="list" items="${searchVo.searchStore }"  varStatus="w" >
	   		<input type="hidden" name="searchStore" value="${list}" />
	   	</c:forEach> 
	   	<c:forEach var="list" items="${searchVo.searchDesigner }"  varStatus="w" >
	   		<input type="hidden" name="searchDesigner" value="${list}" />
	   	</c:forEach> 
	   	<c:forEach var="list" items="${searchVo.searchLcate }"  varStatus="w" >
	   		<input type="hidden" name="searchLcate" value="${list}" />
	   	</c:forEach> 
	   	<c:forEach var="list" items="${searchVo.searchMcate }"  varStatus="w" >
	   		<input type="hidden" name="searchMcate" value="${list}" />
	   	</c:forEach> 
	   	<c:forEach var="list" items="${searchVo.searchScate }"  varStatus="w" >
	   		<input type="hidden" name="searchScate" value="${list}" />
	   	</c:forEach> 
	</form>