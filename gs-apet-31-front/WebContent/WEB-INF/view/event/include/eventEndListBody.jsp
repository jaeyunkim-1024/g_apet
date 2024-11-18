<c:forEach var="end" items="${eventEndList}">
<li id="event-end-list">
    <div class="gdset event" id="${end.eventNo}" onclick="window.location.href ='/event/detail?eventNo=${end.eventNo}'">
        <div class="thum">
            <a href="javascript:;" class="pic">
                <img class="img pc" src="${frame:optImagePath(end.dlgtImgPath,frontConstants.IMG_OPT_QRY_778)}" alt="<spring:message code='front.web.view.common.msg.image' />">
                <img class="img mo" src="${frame:optImagePath(end.dlgtImgPath,frontConstants.IMG_OPT_QRY_744)}" alt="<spring:message code='front.web.view.common.msg.image' />">
            </a>
        </div>
        <div class="boxs">
            <div class="tit"><a href="javascript:;" class="lk" style="color:#9a9a9a;">${end.ttl}</a></div>
            <a href="javascript:;" class="inf">
                <span class="date">
                    <em class="dd"><fmt:formatDate value="${end.aplStrtDtm}" pattern="yyyy.MM.dd"/> ~ <fmt:formatDate value="${end.aplEndDtm}" pattern="yyyy.MM.dd"/></em>
                    <i class="dn"><spring:message code='front.web.view.common.msg.finish' /></i>
                </span>
                <fmt:parseDate var="dateString" value="${end.winDt}" pattern="yyyy-MM-dd" />
                <%--<span class="name"><em class="dd">당첨자 발표 :  <fmt:formatDate value="${dateString}" pattern="yyyy.MM.dd" /> </em></span>--%>
            </a>
        </div>
    </div>
</li>
</c:forEach>