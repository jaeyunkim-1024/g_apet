<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">

			$(document).ready(function(){
			});

			// 송장 건별 등록 실행
			function fnDeliveryInvoiceOneCreateExec() {
				// 택배사 코드 체크
				if ( $("#hdcCd").val() == "" ) {
					messager.alert( "택배사를 선택하세요." ,"Info","info");
					return;
				}

				if ( validate.check("deliveryInvcOneForm") ) {
					messager.confirm("<spring:message code="column.order_common.confirm.delivery_one_create" />",function(r){
						if(r){
							console.log('deliveryInvcOneForm.dlvrNo.value='+deliveryInvcOneForm.dlvrNo.value);
							console.log('$("#exe_dlvr_no").html()='+$("#exe_dlvr_no").html());
							if(deliveryInvcOneForm.dlvrNo.value == null || deliveryInvcOneForm.dlvrNo.value == ""){
								deliveryInvcOneForm.dlvrNo.value = $("#exe_dlvr_no").html();
								console.log('deliveryInvcOneForm.dlvrNo.value='+deliveryInvcOneForm.dlvrNo.value);
							}
							var options = {
								url : "<spring:url value='/delivery/deliveryInvoiceOneCreateExec.do' />"
								, data : $("#deliveryInvcOneForm").serializeJson()
								, callBack : function(result){
									messager.alert( '<spring:message code="column.common.regist.final_msg" />' ,"Info","info");
									reloadOrderListGrid();
									layer.close('deliveryInvoiceOneCreateView');
								}
							};

							ajax.call(options);
						}
					});
				}
			}

		</script>
	
				<form id="deliveryInvcOneForm" name="deliveryInvcOneForm" method="post" >
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
							<td id="exe_dlvr_no">${delivery.dlvrNo}</td>
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
									<frame:select grpCd="${adminConstants.HDC}" useYn="Y" selectKey="${delivery.dftHdcCd }" defaultName="선택하세요" />
								</select>
							</td>
							<th><spring:message code="column.inv_no"/><strong class="red">*</strong></th>
							<td>
								<!-- 송장 번호 -->
								<input type="text" class="validate[required, maxSize[30]]" name="invNo" id="invNo" title="<spring:message code="column.inv_no"/>" value="" autocomplete="off" />
								<br/>
								* 송장번호가 여러개인 경우 콤마","로 구분해서 입력해 주세요. 
							</td>
						</tr>

					</tbody>
				</table>
				</form>


