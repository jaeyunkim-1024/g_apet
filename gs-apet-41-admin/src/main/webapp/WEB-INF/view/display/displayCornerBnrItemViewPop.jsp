<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">
			$(document).ready(function() {
				// 제한 없음 날짜 셋팅
				var dispEnddt =  $("#dispEnddt").val();
				if(dispEnddt == '9999-12-31') {
					$("input:checkbox[id=noLimit]").prop("checked", true);
				}else {
					$("input:checkbox[id=noLimit]").prop("checked", false);
				}
				
				// 전시 우선 순위 설정
				$("#dispPriorRankArea").append('<input type="text" class="w93 numeric validate[required]" name="dispPriorRank" id="dispPriorRank" value="${displayCornerBnrItem[0].dispPriorRank}" title="<spring:message code='column.display_view.disp_prior_rank'/>" />');
				/*
				if('${displayCornerBnrItem[0].dispPriorRank}' != "") {
					$("#dispPriorRank").val('${displayCornerBnrItem[0].dispPriorRank}');
				} else {
					$("#dispPriorRank").val('');
				}
				*/
				<c:if test="${displayCornerItem.dispCornTpCd eq adminConstants.DISP_CORN_TP_80}">
					$("#bnrGbCd").change(function() {
			            bnrGbCdChange($(this).val());
			        });
					bnrGbCdChange("${displayCornerBnrItem[0].bnrGbCd eq null ? adminConstants.BNR_GB_TP_10 : displayCornerBnrItem[0].bnrGbCd }");
				</c:if>
				
 				// 이모지 사용 설정
 				<c:if test="${displayCornerItem.dispCornTpCd eq adminConstants.DISP_CORN_TP_30}">
 				<c:choose>
					<c:when test="${!empty displayCornerBnrItem[0]}">
						if(!'${displayCornerBnrItem[0].bnrImgPath}') {
							$("#emojiUrl").show();
							$("#chkEmojiYn").prop("checked", true);
							$("#bnrImgNm").prop('readonly', false); 
							$("#bnrImgNm").removeClass("readonly");
							$(".pcEmojiView").show();
							$(".pcImgView").hide();
						}else {
							$("#bnrImgNm").prop('readonly', true); 
							$("#bnrImgNm").addClass("readonly");
							$(".pcEmojiView").hide();
							$(".pcImgView").show();
						}
					</c:when>
					<c:otherwise>
						$(".imgView").show();
						$(".emojiView").hide();
					</c:otherwise>
				</c:choose>
 				
				/* if ('${displayCornerBnrItem[0]}') {	// 상세
					if(!'${displayCornerBnrItem[0].bnrImgPath}') {
						$("#emojiUrl").show();
						$("#chkEmojiYn").prop("checked", true);
						$("#bnrImgNm").prop('readonly', false); 
						$("#bnrImgNm").removeClass("readonly");
						$(".pcEmojiView").show();
						$(".pcImgView").hide();
					}else {
						$("#bnrImgNm").prop('readonly', true); 
						$("#bnrImgNm").addClass("readonly");
						$(".pcEmojiView").hide();
						$(".pcImgView").show();
					} */

// 					if(!'${displayCornerBnrItem[0].bnrMobileImgPath}') {
// 						$("#chkMoEmojiYn").prop("checked", true);
// 						$(".moEmojiView").show();
// 						$(".moImgView").hide();
// 					}else {
// 						$(".moEmojiView").hide();
// 						$(".moImgView").show();
// 					}
				/* } else {	// 추가
					$(".imgView").show();
					$(".emojiView").hide();
				}
				 */
				//라디오 버튼 체인지 이벤트
				$("input[name^=chk]").change(function() {
					var check = $(this).prop("checked");
// 					// 초기화
					$(this).parent().siblings("input[name^=bnr]").val("");
					if (check) {
						$("#emojiUrl").show();
						$("#bnrImgNm").prop('readonly', false); 
						$("#bnrImgNm").removeClass("readonly");
						$("#bnrImgNm").attr("placeholder", "이모지를 붙여 넣으세요");
						$(this).parent().siblings(".pcImgView").hide();
					} else {
						$("#emojiUrl").hide();
						$("#bnrImgNm").prop('readonly', true); 
						$("#bnrImgNm").addClass("readonly");
						$("#bnrImgNm").attr("placeholder", "");
						$(this).parent().siblings(".pcImgView").show();
					}
				});
				</c:if>
				
				$("input[id=noLimit]").change(function() {
					var check = $(this).prop("checked");
					if (check) {
						$("#dispEnddt").datepicker('setDate',"${adminConstants.COMMON_END_DATE}");
					} else {
						$("#dispEnddt").val(dispEnddt == '9999-12-31' ? "${frame:addMonth('yyyy-MM-dd', 1)}" : dispEnddt);
					}
				});
			});
			
			function bnrGbCdChange(val) {
				if (val == "${adminConstants.BNR_GB_10}" ) {
					$("#bnrImgPathTr").show();
					$("#bnrMobileImgPathTr").show();
					$("#bnrAviPathTr").hide();
					$("#bnrMobileAviPathTr").hide();
				} else {
					$("#bnrImgPathTr").hide();
					$("#bnrMobileImgPathTr").hide();
					$("#bnrAviPathTr").show();
					$("#bnrMobileAviPathTr").show();
				}
			}

			// 등록 / 수정
			function insertDisplayCornerItem() {
				if(validate.check("displayCornerPopForm")) {					
					var sendData = $("#displayCornerPopForm").serializeJson();						
					$.extend(sendData, {
						dispCornerItemStrtdt : $("#displayCornerPopForm #dispStrtdt").val()
						, dispCornerItemEnddt : $("#displayCornerPopForm #dispEnddt").val()
					});					
					messager.confirm('<spring:message code="column.display_view.message.confirm_save" />',function(r){
						if(r){
							var options = {
									url : "<spring:url value='/display/displayCornerItemSave.do' />"
									, data : sendData
									, callBack : function(result){
										reloadDisplayCornerItemGrid();
										layer.close('displayCornerItemView');
									}
								};

								ajax.call(options);				
						}
					});
				}
			}

			// 배너 이미지(PC) 파일 업로드
			function resultBnrPcImage(result) {
				$("#bnrImgPath").val(result.filePath);
				$("#bnrImgNm").val(result.fileName);
			}
// 			// 배너 이미지(MOBILE) 파일 업로드
// 			function resultBnrMobileImage(result) {
// 				$("#bnrMobileImgPath").val(result.filePath);
// 				$("#bnrMobileImgNm").val(result.fileName);
// 			}
		</script>
		
		<form name="displayCornerPopForm" id="displayCornerPopForm">
			<input type="hidden" name="dispCnrItemNo" id="dispCnrItemNo" value="${displayCornerItem.dispCnrItemNo}"/>
			<input type="hidden" name="dispClsfNo" id="dispClsfNo" value="${displayCornerItem.dispClsfNo}"/>
			<input type="hidden" name="dispCornTpCd" id="dispCornTpCd" value="${displayCornerItem.dispCornTpCd}">
			<input type="hidden" name="dispBnrNo" id="dispBnrNo" value="${displayCornerItem.dispBnrNo}">
			<input type="hidden" name="dispClsfCornNo" id="dispClsfCornNo" value="${displayCornerItem.dispClsfCornNo}"/>
			<!-- <input type="hidden" name="displayCornerItemPOList" id="displayCornerItemPOList" value=""> -->

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
<!-- 					<tr> -->
<%-- 						<th><spring:message code="column.display_view.disp_prior_rank"/><strong class="red">*</strong></th> --%>
<!-- 						<td colspan="3"> -->
<!-- 							전시 우선 순위 -->
<!-- 							<div id="dispPriorRankArea"> -->
<!-- 							</div> -->
<!-- 						</td> -->
<!-- 					</tr> -->
					<!--  전시 코너 아니템 (배너 TEXT, 메뉴 리스트)가 아닌 경우 -->
					<c:if test="${displayCornerItem.dispCornTpCd ne adminConstants.DISP_CORN_TP_20 and displayCornerItem.dispCornTpCd ne adminConstants.DISP_CORN_TP_90}">
						<tr id="bnrImgPathTr">
							<th><spring:message code="column.display_view.pc_img"/><strong class="red">*</strong></th>
							<td colspan="3">
								<!-- 이미지(PC) -->
								<input type="text" class="w300 readonly validate[required]" readonly="readonly" name="bnrImgNm" id="bnrImgNm" title="<spring:message code="column.display_view.pc_img"/>" value="${displayCornerBnrItem[0].bnrImgNm}" />
								<input type="hidden" name="bnrImgPath" id="bnrImgPath" class="pcImgView" title="<spring:message code="column.bnr_img_path"/>" value="${displayCornerBnrItem[0].bnrImgPath}" />
								<button type="button" onclick="fileUpload.image(resultBnrPcImage);" class="btn pcImgView">파일찾기</button>
<!-- 								<br/> -->
								<c:if test="${displayCornerItem.dispCornTpCd eq adminConstants.DISP_CORN_TP_30}">
								<label class="fCheck" name="chkEmojiYn"><input type="checkbox" name="chkEmojiYn" id="chkEmojiYn">
									<span><spring:message code="column.bnr_use_emoji"/></span>
								</label>
								<br>
								<a id="emojiUrl" href="https://emojipedia.org/" target="_blank" style="display: none;">이모지는<span style="color:blue; text-decoration: underline;">https://emojipedia.org/</span> 에서 찾아 주세요</a>&nbsp;
								</c:if>
							</td>
						</tr>
						<!-- 이미지(MOBILE) 
						<tr id="bnrMobileImgPathTr">
							<th><spring:message code="column.display_view.mobile_img"/><strong class="red">*</strong></th>
							<td colspan="3">
								<input type="text" class="w300 readonly validate[required] imgView moImgView" readonly="readonly" name="bnrMobileImgNm" id="bnrMobileImgNm" title="<spring:message code="column.display_view.mobile_img"/>" value="${displayCornerBnrItem[0].bnrMobileImgNm}" />
								<input type="text" class="w300 validate[required] emojiView moEmojiView" name="bnrMobileImgNm" value="${displayCornerBnrItem[0].bnrMobileImgNm}" />
								<input type="hidden" name="bnrMobileImgPath" id="bnrMobileImgPath imgView moImgView" title="<spring:message code="column.bnr_mobile_img_path"/>" value="${displayCornerBnrItem[0].bnrMobileImgPath}" />
								<button type="button" onclick="fileUpload.image(resultBnrMobileImage);" class="btn imgView moImgView">파일찾기</button>
								<label class="fCheck" name="chkMoEmojiYn"><input type="checkbox" name="chkMoEmojiYn" id="chkMoEmojiYn" onclick="movePage('chkMoEmojiYn');">
									<span>이모지 사용</span>
								</label>
							</td>
						</tr>
						-->
					</c:if>
					<c:if test="${displayCornerItem.dispCornTpCd ne adminConstants.DISP_CORN_TP_30}">
					<tr id="bnrAviPathTr" style="display:none;">
						<th><spring:message code="column.display_view.bnr_avi_path"/><strong class="red">*</strong></th>
						<td colspan="3">
							<input type="text" class="w300 validate[required]" name="bnrAviPath" id="bnrAviPath" title="<spring:message code="column.display_view.bnr_avi_path"/>" value="${displayCornerBnrItem[0].bnrImgPath}" />
						</td>
					</tr>
					<tr id="bnrMobileAviPathTr" style="display:none;">
						<th><spring:message code="column.display_view.bnr_mobile_avi_path"/><strong class="red">*</strong></th>
						<td colspan="3">
							<input type="text" class="w300 validate[required]" name="bnrMobileAviPath" id="bnrMobileAviPath" title="<spring:message code="column.display_view.bnr_avi_path"/>" value="${displayCornerBnrItem[0].bnrMobileImgPath}" />
						</td>
					</tr>
					</c:if>
					<!--  전시 코너 아니템 (배너 TEXT)가 아닌 경우 -->
					<c:if test="${displayCornerItem.dispCornTpCd ne adminConstants.DISP_CORN_TP_20}">
					<tr>
						<th><spring:message code="column.display_view.bnr_link_url"/><strong class="red">*</strong></th>
						<td colspan="3">
							<!-- LINK URL -->
							<input type="text" class="w300 validate[required]" name="bnrLinkUrl" id="bnrLinkUrl" title="<spring:message code="column.display_view.bnr_link_url"/>" value="${displayCornerBnrItem[0].bnrLinkUrl}" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="column.display_view.bnr_mobile_link_url"/><strong class="red">*</strong></th>
						<td colspan="3">
							<!-- 모바일 LINK URL -->
							<input type="text" class="w300 validate[required]" name="bnrMobileLinkUrl" id="bnrMobileLinkUrl" title="<spring:message code="column.display_view.bnr_mobile_link_url"/>" value="${displayCornerBnrItem[0].bnrMobileLinkUrl}" />
						</td>
					</tr>
					</c:if>
					<tr>
						<th><spring:message code="column.disp_data"/><strong class="red">*</strong></th>
						<td colspan="3">
							<!-- 전시 기간-->
							<frame:datepicker startDate="dispStrtdt"
											  startValue="${empty displayCornerBnrItem[0].dispStrtdt ? frame:toDate('yyyy-MM-dd') : displayCornerBnrItem[0].dispStrtdt}"
											  endDate="dispEnddt"
											  endValue="${empty displayCornerBnrItem[0].dispEnddt ? frame:addMonth('yyyy-MM-dd', 1) : displayCornerBnrItem[0].dispEnddt}"
												/>
							<label class="fCheck" ><input type="checkbox" id="noLimit">
								<span><spring:message code="column.disp_date_no_imit"/></span>
							</label>
						</td>
					</tr>
					<!-- 전시 코너 아이템 (배너 복합 / 배너 TEXT/ 배너 리스트 / 메뉴 리스트) -->
					<c:if test="${displayCornerItem.dispCornTpCd eq adminConstants.DISP_CORN_TP_20
									or displayCornerItem.dispCornTpCd eq adminConstants.DISP_CORN_TP_30
									or displayCornerItem.dispCornTpCd eq adminConstants.DISP_CORN_TP_90}">
						<tr>
							<c:if test="${displayCornerItem.dispCornTpCd eq adminConstants.DISP_CORN_TP_20
											or displayCornerItem.dispCornTpCd eq adminConstants.DISP_CORN_TP_90}">
								<th><spring:message code="column.bnr_text"/><strong class="red">*</strong></th>
							</c:if>
							<c:if test="${displayCornerItem.dispCornTpCd eq adminConstants.DISP_CORN_TP_30}">
								<th><spring:message code="column.display_view.bnr_text"/><strong class="red">*</strong></th>
							</c:if>
							<td colspan="3">
								<!-- 배너 TEXT -->
								<!-- <input type="text" class="w300 validate[required]" name="bnrText" id="bnrText" title="<spring:message code="column.bnr_text"/>" value="${displayCornerBnrItem[0].bnrText}" /> -->
								<textarea name="bnrText" class="validate[required]" id="bnrText" title="<spring:message code="column.bnr_text"/>" rows="2" cols="70">${displayCornerBnrItem[0].bnrText}</textarea>
							</td>
						</tr>
					</c:if>
					<tr>
						<th><spring:message code="column.bnr_dscrt" /></th> <!-- 배너설명-->
						<td colspan="3">
							<textarea name="bnrDscrt" id="bnrDscrt" title="<spring:message code="column.bnr_dscrt"/>" rows="3" cols="70">${displayCornerBnrItem[0].bnrDscrt }</textarea>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
			

