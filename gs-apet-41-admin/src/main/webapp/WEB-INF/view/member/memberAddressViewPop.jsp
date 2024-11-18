<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="popupLayout">
    <t:putAttribute name="script">
        <script type="text/javascript">
            function fnListMemberAddress(){
                var searchParam = {
                        mbrNo :"${member.mbrNo}"
                    ,   maskingUnlock : "${member.maskingUnlock}"
                };

                var options = {
                    url : "<spring:url value='/member/memberAddressListGrid.do' />"
                    , 	searchParam : searchParam
                    , 	paging : false
                    , 	colModels : [
                        //회원 번호
                        {name:"mbrNo", label:'<spring:message code="column.mbr_no" />', hidden:true}

                        //회원 배송지 번호
                        , {name:"mbrDlvraNo", label:'<spring:message code="column.mbr_dlvra_no" />', hidden:true,width:"100", align:"center"}

                        //구분 명
                        , {name:"gbNm", label:'<spring:message code="column.gb_nm" />', width:"100", align:"center"}

                        //별칭
                        , {label : "별칭",width:"100",align:"center"}

                        //수취인 명
                        , {name:"adrsNm", label:'<spring:message code="column.adrs_nm" />', width:"100", align:"center"}

                        //우편 번호
                        , {name:"postNoOld", label:'우편번호', width:"100", align:"center"}

                        //우편 주소
                        ,{name:"dtlAddr" , label:"우편주소",width:"350",align:"center"}

                        //휴대폰
                        , {name:"mobile", label:'<spring:message code="column.mobile" />', width:"150", align:"center" , formatter:gridFormat.phonenumber}

                        //등록자
                        , {name:"sysRegrNm", label:'<spring:message code="column.sys_regr_nm" />', width:"100", align:"center"}
                        //등록 일시
                        , {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_dtm" />', width:"140", align:"center", formatter:gridFormat.date, dateformat:"yyyy.MM.dd"}
                    ]
                };
                grid.create("memberAddressList",options);
            }
            $(function(){
                fnListMemberAddress();
            });
        </script>
    </t:putAttribute>
    <t:putAttribute name="content">
        <table class="table_type1">
            <tbody>
            <tr>
                <th>User-no</th>
                <td>${member.mbrNo}</td>

                <th>회원 구분</th>
                <td>
                     <span>
                        <frame:codeName grpCd="${adminConstants.MBR_GB_CD}" dtlCd="${member.mbrGbCd}" />
                    </span>
                </td>
            </tr>

            <tr>
                <th>회원명/ID</th>
                <td>
                        ${member.mbrNm} / ${member.loginId}
                </td>

                <th>상태</th>
                <td>
                   <span>
                        <frame:codeName grpCd="${adminConstants.MBR_STAT_CD}" dtlCd="${member.mbrStatCd}" />
                   </span>
                </td>
            </tr>

            <tr>
                <th>내/외국인</th>
                <td>
                    <span>
                        <frame:codeName grpCd="${adminConstants.NTN_GB}" dtlCd="${member.ntnGbCd}" />
                    </span>
                </td>

                <th>MDN</th>
                <td>
                        ${member.mobile}&nbsp;(<frame:codeName grpCd="${adminConstants.MOBILE_CD}" dtlCd="${member.mobileCd}" />)
                </td>
            </tr>
            </tbody>
        </table>

        <div class="mTitle mt30">
            <h2>배송지 목록</h2>
        </div>
        <table id="memberAddressList"></table>

        <div class="btn_area_center">
            <button type="button" onclick="closeTab();" class="btn btn-cancel">닫기</button>
        </div>
    </t:putAttribute>
</t:insertDefinition>