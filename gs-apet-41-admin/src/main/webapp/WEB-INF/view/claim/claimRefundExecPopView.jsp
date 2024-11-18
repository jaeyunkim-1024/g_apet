<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">

			$(document).ready(function(){
				$("select[name=bankCd]").prop("disabled", true);
			});

			// 환불 실행
			function fnPopClaimRefundExec() {

				if ( validate.check("claimRefundForm") ) {
 					
					messager.confirm('<spring:message code="column.order_common.confirm.claim_refund_exec" />',function(r){
						if(r){
							var options = {
								url : "<spring:url value='/claim/claimRefundExec.do' />"
								, data : $("#claimRefundForm").serializeJson()
								, callBack : function(result){
									messager.alert( "<spring:message code='column.common.process.final_msg' />", "Info", "info", function(){
										reloadRefundListGrid();
										layer.close('claimRefundExecView');
									});
									
								}
							};

							ajax.call(options);
						}
					});
				}

			}

		</script>
				<form id="claimRefundForm" name="claimRefundForm" method="post" >
					<input type="hidden" name="cashRfdNo" id="cashRfdNo" value="${payCashRefund.cashRfdNo}">

				<table class="table_type1">
					<caption>글 정보보기</caption>
					<colgroup>
						<col class="th-s" />
						<col />
						<col class="th-s" />
						<col />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><spring:message code="column.cash_rfd_no" /></th>
							<td colspan="3">
								${payCashRefund.cashRfdNo} 
							</td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.order_common.refund_bank" /></th>
							<td colspan="3">
								<frame:codeName grpCd="${adminConstants.BANK}" dtlCd="${payCashRefund.bankCd}" />
							</td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.order_common.refund_account" /></th>
							<td colspan="3">
								${payCashRefund.acctNo}
							</td>
						</tr>
<!-- 						<tr> -->
<%-- 							<th scope="row"><spring:message code="column.order_common.schd_amt" /></th> --%>
<!-- 							<td colspan="3"> -->
<%--  								${payCashRefund.schdAmt} --%>
<!-- 							</td> -->
<!-- 						</tr> -->
						<tr>
							<th scope="row"><spring:message code="column.order_common.refund_amt" /></th>
							<td colspan="3">
 								<input type="hidden" name="rfdAmt" value="${payCashRefund.schdAmt}">
 								<fmt:formatNumber value="${payCashRefund.schdAmt}" type="number" pattern="#,###,###"/>원
							</td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.order_common.refund_memo" /></th>
							<td colspan="3">
 								<textarea class="validate[maxSize[2000]]" name="memo"></textarea>
							</td>
						</tr>

					</tbody>
				</table>
				</form>

	