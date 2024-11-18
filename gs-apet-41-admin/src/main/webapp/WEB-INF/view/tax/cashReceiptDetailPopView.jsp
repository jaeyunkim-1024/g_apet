<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">

			if ( '${cashReceipt}' == '' ) {
				messager.alert( "등록된 현금영수증이 없습니다." ,"Info","info");
				layer.close('cashReceiptDetailView');
			}

			$(document).ready(function(){

				// 승인
// 				if ( '${cashReceipt.cashRctStatCd}' == '${adminConstants.CASH_RCT_STAT_20}' &&
// 						'${cashReceipt.isuGbCd}' == '${adminConstants.ISU_GB_20}' ) {
// 					$("select[name=useGbCd]").prop("disabled", true);
// 					$("input:text[name=isuMeansNo]").prop("disabled", true);
// 				}

			});

			// 현금 영수증 재발행 실행
			function fnCashReceiptRePublishExec() {

				if ( validate.check("cashReceiptForm") ) {
					messager.confirm('<spring:message code="column.order_common.confirm.tax_cash_republish" />',function(r){
						if(r){
							var options = {
								url : "<spring:url value='/tax/cashReceiptRePublishExec.do' />"
								, data : $("#cashReceiptForm").serializeJson()
								, callBack : function(result){
									messager.alert('<spring:message code="column.common.publish.final_msg" />', "Info", "info", function(){
										reloadOrderListGrid();
										layer.close('cashReceiptDetailView');
									});
									
								}
							};

							ajax.call(options);
						}
					});
				}

			}
			// 결제 '${cashReceipt.lnkDealNo}','${cashReceipt.cashReceiptUrl}'
			function fnCashReceipt(lnkDealNo,cashReceipt) {
				var config = {
						  url : cashReceipt
						, width : '430'
						, height : '530'
						, target : lnkDealNo
						, scrollbars : 'no'
						, resizable : 'no'
						, location : 'no'
						, menubar : 'no'
					};
					openWindowPop(config);  
			}
			

		</script>
	
				<form id="cashReceiptForm" name="cashReceiptForm" method="post" >
					<input type="hidden" name="ordNo" id="ordNo" value="${orderSO.ordNo}">
					<input type="hidden" name="cashRctNo" id="cashRctNo" value="${cashReceipt.cashRctNo}">

				<table class="table_type1">
					<caption>글 정보보기</caption>
					<tbody>
						<tr>
							<th scope="row"><spring:message code="column.ord_no" /></th>
							<td>
								${cashReceipt.ordNo}
							</td>
							<th><spring:message code="column.cr_tp_cd"/></th>
							<td>
								<!-- 현금 영수증 발행 유형 코드-->
								<frame:codeName grpCd="${adminConstants.CR_TP }" dtlCd="${cashReceipt.crTpCd }" />
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.cash_rct_stat_cd"/></th>
							<td>
								<!-- 현금 영수증 상태 코드-->
<%-- 								<select class="" name="cashRctStatCd" id="cashRctStatCd" title="<spring:message code="column.cash_rct_stat_cd"/>"> --%>
<%-- 									<frame:select grpCd="${adminConstants.CASH_RCT_STAT}" /> --%>
<!-- 								</select> -->
<%-- 									${cashReceipt.cashRctStatCd} --%>
									<frame:codeName grpCd="${adminConstants.CASH_RCT_STAT }" dtlCd="${cashReceipt.cashRctStatCd }" />
							</td>
							<th><spring:message code="column.isu_gb_cd"/></th>
							<td>
								<!-- 발행 구분 코드-->
<%-- 								<select class="" name="isuGbCd" id="isuGbCd" title="<spring:message code="column.isu_gb_cd"/>"> --%>
<%-- 									<frame:select grpCd="${adminConstants.ISU_GB}" /> --%>
<!-- 								</select> -->
<%-- 								${cashReceipt.isuGbCd} --%>
								<frame:codeName grpCd="${adminConstants.ISU_GB }" dtlCd="${cashReceipt.isuGbCd }" />
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.use_gb_cd"/><strong class="red">*</strong></th>
							<td>
								<!-- 사용 구분 코드-->
								<frame:codeName grpCd="${adminConstants.USE_GB }" dtlCd="${cashReceipt.useGbCd }" />
								<%-- <c:if test="${ cashReceipt.crTpCd eq adminConstants.CR_TP_10 and cashReceipt.cashRctStatCd ne adminConstants.CASH_RCT_STAT_30}">
									<select class="" name="useGbCd" id="useGbCd" title="<spring:message code="column.use_gb_cd"/>">
										<frame:select grpCd="${adminConstants.USE_GB}" selectKey="${cashReceipt.useGbCd }"/>										
									</select>									
								</c:if>
								<c:if test="${ (cashReceipt.crTpCd eq adminConstants.CR_TP_10 and cashReceipt.cashRctStatCd eq adminConstants.CASH_RCT_STAT_30)
									or cashReceipt.crTpCd eq adminConstants.CR_TP_20}">
									<frame:codeName grpCd="${adminConstants.USE_GB }" dtlCd="${cashReceipt.useGbCd }" />
								</c:if> --%>
							</td>
							<th><spring:message code="column.isu_means_cd"/></th>
							<td>
								<!-- 발급 수단 코드-->
								<frame:codeName grpCd="${adminConstants.ISU_MEANS }" dtlCd="${cashReceipt.isuMeansCd }" />
								<%-- <c:if test="${ cashReceipt.crTpCd eq adminConstants.CR_TP_10 and cashReceipt.cashRctStatCd ne adminConstants.CASH_RCT_STAT_30}">
									<select class="" name="isuMeansCd" id="isuMeansCd" title="<spring:message code="column.isu_means_cd"/>">
										<frame:select grpCd="${adminConstants.ISU_MEANS}" selectKey="${cashReceipt.isuMeansCd }"/>										
									</select>									
								</c:if>
								<c:if test="${ (cashReceipt.crTpCd eq adminConstants.CR_TP_10 and cashReceipt.cashRctStatCd eq adminConstants.CASH_RCT_STAT_30)
									or cashReceipt.crTpCd eq adminConstants.CR_TP_20}">
									<frame:codeName grpCd="${adminConstants.ISU_MEANS }" dtlCd="${cashReceipt.isuMeansCd }" />
								</c:if> --%>
								
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.isu_means_no"/><strong class="red">*</strong></th>
							<td colspan="3">
								<!-- 발급 수단 번호-->
								<%-- <input type="text" class="phoneNumber validate[required]" name="isuMeansNo" id="isuMeansNo" title="<spring:message code="column.isu_means_no"/>" value="${cashReceipt.isuMeansNo}" /> --%>
								${cashReceipt.isuMeansNo}
							</td>
							<!-- 
							<th><spring:message code="column.cash_rct_stat_cd"/></th>
							<td><%-- ${ cashReceipt.lnkDealNo},${ cashReceipt.cashReceiptUrl} --%>
								<c:if test="${ cashReceipt.cashReceiptUrl ne '' }">
									<button type="button" class="btn_type1" onclick="fnCashReceipt('${cashReceipt.lnkDealNo}','${cashReceipt.cashReceiptUrl}');"><spring:message code="column.order_common.btn.cash_view" /></button>
								</c:if>
							</td>
							 -->
						</tr>
						<tr>
							<th><spring:message code="column.spl_amt"/></th>
							<td>
								<!-- 공급 금액-->
								<%-- <input type="text" class="numeric" name="splAmt" id="splAmt" title="<spring:message code="column.spl_amt"/>" value="${cashReceipt.splAmt}" />원 --%>
								<fmt:formatNumber value="${cashReceipt.splAmt}" type="number" pattern="#,###,###"/>원
							</td>
							<th><spring:message code="column.stax_amt"/></th>
							<td>
								<!-- 부가세 금액-->
								<%-- <input type="text" class="numeric" name="staxAmt" id="staxAmt" title="<spring:message code="column.stax_amt"/>" value="${cashReceipt.staxAmt}" />원 --%>
								<fmt:formatNumber value="${cashReceipt.staxAmt}" type="number" pattern="#,###,###"/>원
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.lnk_dtm"/></th>
							<td colspan="3">
								<!-- 연동 일시-->																
								<fmt:formatDate value="${cashReceipt.lnkDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
								
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.lnk_deal_no"/></th>
							<td colspan="3">
								<!-- 연동 거래 번호-->
								${cashReceipt.lnkDealNo}
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.lnk_rst_msg"/></th>
							<td colspan="3">
								<!-- 연동 결과 메세지-->
								${cashReceipt.lnkRstMsg}
							</td>
						</tr>

					</tbody>
				</table>
				</form>


