<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %> 

<%--
  Class Name  : indexCustomer.jsp 
  Description : 고객센터
  Author      : 신남원
  Since       : 2016.03.02
  Modification Information 
	          수정일         	     수정자             수정내용
    ----------  -------  -------------------------------------------
    2016.03.02    신남원            최초 작성
--%>

<script type="text/javascript">

	$(document).ready(function(){
	}); // End Ready

	$(function() {
	
	});
	
	/*
	 * 글 상세 이동.
	*/
	function goBbsLetterDetail(bbsId, lettNo, faqPage){
		
		var inputs = "";
		var action = "";
		
		if (bbsId == "dwFaq") {
			action = "/customer/faq/indexFaqList";
		} else if (bbsId == "dwNotice") {
			action = "/customer/notice/indexNoticeList";
		}
		inputs = "<input type=\"hidden\" name=\"bbsId\" value=\""+bbsId+"\"/><input type=\"hidden\" name=\"lettNo\" value=\""+lettNo+"\"/><input type=\"hidden\" name=\"page\" value=\""+faqPage+"\"/>";
		jQuery("<form action=\""+action+"\" method=\"post\">"+inputs+"</form>").appendTo('body').submit();
	}

</script>

<div class="box_title_area">
	<h3>고객센터</h3>
</div>

<div class="order_lookup_box">
	<dl>
		<dt>Quick Menu</dt>
		<dd>
			<div class="btn_period_group">
				<a href="/mypage/order/indexDeliveryList" class="btn_period fix_w149">주문/배송조회</a>
				<a href="/mypage/order/indexClaimRequestList" class="btn_period fix_w149">취소/반품/교환</a>
				<a href="/mypage/inquiry/indexRequest" class="btn_period fix_w149">1:1 문의하기</a>
				<a href="/mypage/info/indexManageCheck" class="btn_period fix_w149">회원정보 관리</a>
				<a href="/mypage/order/indexReceiptList" class="btn_period fix_w149">계산서/영수증 조회/신청</a>
			</div>
		</dd>
	</dl>
</div>

<div class="cus_delist mgt54">
	<div class="faqwrap">
		<h3>
			자주하는 질문 TOP 10
			
			<div class="btn_more">
				<a href="/customer/faq/indexFaqList" class="btn_h20_type5">더보기</a>
			</div>
		</h3>
		
		<ul>
			<c:forEach items="${faqTopList}" var="faqTop">
			<fmt:parseNumber var="pages" integerOnly="true" value="${faqTop.faqPage }" />
			<li>- <a href="#" onclick="goBbsLetterDetail('${faqTop.bbsId}','${faqTop.lettNo}', '${pages }');return false;"><c:out value='${faqTop.ttl}' /></a></li>
			</c:forEach>
		</ul>
	</div>
	
	<div class="notiwrap">
		<h3>
			공지사항
			
			<div class="btn_more">
				<a href="/customer/notice/indexNoticeList" class="btn_h20_type5">더보기</a>
			</div>
		</h3>
		
		<ul>
			<c:forEach items="${noticeList}" var="notice">
			<fmt:parseNumber var="pages" integerOnly="true" value="${notice.faqPage }" />
			<li>- <a href="#" onclick="goBbsLetterDetail('${notice.bbsId}', '${notice.lettNo}', '${pages }');return false;"><c:out value='${notice.ttl}' /></a></li>
			</c:forEach>
		</ul>
	</div>
</div>