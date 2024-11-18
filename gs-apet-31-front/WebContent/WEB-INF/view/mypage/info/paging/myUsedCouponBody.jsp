<c:if test="${listMemberUsedCouponSize ne 0}">
    <c:forEach var="useCp" items="${listMemberUsedCoupon}" varStatus="idx">
        <li>
            <div class="sale">
                <c:set var="useCpUnit" value="원" />
                <c:if test="${useCp.cpAplCd eq frontConstants.CP_APL_10}">
                    <c:set var="useCpUnit" value="%" />
                </c:if>

                <fmt:formatNumber value="${useCp.aplVal}" type="number" pattern="#,###,###"/>&nbsp;${useCpUnit} 할인
                <c:if test="${not empty fn:trim(useCp.notice) and not empty useCp.notice}" >
                    <div class="alert_pop" data-pop="popCpnGud" id="${useCp.cpNo}">
                        <div class="bubble_txtBox" style="width:267px;">
                            <div class="tit">이용 안내</div>
                            <div class="info-txt">
                                <ul class="cp-notice-list" id="${useCp.cpNo}_notice">
                                    <c:forEach var="nt2" items="${useCp.notices}">
                                        <li>${nt2}</li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </c:if>
                <!-- // alert -->
                <!-- // 2021.03.09 : 추가 -->
            </div>
            <p class="s-tit">${useCp.cpKindNm}쿠폰</p>
            <p class="tit">${useCp.cpNm}</p>
            <div class="bottom-item t2">
                <div class="txt">
                    <c:set var="useMinBuyAmt" value="${useCp.minBuyAmt}" />
                    <c:if test="${empty useMinBuyAmt}">
                        <c:set var="useMinBuyAmt" value="0" />
                    </c:if>
                    <c:set var="useMaxDcAmt" value="${useCp.maxDcAmt}" />
                    <c:if test="${empty useMaxDcAmt}">
                        <c:set var="useMaxDcAmt" value="0" />
                    </c:if>
                    <c:set var="txt" value="기간종료"/>
                    <c:if test="${useCp.useYn eq frontConstants.COMM_YN_Y}">
                        <c:set var="txt" value="사용완료"/>
                    </c:if>

                    <c:choose>
                        <c:when test="${useMinBuyAmt ne 0 and useMaxDcAmt ne 0}">
                            <p><fmt:formatNumber value="${useMinBuyAmt}" type="number" pattern="#,###,###"/> 원 이상 구매 시 / 최대 <fmt:formatNumber value="${useMaxDcAmt}" type="number" pattern="#,###,###"/> 원 할인</p>
                            <p><fmt:formatDate value="${useCp.useStrtDtm}" pattern="yyyy-MM-dd HH:mm"/> ~ <fmt:formatDate value="${useCp.useEndDtm}" pattern="yyyy-MM-dd HH:mm"/><span class="cupon">${txt}</span></p>
                        </c:when>
                        <c:when test="${useMinBuyAmt ne 0}">
                            <p><fmt:formatNumber value="${useMinBuyAmt}" type="number" pattern="#,###,###"/> 원 이상 구매 시</p>
                            <p><fmt:formatDate value="${useCp.useStrtDtm}" pattern="yyyy-MM-dd HH:mm"/> ~ <fmt:formatDate value="${useCp.useEndDtm}" pattern="yyyy-MM-dd HH:mm"/><span class="cupon">${txt}</span></p>
                        </c:when>
                        <c:when test="${useMaxDcAmt ne 0}">
                            <p>최대 <fmt:formatNumber value="${useMaxDcAmt}" type="number" pattern="#,###,###"/> 원 할인</p>
                            <p><fmt:formatDate value="${useCp.useStrtDtm}" pattern="yyyy-MM-dd HH:mm"/> ~ <fmt:formatDate value="${useCp.useEndDtm}" pattern="yyyy-MM-dd HH:mm"/><span class="cupon">${txt}</span></p>
                        </c:when>
                        <c:otherwise>
                            <p><fmt:formatDate value="${useCp.useStrtDtm}" pattern="yyyy-MM-dd HH:mm"/> ~ <fmt:formatDate value="${useCp.useEndDtm}" pattern="yyyy-MM-dd HH:mm"/><span class="cupon">${txt}</span></p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </li>
    </c:forEach>
</c:if>