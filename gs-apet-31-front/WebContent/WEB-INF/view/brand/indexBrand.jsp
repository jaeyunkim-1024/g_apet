<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<script type="text/javascript">

	function changeBrandTab(id) {
		$('.brand_tab li').removeClass("on");
		$('.brand_tab li').eq(id).addClass("on");
		
		$('.tab_content').hide();
		$('.tab_content').eq(id).show();
		
		if (id == 0)
			changeBrandCate(0);
		else if (id == 1)
			showCharBrand(0, 'all');
	}

	function changeBrandCate(id) {
		$('.sub_tab li').removeClass("on");
		$('.sub_tab li').eq(id).addClass("on");
		
		$('.sub_tab_content').hide();
		$('.sub_tab_content').eq(id).show();
	}
	
	function showCharBrand(id, charCd) {
		var initCharCd = "", html = "";
		
		<c:forEach items="${brandInitList}" var="list" varStatus="idx">		
			initCharCd = '${list.initCharCd}';
			
			if (charCd == 'all') {
				html += '<div class="init_brand">';
				html += '<strong>${list.initCharNm}</strong>';
				html += '		<ul>';
				
				<c:forEach items="${list.brandList}" var="brand">
				var brandNm = "";
				<c:if test="${list.initCharGbCd eq 'KO'}">brandNm = '${brand.bndNmKo}'</c:if>
				<c:if test="${list.initCharGbCd eq 'EN'}">brandNm = '${brand.bndNmEn}'</c:if>
				html += '			<li><a href="/brand/indexBrandDetail?bndNo=${brand.bndNo}">' + brandNm + '</a></li>';
				</c:forEach>
				
				html += '		</ul>';
				html += '</div><!-- //init_brand -->';
			}
			else {
				$(".init_list_wrap a").removeClass('active');
				if (initCharCd == charCd) {
					html += '<div class="init_brand">';
					html += '<strong>${list.initCharNm}</strong>';
					html += '		<ul>';
					
					<c:forEach items="${list.brandList}" var="brand">
					var brandNm = "";
					<c:if test="${list.initCharGbCd eq 'KO'}">brandNm = '${brand.bndNmKo}'</c:if>
					<c:if test="${list.initCharGbCd eq 'EN'}">brandNm = '${brand.bndNmEn}'</c:if>
					html += '			<li><a href="/brand/indexBrandDetail?bndNo=${brand.bndNo}">' + brandNm + '</a></li>';
					</c:forEach>
					
					html += '		</ul>';
					html += '</div><!-- //init_brand -->';
				}
			}
			
			<c:if test="${not empty list.brandList}">
			$("#"+initCharCd).removeClass("disabled");
			</c:if>
		</c:forEach>
		
		if (html == "")
			html = '<div class="init_brand no_data"><ul><li">브랜드가 존재하지 않습니다.</li></ul></div>';

		$('#init_result_list').html(html);
		
		$(".init_list_wrap a").parent("li").removeClass('active');
		if (charCd == 'all')
			$(".init_list_wrap .all").addClass('active');
		else
			$('#' + charCd).addClass('active');
		
	}
	
</script>
<!-- pop_contents -->
		<div class="pop_contents" id="pop_contents">
		<!-- pop_brand_wrap -->
			<div class="pop_brand_wrap">
			<c:if test="${topBrandList ne '[]'}">
				<!-- top_brand -->
				<dl class="top_brand">
					<dt>TOP Brand 5</dt>
					<dd>
						<ul>
						<c:forEach items="${topBrandList}" var="top" varStatus="idx">					
							<li><a href="/brand/indexBrandDetail?bndNo=${top.bnrMobileLinkUrl}"><c:out value="${top.bnrText}" /></a></li>
						</c:forEach>
						</ul>
					</dd>
				</dl><!-- //top_brand -->
			</c:if>
				<!-- brand_tab -->
				<ul class="brand_tab tab_func" >
					<li class="on"><a href="javascript:changeBrandTab(0);">카테고리</a></li>
					<li><a href="javascript:changeBrandTab(1);">초성검색</a></li>
				</ul>
				<!-- tab_content_wrap -->
				<div class="tab_content_wrap tab_con_wrap">
					<!-- tab_content cate -->
					<div class="tab_content cate">
						<ul class="sub_tab tab_func">
						<c:forEach items="${brandList}" var="brand" varStatus="idx">	
							<li <c:if test="${idx.first}">class="on"</c:if>><a href="javascript:changeBrandCate(${idx.index});"><c:out value="${brand.dispClsfNm}" /></a></li>
						</c:forEach>
						</ul>
						<!-- sub_tab_content_wrap -->
						<div class="sub_tab_content_wrap tab_con_wrap">
						<c:forEach items="${brandList}" var="brand" varStatus="idx">	
							<!-- sub_tab_content -->
							<div class="sub_tab_content">	
								<ul>
								<c:if test="${brand.seriesList ne '[]'}">
								<c:forEach items="${brand.seriesList}" var="series" varStatus="idx2">
									<li><a href="/brand/indexBrandDetail?bndNo=${series.bndNo}"><c:out value="${series.bndNm}" /></a></li>
								</c:forEach>
								</c:if>
								</ul>
							</div><!-- //sub_tab_content -->
						</c:forEach>
						</div><!-- //sub_tab_content_wrap -->
						
					</div><!-- //tab_content cate -->
					<!-- tab_content init -->
					<div class="tab_content init" style="display:none">
						<!-- init_list_wrap -->
						<div class="init_list_wrap">
							<a href="javascript:showCharBrand(0, 'all')" class="all active">All</a>
							<ul class="init_kr">
							<c:forEach items="${koInitList}" var="ko" varStatus="idx">
								<li id='${ko.dtlCd}' class="disabled"><a href="javascript:showCharBrand(${idx.index}+1, '${ko.dtlCd}');"><c:out value="${ko.dtlNm}" /></a></li>
							</c:forEach>
							</ul>
							<ul>
							<c:forEach items="${enInitList}" var="en" varStatus="idx">					
								<li id='${en.dtlCd}' class="disabled"><a href="javascript:showCharBrand(${idx.index}+1, '${en.dtlCd}');"><c:out value="${en.dtlNm}" /></a></li>
							</c:forEach>	
							</ul>
						</div><!-- //init_list_wrap -->
						<!-- init_brand_wrap -->
						<div class="init_brand_wrap" >
							<div id="init_result_list"></div>
						</div><!-- //init_brand_wrap -->
					</div><!-- //tab_content init -->
				</div><!-- //tab_content_wrap -->
			</div><!-- //pop_brand_wrap -->
		</div><!-- //pop_contents -->			
<script>
	function Tab(selector){
		this.tab; 
		this.tabContentWrap;
		this.init(selector); 
	}

	Tab.prototype.init=function(selector){
		this.tab=$(selector); 
		this.tabContentWrap = this.tab.next(".tab_con_wrap"); 
		this.eventDefine(); 
	}

	Tab.prototype.eventDefine=function(){
		var objThis=this; 
		this.tab.find("a").on("click", function(){
			objThis.tabRun($(this).parent().index()); 
		});
	}

	Tab.prototype.tabRun=function(id){
		var tabCon = this.tabContentWrap.children("div");
		this.tab.children("li").each(function(){
			if($(this).index() == id){
				tabCon.eq(id).show();
				$(this).addClass("on"); 
			}else{
				tabCon.eq($(this).index()).hide(); 
				$(this).removeClass("on"); 
			}
		});
	}

	//$(document).ready(function(){
		//$(".pop_contents .tab_func").each(function(){
		//	var tab=new Tab(this); 
		//});
		//showCharBrand(null, 0, 'all');
	//})
	
	
	
</script>			