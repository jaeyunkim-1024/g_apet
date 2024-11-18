<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">

		<script type="text/javascript">
			$(document).ready(function(){
				searchDateChange();
				createRefundListGrid();
				$("input[name=compNm]").prop("disabled", true);
				$("select[name=pageGbCd]").prop("disabled", true);
			});

			// 환불 목록 그리드
			function createRefundListGrid(){

				var options = {
					url : "<spring:url value='/claim/claimRefundListGrid.do' />"
					, height : 400
					, searchParam : $("#orderSearchForm").serializeJson()
					, colModels : [
						// 현금 환불 번호
						  {name:"cashRfdNo", label:'<b><u><tt><spring:message code="column.cash_rfd_no" /></tt></u></b>', width:"80", align:"center", sortable:false, classes:'pointer fontbold'}
						/* 결제 번호 */
						, {name:"payNo", label:'<spring:message code="column.pay_no" />', width:"80", align:"center", sortable:false, hidden : true}
			 			// 주문 번호
			 			, {name:"ordNo", label:'<b><u><tt><spring:message code="column.ord_no" /></tt></u></b>', width:"110", align:"center", sortable:false, classes:'pointer underline'}
			 			// 클레임 번호
			 			, {name:"clmNo", label:'<b><u><tt><spring:message code="column.clm_no" /></tt></u></b>', width:"120", align:"center", sortable:false, classes:'pointer underline'}
						// 환불 유형 코드
						, {name:"rfdTpCd", label:'<spring:message code="column.rfd_tp_cd" />', width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.RFD_TP}" />"}}
						// 환불 상태 코드
						, {name:"rfdStatCd", label:'<spring:message code="column.rfd_stat_cd" />', width:"60", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.RFD_STAT}" />"}}
						// 은행 코드
						, {name:"bankCd", label:'<spring:message code="column.bank_cd" />', width:"130", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.BANK}" />"}}
						// 계좌 번호
						, {name:"acctNo", label:'<spring:message code="column.acct_no" />', width:"150", align:"center", sortable:false}
						// 예금주 명
						, {name:"ooaNm", label:'<spring:message code="column.ooa_nm" />', width:"100", align:"center", sortable:false}
						// 예정 금액
						, {name:"schdAmt", label:'<spring:message code="column.schd_amt" />', width:"80", align:"center", sortable:false, formatter:'integer'}
						// 환불 금액
						, {name:"rfdAmt", label:'<spring:message code="column.rfd_amt" />', width:"80", align:"center", sortable:false, formatter:'integer'}
						// 완료자 명
						, {name:"cpltrNm", label:'<spring:message code="column.cpltr_nm" />', width:"100", align:"center", sortable:false}
						// 완료 일시
						, {name:"cpltDtm", label:'<spring:message code="column.cplt_dtm" />', width:"130", align:"center", sortable:false, formatter:gridFormat.date, datefomat:"yyyy-MM-dd HH:mm:ss"}
						// 메모
						, {name:"memo", label:'<spring:message code="column.memo" />', width:"300", align:"center", sortable:false}
						// 등록자
						, {name:"sysRegrNm", label:'<spring:message code="column.sys_regr_nm" />', width:"100", align:"center", sortable:false}
						// 등록 일시
						, {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_dtm" />', width:"130", align:"center", sortable:false, formatter:gridFormat.date, datefomat:"yyyy-MM-dd HH:mm:ss"}
						// 수정자
						, {name:"sysUpdrNm", label:'<spring:message code="column.sys_updr_nm" />', width:"100", align:"center", sortable:false}
						// 수정 일시
						, {name:"sysUpdDtm", label:'<spring:message code="column.sys_upd_dtm" />', width:"130", align:"center", sortable:false, formatter:gridFormat.date, datefomat:"yyyy-MM-dd HH:mm:ss"}
						
					]
					,multiselect : true
					,onCellSelect: function(rowid, index, contents, e){ // cell을 클릭 시
						
						var cm = $("#refundList").jqGrid("getGridParam", "colModel");
						var rowData = $("#refundList").getRowData(rowid);

						if(cm[index].name == "ordNo"){
							fnOrderDetailView(rowData.ordNo);
						}

						if(cm[index].name == "clmNo"){
							fnClaimDetailView(rowData.clmNo);
						}
					}
					
				};

				grid.create( "refundList", options) ;

			}

/* 			// 그리드 체크 박스 클릭 : 클레임 단위 토글
			$(document).on("click", "#orderList input[name=arrClmNo]", function(e){
// 				alert( $(this).val() );
				var checked = $(this).is(":checked");
				$("#orderList input[name=arrClmNo]").prop("checked", false);
				$(this).prop("checked", checked);
			}); */

			// 주문상세
			function fnOrderDetailView(ordNo) {
				addTab('주문 상세', '/refund/orderDetailView.do?ordNo=' + ordNo + "&viewGb=" + '${adminConstants.VIEW_GB_POP}');
			}
			
			// 클레임상세
			function fnClaimDetailView(clmNo) {
				addTab('클레임 상세', '/refund/claimDetailView.do?clmNo=' + clmNo);
			}
			// 사이트 검색
			function searchSt () {
				var options = {
					multiselect : false
					, callBack : searchStCallback
				}
				layerStList.create (options );
			}
			function searchStCallback (stList ) {
				if(stList.length > 0 ) {
					$("#stId").val (stList[0].stId );
					$("#stNm").val (stList[0].stNm );
				}
			}
			// 조회
			function reloadRefundListGrid() {

				// 주문 접수 일시 시작일
				var dtmStart = $("#dtmStart").val().replace(/-/gi, "");

				// 주문 접수 일시 종료일
				var dtmEnd = $("#dtmEnd").val().replace(/-/gi, "");

				// 시작일과 종료일 3개월 차이 계산
				
				/* if(dtmStart == "" || dtmEnd == ""){
					alert("검색 기간을 3개월 이내로 설정해 주세요.");
					return;
				} */
				
				var diffMonths = getDiffMonths(dtmStart, dtmEnd);

				if ( parseInt(diffMonths) > 3 ) {
					messager.alert("검색기간은 3개월을 초과할 수 없습니다.","info","info");
					return;
				}
				var data = $("#orderSearchForm").serializeJson();

				var options = {
					searchParam : data
				}

				grid.reload( "refundList", options );
			}

			// callback : 업체 검색
			function fnCallBackCompanySearchPop() {
				var data = {
					multiselect : true
					, callBack : function(result) {
						$("#compNo").val( result[0].compNo );
						$("#compNm").val( result[0].compNm );
					}
				}
				layerCompanyList.create(data);
			}

			// 검색 : 환불 상태코드 클릭
			$(document).on("click", 'input:checkbox[name="arrRfdStatCd"]', function(e) {

				var all = false;

				if ( validation.isNull( $(this).val() ) ){
					all = true;
				}
				if ( $('input:checkbox[name="arrRfdStatCd"]:checked').length == 0 ) {
					$('input:checkbox[name="arrRfdStatCd"]').eq(0).prop( "checked", true );
				} else {
					$('input:checkbox[name="arrRfdStatCd"]').each( function() {
						if ( all ) {
							if ( validation.isNull( $(this).val() ) ) {
								$(this).prop("checked", true);
							} else {
								$(this).prop("checked", false);
							}
						} else {
							if ( validation.isNull($(this).val() ) ) {
								$(this).prop("checked", false);
							}
						}
					});
				}

			});

			// 판매공간 라디오 버튼 클릭
			$(document).on("click", "#orderSearchForm input[name=pageCheck]", function(e){
				if( $(this).val() == "" ) {
					$("select[name=pageGbCd]").prop("disabled", true);
				} else if ( $(this).val() == "01" ) {
					$("select[name=pageGbCd]").prop("disabled", false);
				}
			});

			// 환불실행
			function fnClaimRefundExec() {
				
				var grid = $("#refundList");
				var selectedIDs = grid.getGridParam("selarrrow");
				//선택되지 않은경우
				if ( selectedIDs.length == 0 ) {
					messager.alert("환불내역을 선택하세요.","info","info");
					return;
				}
				if ( selectedIDs.length > 1 ) {
					messager.alert("단일건별 처리가 가능합니다.","info","info");
					return;
				}
				var cashRfdNo ;  
				for ( var i in selectedIDs ) {
					var rowData = grid.getRowData( selectedIDs[i] );
					 
					if ( rowData.rfdStatCd != '${adminConstants.RFD_STAT_20}') {
						messager.alert("환불 상태가 진행중인 데이터만 환불실행을 할 수 있습니다.","info","info");
  						return;
  					}
					cashRfdNo = rowData.cashRfdNo ;
				} 
				var data = {cashRfdNo : cashRfdNo};
				
				var options = {
					url : '/claim/claimRefundExecPopView.do'
					, data : data
					, dataType : "html"
					, callBack : function (data ) {
						var config = {
							id : "claimRefundExecView"
							, width : 1000
							, height : 400
							, top : 200
							, title : "환불실행"
							, body : data
							, button : "<button type=\"button\" onclick=\"fnPopClaimRefundExec();\" class=\"btn btn-ok\">환불실행</button>"
						}
						layer.create(config);
					}
				}
				ajax.call(options );

			}

			// 엑셀 다운로드
			function claimRefundListExcelDownload() {
				createFormSubmit( "claimRefundListExcelDownload", "/claim/claimRefundListExcelDownload.do", $("#orderSearchForm").serializeJson() );
			}
			
			
			function searchDateChange() {
				var term = $("#checkOptDate").children("option:selected").val();
				if(term == "") {
					$("#dtmStart").val("");
					$("#dtmEnd").val("");
				} else {
					setSearchDate(term, "dtmStart", "dtmEnd");
				}
			}

		</script>

	</t:putAttribute>

	<t:putAttribute name="content">

		<!-- ==================================================================== -->
		<!-- 검색 -->
		<!-- ==================================================================== -->
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form name="orderSearchForm" id="orderSearchForm">
					<input type="hidden" name="arrClmDtlStatCd">
					
					<input type="hidden" name="mbrNo" value="${orderSO.mbrNo }">
		
					<table class="table_type1">
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.rfd_accept_dtm" /></th>
								<td>
									<frame:datepicker startDate="dtmStart" endDate="dtmEnd" startValue="${adminConstants.COMMON_START_DATE }" />
									&nbsp;&nbsp;
									<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();" style="width:120px !important;">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }"  selectKey="${adminConstants.SELECT_PERIOD_20 }" defaultName="기간선택" />
									</select>
								</td>
								<th scope="row"><spring:message code="column.rfd_tp_cd" /></th>
								<td>
									<select name="rfdTpCd" class="wth100" title="선택상자" >
										<frame:select grpCd="${adminConstants.RFD_TP }" defaultName="전체"  />
									</select>
									
								</td>
							</tr>
							<tr> 
								<th scope="row"><spring:message code="column.rfd_stat_cd" /></th>
								<td colspan="3">
									<select name="rfdStatCd" class="wth100" title="선택상자" >
										<frame:select grpCd="${adminConstants.RFD_STAT }" defaultName="전체"  />
									</select>
								</td>
							</tr>
							 
						</tbody>
					</table>
				</form>
				
		
				<div class="btn_area_center">
					<button type="button" onclick="reloadRefundListGrid();" class="btn btn-ok">검색</button>
					<button type="button" onclick="resetForm('orderSearchForm');" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>
		<!-- ==================================================================== -->
		<!-- 검색 -->
		<!-- ==================================================================== -->


		<!-- ==================================================================== -->
		<!-- 그리드 -->
		<!-- ==================================================================== -->
		<div class="mModule">
			<div class="mButton">
				<div class="leftInner">
					<button type="button" onclick="fnClaimRefundExec();" class="btn btn-add">
						<spring:message code='column.order_common.btn.claim_refund_final' />
					</button>
					<%-- <button type="button" onclick="fnClaimRefundFinal();" class="btn_h25_type1">
						<spring:message code='column.order_common.btn.claim_refund_final' />
					</button> --%>
				</div>
				<div class="rightInner">
					<button type="button" onclick="claimRefundListExcelDownload();" class="btn btn-add btn-excel"><spring:message code='column.common.btn.excel_download' /></button>
				</div>
			</div>
			
			<table id="refundList" ></table>
			<div id="refundListPage"></div>
		</div>
		<!-- ==================================================================== -->
		<!-- //그리드 -->
		<!-- ==================================================================== -->

	</t:putAttribute>

</t:insertDefinition>
