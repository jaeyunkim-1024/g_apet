<%--
  Created by IntelliJ IDEA.
  User: ssh
  Date: 2021-03-29
  Time: 오후 7:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:forEach var="alarm" items="${ioAlarmList}">
	<c:set var="divCls" value="" />
	<c:if test="${alarm.salePsbCd == frontConstants.SALE_PSB_30}">
		<c:set var="divCls" value="cancel" />
	</c:if>
	<li>
		<div class="untcart ${divCls}">
			<div class="box">
				<div class="tops set-po1" name="contentArea" data-goods-id="${! empty alarm.pakGoodsId ? alarm.pakGoodsId : alarm.goodsId}">
					<div class="pic">
					<c:choose>
						<c:when test="${alarm.salePsbCd == frontConstants.SALE_PSB_30}">
							<div class="soldouts">
								<em class="ts"><spring:message code='front.web.view.common.goods.saleSoldOut.title' /></em>
							</div>
						</c:when>
						<c:when test="${alarm.salePsbCd == frontConstants.SALE_PSB_20}">
							<div class="soldouts">
								<em class="ts"><spring:message code='front.web.view.common.goods.saleEnd.title' /></em>
							</div>
						</c:when>
						<c:when test="${alarm.salePsbCd == frontConstants.SALE_PSB_10}">
							<div class="soldouts">
								<em class="ts"><spring:message code='front.web.view.common.goods.saleStop.title' /></em>
							</div>
						</c:when>
					</c:choose>
					<%--<c:if test="${alarm.salePsbCd == frontConstants.SALE_PSB_30}">
						<div class="soldouts">
							<em class="ts"><spring:message code='front.web.view.common.goods.saleSoldOut.title' /></em>
						</div>
					</c:if>--%>
						<img src="${frame:imagePath(alarm.imgPath)}" alt="${alarm.goodsNm}" class="img">
					</div>
					<div class="name">
						<div class="tit re-po-mb0">${alarm.goodsNm}</div>
							<div class="stt">
								<c:choose>
									<c:when test="${alarm.goodsCstrtTpCd eq frontConstants.GOODS_CSTRT_TP_ITEM || alarm.goodsCstrtTpCd eq frontConstants.GOODS_CSTRT_TP_SET}"></c:when>
									<c:when test="${alarm.goodsCstrtTpCd eq frontConstants.GOODS_CSTRT_TP_PAK}">${alarm.pakGoodsNm}</c:when>
									<c:otherwise>${alarm.attrVal }</c:otherwise>
								</c:choose>
								<%-- <c:if test="${alarm.attr1Val != null and alarm.attr1Val ne ''}">
									${alarm.attr1Val}
								</c:if>
								<c:if test="${alarm.attr2Val != null and alarm.attr2Val ne ''}">
									/ ${alarm.attr2Val}
								</c:if>
								<c:if test="${alarm.attr3Val != null and alarm.attr3Val ne ''}">
									/ ${alarm.attr3Val}
								</c:if>
								<c:if test="${alarm.attr4Val != null and alarm.attr4Val ne ''}">
									/ ${alarm.attr4Val}
								</c:if>
								<c:if test="${alarm.attr5Val != null and alarm.attr5Val ne ''}">
									/ ${alarm.attr5Val}
								</c:if> --%>
							</div>
						<c:choose>
							<c:when test="${alarm.salePsbCd == frontConstants.SALE_PSB_30}">
								<div class="state c4"><spring:message code='front.web.view.common.goods.saleSoldOut.title' /></div>
							</c:when>
							<c:when test="${alarm.salePsbCd == frontConstants.SALE_PSB_20}">
								<div class="state c4"><spring:message code='front.web.view.common.goods.saleEnd.title' /></div>
							</c:when>
							<c:when test="${alarm.salePsbCd == frontConstants.SALE_PSB_10}">
								<div class="state c4"><spring:message code='front.web.view.common.goods.saleStop.title' /></div>
							</c:when>
							<c:otherwise>
								<div class="state c3"><spring:message code='front.web.view.common.goods.count' /><c:out value="${alarm.webStkQty}"/><spring:message code='front.web.view.common.goods.count.number' /></div>
							</c:otherwise>
						</c:choose>
					</div>
					<!-- 2021.03.09 : 수정 -->
					<div class="right-area-pcver">
						<div class="gray-box-round">
							<div>
								<c:choose>
									<c:when test="${alarm.almYn eq 'Y'}"><frame:timestamp date="${alarm.almSndDtm}" dType="C"/><br /><spring:message code='front.web.view.common.goods.completed.alarm' /></c:when>
									<c:otherwise><frame:timestamp date="${alarm.sysRegDtm}" dType="C"/><br /><spring:message code='front.web.view.common.goods.request.alarm' /></c:otherwise>
								</c:choose>
							</div>
						</div>
						<c:set var="goodsIdStr" value="${alarm.goodsId}"/>
						<c:if test="${alarm.pakGoodsId != null and alarm.pakGoodsId ne ''}">
							<c:set var="goodsIdStr" value="${goodsIdStr}:${alarm.pakGoodsId}"/>
						</c:if>
						<button type="button" class="btn d close"
						        data-target="goods"
						        data-action="ioAlarmCancel"
						        data-content="${goodsIdStr}"
						        data-goodsId="${goodsIdStr}"
						>삭제</button>
					</div>
					<!-- // 2021.03.09 : 수정 -->
				</div>
			</div>
		</div>
	</li>
</c:forEach>
<c:choose>
	<c:when test="${totalPage > page}">
		<script>
//			$(document).ready(function(e) {
				$("#ioAlarmList").data("page", "${page}");
//			});
		</script>
	</c:when>
	<c:otherwise>
		<script>
//			$(document).ready(function(e) {
				$("#ioAlarmMoreLoad").parent().hide();
//			});
		</script>
	</c:otherwise>
</c:choose>
<!--
page: ${page}
totalPage: ${totalPage}
totalCount: ${totalCount}
-->
