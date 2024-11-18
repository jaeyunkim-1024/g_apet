<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">
			
			$(document).ready(function(){
			
			});
	
			$(function(){

			});
			
			// 반품 거부 실행
			function fnClaimReturnRefuseExec() {

				if ( validate.check("claimReturnRefuseForm") ) {
					
					messager.confirm('<spring:message code="column.order_common.confirm.claim_return_product_rejection_final" />',function(r){
						if(r){
							var options = {
		 						url : "<spring:url value='/claim/claimProductRejectionFinal.do' />"
		 						, data : $("#claimReturnRefuseForm").serializeJson()
		 						, callBack : function(data) {
		 							alert( "<spring:message code='column.common.process.final_msg' />" );
		 							
		 							if ($("#clmReturnList").length > 0) {
			 							reloadOrderListGrid();
		 							} else if ($("#claimIntegrateList").length > 0) {
			 							reloadIntegrateListGrid();
		 							}
		 							
		 							layer.close('claimReturnRefuseView');
		 						}
		 					};

		 					ajax.call(options);
//							messager.alert( "반품 거부 프로세스 변경 중" ,"Info","info");
						}
					});

				}

			}
			
		</script>
		<form id="claimReturnRefuseForm" name="claimReturnRefuseForm" method="post" >
			<input type="hidden" name="clmNo" id="clmNo" value="${claimBase.clmNo}">

			<table class="table_type1">
				<caption>글 정보보기</caption>
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
						<th scope="row"><spring:message code="column.clm_no" /></th>
						<td colspan="3">
							${claimBase.clmNo}
						</td>
						<th scope="row"><spring:message code="column.ord_no" /></th>
						<td>
							${claimBase.ordNo}
						</td>
					</tr>
					<c:forEach items="${listClaimDetail}" var="claimDetail" varStatus="idx" >
					<tr>
						<th scope="row""><spring:message code="column.ord_dtl_seq" /></th>
						<td>
							<input type="hidden" name="arrClmDtlSeq" value="${claimDetail.clmDtlSeq}">
							${claimDetail.clmDtlSeq}
						</td>
						<th scope="row"><spring:message code="column.goods_nm" /></th>
						<td>
							${claimDetail.goodsNm}
						</td>
						<th scope="row"><spring:message code="column.refuse_qty" /></th>
						<td>
							${claimDetail.clmQty}
							<%-- <select name="arrRefuseQty">
								<c:forEach begin="1" end="${claimDetail.clmQty}" var="qty">
								<option value="${qty}" <c:if test="${claimDetail.clmQty eq  qty}">selected="selected"</c:if>>${qty}</option>
								</c:forEach>
							</select> --%>
						</td>
					</tr>
					</c:forEach>
					<tr>
						<th scope="row"><spring:message code="column.clm_deny_rsn_content" /><strong class="red">*</strong></th>
						<td colspan="5">
							<textarea rows="2" name="clmDenyRsnContent" class="validate[required, maxSize[1000]]" style="width:97%"></textarea>
						</td>
					</tr>
				</tbody>
			</table>
				
			</form>
