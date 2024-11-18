<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<c:forEach items="${listAttrsSel}" var="obj" varStatus="objStatus">
<c:set var="goodsIdStr" value="${obj.goodsId}:${so.goodsId}"/>
	<li>
		<div class="unitSel">
			<a href="javascript:" class="box" onclick="javascript:fnOptionselect('${obj.attrNo}', '${obj.attrValNo}', '${obj.attrVal}', '${obj.goodsId}')">
				<div class="infs">
					<span class="lk" style="word-break:break-all;">${obj.attrVal}
						<c:if test="${obj.saleAmt ne ''}">
							<c:choose>
								<%-- ${goods.orgSaleAmt} --%>
								<c:when test="${obj.saleAmt > so.saleAmt}">
									(+<fmt:formatNumber value="${(obj.saleAmt - so.saleAmt)}" type="percent" pattern="#,###,###"/>원)
								</c:when>
								<c:when test="${obj.saleAmt < so.saleAmt}">
									(-<fmt:formatNumber value="${(so.saleAmt - obj.saleAmt)}" type="percent" pattern="#,###,###"/>원)
								</c:when>
							</c:choose>
						</c:if>
					</span>
				</div>
				<c:if test="${obj.saleAmt ne ''}">
					<div class="price">
						<c:if test="${obj.salePsbCd eq frontConstants.SALE_PSB_00}">
							<em class="p"><fmt:formatNumber type="number" value="${obj.saleAmt}" pattern="#,###,###"/></em><i class="w">원</i>
						</c:if>
						<c:if test="${obj.salePsbCd eq frontConstants.SALE_PSB_10}">
							<span class="bt sold">판매중지</span>
						</c:if>
						<c:if test="${obj.salePsbCd eq frontConstants.SALE_PSB_20}">
							<span class="bt sold">판매종료</span>
						</c:if>
						<c:if test="${obj.salePsbCd eq frontConstants.SALE_PSB_30}">
							<c:choose>
								<c:when test="${obj.ioAlmYn eq 'Y'}">
									<button type="button" class="bt alim" onClick="fnRegAlim(event, this);"
												data-target="goods"
										        data-action="ioAlarm"
										        data-goods-id="${goodsIdStr}"
										        data-content="${goodsIdStr}">입고알림</button>
								</c:when>
								<c:otherwise>
									<span class="bt sold"><spring:message code='front.web.view.common.goods.saleSoldOut.title'/></span>
								</c:otherwise>
							</c:choose>
						</c:if>
					</div>
				</c:if>
			</a>
		</div>
	</li>
</c:forEach>