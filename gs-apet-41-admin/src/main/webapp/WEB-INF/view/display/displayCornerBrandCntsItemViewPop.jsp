<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">
			$(document).ready(function() {
				// 전시 우선 순위 설정
				$("#dispPriorRankArea").append('<input type="text" class="w93 numeric validate[required]" name="dispPriorRank" id="dispPriorRank" title="<spring:message code='column.display_view.disp_prior_rank'/>" />');

				if('${displayCornerBnrItem[0].dispPriorRank}' != "") {
					$("#dispPriorRank").val('${displayCornerBnrItem[0].dispPriorRank}');
				} else {
					$("#dispPriorRank").val('');
				}
			});
			
			// 상품 검색
			function searchBrandCnts () {
				var options = {
					multiselect : false
					, callBack : searchBrandCntsCallback
				}
				layerBrandCntsList.create (options );
			}
			function searchBrandCntsCallback (result ) {
				if(result.length > 0 ) {
					$("#bndCntsNo").val (result[0].bndCntsNo );
					$("#cntsTtl").val (result[0].cntsTtl );
				}
			}

			// 등록 / 수정
			function insertDisplayCornerItem() {
				if(validate.check("displayCornerPopForm")) {
					messager.confirm('<spring:message code="column.display_view.message.confirm_save" />',function(r){
						if(r){
							var options = {
									url : "<spring:url value='/display/displayCornerItemSave.do' />"
									, data : $("#displayCornerPopForm").serializeJson()
									, callBack : function(result){
										reloadDisplayCornerItemGrid();
										layer.close('displayCornerBrandCntsItemView');
									}
								};

								ajax.call(options);				
						}
					});
				}
			}
		</script>
			<form name="displayCornerPopForm" id="displayCornerPopForm">
				<input type="hidden" name="dispCnrItemNo" id="dispCnrItemNo" value="${displayCornerItem.dispCnrItemNo}"/>
				<input type="hidden" name="dispClsfNo" id="dispClsfNo" value="${displayCornerItem.dispClsfNo}"/>
				<input type="hidden" name="dispCornTpCd" id="dispCornTpCd" value="${displayCornerItem.dispCornTpCd}">
				<input type="hidden" name="dispBnrNo" id="dispBnrNo" value="${displayCornerItem.dispBnrNo}">
				<input type="hidden" name="dispClsfCornNo" id="dispClsfCornNo" value="${displayCornerItem.dispClsfCornNo}"/>
				<input type="hidden" name="displayCornerItemPOList" id="displayCornerItemPOList" value="">

				<table class="table_type1">
					<caption>배너 정보</caption>
					<colgroup>
						<col class="th-s" />
						<col />
						<col class="th-s" />
						<col />
					</colgroup>
					<tbody>
						<tr>
							<th><spring:message code="column.bnr_gb_cd" /><strong class="red">*</strong></th>	<!-- 배너 구분 코드-->
							<td colspan="3">
								<!-- 전시 구분 코드 값이 정해 진 경우 -->
								<c:if test="${not empty frame:getCode(adminConstants.DISP_CORN_TP, displayCornerItem.dispCornTpCd).usrDfn1Val}">
									<select class="validate[required]" name="bnrGbCd" id="bnrGbCd" title="<spring:message code="column.bnr_gb_cd" />" disabled>
										<frame:select grpCd="${adminConstants.BNR_GB }" selectKey="${displayCornerBnrItem[0].bnrGbCd eq null ? frame:getCode(adminConstants.DISP_CORN_TP, displayCornerItem.dispCornTpCd).usrDfn1Val : displayCornerBnrItem[0].bnrGbCd }" />
									</select>
								</c:if>
								<!-- 전시 구분 코드 값이 안 정해 진 경우 -->
								<c:if test="${empty frame:getCode(adminConstants.DISP_CORN_TP, displayCornerItem.dispCornTpCd).usrDfn1Val}">
									<select class="validate[required]" name="bnrGbCd" id="bnrGbCd" title="<spring:message code="column.bnr_gb_cd" />">
										<frame:select grpCd="${adminConstants.BNR_GB }" selectKey="${displayCornerBnrItem[0].bnrGbCd eq null ? adminConstants.BNR_GB_TP_10 : displayCornerBnrItem[0].bnrGbCd }" />
									</select>
								</c:if>
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.display_view.disp_prior_rank"/><strong class="red">*</strong></th>
							<td colspan="3">
								<!-- 전시 우선 순위 -->
								<div id="dispPriorRankArea">
								</div>
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.display_view.date"/><strong class="red">*</strong></th>
							<td colspan="3">
								<!-- 전시 기간-->
								<frame:datepicker startDate="dispStrtdt"
												  startValue="${empty displayCornerBnrItem[0].dispStrtdt ? frame:toDate('yyyy-MM-dd') : displayCornerBnrItem[0].dispStrtdt}"
												  endDate="dispEnddt"
												  endValue="${empty displayCornerBnrItem[0].dispEnddt ? frame:addMonth('yyyy-MM-dd', 1) : displayCornerBnrItem[0].dispEnddt}"
												  />
							</td>
						</tr>
						<tr>
							<th scope="row"><spring:message code="column.bnd_cnts_no" /></th> <!-- 브랜드 콘텐츠 번호 -->
							<td colspan="3">								
								<frame:bndCntsNo funcNm="searchBrandCnts()" defaultCntsTtl="${displayCornerBnrItem[0].cntsTtl}" defaultBndCntsNo="${displayCornerBnrItem[0].bndCntsNo}" />
							</td>
						</tr>
					</tbody>
				</table>
			</form>
			
