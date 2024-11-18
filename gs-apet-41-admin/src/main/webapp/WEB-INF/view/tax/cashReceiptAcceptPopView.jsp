<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="popupLayout">
	<t:putAttribute name="title">현금 영수증 접수</t:putAttribute>
	<t:putAttribute name="script">
		<script type="text/javascript">

			$(document).ready(function(){
// 				$("input:radio[name=isuMeansCd]").eq(1).prop("disabled", true);
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
									messager.alert( '<spring:message code="column.common.accept.final_msg" />', "Info", "info", function(){
										opener['reloadOrderListGrid']();
										popupClose();
									});
									
								}
							};

							ajax.call(options);
						}
					});
				}

			}

			// 신청자 구분 코드 클릭
			$(document).on("click", "#cashAcceptForm input:radio[name=apctGbCd]", function(e) {

// 				// 개인
// 				if ( $(this).val() == "${adminConstants.APCT_GB_01}" ) {
// 					$("input:radio[name=isuMeansCd]").eq(0).prop("disabled", false);
// 					$("input:radio[name=isuMeansCd]").eq(0).prop("checked", true);
// 					$("input:radio[name=isuMeansCd]").eq(1).prop("disabled", true);
// 					$("input:text[name=isuMeansNo]").val("${orderSO.ordrMobile}");
// 					$("input:text[name=isuMeansNo]").focus();
// 					$('#isuMeansNo').unmask();
// 					objClass.add($("#isuMeansNo"), "phoneNumber");
// 					common.phoneNumber();
// 				// 법인
// 				} else if ( $(this).val() == "${adminConstants.APCT_GB_02}" ) {
// 					$("input:radio[name=isuMeansCd]").eq(1).prop("disabled", false);
// 					$("input:radio[name=isuMeansCd]").eq(1).prop("checked", true);
// 					$("input:radio[name=isuMeansCd]").eq(0).prop("disabled", true);
// 					$("input:text[name=isuMeansNo]").val("");
// 					$("input:text[name=isuMeansNo]").focus();
// 					$("#isuMeansNo").mask("000-00-00000");
// 					objClass.remove($("#isuMeansNo"), "phoneNumber");
// 				}

			});

			// 사용 구분 코드 클릭
			$(document).on("click", "#cashAcceptForm input:radio[name=useGbCd]", function(e) {
			});

			// 발급 수단 코드 클릭
			$(document).on("click", "#cashAcceptForm input:radio[name=isuMeansCd]", function(e) {
			});

		</script>
	</t:putAttribute>

	<t:putAttribute name="content">

		<div class="popTitle">현금 영수증 접수</div>
		<div class="popContent">

			<div class="table_type1">
				<form id="cashAcceptForm" name="cashAcceptForm" method="post" >
					<input type="hidden" name="ordNo" id="ordNo" value="${orderSO.ordNo}">
					<c:forEach items="${orderSO.arrOrdDtlSeq}" var="item">
						<input type="hidden" name="arrOrdDtlSeq" id="arrOrdDtlSeq" value="${item}">
					</c:forEach>

				<table summary="">
					<caption>글 정보보기</caption>
					<colgroup>
						<col style="width:20%;">
						<col style="width:auto;">
						<col style="width:20%;">
						<col style="width:auto;">
					</colgroup>
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
						<tr>
							<!-- 사용 구분 코드 -->
							<th scope="row"><spring:message code="column.use_gb_cd" /><strong class="red">*</strong></th>
							<td colspan="3">
								<label class="fRadio"><input type="radio" name="useGbCd" value="${adminConstants.USE_GB_10}" checked="checked"> <span><frame:codeName grpCd="${adminConstants.USE_GB}" dtlCd="${adminConstants.USE_GB_10}"/> </span></label>
								<label class="fRadio"><input type="radio" name="useGbCd" value="${adminConstants.USE_GB_20}"> <span><frame:codeName grpCd="${adminConstants.USE_GB}" dtlCd="${adminConstants.USE_GB_20}"/> </span></label>
							</td>
						</tr>
						<tr>
							<!-- 발급 수단 코드 -->
							<th scope="row"><spring:message code="column.isu_means_cd" /><strong class="red">*</strong></th>
							<td colspan="3">
								<label class="fRadio"><input type="radio" name="isuMeansCd" value="${adminConstants.ISU_MEANS_10}" checked="checked"> <span><frame:codeName grpCd="${adminConstants.ISU_MEANS}" dtlCd="${adminConstants.ISU_MEANS_10}"/> </span></label>
								<label class="fRadio"><input type="radio" name="isuMeansCd" value="${adminConstants.ISU_MEANS_20}" > <span><frame:codeName grpCd="${adminConstants.ISU_MEANS}" dtlCd="${adminConstants.ISU_MEANS_20}"/> </span></label>
								<label class="fRadio"><input type="radio" name="isuMeansCd" value="${adminConstants.ISU_MEANS_30}"> <span><frame:codeName grpCd="${adminConstants.ISU_MEANS}" dtlCd="${adminConstants.ISU_MEANS_30}"/> </span></label>
							</td>
						</tr>
						<tr>
							<!-- 발급 번호 -->
							<th scope="row"><spring:message code="column.isu_means_no" /><strong class="red">*</strong></th>
							<td colspan="3">
								<input type="text" class="phoneNumber validate[required]" name="isuMeansNo" id="isuMeansNo">
							</td>
						</tr>
					</tbody>
				</table>
				</form>
			</div>

			<div class="btn_area_center">
				<button type="button" class="btn_type1" onclick="fnCashReceiptAcceptExec();"><spring:message code="column.order_common.btn.cash_accept" /></button>
				<button type="button" class="btn_type2" onclick="popupClose();">닫기</button>
			</div>

		</div>

	</t:putAttribute>

</t:insertDefinition>
