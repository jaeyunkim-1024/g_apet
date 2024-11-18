<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">

			$(document).ready(function(){
				
			});

			$(function(){
				<c:if test="${orderBase.ordStatCd ne adminConstants.ORD_STAT_10}">
				$("#claimAcceptForm #clmRsnCd").change(function(){
					fnClaimAcceptExpt();
					var opt = $(this).find("option:checked");
					if(opt.data("grp") == '${adminConstants.RSP_RSN_20}'){
						$("#claimAcceptForm #clmRsnContent").addClass("validate[required]");
						$("#claimAcceptForm #clmRsnContentText").html('<spring:message code="column.claim_common.claim_rsn_detail_content" /><strong class="red">*</strong>');
					}else{
						$("#claimAcceptForm #clmRsnContent").removeClass("validate[required]");
						$("#claimAcceptForm #clmRsnContentText").html('<spring:message code="column.claim_common.claim_rsn_detail_content" />');
					}
				});
				
				$("#claimAcceptForm #clmRsnCd").trigger('change');

				$("#claimAcceptForm #arrClmQty").change(function(){
					fnClaimAcceptExpt();
				});
				</c:if>
				
				$("#claimAcceptForm #bankCd", "#claimAcceptForm #ooaNm", "#claimAcceptForm #acctNo").change(function(){
					$("#claimAcceptForm #cetifyYn").val("N");
				});
			});
			
			<c:if test="${orderBase.ordStatCd ne adminConstants.ORD_STAT_10}">
			// 주문 취소 예정 조회
			function fnClaimAcceptExpt(){
				if($("#claimAcceptForm #clmRsnCd").val() != "" && $("#claimAcceptForm #arrClmQty") != ""){
		 			var options = {
	 					url : "<spring:url value='/claim/claimCancelExpt.do' />"
	 					, data :  $("#claimAcceptForm").serializeJson()
 						, callBack : function(data){
 							
 							/* var orgDlvrcAmt = 0; //원배송비
 							var ordDlvrcAmt = 0; //조건부무료배송->배송비 부과
 							if(data.claimRefund.orgDlvrcAmt != undefined){
 								orgDlvrcAmt = parseInt(data.claimRefund.orgDlvrcAmt);
 							
	 							if (orgDlvrcAmt < 0) {
	 								ordDlvrcAmt = parseInt(Math.abs(orgDlvrcAmt));
	 								orgDlvrcAmt = 0;
	 							}
 							} */
							//합계정보
							var payGoodsAmt = parseInt(data.claimRefund.goodsAmt);
							$("#claimAcceptForm #pay_goods_amt").html(validation.num(payGoodsAmt));
							var payCpDcAmt = parseInt(data.claimRefund.cpDcAmt) + parseInt(data.claimRefund.cartCpDcAmt);
							$("#claimAcceptForm #pay_cp_amt").html(validation.num(payCpDcAmt * -1));
							
							$("#claimAcceptForm #reduce_cp_amt").html(validation.num(payCpDcAmt));
							
							var payDlvrAmt = parseInt(data.claimRefund.refundDlvrAmt);
							$("#claimAcceptForm #pay_dlvr_amt").html(validation.num(payDlvrAmt));
							
							$("#claimAcceptForm #refund_total_pay").html(validation.num(payGoodsAmt - payCpDcAmt + payDlvrAmt));
							
							var reduceDlvrAmt = parseInt(data.claimRefund.reduceDlvrcAmt * -1);
							$("#claimAcceptForm #reduce_dlvr_amt").html(validation.num(reduceDlvrAmt));
							var reduceAddDlvrAmt = parseInt(data.claimRefund.clmDlvrcAmt * -1);
							$("#claimAcceptForm #reduce_add_dlvr_amt").html(validation.num(reduceAddDlvrAmt));
							
							$("#claimAcceptForm #refund_total_reduce").html(validation.num(reduceDlvrAmt + reduceAddDlvrAmt));
							
							var totalAmt = parseInt(data.claimRefund.totAmt);
							$("#claimAcceptForm #refund_total_refund").html(validation.num(totalAmt));
							
							// 금액 초기화 및 수단별 금액 계산
							$("#claimAcceptForm #refund_pay_amt").html(0);
							$("#claimAcceptForm #refund_pnt_amt").html(0);
							$("#claimAcceptForm #refund_mp_pnt_amt").html(0);
							$("#minus_pay_amt_nm").html("");
							$("#minus_pay_amt").html("");
							
							var refundPayAmt = 0;
							var refundPntAmt = 0;
							
 							jQuery.each(data.claimRefund.meansList, function(i, payMeans){
 								if(payMeans.payMeansCd == '${adminConstants.PAY_MEANS_80}'){
 									refundPntAmt += payMeans.refundAmt;
 									$("#claimAcceptForm #refund_pnt_amt").html(validation.num(payMeans.refundAmt));
 								}else if(payMeans.payMeansCd == '${adminConstants.PAY_MEANS_81}'){
 									refundPntAmt += payMeans.refundAmt;
 									$("#claimAcceptForm #refund_mp_pnt_amt").html(validation.num(payMeans.refundAmt));
 								}else{
 									refundPayAmt += payMeans.refundAmt;
 									$("#claimAcceptForm #refund_pay_amt").html(validation.num(payMeans.refundAmt));
 									if(payMeans.meansNm != null){
 										$("#claimAcceptForm #meansNm").html(payMeans.meansNm +" 환불");
 									} else {
 										$("#claimAcceptForm #meansNm").html("환불");
 									}
 								}
 							});	
							
 							$("#claimAcceptForm #refund_save_pnt").html("");
 							// 최종 환불 금액
 							$("#claimAcceptForm #cancel_pay_amt").val(data.claimRefund.totAmt);
 							
 							// 마이너스 환불 표시
 							var minusRefund = data.claimRefund.totAmt - (refundPayAmt+refundPntAmt);
 							if(data.claimRefund.totAmt < 0){
 								$("#claimAcceptForm #meansNm").html("환불");
 								$("#claimAcceptForm #refund_pay_amt").html(validation.num(data.claimRefund.totAmt));
 							}else if( minusRefund > 0){
 								$("#minus_pay_amt_nm").html("마이너스 환불");
 								$("#minus_pay_amt").html(validation.num(minusRefund));
 							}else{
 								$("#minus_pay_amt_nm").html("");
 								$("#minus_pay_amt").html("");
 							}
						}
		 			};

 					ajax.call(options);
				}
			}
			</c:if>
			
			// 주문 취소 실행
			function fnClaimAcceptExec() {
				
				if($("#twcTckt").val().trim() == ""){
					messager.alert( "CS 티켓 번호를 입력해 주세요.", "Info", "info", function() {
						$("#twcTckt").focus()
					});
					return; 
				}
				
				var confirmMsg;
				
				<c:if test="${orderBase.ordStatCd ne adminConstants.ORD_STAT_10}">
				var payAmt = parseInt($("#claimAcceptForm #cancel_pay_amt").val());
				if(payAmt < 0){
					confirmMsg = "마이너스 환불금이 발생합니다. 그래도 취소 처리 하시겠습니까?";
				}
				</c:if>
				
				<c:if test="${orderBase.ordStatCd eq adminConstants.ORD_STAT_20 and orderBase.payMeansCd eq adminConstants.PAY_MEANS_30 }">
					if($("#claimAcceptForm #cetifyYn").val() == 'N'){
						messager.alert("환불계좌인증이 필요합니다.", "Info", "info", function(){
							$("#claimAcceptForm #certifyBtn").focus();
						});
						return;
					}
				</c:if>
				
				if(!confirmMsg){
					confirmMsg = '<spring:message code="column.order_common.confirm.order_cancel" />';
				}
				messager.confirm(confirmMsg, function(r){
					if(r){
						var options = {
		 					url : "<spring:url value='/claim/claimCancelExc.do' />"
		 					, data :  $("#claimAcceptForm").serializeJson()
	 						, callBack : function(data){
	 							messager.alert( "<spring:message code="column.common.cancel.final_msg" />", "Info", "info", function(){
	 								document.location.reload();
									layer.close('claimCancelAcceptView');
								});		
	 							$(".panel-tool-close").click(function(){
	 								document.location.reload();
									layer.close('claimCancelAcceptView');
	 							})
							}
			 			};

	 					ajax.call(options);
	 				}
				});
			}
			
			function certifyAcctNo(){
				
				var isBankCd = $("#claimAcceptForm #bankCd").validationEngine("validate");
				var isOoaNm = $("#claimAcceptForm #ooaNm").validationEngine("validate");
				var isAcctNo = $("#claimAcceptForm #acctNo").validationEngine("validate");
				
				if(!isBankCd  && !isOoaNm && !isAcctNo ){
					var options = {
	 					url : "<spring:url value='/common/reqCheckBankAccount.do' />"
	 					, data :  {
	 						bankCd : $("#claimAcceptForm #bankCd").val()
	 						,ooaNm : $("#claimAcceptForm #ooaNm").val()
	 						,acctNo : $("#claimAcceptForm #acctNo").val()
	 					}
						, callBack : function(data){
							console.log('data', data);
							if(!data.isOk){
								messager.alert(data.res.resultMsg, "Info", "info", function(){
									return;
								});
								$("#claimAcceptForm #cetifyYn").val("N");
							}else{
								messager.alert("계좌 인증을 성공하였습니다.", "Info", "info", function(){
									return;
								});
								$("#claimAcceptForm #cetifyYn").val("Y");
							}
							
						}
		 			};

					ajax.call(options);
				}
				
			}
		</script>

		<form id="claimAcceptForm" name="claimAcceptForm" method="post" >
			<input type="hidden" name="ordNo" id="ordNo" value="${orderBase.ordNo}">
			<input type="hidden" id="cancel_pay_amt" value="0" />

			<div class="mTitle">
				<h2><spring:message code="column.order_common.order_info" /></h2>
			</div>

			<table class="table_type1">
				<caption><spring:message code="column.order_common.order_info" /></caption>
				<colgroup>
					<col class="th-s" />
					<col class="th-s" />
					<col class="th-s" />
					<col />
					<col class="th-s" />
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><spring:message code="column.ord_no" /></th>
						<td colspan="5">
							${orderBase.ordNo}
						</td>
					</tr>
					<c:forEach items="${listOrderDetail}" var="getOrderDetail" varStatus="idx" >
					<tr>
						<th scope="row"><spring:message code="column.ord_dtl_seq" /></th>
						<td>
							<c:if test="${orderBase.ordStatCd ne adminConstants.ORD_STAT_10}">
								<input type="hidden" name="arrOrdDtlSeq" id="arrOrdDtlSeq" value="${getOrderDetail.ordDtlSeq}">
							</c:if>
							${getOrderDetail.ordDtlSeq}
						</td>
						<th scope="row"><spring:message code="column.goods_nm" /></th>
						<td>
							${getOrderDetail.goodsNm}
						</td>
						<th scope="row"><spring:message code="column.accept_qty" /></th>
						<td>
							<c:choose>
								<c:when test="${orderBase.ordStatCd ne adminConstants.ORD_STAT_10}">
								<select name="arrClmQty" id="arrClmQty">
									<c:forEach begin="1" end="${getOrderDetail.rmnOrdQty}" var="qty">
									<option value="${qty}" <c:if test="${getOrderDetail.rmnOrdQty eq  qty}">selected="selected"</c:if>>${qty}</option>
									</c:forEach>
								</select>
								</c:when>
								<c:otherwise>
								<input type="hidden" id="arrClmQty" name="arrClmQty" value="${getOrderDetail.rmnOrdQty}" />
								${getOrderDetail.rmnOrdQty}
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					</c:forEach>
					<tr>
						<th scope="row"><spring:message code="column.clm_rsn_cd" /><strong class="red">*</strong></th>
						<td colspan="5">
							<select id="clmRsnCd" name="clmRsnCd" title="선택상자" >
								<c:forEach items="${clmRsnList}" var="clmRsn">
									<c:if test="${clmRsn.dtlCd ne adminConstants.CLM_RSN_190}">
									<option value="${clmRsn.dtlCd }" data-grp="${clmRsn.usrDfn2Val }">
										${clmRsn.dtlNm}
										( 귀책 :
									<c:if test="${clmRsn.usrDfn2Val eq adminConstants.RSP_RSN_10}">
										고객										
									</c:if>
									<c:if test="${clmRsn.usrDfn2Val eq adminConstants.RSP_RSN_20}">
										업체
									</c:if>
										)
									</option>
									</c:if>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row" id="clmRsnContentText"><spring:message code="column.claim_common.claim_rsn_detail_content" /></th>
						<td colspan="5">
							<textarea cols="30" rows="3" style="width:95%;" id="clmRsnContent" name="clmRsnContent" class="validate[maxSize[500]]"></textarea>
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="column.claim_common.cs_tck_no" /><strong class="red">*</strong></th>
						<td colspan="5">
							<input type="text" class="validate[required,maxSize[100]]" name="twcTckt" id="twcTckt" title="<spring:message code="column.claim_common.cs_tck_no" />" value="" />
						</td>
					</tr>
				</tbody>
			</table>

<c:if test="${orderBase.ordStatCd ne adminConstants.ORD_STAT_10}">
			<div class="mTitle mt30">
				<h2><spring:message code="column.order_common.refund_amt_info" /></h2>
			</div>
			<table class="table_type1">
				<caption><spring:message code="column.order_common.refund_info" /></caption>
				<colgroup>
					<col class="th-s" />
					<col />
					<col class="th-s" />
					<col />
					<col class="th-s" />
					<col />
				</colgroup>
				<thead>
					<tr>
						<th colspan="2" class="fontbold" style="border-right:#666 solid 1px;">결제정보</th>
						<th colspan="2" class="fontbold" style="border-right:#666 solid 1px;">차감정보</th>
						<th colspan="2" class="fontbold" style="border-right:#666 solid 1px;">환불정보</th>
					</tr>
				</thead>
				<tbody>			
					<tr>
						<td colspan="2" class="right fontbold" id="refund_total_pay" style="border-right:#666 solid 1px;"></td>
						<td colspan="2" class="right fontbold" id="refund_total_reduce" style="border-right:#666 solid 1px;"></td>
						<td colspan="2" class="right fontbold" id="refund_total_refund" style="border-right:#666 solid 1px;"></td>
					</tr>
					<tr>
						<th scope="row">상품금액</th>
						<td id="pay_goods_amt" class="right" style="border-right:#666 solid 1px;">
						</td>
						<th scope="row">배송비</th>
						<td id="reduce_dlvr_amt" class="right" style="border-right:#666 solid 1px;">
						</td>
						<th scope="row" id="meansNm"> 환불</th>
						<td id="refund_pay_amt" class="right" style="border-right:#666 solid 1px;">
						</td>
					</tr>
					<tr>
						<th scope="row">배송비</th>
						<td id="pay_dlvr_amt" class="right" style="border-right:#666 solid 1px;">
						</td>
						<th scope="row">추가배송비</th>
						<td id="reduce_add_dlvr_amt" class="right" style="border-right:#666 solid 1px;">
						</td>
						<th scope="row">GS 포인트 환불</th>
						<td id="refund_pnt_amt" class="right" style="border-right:#666 solid 1px;">
							0
						</td>
					</tr>
					<tr>
						<th scope="row">쿠폰할인금액</th>
						<td id="pay_cp_amt" class="right" style="border-right:#666 solid 1px;">
						</td>
						<th scope="row"></th>
						<td  style="border-right:#666 solid 1px;"></td>
						</td>
						<th scope="row">우주코인 환불</th>
						<td id="refund_mp_pnt_amt" class="right" style="border-right:#666 solid 1px;">
							0
						</td>
					</tr>
					<tr>
						<th scope="row"></th>
						<td  style="border-right:#666 solid 1px;"></td>
						<th scope="row"></th>
						<td  style="border-right:#666 solid 1px;"></td>
						<th id="minus_pay_amt_nm"></th>
						<td id="minus_pay_amt" class="right" style="border-right:#666 solid 1px;"> </td>
					</tr>
				</tbody>
			</table>
			
</c:if>

<c:if test="${orderBase.ordStatCd eq adminConstants.ORD_STAT_20 and orderBase.payMeansCd eq adminConstants.PAY_MEANS_30 }">
			<input type="hidden" id="cetifyYn" value="N"/>
			<div class="mTitle mt30">
				<h2><spring:message code="column.order_common.refund_info" /></h2>
			</div>
			<table class="table_type1">
				<caption><spring:message code="column.order_common.refund_info" /></caption>
				<colgroup>
					<col class="th-s" />
					<col />
					<col class="th-s" />
					<col />
					<col class="th-s" />
					<col />
				</colgroup>
				<tbody>			
					<tr>
						<th scope="row"><spring:message code="column.order_common.refund_bank" /><strong class="red">*</strong></th>
						<td>
							<select name="bankCd" id="bankCd" class="validate[required]" title="선택상자"  >
								<frame:select grpCd="${adminConstants.BANK }"  selectKey="${memberBase.bankCd}" />
							</select>
						</td>
						<th scope="row"><spring:message code="column.order_common.refund_name" /><strong class="red">*</strong></th>
						<td>
							<input type="text" class="validate[required, maxSize[50]] wth50" id="ooaNm" name="ooaNm" value="${memberBase.mbrNm}">
						</td>
						<th scope="row"><spring:message code="column.order_common.refund_account" /><strong class="red">*</strong></th>
						<td>
							<input type="text" class="validate[required, maxSize[50]] w100" id="acctNo" name="acctNo" value="${memberBase.acctNo}">
							<button type="button" id="certifyBtn" onclick="certifyAcctNo();" class="btn btn-ok"><spring:message code="column.order_common.certify_acctNo" /></button>
						</td>
					</tr>
				</tbody>
			</table>
</c:if>
			</form>
			

