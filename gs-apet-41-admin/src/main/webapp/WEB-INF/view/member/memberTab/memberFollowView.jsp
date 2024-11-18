<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="subTabLayout">
    <t:putAttribute name="script">
        <script type="text/javascript">
            var isEmptyFollwing = false;
            var isEmptyFollwer = false;

            function fnCreateMemberFollowerList(){
                var searchParam = {
                        mbrNoFollowed :"${so.mbrNo}"
                    ,   maskingUnlock : "${so.maskingUnlock}"
                };

                var options = {
                        url : "<spring:url value='/member/listFollowerMe.do' />"
                    ,	rowNum : 20
					, 	rowList : [20]
                    ,   height : "${so.mbrNo}" != '' ? 320 : ''
                    ,   searchParam : searchParam
                    ,   colModels : [
                           {label : "No" , name : "rowNum",width : 50 , align :"center"}
                        ,   {label : "관계" , name :"relation",width : 100 , align :"center" , formatter : function(rowId, val, rawObject, cm) {
                                    var rltCnt = parseInt(rawObject.rltCnt);
                                    return rltCnt > 0 ? "서로친구" : "-";
                                }
                            }
                        ,   {label : "회원ID" , name:"loginId",width : 150 , align :"center"}
                        ,   {label : "회원명" , name:"mbrNm",width : 100 , align :"center"}
                        ,   {label : "회원구분" , name:"mbrGbCd",width : 120 , align :"center" , formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.MBR_GB_CD}" />"}}
                        ,   {label : "상태" , name:"mbrStatCd",width : 120 , align :"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.MBR_STAT_CD}" />"}}
                        ,   {label : "회원가입일시" , name:"joinDtm",width : 150 , align :"center", formatter:gridFormat.date, dateformat:"yyyy.MM.dd"}
                        ,   {label : "반려동물수" , name:"petBaseCnt",width : 120 , align :"center"}
                        ,   {label : "최종접속일" , name:"lastLoginDtm",width :150 , align :"center", formatter:gridFormat.date, dateformat:"yyyy.MM.dd"}
                        ,   {label : "등록 일시" , name:"sysRegDtm",width :150 , sortable : true ,align :"center", formatter:gridFormat.date, dateformat:"yyyy.MM.dd"}
                    ]
                    ,   paging : true
                    ,   loadComplete : function(data){
                            if("${so.mbrNo}" != ''){
                                console.dir(data);
                                if(data.length == 0){
                                    $("#memberFollowerListPage_right div").html("<span class='red'>조회결과가 없습니다.</span>");
                                }
                            }
                    }
                };
                grid.create("memberFollowerList",options);
            }
            function fnCreateMemberFollowingList(){
                var searchParam = {
                        mbrNo :"${so.mbrNo}"
                    ,   maskingUnlock : "${so.maskingUnlock}"
                };
                var options = {
                    url : "<spring:url value='/member/listImFollowing.do' />"
                    ,	rowNum : 20
					, 	rowList : [20]
                    ,   height : 320
                    ,   searchParam : searchParam
                    ,   colModels : [
                           {label : "No" , name : "rowNum",width : 50 , align :"center"}
                        ,   {label : "관계" , name :"relation",width : 100 , align :"center" , formatter : function(rowId, val, rawObject, cm) {
                                    var rltCnt = parseInt(rawObject.rltCnt);
                                    return rltCnt > 0 ? "서로친구" : "-";
                                }
                            }
                        ,   {label : "회원ID" , name:"loginId",width : 150 , align :"center"}
                        ,   {label : "회원명" , name:"mbrNm",width : 100 , align :"center"}
                        ,   {label : "회원구분" , name:"mbrGbCd",width : 120 , align :"center" , formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.MBR_GB_CD}" />"}}
                        ,   {label : "상태" , name:"mbrStatCd",width : 120 , align :"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.MBR_STAT_CD}" />"}}
                        ,   {label : "회원가입일시" , name:"joinDtm",width : 150 , align :"center", formatter:gridFormat.date, dateformat:"yyyy.MM.dd"}
                        ,   {label : "반려동물수" , name:"petBaseCnt",width : 120 , align :"center"}
                        ,   {label : "최종접속일" , name:"lastLoginDtm",width :150 , align :"center", formatter:gridFormat.date, dateformat:"yyyy.MM.dd"}
                        ,   {label : "등록 일시" , name:"sysRegDtm",width :150 , sortable : true ,align :"center", formatter:gridFormat.date, dateformat:"yyyy.MM.dd"}
                    ]
                    ,   paging : true
                    ,   loadComplete : function(res){
                            if("${so.mbrNo}" != '' && res.data.length == 0){
                                $("#memberFollowingListPage_right div").html("<span class='red'>조회결과가 없습니다.</span>");
                            }
                    }
                };
                grid.create("memberFollowingList",options);
            }

            $(function(){
                fnCreateMemberFollowerList();

                $(document).on("change","[name='member-follow']",function(){
                    var gridId = $(this).val();
                    $(".gridDiv").hide();
                    $("#div-"+gridId).show();
                    if(gridId === "memberFollowerList"){
                        fnCreateMemberFollowerList();
                    }else{
                        fnCreateMemberFollowingList();
                    }
                });
            });
        </script>
    </t:putAttribute>
    <t:putAttribute name="content">
        <div class="mt30 center">
            <label class="fRadio">
                <input type="radio" name="member-follow" id="follwer" value="memberFollowerList" checked="checked"/>
                <span id="recommanded">팔로워</span>
            </label>
            <label class="fRadio">
                <input type="radio" name="member-follow" id="following" value="memberFollowingList"/>
                <span id="recommanding">팔로잉</span>
            </label>
        </div>

        <div class="mModule">
            <div class="gridDiv" id="div-memberFollowerList">
                <table id="memberFollowerList"></table>
                <div id="memberFollowerListPage"></div>
            </div>
            <div class="gridDiv" id="div-memberFollowingList" style="display:none;">
                <table id="memberFollowingList"></table>
                <div id="memberFollowingListPage"></div>
            </div>
        </div>
    </t:putAttribute>
</t:insertDefinition>