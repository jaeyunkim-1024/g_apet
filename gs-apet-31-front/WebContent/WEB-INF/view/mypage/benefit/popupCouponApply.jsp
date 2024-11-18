<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ page import="framework.common.constants.CommonConstants" %> 
 

<script type="text/javascript">

	$(document).ready(function(){
		$("input[name='input_style1']").focus();  
	}); // End Ready
	 
	function couponInsert(){
		var couponNo = $('#input_style1').val(); 
		//특수문자 방지
		//var sCouponNo = specialCharRemove(couponNo); 
		
		//1. 쿠폰번호 미입력시 ::: 쿠폰번호를 입력하여 주세요.
		if(couponNo == ""){
			alert("<spring:message code='front.web.view.mypage.benefit.coupon.apply.msg.insert' />");
			$("input[name='input_style1']").focus();
			return;
		}
		
		//2. 쿠폰번호 오류 체킹   ::: 쿠폰번호가 유효하지 않습니다. 다시 입력하여 주세요.  
		//3. 쿠폰등록이 정상처리된 경우   ::: callback처리?   쿠폰이 등록되었습니다. 
		couponApply(couponNo); 
	}
	
	function couponApply(sIsuSrlNo){ 	
		var options = {
				url : "<spring:url value='/mypage/benefit/popCouponApply' />",
				data : { isuSrlNo : sIsuSrlNo},
				done : function(data){  
					alert("<spring:message code='front.web.view.mypage.benefit.coupon.apply.insert.success' />");
					// 쿠폰 등록 팝업 CallBack 함수 호출 : cbcouponApply();
					<c:out value="${param.callBackFnc}" />();
					// 쿠폰 등록 팝업 닫기
					pop.close("<c:out value="${param.popId}" />");
				}
		};

		ajax.call(options);
	} 
	
	//정규식 특수문자 제거하기(sapce도 불가)
    function specialCharRemove(obj) {  
        var value = $(obj).val();  
   
        var pattern = /[^(가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9)]/gi;  
        if(pattern.test(value)){ 
        	alert('<spring:message code="front.web.view.claim.msg.insert.specialChar" />');
        	$(obj).val(value.replace(pattern,"")); 
        } 
        //return $(obj).val();
    }

	$(function() {
		
	});
 
</script> 
	
<div id="pop_contents">
					
	<div class="font_gray02">
		쿠폰번호를 등록하여 주세요.
	</div>
	<div class="mgt5 font_gray01">
		<ul>
			<li>
				<b>ㆍ</b>동일한 쿠폰은 중복등록이 불가능합니다.
			</li>
			<li>
				<b>ㆍ</b>쿠폰번호는 대소문자를 구분합니다.
			</li>
		</ul>
	</div>
	<div class="cash_receipts_box">
		<div>
			<span class="label_title">쿠폰번호 입력</span>
			<input type="text" class="input_style1" id="input_style1" name="input_style1" onkeyup="specialCharRemove(this);return false;" title="쿠폰번호" style="width:186px;" />
		</div>
	</div>

</div>
<!-- //팝업 내용 -->

<!-- 버튼 공간 -->
<div class="pop_btn_section">
	<a href="#" class="btn_pop_type1"  onclick="couponInsert();return false;">등록</a><a href="#" onclick="pop.close('<c:out value="${param.popId}" />');return false;" class="btn_pop_type2 mgl6">취소</a>
</div>
<!-- //버튼 공간 -->
