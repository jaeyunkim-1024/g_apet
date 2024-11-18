<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="subTabLayout">
    <t:putAttribute name="script">
        <script src="/js/member.js"></script>
        <script type="text/javascript">
            function fnCreateMemberCommentList(){
                var searchParam = {
                        mbrNo :"${so.mbrNo}"
                    ,   maskingUnlock : "${so.maskingUnlock}"
                };
                var options = {
                    url : "/member/listMemberReply.do"
                   	,	rowNum : 10
  					, 	rowList : [5]
                    ,   height : "${so.mbrNo}" != '' ? 330 : ''
                    ,   searchParam : searchParam
                    ,   colModels : [
                            {name:"aplySeq", hidden:true}
                        ,   {label :"번호" , name : "rowNum" , width:100 , align:"center"}
                        ,   {label :"구분" , name : "replyGbCd", width:100 , align:"center" , formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.REPLY_GB_CD }' showValue='false' />"}}
                        ,   {label :"콘텐츠 제목" , name:"ttl" ,  width:230 , align:"center" , formatter : function(cellvalue, options, rowObject){
                                if(cellvalue != null){
                                    cellvalue = cellvalue.replace(/\r+|\s+|\n+/gi,' ');
                                    var length = cellvalue.length;
                                    if(length > 20){
                                        cellvalue = cellvalue.substring(0,17) + "...";
                                    }
                                }
                                return cellvalue;
                            }}
                        ,   {label :"댓글 내용" , name:"aply", width:230 , align:"center", formatter : function(cellvalue, options, rowObject){
                                if(cellvalue != null){
                                    cellvalue = cellvalue.replace(/\r+|\s+|\n+/gi,' ');
                                    var length = cellvalue.length;
                                    if(length > 20){
                                        cellvalue = cellvalue.substring(0,17) + "...";
                                    }
                                }
                                return cellvalue;
                            }}
                        ,   {name:"rptpCnt", label : "신고수" ,width:80,align: "center"}
                        ,   {label : "등록일" , name:"sysRegDtm",width :150 , sortable:true, align :"center", formatter:gridFormat.date, dateformat:"yyyy.MM.dd"}
                        ,   {label :"상세" , width:100 , align:"center", formatter : function(cellvalue, options, rowObject){
                                var replyGbCd = rowObject.replyGbCd;
                                var html = "";
                                var onClick = "";
                                //어바웃펫 tv
                                if(replyGbCd == "${adminConstants.REPLY_GB_10}"){
                                    var aplySeq = rowObject.aplySeq;
                                    var loginId = rowObject.loginId;
                                    var rpl = rowObject.rpl;
                                    var rptpCnt = parseInt(rowObject.rptpCnt);
                                    onClick = rpl == null ? "petTv.detailLayerPop('"+aplySeq+"','"+loginId+"');" : "petTv.detailLayerPop('"+aplySeq+"','"+loginId+"','"+rpl+"');";
                                    if(rptpCnt > 0){
                                        onClick = "petTv.detailReportPop('"+aplySeq+"','"+loginId+"');";
                                    }
                                    
                                    html = "<button type='button' class='btn' onclick="+onClick+">상세</button>"
                                    
                                //이벤트는 답글 없음
                                }else if(replyGbCd == "${adminConstants.REPLY_GB_40}"){
                                	
									html = "";
								
                                }else{
                                    var petLogNo = rowObject.petLogNo;
                                    var contsStatCd = rowObject.contsStatCd;
                                    var snctYn = rowObject.snctYn;
                                    var petLogChnlCd = rowObject.petLogChnlCd;
                                    onClick = "petLog.detailLayerPop('"+petLogNo+"','"+contsStatCd+"','"+snctYn+"','"+petLogChnlCd+"');";
                                    
                                    html = "<button type='button' class='btn' onclick="+onClick+">상세</button>"
                                }
                                
                                return html;
                            }}
                        ,   {name:"petLogNo", hidden:true}
                        ,   {name:"contsStatCd", hidden:true}
                        ,   {name:"snctYn", hidden:true}
                        ,   {name:"petLogChnlCd", hidden:true}
                    ]
                    ,   paging : true
                    ,   loadComplete : function(res){
                            if("${so.mbrNo}" != '' && res.data.length == 0){
                                $("#memberCommentListPage_right div").html("<span class='red'>조회결과가 없습니다.</span>");
                            }
                    }
                };
                grid.create("memberCommentList",options);
            }
            //리로드
            function fnReloadMemberCommentList(){
                var searchParam = {
                        mbrNo :"${so.mbrNo}"
                    ,   maskingUnlock : "${so.maskingUnlock}"
                };
                var options = {
                    searchParam : searchParam
                };
                grid.reload("memberCommentList",options);
            }

            $(function(){
                fnCreateMemberCommentList();
            });
        </script>
    </t:putAttribute>
    <t:putAttribute name="content">
        <div class="mModule mt30">
            <table id="memberCommentList"></table>
            <div id="memberCommentListPage"></div>
        </div>
    </t:putAttribute>
</t:insertDefinition>
