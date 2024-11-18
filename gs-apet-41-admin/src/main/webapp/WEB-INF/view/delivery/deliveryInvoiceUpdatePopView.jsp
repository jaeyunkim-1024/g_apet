<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">

			$(document).ready(function(){
			});

			// 송장 건별 수정 실행
			function fnDeliveryInvoiceUpdateExec() {

				if ( $("select[name=hdcCd]").val() == "" ) {
					messager.alert( "택배사를 선택하세요." ,"Info","info");
					return;
				}

				if ( validate.check("deliveryForm") ) {
					messager.confirm("<spring:message code='column.common.confirm.update' />",function(r){
						if(r){
							var options = {
								url : "<spring:url value='/delivery/deliveryInvoiceUpdateExec.do' />"
								, data : $("#deliveryForm").serializeJson()
								, callBack : function(result){
									messager.alert( '<spring:message code="column.common.edit.final_msg" />' ,"Info","info");
									reloadOrderListGrid();
									layer.close('deliveryInvoiceUpdateView');
								}
							};

							ajax.call(options);
						}
					});
				}
			}

		</script>
	
				<form id="deliveryForm" name="deliveryForm" method="post" >
					<input type="hidden" name="dlvrNo" id="dlvrNo" value="${delivery.dlvrNo}">

				<table class="table_type1 popup">
					<caption>글 정보보기</caption>
					<tbody>
						<tr>
							<th scope="row"><spring:message code="column.ord_no" /></th>
							<td>
								${delivery.ordNo}
							</td>
							<th scope="row"><spring:message code="column.dlvr_no" /></th>
							<td>
								${delivery.dlvrNo}
							</td>
						</tr>

						<tr>
							<th scope="row"><spring:message code="column.ord_clm_gb_cd" /></th>
							<td>
								<frame:codeName grpCd="${adminConstants.ORD_CLM_GB}" dtlCd="${delivery.ordClmGbCd}"/>    
							</td>
							<th scope="row"><spring:message code="column.dlvr_prcs_tp_cd" /></th>
							<td>
								<frame:codeName grpCd="${adminConstants.DLVR_PRCS_TP}" dtlCd="${delivery.dlvrPrcsTpCd}"/>
							</td>
						</tr>
						
						<tr>
							<th><spring:message code="column.hdc_cd"/><strong class="red">*</strong></th>
							<td>
								<!-- 택배사 코드 -->
								<select class="" name="hdcCd" id="hdcCd" title="<spring:message code="column.hdc_cd"/>">
									<frame:select grpCd="${adminConstants.HDC}" useYn="Y" selectKey="${delivery.hdcCd }" defaultName="선택하세요" />
								</select>
							</td>
							<th><spring:message code="column.inv_no"/><strong class="red">*</strong></th>
							<td>
								<!-- 송장 번호 -->
								<input type="text" class="validate[required]" name="invNo" id="invNo" title="<spring:message code="column.inv_no"/>" value="${delivery.invNo }" />
							</td>
						</tr>

					</tbody>
				</table>
				</form>

