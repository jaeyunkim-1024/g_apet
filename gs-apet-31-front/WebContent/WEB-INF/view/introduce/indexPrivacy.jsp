<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %> 

<script type="text/javascript">

	$(document).ready(function(){
		var options = {
			url : "/introduce/privacy/getPrivacy",
			data : {policyNo : $("#privacy").val()},
			done : function(data) {
				$("#inputPrivacy").html(data.privacyCont);
			}
		};
		ajax.call(options);
	
	}); // End Ready
	
	
	/*
	* 개인정보취급방침 변경
	*/
	function chPrivacy() {
		$("#inputPrivacy")
		var options = {
			url : "<spring:url value='/introduce/privacy/getPrivacy' />",
			data : {policyNo : $("#privacy").val()},
			done : function(data) {
				$("#inputPrivacy").html(data.privacyCont);
			}
		};
		ajax.call(options);
	}
	
</script>

<h2 class="page_title2"><spring:message code='front.web.view.private.policy.title'/></h2>

<div class="search_top mgb10">
	<!-- select_box -->
	<div class="sel-box">
		<select id="privacy" name="privacy" class="sel-type">					
			<c:forEach items="${privacyList }" var="privacy">
				<option value="${privacy.policyNo }">${privacy.verInfo }</option>
			</c:forEach>		
		</select>
		<!-- 버튼 -->
		<a href="#" class="btn_h30_type4 mgl5" onclick="chPrivacy();return false;"><spring:message code='front.web.view.common.msg.confirmation'/></a>
		<!-- // 버튼 -->
	</div>
	<!-- //select_box -->				
</div>
<!-- scroll_box -->
<div class="scroll_box">
	<div class="scroll_contents" id="inputPrivacy">
	</div>
</div><!-- //scroll_box -->
