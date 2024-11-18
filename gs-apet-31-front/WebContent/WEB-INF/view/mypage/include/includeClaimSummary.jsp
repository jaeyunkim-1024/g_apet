<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>
<div class="order_state_box">
    <dl class="cell1">
        <dt><spring:message code='front.web.view.common.msg.return' /></dt>
        <dd>
            <ul class="process">
                <li>
                    <span><spring:message code='front.web.view.common.msg.apply' /></span>
                    <strong>
<c:if test="${claimSummary.rtnAcpt gt 0}">
                        <a href="/mypage/order/indexClaimList"></a>
</c:if>
                        ${claimSummary.rtnAcpt}
                    </strong>
                </li>
                <li>
                    <span><spring:message code='front.web.view.common.msg.processing' /></span>
                    <strong>
<c:if test="${claimSummary.rtnIng gt 0}">
                        <a href="/mypage/order/indexClaimList"></a>
</c:if>
                        ${claimSummary.rtnIng}
                    </strong>
                </li>
                <li>
                    <span><spring:message code='front.web.view.common.msg.completed' /></span>
                    <strong>
<c:if test="${claimSummary.rtnCmplt gt 0}">
                        <a href="/mypage/order/indexClaimList"></a>
</c:if>
                        ${claimSummary.rtnCmplt}
                    </strong>
                </li>
            </ul>
        </dd>
    </dl>
    <dl class="cell2">
        <dt>교환</dt>
        <dd>
            <ul class="process">
                <li>
                    <span><spring:message code='front.web.view.common.msg.apply' /></span>
                    <strong>
<c:if test="${claimSummary.exchgAcpt gt 0}">
                        <a href="/mypage/order/indexClaimList"></a>
</c:if>
                        ${claimSummary.exchgAcpt}
                    </strong>
                </li>
                <li>
                    <span><spring:message code='front.web.view.common.msg.processing' /></span>
                    <strong>
<c:if test="${claimSummary.exchgIng gt 0}">
                        <a href="/mypage/order/indexClaimList"></a>
</c:if>
                        ${claimSummary.exchgIng}
                    </strong>
                </li>
                <li>
                    <span><spring:message code='front.web.view.common.msg.completed' /></span>
                    <strong>
<c:if test="${claimSummary.exchgCmplt gt 0}">
                        <a href="/mypage/order/indexClaimList"></a>
</c:if>
                        ${claimSummary.exchgCmplt}
                    </strong>
                </li>
            </ul>
        </dd>
    </dl>
</div>
<div class="t_right mgt10 point3"><spring:message code='front.web.view.common.msg.list.of.recent.return.and.exchange.lists' /></div>