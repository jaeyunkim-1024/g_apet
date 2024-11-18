<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<script type="text/javascript">
var init = true;

$(document).ready(function(){
	init = true;
	var cateFix=new CateFix();
	loadGoodsList(""); 
});

$(window).bind('popstate', function() {
	loadGoodsList("");
});

function CateFix(){
	this.cateTab;
	this.marginGap; 
	this.init(); 
}

CateFix.prototype.init=function(){
	this.cateTab = $(".mainCate_tab_wrap"); 

	if(this.cateTab.length !=0){
		this.marginGap = Number(this.cateTab.css("margin-bottom").replace("px", "")); 
		var headerFixed = new ThatFixed(this.cateTab, {posY:45});
		this.eventDefine(); 
	}
}//init

CateFix.prototype.eventDefine=function(){
	var objThis=this; 
	$(".mainCate_sub").hide();
	
	$(window).scroll(function(){
		objThis.marginCheck();
	})

	$("ul.mainCate_tab li").on("click", function(){
		var activeTab = $(this).attr("rel");
		$("ul.mainCate_tab li").removeClass("active");
		$(this).addClass("active");
		$(".mainCate_sub").hide(); 
		$("#" + activeTab).fadeIn("fast"); 

		objThis.marginCheck("listClick"); 
		
		var dispClsfNo = $(this).attr("data");
		moveGoodsList(dispClsfNo);
	})
	
	$(".mainCate_sub span").click(function () {
		$(".mainCate_sub span").removeClass("active");
		$(this).addClass("active");

	});

}//eventDefine

CateFix.prototype.marginCheck=function(param){
	var marginT =this.marginGap + this.cateTab.height(); 
	var duration = (param)? "0.2s" : "0s"; 
	
	if(this.cateTab.hasClass("fixed")){
		$(".main_box").css({"margin-top" : marginT+"px", "transition-duration" : duration} ); 
	}else{
		$(".main_box").removeAttr("style"); 
	}
}

function loadGoodsList(dispClsfNo) { 
	var reqDispClsfNo = dispClsfNo;
	
	var data = history.state;
	
	var page = "1", inDealYn = "", inGroupYn = "", inFreeDlvrYn = "", inCouponYn = "", inSortType = "", inRows = "", inPos = 0;
	if (data != null && data != "") {
		page = data.page;
		inDealYn = data.dealYn;
		inGroupYn = data.groupYn;
		inFreeDlvrYn = data.freeDlvrYn;
		inCouponYn = data.couponYn;
		inSortType = data.sortType;
		inRows = data.rows;
		
		inPos = data.pos;
		reqDispClsfNo = data.dispClsfNo;
	}
	
	var selectMenu = checkGetMenuIndex(reqDispClsfNo).split(":");
	
	if (selectMenu[0] <= 0)
		$("ul.mainCate_tab li:eq(0)").addClass("active");
	else {
		$("ul.mainCate_tab li:eq("+selectMenu[0]+")").addClass("active");
		var subIndex = selectMenu[0]-1;
		var subDiv = $(".mainCate_sub_container div:eq("+subIndex+")");
		subDiv.show();

		if (selectMenu[1] >= 0)
			subDiv.children("span").filter(":eq("+selectMenu[1]+")").addClass("active");
	}
	
	ajax.load(
		"goods_list", 
		"/goods/indexGoodsList", 
		{
			targetId : 'goods_list', 
			compNo : '<c:out value='${comp.compNo}'/>',
			dispClsfNo : dispClsfNo, 
			ctgGb : 'NORMAL',
			page : page,
			dealYn : inDealYn, 
			groupYn : inGroupYn,
			freeDlvrYn : inFreeDlvrYn, 
			couponYn : inCouponYn, 
			sortType : inSortType,
			rows : inRows,
			pos : inPos
		},
		"",
		"loadDone"
	); 
}

function checkGetMenuIndex(dispClsfNo) {
	if (dispClsfNo == "")
		return "0:";
	
	var idx1 = -1, idx2 = -1;
	
	<c:forEach items="${cateList}" var="category" varStatus="idx">
	var cateNo = '${category.dispClsfNo}';
	if (cateNo == dispClsfNo) {
		idx1 = parseInt('${idx.index}')+1;
	}
		<c:forEach items="${category.subDispCateList}" var="sub" varStatus="idx2">	
		var cateNo2 = '${sub.dispClsfNo}';
		if (cateNo2 == dispClsfNo) {
			idx1 = parseInt('${idx.index}')+1;
			idx2 = '${idx2.index}';
		}
		</c:forEach>
	</c:forEach>
	
	return idx1 + ":" + idx2;
}

function loadDone() {
	if (!init) {
		var h = $(".top_area").height() + $(".mainCate_tab_wrap").outerHeight(true)
		var offset = $("#prod_list_show").offset();
		$('html, body').animate({scrollTop : offset.top - h }, 300);
	}
}

function moveGoodsList(dispClsfNo) {
	init = false;
	form.clear('goods_list_form');
	history.replaceState("", null, document.URL);
	loadGoodsList(dispClsfNo);
}
</script>

	<h2 class="newTitle">${comp.compNm }</h2>
	<!-- seller_main_wrap -->
	<div class="seller_main_wrap">
		<!-- seller_main_visual -->
		<div class="seller_main_visual">					
			<div class="seller_visual_info">
				<div class="shopBrand"><span>${comp.compNm}</span></div>
			</div>
		</div>
		<!-- // seller_main_visual -->
		<!-- seller_main_best -->
		<div class="seller_main_best">					
			<div class="list_col3 ty01">
				<ul>
				<c:forEach items="${goods}" var="o" varStatus="status">
					<li class="item">
						<p class="best_sec">BEST <span>${status.count}</span></p>
						<div class="img_sec over_link">
							<a href="/goods/indexGoodsDetail?goodsId=${o.goodsId}&amp;dispClsfNo=">
								<frame:goodsImage imgPath="${o.imgPath}" seq="${o.imgSeq}" goodsId="${o.goodsId}" size="${ImageGoodsSize.SIZE_70.size}" alt="${o.goodsNm}"/>
							</a>
							<div class="link_group">
								<div class="btn_area">
									<a href="/goods/indexGoodsDetail?goodsId=${o.goodsId}" class="btn_cover_move" title="상품 새창보기" target="_blank"><span>상품 새창보기</span></a>
									<a href="#" class="btn_cover_fav <c:if test='${o.interestYn eq "Y"}' >click</c:if>" title="위시리스트 추가" onclick="insertWish(this,'${o.goodsId}');return false;"><span>위시리스트 추가</span></a>
								</div>
								<div class="mask_link" onclick="location.href='/goods/indexGoodsDetail?goodsId=${o.goodsId}'"></div>
							</div>
						</div>
						<ul class="text_sec">								
							<li class="u_name"><a href="/goods/indexGoodsDetail?goodsId=${o.goodsId}&amp;dispClsfNo=">${o.goodsNm}</a> </li>
						</ul>
					</li>
				</c:forEach>
				</ul>
			</div>
		</div>
		<!-- // seller_main_best -->

	</div>
	<!-- // seller_main_wrap -->	
	
	<c:if test="${cateList ne '[]'}">
	<!-- mainCate_tab_wrap -->
	<div class="mainCate_tab_wrap">
		<div class="mainCate_tab_container">
			<!-- tab : mainCate_tab -->
			<ul class="mainCate_tab">
				<li rel="cateSubAll" data=""><a href="javascript:void(0)">전체</a></li>
				<c:forEach items="${cateList}" var="category" varStatus="idx">
				<li rel="cateSub${category.dispClsfNo}" data="${category.dispClsfNo}"><a href="javascript:void(0)">${category.dispClsfNm}</a></li>
				</c:forEach> 
			</ul>
			<!--// tab : mainCate_tab -->	
		</div>			
		<!-- tabCont : mainCate_sub  -->
		<div class="mainCate_sub_container">
			<c:forEach items="${cateList}" var="category" varStatus="idx">
			<div id="cateSub${category.dispClsfNo}" class="mainCate_sub">
				<c:forEach items="${category.subDispCateList}" var="sub" varStatus="idx2">	
				<span><a href="javascript:moveGoodsList('${sub.dispClsfNo}');">${sub.dispClsfNm}</a></span>
				</c:forEach>
			</div>
			</c:forEach>
		</div>
		<!-- // tabCont : mainCate_sub  -->
	</div>				
	</c:if>
	
	<!-- template col5 -->			
	<div id="prod_list_show" class="main_box">
		<div id="goods_list">
		</div>
	</div>	
	<!-- template col5 -->