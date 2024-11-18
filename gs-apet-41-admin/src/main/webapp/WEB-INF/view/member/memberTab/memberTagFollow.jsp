<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="subTabLayout">
    <t:putAttribute name="script">
        <script type="text/javascript">
            function fnCreateMemberTagList(){
                var searchParam = {
                        mbrNo :"${so.mbrNo}"
                };

                var options = {
                        url : "<spring:url value='/member/listMemberTagFollow.do' />"
                   	,	rowNum : 99
                   	,	rowList : [5]
                    ,   height : "${so.mbrNo}" != '' ? 800 : ''
                    ,   searchParam : searchParam
                    ,   colModels : [
                           {name : "tagNo", hidden:true}
                        ,   {label : "No" , name : "rowIndex", width:100 , align:"center"}
                        ,   {label : "Tag" , name : "tagNm",width:100 , align:"center"}
                        ,   {label : "팔로우 일시" , name:"sysRegDtm", sortable : true, width :150 , align :"center", formatter:gridFormat.date, dateformat:"yyyy.MM.dd"}
                    ]
                    ,   rowNum : 99
                    ,   paging : true
                    ,   loadComplete : function(res){
                            if("${so.mbrNo}" != '' && res.data.length == 0){
                                $("#memberTagFollowListPage_right div").html("<span class='red'>조회결과가 없습니다.</span>");
                            }
                    }
                };

                grid.create("memberTagFollowList",options);
            }
            $(function(){
                fnCreateMemberTagList();
            });
        </script>
    </t:putAttribute>
    <t:putAttribute name="content">
        <div class="mModule mt30">
            <table id="memberTagFollowList"></table>
            <div id="memberTagFollowListPage"></div>
        </div>
    </t:putAttribute>
</t:insertDefinition>