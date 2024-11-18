<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function() {
			searchDateChange();
			newSetCommonDatePickerEvent('#reqStrtDtm','#reqEndDtm');			
			createMpPntHistGrid();
			// 총금액 계산
			mpPnt.setTotlaInfo();
			
			//엔터 키 이벤트
			$(document).on("keydown","#sktmpSearchForm input[type='text']",function(e) {
				if (e.keyCode == 13) {
					reloadMpGrid();
				}
			})
		});

		// GS&포인트 내역 그리드
		function createMpPntHistGrid(){
			var options = {
				url : "<spring:url value='/settlement/sktmpPntHistListGrid.do' />"
				, height : 400
				, searchParam : $("#mpPntHistSearchForm").serializeJson()
				, sortname : "mpLnkHistNo"
				, sortorder : "desc"
				, colModels : [
					{name:"rowIndex", label:'NO', width:"60", align:"center", sortable:false}
					,{name:"mpLnkHistNo", hidden:true}
					/* 주문 번호 */
					, {name:"ordNo", label:'주문 번호', width:"90", align:"center", sortable:false}
					/* 클레임 번호 */
					, {name:"clmNo", label:'클레임 번호', width:"100", align:"center", sortable:false}
					/* 거래 구분 */
					, {name:"mpRealLnkGbCd", label:'거래구분', width:"80", align:"center", sortable:false , formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.MP_REAL_LNK_GB }' showValue='false' />"}}
					/* 적립 사용 구분 */
					, {name:"mpLnkGbCd", label:'적립사용 구분', width:"120", align:"center", sortable:false , formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.MP_LNK_GB }' showValue='false' />"}}
					/* 회원 번호 */
					, {name:"mbrNo", label:'user-no', width:"80", align:"center", sortable:false}
					/* 멤버십 번호 */
					, {name:"cardNo", label:'멤버십 번호', width:"120", align:"center", sortable:false}
					/* 총 결제 금액 */
					, {name:"payAmt", label:'총 결제 금액', width:"100", align:"right", formatter:"integer", sortable:false} 
					/* 우주코인 거래일시 */
					, {name:"reqDtm", label:'우주코인 거래일시', width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
					//사용
                    , {name:"viewUsePnt", label:'<spring:message code="column.sktmp.hist.use" />', width:"80", align:"center" , sortable : false, formatter:linkGridNumFormat}
                  	//적립
                    , {name:"viewSavePnt", label:'<spring:message code="column.sktmp.hist.accum" />', width:"80", align:"center" , sortable : false, formatter:linkGridNumFormat}
                  	//사용 취소
                    , {name:"viewUseCncPnt", label:'<spring:message code="column.sktmp.hist.use_cancel" />', width:"80", align:"center" , sortable : false, formatter:linkGridNumFormat}
                    //적립 취소
                    , {name:"viewSaveCncPnt", label:'<spring:message code="column.sktmp.hist.accum_cancel" />', width:"80", align:"center" , sortable : false, formatter:linkGridNumFormat}
				]
			};
			grid.create("mpPntHistList", options);
			
			// Header Group
			$("#mpPntHistList").jqGrid('setGroupHeaders', {
			  useColSpanStyle: true, 
			  groupHeaders:[
				{startColumnName: 'viewUsePnt', numberOfColumns: 4, titleText: '우주코인 내역'},
			  ]	
			});
		}
		
		//Number gridFormat
		function linkGridNumFormat(cellvalue, options, rowObject){
			if(cellvalue){
				return addComma(cellvalue);;
			}else{
				return '';
			}
		}
		
		/* 날짜 변경 적용 */
		function searchDateChange() {
			var term = $("#checkOptDate").children("option:selected").val();
			if(term == "") {
				$("#reqStrtDtm").val("");
				$("#reqEndDtm").val("");
			} else if(term == "50") {
				setSearchDateThreeMonth("reqStrtDtm","reqEndDtm");
			} else {
				setSearchDate(term, "reqStrtDtm", "reqEndDtm");
			}
		}	
		
		/* 검색 */
		function reloadMpGrid(){
			compareDateAlert('reqStrtDtm','reqEndDtm','term');
			var options = {
				searchParam : $("#mpPntHistSearchForm").serializeJson()
			};
			gridReload('reqStrtDtm','reqEndDtm','mpPntHistList','term', options);				
			// 총금액 계산
			mpPnt.setTotlaInfo();
		}
		
		/* 초기화 버튼클릭 */
		function searchReset () {
			resetForm ("mpPntHistSearchForm");
			searchDateChange();
		}
		
		/* 엑셀 다운로드 */
		function mpPntHistExcelDownload() {
			createFormSubmit("sktmpPntHistExcelDownload", "/settlement/sktmpPntHistExcelDownload.do", $("#mpPntHistSearchForm").serializeJson());
		}
		var mpPnt = {
			chgOrderInfo : function() {
				$("#searchValueOrder").val("");
			},
			setTotlaInfo : function() {
				var options = {
					url : "/settlement/getSktmpPntHistTotal.do"
					, data : $("#mpPntHistSearchForm").serializeJson()
					, callBack : function(data) {
						if( data.total != null && data.total.totalUsePnt != null){
							$("#totalUsePnt").html(valid.numberWithCommas(data.total.totalUsePnt));
						}else{
							$("#totalUsePnt").html("0");
						}
						if( data.total != null && data.total.totalSavePnt != null){
							$("#totalSavePnt").html(valid.numberWithCommas(data.total.totalSavePnt));
						}else{
							$("#totalSavePnt").html("0");
						}
						if( data.total != null && data.total.totalCncPnt != null){
							$("#totalCncPnt").html(valid.numberWithCommas(data.total.totalCncPnt));
						}else{
							$("#totalCncPnt").html("0");
						}
					}
				};
				ajax.call(options );
			}
		}
		</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="조회 조건" style="padding:10px">
				<form name="mpPntHistSearchForm" id="mpPntHistSearchForm" method="post">
					<table class="table_type1">
						<colgroup>
							<col width="150px"/>
							<col />
							<col width="150px"/>
							<col />
						</colgroup>
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<!-- 기간(등록일) -->
								<th scope="row">우주코인 거래일자</th>
								<td >
									<frame:datepicker startDate="reqStrtDtm" endDate="reqEndDtm"	startValue="${frame:toDate('yyyy-MM-dd') }" endValue="${frame:toDate('yyyy-MM-dd') }" /> 
									&nbsp;&nbsp; 
									<select id="checkOptDate" name="checkOptDate"	onchange="searchDateChange();">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_40 }"	defaultName="기간선택" />
									</select>
								</td>
								<!-- 주문정보 -->
								<th scope="row">주문번호</th>
								<td >
									<input type="text" name="ordNo" title="주문번호"/>
								</td>
							</tr>
							<tr>
								<!-- 클레임번호 -->
								<th scope="row"><spring:message code="column.clm_no" /></th>
								<td>
									<input type="text" id ="clmNo" name="clmNo" />
								</td>
								<!-- 거래 구분 -->
								<th scope="row">거래 구분</th>
								<td>
									<select id="mpRealLnkGbCd" name="mpRealLnkGbCd">
										<frame:select grpCd="${adminConstants.MP_REAL_LNK_GB }" defaultName="전체" />
									</select>
								</td>
							</tr>		
							<tr>
								<!-- 적립/사용 구분 -->
								<th scope="row">적립/사용 구분</th>
								<td>
									<select id="mpLnkGbCd" name="mpLnkGbCd">
										<frame:select grpCd="${adminConstants.MP_LNK_GB }" defaultName="전체" />
									</select>
								</td>
								<!-- 주문자 -->
		                        <th scope="row">주문자</th>
		                        <td>
		                            <select name="searchKeyOrder" id="searchKeyOrder" class="w100" title="선택상자" onchange="mpPnt.chgOrderInfo();">
		                            	<option value="type09">전체</option>
		                                <option value="type10">User-no</option>
		                                <option value="type11">멤버십번호</option>
		                            </select>
		                            <input type="text" name="searchValueOrder" id="searchValueOrder" class="w120"  value="" />
		                        </td>
								
							</tr>		
							<tr>
								<!-- 우주코인 금액 -->
								<th scope="row">우주코인 금액</th>
								<td>
									<input  class="numberOnly" type="text" name="searchPnt" title="우주코인 금액"/>
								</td>
							</tr>							
								
						</tbody>
					</table>
				</form>
		
				<div class="btn_area_center">
					<button type="button" onclick="reloadMpGrid('');" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

		<div class="mModule">
			<div id="resultArea" style="text-align: right;">
					<span>(총 사용금액 : <span id="totalUsePnt" class="comma">0</span>원, 적립금액 : <span id="totalSavePnt" class="comma">0</span>원, 취소금액 : <span id="totalCncPnt" class="comma">0</span>원) </span>
					<button type="button" onclick="mpPntHistExcelDownload();" class="btn btn-add btn-excel">엑셀 다운로드</button>
			</div>
			
			<table id="mpPntHistList"></table>
			<div id="mpPntHistListPage"></div>
		</div>
	</t:putAttribute>

</t:insertDefinition>