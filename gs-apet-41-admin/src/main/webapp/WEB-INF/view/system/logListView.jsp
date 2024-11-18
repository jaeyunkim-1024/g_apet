<t:insertDefinition name="contentsLayout">
    <t:putAttribute name="script">
        <script type="text/javascript">
            // 등록기간
            function searchDateChange() {
                var term = $("#checkOptDate").children("option:selected").val();
                if(term == "") {
                	$("#acsStrtDtm").val("");
    				$("#acsEndDtm").val("");
                }else if(term == "50"){
                	//3개월 기간조회시에만 호출하는 메소드
    				setSearchDateThreeMonth("acsStrtDtm", "acsEndDtm");
                }else {
                    setSearchDate(term, "acsStrtDtm", "acsEndDtm");
                }
            }

            //상세 보기
            function fnLogDetailLayerView(inqrHistNo){
                var options = {
                    url : "<spring:url value='/system/logDetailLayerView.do' />"
                    ,   data : {inqrHistNo : inqrHistNo}
                    ,   dataType : "HTML"
                    ,   callBack : function(result){
                            var config = {
                                id : "logDetailLayerView"
                                , height: 300
                                , title : "로그 상세"
                                , body : result
                                , button : "<button type='button' onclick='layer.close(\"logDetailLayerView\");' class='btn btn-ok'>확인</button>"
                            }
                            layer.create(config);
                    }
                };
                ajax.call(options);
            }

            function fnCreateLogListGrid(){
                var searchParam = $("#logSearchForm").serializeJson();
                var options = {
                        url : "<spring:url value='/system/pageLog.do' />"
                    ,   searchParam : searchParam
                    ,   height : 350
                    ,   rowNum : 20
                    ,   colModels : [
                            {name:"rowNum", label:'번호', width:"50", align:"center"}
                        ,   {name :"histNo" , hidden:true}
                        ,   {name:"usrNo", label:'번호',hidden:true, width:"80", align:"center"}
                        ,   {name:"acsDtm", label:'접속 일시', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd hh:mm:ss"}
                        ,   {name:"adminLoginId", label:'접속자 ID', width:"70", align:"center"}
                        ,   {name:"usrNm", label:'접속자', width:"100", align:"center"}
                        ,   {name:"ip" , label : "접속지 IP" , width:"130", align:"center"}
                        ,   {name:"inqrGbNm", label:'처리 내역', width:"80", align:"center" , formatter : function(cellvalue, options, rowObject){
                                var result = rowObject.inqrGbNm;
                                var inqrGbCd = rowObject.inqrGbCd;
                                if(result === "" || result == null){
                                    result = "-";
                                    if(inqrGbCd == "${adminConstants.INQR_GB_40}"){
                                        result = "열람";
                                    }
                                }
                                return result;
                            }}
                        ,   {name:"menuPath", label:'접근 화면', width:"250", align:"center"}
                        ,   {name:"url", label:'화면 URL', width:"250", align:"center"}
                        ,   {label :"상세" , width:100 , align:"center", formatter : function(cellvalue, options, rowObject){
                                return "<button type='button' class='btn' onclick='fnLogDetailLayerView("+rowObject.inqrHistNo+");'>보기</button>";
                            }}
                    ]
                    ,   paging : true
                    ,   loadComplete : function(result){
                            $("#logListPage_right").text(result.data.length === 0 ? "조회결과가 없습니다." : "");
                    }
                };
                grid.create("logList",options);
            }
            //검색
            function fnReloadGrid(){
            	//검색버튼 click이후에 alert창 띄우기 
				compareDateAlert("acsStrtDtm", "acsEndDtm", "term");

            	
                var options = {
                    searchParam : $("#logSearchForm").serializeJson()
                };
               
            	gridReload('acsStrtDtm','acsEndDtm','logList','term', options);
            }
            //엑셀 다운로드
            function fnExcelDownload(){
                var searchParam = $("#logSearchForm").serializeJson();
                createFormSubmit("logExcelDownload", "/system/logExcelDownload.do", searchParam);
            }

            function fnOnLoadDocument(){
                searchDateChange();
               // setCommonDatePickerEvent("#acsStrtDtm","#acsEndDtm");
               //날짜선택시 selectbox 기간선택문구로 변경 
				newSetCommonDatePickerEvent("#acsStrtDtm", "#acsEndDtm"); 
                fnCreateLogListGrid();
            }

            $(function(){
                fnOnLoadDocument();

                //엔터 키 이벤트
                $(document).on("keydown","#logSearchForm input[type='text']",function(e) {
                    if (e.keyCode == 13) {
                        fnReloadGrid();
                    }
                })
            })
        </script>
    </t:putAttribute>
    <t:putAttribute name="content">
        <form id="logSearchForm">
            <table class="table_type1">
                <tbody>
                    <tr>
                        <th>접속자 ID</th>
                        <td>
                            <input type="text" class="w150" name="adminLoginId" id="adminLoginId" value="" />
                        </td>

                        <th>접속자 명</th>
                        <td>
                            <input type="text" class="w150" name="usrNm" id="usrNm" value="" />
                        </td>

                        <th>처리내역</th>
                        <td>
                            <select name="inqrGbCd" id="inqrGbCd">
                                <frame:select grpCd="${adminConstants.INQR_GB_CD}" selectKey="${adminConstants.INQR_GB_10}" useYn="${adminConstants.COMM_YN_Y}"/>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>날짜</th>
                        <td colspan="5">
                            <frame:datepicker startDate="acsStrtDtm" endDate="acsEndDtm" period="-30" />
                            <select id="checkOptDate" class="ml10" name="checkOptDate" onchange="searchDateChange();">
                                <frame:select grpCd="${adminConstants.SELECT_PERIOD}" selectKey="${adminConstants.SELECT_PERIOD_40}" excludeOption="${adminConstants.SELECT_PERIOD_50}" defaultName="기간선택" />
                            </select>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>

        <div class="btn_area_center">
            <button type="button" onclick="fnReloadGrid();" class="btn btn-ok">검색</button>
            <button type="button" onclick="resetForm('logSearchForm');fnReloadGrid();" class="btn btn-cancel">초기화</button>
        </div>

        <div class="mModule right">
            <button type="button" onclick="fnExcelDownload();" class="btn btn-add btn-excel">
                <spring:message code="admin.web.view.common.button.download.excel"/>
            </button>

            <table id="logList"></table>
            <div id="logListPage"></div>
        </div>
    </t:putAttribute>
</t:insertDefinition>