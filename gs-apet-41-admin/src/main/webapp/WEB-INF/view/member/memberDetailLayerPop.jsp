<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="popupLayout">
    <t:putAttribute name="script">
        <script type="text/javascript">
            function fnUpdateRcvYn(formId,url){
                var data = $("#"+formId).serializeJson();
                data.infoRcvYn = data.infoRcvYn == data.beforeInfoRcvYn ? null : data.infoRcvYn;
                data.mkngRcvYn = data.mkngRcvYn == data.beforeMkngRcvYn ? null : data.mkngRcvYn;

                if(data.infoRcvYn == null && data.mkngRcvYn == null){
                    messager.alert("동의 여부 상태가 정상 변경되었습니다.","알림","알림",function(){
                        fnGetMemberBaseDetail();
                    });
                    return;
                }

                data.mbrNo = $("#hidden-field [name='mbrNo']").val();
                var options = {
                    url : "/member/updateMemberRcvYn.do"
                    ,   data : data
                    ,   callBack : function(result){
                            console.log(result.sysUpdDtm);
                            messager.alert("동의 여부 상태가 정상 변경되었습니다.","알림","알림",function(){
                                fnGetMemberBaseDetail();
                            });
                    }
                };
                ajax.call(options);
            }

            //SMS 보내기
            function fnSmsSend(data){
                data.sendPhone = "02-512-5293";
                var options = {
                    url : "<spring:url value='/member/smsListSend.do' />"
                    , data : data
                    , callBack : function(result){
                       console.dir(result);
                    }
                };
                ajax.call(options);
            }

            //이메일 보내기 - 현재 미사용
            function fnEmailSend(data){
                var arrEmailStr = [];
                arrEmailStr.push({
                    receiverNm : $(this).find("input[name=nm]").val()
                    , receiverEmail : $(this).find("input[name=email]").val()
                    , mbrNo  : $(this).find("input[name=mbrNo]").val()
                    , stId   : $(this).find("input[name=stId]").val()
                });

                var options = {
                    url : "<spring:url value='/member/emailListSend.do' />"
                    , data : {
                        emailTitle : $("#emailLayerForm #emailTitle").val()
                        , emailContent : $("#emailLayerForm #emailContent").val()
                        , arrEmailStr : JSON.stringify(arrEmailStr)
                    }
                    , callBack : function(result){
                        messager.alert(result.resultMessage, "Info", "info", function(){
                            layer.close("emailLayer");
                        });
                    }
                };
                ajax.call(options);
            }

            $(function(){
                $("#memberDetailLayer_dlg-buttons .btn-cancel").hide();
            })
        </script>
    </t:putAttribute>
    <t:putAttribute name="content">
        <style>
            .red-min{
                color: #bf4346;
                font-size: 10px;
                margin-left: 4px;
            }
        </style>
        <div class="mTitle mt30">
            <h2>고객 상세 정보</h2>
        </div>
        <table class="table_type1">
            <colgroup>
                <col width ="12%" />
                <col width ="18%" />
                <col width ="15%" />
                <col width ="15%" />
                <col width ="15%" />
            </colgroup>
            <tr>
                <th>User-no</th>
                <td>
                    <span id="span_mbrNo">${member.mbrNo}</span>
                </td>

                <th>회원 등급</th>
                <td>
                    <span>
                        <frame:codeName grpCd='${adminConstants.MBR_GRD_CD}' dtlCd='${member.mbrGrdCd}' />
                    </span>
                </td>

                <th>상태</th>
                <td>
                   <span><frame:codeName grpCd='${adminConstants.MBR_STAT_CD}' dtlCd='${member.mbrStatCd}' /></span>
                </td>
            </tr>
            <tr>
                <th>구분</th>
                <td>
                    <span><frame:codeName grpCd='${adminConstants.MBR_GB_CD}' dtlCd='${member.mbrGbCd}' /></span>
                </td>

                <th>가입 채널</th>
                <td>
                    <span><frame:codeName grpCd='${adminConstants.JOIN_PATH}' dtlCd='${member.joinPathCd}' defaultName="하루"/></span>
                </td>

                <th>소셜회원</th>
                <td>
                    <span id="span_">${not empty member.snsLnkNm ? member.snsLnkNm : '-'}</span>
                </td>
            </tr>
            <tr>
                <th>ID</th>
                <td>
                    ${member.loginId}
                </td>

                <th>이름</th>
                <td>
                    ${member.mbrNm}
                </td>

                <th>닉네임</th>
                <td>
                    <c:choose>
                        <c:when test="${not empty member.nickNm}">
                            ${member.nickNm}
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th>이메일</th>
                <td>
                    ${member.email}
                </td>

                <th>휴대폰 번호</th>
                <td>
                    ${member.mobile}
                </td>

                <th>성별</th>
                <td>
                    <c:choose>
                        <c:when test="${not empty member.gdGbCd}">
                            <span><frame:codeName grpCd='${adminConstants.GD_GB}' dtlCd='${member.gdGbCd}' /></span>
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th>생년월일</th>
                <td>
                    <c:choose>
                        <c:when test="${not empty member.birth}">
                            ${member.birth}
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>

                <th>내/외국인</th>
                <td>
                    <span><frame:codeName grpCd='${adminConstants.NTN_GB}' dtlCd='${member.ntnGbCd}' /></span>
                </td>

                <th>사이트 명</th>
                <td>
                    ${member.stNm}
                </td>
            </tr>
            <tr>
                <th>관심 주제</th>
                <td>
                   ${empty member.tags ? '관심 태그 없음' : member.tags }
                </td>

                <th>반려 동물</th>
                <td>
                    ${empty member.petSimpleInfo ? '등록된 반려동물 없음' : member.petSimpleInfo}
                </td>

                <th>보유 쿠폰</th>
                <td>
                    ${member.cpCnt} 매
                </td>
            </tr>
            <tr>
                <th>최초 가입일</th>
                <td>
                    <fmt:formatDate value="${member.joinDtm}" pattern="yyyy.MM.dd HH:mm:ss"/>
                </td>

                <th>통합회원 전환일</th>
                <td>
                    <c:choose>
                        <c:when test="${not empty member.gsptStartDtm}">
                            <span><fmt:formatDate value="${member.gsptStartDtm}" pattern="yyyy.MM.dd HH:mm:ss"/></span>
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>

                <th>최종 접속일</th>
                <td>
                    <c:choose>
                        <c:when test="${not empty member.lastLoginDtm}">
                            <span><fmt:formatDate value="${member.lastLoginDtm}" pattern="yyyy.MM.dd HH:mm:ss"/></span>
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th>주소</th>
                <td colspan="5">
                    <c:set var="addr" value="${member.maskingAddr}"/>
                        <%--                         <c:if test="${empty addr}"> --%>
                        <%--                             <c:set var="addr" value="${member.mbrDftDlvrPrclAddress}"/> --%>
                        <%--                         </c:if> --%>
                    <span>${empty addr ? '등록 된 주소지가 없습니다.' : addr }</span>
                </td>
            </tr>
        </table>

        <div class="mTitle mt30">
            <h2>약관 동의 현황</h2>
            <div class="buttonArea">
                <button type="button" onclick="fnUpdateRcvYn('mkngRcvYnForm');" class="btn btn-add">변경</button>
            </div>
        </div>
        <form id="mkngRcvYnForm">
            <input type="hidden" name="beforeMkngRcvYn" value="${member.mkngRcvYn}" />

            <table class="table_type1">
                <colgroup>
                    <col width="45%"/>
                </colgroup>
                <tr>
                    <th>마케팅 정보 수신 동의
                        <c:if test="${not empty member.mkngRcvYnHistDtm && member.mkngRcvYn == 'Y'}" >
                            <span class="red-min" id="mkngRcvDtm">(수신 동의:<fmt:formatDate value="${member.mkngRcvYnHistDtm}" pattern="yyyy.MM.dd"/>)</span>
                        </c:if>
                    </th>
                    <td>
                        <frame:radio name="mkngRcvYn" grpCd="${adminConstants.COMM_YN}" selectKey="${member.mkngRcvYn}" />
                    </td>
                </tr>
            </table>
        </form>

        <div class="mTitle mt30">
            <h2>PUSH 수신 현황</h2>
            <div class="buttonArea">
                <button type="button" onclick="fnUpdateRcvYn('infoRcvYnForm');" class="btn btn-add">변경</button>
            </div>
        </div>
        <form id="infoRcvYnForm">
            <input type="hidden" name="beforeInfoRcvYn" value="${member.infoRcvYn}" />
            <table class="table_type1">
                <colgroup>
                    <col width="45%"/>
                </colgroup>
                <tr>
                    <th>앱 푸시설정
                        <c:if test="${not empty member.infoRcvYnHistDtm && member.infoRcvYn == 'Y'}">
                            <span class="red-min" id="infoRcvDtm">
                                (수신 동의:<fmt:formatDate value="${member.infoRcvYnHistDtm}" pattern="yyyy.MM.dd"/>)
                            </span>
                        </c:if>
                    </th>
                    <td>
                        <frame:radio name="infoRcvYn" grpCd="${adminConstants.COMM_YN}" selectKey="${member.infoRcvYn}"/>
                    </td>
                </tr>
            </table>
        </form>
    </t:putAttribute>
</t:insertDefinition>