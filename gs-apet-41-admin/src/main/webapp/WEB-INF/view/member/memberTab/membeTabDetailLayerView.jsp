<t:insertDefinition name="popupLayout">
    <t:putAttribute name="script">
        <script type="text/javascript">
            $(function(){
                EditorCommon.setSEditor('content', '/member/${path}');

                $("#memberTabDetailLayer_dlg-buttons .btn-cancel").hide();
            })
        </script>
    </t:putAttribute>
    <t:putAttribute name="content">
        <table class="table_type1">
            <tbody>
                <tr>
                    <th>등록일</th>
                    <td>
                        ${sysRegDtm}
                    </td>
                </tr>
                <c:if test="${not empty hits}">
                    <tr>
                        <th>조회수</th>
                        <td>
                                ${hits}
                        </td>
                    </tr>
                </c:if>

                <c:if test="${not empty gbCd}">
                    <tr>
                        <th>구분</th>
                        <td>
                            <frame:codeName grpCd="${grpCd}" dtlCd="${gbCd}" />
                        </td>
                    </tr>
                </c:if>

                <c:if test="${not empty report}">
                    <tr>
                        <th>신고수</th>
                        <td>
                            ${report}
                        </td>
                    </tr>
                </c:if>

                <c:if test="${not empty ttl}">
                    <tr>
                        <th>제목</th>
                        <td>
                                ${ttl}
                        </td>
                    </tr>
                </c:if>

                <tr>
                    <th>내용</th>
                    <td>
                        <textarea id="content" style="width:100%;">${content}</textarea>
                    </td>
                </tr>

                <c:if test="${not empty tags}">
                    <tr>
                        <th>태그</th>
                        <td>
                            ${tags}
                        </td>
                    </tr>
                </c:if>

                <c:if test="${not empty thumbNail}">
                    <tr>
                        <th>등록 컨텐츠</th>
                        <td>
                            <img src="${thumbNail}" />
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </t:putAttribute>
</t:insertDefinition>