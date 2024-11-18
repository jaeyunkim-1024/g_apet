<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				searchDateChange();
				 //날짜선택시 selectbox 기간선택문구로 변경 
				newSetCommonDatePickerEvent("#reqStrtDtm", "#reqEndDtm"); 
				sktmpLinkedHistoryGrid();

				//엔터 키 이벤트
				$(document).on("keydown","#sktmpSearchForm input[type='text']",function(e) {
					if (e.keyCode == 13) {
						reloadSktmpLinkedHistoryGrid();
					}
				})
			});

			//Number gridFormat
			function linkGridNumFormat(cellvalue, options, rowObject){
				if(cellvalue){
					return addComma(cellvalue);;
				}else{
					return '';
				}
			}
			
			function sktmpLinkedHistoryGrid(){
				var options = {
					url : "<spring:url value='/system/sktmpLinkedHistoryGrid.do' />"
					, searchParam : $("#sktmpSearchForm").serializeJson()
					, height : 400
					, colModels : [
						//연동 번호
                        {name:"mpLnkHistNo", label:'<spring:message code="column.lnk_no" />', width:"100", align:"center" , sortable : false}	
						//연동 구분 코드
						, {name:"mpLnkGbCd", label:'<spring:message code="column.lnk_gb" />', width:"200", align:"center" , sortable : false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.MP_LNK_GB}" />"}}
                      	//사용
                        , {name:"viewUsePnt", label:'<spring:message code="column.sktmp.hist.use" />', width:"80", align:"center" , sortable : false, formatter:linkGridNumFormat}
                      	//적립
                        , {name:"viewSavePnt", label:'<spring:message code="column.sktmp.hist.accum" />', width:"80", align:"center" , sortable : false, formatter:linkGridNumFormat}
                      	//사용 취소
                        , {name:"viewUseCncPnt", label:'<spring:message code="column.sktmp.hist.use_cancel" />', width:"80", align:"center" , sortable : false, formatter:linkGridNumFormat}
	                    //적립 취소
                        , {name:"viewSaveCncPnt", label:'<spring:message code="column.sktmp.hist.accum_cancel" />', width:"80", align:"center" , sortable : false, formatter:linkGridNumFormat}
                      	//연동 일자
						, {name:'reqDtm', label:'<spring:message code="column.lnk_dt" />', width:'150', align:'center' , formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss",sortable : false }
						//연동 처리 결과
						, {name:"reqScssYn", label:'<spring:message code="column.lnk_req_result" />', width:"150", align:"center", sortable : false , formatter:function(cellValue, options, rowObject){
							var str;
							if(rowObject.resCd == "00"){
								str = "성공";
							}else{
								str = "실패"
							}
							return str;
						}}
						//결과 메시지
						, {name:"cfmRstMsg", label:'<spring:message code="column.rst_msg" />', width:"150", align:"center", sortable : false, formatter:function(cellValue, options, rowObject){
							if(rowObject.resCd =='00'){
								return "전송 성공";
							}else{
								return rowObject.cfmRstMsg;
							}
						}}
						//에러 처리 일자
						, {name:"errPrcsReqDtm", label:'<spring:message code="column.lnk_err_req_dtm" />', width:"150", align:"center", sortable : false , formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
						//에러 처리 결과
						, {name:"errPrcsScssYn", label:'<spring:message code="column.lnk_err_req_result" />', width:"150", align:"center", sortable : false, formatter:function(cellValue, options, rowObject){
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
						, {name:"errRequest", label:'<spring:message code="column.lnk_err_re_req" />', width:"150", align:"center" , sortable : false, formatter:function(cellValue, options, rowObject){
							var str = "";
							//원 연동 응답 코드가 정상 or 주문건인경우 null 이고, 재요청필요한경우
							if(rowObject.resCd == "100" || rowObject.resCd == "101" || rowObject.resCd == "102"){
								str = '<button type="button" style="padding:5px 5px;" onclick="reReqSktmp(\''+options.rowId+'\')" class="btn">재전송</button>'
							}
							return str;
						}}
						, {name:"resCd", hidden:true}
						, {name:"orgResCd", hidden:true}
					]
				}
				grid.create("sktmpLinkedList", options);
				
				// Header Group
				$("#sktmpLinkedList").jqGrid('setGroupHeaders', {
				  useColSpanStyle: true, 
				  groupHeaders:[
					{startColumnName: 'viewUsePnt', numberOfColumns: 4, titleText: '우주코인 내역'},
				  ]	
				});
			}

			function reloadSktmpLinkedHistoryGrid() {
				//검색버튼 click이후에 alert창 띄우기 
				compareDateAlert("reqStrtDtm", "reqEndDtm", "term");
				
				var searchParam = $("#sktmpSearchForm").serializeJson();
				if($("#chkSaveYn").is(":checked")){
					searchParam.chkSaveYn = "Y";
				}else{
					searchParam.chkSaveYn = "N";
				}
				var options = {
					searchParam : searchParam
				};
				
				gridReload('reqStrtDtm','reqEndDtm','sktmpLinkedList','term', options);
			}

            
            // 초기화 버튼클릭
            function searchReset () {
                resetForm ("sktmpSearchForm");
                searchDateChange();
            }            
            
            // 등록기간
            function searchDateChange() {
                var term = $("#checkOptDate").children("option:selected").val();
                if(term == "") {
                    $("#reqStrtDtm").val("");
                    $("#reqEndDtm").val("");
                } else {
                    setSearchDate(term, "reqStrtDtm", "reqEndDtm");
                }
            }
            
            function reReqSktmp(rowId){
            	var rowData = $("#sktmpLinkedList").getRowData(rowId);
            	if(rowData.orgResCd && rowData.orgResCd != "00"){
            		messager.alert("이전 요청값의 연동처리여부가 성공이 아닙니다. 이전 연동부터 순차 재요청해주세요." , "Info", "info");
            		return;
            	}
            	
            	messager.confirm('재전송 하시겠습니까?',function(r){
            		if(r){
            			var options = {
                        	url : "<spring:url value='/system/reReqSktmpLnkHist.do' />"
                         	, data : {
                         		mpLnkHistNo : rowData.mpLnkHistNo
                         	}
                         	, callBack : function(result){
                         		if(result.resCd == "00"){
	                         		messager.alert("처리 되었습니다.","Info","info", function(){
	                         			reloadSktmpLinkedHistoryGrid();
	                         		});
                         		}else{
                         			messager.alert(result.cfmRstMsg,"Info","info", function(){
	                         			reloadSktmpLinkedHistoryGrid();
	                         		});
                         		}
                         	}
                     	};
                     	ajax.call(options);
            		}
				});
            	
            }
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form name="sktmpSearchForm" id="sktmpSearchForm" method="post">
				<table class="table_type1">
					<caption>우주코인 연동이력 검색</caption>
					<colgroup>
						<col width="15%"/>
						<col width="40%"/>
						<col width="12%"/>
					</colgroup>
					<tbody>
						<tr>
							<!-- 연동 일자 -->
							<th scope="row"> <spring:message code="column.lnk_dt" /></th>
							<td>
                              <frame:datepicker startDate="reqStrtDtm" endDate="reqEndDtm" />
                               <select id="checkOptDate" class="ml5" onchange="searchDateChange();">
                                   <frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_40}" defaultName="기간 선택"/>
                               </select>
							</td>
							<!-- 연동 번호 -->
							<th scope="row"><spring:message code="column.lnk_no" /></th>
							<td>
								<input type="text" id ="mpLnkHistNo" name="mpLnkHistNo" />
							</td>
						</tr>
						<tr>
							<!-- 연동 구분 -->
							<th scope="row"><spring:message code="column.lnk_gb" /></th>
							<td>
								<select id ="mpLnkGbCd" name="mpLnkGbCd">
									<frame:select grpCd="${adminConstants.MP_LNK_GB }" defaultName="전체"/>
								</select>
								<label class="fCheck">
									<input type="checkbox" name="chkSaveYn" id="chkSaveYn">
									<span>1일1회 적립초과</span>
								</label>
							</td>
							<!-- 주문번호 -->
	                        <th scope="row"><spring:message code="column.ord_no" /></th>
	                        <td>
	                            <select name="searchKeyOrder" id="searchKeyOrder" class="w100" title="선택상자" >
	                                <option value="type01">주문번호</option>
	                                <option value="type02">주문자명</option>
	                                <option value="type03">주문자ID</option>
	                                <option value="type04">수령인명</option>
	                            </select>
	                            <input type="text" name="searchValueOrder" id="searchValueOrder" class="w120"  value="" />
	                        </td>
						</tr>
						<tr>
							<!-- 클레임번호 -->
							<th scope="row"><spring:message code="column.clm_no" /></th>
							<td>
								<input type="text" id ="clmNo" name="clmNo" />
							</td>
							<!-- 연동 처리 여부 -->
							<th scope="row"><spring:message code="column.lnk_req_scss_yn" /></th>
							<td>
								<select id ="reqScssYn" name="reqScssYn">
									<frame:select grpCd="${adminConstants.LNK_SUCC_YN }" defaultName="전체"/>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.lnk_err_succ_yn" /></th>
							<td colspan="3">
								<select id ="errPrcsScssYn" name="errPrcsScssYn">
									<frame:select grpCd="${adminConstants.ERR_PRCS_SCSS_YN }" defaultName="전체"/>
								</select>
							</td>			
						</tr>
					</tbody>
				</table>
				</form>
				
				<div class="btn_area_center">
					<button type="button" onclick="reloadSktmpLinkedHistoryGrid();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
				
			</div>
		</div>	
		

		<div class="mModule">
			<table id="sktmpLinkedList" ></table>
			<div id="sktmpLinkedListPage"></div>
		</div>

	</t:putAttribute>
</t:insertDefinition>
