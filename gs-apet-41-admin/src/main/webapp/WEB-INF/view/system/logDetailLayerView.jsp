<t:insertDefinition name="popupLayout">
    <t:putAttribute name="script">
        <script type="text/javascript">
            $(function(){
                var t = $("#target").text();
                if(t.length>27){
                    t = t.substring(0,20) + "...";
                    $("#target").text(t);
                }
            })
        </script>
    </t:putAttribute>
    <t:putAttribute name="content">
        <table class="table_type1">
            <colgroup>
                <col width="15%"/>
                <col width="26%"/>
                <col width="13%"/>
                <col width="20%"/>
                <col width="13%"/>
            </colgroup>
            <tr>
                <th>접속자(ID)</th>
                <td>
                    ${vo.usrNm}(${vo.adminLoginId})
                </td>

                <th>접속지 IP</th>
                <td>${vo.ip}</td>

                <th>접속 일시</th>
                <td>
                    <fmt:formatDate value="${vo.acsDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
            </tr>
            <tr>
                <th>접근 화면</th>
                <td>
                        ${vo.menuPath}
                </td>

                <th>화면 URL</th>
                <td colspan="3"> ${vo.url}</td>
            </tr>

            <tr>
                <th>처리 대상자</th>
                <td>
                    <c:choose>
                        <c:when test="${not empty vo.mbrNo}">
                            <span id="target">${vo.mbrNm}(${vo.loginId})</span>
                        </c:when>
                        <c:otherwise>
                            <span id="target">전체 목록 조회</span>
                        </c:otherwise>
                    </c:choose>
                </td>

                <th>수행 업무</th>
                <td colspan="3">${vo.inqrGbNm}</td>
            </tr>
            <tr>
                <th>처리한 정보주체 정보</th>
                <td ${vo.colGbCd eq adminConstants.COL_GB_00 ? ' colspan="5" ' : ''}>
                    <span>${vo.colGbNm}</span>
                </td>
                <c:if test="${vo.colGbCd ne adminConstants.COL_GB_00}">
                    <c:choose>
                        <c:when test="${vo.inqrGbCd eq adminConstants.INQR_GB_10}">
                            <th>정보 값</th>
                            <td colspan="3">
                                <span>
                                    <c:choose>
                                        <c:when test="${vo.colGbCd eq adminConstants.COL_GB_20}">
                                            <span><frame:codeName grpCd="${adminConstants.MBR_STAT_CD}" dtlCd="${vo.aplVal}" /></span>
                                        </c:when>
                                        <c:otherwise>
                                            ${vo.aplVal}
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </td>
                        </c:when>
                        <c:when test="${vo.inqrGbCd eq adminConstants.INQR_GB_20}">
                            <th>변경 전<br>변경후</th>
                            <td colspan="3">
                                <c:choose>
                                    <c:when test="${vo.colGbCd eq adminConstants.COL_GB_20}">
                                        <span><frame:codeName grpCd="${adminConstants.MBR_STAT_CD}" dtlCd="${fn:split(vo.aplVal,';')[0]}" /></span><br>
                                        <span><frame:codeName grpCd="${adminConstants.MBR_STAT_CD}" dtlCd="${fn:split(vo.aplVal,';')[1]}" /></span>
                                    </c:when>
                                    <c:otherwise>
                                        ${vo.aplVal}
                                    </c:otherwise>
                                </c:choose>

                            </td>
                        </c:when>
                        <c:when test="${vo.inqrGbCd eq adminConstants.INQR_GB_30}">
                            <th>정보 값</th>
                            <td colspan="3">
                                <c:choose>
                                    <c:when test="${vo.colGbCd eq adminConstants.COL_GB_20}">
                                        <span><frame:codeName grpCd="${adminConstants.MBR_STAT_CD}" dtlCd="${vo.aplVal}" /></span>
                                    </c:when>
                                    <c:otherwise>
                                        ${vo.aplVal}
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </c:when>
                        <c:otherwise></c:otherwise>
                    </c:choose>
                </c:if>
            </tr>
        </table>
    </t:putAttribute>
</t:insertDefinition>