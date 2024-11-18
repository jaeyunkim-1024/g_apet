<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %> 

<script type="text/javascript">

	$(document).ready(function(){
	}); // End Ready

	$(function() {

	});

	function confirmBwIstYn(){
		if($("input:checkbox[name=checkboxKnowledge]").is(":checked")){
			if(confirm("<spring:message code='front.web.view.goods.detail.confirm.bwIstYn' />")){
				<c:out value="${param.callBackFnc}" />("<c:out value="${param.bwIstYnGb}" />");
			}
		} else {
			alert('<spring:message code="front.web.view.agree.msg.checkbox.checked" />'); 
			$("input:checkbox[id=checkboxKnowledge]").focus();
			return;
		}
		pop.close("<c:out value="${param.popId}" />");
	}
	
</script>
<div id="pop_contents" class="deincont">
	<div>
		<img src="<c:out value="${view.imgPath}" />/common/antiFallDownBracketPopup.gif" alt="VECI 벽 고정 설치 필수 상품 안내" width="714" height="451" />
		
		<ul class="deinfo">
			<li class="t_left" style="padding:5px 0;">
				<label for="pro01"><input type="checkbox" class="mgl10" id="checkboxKnowledge" name="checkboxKnowledge" /> 위 내용을 숙지하였습니다.</label>
			</li>
		</ul>
		<div class="t_center" style="margin:10px 0;">
			<a href="#" class="btn_pop_type1" onclick="confirmBwIstYn()">동의</a>
			<a href="#" class="btn_pop_type2 mgl6" onclick="pop.close('<c:out value="${param.popId}" />');return false;">비동의</a>
		</div>
	</div>
</div>
<!-- //팝업 내용 -->
