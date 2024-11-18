<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="subTabLayout">
    <t:putAttribute name="script">
        <!--
            2021.02.10 - UID 최신화 작업 진행
            컨텐츠 관리 - 펫로그 - 펫로그 관리와 동일
        -->
        <script type="text/javascript">
            //그리드 생성
            function fnCreateMemberPetLog(){
                var searchParam = $("#memberPetLogSearchForm").serializeJson();
                searchParam.regGb = "temp";
                var _lebel = "<spring:message code='column.sys_reg_dt' /><br/>(<spring:message code='column.sys_upd_dt' />)";

                var options = {
                        url : "<spring:url value='/member/listMemberPetLog.do' />"
                    , 	rowNum : 5
                    ,	rowList : [5]
                    ,   height : "${so.mbrNo}" != '' ? 330 : ''
                    , searchParam : searchParam
                    , colModels : [
                        {name:"rowIndex", 	label:'<spring:message code="column.no" />', 			width:"60", 	align:"center", sortable:false} /* 번호 */
                        , {name:"petLogChnlCd",label:"<spring:message code='column.petlog.chnl' />",  	width:"120", align:"center", sortable:false
                            , editable:true, edittype:'select', formatter:'select', editoptions : {value:"<frame:gridSelect grpCd='${adminConstants.PETLOG_CHNL}' showValue='false' />"}} /* 등록유형 */
                        , {name:"petlogContsGb",label:"<spring:message code='column.petlog.conts_gb' />",  	width:"120", align:"center", sortable:false
                            , editable:true, edittype:'select', formatter:'select', editoptions : {value:"<frame:gridSelect grpCd='${adminConstants.PETLOG_CONTS_GB}' showValue='false' />"}} /* 컨텐츠구분 */
                        , {name:"vdThumPath", 	label:'<spring:message code="column.thum" />',	width:"150", align:"center", sortable:false, formatter: function(cellvalue, options, rowObject) {
                                if(rowObject.vdThumPath != "" && rowObject.vdThumPath != null) {
                                    var imgPath = rowObject.vdThumPath.indexOf('cdn.ntruss.com') > -1 ? rowObject.vdThumPath :  '${frame:optImagePath("' + rowObject.vdThumPath + '","400")}';
                                    return '<img src='+imgPath+' class="petLogImg" style="width:100px; height:100px;" onError="this.src=\'/images/noimage.png\'" />';[]

                                } else {
                                    return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
                                }
                            } /* 썸네일 */
                        }
                        , {name:"dscrt", 		label:'<spring:message code="column.content" />', 		width:"600", 	align:"left",	sortable:false, classes:'pointer fontbold', formatter : function(cellvalue, options, rowObject){
                                if(cellvalue != null){
                                    cellvalue = cellvalue.replace(/\r+|\s+|\n+/gi,' ');
                                    var length = cellvalue.length;
                                    if(length > 20){
                                        cellvalue = cellvalue.substring(0,17) + "...";
                                    }
                                }
                                return cellvalue;
                            }}/* 내용 */
                        , {name:"goodsRcomYn", 	label:"<spring:message code='column.goods_map' />", 	width:"80", 	align:"center", sortable:false} /* 상품추천 */
                        , {name:"pstNm", 		label:"<spring:message code='column.location' />", 		width:"80", 	align:"center", sortable:false} /* 위치 */
                        , {name:"nickNm", 		label:"<spring:message code='column.nickname' />", 		width:"200", 	align:"center", sortable:false} /* 닉네임 */
                        , {name:"shareCnt",		label:"<spring:message code='column.vod.share_cnt' />",	width:"80", 	align:"center", sortable:false} /* 공유수 */
                        , {name:"goodCnt",		label:"<spring:message code='column.good_cnt' />", 		width:"80", 	align:"center", sortable:false} /* 좋아요 */
                        , {name:"hits", 		label:"<spring:message code='column.hits' />", 			width:"80", 	align:"center", sortable:false} /* 조회수 */
                        , {name:"claimCnt", 	label:"<spring:message code='column.claim_cnt' />", 	width:"80", 	align:"center", sortable:false} /* 신고수 */
                        , {name:"snctYn", 		label:"<spring:message code='column.snct_yn' />", 		hidden:true, 	align:"center", sortable:false} /* 제재여부 */
                        , {name:"petLogNo", 	label:'<spring:message code="column.no" />', 			hidden:true,	width:"60", 	align:"center", sortable:false}/* 번호 */
                        , {name:"contsStatCd", 	label:"<spring:message code='column.contsStat' />",  	width:"100", 	align:"center", sortable:false
                            , editable:true, edittype:'select', formatter:'select', editoptions : {value:"<frame:gridSelect grpCd='${adminConstants.CONTS_STAT}' showValue='false' />"}} /* 전시여부 */
                        , {name:"regModDtm",	label:_lebel,  align:"center", sortable:false} /* 등록수정일 */
                    ]

                    , onSelectRow : function (ids) {
                        var rowData = $("#memberPetLogList").getRowData(ids);
                        var petLogNo = rowData.petLogNo;
                        var contsStatCd = rowData.contsStatCd;
                        var snctYn = rowData.snctYn;
                        var petLogChnlCd = rowData.petLogChnlCd;
                        viewPetLogDetail(petLogNo, contsStatCd, snctYn,petLogChnlCd);
                    }
                    ,   loadComplete : function(res){
                            if("${so.mbrNo}" != '' && res.data.length == 0){
                                $("#memberPetLogListPage_right div").html("<span class='red'>조회결과가 없습니다.</span>");
                            }
                    }
                    , gridComplete : function(){
                		var gridData = $("#petlogList").jqGrid('getRowData');
    					$(this).find("tr").each(function(index, item){
    						var imgObj = $(this).find("td").eq(3).find("img");
    						if(imgObj.attr("class") == "petLogImg") {
    							imgObj.bighover({"width":"500", "height":"500"});	
    						}
    					});
                    }
                };

                var mbrNo = "${so.mbrNo}";
                if(mbrNo == ""){
                    options.url = null
                    options.datatype = "local";
                }

                grid.create("memberPetLogList",options);
            }

            //상세
            function viewPetLogDetail(petLogNo, contsStatCd, snctYn,petLogChnlCd) {
                var titles = "펫로그 상세";
                var options = {
                    url : "<spring:url value='/petLogMgmt/popupPetLogDetail.do' />"
                    , data : {  petLogNo : petLogNo
                        ,	contsStatCd : contsStatCd
                        ,   snctYn : snctYn
                        ,   petLogChnlCd : petLogChnlCd
                    }
                    , dataType : "html"
                    , callBack : function (data ) {
                        var config = {
                            id : "petLogDetail"
                            , width : 980
                            , height : 630
                            , top : 200
                            , title : titles
                            , body : data
                            , button : "<button type=\"button\" onclick=\"petLogUpdateProc('detail');\" class=\"btn btn-ok\" style=\"background-color:#0066CC; border-color:#0066CC;\">저장</button>"
                        }
                        layer.create(config);
                    }
                }
                ajax.call(options );
            }

            // 검색 조회
            function fnReloadMemberPetLog() {
                var options = {
                    searchParam : $("#memberPetLogSearchForm").serializeJson()
                };
                if(options.searchParam.mbrNo == ""){
                    messager.alert("회원을 먼저 검색해주세요.","Info","Info",function(){
                        $(parent.document).scrollTop(0);
                        $(parent.document).find("[name='mbrNo']").select();
                    });
                }else{
                    grid.reload("memberPetLogList", options);
                }
            }

            // 초기화 버튼클릭
            function fnInitBtnOnClick () {
                resetForm ("memberPetLogSearchForm");
            }

            // 전시상태 일괄 변경
            function batchUpdatePetLogStat () {
                if($("#contsStatUpdateGb option:selected").val() == "" || $("#contsStatUpdateGb option:selected").val() == null){
                    messager.alert("<spring:message code='column.common.petlog.update.gb' />", "Info", "info");
                    $("#contsStatUpdateGb").focus();
                    return;
                }
                var grid = $("#petlogList");
                var rowids = grid.jqGrid('getGridParam', 'selarrrow');
                if(rowids.length <= 0 ) {
                    messager.alert("<spring:message code='column.common.petlog.update.no_select' />", "Info", "info");
                    return;
                }

                var contsStatUpdateGb = $("#contsStatUpdateGb").children("option:selected").val();
                petLogUpdateProc ("batch");

            }

            // 검색 조회
            function searchPetlogList () {
                var options = {
                    searchParam : $("#memberPetLogSearchForm").serializeJson()
                };
                grid.reload("petlogList", options);
            }

            $(function(){
                fnCreateMemberPetLog();
            });
        </script>
    </t:putAttribute>
    <t:putAttribute name="content">

        <form id="memberPetLogSearchForm" name="memberPetLogSearchForm">
            <input type = "hidden" name = "mbrNo" id = "mbrNo" value="${so.mbrNo}" />
            <input type = "hidden" name = "maskingUnlock" value="${so.maskingUnlock}" />
            <input type = "hidden" name = "customSort" />
        </form>

        <div class="mModule">
            <table id="memberPetLogList"></table>
            <div id="memberPetLogListPage"></div>
        </div>
    </t:putAttribute>
</t:insertDefinition>
