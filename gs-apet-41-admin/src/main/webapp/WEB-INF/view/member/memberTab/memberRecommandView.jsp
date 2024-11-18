<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<jsp:include page="/WEB-INF/include/common.jsp"/>
<t:insertDefinition name="subTabLayout">
    <t:putAttribute name="script">
        <script type="text/javascript">
            function fnCreateMemberRecommandedList(){
                var searchParam = $("#memberRecommandedSearchForm").serializeJson();
                var options = {
                    url : "<spring:url value='/member/listMemberRecommandedListGrid.do' />"
                    ,   height : "${so.mbrNo}" != '' ? 800 : ''
                    ,   searchParam : searchParam
                    ,   colModels : [
                            {label : "번호" , name:"rowIndex" ,width:100 , align: "center"}
                        ,    {label : "추천인ID" , name : "loginId",width:100 , align : "center"}
                        ,   {label : "추천인 명" , name : "mbrNm" , width:100 , align : "center"}
                        ,   {label : "회원 구분" , name : "mbrGbCd",width:100 , align : "center" , sortable : true, formatter:function(rowId, val, rawObject, cm){
                                return "<frame:codeName grpCd='${adminConstants.PAY_MEANS_CD}' dtlCd="+rawObject.mbrGbCd+" defaultName='-' /> ";
                            }}
                        ,   {label : "상태" , name : "mbrStatCd",width:100 , align : "center", formatter:function(rowId, val, rawObject, cm){
                                return "<frame:codeName grpCd='${adminConstants.MBR_STAT_CD}' dtlCd="+rawObject.mbrStatCd+" defaultName='-' /> ";
                            }}
                        ,   {label : "회원가입일시" , name:"joinDtm",width : 150 , align :"center", formatter:gridFormat.date, dateformat:"yyyy.MM.dd"}
                        ,   {label : "추천 일시" , name:"sysRegDtm", width:100 , align : "center", formatter:gridFormat.date, dateformat:"yyyy.MM.dd"}
                    ]
                    ,   paging: true
                    ,   loadComplete : function(res){
                            if("${so.mbrNo}" != '' && res.data.length == 0){
                                $("#memberRecommandedListPage_right div").html("<span class='red'>조회결과가 없습니다.</span>");
                            }
                    }
                };

                if(searchParam.mbrNo === ""){
                    options.url = null;
                    options.datatype = "local";
                }

                grid.create("memberRecommandedList",options);
            }

            function fnCreateMemberRecommandingList(){
                var searchParam = $("#memberRecommandingSearchForm").serializeJson();
                var options = {
                    url : "<spring:url value='/member/listMemberRecommandingListGrid.do' />"
                    ,   height : 800
                    ,   searchParam : searchParam
                    ,   colModels : [
                            {label : "번호" , name:"rowNum" ,width:100 , align: "center"}
                        ,   {label : "추천상대 ID" , name : "rcomLoginId",width:100 , align : "center"}
                        ,   {label : "추천상대 명" , name : "rcomMbrNm" , width:100 , align : "center"}
                        ,   {label : "회원 구분" , name : "mbrGbCd",width:100 , align : "center" , sortable : true, formatter:function(rowId, val, rawObject, cm){
                                return "<frame:codeName grpCd='${adminConstants.PAY_MEANS_CD}' dtlCd="+rawObject.mbrGbCd+" defaultName='-' /> ";
                            }}
                        ,   {label : "상태" , name : "mbrStatCd",width:100 , align : "center", formatter:function(rowId, val, rawObject, cm){
                                return "<frame:codeName grpCd='${adminConstants.MBR_STAT_CD}' dtlCd="+rawObject.mbrStatCd+" defaultName='-' /> ";
                            }}
                        ,   {label : "회원가입일시" , name:"joinDtm",width : 150 , align :"center", formatter:gridFormat.date, dateformat:"yyyy.MM.dd"}
                        ,   {label : "추천 일시" , name:"sysRegDtm", width:100 , align : "center", formatter:gridFormat.date, dateformat:"yyyy.MM.dd"}
                    ]
                    ,   paging: true
                    ,   loadComplete : function(res){
                            if("${so.mbrNo}" != '' && res.data.length == 0){
                                $("#memberRecommandingListPage_right div").html("<span class='red'>조회결과가 없습니다.</span>");
                            }
                    }
                };

                grid.create("memberRecommandingList",options);
            }
            function fnGridReload(){

            }

            $(function(){
                fnCreateMemberRecommandedList();

                $(document).on("change","[name='member-recommand']",function(){
                    var gridId = $(this).val();
                    $(".gridDiv").hide();
                    $("#div-"+gridId).show();
                    if(gridId === "memberRecommandedList"){
                        fnCreateMemberRecommandedList();
                    }else{
                        fnCreateMemberRecommandingList();
                    }
                });
            });
        </script>
    </t:putAttribute>
    <t:putAttribute name="content">
        <div class="mt30 center">
            <label class="fRadio">
                <input type="radio" name="member-recommand" id="recommanded" value="memberRecommandedList" checked="checked"/>
                <span>추천 받음</span>
            </label>
            <label class="fRadio">
                <input type="radio" name="member-recommand" id="recommanding" value="memberRecommandingList"/>
                <span>추천 함</span>
            </label>
        </div>

        <div class="mModule">
            <div class="gridDiv" id="div-memberRecommandedList">
                <form id="memberRecommandedSearchForm" style="display:none;">
                    <input type="text" name="mbrNo" value = "${so.mbrNo}" />
                    <input type="text" name="maskingUnlock" value = "${so.maskingUnlock}" />
                    <input type="text" name="recommandGbCd" value = "${adminConstants.RECOMMAND_GB_10}" />
                </form>
                <table id="memberRecommandedList"></table>
                <div id="memberRecommandedListPage"></div>
            </div>
            <div class="gridDiv" id="div-memberRecommandingList" style="display:none;">
                <form id="memberRecommandingSearchForm" style="display:none;">
                    <input type="text" name="mbrNo" value = "${so.mbrNo}" />
                    <input type="text" name="maskingUnlock" value = "${so.maskingUnlock}" />
                    <input type="text" name="recommandGbCd" value = "${adminConstants.RECOMMAND_GB_20}" />
                </form>
                <table id="memberRecommandingList"></table>
                <div id="memberRecommandingListPage"></div>
            </div>
        </div>
    </t:putAttribute>
</t:insertDefinition>



