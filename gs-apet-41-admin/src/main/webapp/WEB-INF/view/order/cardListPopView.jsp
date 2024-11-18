<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">
	  	$(document).ready(function() {
			
			payBaseCardListGrid();
		});

		// 쪽지 목록
		function payBaseCardListGrid(){
			var options = {
				url : "<spring:url value='/order/payBaseCardListGrid.do' />"
				, height : 250
				, searchParam : {
					ordNo : '${ordNo}'
				}
				, colModels : [
					//주문번호
					{name:"ordNo", label:'<spring:message code="column.ord_no" />', hidden : true}
					
					// 결제 번호
					, {name:"payNo", label:'<spring:message code="column.pay_no" />', width:"80", align:"center", sortable:false}
					, {name:"button", label:'카드영수증 ', width:"80", align:"center", sortable:false  , formatter: function(rowId, val, rawObject, cm) {
						var str =  '';
						if( undefined != rawObject.dealNo && rawObject.dealNo != null && rawObject.dealNo != "" ){
							str =  '<button type="button" onclick="fnPayBaseCard( \'' + rawObject.dealNo + '\',\'' + rawObject.cardReceiptUrl + '\')" class="btn_h25_type1">카드영수증</button>';
						}  
						return str;
					}}
					
					/*
					
					, {name:"payStatCd", label:'<spring:message code="column.pay_stat_cd" />', width:"80", align:"center", sortable:false }
					// 거래번호
					, {name:"dealNo", label:'<spring:message code="column.deal_no" />', width:"150", align:"center", sortable:false }
					// 거래번호
					, {name:"cardReceiptUrl", label:'cardReceiptUrl', width:"150", align:"center", sortable:false  }
					 */
					// 주문 클레임 구분 
					, {name:"ordClmGbCd", label:'<spring:message code="column.ord_clm_gb_cd" />', width:"70", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.ORD_CLM_GB}" />"} }
					// 결제 수단
					, {name:"payMeansCd", index:"payMeansCd", label:'<spring:message code="column.pay_means_cd" />', width:"80", align:"center", formatter:"select", sortable:false, editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.PAY_MEANS}" />"}}			
					// 결제 구분
					, {name:"payGbCd", label:'<spring:message code="column.pay_gb_cd" />', width:"80", align:"center", sortable:false, formatter:"select",  editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.PAY_GB}" />"}}			
					// 결제상태
					, {name:"payStatCd", label:'<spring:message code="column.pay_stat_cd" />', width:"80", align:"center", sortable:false, formatter:"select",  editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.PAY_STAT}" />"}}
					// 결제 금액
					, {name:"payAmt", label:'<spring:message code="column.pay_amt" />', width:"150", align:"center", sortable:false, formatter:'integer', formatoptions:{thousandsSeparator:','}, summaryType:'sum', summaryTpl : 'Totals:'}	
					// 결제 완료 일시
					, {name:"payCpltDtm", label:'<spring:message code="column.pay_cplt_dtm" />', width:"110", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm"}
					// 거래번호
					, {name:"dealNo", label:'<spring:message code="column.deal_no" />', width:"150", align:"center", sortable:false, hidden : true}
					// 거래번호
					, {name:"cardReceiptUrl", label:'cardReceiptUrl', width:"150", align:"center", sortable:false , hidden : true}
					
					// 승인번호
					, {name:"cfmNo", label:'<spring:message code="column.cfm_no" />', width:"120", align:"center", sortable:false}
					// 승인 일시
					, {name:"cfmDtm", label:'<spring:message code="column.cfm_dtm" />', width:"110", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm"}
					// 승인 결과 메세지
					, {name:"cfmRstMsg", label:'<spring:message code="column.cfm_rst_msg" />', width:"150", align:"left",  sortable:false}
					// 카드사코드
					, {name:"cardcCd", label:'<spring:message code="column.cardc_cd" />', width:"80", align:"center", formatter:"select", sortable:false, editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CARDC}" />"}}
					 
				]
				, paging : true
				/* , onSelectRow : function(ids) {
					var rowdata = $("#payBaseCardList").getRowData(ids);
					//코드관리_그룹 상세 조회
					//payBaseCard(rowdata.cashReceiptUrl);
				} */
			};
			grid.create("payBaseCardList", options);
		}
	 
		
		// 결제  
		function fnPayBaseCard( dealNo, cardReceiptUrl) {
			
			//console.log(dealNo +"//"+cashReceiptUrl);
			//return;
			var config = {
				  url : cardReceiptUrl
				, width : '430'
				, height : '530'
				, target : dealNo
				, scrollbars : 'no'
				, resizable : 'no'
				, location : 'no'
				, menubar : 'no'
				 
			};
			openWindowPop(config);  
		}
		
   
		</script>
	
		<div class="mModule">
			<table id="payBaseCardList" ></table>
			<div id="payBaseCardListPage"></div>
		</div>
			
