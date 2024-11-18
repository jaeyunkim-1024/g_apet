<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="subTabLayout">
    <t:putAttribute name="script">
        <script type="text/javascript">
            function fnCreateGoodsIoGrid(){
                var searchParam = $("#memberGoodsIoSearchForm").serializeJson();
                searchParam.mbrNo = "${so.mbrNo}";
                var options = {
                    url : "<spring:url value='/member/listMemberGoodsIoList.do' />"
                    ,	rowNum : 20
                    , 	rowList : [20]
                    ,   searchParam : searchParam
                    ,   height : "${so.mbrNo}" != '' ? 800 : ''
                    ,   colModels : [
                        	{name:"pakGoodsId", hidden:true}
                        ,   {name:"rowNum", label:'No', width:"80", align:"center"}
                        ,   {name:"sysRegDtm", label : "설정 일자", width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy.MM.dd" }
                        ,   {name:"almSndDtm", label:'알림 발송 일자', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy.MM.dd"}
                        ,   {name:"goodsId", label:'상품 번호', width:"150", align:"center"}
                        ,   {name:"goodsNm", label:'상품 명', width:"1000", align:"center"}
                    ]
                    ,   paging : true
                    ,   loadComplete : function(res){
                            if("${so.mbrNo}" != '' && res.data.length == 0){
                                $("#memberGoodsIoListPage_right div").html("<span class='red'>조회결과가 없습니다.</span>");
                            }
                    }
					, onSelectRow : function(ids) {
						var rowData = $("#memberGoodsIoList").getRowData(ids);
						var url = location.protocol + '//<spring:eval expression="@webConfig['site.fo.domain']" />/goods/indexGoodsDetail?goodsId=';
						if(rowData.goodsId != '' && rowData.pakGoodsId != '') {
							url += rowData.pakGoodsId;
						} else if(rowData.pakGoodsId == '') {
							url += rowData.goodsId;
						}
						window.open(url);
					}
                };
                grid.create("memberGoodsIoList",options);
            }

            function fnReloadGrid(){
            	if(dateCheck($("#sysRegDtmStart").val(),$("#sysRegDtmEnd").val())){
            		return;
            	}              	
                var searchParam = $("#memberGoodsIoSearchForm").serializeJson();
                searchParam.mbrNo = "${so.mbrNo}";
                var options = {
                    searchParam : searchParam
                };
                grid.reload("memberGoodsIoList",options);
            }

            function searchDateChange() {
                var term = $("[name=checkOptDate] option:selected").val();
                if(term == "") {
                    $("#sysRegDtmStart").val("");
                    $("#sysRegDtmEnd").val("");
                } else {
                    setSearchDate(term, "sysRegDtmStart", "sysRegDtmEnd");
                }
                $("#sysRegDtmStart").trigger("change");
            }

            $(function(){
                searchDateChange();
                fnCreateGoodsIoGrid();
                //setCommonDatePickerEvent("#sysRegDtmStart","#sysRegDtmEnd");
            })
        </script>
    </t:putAttribute>
    <t:putAttribute name="content">
        <div class="mb30">
            <form id="memberGoodsIoSearchForm">
                <input type="hidden" name="mbrNo" value="${so.mbrNo}" />
                <table class="table_type1">
                      <tr>
                        <th>설정 일자</th>
                        <td colspan="5">
                            <frame:datepicker startDate="sysRegDtmStart" endDate="sysRegDtmEnd" period="-30" />
                            <select name="checkOptDate" onchange="searchDateChange();" class="ml10">
                                <frame:select grpCd="${adminConstants.SELECT_PERIOD}" selectKey="${adminConstants.SELECT_PERIOD_10}" />
                            </select>
                        </td>
                    </tr>
                </table>
            </form>

            <c:if test="${not empty so.mbrNo}">
                <div class="btn_area_center">
                    <button type="button" onclick="resetForm('memberGoodsIoSearchForm');" class="btn btn-cancel">초기화</button>
                    <button type="button" onclick="fnReloadGrid();" class="btn btn-ok">검색</button>
                </div>
            </c:if>
        </div>

        <div class="mModule mt30">
            <table id="memberGoodsIoList"></table>
            <div id="memberGoodsIoListPage"></div>
        </div>
    </t:putAttribute>
</t:insertDefinition>