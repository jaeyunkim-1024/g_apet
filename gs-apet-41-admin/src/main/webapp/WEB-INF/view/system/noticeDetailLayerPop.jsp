<t:insertDefinition name="popupLayout">
    <t:putAttribute name="script">
        <script type="text/javascript">
            /* $(function(){
                EditorCommon.setSEditor('detail-contents','/noticeSend');
                $("#noticeDetailLayerPop_dlg-buttons .btn-cancel").hide();
                $("#noticeDetailLayerPop_dlg-buttons .btn-ok").text("닫기");
            }) */
        </script>
    </t:putAttribute>
    <t:putAttribute name="content">
        <table class="table_type1">
            <colgroup>
                <col width="13%"/>
                <col width="35%"/>
                <col width="13%"/>
            </colgroup>
            <tbody>
                <tr>
                    <th>수신자</th>
                    <td colspan="3">${vo.mbrNm}(${vo.loginId})</td>
                </tr>
                <tr>
                    <th>발송일</th>
                    <td colspan="3">${vo.sendReqTime}</td>
                </tr>
                <tr>
                    <th>발송방법</th>
                    <td>${vo.sndTypeNm}(${vo.receiverInfo})</td>

                    <th>발송결과</th>
                    <td>${vo.sndRstNm}</td>
                </tr>
                <tr>
                    <th>제목</th>
                    <td colspan="3">${vo.subject}</td>

                </tr>
                <tr>
                    <th>내용</th>
                    <td colspan="3">
                    	<img src="" />
                    	<c:choose>
                           <c:when test="${not empty vo.contents}">
								<textarea id="detail-contents" name="detail-contents" style="width:97%; height:300px;">${vo.contents}</textarea>
                           </c:when>
                           <c:otherwise>
                           		<textarea id="detail-contents" name="detail-contents" style="width:97%; height:300px;">
	                               <a href="${sndInfo['landingUrl']}">
	                                   <img src="${sndInfo['image']}" />
	                               </a>
	                            </textarea>
                           </c:otherwise>
                       	</c:choose>
                    </td>
                </tr>
            </tbody>
        </table>
    </t:putAttribute>
</t:insertDefinition>