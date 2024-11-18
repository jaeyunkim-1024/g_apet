<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="framework.common.constants.CommonConstants" %>

<form id="delivery_list_form">
	<input type="hidden" id="delivery_list_page" name="page" value="<c:out value="${orderSO.page}" />" />
	<input type="hidden" id="delivery_list_rows" name="rows" value="<c:out value="${orderSO.rows}" />" />
	<input type="hidden" id="delivery_list_totalPage"  value="<c:out value="${orderSO.totalPageCount}" />" />
	<input type="hidden" name="period" value="<c:out value="${orderSO.period}" />" />
	<input type="hidden" name="ordAcptDtmStart" value="<frame:timestamp date="${orderSO.ordAcptDtmStart}" dType="H" />" />
	<input type="hidden" name="ordAcptDtmEnd" value="<frame:timestamp date="${orderSO.ordAcptDtmEnd}" dType="H" />" />
	<input type="hidden" id="callAjaxdeliveryHtml" name="callAjaxdeliveryHtml" value="N" />
	<c:forEach items="${ orderSO.arrOrdDtlStatCd }" var="stut">
		<input type="hidden" name="arrOrdDtlStatCd"  value="${stut}" />
	</c:forEach>
</form>
<jsp:include page="/WEB-INF/view/mypage/order/include/includeDeliveryList.jsp"/><!-- 주문/배송 목록 include -->
