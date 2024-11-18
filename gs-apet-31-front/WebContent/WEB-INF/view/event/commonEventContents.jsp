<main class="container page comm event" id="container">
    <div class="inr">
        <!-- 본문 -->
        <div class="contents" id="contents">

            <section class="sect petTabContent mode_fixed leftTab hmode_auto"><!-- 2021.03.15 : mode_fixed, hmode_auto 클래스 추가 -->
                <ul class="uiTab line a">
                    <li class="active">
                        <a class="bt" href="javascript:;"><span><spring:message code='front.web.view.event.title.in.progress' /></span></a>
                    </li>
                    <li>
                        <a class="bt" href="javascript:;"><span><spring:message code='front.web.view.event.title.finish' /></span></a>
                    </li>
                    <!-- 2021.03.10 : 삭제
                    <li>
                        <a class="bt" href="javascript:;"><span>나의 참여내역</span></a>
                    </li>
                    -->
                </ul>

                <section class="sect event uiTab_content">
                    <ul class="list">
                        <!-- s : 진행중인 이벤트가 없을 때 -->
                        <c:if test="${eventIngListSize eq 0}">
                            <li class="nodata">
                                <div class="msg">
                                    <p class="txt"><spring:message code='front.web.view.event.msg.no.in.progress' /></p>
                                </div>
                            </li>
                        </c:if>
                        <!-- e : 진행중인 이벤트가 없을 때 -->

                        <!-- s : 진행중인 이벤트 리스트 -->
                        <c:if test="${eventIngListSize ne 0}">
                        	<li>
                        		<c:forEach var="ing" items="${eventIngList}">
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
							    </c:forEach>                     	
<%-- 								<jsp:include page="./include/eventListBody.jsp"/> --%>
							</li>
                        </c:if>
                        <!-- e : 진행중인 이벤트 리스트 -->

                        <!-- s : 종료된 이벤트가 없을 때 -->
                        <c:if test="${eventEndListSize eq 0}">
                            <li class="nodata">
                                <div class="msg">
                                    <p class="txt"><spring:message code='front.web.view.event.msg.no.end.event' /></p>
                                </div>
                            </li>
                        </c:if>
                        <!-- e : 종료된 이벤트가 없을 때 -->

                        <!-- s : 종료된 이벤트 리스트 -->
                        <c:if test="${eventEndListSize ne 0}">
                        	<li>
                        		<c:forEach var="end" items="${eventEndList}">
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
								                <%--<span class="name"><em class="dd">ë¹ì²¨ì ë°í :  <fmt:formatDate value="${dateString}" pattern="yyyy.MM.dd" /> </em></span>--%>
								            </a>
								        </div>
								    </div> 
							    </c:forEach>                       	
<%-- 								<jsp:include page="./include/eventEndListBody.jsp"/> --%>
							</li>
                        </c:if>
                        <!-- e : 종료된 이벤트 리스트 -->
                    </ul>
                </section>
            </section>
        </div>

    </div>
</main>

<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}" >
    <jsp:include page="/WEB-INF/tiles/include/floating.jsp">
    <jsp:param name="floating" value="" />
    </jsp:include>
 </c:if>