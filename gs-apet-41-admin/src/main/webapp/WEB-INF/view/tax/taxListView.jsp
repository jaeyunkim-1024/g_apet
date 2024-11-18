<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="title">세금계산서</t:putAttribute>

	<t:putAttribute name="script">

		<jsp:include page="/WEB-INF/view/tax/include/incTaxList.jsp" />

		<script type="text/javascript">
			$(document).ready(function(){
				createOrderListGrid();
				$("input[name=compNm]").prop("disabled", true);
				$("select[name=pageGbCd]").prop("disabled", true);
			});

			// 주문 상품 그리드
			function createOrderListGrid(){

				var options = $.extend( {} , orderGridListCommon, {
					url : "<spring:url value='/tax/taxListGrid.do' />"
					, height : 400
					, datatype : 'local'
					, searchParam : $("#orderSearchForm").serializeJson()
					, onSelectRow : function(ids) {	// row click

						// 로우 데이터
						var rowData = $("#orderList").getRowData(ids);

						var checked = $("#orderList input[name=arrOrdNo]:checkbox[value=" + rowData.ordNo + "]").is(":checked");
						$("#orderList input[name=arrOrdNo]").prop("checked", false);
						$("#orderList input[name=arrOrdNo]:checkbox[value=" + rowData.ordNo + "]").prop("checked", !checked);

					}
				});

				grid.create( "orderList", options) ;

			}

			// 그리드 체크 박스 클릭 : 주문번호 단위 토글
			$(document).on("click", "#orderList input[name=arrOrdNo]", function(e){
				var checked = $(this).is(":checked");
				$("#orderList input[name=arrOrdNo]").prop("checked", false);
				$(this).prop("checked", checked);
			});

			// 주문상세
			function fnOrderDetailView(ordNo) {
				addTab('주문 상세', '/tax/orderDetailView.do?ordNo=' + ordNo + "&compNo=" + $("#compNo").val());
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
			function reloadOrderListGrid() {

				// 주문 접수 일시 시작일
				var ordAcptDtmStart = $("#ordAcptDtmStart").val().replace(/-/gi, "");

				// 주문 접수 일시 종료일
				var ordAcptDtmEnd = $("#ordAcptDtmEnd").val().replace(/-/gi, "");

				// 시작일과 종료일 3개월 차이 계산
				var diffMonths = getDiffMonths(ordAcptDtmStart, ordAcptDtmEnd);

				if ( eval(diffMonths) > 3 ) {
					messager.alert( "검색기간은 3개월을 초과할 수 없습니다." ,"Info","info");
					return;
				}

				// 판매 공간 체크
				if ( $("input:radio[name=pageCheck]:checked").val() == '01' ) {
					if ( $("select[name=pageGbCd]").val() == '' ) {
						messager.alert("외부몰을 선택하세요." ,"Info","info");
					}
				}

				var data = $("#orderSearchForm").serializeJson();
				if ( undefined != data.arrTaxIvcStatCd && data.arrTaxIvcStatCd != null && Array.isArray(data.arrTaxIvcStatCd) ) {
					$.extend( data, { arrTaxIvcStatCd : data.arrTaxIvcStatCd.join(",") } );
				}
				if ( undefined != data.arrOrdDtlStatCd && data.arrOrdDtlStatCd != null && Array.isArray(data.arrOrdDtlStatCd) ) {
					$.extend( data, { arrOrdDtlStatCd : data.arrOrdDtlStatCd.join(",") } );
				}

				var options = {
					searchParam : data
				}

				grid.reload( "orderList", options );
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

			// 검색 : 주문 상세 상태코드 클릭
			$(document).on("click", 'input:checkbox[name="arrOrdDtlStatCd"]', function(e) {

				var all = false;

				if ( validation.isNull( $(this).val() ) ){
					all = true;
				}
				if ( $('input:checkbox[name="arrOrdDtlStatCd"]:checked').length == 0 ) {
					$('input:checkbox[name="arrOrdDtlStatCd"]').eq(0).prop( "checked", true );
				} else {
					$('input:checkbox[name="arrOrdDtlStatCd"]').each( function() {
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

			// 검색 : 세금 계산서 상태코드 클릭
			$(document).on("click", 'input:checkbox[name="arrTaxIvcStatCd"]', function(e) {

				var all = false;

				if ( validation.isNull( $(this).val() ) ){
					all = true;
				}
				if ( $('input:checkbox[name="arrTaxIvcStatCd"]:checked').length == 0 ) {
					$('input:checkbox[name="arrTaxIvcStatCd"]').eq(0).prop( "checked", true );
				} else {
					$('input:checkbox[name="arrTaxIvcStatCd"]').each( function() {
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

			// 세금 계산서 상세 보기 팝업
			function fnTaxInvoiceDetailPop() {

				if ( $("#orderList input[name=arrOrdNo]:checked").length == 0 ) {
					messager.alert("주문 번호를 선택하세요." ,"Info","info");
					return;
				}

				var ordNo = $("#orderList input[name=arrOrdNo]:checked").val();
				
				var btn = '';
				if ('${taxInvoice.taxIvcStatCd}' == '${adminConstants.TAX_IVC_STAT_01}')
					btn = "<button type=\"button\" onclick=\"fnTaxInvoicePublishExec();\" class=\"btn btn-ok\">세금계산서 발행</button>"
					
			
				var options = {
					url : '/tax/taxInvoiceDetailPopView.do'
					, data : {ordNo : ordNo}
					, dataType : "html"
					, callBack : function (data ) {
						var config = {
							id : "taxInvoiceDetailView"
							, width : 1000
							, height : 800
							, top : 200
							, title : "세금 계산서 상세"
							, body : data
							, button : btn
						}
						layer.create(config);
					}
				}
				ajax.call(options );

			}

			// 세금 계산서 접수 팝업
			function fnTaxInvoiceAcceptPop() {

				var id = $('#orderList').getDataIDs();
				var ordNo = null;
				var ordrMobile = null;
				for ( var i=0; id.length > i; i++ ) {
					var rowData = $("#orderList").getRowData(id[i]);

					if ( rowData.checkbox == "Yes" ) {

						if ( rowData.taxIvcStatCd == "${adminConstants.CASH_RCT_STAT_10 }" ) {
							messager.alert("세금 계산서로 접수건이 이미 존재합니다." ,"Info","info");
							return;
						} else {
							ordNo = rowData.ordNo;
							ordrMobile = rowData.ordrMobile;
							break;
						}
					}
				}

				if ( ordNo == null || ordNo.length == 0 ) {
					messager.alert("주문 번호를 선택하세요." ,"Info","info");
					return;
				}

				var options = {
					url : '/tax/taxInvoiceAcceptPopView.do'
					, data : {ordNo : ordNo, ordrMobile : ordrMobile}
					, dataType : "html"
					, callBack : function (data ) {
						var config = {
							id : "taxInvoiceAcceptView"
							, width : 1000
							, height : 400
							, top : 200
							, title : "세금 계산서 접수"
							, body : data
							, button : "<button type=\"button\" onclick=\"fnCashReceiptAcceptExec();\" class=\"btn btn-ok\">세금계산서 접수</button>"
						}
						layer.create(config);
					}
				}
				ajax.call(options );

			}

			// 세금 계산서 발행
			function fnTaxInvoicePublishExec() {

				var id = $('#orderList').getDataIDs();
				var ordNo = null;
				for ( var i=0; id.length > i; i++ ) {
					var rowData = $("#orderList").getRowData(id[i]);

					if ( rowData.checkbox == "Yes" ) {

						if ( rowData.taxIvcStatCd != "${adminConstants.CASH_RCT_STAT_10 }" ) {
							messager.alert("세금 계산서로 접수된 건이 없으므로 발행을 계속할 수 업습니다." ,"Info","info");
							return;
						} else {
							ordNo = rowData.ordNo;
							break;
						}
					}
				}

				if ( ordNo == null || ordNo.length == 0 ) {
					messager.alert("주문 번호를 선택하세요." ,"Info","info");
					return;
				}

// 				console.debug(ordNo);
				
				messager.confirm('세금계산서를 ' + '<spring:message code="column.common.confirm.publish" />',function(r){
					if(r){
						var options = {
							url : "<spring:url value='/tax/taxInvoicePublishExec.do' />"
							, data : {ordNo : ordNo }
							, callBack : function(data ) {
								messager.alert( "<spring:message code='column.common.publish.final_msg' />", "Info", "info", function(){
									reloadOrderListGrid();
								});
								
							}
						};

						ajax.call(options);
					}
				});

			}

			// 판매공간 라디오 버튼 클릭
			$(document).on("click", "#orderSearchForm input[name=pageCheck]", function(e){
				if( $(this).val() == "" ) {
					$("select[name=pageGbCd]").prop("disabled", true);
				} else if ( $(this).val() == "01" ) {
					$("select[name=pageGbCd]").prop("disabled", false);
				}
			});

			// 엑셀 다운로드
			function taxListExcelDownload() {
				createFormSubmit( "taxListExcelDownload", "/tax/taxListExcelDownload.do", $("#orderSearchForm").serializeJson() );
			}

		</script>

	</t:putAttribute>

	<t:putAttribute name="content">

		<!-- ==================================================================== -->
		<!-- 검색 -->
		<!-- ==================================================================== -->
		<jsp:include page="/WEB-INF/view/order/include/incSearchInfo.jsp" />

		<div class="btn_area_center">
			<button type="button" onclick="reloadOrderListGrid('');" class="btn btn-ok">검색</button>
			<button type="button" onclick="resetForm('orderSearchForm');" class="btn btn-cancel">초기화</button>
		</div>
		<!-- ==================================================================== -->
		<!-- 검색 -->
		<!-- ==================================================================== -->

		<!-- ==================================================================== -->
		<!-- 그리드 -->
		<!-- ==================================================================== -->
		<div class="mModule">
			<div class="leftInner">
 				<button type="button" onclick="fnTaxInvoiceAcceptPop();" class="btn btn-add"><spring:message code='column.order_common.btn.tax_accept' /></button>
 				<button type="button" onclick="fnTaxInvoicePublishExec();" class="btn btn-add"><spring:message code='column.order_common.btn.tax_publish' /></button>
				<button type="button" onclick="fnTaxInvoiceDetailPop();" class="btn btn-add"><spring:message code='column.order_common.btn.tax_view' /></button>
			</div>
			<div class="rightInner">
				<button type="button" onclick="taxListExcelDownload();" class="btn btn-add btn-excel">엑셀 다운로드</button>
			</div>
			
			<table id="orderList" ></table>
			<div id="orderListPage"></div>
		</div>
		<!-- ==================================================================== -->
		<!-- //그리드 -->
		<!-- ==================================================================== -->

	</t:putAttribute>

</t:insertDefinition>
