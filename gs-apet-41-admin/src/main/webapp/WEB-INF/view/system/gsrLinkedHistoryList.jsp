<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				searchDateChange();
				gsrLinkedHistoryGrid();
				 //날짜선택시 selectbox 기간선택문구로 변경 
				newSetCommonDatePickerEventOptions("#reqStrtDtm", "#reqEndDtm", "#reqDtm"); 

				//엔터 키 이벤트
				$(document).on("keydown","#sgrSearchForm input[type='text']",function(e) {
					if (e.keyCode == 13) {
						reloadGsrLinkedHistoryGrid();
					}
				});
			});

			function gsrLinkedHistoryGrid(){
				var options = {
					url : "<spring:url value='/system/gsrLinkedHistoryGrid.do' />"
					, height : 400
					, colModels : [
						//연동 번호
                        {name:"gsrLnkHistNo", label:'<spring:message code="column.lnk_no" />', width:"100", align:"center" , sortable : false}	
						//연동 구분
						, {name:"gsrLnkCd", label:'<spring:message code="column.lnk_gb" />', width:"200", align:"center" , hidden : true , sortable : false}
						//연동 구분 코드 명
						, {name:"gsrLnkNm", label:'<spring:message code="column.lnk_gb" />', width:"200", align:"center" , sortable : false}
	                    //포인트 구분
                        , {name:"pntRsnCd", label:'<spring:message code="column.pnt_gb_cd" />', width:"120", align:"center" , hidden : true , sortable : false}
                     	 //포인트 구분
                        , {name:"pntRsnNm", label:'<spring:message code="column.pnt_gb_cd" />', width:"120", align:"center" , sortable : false}
	                    //포인트(확인 후 수정)
                        , {name:"point", label:'<spring:message code="column.pnt" />', width:"120", align:"center" , sortable : false}
                      	//연동 일자
						, {name:'reqDtm', label:'<spring:message code="column.lnk_dt" />', width:'90', align:'center' , formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss",sortable : false }
						//연동 처리 결과
						, {name:"reqScssYn", label:'<spring:message code="column.lnk_req_scss_yn" />', width:"150", align:"center", sortable : false , formatter:function(cellValue, options, rowObject){
							var str;
							if(rowObject.reqScssYn == "Y"){
								str = "성공";
							}else{
								str = "실패"
							}
							return str;
						}}
						//결과 메시지
						, {name:"rstCd", hidden: true}
						//결과 메시지
						, {name:"rstMsg", label:'<spring:message code="column.rst_msg" />', width:"150", align:"center", sortable : false}
						//에러 처리 일자
						, {name:"errPrcsReqDtm", label:'<spring:message code="column.lnk_err_req_dtm" />', width:"150", align:"center", sortable : false , formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						//에러 처리 결과
						, {name:"errPrcsScssYn", label:'<spring:message code="column.lnk_err_succ_yn" />', width:"150", align:"center", sortable : false, formatter:function(cellValue, options, rowObject){
							var str;
							if(rowObject.errPrcsScssYn == "Y"){
								str = "성공";
							}else if(rowObject.errPrcsScssYn =="N"){
								str = "실패";
							}else{
								str = "-";
							}
							return str;
						}}
						//에러 재처리
						, {name:"errRequest", label:'<spring:message code="column.lnk_err_req" />', width:"150", align:"center" , sortable : false, formatter:function(cellValue, options, rowObject){
							var str = "";
							if(rowObject.errPrcsScssYn == "N"){
								str = '<button type="button" style="padding:5px 5px;" onclick="requestGsrLink()" class="btn">재전송</button>'
							}
							return str;
						}}
					]
					, searchParam : $("#sgrSearchForm").serializeJson()
					}
				grid.create("gsrLinkedList", options);
			}

			function reloadGsrLinkedHistoryGrid() {
				//검색버튼 click이후에 alert창 띄우기 
				compareDateAlertOptions("reqStrtDtm", "reqEndDtm", "reqDtm");
				
				var options = {
					searchParam : $("#sgrSearchForm").serializeJson()
				};
				gridReload('reqStrtDtm','reqEndDtm','gsrLinkedList','term', options);
			}

            
            // 초기화 버튼클릭
            function searchReset () {
                resetForm ("sgrSearchForm");
            }            
            
            // 등록기간
            function searchDateChange() {
                var term = $("#reqDtm").children("option:selected").val();
                if(term == "") {
                    $("#reqStrtDtm").val("");
                    $("#reqEndDtm").val("");
                }else if(term == "50"){
    				//3개월 기간조회시에만 호출하는 메소드
    				setSearchDateThreeMonth("reqStrtDtm", "reqEndDtm");
    			} else {
                    setSearchDate(term, "reqStrtDtm", "reqEndDtm");
                }
            }
            
            function requestGsrLink(){
            	alert("추가개발");
            }
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form name="sgrSearchForm" id="sgrSearchForm" method="post">
				<table class="table_type1">
					<caption>GSR 연동이력 검색</caption>
					<colgroup>
						<col width="15%"/>
						<col width="40%"/>
						<col width="12%"/>
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"> <spring:message code="column.lnk_dt" /></th>
							<td>
                              <frame:datepicker startDate="reqStrtDtm" endDate="reqEndDtm" />
                               <select id="reqDtm" class="ml5" onchange="searchDateChange();">
                                   <frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_40}" defaultName="기간 선택"/>
                               </select>
							</td>
							<!-- 전시여부 -->
							<th scope="row"><spring:message code="column.lnk_no" /></th>
							<td>
								<input type="text" id ="gsrLnkHistNo" name="gsrLnkHistNo" />
							</td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.lnk_gb" /></th>
							<td>
								<select id ="gsrLnkCd" name="gsrLnkCd">
									<frame:select grpCd="${adminConstants.GSR_LNK }" defaultName="전체"/>
								</select>
							</td>
							<th scope="row"><spring:message code="column.pnt_gb_cd" /></th>
							<td>
								<select id ="pntRsnCd" name="pntRsnCd">
									<frame:select grpCd="${adminConstants.PNT_RSN }" defaultName="전체"/>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.lnk_req_scss_yn" /></th>
							<td>
								<select id ="reqScssYn" name="reqScssYn">
									<frame:select grpCd="${adminConstants.LNK_SUCC_YN }" defaultName="전체"/>
								</select>
							</td>
							<th scope="row"><spring:message code="column.lnk_err_succ_yn" /></th>
							<td>
								<select id ="errPrcsScssYn" name="errPrcsScssYn">
									<frame:select grpCd="${adminConstants.ERR_PRCS_SCSS_YN }" defaultName="전체"/>
								</select>
							</td>							
						</tr>
					</tbody>
				</table>
				</form>
				
				<div class="btn_area_center">
					<button type="button" onclick="reloadGsrLinkedHistoryGrid();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
				
			</div>
		</div>	
		

		<div class="mModule">

			<table id="gsrLinkedList" ></table>
			<div id="gsrLinkedListPage"></div>
		</div>

	</t:putAttribute>
</t:insertDefinition>
