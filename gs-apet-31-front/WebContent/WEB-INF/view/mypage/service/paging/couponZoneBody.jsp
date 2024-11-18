<c:if test="${p le t and listSize ne 0}">
    <c:forEach var="coupon" items="${list}" varStatus="idx">
        <c:set var="unit" value="원" />
        <c:if test="${coupon.cpAplCd eq frontConstants.CP_APL_10}">
            <c:set var="unit" value="%" />
        </c:if>

        <li class="bubble_par ${coupon.cpDwYn eq frontConstants.COMM_YN_Y ? "disabled" : ""}"><!-- 2021.03.26 : "bubble_par" 클래스 추가 -->
            <div class="sale">
                <fmt:formatNumber value="${coupon.aplVal}" type="number" pattern="#,###,###"/>&nbsp;${unit} 할인
                <!-- alert : 웹용 -->
                <c:if test="${not empty fn:trim(coupon.notice) and not empty coupon.notice}" >
                    <div class="alert_pop" data-pop="popCpnGud" id="${coupon.cpNo}">
                        <div class="bubble_txtBox" style="width:267px;">
                            <div class="tit">이용 안내</div>
                            <div class="info-txt">
                                <ul id="${coupon.cpNo}_notice">
                                    <c:forEach var="nt" items="${coupon.notices}">
                                        <li>${nt}</li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </c:if>
                <!-- // alert -->
            </div>
            <!-- 03.29 수정 : 디자인 변경으로 인한 HTML 구조 변경 -->
            <p class="s-tit">${coupon.cpKindNm} 쿠폰</p>
            <p class="tit">${coupon.cpNm}</p>
            <!-- // 03.29 수정 : 디자인 변경으로 인한 HTML 구조 변경 -->

            <c:set var="minBuyAmt" value="${coupon.minBuyAmt}" />
            <c:if test="${empty minBuyAmt}">
                <c:set var="minBuyAmt" value="0" />
            </c:if>
            <c:set var="maxDcAmt" value="${coupon.maxDcAmt}" />
            <c:if test="${empty maxDcAmt}">
                <c:set var="maxDcAmt" value="0" />
            </c:if>

            <div class="bottom-item">
                <div class="txt">
                    <c:choose>
                        <c:when test="${minBuyAmt ne 0 and maxDcAmt ne 0}">
                            <p><fmt:formatNumber value="${minBuyAmt}" type="number" pattern="#,###,###"/> 원 이상 구매 시 / 최대 <fmt:formatNumber value="${maxDcAmt}" type="number" pattern="#,###,###"/> 원 할인</p>
                        </c:when>
                        <c:when test="${minBuyAmt ne 0 and maxDcAmt eq 0}">
                            <p><fmt:formatNumber value="${minBuyAmt}" type="number" pattern="#,###,###"/> 원 이상 구매 시</p>
                        </c:when>
                        <c:when test="${maxDcAmt ne 0}">
                            <p>최대 <fmt:formatNumber value="${maxDcAmt}" type="number" pattern="#,###,###"/> 원 할인</p>
                        </c:when>
                        <c:otherwise><p>&nbsp;</p></c:otherwise>
                    </c:choose>
                    <c:choose>
                        <c:when test="${coupon.vldPrdCd eq frontConstants.VLD_PRD_10}" >
                            <p>발급일로부터 ${coupon.vldPrdDay}일까지</p>
                        </c:when>
                        <c:when test="${coupon.vldPrdCd eq frontConstants.VLD_PRD_20}">
                            <p><fmt:formatDate value="${coupon.vldPrdStrtDtm}" pattern="yyyy-MM-dd HH:mm"/> ~ <fmt:formatDate value="${coupon.vldPrdEndDtm}" pattern="yyyy-MM-dd HH:mm"/></p>
                        </c:when>
                        <c:otherwise></c:otherwise>
                    </c:choose>
                </div>
            </div>
            <button class="btn-down" name="cp-down-btn" value="${coupon.cpNo}">
                쿠폰 다운로드
            </button>
        </li>
    </c:forEach>
</c:if>