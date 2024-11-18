<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">

			$(document).ready(function(){
				$("input:radio[name=isuMeansCd]").eq(1).prop("disabled", true);
			});

			// 현금 영수증 접수 실행
			function fnCashReceiptAcceptExec() {

				if ( validate.check("cashAcceptForm") ) {
					
					messager.confirm('<spring:message code="column.order_common.confirm.tax_cash_accept" />',function(r){
						if(r){
							var options = {
								url : "<spring:url value='/tax/cashReceiptAcceptExec.do' />"
								, data : $("#cashAcceptForm").serializeJson()
								, callBack : function(result){
									messager.alert('<spring:message code="column.common.accept.final_msg" />', "Info", "info", function(){
										reloadOrderListGrid();
										layer.close('taxInvoiceAcceptView');
									});
								}
							};

							ajax.call(options);
						}
					});
				}

			}

			// 우편번호 : 콜백
			function fnCallBackPostNo(result) {

				// ====================================================================================
				// http://postcode.map.daum.net/guide 참조
				// zonecode : 우편번호
				// address : 기본주소
				// addressEnglish : 기본 영문 주소
				// roadAddress : 도로명 주소
				// roadAddress : 영문 도로명 주소
				// jibunAddress : 지번 주소
				// jibunAddressEnglish : 영문 지번 주소
				// postcode : 구 우편번호
				// ====================================================================================

				var reg_zipcode = result.postcode.split("-");

				// 구 우편번호
				$("#postNoOld").val( reg_zipcode[0] + reg_zipcode[1] );

				// 신 우편번호
				$("#postNoNew").val(result.zonecode);

				// 지번 주소
				$("#prclAddr").val(result.jibunAddress);

				// 도로명 주소
				$("#roadAddr").val(result.roadAddress);

				// 도로명 상세주소
				$("#roadDtlAddr").focus();

			}

		</script>
	
				<form id="cashAcceptForm" name="cashAcceptForm" method="post" >
					<input type="hidden" name="ordNo" id="ordNo" value="${orderSO.ordNo}">
					<c:forEach items="${orderSO.arrOrdDtlSeq}" var="item">
						<input type="hidden" name="arrOrdDtlSeq" id="arrOrdDtlSeq" value="${item}">
					</c:forEach>

				<table class="table_type1">
					<caption>글 정보보기</caption>
					<tbody>
						<tr>
							<th scope="row"><spring:message code="column.ord_no" /></th>
							<td colspan="3">
								${orderSO.ordNo}
							</td>
<%-- 							<th scope="row"><spring:message code="column.ord_dtl_seq" /></th> --%>
<!-- 							<td> -->
<%-- 								<c:forEach items="${orderSO.arrOrdDtlSeq}" var="ordDtlSeq" varStatus="idx" > --%>
<%-- 									<c:if test="${idx.index > 0}"> --%>
<!-- 									, -->
<%-- 									</c:if> --%>
<%-- 									${ordDtlSeq} --%>
<%-- 		  						</c:forEach> --%>
<!-- 							</td> -->
						</tr>
<!-- 						<tr> -->
<!-- 							신청자 구분 코드 -->
<%-- 							<th scope="row"><spring:message code="column.apct_gb_cd" /><strong class="red">*</strong></th> --%>
<!-- 							<td colspan="3"> -->
<%-- 								<label class="fRadio"><input type="radio" name="apctGbCd" value="${adminConstants.APCT_GB_01}" checked="checked"> <span><frame:codeName grpCd="${adminConstants.APCT_GB}" dtlCd="${adminConstants.APCT_GB_01}"/> </span></label> --%>
<%-- 								<label class="fRadio"><input type="radio" name="apctGbCd" value="${adminConstants.APCT_GB_02}"> <span><frame:codeName grpCd="${adminConstants.APCT_GB}" dtlCd="${adminConstants.APCT_GB_02}"/> </span></label> --%>
<!-- 							</td> -->
<!-- 						</tr> -->

						<tr>
							<th><spring:message code="column.comp_nm"/><strong class="red">*</strong></th>
							<td>
								<!-- 업체 명-->
								<input type="text" class="" name="compNm" id="compNm" title="<spring:message code="column.comp_nm"/>" value="" />
							</td>
							<th><spring:message code="column.ceo_nm"/><strong class="red">*</strong></th>
							<td>
								<!-- 대표자 명-->
								<input type="text" class="" name="ceoNm" id="ceoNm" title="<spring:message code="column.ceo_nm"/>" value="" />
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.biz_tp"/><strong class="red">*</strong></th>
							<td>
								<!-- 종목-->
								<input type="text" class="" name="bizTp" id="bizTp" title="<spring:message code="column.biz_tp"/>" value="" />
							</td>
							<th><spring:message code="column.biz_cdts"/><strong class="red">*</strong></th>
							<td>
								<!-- 업태-->
								<select class="" name="bizCdts" id="bizCdts" title="<spring:message code="column.biz_cdts"/>">
									<frame:select grpCd="${adminConstants.BIZ}" />
								</select>
							</td>
						</tr>

						<tr>
							<th><spring:message code="column.biz_no"/><strong class="red">*</strong></th>
							<td colspan="3">
								<!-- 사업자 번호-->
								<input type="text" class="" name="bizNo" id="bizNo" title="<spring:message code="column.biz_no"/>" value="" />
							</td>
						</tr>

						<tr>
							<!-- 주소 -->
							<th scope="row"><spring:message code="column.addr" /><strong class="red">*</strong></th>
							<td colspan="3">
								<input type="hidden" name="prclAddr"	id="prclAddr"		value="${delivery.prclAddr}">
								<input type="hidden" name="prclDtlAddr" id="prclDtlAddr" 	value="${delivery.prclDtlAddr}">
								<input type="hidden" name="postNoOld"	id="postNoOld"		value="${delivery.postNoOld}">
								* 도로명주소<br>
								<div class="mg5">
									<input type="text" class="ml5 readonly w50 validate[maxSize[6]]" name="postNoNew" id="postNoNew" value="${delivery.postNoNew}" readonly="readonly">
									<button type="button" onclick="layer.post(fnCallBackPostNo);" class="btn">주소검색</button>
								</div>
								<div class="mg5">
									<input type="text" class="ml5 readonly w180 validate[maxSize[100]]" name="roadAddr" id="roadAddr" value="${delivery.roadAddr}" readonly="readonly">
									<input type="text" class="w180 validate[required, maxSize[100]]" name="roadDtlAddr" id="roadDtlAddr" value="${delivery.roadDtlAddr}">
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				</form>

			

