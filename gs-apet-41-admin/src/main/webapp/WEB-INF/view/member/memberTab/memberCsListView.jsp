<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="subTabLayout">
    <t:putAttribute name="script">
		<style type="text/css">
		    .ui-jqgrid tr.jqgrow td { text-overflow: ellipsis; -o-text-overflow: ellipsis; white-space: nowrap; }
		    .underline {text-decoration:underline !important; text-underline-position: under;}
		</style>
		
        <script type="text/javascript">
	        $(document).ready(function(){
	            
	            $(document).on("keydown","#memberCsSearchForm input",function(){
	    			if ( window.event.keyCode == 13 ) {
	    				fnReloadGrid();
	  		  		}
	            });
	        });	        
        
            function fnCreateMemberCsList(){
                var searchParam = $("#memberCsSearchForm").serializeJson();
                searchParam.six = "CS.cusAcptDtm";
                var options = {
                        url : "<spring:url value='/counsel/web/counselWebListGrid.do' />"
                   	,	rowNum : 20
                   	,	rowList : [20]
                    ,   searchParam : searchParam
                    ,   height : "${so.mbrNo}" != '' ? 800 : ''
                    ,   colModels : [
                            {name:"cusAcptDtm", hidden:true}
                       	,	{name:"cusNo", hidden:true}
                        ,   {name:"rowNum", label:'번호', width:"80", align:"center"}
                        ,   {name:"cusAcptDtm", label:'접수일자', width:"200", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy.MM.dd HH.mm.ss"}
                        ,   {name:"cusStatCd", label:'답변 상태', width:"120", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_STAT}" />"}}
                        ,   {name:"cusCtg1Cd", label:'카테고리', width:"200", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_CTG1}" />"}}
                        ,   {name:"cusCtg2Cd", label:'카테고리2', width:"200", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_CTG2}" />"}, hidden:true}
                        ,   {name:"cusCtg3Cd", label:'카테고리3', width:"200", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_CTG3}" />"}, hidden:true}
                        ,   {name:"content" , label : "문의 내용" , width:"230" , align:"center" ,classes:'underline'}
                        ,   {name:"cusCpltrNm", label:'처리자', width:"80", align:"center"}
                        ,   {name:"cusCpltDtm", label:'답변 일시', width:"200", align:"center", sortable:true ,formatter:gridFormat.date, dateformat:"yyyy.MM.dd HH.mm.ss"}
                    ]
                    ,   paging : true
                    ,   loadComplete : function(res) {
                            if("${so.mbrNo}" != '' && res.data.length == 0){
                                $("#memberCsListPage_right div").html("<span class='red'>조회결과가 없습니다.</span>");
                            }

                            /* var td = $("#memberCsList").find("tr").find("td[aria-describedby=memberCsList_cusCtg1Cd]");
                            var txt = $(td).text().replace(/([a-zA-Zㄱ-힣]*[\/]*[a-zA-Zㄱ-힣]*)(\/)+([a-zA-Zㄱ-힣]*)/,'$1->$3');
                            $("#memberCsList").find("tr").find("td[aria-describedby=memberCsList_cusCtg1Cd]").text(txt);
                            $("#memberCsList").find("tr").find("td[aria-describedby=memberCsList_content]").css('text-decoration', 'underline'); */
                    }
					, onSelectRow : function(ids) {
						var rowData = $("#memberCsList").getRowData(ids);
						popupCs(rowData);
					}
                };

                if(searchParam.mbrNo == ""){
                    options.url = null;
                    options.datatype = "local";
                }

                grid.create("memberCsList",options);
            }
            
            function popupCs(rowData) {
				var options = {
					  url : '/counsel/web/counselWebView.do'
					, dataType : "html"
					, data : {
						cusNo : rowData.cusNo 
						, popupYn : "Y"
					}
					, callBack : function(result) {
						var config = {
							 id : 'counselWebViewPop'
							,width : 1500
							,height : 580
// 							,top : 100
							,title : '1:1문의 상세'
							,body : result
						}
						layer.create(config);		
					}			
				}
				ajax.call(options);
            }

            function fnReloadGrid(){
            	if(dateCheck($("#cusAcptDtmStart").val(),$("#cusAcptDtmEnd").val())){
            		return;
            	}
                var searchParam = $("#memberCsSearchForm").serializeJson();
                searchParam.mbrNo = "${so.mbrNo}";
                searchParam.six = "CS.cusAcptDtm";

                var options = {
                        url : "<spring:url value='/counsel/web/counselWebListGrid.do' />"
                    ,   searchParam : searchParam
                };
                grid.reload("memberCsList",options);
            }

            function searchDateChange() {
                var term = $("[name=checkOptDate] option:selected").val();
                if(term == "") {
                    $("#cusAcptDtmStart").val("");
                    $("#cusAcptDtmEnd").val("");
                } else {
                    setSearchDate(term, "cusAcptDtmStart", "cusAcptDtmEnd");
                }
                $("#cusAcptDtmStart").trigger("change");
            }

            $(function(){
                searchDateChange();
                fnCreateMemberCsList();
            });
            
        </script>
    </t:putAttribute>
    <t:putAttribute name="content">
        <div class="mb30">
            <form id="memberCsSearchForm">
                <input type="hidden" name="mbrNo" value="${so.mbrNo}" />
                <table class="table_type1">
                    <tr>
                        <th>답변 상태</th>
                        <td>
                            <select name="cusStatCd">
                                <frame:select grpCd="${adminConstants.CUS_STAT}" defaultName="전체" />
                            </select>
                        </td>

                        <th>문의 카테고리</th>
                        <td>
                            <select name="cusCtg1Cd">
                                <frame:select grpCd="${ adminConstants.CUS_CTG1}" defaultName="전체" />
                            </select>
                        </td>

                        <th>처리자</th>
                        <td>
                            <input type="text" name="cusChrgNm" class="w200"/>
                        </td>
                    </tr>
                    <tr>
                        <th>상담 접수일시</th>
                        <td colspan="5">
                            <frame:datepicker startDate="cusAcptDtmStart" endDate="cusAcptDtmEnd" period="-30" />
                            <select name="checkOptDate" onchange="searchDateChange();" class="ml10">
                                <frame:select grpCd="${adminConstants.SELECT_PERIOD}" selectKey="${adminConstants.SELECT_PERIOD_40}" />
                            </select>
                        </td>
                    </tr>
                </table>
            </form>

            <c:if test="${not empty so.mbrNo}">
                <div class="btn_area_center">
                    <button type="button" onclick="resetForm('memberCsSearchForm');" class="btn btn-cancel">초기화</button>
                    <button type="button" onclick="fnReloadGrid();" class="btn btn-ok">검색</button>
                </div>
            </c:if>
        </div>

        <div class="mModule">
            <table id="memberCsList"></table>
            <div id="memberCsListPage"></div>
        </div>
    </t:putAttribute>
</t:insertDefinition>