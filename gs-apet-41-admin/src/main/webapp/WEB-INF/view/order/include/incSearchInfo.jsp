<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%-- ${orderSO.viewGb} --%>


		<form name="orderSearchForm" id="orderSearchForm">

			<input type="hidden" name="mbrNo" value="${orderSO.mbrNo }">

			<table class="table_type1">
				<caption>정보 검색</caption>
				<tbody>

					<tr>
						<c:choose>
							<c:when test="${orderSO.viewGb ne 'RETURN' and orderSO.viewGb ne 'EXCHANGE' and orderSO.viewGb ne 'AS' and orderSO.viewGb ne 'REFUND' and orderSO.viewGb ne 'CLAIM' }">
								<!-- 주문일자 -->
								<th scope="row"><spring:message code="column.ord_acpt_dtm" /></th>
								<td>
									<frame:datepicker startDate="ordAcptDtmStart" endDate="ordAcptDtmEnd" startValue="${adminConstants.COMMON_START_DATE }" />
								</td>
								<!-- Start 날짜 수정 2016-08-10 pkt -->
								<script>
									$(function(){
										$("#ordAcptDtmStart").val(f_today("Y"));
									});
								</script>
								<!-- Start 날짜 수정 2016-08-10 pkt -->
							</c:when>
							<c:otherwise>
								<!-- 클레임접수일자 -->
								<th scope="row"><spring:message code="column.clm_acpt_dtm" /></th>
								<td>
									<frame:datepicker startDate="clmAcptDtmStart" endDate="clmAcptDtmEnd" startValue="${adminConstants.COMMON_START_DATE }" />
								</td>
								<!-- Start 날짜 수정 2016-08-10 pkt -->
								<script>
									$(function(){
										$("#clmAcptDtmStart").val(f_today("Y"));
									});
								</script>
								<!-- Start 날짜 수정 2016-08-10 pkt -->
							</c:otherwise>
						</c:choose>
                        <!-- 주문정보 -->
                        <th scope="row"><spring:message code="column.order_common.order_info" /></th>
                        <td>
                            <select name="searchKeyOrder" class="wth100" title="선택상자" >
                                <option selected="selected">선택</option>
                                <option value="type01">주문번호</option>
                            <c:if test="${orderSO.viewGb ne 'RETURN' and orderSO.viewGb ne 'EXCHANGE' and orderSO.viewGb ne 'AS' }">
                                <option value="type02">주문자명</option>
                                <option value="type03">주문자ID</option>
                                <option value="type04">수령인명</option>
                            </c:if>
                            </select>
                            <input type="text" name="searchValueOrder" class="w120"  value="" />
                        </td>
					</tr>

					<tr>
                        <!-- 주문매체 -->
                        <th scope="row"><spring:message code="column.ord_mda_cd" /></th>
                        <td>
                            <frame:radio name="ordMdaCd" grpCd="${adminConstants.ORD_MDA }" defaultName="전체" />
                        </td>
						<!-- 사이트 ID -->
	                    <th scope="row"><spring:message code="column.st_id" /></th> <!-- 사이트 ID -->
	                    <td>
                            <select id="stIdCombo" name="stId">
                                <frame:stIdStSelect defaultName="사이트선택" />
                            </select>
	                    </td>
					</tr>
					<tr>
                        <!-- 결제수단 -->
                        <th scope="row"><spring:message code="column.pay_means_cd" /></th>
                        <td>
                        <c:if test="${orderSO.viewGb ne 'CASH' and orderSO.viewGb ne 'TAX' }">
                            <frame:radio name="payMeansCd" grpCd="${adminConstants.PAY_MEANS }" defaultName="전체" usrDfn1Val="ORDER"/>
                        </c:if>
                        <c:if test="${orderSO.viewGb eq 'CASH' or orderSO.viewGb eq 'TAX' }">
                            <frame:radio name="payMeansCd" grpCd="${adminConstants.PAY_MEANS }" defaultName="전체" usrDfn2Val="CASH"/>
                        </c:if>
                        </td>
                        <!-- 주문상태/환불상태/현금영수증상태/세금계산서상태 -->
                        <c:if test="${orderSO.viewGb eq 'ORDER' }">
                            <th scope="row"><spring:message code="column.order_common.ord_stat_cd" /></th>
                            <td>
                                <frame:checkbox name="arrOrdDtlStatCd" grpCd="${adminConstants.ORD_DTL_STAT }" defaultName="전체" />
                            </td>
                        </c:if>
                        <c:if test="${orderSO.viewGb eq 'DELIVERY' }">
                            <th scope="row"><spring:message code="column.order_common.ord_stat_cd" /></th>
                            <td>
                                <frame:checkbox name="arrOrdDtlStatCd" grpCd="${adminConstants.ORD_DTL_STAT }" defaultName="전체" />
                            </td>
                        </c:if>
                        <c:if test="${orderSO.viewGb eq 'EXCHANGE' }">
                            <th scope="row"><spring:message code="column.order_common.ord_stat_cd" /></th>
                            <td>
                                <frame:checkbox name="arrOrdDtlStatCd" grpCd="${adminConstants.ORD_DTL_STAT }" defaultName="전체"/>
                            </td>
                        </c:if>
                        <c:if test="${orderSO.viewGb eq 'RETURN' }">
                            <th scope="row"><spring:message code="column.order_common.ord_stat_cd" /></th>
                            <td>
                                <frame:checkbox name="arrOrdDtlStatCd" grpCd="${adminConstants.ORD_DTL_STAT }" defaultName="전체" usrDfn2Val="${orderSO.viewGb}" />
                            </td>
                        </c:if>
                        <c:if test="${orderSO.viewGb eq 'CS' }">
                            <th scope="row"><spring:message code="column.order_common.ord_stat_cd" /></th>
                            <td>
                                <frame:checkbox name="arrOrdDtlStatCd" grpCd="${adminConstants.ORD_DTL_STAT }" defaultName="전체" />
                            </td>
                        </c:if>
                        <c:if test="${orderSO.viewGb eq 'REFUND' }">
                            <th scope="row"><spring:message code="column.order_common.rfd_stat" /></th>
                            <td>
                                <frame:checkbox name="arrRfdStatCd" grpCd="${adminConstants.RFD_STAT }" defaultName="전체" />
                            </td>
                        </c:if>
                        <c:if test="${orderSO.viewGb eq 'CASH' }">
                            <th scope="row"><spring:message code="column.order_common.cash_rct_stat" /></th>
                            <td>
                                <frame:checkbox name="arrCashRctStatCd" grpCd="${adminConstants.CASH_RCT_STAT }" defaultName="전체" />
                            </td>
                        </c:if>
                        <c:if test="${orderSO.viewGb eq 'TAX' }">
                            <th scope="row"><spring:message code="column.order_common.tax_ivc_stat" /></th>
                            <td>
                                <frame:checkbox name="arrTaxIvcStatCd" grpCd="${adminConstants.TAX_IVC_STAT }" defaultName="전체" />
                            </td>
                        </c:if>
                        <c:if test="${orderSO.viewGb eq 'CLAIM' }">
                            <th scope="row"><spring:message code="column.order_common.ord_stat_cd" /></th>
                            <td>
                                <frame:checkbox name="arrOrdDtlStatCd" grpCd="${adminConstants.ORD_DTL_STAT }" defaultName="전체" usrDfn3Val="${orderSO.viewGb}" />
                            </td>
                        </c:if>                        
					</tr>

					<tr>
                        <!-- 상품정보 -->
                        <th scope="row"><spring:message code="column.order_common.goods_info" /></th>
                        <td>
                            <select name="searchKeyGoods" class="w100" title="선택상자" >
                                <option selected="selected">전체</option>
                                <option value="type01">상품명</option>
                                <option value="type02">상품NO</option>
                                <option value="type03">단품명</option>
                                <option value="type04">단품NO</option>
                            </select>
                            <input type="text" name="searchValueGoods" class="w120" value="" />
                        </td>
                        <!-- 업체구분 -->
                        <th scope="row"><spring:message code="column.goods.comp_nm" /></th>
                        <td>
                            <frame:compNo funcNm="fnCallBackCompanySearchPop" />
                        </td>                        
					</tr>

					<tr>
						<!-- 현금영수증/세금계산서 - 주문상세상태 -->
						<c:if test="${orderSO.viewGb eq 'CASH' }">
							<th scope="row"><spring:message code="column.order_common.ord_stat_cd" /></th>
							<td>
								<frame:checkbox name="arrOrdDtlStatCd" grpCd="${adminConstants.ORD_DTL_STAT }" defaultName="전체"/>
							</td>
							
                            <th scope="row"><spring:message code="column.cr_tp_cd" /></th>
                            <td>
                                <frame:checkbox name="arrCrTpCd" grpCd="${adminConstants.CR_TP }" defaultName="전체" />
                            </td>
						</c:if>
						<c:if test="${orderSO.viewGb eq 'TAX' }">
							<th scope="row"><spring:message code="column.order_common.ord_stat_cd" /></th>
							<td>
								<frame:checkbox name="arrOrdDtlStatCd" grpCd="${adminConstants.ORD_DTL_STAT }" defaultName="전체"/>
							</td>
							
							<th scope="row"></th>
							<td></td>
						</c:if>
					</tr>

				<c:if test="${orderSO.viewGb eq 'DELIVERY' }">
					<tr>
						<!-- 택배사 -->
						<th scope="row"><spring:message code="column.order_common.hdc" /></th>
						<td colspan="3">
							<select name="hdcCd" class="w100" title="선택상자" >
								<frame:select grpCd="${adminConstants.HDC }" defaultName="전체"  />
							</select>

							<!-- 송장번호 -->
							<input type="text" name="invNo" class="w120" value="" />
						</td>
					</tr>
				</c:if>

				<c:if test="${orderSO.viewGb eq 'CS' }">
					<tr>
						<!-- 상담 상태 -->
						<th scope="row"><spring:message code="column.order_common.cus_stat" /></th>
						<td>
							<frame:checkbox name="arrCusStatCd" grpCd="${adminConstants.CUS_STAT }" defaultName="전체" />
						</td>
						<!-- 상담 카테고리 -->
						<th scope="row"><spring:message code="column.order_common.cus_ctg" /></th>
						<td>
							<select name="cusCtg1Cd" id="cusCtg1Cd" class="w100" title="선택상자" >
								<frame:select grpCd="${adminConstants.CUS_CTG1 }" defaultName="선택" />
							</select>
							<select name="cusCtg2Cd" id="cusCtg2Cd" class="w100" title="선택상자" >
	<%-- 							<frame:select grpCd="${adminConstants.CUS_CTG2 }" /> --%>
							</select>
							<select name="cusCtg3Cd" id="cusCtg3Cd" class="w100" title="선택상자" >
	<%-- 							<frame:select grpCd="${adminConstants.CUS_CTG3 }" /> --%>
							</select>
						</td>
					</tr>
				</c:if>

				</tbody>
			</table>
		</form>
		

<script type="text/javascript">
// 현금영수증/세금계산서 목록에서 주문접수 조건은 비활성화 처리  hjko 20170123
<c:if test="${orderSO.viewGb eq 'CASH' || orderSO.viewGb eq 'TAX'  }">
var chkSts = $("input:checkbox[name='arrOrdDtlStatCd']").length;
for(var i=0 ; i< chkSts ; i++){
	$("input[name='arrOrdDtlStatCd'][value='01']").prop("disabled", true);
}
</c:if>
</script>