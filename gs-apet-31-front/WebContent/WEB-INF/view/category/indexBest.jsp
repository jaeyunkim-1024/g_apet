<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>
<%@ page import="framework.front.constants.FrontConstants" %>

<script type="text/javascript"  src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/jquery/jquery.slides.min.js" ></script>

<script type="text/javascript">

	$(document).ready(function(){
		loadCategoryBestGoodsList("", ""); 
	}); // End Ready
	
	function loadCategoryBestGoodsList(srchCtgNo, categoryId) { 
		  
		$('.main_box_menu li').removeClass('active'); 
		$(categoryId).parent('li').addClass('active');
		if (categoryId == null || categoryId == "undefined" || categoryId == '' ) {
			$("#allCategoryList").parent('li').addClass('active');
		}
		ajax.load(
			"category_best_goods_list", 
			"/goods/indexGoodsList", 
			{
				targetId : 'category_best_goods_list', 
				dispCornNo : '<c:out value='${dispCornNo}'/>',
				dispClsfNo : srchCtgNo, 
				ctgGb : 'BEST'
			}
		); 
	}
	 
	function openEventDetail(eventUrl){
		location.href = eventUrl;	
	}
	
</script>

<h2 class="newTitle">베스트</h2>
<!-- template col4 -->			
<div class="main_box">
	<div class="main_box_top t_center">
		<ul class="main_box_menu">
			<li class="active"><a href="#" id="allCategoryList" onclick="loadCategoryBestGoodsList();return false;"><span>전체</span></a></li>
			<c:forEach var="allCategorylist" items="${view.displayCategoryList}"  varStatus="categoryIndex"><c:if test="${allCategorylist.dispLvl eq FrontConstants.DISP_LVL_1}"> 
				<c:if test="${allCategorylist.dispClsfNo ne 100000144 and allCategorylist.dispClsfNo ne 100000146 }">
				<li><a href="#" id="category${categoryIndex.index}" onclick="loadCategoryBestGoodsList(<c:out value="${allCategorylist.dispClsfNo}"/>, this);return false;"><span>${allCategorylist.dispClsfNm }</span></a></li></c:if>
				</c:if>	
			</c:forEach>	
		</ul>
	</div>
	<div id="category_best_goods_list">
	</div>	
</div>	
