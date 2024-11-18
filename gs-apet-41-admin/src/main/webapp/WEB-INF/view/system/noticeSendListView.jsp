<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
    <t:putAttribute name="script">
        <style type="text/css">
            .ui-jqgrid tr.jqgrow td { text-overflow: ellipsis; -o-text-overflow: ellipsis; white-space: nowrap; }
            .underline {text-decoration:underline !important; text-underline-position: under;}
        </style>

        <script type="text/javascript">
		$(document).ready(function(){
			
            $(document).on("keydown","#noticeSendSearchForm input",function(){
      			if ( window.event.keyCode == 13 ) {
      				fnReloadNoticeSendListDaily();
    		  	}
            });					
		});        
            function fnGetSearchParam(){
                var data = $("#noticeSendSearchForm").serializeJson();
                if($("[name='sysCds']").length>0){
                    data.sysCds = data.sysCds.join(",");
                }
                return data;
            }
            function fnCreateNoticeSendListDaily(){
                var options = {
                    url : "<spring:url value='/system/pageNoticeSendListByDailiy.do' />"
                    ,   searchParam : fnGetSearchParam()
                    ,   colModels : [
                            { name : "noticeSendNo", key : true , hidden :true}
                        ,   { name : "rowNum" , label : "No" , align : "center" , width : "50"}
                        ,   { label : "발송일" , name : "sendReqDtm" ,  align : "center" , width : "150" , formatter:gridFormat.date, dateformat:"yyyy.MM.dd", sortable :true}
                        ,   { label : "대상자 수" , name : "cnt" , align : "center" , width : "150" , classes:'pointer underline'}
                        ,   { label : "발송 수단" , name:"sndTypeNm" ,  align : "center" , width : "150" }
                        ,   { label : "제목" , name : "subject", align : "center" , width : "250" }
                        ,   { label : "발송 결과" , name : "sndRstNm", align : "center" , width : "70" }
                        ,   {name : "sysCd" , hidden: true}
                        ,   {name : "sndTypeCd" , hidden: true}
                    ]
                    ,   paging : true
                    ,   rowNum : 10
                    ,   onCellSelect : function(id, cellidx, cellvalue) {
                            if(cellidx === 3){
                                $("#gbox_memberSendHistList").show();
                                $("#memberSendHistListHeader").show();
                                var rowData = $("#noticeSendList").getRowData(id);
                                fnReloadMemberSendHistList(rowData);
                            }
                    }
                    ,   loadComplete : function(result){
                            if(result.data == undefined || result.data.length === 0){
                                $("#noticeSendListExcelBtn").hide();
                            }else{
                                $("#noticeSendListExcelBtn").show();
                            }
                            $("#memberSendHistList").jqGrid("clearGridData");
                            $("#memberSendHistListExcelBtn").hide();

                            $("#gbox_memberSendHistList").hide();
                            $("#memberSendHistListHeader").hide();
                    }
    				, gridComplete : function() {
    					$("#noData").remove();
    					var grid = $("#noticeSendList").jqGrid('getRowData');
    					if(grid.length <= 0) {
    						var str = "";
    						str += "<tr id='noData' role='row' class='jqgrow ui-row-ltr ui-widget-content'>";
    						str += "	<td role='gridcell' colspan='10' style='text-align:center;'>검색결과가 없습니다.</td>";
    						str += "</tr>"
    								
    						$("#noticeSendList.ui-jqgrid-btable").append(str);
    					}
    				}
                };
                grid.create("noticeSendList",options);
            }
            function fnReloadNoticeSendListDaily(){
            	//검색버튼 click이후에 alert창 띄우기 
				compareDateAlert("sendReqStrtDtm", "sendReqEndDtm", "term");
            	
                var options = {
                    searchParam : fnGetSearchParam()
                };
            	gridReload('sendReqStrtDtm','sendReqEndDtm','noticeSendList','term', options);
            }

            function fnCreateMemberSendHistList(){
                var options = {
                        url : "<spring:url value='/system/pageMemberSendHist.do'/>"
                    ,   colModels : [
                        { name : "noticeSendNo", key : true , hidden :true}
                        ,   { name : "mbrNo", hidden :true}
                        ,   { name : "sndInfo" , hidden : true}
                        ,   { name : "rowNum" , label : "No" , align : "center" , width : "50"}
                        ,   { label : "발송일" , name : "sendReqDtm" ,  align : "center" , width : "150" , formatter:gridFormat.date, dateformat:"yyyy.MM.dd", sortable :true}
                        ,   { label : "회원 ID" , name : "loginId" ,  align : "center" , width : "150" }
                        ,   { label : "회원명" , name : "mbrNm" , align : "center" , width : "150"}
                        ,   { label : "발송 수단" , name:"sndTypeNm" ,  align : "center" , width : "150" }
                        ,   { label : "Email/휴대폰 번호" , name:"receiverInfo", align : "center" , width : "150" , formatter : function(cellvalue, options, rowObject){
                                var result = "";
                                if(rowObject.sndTypeCd === "${adminConstants.SND_TYPE_10}" || rowObject.sndTypeCd === "${adminConstants.SND_TYPE_20}" || rowObject.sndTypeCd === "${adminConstants.SND_TYPE_30}"){
                                    result = rowObject.rcvrNo;
                                }
                                else if(rowObject.sndTypeCd === "${adminConstants.SND_TYPE_40}"){
                                    result = rowObject.receiverEmail;
                                }
                                return result;
                            }}
                        ,   { label : "발송 제목" , name : "subject", align : "center" , width : "250" , classes:'pointer underline'}
                        ,   { label : "발송 결과" , name : "sndRstNm", align : "center" , width : "70" }
                        ,   {name : "sendReqTime" , hidden : true , formatter : function(cellvalue, options, rowObject){
                                return new Date(rowObject.sendReqDtm).format("yyyy-MM-dd HH:mm:ss");
                            }}
                        ,   {name : "sndTypeCd" , hidden : true , align : "center" , width : "70" }
                        ,   {name : "contents" , hidden : true , align : "center" , width : "70" }
                    ]
                    ,   paging : true
                    ,   rowNum : 20
                    ,   onCellSelect : function(id, cellidx, cellvalue){
                            if(cellidx === 9){
                                var rowData = $("#memberSendHistList").getRowData(id);
                                /* var convertJsonStr = JSON.stringify(JSON.parse(rowData.sndInfo));
                                rowData.sndInfo = convertJsonStr; */
                                fnNoticeDetailLayerPop(rowData);
                            }
                    }
                    ,   loadComplete : function(result){
                            if(result.data == undefined || result.data.length === 0){
                                $("#memberSendHistListExcelBtn").hide();
                            }else{
                                $("#memberSendHistListExcelBtn").show();
                            }
                    }
                };
                grid.create("memberSendHistList",options);
            }
            function fnReloadMemberSendHistList(rowData){
                rowData.sendReqStrtDtm = rowData.sendReqDtm.replace(/[.]/g,'-');
                rowData.sendReqEndDtm = rowData.sendReqDtm.replace(/[.]/g,'-');
                var options = {
                        url : "<spring:url value='/system/pageMemberSendHist.do'/>"
                    ,   searchParam : rowData
                };
                grid.reload("memberSendHistList",options);
            }

            function fnInitBtnOnClick(){
                resetForm("noticeSendSearchForm");
            	searchDateChange();
                $("#noticeSendSearchForm").find("input[type=hidden]").val($("#noticeSendSearchForm").find("input[type=hidden]").data("origin"));
//                 fnReloadNoticeSendListDaily();
            }

            // 등록기간
            function searchDateChange() {
                var term = $("#checkOptDate").children("option:selected").val();
                if(term == "") {
                    $("#sendReqStrtDtm").val("");
                    $("#sendReqEndDtm").val("");
                }else if(term == "50"){
    				//3개월 기간조회시에만 호출하는 메소드
    				setSearchDateThreeMonth("sendReqStrtDtm", "sendReqEndDtm");
    			}else {
                    setSearchDate(term, "sendReqStrtDtm", "sendReqEndDtm");
                }
            }

            //화면 로드
            function fnOnLoadDocument(){
            	newSetCommonDatePickerEvent("#sendReqStrtDtm", "#sendReqEndDtm"); 
                searchDateChange();
                fnCreateNoticeSendListDaily();
                fnCreateMemberSendHistList();
                $("#sendReqStrtDtm").data("origin",$("#sendReqStrtDtm").val());
                $("#sendReqEndDtm").data("origin",$("#sendReqEndDtm").val());
            }

            function fnNoticeDetailLayerPop(rowData){
                delete rowData.sendReqDtm;
                var options = {
                        url : "/system/noticeDetailLayerPop.do"
                    ,   dataType : "HTML"
                    ,   data : rowData
                    ,   callBack : function(result){
                            var config = {
                                id : "noticeDetailLayerPop"
                                , width :  850
                                , height :  600
                                , title : "상세"
                                , body : result
                                , button : "<button type='button' onclick='layer.close(\"noticeDetailLayerPop\");' class='btn btn-ok'>확인</button>"
                            };
                            layer.create(config);
                    }
                };
                ajax.call(options);
            }

            //일자별 발송 내역 엑셀 다운로드
            function fnNoticeSendListExcelBtnOnClick(){
                if($("#noticeSendListExcelBtn").is(":visible")){
                    createFormSubmit( "noticeSendList", "/system/noticeSendListExcelDownload.do", fnGetSearchParam() );
                }
            }

            //대상자별 발송 내역 엑셀 다운로드
            function fnMemberSendHistListExcelBtnOnClick(){
                if($("#memberSendHistListExcelBtn").is(":visible")){
                    var idx = $('#noticeSendList').getGridParam('selrow');
                    var searchParam = $("#noticeSendList").getRowData(idx);
                    createFormSubmit( "memberSendHistList", "/system/memberSendHistListExcelDownload.do", searchParam );
                }
            }

            $(function(){
                fnOnLoadDocument();
				
               /*  $(document).on("change","#sendReqStrtDtm , #sendReqEndDtm",function(){
                    var sendReqStrtDtm = $("#sendReqStrtDtm").val();
                    var sendReqEndDtm = $("#sendReqEndDtm").val();

                    var strtMonth = new Date(sendReqStrtDtm).getMonth() + 1;
                    var limitDays = strtMonth % 2 === 0 ? 92 : 91;
                    var diff = getDifDays(sendReqStrtDtm.replace(/-/g,''),sendReqEndDtm.replace(/-/g,''));
                    if(diff>limitDays){
                        messager.alert("기간 선택범위를 3개월로 선택해 주세요","Info","Info",function(){
                            $("#sendReqStrtDtm").val($("#sendReqStrtDtm").data("origin"));
                            $("#sendReqEndDtm").val($("#sendReqEndDtm").data("origin"));
                        });
                    }else if(diff<0){
                        messager.alert("종료일이 시작일보다 크게 선택해 주세요.","Info","Info",function(){
                            $("#sendReqStrtDtm").val($("#sendReqStrtDtm").data("origin"));
                            $("#sendReqEndDtm").val($("#sendReqEndDtm").data("origin"));
                        });
                    }else{
                        $("#sendReqStrtDtm").data("origin",sendReqStrtDtm);
                        $("#sendReqEndDtm").data("origin",sendReqEndDtm);
                    }
                }); */
            })
        </script>
    </t:putAttribute>
    <t:putAttribute name="content">
        <div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
            <div title="조회 설정" style="padding:10px">
                <form id="noticeSendSearchForm">
                    <c:choose>
                        <c:when test="${not empty sysCd}">
                            <input type="hidden" name="sysCd" value="${sysCd}" data-origin="${sysCd}"/>
                        </c:when>
                        <c:when test="${not empty sysCds}">
                            <c:forEach var="item" items="${sysCds}">
                                <input type="hidden" name="sysCds" value="${item}" data-origin="${item}"/>
                            </c:forEach>
                        </c:when>
                    </c:choose>
                    <table class="table_type1">
                        <colgroup>
                            <col width="10%"/>
                            <col width="40%"/>
                            <col width="10%"/>
                        </colgroup>
                        <tbody>
                        <tr>
                            <th>발송일</th>
                            <td>
                                <frame:datepicker startDate="sendReqStrtDtm" endDate="sendReqEndDtm" />
                                <select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
                                    <frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_40}" excludeOption="${adminConstants.SELECT_PERIOD_30},${adminConstants.SELECT_PERIOD_50}" defaultName="기간선택"/>
                                </select>
                            </td>

                            <th>발송 결과</th>
                            <td>
                                <select name="reqRstCd">
                                    <frame:select grpCd="${adminConstants.SND_RST}" defaultName="전체" />
                                </select>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </form>
                <div class="btn_area_center">
                    <button type="button" onclick="fnReloadNoticeSendListDaily();" class="btn btn-ok">검색</button>
                    <button type="button" onclick="fnInitBtnOnClick();" class="btn btn-cancel">초기화</button>
                </div>
            </div>
        </div>

        <div class="mModule">
            <div class="mTitle">
                <h2>일자별 발송 내역 </h2>
                <div class="buttonArea">
                    <button type="button" onclick="fnNoticeSendListExcelBtnOnClick();" id="noticeSendListExcelBtn" class="btn btn-add btn-excel right">
                        <spring:message code="admin.web.view.common.button.download.excel"/>
                    </button>
                </div>
            </div>
            <table id="noticeSendList"></table>
            <div id="noticeSendListPage"></div>
        </div>

        <div class="mModule">
            <div class="mTitle" id="memberSendHistListHeader">
                <h2>대상자별 발송 내역 </h2>
                <div class="buttonArea">
                    <button type="button" onclick="fnMemberSendHistListExcelBtnOnClick();" id="memberSendHistListExcelBtn" class="btn btn-add btn-excel right">
                        <spring:message code="admin.web.view.common.button.download.excel"/>
                    </button>
                </div>
            </div>
            <table id="memberSendHistList"></table>
            <div id="memberSendHistListPage"></div>
        </div>
    </t:putAttribute>
</t:insertDefinition>