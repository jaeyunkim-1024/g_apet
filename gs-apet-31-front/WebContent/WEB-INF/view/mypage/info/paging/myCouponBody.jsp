<c:if test="${listMemberCouponSize ne 0}">
    <c:forEach var="cp" items="${listMemberCoupon}" varStatus="idx">
        <li class="bubble_par"><!-- 2021.03.26 : "bubble_par" 클래스 추가 -->
            <div class="sale">
                <c:set var="cpUnit" value="원" />
                <c:if test="${cp.cpAplCd eq frontConstants.CP_APL_10}">
                    <c:set var="cpUnit" value="%" />
                </c:if>

                <fmt:formatNumber value="${cp.aplVal}" type="number" pattern="#,###,###"/>&nbsp;${cpUnit} 할인
                <c:if test="${not empty fn:trim(cp.notice) and not empty cp.notice}" >
                    <div class="alert_pop" data-pop="popCpnGud" id="${cp.cpNo}">
                        <div class="bubble_txtBox" style="width:267px;">
                            <div class="tit">이용안내</div>
                            <div class="info-txt">
                                <ul class="cp-notice-list" id="${cp.cpNo}_notice">
                                    <c:forEach var="nt" items="${cp.notices}">
                                        <li>${nt}</li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
            <p class="s-tit">${cp.cpKindNm}쿠폰</p>
            <p class="tit">${cp.cpNm}</p>
            <div class="bottom-item">
                <c:set var="cpMinBuyAmt" value="${cp.minBuyAmt}" />
                <c:if test="${empty cpMinBuyAmt}">
                    <c:set var="cpMinBuyAmt" value="0" />
                </c:if>
                <c:set var="cpMaxDcAmt" value="${cp.maxDcAmt}" />
                <c:if test="${empty cpMaxDcAmt}">
                    <c:set var="cpMaxDcAmt" value="0" />
                </c:if>

                <div class="txt">
                    <c:set var="leftDays" value="${cp.leftDays}일 남음"/>
                    <c:if test="${cp.leftDays eq 0}">
                        <c:set var="leftDays" value="오늘 종료"/>
                    </c:if>

                    <c:choose>
                        <c:when test="${cpMinBuyAmt ne 0 and cpMaxDcAmt ne 0}">
                            <p><fmt:formatNumber value="${cpMinBuyAmt}" type="number" pattern="#,###,###"/> 원 이상 구매 시 / 최대 <fmt:formatNumber value="${cpMaxDcAmt}" type="number" pattern="#,###,###"/> 원 할인</p>
                            <p><fmt:formatDate value="${cp.useStrtDtm}" pattern="yyyy-MM-dd HH:mm"/> ~ <fmt:formatDate value="${cp.useEndDtm}" pattern="yyyy-MM-dd HH:mm"/><span class="cupon">${leftDays}</span></p>
                        </c:when>
                        <c:when test="${cpMinBuyAmt ne 0}">
                            <p><fmt:formatNumber value="${cpMinBuyAmt}" type="number" pattern="#,###,###"/> 원 이상 구매 시</p>
                            <p><fmt:formatDate value="${cp.useStrtDtm}" pattern="yyyy-MM-dd HH:mm"/> ~ <fmt:formatDate value="${cp.useEndDtm}" pattern="yyyy-MM-dd HH:mm"/><span class="cupon">${leftDays}</span></p>
                        </c:when>
                        <c:when test="${cpMaxDcAmt ne 0}">
                            <p>최대 <fmt:formatNumber value="${cpMaxDcAmt}" type="number" pattern="#,###,###"/> 원 할인</p>
                            <p><fmt:formatDate value="${cp.useStrtDtm}" pattern="yyyy-MM-dd HH:mm"/> ~ <fmt:formatDate value="${cp.useEndDtm}" pattern="yyyy-MM-dd HH:mm"/><span class="cupon">${leftDays}</span></p>
                        </c:when>
                        <c:otherwise>
                            <p><fmt:formatDate value="${cp.useStrtDtm}" pattern="yyyy-MM-dd HH:mm"/> ~ <fmt:formatDate value="${cp.useEndDtm}" pattern="yyyy-MM-dd HH:mm"/><span class="cupon">${leftDays}</span></p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </li>
    </c:forEach>
</c:if>