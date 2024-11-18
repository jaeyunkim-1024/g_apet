<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="popupLayout">
    <t:putAttribute name="script">
        <script type="text/javascript">
            //회원 MDN 변경 이력
            function fnMemberMdnHistoryList(){
                var searchParam = $("#hidden-field").serializeJson();
                var options = {
                        url : "<spring:url value='/member/listMemberMdnChangeHistory.do' />"
                    , 	searchParam : searchParam
                    , 	paging : true
                    , 	colModels : [
                            {name : "histNo" , label : "No" , width:"100",align:"center"}
                        ,	{name : "histStrtDtm" ,label:'변경일', key:true , sortable : true, width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy.MM.dd" }
                        ,	{name : "mobile" ,label:'전화번호', width:"150", align:"center" , formatter:gridFormat.phonenumber }
                        ,	{name : "mobileCd" ,label:'통신사', width:"150", align:"center" , formatter:"select"
                            , editoptions:{ value:"<frame:gridSelect grpCd='${adminConstants.MOBILE_CD}'/>"}
                        }
                        ,	{name : "mbrNm" , label:'휴대폰 명의자', width:"150", align:"center" }
                    ]
                    ,   loadComplete : function(){
                            $("#memberMobileHistoryLayer_dlg-buttons .btn-cancel").hide();
                    }
                };
                grid.create("memberInfoGridList",options);
            }

            //회원의 사용가능한 쿠폰
            function fnMemberCouponPossibleListGrid(){
                var options = {
                    url : "<spring:url value='/member/memberCouponPossibleListGrid.do' />"
                    , height : 265
                    , searchParam : { mbrNo : '${member.mbrNo }' }
                    , colModels : [
                        {name:"cpNo", label:'<spring:message code="column.cp_no" />', width:"80", align:"center", formatter:'integer'}
                        , {name:"cpNm", label:'<spring:message code="column.cp_nm" />', width:"200", align:"center"}
                        , {name:"cpDscrt", label:'<spring:message code="column.cp_dscrt" />', width:"300", align:"center" }
                        , {name:"mbrCpNo", label:'<spring:message code="column.mbr_cp_no" />', width:"90", align:"center"}
                        , {name:"sysRegrNm", label:'<spring:message code="column.sys_regr_nm" />', width:"100", align:"center"}
                        , {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_dtm" />', width:"140", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
                        , {name:"sysUpdrNm", label:'<spring:message code="column.sys_updr_nm" />', width:"100", align:"center"}
                        , {name:"sysUpdDtm", label:'<spring:message code="column.sys_upd_dtm" />', width:"140", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
                        , {name:"cpKindCd", label:'<spring:message code="column.cp_kind_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_KIND}" />"}}
                        , {name:"cpStatCd", label:'<spring:message code="column.cp_stat_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_STAT}" />"}}
                        , {name:"cpAplCd", label:'<spring:message code="column.dc_gb_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_APL}" />"}}
                        , {name:"cpTgCd", label:'<spring:message code="column.cp_tg_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_TG}" />"}}

                    ]
                    , grouping: true
                    , groupField: ["cpNo"]
                    , groupText: ["쿠폰번호"]
                    , groupOrder : ["desc"]
                    , groupCollapse: false
                    , groupColumnShow : [false]
                };

                grid.create("memberCouponPossibleList", options);
            }
            function reloadCsMemberCouponPossibleListGrid(){
                var options = {
                    searchParam : { mbrNo : "${member.mbrNo }" }
                };
				$("#memberCouponPossibleArea").show();
				$("#memberCouponCompletionArea").hide();
                grid.reload("memberCouponPossibleList", options);
            }

            //회원의 사용한 쿠폰
            function fnMemberCouponCompletionListGrid(){
                var options = {
                    url : "<spring:url value='/member/memberCouponCompletionListGrid.do' />"
                    , height : 265
                    , searchParam : { mbrNo : '${member.mbrNo}' }
                    , colModels : [
                        {name:"cpNo", label:'<spring:message code="column.cp_no" />', width:"80", align:"center", formatter:'integer'}
                        , {name:"cpNm", label:'<spring:message code="column.cp_nm" />', width:"200", align:"center"}
                        , {name:"cpDscrt", label:'<spring:message code="column.cp_dscrt" />', width:"300", align:"center" }
                        , {name:"mbrCpNo", label:'<spring:message code="column.mbr_cp_no" />', width:"90", align:"center"}
                        , {name:"sysRegrNm", label:'<spring:message code="column.sys_regr_nm" />', width:"100", align:"center"}
                        , {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_dtm" />', width:"140", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
                        , {name:"sysUpdrNm", label:'<spring:message code="column.sys_updr_nm" />', width:"100", align:"center"}
                        , {name:"sysUpdDtm", label:'<spring:message code="column.sys_upd_dtm" />', width:"140", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
                        , {name:"useDtm", label:'<spring:message code="column.use_dtm" />', width:"120", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
                        , {name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"120", align:"center"}
                        , {name:"cpKindCd", label:'<spring:message code="column.cp_kind_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_KIND}" />"}}
                        , {name:"cpStatCd", label:'<spring:message code="column.cp_stat_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_STAT}" />"}}
                        , {name:"cpAplCd", label:'<spring:message code="column.dc_gb_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_APL}" />"}}
                        , {name:"cpTgCd", label:'<spring:message code="column.cp_tg_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CP_TG}" />"}}

                    ]
                    , grouping: true
                    , groupField: ["cpNo"]
                    , groupText: ["쿠폰번호"]
                    , groupOrder : ["desc"]
                    , groupCollapse: false
                    , groupColumnShow : [false]
                };

                grid.create("memberCouponCompletionList", options);
            }
            function reloadCsMemberCouponCompleteListGrid(){
                var options = {
                    searchParam : { mbrNo : '${member.mbrNo}'}
                };
				$("#memberCouponPossibleArea").hide();
				$("#memberCouponCompletionArea").show();
                grid.reload("memberCouponCompletionList", options);
            }

            //회원 주소 목록
            function fnMemberAddressListGrid(){
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

                        //구분
                        , {name:"dftYn",label:"구분",width:"100",align:"center", formatter : function(cellvalue,options,rowObject){
                                var txt = "선택";
                                if(cellvalue == "${adminConstants.DFT_YN_Y}"){
                                    txt = "기본";
                                }
                                return txt;
                        }}
                        //별칭
                        , {name:"gbNm", label:"별칭", width:"100", align:"center"}

                        //수취인 명
                        , {name:"adrsNm", label:'<spring:message code="column.adrs_nm" />', width:"100", align:"center"}

                        //우편 번호
                        , {name:"postNoNew", label:'우편번호', width:"100", align:"center"}

                        //우편 주소
                        ,{name:"dtlAddr" , label:"우편주소",width:"350",align:"center"}

                        //휴대폰
                        , {name:"mobile", label:'<spring:message code="column.mobile" />', width:"150", align:"center" , formatter:gridFormat.phonenumber}

                        //등록자
                        , {name:"sysRegrNm", label:'<spring:message code="column.sys_regr_nm" />', width:"100", align:"center"}
                        //등록 일시
                        , {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_dtm" />', width:"140", align:"center", formatter:gridFormat.date, dateformat:"yyyy.MM.dd"}
                    ]
                    , loadComplete : function(){
                            $("#memberAddressLayer_dlg-buttons .btn-cancel").hide();
                    }
                };
                grid.create("memberAddressList",options);
            }

            //회원 간편 결제 상세 내역
            function fnMemberCardListGrid(){
                var searchParam = {
                        mbrNo :"${member.mbrNo}"
                    ,   maskingUnlock : "${member.maskingUnlock}"
                };
                var options = {
                    url : "<spring:url value='/member/memberCardListGrid.do' />"
                    , 	searchParam : searchParam
                    , 	paging : false
                    , 	colModels : [
                        {name : "prsnCardBillNo" , hidden : true}
                        ,   {name:"rowIndex",label:"No.", width:"80",align: "center"}
                        , {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_dtm" />', width:"140", align:"center", formatter:gridFormat.date, dateformat:"yyyy.MM.dd"}
                        , {name:"cardcNm", label:'카드사명', width:"140", align:"center"}
                        , {name:"cardNo", label:'카드번호', width:"140", align:"center"}
                        , {label:"삭제",align : "center" , formatter : function(cellvalue, options, rowObject){
                                return "<button class='btn' onclick='fnRemoveBillingCardInfo("+rowObject.prsnCardBillNo+")'>삭제</button>"
                        }}
                    ]
                };
                grid.create("memberCardListList",options);
            }
            function fnReloadMemberCardList(){
                var searchParam = {
                        mbrNo :"${member.mbrNo}"
                    ,   maskingUnlock : "${member.maskingUnlock}"
                };
                var options = {
                    searchParam :searchParam
                };
                grid.reload("memberCardListList",options);
            }
            //카드 삭제
            function fnRemoveBillingCardInfo(prsnCardBillNo){
                messager.alert("간편카드를 삭제하시겠습니까?","알림","Info",function(){
                    var options = {
                        url : "/member/card-delete.do"
                        ,   data : {mbrNo : "${member.mbrNo }" , prsnCardBillNo : prsnCardBillNo}
                        ,   callBack :function(result){
                            if(result.resultCode == "${adminConstants.NICEPAY_BILLING_DELETE_SUCCESS}"){
                                var cardCnt = parseInt($("#cardCnt").text()) - 1;
                                $("#cardCnt").text(cardCnt);
                                fnReloadMemberCardList();
                            }else{
                                messager.alert(result.resultMsg,"Info");
                            }
                        }
                    };
                    ajax.call(options);
                });
            }
            
            //우주코인 상세 내역
            function fnMemberSktmpListGrid(){
                var searchParam = {
                        mbrNo :"${member.mbrNo}"
                    ,   maskingUnlock : "${member.maskingUnlock}"
                };
                var options = {
                    url : "<spring:url value='/member/memberSktmpListGrid.do' />"
                    , 	searchParam : searchParam
                    ,	rowNum : 10
                    ,	paging : true
                    , 	colModels : [
                        {name : "cardInfoNo" , hidden : true}
                        , {name:"rowIndex",label:"No.", width:"115",align: "center"}
                        , {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_dt" />', width:"300", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
                        , {name:"viewCardNo", label:'우주멤버십번호', width:"550", align:"center"}
                    ]
                };
                grid.create("memberSktmpList", options);
            }

            $(function(){
                var type="${type}";

                if(type === "MDN"){
                    fnMemberMdnHistoryList();
                }
                if(type === "CP"){
                   $("#memberCpDiv .panel").css("width", $("#memberCpDiv").width());
                   fnMemberCouponCompletionListGrid();
                   fnMemberCouponPossibleListGrid();

                   $("#memberCouponCompletionArea").hide();

                   $("#memberCouponLayer_dlg-buttons .btn-cancel").hide();
                }
                if(type === "ADR"){
                   fnMemberAddressListGrid();
                }

                if(type==="CARD"){
                    fnMemberCardListGrid();
                }
                
                if(type==="SKTMP"){
                    fnMemberSktmpListGrid();
                }

                $(document).on("click","#memberCpDiv .tabs li",function(){
                    $("#memberCpDiv .tabs li").removeClass("tabs-selected");
                    $(this).addClass("tabs-selected");
                })
            })
        </script>
    </t:putAttribute>
    <t:putAttribute name="content">
        <table class="table_type1 mb30">
            <tbody>
            <tr>
                <th>User-no</th>
                <td>${member.mbrNo}</td>

                <th>회원 구분</th>
                <td>
                    <span>
                        ${member.mbrGbNm}
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
                    <span>${member.mbrStatNm}</span>
                </td>
            </tr>

            <tr>
                <th>내/외국인</th>
                <td>
                    <span>${member.ntnGbNm}</span>
                </td>

                <th>MDN</th>
                <td>
                        ${member.mobile}
                        <c:if test="${not empty member.mobileCd}">
                            ( ${member.mobileNm} )
                        </c:if>
                </td>
            </tr>
            </tbody>
        </table>

        <style>
            .custom-tabs-header{
                border-top-style: none;
                border-left-style: none;
                border-right-style: none;
                background: white;
            }
        </style>


        <c:choose>
            <c:when test="${type eq 'MDN'}">
                <!-- MDN 변경 이력 -->
                <div class="mModule">
                    <div class="mTitle mdnDiv">
                        <h2>변경 history</h2>
                    </div>
                    <table id="memberInfoGridList"></table>
                    <div id="memberInfoGridListPage"></div>
                </div>
            </c:when>
            <c:when test="${type eq 'CP'}">
                <!-- 회원 쿠폰 상세 -->
                <div id="memberCpDiv" style="margin-top:10px;">
                    <div class="tabs-header custom-tabs-header">
                        <div class="tabs-wrap">
                            <div style="background:white">
                                <ul class="tabs" style="height: 26px;">
                                    <li class="tabs-first tabs-selected" onclick="reloadCsMemberCouponPossibleListGrid();">
                                        <a href="javascript:;" class="tabs-inner" style="height: 25px; line-height: 25px;">
                                            <span class="tabs-title">회원 사용 가능 쿠폰</span>
                                            <span class="tabs-icon"></span>
                                        </a>
                                    </li>
                                    <li class="tabs-last" onclick="reloadCsMemberCouponCompleteListGrid();">
                                        <a href="javascript:;" class="tabs-inner" style="height: 25px; line-height: 25px;">
                                            <span class="tabs-title">회원 사용 완료 쿠폰</span><span class="tabs-icon"></span>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="tabs-panels mt10">
                        <div id="memberCouponPossibleArea" class="panel panel-htop">
                            <table id="memberCouponPossibleList"></table>
                            <div id="memberCouponPossibleListPage"></div>
                        </div>
                        <div id="memberCouponCompletionArea" class="panel panel-htop">
                            <table id="memberCouponCompletionList"></table>
                            <div id="memberCouponCompletionListPage"></div>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:when test="${type eq 'ADR'}">
                <!-- 회원 주소지 -->
                <div class="mModule mt30">
                    <div class="mTitle">
                        <h2>배송지 목록</h2>
                    </div>
                    <table id="memberAddressList"></table>
                    <div id="memberAddressListPage"></div>
                </div>
            </c:when>
            <c:when test="${type eq 'CARD'}">
                <div class="mModule mt30">
                    <div class="mTitle">
                        <h2>간편카드 등록 현황</h2>
                    </div>
                    <table id="memberCardListList"></table>
                    <div id="memberCardListListPage"></div>
                </div>
            </c:when>
            <c:when test="${type eq 'SKTMP'}">
                <div class="mModule mt30">
                    <div class="mTitle">
                        <h2>우주코인 등록 현황</h2>
                    </div>
                    <table id="memberSktmpList"></table>
                    <div id="memberSktmpListPage"></div>
                </div>
            </c:when>
            <c:otherwise></c:otherwise>
        </c:choose>

    </t:putAttribute>
</t:insertDefinition>
