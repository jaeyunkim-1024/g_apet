<c:forEach var="ing" items="${eventIngList}">
<li id="event-ing-list">
    <div class="gdset event" id="${ing.eventNo}" onclick="window.location.href ='/event/detail?eventNo=${ing.eventNo}'">
        <div class="thum">
            <a href="javascript:;" class="pic">
                <img class="img pc" src="${frame:optImagePath(ing.dlgtImgPath,frontConstants.IMG_OPT_QRY_778)}" alt="<spring:message code='front.web.view.common.msg.image' />">
                <img class="img mo" src="${frame:optImagePath(ing.dlgtImgPath,frontConstants.IMG_OPT_QRY_744)}" alt="<spring:message code='front.web.view.common.msg.image' />">
            </a>
        </div>
        <div class="boxs">
            <div class="tit"><a href="javascript:;" class="lk">${ing.ttl}</a></div>
            <a href="javascript:;" class="inf">
                <span class="date">
                    <em class="dd" style="color:black;"><fmt:formatDate value="${ing.aplStrtDtm}" pattern="yyyy.MM.dd"/> ~ <fmt:formatDate value="${ing.aplEndDtm}" pattern="yyyy.MM.dd"/></em>
                    <c:if test="${ing.leftDays le 7}">
                        <i class="dn">D-${ing.leftDays}</i>
                    </c:if>
                </span>
                <c:if test="${ing.aplyUseYn eq frontConstants.COMM_YN_Y}">
                    <span class="repy"><em class="n">${ing.aplyCnt}</em></span>
                </c:if>
            </a>
        </div>
    </div>
</li>
</c:forEach>