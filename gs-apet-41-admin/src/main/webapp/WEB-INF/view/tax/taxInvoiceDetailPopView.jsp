<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">

			if ( '${taxInvoice}' == '' ) {
				messager.alert("등록된 세금계산서가 없습니다." ,"Info","info");
				layer.close('taxInvoiceDetailView');
			}

			$(document).ready(function(){

				// 승인
				if ( '${taxInvoice.taxIvcStatCd}' == '${adminConstants.CASH_RCT_STAT_20}' ) {
					$("input:text[name=compNm]").prop("disabled", true);
					$("input:text[name=ceoNm]").prop("disabled", true);
					$("input:text[name=bizCdts]").prop("disabled", true);
					$("input:text[name=bizTp]").prop("disabled", true);
					$("input:text[name=bizNo]").prop("disabled", true);
					$("input:text[name=roadDtlAddr]").prop("disabled", true);
				} else {
					$("input:text[name=compNm]").focus();
					$("#bizNo").mask("000-00-00000");
				}

			});

			// 세금 계산서 발행 실행
			function fnTaxInvoicePublishExec() {

				if ( validate.check("taxInvoiceForm") ) {
					
					messager.confirm('<spring:message code="column.order_common.confirm.tax_tax_publish" />',function(r){
						var options = {
								url : "<spring:url value='/tax/taxInvoicePublishExec.do' />"
								, data : $("#taxInvoiceForm").serializeJson()
								, callBack : function(result){
									messager.alert('<spring:message code="column.common.publish.final_msg" />', "Info", "info", function(){
										reloadOrderListGrid();
										layer.close('taxInvoiceDetailView');
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
	

				<form id="taxInvoiceForm" name="taxInvoiceForm" method="post" >
					<input type="hidden" name="ordNo" id="ordNo" value="${orderSO.ordNo}">

				<table class="table_type1">
					<caption>글 정보보기</caption>
					<tbody>
						<tr>
							<th scope="row"><spring:message code="column.ord_no" /></th>
							<td>
								${orderSO.ordNo}
							</td>
							<th><spring:message code="column.tax_ivc_stat_cd"/></th>
							<td>
								<!-- 세금 계산서 상태 코드-->
								<frame:codeName grpCd="${adminConstants.TAX_IVC_STAT }" dtlCd="${taxInvoice.taxIvcStatCd }"/>
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.comp_nm"/><strong class="red">*</strong></th>
							<td>
								<!-- 업체 명-->
								<input type="text" class="validate[required]" name="compNm" id="compNm" title="<spring:message code="column.comp_nm"/>" value="${taxInvoice.compNm }" />
							</td>
							<th><spring:message code="column.ceo_nm"/><strong class="red">*</strong></th>
							<td>
								<!-- 대표자 명-->
								<input type="text" class="validate[required]" name="ceoNm" id="ceoNm" title="<spring:message code="column.ceo_nm"/>" value="${taxInvoice.ceoNm }" />
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.biz_cdts"/><strong class="red">*</strong></th>
							<td>
								<!-- 업태-->
								<input type="text" class="validate[required]" name="bizCdts" id="bizCdts" title="<spring:message code="column.biz_cdts"/>" value="${taxInvoice.bizCdts }" />
							</td>
							<th><spring:message code="column.biz_tp"/><strong class="red">*</strong></th>
							<td>
								<!-- 종목-->
								<input type="text" class="validate[required]" name="bizTp" id="bizTp" title="<spring:message code="column.biz_tp"/>" value="${taxInvoice.bizTp }" />
							</td>
						</tr>

						<tr>
							<th><spring:message code="column.biz_no"/><strong class="red">*</strong></th>
							<td colspan="3">
								<!-- 사업자 번호-->
								<input type="text" class="validate[required]" name="bizNo" id="bizNo" title="<spring:message code="column.biz_no"/>"  value="${taxInvoice.bizNo }" />
							</td>
						</tr>
						<%-- <tr>
							<th><spring:message code="column.biz.addr"/></th>
							<td colspan="3">
								<!-- 사업장 소재지-->
								<input type="text" name="addr" id="addr" title="<spring:message code="column.biz.addr"/>"  value="${taxInvoice.addr }" size="70"/>
							</td>
						</tr> --%>
						<tr>
							<%-- <!-- 주소 -->
							<th scope="row"><spring:message code="column.addr" /><strong class="red">*</strong></th> --%>
							<!-- 사업장 소재지-->
							<th scope="row"><spring:message code="column.biz.addr" /><strong class="red">*</strong></th>
							<td colspan="3">
								<input type="hidden" name="prclAddr"	id="prclAddr"		value="${taxInvoice.prclAddr}">
								<input type="hidden" name="prclDtlAddr" id="prclDtlAddr" 	value="${taxInvoice.prclDtlAddr}">
								<input type="hidden" name="postNoOld"	id="postNoOld"		value="${taxInvoice.postNoOld}">
								* 도로명주소<br>
								<div class="mg5">
									<input type="text" class="ml5 readonly w50 validate[maxSize[6]]" name="postNoNew" id="postNoNew" value="${taxInvoice.postNoNew}" readonly="readonly">
								<c:if test="${taxInvoice.taxIvcStatCd eq adminConstants.TAX_IVC_STAT_01}">
									<button type="button" onclick="layer.post(fnCallBackPostNo);" class="btn">주소검색</button>
								</c:if>
								</div>
								<div class="mg5">
									<input type="text" class="ml5 readonly w180 validate[maxSize[100]]" name="roadAddr" id="roadAddr" value="${taxInvoice.roadAddr}" readonly="readonly">
									<input type="text" class="w180 validate[required, maxSize[100]]" name="roadDtlAddr" id="roadDtlAddr" value="${taxInvoice.roadDtlAddr}">
								</div>
							</td>
						</tr>

						<tr>
							<th><spring:message code="column.spl_amt"/></th>
							<td>
								<!-- 공급 금액-->
								<fmt:formatNumber value="${taxInvoice.splAmt}" type="number" pattern="#,###,###"/>원
							</td>
							<th><spring:message code="column.stax_amt"/></th>
							<td>
								<!-- 부가세 금액-->
								<fmt:formatNumber value="${taxInvoice.staxAmt}" type="number" pattern="#,###,###"/>원
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.tot_amt"/></th>
							<td colspan="3">
								<!-- 총 금액-->
								<fmt:formatNumber value="${taxInvoice.totAmt}" type="number" pattern="#,###,###"/>원
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.acpt_dtm"/></th>
							<td colspan="3">
								<!-- 접수 일시-->
								${taxInvoice.acptDtm}
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.lnk_dtm"/></th>
							<td>
								<!-- 연동 일시-->
								${taxInvoice.lnkDtm}
							</td>
							<th><spring:message code="column.prcsr_no"/></th>
							<td>
								<!-- 처리자 번호-->
								${taxInvoice.prcsrNo}
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.lnk_deal_no"/></th>
							<td colspan="3">
								<!-- 연동 거래 번호-->
								${taxInvoice.lnkDealNo}
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.lnk_rst_msg"/></th>
							<td colspan="3">
								<!-- 연동 결과 메세지-->
								${taxInvoice.lnkRstMsg}
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.memo"/></th>
							<td colspan="3">
								<!-- 메모-->
								<textarea rows="3" cols="30" id="memo" name="memo" maxlength="50" class="w500">${taxInvoice.memo}</textarea>
							</td>
						</tr>

					</tbody>
				</table>
				</form>



