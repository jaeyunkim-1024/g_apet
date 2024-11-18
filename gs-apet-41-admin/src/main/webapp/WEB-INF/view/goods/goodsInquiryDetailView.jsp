<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {

		});

		// 상품Q&A 답변 저장
		function updateGoodsInquiry () {
			var sendData = $("#goodsReplyForm").serializeJson();
			messager.confirm("<spring:message code='column.display_view.message.confirm_save' />",function(r){
				if(r){

					if($.trim($("#goodsReplyForm #rplContent").val()) == "") {
						messager.alert("<spring:message code='column.display_view.message.rplr_body_fail' />","Info","info");
						return;
					}

					var options = {
						url : "<spring:url value='/${gb}/goodsReplyUpdate.do' />"
						, data : sendData
						, callBack : function(data) {
							messager.alert("<spring:message code='column.display_view.message.save' />","Info","info",function(){
								location.reload();
							});
						}
					};
					ajax.call(options);
				}
			});
		}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
	<form id="goodsReplyForm" name="goodsReplyForm" method="post" >
		<input type="hidden" id="goodsIqrNo" name="goodsIqrNo" value="${goodsInquiryDetail.goodsIqrNo}" />
		<table class="table_type1">
			<caption><spring:message code="admin.web.view.app.goods.qna.tab.detail"/></caption>
			<tbody>
				<tr>
					<!-- 상품번호 -->
					<th scope="row"><spring:message code='column.goods_id' /></th>
					<td>
						${goodsInquiryDetail.goodsId}
					</td>
					<!-- 상품명 -->
					<th scope="row"><spring:message code='column.goods_nm' /></th>
					<td>
						${goodsInquiryDetail.goodsNm}
					</td>
				</tr>
				<tr>
					<!-- 등록일시 -->
					<th scope="row"><spring:message code='column.sys_reg_dtm' /></th>
					<td>
						<fmt:formatDate value="${goodsInquiryDetail.sysRegDtm}" pattern="${adminConstants.COMMON_DATE_FORMAT }"/>
					</td>
					<!-- 고객 ID/이름 -->
					<th scope="row"><spring:message code='column.display_view.eqrr_mbr_id' /> / <spring:message code='column.display_view.eqrr_mbr_nm' /></th>
					<td>
							${goodsInquiryDetail.eqrrId} / ${goodsInquiryDetail.eqrrNm}
					</td>
				</tr>
				<tr>
					<!-- 완료 Push 알림 -->
					<th scope="row">완료 Push 알림</th>
					<td>
						<c:choose>
							<c:when test="${goodsInquiryDetail.rplAlmRcvYn eq adminConstants.COMM_YN_Y}"><spring:message code='column.goods.rplAlmRcvYnY' /></c:when>
							<c:otherwise><spring:message code='column.goods.rplAlmRcvYnN' /></c:otherwise>
						</c:choose>
					</td>
					<!-- 답변여부 -->
					<th>답변여부</th>
					<td>
						<frame:codeName grpCd="${adminConstants.GOODS_IQR_STAT}" dtlCd="${goodsInquiryDetail.goodsIqrStatCd}"/>
					</td>
				</tr>
				<tr>
					<!-- 내용 -->
					<th scope="row"><spring:message code='column.content' /></th>
					<td colspan="3">
						${goodsInquiryDetail.iqrContent}
					</td>
				</tr>
				<tr>
					<!-- 답변 -->
					<th scope="row">답변 내용</th>
					<td colspan="3">
						<textarea class="w500" rows="8" cols="80" id="rplContent" name="rplContent" >${goodsInquiryDetail.rplContent}</textarea>
					</td>
				</tr>
				<c:if test="${goodsInquiryDetail.goodsIqrStatCd eq adminConstants.GOODS_IQR_STAT_20}">
				<tr>
					<!-- 답변자 -->
					<th scope="row">답변자</th>
					<td><c:out value="${goodsInquiryDetail.rplrNm}"/></td>
					<!-- 답변일시 -->
					<th scope="row">답변일시</th>
					<td><fmt:formatDate value="${goodsInquiryDetail.rplDtm}" pattern="${adminConstants.COMMON_DATE_FORMAT }"/></td>
				</tr>
				</c:if>
 		</table>
	</form>

	<div class="btn_area_center">
		<button type="button" class="btn btn-ok" onclick="updateGoodsInquiry();" >
			<c:choose>
				<c:when test="${goodsInquiryDetail.goodsIqrStatCd eq adminConstants.GOODS_IQR_STAT_20}"><spring:message code="admin.web.view.common.button.update"/></c:when>
				<c:otherwise><spring:message code="admin.web.view.common.button.insert"/></c:otherwise>
			</c:choose>
		</button>
		<button type="button" class="btn btn-cancel" onclick="closeTab();"><spring:message code="admin.web.view.common.button.close"/></button>
	</div>
	</t:putAttribute>
</t:insertDefinition>