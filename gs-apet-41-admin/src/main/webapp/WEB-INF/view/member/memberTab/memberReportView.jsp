<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="subTabLayout">
    <t:putAttribute name="script">
        <script src="/js/member.js"></script>
        <script type="text/javascript">
            var petLogAplySeq;

            function fnCreateMemberReportList(){
                var searchParam = {
                        mbrNo :"${so.mbrNo}"
                };

                var options = {
                        url : "<spring:url value='/member/listMemberReport.do' />"
                    ,	rowNum : 5
					, 	rowList : [5]
                    ,   height : "${so.mbrNo}" != '' ? 330 : ''
                    ,   searchParam : searchParam
                    ,   colModels : [
                            {label : "번호" , name : "rowIndex", width:100 , align:"center"}
                        ,   {label :"구분" , name : "replyGbCd", width:100 , align:"center" , formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.REPLY_GB_CD }' showValue='false' />"}}
                        ,   {label :"콘텐츠 제목/상품명" , name:"ttl" ,  width:230 , align:"center", formatter : function(cellvalue, options, rowObject){
                                if(cellvalue != null){
                                    cellvalue = cellvalue.replace(/\r+|\s+|\n+/gi,' ');
                                    var length = cellvalue.length;
                                    if(length > 20){
                                        cellvalue = cellvalue.substring(0,17) + "...";
                                    }
                                }
                                return cellvalue;
                            }}
                        ,   {label : "댓글 내용" , name : "aply",width:230 , align:"center", formatter : function(cellvalue, options, rowObject){
                                if(cellvalue != null){
                                    cellvalue = cellvalue.replace(/\r+|\s+|\n+/gi,' ');
                                    var length = cellvalue.length;
                                    if(length > 20){
                                        cellvalue = cellvalue.substring(0,17) + "...";
                                    }
                                }
                                return cellvalue;
                            }}
                        ,   {label : "신고수" , name : "rptpCnt",width:100 , align:"center"}
                        ,   {label : "등록일" , name:"sysRegDtm",width :150 , sortable : true, align :"center", formatter:gridFormat.date, dateformat:"yyyy.MM.dd"}
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
                                    onClick = "petTv.detailReportPop('"+aplySeq+"','"+loginId+"');";
                                }else if(replyGbCd == "${adminConstants.REPLY_GB_20}"){
                                    var petLogNo = rowObject.petLogNo;
                                    var contsStatCd = rowObject.contsStatCd;
                                    var snctYn = rowObject.snctYn;
                                    var petLogChnlCd = rowObject.petLogChnlCd;
                                    var petLogAplySeq = rowObject.aplySeq;
                                    onClick = "petLog.detailLayerPop('"+petLogNo+"','"+contsStatCd+"','"+snctYn+"','"+petLogChnlCd+"',\"Y\",'"+petLogAplySeq+"');";
                                }else if(replyGbCd == "${adminConstants.REPLY_GB_30}"){
                                    onClick ="alert('상품 후기 진행 중 -');"
                                }
                                return "<button type='button' class='btn' onclick="+onClick+">상세</button>";
                            }}
                        ,   {name:"petLogNo",hidden:true}
                        ,   {name:"contsStatCd", hidden:true}
                        ,   {name:"snctYn", hidden:true}
                        ,   {name:"petLogChnlCd", hidden:true}
                        ,   {name:"aplySeq", hidden:true}
                    ]
                    ,   onSelectRow : function(ids){
                            var rowData = $("#memberReportList").jqGrid("getRowData",ids);
                            //viewPetLogDetail(rowData);
                    }
                    ,   loadComplete : function(res){
                            if("${so.mbrNo}" != '' && res.data.length == 0){
                                $("#memberReportListPage_right div").html("<span class='red'>조회결과가 없습니다.</span>");
                            }
                    }
                    ,   paging : true
                    ,   rowNum : 5
                };
                grid.create("memberReportList",options);
            }

            //상세 팝업
            function viewPetLogDetail(petLogNo, contsStatCd, snctYn, petLogChnlCd) {
                var titles = "펫로그 상세";
                var options = {
                    url : "<spring:url value='/petLogMgmt/popupPetLogDetail.do' />"
                    , data : {  petLogNo : petLogNo
                        ,	contsStatCd : contsStatCd
                        , snctYn : snctYn
                        , petLogChnlCd : petLogChnlCd
                    }
                    , dataType : "html"
                    , callBack : function (data ) {
                        var config = {
                            id : "petLogDetail"
                            , width : 1050
                            , height : 630
                            , top : 200
                            , title : titles
                            , body : data
                            , button : "<button type=\"button\" onclick=\"petLogUpdateProc('detail',"+petLogNo+");\" class=\"btn btn-ok\" style=\"background-color:#0066CC; border-color:#0066CC;\">저장</button>"
                        }
                        layer.create(config);
                    }
                }
                ajax.call(options );
            }

            function petLogUpdateProc (location,petLogNo) {
                var addMsg="";
                if(location == "batch") addMsg="선택 ";
                messager.confirm(addMsg+"<spring:message code='column.common.petlog.confirm.batch_update' />",function(r){
                    if(r){
                        var contsStatUpdateGb = $("#contsStatUpdateGb").children("option:selected").val();
                        var petLogNos = new Array();
                        var snctYn = "";

                        petLogNos.push (petLogNo);
                        contsStatUpdateGb = $(":input:radio[name=detailContsStatCd]:checked").val();

                        var sendData = {
                            petLogNos : petLogNos
                            , contsStatUpdateGb:contsStatUpdateGb
                        };

                        var options = {
                            url : "<spring:url value='/petLogMgmt/updatePetLog.do' />"
                            , data : sendData
                            , callBack : function(data ) {
                                messager.alert("<spring:message code='column.common.edit.final_msg' />", "Info", "info", function(){
                                    searchPetlogList ();
                                    $("#contsStatUpdateGb").val("");
                                    layer.close('petLogDetail');
                                });
                            }
                        };
                        ajax.call(options);
                    }
                });
            }

            $(function(){
                fnCreateMemberReportList();
            });
        </script>
    </t:putAttribute>
    <t:putAttribute name="content">
        <div class="mModule mt30">
            <table id="memberReportList"></table>
            <div id="memberReportListPage"></div>
        </div>
    </t:putAttribute>
</t:insertDefinition>