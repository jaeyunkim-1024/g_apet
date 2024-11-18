<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">

		<script type="text/javascript">
			$(document).ready(function(){
				<c:if test="${adminConstants.USR_GRP_10 eq session.usrGrpCd}">
				payBase.createList();
				</c:if>
				claimDetail.createList();
				deliveryCharge.createList();

				<c:if test="${claimBase.clmTpCd ne adminConstants.CLM_TP_10}">
				deliveryAddress.createList();
				</c:if>
				
				<c:if test="${claimBase.clmTpCd eq adminConstants.CLM_TP_20}">
					$("#depositForm #fixAcct").change(function(){
						var chk = $(this).find("option:checked");
						$("#depositForm #bankCd").val(chk.data("usrdfn1"));
						$("#depositForm #acctNo").val(chk.data("usrdfn2"));
						$("#depositForm #depositAcctNoText").text(chk.data("usrdfn2"));
					});
				</c:if>

				<c:if test="${claimBase.mbrNo ne  adminConstants.NO_MEMBER_NO}">
					var cnctHistNo = "${cnctHistNo}";
					var mbrNo = "${claimBase.mbrNo}";
					var colGbCd = "${adminConstants.COL_GB_00}";
					var maskingUnlock = $("#maskingUnlock").val();
					var inqrGbCd = maskingUnlock == "${adminConstants.COMM_YN_Y}" ? "${adminConstants.INQR_GB_10}" : "${adminConstants.INQR_GB_40}";
					var execSql = "${execSql}";

					va.init(cnctHistNo);
					va.ac(mbrNo,colGbCd,inqrGbCd,maskingUnlock,execSql);
				</c:if>
			});

			/*
			 * 클레임 기본 기능
			 */
			var claimBase = {
				/* 수정 */
				cancel : function(){
					
					messager.confirm('<spring:message code="column.claim_common.confirm.accept_cancel" />',function(r){
						if(r){
							var options = {
								url : "<spring:url value='/claim/claimAcceptCancel.do' />"
								, data : {clmNo : '${claimBase.clmNo}' }
		
								, callBack : function(data){
									messager.alert( "<spring:message code="column.claim_common.message.accept_cancel.success" />", "Info", "info", function(){
										updateTab();
									});
								}
							};
							ajax.call(options);
						}
					});
				},
				/* 취소 PG실행 */
				reactPg : function(){
					
					messager.confirm('환불을 재실행하시겠습니까?',function(r){
						if(r){
							var options = {
								url : "<spring:url value='/claim/claimReactPgCancel.do' />"
								, data : {clmNo : '${claimBase.clmNo}' }
		
								, callBack : function(data){
									messager.alert( "<spring:message code="column.claim_common.message.accept_cancel.success" />", "Info", "info", function(){
										updateTab();
									});
								}
							};
							ajax.call(options);
						}
					});
				}

			};

			<c:if test="${adminConstants.USR_GRP_10 eq session.usrGrpCd}">
			/*
			 * 결제 기능
			 */
			var payBase = {
				/* 결제 목록 생성 */
				createList : function(){
					var options = {
						url : "<spring:url value='/claim/payBaseListGrid.do' />"
						, height : 200
						, searchParam : {
								clmNo : '${claimBase.clmNo}'
							,	maskingUnlock : $("#maskingUnlock").val()
						}
						, colModels : [
				             // 주문번호
				             {name:"ordNo", label:'<spring:message code="column.ord_no" />', hidden : true}
                            // 결제 번호
                            , {name:"payNo", label:'<spring:message code="column.pay_no" />', width:"80", align:"center", sortable:false}
				             // 결제 구분
				            , {name:"payGbCd", label:'<spring:message code="column.pay_gb_cd" />', width:"80", align:"center", sortable:false, formatter:"select",  editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.PAY_GB}" />"}}
				             // 결제상태
				            , {name:"payStatCd", label:'<spring:message code="column.pay_stat_cd" />', width:"80", align:"center", sortable:false, formatter:"select",  editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.PAY_STAT}" />"}}
				             // 결제 수단
				            , {name:"payMeansCd", label:'<spring:message code="column.pay_means_cd" />', width:"80", align:"center", formatter:"select", sortable:false, editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.PAY_MEANS}" />"}}
				             // 결제 금액
				 			, {name:"payAmt", label:'<spring:message code="column.amt" />', width:"100", align:"center", sortable:false ,formatter:'integer', formatoptions:{thousandsSeparator:','}, summaryType:'sum', summaryTpl : 'Totals:', hidden : true}
				 			// 결제 금액 (마이너스 환불 제외)
							, {name:"payAmt01", label:'<spring:message code="column.pay_amt" />', width:"150", align:"center", sortable:false, formatter:'integer', formatoptions:{thousandsSeparator:','}, summaryType:'sum', summaryTpl : 'Totals:'}
				 			// 입금 금액 : 분리(마이너스 환불)
				 			, {name:"payAmt02", label:'<spring:message code="column.claim_common.deposit_amt" />', width:"150", align:"center", sortable:false, formatter:'integer', formatoptions:{thousandsSeparator:','}, summaryType:'sum', summaryTpl : 'Totals:'}
				             // 결제 완료 일시
						 	, {name:"payCpltDtm", label:'<spring:message code="column.cplt_dtm" />', width:"110", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm"}
				 			// 취소여부
				 			, {name:"cncYn", label:'<spring:message code="column.cnc_yn" />', width:"60", align:"center", sortable:false}
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
							var paySum = $("#payBaseList").jqGrid('getCol', 'payAmt', false, 'sum');
							var paySum01 = $("#payBaseList").jqGrid('getCol', 'payAmt01', false, 'sum');
							var paySum02 = $("#payBaseList").jqGrid('getCol', 'payAmt02', false, 'sum');
							$("#payBaseList").jqGrid('footerData', 'set', {payNo : '합계', payAmt01 : paySum01, payAmt02 : paySum02});
						}
					};

					grid.create("payBaseList", options);
				}
			};
			</c:if>

			/*
			 * 클레임 상세 기능
			 */
			var claimDetail = {
				/* 목록 생성 */
				createList : function(){
					var options = {
						url : "<spring:url value='/claim/claimDetailListGrid.do' />"
						, height : 200
						, searchParam : {
							clmNo : '${claimBase.clmNo}'
						}
						,colModels : [
				 			//클레임 번호
				 			{name:"clmNo", label:'<spring:message code="column.clm_no" />', hidden:true }
				 			// 클레임 상세 순번
				 			, {name:"clmDtlSeq", label:'<spring:message code="column.clm_dtl_seq" />', width:"85", align:"center"}
				 			// 클레임 상세 유형 코드
				 			, {name:"clmDtlTpCd", label:'<spring:message code="column.clm_dtl_tp_cd" />', width:"90", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_DTL_TP}" />"}}
				 			// 클레임 상세 상태 코드
				 			, {name:"clmDtlStatCd", label:'<spring:message code="column.clm_dtl_stat_cd" />', width:"90", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_DTL_STAT}" />"}}
				 			// 클레임 사유 코드
				 			, {name:"clmRsnCd", label:'<spring:message code="column.clm_rsn_cd" />', width:"150", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_RSN}" />"}}
				 			// 상품번호
				 			, {name:"goodsId", label:'<spring:message code="column.goods_id" />', width:"60", align:"center", sortable:false, hidden:true}
				 			// 상품명
				 			, {name:"goodsNm", label:'<b><u><tt><spring:message code="column.goods_nm" /></tt></u></b>', width:"300", align:"center", sortable:false, classes:'pointer fontbold'}
				 			// 단품명 ( 기능 없어 삭제 v0.6 )
				 			//, {name:"itemNm", label:'<spring:message code="column.item_nm" />', width:"150", align:"center", sortable:false}
				 			// 판매 단가
				 			, {name:"saleAmt", label:'<spring:message code="column.sale_unit_prc" />', width:"80", align:"center", formatter:'integer', sortable:false}
				 			// 프로모션 할인 단가
// 				 			, {name:"prmtDcAmt", label:'<spring:message code="column.prmt_dc_unit_prc" />', width:"80", align:"center", formatter:'integer', sortable:false}
				 			// 상품 쿠폰 할인 단가
				 			, {name:"cpDcAmt", label:'<spring:message code="column.cp_dc_unit_prc" />', width:"80", align:"center", formatter:'integer', sortable:false}
				 			// 장바구니쿠폰할인
				 			, {name:"cartCpDcAmt", label:'<spring:message code="column.cart_cp_dc_unit_prc" />', width:"80", align:"center", formatter:'integer', sortable:false}
				 			// 결제 단가
				 			, {name:"payAmt", label:'<spring:message code="column.pay_unit_price" />', width:"80", align:"center", formatter:'integer', sortable:false}
				 			// 주문수량
				 			, {name:"ordQty", label:'<spring:message code="column.ord_qty" />', width:"60", align:"center", formatter:'integer', sortable:false}
				 			// 클레임 수량
				 			, {name:"clmQty", label:'<spring:message code="column.clm_qty" />', width:"80", align:"center", formatter:'integer'}
				 			//결제 환불 합계 금액
				 			<c:if test="${claimBase.clmTpCd ne adminConstants.CLM_TP_30}">
				 			, {name:"rfdPayTotAmt", label:'<spring:message code="column.refund_total_amt" />', width:"90", align:"center", sortable:false,  formatter:'integer', formatoptions:{thousandsSeparator:','}, summaryType:'sum', summaryTpl : 'Totals:'}
				 			</c:if>
				 			// 배송비번호
				 			, {name:"dlvrcNo", label:'<spring:message code="column.dlvrc_no" />', width:"80", align:"center"}
				 			// 회수비번호
				 			, {name:"rtnDlvrcNo", label:'<spring:message code="column.rtn_dlvrc_no" />', width:"80", align:"center" }
				 			<c:if test="${claimBase.clmTpCd ne adminConstants.CLM_TP_10}">
				 			// 배송지번호
				 			, {name:"dlvraNo", label:'<spring:message code="column.ord_dlvp_sn" />', width:"80", align:"center"}
				 			// 회수지번호
				 			, {name:"rtrnaNo", label:'<spring:message code="column.rtn_dlvra_no" />', width:"80", align:"center"}
				 			</c:if>
				 			// 주문 번호
				 			, {name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"110", align:"center", hidden:true}
				 			// 주문 상세 순번
				 			, {name:"ordDtlSeq", label:'<spring:message code="column.ord_dtl_seq" />', width:"70", align:"center", formatter:'integer'}
				 		]
						,onCellSelect : function (id, cellidx, cellvalue) {
							var cm = $("#claimGoodsList").jqGrid("getGridParam", "colModel");
							var rowData = $("#claimGoodsList").getRowData(id);
							if(cm[cellidx].name == "goodsNm"  ){
								claimDetail.goodsDetailView(rowData.goodsId);
							}else if(cellidx != 0){
								var clmNo =  $('#claimGoodsList').jqGrid ('getCell', id, 'clmNo');
								var clmDtlSeq =  $('#claimGoodsList').jqGrid ('getCell', id, 'clmDtlSeq');
								var options = {
									url : "<spring:url value='/claim/claimDetailCstrtPopView.do' />"
									, dataType : "html"
									, data : {
										clmNo : clmNo
										, clmDtlSeq : clmDtlSeq
									}
									, callBack : function(result) {
										var config = {
											id : "layerClaimCstrtView"
											, top : 50
											, width : 800
											, height : 540
											, title : "클레임 상세 내역"
											, body : result
										}
										layer.create(config);
									}
								}
								ajax.call(options );
							}
						}
						, onSelectRow : function(rowid){

						}
						, paging : false
						<c:if test="${claimBase.clmTpCd ne adminConstants.CLM_TP_30}">
						, footerrow : true
						, userDataOnFooter:true
						</c:if>
			            , gridComplete: function() {  /** 데이터 로딩시 함수 **/

			            	var ids = $('#claimGoodsList').jqGrid('getDataIDs');

			                // 그리드 데이터 가져오기
			                var gridData = $("#claimGoodsList").jqGrid('getRowData');

			            	if(gridData.length > 0){
				                // 데이터 확인후 색상 변경
				                for (var i = 0; i < gridData.length; i++) {

				                	// 데이터의 is_test 확인
				                	if (gridData[i].clmStatCd == '<c:out value="${adminConstants.CLM_STAT_40}" />') {

				                		// 열의 색상을 변경하고 싶을 때(css는 미리 선언)
				                		$('#claimGoodsList tr[id=' + ids[i] + ']').css('color', 'red');
				                   }
				                }
			            	}

			            	/*
			            	 * 환불 합계
			            	 */
			            	 <c:if test="${claimBase.clmTpCd ne adminConstants.CLM_TP_30}">
							var payTotSum = $("#claimGoodsList").jqGrid('getCol', 'rfdPayTotAmt', false, 'sum');
							$("#claimGoodsList").jqGrid('footerData', 'set', {clmDtlSeq : '합계', rfdPayTotAmt : payTotSum});
							</c:if>

			            }
					};

					grid.create("claimGoodsList", options);

					$("#claimGoodsList").jqGrid('setGroupHeaders', {
					  useColSpanStyle: true,
					  groupHeaders:[
						{startColumnName: 'saleAmt', numberOfColumns: 4, titleText: '상품단가정보'},
						{startColumnName: 'dlvrcNo', numberOfColumns: 2, titleText: '배송비정보'},
						{startColumnName: 'dlvraNo', numberOfColumns: 2, titleText: '배송지정보'}
					  ]
					});
				}
				, goodsDetailView : function(goodsId){
					addTab('상품 상세 - ' + goodsId, '/order/goodsDetailView.do?goodsId=' + goodsId + "&viewGb=" + '${adminConstants.VIEW_GB_POP}');
				}

			};

			/*
			 * 배송지
			 */
			var deliveryAddress = {
				/* 목록 생성 */
				createList : function(){
					var options = {
						url : "<spring:url value='/claim/deliveryAddressListGrid.do' />"
						, height : 100
						, searchParam : {
								clmNo : '${claimBase.clmNo}'
							,	maskingUnlock: $("#maskingUnlock").val()
						}
						,colModels : [
				 			// 배송비 번호
				 			{name:"ordDlvraNo", label:'<spring:message code="column.ord_dlvp_sn" />', width:"90", align:"center" }
				 			// 수취인명
				 			, {name:"adrsNm", label:'<spring:message code="column.adrs_nm" />', width:"100", align:"center",  sortable:false}
				 			// 전화
				 			, {name:"tel", label:'<spring:message code="column.tel" />', width:"100", align:"center",  formatter:gridFormat.phonenumber, sortable:false }
				 			// 휴대폰 번호
				 			, {name:"mobile", label:'<spring:message code="column.mobile" />', width:"100", align:"center",  formatter:gridFormat.phonenumber, sortable:false}
				 			// 우편번호
				 			, {name:"postNoNew", label:'<spring:message code="column.post_no_new" />', width:"80", align:"center",  sortable:false}
				 			// 도로주소
				 			, {name:"fullRoadAddr", label:'<spring:message code="column.road_addr" />', width:"230", align:"center",  sortable:false}
				 			// 지번주소
				 			, {name:"fullPrclAddr", label:'<spring:message code="column.prcl_addr" />', width:"230", align:"center",  sortable:false}
				 			// 배송 요청사항
				 			, {name:"dlvrDemand", label:'<spring:message code="column.order_common.dlvr_demand" />', width:"200", align:"center",  sortable:false}
				 		]
						, paging : false
					};

					options.accessYn = "${adminConstants.COMM_YN_Y}"
					va.la($("#maskingUnlock").val());
					var searchParam = {
							clmNo : '${claimBase.clmNo}'
						,	maskingUnlock : $("#maskingUnlock").val()
					};
					options.searchParam = $.extend(searchParam,va.data);
					grid.create("claimDeliveryAddressList", options);
				}

			};

			/*
			 * 배송비
			 */
			var deliveryCharge = {
				/* 목록 생성 */
				createList : function(){
					var options = {
						url : "<spring:url value='/claim/deliveryChargeListGrid.do' />"
						, height : 120
						, searchParam : {
							clmNo : '${claimBase.clmNo}'
						}
						,colModels : [
				 			// 배송비 번호
				 			{name:"dlvrcNo", label:'<spring:message code="column.dlvrc_no" />', width:"100", align:"center" }
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
				 			, {name:"buyPrc", label:'<spring:message code="column.buy_std_prc" />', width:"75", align:"center", formatter:'integer', sortable:false }
				 		]
						, paging : false
						, footerrow : true
						, userDataOnFooter:true
			            , gridComplete: function() {  /** 데이터 로딩시 함수 **/
			            	/*
			            	 * 그리드 색상 변경
			            	 */
			            	var ids = $('#claimDeliveryChargeList').jqGrid('getDataIDs');

			                // 그리드 데이터 가져오기
			                var gridData = $("#claimDeliveryChargeList").jqGrid('getRowData');
			                
			                var realDlvrTotSum = 0;

			            	if(gridData.length > 0){
				                // 데이터 확인후 색상 변경
				                for (var i = 0; i < gridData.length; i++) {

				                	// 데이터의 is_test 확인
				                	if (gridData[i].cncYn === 'Y' && gridData[i].cncClmNo === '${claimBase.clmNo}') {

				                		// 열의 색상을 변경하고 싶을 때(css는 미리 선언)
				                		$('#claimDeliveryChargeList tr[id=' + ids[i] + ']').css('color', 'red');
				                	} else {
				                	   realDlvrTotSum += parseInt(gridData[i].realDlvrAmt);
				                   }
				                }
			            	}

			            	/*
			            	 * 배송비 합계
			            	 */
// 							var realDlvrTotSum = $("#claimDeliveryChargeList").jqGrid('getCol', 'realDlvrAmt', false, 'sum');
							$("#claimDeliveryChargeList").jqGrid('footerData', 'set', {dlvrcNo : '합계', realDlvrAmt : realDlvrTotSum});
			            }
					};

					grid.create("claimDeliveryChargeList", options);

					$("#claimDeliveryChargeList").jqGrid('setGroupHeaders', {
					  useColSpanStyle: true,
					  groupHeaders:[
						{startColumnName: 'costGbCd', numberOfColumns: 8, titleText: '배송비정보'},
						{startColumnName: 'dlvrcStdCd', numberOfColumns: 7, titleText: '배송비기준정보'},
					  ]
					});
				}

			};

			var memo = {
				valid : function(){
					var memoContent = $("#memoContent").val();

					if(memoContent.length == 0){
						$('#memoEmptyText').show();
						return false;
					}
					$('#memoEmptyText').hide();
					this.insert();
				},
				insert : function(){
					messager.confirm('<spring:message code="column.order_common.confirm.order_memo_insert" />',function(r){
						if(r){
							var options = {
								url : "<spring:url value='/order/orderMemoInsert.do' />"
								, data : $("#orderMemoForm").serializeJson()
								, callBack : function(data){
									messager.alert( "<spring:message code='column.common.regist.final_msg' />", "Info", "info", function(){
										document.location.reload();
									});
									
								}
							};

							ajax.call(options);
						}
					});
				}
			};
			
			function clmDtlImgReview(imgPath){
				
				window.open(location.protocol + '//<spring:eval expression="@webConfig['site.domain']" />/common/imageView.do?filePath=' + imgPath, "","width=600px, height=600px, left=0, top=0"); 
				
				/* var options = {
						url : "<spring:url value='/claim/claimDetailImageLayerView.do' />"
							, data : { rsnImgPath : imgPath }
						, dataType : "html"
						, callBack : function (data ) {
							var config = {
								id : "clmDtlImgReview"
								, width : 500
								, height : 600
								, top : 200
								, title : "이미지 리뷰"
								, body : data
							}
							layer.create(config);
						}
					}
				ajax.call(options ); */
			}
			
			var deposit = {
				//입금 조회	
				searchPop : function(){
					var options = {
						url : "<spring:url value='/claim/depositListPopView.do' />"
						, dataType : "html"
						, data : {
							acctNo : '${depositInfo.acctNo}'
							, clmNo : '${claimBase.clmNo}'
						}
						, callBack : function(result) {
							var config = {
								id : "depositListPopView"
								, width : 1010
								, height : 525
								, top : 100
								, title : "입금 조회"
								, body : result
							}
							layer.create(config);
						}
					}
					ajax.call(options );
				}
				//입금 확인완료
				, confirm : function(){
					messager.confirm('입금 확인 완료 처리시 클레임이 종료됩니다. 입금 확인 완료 하시겠습니까?',function(r){
	            		if(r){
	            			var options = {
                            	url : "<spring:url value='/claim/confirmDepositInfo.do' />"
                             	, data : $("#depositForm").serializeJson()
                             	, callBack : function(result){
                             		messager.alert("처리 되었습니다.","Info","info", function(){
                             			updateTab();
                             		});
                             	}
                         	};
                         	ajax.call(options);
	            		}
					});
				}
				//입금 정보 등록
				, insert : function(){
					if(!$("#depositForm select[name='fixAcct']").val()) {
						alert("입금 은행을 선택하세요");
						return;
					}
					if(!$("#depositForm input[name='payAmt']").val()) {
						alert("입금 금액을 입력하세요");
						return;
					}
					if(validate.check("depositForm")) {
						messager.confirm('입금 정보를 등록하시겠습니까? 등록 후 수정이 불가능합니다.',function(r){
		            		if(r){
		            			var options = {
	                            	url : "<spring:url value='/claim/insertDepositInfo.do' />"
	                             	, data : $("#depositForm").serializeJson()
	                             	, callBack : function(result){
	                             		messager.alert("등록 되었습니다.","Info","info", function(){
	                             			updateTab();
	                             		});
	                             	}
	                         	};

	                         	ajax.call(options);
		            		}
						});
					 }
				}
			}

			//개인정보 해제
			function fnUnlockPrivacyMasking(){
				if( $("#maskingUnlock").val() == '${adminConstants.COMM_YN_N}' ) {
					messager.confirm("<spring:message code='column.member_search_view.maksing_unlock_msg' />",function(r){
						//개인정보 숨김
						if(r){
							$("#maskingUnlock").val('${adminConstants.COMM_YN_Y}');
							var url = '/delivery/claimDetailView.do?clmNo=' + $("[name='clmNo']").val()
									+ '&viewGb=' + '${adminConstants.VIEW_GB_POP}'
									+ '&maskingUnlock=' + $("#maskingUnlock").val()
									+ '&cnctHistNo=' + va.data.cnctHistNo
							updateTab(url,"클레임 상세");
						}
					});
				}else{
					//개인정보 해제
					messager.alert("<spring:message code='column.member_search_view.maksing_unlock_msg_already' />","Info","Info",function(){});
				}
			}
		</script>
	</t:putAttribute>


	<t:putAttribute name="content">

		<input type="hidden" id="maskingUnlock" name="maskingUnlock" value="${maskingUnlock}">
<!-- ==================================================================== -->
<!-- 클레임 정보 -->
<!-- ==================================================================== -->
		<div class="mTitle">
			<h2><spring:message code="column.claim_common.claim_info" /></h2>
			<div class="buttonArea">
				<button type="button" onclick="fnUnlockPrivacyMasking();" class="btn btn-add" id='privacyBtn'>개인정보 해제</button>
			</div>
		</div>

		<form id="claimInfoForm" name="claimInfoForm" method="post" >
			<input type="hidden" name="clmNo" value="${claimBase.clmNo}">
			<table class="table_type1">
				<caption><spring:message code="column.claim_common.claim_info" /></caption>
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
						<!-- 클레임번호 -->
						<th scope="row"><spring:message code="column.clm_no" /></th>
						<td>
							${claimBase.clmNo}
						</td>
						<!-- 클레임유형 -->
						<th scope="row"><spring:message code="column.clm_tp_cd" /></th>
						<td>
							<frame:codeName grpCd="${adminConstants.CLM_TP }" dtlCd="${claimBase.clmTpCd }"/>
							<c:if test="${claimBase.swapYn eq adminConstants.COMM_YN_Y}">
							(맞교환)
							</c:if>
						</td>
						<!-- 클레임상태 -->
						<th scope="row"><spring:message code="column.clm_stat_cd" /></th>
						<td><frame:codeName grpCd="${adminConstants.CLM_STAT }" dtlCd="${claimBase.clmStatCd }"/></td>
					</tr>
					<tr>
						<!-- 사이트 -->
						<th scope="row"><spring:message code="column.st" /></th>
						<td>
							${claimBase.stNm}
						</td>
						<!-- 주문매체 -->
						<th scope="row"><spring:message code="column.ord_mda_cd" /></th>
						<td colspan="3"><frame:codeName grpCd="${adminConstants.ORD_MDA }" dtlCd="${claimBase.ordMdaCd }"/></td>
						<!-- 채널 -->
						<%-- <th scope="row"><spring:message code="column.chnl" /></th>
						<td>
							${claimBase.chnlNm}
						</td> --%>
					</tr>
					<tr>
						<!-- 회원명/회원번호 -->
						<th scope="row"><spring:message code="column.ordr_info" /></th>
						<td>
							<c:if test="${claimBase.mbrNo eq  adminConstants.NO_MEMBER_NO}">
							비회원
							</c:if>
							<c:if test="${claimBase.mbrNo ne  adminConstants.NO_MEMBER_NO}">
							${claimBase.ordNm}
							<c:if test="${adminConstants.USR_GRP_10 eq session.usrGrpCd}">
							/
							${claimBase.ordrId}
							</c:if>
							</c:if>
						</td>
						<!-- 주문 접수 일시 -->
						<th scope="row"><spring:message code="column.acpt_dtm" /></th>
						<td>
							<fmt:formatDate value="${claimBase.acptDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
							
						</td>
						<c:if test="${claimBase.clmStatCd eq adminConstants.CLM_STAT_40}">
						<!-- 주문 취소 일시 -->
						<th scope="row"><spring:message code="column.cnc_dtm" /></th>
						<td>
							<fmt:formatDate value="${claimBase.cncDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
						</c:if>
						<c:if test="${claimBase.clmStatCd ne adminConstants.CLM_STAT_40}">
						<!-- 주문 완료 일시 -->
						<th scope="row"><spring:message code="column.cplt_dtm" /></th>
						<td>
							<fmt:formatDate value="${claimBase.cpltDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
						</c:if>
					</tr>
				</tbody>
			</table>
		</form>
		
<!-- ==================================================================== -->
<!-- //클레임 정보 -->
<!-- ==================================================================== -->

<c:if test="${adminConstants.USR_GRP_10 eq session.usrGrpCd}">
<!-- ==================================================================== -->
<!-- 결제정보 -->
<!-- ==================================================================== -->
		<div class="mTitle mt30">
			<h2><spring:message code="column.claim_common.pay_info" /></h2>
		<!-- <div class="buttonArea">
			<button type="button" onclick="claimBase.reactPg();" class="btn">환불재실행</button>
		</div> -->
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
<!-- 입금계좌 정보 -->
<!-- ==================================================================== -->
<c:if test="${claimBase.clmTpCd eq adminConstants.CLM_TP_20}">
<c:choose>
	<c:when test="${not empty depositInfo}">
		<div class="mTitle mt30">
			<h2><spring:message code="column.claim_common.deposit_acct_info" /></h2>
			<div class="buttonArea">
				<c:if test="${adminConstants.USR_GRP_10 eq session.usrGrpCd}" >
					<button type="button" onclick="deposit.searchPop()" class="btn btn-add">입금 조회</button>
				</c:if>
				<c:if test="${depositInfo.payStatCd eq adminConstants.PAY_STAT_01 and  depositInfo.mngrCheckYn ne 'Y' }">
					<button type="button" onclick="deposit.confirm()" class="btn btn-add">입금 확인 완료</button>
				</c:if>
			</div>
		</div>
		<form id="depositForm" name="depositForm" method="post" >
			<input type="hidden" name="payNo" value="${depositInfo.payNo}">
			<input type="hidden" id="acctNo" name="acctNo" value="${depositInfo.acctNo}"/>
			<input type="hidden" name="clmNo" value="${claimBase.clmNo}">
			<table class="table_type1">
				<caption><spring:message code="column.claim_common.deposit_acct_info" /></caption>
				<tbody>
					<tr>
						<!-- 입금 은행 -->
						<th scope="row"><spring:message code="column.claim_common.deposit_bank" /></th>
						<td>
							<frame:codeName grpCd="${adminConstants.BANK }" dtlCd="${depositInfo.bankCd}"/>
						</td>
						<!-- 입금 계좌번호 -->
						<th scope="row"><spring:message code="column.claim_common.deposit_acct_no" /></th>
						<td>
							${depositInfo.acctNo}
						</td>
					</tr>
					<tr>
						<!-- 입금 금액 -->
						<th scope="row"><spring:message code="column.claim_common.deposit_amt" /></th>
						<td>
							<fmt:formatNumber value="${depositInfo.payAmt}" type="number" pattern="#,###,###"/>
						</td>
						<!-- 입금자명 -->
						<th scope="row"><spring:message code="column.claim_common.deposit_nm" /></th>
						<td>
							${depositInfo.ooaNm}
						</td>
					</tr>
					<tr>
						<!-- 입금 상태 -->
						<th scope="row"><spring:message code="column.claim_common.deposit_stat" /></th>
						<td colspan="3">
							<c:choose>
								<c:when test="${depositInfo.mngrCheckYn eq 'Y'}">
									입금확인완료
								</c:when>
								<c:otherwise>
									입금확인중
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</c:when>
	<c:otherwise>
		<c:if test="${adminConstants.USR_GRP_10 eq session.usrGrpCd}" >
			<div class="mTitle mt30">
				<h2><spring:message code="column.claim_common.deposit_acct_info" /></h2>
				<div class="buttonArea">
					<button type="button" onclick="deposit.insert()" class="btn btn-add">입금 정보 등록</button>
				</div>
			</div>
			<form id="depositForm" name="depositForm" method="post" >
				<input type="hidden" name="clmNo" value="${claimBase.clmNo}">
				<input type="hidden" name="ordNo" value="${claimBase.ordNo}">
				<input type="hidden" id="bankCd" name="bankCd" value=""/>
				<input type="hidden" id="ooaNm" name="ooaNm" value="${claimBase.ordNm }"/>
				<input type="hidden" id="acctNo" name="acctNo" value=""/>
				<input type="hidden" id="depositMobile" name="depositMobile" value="${claimBase.ordrMobile }"/>
				<table class="table_type1">
					<caption><spring:message code="column.order_common.goods_info" /></caption>
					<tbody>
						<tr>
							<!-- 입금 은행 -->
							<th scope="row"><spring:message code="column.claim_common.deposit_bank" /></th>
							<td>
								<select name="fixAcct" id="fixAcct" class="validate[required]" title="선택상자">
									<frame:select grpCd="${adminConstants.FIX_ACCT }" defaultName="선택"/>
								</select>
							</td>
							<!-- 입금 계좌번호 -->
							<th scope="row"><spring:message code="column.claim_common.deposit_acct_no" /></th>
							<td id="depositAcctNoText">
								${depositInfo.acctNo}
							</td>
						</tr>
						<tr>
							<!-- 입금 금액 -->
							<th scope="row"><spring:message code="column.claim_common.deposit_amt" /></th>
							<td>
								<input type="text" class="right comma validate[custom[number], min[1]]" name="payAmt" title="<spring:message code="column.claim_common.deposit_amt" />" />
							</td>
							<!-- 입금자명 -->
							<th scope="row"><spring:message code="column.claim_common.deposit_nm" /></th>
							<td>
								${claimBase.ordNm}
							</td>
						</tr>
						<tr>
							<!-- 입금 상태 -->
							<th scope="row"><spring:message code="column.claim_common.deposit_stat" /></th>
							<td colspan="3">
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</c:if>
	</c:otherwise>
</c:choose>
</c:if>
		
<!-- ==================================================================== -->
<!-- 클레임 상품정보 : grid -->
<!-- ==================================================================== -->
		<div class="mTitle mt30">
			<h2><spring:message code="column.order_common.goods_info" /></h2>
		</div>
		<div class="mModule no_m">
			<table id="claimGoodsList" ></table>
		</div>

<!-- ==================================================================== -->
<!-- //클레임 상품정보 : grid -->
<!-- ==================================================================== -->

<c:if test="${claimBase.clmTpCd ne adminConstants.CLM_TP_10}">
<!-- ==================================================================== -->
<!-- 배송지 정보 : grid -->
<!-- ==================================================================== -->
		<div class="mTitle mt30">
			<h2><spring:message code="column.claim_common.delivery_address_info" /></h2>
		</div>
		<div class="mModule no_m">
			<table id="claimDeliveryAddressList" ></table>
		</div>
<!-- ==================================================================== -->
<!-- //배송지 정보 : grid -->
<!-- ==================================================================== -->
</c:if>

<!-- ==================================================================== -->
<!-- 배송비 정보 : grid -->
<!-- ==================================================================== -->
		<div class="mTitle mt30">
			<h2><spring:message code="column.claim_common.delivery_charge_info" /></h2>
		</div>
		<div class="mModule no_m">
			<table id="claimDeliveryChargeList" ></table>
		</div>

<!-- ==================================================================== -->
<!-- //배송비 정보 : grid -->
<!-- ==================================================================== -->



<!-- ==================================================================== -->
<!-- 클레임 상세 사유 -->
<!-- ==================================================================== -->
		<div class="mTitle mt30">
			<h2><spring:message code="column.claim_common.claim_rsn_content" /></h2>
		</div>
		<table class="table_type1">
			<caption><spring:message code="column.claim_common.claim_rsn_content" /></caption>
			<colgroup>
				<col style="width:10%;">
				<col style="width:auto;">
			</colgroup>
			<tbody>
				<tr>
					<th><spring:message code="column.claim_common.claim_rsn_detail_content" /></th>
					<td>
						${clmRsnContent}
					</td>
				</tr>
				<c:if test="${claimBase.clmTpCd ne adminConstants.CLM_TP_10}">
					<tr>
						<th><spring:message code="column.claim_common.claim_rsn_detail_image" /></th>
						<td>
							<c:if test="${not empty claimDetailImageList}">
								<c:forEach var="resultList" items="${claimDetailImageList}" varStatus="status">
									<a onclick="clmDtlImgReview('${resultList.rsnImgPath}');"><img id="clmDtlImgPathView${resultList.clmDtlRsnSeq}" name="clmDtlImgPathView${resultList.clmDtlRsnSeq}" src="<frame:imgUrl/>${resultList.rsnImgPath}" class="thumb" alt="" /></a> 
								</c:forEach>
							</c:if>
							<c:if test="${empty claimDetailImageList}">
							<img id="clmDtlImgPathView" name="clmDtlImgPathView" src="/images/noimage.png" class="thumb" alt="" />
							</c:if>
						</td>
					</tr>
				</c:if>
			</tbody>
		</table>

<!-- ==================================================================== -->
<!-- 클레임 상세 사유 -->
<!-- ==================================================================== -->



<!-- ==================================================================== -->
<!-- 주문메모정보 -->
<!-- ==================================================================== -->
		<div class="mTitle mt30">
			<h2><spring:message code="column.order_common.order_memo" /></h2>
		</div>
		<form id="orderMemoForm" name="orderMemoForm" method="post" >
		<input type="hidden" name="ordNo" value="${claimBase.ordNo}">
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
							<p id="memoEmptyText" style="display:none"><strong class="red">*</strong> 필수입력입니다.</p>
						</td>
						<td>
							<button type="button" onclick="memo.valid();" class="btn"><spring:message code="column.claim_common.btn.claim_memo_insert" /></button>
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
