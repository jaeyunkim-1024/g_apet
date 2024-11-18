<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">

		<script type="text/javascript">
			$(document).ready(function(){
				<c:if test="${adminConstants.USR_GRP_10 eq session.usrGrpCd}">
					payBase.createList();
				</c:if>
				fnOnLoadDocument();
			});

			function fnOnLoadDocument(){
				orderDetail.createList();
				deliveryCharge.createList();
				claim.createList();
				cs.createList();

				var cnctHistNo = "${cnctHistNo}";
				var mbrNo = "${orderBase.mbrNo}";
				var colGbCd = "${adminConstants.COL_GB_00}";
				var maskingUnlock = $("#maskingUnlock").val();
				var inqrGbCd = maskingUnlock == "${adminConstants.COMM_YN_Y}" ? "${adminConstants.INQR_GB_10}" : "${adminConstants.INQR_GB_40}";
				var execSql = "${execSql}";

				va.init(cnctHistNo);
				va.ac(mbrNo,colGbCd,inqrGbCd,maskingUnlock,execSql);
			}

			function openNewPopOrTab(menuNm,url){
				var viewGb = "${viewGb}";
				if(viewGb == "${adminConstants.VIEW_GB_POP}"){
					window.open(url,menuNm,'width=1300,height=600,resizable=true,scrollbars=true');
				}else{
					addTab(menuNm,url);
				}
			}

			/*
			 * 주문 기본 기능
			 */
			var orderBase = {
				<c:if test="${adminConstants.USR_GRP_10 eq session.usrGrpCd and orderBase.ordCancelYn eq adminConstants.COMM_YN_N}">
					/* 수정 */
					update : function(){
						if ( validate.check("orderInfoForm")) {
							
							messager.confirm("<spring:message code='column.order_common.confirm.order_info_update' />",function(r){
								if(r){
									var options = {
										url : "<spring:url value='/order/orderInfoUpdate.do' />"
										, data : $("#orderInfoForm").serializeJson()
										, callBack : function(data){
											
											messager.alert('<spring:message code="column.common.edit.final_msg" />', "Info", "info", function(){
												updateTab();
											});
										}
									};
	
									ajax.call(options);			
								}
							});
						}
					}		
				</c:if>
			};
		
			<c:if test="${adminConstants.USR_GRP_10 eq session.usrGrpCd}">
			/*
			 * 배송지 기능
			 */
			var orderDlvra = {
					
				data : {
					zonecode 	: ""
					,postcode 	: ""
					,roadAddress  	: ""
					,jibunAddress  	: ""
				}			
				/* 배송지 정보 수정 */
				,update : function(){
					if($("#maskingUnlock").val() == "${adminConstants.COMM_YN_N}"){
						messager.alert('개인정보 해제를 하셔야 수정이 가능합니다.', "Info", "info");
					}
					if( validate.check("orderDeliveryAddressForm") && $("#maskingUnlock").val() == "${adminConstants.COMM_YN_Y}" ) {
						
						var ordDtlList = $("#orderGoodsList").getRowData();
						
						for(var i = 0; i < ordDtlList.length; i++) {
							
							if(ordDtlList[i].ordDtlStatCd != '${adminConstants.ORD_DTL_STAT_110}'
								&& ordDtlList[i].ordDtlStatCd != '${adminConstants.ORD_DTL_STAT_120}' 
								&& ordDtlList[i].ordDtlStatCd != '${adminConstants.ORD_DTL_STAT_130}' 
								&& ordDtlList[i].ordDtlStatCd != '${adminConstants.ORD_DTL_STAT_140}'){
								messager.alert('주문상세상태가 주문접수/주문완료/배송지시/배송준비중 일 경우에만 배송지 변경이 가능 합니다.', "Info", "info");
								return false;
							}
								
						}
						
						// 지번 상세주소
						$("#prclDtlAddr").val( $("#roadDtlAddr").val() );

						messager.confirm('<spring:message code="column.order_common.confirm.order_delivery_address_update" />',function(r){
							if(r){
								var options = {
									url : "<spring:url value='/order/orderDeliveryAddressUpdate.do' />"
									, data : $("#orderDeliveryAddressForm").serializeJson()
									, callBack : function(data){
										messager.alert('<spring:message code="column.common.edit.final_msg" />', "Info", "info", function(){
											updateTab();
										});
										
									}
								};

								ajax.call(options);
							}
						});
					}					
				}		
				/* 배송지주소 CallBack */
				,cbPost : function(data){
					this.data = data;
					orderDlvra.chkAddr(data);
				}

				// 도서 산간 지역 체크
				,chkAddr : function(data){

					if (this.data == null){
						return;
					}

					if(data.zonecode != null && data.zonecode != ""){

						this.checkLocalPost(data);
					}

				}
				,setAddr : function(data){

					if (data == null){
						return;
					}
					
					var chgPostNoNew = data.zonecode;
					var chgPrclAddr = data.jibunAddress;
					var chgRoadAddr = data.roadAddress;
					var chgRoadDtlAddr = data.addrDetail;
					
					var ac = $("#addressChanged").val();
					
					if(ac != "N"){
						
						// 신 우편번호
						$("#postNoNew").val(chgPostNoNew);
						// 지번 주소
						$("#prclAddr").val(chgPrclAddr);
						// 도로명 주소
						$("#roadAddr").val(chgRoadAddr);
						
						$("#roadDtlAddr").val(chgRoadDtlAddr);
						// 도로명 상세주소
						$("#roadDtlAddr").focus();
						
					}
					
				}
				, checkLocalPost : function(data){

					let addrData = data;

					var options = {
						url : "<spring:url value='/order/checkLocalPost.do' />"
						,data : {
							postNoNew : data.zonecode
							, postNoOld : ""
						}
						,callBack : function(data){
							
							var localPostYn = data.localPostYn;

							if($("#localPostYn").val() != localPostYn){
								if(localPostYn == "Y"){
									messager.alert("일반지역 배송지에서 도서/산간지역으로 배송지를 변경할 수 없습니다.","Info","info");
									$("#addressChanged").val("N");
								}else{
									messager.alert("도서/산간지역에서 일반지역 배송지로 배송지를 변경할 수 없습니다.","Info","info");
									$("#addressChanged").val("N");
								}
								
							}else{
								$("#addressChanged").val("Y");
								
							}
							
							orderDlvra.setAddr(addrData);
							
						}
					};
					ajax.call(options);
				}
			};
			</c:if>

			<c:if test="${adminConstants.USR_GRP_10 eq session.usrGrpCd}">
			/*
			 * 결제 기능
			 */
			var payBase = {
				/* 결제 목록 생성 */
				createList : function(){
					var options = {
						url : "<spring:url value='/order/payBaseListGrid.do' />"
						, height : 200
						, searchParam : {
								ordNo : '${orderBase.ordNo}'
							,	maskingUnlock : $("#maskingUnlock").val()
						}
						, colModels : [
				             // 주문번호
				             {name:"ordNo", label:'<spring:message code="column.ord_no" />', hidden : true}
                            // 결제 번호
                            , {name:"payNo", label:'<spring:message code="column.pay_no" />', width:"80", align:"center", sortable:false}
                         	// 주문 클레임 구분
				            , {name:"ordClmGbCd", label:'<spring:message code="column.ord_clm_gb" />', width:"100", align:"center", sortable:false, formatter:"select",  editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.ORD_CLM_GB}" />"}}			
				             // 결제 구분
				            , {name:"payGbCd", label:'<spring:message code="column.pay_gb_cd" />', width:"80", align:"center", sortable:false, formatter:"select",  editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.PAY_GB}" />"}}			
				             // 결제상태
				            , {name:"payStatCd", label:'<spring:message code="column.pay_stat_cd" />', width:"80", align:"center", sortable:false, formatter:"select",  editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.PAY_STAT}" />"}}
                            // 결제 수단
				            , {name:"payMeansCd", index:"payMeansCd", label:'<spring:message code="column.pay_means_cd" />', width:"80", align:"center", formatter:"select", sortable:false, editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.PAY_MEANS}" />"}}			
							// 결제 완료,
							/* , {name:"button", label:'<spring:message code="column.order_common.btn.order_pay_complete" />', width:"80", align:"center", sortable:false, formatter: function(rowId, val, rawObject, cm) {
								var str = '';
								
								<c:if test="${orderBase.ordCancelYn eq adminConstants.COMM_YN_N and orderBase.ordStatCd eq adminConstants.ORD_STAT_10}">
								if (rawObject.payMeansCd == '${adminConstants.PAY_MEANS_40}' && rawObject.payStatCd == '${adminConstants.PAY_STAT_00}'){
									str = '<button type="button" onclick="payBase.complete(\'' + rawObject.payNo + '\');" class="btn_h25_type1"><spring:message code="column.order_common.btn.order_pay_complete" /></button>';
								}
								</c:if>
								return str;
							}} */
				             // 결제 금액
				 			, {name:"payAmt", label:'<spring:message code="column.pay_amt" />', width:"150", align:"center", sortable:false, formatter:'integer', formatoptions:{thousandsSeparator:','}, summaryType:'sum', summaryTpl : 'Totals:', hidden : true}
							// 결제 금액 (마이너스 환불 제외)
							, {name:"payAmt01", label:'<spring:message code="column.pay_amt" />', width:"150", align:"center", sortable:false, formatter:'integer', formatoptions:{thousandsSeparator:','}, summaryType:'sum', summaryTpl : 'Totals:'}
				 			// 입금 금액 : 분리(마이너스 환불)
				 			, {name:"payAmt02", label:'<spring:message code="column.claim_common.deposit_amt" />', width:"150", align:"center", sortable:false, formatter:'integer', formatoptions:{thousandsSeparator:','}, summaryType:'sum', summaryTpl : 'Totals:'}
				 			, {name:"tempAmt", label:'<spring:message code="column.pay_amt" />', width:"150", align:"center", sortable:false, formatter:'integer', formatoptions:{thousandsSeparator:','}, hidden:true}
				 			, {name:"tempAmt01", label:'<spring:message code="column.pay_amt" />', width:"150", align:"center", sortable:false, formatter:'integer', formatoptions:{thousandsSeparator:','}, hidden:true}
				 			, {name:"tempAmt02", label:'<spring:message code="column.claim_common.deposit_amt" />', width:"150", align:"center", sortable:false, formatter:'integer', formatoptions:{thousandsSeparator:','}, hidden:true}
							// 등록 일시
							, {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm", sortable:false}
							 // 결제 완료 일시
						 	, {name:"payCpltDtm", label:'<spring:message code="column.pay_cplt_dtm" />', width:"110", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm"}
						 	// 거래번호
						 	, {name:"dealNo", label:'<spring:message code="column.deal_no" />', width:"150", align:"center", sortable:false}
						 	// 승인번호
						 	, {name:"cfmNo", label:'<spring:message code="column.cfm_no" />', width:"120", align:"center", sortable:false}
							// 승인 일시
						 	, {name:"cfmDtm", label:'<spring:message code="column.cfm_dtm" />', width:"110", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm"}
				 			// 승인 결과 메세지
				 			, {name:"cfmRstMsg", label:'<spring:message code="column.cfm_rst_msg" />', width:"150", align:"left",  sortable:false}
						 	// 카드사코드
						 	, {name:"cardcCd", label:'<spring:message code="column.cardc_cd" />', width:"80", align:"center", formatter:"select", sortable:false, editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CARDC}" />"}}
						 	// 은행코드
						 	, {name:"bankCd", label:'<spring:message code="column.bank_cd" />', width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.BANK}" />"}}
						 	// 계좌번호
						 	, {name:"acctNo", label:'<spring:message code="column.acct_no" />', width:"150", align:"center", sortable:false}
				 		]							
	 					, onSelectRow : function(ids) {	
	 						var rowdata = $("#payBaseList").getRowData(ids);
						}
						, paging : false
						,footerrow : true
						,userDataOnFooter:true
						,gridComplete : function(){
							
							/*
			            	 * 그리드 색상 변경
			            	 */
			            	var ids = $('#payBaseList').jqGrid('getDataIDs');
				            
			                // 그리드 데이터 가져오기
			                var gridData = $("#payBaseList").jqGrid('getRowData');

			                var refundAmt = 0;
			                var payAmt = 0;
			                
			            	if(gridData.length > 0){
				                // 데이터 확인후 색상 변경
				                for(var i = 0; i < gridData.length; i++) {
									
				                	var tempAmt = 0;
				                	// 데이터의 is_test 확인
				                	if (gridData[i].payGbCd == '20' || gridData[i].payGbCd == '40') {
				                	   
				                		// 열의 색상을 변경하고 싶을 때(css는 미리 선언)
				                		$('#payBaseList tr[id=' + ids[i] + ']').css('color', 'red');
				                		
				                		if(gridData[i].payStatCd == '00' && gridData[i].payGbCd != '40'){
				                			$("#payBaseList").jqGrid('setCell', ids[i],'tempAmt', 0);
				                			$("#payBaseList").jqGrid('setCell', ids[i],'tempAmt01', 0);
				                		}else{
				                			tempAmt = gridData[i].payAmt * -1;
				                			$("#payBaseList").jqGrid('setCell', ids[i],'tempAmt', tempAmt);
				                			if(gridData[i].payGbCd == '20'){
					                			$("#payBaseList").jqGrid('setCell', ids[i],'tempAmt01', tempAmt);
				                			}else{
				                				$("#payBaseList").jqGrid('setCell', ids[i],'tempAmt02', tempAmt);
				                			}
				                		}
				                		
				                    }else{
										tempAmt = gridData[i].payAmt;
				                		
				                		$("#payBaseList").jqGrid('setCell', ids[i],'tempAmt', tempAmt);
				                		if(gridData[i].payGbCd == '10'){
					                		$("#payBaseList").jqGrid('setCell', ids[i],'tempAmt01', tempAmt);
				                		}else{
					                		$("#payBaseList").jqGrid('setCell', ids[i],'tempAmt02', tempAmt);
				                		}
				                    }
				                }			     
			            	}
							
							//var paySum = $("#payBaseList").jqGrid('getCol', 'payAmt', false, 'sum');
// 							var refundSum = $("#payBaseList").jqGrid('getCol', 'tempAmt', false, 'sum');
							var refundSum01 = $("#payBaseList").jqGrid('getCol', 'tempAmt01', false, 'sum');
							var refundSum02 = $("#payBaseList").jqGrid('getCol', 'tempAmt02', false, 'sum');
							
							$("#payBaseList").jqGrid('footerData', 'set', {
								payNo : '합계', 
								payAmt01 : refundSum01, 
								payAmt02 : refundSum02
							});
						}
					};

					grid.create("payBaseList", options);
					
				}
			<c:if test="${orderBase.ordCancelYn eq adminConstants.COMM_YN_N and orderBase.ordStatCd eq adminConstants.ORD_STAT_10}">	
				/* 결제 완료 */
				,complete : function(payNo){

					messager.confirm('<spring:message code="column.order_common.confirm.order_pay_complete" />',function(r){
						if(r){
							var options = {
								url : "<spring:url value='/order/orderPayComplete.do' />"
								, data : {payNo : payNo}
								, callBack : function(data){
									
									messager.alert('<spring:message code="column.common.process.final_msg" />', "Info", "info", function(){
										updateTab();
									});
								}
							};

							ajax.call(options);
						}
					});
				}
				</c:if>
			};
			</c:if>
			
			/*
			 * 주문 상세 기능
			 */
			var orderDetail = {
				/* 목록 생성 */
				createList : function(){
					var options = {
						url : "<spring:url value='/order/orderDetailListGrid.do' />"
						, height : 200
						, searchParam : {
							ordNo : '${orderBase.ordNo}'
						}
						,colModels : [
				 			// 주문번호
				 			{name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"110", align:"center", sortable:false, hidden : true}
				 			// 주문상세일련번호
				 			, {name:"ordDtlSeq", label:'<spring:message code="column.ord_dtl_seq" />', width:"75", align:"center", sortable:false}
				 			// 주문내역상태코드
				 			, {name:"ordDtlStatCd", label:'<spring:message code="column.ord_dtl_stat_cd" />', width:"80", align:"center", formatter:"select", sortable:false, editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.ORD_DTL_STAT}" />"}, hidden:true}
				 			// 주문 내역 상세 코드 명
				 			, {name:"ordDtlStatCdNm", label:'<spring:message code="column.ord_dtl_stat_cd" />', width:"80", align:"center", sortable:false , formatter: function(cellValue, options, rowObject) {
				 					// 배송중, 배송완료, 구매확정이고 송장이 있을 경우 배송추적
				 					var str = '';
				 					if(rowObject.invNoNm != null && (rowObject.ordDtlStatCd === '${adminConstants.ORD_DTL_STAT_150}' || rowObject.ordDtlStatCd === '${adminConstants.ORD_DTL_STAT_160}' || rowObject.ordDtlStatCd === '${adminConstants.ORD_DTL_STAT_170}')){
						 				str = '<button type="button" onclick="viewFoGoodsFlow(\'' + rowObject.dlvrNo + '\')" class="mt5 w75 btn-add a"><spring:message code="column.order_common.dlvr_flow" /></button>';
				 					}
		                            return cellValue + str;
			 					}
				 			}
				 			// 택배사
				 			, {name:"hdcCdNm", label:'<spring:message code="column.dft_hdc_cd" />', width:"100", align:"center", sortable:false }
// 				 			, {name:"hdcCdNm", label:'<spring:message code="column.dft_hdc_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.HDC}"/>"}, sortable:false} //택배사명이 안보이는 현상이있어 주석처리함, 2021.03.22 by kek01
				 			// 송장번호
				 			, {name:"invNoNm", label:'<spring:message code="column.inv_no" />', width:"100", align:"center", sortable:false }
							// 배송 처리 유형
							, {name:"dlvrPrcsTpNm", label:'<spring:message code="column.dlvr_prcs_tp_cd" />', width:"90", align:"center"
								, cellattr : function(rowId, value, rowObject){
									//업체구분 코드 위탁
									if(rowObject.dlvrPrcsTpCd == '${adminConstants.DLVR_PRCS_TP_10}' || rowObject.compGbCd ==='20'){
										//택배 -검정
										return 'style="color:#000000"';
									}else if(rowObject.dlvrPrcsTpCd == '${adminConstants.DLVR_PRCS_TP_20}'){
										//당일배송 -초록
										return 'style="color:#05B36D"';
									}else if(rowObject.dlvrPrcsTpCd == '${adminConstants.DLVR_PRCS_TP_21}'){
										//새벽배송 -파랑
										return 'style="color:#2F6FFD"';
									}
								}
							}
				 			// 상품번호
				 			, {name:"goodsId", label:'<spring:message code="column.goods_id" />', width:"60", align:"center", sortable:false, hidden:true}
				 			// 상품명
				 			, {name:"goodsNm", label:'<b><u><tt><spring:message code="column.goods_nm" /></tt></u></b>', width:"300", align:"center", sortable:false, classes:'pointer fontbold'}
				 			// 반품 가능 여부
				 			, {name:"rtnPsbYn", label:'<spring:message code="column.rtn_psb_yn" />', width:"300", align:"center", sortable:false, hidden : true}
				 			// 반품 진행 여부
				 			, {name:"rtnIngYn", label:'<spring:message code="column.rtn_ing_yn" />', width:"300", align:"center", sortable:false, hidden : true}
				 			//업체 번호
				 			, {name:"compNo", hidden:true, label:'', width:"100", align:"center", formatter:'integer', sortable:false}
				 			// 업체명
				 			, {name:"compNm", label:'<spring:message code="column.comp_nm" />', width:"100", align:"center", sortable:false}
				 			// 상품 쿠폰 할인 금액
				 			, {name:"cpDcAmt", hidden:true}
				 			// 장바구니 쿠폰 할인 금액
				 			, {name:"cartCpDcAmt", hidden:true}
				 			// 상품금액
				 			, {name:"saleAmt", label:'<spring:message code="column.sale_unit_prc" />', width:"80", align:"center", formatter:'integer', sortable:false}
				 			/* // 프로모션 할인 금액
				 			, {name:"prmtDcAmt", label:'<spring:message code="column.prmt_dc_unit_prc" />', width:"80", align:"center", formatter:'integer', sortable:false} */
				 			// 상품 쿠폰 할인 금액 Text
				 			, {name:"cpDcAmtText", label:'<spring:message code="column.cp_dc_unit_prc" />', width:"80", align:"center", sortable:false, formatter: function(cellValue, options, rowObject) {
								var cpDcAmt = valid.numberWithCommas(rowObject.cpDcAmt);
								if(rowObject.cpNm){
									return cpDcAmt + "("+rowObject.cpNm+")";
								}else{
									return cpDcAmt;
								}
							}}
				 			// 장바구니 쿠폰 할인 금액 Text
				 			, {name:"cartCpDcAmtText", label:'<spring:message code="column.cart_cp_dc_unit_prc" />', width:"80", align:"center", sortable:false, formatter: function(cellValue, options, rowObject) {
								var cartCpDcAmt = valid.numberWithCommas(rowObject.cartCpDcAmt);
								if(rowObject.cartCpNm){
									return cartCpDcAmt + "("+rowObject.cartCpNm+")";
								}else{
									return cartCpDcAmt;
								}
								
							}}
				 			// 결제 금액
				 			, {name:"payAmt", label:'<spring:message code="column.pay_unit_price" />', width:"80", align:"center", formatter:'integer', sortable:false}
				 			// 재고관리여부
				 			, {name:"stkMngYn", label:'<spring:message code="column.stk_mng_yn" />', width:"60", align:"center", sortable:false, hidden:true}
				 			// 주문수량
				 			, {name:"ordQty", label:'<spring:message code="column.ord_qty" />', width:"60", align:"center", formatter:'integer', sortable:false}
				 			// 취소수량
				 			, {name:"cncQty", label:'<spring:message code="column.cnc_qty" />', width:"60", align:"center", formatter:'integer', sortable:false}
				 			// 반품완료수량
				 			, {name:"rtnCpltQty", label:'<spring:message code="column.rtn_cplt_qty" />', width:"70", align:"center", formatter:'integer', sortable:false}
				 			// 반품수량
				 			, {name:"rtnQty", label:'<spring:message code="column.rtn_qty" />', width:"70", align:"center", formatter:'integer', sortable:false, hidden:true}
				 			// 잔여주문수량
				 			, {name:"rmnOrdQty", label:'<spring:message code="column.rmn_ord_qty" />', width:"70", align:"center", formatter:'integer', sortable:false, hidden:true}
				 			// 반품진행수량
				 			, {name:"rtnIngQty", label:'<spring:message code="column.rtn_ing_qty" />', width:"70", align:"center", formatter:'integer', sortable:false}
				 			// 교환진행수량
				 			, {name:"clmExcIngQty", label:'<spring:message code="column.clm_exc_ing_qty" />', width:"70", align:"center", formatter:'integer', sortable:false}
				 			//총 상품쿠폰 할인 금액
				 			, {name:"totCpDcAmt", label:'<spring:message code="column.tot_cp_dc_amt" />', width:"80", align:"center", formatter:'integer', sortable:false}
				 			//총 장바구니쿠폰 할인 금액
				 			, {name:"totCartCpDcAmt", label:'<spring:message code="column.tot_cart_cp_dc_amt" />', width:"80", align:"center", formatter:'integer', sortable:false}
				 			//할인합계
				 			, {name:"totDcAmt", label:'<spring:message code="column.tot_dc_amt" />', width:"80", align:"center", formatter:'integer', sortable:false}
				 			// 유효 주문 수량 (잔여주문수량 - 반품완료수량)
				 			, {name:"vldOrdQty", label:'<spring:message code="column.vld_ord_qty" />', width:"70", align:"center", formatter:'integer', sortable:false, hidden:true }
				 			// 원 결제 합계 금액
				 			, {name:"orgPayTotAmt", label:'<spring:message code="column.org_pay_amt" />', width:"100", align:"center", sortable:false,  formatter:'integer', formatoptions:{thousandsSeparator:','}, summaryType:'sum', summaryTpl : 'Totals:'}
				 			// 클레임진행여부
				 			, {name:"clmIngYn", label:'<spring:message code="column.clm_ing_yn" />', width:"80", align:"center", sortable:false, hidden:true}
				 			// 배송비 번호
				 			, {name:"dlvrcNo", label:'<spring:message code="column.dlvrc_no" />', width:"60", align:"center", sortable:false}
				 			// 주문제작
				 			, {name:"mkiGoodsYn", label:'<spring:message code="column.order_common.mki_goods_yn" />', width:"80", align:"center", sortable:false}
				 			// 사전예약
				 			, {name:"rsvGoodsYn", label:'<spring:message code="column.order_common.rsv_goods_yn" />', width:"80", align:"center", sortable:false}
				 			// 사은품여부
				 			, {name:"frbGoodsYn", label:'<spring:message code="column.order_common.frb_goods_yn" />', width:"80", align:"center", sortable:false}
				 			// 상품 구성 유형
			 				, {name:"goodsCstrtTpCd", label:'<spring:message code="column.goods_cstrt_cd" />', width:"80", align:"center", formatter:"select", sortable:false, editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.GOODS_CSTRT_TP}" />"}}
				 			// 묶음 여부
				 			, {name:"pakGoodsYn", label:'<spring:message code="column.order_common.pak_goods_yn" />', width:"80", align:"center", sortable:false}
				 			, {name:"dftHdcCd", hidden:true}
				 			, {name:"dftInvNo", hidden:true}
				 			, {name:"dlvrPrcsTpCd", hidden: true}
				 			, {name:"compGbCd", hidden: true}
				 			, {name:"dlvrNo", hidden: true}
				 		]		
						, paging : false
						, multiselect : true
						, footerrow : true
						, userDataOnFooter:true
						, onCellSelect : function (id, cellidx, cellvalue) {
							
							var cm = $("#orderGoodsList").jqGrid("getGridParam", "colModel");
							var rowData = $("#orderGoodsList").getRowData(id);
							if(cm[cellidx].name == "goodsNm"  ){
								orderDetail.goodsDetailView(rowData.goodsId  );
// 							} else if (cm[cellidx].name == "hdcCdNm" || cm[cellidx].name == "invNoNm") {
// 								var invNo = $('#orderGoodsList').jqGrid ('getCell', id, 'invNoNm');
// 								var dlvrNo =  $('#orderGoodsList').jqGrid ('getCell', id, 'dlvrNo');
// 								if (invNo != '') {
// 									viewFoGoodsFlow(dlvrNo);
// 								}
							} else if(cellidx != 0 && cm[cellidx].name != "ordDtlStatCdNm"){
								var ordNo =  $('#orderGoodsList').jqGrid ('getCell', id, 'ordNo');
								var ordDtlSeq =  $('#orderGoodsList').jqGrid ('getCell', id, 'ordDtlSeq');
								var options = {
									url : "<spring:url value='/order/orderDetailCstrtPopView.do' />"
									, dataType : "html"
									, data : {
										ordNo : ordNo
										, ordDtlSeq : ordDtlSeq
									}
									, callBack : function(result) {
										var config = {
											id : "layerOrderCstrtView"
											, top : 50
											, width : 800
											, height : 540
											, title : "주문 상세 내역"
											, body : result
										}
										layer.create(config);
									}
								}
								ajax.call(options );
							}
						}
			            , gridComplete: function() {  /** 데이터 로딩시 함수 **/

			            	/*
			            	 * 그리드 색상 변경
			            	 */
			            	var ids = $('#orderGoodsList').jqGrid('getDataIDs');
				            
			                // 그리드 데이터 가져오기
			                var gridData = $("#orderGoodsList").jqGrid('getRowData');

			            	if(gridData.length > 0){
				                // 데이터 확인후 색상 변경
				                for (var i = 0; i < gridData.length; i++) {

				                	// 데이터의 is_test 확인
				                	if (gridData[i].rmnOrdQty == '0') {
				                	   
				                		// 열의 색상을 변경하고 싶을 때(css는 미리 선언)
				                		$('#orderGoodsList tr[id=' + ids[i] + ']').css('color', 'red');
				                    }
									//업무구분코드 위탁 추가
				                	if(gridData[i].dlvrPrcsTpCd === '${adminConstants.DLVR_PRCS_TP_10}' || gridData[i].compGbCd === '20' ){

										$("#orderGoodsList").jqGrid('setCell', ids[i],'dlvrPrcsTpNm', '택배');
									}else if(gridData[i].dlvrPrcsTpCd === '${adminConstants.DLVR_PRCS_TP_20}'){

										$("#orderGoodsList").jqGrid('setCell', ids[i],'dlvrPrcsTpNm', '당일');
										$("#orderGoodsList").jqGrid('setCell', ids[i],'goodsNm', '<span style="color:#05B36D">[당일]</span>' + $("#orderGoodsList").getCell(ids[i], 'goodsNm'));

									}else if(gridData[i].dlvrPrcsTpCd === '${adminConstants.DLVR_PRCS_TP_21}'){

										$("#orderGoodsList").jqGrid('setCell', ids[i],'dlvrPrcsTpNm', '새벽');
										$("#orderGoodsList").jqGrid('setCell', ids[i],'goodsNm', '<span style="color:#2F6FFD">[새벽]</span>' + $("#orderGoodsList").getCell(ids[i], 'goodsNm'));

									}

				                }
			            	}

			            	/*
			            	 * 주문 합계
			            	 */
							var payTotSum = $("#orderGoodsList").jqGrid('getCol', 'orgPayTotAmt', false, 'sum');
							var totCpDcAmtSum = $("#orderGoodsList").jqGrid('getCol', 'totCpDcAmt', false, 'sum');
							var totCartCpDcAmtSum = $("#orderGoodsList").jqGrid('getCol', 'totCartCpDcAmt', false, 'sum');
							var totDcAmtSum = $("#orderGoodsList").jqGrid('getCol', 'totDcAmt', false, 'sum');
							$("#orderGoodsList").jqGrid('footerData', 'set', {
								ordDtlSeq : '합계', 
								orgPayTotAmt : payTotSum, 
								totCpDcAmt : totCpDcAmtSum,
								totCartCpDcAmt : totCartCpDcAmtSum,
								totDcAmt : totDcAmtSum
							});
			            }					
					};

					grid.create("orderGoodsList", options);
					
					// Header Group
					$("#orderGoodsList").jqGrid('setGroupHeaders', {
					  useColSpanStyle: true, 
					  groupHeaders:[
						{startColumnName: 'saleAmt', numberOfColumns: 4, titleText: '상품단가정보'},
						{startColumnName: 'ordQty', numberOfColumns: 7, titleText: '주문수량정보'}
					  ]	
					});
				}
				/* 주문 상세 재조회 */
				,reload : function(ordDtlSeq){
					var options = {
						searchParam : {
							ordNo : '${orderBase.ordNo}'
						}
					}
					grid.reload("orderGoodsList", options);
				}			
				, goodsDetailView : function(goodsId){
					openNewPopOrTab('상품 상세 - ' + goodsId, '/order/goodsDetailView.do?goodsId=' + goodsId + "&viewGb=" + '${adminConstants.VIEW_GB_POP}');
				}
				<c:if test="${orderBase.ordCancelYn eq adminConstants.COMM_YN_N}">	
				/* 주문 취소 */
				, cancel : function(){
					var cancelInfo = false;
					
					if ('<c:out value="${orderBase.payMeansCd}" />' == '<c:out value="${adminConstants.PAY_MEANS_90}" />' ) {
						messager.alert( "외부몰주문은 취소 할 수 없습니다. 관리자에게 문의하세요.","Info","info");
						return;
					}
					
					var grid = $("#orderGoodsList");

					var selectedIDs = grid.getGridParam("selarrrow");

					if ( selectedIDs.length == 0 ) {
						messager.alert( "취소하실 상품을 선택하세요.","Info","info");
						return;
					}

					if( '<c:out value="${orderBase.ordStatCd}" />' == '<c:out value="${adminConstants.ORD_STAT_10}" />' && selectedIDs.length != <c:out value="${orderBase.ordDtlCnt}" />){
						messager.alert("주문 접수시에는 전체 취소만 가능합니다.","Info","info");
						return;
					}
					
					var arrOrdDtlSeq = new Array();

					for ( var i in selectedIDs ) {

						var rowData = grid.getRowData( selectedIDs[i] );

						if( parseInt(rowData.rmnOrdQty) == 0){
							messager.alert("취소된 주문 입니다.","Info","info");
							return;
						}
						
						if ( rowData.ordDtlStatCd != '${adminConstants.ORD_DTL_STAT_110}'
							&& rowData.ordDtlStatCd != '${adminConstants.ORD_DTL_STAT_120}'
								&& rowData.ordDtlStatCd != '${adminConstants.ORD_DTL_STAT_130}'
									&& rowData.ordDtlStatCd != '${adminConstants.ORD_DTL_STAT_140}' ) {

							messager.alert( "주문상세상태가 주문접수/주문완료/배송지시/배송준비중 일 경우에만 취소 가능 합니다.","Info","info");
							return;

						} else{
							if(rowData.ordDtlStatCd == '${adminConstants.ORD_DTL_STAT_130}' || rowData.ordDtlStatCd == '${adminConstants.ORD_DTL_STAT_140}'){
								cancelInfo = true;							
							}
						}

						arrOrdDtlSeq.push( rowData.ordDtlSeq );

					}	// for selectedIDs
					
					var claimIngCnt = 0;
					var rowDatas = grid.getRowData();
					for(var i=0; i < rowDatas.length; i++) {
						claimIngCnt += parseInt(rowDatas[i].rtnIngQty) + parseInt(rowDatas[i].clmExcIngQty);
					}					
					
					if (claimIngCnt > 0) {
						messager.alert("클레임 진행중인 건이 존재합니다. 기존 진행건 완료 후 접수가 가능합니다.","Info","info");
						return;
					}

					var data = {
						ordNo : '${orderBase.ordNo}'
						, arrOrdDtlSeq : arrOrdDtlSeq
					}

					var options = {
						url : '/claim/claimCancelAcceptPopView.do'
						, data : data
						, dataType : "html"
						, callBack : function (data ) {
							var config = {
								id : "claimCancelAcceptView"
								, width : 1200
								, height : 770
								, top : 200
								, title : "주문취소 신청"
								, body : data
								, button : "<button type=\"button\" onclick=\"fnClaimAcceptExec();\" class=\"btn btn-ok\">주문취소</button>"
							}
							layer.create(config);
						}
					}
				
					if(cancelInfo){
						messager.confirm('배송지시/상품준비중인 상품이 존재합니다.<br>해당상품의 발송여부를 확인 후 취소하시기 바랍니다.<br><span style=\"margin-left:42px\">계속진행 하시겠습니까?</span>',function(r){
							
		 					if(r){
		 						ajax.call(options );
		 					}
						});
					}else{
						ajax.call(options );
					}
				}
				/* 반품 접수 */
				, rtnAccept : function(){
					var grid = $("#orderGoodsList");
					var selectedIDs = grid.getGridParam("selarrrow");

					if ('<c:out value="${orderBase.payMeansCd}" />' == '<c:out value="${adminConstants.PAY_MEANS_90}" />' ) {
						messager.alert( "외부몰주문은 반품이 불가능 합니다. 관리자에게 문의하세요.","Info","info");
						return;
					}
					
					if ( selectedIDs.length == 0 ) {
						messager.alert( "반품하실 상품을 선택하세요.","Info","info");
						return;
					}

					/* if ( selectedIDs.length >= 2 ) {
						messager.alert( "반품 접수는 주문상품 단건별로 가능합니다.","Info","info");
						return;
					} */

					var arrOrdDtlSeq = new Array();
					var msg;
					
					for ( var i in selectedIDs ) {
						var rowData = grid.getRowData( selectedIDs[i] );	
						
						if ( rowData.ordDtlStatCd != '${adminConstants.ORD_DTL_STAT_160}') {
							messager.alert( "주문상세 상태가 배송완료일 경우에만 반품 접수가 가능 합니다.","Info","info");
							return;

						}
						
						if( parseInt(rowData.rmnOrdQty) == 0){
							messager.alert("취소된 주문 입니다.","Info","info");
							return;
						}
						
						if( parseInt(rowData.rmnOrdQty) - parseInt(rowData.rtnQty) - parseInt(rowData.clmExcIngQty)  == 0){
							messager.alert("반품 가능한 수량이 부족합니다.","Info","info");
							return;
						}

						if( rowData.rtnIngYn == "Y"){
							messager.alert("반품 진행중인 건이 존재합니다. 기존 진행건 완료 후 접수가 가능합니다.","Info","info");
							return;
						}
						
						if(rowData.rtnPsbYn != "Y"){
							msg = '반품이 불가능한 상품입니다. <br>반품을 진행하시겠습니까?';
						}
						
						arrOrdDtlSeq.push( rowData.ordDtlSeq );
					}

					var claimIngCnt = 0;
					var rowDatas = grid.getRowData();
					for(var i=0; i < rowDatas.length; i++) {
						claimIngCnt += parseInt(rowDatas[i].rtnIngQty) + parseInt(rowDatas[i].clmExcIngQty);
					}					
					
					if (claimIngCnt > 0) {
						messager.alert("클레임 진행중인 건이 존재합니다. 기존 진행건 완료 후 접수가 가능합니다.","Info","info");
						return;
					}
					
					if(msg){
						messager.confirm(msg,function(r){
							
		 					if(r){
		 						var data = {
	 								ordNo : '${orderBase.ordNo}'
	 								, arrOrdDtlSeq : arrOrdDtlSeq
	 							}
	 							
	 							var options = {
	 								url : '/claim/claimReturnAcceptPopView.do'
	 								, data : data
	 								, dataType : "html"
	 								, callBack : function (data ) {
	 									var config = {
	 										id : "claimReturnAcceptView"
	 										, width : 1200
	 										, height : 800
	 										, top : 200
	 										, title : "반품접수 신청"
	 										, body : data
	 										, button : "<button type=\"button\" onclick=\"fnClaimReturnAcceptExec();\" class=\"btn btn-ok\">반품접수</button>"
	 									}
	 									layer.create(config);
	 								}
	 							}
	 							ajax.call(options );
							}
						});
					}else{
						var data = {
								ordNo : '${orderBase.ordNo}'
								, arrOrdDtlSeq : arrOrdDtlSeq
							}
							
							var options = {
								url : '/claim/claimReturnAcceptPopView.do'
								, data : data
								, dataType : "html"
								, callBack : function (data ) {
									var config = {
										id : "claimReturnAcceptView"
										, width : 1200
										, height : 800
										, top : 200
										, title : "반품접수 신청"
										, body : data
										, button : "<button type=\"button\" onclick=\"fnClaimReturnAcceptExec();\" class=\"btn btn-ok\">반품접수</button>"
									}
									layer.create(config);
								}
							}
							ajax.call(options );
					}
				}
				/* 교환 접수 */
				, excAccept : function(clmTpCd){
					var grid = $("#orderGoodsList");
					var selectedIDs = grid.getGridParam("selarrrow");

					if ('<c:out value="${orderBase.payMeansCd}" />' == '<c:out value="${adminConstants.PAY_MEANS_90}" />' ) {
						messager.alert( "외부몰주문은 교환이 불가능 합니다. 관리자에게 문의하세요.","Info","info");
						return;
					}
					
					if ( selectedIDs.length == 0 ) {
						messager.alert( "교환하실 상품을 선택하세요.","Info","info");
						return;
					}

					/*if ( selectedIDs.length >= 2 ) {
						messager.alert( "교환 접수는 주문상품 단건별로 가능합니다.","Info","info");
						return;
					}*/

					var arrOrdDtlSeq = new Array();
					
					for ( var i in selectedIDs ) {

						var rowData = grid.getRowData( selectedIDs[i] );
						
						if ( rowData.ordDtlStatCd != '${adminConstants.ORD_DTL_STAT_160}' ) {
							messager.alert( "주문상세 상태가 배송완료일 경우에만 교환 접수가 가능 합니다.","Info","info");
							return;
						}
						
						if( parseInt(rowData.rmnOrdQty) == 0){
							messager.alert("취소된 주문 입니다.","Info","info");
							return;
						}
						
						if( parseInt(rowData.rmnOrdQty) - parseInt(rowData.rtnQty) - parseInt(rowData.clmExcIngQty)  == 0){
							messager.alert("교환 가능한 수량이 부족합니다.","Info","info");
							return;
						}
						
						arrOrdDtlSeq.push( rowData.ordDtlSeq );
						
					}
					
					var claimIngCnt = 0;
					var rowDatas = grid.getRowData();
					for(var i=0; i < rowDatas.length; i++) {
						claimIngCnt += parseInt(rowDatas[i].rtnIngQty) + parseInt(rowDatas[i].clmExcIngQty);
					}
					
					if (claimIngCnt > 0) {
						messager.alert("클레임 진행중인 건이 존재합니다. 기존 진행건 완료 후 접수가 가능합니다.","Info","info");
						return;
					}
					
					var data = {
						ordNo : '${orderBase.ordNo}'
						, arrOrdDtlSeq : arrOrdDtlSeq
					}

					var options = {
						url : '/claim/claimExchangeAcceptPopView.do'
						, data : data
						, dataType : "html"
						, callBack : function (data ) {
							var config = {
								id : "claimExchangeAcceptView"
								, width : 1200
								, height : 800
								, top : 200
								, title : "교환접수 신청"
								, body : data
								, button : "<button type=\"button\" onclick=\"fnClaimExchangeAcceptExec();\" class=\"btn btn-ok\">교환접수</button>"
							}
							layer.create(config);
						}
					}
					ajax.call(options );
							
				}
				/* 구매완료 */
				,purchase : function(){
					var grid = $("#orderGoodsList");
					var selectedIDs = grid.getGridParam("selarrrow");

					if ('<c:out value="${orderBase.payMeansCd}" />' == '<c:out value="${adminConstants.PAY_MEANS_90}" />' ) {
						messager.alert( "외부몰주문은 구매확정가 불가능 합니다. 관리자에게 문의하세요.","Info","info");
						return;
					}
					
					if ( selectedIDs.length == 0 ) {
						messager.alert( "구매확정하실 상품을 선택하세요.","Info","info");
						return;
					}

					var arrOrdDtlSeq = new Array();
					
					for ( var i in selectedIDs ) {

						var rowData = grid.getRowData( selectedIDs[i] );
						
						if ( rowData.ordDtlStatCd != '${adminConstants.ORD_DTL_STAT_150}' && rowData.ordDtlStatCd != '${adminConstants.ORD_DTL_STAT_160}' ) {

							messager.alert( "주문상세 상태가 배송중/배송완료일 경우에만 구매확정이 가능 합니다.","Info","info");
							return;

						}
						
						if( parseInt(rowData.rmnOrdQty) == 0){
							messager.alert("취소된 주문 입니다.","Info","info");
							return;
						}
						
						if(rowData.clmIngYn == 'Y'){
							messager.alert("클레임이 진행중인 상품은 구매완료를 하실 수 없습니다.","Info","info");
							return;
						}
						
						if(parseInt(rowData.vldOrdQty) == 0){
							messager.alert("구매확정 가능한 수량이 부족합니다.","Info","info");
							return;
						}
						
						arrOrdDtlSeq.push( rowData.ordDtlSeq );
						
					}
					
					var data = {
						ordNo : '${orderBase.ordNo}'
						, arrOrdDtlSeq : arrOrdDtlSeq
					}
					
					messager.confirm('<spring:message code="column.order_common.confirm.purchase_update" />',function(r){
	 					if(r){
	 						var options = {
	 			 					url : "<spring:url value='/order/orderPurchase.do' />"
	 			 					, data :  data
	 		 						, callBack : function(data){
	 		 							
	 		 							messager.alert('<spring:message code="column.order_common.purchase_update.success" />', "Info", "info", function(){
	 		 								orderDetail.reload();
										});
	 								}
	 				 			};
	 				 			
	 				 			ajax.call(options);
	 						}
					});
					
				}
				</c:if>
			};

			/*
			 * 배송비 
			 */
			var deliveryCharge = {
				/* 목록 생성 */
				createList : function(){
					var options = {
						url : "<spring:url value='/order/deliveryChargeListGrid.do' />"
						, height : 120
						, searchParam : {
								ordNo : '${orderBase.ordNo}'
						}
						,colModels : [
				 			// 배송비 번호
				 			{name:"dlvrcNo", label:'<spring:message code="column.dlvrc_no" />', width:"80", align:"center" }
				 			// 배송비구분코드
				 			, {name:"costGbCd", label:'<spring:message code="column.cost_gb_cd" />', width:"70", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.COST_GB}" />"}}
				 			// 선착불코드
				 			, {name:"prepayGbCd", label:'<spring:message code="column.prepay_gb_cd" />', width:"70", align:"center", sortable:false,  formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.PREPAY_GB}" />"}}
				 			// 원 배송 금액
				 			, {name:"orgDlvrAmt", label:'<spring:message code="column.org_dlvr_amt" />', width:"75", align:"center", formatter:'integer', sortable:false}
				 			// 쿠폰 할인 금액
				 			, {name:"cpDcAmt", label:'<spring:message code="column.dc_dlvr_amt" />', width:"75", align:"center", formatter:'integer', sortable:false }
				 			// 실 배송 금액
				 			, {name:"realDlvrAmt", label:'<spring:message code="column.real_dlvr_amt" />', width:"75", align:"center", sortable:false, formatter:'integer', formatoptions:{thousandsSeparator:','}, summaryType:'sum', summaryTpl : 'Totals:'}
				 			// 추가 배송 금액
				 			, {name:"addDlvrAmt", label:'<spring:message code="column.add_dlvr_amt" />', width:"75", align:"center", formatter:'integer', sortable:false}
				 			// 취소여부
				 			, {name:"cncYn", label:'<spring:message code="column.cnc_yn" />', width:"60", align:"center", sortable:false}
				 			// 취소 클레임 번호
				 			, {name:"cncClmNo", label:'<spring:message code="column.cnc_clm_no" />', width:"120", align:"center", sortable:false}
				 			// 배송비기준코드
				 			, {name:"dlvrcStdCd", label:'<spring:message code="column.dlvrc_std_cd" />', width:"70", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.DLVRC_STD}" />"}}
				 			// 배송비조건코드
				 			, {name:"dlvrcCdtCd", label:'<spring:message code="column.dlvrc_cdt_cd" />', width:"70", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.DLVRC_CDT}" />"}}
				 			// 배송비조건기준코드
				 			, {name:"dlvrcCdtStdCd", label:'<spring:message code="column.dlvrc_cdt_std_cd" />', width:"150", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.DLVRC_CDT_STD}" />"}}
				 			// 배송비 기준 금액
				 			, {name:"dlvrStdAmt", label:'<spring:message code="column.dlvr_std_amt" />', width:"75", align:"center", formatter:'integer', sortable:false }
				 			// 추가 배송비 기준 금액
				 			, {name:"addDlvrStdAmt", label:'<spring:message code="column.add_dlvr_std_amt" />', width:"75", align:"center", formatter:'integer', sortable:false }
				 			// 구매 기준 수량
				 			, {name:"buyQty", label:'<spring:message code="column.buy_std_qty" />', width:"75", align:"center", formatter:'integer', sortable:false }
				 			// 구매 기준 금액
				 			, {name:"buyPrc", label:'<spring:message code="column.buy_std_prc" />', width:"75", align:"center", formatter:'integer', sortable:false }				 		]		
						, paging : false
						, footerrow : true
						, userDataOnFooter:true
			            , gridComplete: function() {  /** 데이터 로딩시 함수 **/
			            	/*
			            	 * 그리드 색상 변경
			            	 */
			            	var ids = $('#orderDeliveryChargeList').jqGrid('getDataIDs');

			                // 그리드 데이터 가져오기
			                var gridData = $("#orderDeliveryChargeList").jqGrid('getRowData');
			                
			                var realDlvrTotSum = 0;

			            	if(gridData.length > 0){
				                // 데이터 확인후 색상 변경
				                for (var i = 0; i < gridData.length; i++) {

				                	// 데이터의 확인
				                	if (gridData[i].cncYn == 'Y') {

				                		// 열의 색상을 변경하고 싶을 때(css는 미리 선언)
				                		$('#orderDeliveryChargeList tr[id=' + ids[i] + ']').css('color', 'red');
				                   } else {
				                	   realDlvrTotSum += parseInt(gridData[i].realDlvrAmt);
				                   }
				                }
			            	}
			            	
			            	console.log(realDlvrTotSum);
			            	/*
			            	 * 배송비 합계
			            	 */
							//var realDlvrTotSum = $("#orderDeliveryChargeList").jqGrid('getCol', 'realDlvrAmt', false, 'sum');
							$("#orderDeliveryChargeList").jqGrid('footerData', 'set', {dlvrcNo : '합계', realDlvrAmt : realDlvrTotSum});
			            }							
					};

					grid.create("orderDeliveryChargeList", options);

					
					$("#orderDeliveryChargeList").jqGrid('setGroupHeaders', {
					  useColSpanStyle: true, 
					  groupHeaders:[
						{startColumnName: 'costGbCd', numberOfColumns: 8, titleText: '배송비정보'},
						{startColumnName: 'dlvrcStdCd', numberOfColumns: 7, titleText: '배송비기준정보'},
					  ]	
					});	
				}

			};
			
			/*
			 * 클레임 기능
			 */		
			var claim = {
				/* 목록 생성 */
				createList : function(){
					var options = {
						url : "<spring:url value='/order/orderClaimListGrid.do' />"
						, height : 200
						, searchParam : {
							ordNo : '${orderBase.ordNo}'
							, ordDtlSeq : ''
						}
						,colModels : [
				 			//클레임 번호
				 			{name:"clmNo", label:'<spring:message code="column.clm_no" />', width:"125", align:"center"}
				 			// 클레임 유형 코드
				 			, {name:"clmTpCd", label:'<b><u><tt><spring:message code="column.clm_tp_cd" /></tt></u></b>', width:"85", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_TP}" />"}, classes:'pointer fontbold'}
				 			// 클레임 상태 코드
				 			, {name:"clmStatCd", label:'<spring:message code="column.clm_stat_cd" />', width:"85", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_STAT}" />"}}
				 			// 클레임 접수 일시
				 			, {name:"acptDtm", label:'<spring:message code="column.clm_acpt_dtm" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
				 			// 클레임 완료 일시
				 			, {name:"clmCpltDtm", label:'<spring:message code="column.clm_cplt_dtm" />', width:"125", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
				 			// 클레임 취소 일시
				 			, {name:"cncDtm", label:'<spring:message code="column.clm_cnc_dtm" />', width:"130", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
				 			// 클레임 상세 순번
				 			, {name:"clmDtlSeq", label:'<b><u><tt><spring:message code="column.clm_dtl_seq" /></tt></u></b>', width:"85", align:"center", formatter:'integer', classes:'pointer fontbold'}
				 			// 클레임 상세 유형 코드
				 			, {name:"clmDtlTpCd", label:'<spring:message code="column.clm_dtl_tp_cd" />', width:"90", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_DTL_TP}" />"}}
				 			// 클레임 상세 상태 코드
				 			, {name:"clmDtlStatCd", label:'<spring:message code="column.clm_dtl_stat_cd" />', width:"90", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_DTL_STAT}" />"}}
				 			// 클레임 사유 코드
				 			, {name:"clmRsnCd", label:'<spring:message code="column.clm_rsn_cd" />', width:"120", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_RSN}" />"}}
				 			// 상품명
				 			, {name:"goodsNm", label:'<spring:message code="column.goods_nm" />', width:"300", align:"center", sortable:false}
				 			// 클레임 수량
				 			, {name:"clmQty", label:'<spring:message code="column.clm_qty" />', width:"85", align:"center", formatter:'integer'}
				 			// 주문 번호
				 			, {name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"110", align:"center", hidden:true}
				 			// 주문 상세 순번
				 			, {name:"ordDtlSeq", label:'<spring:message code="column.ord_dtl_seq" />', width:"70", align:"center", formatter:'integer'}
				 			// 상위 클레임 번호
				 			, {name:"orgClmNo", label:'<spring:message code="column.org_clm_no" />', width:"140", align:"center",}
				 			// 상위 클레임 상세순번
				 			, {name:"orgClmDtlSeq", label:'<spring:message code="column.org_clm_dtl_seq" />', width:"85", align:"center", /* formatter:'integer' */}
				 		]			
			            , gridComplete: function() {  /** 데이터 로딩시 함수 **/

			            	var ids = $('#claimList').jqGrid('getDataIDs');
				            
			                // 그리드 데이터 가져오기
			                var gridData = $("#claimList").jqGrid('getRowData');

			            	if(gridData.length > 0){
				                // 데이터 확인후 색상 변경
				                for (var i = 0; i < gridData.length; i++) {

				                	// 데이터의 is_test 확인
				                	if (gridData[i].clmStatCd == '<c:out value="${adminConstants.CLM_STAT_40}" />') {
				                	   
				                		// 열의 색상을 변경하고 싶을 때(css는 미리 선언)
				                		$('#claimList tr[id=' + ids[i] + ']').css('color', 'red');
				                   }
				                }			     
			            	}
			            	
			            }						
						, onSelectRow : function(ids) {	// row click
							var rowData = $("#claimList").getRowData(ids);
						
							claim.detailView(rowData.clmNo);
						}
						, paging : false
						, grouping: true
						, groupField: ["clmNo"]
						, groupText: ["클레임번호"]
						, groupOrder : ["asc"]
						, groupCollapse: false
						, groupColumnShow : [false]
	 					
					};

					grid.create("claimList", options);					
				}
				/* 재조회 */
				,reload : function(ordDtlSeq){
					var options = {
						searchParam : {
							ordNo : '${orderBase.ordNo}'
							, ordDtlSeq : ordDtlSeq
						}
					}
					grid.reload("claimList", options);
				}
				// 클레임상세
				,detailView : function(clmNo){
					openNewPopOrTab('클레임 상세', '/order/claimDetailView.do?clmNo=' + clmNo + "&viewGb=" + '${adminConstants.VIEW_GB_POP}');
				}
			};
			
			/*
			 * CS 기능
			 */		
			var cs = {
				createList :function(){
					var options = {
						url : "<spring:url value='/order/orderCsListGrid.do' />"
						, height : 150
						, searchParam : {
							ordNo : '${orderBase.ordNo}'
						}
						, colModels : [
				 			//상담 번호
				 			{name:"cusNo", label:'<spring:message code="column.cus_no" />', width:"50", align:"center"}
				 			//상담 경로 코드
				 			, {name:"cusPathCd", label:'<spring:message code="column.cus_path_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_PATH}" />"}}
				 			// 상담 상태 코드
				 			, {name:"cusStatCd", label:'<spring:message code="column.cus_stat_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_STAT}" />"}}
				 			// 문의자 명
				 			, {name:"eqrrNm", label:'<spring:message code="column.eqrr_nm" />', width:"50", align:"center"}
				 			// 제목
				 			, {name:"ttl", label:'<spring:message code="column.ttl" />', width:"200", align:"center"}
				 			// 내용
// 				  			, {name:"content", label:'<spring:message code="column.content" />', width:"300", align:"center"}
				 			// 상담 카테고리1 코드
				 			, {name:"cusCtg1Cd", label:'<spring:message code="column.cus_ctg1_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_CTG1}" />"}}
				 			// 상담 카테고리2 코드
				 			, {name:"cusCtg2Cd", label:'<spring:message code="column.cus_ctg2_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_CTG2}" />"}}
				 			// 상담 카테고리3 코드
				 			, {name:"cusCtg3Cd", label:'<spring:message code="column.cus_ctg3_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_CTG3}" />"}}
				 			// 상담 접수 일시
				 			, {name:"cusAcptDtm", label:'<spring:message code="column.cus_acpt_dtm" />', width:"125", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
				 			// 상담 취소 일시
				 			, {name:"cusCncDtm", label:'<spring:message code="column.cus_cnc_dtm" />', width:"125", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
				 			// 상담 완료 일시
				 			, {name:"cusCpltDtm", label:'<spring:message code="column.cus_cplt_dtm" />', width:"125", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
							//상담 담당자명
							, {name:"cusChrgNm", label:'<spring:message code="column.cus_chrg_nm" />', width:"80", align:"center"}
				 			// 상담 완료자 명
				 			, {name:"cusCpltrNm", label:'<spring:message code="column.order_common.cpltr_nm" />', width:"100", align:"center"}
				 			// 주문 번호
				 			, {name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"110", align:"center"}
				 		]						
	 					, onSelectRow : function(ids) {	
	 						var rowdata = $("#csList").getRowData(ids);
	 						
	 						cs.view(rowdata.cusNo, rowdata.cusPathCd);
						}
						, paging : false
					};

					grid.create("csList", options);					
				}
				,view : function(cusNo, cusPathCd){
					if(cusPathCd == "${adminConstants.CUS_PATH_10}"){
						openNewPopOrTab('1:1문의 상세', '/counsel/web/counselWebView.do?cusNo=' + cusNo);
					}else{
						openNewPopOrTab('CS문의 상세', '/counsel/cc/counselCcView.do?cusNo=' + cusNo);
					}
				}
			};
			
			
			var memo = {
				insert : function(){
					if ( validate.check("orderMemoForm") ) {
						messager.confirm('<spring:message code="column.order_common.confirm.order_memo_insert" />',function(r){
							if(r){
								var options = {
									url : "<spring:url value='/order/orderMemoInsert.do' />"
									, data : $("#orderMemoForm").serializeJson()
									, callBack : function(data){
										
										messager.alert('<spring:message code="column.common.regist.final_msg" />', "Info", "info", function(){
											document.location.reload();
										});
										
									}
								};

								ajax.call(options);
							}
						});
					}
				}		
			};
			
			function viewFoGoodsFlow(dlvrNo) {
				var goodsFlowLink = 'https://<spring:eval expression="@webConfig['site.fo.domain']" />/mypage/order/goodsflow/' + dlvrNo;
				window.open(goodsFlowLink,"","width=498,height=640, scrollbars=yes,resizable=no");	
			}

			//배송완료 이미지
			function ordDtlImgReview(imgPath){							
				//window.open(location.protocol + '//<spring:eval expression="@webConfig['site.domain']" />/common/imageView.do?filePath=' + imgPath, "","width=600px, height=600px, left=0, top=0");
				window.open(imgPath, "","width=600px, height=600px, left=0, top=0");
			}
			
			//개인정보 해제
			function fnUnlockPrivacyMasking(){		
				if( $("#maskingUnlock").val() == '${adminConstants.COMM_YN_N}' ) {
					messager.confirm("<spring:message code='column.member_search_view.maksing_unlock_msg' />",function(r){
						//개인정보 숨김
						if(r){
							$("#maskingUnlock").val('${adminConstants.COMM_YN_Y}');
							searchOrderDetail();
						}
					});						
				}else{
					//개인정보 해제
					messager.alert("<spring:message code='column.member_search_view.maksing_unlock_msg_already' />","Info","Info",function(){});
				}
			}

            function searchOrderDetail(){       
            	var maskingUnlock = $("#maskingUnlock").val();
            	var ordNo = $("#ordNo").val();
            	var cnctHistNo = va.data.cnctHistNo;
            	var viewGb = "${viewGb}";
            	var url = '/order/orderDetailView.do?ordNo=' + ordNo
						+ "&maskingUnlock="+maskingUnlock
						+ "&cnctHistNo="+cnctHistNo
						+ "&viewGb=" + viewGb;

				if(viewGb == "${adminConstants.VIEW_GB_POP}"){
					window.location.href = url;
				}else{
					updateTab(url,"주문 상세");
				}
            }                        
            
		</script>

	</t:putAttribute>

	<t:putAttribute name="content">

<!-- ==================================================================== -->
<!-- 주문정보 -->
<!-- ==================================================================== -->
<input type="hidden" id="addressChanged" name="addressChanged" value="" />
<input type="hidden" id="ordNo" name="ordNo" value="${ordNo}" />
<input type="hidden" id="localPostYn" name="localPostYn" value="<c:out value="${localPostYn}" />" />
<input type='hidden' id="maskingUnlock" name="maskingUnlock" value="${maskingUnlock}">
		<div class="mTitle">
			<h2><spring:message code="column.order_common.order_info" /></h2>
			<c:if test="${orderBase.ordCancelYn eq adminConstants.COMM_YN_N}">
				<div class="buttonArea">
					<button type="button" onclick="fnUnlockPrivacyMasking();" class="btn btn-add" id='privacyBtn'>개인정보 해제</button>
				</div>
			</c:if>
		</div>
		<form id="orderInfoForm" name="orderInfoForm" method="post" >
			<input type="hidden" name="ordNo" value="${orderBase.ordNo}">
			<table class="table_type1">
				<caption><spring:message code="column.order_common.order_info" /></caption>
				<colgroup>
					<col style="width:170px;">
					<col />
					<col style="width:170px;">
					<col />
					<col style="width:170px;">
					<col />
				</colgroup>
				<tbody>
					<tr>
						<!-- 주문번호 -->
						<th scope="row"><spring:message code="column.ord_no" /></th>
						<td>${orderBase.ordNo}</td>
						<!-- 주문상태 -->
						<th scope="row"><spring:message code="column.ord_stat_cd" /></th>
						<td><frame:codeName grpCd="${adminConstants.ORD_STAT }" dtlCd="${orderBase.ordStatCd }"/></td>
						<!-- 회원명/회원번호 -->
						<th scope="row"><spring:message code="column.mbr_info" /></th>
						<td>
							<c:if test="${orderBase.mbrNo eq  adminConstants.NO_MEMBER_NO}">
							비회원
							</c:if>
							<c:if test="${orderBase.mbrNo ne  adminConstants.NO_MEMBER_NO}">
							${orderBase.mbrNm}
							<c:if test="${adminConstants.USR_GRP_10 eq session.usrGrpCd}">
							/ 
							${orderBase.ordrId}
							/
							${orderBase.mbrNo}
							</c:if>
							</c:if>
						</td>
					</tr>
					<tr>
						<!-- 사이트 -->
						<th scope="row"><spring:message code="column.st" /></th>
						<td>
							${orderBase.stNm}
						</td>
						<!-- 주문매체 -->
						<th scope="row"><spring:message code="column.ord_mda_cd" /></th>
						<td colspan="3"><frame:codeName grpCd="${adminConstants.ORD_MDA }" dtlCd="${orderBase.ordMdaCd }"/></td>
						<!-- 채널 -->
						<%-- <th scope="row"><spring:message code="column.chnl" /></th>
						<td>
							${orderBase.chnlNm}
						</td> --%>
					</tr>					
					<tr>
						<!-- 주문자명 -->
						<th scope="row"><spring:message code="column.ord_nm" /><strong class="red">*</strong></th>
						<td>
							<c:if test="${orderBase.mbrNo eq  adminConstants.NO_MEMBER_NO}">
							<input type="text" class="input_text validate[required, maxSize[50]]" name="ordNm" title="<spring:message code="column.ord_nm" />" value="${orderBase.ordNm}">
							</c:if>
							<c:if test="${orderBase.mbrNo ne  adminConstants.NO_MEMBER_NO}">
							${orderBase.ordNm}
							</c:if>
						</td>
						<!-- 주문 접수 일시 -->
						<th scope="row"><spring:message code="column.ord_acpt_dtm" /></th>
						<td>
							<fmt:formatDate value="${orderBase.ordAcptDtm}" pattern="${adminConstants.COMMON_DATE_FORMAT }"/>
						</td>
						<!-- 주문 완료 일시 -->
						<th scope="row"><spring:message code="column.ord_cplt_dtm" /></th>
						<td>
							<fmt:formatDate value="${orderBase.ordCpltDtm}" pattern="${adminConstants.COMMON_DATE_FORMAT }"/>
							
						</td>
					</tr>
					<tr>
						<!-- 주문자전화 -->
						<th scope="row"><spring:message code="column.ordr_tel" /><strong class="red">*</strong></th>
						<td>
							<input type="text" class="readonly validate[maxSize[20], custom[tel]]" name="ordrTel" title="<spring:message code="column.ordr_tel" />" value="<c:choose><c:when test="${orderBase.ordrTel eq null}">${orderBase.ordrMobile}</c:when><c:otherwise>${orderBase.ordrTel}</c:otherwise></c:choose>"  readonly="readonly">
						</td>
						<!-- 주문자휴대폰 -->
						<th scope="row"><spring:message code="column.ordr_mobile" /><strong class="red">*</strong></th>
						<td>
							<input type="text" class="readonly validate[maxSize[50], custom[mobile]]" name="ordrMobile" title="<spring:message code="column.ordr_mobile" />" value="${orderBase.ordrMobile}" readonly="readonly">
						</td>
						<!-- 주문자이메일 -->
						<th scope="row"><spring:message code="column.ordr_email" /><strong class="red">*</strong></th>
						<td>
							${orderBase.ordrEmail}
						</td>
					</tr>
				</tbody>
			</table>
		</form>

<!-- ==================================================================== -->
<!-- //주문정보 -->
<!-- ==================================================================== -->

<c:if test="${adminConstants.USR_GRP_10 eq session.usrGrpCd}">
<!-- ==================================================================== -->
<!-- 결제정보 -->
<!-- ==================================================================== -->
		<div class="mTitle mt30">
			<h2><spring:message code="column.order_common.pay_info" /></h2>
		</div>
		<form id="orderPayForm" name="orderPayForm" method="post" >
			<!-- 그리드 : 결제정보 -->
			<div class="mModule no_m">
				<table id="payBaseList" ></table>
			</div>
			<!-- //그리드 : 결제정보 -->
		</form>
				
<!-- ==================================================================== -->
<!-- //결제정보 -->
<!-- ==================================================================== -->
</c:if>

<!-- ==================================================================== -->
<!-- 주문 상품정보 : grid -->
<!-- ==================================================================== -->
		<div class="mTitle mt30">
			<h2><spring:message code="column.order_common.goods_info" /></h2>
			<c:if test="${adminConstants.USR_GRP_10 eq session.usrGrpCd}">
				<div class="buttonArea">
					<button type="button" class="btn btn-add" onclick="orderDetail.cancel();" ><spring:message code="column.order_common.btn.order_cancel" /></button>
					<button type="button" class="btn btn-add" onclick="orderDetail.excAccept();" ><spring:message code="column.order_common.btn.claim_exchange_accept" /></button>
					<button type="button" class="btn btn-add" onclick="orderDetail.rtnAccept();" ><spring:message code="column.order_common.btn.claim_return_accept" /></button>
					<button type="button" class="btn btn-add" onclick="orderDetail.purchase();" ><spring:message code="column.order_common.btn.claim_purchase" /></button>
				</div>
			</c:if>
		</div>

		<!-- 그리드 : 상품정보 -->
		<div class="mModule no_m">
			<table id="orderGoodsList" ></table>
		</div>
		<!-- //그리드 : 상품정보 -->


<c:set var="isAllMkiGoodsYn" value="${false }"/>
<c:forEach var="detail" items="${orderDetailList}" varStatus="idx">
	<c:if test="${detail.mkiGoodsYn eq 'Y' }">
		<c:set var="isAllMkiGoodsYn" value="${true }"/>
	</c:if>
</c:forEach>

<!-- ==================================================================== -->
<!-- //주문 상품정보 : grid -->
<!-- ==================================================================== -->


		<div class="row mt30">
			<div class="col-md-6">
				<!-- ==================================================================== -->
				<!-- 배송지정보 -->
				<!-- ==================================================================== -->
				<div class="mTitle">
					<h2><spring:message code="column.order_common.delivery_info" /></h2>
					<!-- 버튼 : 배송정보 수정 -->
					<c:if test="${adminConstants.USR_GRP_10 eq session.usrGrpCd}">
						<div class="buttonArea">
							<button type="button" onclick="orderDlvra.update();" class="btn btn-add"><spring:message code="column.order_common.btn.order_delivery_update" /></button>
						</div>
					</c:if>
				</div>
		
				<form id="orderDeliveryAddressForm" name="orderDeliveryAddressForm" method="post" >
				<input type="hidden" name="ordNo" value="${orderBase.ordNo}">
				<table class="table_type1">
					<caption>글 정보보기</caption>
					<colgroup>
						<col style="width:100px;">
						<col />
						<col style="width:100px">
						<col />
					</colgroup>
					<tbody>
						<tr>
							<!-- 받는분 명 -->
							<th scope="row"><spring:message code="column.order_common.adrs_nm" /><strong class="red">*</strong></th>
							<td colspan="3">
								<c:choose>
									<c:when test="${maskingUnlock eq adminConstants.COMM_YN_N}">
										${orderDlvra.adrsNm}
									</c:when>
									<c:otherwise>
										<input type="text" class="validate[required, maxSize[50]]" name="adrsNm" title="<spring:message code="column.order_common.adrs_nm" />" value="${orderDlvra.adrsNm}">
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<!-- 전화 -->
							<th scope="row"><spring:message code="column.tel" /></th>
							<td>
								<c:choose>
									<c:when test="${maskingUnlock eq adminConstants.COMM_YN_N}">
										${orderDlvra.tel}
									</c:when>
									<c:otherwise>
										<input type="text" class="validate[maxSize[20]]" name="tel" title="<spring:message code="column.tel" />" value="${orderDlvra.tel}">
									</c:otherwise>
								</c:choose>
							</td>
							<!-- 휴대폰 -->
							<th scope="row"><spring:message code="column.mobile" /><strong class="red">*</strong></th>
							<td>
								<c:choose>
									<c:when test="${maskingUnlock eq adminConstants.COMM_YN_N}">
										${orderDlvra.mobile}
									</c:when>
									<c:otherwise>
										<input type="text" class="validate[required, maxSize[20]]" name="mobile" title="<spring:message code="column.mobile" />" value="${orderDlvra.mobile}">
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<!-- 주소 : 도로명 주소 -->
							<th scope="row"><spring:message code="column.addr" /><strong class="red">*</strong></th>
							<td colspan="3">
								<div class="mg5">
									<c:choose>
										<c:when test="${maskingUnlock eq adminConstants.COMM_YN_N}">
											${orderDlvra.postNoNew}
										</c:when>
										<c:otherwise>
											<input type="text" class="readonly w50 validate[maxSize[6]]" name="postNoNew" id="postNoNew" value="${orderDlvra.postNoNew}" readonly="readonly">
											<button type="button" onclick="layerMoisPost.create(orderDlvra.cbPost);" class="btn">주소검색</button>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="mg5">
									<c:choose>
										<c:when test="${maskingUnlock eq adminConstants.COMM_YN_N}">
											${orderDlvra.roadAddr}
											${orderDlvra.roadDtlAddr}
										</c:when>
										<c:otherwise>
											<input type="text" class="readonly w300 validate[maxSize[100]]" name="roadAddr" id="roadAddr" value="${orderDlvra.roadAddr}" readonly="readonly">
											<input type="text" class="w200 validate[required, maxSize[100]]" name="roadDtlAddr" id="roadDtlAddr" value="${orderDlvra.roadDtlAddr}">
										</c:otherwise>
									</c:choose>
								</div>
								<input type="hidden" name="postNoOld" id="postNoOld" value="${orderDlvra.postNoOld}" />
								<input type="hidden" name="prclAddr" id="prclAddr" value="${orderDlvra.prclAddr}" readonly="readonly" />
							</td>
						</tr>
						<tr>
							<!-- 상품수령위치 -->
							<th scope="row"><spring:message code="column.order_common.goods_rcv_pst" /></th>
							<td colspan="3">
								<c:choose>
									<c:when test="${orderDlvra.goodsRcvPstCd eq adminConstants.GOODS_RCV_PST_40}">
										${orderDlvra.goodsRcvPstEtc}
									</c:when>
									<c:otherwise>
										<frame:codeName grpCd="${adminConstants.GOODS_RCV_PST }" dtlCd="${orderDlvra.goodsRcvPstCd}"  />
										<input type="hidden" name="goodsRcvPstCd" value="${orderDlvra.goodsRcvPstCd}" />
										<input type="hidden" name="goodsRcvPstEtc" value="${orderDlvra.goodsRcvPstEtc}" />
										<input type="hidden" name="dlvrDemandYn" value="${orderDlvra.dlvrDemandYn}" />
										<input type="hidden" name="pblGateEntMtdCd" value="${orderDlvra.pblGateEntMtdCd}" />
										<input type="hidden" name="pblGatePswd" value="${orderDlvra.pblGatePswd}" />
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<!-- 배송 요청사항 -->
							<th scope="row"><spring:message code="column.order_common.dlvr_demand" /></th>
							<td colspan="3">
								<c:choose>
									<c:when test="${maskingUnlock eq adminConstants.COMM_YN_N}">
										${orderDlvra.dlvrDemand}
									</c:when>
									<c:otherwise>
										${orderDlvra.dlvrDemand}
										<input type="hidden" name="dlvrDemand" value="${orderDlvra.dlvrDemand}" />
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</tbody>
				</table>
				</form>
				<!-- ==================================================================== -->
				<!-- //배송지정보 -->
				<!-- ==================================================================== -->
			</div>
			<div class="col-md-6">
				<!-- ==================================================================== -->
				<!-- 배송비 정보 : grid -->
				<!-- ==================================================================== -->
				<div class="mTitle">
					<h2><spring:message code="column.claim_common.delivery_charge_info" /></h2>
				</div>
				<!-- 그리드 : 상품정보 -->
				<div class="mModule no_m">
					<table id="orderDeliveryChargeList" ></table>
				</div>
				<!-- //그리드 : 상품정보 -->
				
				<!-- ==================================================================== -->
				<!-- //배송비 정보 : grid -->
				<!-- ==================================================================== -->
			</div>
		</div>
<!-- ==================================================================== -->
<!-- 주문 제작 정보 -->
<!-- ==================================================================== -->

<c:if test="${isAllMkiGoodsYn}">
		<div class="mTitle mt30">
			<h2><spring:message code="column.order_common.mki_goods_info" /></h2>
		</div>
		<div class="mModule no_m">
			<table class="table_type1">
				<caption>주문 제작 정보</caption>
				<tbody>
					<c:forEach var="detail" items="${orderDetailList}" varStatus="idx">
						<c:if test="${detail.mkiGoodsYn eq 'Y' }">
							<tr>
								<!-- 각인문구 -->
								<th scope="row"><spring:message code="column.order_common.mki_goods_content" /> ${idx.count }</th>
								<td colspan="3">
									<c:forTokens var="optContent" items="${detail.mkiGoodsOptContent }" delims="|" varStatus="conStatus">
										${optContent}${!conStatus.last ? ',' : '' }
									</c:forTokens>
								</td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>
</c:if>		

<!-- ==================================================================== -->
<!-- 새벽 당일 배송 정보 -->
<!-- ==================================================================== -->
		<c:if test="${orderBase.dlvrPrcsTpCd ne adminConstants.DLVR_PRCS_TP_10}" >
			<div class="row mt30">
				<div class="col-md-6">
					<!-- ==================================================================== -->
					<!-- 새벽/당일배송 정보 -->
					<!-- ==================================================================== -->
					<div class="mTitle">
						<h2><spring:message code="column.order_common.dawn.one_day.dlvr_info" /></h2>
					</div>
			
					<table class="table_type1">
						<caption>새벽/당일배송 정보</caption>
						<colgroup>
						</colgroup>
						<tbody>
							<tr>
								<!-- 새벽배송/당일배송 -->
								<th scope="row"><spring:message code="column.order_common.dawn_dlvr" />/<spring:message code="column.order_common.one_day_dlvr" /></th>
								<td colspan="3">
									<frame:codeName grpCd="${adminConstants.DLVR_PRCS_TP}" dtlCd="${orderBase.dlvrPrcsTpCd }"/>
								</td>
							</tr>
							<tr>
								<!-- 공동현관 출입방법 -->
								<th scope="row"><spring:message code="column.order_common.enter_method" /></th>
								<td colspan="3">
									<frame:codeName grpCd="${adminConstants.PBL_GATE_ENT_MTD}" dtlCd="${orderDlvra.pblGateEntMtdCd }"/>
								</td>
							</tr>
							<tr>
								<!-- 배송 SMS -->
								<th scope="row"><spring:message code="column.order_common.dlvr_sms" /></th>
								<td colspan="3">
									${orderDlvra.dlvrSms }
								</td>
							</tr>
							<tr>
								<!-- 배송 결과 -->
								<th scope="row"><spring:message code="column.order_common.dlvr_result" /></th>
								<td colspan="3">
									${orderDlvra.dlvrCpltYn }
								</td>
							</tr>
							<tr>
								<!-- 배송 사진 -->
								<th scope="row"><spring:message code="column.order_common.dlvr_image" /></th>
								<td colspan="3">
									<c:if test="${not empty orderDlvra.dlvrCpltPicUrl }">
										<a onclick="ordDtlImgReview('${orderDlvra.dlvrCpltPicUrl}');"><img src="${orderDlvra.dlvrCpltPicUrl }" class="thumb" style="width:auto;height:70px" alt=""/></a>									
									</c:if>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="col-md-6">
					<!-- ==================================================================== -->
					<!-- 권역 정보-->
					<!-- ==================================================================== -->
					<div class="mTitle">
						<h2><spring:message code="column.order_common.dlvr_area_info" /></h2>
					</div>
					<table class="table_type1">
						<caption>권역 정보</caption>
						<colgroup>
						</colgroup>
						<tbody>
							<tr>
								<!-- 우편번호 -->
								<th scope="row"><spring:message code="column.post_no_new" /></th>
								<td colspan="3">
									${orderDlvra.postNoNew }
								</td>
							</tr>
							<tr>
								<!-- 시 -->
								<th scope="row"><spring:message code="column.order_common.dlvr_si" /></th>
								<td colspan="3">
									${orderDlvra.sido }
								</td>
							</tr>
							<tr>
								<!-- 구 -->
								<th scope="row"><spring:message code="column.order_common.dlvr_gu" /></th>
								<td colspan="3">
									${orderDlvra.gugun }
								</td>
							</tr>
							<tr>
								<!-- 배송 권역 -->
								<th scope="row"><spring:message code="column.order_common.dlvr_area" /></th>
								<td colspan="3">
									${orderDlvra.dlvrAreaCd }
								</td>
							</tr>
							<tr>
								<!-- 배송 권역명 -->
								<th scope="row"><spring:message code="column.order_common.dlvr_area_nm" /></th>
								<td colspan="3">
									${orderDlvra.dlvrAreaNm }
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</c:if>
<!-- ==================================================================== -->
<!-- 클레임정보 : grid -->
<!-- ==================================================================== -->
		<div class="mTitle mt30">
			<h2><spring:message code="column.order_common.claim_info" /></h2>
		</div>
		<!-- 그리드 : 클레임정보 -->
		<div class="mModule no_m">
			<table id="claimList" ></table>
		</div>
		<!-- //그리드 : 클레임정보 -->

<!-- ==================================================================== -->
<!-- //클레임정보 : grid -->
<!-- ==================================================================== -->

<!-- ==================================================================== -->
<!-- CS정보 : grid -->
<!-- ==================================================================== -->
		<%-- <div class="mTitle mt30">
			<h2><spring:message code="column.order_common.cs_info" /></h2>
		</div>
		<!-- 그리드 : CS정보 -->
		<div class="mModule no_m">
			<table id="csList" ></table>
		</div> --%>
		<!-- //그리드 : CS정보 -->

<!-- ==================================================================== -->
<!-- //CS정보 : grid -->
<!-- ==================================================================== -->

<!-- ==================================================================== -->
<!-- 주문메모정보 -->
<!-- ==================================================================== -->
		<div class="mTitle mt30">
			<h2><spring:message code="column.order_common.order_memo" /></h2>
		</div>
		
		<form id="orderMemoForm" name="orderMemoForm" method="post" >
		<input type="hidden" name="ordNo" value="${orderBase.ordNo}">
			<table class="table_type1">
				<caption><spring:message code="column.order_common.order_memo" /></caption>
				<colgroup>
					<col style="width:10%;">
					<col style="width:auto;">
					<col style="width:10%;">
					<col style="width:15%;">
				</colgroup>
				<thead>
					<tr>
						<th class="center"><spring:message code="column.memo_seq" /></th>
						<th class="center"><spring:message code="column.memo_content" /></th>
						<th class="center"><spring:message code="column.sys_regr_nm" /></th>
						<th class="center"><spring:message code="column.order_common.ord_memo_dtm" /></th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty orderMemoList}">
						<tr>
							<td colspan="4" class="center">주문메모 정보가 존재하지 않습니다.</td>
						</tr>
					</c:if>
					<c:if test="${!empty orderMemoList}">
					<c:forEach items="${orderMemoList}" var="orderMemo">
					<tr>
						<td class="center">
							${orderMemo.memoSeq}
						</td>
						<td>
							${orderMemo.memoContent}
						</td>
						<td class="center">
							${orderMemo.sysRegrNm}
						</td>
						<td class="center">
							${orderMemo.sysRegDtm}
						</td>
					</tr>
					</c:forEach>
					</c:if>
				</tbody>
				<tfoot>
					<tr>
						<th><spring:message code="column.memo" /><strong class="red">*</strong></th>
						<td colspan="2">
							<textarea rows="3" id="memoContent" name="memoContent" class="validate[required, maxSize[4000]]" style="width:97%"></textarea>
						</td>
						<td>
							<button type="button" onclick="memo.insert();" class="btn"><spring:message code="column.order_common.btn.order_memo_insert" /></button>
						</td>
					</tr>
				</tfoot>
			</table>
		</form>


<!-- ==================================================================== -->
<!-- 주문메모정보 -->
<!-- ==================================================================== -->

		<!-- ==================================================================== -->
		<!-- 버튼 : 주문목록 -->
		<!-- ==================================================================== -->

		<div class="btn_area_center">
			<button type="button" class="btn btn-cancel" onclick="closeTab();">닫기</button>
		</div>

	</t:putAttribute>

</t:insertDefinition>
