<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<script type="text/javascript">

	$(document).ready(function(){
	}); // End Ready

	$(function() {
		
	});
	
</script>

<div id="pop_contents">
	<iframe src="${pageContext.request.scheme}://b2c.goodsflow.com/dcg/Whereis.aspx?item_unique_code=${delivery.itemUniqueCode}" width="600" height="650" ></iframe>
</div>
<!-- //팝업 내용 -->

<!-- 버튼 공간 -->
<div class="pop_btn_section">
	<a href="#" class="btn_pop_type1" onclick="pop.close('<c:out value="${param.popId}" />');return false;">닫기</a>
</div>
<!-- //버튼 공간 -->