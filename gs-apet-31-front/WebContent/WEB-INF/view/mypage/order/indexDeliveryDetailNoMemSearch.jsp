<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<script type="text/javascript">

	$(document).ready(function(){

	}); // End Ready

	$(function() {
		// 검색조건 Enter Key 이벤트
		$(".ord_ipt").keypress(function() {
			if ( window.event.keyCode == 13 ) {
				searchOrder();
			}
		});
	});

	/*
	 * 비회원 주문 조회
	 */
	function searchOrder(){
		if($("#login_ord_no").val() == ""){
			alert("주문번호를 입력해 주세요.");
			$("#login_ord_no").focus();
			return;
		}

		if($("#login_ord_password").val() == ""){
			alert("이메일주소를 입력해 주세요.");
			$("#login_ord_password").focus();
			return;
		}

		var options = {
				url : "<spring:url value='/mypage/order/checkNoMemOrder' />",
				data : $("#no_mem_order_form").serialize(),
				done : function(data){    
					jQuery("<form action=\"/mypage/order/indexDeliveryDetailNoMem\" method=\"get\"><input type=\"hidden\" name=\"ordNo\" value=\""+ $("#login_ord_no").val() +"\"/></form>").appendTo('body').submit();
				}
		};

		ajax.call(options);
	}

</script>

<div class="member_wrap" style="padding-top:0;border-top:none;">

	<div class="order_tracking_section" style="">
		<h2 class="login_title">비회원 주문조회</h2>
		<div class="input_area">
			<form id="no_mem_order_form">
			<input type="text" id="login_ord_no" name="ordNo" class="login_input1 ord_ipt" title="주문번호" placeholder="주문번호" />
			<input type="password" id="login_ord_password" name="ordrEmail" class="login_input2 ord_ipt" title="이메일주소" placeholder="이메일주소" />
			</form>
			<a href="#" class="btn_login2" onclick="searchOrder();return false;">조회</a>
		</div>
		<div class="add_text_box">
			<p>주문번호와 주문시 입력하신 이메일주소를 입력하신 후 조회 버튼을 눌러주세요.</p>
		</div>
	</div>
</div>